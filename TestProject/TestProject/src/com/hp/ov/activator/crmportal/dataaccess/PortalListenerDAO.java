
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.dataaccess;

import java.sql.*;
import java.io.*;
import java.util.*;
import org.apache.log4j.Logger;
import com.hp.ov.activator.crmportal.utils.Constants;

public class PortalListenerDAO 
{
    Connection dbConnection = null;
    Logger logger = Logger.getLogger("CRMPortalLOG");
    
	public PortalListenerDAO()
	{}
	
	public PortalListenerDAO(Connection dbConnection)
	{
	  this.dbConnection = dbConnection;
	}
	
	public long getMaxCRMStates(Connection dbConnection)
	{
		

	  final Statement statement;
      final ResultSet resultSet;
      long  idCounter = 0;    
       //logger.debug("GET MAX ID");

		try{
				
		statement = dbConnection.createStatement();
    		resultSet = statement.executeQuery(DAOConstants.getMaxOfCRMStates);
    	
	      if (resultSet.next())
	      
	        idCounter = resultSet.getLong(1);
	      else
	        idCounter = 0;

	        logger.debug("getMaxCRMStates - ID count ==" + idCounter);

	      resultSet.close();
	      statement.close();
	     } catch (SQLException e) {
	   	   logger.error("CRM Portal listener thread DB problem: fail to access " + Constants.CRM_STATES_TABLE ,  e);
 
	   	 }
	      return idCounter; 
	}
	
}
