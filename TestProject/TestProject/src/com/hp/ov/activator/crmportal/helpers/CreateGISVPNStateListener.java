package com.hp.ov.activator.crmportal.helpers;

import java.sql.Connection;

import org.apache.log4j.Logger;

import com.hp.ov.activator.crmportal.utils.Constants;

public class CreateGISVPNStateListener implements StateListener {
	 Logger logger = Logger.getLogger(Constants.CRMPORTALLOG);

	  public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception
	  {
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
	      logger.debug("CreateGISVPNStateListener.proccedState: " + state);
	    }

	    if (state.contains(Constants.STATE_WAIT_END_TIME)) {
	      //set the lastcommit action to DeleteL3SiteAttachmentListener
	      ServiceUtils.saveOrUpdateParameter(connection, serviceId, Constants.PARAMETER_LAST_COMMIT,
	    		  DeleteGISSiteAttachmentListener.class.getName());
	    }

	    if (state.indexOf(Constants.SERVICE_STATE_OK) == -1 && state.indexOf(Constants.SERVICE_STATE_MSG_FAILURE) == -1)
	      return StateListener.STAY_AND_CONTINUE;

	    return StateListener.REMOVE_AND_CONTINUE;
	  }

}
