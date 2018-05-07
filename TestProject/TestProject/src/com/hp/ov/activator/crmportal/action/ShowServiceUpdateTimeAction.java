
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.action;

import java.sql.*;
import java.util.HashMap;
import java.text.*;
import javax.servlet.http.*;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;
import com.hp.ov.activator.crmportal.bean.*;
import com.hp.ov.activator.crmportal.helpers.*;
import com.hp.ov.activator.crmportal.common.*;

public class ShowServiceUpdateTimeAction extends Action{
	
	public ShowServiceUpdateTimeAction() 
	{}
	
	 public ActionForward execute(ActionMapping mapping,
	            ActionForm form,
	            HttpServletRequest request,
	            HttpServletResponse response) throws Exception 
	 {
	
	 Logger logger = Logger.getLogger("CRMPortalLOG");
     DatabasePool dbp = null;
     Connection con = null;
     PreparedStatement statement = null;
     ResultSet resultSet = null;
     boolean error = false; 
     
     // Get database connection from session
	 HttpSession session = request.getSession();
	 dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
	 
      // No update by default
	  boolean doUpdate = false;
	  // Fetching request parameters
	  String customerid = request.getParameter("CustomerId");
	  String serviceid = request.getParameter("ServiceId");
	  long lastTime;


     try
     {
    	con = (Connection) dbp.getConnection();
    	
 	    lastTime = Long.parseLong(request.getParameter("LastTime"));
 	    
 	    Service service =
 	    	 Service.findByPrimaryKey(con, String.valueOf(serviceid));
 	    Customer customer =
 	    	 Customer.findByPrimaryKey(con, String.valueOf(customerid));
 	    
 	     // If service parameter was passed then
 	     //check service's last time first
 	    if(service != null && service.getLastupdatetime() > lastTime)
 	    {
 	      doUpdate = true;
 	      lastTime = service.getLastupdatetime();
 	    }else if(customer != null && 
 	    		customer.getLastupdatetime() > lastTime)
 	    {
 	      // If customer parameter is passed then check last time
 	    	//of the customer
 	      doUpdate = true;
 	      lastTime = customer.getLastupdatetime();
 	    }else
 	    {
 	      // If the customer's last time is less then LastTime parameter 
 	    	//then there could be customer's services
 	      // with the last time greater then LastTime
 	      String query = "select max(lastupdatetime) from crm_service" +
 	      		" where customerid = ? and lastupdatetime > ?";

 	      statement = con.prepareStatement(query);
 	      statement.setString(1, customerid);
 	      statement.setLong(2, lastTime);

 	      resultSet = statement.executeQuery();
 	      if(resultSet.next())
 	      {
 	        lastTime = resultSet.getLong(1);
 	        doUpdate = lastTime > 0;
 	      }
 	    }
 	     
 		 //set lasttime,doUpdate here
 	   ((ServiceForm)form).setLastUpdateTime(lastTime);
 	   String strDoUpdate = "N";
 	   if(doUpdate) 
 		strDoUpdate = "Y";
 	   else
 		strDoUpdate = "N";  
 	   
 	   request.setAttribute("doUpdate",strDoUpdate);
 	   
 	  ((ServiceForm)form).setCustomerid(customerid);
 	  ((ServiceForm)form).setServiceid(serviceid);
 	 }
	 	catch(Exception ex)
	 	{
	 		 error = true;
	 	    lastTime = 0;
	 
	 	}finally
	 	{
			if (statement != null)
				statement.close();
			if (resultSet != null)
				resultSet.close();

	         // close the connection
	        dbp.releaseConnection(con);
			
			// try { if (con != null) con.close(); } catch (Exception ex) { }
	 	}
 
 //Forward Action
 if(!(error))
  {        
	  //set values to actionform obj && Transfer to the jsp   		  
   	return mapping.findForward(Constants.SUCCESS);           
  }
  else
  {       	
 	   return mapping.findForward(Constants.FAILURE);
  }
	 }

}
