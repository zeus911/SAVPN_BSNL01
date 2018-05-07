
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.common;

import java.sql.*;
import java.io.*;
import java.util.*;
import com.hp.ov.activator.crmportal.utils.Constants;

public class IdGenerator
{
  private Connection dbConnection = null;

  public IdGenerator(Connection dbConnection)
  {
    this.dbConnection = dbConnection;
  }

  public String getCustomerId() throws SQLException
  {
    return getId(Constants.CUSTOMER_ID_SEQUENCE);
  }

  public String getServiceId() throws SQLException
  {
    return getId(Constants.SERVICE_ID_SEQUENCE);
  }

  public String getMessageId() throws SQLException
  {
    return getId(Constants.MESSAGE_ID_SEQUENCE);
  }

  private String getId(String sequence) throws SQLException
  {
    if (dbConnection != null) {
      PreparedStatement getNextValueCall = null;
      ResultSet result = null;

      try{
        getNextValueCall = dbConnection.prepareStatement ("select " + sequence + ".NextVal as NextVal from DUAL");
        result = getNextValueCall.executeQuery();
        if (result.next()) {
          return result.getString(1);
        } else {
          throw new RuntimeException ("No result returned from the database sequence - " + sequence);
        }
      } finally {
        if (getNextValueCall != null) {
          getNextValueCall.close();
        }
      }
    } else {
      throw new RuntimeException ("The database connection is not established");
    }
  }
}

