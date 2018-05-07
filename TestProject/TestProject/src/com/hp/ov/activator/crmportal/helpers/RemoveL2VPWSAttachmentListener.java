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
import com.hp.ov.activator.crmportal.helpers.VPWSDeleteUtils;

public class RemoveL2VPWSAttachmentListener implements StateListener{
    Logger logger = Logger.getLogger(Constants.CRMPORTALLOG);

    public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception {
        //if (PortalSyncListener.DEBUG) {
            logger.debug("Inside RemoveL2VPWSAttachmentListener");
            logger.debug("connection = " + connection);
            logger.debug("serviceId = " + serviceId);
            logger.debug("state = " + state);
            logger.debug("data = " + data);
            //System.out.println("Inside RemoveL2VPWSAttachmentListener serviceId = " + serviceId);
        //}
        try{

            if (state == null)
                return StateListener.REMOVE_AND_CONTINUE;
            
            if (serviceId == null)
                return StateListener.REMOVE_AND_CONTINUE;
            
            if (connection == null)
                return StateListener.REMOVE_AND_CONTINUE;
                
            String aEndAttachmentServiceID=serviceId;
            String zEndAttachmentServiceID=null;
            Service zEndAttchmentService=null;
      		//Try to get the zEnd attachement id to set the status. Get it through VPN membership.
            String vPWSVPNServiceId=null;
      		VPNMembership[] vpwsVPNs = VPNMembership.findBySiteattachmentid(connection, serviceId);
      		if (vpwsVPNs != null && vpwsVPNs.length == 1 ) {
          		VPNMembership[] attachmentMembers = VPNMembership.findByVpnid(connection, vpwsVPNs[0].getVpnid());
          		if ( attachmentMembers != null && attachmentMembers.length == 2 ) {
          		    if ( ! attachmentMembers[0].getSiteattachmentid().equals(aEndAttachmentServiceID) ) {
          		        zEndAttachmentServiceID=attachmentMembers[0].getSiteattachmentid();
          		    } else {
          		        zEndAttachmentServiceID=attachmentMembers[1].getSiteattachmentid();
          		    }
          		} else {
          		    logger.warn("zEnd attachement is not found.");
          		}
                vPWSVPNServiceId=vpwsVPNs[0].getVpnid();
                //System.out.println("Inside RemoveL2VPWSAttachmentListener vPWSVPNServiceId = " + vPWSVPNServiceId);
        	} else {
        	    //Invalid scenario
        	    //Attachement is not part of any VPN or attachement is part of more than one VPN.
        	    logger.warn("RemoveL2VPWSAttachmentListener (aEnd att id "+aEndAttachmentServiceID+" ): Should never reach here.Attachement is not part of any VPN or attachement is part of more than one VPN.");
        	}
        	if ( zEndAttachmentServiceID != null ) {
        	    zEndAttchmentService=Service.findByPrimaryKey(connection,zEndAttachmentServiceID);
        	    if ( zEndAttchmentService != null ) {
        	        if (!state.equals(Constants.SERVICE_STATE_DELETE) && !state.contains("REUSE")) {
        	          zEndAttchmentService.setState(SaSyncThread.getPENextState(state));
        	        } else {
        	          zEndAttchmentService.setState(state);
        	        }
                    
                    ServiceUtils.updateService(connection, zEndAttchmentService);
                }
            }
        	if(state.equals(Constants.STATE_DELETE_FAILURE)){
        	//update the state of aEnd and zEnd site as Failure
              String aEndAttachmentSiteID=ServiceUtils.getServiceParam(connection, vPWSVPNServiceId,Constants.SERVICE_PARAM_SITE_SERVICE_ID_AEND);
              Service aEndAttachmentSite=Service.findByPrimaryKey(connection, aEndAttachmentSiteID);
              aEndAttachmentSite.setState(state);
              ServiceUtils.updateService(connection, aEndAttachmentSite);
              
              String zEndAttachmentSiteID=ServiceUtils.getServiceParam(connection, vPWSVPNServiceId,Constants.SERVICE_PARAM_SITE_SERVICE_ID_ZEND);
              Service zEndAttachmentSite=Service.findByPrimaryKey(connection, zEndAttachmentSiteID);
              zEndAttachmentSite.setState(state);
              ServiceUtils.updateService(connection, zEndAttachmentSite);
              
              
              //update the state of vpn id
              Service vpws=Service.findByPrimaryKey(connection, vPWSVPNServiceId);
              vpws.setState(state);
              ServiceUtils.updateService(connection, vpws);
        	}

            if (state.indexOf(Constants.SERVICE_STATE_OK) == -1 && state.indexOf(Constants.SERVICE_STATE_MSG_FAILURE) == -1 &&  ! state.equals(Constants.SERVICE_STATE_DELETE))
                return StateListener.STAY_AND_CONTINUE;


            HashMap allParameters=new HashMap();
            String skip_activation=ServiceUtils.getServiceParam(connection, vPWSVPNServiceId,Constants.SKIP_ACTIVATION);
            
            String socketListener_port = PortalSyncListener.servletConfig.getInitParameter(Constants.SOCKET_LIS_PORT);
            String socketListener_host = PortalSyncListener.servletConfig.getInitParameter (Constants.SOCKET_LIS_HOST);
            String request_synchronisation = PortalSyncListener.servletConfig.getInitParameter (Constants.REQUEST_SYNCHRONISATION);
            String templateDir = PortalSyncListener.servletConfig.getInitParameter (Constants.TEMPLATE_DIR); 
            String logDir = PortalSyncListener.servletConfig.getInitParameter (Constants.LOGS_DIRECTORY); 
            
            allParameters.put(Constants.XSLPARAM_HOST, socketListener_host);
            allParameters.put(Constants.XSLPARAM_PORT, socketListener_port);
            allParameters.put(Constants.XSLPARAM_TEMPLATE_DIR,templateDir);
			allParameters.put("operator", ServiceUtils.getServiceParam(connection, vPWSVPNServiceId, Constants.SERVICE_PARAM_OPERATOR));
            allParameters.put(Constants.XSLPARAM_LOG_DIRECTORY, logDir);
            allParameters.put(Constants.XSLPARAM_REQUEST_SYNCHRONISATION, request_synchronisation);     
            allParameters.put(Constants.XSLPARAM_TYPE, Constants.TYPE_SITE);
            allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_DELETE);
            allParameters.put(Constants.SKIP_ACTIVATION, skip_activation);
            IdGenerator idGenerator = new IdGenerator(connection);
            String messageid = idGenerator.getMessageId();
            allParameters.put(Constants.XSLPARAM_MESSAGEID,messageid);
            
        	Service aEndAttchmentService=Service.findByPrimaryKey(connection,aEndAttachmentServiceID);

            String aEndSiteServiceId=(aEndAttchmentService!=null) ? aEndAttchmentService.getParentserviceid():null;
            String zEndSiteServiceId=(zEndAttchmentService!=null) ? zEndAttchmentService.getParentserviceid():null;
            boolean sendRequest=VPWSDeleteUtils.DeleteSite(connection,allParameters,vPWSVPNServiceId,aEndSiteServiceId,zEndSiteServiceId);
            if ( sendRequest ) {
                try {
                    SendXML sender = new SendXML(allParameters);
                    sender.Init();
                    sender.Send();
                } catch (IOException e){
    	            Service aEndAttachment= Service.findByPrimaryKey(connection, aEndAttachmentServiceID);
    	            aEndAttachment.setState(Constants.SERVICE_STATE_FAILURE);
    	            if ( zEndAttchmentService != null ) {
    	                zEndAttchmentService.setState(Constants.SERVICE_STATE_FAILURE);
    	            }
                    try{
                        ServiceUtils.updateService(connection, aEndAttachment);
                        ServiceUtils.saveOrUpdateParameter(connection, aEndAttachmentServiceID,Constants.SERVICE_PARAM_FAILURE_DESCRIPTION,e.getMessage());
                        if ( zEndAttchmentService != null ) {
                            ServiceUtils.updateService(connection, zEndAttchmentService);
                            ServiceUtils.saveOrUpdateParameter(connection, zEndAttachmentServiceID,Constants.SERVICE_PARAM_FAILURE_DESCRIPTION,e.getMessage());
                        }
                    }catch(Exception ex) {
                        logger.error("Exception in RemoveL2VPWSAttachmentListener "+ex);
                    }
                }
            }
            if ( zEndAttchmentService != null ) { 
                ServiceUtils.deleteService(connection, zEndAttchmentService);
            }
        }catch(Exception ex){
                logger.error("Exception in RemoveL2VPWSAttachmentListener "+ex);
        }
        return StateListener.REMOVE_AND_CONTINUE;
        
    } //End public int proccedState(Connection connection, String serviceId, String state, String data)
    
} //End class RemoveL2VPWSAttachmentListener implements StateListener


