/*

 ***************************************************************************

 *

 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.

 *

 ************************************************************************

 */




package com.hp.ov.activator.crmportal.action;


import java.io.IOException;
import java.sql.*;
import java.util.*;
import java.util.Date;
import java.text.*;

import javax.servlet.http.*;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;
import com.hp.ov.activator.crmportal.common.*;
import com.hp.ov.activator.crmportal.bean.*;
import com.hp.ov.activator.crmportal.helpers.*;
import com.hp.ov.activator.vpn.IPAddressHelper.IPAddressHelper;

public class ModifyServiceAction extends Action

{

	private Logger logger =  Logger.getLogger("CRMPortalLOG");

	public ModifyServiceAction()

	{}



	 public ActionForward execute(ActionMapping mapping,

	            ActionForm form,

	            HttpServletRequest request,

	            HttpServletResponse response) throws Exception

	 {

	      DatabasePool dbp = null;

	      Connection con = null;

	      boolean error = false;

	      String formAction = request.getParameter ("actionType");
	      String searchSite = request.getParameter("searchSite");
	      request.setAttribute("searchSite",searchSite);
	      String siteidSearch = request.getParameter("siteidSearch");



	      logger.debug("ModifyServiceAction:::::::::formAction"+formAction);

	      String customerid = request.getParameter("customerid");

	      String type = request.getParameter ("type");

	      HashMap serviceParameters = new HashMap ();

	      HashMap parentServiceParameters = new HashMap ();

	      String serviceid = request.getParameter ("serviceid");

	      String parentserviceid = request.getParameter ("parentserviceid");

          String attachmentid = request.getParameter ("attachmentid"); // added by tanye

          logger.debug("ModifyServiceAction:::: parentserviceid|" + parentserviceid + " attachmentid|" + attachmentid );

	      String modifySelection = request.getParameter("action");

			Customer customer = null;

	      String messageid = null;

	      String link_part = "";

	      Service service = null;

	      String lastState = null;

	      String startTime = null, endTime = null, period = null, duration = null;

		    String strMessage= "";	//richa

	      boolean isPeriodic = "true".equals(request.getParameter("SP_isPeriodic"));

	      final  String PARAMETER_UNDO_MODIFY = "UndoModify";

	      // Get database connection from session

		  HttpSession session = request.getSession();

		  dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);

		  Service aEndService=null ;
	      Service zEndService=null ;
	      String protectionAttachmentId = null;
	      String siteServiceId = null;
	      Service protectionService=null ;
		  Boolean isL3AttachmentRequest=false;
		  boolean modifyQoSBulk=false;
	      try

		  	{

		  		con = (Connection) dbp.getConnection();
				
				// Aggregated LSPS ER
				String lspUsageMode = request.getParameter("lspoptions");	
				if (lspUsageMode != null)
				{
					serviceParameters.put("lspusagemode", lspUsageMode);
					ServiceUtils.saveOrUpdateParameter(con, serviceid, "lspusagemode", lspUsageMode);
				}
				// Aggregated LSPs ER
				
				// Modify IP ER
				String addressPool = request.getParameter("SP_AddressPool");	
				if (addressPool != null)
				{
					serviceParameters.put("AddressPool", addressPool);
					ServiceUtils.saveOrUpdateParameter(con, serviceid, "AddressPool", addressPool);
					
					String secondaryAddressPool = request.getParameter("SP_SecondaryAddressPool");
					if (secondaryAddressPool != null)
					{
						serviceParameters.put("SecondaryAddressPool", secondaryAddressPool);
						ServiceUtils.saveOrUpdateParameter(con, serviceid, "SecondaryAddressPool", secondaryAddressPool);
					}
					
					String addressFam = request.getParameter("AddressFamily");	
					if (addressFam != null)
					{
						serviceParameters.put("AddressFamily", addressFam);
						ServiceUtils.saveOrUpdateParameter(con, serviceid, "AddressFamily", addressFam);
					}
					
					String act_scope = ServiceUtils.getServiceParam(con, serviceid, "Activation_Scope");
					String managed_ce = ServiceUtils.getServiceParam(con, serviceid, "Managed_CE_Router");
		
					serviceParameters.put("Activation_Scope", act_scope);
					serviceParameters.put("Managed_CE_Router", managed_ce);
					
				}
				// Modify IP ER
				
				
				Service attachService  = null;
				Service requestedService = null;
				String vpnServiceId = null; //Note:- In case of attachment service request and attachment is joined to another VPN
											//then this variable may not contain the vpnid on which the attachment operation 
											//is invoked. But this can be used to retrieve the protection attachment.
				if (serviceid != null && !serviceid.equals("") ) {
					requestedService = Service.findByPrimaryKey(con, serviceid);
				}
				if (attachmentid != null && !attachmentid.equals("") ) {
					attachService = Service.findByPrimaryKey(con, attachmentid);
				}
				if ( requestedService != null && Constants.TYPE_LAYER3_ATTACHMENT.equals(requestedService.getType()) ) {
					isL3AttachmentRequest=true;
				}
				if ( requestedService != null  && Constants.TYPE_SITE.equals(requestedService.getType()) ) {
					siteServiceId = serviceid;
					vpnServiceId = parentserviceid ;
				} else if ( attachService != null && (attachService.getType().equals(Constants.TYPE_LAYER3_ATTACHMENT)||attachService.getType().equals(Constants.TYPE_GIS_ATTACHMENT))) {
					siteServiceId = attachService.getParentserviceid();
					VPNMembership []membershipObj = VPNMembership.findBySiteattachmentid(con, attachService.getServiceid());
					if ( membershipObj != null && membershipObj.length > 0 ) {
						vpnServiceId = membershipObj[0].getVpnid();
					}
				}
				
				//Find the protection attachment id
				if ( siteServiceId != null && vpnServiceId != null ) {
					Service[] attachments = Service.findByParentserviceid(con, siteServiceId);
					for (Service attachment : attachments) {
						if ( attachment.getType().equals(Constants.TYPE_LAYER3_PROTECTION) ) {
							VPNMembership membershipObj = VPNMembership.findByVpnidsiteattachmentid(con, vpnServiceId, attachment.getServiceid());
							if( membershipObj != null ){
							   protectionAttachmentId=attachment.getServiceid();
							   protectionService=Service.findByServiceid(con, protectionAttachmentId);
							   logger.debug("ModifyServiceAction:::: Protection Attachment service id: " + protectionAttachmentId );
							}
						}
					}    
				}
				
				//======== ::Begin:: Code to handle migration of sites with state modify failed/modify partial from V5.1. =================
				//If a l3 site in V5.1 has the state Modify_Failure or Modify_Partial
				//then the site is migrated to V6.0 or later with the same state
				//and Undo modify and Resend modify options are available for the site.
				//But in 6.0 or later, all the modify operation from site has been moved to attachment.
				//So if a Undo Modify Request or Resend Modify request comes for the site,
				//We have to convert this request to corresponding site attachment request.
				if ( 	requestedService != null && attachService != null &&
						Constants.TYPE_SITE.equals(requestedService.getType()) && 
						(requestedService.getState().equals(Constants.STATE_MODIFY_FAILURE) || requestedService.getState().equals(Constants.STATE_MODIFY_PARTIAL) )
					) 
				{
					logger.debug("ModifyServiceAction:::: Handling migration of migration of site["+requestedService.getServiceid()
							+","+requestedService.getPresname()+"] with state "+requestedService.getState()+" from V5.1" );
					//We received a modify request (either Undo modify or Resend Modify)
					//Convert it to a site modify operation.
					isL3AttachmentRequest=true;
					
					if ( attachService.getState().equals(Constants.SERVICE_STATE_OK) ) {
						//If the PE state is Ok, then set the status to Modify_Failure/Modify_Partial
						attachService.setState(requestedService.getState());
					} else {
						//If the PE state is PE_Ok, then set the status to PE_Modify_Failure/PE_Modify_Partial
						attachService.setState("PE_"+requestedService.getState());
					}
					ServiceUtils.updateService(con,attachService);
					if ( protectionService != null ) {
						if ( protectionService.getState().equals(Constants.SERVICE_STATE_OK) ) {
							//If the PE state is Ok, then set the status to Modify_Failure/Modify_Partial
							protectionService.setState(requestedService.getState());
						} else {
							//If the PE state is PE_Ok, then set the status to PE_Modify_Failure/PE_Modify_Partial
							protectionService.setState("PE_"+requestedService.getState());
						}
						ServiceUtils.updateService(con,protectionService);
					}
					
					//Update the site service state to OK.
					requestedService.setState(Constants.SERVICE_STATE_OK);
					ServiceUtils.updateService(con,requestedService);
					
					parentserviceid = siteServiceId;
					serviceid = attachService.getServiceid();
					type = Constants.TYPE_LAYER3_ATTACHMENT;
					
					//Update the attachmentid parameter to correct values. 
					//This is needed in situation where initial attachment is 
					//deleted and protection has become the initial.
					ServiceParameter sParameter = ServiceParameter.findByServiceidattribute(con, serviceid, "attachmentid");
					if ( sParameter != null ) {
						sParameter.setValue(serviceid);
						sParameter.update(con);
					}
					sParameter = null;
					if ( protectionAttachmentId != null ) {
						//Update Site_Service_id parameter for protection attachment.
						ServiceUtils.saveOrUpdateParameter(con,protectionAttachmentId,"Site_Service_id",siteServiceId);
						sParameter = ServiceParameter.findByServiceidattribute(con, protectionAttachmentId, "attachmentid");
						if ( sParameter != null ) {
							sParameter.setValue(serviceid);
							sParameter.update(con);
						}
					}
					
					//Move all the modify specific service parameters from site to attachment.
					String []modifyServiceParameters = new String[] { 
																		"MulticastQoSClass", 
																		"MulticastRP", 
																		"MulticastRateLimit",
																		"MulticastStatus",
																		"MulticastVPNId",
																		"hidden_LastModifiedAttribute",
																		"hidden_LastModifiedAttributeValue",
																		"hidden_LastModifyAction",
																		"hidden_attachmentid",
																		"hidden_connectivity_VPNid",
																		"hidden_lastOperationUndo",
																		"hidden_old_connectivity",
																		"hidden_vpnId" 
																	};
					for (int index=0; index<modifyServiceParameters.length; index++) {
						sParameter = null;
						sParameter = ServiceParameter.findByServiceidattribute(con, siteServiceId, modifyServiceParameters[index]);
						if ( sParameter != null ) {
							ServiceUtils.saveOrUpdateParameter(con, serviceid, modifyServiceParameters[index], sParameter.getValue());
							sParameter.delete(con);
						}
					} 
				}
				//======== ::End:: Code to handle migration of sites with state modify failed/modify partial from V5.1. =================

				logger.debug("ModifyServiceAction:::: parentserviceid|" + parentserviceid + " attachmentid|" + attachmentid );


		  		((ServiceForm)form).setCustomerid(customerid);

		  		((ServiceForm)form).setType(type);



		  		customer = (Customer) Customer.findByPrimaryKey(con,customerid);

		  		((ServiceForm)form).setCustomer(customer);



		  	    IdGenerator idGenerator = new IdGenerator(con);





		    	if (serviceid != null && !serviceid.equals(""))

		    	{

		    	    service = Service.findByPrimaryKey(con, serviceid);

		    	   ((ServiceForm)form).setService(service);



		    	       if(service != null)

		    	       {

		    	         serviceParameters.put("serviceid", service.getServiceid());

		    	         serviceParameters.put("state", service.getState());

		    	         serviceParameters.put("presname", service.getPresname());

		    	         serviceParameters.put("submitdate", service.getSubmitdate());

		    	         serviceParameters.put("modifydate", service.getModifydate());

                         String realtype = getRealType(service.getType(), con, parentserviceid);

                         logger.debug("ModifyServiceActio::::::: type: " + realtype);


		    	         serviceParameters.put("type", (realtype.equals("layer3-Protection"))?"layer3-Attachment":realtype);

		    	         serviceParameters.put("customerid", service.getCustomerid());



		    	         // If it is not vpn service, parentserviceid must be passed in. Following is commented by tanye



		    	         /*// if parent service id was passed through request - then use it,

		    	         //else use from service params

		    	         parentserviceid = parentserviceid != null ? parentserviceid : service.getParentserviceid();

		    	         // if it is Layer3 site - then there aren't any parent service id,

		    	         //it should be fetched from VPNMembership

		    	         if(parentserviceid == null && "layer3-Site".equals(service.getType()))

		    	         {

		    	           parent service id is needed

		    	            when creating/deleting L3Site and after failure retry is pressed



		    	            for other cases for Layer3 sites parent service id is not used



		    	           final VPNMembership[] memberships =

		    	        	   VPNMembership.findBySiteid(con, serviceid);

		    	           if(memberships != null && memberships.length > 0)

		    	           {

		    	             parentserviceid = memberships[0].getVpnid();

		    	           }

		    	         }*/

		    	       }

		    	       serviceParameters.put("parentserviceid", parentserviceid);




		    	       ServiceParameter[] serviceParamArray =

		    	    	   ServiceParameter.findByServiceid(con, serviceid);


		    	       // Map all array entries to a HashMap.

		    	       if (serviceParamArray != null)

		    	       {

		    	         for (int i = 0; i < serviceParamArray.length; i++)

		    	         {

		    	           serviceParameters.put(serviceParamArray[i].getAttribute(), serviceParamArray[i].getValue());

		    	         }

		    	       }

		    	     }
		    	if ("ModifyQoSProfile".equalsIgnoreCase(request.getParameter("action")) || ("ModifyQoSBulk".equalsIgnoreCase(request.getParameter("action"))) || "ModifyRateLimitInterface".equalsIgnoreCase(request.getParameter("action")) ){
		    	
    		    	String SP_QoSChildEnabled="";
                    
                    if (request.getParameter("SP_QoSChildEnabled") != null) 
                    {                       
                      SP_QoSChildEnabled = request.getParameter("SP_QoSChildEnabled"); 
                    }
                   // serviceParameters.put("SP_QoSChildEnabled", SP_QoSChildEnabled);
                    serviceParameters.remove("QoSChildEnabled");
                    serviceParameters.put("QoSChildEnabled", SP_QoSChildEnabled);
                    ServiceUtils.saveOrUpdateParameter(con, serviceid, "QoSChildEnabled", SP_QoSChildEnabled);
		    	} 
				
				if ("ModifyCAR".equalsIgnoreCase(request.getParameter("action")))
				{
					String paramQoSChildEnabled = ServiceUtils.getServiceParam(con, serviceid, "QoSChildEnabled");
					serviceParameters.put("QoSChildEnabled", paramQoSChildEnabled);					
				}
					 
					 if ("ModifyQoSBulk".equalsIgnoreCase(request.getParameter("action"))) 
					 {
						modifyQoSBulk = true;
					 }
					 
					 // Check if all attachments are OK before carrying out a Modify QoS Bulk operation
					 if (modifyQoSBulk)
					 {
						boolean allAttachmentsOk = true;
						
						String whereClause = "attribute = 'vpnserviceid' and value = '"+serviceid+"'"; 
						
						ServiceParameter[] attachments = ServiceParameter.findAll(con,whereClause);
						
						attachments = attachments != null ? attachments : new ServiceParameter[0];
						
						for (int i=0; i < attachments.length; i++) 
						{
							Service attachment = Service.findByServiceid(con, attachments[i].getServiceid());
							String state = attachment.getState();
							
							if (state.indexOf("Ok") == -1)
							{
								allAttachmentsOk = false;
							}
						}
						
						if (!allAttachmentsOk)
						{
							throw new Exception("One or more site attachments are not in Ok/PE_Ok state. Bulk modification cannot be performed. Please check the site attachments.");
						}
					 }

					 // Bulk QoS Modify for Layer-3 VPNs - BEGIN 
					 if ( modifyQoSBulk && ("layer3-VPN".equals(service.getType())))
					 {
						// Save parameters in VPN parameters so they can be read from the listener
						String selectedCAR = ""; 
						if (request.getParameter("SP_CAR") != null) 
						{
							selectedCAR = request.getParameter("SP_CAR"); 
						}
						else // in case of resend, request is not present anymore so we have to pick the data from the VPN Parameters
						{
							selectedCAR = (String) ServiceUtils.getServiceParam(con, serviceid, "CAR"); 
						}
						
						String selectedQoS = ""; 
						if (request.getParameter("SP_QOS_PROFILE") != null) 
						{						
							selectedQoS = request.getParameter("SP_QOS_PROFILE"); 
						}
						else // in case of resend, request is not present anymore so we have to pick the data from the VPN Parameters
						{
							selectedQoS = (String) ServiceUtils.getServiceParam(con, serviceid, "QOS_PROFILE"); 
						}
						
						String baseProfile = ""; 
						if (request.getParameter("SP_QOS_BASE_PROFILE") != null) 
						{						
							baseProfile = request.getParameter("SP_QOS_BASE_PROFILE"); 
						}
						else // in case of resend, request is not present anymore so we have to pick the data from the VPN Parameters
						{
							baseProfile = (String) ServiceUtils.getServiceParam(con, serviceid, "QOS_BASE_PROFILE");
						}
						
						serviceParameters.put("CAR", selectedCAR);
						ServiceUtils.saveOrUpdateParameter(con, serviceid, "CAR", selectedCAR);	
						
						serviceParameters.put("QOS_PROFILE", selectedQoS);
						ServiceUtils.saveOrUpdateParameter(con, serviceid, "QOS_PROFILE", selectedQoS);
						
						serviceParameters.put("QOS_BASE_PROFILE", baseProfile);
						ServiceUtils.saveOrUpdateParameter(con, serviceid, "QOS_BASE_PROFILE", baseProfile);
						
						EXPMapping[] expMappings = EXPMapping.findAll(con);

						int expMappingsCount = expMappings == null ? 0 : expMappings.length;

						for(int i = 0; i < expMappingsCount; i++)
						{
						  // Get Percent
						  String parameterNamePercent = "QOS_CLASS_"+expMappings[i].getPosition()+"_PERCENT";
						  
						  String parameterPercent = "";
						  if (request.getParameter("SP_"+parameterNamePercent) != null)
						  {
							parameterPercent = request.getParameter("SP_"+parameterNamePercent);
						  }
						  else // in case of resend, request is not present anymore so we have to pick the data from the VPN Parameters
						  {
							parameterPercent = ServiceUtils.getServiceParam(con, serviceid, parameterNamePercent);
						  }

						  serviceParameters.put(parameterNamePercent, parameterPercent);
						  ServiceUtils.saveOrUpdateParameter(con, serviceid, parameterNamePercent, parameterPercent);
						  
						  // Get Rate Limit
						  String parameterNameRL = "QOS_CLASS_"+expMappings[i].getPosition()+"_RL";
						  
						  String parameterRL = "";
						  if (request.getParameter("SP_"+parameterNameRL) != null)
						  {
							parameterRL = request.getParameter("SP_"+parameterNameRL);
						  }
						  else // in case of resend, request is not present anymore so we have to pick the data from the VPN Parameters
						  {
							parameterRL = ServiceUtils.getServiceParam(con, serviceid, parameterNameRL);
						  }

						  serviceParameters.put(parameterNameRL, parameterRL);
						  ServiceUtils.saveOrUpdateParameter(con, serviceid, parameterNameRL, parameterRL);
						}
						
						// Save listener for QoS Bulk operation
						ServiceUtils.saveOrUpdateParameter(con, serviceid, Constants.PARAMETER_LAST_COMMIT, ModifyQoSBulkVPNLayer3Listener.class.getName());
						
						// Save activation name
						serviceParameters.put("activation_name", "modify_QoS_Bulk");
				
					 } // Bulk QoS Modify for Layer-3 VPNs - END
					 
					 // Bulk QoS Modify for Layer-2 VPNs - BEGIN 
					 if ( modifyQoSBulk && ("layer2-VPN".equals(service.getType())))
					 {
						// Save parameters in VPN parameters so they can be read from the listener
						String selectedCAR = ""; 
						if (request.getParameter("SP_CAR") != null) 
						{
							selectedCAR = request.getParameter("SP_CAR"); 
						}
						else // in case of resend, request is not present anymore so we have to pick the data from the VPN Parameters
						{
							selectedCAR = (String) ServiceUtils.getServiceParam(con, serviceid, "CAR"); 
						}
						
						String selectedQoS = ""; 
						if (request.getParameter("SP_QOS_PROFILE") != null) 
						{						
							selectedQoS = request.getParameter("SP_QOS_PROFILE"); 
						}
						else // in case of resend, request is not present anymore so we have to pick the data from the VPN Parameters
						{
							selectedQoS = (String) ServiceUtils.getServiceParam(con, serviceid, "QOS_PROFILE"); 
						}
						
						String baseProfile = ""; 
						if (request.getParameter("SP_QOS_BASE_PROFILE") != null) 
						{						
							baseProfile = request.getParameter("SP_QOS_BASE_PROFILE"); 
						}
						else // in case of resend, request is not present anymore so we have to pick the data from the VPN Parameters
						{
							baseProfile = (String) ServiceUtils.getServiceParam(con, serviceid, "QOS_BASE_PROFILE");
						}
						
						serviceParameters.put("CAR", selectedCAR);
						ServiceUtils.saveOrUpdateParameter(con, serviceid, "CAR", selectedCAR);	
						
						serviceParameters.put("QOS_PROFILE", selectedQoS);
						ServiceUtils.saveOrUpdateParameter(con, serviceid, "QOS_PROFILE", selectedQoS);
						
						serviceParameters.put("QOS_BASE_PROFILE", baseProfile);
						ServiceUtils.saveOrUpdateParameter(con, serviceid, "QOS_BASE_PROFILE", baseProfile);
						
						EXPMapping[] expMappings = EXPMapping.findAll(con);

						int expMappingsCount = expMappings == null ? 0 : expMappings.length;

						for(int i = 0; i < expMappingsCount; i++)
						{
						  // Get Percent
						  String parameterNamePercent = "QOS_CLASS_"+expMappings[i].getPosition()+"_PERCENT";
						  
						  String parameterPercent = "";
						  if (request.getParameter("SP_"+parameterNamePercent) != null)
						  {
							parameterPercent = request.getParameter("SP_"+parameterNamePercent);
						  }
						  else // in case of resend, request is not present anymore so we have to pick the data from the VPN Parameters
						  {
							parameterPercent = ServiceUtils.getServiceParam(con, serviceid, parameterNamePercent);
						  }

						  serviceParameters.put(parameterNamePercent, parameterPercent);
						  ServiceUtils.saveOrUpdateParameter(con, serviceid, parameterNamePercent, parameterPercent);
						  
						  // Get Rate Limit
						  String parameterNameRL = "QOS_CLASS_"+expMappings[i].getPosition()+"_RL";
						  
						  String parameterRL = "";
						  if (request.getParameter("SP_"+parameterNameRL) != null)
						  {
							parameterRL = request.getParameter("SP_"+parameterNameRL);
						  }
						  else // in case of resend, request is not present anymore so we have to pick the data from the VPN Parameters
						  {
							parameterRL = ServiceUtils.getServiceParam(con, serviceid, parameterNameRL);
						  }

						  serviceParameters.put(parameterNameRL, parameterRL);
						  ServiceUtils.saveOrUpdateParameter(con, serviceid, parameterNameRL, parameterRL);
						}
						
						// Save listener for QoS Bulk operation
						ServiceUtils.saveOrUpdateParameter(con, serviceid, Constants.PARAMETER_LAST_COMMIT, ModifyQoSBulkVPNLayer2Listener.class.getName());
						
						// Save activation name
						serviceParameters.put("activation_name", "modify_QoS_Bulk");
				
					 } // Bulk QoS Modify for Layer-2 VPNs - END

					 // Bulk Attachment Deletion - BEGIN
					 if ("DeleteAllAttachments".equalsIgnoreCase(request.getParameter("action"))) 
					 {
						serviceParameters.put("serviceid", serviceid);
						serviceParameters.put("activation_name", "delete_All_Attachments");
						
						// Save hidden last modify action
						ServiceUtils.saveOrUpdateParameter(con, serviceid, "hidden_LastModifyAction", "DeleteAllAttachments");
						
						// Save listener for QoS Bulk operation depending on service type
						if ("layer3-VPN".equals(service.getType()))
						{
							ServiceUtils.saveOrUpdateParameter(con, serviceid, Constants.PARAMETER_LAST_COMMIT, DeleteAllAttachmentsVPNLayer3Listener.class.getName());
						}
						else
						{
							ServiceUtils.saveOrUpdateParameter(con, serviceid, Constants.PARAMETER_LAST_COMMIT, DeleteAllAttachmentsVPNLayer2Listener.class.getName());
						}
						
					 } // Bulk Attachment Deletion - END

					 if ("ModifyRateLimitInterface".equalsIgnoreCase(request.getParameter("action")) ){
		                	                   
	                   
	                    String selected_interface="";	                    
	                   
                        String source_terminationpoint="";
                        String selected_region="";
                        String selected_network="";
	                    
	                   
	                    if (request.getParameter("INTERFACES") != null) 
                        {                       
	                      selected_interface = request.getParameter("INTERFACES"); 
                        }
	                    
	                    if(request.getParameter("source_terminationpoint") != null){
	                      source_terminationpoint = request.getParameter("source_terminationpoint"); 
	                    }
	                    
	                    if (request.getParameter("REGIONS") != null) 
                        {                       
	                      selected_region = request.getParameter("REGIONS"); 
                        }
	                    
	                    if (request.getParameter("NETWORKS") != null) 
                        {                       
	                      selected_network = request.getParameter("NETWORKS"); 
                        }
	                    
	                   // serviceParameters.put("SP_QoSChildEnabled", SP_QoSChildEnabled);	                
                        
                        serviceParameters.remove("Interface");
                        serviceParameters.put("Interface", selected_interface);
                        ServiceUtils.saveOrUpdateParameter(con, serviceid, "Interface", selected_interface);
                        
                        serviceParameters.remove("Source_Interface");
                        serviceParameters.put("Source_Interface", source_terminationpoint);
                        ServiceUtils.saveOrUpdateParameter(con, serviceid, "Source_Interface", source_terminationpoint);
                        
                        serviceParameters.remove("Region");
                        serviceParameters.put("Region", selected_region);
                        ServiceUtils.saveOrUpdateParameter(con, serviceid, "Region", selected_region);
                        
                        serviceParameters.remove("Location");
                        serviceParameters.put("Location", selected_network);
                        ServiceUtils.saveOrUpdateParameter(con, serviceid, "Location", selected_network);
	                  }

		    	     if (parentserviceid != null && !parentserviceid.equals(""))

		    	     {

		    	       Service parentService = Service.findByPrimaryKey(con, parentserviceid);

		    	       if (parentService != null)

		    	       {

		    	         parentServiceParameters.put("serviceid", parentService.getServiceid());

		    	         parentServiceParameters.put("state", parentService.getState());

		    	         parentServiceParameters.put("presname", parentService.getPresname());

		    	         parentServiceParameters.put("submitdate", parentService.getSubmitdate());

		    	         parentServiceParameters.put("modifydate", parentService.getModifydate());

		    	         parentServiceParameters.put("type", parentService.getType());

		    	         parentServiceParameters.put("customerid", parentService.getCustomerid());

		    	         parentServiceParameters.put("parentserviceid", parentService.getParentserviceid());


		    	         ServiceParameter[] parentServiceParamArray

		    	         = ServiceParameter.findByServiceid(con, parentserviceid);



		    	         if (parentServiceParamArray != null)

		    	         {

		    	           for (int i = 0; i < parentServiceParamArray.length; i++)

		    	           {

		    	             parentServiceParameters.put (parentServiceParamArray[i].getAttribute(), parentServiceParamArray[i].getValue());

		    	           }

		    	         }

		    	       }

		    	     }



		    	    /* if(customer!=null)

		 	  	    {

		 	  	    	if (serviceid == null)

		 	  	    	{

		 	  	    	 serviceid = idGenerator.getServiceId();

		 	  	    	}

		 	  	    	 messageid = idGenerator.getMessageId();



		 	  	    } */

		 	  	    ((ServiceForm)form).setServiceid(serviceid);

		 	    	((ServiceForm)form).setMessageid(messageid);

		 	    	((ServiceForm)form).setParentserviceid(parentserviceid);



		 	    request.setAttribute("serviceParameters",serviceParameters);

		 	    request.setAttribute("parentServiceParameters",parentServiceParameters);

		 	    request.setAttribute("modifySelection",modifySelection);



		 	    //end of loadparams



		 	   /*

		        undo index is used to save more then one parameter for undo

		        If index is not specified then value is saved without any index(as it was before)

		        Undo will restore attribute value without the index and all values with the indices from 0 to n

		        where n+1 is non-existent attribute

		     */



		 	    int undoIndex = 0;



		 	   if (serviceid == null) {

		 	       throw new Exception("Service ID not set, cannot modify service.");

		 	     }

		 	     EXPMapping[] expMappings = EXPMapping.findAll(con);

		 	     final int expMappingsCount = expMappings == null ? 0 : expMappings.length;


		 	     // Generate new message id or get it from the site parameters

		 	     if (request.getParameter("messageid") == null) {

		 	        idGenerator = new IdGenerator(con);

		 	       serviceParameters.put("messageid", idGenerator.getMessageId());

		 	     } else {

		 	       serviceParameters.put("messageid", request.getParameter("messageid"));

		 	     }


		 	     // Default action is create

		 	     if (request.getParameter("action") != null) {

		 	       serviceParameters.put("ACTION", request.getParameter("action"));

		 	     } else {

		 	       serviceParameters.put("ACTION", "Create");

		 	     }


		 	     // In order to be able to resend a modify action it is necessary to remember what the action was!!! it is marked hidden so that it is not

		 	     // shown on the service parameters site.

		 	     if (!serviceParameters.containsKey("hidden_LastModifyAction")) 
				 {			
					ServiceUtils.saveOrUpdateParameter(con, serviceid, "hidden_LastModifyAction", (String)serviceParameters.get("ACTION"));
		 	     }

		 	     serviceParameters.put("hidden_LastModifyAction", (String)serviceParameters.get("ACTION"));



		 	     // Change modify date


		 	     serviceParameters.put("modifydate", Constants.DEFAULT_DATE_FORMAT.format(new java.util.Date()));


		 	     serviceParameters.put("HOST", session.getAttribute(Constants.SOCKET_LIS_HOST));

		 	     serviceParameters.put("PORT", session.getAttribute(Constants.SOCKET_LIS_PORT));

		 	     serviceParameters.put("TEMPLATE_DIR", session.getAttribute(Constants.TEMPLATE_DIR));

		 	     serviceParameters.put("operator", session.getAttribute(Constants.USER_KEY));
		 	     
		 	     serviceParameters.put("LOG_DIRECTORY", session.getAttribute(Constants.LOG_DIRECTORY));


		 	     service = Service.findByPrimaryKey(con, serviceid);



		 	    /*

		 	    * Insert modify sections here. No section must assume that parameters are set pr. default this

		 	    * will reduce the possibilities of this jsp.

		 	    */


		 	    if (request.getParameter("SP_StartTime") != null) {

		 	       startTime = request.getParameter("SP_StartTime");

		 	       if (startTime != null)

		 	         startTime = formatTime(startTime);

		 	       serviceParameters.put("StartTime", startTime);

		 	     } else {

		 		startTime = null;

		 		endTime = null;

		 	        serviceParameters.put("StartTime", null);

		 	        serviceParameters.put("EndTime", null);

		 	     }


		 	   if (request.getParameter("SP_EndTime") != null) {

		 	       endTime = request.getParameter("SP_EndTime");

		 	       if (endTime != null)

		 	         endTime = formatTime(endTime);


		 	       serviceParameters.put("EndTime", endTime);

		 	     } else {

		 		endTime = null;

		 	        serviceParameters.put("EndTime", null);

		 	     }


		 	     if (isPeriodic) {

		 	        if (request.getParameter("SP_Period") != null) {

		 	          period = request.getParameter("SP_Period");

		 	          serviceParameters.put("Period", period);

		 	        }

		 	        if (request.getParameter("SP_Duration") != null) {

		 	          duration = request.getParameter("SP_Duration");

		 	          serviceParameters.put("Duration", duration);

		 	        }

		 	     } else {

		 	          serviceParameters.put("Period", null);

		 	          serviceParameters.put("Duration", null);

		 	     }


		 	    String addressFamily = (String) serviceParameters.get("AddressFamily");
		 	    request.setAttribute("AddressFamily",addressFamily);
		 	    
		 	    if (request.getParameter("SP_STATIC_Routes") != null) {

		 	         boolean exception = false;

		 	         Vector badIPs = new Vector();

		 	         int vector_count = 0;

		 	        String routes = request.getParameter("SP_STATIC_Routes");

		 	        saveAttributeForUndo(con, serviceid, "STATIC_Routes", serviceParameters);


		 	        if (request.getParameter("staticCounter") != null ) {

		 	            if (!routes.equalsIgnoreCase("")) {

		 	                routes += ",";

		 	            }

		 	            int staticCounter = Integer.parseInt(request.getParameter("staticCounter"));
		 	            request.setAttribute("staticCounter", String.valueOf(staticCounter));

		 	            

		 	           
		 	            for (int k = 0; k < staticCounter; k++) {

		 	                if (request.getParameter("routes"+k) != null && request.getParameter("masks"+k) != null) {
		 	                	
		 	                	String route = request.getParameter("routes" + k);
								String mask  = request.getParameter("masks" + k);
								String route_temp="";
								try{
									if (route != null && !route.equals("")) {
										IPAddressHelper.validateCIDRAddress(route +"/"+ mask , addressFamily);
										/***** new logic *****************/
										if(addressFamily.equalsIgnoreCase("IPv4")) {
										int V1= 32 -Integer.parseInt(mask);
										int n=2;
										long V2= (long)Math.pow(n,V1);
										int last_oct= Integer.parseInt(route.split("\\.")[3]);
										if(last_oct % V2 ==0)
										{
											System.out.print("Valid IP with respect to mask");
										}else
										{
											System.out.print("Not Valid IP with respect to mask");
																		
											request.setAttribute("Message", "IP Prefix does not match with Mask");
											error = true;											
								            throw new IllegalStateException("IP Prefix does not match with Mask");	
											
										}
										}

									}
								
	
			 	                    link_part += "&routes" + k + "=" + route;
	
			 	                    link_part += "&masks" + k + "=" + mask;
	
			 	                    routes += route;
	
			 	                    routes += "/";
		 	                    	routes += request.getParameter("masks" + k);
			 	                    
		 	                    	route_temp=route+"/"+request.getParameter("masks" + k);
		 	                    	StaticRoute beanRoute=StaticRoute.findByAttachmentidstaticrouteaddress(con, serviceid, route_temp);
		 	                    	if(beanRoute==null){
		 	                    	  beanRoute=new StaticRoute();
		 	                    	  beanRoute.setAttachmentid(serviceid);
		 	                    	  beanRoute.setStaticrouteaddress(route_temp);
		 	                    	  beanRoute.store(con);
		 	                    	}
			 	                    
			 	                    if (k < staticCounter - 1) {
	
			 	                        routes += ",";
	
			 	                    }
								}
								catch(Exception e){
									error = true;
									strMessage = e.getMessage();
						            throw new IllegalStateException(e);									
								}

		 	                }

		 	            }

		 	            link_part += "&staticCounter=" + (staticCounter-1);




		 	            if (!serviceParameters.containsKey("STATIC_Routes")) {

		 	                ServiceParameter staticRoutes = new ServiceParameter();

		 	                staticRoutes.setServiceid(serviceid);

		 	                staticRoutes.setAttribute("STATIC_Routes");

		 	                staticRoutes.setValue(routes);

		 	                staticRoutes.store(con);

		 	            }

		 	            serviceParameters.put("STATIC_Routes", routes);

		 	       }

		 	     }



		 	   if (request.getParameter("Remove_Static_Routes") != null) {

		 	       int index = 0;

		 	       String allRoutes = "";

		 	       String route;
		 	       String deleteroute="";
		 	     



		 	       while(request.getParameter("route" + index) != null) {

		 	         route = request.getParameter("route" + index);



		 	         // Only care about the route that has not been deleted!!!!!

		 	         if (request.getParameter("deleteCheckBox" + index) == null) {

		 	           allRoutes += route + ",";

		 	         }
		 	         else{//delete into bean staticRoute
		 	           StaticRoute beanRoute=StaticRoute.findByAttachmentidstaticrouteaddress(con, serviceid, route);
		 	           if(beanRoute!=null){
		 	            beanRoute.delete(con);
		 	           }
		 	         }

		 	         index++;

		 	       }



		 	       if (allRoutes.endsWith(",")) {

		 	         allRoutes = allRoutes.substring(0, allRoutes.length() - 1);

		 	       }



		 	       if (allRoutes != null) {

		 	         saveAttributeForUndo(con, serviceid, "STATIC_Routes", serviceParameters);

		 	         serviceParameters.put("STATIC_Routes", allRoutes);
		 	       }
		 	     }
				  if (request.getParameter("SP_PREFIX_Routes") != null) {
		 	         boolean exception = false;
		 	         Vector badIPs = new Vector();
		 	         int vector_count = 0;
		 	        String routes = request.getParameter("SP_PREFIX_Routes");
		 	        saveAttributeForUndo(con, serviceid, "PREFIX_Routes", serviceParameters);
		 	        if (request.getParameter("prefixCounter") != null ) {
		 	            if (!routes.equalsIgnoreCase("")) {
		 	                routes += ",";
		 	            }
		 	            int prefixCounter = Integer.parseInt(request.getParameter("prefixCounter"));
		 	            request.setAttribute("prefixCounter", String.valueOf(prefixCounter));
		 	            
		 	           
		 	            for (int k = 0; k < prefixCounter; k++) {
		 	                if (request.getParameter("routes"+k) != null && request.getParameter("masks"+k) != null) {
		 	                	
		 	                	String route = request.getParameter("routes" + k);
								String mask  = request.getParameter("masks" + k);
								String lemask = request.getParameter("lemask"+ k);
								try{
									if (route != null && !route.equals("")) {
										IPAddressHelper.validateCIDRAddress(route +"/"+ mask , addressFamily);
									}
			 	                    link_part += "&routes" + k + "=" + route;
	
			 	                    link_part += "&masks" + k + "=" + mask;
									if(lemask==null){lemask="";}
								    link_part += "&lemask" + k + "=" + lemask;
									
			 	                    routes += route;
			 	                    routes += "/";
		 	                    	routes += request.getParameter("masks" + k);
			 	                if(lemask!=null && !"".equals(lemask))
								{
								// append the le mask
								routes +=" le ";
								routes += request.getParameter("lemask" + k);
								}
			 	                    
			 	                    if (k < prefixCounter - 1) {
	
			 	                        routes += ",";
	
			 	                    }
								}
								catch(Exception e){
									error = true;
									strMessage = e.getMessage();
						            throw new IllegalStateException(e);									
								}
		 	                }
		 	            }
		 	            link_part += "&prefixCounter=" + (prefixCounter-1);
		 	            if (!serviceParameters.containsKey("PREFIX_Routes")) {
		 	                ServiceParameter prefixRoutes = new ServiceParameter();
		 	                prefixRoutes.setServiceid(serviceid);
		 	                prefixRoutes.setAttribute("PREFIX_Routes");
		 	                prefixRoutes.setValue(routes);
		 	                prefixRoutes.store(con);
		 	            }
		 	            serviceParameters.put("PREFIX_Routes", routes);
		 	       }
		 	     }
				 if (request.getParameter("Remove_Prefix_List") != null) {
		 	       int index = 0;
		 	       String allRoutes = "";
		 	       String route;
		 	       while(request.getParameter("route" + index) != null) {
		 	         route = request.getParameter("route" + index);
		 	         // Only care about the route that has not been deleted!!!!!
		 	         if (request.getParameter("deleteCheckBox" + index) == null) {
		 	           allRoutes += route + ",";
		 	         }
		 	         index++;
		 	       }
		 	       if (allRoutes.endsWith(",")) {
		 	         allRoutes = allRoutes.substring(0, allRoutes.length() - 1);
		 	       }
		 	       if (allRoutes != null) {
		 	         saveAttributeForUndo(con, serviceid, "PREFIX_Routes", serviceParameters);
		 	         serviceParameters.put("PREFIX_Routes", allRoutes);
		 	       }
		 	     }
		 	  if ((request.getParameter("SP_CAR") != null) && !modifyQoSBulk) {

		 	       if (serviceParameters.get("CAR") != null) {

					  //Added  to fix PR 10998 --Divya

					 saveAttributeForUndoPeriodic(con, serviceid, "Periodic_Org_CAR", serviceParameters);

		 	         saveAttributeForUndo(con, serviceid, "CAR", serviceParameters);

					// if(!isPeriodic)

		 	         serviceParameters.put("CAR", request.getParameter("SP_CAR"));

		 	      	 //ends here

		 	         String region = ServiceParameter.findByServiceidattribute( con, serviceid, "Region" ).getValue();

		 	         serviceParameters.put("Region", region);

		 	       } else {

		 	         throw new Exception("CAR not set for the selected service, cannot be modified.");

		 	       }

		 	     }



		      if (request.getParameter("SP_VPNTopology") != null) {

		          if (serviceParameters.get("VPNTopology") != null) {

		            saveAttributeForUndo(con, serviceid, "VPNTopology", serviceParameters);

		            serviceParameters.put("VPNTopology", request.getParameter("SP_VPNTopology"));

		          } else {

		            throw new Exception("VPNTopology not set for the selected service, cannot be modified.");

		          }

		        }



		      if (request.getParameter("SP_VPNLayerType") != null) {

		          if (serviceParameters.get("VPNLayerType") != null) {

		            saveAttributeForUndo(con, serviceid, "VPNLayerType", serviceParameters);

		            serviceParameters.put("VPNLayerType", request.getParameter("SP_VPNLayerType"));

		          } else {

		            throw new Exception("VPNLayerType not set for the selected service, cannot be modified.");

		          }

		        }



		      if ("ModifyQoS".equalsIgnoreCase(request.getParameter("action")) || "ModifyQoSProfile".equalsIgnoreCase(request.getParameter("action")) || "ModifyRateLimitInterface".equalsIgnoreCase(request.getParameter("action"))) {

		          String profile = request.getParameter("SP_QOS_PROFILE");

		          if(profile != null){

		            extractParameter(con, request, serviceParameters, serviceid, "QOS_BASE_PROFILE", "QoS Base Profile");

		            for(int i = 0; i < expMappingsCount; i++){

		              final String parameterName = "QOS_CLASS_"+expMappings[i].getPosition()+"_PERCENT";

		              final String parameter = request.getParameter("SP_"+parameterName);

		              serviceParameters.put(parameterName, parameter);

		              ServiceUtils.saveOrUpdateParameter(con, serviceid, parameterName, parameter);

		            }

		            extractParameter(con, request, serviceParameters, serviceid, "QOS_PROFILE", "QoS Profile");

		            extractParameter(con, request, serviceParameters, serviceid, "CAR", "Rate-limit", undoIndex++);

		          }

		        }



		      // Modify L2VPWS Rate-limit part

		      if("ModifyRateLimit".equals(request.getParameter("action"))){


		        String undoMode = request.getParameter(PARAMETER_UNDO_MODIFY);

		        String rateLimit = (String) serviceParameters.get("RL");

		        String oldRateLimit = (String) serviceParameters.get(Constants.PARAMETER_LAST_MODIFIED_VALUE);


		        if("true".equals(undoMode)){

		          saveAttributeForUndo(con, serviceid, "RL", serviceParameters);

		          serviceParameters.put("RL", oldRateLimit);

		        }

		        String siteAttachmentIdAEnd = (String)serviceParameters.get((String)Constants.SERVICE_PARAM_SITE_ATTACHMENT_ID_AEND);
		        String siteAttachmentIdZEnd = (String)serviceParameters.get((String)Constants.SERVICE_PARAM_SITE_ATTACHMENT_ID_ZEND);
		        aEndService = Service.findByServiceid(con, siteAttachmentIdAEnd);
		        zEndService = Service.findByServiceid(con, siteAttachmentIdZEnd);

		        String rateLimitParam = request.getParameter("SP_RL");

		        if (rateLimitParam != null) {

		          if (rateLimit != null) {

		            saveAttributeForUndo(con, serviceid, "RL", serviceParameters);

		            serviceParameters.put("RL", rateLimitParam);
		            ServiceUtils.saveOrUpdateParameter(con, siteAttachmentIdAEnd, "RL", rateLimitParam);
		            ServiceUtils.saveOrUpdateParameter(con, siteAttachmentIdZEnd, "RL", rateLimitParam);
		          } else {

		            throw new Exception("Rate-Limit not set for the selected service, cannot be modified.");

		          }

		        }

		      }
			  if(("ModifyLSPUsageMode".equals(request.getParameter("action")))&&("layer2-VPWS".equals(type)))
			  {
				String siteAttachmentIdAEnd = (String)serviceParameters.get((String)Constants.SERVICE_PARAM_SITE_ATTACHMENT_ID_AEND);
		        String siteAttachmentIdZEnd = (String)serviceParameters.get((String)Constants.SERVICE_PARAM_SITE_ATTACHMENT_ID_ZEND);
		        aEndService = Service.findByServiceid(con, siteAttachmentIdAEnd);
		        zEndService = Service.findByServiceid(con, siteAttachmentIdZEnd);
			  }
			  
		       Date startTimeDate = new Date();

		       Date endTimeDate = new Date();


			if((startTime !=null) && (endTime != null))

				{


		       startTimeDate = Constants.SCHEDULED_DATE_FORMAT.parse(startTime, new ParsePosition(0));

		       endTimeDate = Constants.SCHEDULED_DATE_FORMAT.parse(endTime, new ParsePosition(0));

			   if((endTimeDate.getTime() - startTimeDate.getTime()) <= 0 )

				   {


					strMessage = "EndTime must be later than StartTime";

		            throw new IllegalStateException("EndTime must be later than StartTime");

				   }

		     }

//		    If it's scheduled but not periodiodic modification then add Undo listener

		       // to change values when undo modification will occur

		       if ((endTime != null) && !isPeriodic &&

		           ("ModifyCAR".equalsIgnoreCase(request.getParameter("action"))  ||

		                   "ModifyRateLimit".equalsIgnoreCase(request.getParameter("action")) ||
		                   
		                   Constants.ACTION_MODIFY_QOSPROFILE.equalsIgnoreCase(request.getParameter("action")) ||

		                   "ModifyQoS".equalsIgnoreCase(request.getParameter("action")))) {

		               ServiceUtils.saveOrUpdateParameter(con, serviceid,  Constants.PARAMETER_LAST_COMMIT, UndoModifyListener.class.getName());

		       }



//		     SCHEDULED PARAMS PROCESSING

		       if (request.getParameter("state") != null) {

		           String state_inner = (String)request.getParameter("state");

		         if(isPeriodic)

		           state_inner = "Periodic_".concat(state_inner);

		         else if(startTime != null)

		              state_inner = "Sched_".concat(state_inner);

		          serviceParameters.put("state", state_inner);

		       }


		       if(isPeriodic){

		         // serviceParameters.remove("EndTime");

		         period = request.getParameter("SP_Period");

		         duration = formatTime(request.getParameter("SP_Duration"));


		         if(duration == null){
              strMessage = "Until date is incorrect";
		          throw new IllegalStateException("Until date is incorrect");
             }

		         Date durationDate = Constants.SCHEDULED_DATE_FORMAT.parse(duration, new ParsePosition(0));

		        /* Date startTimeDate = Constants.SCHEDULED_DATE_FORMAT.parse(startTime, new ParsePosition(0));

		         Date endTimeDate = Constants.SCHEDULED_DATE_FORMAT.parse(endTime, new ParsePosition(0));

				 */

		         if(startTimeDate == null)

				   {

					 strMessage = "StarTime is incorrect";

		          throw new IllegalStateException("StarTime is incorrect");

				   }


		         if(endTimeDate == null)

				   {

				  strMessage = "EndTime is incorrect";

		          throw new IllegalStateException("EndTime is incorrect");

				   }


		         if((endTimeDate.getTime() - startTimeDate.getTime()) <= 0 )

				   {

					strMessage = "EndTime must be later than StartTime";

		          throw new IllegalStateException("EndTime must be later than StartTime");

				   }


		         if(durationDate == null)

				   {

					strMessage = "Until date is incorrect";

		          throw new IllegalStateException("Until date is incorrect");

				   }


		         if(period == null)

				   {

					strMessage = "Repeat period is incorrect";

		          throw new IllegalStateException("Repeat period is incorrect");

				   }


		         if(durationDate.getTime() < endTimeDate.getTime())

				   {

					strMessage = "Until time must be later then EndTime";

		          throw new IllegalStateException("Until time must be later then EndTime");

				   }


		         GregorianCalendar calendar = new GregorianCalendar();

		         calendar.setTime(startTimeDate);

		          if ("5min".equals(period)) {

		            calendar.set(Calendar.MINUTE, calendar.get(Calendar.MINUTE) + 5);

		          } else if ("daily".equals(period)) {

		            calendar.set(Calendar.DATE, calendar.get(Calendar.DATE) + 1);

		          } else if ("weekly".equals(period)) {

		            calendar.set(Calendar.DATE, calendar.get(Calendar.DATE) + 7);

		          } else if ("monthly".equals(period)) {

		            calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH) + 1);

		          } else{
                strMessage = "Repeat period is unsupportable";
		            throw new IllegalStateException("Repeat period is unsupportable");
              }
		         // if startTime + period < endTime then the period is wrong

		          if(calendar.getTimeInMillis() < endTimeDate.getTime()){

               // strMessage = "Until time must be later then EndTime";
                 strMessage = "Repeat period is too small";
		            throw new IllegalStateException("Repeat period is too small");
		          }

		       }


		       if (request.getParameter("SP_Activation_Scope") != null) {

		           if (serviceParameters.get("Activation_Scope") != null) {

		             serviceParameters.put("Activation_Scope", request.getParameter("SP_Activation_Scope"));

		           } else {

		             throw new Exception("Activation Scope not set for the selected service.");

		           }

		         }
		       
		         if ( request.getParameter("ce_action") != null) {

		             serviceParameters.put("hidden_activate_CE", request.getParameter("ce_action"));
		             ServiceUtils.saveOrUpdateParameter(con, serviceid, "hidden_activate_CE", request.getParameter("ce_action"));

		           }
		         if(request.getParameter("next_state") != null){
		        	 serviceParameters.put("hidden_next_state", request.getParameter("next_state"));
		        	 ServiceUtils.saveOrUpdateParameter(con, serviceid, "hidden_next_state", request.getParameter("next_state"));
		         }
       



               ServiceUtils.saveOrUpdateParameter(con, serviceid, "hidden_attachmentid", attachmentid); //added by tanye



		       if ("ModifyConnectivityType".equalsIgnoreCase(request.getParameter("action"))) {



		           String newConnectivity = request.getParameter("SP_ConnectivityType");

                   siteServiceId = attachService.getParentserviceid();
		           //String vpnId = request.getParameter("VPNid");

				    String vpnId = request.getParameter("connTypeVPNId");

		           String oldConnectivity;

		           VPNMembership membership;






		           // if it is resend request

		           if(vpnId == null && newConnectivity == null){
		
		             vpnId = ServiceParameter.findByServiceidattribute(con, serviceid, Constants.PARAMETER_MODIFIED_VPN_ID).getValue();

		             newConnectivity = VPNMembership.findByVpnidsiteattachmentid(con, vpnId, attachmentid).getConnectivitytype(); // modified by tanye

		           }else{

		             membership = VPNMembership.findByVpnidsiteattachmentid(con, vpnId, attachmentid); // modified by tanye

		             oldConnectivity = membership.getConnectivitytype();


		             membership.setConnectivitytype(newConnectivity);

		             membership.update(con);


		             ServiceUtils.saveOrUpdateParameter(con, serviceid, Constants.PARAMETER_MODIFIED_VPN_ID, vpnId);

		             ServiceUtils.saveOrUpdateParameter(con, serviceid, Constants.PARAMETER_LAST_UNDO, ModifyConnectivityListener.class.getName());

		             ServiceUtils.saveOrUpdateParameter(con, serviceid, Constants.PARAMETER_OLD_CONNECTIVITY, oldConnectivity);


		           }





		           ServiceParameter old_con_type  = ServiceParameter.findByServiceidattribute(con, serviceid, Constants.PARAMETER_OLD_CONNECTIVITY);

		           ServiceParameter modified_vpnid = ServiceParameter.findByServiceidattribute(con, serviceid, Constants.PARAMETER_MODIFIED_VPN_ID);

		           logger.debug("parameter = " + old_con_type);

		           logger.debug("parameter = " + modified_vpnid);

		           String undo_partial_modify = request.getParameter(PARAMETER_UNDO_MODIFY);

		           if("true".equals(undo_partial_modify) && old_con_type != null && modified_vpnid != null ){

		        	 logger.debug("Undo flow for Conenctivity type modification. Params are  " + old_con_type.getValue()+ ":"+modified_vpnid.getValue());

		             serviceParameters.put("ConnectivityType", old_con_type.getValue());

			         serviceParameters.put("VPNid", modified_vpnid.getValue());

			         ServiceUtils.updateSubServicesParam(con,serviceid,"ConnectivityType" ,old_con_type.getValue());

		           }else{

		        	   logger.debug("Do or resend flow  for Conenctivity type modification. Params are  " + newConnectivity+ ":"+vpnId);

		        	   serviceParameters.put("ConnectivityType", newConnectivity);

				       serviceParameters.put("VPNid", vpnId);

				       ServiceUtils.updateSubServicesParam(con,serviceid,"ConnectivityType" ,newConnectivity);

		           }

		           serviceParameters.remove(Constants.PARAMETER_MODIFIED_VPN_ID);

		           serviceParameters.remove(Constants.PARAMETER_LAST_UNDO);

		           serviceParameters.remove(Constants.PARAMETER_OLD_CONNECTIVITY);

		         }



		       /*

		        *

		        * * adding VPN_Membership bean. if modification will fail,

		        *  then in undo section this bean will be deleted

                */

     if(Constants.ACTION_JOIN_VPN.equalsIgnoreCase(request.getParameter("action"))){

         String vpnId = request.getParameter("vpnId");

         String connectivityType = request.getParameter("connectivity");

         final String confirmId = request.getParameter("newServiceId");

         final String storedVPNId = (String) serviceParameters.get("hidden_vpnId");

         final VPNMembership membership;


         // if it is resend action then there aren't any vpnId and connectivityType parameters

         if(vpnId == null && connectivityType == null){
             if(storedVPNId == null)

                throw new IllegalStateException("not enougth parameters to send request");

             vpnId = storedVPNId;

             membership = VPNMembership.findByVpnidsiteattachmentid(con, vpnId, attachmentid); // modified by tanye

             connectivityType = membership.getConnectivitytype();

         }else{

           // modified by tanye
        	 siteServiceId = attachService.getParentserviceid();
             Service[] attachs = Service.findByParentserviceid(con, siteServiceId);

             for (Service attach : attachs) {

               VPNMembership old = VPNMembership.findByVpnidsiteattachmentid(con, parentserviceid, attach.getServiceid());
               if (old != null) {

                 old.setVpnid(vpnId);

                 old.setConnectivitytype(connectivityType);

                 old.store(con);

               }

             }

             //membership = new VPNMembership(vpnId, attachmentid, connectivityType);

             //membership.store(con);

             ServiceParameter parameter = new ServiceParameter(serviceid, "hidden_vpnId", vpnId );


             if(serviceParameters.containsKey("hidden_vpnId"))

                 parameter.update(con);

             else

                 parameter.store(con);

         }

         if(confirmId != null){

            ServiceUtils.saveOrUpdateParameter(con, serviceid, "confirmId", confirmId);

         }

         serviceParameters.put("vpnId", vpnId);

         serviceParameters.put("attachmentid", attachmentid);

         serviceParameters.put("connectivity", connectivityType);

         serviceParameters.put("confirmId", confirmId);


     }

     if(Constants.ACTION_LEAVE_VPN.equalsIgnoreCase(request.getParameter("action"))){

         String vpnId = request.getParameter("vpnId");

         ServiceParameter hidenVPNParameter = ServiceParameter.findByServiceidattribute(con, serviceid, "hidden_vpnId" );

         // if vpnId is null then it is resend request

         if(vpnId == null){

             if(hidenVPNParameter == null)

                 throw new IllegalStateException("not enougth parameters to send request");

             vpnId = hidenVPNParameter.getValue();

         }else{

             if(hidenVPNParameter == null){

                 new ServiceParameter(serviceid, "hidden_vpnId", vpnId ).store(con);

             }else{

                 hidenVPNParameter.setValue(vpnId);

                 hidenVPNParameter.update(con);

             }

         }
		//added for PR 15838 by Divya
		VPNMembership membership = VPNMembership.findByVpnidsiteattachmentid(con, vpnId, attachmentid);
        String connectivityType = membership.getConnectivitytype();
		//Ends here

		serviceParameters.put("vpnId", vpnId);

       serviceParameters.remove("hidden_vpnId");
	   serviceParameters.put("connectivity", connectivityType);


       ServiceUtils.saveOrUpdateParameter(con, serviceid, Constants.PARAMETER_LAST_COMMIT, LeaveVPNStateListener.class.getName());

       serviceParameters.remove(Constants.PARAMETER_LAST_COMMIT);



     }



     if("ModifyMulticast".equals(request.getParameter("action"))){


         final String PARAMETER_MULTICAST_STATUS = "MulticastStatus";
		 
		 String newStatus = request.getParameter(PARAMETER_MULTICAST_STATUS);
		 
		 serviceParameters.put(PARAMETER_MULTICAST_STATUS, newStatus);

       /*  final String PARAMETER_MULTICAST_MODE = "MulticastMode";

         final String PARAMETER_MULTICAST_ID = "MulticastVPNId";

         final String PARAMETER_MULTICAST_RP = "MulticastRP";

         final String PARAMETER_MULTICAST_QOS_CLASS = "MulticastQoSClass";

         final String PARAMETER_MULTICAST_RATE_LIMIT = "MulticastRateLimit"; 


         final String oldStatus = (String) serviceParameters.get(PARAMETER_MULTICAST_STATUS);

         String newStatus = request.getParameter(PARAMETER_MULTICAST_STATUS);

         String multicastMode = request.getParameter("SP_"+PARAMETER_MULTICAST_MODE);

         String switchMulticast = request.getParameter(PARAMETER_UNDO_MODIFY);

         if("true".equals(switchMulticast) && oldStatus != null){

           newStatus = oldStatus.equals("enabled") ? "disabled" : "enabled";

         }


         // if it is not just resent modify request

         if(newStatus != null){


           // save multicast status if it wasn't saved yet in service parameters

           if(oldStatus == null){

            ServiceParameter parameter = new ServiceParameter(serviceid, PARAMETER_MULTICAST_STATUS, "disabled");

            parameter.store(con);

            serviceParameters.put(PARAMETER_MULTICAST_STATUS, oldStatus);

           }



           saveAttributeForUndo(con, serviceid, PARAMETER_MULTICAST_STATUS, serviceParameters);


           if(newStatus != null)

            serviceParameters.put(PARAMETER_MULTICAST_STATUS, newStatus);





           String multicastId = (String) serviceParameters.get(PARAMETER_MULTICAST_ID);

           String serviceType = service.getType();



           if("layer3-VPN".equals(serviceType)){

            // generate id for a multicast VPN

              if(multicastId == null){

                 idGenerator = new IdGenerator(con);

                multicastId = idGenerator.getServiceId();

                ServiceParameter parameter = new ServiceParameter(serviceid, PARAMETER_MULTICAST_ID, multicastId);

                parameter.store(con);

                serviceParameters.put(PARAMETER_MULTICAST_ID, multicastId);

             }

             if(multicastMode != null){

               ServiceUtils.saveOrUpdateParameter(con, serviceid, PARAMETER_MULTICAST_MODE, multicastMode);

               serviceParameters.put(PARAMETER_MULTICAST_MODE, multicastMode);



             }



           }else if ("layer3-Attachment".equals(serviceType)){ // Modified by tanye

              serviceParameters.put("attachmentid", attachmentid);



              final String multicastParameter = request.getParameter(PARAMETER_MULTICAST_ID);


              if(multicastParameter != null){

                // save multicast VPN id if it wasn't saved yet in site parameters

                if(multicastId == null){

                   ServiceParameter parameter = new ServiceParameter(serviceid, PARAMETER_MULTICAST_ID, multicastParameter);

                   parameter.store(con);

                }

                serviceParameters.put(PARAMETER_MULTICAST_ID, multicastParameter);

              }


              final String rpParameter = request.getParameter(PARAMETER_MULTICAST_RP);


              if(rpParameter != null){

                if(serviceParameters.get(PARAMETER_MULTICAST_RP) == null){

                 // new ServiceParameter(serviceid, PARAMETER_MULTICAST_RP, rpParameter).store(con);
				 ServiceUtils.saveOrUpdateParameter(con, serviceid , PARAMETER_MULTICAST_RP, rpParameter);

                }

                serviceParameters.put(PARAMETER_MULTICAST_RP, rpParameter);

              }


             final String qosParameter = request.getParameter(PARAMETER_MULTICAST_QOS_CLASS);

             if(qosParameter != null){

               if(serviceParameters.get(PARAMETER_MULTICAST_QOS_CLASS) == null){

                ServiceUtils.saveOrUpdateParameter(con, serviceid , PARAMETER_MULTICAST_QOS_CLASS, qosParameter);

               }

               serviceParameters.put(PARAMETER_MULTICAST_QOS_CLASS, qosParameter);

             }


             final String rateLimitParameter = request.getParameter(PARAMETER_MULTICAST_RATE_LIMIT);

             if(rateLimitParameter != null){

               if(!serviceParameters.containsKey(PARAMETER_MULTICAST_RATE_LIMIT)){

               //  new ServiceParameter(serviceid, PARAMETER_MULTICAST_RATE_LIMIT, rateLimitParameter).store(con);
			   ServiceUtils.saveOrUpdateParameter(con, serviceid , PARAMETER_MULTICAST_RATE_LIMIT, rateLimitParameter);

               }

               serviceParameters.put(PARAMETER_MULTICAST_RATE_LIMIT, rateLimitParameter);

             }

           }else throw new IllegalStateException("wrong service type[" + serviceType + "] when modifying multicast");

         }*/



       }



     // Save state for later undo

     lastState = service.getState();

     // State needs to be set before sending to SA to avoid race condition!

	 //Added if null check for PR-17694

    if (serviceParameters.get("state")== null || serviceParameters.get("state") == "") {

    	 service.setState(lastState);

     }else{
		service.setState((String) serviceParameters.get("state"));
	}

     ServiceUtils.updateService(con, service);
     
     
     
     if (isL3AttachmentRequest && protectionService !=  null && (Constants.ACTION_JOINVPN.equals(serviceParameters.get("ACTION")) 
    		 || Constants.ACTION_LEAVEVPN.equals(serviceParameters.get("ACTION")) 
    		 || Constants.ACTION_MODIFYMULTICAST.equals(serviceParameters.get("ACTION")) 
    		 || Constants.ACTION_MODIFYCONNECTIVITYTYPE.equals(serviceParameters.get("ACTION")) )){
    	 protectionService.setState((String)serviceParameters.get("state"));
    	 ServiceUtils.updateService(con, protectionService);
    	 ServiceUtils.saveOrUpdateParameter(con,serviceid,"protectionAttachmentId",protectionAttachmentId);

     }
     if("ModifyRateLimit".equals(request.getParameter("action"))){
    	 aEndService.setState((String)serviceParameters.get("state"));
    	 zEndService.setState((String)serviceParameters.get("state"));
    	 ServiceUtils.updateService(con, aEndService);
    	 ServiceUtils.updateService(con, zEndService);
     }
	 
	 if(("ModifyLSPUsageMode".equals(request.getParameter("action")))&&("layer2-VPWS".equals(type)))
	 {
		 aEndService.setState((String)serviceParameters.get("state"));
    	 zEndService.setState((String)serviceParameters.get("state"));
    	 ServiceUtils.updateService(con, aEndService);
    	 ServiceUtils.updateService(con, zEndService);
	 }


     // Prepare message to SA: Have to change serviceType without updating db!!! Hack!!!

       String Old_serviceType = null;

       if (serviceParameters.get("type") != null) {

         String serviceType = (String)serviceParameters.get("type");

         Old_serviceType = serviceType;

         serviceParameters.put("type", serviceType);

       }

     // set skip_activation value

     serviceParameters.put("skip_activation", session.getAttribute("SKIP_ACTIVATION"));


	//


	String attachmentParentId = null;
	if("layer3-Attachment".equals(service.getType())||"GIS-Attachment".equals(service.getType()) || "layer2-Attachment".equals(service.getType()) || "layer3-Protection".equals(service.getType()))
	{

		final VPNMembership[] attachMems =

		VPNMembership.findBySiteattachmentid(con, attachmentid); // modified by tanye

		if(attachMems != null && attachMems.length > 0)

		{

			attachmentParentId = attachMems[0].getVpnid();

		}

		serviceParameters.put("vpnserviceid", attachmentParentId);

		serviceParameters.put("protectionAttachmentId", protectionAttachmentId);

        serviceParameters.put("parentserviceid", service.getParentserviceid()); //added by jacqie

       /**jacqie PR 15353 BEGIN*/

        if(modifySelection!=null && modifySelection.equals("resend_modify")){

          ServiceParameter lastModifyAction = ServiceParameter.findByServiceidattribute(con, serviceid, "hidden_LastModifyAction");

          serviceParameters.put("ACTION", lastModifyAction.getValue());

        }

        /**jacqie PR 15353 END*/
        if ( ((String)serviceParameters.get("ACTION")).equals(Constants.ACTION_CREATE) ) {
            serviceParameters.put("ACTION", Constants.ACTION_ADD);
        }
        serviceParameters.put(Constants.XSLPARAM_ADDRESS_TYPE, Constants.IP_ADDR_V4);
	}



	/*if("layer2-Attachment".equals(service.getType()))

	{

		Service Ataparentservice = Service.findByPrimaryKey(con, service.getParentserviceid());

		attachmentParentId = Ataparentservice.getParentserviceid();

		serviceParameters.put("vpnserviceid", attachmentParentId);

	}*/


	/*
		Static routes:
		are directly compound from database because with a big amount of static routes the XSLTransformHelper.transformXML launch error
		the following string are replaced in SendXML after transformXML:
		##nl## -> is \n
		##lt## -> is <
		##gt## -> is >
	*/
	StaticRoute staticRoutes[] = StaticRoute.findByAttachmentid(con, serviceid);
	String staticRoutesXml = "##nl##          ";
	if (staticRoutes != null) {
		for (int i = 0; i < staticRoutes.length; i++) {
		  staticRoutesXml += "  ##lt##Static_route##gt##" + staticRoutes[i].getStaticrouteaddress() + "##lt##/Static_route##gt####nl##          ";
		}
		
		
		
		serviceParameters.put("STATIC_Routes", staticRoutesXml);
	}
	else
	{
		serviceParameters.put("STATIC_Routes", "");
	}
	

     // Send message to SA.

     SendXML sender = new SendXML(serviceParameters);

     sender.Init();

     sender.Send();

     // Restore old serviceType before update!! Hack!!

     serviceParameters.put("type", Old_serviceType);


     // Remove unnecessary parameters !!Hack!!

     serviceParameters.remove("vpnId");

     serviceParameters.remove("connectivity");
    // Hack again for hidden_vpnId PR15163 and PR15325
     serviceParameters.remove("hidden_vpnId");

     // Store all necessary service parameters. If nothing has changed then nothing is changed.

     service.setSubmitdate((String)serviceParameters.get("submitdate"));

     service.setModifydate((String)serviceParameters.get("modifydate"));

     String param_type = (String) serviceParameters.get("type");

     if ("layer2-Site".equals(param_type)) {

       service.setType("Site");

     } else {

//       service.setType((String)serviceParameters.get("type"));

     }


     // Store data in the DB.

     ServiceUtils.updateService(con, service);


     ServiceParameter[] serviceParamArray = ServiceParameter.findByServiceid(con, serviceid);


     // Save service parameters.

     if (serviceParamArray != null) {

       for (int i = 0; i < serviceParamArray.length; i++) {

           String temp = serviceParamArray[i].getAttribute();

         if (serviceParameters.containsKey(serviceParamArray[i].getAttribute())) {

             if(!temp.equalsIgnoreCase("StartTime") && !temp.equalsIgnoreCase("EndTime")){

                serviceParamArray[i].setValue((String)serviceParameters.get(serviceParamArray[i].getAttribute()));

                serviceParamArray[i].update(con);

             }

         }

       }

     }

     // if this is periodic modify action

     if(isPeriodic){

       ServiceUtils.saveOrUpdateParameter(con, serviceid, "StartTime", startTime);

       ServiceUtils.saveOrUpdateParameter(con, serviceid, "EndTime", endTime);

       period = request.getParameter("SP_Period");

       duration = formatTime(request.getParameter("SP_Duration"));

	  //Added  to fix PR 10998 --Divya

	   if(request.getParameter("SP_CAR")!=null)

			   ServiceUtils.saveOrUpdateParameter(con, serviceid, "Periodic_car",request.getParameter("SP_CAR"));

	    ServiceUtils.saveOrUpdateParameter(con, serviceid,  Constants.PARAMETER_PERIODIC_ACTION, UndoPeriodicScheduleListener.class.getName());

      //ends here

       ServiceUtils.saveOrUpdateParameter(con, serviceid, "hidden_PeriodicAction", request.getParameter("action"));

       ServiceUtils.saveOrUpdateParameter(con, serviceid, "Period", period);

       ServiceUtils.saveOrUpdateParameter(con, serviceid, "Duration", duration);


     }



		//findallservices action code here
	}
          catch(SQLException se)
            {
              error = true;
              if(se.getMessage().startsWith("ORA-02291")){
                //parent service deleted
                logger.debug("Parent service deleted: " , se);
                request.setAttribute("errormessage","Parent service deleted");

              }else{
                logger.debug("Database Connection errors: " , se);
                request.setAttribute("errormessage","Database Connection Error!");
              }
            }
            catch (IOException ie) {
              error = true;
              logger.error("Modify service Action class errors: ", ie);
              request.setAttribute("errormessage", ie.getMessage());
              if (service != null) {
                service.setState("Modify_Failure");

                try {
                  ServiceUtils.updateService(con, service);
                  ServiceUtils.saveOrUpdateParameter(con, service.getServiceid(), "Failure_Description", ie.getMessage());
                } catch (Exception excep) {
                  logger.error("Could not set the service state upon failure, " + "portal and SA might be inconsistent.");
                }
                 }
            }
		 	catch(Exception ex)

		 	{

		 		 error = true;

		 		ex.printStackTrace();

		 		 logger.error("Exception in ModifyService Action"+ex);
		 		// request.setAttribute("message", ex.getMessage());


            //		 		 reset state on failure

		 		  if (lastState != null && !lastState.equals(""))

		 		  {

		 		     service.setState(lastState);

		 		     ServiceUtils.updateService(con, service);

		 		  }

		 		if (request.getParameter("SP_STATIC_Routes") == null)

		 		{

		 			//return to find all services

		 		}

		 		else{

		 		    String exception = ex.toString();

		 		    String[] result = exception.split(":");

		 		    if (result[1] != null)

		 		            exception = result[1];

		 		   link_part = "";

		 		   //return to modifyserviceform with action=AddStaticRoutes



		 		    }

		 	}finally

		 	{

		         // close the connection

		        dbp.releaseConnection(con);

		 	}



		 	ListServicesAction allServices = new ListServicesAction();



	      //Forward Action

	      if(!(error))

	       {
	    	  ActionForward actionforward = null;

	    	  if(searchSite!=null && !searchSite.equals("") && !searchSite.equals("null")){ 
	    	        if (siteidSearch != null){
	    	          ((ServiceForm)form).setServiceid(siteidSearch);
	    	        }
	    	        SiteSearchAction siteSearchAction = new SiteSearchAction();
	    	        actionforward = siteSearchAction.execute(mapping, form, request, response);
	    	        actionforward =
	    	            new ActionForward("/jsp/FindSearchServices.jsp");

	    	      }
	    	      else {
	    	        actionforward = allServices.execute(mapping, form, request, response);
	    		actionforward =

         			 new ActionForward("/jsp/FindAllServices.jsp");
	    	      }
	    		return  actionforward;

	       }

	       else

	       {

//	    	 when error exists

          	 if(formAction.equals("CommitModifyService")||

       			    formAction.equals("CommitModifyService.do"))

       	         {

          		request.setAttribute("Message", strMessage);

          		logger.debug("ModifyServiceAction:::::::::forwarding to modify service form due to error");

          		 ActionForward actionforward =

          			 new ActionForward("/jsp/ModifyServiceForm.jsp");

          		 return  actionforward;



       	         }

       	        else

       	         {





  	            return mapping.findForward(Constants.FAILURE);

  	             }

	       }



	   	 }



	 void saveAttributeForUndo(Connection con, String serviceid, String attribute, HashMap serviceParameters, int id) throws SQLException{

	     final ServiceParameter modifiedServiceParameter = ServiceParameter.findByServiceidattribute(con, serviceid, attribute);


	     final String index = id < 0 ? "" : String.valueOf(id);

	     final String ATTRIBUTE_NAME = Constants.PARAMETER_LAST_MODIFIED  + index;

	     final String ATTRIBUTE_VALUE = Constants.PARAMETER_LAST_MODIFIED_VALUE + index;


	     /*

	      If there is undo attribute with the bigger index from the previous modification it should be deleted in order to prevent its restoration

	      when the undo will happen.

	     */

	     //int nextId = id + 1;

	     id++;

	     final String nextIndex = id < 0 ? "" : String.valueOf(id);

	     final String NEXT_ATTRIBUTE_NAME = Constants.PARAMETER_LAST_MODIFIED + nextIndex;

	     ServiceParameter nextAttribute = new ServiceParameter(serviceid, NEXT_ATTRIBUTE_NAME, "");

	     try{

	        nextAttribute.delete(con);

	     }catch(SQLException ex){

	       // don't care if attribute have existed before deletion

	     }




	     String value = null;


	     if (modifiedServiceParameter != null) {

	       value = modifiedServiceParameter.getValue();

	     } else {

	       // If the service parameter does not exists, then the undo action is to remove it again. This will be done in the undoModify jsp

	       // if the ##REMOVE_IT## value is set in value!!!!

	       value = "##REMOVE_IT##";

	     }



	    ServiceParameter lastModifiedAttribute = ServiceParameter.findByServiceidattribute(con, serviceid, ATTRIBUTE_NAME);

	     if(lastModifiedAttribute == null) {

	       lastModifiedAttribute = new ServiceParameter();

	       lastModifiedAttribute.setServiceid(serviceid);

	       lastModifiedAttribute.setAttribute(ATTRIBUTE_NAME);

	       lastModifiedAttribute.setValue(attribute);

	       lastModifiedAttribute.store(con);

	     } else {

	       serviceParameters.put(ATTRIBUTE_NAME, attribute);

	     }


	    ServiceParameter lastModifiedAttributeValue = ServiceParameter.findByServiceidattribute(con, serviceid, ATTRIBUTE_VALUE);

	     if(lastModifiedAttributeValue == null) {

	       lastModifiedAttributeValue = new ServiceParameter();

	       lastModifiedAttributeValue.setServiceid(serviceid);

	       lastModifiedAttributeValue.setAttribute(ATTRIBUTE_VALUE);

	       lastModifiedAttributeValue.setValue(value);

	       lastModifiedAttributeValue.store(con);

	     } else {

	       serviceParameters.put(ATTRIBUTE_VALUE, value);

	     }



	  }

	  void saveAttributeForUndo(Connection con, String serviceid, String attribute, HashMap serviceParameters) throws SQLException{

	    saveAttributeForUndo(con, serviceid, attribute, serviceParameters, -1);

	  }



		  //Added  to fix PR 10998 --Divya

		void saveAttributeForUndoPeriodic(Connection con, String serviceid, String attribute, HashMap serviceParameters) throws SQLException

		{



		  final ServiceParameter modifiedServiceParameter = ServiceParameter.findByServiceidattribute(con, serviceid, "CAR");

			ServiceParameter lastModifiedAttribute = ServiceParameter.findByServiceidattribute(con, serviceid, attribute);

	     if(lastModifiedAttribute == null) {

	   		ServiceParameter lastModifiedCarAttribute = new ServiceParameter();

			   lastModifiedCarAttribute.setServiceid(serviceid);

			   lastModifiedCarAttribute.setAttribute(attribute);

			   lastModifiedCarAttribute.setValue(modifiedServiceParameter.getValue());

			   lastModifiedCarAttribute.store(con);

		 }

		else {

	       serviceParameters.put(attribute, modifiedServiceParameter.getValue());

	     }


			serviceParameters.put("CAR", modifiedServiceParameter.getValue());

		 }


		 //ends here
	  void extractParameter(Connection connection, HttpServletRequest request, HashMap serviceParameters, String serviceId, String parameterName, String parameterDescription) throws Exception{
	    extractParameter(connection, request, serviceParameters, serviceId, parameterName, parameterDescription, -1);

	  }

	  void extractParameter(Connection connection, HttpServletRequest request, HashMap serviceParameters,

	                        String serviceId, String parameterName, String parameterDescription, int index) throws Exception{

	      final String parameter = request.getParameter("SP_"+parameterName);

	      if (parameter != null) {

	          if (serviceParameters.get(parameterName) != null) {

	              saveAttributeForUndo(connection, serviceId, parameterName, serviceParameters, index);

	              serviceParameters.put(parameterName, parameter);

	          } else {

	              throw new Exception(parameterDescription +" not set for the selected service, cannot be modified.");

	          }

	      }

	  }



      private String getParentType(Connection con, String siteid) throws SQLException

      {

        logger.debug("ModifyServiceAction getParentType siteid: " + siteid);

        Service vpn = Service.findByServiceid(con, siteid);

        String paraentType = (vpn == null) ? "" : vpn.getType();

        logger.debug("ModifyServiceAction parentType: " + paraentType);


        return paraentType;

      }



	  private String getRealType(String dbtype, Connection con, String parentid) throws Exception {

        logger.debug("ModifyServiceAction getRealType parentid: " + parentid);

        if ("Site".equals(dbtype)) {

          if (parentid == null)

            return dbtype;

          Service vpn = Service.findByServiceid(con, parentid);

          if (vpn != null) {

            if ("layer2-VPN".equals(vpn.getType())) {

              logger.debug("RealType: layer2-Site" );

              return "layer2-Site";

            } else if ("layer3-VPN".equals(vpn.getType())) {

              logger.debug("RealType: layer3-Site" );

              return "layer3-Site";

            }

          }

        }

        logger.debug("RealType: " + dbtype);

        return dbtype;

      }



	  private static String formatTime(String schedulationTime){

	        java.util.Date startingTime = null;

	        final Date currentDate = new Date();

	        String result =null;

	        final SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy.MM.dd");

	        final SimpleDateFormat sdf3 = new SimpleDateFormat("HH:mm");

	        final SimpleDateFormat sdf4 = new SimpleDateFormat("dd HH");

	        final SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy.MM");


	        startingTime = Constants.SCHEDULED_DATE_FORMAT.parse(schedulationTime, new java.text.ParsePosition(0));


	        if(startingTime == null){

	            startingTime = sdf2.parse(schedulationTime, new java.text.ParsePosition(0));

	            if (startingTime != null){

	                result = schedulationTime.trim().concat(" 00:00");

	            } else {

	                startingTime = sdf3.parse(schedulationTime, new java.text.ParsePosition(0));

	                if(startingTime != null){

	                    result = sdf2.format(currentDate).concat(" "+schedulationTime.trim());

	                }

	                else{

	                    startingTime = sdf4.parse(schedulationTime, new java.text.ParsePosition(0));

	                    if(startingTime != null){

	                        result = sdf5.format(currentDate).concat("."+schedulationTime.trim()).concat(":00");

	                    }

	                }

	            }

	        }else

	          result = schedulationTime;


	      return result;

	  }


}

