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

public class DeleteL2VPWSSiteListener implements StateListener{
    Logger logger = Logger.getLogger(Constants.CRMPORTALLOG);

    public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception {
        //if (PortalSyncListener.DEBUG) {
            logger.debug("Inside DeleteL2VPWSSiteListener");
            logger.debug("connection = " + connection);
            logger.debug("serviceId = " + serviceId);
            logger.debug("state = " + state);
            logger.debug("data = " + data);
            //System.out.println("Inside DeleteL2VPWSSiteListener serviceId = " + serviceId);
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
            //System.out.println("Inside DeleteL2VPWSSiteListener vpnServiceId = " + vpnServiceId);
            //For VPWS all the service parameter entries are stored against VPWS VPN service Id. 
            //So use vpn service id to fetch any service param table entry
                
            String zEndSiteServiceId=ServiceUtils.getServiceParam(connection, serviceId,Constants.SERVICE_PARAM_DELETED_ZEND_SITEID);
            if ( zEndSiteServiceId != null ) {
                Service zEndSiteService=Service.findByPrimaryKey(connection,zEndSiteServiceId);
                ServiceUtils.updateService(connection, zEndSiteService);
                
                if(state.equals(Constants.STATE_DELETE_FAILURE)){
                  zEndSiteService.setState(state);
                  ServiceUtils.updateService(connection, zEndSiteService);
                  
                //update the state of vpn id
                  Service vpws=Service.findByPrimaryKey(connection, vpnServiceId);
                  vpws.setState(state);
                  ServiceUtils.updateService(connection, vpws);
                }
            }

            if (state.indexOf(Constants.SERVICE_STATE_OK) == -1 && state.indexOf(Constants.SERVICE_STATE_MSG_FAILURE) == -1 &&  ! state.equals(Constants.SERVICE_STATE_DELETE))
                return StateListener.STAY_AND_CONTINUE;

            HashMap allParameters=new HashMap(); 
            String skip_activation=ServiceUtils.getServiceParam(connection, vpnServiceId,Constants.SKIP_ACTIVATION);
            
            String socketListener_port = PortalSyncListener.servletConfig.getInitParameter(Constants.SOCKET_LIS_PORT);
            String socketListener_host = PortalSyncListener.servletConfig.getInitParameter (Constants.SOCKET_LIS_HOST);
            String request_synchronisation = PortalSyncListener.servletConfig.getInitParameter (Constants.REQUEST_SYNCHRONISATION);
            String templateDir = PortalSyncListener.servletConfig.getInitParameter (Constants.TEMPLATE_DIR); 
            String logDir = PortalSyncListener.servletConfig.getInitParameter (Constants.LOGS_DIRECTORY); 
            
            allParameters.put(Constants.XSLPARAM_HOST, socketListener_host);
            allParameters.put(Constants.XSLPARAM_PORT, socketListener_port);
            allParameters.put(Constants.XSLPARAM_TEMPLATE_DIR,templateDir);
			allParameters.put("operator", ServiceUtils.getServiceParam(connection, vpnServiceId, Constants.SERVICE_PARAM_OPERATOR));
            allParameters.put(Constants.XSLPARAM_LOG_DIRECTORY, logDir);
            allParameters.put(Constants.XSLPARAM_REQUEST_SYNCHRONISATION, request_synchronisation);     
            allParameters.put(Constants.XSLPARAM_TYPE, Constants.TYPE_SITE);
            allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_DELETE);
            allParameters.put(Constants.SKIP_ACTIVATION, skip_activation);
            IdGenerator idGenerator = new IdGenerator(connection);
            String messageid = idGenerator.getMessageId();
            allParameters.put(Constants.XSLPARAM_MESSAGEID,messageid);
            
            boolean sendRequest=VPWSDeleteUtils.DeleteVPWSVPN(connection,allParameters,vpnServiceId);
            
            if ( sendRequest ) {
                try {
                    SendXML sender = new SendXML(allParameters);
                    sender.Init();
                    sender.Send();
                } catch (IOException e){
                    try{
        	            Service aEndSiteService= Service.findByPrimaryKey(connection, serviceId);
        	            aEndSiteService.setState(Constants.SERVICE_STATE_FAILURE);
                        ServiceUtils.updateService(connection, aEndSiteService);
                        ServiceUtils.saveOrUpdateParameter(connection, serviceId,Constants.SERVICE_PARAM_FAILURE_DESCRIPTION,e.getMessage());
        	            if ( zEndSiteServiceId != null ) {
        	                Service zEndSiteService= Service.findByPrimaryKey(connection, zEndSiteServiceId);
        	                zEndSiteService.setState(Constants.SERVICE_STATE_FAILURE);
                            ServiceUtils.updateService(connection, zEndSiteService);
                            ServiceUtils.saveOrUpdateParameter(connection, zEndSiteServiceId,Constants.SERVICE_PARAM_FAILURE_DESCRIPTION,e.getMessage());
        	            }
                    }catch(Exception ex) {
                    
                    }
                }
                if(zEndSiteServiceId!=null){
                  Service zEndSiteService = Service.findByPrimaryKey(connection, zEndSiteServiceId);
                  ServiceUtils.deleteService(connection, zEndSiteService);
                }
            }
        }catch(Exception ex){
                logger.error("Exception in DeleteL2VPWSSiteListener "+ex);
        }
        return StateListener.REMOVE_AND_CONTINUE;
        
    } //End public int proccedState(Connection connection, String serviceId, String state, String data)
    
} //End class DeleteL2VPWSSiteListener implements StateListener


