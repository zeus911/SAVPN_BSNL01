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
import java.util.ArrayList;
import java.util.HashMap;
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

public class DisableServiceAction extends Action{
	
	public DisableServiceAction() 
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
     String searchSite=request.getParameter("searchSite");
     String siteidSearch=request.getParameter("siteidSearch");
    
      String action = request.getParameter("action");
      if ( action.equalsIgnoreCase("Enable") ) {
        action=Constants.ACTION_ENABLE;
      }
      if ( action.equalsIgnoreCase("disable") ) {
        action=Constants.ACTION_DISABLE;
      }
     String serviceType = null;
     Service service = null;
     String oldState = null;
     StringBuffer failMessage = new StringBuffer(256);

   HttpSession session1 = request.getSession();
   HashMap hmp = (HashMap)session1.getAttribute("disableParam");

	      String VPNId = request.getParameter ("parentserviceid");
	      String curVPNtype = request.getParameter ("curVPNtype");
	      String SiteAtt = request.getParameter ("attachmentid");
	      logger.debug("DisableServiceAction.java: parentserviceid is "+VPNId+", curVPNtype is "+curVPNtype+", attachmentid is "+SiteAtt+", action is "+action);

   //logger.debug("DisableServiceAction.java: HashMap hmp is");
   //logger.debug(hmp);

     // Used when disabling CE_Ok Site.
     // In this case it's impossible to disable PE link so just disable it on CRM_Portal side
     boolean skipOVSA = false;

     
     // Get database connection from session
	  HttpSession session = request.getSession();
	  dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
			
	   HashMap serviceParameters = new HashMap(10);

	    serviceParameters.put("modifydate", Constants.DEFAULT_DATE_FORMAT.format(new java.util.Date()));
	    serviceParameters.put("HOST", session.getAttribute(Constants.SOCKET_LIS_HOST));
	    serviceParameters.put("PORT", session.getAttribute(Constants.SOCKET_LIS_PORT));
	    serviceParameters.put("TEMPLATE_DIR", session.getAttribute(Constants.TEMPLATE_DIR));
		serviceParameters.put("operator", session.getAttribute(Constants.USER_KEY));
	    serviceParameters.put("LOG_DIRECTORY", session.getAttribute(Constants.LOG_DIRECTORY));
	    serviceParameters.put("type", "Service");
	    serviceParameters.put("ACTION", "Disable");
	  
		StringBuffer sql = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String curSiteId = null;
		Service SiteAttachment = null;
		StringBuffer sqlSite = null;
		PreparedStatement pstmt_Site = null;
		ResultSet RsetSite = null;
		StringBuffer sqlSiteAttachmentsOfSite = null;
		PreparedStatement pstmt_AttachmentsNum = null;
		ResultSet Rset_AttachmentsNum = null;
			
	    try
	  	{
	  		
	  		con = (Connection) dbp.getConnection();
	  		
	  		
	  	      if (serviceid == null) 
	  	      {
	  	        throw new IllegalStateException("Service ID not set, cannot modify service.");
	  	      }
	  	      if(!Constants.ACTION_ENABLE.equalsIgnoreCase(action) && !Constants.ACTION_DISABLE.equalsIgnoreCase(action))
	  	        throw new IllegalStateException("Action is undefined or wrong");
	  	      
	  	      
	  	   
	  	      if (con == null)
	  	        throw new NullPointerException("The database connection could not be established");

	  	      service = Service.findByPrimaryKey(con, serviceid);
	  	      if(curVPNtype == null && (service.getParentserviceid()==null) && ((service.getType().equals(Constants.TYPE_LAYER3_VPN))||(service.getType().equals(Constants.TYPE_LAYER2_VPWS))||(service.getType().equals(Constants.TYPE_LAYER2_VPN)))) {
	  	        curVPNtype=service.getType();
	  	      }
	  	      oldState = service.getState();

	  	      if("CE_Setup_Ok".equals(oldState))
	  	      {
	  	        skipOVSA = true;
	  	        service.setState("CE_Disabled");
	  	        ServiceUtils.updateService(con, service);
	  	      }
	  	      if("CE_Disabled".equals(oldState))
	  	      {
	  	        skipOVSA = true;
	  	        service.setState("CE_Setup_Ok");
	  	        ServiceUtils.updateService(con, service);
	  	      }

	  	      ServiceParameter reqSynchronizationParam =
	  	    	  ServiceParameter.findByServiceidattribute(con, serviceid, "request_synchronisation");
	  	     
	  	      serviceParameters.put("request_synchronisation", reqSynchronizationParam.getValue());

	  	      if(!skipOVSA)
	  	      {
//PR 15068 for site maybe multiplexed, judge it later   	      	
//	  	        serviceParameters.put("Region", getRegion(con, serviceid));

//	  	        String nextState = getNextState(action, oldState);

//	  	        service.setState(nextState);

//	  	        VPNMembership[] memberships = 
//	  	        	VPNMembership.findBySiteid(con, serviceid);
//	  	        	VPNMembership.findBySiteattachmentid(con, serviceid);
	  	        	/*
	  	        			old		new
	  	        		VPN	null		null
	  	        		Site	memb[]		memb[]
	  	        		Att	null		null
	  	        	*/
	  	      
	  	        //if type id layer3-site handle it diffrently 
//	  	        if("layer3-Attachment".equals( service.getType()) ){
//	  	        	serviceType="SiteAttachment";
//	  	        }else   if("Site".equals( service.getType()) && "layer3-VPN".equals(curVPNtype) ){
//	  	        	serviceType="layer3Site";
//	  	        }
	  	       		
//	  	       	if("layer2-Attachment".equals( service.getType()) ){
//	  	        	serviceType="SiteAttachment";
//	  	        }else   if("Site".equals( service.getType()) && "layer2-VPN".equals(curVPNtype)){
//	  	        	serviceType="layer2Site";
//	  	        }
	  	        
//	  	      logger.debug("Disable service : Service type is  "+ serviceType );
	  	      
	  	        //PR12005 -START

//	  	        ServiceUtils.updateService(con, service);
	  	          // Send message to SA.
	  	        // set skip_activation value
//	  	        serviceParameters.put("skip_activation", session.getAttribute("SKIP_ACTIVATION"));
	  	        //SendXML sender = new SendXML(serviceParameters);
	  	        /*PR 15068
	  	        We aren't sure whether to disable site here, so move all message sending to later
	  	        sender.Init();
	  	        logger.debug("DisableServiceAction.java: line 180 sent");
	  	        sender.Send();
	  	        //End of PR 15068
	  	        */
	  	        

	  	        	/*
	  	          // fetching direct subservices using Service->Parent_id
	  	        
	  	         
	  	          final Service[] directServices
	  	          = Service.findByParentserviceid(con, serviceid, whereClause);

	  	          // fetching related subservices using CRM_VPN_MEMBERSHIP (VPN, Site) relations
	  	          String whereClause2 =whereClause+ " and crm_service.SERVICEID " +
	  	          		"in (select SITEID from CRM_VPN_MEMBERSHIP A " +
	  	          		"where VPNID = '"+serviceid+"' and 1 = " +
	  	          				"(select count(VPNID) from CRM_VPN_MEMBERSHIP " +
	  	          				"where SITEID = a.SITEID))";
	  	          
	  	     
	  	        
	  	         relatedServices
	  	          = Service.findAll(con, whereClause2);

	  	          
	  	          int directServicesCount 
	  	          = directServices != null ? directServices.length : 0;

	  	          // joining direct and related subservices into
	  	          //the single array
	  	          
	  	          if(directServicesCount == 0)
	  	            subServices = relatedServices;
	  	          else if(relatedServices == null)
	  	              subServices = directServices;
	  	          else{
	  	             
	  	        subServices =
	  	            new Service[directServicesCount + relatedServices.length];
	  	              System.arraycopy(directServices, 0, subServices, 0 , directServicesCount);
	  	              System.arraycopy(relatedServices, 0, subServices, directServicesCount, relatedServices.length);
	  	          }

	  	          // setting serviceType for all subservices since all of them are of Site type
	  	          serviceParameters.put("servicetype", "Site");

	  	   		if(directServices!=null){
	  	    	  
	  	    	  for(int i =0 ; i< directServices.length ; i++){
	  	    		    
	  	    		  Service site=directServices[i];
  	    		    Service[] attachments = Service.findByParentserviceid(con,site.getServiceid(),whereClause);
//	  	    		add the attachments  to the list of services
	  	    		    
	  	    		 if(attachments!=null){
	  	    			 
	  	    			logger.debug("Disable service :"+ site.getServiceid()+ "has  " +attachments.length +"attachments" );
	  	    			
	  	    			 for(int k =0 ; k< attachments.length ; k++)
	  		  	    	 listofServices.add(attachments[k]);
	  	    			
	  	    		 }
	  	    		  
	  	    	  }
	  	      }
	  	      */	  	        
	  	      //Service[] subServices = null;
//	  	        if(action.equals("Enable")) action = "enable";
//	                if(action.equals("Disable")) action = "disable";
	  	      
	  	      String whereClause;

	  	      if(action.equalsIgnoreCase(Constants.ACTION_ENABLE))
	            whereClause = "s.state in ('Disable_Failure', " +
	            		"'Enable_Failure', 'PE_Disabled', 'CE_Disabled', 'PE_CE_Disabled'," +
	            		" 'Disabled')";
	          else
	            whereClause = "s.state in ('PE_Ok', 'CE_Setup_Ok'," +
	            		" 'Ok', 'Disable_Failure', 'Enable_Failure'," +
	            		" 'End_Time_Failure', 'PE_End_Time_Failure', 'PE_CE_Ok', 'PE_CE_End_Time_Failure')";

	  	     //Service[] relatedServices=null;
	  	     ArrayList  listofServices =new ArrayList();

			Service Site = null;
                
            //curVPNtype comes as layer3-VPN(TYPE_LAYER3_VPN) or layer2-VPN(TYPE_LAYER2_VPN) or layer2-VPWS(TYPE_LAYER2_VPWS).
            //We need to convert it to L3VPN or L2VPN or L2VPWS
            String attachmentType=new String();
			if ( curVPNtype.equals(Constants.TYPE_LAYER3_VPN) ) {
				attachmentType=Constants.ATTACHMENT_TYPE_L3VPN;
			} else if ( curVPNtype.equals(Constants.TYPE_LAYER2_VPN) ) {
				attachmentType=Constants.ATTACHMENT_TYPE_L2VPN;
			} else if ( curVPNtype.equals(Constants.TYPE_LAYER2_VPWS) ) {
				attachmentType=Constants.ATTACHMENT_TYPE_L2VPWS;
			}
            serviceParameters.put("Attachmenttype", attachmentType);
			//Though in current UI, we just can disable VPN(include VPWS) and l2,l3 sites, we still list all the possibility here
	  	        if("layer3-Attachment".equals( service.getType()) || "layer3-Protection".equals( service.getType()) || "layer2-Attachment".equals( service.getType())){
	  	        	serviceType="SiteAttachment";
	  	        }else if("Site".equals( service.getType()) && "layer3-VPN".equals(curVPNtype) ){
	  	        	serviceType="layer3Site";
	  	        }else if("Site".equals( service.getType()) && "layer2-VPN".equals(curVPNtype)){
	  	        	serviceType="layer2Site";
	  	        }else if ((service.getType().equals("layer3-VPN"))||(service.getType().equals("layer2-VPN"))){
	  	        	serviceType="VPN";
	  	        }else if ("layer2-VPWS".equals( service.getType())) {
	  	        	serviceType="VPWS";
	  	        }else if ("vpws-Attachment".equals(service.getType())) {
	  	        	serviceType="vpws-Attachment";	 //actually cannot delete a single vpws attachment
	  	        }else if ("Site".equals( service.getType()) && "layer2-VPWS".equals(curVPNtype) ) {
	  	        	serviceType="vpws-Site";	
	  	        }else {
	  	        	serviceType="UnSupported";	
	  	        }

			//logger.debug("DisableServiceAction.java: serviceType is "+serviceType);
			
	  	      if(serviceType.equals("VPN")) {
				//Add VPN to disableList
				listofServices.add(service);
				VPNId = serviceid;
				curVPNtype = service.getType();

				sql = new StringBuffer("select s.serviceid, s.presname, s.state, s.submitdate, s.modifydate, s.type, s.customerid, "+
					"s.parentserviceid, s.endtime, s.nextoperationtime, s.lastupdatetime from crm_service s, crm_vpn_membership m "+
					"where s.serviceid=m.siteattachmentid and m.vpnid='"+serviceid+"' and "+whereClause
				);				
	  	        }else if (serviceType.equals("layer2Site") || serviceType.equals("layer3Site")) {
	  	        	// fetching direct subservices using Service->Parent_id
				//PR 15068
				sql = new StringBuffer("select s.serviceid, s.presname, s.state, s.submitdate, s.modifydate, s.type, s.customerid, "+
					"s.parentserviceid, s.endtime, s.nextoperationtime, s.lastupdatetime from crm_service s, crm_vpn_membership m "+
					"where s.serviceid=m.siteattachmentid and m.vpnid='"+VPNId+"'and s.parentserviceid='"+serviceid+"' and "+whereClause
				);				
  	        	} else if (serviceType.equals("VPWS")) {
  	        		//VPWS is special case
  	        		listofServices.add(service);
  	        	} else if(serviceType.equals("SiteAttachment")) {
  	        		//For Partial_Disabled
                    listofServices.add(service);
  	        		
  	        	}
  	        	
			//logger.debug("DisableServiceAction.java: site sql is "+sql);
			if(null!=sql) {
	                  	pstmt = con.prepareStatement( sql.toString() );
				rset = pstmt.executeQuery(); 
				while( rset.next()) {
					if(null!=rset.getString(8)){
						if(!((rset.getString(8)).equals(curSiteId))){
							/*New Site*/
							curSiteId = rset.getString(8);

							/*Only if there isn't any other siteattachments of the site is multiplexed(but not joined), 
							we send the disable site command*/
							String AllAttachmentsNum = null; 
							String AttachmentsNum = null; 
							sqlSiteAttachmentsOfSite = new StringBuffer("select count(*) count from (select "+
								"distinct s.serviceid from crm_service s, crm_vpn_membership m where "+
							"s.serviceid=m.siteattachmentid and s.parentserviceid='"+curSiteId+"')");	
							pstmt_AttachmentsNum = con.prepareStatement( sqlSiteAttachmentsOfSite.toString() );
							Rset_AttachmentsNum = pstmt_AttachmentsNum.executeQuery();
							if (Rset_AttachmentsNum.next()){
								AllAttachmentsNum = Rset_AttachmentsNum.getString(1);
								//logger.debug("DisableServiceAction.java:: Site_"+curSiteId+"'s AllAttachmentsNum is "+AllAttachmentsNum);   
		                     			}
		                     			pstmt_AttachmentsNum = null;
		                     			Rset_AttachmentsNum = null;
							sqlSiteAttachmentsOfSite = new StringBuffer("select count(*) count from (select "+
								"distinct s.serviceid from crm_service s, crm_vpn_membership m where "+
								"s.serviceid=m.siteattachmentid and s.parentserviceid='"+curSiteId+"' and "+
								"m.vpnid='"+VPNId+"')");	
							pstmt_AttachmentsNum = con.prepareStatement( sqlSiteAttachmentsOfSite.toString() );
							Rset_AttachmentsNum = pstmt_AttachmentsNum.executeQuery();
							if (Rset_AttachmentsNum.next()){
								AttachmentsNum = Rset_AttachmentsNum.getString(1);   
								//logger.debug("DisableServiceAction.java:: Site_"+curSiteId+"'s AttachmentsNum is "+AttachmentsNum);   
		                     			}								
		                     			if(AllAttachmentsNum!=null && AttachmentsNum!=null && (AllAttachmentsNum.equals(AttachmentsNum))) {
								Site = Service.findByServiceid(con, curSiteId);
								//Add Site to disableList
	                     					listofServices.add(Site);
	                     					logger.debug("DisableServiceAction.java:: Site_"+curSiteId+" isn't multiplexed, we'll send the disable site message");
	                     				}
							/*New siteAttachment process*/
							/**/
							SiteAttachment = new Service(
										rset.getString(1),
										rset.getString(2),
										rset.getString(3),
										rset.getString(4),
										rset.getString(5),
										rset.getString(6),
										rset.getString(7),
										rset.getString(8),
										rset.getString(9),
										rset.getLong(10),
										rset.getLong(11)
									);
	     						listofServices.add(SiteAttachment);
	     						/**/
						}
						/**/
						else if ((rset.getString(8)).equals(curSiteId)) {
							//L3-Site Protection process
							SiteAttachment = new Service(
										rset.getString(1),
										rset.getString(2),
										rset.getString(3),
										rset.getString(4),
										rset.getString(5),
										rset.getString(6),
										rset.getString(7),
										rset.getString(8),
										rset.getString(9),
										rset.getLong(10),
										rset.getLong(11)
									);
							listofServices.add(SiteAttachment);		
						}
						/**/
					}
				}
			}	  	        
		      //logger.debug("listofServices.size is "+listofServices.size());
/*	  	      
	  	    final int subServicesCount = subServices == null ? 0 : subServices.length;

	  	      
	  	      //add the sub services to the list of services 
	  	    for(int j =0 ; j< subServicesCount ; j++)
	  	    	listofServices.add(subServices[j]);
	  	      
	  	      if(relatedServices!=null){
	  	    	  
	  	    	logger.debug("Disable service : Related service are not null and length is "+ relatedServices.length );
	  	    	  
	  	    	  for(int i =0 ; i< relatedServices.length ; i++){
	  	    		    
	  	    		  Service site=relatedServices[i];
	  	    		  
	  	    		logger.debug("Disable service : Related service is" + site );
	  	    		
	  	    		    		    
	  	    		    Service[] attachments = Service.findByParentserviceid(con,site.getServiceid(),whereClause);
//	  	    		add the attachments  to the list of services
	  	    		    
	  	    		 if(attachments!=null){
	  	    			 
	  	    			logger.debug("Disable service :"+ site.getServiceid()+ "has  " +attachments.length +"attachments" );
	  	    			
	  	    			 for(int k =0 ; k< attachments.length ; k++)
	  		  	    	 listofServices.add(attachments[k]);
	  	    			
	  	    		 }
	  	    		  
	  	    	  }
	  	      }
*/	  	      
	  	       
	  	    for (int i = 0; i < listofServices.size(); i++) 
	            {

				//Moved the Generation of message ids inside the forloop since it has to generate unique ids for all the requests. -- Done for an uniquie Const violation being thrown on simulteanous submission in the controller.
	  	    	 IdGenerator idGenerator = new IdGenerator(con);
				String abc = idGenerator.getMessageId();
	  	        serviceParameters.put("messageid", abc );
				//logger.debug("SDSDSDSD&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" + abc);
	  	    	
	  	    	Service subService = (Service) listofServices.get(i);
	  	    	logger.debug("Service to be disabled "+subService.getServiceid());
	  	    	
			serviceParameters.put("EnableState", action);
				  	    	
	  	            String oldSubState = subService.getState();

	  	            if("CE_Setup_Ok".equals(oldSubState)){
	  	              subService.setState("CE_Disabled");
	  	              ServiceUtils.updateService(con, subService);
	  	              continue;
	  	            }
	  	            if("CE_Disabled".equals(oldSubState)){
	  	              subService.setState("CE_Setup_Ok");
	  	              ServiceUtils.updateService(con, subService);
	  	              continue;
	  	            }

	  	            String nextState = getNextState(action, oldSubState);
	  	            subService.setState(nextState);

	  	            ServiceUtils.updateService(con, subService);
	  	            if(curVPNtype.equals(Constants.TYPE_LAYER2_VPWS)){
	  	          ServiceUtils.saveOrUpdateParameter(con, serviceid, Constants.PARAMETER_LAST_COMMIT,
						DisableL2VPWSVPNStateListener.class.getName());
	  	            }
       	  	            //logger.debug("DisableServiceAction.java: subService_"+subService.getServiceid()+"'s oldstate "+oldSubState+" will be updated to new state "+nextState);

	  	          if("layer3-Attachment".equals( subService.getType()) || "layer3-Protection".equals( subService.getType()) || "layer2-Attachment".equals( subService.getType())){
	  	        	serviceParameters.put("servicetype", "SiteAttachment");
		  	  }
					//Added by Rama on 20th May 2008.
					// The check is to make the service type for l3 site as layer3site. Earliear it was comin as site.
					//Done for the PR:13911
	  	            else if("Site".equals( subService.getType()) && curVPNtype.equals("layer3-VPN") ){
	  	        	serviceParameters.put("servicetype", "layer3Site");
	  	            }else if("Site".equals( subService.getType()) && curVPNtype.equals("layer2-VPN") ){
	  	        	serviceParameters.put("servicetype", "layer2Site");
	  	            }else if (subService.getParentserviceid() == null && ((subService.getType().equals("layer3-VPN"))||(subService.getType().equals("layer2-VPN")))) {
	  	            	serviceParameters.put("servicetype", "VPN");
	  	            }else if ("layer2-VPWS".equals( subService.getType())) {
	  	            	serviceParameters.put("servicetype", "Site");
	  	            }else if ("vpws-Attachment".equals(subService.getType())){
	  	            	serviceParameters.put("servicetype", "vpws-Attachment");	
	  	            }else {
	  	            	serviceParameters.put("servicetype", "Unsupported");	
	  	            }
	  	            
	  	            serviceParameters.put("serviceid", subService.getServiceid());
	  	            serviceParameters.put("Region", getRegion(con, subService.getServiceid()));

	  	            try{
	  	              // set skip_activation value
	  	              serviceParameters.put("skip_activation", session.getAttribute("SKIP_ACTIVATION"));              
	  	              SendXML sender = new SendXML(serviceParameters);
	  	              sender.Init();
	  	              sender.Send();
	  	            }catch(IOException ex){
	  	              ex.printStackTrace();
	  	              
	  	              logger.error(ex);
	  	              logger.error("Unable to send request to OVSA", ex);
                      
                     subService.setState("Disable_Failure");
	  	              
                    try {
                        ServiceUtils.updateService(con, subService);
                        ServiceUtils.saveOrUpdateParameter(con, subService.getServiceid(), "Failure_Description", ex.getMessage());
                      } catch (Exception e)
                      {
                        e.printStackTrace();
                      }
	  	              failMessage.append(subService.getPresname()).append('(').append(subService.getServiceid()).append("), ");
                      
	  	            }
	  	          }
	  	        
	  	        
	  	        
	  	        // End of if service is VPN

	  	        // if some of disables failed then show error message
	  	        if(failMessage.length() > 0){
	  	          failMessage.delete(failMessage.length()-3, failMessage.length()-1);
                  
	  	          throw new Exception("Failed to send request to OVSA for these services: "+ failMessage);
	  	        }
	  	      }// End of if(!skipOVSA)

	  		
	  		
	  	     
	  	}
        
	 	catch(Exception ex)
	 	{
	 		 error = true;
	 		 logger.error(ex);
	 		// If message wasn't sent then return old state to the service
	        if(service != null && (failMessage == null || failMessage.length() == 0)){
	          service.setState(oldState);
	          ServiceUtils.updateService(con, service);
	        }

	 	}finally
	 	{		
			if (pstmt != null)
				pstmt.close();
			if (rset != null)
				rset.close();
			if (pstmt_Site != null)
				pstmt_Site.close();
			if (RsetSite != null)
				RsetSite.close();
			if (pstmt_AttachmentsNum != null)
				pstmt_AttachmentsNum.close();
			if (Rset_AttachmentsNum != null)
				Rset_AttachmentsNum.close();
				
	         // close the connection
	        dbp.releaseConnection(con);
			
			 try { if (con != null) con.close(); } catch (Exception ex) { }
	 	}

	 	//	 send control to findallservices
  		((ServiceForm)form).setCustomerid(customerid);
  	   ((ServiceForm)form).setServiceid(serviceid);
  	   
  	 ActionForward actionforward=null;
  	 ListServicesAction allServices = new ListServicesAction();
  	 if(searchSite!=null && !searchSite.equals("") && !searchSite.equals("null")){ 
  	   ((ServiceForm)form).setServiceid(siteidSearch);
         SiteSearchAction siteSearchAction=new SiteSearchAction();
      actionforward 
       = siteSearchAction.execute(mapping,form,request,response);     
      
    }
  	 else{
    	
  	   actionforward 
  	   = allServices.execute(mapping,form,request,response);
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
    	   //return mapping.findForward(Constants.FAILURE);
        	 return  actionforward;
          }
	
	}
	
	 
	 
	 private static String getNextState(String action, String previousState){
		    if(action.equalsIgnoreCase(Constants.ACTION_ENABLE))
		      //return previousState.indexOf("PE") != -1 ? "Enable_PE_Request_Sent" : "Enable_Request_Sent";
		      return previousState.indexOf("PE") != -1 ? "Enable_Request_Sent" : "Enable_Request_Sent";
		    else
		      //return previousState.indexOf("PE") != -1 ? "Disable_PE_Request_Sent" : "Disable_Request_Sent";
		      return previousState.indexOf("PE") != -1 ? "Disable_Request_Sent" : "Disable_Request_Sent";
		  }

     private static String getRegion(Connection connection, String serviceId) throws SQLException{
		    ServiceParameter parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, "Region");
		    if(parameter != null)
		      return parameter.getValue();
		    // if it is l2vpws
		    parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, "PW_aEnd_region");
		    if(parameter != null)
		      return parameter.getValue();

		    return null;
		  }

}
