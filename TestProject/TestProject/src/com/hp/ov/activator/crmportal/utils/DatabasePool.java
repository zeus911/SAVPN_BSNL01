
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.utils;

import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DatabasePool 
{
	 private InitialContext context;
	 private DataSource dataSource;
	 private Connection connection;
	 public DatabasePool()
	 {
		 
	 }

	  public DatabasePool(DataSource dataSource)
	  {
	    this.dataSource = dataSource;
	  }

	  public Connection getConnection () throws SQLException
	  {
		
		   return dataSource.getConnection();
	  }
	  public void releaseConnection (Connection con)
	  {
	    try {
	      con.close();
	    } catch (Exception e) {
	      e.printStackTrace();
	    }
	  }

}
