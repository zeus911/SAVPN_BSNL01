
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.action;

import java.sql.*;
import javax.servlet.http.*;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;

import com.hp.ov.activator.crmportal.bean.*;


public class CustomerDeleteAction extends Action
{

	public CustomerDeleteAction() 
	{
		
	}
	
	 public ActionForward execute(ActionMapping mapping,
	            ActionForm form,
	            HttpServletRequest request,
	            HttpServletResponse response) throws Exception 
	 {
	    	 Logger logger = Logger.getLogger("CRMPortalLOG"); 
	         DatabasePool dbp = null;
	         Connection connection = null;
	         Service[] services = null;  
	         Customer cust = null;
	         boolean error = false;
			 String customerId = ((CustomerForm) form).getCustomerid();
			 String str1,str2;
			 boolean isSoftDelete = ((CustomerForm) form).getSoft();
			 boolean isDeactivate = ((CustomerForm) form).getDeactivate();
			 
			 /* System.out.println("Cust deleteAction >>Cust ID is ::"+customerId);
			 System.out.println("Cust deleteAction >>isSoftDelete ::"+isSoftDelete);
			 System.out.println("Cust deleteAction >>isDeactivate ::"+isDeactivate); */
			
			 if(isSoftDelete) str1 = "Y"; 
				 else str1= "N";
			 if(isDeactivate) str2 = "Y"; 
			     else str2= "N";
			 
			 try
			 {
				 if(customerId!=null)		 
			      {
			      // Get database connection from session
			     HttpSession session = request.getSession();
			     dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
			     connection = (Connection) dbp.getConnection();	
			     
			     services = Service.findByCustomerid(connection, customerId);
			     request.setAttribute("isSoft",str1);
			     request.setAttribute("deactivate",str2);
			     
			     if (isSoftDelete && (services != null)) 
			      {
			         request.setAttribute("Services_Found","Y");
			         logger.debug("CustomerDeleteAction ::: SoftDelete && services found");
			      }else if (isDeactivate)
			      {
			    	  cust = Customer.findByPrimaryKey(connection, customerId);
			          if (cust != null)
					  {
			              cust.setStatus("Deleted");
			              cust.update( connection );
			          }
			          logger.debug("CustomerDeleteAction :::: Only Deactivate ");
			      }else
			      {
			    	  cust = Customer.findByPrimaryKey(connection, customerId);
			          if (cust != null) {
			        	  cust.delete (connection);
			          }
			          request.setAttribute("Services_Found","N");
			          logger.debug("CustomerDeleteAction :::: Only SoftDelete");
			      }
	             
                 
			 		  
			     
			      }//custID
			 }//try
			 catch(Exception ex)
			 {
				 error = true;
			 }finally
	     	{
	             // close the connection
	            dbp.releaseConnection(connection);
	     	}
             
			 if(error)		 
				 return mapping.findForward(Constants.FAILURE);			 
			 else			 
				 return mapping.findForward(Constants.SUCCESS);
	   
	 }  //execute method      
	 

}//action class
