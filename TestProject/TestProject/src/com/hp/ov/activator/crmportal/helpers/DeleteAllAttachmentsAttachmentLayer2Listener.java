
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;

import com.hp.ov.activator.crmportal.bean.ServiceParameter;
import com.hp.ov.activator.crmportal.bean.VPNMembership;
import com.hp.ov.activator.crmportal.helpers.StateListener;
import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;

import com.hp.ov.activator.crmportal.common.*;
import com.hp.ov.activator.crmportal.bean.*;
import com.hp.ov.activator.crmportal.helpers.*;

import java.sql.*;
import java.text.*;
import java.util.*;
import java.util.Date;
import java.sql.Connection;
import java.io.IOException;

import javax.servlet.http.*;

import org.apache.log4j.Logger;

public class DeleteAllAttachmentsAttachmentLayer2Listener implements StateListener
{
	Logger logger = Logger.getLogger("CRMPortalLOG");

	public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception 
   {
      logger.debug("connection = " + connection);
      logger.debug("serviceId = " + serviceId);
      logger.debug("state = " + state);
      logger.debug("data = " + data);
	  
	  //System.out.println("serviceId = " + serviceId+" || state = " + state);

    if (state == null)
      return StateListener.REMOVE_AND_CONTINUE;

    if (serviceId == null)
      return StateListener.REMOVE_AND_CONTINUE;

    if (connection == null)
      return StateListener.REMOVE_AND_CONTINUE;

  
    // if service failed or in some transitional state then everything ok and let's wait for our state
    if (!state.equalsIgnoreCase("Delete"))
        return StateListener.STAY_AND_CONTINUE;
    //logger.debug("DeleteL2SiteAttachmentListener:::::StateListener for delete layer3 site attachment  fired:need to send the Delete site request here");
    
    
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
           logger.debug("DeleteAllAttachmentsAttachmentLayer2Listener:: Site_"+siteService.getServiceid()+"'s attachments.length is "+attachments.length);
     }else {
           logger.debug("DeleteAllAttachmentsAttachmentLayer2Listener:: Site_"+siteService.getServiceid()+" is null");
     }    
          
     if(attachments != null && attachments.length == 1 ){
    	 //send the Delete Site Request here . 
    	 
    	 allParameters = ServiceUtils.fillParameterTable(allParameters, siteService, idGenerator.getMessageId(),connection);
    	 //set skip_activation value
         //PR 15247
 //        allParameters.put("skip_activation",PortalSyncListener.servletConfig.getInitParameter("SKIP_ACTIVATION"));
    	  allParameters.put("type", "layer2-Site");
            allParameters.put(Constants.XSLPARAM_XSLNAME,Constants.XSLNAME_SITE);
    	 
    	   siteService.setState("Delete_Requested");
           ServiceUtils.updateService(connection, siteService);
           
           SendXML sender = new SendXML(allParameters);
           sender.Init();
           sender.Send();
           logger.debug("DeleteAllAttachmentsAttachmentLayer2Listener:: Delete site_"+siteService.getServiceid()+" is sent");
		   
		   String vpnid = ServiceUtils.getServiceParam(connection, serviceId, "vpnserviceid");
			
			Service vpnService = Service.findByServiceid(connection, vpnid);
		
			// Save listener for bulk delete operation
			ServiceUtils.saveOrUpdateParameter(connection, vpnService.getServiceid(), Constants.PARAMETER_LAST_COMMIT, DeleteAllAttachmentsVPNLayer2Listener.class.getName());
			
			HashMap serviceParameters = new HashMap();

			serviceParameters.put("serviceid", vpnService.getServiceid());
			serviceParameters.put("presname", vpnService.getPresname());
			serviceParameters.put("submitdate", vpnService.getSubmitdate());
			serviceParameters.put("modifydate", vpnService.getModifydate());
			serviceParameters.put("type", vpnService.getType());
			serviceParameters.put("customerid", vpnService.getCustomerid());
			serviceParameters.put("modifydate", Constants.DEFAULT_DATE_FORMAT.format(new java.util.Date()));
			serviceParameters.put("HOST", socketListener_host);
			serviceParameters.put("PORT", socketListener_port);
			serviceParameters.put("TEMPLATE_DIR", templateDir);
			serviceParameters.put("operator", ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_OPERATOR));
			serviceParameters.put("LOG_DIRECTORY", logDir);
			serviceParameters.put(Constants.XSLPARAM_REQUEST_SYNCHRONISATION, request_synchronisation);
			serviceParameters.put("ACTION", "DeleteAllAttachments");
			serviceParameters.put("activation_name", "delete_All_Attachments");
								
			String messageid = idGenerator.getMessageId();
			serviceParameters.put(Constants.XSLPARAM_MESSAGEID, messageid);
			
			ServiceParameter[] serviceParamArray = ServiceParameter.findByServiceid(connection, vpnService.getServiceid());

			if (serviceParamArray != null)
			{
				for (int j = 0; j < serviceParamArray.length; j++)
				{
					serviceParameters.put(serviceParamArray[j].getAttribute(), serviceParamArray[j].getValue());
				}
			}
			
			ServiceUtils.saveOrUpdateParameter(connection, serviceId, "hidden_LastModifyAction", "DeleteAllAttachments");
			
			try 
			{
				SendXML sender2 = new SendXML(serviceParameters);
				sender2.Init();
				sender2.Send();
			} 
			catch (IOException e) 
			{
				try 
				{
					vpnService.setState(Constants.SERVICE_STATE_FAILURE);
					ServiceUtils.updateService(connection, vpnService);
					ServiceUtils.saveOrUpdateParameter(connection, vpnService.getServiceid(), Constants.SERVICE_PARAM_FAILURE_DESCRIPTION, e.getMessage());
				} 
				catch (Exception ex) 
				{
					logger.error("Exception in DeleteAllAttachmentsAttachmentLayer2Listener listener" + ex);
				}
			}
    	 
     }
	 else if (state.indexOf("Failure") > -1)
	{
			// Set VPN status to failed
			String vpnid = ServiceUtils.getServiceParam(connection, serviceId, "vpnserviceid");
			Service vpnservice = Service.findByServiceid(connection, vpnid);
			vpnservice.setState("Modify_Failure");
			ServiceUtils.updateService(connection, vpnservice);
			ServiceUtils.saveOrUpdateParameter(connection, vpnservice.getServiceid(), Constants.SERVICE_PARAM_FAILURE_DESCRIPTION, "Bulk attachment deletion failed");
	}
	 else{
    	 logger.debug("DeleteAllAttachmentsAttachmentLayer2Listener::Site has more than one attachments So Delete site request is not sent");
     }
    	 
	   
	
    }catch(Exception ex){
    
    		logger.error("DeleteAllAttachmentsAttachmentLayer2Listener:::Exception in DeleteAllAttachmentsAttachmentLayer2Listener"+ex);
    }

    //chnages for attachment id ends here 
    
      
    return StateListener.REMOVE_AND_CONTINUE;
}
}
