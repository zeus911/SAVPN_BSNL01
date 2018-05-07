
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.action;

import java.sql.Connection;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import com.hp.ov.activator.crmportal.bean.*;
import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;

public class CustomerEditAction extends Action{
	
	public CustomerEditAction() { }
	
	 public ActionForward execute(ActionMapping mapping,
	            ActionForm form,
	            HttpServletRequest request,
	            HttpServletResponse response) throws Exception 
	  {
		 Logger logger = Logger.getLogger("CRMPortalLOG");
		 DatabasePool dbp = null;
	     Connection connection = null;
		 Customer cust = null;
		 boolean error = false;
		 String customerId = ((CustomerForm) form).getCustomerid();
		 String actionFlag = ((CustomerForm) form).getActionflag();
		 String reqCustID  = request.getParameter("customerid");
		 String reqActionFlag = request.getParameter("actionflag");
		 
		 /*
		 System.out.println("EditAction-Reqobj >> reqCustID >>> " + reqCustID);
		 System.out.println("EditAction-Reqobj >> reqActionFlag >>> " + reqActionFlag); 
		 System.out.println("CustomerEditAction >> actionFlag >>> " + actionFlag);
		 */
    try{
		    if(customerId!=null)
		    {
			 // Get database connection from session
		  HttpSession session = request.getSession();
		  dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
		  connection = (Connection) dbp.getConnection();
		  // System.out.println("CustomerEditAction >>Cust ID is ::"+customerId);
		  cust = (Customer) Customer.findByPrimaryKey (connection, customerId);
		      if(cust!=null)
		      {
			    CustomerForm custForm = new CustomerForm();
				custForm.setCustomerid(cust.getCustomerid());
				custForm.setCompanyname(cust.getCompanyname()); 
				custForm.setCompanyaddress(cust.getCompanyaddress()); 
				custForm.setCompanycity(cust.getCompanycity()); 
				custForm.setCompanyzipcode(cust.getCompanyzipcode()); 
				custForm.setContactpersonname(cust.getContactpersonname()); 
				custForm.setContactpersonsurname(cust.getContactpersonsurname()); 
				custForm.setContactpersonphonenumber(cust.getContactpersonphonenumber()); 
				custForm.setContactpersonemail(cust.getContactpersonemail()); 
				custForm.setCreationtime(cust.getCreationtime());
				custForm.setLastUpdateTime(cust.getLastupdatetime());
				custForm.setStatus(cust.getStatus()); 
				    if(actionFlag!=null)
				     {
					custForm.setActionflag(actionFlag);
				     }			
				request.setAttribute("EditCustomerSubmit", custForm); 
		      
		       }//cust not null
		    // System.out.println("CustomerEditAction >>cust obj ::"+cust);
		   
          } //cust ID 
		 else
          { 
          logger.error("Customer EditAction ERROR : Cust ID is null");
          request.setAttribute("EditCustomerSubmit",(CustomerForm) form);
          error = true;
          }
		 
	  }//try
	 catch(Exception ex)
	 {
			 error = true;
	  }
	finally
	  {
	       // close the connection
	        dbp.releaseConnection(connection);
	  }
		 
	 //Action Forward
	 if(error)		
     	 return mapping.findForward(Constants.FAILURE);
	 else
		 return mapping.findForward(Constants.SUCCESS);
		 
	  }//method
	 	 
		 
 }

