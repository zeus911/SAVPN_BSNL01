/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
 *
 ************************************************************************
 */
package com.hp.ov.activator.crmportal.action;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;
import java.util.Set;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.hp.ov.activator.crmportal.bean.Customer;
import com.hp.ov.activator.crmportal.bean.Service;
import com.hp.ov.activator.crmportal.bean.ServiceParameter;
import com.hp.ov.activator.crmportal.bean.StaticRoute;
import com.hp.ov.activator.crmportal.bean.VPNMembership;
import com.hp.ov.activator.crmportal.bean.Profile;
import com.hp.ov.activator.crmportal.common.IdGenerator;
import com.hp.ov.activator.crmportal.helpers.CreateGISSiteListener;
import com.hp.ov.activator.crmportal.helpers.CreateL2VPNStateListener;
import com.hp.ov.activator.crmportal.helpers.CreateL2VPWSVPNStateListener;
import com.hp.ov.activator.crmportal.helpers.CreateL3SiteListener;
import com.hp.ov.activator.crmportal.helpers.JspHelper;
import com.hp.ov.activator.crmportal.helpers.PortalSyncListener;
import com.hp.ov.activator.crmportal.helpers.SendXML;
import com.hp.ov.activator.crmportal.helpers.ServiceUtils;
import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;
import com.hp.ov.activator.vpn.IPAddressHelper.IPAddressHelper;

public class AddServiceAction extends Action
{
	private static final Logger logger = Logger.getLogger("CRMPortalLOG");

	public AddServiceAction()
	{
	}
	public ActionForward execute(ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception
			{
		DatabasePool dbp = null;
		Connection con = null;
		boolean error = false;
		//String serviceid = ((ServiceForm)form).getServiceid();
		Service service = new Service();
		Customer customer = null; //richa for time format
		String customerid = ((ServiceForm)form).getCustomerid(); //richa for time format
		HashMap allParameters = new HashMap();
		// Holds all the ServiceParameter bean object so that store
		//can be called on them when the SA interaction has been performed.
		Vector serviceParameterVector = new Vector();
		//richa
		String strMessage = "";
		String formAction = request.getParameter("actionType");
		String addressFamily = null;
		String curVPNId = request.getParameter("SP_vpnserviceid");
		//richa
		
		String searchSite=request.getParameter("searchSite");
	    String siteidSearch=request.getParameter("siteidSearch");
		
		// Get database connection from session
		HttpSession session = request.getSession();
		dbp = (DatabasePool)session.getAttribute(Constants.DATABASE_POOL);
		try {
			con = (Connection)dbp.getConnection();
			String resend = request.getParameter("resend");
			if (!"true".equals(resend) && this.checkDuplicatedSiteName(mapping, form, request, response, con)) {
				logger.debug("Site name duplicated. Action return!");
				return mapping.findForward(Constants.FAILURE);
			}

			IdGenerator idGenerator = new IdGenerator(con);
			customer = (Customer)Customer.findByPrimaryKey(con, customerid); //richa for time format
			((ServiceForm)form).setCustomer(customer); //richa for time format
			String mv = request.getParameter("mv");
			// logger.debug("AddServiceAction ======mv========"+mv);
			String currentPageNo = request.getParameter("currentPageNo");
			//logger.debug("AddServiceAction ======currentPageNo========"+currentPageNo);
			String viewPageNo = request.getParameter("viewPageNo");
			//   logger.debug("AddServiceAction ======viewPageNo========"+viewPageNo);
		


			//richa uncommented it for time format
			request.setAttribute("mv", mv);
			((ServiceForm)form).setMv(mv);
			request.setAttribute("currentPageNo", currentPageNo);
			((ServiceForm)form).setCurrentPageNo(currentPageNo);
			request.setAttribute("viewPageNo", viewPageNo);
			((ServiceForm)form).setViewPageNo(viewPageNo);
			//richa uncommented it for time format
			
			String request_synchronisation = PortalSyncListener.servletConfig.getInitParameter(Constants.REQUEST_SYNCHRONISATION);
			
			// TODO Delete TRUNK PART
			String reqtype = request.getParameter("reqtype");
			if ("deleteTrunk".equals(reqtype)) {
			  allParameters.put("ACTION", "Delete");
			  String SP_trunk_id = (String)request.getAttribute("SP_trunk_id");
	          allParameters.put("trunk_id", SP_trunk_id);
			} else {
			  allParameters.put("ACTION", "Create");
			}
			
			allParameters.put("HOST", (String)session.getAttribute(Constants.SOCKET_LIS_HOST));
			allParameters.put("PORT", (String)session.getAttribute(Constants.SOCKET_LIS_PORT));
			allParameters.put("TEMPLATE_DIR", (String)session.getAttribute(Constants.TEMPLATE_DIR));
			allParameters.put("operator", (String)session.getAttribute(Constants.USER_KEY));
			allParameters.put("LOG_DIRECTORY", (String)session.getAttribute(Constants.LOG_DIRECTORY));
			allParameters.put("request_synchronisation", request_synchronisation);

			//service multiplexing
			handleServiceMultiplexing(request, allParameters, serviceParameterVector, (ServiceForm)form);
			String serviceid = ((ServiceForm)form).getServiceid();	

			// Aggregated LSPS ER
			String lspUsageMode = request.getParameter("lspoptions");	
			if (lspUsageMode != null)
			{
				ServiceParameter serviceParameter = new ServiceParameter();
				serviceParameter.setServiceid(serviceid);
				serviceParameter.setAttribute("lspusagemode");
				serviceParameter.setValue(lspUsageMode);
				serviceParameterVector.add(serviceParameter);
				allParameters.put("lspusagemode", lspUsageMode);
			}
			// Aggregated LSPs ER

			//PR 15247
			serviceParameterVector.add(new ServiceParameter(serviceid,"skip_activation",(session.getAttribute("SKIP_ACTIVATION")).toString()));

			//serviceid
			if (((ServiceForm)form).getServiceid() != null)
				allParameters.put("serviceid", ((ServiceForm)form).getServiceid());
			// presname
			if (((ServiceForm)form).getPresname() != null)
				allParameters.put("presname", ((ServiceForm)form).getPresname());
			//state based on ACTIVATION SCOPE
			if (((ServiceForm)form).getState() != null)
				allParameters.put("state", ((ServiceForm)form).getState());
			if (((ServiceForm)form).getSP_Activation_Scope() != null
					&& ((ServiceForm)form).getSP_Activation_Scope().equals("BOTH")) {
				((ServiceForm)form).setState("Request_Sent");
				if (request.getParameter("SP_StartTime") != null && !((ServiceForm)form).getSP_StartTime().equalsIgnoreCase(""))
					((ServiceForm)form).setState("Sched_Request_Sent");
			}
			if (((ServiceForm)form).getSP_Activation_Scope() != null
					&& ((ServiceForm)form).getSP_Activation_Scope().equals("PE_ONLY")) {
				((ServiceForm)form).setState("Request_Sent");
				if (request.getParameter("SP_StartTime") != null && !((ServiceForm)form).getSP_StartTime().equalsIgnoreCase(""))
					((ServiceForm)form).setState("Sched_Request_Sent");
			}
			if (((ServiceForm)form).getSP_Activation_Scope() != null
					&& ((ServiceForm)form).getSP_Activation_Scope().equals("CE_ONLY")) {
				((ServiceForm)form).setState("Request_Sent");
				if (request.getParameter("SP_StartTime") != null && !((ServiceForm)form).getSP_StartTime().equalsIgnoreCase(""))
					((ServiceForm)form).setState("Sched_Request_Sent");
			}
			if (((ServiceForm)form).getSP_Activation_Scope() == null) {
				((ServiceForm)form).setState("Request_Sent");
				if (request.getParameter("SP_StartTime") != null && !((ServiceForm)form).getSP_StartTime().equalsIgnoreCase(""))
					((ServiceForm)form).setState("Sched_Request_Sent");
			}
			//Add layer2-Site type for layer2-attachment
			//modified for GIS 
			if ((((ServiceForm)form).getType().equalsIgnoreCase("layer3-Site")||
					((ServiceForm)form).getType().equalsIgnoreCase("GIS-Site")
					|| ((ServiceForm)form).getType().equalsIgnoreCase("layer2-Site"))
					&&"false".equals(request.getParameter("ServiceMultiplexing"))) {
				((ServiceForm)form).setState("Request_Sent");
			}
			//submit date
			if (((ServiceForm)form).getSubmitDate() != null)
				allParameters.put("submitdate", ((ServiceForm)form).getSubmitDate());
			//modify date
			if (((ServiceForm)form).getModifyDate() != null)
				allParameters.put("modifydate", ((ServiceForm)form).getModifyDate());
			//SERVICE TYPE
			String serviceType = ((ServiceForm)form).getType();
			if (((ServiceForm)form).getType() != null) {
				serviceType = ((ServiceForm)form).getType();
				allParameters.put("type", serviceType);
			}
			//customer id
			if (((ServiceForm)form).getCustomerid() != null)
				allParameters.put("customerid", ((ServiceForm)form).getCustomerid());
			//parentservice id
			if (((ServiceForm)form).getParentserviceid() != null)
				allParameters.put("parentserviceid", ((ServiceForm)form).getParentserviceid());
			//logger.debug("req messageid ============> "+request.getParameter("messageid"));
			//logger.debug("formbean  messageid ============> "+((ServiceForm)form).getMessageid());
			//MESSAGE ID
			if (((ServiceForm)form).getMessageid() != null) {
				allParameters.put("messageid", ((ServiceForm)form).getMessageid());
			} else {
				logger.error(" ADDSERVICEACTION :::::Message id was not set, cannot complete service action  ");
				throw new Exception("Message id was not set, cannot complete service action");
			}
			//REGION
			if (((ServiceForm)form).getSP_PW_aEnd_region() != null) {
				//This may not be regquired after PR17619 (NBI Changes for Flowthrough Activation)
				//but it needs to be investigated whether to remove "Region" update
				allParameters.put("Region", ((ServiceForm)form).getSP_PW_aEnd_region());
				ServiceParameter serviceParameter = new ServiceParameter();
				serviceParameter.setServiceid(serviceid);
				serviceParameter.setAttribute("Region");
				serviceParameter.setValue(((ServiceForm)form).getSP_PW_aEnd_region());
				serviceParameterVector.add(serviceParameter);
			}
			//  Build a comma seperated list of static routes.
			if (((ServiceForm)form).getStaticCounter() != null && ((ServiceForm)form).getSP_RoutingProtocol() != null
					&& ((ServiceForm)form).getSP_RoutingProtocol().equals("STATIC")) {
				addressFamily = request.getParameter("SP_AddressFamily");
				if (addressFamily == null){
					addressFamily=ServiceUtils.getServiceParam(con, curVPNId ,"AddressFamily");
				}
				int staticCounter = Integer.parseInt(((ServiceForm)form).getStaticCounter());
				String staticRoutes = "";

				for (int k = 0; k < staticCounter; k++) {
					if (request.getParameter("route" + k) != null && request.getParameter("mask" + k) != null) {
						String route = request.getParameter("route" + k);
						String mask  = request.getParameter("mask" + k);
						try{
							if((route == null || "".equals(route)) || (mask == null || "".equals(mask))){
								throw new Exception("Static Route at Row no "+(k+1)+" must have a value");
								
							}
							IPAddressHelper.validateCIDRAddress(route +"/"+ mask , addressFamily);
							
							/***** new logic *****************/
							if(addressFamily.equalsIgnoreCase("IPv4")) {
							int V1= 32 -Integer.parseInt(mask);
							int n=2;
							int V2= (int)Math.pow(n,V1);
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
							
							staticRoutes += request.getParameter("route" + k);
							staticRoutes += "/";
							staticRoutes += request.getParameter("mask" + k);
							
							if (k < staticCounter - 1) {
								staticRoutes += ",";
							}
						}
						catch(Exception e){
							error = true;
							for (int ki = 0; ki < staticCounter; ki++) {
								String tempRoute = request.getParameter("route" + ki);
								String tempMask = request.getParameter("mask" + ki);
								request.setAttribute("mask"+ki, tempMask);
								request.setAttribute("route"+ki, tempRoute);
							}
//PreAddServiceAction preaddAction = new PreAddServiceAction();
							request.setAttribute("Message", e.getMessage());
							request.setAttribute("ServiceForm", form);
//ActionForward actionforward = preaddAction.execute(mapping, form, request, response);
							logger.debug("AddServiceAction: " + e.getMessage());
							return mapping.findForward(Constants.FAILURE);
						}
					}
				}
				// Save the static routes a service parameter!
				ServiceParameter serviceParameter = new ServiceParameter();
				serviceParameter.setServiceid(serviceid);
				serviceParameter.setAttribute("STATIC_Routes");
				serviceParameter.setValue(staticRoutes);
				serviceParameterVector.add(serviceParameter);
				allParameters.put("STATIC_Routes", staticRoutes);
			}
			/* ************* logic for Prefix list BGP ************************/
			
			
			if (((ServiceForm)form).getPrefixCounter() != null && ((ServiceForm)form).getSP_RoutingProtocol() != null
					&& ((ServiceForm)form).getSP_RoutingProtocol().equals("BGP")) {
				
				
				addressFamily = request.getParameter("SP_AddressFamily");
				if (addressFamily == null){
					addressFamily=ServiceUtils.getServiceParam(con, curVPNId ,"AddressFamily");
				}
				int prefixCounter = Integer.parseInt(((ServiceForm)form).getPrefixCounter());
				String prefixRoutes = "";

				for (int k = 0; k < prefixCounter; k++) {
					if (request.getParameter("prefixroute" + k) != null && request.getParameter("prefixmask" + k) != null) {
						String route = request.getParameter("prefixroute" + k);
						String mask  = request.getParameter("prefixmask" + k);
						String lemask=request.getParameter("lemask"+ k);
						try{
							if((route == null || "".equals(route)) || (mask == null || "".equals(mask))){
								throw new Exception("Prefix Route at Row no "+(k+1)+" must have a value");
								
							}
							IPAddressHelper.validateCIDRAddress(route +"/"+ mask , addressFamily);
							prefixRoutes += request.getParameter("prefixroute" + k);
							prefixRoutes += "/";
							prefixRoutes += request.getParameter("prefixmask" + k);
							
							if(lemask!=null && !"".equals(lemask))
							{
								// append the le mask
								prefixRoutes +=" le ";
								prefixRoutes += request.getParameter("lemask" + k);
							}
							
							if (k < prefixCounter - 1) {
								prefixRoutes += ",";
							}
						}
						catch(Exception e){
							error = true;
							for (int ki = 0; ki < prefixCounter; ki++) {
								String tempRoute = request.getParameter("prefixroute" + ki);
								String tempMask  = request.getParameter("prefixmask" + ki);
								String templemask = request.getParameter("lemask"+ki);
								
								request.setAttribute("prefixmask"+ki, tempMask);
								request.setAttribute("prefixroute"+ki, tempRoute);
							}
							PreAddServiceAction preaddAction = new PreAddServiceAction();
							request.setAttribute("Message", e.getMessage());
							request.setAttribute("ServiceForm", (ServiceForm)form);
							ActionForward actionforward = preaddAction.execute(mapping, form, request, response);
							logger.debug("AddServiceAction: " + e.getMessage());
							return mapping.findForward(Constants.FAILURE);
						}
					}
				}
				
				// Save the static routes a service parameter!
				ServiceParameter serviceParameter = new ServiceParameter();
				serviceParameter.setServiceid(serviceid);
				serviceParameter.setAttribute("PREFIX_Routes");
				serviceParameter.setValue(prefixRoutes);
				serviceParameterVector.add(serviceParameter);
				allParameters.put("PREFIX_Routes", prefixRoutes);
			}
			
			Enumeration parametersNames = request.getParameterNames();
			String parameter = null;
			String parameterValue = null;
			String[] parameterInterfaceValue=null; // Trunk code
			//code for the set of interfaces..
			  	while (parametersNames.hasMoreElements()) {
				parameter = (String) parametersNames.nextElement();
				if (parameter != null && parameter.startsWith("SP_")) {
					if (parameter.equalsIgnoreCase("SP_StartTime") || parameter.equalsIgnoreCase("SP_EndTime")) {
						parameterValue = request.getParameter(parameter);
						if (parameterValue != null)
							parameterValue = formatTime(parameterValue);
					} else {
						       //added
						if (parameter.contains("SP_PEInterface_aEnd")||parameter.contains("SP_PEInterface_zEnd"))
						{
							parameterInterfaceValue = request.getParameterValues(parameter);
							parameterValue = Arrays.toString(parameterInterfaceValue);
						}
						else  
						{      //original
							parameterValue = request.getParameter(parameter);	
						}
					}
					parameter = parameter.substring(3);
					logger.debug("AddServiceAction::::::::::::> PARAM : " + parameter + " Value: " + parameterValue);
					if (parameterValue != null) {
						ServiceParameter serviceParameter = new ServiceParameter();
						serviceParameter.setServiceid(serviceid);
						serviceParameter.setAttribute(parameter);
						serviceParameter.setValue(parameterValue);
						serviceParameterVector.add(serviceParameter);
						allParameters.put(parameter, parameterValue);
					}
				}
			}
			  	
			// Put IGW subinterface parameters into allParameters to be sent by XML
			HashMap<String, HashMap<String,String>> sub_interface_list = (HashMap<String, HashMap<String,String>>)session.getAttribute("sub_interface_list");
			if (sub_interface_list != null) {
			  Set<Entry<String, HashMap<String, String>>> hashMaps = sub_interface_list.entrySet();
			  Iterator<Entry<String, HashMap<String, String>>> hashMapsIterator = hashMaps.iterator();
			  while (hashMapsIterator.hasNext()) {
			    Entry<String, HashMap<String, String>> hashMapValue = hashMapsIterator.next();
			    HashMap<String, String> hashMap = hashMapValue.getValue();
			    Iterator<String> keyIterator = hashMap.keySet().iterator();
			    while (keyIterator.hasNext()) {
                  String key = keyIterator.next();
                  String value = hashMap.get(key);
                  if (allParameters.containsKey(key)) {
                    allParameters.put(key, allParameters.get(key) + "," + value);
                  } else {
                    allParameters.put(key, value);
                  }
                }
			  }
			}

			String attachment_service_id="";
			((ServiceForm)form).setLastUpdateTime(new java.util.Date().getTime());
			Date date = new Date(System.currentTimeMillis());
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			String sDate = "";
			if (date != null) {
				sDate = String.valueOf(sdf.format(date));
			}
			((ServiceForm)form).setSubmitDate(sDate);
			((ServiceForm)form).setModifyDate(sDate);
			Date startTimeDate = new Date();
			Date endTimeDate = new Date();
			String StartTime = request.getParameter("SP_StartTime");
			String EndTime = request.getParameter("SP_EndTime");
			if (StartTime != null && !StartTime.equalsIgnoreCase("")) {
				StartTime = formatTime(StartTime);
				startTimeDate = Constants.SCHEDULED_DATE_FORMAT.parse(StartTime, new ParsePosition(0));
			}
			if (EndTime != null && !EndTime.equalsIgnoreCase("")) {
				EndTime = formatTime(EndTime);
				endTimeDate = Constants.SCHEDULED_DATE_FORMAT.parse(EndTime, new ParsePosition(0));
			}
			if (StartTime != null && EndTime != null && !StartTime.equalsIgnoreCase("") && !EndTime.equalsIgnoreCase("")
					&& (endTimeDate.getTime() - startTimeDate.getTime()) <= 0) {
				error = true;
				strMessage = "EndTime must be later than StartTime";
				throw new IllegalStateException("EndTime must be later than StartTime");
			}
			//    The bean must be stored now, to avoid race conditions with the sync. threads
			if (((ServiceForm)form).getType().equals("layer3-VPN")||((ServiceForm)form).getType().equals("GIS-VPN")) {
				storeService(con, service, (ServiceForm)form, resend);
			} else if (((ServiceForm)form).getType().equals("layer2-VPN")) {
				storeService(con, service, (ServiceForm)form, resend);
				ServiceUtils.saveOrUpdateParameter(con, serviceid, Constants.PARAMETER_LAST_COMMIT,
						CreateL2VPNStateListener.class.getName());
				serviceParameterVector.remove(Constants.PARAMETER_LAST_COMMIT);

			} else if (((ServiceForm)form).getType().equals("layer2-VPWS")) {
				// store VPWS VPN service
				//by KK
				String stateSet=((ServiceForm)form).getState();
				
				if(((ServiceForm)form).getSP_Vlan_Flag_aEnd().equals("true")){
					
					((ServiceForm)form).setSP_UNIType_aEnd("PortVlan");
				}
				
				if(((ServiceForm)form).getSP_Vlan_Flag_zEnd().equals("true")){
					
					((ServiceForm)form).setSP_UNIType_zEnd("PortVlan");
				}
				
				
				boolean scheduledRequest=false;
				if(stateSet.startsWith("Sched")){
					scheduledRequest=true;
				}
				boolean vpwsCreationFailed=false;
				boolean vpwsSiteCreationFailed=false;
				String vpwsVPNId=null;
				//////If resending request determine from which point
				if(resend.equalsIgnoreCase("true")){
				    //check if the VPWS creation failed
            	    vpwsVPNId=((ServiceForm)form).getServiceid();
            	    String vpwsFailureStatus=ServiceUtils.getServiceParam(con, vpwsVPNId,Constants.SERVICE_PARAM_FAILURE_STATUS);
            	    if(vpwsFailureStatus!=null && vpwsFailureStatus.equals(Constants.SERVICE_PARAM_VALUE_VPWS_FAILURE)){
            		    //allParameters.put(Constants.XSLPARAM_XSLNAME,Constants.XSLNAME_CREATE_L2VPWS);
            		    allParameters.remove(Constants.XSLPARAM_XSLNAME);
            		    vpwsCreationFailed=true;
            	    } else {
            	    	//check if site creation has failed
            	    	String aEndSiteId=((ServiceForm)form).getSP_Site_Service_ID_aEnd();
            	    	String zEndSiteId=((ServiceForm)form).getSP_Site_Service_ID_zEnd();
            	    	String aEndSiteFailureStatus=ServiceUtils.getServiceParam(con, aEndSiteId,Constants.SERVICE_PARAM_FAILURE_STATUS);
            	    	if(aEndSiteFailureStatus!=null && aEndSiteFailureStatus.equals(Constants.SERVICE_PARAM_VALUE_SITE_FAILURE)){
            	    		vpwsSiteCreationFailed=true;
            	    	} else{
            	    		String zEndSiteFailureStatus=ServiceUtils.getServiceParam(con, zEndSiteId,Constants.SERVICE_PARAM_FAILURE_STATUS);
            	    		if(zEndSiteFailureStatus!=null && zEndSiteFailureStatus.equals(Constants.SERVICE_PARAM_VALUE_SITE_FAILURE)){
            	    			vpwsSiteCreationFailed=true;
            	    		}
            	    	}
            	    }
				}
				//////
                if(!resend.equalsIgnoreCase("true")){
                   ((ServiceForm)form).setState(Constants.STATE_REQUEST_SENT);
                }else{
                	if(vpwsCreationFailed){
                		((ServiceForm)form).setState(Constants.STATE_REQUEST_SENT);
                	}else{
                        ((ServiceForm)form).setState(Constants.SERVICE_STATE_OK);
                	}
                }

				//by KK
				storeService(con, service, (ServiceForm)form, resend);
				ServiceUtils.saveOrUpdateParameter(con, service.getServiceid(), Constants.SERVICE_PARAM_OPERATOR, (String) session.getAttribute(Constants.USER_KEY));
				//by KK
				if(scheduledRequest){
					((ServiceForm)form).setState(Constants.STATE_SCHED_REQUEST_SENT);
				}else{
					((ServiceForm)form).setState(Constants.STATE_REQUEST_SENT);
				}
				//by KK

				// handle aEnd new record
				VPNMembership amem = new VPNMembership();
				Service aEndAttach = copyService(service);

				if ("true".equals(request.getParameter("ServiceMultiplexing_aEnd"))) {
					amem.setConnectivitytype("VPWS_REUSED" + request.getParameter("SP_PW_aEndlist"));
					aEndAttach.setParentserviceid(request.getParameter("SP_PW_aEndlist"));

					allParameters.put("Site_Service_ID_aEnd", request.getParameter("SP_PW_aEndlist"));
					if((request.getParameter("SP_PW_aEndlist")).equalsIgnoreCase("")){
						allParameters.put("Site_Service_ID_aEnd", request.getParameter("SP_Site_Service_ID_aEnd"));
						serviceParameterVector.add(new ServiceParameter(((ServiceForm)form).getServiceid(), "Site_Service_ID_aEnd", request.getParameter("SP_Site_Service_ID_aEnd")));
					} else {
						serviceParameterVector.add(new ServiceParameter(((ServiceForm)form).getServiceid(), "Site_Service_ID_aEnd", request.getParameter("SP_PW_aEndlist")));
					}

					//          Service asite = Service.findByServiceid(con, request.getParameter("SP_PW_aEndlist"));
					//          asite.setState(((ServiceForm)form).getState());
					//          ServiceUtils.updateService(con, asite);
				} else {
					amem.setConnectivitytype("VPWS_NEW" + ((ServiceForm)form).getSP_Site_Service_ID_aEnd());
					aEndAttach.setParentserviceid(((ServiceForm)form).getSP_Site_Service_ID_aEnd());
					// store new aEnd site
					Service asite = copyService(service);
                    //By KK
                    if(!resend.equalsIgnoreCase("true")){
                       asite.setState(Constants.STATE_REQUEST_SENT);
                    }else{
                    	if(vpwsCreationFailed || vpwsSiteCreationFailed){
                    		asite.setState(Constants.STATE_REQUEST_SENT);
                    	}else{
                            asite.setState(Constants.SERVICE_STATE_OK);
                    	}
                    }
                    //By KK
					asite.setServiceid(((ServiceForm)form).getSP_Site_Service_ID_aEnd());
					asite.setPresname(((ServiceForm)form).getSP_PW_aEnd());

					asite.setType("Site");
					asite.setParentserviceid(null);

					if(resend == null || !resend.equals("true")){
						asite.store(con);
					} else {
						asite.update(con);
					}
					ServiceUtils.saveOrUpdateParameter(con, ((ServiceForm)form).getSP_Site_Service_ID_aEnd(), Constants.SERVICE_PARAM_OPERATOR, (String) session.getAttribute(Constants.USER_KEY));
					
					if ("VPWS-PortVlan".equals(((ServiceForm)form).getSP_EthType_aEnd())){
						//              if(request.getAttribute("VLANIdaEnd")==null || request.getAttribute("VLANIdaEnd").equals("")){
						//
						//                allParameters.put("VLANIdaEnd", "0");
						//
						//              }
					}

					if("FrameRelay".equals(((ServiceForm)form).getSP_PW_Type_aEnd())){
						if(request.getAttribute("DLCIaEnd")==null || request.getAttribute("DLCIaEnd").equals("")){
							allParameters.put("DLCIaEnd", "0");
						}
					}

				}
				// store aEnd attachment
				aEndAttach.setServiceid(request.getParameter("SP_Site_Attachment_ID_aEnd"));
				aEndAttach.setPresname(((ServiceForm)form).getSP_PW_aEnd()+"vpws-Attachment");
				aEndAttach.setType("vpws-Attachment");
				if(resend.equals("true")){

					aEndAttach.setParentserviceid(request.getParameter("SP_Site_Service_ID_aEnd"));
				}

                if(((ServiceForm)form).getState()!=null && ((ServiceForm)form).getState().equalsIgnoreCase(Constants.STATE_SCHED_REQUEST_SENT)){
                    aEndAttach.setState(Constants.STATE_SCHED_REQUEST_SENT);
				} else {
					aEndAttach.setState("PE_" + ((ServiceForm)form).getState());
				}
				if(resend == null || !resend.equals("true")){
					aEndAttach.store(con);
				} else {
					aEndAttach.update(con);
				}
				ServiceUtils.saveOrUpdateParameter(con, (String)request.getParameter("SP_Site_Attachment_ID_aEnd"), Constants.SERVICE_PARAM_OPERATOR, (String) session.getAttribute(Constants.USER_KEY));
				//store aEnd VPN-Attachment relationship
				amem.setVpnid(serviceid);
				amem.setSiteattachmentid(aEndAttach.getServiceid());
				if(resend == null || !resend.equals("true")){
					amem.store(con);
				}
				logger.debug("Stored the aEnd VPNMembership: " + amem.toString());

				// handle zEnd new record
				VPNMembership zmem = new VPNMembership();
				Service zEndAttach = copyService(service);
				if ("true".equals(request.getParameter("ServiceMultiplexing_zEnd"))) {
					zmem.setConnectivitytype("VPWS_REUSED" + request.getParameter("SP_PW_zEndlist"));

					allParameters.put("Site_Service_ID_zEnd", request.getParameter("SP_PW_zEndlist"));
					zEndAttach.setParentserviceid(request.getParameter("SP_PW_zEndlist"));
					if((request.getParameter("SP_PW_zEndlist")).equalsIgnoreCase("")){
						allParameters.put("Site_Service_ID_zEnd", request.getParameter("SP_Site_Service_ID_zEnd"));
						serviceParameterVector.add(new ServiceParameter(((ServiceForm)form).getServiceid(), "Site_Service_ID_zEnd", request.getParameter("SP_Site_Service_ID_zEnd")));
					} else {
						serviceParameterVector.add(new ServiceParameter(((ServiceForm)form).getServiceid(), "Site_Service_ID_zEnd", request.getParameter("SP_PW_zEndlist")));
					}
					//          Service zsite = Service.findByServiceid(con, request.getParameter("SP_PW_zEndlist"));
					//          zsite.setState(((ServiceForm)form).getState());
					//          ServiceUtils.updateService(con, zsite);
				} else {
					zmem.setConnectivitytype("VPWS_NEW" + ((ServiceForm)form).getSP_Site_Service_ID_zEnd());
					zEndAttach.setParentserviceid(((ServiceForm)form).getSP_Site_Service_ID_zEnd());
					// store new aEnd site
					Service zsite = copyService(service);
                    //By KK
                    if(!resend.equalsIgnoreCase("true")){
                       zsite.setState(Constants.STATE_REQUEST_SENT);
                    }else{
                    	if(vpwsCreationFailed || vpwsSiteCreationFailed){
                    		zsite.setState(Constants.STATE_REQUEST_SENT);
                    	}else{
                            zsite.setState(Constants.SERVICE_STATE_OK);
                    	}
                    }
                    //By KK
					zsite.setServiceid(((ServiceForm)form).getSP_Site_Service_ID_zEnd());
					zsite.setPresname(((ServiceForm)form).getSP_PW_zEnd());
					zsite.setType("Site");
					zsite.setParentserviceid(null);

					if(resend == null || !resend.equals("true")){
						zsite.store(con);
					} else {
						zsite.update(con);
					}
					ServiceUtils.saveOrUpdateParameter(con, ((ServiceForm)form).getSP_Site_Service_ID_zEnd(), Constants.SERVICE_PARAM_OPERATOR, (String) session.getAttribute(Constants.USER_KEY));


					if ("VPWS-PortVlan".equals(((ServiceForm)form).getSP_EthType_zEnd())) {
						//            if(request.getAttribute("VLANIdzEnd")==null || request.getAttribute("VLANIdzEnd").equals("")){
						//
						//              allParameters.put("VLANIdzEnd", "0");
						//
						//            }
					}

					if("FrameRelay".equals(((ServiceForm)form).getSP_PW_Type_zEnd())){
						if(request.getAttribute("DLCIzEnd")==null || request.getAttribute("DLCIzEnd").equals("")){
							allParameters.put("DLCIzEnd", "0");
						}
					}
				}
				// store zEnd attachment
				zEndAttach.setServiceid(request.getParameter("SP_Site_Attachment_ID_zEnd"));
				zEndAttach.setPresname(((ServiceForm)form).getSP_PW_zEnd()+"vpws-Attachment");
				zEndAttach.setType("vpws-Attachment");

				//Modified by Rama since we are not updating the Parent Service id
				if(resend.equals("true")){

					zEndAttach.setParentserviceid(request.getParameter("SP_Site_Service_ID_zEnd"));
				}

                if(((ServiceForm)form).getState()!=null && ((ServiceForm)form).getState().equalsIgnoreCase(Constants.STATE_SCHED_REQUEST_SENT)){
                    zEndAttach.setState(Constants.STATE_SCHED_REQUEST_SENT);
				} else {
					zEndAttach.setState("PE_" + ((ServiceForm)form).getState());
				}
				if(resend == null || !resend.equals("true")){
					zEndAttach.store(con);
				} else {
					zEndAttach.update(con);
				}
				ServiceUtils.saveOrUpdateParameter(con, (String)request.getParameter("SP_Site_Attachment_ID_zEnd"), Constants.SERVICE_PARAM_OPERATOR, (String) session.getAttribute(Constants.USER_KEY));

				// store zEnd VPN-Attachment relationship
				zmem.setVpnid(serviceid);
				zmem.setSiteattachmentid(zEndAttach.getServiceid());

				if(resend == null || !resend.equals("true")){
					zmem.store(con);
				}
				logger.debug("Stored the zEnd VPNMembership: " + zmem.toString());

				ServiceUtils.saveOrUpdateParameter(con, ((ServiceForm)form).getServiceid(), Constants.PARAMETER_LAST_COMMIT,
						CreateL2VPWSVPNStateListener.class.getName());
				serviceParameterVector.remove(Constants.PARAMETER_LAST_COMMIT);
                //by KK
                if(!resend.equals("true")){
                   allParameters.remove(Constants.START_TIME);
                   allParameters.remove(Constants.END_TIME);
                }

                if(resend.equals("true")){

                	if(vpwsCreationFailed){
                		//allParameters.put(Constants.XSLPARAM_XSLNAME,Constants.XSLNAME_CREATE_L2VPWS);
                		allParameters.remove(Constants.XSLPARAM_XSLNAME);
                	}else{
                	    if(vpwsSiteCreationFailed){
                	    	//check which site request to send
                	    	boolean aEndSiteReused=ServiceUtils.getServiceParam(con, serviceid,Constants.SERVICE_PARAM_SERVICEMULTIPLEXING_AEND).equalsIgnoreCase("true");
                            boolean zEndSiteReused=ServiceUtils.getServiceParam(con, serviceid,Constants.SERVICE_PARAM_SERVICEMULTIPLEXING_ZEND).equalsIgnoreCase("true");
                            Service siteService=null;
                            String siteServiceId=null;
                            if ( aEndSiteReused && zEndSiteReused ) {
                            	allParameters.put(Constants.SERVICE_PARAM_VPN_ID, serviceid);
                                allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_ADD);
                                allParameters.put(Constants.XSLPARAM_XSLNAME,Constants.XSLNAME_L2VPWS_ATTACHMENT);
                            } else if ( aEndSiteReused || zEndSiteReused ) {
                            	//One of the site is reused. Send site creation request for the other one.
                                siteServiceId=aEndSiteReused ? ServiceUtils.getServiceParam(con, serviceid,Constants.SERVICE_PARAM_SITE_SERVICE_ID_ZEND) : ServiceUtils.getServiceParam(con, serviceid,Constants.SERVICE_PARAM_SITE_SERVICE_ID_AEND);
                                siteService=Service.findByPrimaryKey(con, siteServiceId);
                                String serviceIdOfToBeCreatedService=siteServiceId;

                                //We need to the site name as Presname for Create Site
                                if(siteService != null) {

                                	String presname = siteService.getPresname();
                                	allParameters.put("presname", presname);
                                }
                                allParameters.put(Constants.XSLPARAM_XSLNAME, Constants.XSLNAME_SITE);
                                allParameters.put(Constants.XSLPARAM_CUSTOMERID,siteService.getCustomerid());
                            } else{
                            	siteServiceId=ServiceUtils.getServiceParam(con, serviceid,Constants.SERVICE_PARAM_SITE_SERVICE_ID_AEND);
                            	allParameters.put(Constants.XSLPARAM_SERVICEID, siteServiceId);
                            	allParameters.put(Constants.XSLPARAM_XSLNAME, Constants.XSLNAME_SITES);
                            }
                            if ( siteService != null ) {
                            	allParameters.put(Constants.XSLPARAM_SERVICEID, siteServiceId);
                                allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_CREATE);
                                allParameters.put(Constants.XSLPARAM_CUSTOMERID,siteService.getCustomerid());
                            }
                	    } else{
                	       //check if site creation failed
                           allParameters.put(Constants.SERVICE_PARAM_VPN_ID, serviceid);
                           allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_ADD);
                           allParameters.put(Constants.XSLPARAM_XSLNAME,Constants.XSLNAME_L2VPWS_ATTACHMENT);
                	    }
                	}
                }
                //by KK --

			}
			
			else if (((ServiceForm)form).getType().equals("Trunk")) {
				// store VPWS VPN service
				
				// Store in DB  - CR_TRunk , CR_TrunkSides , CR_trunkSubinterfaces
				System.out.print("Service id "+((ServiceForm)form).getServiceid());
				
				//System.out.print("trunk_name "+((ServiceForm)form).getPresname());						
				//by KK
//String stateSet=((ServiceForm)form).getState();
				//System.out.print("stateSet "+stateSet+" resend val"+ resend);
				
			//	ServiceUtils.saveorUpdateTrunk(con, ((ServiceForm)form),(HashMap<String,List<List<String>>>)session.getAttribute("sub_interface_list"));
								
			
				storeService(con, service, (ServiceForm)form, resend);
				/*ServiceUtils.saveOrUpdateParameter(con, serviceid, Constants.PARAMETER_LAST_COMMIT,
						CreateTrunkStateListener.class.getName());*/
				//serviceParameterVector.remove(Constants.PARAMETER_LAST_COMMIT);

			} 			
			//ENd of code Trunk
					
			
			else if (((ServiceForm)form).getType().equals("layer3-Site")) {
				
				if ("true".equals(request.getParameter("ServiceMultiplexing"))) {
					// store attachment for multi service
					attachment_service_id= idGenerator.getServiceId();
					Service l3attach = Service.findByPrimaryKey(con, serviceid);
					l3attach.setServiceid(attachment_service_id);
					l3attach.setPresname(l3attach.getPresname() + "layer3-Attachment");
					l3attach.setType("layer3-Attachment");
					l3attach.setParentserviceid(serviceid);
					// mulit service need change the state from OK back to Request_Sent


					l3attach.setState(((ServiceForm)form).getState());
					l3attach.store(con);

					VPNMembership mem = new VPNMembership();
					mem.setVpnid(((ServiceForm)form).getParentserviceid());
					mem.setSiteattachmentid(attachment_service_id);
					mem.setConnectivitytype(request.getParameter("SP_ConnectivityType"));
					mem.store(con);
					logger.debug("Stored the VPNMembership: " + mem.toString());
					//logger.debug("===vpnserviceid= " + ((ServiceForm)form).getParentserviceid()+" parentserviceid="+((ServiceForm)form).getServiceid()+" serviceid is="+attachment_service_id);
					allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_ADD);
				    allParameters.put(Constants.XSLPARAM_ADDRESS_TYPE, Constants.IP_ADDR_V4);
					allParameters.put("vpnserviceid", ((ServiceForm)form).getParentserviceid());
					allParameters.put("parentserviceid", ((ServiceForm)form).getServiceid());
					allParameters.put("serviceid", attachment_service_id);
					allParameters.put("type", "layer3-Attachment");
					allParameters.put("presname",((ServiceForm)form).getPresname()+"layer3-Attachment");
					
					//handle managed CE router.
					if (request.getParameter("SP_Managed_CE_Router") != null) {
						logger.debug("Reused a non l3 site, Managed_CE_Router: " + request.getParameter("SP_Managed_CE_Router"));
					} else {
						String managedCERouter = ServiceUtils.getServiceParam(con, serviceid, "Managed_CE_Router");
						logger.debug("Get Managed_CE_Router from Service Parameter: " + managedCERouter);
						allParameters.put("Managed_CE_Router", managedCERouter);
						serviceParameterVector.add(new ServiceParameter(serviceid,"Managed_CE_Router",managedCERouter));
					}
					// For modification

					for (Enumeration e = serviceParameterVector.elements(); e.hasMoreElements();) {
						ServiceParameter temp = (ServiceParameter)e.nextElement();
						ServiceUtils.saveOrUpdateParameter(con, attachment_service_id, temp.getAttribute(),
								temp.getValue());
						logger.debug(temp.getAttribute() + "::::::" + temp.getValue());
					}

					ServiceUtils.saveOrUpdateParameter(con, attachment_service_id, "vpnserviceid",((ServiceForm)form).getParentserviceid());
					//logger.debug("vpnserviceid has been changed to" + "::::::" + ((ServiceForm)form).getParentserviceid());

				} else {
					//System.out.println("=======CreateL3SiteListener create attach========="+serviceid);
					allParameters.put(Constants.XSLPARAM_XSLNAME,Constants.XSLNAME_SITE);
					storeService(con, service, (ServiceForm)form, resend);
					service.setParentserviceid(null);
					ServiceUtils.updateService(con, service);
					ServiceUtils.saveOrUpdateParameter(con, serviceid, Constants.PARAMETER_LAST_COMMIT, CreateL3SiteListener.class
							.getName());
				}
				if("false".equals(request.getParameter("ServiceMultiplexing"))) {
						ServiceUtils.saveOrUpdateParameter(con, serviceid, "l3vpnserviceid", ((ServiceForm)form).getParentserviceid());
				}
				serviceParameterVector.remove(Constants.PARAMETER_LAST_COMMIT);

			} 
			
			// Added for GIS - Anu
				else if (((ServiceForm)form).getType().equals("GIS-Site")) {
				
					
					
				if ("true".equals(request.getParameter("ServiceMultiplexing"))) {
					// store attachment for multi service
					
				
					
					attachment_service_id= idGenerator.getServiceId();
					Service gisattach = Service.findByPrimaryKey(con, serviceid);
					gisattach.setServiceid(attachment_service_id);
					gisattach.setPresname(gisattach.getPresname() + "GIS-Attachment");
					gisattach.setType("GIS-Attachment");
					gisattach.setParentserviceid(serviceid);
					// mulit service need change the state from OK back to Request_Sent


					gisattach.setState(((ServiceForm)form).getState());
					gisattach.store(con);

					VPNMembership mem = new VPNMembership();
					mem.setVpnid(((ServiceForm)form).getParentserviceid());
					mem.setSiteattachmentid(attachment_service_id);
					mem.setConnectivitytype(request.getParameter("SP_ConnectivityType"));
					mem.store(con);
					logger.debug("Stored the VPNMembership: " + mem.toString());
					//logger.debug("===vpnserviceid= " + ((ServiceForm)form).getParentserviceid()+" parentserviceid="+((ServiceForm)form).getServiceid()+" serviceid is="+attachment_service_id);
					allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_ADD);
				    allParameters.put(Constants.XSLPARAM_ADDRESS_TYPE, Constants.IP_ADDR_V4);
					allParameters.put("vpnserviceid", ((ServiceForm)form).getParentserviceid());
					allParameters.put("parentserviceid", ((ServiceForm)form).getServiceid());
					allParameters.put("serviceid", attachment_service_id);
					allParameters.put("type", "GIS-Attachment");
					allParameters.put("presname",((ServiceForm)form).getPresname()+"GIS-Attachment");
					
					//handle managed CE router.
					if (request.getParameter("SP_Managed_CE_Router") != null) {
						logger.debug("Reused a non gis site, Managed_CE_Router: " + request.getParameter("SP_Managed_CE_Router"));
					} else {
						String managedCERouter = ServiceUtils.getServiceParam(con, serviceid, "Managed_CE_Router");
						logger.debug("Get Managed_CE_Router from Service Parameter: " + managedCERouter);
						allParameters.put("Managed_CE_Router", managedCERouter);
						serviceParameterVector.add(new ServiceParameter(serviceid,"Managed_CE_Router",managedCERouter));
					}
					// For modification

					for (Enumeration e = serviceParameterVector.elements(); e.hasMoreElements();) {
						ServiceParameter temp = (ServiceParameter)e.nextElement();
						ServiceUtils.saveOrUpdateParameter(con, attachment_service_id, temp.getAttribute(),
								temp.getValue());
						logger.debug(temp.getAttribute() + "::::::" + temp.getValue());
					}

					ServiceUtils.saveOrUpdateParameter(con, attachment_service_id, "vpnserviceid",((ServiceForm)form).getParentserviceid());
					//logger.debug("vpnserviceid has been changed to" + "::::::" + ((ServiceForm)form).getParentserviceid());

				} else {
					//System.out.println("=======CreateL3SiteListener create attach========="+serviceid);
					allParameters.put(Constants.XSLPARAM_XSLNAME,Constants.XSLNAME_SITE);
					storeService(con, service, (ServiceForm)form, resend);
					service.setParentserviceid(null);
					ServiceUtils.updateService(con, service);
					ServiceUtils.saveOrUpdateParameter(con, serviceid, Constants.PARAMETER_LAST_COMMIT, CreateGISSiteListener.class.getName());
					
					//System.out.println("AddServiceAction.java::TESTING GIS::::Inside the ServiceMultiplexing FALSE");
				}
				//doubts
				if("false".equals(request.getParameter("ServiceMultiplexing"))) {
						ServiceUtils.saveOrUpdateParameter(con, serviceid, "gisvpnserviceid", ((ServiceForm)form).getParentserviceid());
				}
				serviceParameterVector.remove(Constants.PARAMETER_LAST_COMMIT);

			}
			else if (((ServiceForm)form).getType().equals("layer2-Site")) {

				if ("true".equals(request.getParameter("ServiceMultiplexing"))) {
					// store attachment for multi service
					attachment_service_id= idGenerator.getServiceId();
					Service l2attach = Service.findByPrimaryKey(con, serviceid);
					l2attach.setServiceid(attachment_service_id);
					l2attach.setPresname(l2attach.getPresname() + "layer2-Attachment");
					l2attach.setType("layer2-Attachment");
					l2attach.setParentserviceid(serviceid);
					// mulit service need change the state from OK back to Request_Sent
					l2attach.setState("PE_Request_Sent");
					l2attach.store(con);

					VPNMembership mem = new VPNMembership();
					mem.setVpnid(((ServiceForm)form).getParentserviceid());
					mem.setSiteattachmentid(attachment_service_id);
					mem.setConnectivitytype("LAYER2_REUSED" + serviceid);
					mem.store(con);
					logger.debug("Stored the VPNMembership: " + mem.toString());
					allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_ADD);
					allParameters.put("vpnserviceid", ((ServiceForm)form).getParentserviceid());
					allParameters.put("parentserviceid", ((ServiceForm)form).getServiceid());
					allParameters.put("serviceid", attachment_service_id);
					allParameters.put("type", "layer2-Attachment");
					allParameters.put("presname",((ServiceForm)form).getPresname()+"layer2-Attachment");
					// For modification
					serviceParameterVector.add(new ServiceParameter(((ServiceForm)form).getServiceid(), "vpnserviceid", ((ServiceForm)form).getParentserviceid()));
					ServiceUtils.saveOrUpdateParameter(con,attachment_service_id, "EthServiceType","VPLS-PortVlan");
					for (Enumeration e = serviceParameterVector.elements(); e.hasMoreElements();) {
						ServiceParameter temp = (ServiceParameter)e.nextElement();
						ServiceUtils.saveOrUpdateParameter(con, attachment_service_id, temp.getAttribute(),
								temp.getValue());
						logger.debug(temp.getAttribute() + "::::::" + temp.getValue());
					}
				} else {
					allParameters.put(Constants.XSLPARAM_XSLNAME,Constants.XSLNAME_SITE);
					storeService(con, service, (ServiceForm)form, resend);
					service.setParentserviceid(null);
					ServiceUtils.updateService(con, service);
				}
				ServiceUtils.saveOrUpdateParameter(con, serviceid, "l2vpnserviceid", ((ServiceForm)form).getParentserviceid());
				ServiceUtils.saveOrUpdateParameter(con, serviceid, Constants.PARAMETER_LAST_COMMIT,
						CreateL2VPNStateListener.class.getName());
				serviceParameterVector.remove(Constants.PARAMETER_LAST_COMMIT);

			} else if (((ServiceForm)form).getType().equals("layer3-Attachment")) {
				logger.debug("Attachment type: " + request.getParameter("SP_Attachmenttype"));
				String subType = request.getParameter("subType");
				addressFamily = request.getParameter("SP_AddressFamily");
				if (addressFamily == null){
					addressFamily=ServiceUtils.getServiceParam(con, curVPNId,"AddressFamily");
					ServiceUtils.saveOrUpdateParameter(con, service.getServiceid(), "AddressFamily", addressFamily);
				}
				allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_ADD);
				allParameters.put(Constants.XSLPARAM_ADDRESS_TYPE, Constants.IP_ADDR_V4);
				allParameters.put(Constants.XSLPARAM_ADDRESS_FAMILY, addressFamily);

				if (subType != null){
					((ServiceForm)form).setType(subType);
				}
				storeService(con, service, (ServiceForm)form, resend);

				String old_attachmentid =  request.getParameter("attachmentid");
				logger.debug("Be protected attachment id: " + old_attachmentid);

				if(subType!=null && subType.equals("layer3-Protection") && !"true".equals(resend)){
					ServiceUtils.saveOrUpdateParameter(con, service.getServiceid(), "attachmentid", old_attachmentid);
					ServiceUtils.saveOrUpdateParameter(con, service.getServiceid(), "Site_Service_id", ((ServiceForm)form).getParentserviceid());
				}
				VPNMembership[] olds = VPNMembership.findBySiteattachmentid(con, old_attachmentid);
				if (olds == null || olds.length < 1) {
					logger.error("Be protected attachment:" + old_attachmentid + " must belong to one vpn");
				} else if (olds.length > 1) {
					for (VPNMembership old : olds) {
						if (!old.getVpnid().equals(curVPNId)) {
							old.setSiteattachmentid(((ServiceForm)form).getServiceid());
							old.setConnectivitytype(request.getParameter("SP_ConnectivityType"));
							logger.debug("Stored the VPNMembership for LAYER3_PROTECTION: " + old.toString());
							old.store(con);
						}
					}
				}
				if(resend == null || !resend.equalsIgnoreCase("true")){
					VPNMembership mem = new VPNMembership();
					mem.setVpnid(curVPNId);
					mem.setSiteattachmentid(((ServiceForm)form).getServiceid());
					mem.setConnectivitytype(request.getParameter("SP_ConnectivityType"));
					mem.store(con);
					logger.debug("Stored the VPNMembership for LAYER3_PROTECTION: " + mem.toString());
				}
				if(resend != null || resend.equalsIgnoreCase("true")){
					//logger.debug("===vpnserviceid= " + ((ServiceForm)form).getParentserviceid()+" parentserviceid="+((ServiceForm)form).getServiceid()+" from reqeust vpnid is="+request.getParameter("SP_vpnserviceid"));
					//allParameters.put("vpnserviceid", ((ServiceForm)form).getParentserviceid());
				}


				for (Enumeration e = serviceParameterVector.elements(); e.hasMoreElements();) {
					ServiceParameter temp = (ServiceParameter)e.nextElement();
					ServiceUtils.saveOrUpdateParameter(con, ((ServiceForm)form).getServiceid(), temp.getAttribute(),
							temp.getValue());

					if("true".equals(resend)){
						ServiceUtils.saveOrUpdateParameter(con, ((ServiceForm)form).getParentserviceid(), temp.getAttribute(),
								temp.getValue());
					}
					logger.debug(temp.getAttribute() + "::::::" + temp.getValue());
				}
			} 
			
			// Added for GIS  - Anu
			else if (((ServiceForm)form).getType().equals("GIS-Attachment")) {
				logger.debug("Attachment type: " + request.getParameter("SP_Attachmenttype"));
				
				String subType = request.getParameter("subType");
				addressFamily = request.getParameter("SP_AddressFamily");
				if (addressFamily == null){
					addressFamily=ServiceUtils.getServiceParam(con, curVPNId,"AddressFamily");
					ServiceUtils.saveOrUpdateParameter(con, service.getServiceid(), "AddressFamily", addressFamily);
				}
				allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_ADD);
				allParameters.put(Constants.XSLPARAM_ADDRESS_TYPE, Constants.IP_ADDR_V4);
				allParameters.put(Constants.XSLPARAM_ADDRESS_FAMILY, addressFamily);

				if (subType != null){
					((ServiceForm)form).setType(subType);
				}
				
			//	System.out.print("Value of WAN IP in AddSErviceActions "+((ServiceForm)form).getSP_IPNetAddr());
				
				storeService(con, service, (ServiceForm)form, resend);

				String old_attachmentid =  request.getParameter("attachmentid");
				logger.debug("Be protected attachment id: " + old_attachmentid);

				if(subType!=null && subType.equals("GIS-Protection") && !"true".equals(resend)){
					ServiceUtils.saveOrUpdateParameter(con, service.getServiceid(), "attachmentid", old_attachmentid);
					ServiceUtils.saveOrUpdateParameter(con, service.getServiceid(), "Site_Service_id", ((ServiceForm)form).getParentserviceid());
				}
				VPNMembership[] olds = VPNMembership.findBySiteattachmentid(con, old_attachmentid);
				if (olds == null || olds.length < 1) {
					logger.error("Be protected attachment:" + old_attachmentid + " must belong to one vpn");
				} else if (olds.length > 1) {
					for (VPNMembership old : olds) {
						if (!old.getVpnid().equals(curVPNId)) {
							old.setSiteattachmentid(((ServiceForm)form).getServiceid());
							old.setConnectivitytype(request.getParameter("SP_ConnectivityType"));
							logger.debug("Stored the VPNMembership for GIS_PROTECTION: " + old.toString());
							old.store(con);
						}
					}
				}
				if(resend == null || !resend.equalsIgnoreCase("true")){
					VPNMembership mem = new VPNMembership();
					mem.setVpnid(curVPNId);
					mem.setSiteattachmentid(((ServiceForm)form).getServiceid());
					mem.setConnectivitytype(request.getParameter("SP_ConnectivityType"));
					mem.store(con);
					logger.debug("Stored the VPNMembership for GIS_PROTECTION: " + mem.toString());
				}
				if(resend != null || resend.equalsIgnoreCase("true")){
					//logger.debug("===vpnserviceid= " + ((ServiceForm)form).getParentserviceid()+" parentserviceid="+((ServiceForm)form).getServiceid()+" from reqeust vpnid is="+request.getParameter("SP_vpnserviceid"));
					//allParameters.put("vpnserviceid", ((ServiceForm)form).getParentserviceid());
				}


				for (Enumeration e = serviceParameterVector.elements(); e.hasMoreElements();) {
					ServiceParameter temp = (ServiceParameter)e.nextElement();
					ServiceUtils.saveOrUpdateParameter(con, ((ServiceForm)form).getServiceid(), temp.getAttribute(),
							temp.getValue());

					if("true".equals(resend)){
						ServiceUtils.saveOrUpdateParameter(con, ((ServiceForm)form).getParentserviceid(), temp.getAttribute(),
								temp.getValue());
					}
					logger.debug(temp.getAttribute() + "::::::" + temp.getValue());
				}
			}
			
			
			else if (((ServiceForm)form).getType().equals("layer2-Attachment")){
				allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_ADD);
				allParameters.put(Constants.XSLPARAM_ADDRESS_TYPE, Constants.IP_ADDR_V4);
				((ServiceForm)form).setState("PE_Request_Sent");
				storeService(con, service, (ServiceForm)form, resend);
			} else {
				logger.debug("Specific service type: " + ((ServiceForm)form).getType());
				storeService(con, service, (ServiceForm)form, resend);
			}
			
//		  Build a comma seperated list of static routes.
            if (((ServiceForm)form).getStaticCounter() != null && ((ServiceForm)form).getSP_RoutingProtocol() != null
                    && ((ServiceForm)form).getSP_RoutingProtocol().equals("STATIC")) {
                addressFamily = request.getParameter("SP_AddressFamily");
                if (addressFamily == null){
                    addressFamily=ServiceUtils.getServiceParam(con, curVPNId ,"AddressFamily");
                }
                int staticCounter = Integer.parseInt(((ServiceForm)form).getStaticCounter());
                String staticRoutes = "";           
                
                for (int k = 0; k < staticCounter; k++) {
                    if (request.getParameter("route" + k) != null && request.getParameter("mask" + k) != null) {
                        StaticRoute routes= new StaticRoute(); 
                        String staticRoute="";
                        String route = request.getParameter("route" + k);
                        String mask  = request.getParameter("mask" + k);
                        try{
                            if((route == null || "".equals(route)) || (mask == null || "".equals(mask))){
                                throw new Exception("Static Route at Row no "+(k+1)+" must have a value");
                                
                            }
                            IPAddressHelper.validateCIDRAddress(route +"/"+ mask , addressFamily);
                            staticRoutes += request.getParameter("route" + k);
                            staticRoutes += "/";
                            staticRoutes += request.getParameter("mask" + k);
                            
                            staticRoute += request.getParameter("route" + k);
                            staticRoute += "/";
                            staticRoute += request.getParameter("mask" + k);
                            routes.setStaticrouteaddress(staticRoute);
                            routes.setAttachmentid(serviceid);
                            routes.store(con);
                            
                            
                            if (k < staticCounter - 1) {
                                staticRoutes += ",";
                            }
                        }
                        catch(Exception e){
                            error = true;
                            for (int ki = 0; ki < staticCounter; ki++) {
                                String tempRoute = request.getParameter("route" + ki);
                                String tempMask = request.getParameter("mask" + ki);
                                request.setAttribute("mask"+ki, tempMask);
                                request.setAttribute("route"+ki, tempRoute);
                            }
                            PreAddServiceAction preaddAction = new PreAddServiceAction();
                            request.setAttribute("Message", e.getMessage());
                            request.setAttribute("ServiceForm", (ServiceForm)form);
                            ActionForward actionforward = preaddAction.execute(mapping, form, request, response);
                            logger.debug("AddServiceAction: " + e.getMessage());
                            return mapping.findForward(Constants.FAILURE);
                        }
                    }
                }
               
            }			
			
			// store the operator/requestor by default for all services
			ServiceUtils.saveOrUpdateParameter(con, serviceid, Constants.SERVICE_PARAM_OPERATOR, (String) session.getAttribute(Constants.USER_KEY));
			//System.out.println("Inside AddServiceAction, settting serviceId="+serviceid+"; operator="+(String) session.getAttribute(Constants.USER_KEY)+";");
			//      set skip_activation value
			allParameters.put("skip_activation", session.getAttribute("SKIP_ACTIVATION"));
			// Send message to SA.
			//System.out.println("Send Once");
			SendXML sender = new SendXML(allParameters);
			sender.Init();
			// Store all ServiceParameters.
			//logger.debug("ADDServiceAction:::::::::::Service parameters to be stored ");
			//System.out.println("Service Type   ----  "+((ServiceForm)form).getType());
			for (Enumeration e = serviceParameterVector.elements(); e.hasMoreElements();) {
				ServiceParameter temp = (ServiceParameter)e.nextElement();
				// if (!temp.getAttribute().equalsIgnoreCase("StartTime") &&
				//  !temp.getAttribute().equalsIgnoreCase("EndTime"))

				if(!(temp.getAttribute().equals("RoutingProtocol")&& "true".equals(request.getParameter("ServiceMultiplexing"))) &&
						!((((ServiceForm)form).getType().equals("layer3-Site")) && temp.getAttribute().equals("AddressFamily"))){
						ServiceUtils.saveOrUpdateParameter(con, temp.getServiceid(), temp.getAttribute(),temp.getValue());
						//System.out.println("Inside If............");
					}
				//Added for GIS
				if(!(temp.getAttribute().equals("RoutingProtocol")&& "true".equals(request.getParameter("ServiceMultiplexing"))) &&
						!((((ServiceForm)form).getType().equals("GIS-Site")) && temp.getAttribute().equals("AddressFamily"))){
						ServiceUtils.saveOrUpdateParameter(con, temp.getServiceid(), temp.getAttribute(),temp.getValue());
						//System.out.println("Inside GIS If............");
					}
				
				//System.out.println("Service id  "+temp.getServiceid()+"  Attribute "+temp.getAttribute()+" Value "+temp.getValue());
				logger.debug(temp.getAttribute() + "::::::" + temp.getValue());
			}
			customerid = ((ServiceForm)form).getCustomerid();
			//  request.setAttribute("fromCommitService","true");
			sender.Send();
		}
		catch(SQLException se)
		{se.printStackTrace();
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
			ie.printStackTrace();
			logger.error("add service Action class errors: ", ie);
			request.setAttribute("errormessage", ie.getMessage());
			// Delete the bean and service from the DB.
			if (service != null) {
				try {
					ServiceUtils.deleteService(con, service);
				} catch (Exception excep) {
					logger.error("Could not delete the service upon failure, " + "portal and SA migth be inconsistent.");
				}
				if (request.getParameter("staticCounter") == null && request.getParameter("SP_RoutingProtocol") == null) {
					error = true;
					//set exception messgs
				}
			}
		} catch (Exception ex) {ex.printStackTrace();
		error = true;
		logger.error("add service  Action class errors: ", ex);
		//ex.printStackTrace();
		request.setAttribute("errormessage", ex.getMessage());
		// Delete the bean and service from the DB.
		if (service != null) {
			try {
				ServiceUtils.deleteService(con, service);
			} catch (Exception excep) {
				logger.error("Could not delete the service upon failure, " + "portal and SA migth be inconsistent.");
			}
			if (request.getParameter("staticCounter") == null && request.getParameter("SP_RoutingProtocol") == null) {
				error = true;
				//set exception messgs
			}
		}
		} finally {
			// close the connection
			dbp.releaseConnection(con);
		}
		//logger.debug("ERROR  ^^^^^^^^^^^"+error);
		ListServicesAction allServices = new ListServicesAction();
		PreAddServiceAction preaddAction = new PreAddServiceAction();
		ActionForward actionforward=null;
		// Forward Action
		if (!(error)) {
			if(searchSite!=null && !searchSite.equals("") && !searchSite.equals("null")){ 
				((ServiceForm)form).setServiceid(siteidSearch);
		         SiteSearchAction siteSearchAction=new SiteSearchAction();
		      actionforward 
		       = siteSearchAction.execute(mapping,form,request,response); 
			}
			else{
			//set values to actionform obj && Transfer to the jsp
				actionforward = allServices.execute(mapping, form, request, response);
			}
			return mapping.findForward(Constants.SUCCESS);
		} else {
			request.setAttribute("Message", strMessage);
			request.setAttribute("ServiceForm", (ServiceForm)form);
			actionforward = preaddAction.execute(mapping, form, request, response);
			return mapping.findForward(Constants.FAILURE);
		}
			}//execute
	private Service copyService(Service src)
	{
		Service dest = new Service();
		dest.setCustomerid(src.getCustomerid());
		dest.setEndtime(src.getEndtime());
		dest.setModifydate(src.getModifydate());
		dest.setLastupdatetime(src.getLastupdatetime());
		dest.setNextoperationtime(src.getNextoperationtime());
		dest.setParentserviceid(src.getParentserviceid());
		dest.setPresname(src.getPresname());
		dest.setServiceid(src.getServiceid());
		dest.setState(src.getState());
		dest.setSubmitdate(src.getSubmitdate());
		dest.setType(src.getType());
		return dest;
	}

	private void storeService(Connection con, Service service, ServiceForm form, String resend) throws SQLException
	{
		service.setCustomerid(form.getCustomerid());
		service.setEndtime(form.getEndTime());
		service.setModifydate(form.getModifyDate());
		service.setLastupdatetime(form.getLastupdatetime());
		service.setNextoperationtime(form.getNextOperationTime());
		service.setParentserviceid(form.getParentserviceid());
		service.setPresname(form.getPresname());
		service.setServiceid(form.getServiceid());
		service.setState(form.getState());
		service.setSubmitdate(form.getSubmitDate());
		
		//modified for GIS
		if ("layer2-Site".equals(form.getType()) || "layer3-Site".equals(form.getType())|| "GIS-Site".equals(form.getType())) {
			service.setType("Site");
		} else {
			service.setType(form.getType());
		}

		if(resend == null || !resend.equalsIgnoreCase("true"))
			service.store(con);
		else
			service.update(con);
	}

	private void handleServiceMultiplexing(HttpServletRequest request, HashMap allParameters, Vector serviceParameterVector, ServiceForm form) {
		String ServiceMultiplexing = request.getParameter("ServiceMultiplexing");
		String ServiceMultiplexing_aEnd = request.getParameter("ServiceMultiplexing_aEnd");
		String ServiceMultiplexing_zEnd = request.getParameter("ServiceMultiplexing_zEnd");
		String disable_flag = request.getParameter("manualSet");
		if (ServiceMultiplexing != null && !"".equals(ServiceMultiplexing)) {
			if ("true".equals(ServiceMultiplexing) && request.getParameter("presnamelist") != null) {
				form.setServiceid(request.getParameter("presnamelist"));
			}
			allParameters.put("ServiceMultiplexing", ServiceMultiplexing);
			ServiceParameter serviceParameter = new ServiceParameter();
			serviceParameter.setServiceid(form.getServiceid());
			serviceParameter.setAttribute("ServiceMultiplexing");
			serviceParameter.setValue(ServiceMultiplexing);
			serviceParameterVector.add(serviceParameter);
		}
		if (ServiceMultiplexing_aEnd != null && !"".equals(ServiceMultiplexing_aEnd)) {
			allParameters.put("ServiceMultiplexing_aEnd", ServiceMultiplexing_aEnd);
			ServiceParameter serviceParameter = new ServiceParameter();
			serviceParameter.setServiceid(form.getServiceid());
			serviceParameter.setAttribute("ServiceMultiplexing_aEnd");
			serviceParameter.setValue(ServiceMultiplexing_aEnd);
			serviceParameterVector.add(serviceParameter);
		}
		if (ServiceMultiplexing_zEnd != null && !"".equals(ServiceMultiplexing_zEnd)) {
			allParameters.put("ServiceMultiplexing_zEnd", ServiceMultiplexing_zEnd);
			ServiceParameter serviceParameter = new ServiceParameter();
			serviceParameter.setServiceid(form.getServiceid());
			serviceParameter.setAttribute("ServiceMultiplexing_zEnd");
			serviceParameter.setValue(ServiceMultiplexing_zEnd);
			serviceParameterVector.add(serviceParameter);
		}

		logger.debug("AddServiceAction handleServiceMultiplexing: " + form.getType() + "|" + ServiceMultiplexing_aEnd + "|"
				+ ServiceMultiplexing_zEnd + "|" + disable_flag);
		if ("layer2-VPWS".equals(form.getType())
				&& ("true".equals(ServiceMultiplexing_aEnd) || "true".equals(ServiceMultiplexing_zEnd))) {
			logger.debug("Set type and ethtype manually");
			form.setSP_PW_Type_aEnd("Ethernet");
			form.setSP_PW_Type_zEnd("Ethernet");
			form.setSP_EthType_aEnd("VPWS-PortVlan");
			form.setSP_EthType_zEnd("VPWS-PortVlan");
			form.setSP_UNIType_aEnd("PortVlan");
			form.setSP_UNIType_zEnd("PortVlan");
		}
	}

	private boolean checkDuplicatedSiteName(ActionMapping mapping,
			ActionForm form,
			HttpServletRequest request,
			HttpServletResponse response, Connection con) throws Exception
			{
		boolean isDuplicated = false;
		StringBuffer sb = new StringBuffer();
		String ServiceMultiplexing = request.getParameter("ServiceMultiplexing");
		String ServiceMultiplexing_aEnd = request.getParameter("ServiceMultiplexing_aEnd");
		String ServiceMultiplexing_zEnd = request.getParameter("ServiceMultiplexing_zEnd");
		//logger.debug("AddServiceAction: " + ((ServiceForm)form).getType());
		if ("layer3-Site".equals(((ServiceForm)form).getType()) || "layer2-Site".equals(((ServiceForm)form).getType())||"GIS-Site".equals(((ServiceForm)form).getType())) {
			logger.debug("AddServiceAction: " + ((ServiceForm)form).getType() + "|" + ((ServiceForm)form).getPresname() + " : " + ServiceMultiplexing);
			if (ServiceMultiplexing != null && "false".equals(ServiceMultiplexing)) {
				Service[] sites = Service.findByType(con, "Site", "crm_service.PresName='" + ((ServiceForm)form).getPresname() + "' and crm_service.customerid='" + ((ServiceForm)form).getCustomerid() + "'");
				if (sites != null && sites.length > 0) {
					isDuplicated = true;
					sb.append("Site name has existed. Please retry another name.");
				}
			}
		}

		if ("layer2-VPWS".equals(((ServiceForm)form).getType())) {
			logger.debug("AddServiceAction: " + ((ServiceForm)form).getType() + "|" + ((ServiceForm)form).getSP_PW_aEnd()
					+ "|" + ((ServiceForm)form).getSP_PW_zEnd() + " : " + ServiceMultiplexing_aEnd + "|"
					+ ServiceMultiplexing_zEnd);
			if (ServiceMultiplexing_aEnd != null && "false".equals(ServiceMultiplexing_aEnd)) {
				Service[] sites = Service.findByType(con, "Site", "crm_service.PresName='"
						+ ((ServiceForm)form).getSP_PW_aEnd() + "' and crm_service.customerid='" + ((ServiceForm)form).getCustomerid() + "'");
				if (sites != null && sites.length > 0) {
					isDuplicated = true;
					sb.append("AEnd Site name has existed. Please retry another name! ");
				}
			}
			if (ServiceMultiplexing_zEnd != null && "false".equals(ServiceMultiplexing_zEnd)) {
				Service[] sites = Service.findByType(con, "Site", "crm_service.PresName='"
						+ ((ServiceForm)form).getSP_PW_zEnd() + "' and crm_service.customerid='" + ((ServiceForm)form).getCustomerid() + "'");
				if (sites != null && sites.length > 0) {
					isDuplicated = true;
					sb.append("ZEnd Site name has existed. Please retry another name! ");
				}
			}
			if (ServiceMultiplexing_aEnd != null && "false".equals(ServiceMultiplexing_aEnd) &&
					ServiceMultiplexing_zEnd != null && "false".equals(ServiceMultiplexing_zEnd)) {
				String aname = ((ServiceForm)form).getSP_PW_aEnd();
				String zname = ((ServiceForm)form).getSP_PW_zEnd();
				if (aname.equals(zname)) {
					isDuplicated = true;
					sb.append("AEnd Site name could not be as same as ZEnd Site name! ");
				}
			}
		}

		PreAddServiceAction preaddAction = new PreAddServiceAction();
		request.setAttribute("Message", sb.toString());
		request.setAttribute("ServiceForm", (ServiceForm)form);
		ActionForward actionforward = preaddAction.execute(mapping, form, request, response);
		logger.debug("AddServiceAction: " + sb.toString() + " isDuplicated: " + isDuplicated);
		return isDuplicated;
			}
	//FORMAT SCHEDULATION TIME
	private String formatTime(String schedulationTime)
	{
		java.util.Date StartingTime = null;
		long currTime = System.currentTimeMillis();
		Date currentDate = new Date(currTime);
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy.MM.dd HH:mm");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy.MM.dd");
		SimpleDateFormat sdf3 = new SimpleDateFormat("HH:mm");
		SimpleDateFormat sdf4 = new SimpleDateFormat("dd HH");
		SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy.MM");
		StartingTime = sdf1.parse(schedulationTime, new java.text.ParsePosition(0));
		if (StartingTime == null) {
			StartingTime = sdf2.parse(schedulationTime, new java.text.ParsePosition(0));
			if (StartingTime != null) {
				schedulationTime = schedulationTime.trim().concat(" 00:00");
				StartingTime = sdf1.parse(schedulationTime, new java.text.ParsePosition(0));
			} else {
				StartingTime = sdf3.parse(schedulationTime, new java.text.ParsePosition(0));
				if (StartingTime != null) {
					schedulationTime = sdf2.format(currentDate).concat(" " + schedulationTime.trim());
					StartingTime = sdf1.parse(schedulationTime, new java.text.ParsePosition(0));
				} else {
					StartingTime = sdf4.parse(schedulationTime, new java.text.ParsePosition(0));
					if (StartingTime != null) {
						schedulationTime = sdf5.format(currentDate).concat("." + schedulationTime.trim()).concat(":00");
						StartingTime = sdf1.parse(schedulationTime, new java.text.ParsePosition(0));
					}
				}
			}
		}
		return schedulationTime;
	}
}
