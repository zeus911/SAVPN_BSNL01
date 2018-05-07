/*
 ***************************************************************************
 *
 * (c) Copyright 2011 Hewlett-Packard Development Company, L.P. 
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
import com.hp.ov.activator.crmportal.helpers.RemoveL2VPWSAttachmentListener;
import com.hp.ov.activator.crmportal.helpers.DeleteL2VPWSSiteListener;

public class VPWSDeleteUtils {
    public static boolean DeleteAttachment(Connection dbConnection, HashMap allParameters, String vPWSVPNServiceid, String currentState)  throws java.sql.SQLException {
        //We need to first send the delete request for attachment. 
        //Check if there are any attachments
        VPNMembership[] vPWSVPNMembers = VPNMembership.findByVpnid(dbConnection, vPWSVPNServiceid);
        if (vPWSVPNMembers != null) {
         // if(!currentState.equals(Constants.SERVICE_STATE_FAILURE)){
            //Atleast one attachement is present as part of this vpn. Send the delete attachement request.
            allParameters.put(Constants.XSLPARAM_TYPE, Constants.XSLNAME_L2VPWS_ATTACHMENT);
            allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_REMOVE);
            String aEndAttachmentServiceId=(String)allParameters.get(Constants.SERVICE_PARAM_SITE_ATTACHMENT_ID_AEND);
            
            ServiceUtils.saveOrUpdateParameter(dbConnection, aEndAttachmentServiceId, 
            Constants.PARAMETER_LAST_COMMIT,
            RemoveL2VPWSAttachmentListener.class.getName());
         // }
//          }else{
//            //delete the attachments entries from CRM_SERVICE table
////            for(int i = 0; i < vPWSVPNMembers.length; i++){
////              Service attachsrv = Service.findByPrimaryKey(dbConnection, vPWSVPNMembers[i].getSiteattachmentid());
////              ServiceUtils.deleteService(dbConnection, attachsrv);
////            }
//            return VPWSDeleteUtils.DeleteSite(dbConnection,allParameters,vPWSVPNServiceid,(String)allParameters.get(Constants.SERVICE_PARAM_SITE_SERVICE_ID_AEND),(String)allParameters.get(Constants.SERVICE_PARAM_SITE_SERVICE_ID_ZEND));
//          }
        } else {
            //No attachments present for this vpn. Send delete site request
            return VPWSDeleteUtils.DeleteSite(dbConnection,allParameters,vPWSVPNServiceid,(String)allParameters.get(Constants.SERVICE_PARAM_SITE_SERVICE_ID_AEND),(String)allParameters.get(Constants.SERVICE_PARAM_SITE_SERVICE_ID_ZEND));
        }
        allParameters.put(Constants.XSLPARAM_VPNSERVICEID, vPWSVPNServiceid);   
        return true;
    }
    public static boolean DeleteSite(Connection dbConnection, HashMap allParameters, String vPWSVPNServiceid, String aEndSiteServiceID,String zEndSiteServiceID)  throws java.sql.SQLException {
		    Logger logger = Logger.getLogger(Constants.CRMPORTALLOG);
            //Find the aEnd site information
            Service aEndSiteService=null;
            if ( aEndSiteServiceID != null ) {
                aEndSiteService=Service.findByPrimaryKey(dbConnection,aEndSiteServiceID);
                Service [] aEndSiteAttachmentServices = Service.findByParentserviceid(dbConnection,aEndSiteServiceID);
                if ( aEndSiteAttachmentServices == null ) {
                    logger.debug("VPWSDeleteUtils Info: aEnd Site ("+aEndSiteServiceID+"): does not have any attachment");
                } else if ( aEndSiteAttachmentServices.length > 1 ) {
                    //No need to do anything about site service
                    aEndSiteService=null;
                    logger.debug("VPWSDeleteUtils Info: aEnd Site ("+aEndSiteServiceID+"): has morethan one attachment("+aEndSiteAttachmentServices.length+"). Site not deleted");
                }
            }
            //Find the zEnd site information
            Service zEndSiteService=null;
            if ( zEndSiteServiceID != null ) {
                zEndSiteService=Service.findByPrimaryKey(dbConnection,zEndSiteServiceID);
                Service [] zEndSiteAttachmentServices = Service.findByParentserviceid(dbConnection,zEndSiteServiceID);
                if ( zEndSiteAttachmentServices == null ) {
                    logger.debug("VPWSDeleteUtils Info: aEnd Site ("+zEndSiteServiceID+"): does not have any attachment");
                } else if ( zEndSiteAttachmentServices.length > 1 ) {
                    //No need to do anything about site service
                    zEndSiteService=null;
                    logger.debug("VPWSDeleteUtils Info: aEnd Site ("+zEndSiteServiceID+"): has morethan one attachment("+zEndSiteAttachmentServices.length+"). Site not deleted");
                }
            }

            if (aEndSiteService != null && zEndSiteService != null ) {
                //Both aEnd and zEnd sites should be deleted.
                //Send delete sites request
                allParameters.put(Constants.XSLPARAM_XSLNAME,Constants.XSLNAME_SITES);
                allParameters.put(Constants.XSLPARAM_CUSTOMERID,aEndSiteService.getCustomerid());
                allParameters.put(Constants.SERVICE_PARAM_SITE_SERVICE_ID_AEND,aEndSiteService.getServiceid());
                allParameters.put(Constants.XSLPARAM_PW_AEND,aEndSiteService.getPresname());
                allParameters.put(Constants.SERVICE_PARAM_SITE_SERVICE_ID_ZEND,zEndSiteService.getServiceid());
                allParameters.put(Constants.XSLPARAM_PW_ZEND,zEndSiteService.getPresname());
                ServiceUtils.saveOrUpdateParameter(dbConnection, aEndSiteService.getServiceid(), 
                Constants.PARAMETER_LAST_COMMIT,
                DeleteL2VPWSSiteListener.class.getName());
                
                //set the states for the two sites as "Delete_Requested"
                aEndSiteService.setState(Constants.STATE_DELETE_REQUESTED);
                ServiceUtils.updateService(dbConnection, aEndSiteService);
                zEndSiteService.setState(Constants.STATE_DELETE_REQUESTED);
                ServiceUtils.updateService(dbConnection, zEndSiteService);
                
                //Store the to be deleted zEnd Site id. So that Site Listener can update delete status for zEnd also by looking at this parameter.
                //Because when both sites are sent for delete, SA sends the response with the aEnd Service ID. So we will not know whether we
                //sent two sites for delete or only one site for delete
                ServiceUtils.saveOrUpdateParameter(dbConnection, aEndSiteService.getServiceid(), 
                Constants.SERVICE_PARAM_DELETED_ZEND_SITEID,
                zEndSiteService.getServiceid());
                
                if ( vPWSVPNServiceid != null ) {
                    ServiceUtils.saveOrUpdateParameter(dbConnection, aEndSiteService.getServiceid(), 
                    Constants.SERVICE_PARAM_VPN_ID,
                    vPWSVPNServiceid);
                }
            } else if (aEndSiteService != null || zEndSiteService != null) {
                //Only of either aEnd or zEnd site needs to be deleted. 
                //Send delete site request.
                Service siteService=( aEndSiteService != null ) ? aEndSiteService : zEndSiteService;
                allParameters.put(Constants.XSLPARAM_TYPE, Constants.XSLNAME_SITE);
                allParameters.put(Constants.XSLPARAM_CUSTOMERID,siteService.getCustomerid());
                allParameters.put(Constants.XSLPARAM_SERVICEID,siteService.getServiceid());
                allParameters.put(Constants.XSLPARAM_PRESNAME,siteService.getPresname());
                ServiceUtils.saveOrUpdateParameter(dbConnection, siteService.getServiceid(), 
                Constants.PARAMETER_LAST_COMMIT,
                DeleteL2VPWSSiteListener.class.getName());
                
                if ( vPWSVPNServiceid != null ) {
                    ServiceUtils.saveOrUpdateParameter(dbConnection, siteService.getServiceid(), 
                    Constants.SERVICE_PARAM_VPN_ID,
                    vPWSVPNServiceid);
                }
            } else if (vPWSVPNServiceid != null ) {
                //No sites needs to be deleted send delete VPWS request.
                return VPWSDeleteUtils.DeleteVPWSVPN(dbConnection,allParameters,vPWSVPNServiceid);
            } else {
                return false;
            }
            return true;
    }
    public static boolean DeleteVPWSVPN(Connection dbConnection, HashMap allParameters, String vPWSVPNServiceid) throws java.sql.SQLException{
        if ( vPWSVPNServiceid != null ) {
            Service vpwsVPNService=Service.findByPrimaryKey(dbConnection,vPWSVPNServiceid);
            allParameters.put(Constants.XSLPARAM_TYPE, Constants.TYPE_LAYER2_VPWS);
            allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_DELETE);
            allParameters.put(Constants.XSLPARAM_CUSTOMERID,vpwsVPNService.getCustomerid());
            allParameters.put(Constants.XSLPARAM_SERVICEID,vpwsVPNService.getServiceid());
            allParameters.put(Constants.XSLPARAM_PRESNAME,vpwsVPNService.getPresname());
            
            vpwsVPNService.setState(Constants.STATE_DELETE_REQUESTED);
            ServiceUtils.updateService(dbConnection, vpwsVPNService);
        } else {
            return false;
        }
        return true;
    }
}