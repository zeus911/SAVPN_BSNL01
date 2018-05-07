/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.action;

import javax.servlet.http.HttpServletRequest;
import org.apache.struts.action.ActionError;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import java.io.*;
import java.util.Date;

public class ServiceParameterVO  implements Serializable 
{
	String serviceid,attribute,value,servicename,customerid,customername;
	
	 public ServiceParameterVO(){}
	 public ServiceParameterVO (
			    String customerid,
				String customername,
				String servicename,
				String attribute )
			{
				this.customerid = customerid;
				this.customername = customername;
				this.servicename = servicename;
				this.attribute = attribute;
			}

		public void setServiceid( String serviceid )
		{
			this.serviceid = serviceid;
		}

		public String getServiceid()
		{
			return serviceid;
		}
		
		public void setServicename( String servicename )
		{
			this.servicename = servicename;
		}

		public String getServicename()
		{
			return servicename;
		}
		
		public void setAttribute( String attribute )
		{
			this.attribute = attribute;
		}

		public String getAttribute()
		{
			return attribute;
		}
		
		public void setValue( String value )
		{
			this.value = value;
		}

		public String getValue()
		{
			return value;
		}
		
		public void setCustomerid( String customerid )
		{
			this.customerid = customerid;
		}

		public String getCustomerid()
		{
			return customerid;
		}
		public void setCustomername( String customername )
		{
			this.customername = customername;
		}

		public String getCustomername()
		{
			return customername;
		}
		
		/* public void reset(ActionMapping actionMapping,HttpServletRequest request)
		 {
			 serviceid = null;
			 attribute = null;
			 value = null;
			 servicename= null;
			 customerid = null;
			 customername= null;
			 
		 }*/
		 
		
}