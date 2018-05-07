/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */


package com.hp.ov.activator.crmportal.action;
import java.sql.*;
import java.util.*;

import javax.servlet.http.*;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;
import com.hp.ov.activator.crmportal.common.*;
import com.hp.ov.activator.crmportal.helpers.ServiceUtils;
import com.hp.ov.activator.crmportal.bean.*;
import com.hp.ov.activator.vpn.IPAddressHelper.IPAddressHelper;

public class PreEditServiceAction extends Action{
	
	public PreEditServiceAction() 
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
		  String whereForRate = "RateLimitName != 'Unknown'";

	       //logger.debug("++++++++++++++++++++++++++++++++++++++++++++++");
	      String customerid = request.getParameter("customerid");
		  //logger.debug("ACTION CLASS ==customerid"+customerid);

	      String type = request.getParameter ("type");
          
		 logger.debug("ACTION CLASS ==type"+type);

	      HashMap serviceParameters = new HashMap ();
	      HashMap parentServiceParameters = new HashMap ();
	      
	      String searchSite=request.getParameter("searchSite");
	      request.setAttribute("searchSite", searchSite);
	      String siteidSearch = request.getParameter("siteidSearch");
	      request.setAttribute("siteidSearch", siteidSearch);

	      String serviceid = request.getParameter ("serviceid");
		   logger.debug("ACTION CLASS ==serviceid"+serviceid);

	      String parentserviceid = request.getParameter ("parentserviceid");
          logger.debug("ACTION CLASS ==parentserviceid"+parentserviceid);
          
          // added by tanye
          String attachmentid = request.getParameter ("attachmentid");
          request.setAttribute("attachmentid", attachmentid);
          logger.debug("PreEditServiceACTION CLASS ==attachmentid"+attachmentid);

	      String modifySelection = request.getParameter("action");
	      logger.debug("ACTION CLASS == modifySelection/action =="+modifySelection);
	      if(modifySelection==null)
			{
	    	  modifySelection= ((ServiceForm)form).getActionflag();
	          logger.debug("ACTION CLASS == " +
	      		             "modifySelection thru actionflag =="+modifySelection);
	      }
	      
	      String formAction = request.getParameter ("actionType");
	      if(formAction == null){formAction = "ModifyService";}
	       logger.debug("ACTION CLASS == formAction =="+formAction);

//richa - 11687
			 String mv = request.getParameter("mv");
		   if(mv==null){
              mv = ((ServiceForm)form).getMv();  
		   }

		  String currentPageNo = request.getParameter("currentPageNo");
		   if(currentPageNo==null){
              currentPageNo =((ServiceForm)form).getCurrentPageNo();
		   }

		  String viewPageNo = request.getParameter("viewPageNo");
		   if(viewPageNo==null){
              viewPageNo =((ServiceForm)form).getViewPageNo();
		   }


		   request.setAttribute("mv",mv);
		  ((ServiceForm)form).setMv(mv);
	 	  request.setAttribute("currentPageNo",currentPageNo);
		  ((ServiceForm)form).setCurrentPageNo(currentPageNo);
	      request.setAttribute("viewPageNo",viewPageNo);
		  ((ServiceForm)form).setViewPageNo(viewPageNo);


//richa - 11687



	      Customer customer = null;
	      String messageid = null;
	      
	      String SP_QoSChildEnabled = null;
	      
	      // Get database connection from session
		  HttpSession session = request.getSession();
		  dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
			
		
		  try
		  	{
		  		
		  		con = (Connection) dbp.getConnection();
				IdGenerator idGenerator = new IdGenerator(con);

		  		((ServiceForm)form).setCustomerid(customerid);
		  		((ServiceForm)form).setType(type);
		  			  		
		  		customer = (Customer) Customer.findByPrimaryKey(con,customerid);
		  		((ServiceForm)form).setCustomer(customer);

				  // logger.debug("ACTION CLASS ==customer obj"+customer);	  	    
		  	  	    	
		    	if (serviceid != null && !serviceid.equals(""))
		    	{
		    	   Service service = Service.findByPrimaryKey(con, serviceid);
		    	   ((ServiceForm)form).setService(service);
				   ((ServiceForm)form).setServiceid(serviceid);

				  // logger.debug("ACTION CLASS ==service obj"+service);

		    	   
		    	       if(service != null)
		    	       {
		    	         serviceParameters.put("serviceid", service.getServiceid());
		    	         serviceParameters.put("state", service.getState());
		    	         serviceParameters.put("presname", service.getPresname());
		    	         serviceParameters.put("submitdate", service.getSubmitdate());
		    	         serviceParameters.put("modifydate", service.getModifydate());
		    	         serviceParameters.put("type", service.getType());
		    	         serviceParameters.put("customerid", service.getCustomerid());
                         // Comment following code. parentserviceid must be passed in.
                         
		    	         /*// if parent service id was passed through request - 
		    	         //then use it,
		    	         //else use from service params
		    	         parentserviceid = parentserviceid != null ? parentserviceid : service.getParentserviceid();
		    	         // if it is Layer3 site - then there aren't any parent
		    	         //service id, 
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
						   ((ServiceForm)form).setParentserviceid(parentserviceid);

		    	       }
					  // logger.debug("ACTION CLASS == parentserviceid in servparams"+parentserviceid);

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

					   //logger.debug("ACTION CLASS == serviceParamArray"+serviceParamArray);

		    	     }
		    			
		    	     if (parentserviceid != null && !parentserviceid.equals("")) 
		    	     {
		    	       Service parentService = Service.findByPrimaryKey(con, parentserviceid);
					   // logger.debug("ACTION CLASS == parentService obj"+parentService);

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
						   //logger.debug("ACTION CLASS == parentServiceParamArray"+parentServiceParamArray);
		    	         }
		    	       }
		    	     }
		    	
		    	  
		 	  	    ((ServiceForm)form).setServiceid(serviceid);
		 	    	
		 	    	((ServiceForm)form).setParentserviceid(parentserviceid);
		    	
		 	    request.setAttribute("serviceParameters",serviceParameters);
		 	    request.setAttribute("parentServiceParameters",parentServiceParameters);
		 	    request.setAttribute("modifySelection",modifySelection);
		 	   
		 	   String addressFamily = (String) serviceParameters.get("AddressFamily");
		 	   request.setAttribute("AddressFamily",addressFamily);
		 	   
               
               String parentType = "";
			   if (type!=null&&type.endsWith("Site") && parentserviceid != null) {
                 Service vpn = Service.findByServiceid(con, parentserviceid);
                 parentType = (vpn == null) ? "" : vpn.getType();
               }
		 	   if("layer3-Attachment".equals(type))
		 	    {
		 	  
                request.setAttribute("parentType",parentType);
                logger.debug("PreEditServiceAction parentType: " + parentType);
				//find the compliance of the service here , i.e compliance of the Qos 
				String profile_compliance = Constants.NON_COMPLAINT;;
				
				if ((type!=null&&type.endsWith("Site")&&"layer3-VPN".equals(parentType)))	{
				    profile_compliance = ServiceUtils.getSiteServiceQoSCompliance(con,serviceid, parentserviceid);
				}else{
					 profile_compliance = ServiceUtils.getServiceQoSCompliance(con,serviceid);
				}
				request.setAttribute("qos_compliance",profile_compliance);
					
              								
					//JOIN VPN
		 	    	if(Constants.ACTION_JOIN_VPN.equals(modifySelection)) //start of join vpn
		 	    	{
		 	    	  final String EXTERNAL = "EXTERNAL";
		 	    	  final String PARAMETER_MULTICAST_STATUS = "MulticastStatus";
		 	    	  final String OK = "Ok";
		 	    	   String strExternal="";
		 	    	 
		 	         boolean isExternal =
		 	    	   EXTERNAL.equalsIgnoreCase(request.getParameter("operation_type"));

					 if(isExternal) 
						 strExternal = "true";
					 else
						 strExternal="false";

					 request.setAttribute("isExternal",strExternal);
					 //logger.debug("ACTION CLASS == isExternal"+strExternal);
		 	       
		 	       String newServiceId = request.getParameter("newServiceId");
		 	       if(newServiceId == null && isExternal)
		 	       {
		 	            
		 	            newServiceId = idGenerator.getServiceId();
		 	        }
		 	        
		 	       request.setAttribute("newServiceId",newServiceId);
				    //logger.debug("ACTION CLASS == newServiceId"+newServiceId);

		 	       String extranetName = request.getParameter("extranet_name");
		 	       extranetName = (extranetName == null) ?  "" : extranetName;
		 	       request.setAttribute("extranetName",extranetName);
				  //  logger.debug("ACTION CLASS == extranetName"+extranetName);

		 	       String otherCustomer = request.getParameter("otherCustomer");
		 	       otherCustomer = otherCustomer == null ? "" : otherCustomer;
		 	       request.setAttribute("otherCustomer",otherCustomer);
				  // logger.debug("ACTION CLASS == otherCustomer"+otherCustomer);

		 	       String selectedVPNid = request.getParameter("vpnId");
		 	       selectedVPNid = selectedVPNid == null ? "" : selectedVPNid;
		 	       request.setAttribute("selectedVPNid",selectedVPNid);
				   logger.debug("ACTION CLASS == selectedVPNid"+selectedVPNid);
		 	       
		 	       String siteMulticastStatus;//, vpnMulticastStatus;
		 	       siteMulticastStatus = (String)serviceParameters.get(PARAMETER_MULTICAST_STATUS);
		 	       siteMulticastStatus = siteMulticastStatus == null ? "disabled" : siteMulticastStatus;
		 	       request.setAttribute("siteMulticastStatus",siteMulticastStatus);
				  // logger.debug("ACTION CLASS == siteMulticastStatus"+siteMulticastStatus);

		 	       Customer[] customers = null;
		 	       
		 	      if(isExternal)
		 	      {
		 	         String whereClause = "customerid != '"+customerid+"'" +
		 	         		" and customerid in (select distinct(customerid)" +
		 	         		" from crm_service where type = 'layer3-VPN')";
		 	        customers = Customer.findAll(con, whereClause);
		 	        request.setAttribute("customers",customers);
					//logger.debug("ACTION CLASS == customers"+customers);
		 	       
		 	      }//isexternal
		 	      
		 	     String selectedCustomerId = null;
		         boolean selected = false;
		         int customersLength = customers != null ? customers.length : 0;

                  if(customersLength>0)
			    {
		            for(int customerIndex = 0; customerIndex < customersLength; customerIndex++)
				    {
		             Customer cust = customers[customerIndex];            

		             if(otherCustomer.equals(cust.getCustomerid()))
						 {
		                 selected = true;
		                 selectedCustomerId = otherCustomer;
		             }else
		                 selected = false;
		            }

				  }
		         // if there wasn't any selected customers then lets
		         //select the first in the list
		         if(selectedCustomerId == null && customersLength > 0)
		         {
		             otherCustomer = customers[0].getCustomerid();        
					 request.setAttribute("otherCustomer",otherCustomer);
		         }
		 	       

		 	     String whereClause2 = "type='layer3-VPN' and state like '%"+OK+"%'"+
	                " and serviceid not in (select VPNID from CRM_VPN_MEMBERSHIP " +
	                "where SITEATTACHMENTID ='"+new String(attachmentid).replaceAll(";", "\\;")+"')"; // modified by tanye

		 	    String id = isExternal ? otherCustomer : customerid;
				//logger.debug("ACTION CLASS == id"+id);
		 	       
                 if(id != null )
				{
		 	    Service[] vpns  = Service.findByCustomerid(con, id, whereClause2);
				//logger.debug("ACTION CLASS == vpns"+vpns);
		 	       
		 	   ((ServiceForm)form).setServices(vpns);
				
		 	   
		 	     String selectedId = null;
		 	     int vpnsLength = vpns != null ? vpns.length : 0;
				 if(vpnsLength>0)
					 {
		         for(int vpnIndex = 0; vpnIndex < vpnsLength; vpnIndex++)
		         {
		            Service vpn = vpns[vpnIndex];

		            if(selectedVPNid.equals(vpn.getServiceid())){
		                selected = true;
		                selectedId = selectedVPNid; // saving id to get VPNTopology attribute
		            }else
		                selected = false;
		        }

				 }
                 logger.debug("PreEditServiceAction: selectedId: " + selectedId);
		        if(selectedId == null && vpnsLength > 0)
		            selectedId = vpns[0].getServiceid();
		        
		        if(selectedId != null)
		        {
		            ServiceParameter parameter =
		        ServiceParameter.findByServiceidattribute(con, selectedId, "VPNTopology");
		       
		            request.setAttribute("parameter",parameter);
		        }
		        
				 }//end of id not null
		        
		 	    	}//end of join vpn
		 	     
		 	    	//LEAVE VPN
		 	    	if(Constants.ACTION_LEAVE_VPN.equals(modifySelection)) //start of LEAVE VPN
		 	    	{
						 //logger.debug("ACTION_LEAVE_VPN loop ======");

		 	    		   String selectedVPNid = request.getParameter("vpnId");
				 	       selectedVPNid = selectedVPNid == null ? "" : selectedVPNid;
				 	       request.setAttribute("vpnId",selectedVPNid);
						   //logger.debug("vpnId set======"+selectedVPNid);
				 	       
                           //jacqie - PR 15284
                           if(!selectedVPNid.equals("")){
                             Service selectedVpn = Service.findByPrimaryKey(con, selectedVPNid);
                             Customer vpnOwner = Customer.findByCustomerid(con, selectedVpn.getCustomerid());
                             request.setAttribute("owner",vpnOwner.getCompanyname());
                           }
				 	       
						   if(serviceid!=null)
						{
				 	      String whereClause = "state like '%Ok%' and serviceid in (select VPNID from " +
				 	      		"CRM_VPN_MEMBERSHIP where siteattachmentid = '"+attachmentid+"')"; // modified by tanye
				 	     Service[] services = Service.findByType(con, "layer3-VPN", whereClause);
				 	    ((ServiceForm)form).setServices(services);
						 //logger.debug("services set======"+services);
				 	     Customer cust = Customer.findByCustomerid(con, customerid);
				 	    ((ServiceForm)form).setCustomer(cust);
						 //logger.debug("cust set======"+cust);
				 	    
				 	   Service selectedService = null;
				       boolean select;
					   if(services!=null)
						{
				       for (int i = 0; i < services.length; i++) 
						   {
				         Service service = services[i];
				         if(service.getServiceid().equals(selectedVPNid))
							 {
				           selectedService = service;
				           select = true;
				             }else
				                select = false;
				           }
				       if(selectedService == null)
				           selectedService = services[0];
					     
						  }//services not null

						 if(selectedService!=null)
						   {
				         
						 // if it is last VPN of owner then do no let to leave
				            if(selectedService.getCustomerid().equals(customerid))
				               {
				           String clause = "VPNID in (select CRM_SERVICE.SERVICEID from" +
				           		" CRM_SERVICE where CRM_SERVICE.CUSTOMERID = "+customerid+")";
				           VPNMembership[] memberships =
				        	   VPNMembership.findBySiteattachmentid(con, attachmentid, clause); // modified by tanye
				           //session.setAttribute("memberships",memberships);
				           request.setAttribute("memberships",memberships);
				                }
						   }
					   
					    
						}else
						{
							 logger.debug("ACTION_LEAVE_VPN ======serviceid is null");
						}
		 	    	
		 	    	
		 	    	}//end of LEAVE VPN
		 	    	
		 	    	//MODIFY QOSPROFILE
		 	    	if("ModifyQoSProfile".equals(modifySelection) || "ModifyCAR".equals(modifySelection) || "ModifyRateLimitInterface".equals(modifySelection)) //start of MODIFY QOSPROFILE
		 	    	{

													
		 	    		
		 	    		// THIS IS COMMON SECTION FOR MODIFY car AND MODIFY RATELIMIT -satrts pr 11901
		 	    	
						 CAR[] rateLimits = CAR.findAll(con,whereForRate);
						 logger.debug("PreEditserviceAction: rateLimits" + rateLimits);
                         
                         
		 	    		 CAR multicastRateLimit = null;
		 	    		 request.setAttribute("rateLimits",rateLimits);
		 	    		
		 	    		 String rateLimit = request.getParameter("SP_CAR");
		 	    		 request.setAttribute("rateLimit",rateLimit);
		 	    		 
		 	    		String multicastRLParam = (String) serviceParameters.get("MulticastRateLimit");
		 	    		
		 	    		if(multicastRLParam != null && 
		 	    				"enabled".equals(serviceParameters.get("MulticastStatus")))
		 	    			multicastRateLimit = CAR.findByRatelimitname(con, multicastRLParam); 
		 	    			//chnages for PR 11901
		 	    			//Now find the parents multicast ratelimit 	if it is null
		 	    			if(multicastRLParam == null ) {
		 	    				multicastRLParam = (String) parentServiceParameters.get("MulticastRateLimit");
		 	    				if(multicastRLParam != null &&"enabled".equals(parentServiceParameters.get("MulticastStatus")))
				 	    			multicastRateLimit = CAR.findByRatelimitname(con, multicastRLParam); 
		 	    			}
			 	          request.setAttribute("multicastRateLimit",multicastRateLimit);
		 	    		  		 
		 	    		 	 	    		 
		 	    		 //THIS IS COMMON SECTION FOR MODIFY car AND MODIFY RATELIMIT --eNDS
		 	    		 
		 	    		//QOS SPeCIFIC SECTION STARTS HERE 
		 	    		 
		 	    		EXPMapping[] mappings = EXPMapping.findAll(con);
		 	    		request.setAttribute("mappings",mappings);
		 	    		Profile[] profiles;
		 	    		Profile[] publicprofiles;
		 	    	    EXPMapping[] expMappings = null;
		 	    	    PolicyMapping[] policyMappings = null;
		 	    	    String layer = "layer 3";
		 	    	    Profile selectedProfile = null;

		 	    	    String selectedProfileName = request.getParameter("SP_QOS_PROFILE");
		 	    	    request.setAttribute("SP_QOS_PROFILE",selectedProfileName);
		 	    	    String baseProfile = request.getParameter("SP_QOS_BASE_PROFILE");
		 	    	    request.setAttribute("SP_QOS_BASE_PROFILE",baseProfile);
		 	    	    
		 	    	    
		 	    	    expMappings = EXPMapping.findAll(con);
		 	    	    request.setAttribute("expMappings",expMappings);
		 	    	    
		 	    	    String whereClause1 = null;
		 	    	    String whereClause2 = null;
						if("IPv6".equalsIgnoreCase(addressFamily)){
							whereClause1 = "peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename like '%_v6'" ;
							whereClause2 = "customerid is null and peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename like '%_v6'";
						}
						else{
							whereClause1 = "peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename not like '%_v6'" ;
							whereClause2 = "customerid is null and peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename not like '%_v6'";
						}
		 	    	   // getting customer profiles
		 	           profiles = Profile.findByCustomeridlayer(con, customerid, layer, whereClause1);
		 	          request.setAttribute("profiles",profiles);
		 	          
		 	         // getting public profiles
		 	          publicprofiles = Profile.findByLayer(con, layer, whereClause2);
		 	           request.setAttribute("publicprofiles",publicprofiles);
		 	           
		 	          if(baseProfile == null || baseProfile.equals(""))
		 	 		 {
		 	            baseProfile = selectedProfileName;
		 	         }
		 	         if(baseProfile != null)
		 			{
		 	            selectedProfile = Profile.findByQosprofilename(con, baseProfile);
		 	        }
		 	       
		 	         String parentProfileName = (String)parentServiceParameters.get("QOS_PROFILE");
		 	        if(selectedProfile == null && parentProfileName != null)
		 			{
		 	          selectedProfile = Profile.findByQosprofilename(con, parentProfileName);
		 			}
		 	         request.setAttribute("selectedProfile",selectedProfile);

		 	        policyMappings = PolicyMapping.findByProfilename(con, baseProfile);
		 	         request.setAttribute("policyMappings",policyMappings);
		 	         
		 	        SP_QoSChildEnabled = request.getParameter("SP_QoSChildEnabled");		 	        
		 	        

	                if (SP_QoSChildEnabled == null) {

	                  SP_QoSChildEnabled = (String) serviceParameters.get("QoSChildEnabled");

	                }
	                request.setAttribute("SP_QoSChildEnabled", SP_QoSChildEnabled);
                    ((ServiceForm)form).setSP_QoSChildEnabled(SP_QoSChildEnabled); 
	               /* if(request.getParameter("SP_QoSChildEnabled") != null){	                      
	                  serviceParameters.remove("QoSChildEnabled");
	                  serviceParameters.put("SP_QoSChildEnabled", SP_QoSChildEnabled);
	                }*/
		 	         
		 	    	    
		 	    	}// end of MODIFY QOSPROFILE
		 	    	
		 	    	//MODIFY CAR
		 	    	if("ModifyCAR".equals(modifySelection)) 
		 	    	{
                        //start of MODIFY CAR
		 	    		//now n OTHING  SPECIAL NEEDS TO BE DONE pr -11901 	 	    		
		 	    	}// end of MODIFY CAR
		 	    	
		 	    	//MODIFY CONNECTIVITY TYPE
		 	    	if("ModifyConnectivityType".equals(modifySelection)) 
		 	    	{
                         //	start of MODIFY CONNECTIVITY TYPE	
		 	    		
		 	    		String selectedVPN = request.getParameter("connTypeVPNId");
		 	    		request.setAttribute("selectedVPN",selectedVPN);
		 	    		
		 	    		 // get VPNs List
		 	       String whereClause = "state like '%Ok%' and serviceid in" +
		 	    	 		" (select VPNID from CRM_VPN_MEMBERSHIP " +
		 	    	  		"where siteattachmentid = '"+attachmentid+"')";
		 	       Service[] services = Service.findByType(con, "layer3-VPN", whereClause);
		 	    	  ((ServiceForm)form).setServices(services);
		 	    	  
		 	    	 boolean wasSelected = false;
		 	       /* for (int i = 0; i < services.length; i++)
		 	        {
		 	          Service serviceVPN = services[i];
		 	          String selected;
		 	          if(serviceVPN.getServiceid().equals(selectedVPN)){
		 	            selected = " selected";
		 	            wasSelected = true;
		 	          }else
		 	            selected = "";    
		 	        }*/

					 selectedVPN = selectedVPN == null ? parentserviceid : selectedVPN;
	                String currentConnectivityType = 
		 	          VPNMembership.findByVpnidsiteattachmentid(con, selectedVPN, attachmentid).getConnectivitytype(); // moidfied by tanye

		 	         String siteTopology = 
		 	         ServiceParameter.findByServiceidattribute(con, selectedVPN, "VPNTopology").getValue();
	    
		 	      request.setAttribute("currentConnectivityType",currentConnectivityType);
		 	      request.setAttribute("siteTopology",siteTopology);      
		 	        
		 	    	}   // end of MODIFY CONNECTIVITY TYPE


		 	    	
		 	    	//ADD STATIC ROUTES
		 	    	if("AddStaticRoutes".equals(modifySelection)) 
		 	    	{	
		 	    		boolean inc_static = true;
                        int staticCounter=1;
						String removelink = (String)request.getParameter ("remove");
						  request.setAttribute("removeflag",removelink);
						
						//start of ADD STATIC ROUTES
		 	          String allRoutes = request.getParameter ("allRoutes");
		 	         
		 	          StaticRoute routes[]=StaticRoute.findByAttachmentid(con, serviceid);
		 	          if(routes!=null)
		 	            request.setAttribute("routes", routes);
		 	         
		 	          
		 	          
		 	          request.setAttribute("allRoutes",allRoutes);
					  //logger.debug("preedit AddStaticRoutes allRoutes======"+allRoutes);
               //logger.debug("preedit=== SP_STATIC_Routes ======"+request.getParameter ("SP_STATIC_Routes"));

//richa - 12083
					 String SelfLoad =  request.getParameter("SelfLoad");
	 				 request.setAttribute("SelfLoad",SelfLoad);
//richa - 12083
		 	          String strstaticCounter = request.getParameter("staticCounter"); 
		 	          
		 	          request.setAttribute("staticCounter", strstaticCounter);
		 	         
                        
                          if(strstaticCounter != null)
	                        {
			                     staticCounter = Integer.parseInt(strstaticCounter);
				             }
			      //logger.debug("preedit action --- int staticCounter >>>>>>>>>>>>>>>>>>>>>"+staticCounter);
                  String s1 = "";

                              for(int i=0;i<staticCounter;i++)
			                   {
				                   s1 = Integer.toString(i);
					              String route = request.getParameter("routes" + s1);
								  String mask = request.getParameter("masks" + s1);
                                  request.setAttribute("masks"+s1,mask);
					              request.setAttribute("routes"+s1,route);
					              try{
										if(route != null && !"".equals(route)){
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
												PreAddServiceAction preaddAction = new PreAddServiceAction();
												request.setAttribute("Message", "IP Prefix does not match with Mask");
												request.setAttribute("ServiceForm", (ServiceForm)form);
												ActionForward actionforward = preaddAction.execute(mapping, form, request, response);
												logger.debug("AddServiceAction: " + "IP Prefix does not match with Mask");
												return mapping.findForward(Constants.FAILURE);
											}
											}
										}
									}
									catch(Exception e){
										inc_static = false;
										request.setAttribute("Message", e.getMessage());
									}

			                     }
                              if (strstaticCounter != null && inc_static) {

              					staticCounter = Integer.parseInt(request.getParameter("staticCounter"));
              					if (!"Y".equals(request.getAttribute("removeflag"))) {
              						staticCounter++;

              					}

              					strstaticCounter = Integer.toString(staticCounter);
              					request.setAttribute("staticCounter", strstaticCounter);

              				}
		 	    		
		 	    	}  //end of ADD STATIC ROUTES
		 	    	
		 	    	//REMOVE STATIC ROUTES
		 	    	if("RemoveStaticRoutes".equals(modifySelection)) 
		 	    	{
                       //start of REMOVE STATIC ROUTES
		 	    		String rowCounter = request.getParameter ("rowCounter");
		 	    		request.setAttribute("rowCounter",rowCounter);
		 	    		StaticRoute routes[]=StaticRoute.findByAttachmentid(con, serviceid);
	                      if(routes!=null)
	                        request.setAttribute("routes", routes);
		 	    		
		 	    	}//end of REMOVE STATIC ROUTES
		 	    	

		 	    	// MODIFY MULTICAST
		 	    	if("ModifyMulticast".equals(modifySelection)) 
		 	    	{
                     //start of MODIFY MULTICAST
		 	    		
		 	    		 String selectedVPNid = request.getParameter("VPNid");
						 //modified vpnId to VPNid for the pr15012 by azmath
						  selectedVPNid = selectedVPNid != null ? selectedVPNid :parentserviceid;
		 	    		 request.setAttribute("vpnId",selectedVPNid);
						//  logger.debug("INSIDE ModifyMulticast LOOP ");
						// logger.debug("selectedVPNid == "+selectedVPNid);
		 	    		 
		 	    		final String PARAMETER_MULTICAST_STATUS = "MulticastStatus";
		 	    		final String PARAMETER_MULTICAST_ID = "MulticastVPNId";
		 	    		
		 	    		  ServiceParameter vpnMulticast = null;
		 	    		  ServiceParameter multicastIdParam = null;
		 	    		  VPNMembership[] memberships = null;
		 	    		  EXPMapping[] expMappings = {};
		 	    		  CAR[] rateLimits = {};
		 	    		  CAR siteRateLimit = null;
						  Profile profile = new Profile();
						  String pkForQos =" ";
						  ServiceParameter qosParam  = null;
						  String qos = "";

		 	    		  
						  Service attachService = Service.findByPrimaryKey(con, attachmentid);
		 	    		  String siteServiceId = attachService.getParentserviceid();;
			 	    	  request.setAttribute("Site_Service_id",siteServiceId);
		 	    		 vpnMulticast = 
		 	      ServiceParameter.findByServiceidattribute(con, selectedVPNid, PARAMETER_MULTICAST_STATUS);
		 	    		request.setAttribute("vpnMulticast",vpnMulticast);
						 //logger.debug("vpnMulticast == "+vpnMulticast);
		 	    		 
		 	    		multicastIdParam = 
		 	      ServiceParameter.findByServiceidattribute(con, selectedVPNid, PARAMETER_MULTICAST_ID);
		 	    		request.setAttribute("multicastIdParam",multicastIdParam);
						// logger.debug("multicastIdParam == "+multicastIdParam);
		 	    		
		 	    		memberships = VPNMembership.findBySiteattachmentid(con, attachmentid); // modified by tanye
		 	    		request.setAttribute("memberships",memberships);
						// logger.debug("memberships == "+memberships);

		 	    	    expMappings = EXPMapping.findAll(con);
		 	    	   request.setAttribute("expMappings",expMappings);
					    //logger.debug("expMappings == "+expMappings);
					
						 rateLimits = CAR.findAll(con,whereForRate);
					
		 	    	   request.setAttribute("rateLimits",rateLimits);
					    //logger.debug("rateLimits == "+rateLimits);

		 	    	   // siteRateLimit = CAR.findByPrimaryKey(con, (String)serviceParameters.get("CAR"));
		 	    	   //Now the Sites ratelimit is lowest of the atatchments ratelimits 
		 	    	 
					  siteRateLimit =ServiceUtils.getSiteServiceRateLimit(con ,siteServiceId, parentserviceid);
		 	    	  request.setAttribute("siteRateLimit",siteRateLimit);
					 
					 	    	   
		 	    	}//end of MODIFY MULTICAST
		 	    	
		 	    	
		 	    }
		 	     /* ********** Modify GIS Attachment ********** */
				 	   if("GIS-Attachment".equals(type))
				{
					request.setAttribute("parentType",parentType);
					logger.debug("PreEditServiceAction parentType: " + parentType);
				//find the compliance of the service here , i.e compliance of the Qos 
						String profile_compliance = Constants.NON_COMPLAINT;;
				
				if ((type!=null&&type.endsWith("Site")&&"GIS-VPN".equals(parentType)))	{
				    profile_compliance = ServiceUtils.getSiteServiceQoSCompliance(con,serviceid, parentserviceid);
				}else{
					 profile_compliance = ServiceUtils.getServiceQoSCompliance(con,serviceid);
				}
				request.setAttribute("qos_compliance",profile_compliance);
			if("ModifyQoSProfile".equals(modifySelection) || "ModifyCAR".equals(modifySelection)) //start of MODIFY QOSPROFILE
		 	    	{
						 CAR[] rateLimits = CAR.findAll(con,whereForRate);
						 logger.debug("PreEditserviceAction: rateLimits GIS" + rateLimits);
                       
		 	    		 CAR multicastRateLimit = null;
		 	    		 request.setAttribute("rateLimits",rateLimits);
						 
		 	    		 String rateLimit = request.getParameter("SP_CAR");
		 	    		 request.setAttribute("rateLimit",rateLimit);
		 	    		 
		 	    		String multicastRLParam = (String) serviceParameters.get("MulticastRateLimit");
		 	    		
		 	    		if(multicastRLParam != null && 
		 	    				"enabled".equals(serviceParameters.get("MulticastStatus")))
		 	    			multicastRateLimit = CAR.findByRatelimitname(con, multicastRLParam); 
		 	    			//chnages for PR 11901
		 	    			//Now find the parents multicast ratelimit 	if it is null
		 	    			if(multicastRLParam == null ) {
		 	    				multicastRLParam = (String) parentServiceParameters.get("MulticastRateLimit");
		 	    				if(multicastRLParam != null &&"enabled".equals(parentServiceParameters.get("MulticastStatus")))
				 	    			multicastRateLimit = CAR.findByRatelimitname(con, multicastRLParam); 
		 	    			}
			 	          request.setAttribute("multicastRateLimit",multicastRateLimit);

		 	    		EXPMapping[] mappings = EXPMapping.findAll(con);
		 	    		request.setAttribute("mappings",mappings);
		 	    		Profile[] profiles;
		 	    		Profile[] publicprofiles;
		 	    	    EXPMapping[] expMappings = null;
		 	    	    PolicyMapping[] policyMappings = null;
		 	    	    String layer = "layer 3";
		 	    	    Profile selectedProfile = null;

		 	    	    String selectedProfileName = request.getParameter("SP_QOS_PROFILE");
		 	    	    request.setAttribute("SP_QOS_PROFILE",selectedProfileName);
		 	    	    String baseProfile = request.getParameter("SP_QOS_BASE_PROFILE");
		 	    	    request.setAttribute("SP_QOS_BASE_PROFILE",baseProfile);
		 	    	    		 	    	    
		 	    	    expMappings = EXPMapping.findAll(con);
		 	    	    request.setAttribute("expMappings",expMappings);
		 	    	    
		 	    	    String whereClause1 = null;
		 	    	    String whereClause2 = null;
						if("IPv6".equalsIgnoreCase(addressFamily)){
							whereClause1 = "peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename like '%_v6'" ;
							whereClause2 = "customerid is null and peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename like '%_v6'";
						}
						else{
							whereClause1 = "peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename not like '%_v6'" ;
							whereClause2 = "customerid is null and peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename not like '%_v6'";
						}
		 	    	   // getting customer profiles
		 	           profiles = Profile.findByCustomeridlayer(con, customerid, layer, whereClause1);
		 	          request.setAttribute("profiles",profiles);
		 	          
		 	         // getting public profiles
		 	          publicprofiles = Profile.findByLayer(con, layer, whereClause2);
		 	           request.setAttribute("publicprofiles",publicprofiles);
		 	           
		 	          if(baseProfile == null || baseProfile.equals(""))
		 	 		 {
		 	            baseProfile = selectedProfileName;
		 	         }
		 	         if(baseProfile != null)
		 			{
		 	            selectedProfile = Profile.findByQosprofilename(con, baseProfile);
		 	        }       
		 	         String parentProfileName = (String)parentServiceParameters.get("QOS_PROFILE");
		 	        if(selectedProfile == null && parentProfileName != null)
		 			{
		 	          selectedProfile = Profile.findByQosprofilename(con, parentProfileName);
		 			}
		 	         request.setAttribute("selectedProfile",selectedProfile);

		 	        policyMappings = PolicyMapping.findByProfilename(con, baseProfile);
		 	         request.setAttribute("policyMappings",policyMappings);
		 	    	    
		 	    	}
				}
				
		 	    	//ADD PREFIX LIST
		 	    	if("AddPrefixList".equals(modifySelection)) 
		 	    	{	
		 	    		boolean inc_static = true;
                        int prefixCounter=1;
						String removelink = (String)request.getParameter ("remove");
						  request.setAttribute("removeflag",removelink);
						
						//start of ADD Prefix list
		 	          String allRoutes = request.getParameter ("allRoutes");
		 	          request.setAttribute("allRoutes",allRoutes);
					 
					 String SelfLoad =  request.getParameter("SelfLoad");
	 				 request.setAttribute("SelfLoad",SelfLoad);

		 	          String strprefixCounter = request.getParameter("prefixCounter"); 
		 	          
		 	          request.setAttribute("prefixCounter", strprefixCounter);
		 	         
                        
                          if(strprefixCounter != null)
	                        {
			                     prefixCounter = Integer.parseInt(strprefixCounter);
				             }
                  String s1 = "";

                              for(int i=0;i<prefixCounter;i++)
			                   {
				                   s1 = Integer.toString(i);
					              String route = request.getParameter("routes" + s1);
								  String mask = request.getParameter("masks" + s1);
								  String lemask=request.getParameter("lemask"+ s1);
								  if(lemask==null){lemask="";}
                                  request.setAttribute("masks"+s1,mask);
					              request.setAttribute("routes"+s1,route);
								  request.setAttribute("lemask"+ s1 ,lemask);
					              try{
										if(route != null && !"".equals(route)){
											IPAddressHelper.validateCIDRAddress(route +"/"+ mask , addressFamily);
										}
									}
									catch(Exception e){
										inc_static = false;
										request.setAttribute("Message", e.getMessage());
									}

			                     }
                              if (strprefixCounter != null && inc_static) {

              					prefixCounter = Integer.parseInt(request.getParameter("prefixCounter"));
              					if (!"Y".equals(request.getAttribute("removeflag"))) {
              						prefixCounter++;

              					}

              					strprefixCounter = Integer.toString(prefixCounter);
              					request.setAttribute("prefixCounter", strprefixCounter);

              				}
		 	    		
		 	    	}  //end of ADD PREFIX ROUTES
					if("RemovePrefixList".equals(modifySelection)) 
		 	    	{
                       //start of REMOVE STATIC ROUTES
		 	    		String rowCounter = request.getParameter ("rowCounter");
		 	    		request.setAttribute("rowCounter",rowCounter);
		 	    		
		 	    	}//end of REMOVE PREFIX ROUTES
                /* *********** end Modify GIS Attachment ************ */			   
		 	   if((type!=null&&type.endsWith("Site")&&"layer2-VPN".equals(parentType))|| "layer2-Attachment".equals(type))
		 	   { 
		 		   //MODIFY QOS
		 		   if("ModifyQoS".equals(modifySelection)) //start of MODIFY QOS
		 	    	{
		 			  CAR[] rateLimits = null;
		 			 String rateLimit = request.getParameter("SP_CAR");
		 			 request.setAttribute("SP_CAR",rateLimit);
		 			
		 			rateLimits = CAR.findAll(con,whereForRate);
					
		 			request.setAttribute("rateLimits",rateLimits);

		 	        EXPMapping[] mappings = EXPMapping.findAll(con);
		 	       request.setAttribute("mappings",mappings);
		 	    		
		 	      //QOS
	 	    		 
//		 		 	QOS
		 	   		 
		    		Profile[] profiles;
		    		Profile[] publicprofiles;
		    	    EXPMapping[] expMappings = null;
		    	    PolicyMapping[] policyMappings = null;
		    	    String layer = "layer 2";
		    	    Profile selectedProfile = null;

		    	    String selectedProfileName = request.getParameter("SP_QOS_PROFILE");
		    	    request.setAttribute("SP_QOS_PROFILE",selectedProfileName);
		    	    String baseProfile = request.getParameter("SP_QOS_BASE_PROFILE");
		    	    request.setAttribute("SP_QOS_BASE_PROFILE",baseProfile);
		    	    
		    	    
		    	    expMappings = EXPMapping.findAll(con);
		    	    request.setAttribute("expMappings",expMappings);
		    	    
		    	   // getting customer profiles
		           profiles = Profile.findByCustomeridlayer(con, customerid, layer, "peqosprofilename is not null");
		          request.setAttribute("profiles",profiles);
		          
		         // getting public profiles
		          publicprofiles = Profile.findByLayer(con, layer, "customerid is null" +
		           		" and peqosprofilename is not null");
		           request.setAttribute("publicprofiles",publicprofiles);
		           
		          if(baseProfile == null || baseProfile.equals(""))
		 		 {
		            baseProfile = selectedProfileName;
		         }
		         if(baseProfile != null)
				{
		            selectedProfile = Profile.findByQosprofilename(con, baseProfile);
		        }
		       
		         String parentProfileName = (String)parentServiceParameters.get("QOS_PROFILE");
		        if(selectedProfile == null && parentProfileName != null)
				{
		          selectedProfile = Profile.findByQosprofilename(con, parentProfileName);
				}
		         request.setAttribute("selectedProfile",selectedProfile);

		        policyMappings = PolicyMapping.findByProfilename(con, baseProfile);
		         request.setAttribute("policyMappings",policyMappings);
			    		
			 	  
		 	    		
		 	    	}//end of MODIFY QOS
		 		   
		 	   }
			   
			   if("layer2-VPN".equals(type))
		 	  { 					
					//MODIFY QOS BULK
		 		   if("ModifyQoSBulk".equals(modifySelection)) 
		 	    	{						
						String rateLimit = request.getParameter("SP_CAR");
		 	    		request.setAttribute("rateLimit",rateLimit);
						
						String selectedProfileName = request.getParameter("SP_QOS_PROFILE");
		 	    	    request.setAttribute("SP_QOS_PROFILE",selectedProfileName);
		 	    	    
						String baseProfile = request.getParameter("SP_QOS_BASE_PROFILE");
		 	    	    request.setAttribute("SP_QOS_BASE_PROFILE",baseProfile);
						
		 	    	}//MODIFY QOS BULK
		 	  }
		 	   
		 	  if("layer3-VPN".equals(type))
		 	  { 
		 		  //MODIFY TOPOLOGY
		 		   if("ModifyTopology".equals(modifySelection)) 
		 	    	{
                        //	start of MODIFY TOPOLOGY
		 			   String rowCounter = request.getParameter ("rowCounter");
		 			   request.setAttribute("rowCounter",rowCounter);
		 	    		
		 	    	}//end of MODIFY TOPOLOGY
		 		  
		 		  //MODIFY MULTICAST
		 		   if("ModifyMulticast".equals(modifySelection)) 
		 	    	{
                       //	start of MODIFY MULTICAST
		 			  PreparedStatement ps = null;
		 			  ResultSet resultSet = null;
		 			  
		 			   try
		 			   {
		 		   int sitesCount =0;
		 		   ps = con.prepareStatement("select count(*) from CRM_SERVICEPARAM A," +
		 		   		" CRM_SERVICEPARAM B " +			
		 		   		"where a.SERVICEID = b.SERVICEID and " +
		 		   		"a.ATTRIBUTE = 'MulticastStatus' and " +
		 			   "a.VALUE = 'enabled' and b.ATTRIBUTE = 'MulticastVPNId'" +
		 			   " and b.VALUE = ?");
		 		   ps.setString(1, (String) serviceParameters.get("MulticastVPNId"));
		 			resultSet = ps.executeQuery();

		 					    if(resultSet.next()) {
		 					      sitesCount = resultSet.getInt(1);
		 					    }
		 			 request.setAttribute("sitesCount",String.valueOf(sitesCount));
		 			   }
		 			   catch(Exception excep)
		 			   {
						   logger.error("PreEditServiceAction =="+excep);
		 			   }
		 	    		finally
		 	    		{
		 	    			 resultSet.close();
		 	    		    ps.close();
		 	    		}
		 	    	}//end of MODIFY MULTICAST
					
					//MODIFY QOS BULK
		 		   if("ModifyQoSBulk".equals(modifySelection)) 
		 	    	{						
						String rateLimit = request.getParameter("SP_CAR");
		 	    		request.setAttribute("rateLimit",rateLimit);
						
						String selectedProfileName = request.getParameter("SP_QOS_PROFILE");
		 	    	    request.setAttribute("SP_QOS_PROFILE",selectedProfileName);
		 	    	    
						String baseProfile = request.getParameter("SP_QOS_BASE_PROFILE");
		 	    	    request.setAttribute("SP_QOS_BASE_PROFILE",baseProfile);
						
						String QoSChildEnabledParam = request.getParameter("SP_QoSChildEnabled");
		 	    	    request.setAttribute("SP_QoSChildEnabled",QoSChildEnabledParam);
						
		 	    	}//MODIFY QOS BULK
		 	  }
		 	  
		 	  
		 	 if("layer2-VPWS".equals(type))
		 	 { 
		 		 //MODIFY RATELIMIT
		 		 if("ModifyRateLimit".equals(modifySelection)) //start of MODIFY RATELIMIT
		 	    	{
		 			 CAR[] rateLimits = null;
				
		 			rateLimits = CAR.findAll(con,whereForRate);
				
		 			request.setAttribute("rateLimits",rateLimits);
		 	    	}//end of MODIFY RATELIMIT
		 	 }
		 	 
		 	 //MODIFY RATE LIMIT AND INTERFACE
		 	if("ModifyRateLimitInterface".equals(modifySelection) ) 
            { 
              String name_terminationpoint="";
              String source_terminationpoint="";
              String networkelement_id="";
              String network_id="";
              String type_interface="";            
              
              
              PreparedStatement ps = null;
              ResultSet resultSet = null;
              String source_parentIf = "";
              
              try{
                ps = con.prepareStatement("SELECT DISTINCT cr_terminationpoint.name, cr_terminationpoint.ne_id, cr_networkelement.networkid,  cr_interface.type, cr_terminationpoint.terminationpointid, cr_interface.parentIf "+
                                         "from cr_terminationpoint, cr_networkelement, cr_interface "+
                                         "WHERE cr_terminationpoint.terminationpointid in (SELECT DISTINCT terminationpointid from v_flowpoint WHERE attachmentid = ?) "+
                                         "and cr_terminationpoint.ne_id= cr_networkelement.networkelementid and cr_terminationpoint.terminationpointid = cr_interface.terminationpointid");
                ps.setString(1, attachmentid);
                resultSet = ps.executeQuery();                
                
                if(resultSet.next()) {
                  name_terminationpoint = resultSet.getString(1);
                  networkelement_id=resultSet.getString(2);
                  network_id=resultSet.getString(3);
                  type_interface=resultSet.getString(4);
                  source_terminationpoint=resultSet.getString(5);
                  source_parentIf=resultSet.getString(6);
                }               
                
              }
              catch(Exception excep)
              {
                  logger.error("PreEditServiceAction =="+excep);
              }
               finally
          
               {
                   resultSet.close();
                   ps.close();
               } 
              
              String current_region=getCurrentRegion(attachmentid,con,logger);              
              request.setAttribute("current_region",current_region);
              request.setAttribute("source_terminationpoint",source_terminationpoint);
              request.setAttribute("interface_name",name_terminationpoint);    
              String current_network=getNetwork(networkelement_id, con, logger);
              request.setAttribute("current_network",current_network);
              String peRouter=getPERouter(networkelement_id, con, logger);
              request.setAttribute("current_perouter",peRouter);
           
              TreeMap networks = new TreeMap ();
              TreeMap peRouters = new TreeMap ();              
              TreeMap interfaces = new TreeMap ();
              
              Region[] regions_aux = Region.findAll(con); 
              Region[] regions=new Region[regions_aux.length+1];
              regions[0]=new Region("","");
              for(int i=0;i<regions_aux.length;i++){
                regions[i+1]=regions_aux[i];
              }
              
			  String rateLimit = request.getParameter("SP_CAR");
			  String rateLimitOld = request.getParameter("SP_CAR_OLD");
			  long rateLimitSource=0;
              request.setAttribute("regions",regions);
              String selected_region = request.getParameter("REGIONS"); 
              String aux_region=request.getParameter("aux_region"); 
              String aux_network=request.getParameter("aux_network"); 
              
              if(selected_region != null && ("null".equals(rateLimitOld) || rateLimit.equals(rateLimitOld))){
                request.setAttribute("selected_region",selected_region);                   
                networks=getNetworks(selected_region, con, logger);
                if(aux_region == null || aux_region.compareTo(selected_region)==0){
                  String selected_network = request.getParameter("NETWORKS");
                  if(selected_network != null){
                    request.setAttribute("selected_network",selected_network);
                    peRouters=getPERouters(selected_network, con, logger);                  
                  }
                  
                  String selected_perouter = request.getParameter("PEROUTERS");  
                  String selected_interface = request.getParameter("INTERFACES");       
                  if(selected_perouter != null && selected_network !=null){                      
                      request.setAttribute("selected_perouter",selected_perouter);

                      if((aux_network !=null && aux_network.compareTo(selected_network)==0) || aux_region == null){
                        //get interface                       
                          ps = null;
                          resultSet = null;
                          boolean no_enough_bandwidth = false;
                          boolean ratelimit_interface_ok = false;
                          long rateLimitCurrent = 0;
                          boolean empty = true;
                          try {
                        	  
                            ps = con.prepareStatement("select t.terminationpointid, t.name, i.bandwidth, t.ec_id, i.parentif "+
                                                      "from cr_terminationpoint t, cr_interface i "+
                                                       "where t.ne_id= ? and (i.type='Ethernet' or i.type='Serial') and" +
                                                       " i.usagestate='Available' and i.activationstate != 'Activated' and  i.type=?" +
                                                       
                                                       "and i.terminationpointid=t.terminationpointid and t.terminationpointid != ?" +
                                                       " and i.parentif IS NULL");
                            ps.setString(1, selected_perouter);
                            ps.setString(2, type_interface);
                            ps.setString(3, source_terminationpoint);

                            resultSet = ps.executeQuery();                                  
                            if (resultSet != null) {
                              interfaces.put("", "");
                            }
                            while(resultSet.next()) {

                              // Check destination router allowUseEntireFastEth only if the service is inside an interface (not for subinterfaces which has the source_parentIf != null)
                              //boolean allowUseEntireFastEth = true;
                              if (source_parentIf == null) {
                                if (rateLimit != null) {
                                  rateLimitSource = getRateLimint(rateLimit, con, logger);
                                  //allowUseEntireFastEth = 2000000 <= rateLimitSource;
                                }
                              }

                              empty = false;
                              String name = resultSet.getString(2);
System.out.println("While loop - name: " + name);
/*
                              String[] vendorAndOS = getVendorAndOsVersion(selected_perouter,con,logger);
                              String ectype = getECType(resultSet.getString(4), con, logger);
System.out.println("While loop - name: " + name + " vendor: " + vendorAndOS[0] + " OS version: " + vendorAndOS[1] + " ectype: " + ectype);

                              if (vendorAndOS!=null && ectype!= null) {
                                if (!allowUseEntireFastEth && !name.startsWith("Ethernet") && "Cisco".equals(vendorAndOS[0]) && !"CiscoXR".equals(vendorAndOS[1]) && "Port".equals(ectype)) {
System.out.println("skipping interface: " + name);
                                  continue;
                                }
                              }
*/						  
                              /*if (isSerialInterface(con, source_terminationpoint) && !isSameParentECType(con, source_terminationpoint, resultSet.getString(1))) {
System.out.println("skipping interface (serial) name: " + name);
                                continue;
                              }*/
                              
System.out.println("ratelimit_interface_ok = true");
                              ratelimit_interface_ok = true;
							  
                              try {
                                rateLimitCurrent = Long.valueOf(resultSet.getString(3));
                              } catch (NumberFormatException nfe) {
                                // If there is any error in bandwidth then rateLimitCurrent will be 0
System.out.println("NumberFormatException with: " + resultSet.getString(3));
                              }
                              
System.out.println("rateLimitSource: " + rateLimitSource + " <=? rateLimitCurrent: " + rateLimitCurrent);
                              if (rateLimitSource <= rateLimitCurrent) {
System.out.println("Adding interface name: " + name);
                                interfaces.put(resultSet.getString(1), name);
                                no_enough_bandwidth = false;
                              }
                            }
                          } catch(Exception excep) {
                            excep.printStackTrace();
                            logger.error("PreEditServiceAction =="+excep);
                          } finally {
                            resultSet.close();
                            ps.close();
                          }
                          
                        request.setAttribute("selected_interface",selected_interface); 
                        if (interfaces != null) {
                          request.setAttribute("size_interface",interfaces.size());
                        }
                        
                        if (interfaces.size() <= 1) {
System.out.println("interfaces.size(): " + interfaces.size() + " empty: " + empty);
                          if(!empty){
                            if (!ratelimit_interface_ok) {
                              // 2M ratelimit error
System.out.println("Error 2M");
                              request.setAttribute("errorInterface", "2M");
                            }
                            else if(no_enough_bandwidth){
System.out.println("Error bandwidth");
                              request.setAttribute("errorInterface", "bandwidth");
                            }
                          }
                        }
                      }
                  }
                }
              }
			  request.setAttribute("SP_CAR_OLD",rateLimit);
              request.setAttribute("networks",networks);
              request.setAttribute("peRouters",peRouters);
              request.setAttribute("interfaces",interfaces); 
                
            }
		  		
			}
		 	catch(Exception ex)
		 	{
		 		logger.error("Exception in preedit class......due to..."+ex, ex);
				 error = true;

		 	}
		 	finally
		 	{
		         // close the connection
		        dbp.releaseConnection(con);
		 	}
	      
		//} //if not commitmodify
		  
		  if(formAction.equals("CommitModifyService")||
				    formAction.equals("CommitModifyService.do"))
		  {
			  ModifyServiceAction modifyServices = new ModifyServiceAction();
	    	   ActionForward actionforward 
	    	   = modifyServices.execute(mapping,form,request,response);
	       	   return  actionforward;
			  
		  }
		  else
		  {
	          //Forward Action
	            if(!(error))
	            {        
	     	  //set values to actionform obj && Transfer to the jsp   		  
	        	return mapping.findForward(Constants.SUCCESS);           
	            }
	            else
	            {       	
	      	 //  return mapping.findForward(Constants.FAILURE);
	    	   ListServicesAction allServices = new ListServicesAction();
	    	   ActionForward actionforward 
	    	   = allServices.execute(mapping,form,request,response);
	       	   return  actionforward;
	            }
	            
		  }
	   		 
	   	 }
	 
	 private String getCurrentRegion(String attachmentid, Connection con,Logger logger) throws SQLException{
	   PreparedStatement ps = null;
       ResultSet resultSet = null;   
       
       String current_region="";
       
       try{
         ps = con.prepareStatement("SELECT DISTINCT region "+
                                  "from v_site "+
                                  "WHERE serviceid = (SELECT DISTINCT siteid from v_accessflow WHERE serviceid = ?)");
         ps.setString(1, attachmentid);
         resultSet = ps.executeQuery();                
         
         while(resultSet.next()) {
           current_region = resultSet.getString(1);
         } 
         
         
       }
       catch(Exception excep)
       {
           logger.error("PreEditServiceAction =="+excep);
       }
        finally
        {
            resultSet.close();
            ps.close();
        }
       
       return current_region;
	 }
	 
	
	 
	 private String getNetwork(String networkelement_id, Connection con,Logger logger) throws SQLException{
       PreparedStatement ps = null;
       ResultSet resultSet = null;   
       
       String current_network="";
       
       try{
         ps = con.prepareStatement("SELECT DISTINCT cr_network.name "+
                                  "from cr_network, cr_networkelement "+
                                  "WHERE cr_networkelement.networkelementid =  ? and cr_networkelement.networkid = cr_network.networkid");
         ps.setString(1, networkelement_id);
         resultSet = ps.executeQuery();                
         
         while(resultSet.next()) {
           current_network = resultSet.getString(1);
         }               
         
       }
       catch(Exception excep)
       {
           logger.error("PreEditServiceAction =="+excep);
       }
        finally
        {
            resultSet.close();
            ps.close();
        }        
       
       return current_network;
     }
	 
	 private TreeMap getNetworks(String current_region, Connection con,Logger logger) throws SQLException{
       PreparedStatement ps = null;
       ResultSet resultSet = null;  
       TreeMap networks = new TreeMap ();
       try{
         ps = con.prepareStatement("select networkid, name from cr_network where region = ? and type='Network'");
         ps.setString(1, current_region);
         resultSet = ps.executeQuery();                
         if(resultSet!=null){
           networks.put("", "");
         }
         while(resultSet.next()) {          
           networks.put(resultSet.getString(1), resultSet.getString(2));
         }               
         
       }
       catch(Exception excep)
       {
           logger.error("PreEditServiceAction =="+excep);
       }
        finally
        {
            resultSet.close();
            ps.close();
        }        
       
       return networks;
     }
	 
	 
	 private TreeMap getPERouters(String networkid, Connection con,Logger logger) throws SQLException{
       PreparedStatement ps = null;
       ResultSet resultSet = null;  
       TreeMap PERouters = new TreeMap ();
       try{
         ps = con.prepareStatement("SELECT cr_networkelement.networkelementid, cr_networkelement.name "+
             "FROM cr_networkelement, v_perouter "+
             "where cr_networkelement.networkid= ? and v_perouter.networkelementid = cr_networkelement.networkelementid  and cr_networkelement.role='PE'"+
             "ORDER BY v_perouter.networkelementid");
         ps.setString(1, networkid);
         resultSet = ps.executeQuery(); 
         if(resultSet!=null){
           PERouters.put("", "");
         }
         while(resultSet.next()) {          
           PERouters.put(resultSet.getString(1), resultSet.getString(2));
         }               
         
       }
       
       catch(Exception excep)
       {
           logger.error("PreEditServiceAction =="+excep);
       }
        finally
        {
            resultSet.close();
            ps.close();
        }        
       
       return PERouters;
     }
	 
	 private String getPERouter(String networkelement_id, Connection con,Logger logger) throws SQLException{
       PreparedStatement ps = null;
       ResultSet resultSet = null;  
       String PERouter = "";
       try{
         ps = con.prepareStatement("SELECT cr_networkelement.name "+
                                    "FROM cr_networkelement, v_perouter "+
                                    "WHERE v_perouter.networkelementid = ? and cr_networkelement.networkelementid=v_perouter.networkelementid");
         ps.setString(1, networkelement_id);
         resultSet = ps.executeQuery();                
         
         while(resultSet.next()) {          
           PERouter=resultSet.getString(1);
         }               
         
       }
       
       catch(Exception excep)
       {
           logger.error("PreEditServiceAction =="+excep);
       }
        finally
        {
            resultSet.close();
            ps.close();
        }        
       
       return PERouter;
     }
	 
	 private long getRateLimint(String rateLimit, Connection con,Logger logger) throws SQLException{
       PreparedStatement ps = null;
       ResultSet resultSet = null;  
       long resultRateLimit =0;
       try{
         ps = con.prepareStatement("select r.averagebw from  v_ratelimit r where  r.ratelimitname= ? ");
         ps.setString(1, rateLimit);
         resultSet = ps.executeQuery();                
         
         while(resultSet.next()) {          
           resultRateLimit=resultSet.getLong(1);
         }               
         
       }
       
       catch(Exception excep)
       {
           logger.error("PreEditServiceAction =="+excep);
       }
        finally
        {
            resultSet.close();
            ps.close();
        }        
       
       return resultRateLimit;
     }
	 
	 private String[] getVendorAndOsVersion(String ne_id, Connection con,Logger logger) throws SQLException{
       PreparedStatement ps = null;
       ResultSet resultSet = null;  
       String[] result = {"", ""};
       try{
         ps = con.prepareStatement("select n.vendor, n.osversion from cr_networkelement n where n.networkelementid= ? ");
         ps.setString(1, ne_id);
         resultSet = ps.executeQuery();                
         
         while(resultSet.next()) {          
           result[0] = resultSet.getString(1);
           result[1] = resultSet.getString(2);
         }               
         
       }
       
       catch(Exception excep)
       {
           logger.error("PreEditServiceAction =="+excep);
       }
        finally
        {
            resultSet.close();
            ps.close();
        }        
       
       return result;
     }
	 
	 private String getECType(String ec_id, Connection con,Logger logger) throws SQLException{
       PreparedStatement ps = null;
       ResultSet resultSet = null;  
       String ectype="";
       try{
         ps = con.prepareStatement("select e.ectype from cr_elementcomponent e where e.elementcomponentid= ? ");
         ps.setString(1, ec_id);
         resultSet = ps.executeQuery();                
         
         while(resultSet.next()) {          
           ectype=resultSet.getString(1);
         }               
         
       }
       
       catch(Exception excep)
       {
           logger.error("PreEditServiceAction =="+excep);
       }
        finally
        {
            resultSet.close();
            ps.close();
        }        
       
       return ectype;
     }
	
	
  // Finds out whether the provided interface type is Serial or not
  private boolean isSerialInterface(Connection con, String tpId)
  {
	boolean result = false;
	PreparedStatement ps = null;
    ResultSet resultSet = null;  
	
	try
	{
		String type = ""; 
		
		String query = "select type from cr_interface where terminationpointid = ?";
		
		ps = con.prepareStatement(query);
        ps.setString(1, tpId);
		
		resultSet = ps.executeQuery();                
         
		while(resultSet.next()) 
		{
			type = resultSet.getString(1);
		}  
		
		if ("Serial".equals(type)) result = true; 
	}
	catch (Exception e) 
	{
		System.out.println("Exception inside isSerialInterface(): "+e);
	}
	finally
	{
		try { resultSet.close(); } catch (Exception ex) { } 
		try { ps.close(); } catch (Exception ex) { } 
	}   
	
	return result;
  }
	
  // Finds out whether source tp id and target tp id have a similar parent ec type
  private boolean isSameParentECType(Connection con, String sourceTpId, String targetTpId)
  {
	boolean result = false;
	PreparedStatement ps = null;
    ResultSet resultSet = null;  
	
	try
	{
		String sourceIfEcParentEcName = "";
		String targetIfEcParentEcName = "";
		
		String query = "select name from cr_elementcomponent where elementcomponentid = (select parentec_id from cr_elementcomponent where elementcomponentid = (select ec_id from cr_terminationpoint where terminationpointid = ? ))";
		
		ps = con.prepareStatement(query);
        ps.setString(1, sourceTpId);
		
		resultSet = ps.executeQuery();                
         
		while(resultSet.next()) 
		{
			sourceIfEcParentEcName = resultSet.getString(1);
		}  
		
		ps = con.prepareStatement(query);
        ps.setString(1, targetTpId);
		
		resultSet = ps.executeQuery();                
         
		while(resultSet.next()) 
		{
			targetIfEcParentEcName = resultSet.getString(1);
		} 
		
		if (isSONET(sourceIfEcParentEcName) && isSONET(targetIfEcParentEcName)) result = true;
		
		if (isE1(sourceIfEcParentEcName) && isE1(targetIfEcParentEcName)) result = true;
		
		if (isSTM(sourceIfEcParentEcName) && isSTM(targetIfEcParentEcName)) result = true;
		
		if (isSerial(sourceIfEcParentEcName) && isSerial(targetIfEcParentEcName)) result = true;
	}
	catch (Exception e) 
	{
		System.out.println("Exception inside isSameParentECType(): "+e);
	}
	finally
	{
		try { resultSet.close(); } catch (Exception ex) { } 
		try { ps.close(); } catch (Exception ex) { } 
	}   
	
	return result;
  }
  
  
  private boolean isSONET(String slotName)
  {
	if (slotName.contains("SONET"))
	{
		return true;
	}
	else
	{
		return false;
	}
  }
  
  
  private boolean isE1(String slotName)
  {
	if (slotName.contains("E1"))
	{
		return true;
	}
	else
	{
		return false;
	}
  }
  
  
  private boolean isSTM(String slotName)
  {
	if (slotName.contains("STM"))
	{
		return true;
	}
	else
	{
		return false;
	}
  }
  
  
  private boolean isSerial(String slotName)
  {
	if (slotName.contains("Serial"))
	{
		return true;
	}
	else
	{
		return false;
	}
  }

}
