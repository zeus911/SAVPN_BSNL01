
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
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.hp.ov.activator.crmportal.utils.*;
import com.hp.ov.activator.crmportal.common.*;
import org.apache.log4j.Logger;


/**
 * Action Class That Is Used To Generate Customer ID
 *
 */
public  class CustomerIDGenerateAction extends Action
{
	public CustomerIDGenerateAction() { }
	
    public ActionForward execute(ActionMapping mapping,
            ActionForm form,
            HttpServletRequest request,
            HttpServletResponse response) throws Exception 
       {
           
        Logger logger = Logger.getLogger("CRMPortalLOG"); 
        DatabasePool dbp = null;
        Connection connection = null;
        boolean error = false;
		 try
		 {
			  // Get database connection from session
		   HttpSession session = request.getSession();
		   dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
		   connection = (Connection) dbp.getConnection();
		  
		   IdGenerator generator  = new IdGenerator(connection);
	       String customerId = generator.getCustomerId(); 
	         if (customerId != null)
			 {
	        	 logger.debug("CustomerIDGenerateAction - ID generated >> "+customerId);
				 ((CustomerForm) form).setCustomerid(customerId);
				  request.setAttribute("customerid", customerId);  
	        	
			 }else
             {
				 logger.debug(" CustomerIDGenerateAction -  ID generated is NULL ");
				 error = true;
				
			 }

		 }//try
		 catch (Exception ex)
		 {
			  
			 logger.error("CUSTOMER ID GENERATION error : " , ex);
		 }
		 finally
		 {
			 //close the connection
           dbp.releaseConnection(connection);
		 }

	    if(error)
	    {
           return mapping.findForward(Constants.FAILURE);
	    }else
	    {
	      return mapping.findForward(Constants.SUCCESS);
            
	    }
         
       }
} // End CustomerIDGenerateAction

