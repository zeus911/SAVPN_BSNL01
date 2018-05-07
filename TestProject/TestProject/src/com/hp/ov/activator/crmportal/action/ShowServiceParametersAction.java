
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.action;

import java.sql.*;
import java.util.ArrayList;
import javax.servlet.http.*;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;
import com.hp.ov.activator.crmportal.bean.*;


public class ShowServiceParametersAction extends Action
{

	public ShowServiceParametersAction() 
	{}
	
	 public ActionForward execute(ActionMapping mapping,
	            ActionForm form,
	            HttpServletRequest request,
	            HttpServletResponse response) throws Exception 
	 {
         Logger logger = Logger.getLogger("CRMPortalLOG");
		 
         DatabasePool dbp = null;
         Connection con = null;
         String serviceid = ((ServiceForm)form).getServiceid();
         ServiceParameter [] parameters = null;      
         Service service = null;
         ArrayList v = new ArrayList();
         boolean error = false;       
		 
		 ResultSet rs1 = null;
		 PreparedStatement statement1 = null;
		 
		 ResultSet attRs = null;
		 ResultSet rs = null;
         
//richa - 11687
  
		String mv = ((ServiceForm)form).getMv();
    	String currentPageNo = ((ServiceForm)form).getCurrentPageNo();
		String viewPageNo = ((ServiceForm)form).getViewPageNo();

		String currentRs = ((ServiceForm)form).getCurrentRs();
    	String lastRs = ((ServiceForm)form).getLastRs();
		String totalPages = ((ServiceForm)form).getTotalPages();

		
//richa - 11687

	logger.debug("Entry of ShowServiceParametersAction.java: serviceid is "+serviceid);
		 
		 // Get database connection from session
		HttpSession session = request.getSession();
		dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
				     	
    	try
    	{
    		
    		con = (Connection) dbp.getConnection();
    		String attachmentId ="";
    		if(serviceid!= null)
    		{
    		 parameters = ServiceParameter.findByServiceid(con, serviceid);
    		
    		 service = Service.findByPrimaryKey(con, serviceid); 
    		 //set service
    		 ((ServiceForm)form).setService(service);
    		 
    		 
    		 
    		 //PR 14830 
    		statement1 =con.prepareStatement("select serviceid from CRM_SERVICE where parentserviceid =?");
    		 statement1.setString(1, serviceid);
    		 rs1 = statement1.executeQuery();
    		  while(rs1.next())
              {
             	 attachmentId=rs1.getString(1);
              }
            attRs = getRsetObject(con,attachmentId,parameters);
            while(attRs.next()){
              setConnectivity(parameters, attRs);
            }
              //ends here
    		 
    		 //In past, site and siteattachment both has pid, now just siteattachment has pid
    		 if(service.getParentserviceid()!= null)
    		 {
    		 Service pservice = Service.findByPrimaryKey(con, service.getParentserviceid());
               //set parent service
    		 ((ServiceForm)form).setParentService(pservice);
    		 }
    		 
    		  rs = getRsetObject(con,serviceid, parameters);
             while(rs.next())
             {

               setConnectivity(parameters, rs);            
               
            	v.add( new ServiceParameterVO(rs.getString(1),rs.getString(2),
            			 rs.getString(3),rs.getString(4)));        	 
             }
            
             ServiceParameterVO [] parameterVO = 
            	 new ServiceParameterVO[v.size()];      
				 v.toArray( parameterVO );
			//SERVICE PARAMS VO	 
		((ServiceForm)form).setServiceparameterVO(parameterVO);
		 //set parameters
		 ((ServiceForm)form).setServiceparameters(parameters);
    		}//serviceID
    	}//try
     	catch(Exception ex)
     	{
     		 error = true;
     		 logger.error("show service parameter Action class errors: " , ex);	
     	}finally
     	{
			if (rs1 != null)
				rs1.close();
			if (statement1 != null)
				statement1.close();
			if (attRs != null)
				attRs.close();
			if (rs != null)
				rs.close();	
			
             // close the connection
            dbp.releaseConnection(con);
			
			// try { if (con != null) con.close(); } catch (Exception ex) { }
     	}
           //      Forward Action
        if(!(error))
         {        
   	         //Transfer to the jsp
 		   
        	return mapping.findForward(Constants.SUCCESS);
             
         }else
         { 
        	
        	 //return mapping.findForward(Constants.FAILURE);
        	 
        	 ListServicesAction allServices = new ListServicesAction();
         	 ActionForward actionforward =
         		allServices.execute(mapping,form,request,response);
	    	 actionforward = 
      			    new ActionForward("/jsp/FindAllServices.jsp");
	    	 return  actionforward;
        	 
         }
		 
	 }
	 
	 
	private void setConnectivity(ServiceParameter [] parameters, ResultSet rs) throws SQLException
  {
      if(parameters!=null)
      {
         for(int i=0;i<parameters.length;i++)
         {
             ServiceParameter obj = (ServiceParameter)parameters[i];
             String name = obj.getAttribute();
            if(name.equalsIgnoreCase("ConnectivityType"))
            {
                obj.setValue(rs.getString(4));
            
            }
             
         }
       }
    
  }

  //Reorganized for PR 14830 
	 
	  public ResultSet getRsetObject(Connection con,String id, ServiceParameter[] parameters) throws SQLException
	   {
			 PreparedStatement statement=con.prepareStatement("select CRM_SERVICE.CUSTOMERID, " +
				"COMPANYNAME, PRESNAME, CONNECTIVITYTYPE " +
				"from CRM_VPN_MEMBERSHIP, CRM_SERVICE, CRM_CUSTOMER\n" +
		     "where CRM_VPN_MEMBERSHIP.VPNID = CRM_SERVICE.SERVICEID\n" +
		     "and CRM_CUSTOMER.CUSTOMERID = CRM_SERVICE.CUSTOMERID\n" +
		      "and CRM_VPN_MEMBERSHIP.SITEATTACHMENTID = ?");
			
			 statement.setString(1, id);
			 ResultSet rs = statement.executeQuery();
             //Should NOT use rs.next() here!!!!!!!!
			 return rs;
	     }
	 
}
