
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.hp.ov.activator.crmportal.bean.Service;
import com.hp.ov.activator.crmportal.bean.ServiceParameter;
import com.hp.ov.activator.crmportal.bean.VPNMembership;
import com.hp.ov.activator.crmportal.common.IdGenerator;
import com.hp.ov.activator.crmportal.utils.Constants;

public class CreateL2VPNStateListener implements StateListener{
  private Logger logger = Logger.getLogger("CRMPortalLOG");
  public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception {

    if (PortalSyncListener.DEBUG) {
      logger.debug("connection = " + connection);
      logger.debug("serviceId = " + serviceId);
      logger.debug("state = " + state);
      logger.debug("data = " + data);
    }

    if (state == null)
      return StateListener.REMOVE_AND_CONTINUE;

    if (serviceId == null)
      return StateListener.REMOVE_AND_CONTINUE;

    if (connection == null)
      return StateListener.REMOVE_AND_CONTINUE;

    if (PortalSyncListener.DEBUG) {
        logger.debug("CreateL2VPNStateListener.proccedState: "+state);
    }

    // if service failed or in some transitional state then everything ok and let's wait for our state
    if (state.indexOf("Ok") == -1 && state.indexOf("MSG_Failure") == -1)
      return StateListener.STAY_AND_CONTINUE;
      
   //Add for create layer2-Attachment for layer2-site
  try
  {
    	    
    Thread.sleep(2000);
    //Sleeping for two seconds to wait for the commit of the site parameters
    
    String vpnserviceid = ServiceUtils.getServiceParam(connection, serviceId, "l2vpnserviceid");
    if (vpnserviceid == null)
      vpnserviceid = "";
    logger.debug("CreateL2VPNStateListener: vpnserviceid: " + vpnserviceid);
    
   	if ( Service.findByPrimaryKey(connection, serviceId).getType().equalsIgnoreCase("site"))  
   	{// modified by tanye. For multi service, there are not layer2-Site, layer3-Site for 'type' column any more. Only Site!
  
    HashMap allParameters=new HashMap(); 
		String socketListener_port = PortalSyncListener.servletConfig.getInitParameter(Constants.SOCKET_LIS_PORT);
    String socketListener_host = PortalSyncListener.servletConfig.getInitParameter (Constants.SOCKET_LIS_HOST);
		String request_synchronisation = PortalSyncListener.servletConfig.getInitParameter (Constants.REQUEST_SYNCHRONISATION);
    String templateDir = PortalSyncListener.servletConfig.getInitParameter (Constants.TEMPLATE_DIR); 
    String logDir = PortalSyncListener.servletConfig.getInitParameter (Constants.LOGS_DIRECTORY); 
    allParameters.put("HOST", socketListener_host);
    allParameters.put("PORT", socketListener_port);
    allParameters.put("TEMPLATE_DIR",templateDir);
	allParameters.put("operator", ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_OPERATOR));
    allParameters.put("LOG_DIRECTORY", logDir);
    allParameters.put("request_synchronisation", request_synchronisation);
   
   
    //Get one attachment service id and store
    //changes for attachment is starts here 
    
    IdGenerator idGenerator = new IdGenerator(connection);
    String attachment_service_id = idGenerator.getServiceId();
    
    //ServiceUtils.saveOrUpdateParameter(connection,serviceId,"initial_attachment_id",attachment_service_id);
    
    ServiceParameter stTime=ServiceParameter.findByServiceidattribute(connection, serviceId,"StartTime");
    String startTime="";
    if(stTime!=null)
    {
        	startTime=stTime.getValue();
        }
   // logger.debug("StateListener for layer2site: start time is "+startTime);
  
    Service attachment_service =  new Service();
    	   
 	   //attachment_service.setState("PE_Request_Sent");
       attachment_service.setState("Request_Sent");
           if (startTime!=null && !startTime.equalsIgnoreCase(""))
        	   
 	   attachment_service.setState("Sched_Request_Sent");
    
   //logger.debug("StateListener for layer2site: state set is  "+attachment_service.getState());
           
		Service site= Service.findByPrimaryKey(connection, serviceId);
    ServiceParameter siteparams[]=ServiceParameter.findByServiceid(connection, serviceId);
    attachment_service.setCustomerid(site.getCustomerid());
    attachment_service.setEndtime(site.getEndtime());
    attachment_service.setModifydate(site.getModifydate());
    attachment_service.setLastupdatetime(site.getLastupdatetime());
    attachment_service.setNextoperationtime(site.getNextoperationtime());
    attachment_service.setParentserviceid(site.getServiceid());
    attachment_service.setPresname(site.getPresname()+"layer2-Attachment");
    attachment_service.setServiceid(attachment_service_id);
    //attachment_service.setState(site.getState());
    attachment_service.setSubmitdate(site.getSubmitdate());
    attachment_service.setType("layer2-Attachment");
    attachment_service.store(connection);
   	logger.debug("laye2site listener:::::::::::::Stored the attachment service bean");
    
    VPNMembership mem = new VPNMembership();
    mem.setVpnid(vpnserviceid);
    mem.setSiteattachmentid(attachment_service_id);
    mem.setConnectivitytype("LAYER2_NEW" + serviceId);
    mem.store(connection);
    logger.debug("Stored the VPNMembership: " + mem.toString());
    
 // Send message to SA- Start. 
    //logger.debug("laye2site listener:::::::::::::site parameters");
    for(int i=0;i<siteparams.length;i++){
    	
    	ServiceParameter tmp=siteparams[i];
    	tmp.setServiceid(attachment_service_id);
    	//logger.debug(tmp.getAttribute()+":::::::"+tmp.getValue());
    	allParameters.put(tmp.getAttribute(),tmp.getValue());
    	if(!tmp.getAttribute().equals(Constants.PARAMETER_LAST_COMMIT)){
    	    	tmp.store(connection);
    	}
     }
    	
    allParameters.put("parentserviceid",serviceId);
    allParameters.put("attachmenttype","Initial");
    
    allParameters.put("type", "layer2-Attachment");
    allParameters.put("ACTION", Constants.ACTION_ADD);
    allParameters.put(Constants.XSLPARAM_ADDRESS_TYPE, Constants.IP_ADDR_V4);
    allParameters.put("serviceid",attachment_service_id);
    ServiceUtils.saveOrUpdateParameter(connection,attachment_service_id,"Site_Service_id",serviceId);
    
        //add by LuYan 20080814  
    ServiceUtils.saveOrUpdateParameter(connection, attachment_service_id, 
        		  Constants.PARAMETER_LAST_COMMIT,
        		  CreateL2VPNStateListener.class.getName());
    
    
    allParameters.put("vpnserviceid",vpnserviceid);
    ServiceUtils.saveOrUpdateParameter(connection,attachment_service_id,"vpnserviceid",vpnserviceid); 
    
    allParameters.put("presname",site.getPresname()+"layer2-Attachment");
    //ServiceUtils.saveOrUpdateParameter(connection,attachment_service_id,"presname",site.getPresname()+"layer2-Attachment"); 
    
	
    String messageid = idGenerator.getMessageId();
    allParameters.put("messageid",messageid);
    
/**PR15830 BEGIN**/
    ServiceParameter ethServiceType = ServiceParameter.findByServiceidattribute(connection, vpnserviceid, "EthServiceType");
    if(ethServiceType != null){
      ServiceUtils.saveOrUpdateParameter(connection,attachment_service_id,ethServiceType.getAttribute(),ethServiceType.getValue()); 
    }
    /**PR15830 END**/       
//  set skip_activation value
    //PR 15247
  //  allParameters.put("skip_activation",PortalSyncListener.servletConfig.getInitParameter("SKIP_ACTIVATION"));
    // Send message to SA.
    
    try {
    SendXML sender = new SendXML(allParameters);
    sender.Init();
    sender.Send();
    } catch (IOException e){
      attachment_service.setState(Constants.SERVICE_STATE_MSG_FAILURE);
      try{
        ServiceUtils.updateService(connection, attachment_service);
        ServiceUtils.saveOrUpdateParameter(connection, attachment_service_id, 
          "Failure_Description",
          e.getMessage());
      }catch(Exception ex) {
        
      }
    }
    
    
   	} 
		//Add for create layer2-Attachment for layer2-site -end
    if (data == null)
      return StateListener.REMOVE_AND_CONTINUE;
    
    
    ServiceParameter parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, "VLANId");
    if (PortalSyncListener.DEBUG) {
      logger.debug("parameter = " + parameter);
    }
    if(!(Service.findByPrimaryKey(connection, serviceId).getType().equalsIgnoreCase("Site") ||
    			Service.findByPrimaryKey(connection, serviceId).getType().equalsIgnoreCase("layer2-VPN"))){
	    if (parameter != null && parameter.getValue() != null && !parameter.getValue().equals("0")) {
	      if (PortalSyncListener.DEBUG) {
	        logger.debug("parameter.getValue() = " + parameter.getValue());
	      }
	      // If parameter exists, then do not update it
	    } else {
	
	      ServiceParameter serviceParameter = new ServiceParameter(serviceId, "VLANId", data);
	      if ( parameter == null )
	        serviceParameter.store(connection);
	      else{
	        serviceParameter.update(connection);
	      }
	    }
    }
    //update by Lu Yan 20080827
    // Check if site has to be modified
    Service service = Service.findByServiceid(connection,serviceId);
    ServiceParameter siteParameter = ServiceParameter.findByServiceidattribute(connection, service.getParentserviceid(), "VLANId");
		if (siteParameter == null || siteParameter.getValue() == null || siteParameter.getValue().equals("0") ) {

      ServiceParameter siteServiceParameter = new ServiceParameter(service.getParentserviceid(), "VLANId", data);

      if ( siteParameter == null )
        siteServiceParameter.store(connection);
      else{
        siteServiceParameter.update(connection);
       }
    	}
	
	  // Check if VPN has to be modified      
    ServiceParameter vpnParameter = ServiceParameter.findByServiceidattribute(connection, vpnserviceid, "VLANId");
		if (vpnParameter == null || vpnParameter.getValue() == null || vpnParameter.getValue().equals("0") ) {

      ServiceParameter vpnServiceParameter = new ServiceParameter(vpnserviceid, "VLANId", data);

      if ( vpnParameter == null )
        vpnServiceParameter.store(connection);
      else{
        vpnServiceParameter.update(connection);
       }
    	}
	}catch(Exception ex)
	{
    
    		logger.error("Exception in laye2VPN listener"+ex);
  }  
    return StateListener.REMOVE_AND_CONTINUE;

  }
}
