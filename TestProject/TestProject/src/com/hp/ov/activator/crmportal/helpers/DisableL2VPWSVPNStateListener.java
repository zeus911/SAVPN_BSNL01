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
import java.util.ArrayList;
import org.apache.log4j.Logger;
import com.hp.ov.activator.crmportal.bean.Service;
import com.hp.ov.activator.crmportal.bean.VPNMembership;
import com.hp.ov.activator.crmportal.utils.Constants;

public class DisableL2VPWSVPNStateListener implements StateListener{
    Logger logger = Logger.getLogger(Constants.CRMPORTALLOG);

    public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception {
        if (PortalSyncListener.DEBUG) {
            logger.debug("Inside ModifyL2VPWSVPNStateListener");
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
        
        if(state.equals(Constants.SERVICE_STATE_FAILURE)){
            ServiceUtils.saveOrUpdateParameter(connection, serviceId,Constants.SERVICE_PARAM_FAILURE_STATUS,Constants.SERVICE_PARAM_VALUE_VPWS_FAILURE);
        }
                    

        try{
        	Service service = Service.findByPrimaryKey(connection, serviceId);
        	setVPWSState(service, connection, state);
        	
        	
        }catch(Exception ex){
                logger.error("Exception in ModifyL2VPWSVPNState listener"+ex);
        }
        
        
        if(state.indexOf(Constants.SERVICE_STATE_ENABLE_IN_PROGRESS) == -1 || state.indexOf(Constants.SERVICE_STATE_DISABLE_IN_PROGRESS) == -1){
            return StateListener.STAY_AND_CONTINUE;
        }else if(state.indexOf(Constants.SERVICE_STATE_OK) == -1 || state.indexOf(Constants.SERVICE_STATE_DISABLED) == -1){
            return StateListener.REMOVE_AND_CONTINUE;
        }
        return StateListener.STAY_AND_CONTINUE;
   

		
		} //End public int proccedState(Connection connection, String serviceId, String state, String data)
    
    
		
    
    
	private void setVPWSState(Service service, Connection connection, String state) {
		try {
            VPNMembership[] mems = VPNMembership.findByVpnid(connection, service.getServiceid());
            if (mems == null || mems.length != 2) {
                logger.warn("VPWS doesn't have both two end attachments!!!");
                return;
            }
            setVPWSState(connection, state, mems[0].getSiteattachmentid());
            setVPWSState(connection, state, mems[1].getSiteattachmentid());
		}  
		catch (Exception e) {
           logger.error("DisableL2VPWSVPNStatelistener Error: ", e);
		}
	}

	private void setVPWSState(Connection connection, String state, String siteattachmentid) throws Exception {
          Service attach = Service.findByServiceid(connection, siteattachmentid);
          attach.setState(getPENextState(state));
          logger.debug("DisableL2VPWSVPNStatelistener INFO: Changing vpws attachment '" + attach.getServiceid() + "' state to PE_" + state);
          ServiceUtils.updateService(connection, attach);
          Service site = Service.findByServiceid(connection, attach.getParentserviceid());
          Service attachments [] =Service.findByParentserviceid(connection, site.getServiceid());
          if(attachments.length>0){
    	      int disabled_attachments_num = 0;
    	      for (int i=0;i<attachments.length;i++){
    		      if ((attachments[i].getState()).equals(getPENextState(state))){
    			      disabled_attachments_num++;
    		      }
    	      }
    	      if (disabled_attachments_num==attachments.length) {
    	          site.setState(state);
    	      }else if(disabled_attachments_num < attachments.length && disabled_attachments_num != 0){
    	    	  site.setState(Constants.STATE_PARTIAL_DISABLED);
                  
    	      }
          }
          logger.debug("DisableL2VPWSVPNStatelistener INFO: Changing vpws site '" + attach.getServiceid() + "' state to " + state);
          ServiceUtils.updateService(connection, site);
	}
		
		
	public static String getPENextState(String SiteState){
		  if (SiteState.indexOf("PE_") >= 0) {
		        return SiteState;
		  }
		  return "PE_" + SiteState;
	}
    
} //End class DisableL2VPWSVPNStateListener implements StateListener


