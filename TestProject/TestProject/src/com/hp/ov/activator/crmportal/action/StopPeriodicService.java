

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

public class StopPeriodicService extends Action 
{
	public StopPeriodicService() 
	{}
	
	 public ActionForward execute(ActionMapping mapping,
	            ActionForm form,
	            HttpServletRequest request,
	            HttpServletResponse response) throws Exception 
	 {
	
	 Logger logger = Logger.getLogger("CRMPortalLOG");
     DatabasePool dbp = null;
     Connection con = null;
     String servicesPage = "";
     boolean error = false; 
     
     // Get database connection from session
	 HttpSession session = request.getSession();
	 dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
	 
 	  // Fetching request parameters
	  String customerid = request.getParameter("customerid");
	  String serviceid = request.getParameter("serviceid");
	
	  try
	     {
	    	con = (Connection) dbp.getConnection();
	    	
	    	((ServiceForm)form).setCustomerid(customerid);
	   	    ((ServiceForm)form).setServiceid(serviceid);
	   	    
	   	 if (serviceid == null) 
	   	 {
			throw new IllegalStateException("Service ID not set," +
						" cannot find service.");
	   	 }
	   	    
	   	Service service = Service.findByPrimaryKey(con, serviceid);
	   	((ServiceForm)form).setService(service);
	   	
		if (service == null)
			throw new IllegalStateException("Service not found");

		if (customerid == null)
			customerid = service.getCustomerid();
          
		 // PeriodicSenderThread.removeService(con, serviceid);
	   	   //not implemented yet
	   	 }
	  	catch(Exception ex)
	  	{
	  	  error = true;
	  	if (customerid != null)
		servicesPage = "FindAllServices.jsp?customerid=" 
			+ customerid + "&doResetReload=true";
		else
		servicesPage = "FindCustomer.jsp";
	  	 	   
	  	 }finally
	  	 {
	  	         // close the connection
	  	        dbp.releaseConnection(con);
	  	 }
	   
	  	ListServicesAction allServices = new ListServicesAction();
	   //Forward Action
	   if(!(error))
	    {        
	  	  //set values to actionform obj && Transfer to the jsp   		  
	     	//return mapping.findForward(Constants.SUCCESS);
		   ActionForward actionforward = allServices.execute(mapping,form,request,response);
   		actionforward = 
    			 new ActionForward("/jsp/FindAllServices.jsp");
   		return  actionforward;
	    }
	    else
	    {       	
	   	   return mapping.findForward(Constants.FAILURE);
	    }
	 }	
	
}
