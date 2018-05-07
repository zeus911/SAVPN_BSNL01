package com.hp.ov.activator.crmportal.helpers;

import java.sql.Connection;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.hp.ov.activator.crmportal.bean.Service;
import com.hp.ov.activator.crmportal.bean.ServiceParameter;
import com.hp.ov.activator.crmportal.common.IdGenerator;
import com.hp.ov.activator.crmportal.utils.Constants;

public class DeleteGISSiteAttachmentListener implements StateListener{
	 Logger logger = Logger.getLogger("CRMPortalLOG");

	  public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception {

	    //if (PortalSyncListener.DEBUG) {
		  logger.debug("Inside StateListener for Delete  GIS site attachment");
	      logger.debug("connection = " + connection);
	      logger.debug("serviceId = " + serviceId);
	      logger.debug("state = " + state);
	      logger.debug("data = " + data);
	    //}

	    if (state == null)
	      return StateListener.REMOVE_AND_CONTINUE;

	    if (serviceId == null)
	      return StateListener.REMOVE_AND_CONTINUE;

	    if (connection == null)
	      return StateListener.REMOVE_AND_CONTINUE;

	  
	    // if service failed or in some transitional state then everything ok and let's wait for our state
	    if (!state.equalsIgnoreCase("Delete"))
	        return StateListener.STAY_AND_CONTINUE;
	  
	    
	    
	    try{
	    
	    
	    HashMap allParameters=new HashMap(); 
	    
		   
		String socketListener_port = PortalSyncListener.servletConfig.getInitParameter(Constants.SOCKET_LIS_PORT);
	    String socketListener_host = PortalSyncListener.servletConfig.getInitParameter (Constants.SOCKET_LIS_HOST);
		String request_synchronisation = PortalSyncListener.servletConfig.getInitParameter (Constants.REQUEST_SYNCHRONISATION);
	    String templateDir = PortalSyncListener.servletConfig.getInitParameter (Constants.TEMPLATE_DIR); 
	    String logDir = PortalSyncListener.servletConfig.getInitParameter (Constants.LOGS_DIRECTORY); 
	    
	    allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_DELETE);
	    allParameters.put("HOST", socketListener_host);
	    allParameters.put("PORT", socketListener_port);
	    allParameters.put("TEMPLATE_DIR",templateDir);
	    allParameters.put("operator", ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_OPERATOR));
	    allParameters.put("LOG_DIRECTORY", logDir);
	    allParameters.put("request_synchronisation", request_synchronisation);
	   
	   
	      //Get one attachment service id and store
	    //chnages for attachment starts here 
	    
	    IdGenerator idGenerator = new IdGenerator(connection);
	      
	    
	    // get the attachment service here . 
	    
	    Service attachmentService =Service.findByServiceid(connection,serviceId);
	    
	    if (attachmentService == null)
	    	 return StateListener.REMOVE_AND_CONTINUE;
	    
	     Service siteService = Service.findByServiceid(connection,attachmentService.getParentserviceid());
	   
	     if(siteService == null)
	    	 return StateListener.REMOVE_AND_CONTINUE;
	    
	    //here count the attachments associated with this site 
	     // if the count is one site delete request has to be sent . 
	     
	     Service attachments [] =Service.findByParentserviceid(connection,siteService.getServiceid());
	     if(attachments != null){
	           logger.debug("DeleteGISSiteAttachmentListener:: Site_"+siteService.getServiceid()+"'s attachments.length is "+attachments.length);
	     }else {
	           logger.debug("DeleteGISSiteAttachmentListener:: Site_"+siteService.getServiceid()+" is null");
	     }          
	     
	     if(attachments != null && attachments.length == 1 ){
	    	 //send the Delete Site Request here . 
	    	 
	    	 allParameters = ServiceUtils.fillParameterTable(allParameters, siteService, idGenerator.getMessageId(),connection);
	    	 //set skip_activation value
	         //PR 15247
	         //allParameters.put("skip_activation",PortalSyncListener.servletConfig.getInitParameter("SKIP_ACTIVATION"));

	            allParameters.put("type", "GIS-Site");
	        allParameters.put(Constants.XSLPARAM_XSLNAME,Constants.XSLNAME_SITE);
	    	 
	    	   siteService.setState("Delete_Requested");
	           ServiceUtils.updateService(connection, siteService);
	           
	           SendXML sender = new SendXML(allParameters);
	           sender.Init();
	           sender.Send();
	           logger.debug("DeleteGISSiteAttachmentListener:: Delete site_"+siteService.getServiceid()+" is sent");
	    	 
	     }else if(attachments != null){
	       
	       //set the protection to initial attachment
	        Service[] protection = Service.findByParentserviceid(connection, attachmentService.getParentserviceid(), 
	           "type='GIS-Protection' and serviceid in (select serviceid from crm_serviceparam where attribute='attachmentid' and value='"+attachmentService.getServiceid()+"')");
	       if(protection != null && protection.length > 0){
	         Service prt = protection[0];
	         prt.setType("GIS-Attachment");
	         ServiceUtils.updateService(connection, prt);        
	       
		       ServiceParameter parameter = ServiceParameter.findByServiceidattribute(connection, prt.getServiceid(), Constants.SERVICE_PARAM_ATTACHMENTID);
		       parameter.delete(connection);

				String []multicastServiceParameters = new String[] { 
					    Constants.SERVICE_PARAM_MULTICASTQOSCLASS,
					    Constants.SERVICE_PARAM_MULTICASTRP,
					    Constants.SERVICE_PARAM_MULTICASTRATELIMIT,
					    Constants.SERVCIE_PARAM_MULTICASTSTATUS,
					    Constants.SERVICE_PARAM_MULTICASTVPNID,
					    Constants.SERVICE_PARAM_ATTACHMENTTYPE
					};
					for (String multicastServiceParameter:multicastServiceParameters) {
						ServiceParameter sParameter = null;
						sParameter = ServiceParameter.findByServiceidattribute(connection, serviceId, multicastServiceParameter);
						if ( sParameter != null ) {
							ServiceUtils.saveOrUpdateParameter(connection, prt.getServiceid(), multicastServiceParameter, sParameter.getValue());
						}
					} 	       
		       
		       
		       
	       }
	    	 logger.debug("DeleteGISSiteAttachmentListener::Site has more than one attachments So Delete site request is not sent");
	     }
	    	 
		   
		
	    }catch(Exception ex){
	    
	    		logger.error("DeleteGISSiteAttachmentListener:::Exception in DeleteGISSiteAttachmentListener"+ex);
	    }

	    //chnages for attachment id ends here 
	    
	      
	    return StateListener.REMOVE_AND_CONTINUE;

	  }

}
