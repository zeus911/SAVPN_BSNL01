
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.hp.ov.activator.crmportal.bean.CAR;
import com.hp.ov.activator.crmportal.bean.Customer;
import com.hp.ov.activator.crmportal.bean.Profile;
import com.hp.ov.activator.crmportal.bean.Service;
import com.hp.ov.activator.crmportal.bean.ServiceParameter;
import com.hp.ov.activator.crmportal.bean.VPNMembership;
import com.hp.ov.activator.crmportal.utils.Constants;

public class ServiceUtils {
 
	public static void updateSubServicesParam(Connection connection, String parent_ServiceId, String parameterName, String parameterValue) throws SQLException
	  {
		  
		  
		  Service services[] = Service.findByParentserviceid(connection,parent_ServiceId);
		  if(services != null && services.length != 0){
			  
			  for (int i =0; i<services.length ;i++){
				  saveOrUpdateParameter(connection,services[i].getServiceid(),parameterName,parameterValue);
			  	}
		  }
	 }
	public static void updateService(Connection connection, Service service) throws SQLException {
		final Date date = new Date();
		service.setLastupdatetime(date.getTime());
		service.update(connection);
	}

	public static void deleteService(Connection connection, Service service) throws SQLException {
		final Date date = new Date();
		final Customer customer = Customer.findByCustomerid(connection, service.getCustomerid());
		customer.setLastupdatetime(date.getTime());
		customer.update(connection);
		service.delete(connection);
	}
	
//	SAVE OR UPDATE PARAMETER
	  public static void saveOrUpdateParameter(Connection connection, String serviceId, String parameterName, String parameterValue) throws SQLException
	  {
		  Logger logger = Logger.getLogger("CRMPortalLOG");
		  ServiceParameter parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, parameterName);
	    logger.debug(".saveOrUpdateParameter");
	    logger.debug("serviceId = " + serviceId);
	    logger.debug("parameterName = " + parameterName);
	    logger.debug("parameterValue = " + parameterValue);
	    logger.debug("parameter = " + parameter);

	    if(parameter == null){
	      new ServiceParameter(serviceId, parameterName, parameterValue).store(connection);
	    } else{
	      parameter.setValue(parameterValue);
	      parameter.update(connection);
	    }
	    logger.debug("end.");
	  }
	
	
	  public static HashMap fillParameterTable(HashMap table, Service service, String messageid, Connection con) throws SQLException
	   {
	     ServiceParameter[] parentServiceParameters 
	     = ServiceParameter.findByServiceid(con, service.getParentserviceid());

	     boolean layer3=true;
	     if (parentServiceParameters != null)
			 {
	       for (int i=0; i<parentServiceParameters.length; i++)
			   {
	         if (parentServiceParameters[i].getAttribute() != null && 
	        		 parentServiceParameters[i].getValue() != null) 
				 {
	           if ((parentServiceParameters[i].getAttribute()).equals("VPNLayerType")
	        		   && (parentServiceParameters[i].getValue()).equals("layer-2"))
	  	             layer3=false;
	              }
	            }//for
	         }

	     if (service.getServiceid() != null)
	       table.put("serviceid", service.getServiceid());
	     if (service.getState() != null)
	       table.put("state", service.getState());
	     if (service.getSubmitdate() != null)
	       table.put("submitdate", service.getSubmitdate());
	     if (service.getModifydate() != null)
	       table.put("modifydate", service.getModifydate());
	     if (service.getType() != null) {
	       String serviceType = service.getType();
	       if (!layer3)
	         serviceType += "2";
	       table.put("type", serviceType);
	       }
	     if (service.getCustomerid() != null)
	       table.put("customerid", service.getCustomerid());
	     if (service.getParentserviceid() != null)
	       table.put("parentserviceid", service.getParentserviceid());

	     table.put("messageid", messageid);

	     ServiceParameter[] serviceParameters
	     = ServiceParameter.findByServiceid(con, service.getServiceid());

	     if (serviceParameters != null) {
	       for (int i=0; i<serviceParameters.length; i++) {
	         // This method: "fillParameterTable" is call only from the delete operations and in delete the operator attribute must not be changed to keep the current user 
	         if (serviceParameters[i].getAttribute() != null && !serviceParameters[i].getAttribute().equals("operator") && serviceParameters[i].getValue() != null) {
	           table.put(serviceParameters[i].getAttribute(), serviceParameters[i].getValue());
	         }
	       }
	     }
	     table.remove("StartTime");
	     
	      return table;
	   }
	 
	  public static CAR getSiteServiceRateLimit(Connection connection, String serviceId) throws SQLException {
	
		  Logger logger = Logger.getLogger("CRMPortalLOG");
		 Service childs [] =Service.findByParentserviceid(connection , serviceId);
		 CAR car=null;
		 CAR mincar=null;
		 int minBw=0;
		
		 if (childs != null && childs.length != 0 ){
			   mincar=getServiceRateLimit(connection,childs[0].getServiceid());
			   minBw=mincar.getAveragebw();
			   logger.debug("child length is "+ childs.length);
			  for(int i=1; i<childs.length ; ++i){
				   logger.debug("child length is "+ i);
				  car=getServiceRateLimit(connection,childs[i].getServiceid());
			  		 if(minBw > car.getAveragebw()){
			  			mincar= car;
			  			minBw =car.getAveragebw();
			  		 }
			  			
			  }
			 }else{
			  
			 throw new SQLException("Could not find the child services"); 
		  }
		 
		
		  logger.debug("Ratelimit of service " +serviceId +"is" +mincar);
		 
		return mincar;
		
		}
      
  public static CAR getSiteServiceRateLimit(Connection connection, String siteid, String vpnid) throws SQLException
  {
    Logger logger = Logger.getLogger("CRMPortalLOG");
    Service childs[] = Service.findByParentserviceid(connection, siteid);
    CAR car = null;
    CAR mincar = null;
    int minBw = 0;

    if (childs != null && childs.length != 0) {
      mincar = getServiceRateLimit(connection, childs[0].getServiceid());
      minBw = mincar.getAveragebw();
      logger.debug("child length is " + childs.length);
      for (int i = 1; i < childs.length; ++i) {
        VPNMembership mem = VPNMembership.findByVpnidsiteattachmentid(connection, vpnid, childs[i].getServiceid());
        if (mem != null) {
          logger.debug("child length is " + i);
          car = getServiceRateLimit(connection, childs[i].getServiceid());
          if (minBw > car.getAveragebw()) {
            mincar = car;
            minBw = car.getAveragebw();
          }
        }
      }
    } else {
      throw new SQLException("Could not find the child services");
    }

    logger.debug("Ratelimit of vpn|site " + vpnid + "|" + siteid + " is " + mincar);
    return mincar;

  }
	  
	  public static CAR getServiceRateLimit(Connection connection, String serviceId) throws SQLException {
          Logger logger = Logger.getLogger("CRMPortalLOG");
		  CAR car =null;
		  String pk = serviceId+"||"+"CAR";
		  ServiceParameter ratelimit = ServiceParameter.findByPrimaryKey(connection,pk);
		  String rLValue =ratelimit.getValue();
		  car = CAR.findByPrimaryKey(connection,rLValue);
          logger.debug("RateLimit of  of service " +serviceId +" is " + car);
		  return car;
	  }


	   public static String getSiteServiceQoSCompliance(Connection connection, String serviceId) throws SQLException {
	
		  Logger logger = Logger.getLogger("CRMPortalLOG");
		  Service childs [] =Service.findByParentserviceid(connection , serviceId);
	      String compliance = Constants.COMPLAINT;
		  if (childs != null && childs.length != 0 ){
			  for(int i=0; i<childs.length ; ++i){
      				String tmp=getServiceQoSCompliance(connection,childs[i].getServiceid());			  			
						if(!tmp.equalsIgnoreCase(Constants.COMPLAINT)){
							compliance = tmp;
							break;
						}
			  }

		  }else{
			  
			 throw new SQLException("Could not find the child services"); 
		  }
		 		
		  logger.debug("Qos Compliance of  of service " +serviceId +" is " +compliance);
		 
		return compliance;
		
		}
       
  public static String getSiteServiceQoSCompliance(Connection connection, String siteid, String vpnid) throws SQLException
  {

    Logger logger = Logger.getLogger("CRMPortalLOG");
    Service childs[] = Service.findByParentserviceid(connection, siteid);
    String compliance = Constants.COMPLAINT;
    if (childs != null && childs.length != 0) {
      for (int i = 0; i < childs.length; ++i) {
        VPNMembership mem = VPNMembership.findByVpnidsiteattachmentid(connection, vpnid, childs[i].getServiceid());
        if (mem != null) {
          String tmp = getServiceQoSCompliance(connection, childs[i].getServiceid());
          if (!tmp.equalsIgnoreCase(Constants.COMPLAINT)) {
            compliance = tmp;
            break;
          }
        }
        
      }

    } else {

      throw new SQLException("Could not find the child services");
    }

    logger.debug("Qos Compliance of  of vpn|site " + vpnid + "+" + siteid + " is " + compliance);

    return compliance;

  }
	  
	   public static String getServiceQoSCompliance(Connection connection, String serviceId) throws SQLException {
		
		 Logger logger = Logger.getLogger("CRMPortalLOG");
	     String compliance = Constants.COMPLAINT;
		 Profile profile =null;
		 String  pkForQos = serviceId+"||"+Constants.QOS_PROFILE;
		 ServiceParameter param = ServiceParameter.findByPrimaryKey(connection,pkForQos);
		 String qos = param.getValue();
          if (qos != null) {
			  profile =Profile.findByQosprofilename(connection,qos);
			  if (profile != null)  {
				 compliance = profile.getCompliant();
			  }
          }
		  logger.debug("Qos Compliance of  of service " +serviceId +" is " +compliance);
		  return compliance;
	  }

	  public static String getServiceParam(Connection connection, String serviceId, String Param) throws SQLException {
		  String value =null;
		  ServiceParameter ServiceParam = ServiceParameter.findByServiceidattribute(connection,serviceId,Param);
		  if (ServiceParam !=null)
		   value =ServiceParam.getValue();
		   return value;
	  }
 }
