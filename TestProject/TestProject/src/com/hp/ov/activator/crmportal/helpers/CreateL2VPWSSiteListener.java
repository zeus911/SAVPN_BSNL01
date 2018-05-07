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

public class CreateL2VPWSSiteListener implements StateListener{
    Logger logger = Logger.getLogger(Constants.CRMPORTALLOG);

    public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception {
        //if (PortalSyncListener.DEBUG) {
            logger.debug("Inside CreateL2VPWSSiteListener");
            logger.debug("connection = " + connection);
            logger.debug("serviceId = " + serviceId);
            logger.debug("state = " + state);
            logger.debug("data = " + data);
            //System.out.println("Inside CreateL2VPWSSiteListener serviceId = " + serviceId);
        //}
        try{
            if (state == null)
                return StateListener.REMOVE_AND_CONTINUE;
            
            if (serviceId == null)
                return StateListener.REMOVE_AND_CONTINUE;
            
            if (connection == null)
                return StateListener.REMOVE_AND_CONTINUE;
            String vpnServiceId=ServiceUtils.getServiceParam(connection, serviceId,Constants.SERVICE_PARAM_VPN_ID);
            if ( vpnServiceId == null ) {
            	throw new Exception("VPWS VPN Service ID is not found in service param table for Site Service ID: "+serviceId);
            }
            
            //For VPWS all the service parameter entries are stored against VPWS VPN service Id. 
            //So use vpn service id to fetch any service param table entry
            boolean aEndSiteReused=ServiceUtils.getServiceParam(connection, vpnServiceId,Constants.SERVICE_PARAM_SERVICEMULTIPLEXING_AEND).equalsIgnoreCase("true");
            boolean zEndSiteReused=ServiceUtils.getServiceParam(connection, vpnServiceId,Constants.SERVICE_PARAM_SERVICEMULTIPLEXING_ZEND).equalsIgnoreCase("true");
            if ( !aEndSiteReused && !zEndSiteReused ) {
                //Response has come for aEnd Site, so set the same status for zEnd site
                String zEndSiteServiceID=ServiceUtils.getServiceParam(connection, vpnServiceId,Constants.SERVICE_PARAM_SITE_SERVICE_ID_ZEND);
                Service zEndSite= Service.findByPrimaryKey(connection, zEndSiteServiceID);
                zEndSite.setState(state);
                ServiceUtils.updateService(connection, zEndSite);
                
                if(state.equals(Constants.STATE_FAILURE)){
                	//update the state of vpn id as FAILURE
                    String vpnID=ServiceUtils.getServiceParam(connection, vpnServiceId,Constants.SERVICE_PARAM_VPN_ID);
                    Service vpws=Service.findByPrimaryKey(connection, vpnID);
                    vpws.setState(state);
                    ServiceUtils.updateService(connection, vpws);
                    
                    //also set the failure status in CRM_SERVICEPARAM
                    ServiceUtils.saveOrUpdateParameter(connection, serviceId,Constants.SERVICE_PARAM_FAILURE_STATUS,Constants.SERVICE_PARAM_VALUE_SITE_FAILURE);
                }
            }
    
            if (state.indexOf(Constants.SERVICE_STATE_OK) == -1 && state.indexOf(Constants.SERVICE_STATE_MSG_FAILURE) == -1 )
                return StateListener.STAY_AND_CONTINUE;

            	
            HashMap allParameters=new HashMap(); 
            String socketListener_port = PortalSyncListener.servletConfig.getInitParameter(Constants.SOCKET_LIS_PORT);
            String socketListener_host = PortalSyncListener.servletConfig.getInitParameter (Constants.SOCKET_LIS_HOST);
            String request_synchronisation = PortalSyncListener.servletConfig.getInitParameter (Constants.REQUEST_SYNCHRONISATION);
            String templateDir = PortalSyncListener.servletConfig.getInitParameter (Constants.TEMPLATE_DIR); 
            String logDir = PortalSyncListener.servletConfig.getInitParameter (Constants.LOGS_DIRECTORY); 
            
            allParameters.put(Constants.XSLPARAM_HOST, socketListener_host);
            allParameters.put(Constants.XSLPARAM_PORT, socketListener_port);
            allParameters.put(Constants.XSLPARAM_TEMPLATE_DIR,templateDir);
			allParameters.put("operator", ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_OPERATOR));
            allParameters.put(Constants.XSLPARAM_LOG_DIRECTORY, logDir);
            allParameters.put(Constants.XSLPARAM_REQUEST_SYNCHRONISATION, request_synchronisation);     

            String aEndAttachmentServiceID=ServiceUtils.getServiceParam(connection, vpnServiceId,Constants.SERVICE_PARAM_SITE_ATTACHMENT_ID_AEND);
            String zEndAttachmentServiceID=ServiceUtils.getServiceParam(connection, vpnServiceId,Constants.SERVICE_PARAM_SITE_ATTACHMENT_ID_ZEND);
            allParameters.put(Constants.SERVICE_PARAM_VPN_ID,vpnServiceId);
            //System.out.println("Inside CreateL2VPWSSiteListener vpnServiceId = " + vpnServiceId);

            ServiceParameter VPWSServiceParams[]=ServiceParameter.findByServiceid(connection, vpnServiceId);
            for(int i=0;i<VPWSServiceParams.length;i++){
                ServiceParameter serviceParameter=VPWSServiceParams[i];
            	serviceParameter.setServiceid(aEndAttachmentServiceID);
                allParameters.put(serviceParameter.getAttribute(),serviceParameter.getValue());
            }
            for(int i=0;i<VPWSServiceParams.length;i++){
                ServiceParameter serviceParameter=VPWSServiceParams[i];
            	serviceParameter.setServiceid(zEndAttachmentServiceID);
                allParameters.put(serviceParameter.getAttribute(),serviceParameter.getValue());
            }
            
			ServiceUtils.saveOrUpdateParameter(connection, aEndAttachmentServiceID,Constants.PARAMETER_LAST_COMMIT
                    ,CreateL2VPWSStateListener.class.getName());
			ServiceUtils.saveOrUpdateParameter(connection, zEndAttachmentServiceID,Constants.PARAMETER_LAST_COMMIT
                    ,CreateL2VPWSStateListener.class.getName());
            ServiceUtils.saveOrUpdateParameter(connection, aEndAttachmentServiceID,Constants.SERVICE_PARAM_VPN_ID
                    ,vpnServiceId);
            ServiceUtils.saveOrUpdateParameter(connection, zEndAttachmentServiceID,Constants.SERVICE_PARAM_VPN_ID
                    ,vpnServiceId);
            
            allParameters.put(Constants.XSLPARAM_SERVICEID, aEndAttachmentServiceID);
            allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_ADD);
            allParameters.put(Constants.XSLPARAM_XSLNAME, Constants.XSLNAME_L2VPWS_ATTACHMENT);
            IdGenerator idGenerator = new IdGenerator(connection);
            String messageid = idGenerator.getMessageId();
            allParameters.put(Constants.XSLPARAM_MESSAGEID,messageid);
            
            try {
                SendXML sender = new SendXML(allParameters);
                sender.Init();
                sender.Send();
            } catch (IOException e){
	            Service aEndAttachment= Service.findByPrimaryKey(connection, aEndAttachmentServiceID);
	            aEndAttachment.setState(Constants.SERVICE_STATE_MSG_FAILURE);
                zEndAttachmentServiceID=ServiceUtils.getServiceParam(connection, vpnServiceId,Constants.SERVICE_PARAM_SITE_ATTACHMENT_ID_ZEND);
	            Service zEndAttachment= Service.findByPrimaryKey(connection, zEndAttachmentServiceID);
	            zEndAttachment.setState(Constants.SERVICE_STATE_MSG_FAILURE);
                try{
                    ServiceUtils.updateService(connection, aEndAttachment);
                    ServiceUtils.saveOrUpdateParameter(connection, aEndAttachmentServiceID,Constants.SERVICE_PARAM_FAILURE_DESCRIPTION,e.getMessage());
                    ServiceUtils.updateService(connection, zEndAttachment);
                    ServiceUtils.saveOrUpdateParameter(connection, zEndAttachmentServiceID,Constants.SERVICE_PARAM_FAILURE_DESCRIPTION,e.getMessage());
                }catch(Exception ex) {
                
                }
            }
        }catch(Exception ex){
                logger.error("Exception in CreateL2VPWSSiteListener "+ex);
        }
        return StateListener.REMOVE_AND_CONTINUE;
        
    } //End public int proccedState(Connection connection, String serviceId, String state, String data)
    
} //End class CreateL2VPWSSiteListener implements StateListener


