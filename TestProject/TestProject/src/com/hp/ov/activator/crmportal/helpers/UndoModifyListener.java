
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;

import com.hp.ov.activator.crmportal.bean.ServiceParameter;
import org.apache.log4j.Logger;

import com.hp.ov.activator.crmportal.utils.*;
import java.sql.Connection;

public class UndoModifyListener implements StateListener {
	Logger logger = Logger.getLogger("CRMPortalLOG");

	public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception {
		/*logger.debug("connection = " + connection);
		logger.debug("serviceId = " + serviceId);
		logger.debug("state = " + state);
		logger.debug("data = " + data);  */
		boolean perform = false;

		if (state == null)
			return StateListener.REMOVE_AND_CONTINUE;

		if (state.equalsIgnoreCase(Constants.STATE_PE_WAIT_MOD_END_TIME) || state.equalsIgnoreCase(Constants.STATE_WAIT_MOD_END_TIME)) {
			ServiceParameter parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, Constants.SERVCIE_PARAM_HIDDEN_UNDO_WAIT);
			if (parameter == null) {
				new ServiceParameter(serviceId, Constants.SERVCIE_PARAM_HIDDEN_UNDO_WAIT, "true").store(connection);
			} else {
				parameter.setValue("true");
				parameter.update(connection);
			}
		}

		if (state.equalsIgnoreCase(Constants.STATE_PE_OK) || state.equalsIgnoreCase(Constants.SERVICE_STATE_OK)) {
			ServiceParameter parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, Constants.SERVCIE_PARAM_HIDDEN_UNDO_WAIT);
			if (parameter != null) {
				if (parameter.getValue().equalsIgnoreCase("true")) {
					perform = true;
				}
				parameter.delete(connection);
			}
		}

		if (state.equalsIgnoreCase(Constants.STATE_PE_MODIFY_WAIT_END_TIME_FAILURE) || state.equalsIgnoreCase(Constants.STATE_MODIFY_WAIT_END_TIME_FAILURE)) {
			ServiceParameter parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, Constants.SERVCIE_PARAM_HIDDEN_UNDO_WAIT);
			if (parameter != null) {
				parameter.setValue("false");
				parameter.update(connection);
			}
		}
		if (perform) {
			if (serviceId == null)
				return StateListener.REMOVE_AND_CONTINUE;
			if (connection == null || connection.isClosed())
				return StateListener.REMOVE_AND_CONTINUE;

			ServiceParameter parameter = null;
			parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, Constants.SERVICE_PARAM_HIDDEN_LASTMODIFYACTION);
			//logger.debug("parameter = " + parameter.getValue());
			if (parameter == null)
				return StateListener.REMOVE_AND_CONTINUE;// no parameter - no problem

			parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, Constants.PARAMETER_LAST_MODIFIED);
			logger.debug("parameter PARAMETER_LAST_MODIFIED = " + parameter.getValue() + " " + parameter.getAttribute());
			if (parameter == null)
				return StateListener.REMOVE_AND_CONTINUE;// something wrong

			String paramName = Constants.PARAMETER_LAST_MODIFIED;
			String valueName = Constants.PARAMETER_LAST_MODIFIED_VALUE;
			int index = 0;

			while (true) {
				ServiceParameter modifiedName = ServiceParameter.findByServiceidattribute(connection, serviceId, paramName);
				ServiceParameter modifiedValue = ServiceParameter.findByServiceidattribute(connection, serviceId, valueName);
				if (modifiedName == null)
					return StateListener.REMOVE_AND_CONTINUE;

				logger.debug("parameter PARAMETER_LAST_MODIFIED_NAME = " + modifiedName.getValue());
				logger.debug("parameter PARAMETER_LAST_MODIFIED_VALUE = " + modifiedValue.getValue());

				//        String oldValue = parameter.getValue();
				parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, modifiedName.getValue());

				if (parameter == null)
					continue;

				parameter.setValue(modifiedValue.getValue());
				parameter.update(connection);

				paramName = Constants.PARAMETER_LAST_MODIFIED + index;
				valueName = Constants.PARAMETER_LAST_MODIFIED_VALUE + index;

				index++;
			}

		} else
			return StateListener.STAY_AND_CONTINUE;
	}

}
