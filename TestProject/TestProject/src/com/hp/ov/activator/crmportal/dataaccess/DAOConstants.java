
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.dataaccess;

import com.hp.ov.activator.crmportal.utils.Constants;

public class DAOConstants 
{
	public static final String CRM_STATES_TABLE = Constants.CRM_STATES_TABLE;
	public static final String CRM_STATES_TABLE_ID = Constants.CRM_STATES_TABLE_ID;
	
    public static final String getMaxOfCRMStates =
    	"select max(" + CRM_STATES_TABLE_ID + ") from " + CRM_STATES_TABLE;

}
