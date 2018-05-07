
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
import com.hp.ov.activator.crmportal.helpers.*;

public class UndoModifyService extends Action{
	
	public UndoModifyService() 
	{}
	
	 public ActionForward execute(ActionMapping mapping,
	            ActionForm form,
	            HttpServletRequest request,
	            HttpServletResponse response) throws Exception 
	 {
	
	 Logger logger = Logger.getLogger("CRMPortalLOG");
     DatabasePool dbp = null;
     Connection con = null;
     boolean error = false; 
     
     String customerid = request.getParameter("customerid");
     String serviceid = request.getParameter ("serviceid");
     String attachmentid = request.getParameter ("attachmentid"); // added by tanye
     String parentserviceid = request.getParameter ("parentserviceid");
     Service service = null;
     String searchSite = request.getParameter("searchSite");
     request.setAttribute("searchSite",searchSite);
     String siteidSearch = request.getParameter("siteidSearch");
     
     // Get database connection from session
	  HttpSession session = request.getSession();
	  dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
				     	
	  try
	  	{
	  		
	  		con = (Connection) dbp.getConnection(); 
	  		if (request.getParameter("serviceid") == null) 
	  		{
	  	       throw new Exception("Service ID not set," +
	  	       		" cannot modify service.");
	  	     }
	  		
	  		service = Service.findByPrimaryKey(con, request.getParameter("serviceid"));
			 String currentState = service.getState();
			 String nextState = null;
	  	     ServiceParameter lastModifiedAction = ServiceParameter.findByPrimaryKey(con, service.getServiceid() + "||hidden_LastModifyAction"); 
	  	     ServiceParameter lastModifiedAttribute = ServiceParameter.findByPrimaryKey(con, service.getServiceid() + "||hidden_LastModifiedAttribute");
	  	     ServiceParameter lastModifiedAttributeValue = ServiceParameter.findByPrimaryKey(con, service.getServiceid() + "||hidden_LastModifiedAttributeValue");
	  	     ServiceParameter lastUndoAction = ServiceParameter.findByServiceidattribute(con, service.getServiceid(), Constants.PARAMETER_LAST_UNDO);

	  	     // hack: if last action was Constants.ACTION_JOIN_VPN and it should be undone then VPNMembership bean should be removed
	  	    final String action = lastModifiedAction != null ? lastModifiedAction.getValue() : "";
	  	    if(Constants.ACTION_JOIN_VPN.equals(action)){
	  	         final ServiceParameter parameter = ServiceParameter.findByServiceidattribute(con, service.getServiceid(), "hidden_vpnId");
	  	         if(parameter == null)
	  	             throw new IllegalStateException("Join VPN action had set hidden_vpnId parameter");
	  	         parameter.delete(con);
	  	        ServiceParameter protectionAttachmentIdParam =ServiceParameter.findByServiceidattribute(con, service.getServiceid(), "protectionAttachmentId");
	  	        String protectionAttachmentId =null;
	  			if(protectionAttachmentIdParam != null){
	  				protectionAttachmentId = protectionAttachmentIdParam.getValue();
	  			}
	  	         final VPNMembership membership = VPNMembership.findByVpnidsiteattachmentid(con, parameter.getValue(), attachmentid);
	  	         if(membership != null)
	  	             membership.delete(con);
	  	         final VPNMembership protectionMembership = VPNMembership.findByVpnidsiteattachmentid(con, parameter.getValue(), protectionAttachmentId);
	  	         if(protectionMembership != null){
	  	        	protectionMembership.delete(con);
	  	        	Service protectionService = Service.findByServiceid(con, protectionAttachmentId);
					if ( protectionService.getState().contains("PE_CE") ) {
						protectionService.setState("PE_CE_Ok");
					} else if ( protectionService.getState().contains("PE_") ) {
						protectionService.setState("PE_Ok");
					} else if ( protectionService.getState().contains("CE_Setup") ) {
						protectionService.setState("CE_Setup_Ok");
					} else if ( protectionService.getState().contains("CE_") ) {
						protectionService.setState("CE_Ok");
					} else  {
					   	protectionService.setState("Ok");
					}
	  	        	ServiceUtils.updateService(con, protectionService);
	  	         }
	  	     }
	  	      if(lastUndoAction != null){
	  	        try{
	  	          Class clazz = Class.forName(lastUndoAction.getValue());
	  	          Object object = clazz.newInstance();
	  	          StateListener listener = (StateListener) object;
	  	          int result = listener.proccedState(con, service.getServiceid(), currentState, null);
	  	          switch(result){
	  	            case StateListener.REMOVE_AND_BREAK :;
	  	            case StateListener.REMOVE_AND_CONTINUE :lastUndoAction.delete(con); break;
	  	          }
	  	      }catch (Exception ex) 
	  	      {
	  	          ex.printStackTrace();
	  	          error = true;
	  	        }

	  	      }
	  	    int i = 0;
	  	     while(lastModifiedAttribute != null && lastModifiedAttributeValue != null) {
	  	       ServiceParameter undoModifyParam = ServiceParameter.findByPrimaryKey(con, service.getServiceid() + "||" + lastModifiedAttribute.getValue());
	  	       
	  	       String value = lastModifiedAttributeValue.getValue();
	  	       
	  	       if (value != null && !value.equals("##REMOVE_IT##")) {
	  	         undoModifyParam.setValue(value);
	  	         undoModifyParam.update(con);
	  	       }
	  	       
	  	       // If the value is null, then set the last modified value to ""
	  	       if (value == null) {
	  	         undoModifyParam.setValue("");
	  	         undoModifyParam.update(con);
	  	       }

	  	       // If ##REMOVE_IT## was set in commitModifyService.jsp, it was because the modified service parameter did not exist before the modification.
	  	       // The undo action here is the to remove the service parameter again!
	  	       if (value != null && value.equals("##REMOVE_IT##")) {
	  	         undoModifyParam.delete(con);
	  	       }

	  	       lastModifiedAttribute = ServiceParameter.findByServiceidattribute(con, service.getServiceid(), "hidden_LastModifiedAttribute" + i);
	  	       lastModifiedAttributeValue = ServiceParameter.findByServiceidattribute(con, service.getServiceid(), "hidden_LastModifiedAttributeValue" + i);
	  	       i++;

	  	     }
	  	     
	  	     if (currentState.equals("Modify_Failure") || (currentState.indexOf("Wait_Start_Time_Failure") != -1 && currentState.indexOf("PE") == -1)) {
	  	       nextState = "Ok";
	  	     }

	  	     if (currentState.equals("PE_Modify_Failure") || (currentState.indexOf("Wait_Start_Time_Failure") != -1 && currentState.indexOf("PE") != -1)) {
	  	       nextState = "PE_Ok";
	  	     }
	  	    
	  	     if (currentState.equals("Periodic_Modify_Failure") || (currentState.indexOf("Wait_Start_Time_Failure") != -1 && currentState.indexOf("PE") != -1)) {
	  	       nextState = "Ok";
	  	     }
	  	     
	  	    if (currentState.equals("PE_CE_Modify_Failure") || (currentState.indexOf("Wait_Start_Time_Failure") != -1 && currentState.indexOf("PE_CE") != -1)) {
	  	       nextState = "PE_CE_Ok";
	  	     }
	  	   
			if ( currentState.equals(Constants.STATE_MODIFY_PARTIAL) ) {
				nextState=Constants.SERVICE_STATE_OK;
			} else if ( currentState.equals(Constants.STATE_PE_CE_MODIFY_PARTIAL) ) {
				nextState = Constants.STATE_PE_CE_OK;
			}
	  	    //Added Periodic_Modify_PE_Failure state to fix PR 14250 
	  	     if (currentState.equalsIgnoreCase("PE_Modify_Wait_End_Time_Failure")|| currentState.equals("PE_Modify_Partial") ||currentState.equals("PE_Modify_Wait_Start_Time_Failure") || currentState.equals("PE_Periodic_Modify_Failure")||(currentState.indexOf("Wait_Start_Time_Failure") != -1 && currentState.indexOf("PE") != -1)) {
	  	    	if ("layer2-VPWS".equals(service.getType())) {
	  	    		nextState = "Ok";
	  	    	}else{
	  	    		nextState = "PE_Ok";
	  	    	}
	  	       
	  	     }
	  	    
	  	     if ("layer2-VPWS".equals(service.getType())) {
	  	       try {
	  	         VPNMembership[] mems = VPNMembership.findByVpnid(con, service.getServiceid());
	  	         if (mems == null || mems.length != 2) {
	  	           logger.warn("VPWS doesn't have both two end attachments!!!");
	  	         } else {
	  	           Service attach1 = Service.findByServiceid(con, mems[0].getSiteattachmentid());
	  	           if ("PE_Modify_Failure".equals(attach1.getState())) {
	  	             attach1.setState("PE_Ok");
	  	           }
	  	           ServiceUtils.updateService(con, attach1);
	  	           Service attach2 = Service.findByServiceid(con, mems[1].getSiteattachmentid());
	  	           if ("PE_Modify_Failure".equals(attach2.getState())) {
	  	             attach2.setState("PE_Ok");
	  	           }
	  	           ServiceUtils.updateService(con, attach2);
	  	         }
	  	       } catch (Exception e) {
	  	         logger.error("UndoModifyService Error: ", e);
	  	       }
	  	     }
	  	    
	  	     if (nextState != null) {
	  	       service.setState(nextState);
	  	       ServiceUtils.updateService(con, service);
	  	     } else {
	  	       throw new Exception("Wrong state for undo modify action, nothing done!");
	  	     }    
	  		
	  		//send control to findallservices
	  		((ServiceForm)form).setCustomerid(customerid);
	  	   ((ServiceForm)form).setServiceid(serviceid);
	  	     
	  	}
	 	catch(Exception ex)
	 	{
	 		 error = true;

	 	}finally
	 	{
	         // close the connection
	        dbp.releaseConnection(con);
	 	}
	 	
	 	 
	 	 ActionForward actionforward = null;
  	  
	 	if(searchSite!=null && !searchSite.equals("") && !searchSite.equals("null")){ 
	  	        if (siteidSearch != null){
	  	          ((ServiceForm)form).setServiceid(siteidSearch);
	  	        }
	  	        SiteSearchAction siteSearchAction = new SiteSearchAction();
	  	        actionforward = siteSearchAction.execute(mapping, form, request, response);
	  	        
	
	  	      }
	  	      else {
	  	    	ListServicesAction allServices = new ListServicesAction();
	  	        actionforward = allServices.execute(mapping, form, request, response);
	  	       
	  	      }
    
    //Forward Action
    if(!(error))
     {        
   	  //set values to actionform obj && Transfer to the jsp   		  
      	//return mapping.findForward(Constants.SUCCESS);     
    	return  actionforward;
     }
     else
     {       	
    	 //  return mapping.findForward(Constants.FAILURE);
    	 return  actionforward;
     }
	
	 }

}
