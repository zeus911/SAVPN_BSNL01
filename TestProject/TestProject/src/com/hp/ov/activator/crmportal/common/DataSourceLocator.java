/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */


package com.hp.ov.activator.crmportal.common;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import com.hp.ov.activator.crmportal.utils.*;

public class DataSourceLocator 
{
	private InitialContext context;
	private DataSource dataSource;
	
	public DataSource getDataSource()throws NamingException
	{
		 context = new InitialContext();
		 dataSource = (DataSource) context.lookup(Constants.DATASOURCE_NAME);
		 return dataSource;
	}
	
	
}
