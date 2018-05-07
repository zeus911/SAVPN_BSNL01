
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


 //Added this class to fix PR 10998 --Divya 


public class UndoPeriodicScheduleListener implements StateListener {
	Logger logger = Logger.getLogger("CRMPortalLOG");

	//ACT_OK	,'Periodic_Modify_PE_Ok_Wait_Start'--hidden val
	//ACT_SCHED,'Periodic_Modify_PE_In_Progress' -- periodic val
	public int proccedState(Connection connection, String serviceId, String state, String saResp) throws Exception 
	{
		try 
		{
			String data = null;
			if((saResp.equalsIgnoreCase(Constants.SA_RESP_ACT_OK))&&(state.equalsIgnoreCase(Constants.STATE_PE_PERIODIC_MODIFY_WAIT_START)))
				data="Periodic_Org_CAR";
			else if((saResp.equalsIgnoreCase(Constants.SA_RESP_WAIT_START))&&(state.equalsIgnoreCase(Constants.STATE_PE_PERIODIC_MODIFY_IN_PROGRESS)))
				data="Periodic_car";
			if(data!=null)
			{
				ServiceParameter serivceObj = ServiceParameter.findByServiceidattribute(connection, serviceId,data );
				if(serivceObj!=null)
				{
					logger.debug("***********serivceObj***********");
					logger.debug("Attribute"+serivceObj.getAttribute());
					logger.debug("Attribute"+serivceObj.getValue());
					logger.debug("***********serivceObj ends***********");
					ServiceParameter modifyObj = ServiceParameter.findByServiceidattribute(connection, serviceId,Constants.PARAMETER_CAR );
					if(modifyObj!=null)
					{
						 logger.debug("***********modifyObj***********");
						 logger.debug("Attribute"+modifyObj.getAttribute());
						 logger.debug("Attribute"+modifyObj.getValue());
						 logger.debug("***********modifyObj ends***********");
					modifyObj.setValue(serivceObj.getValue());
					modifyObj.update(connection);
					}
				}
			}


		} 
		catch (Exception ex) 
		{
			logger.error("UndoPeriodicScheduleListener INFO: ERROR during UndoPeriodicScheduleListener procceding"+ex);
			ex.printStackTrace();
		}
		return 0;
	}

}
