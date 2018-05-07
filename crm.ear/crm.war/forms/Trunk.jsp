<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  2017                                                                       --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- -*- html -*- --%>
<%@page import="com.hp.ov.activator.mwfm.component.builtin.ForEach"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>

<%@page info="Create a service" contentType="text/html;charset=UTF-8"
	language="java"
	import="com.hp.ov.activator.crmportal.action.*, java.sql.*, javax.sql.*,com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*, java.text.*, java.net.*,com.hp.ov.activator.crmportal.utils.DatabasePool,com.hp.ov.activator.crmportal.helpers.*,com.hp.ov.activator.crmportal.utils.*,org.apache.log4j.Logger,java.util.Map.Entry"%>
<%
	String ua = request.getHeader("User-Agent");
	boolean isFirefox = (ua != null && ua.indexOf("Firefox/") != -1);
	boolean isMSIE = (ua != null && ua.indexOf("MSIE") != -1);
	response.setHeader("Vary", "User-Agent");

	//load param parameters got here
	Logger logger = Logger.getLogger("CRMPortalLOG");

	ServiceForm serviceform = (ServiceForm) request.getAttribute("ServiceForm");
	HashMap serviceParameters = new HashMap();
	serviceParameters = (HashMap) request.getAttribute("serviceParameters");
	HashMap parentServiceParameters = new HashMap();
	parentServiceParameters = (HashMap) request.getAttribute("parentServiceParameters");
	String serviceid = serviceform.getServiceid();
	String parentserviceid = serviceform.getParentserviceid();
	String customerId = serviceform.getCustomerid();
	String type = serviceform.getType();
	String messageid = serviceform.getMessageid();
	//For trunk Router display.
	String mv = (String) request.getAttribute("mv");
	String currentPageNo = (String) request.getAttribute("currentPageNo");
	if(currentPageNo == null || "null".equals(currentPageNo))
		currentPageNo="1";
	String viewPageNo = (String) request.getAttribute("viewPageNo");
	if(viewPageNo == null || "null".equals(viewPageNo))
		viewPageNo="1";
	String resendCreate = (String) request.getAttribute("resend");
	Boolean resend = resendCreate != null && resendCreate.equals("true");

	String peRouter_aEnd = (String) request.getAttribute("PERouter_aEnd");
	String peRouter_zEnd = (String) request.getAttribute("PERouter_zEnd");

	String peInterface_aEnd = (String) request.getAttribute("peinterface_aEnd");
	String peInterface_zEnd = (String) request.getAttribute("peinterface_zEnd");

	HashMap<String, String> ifList = new HashMap<String, String>();
	ifList = (HashMap<String, String>) request.getAttribute("ifList");//A End
	HashMap<String, String> ifList_zEnd = new HashMap<String, String>();
	ifList_zEnd = (HashMap<String, String>) request.getAttribute("ifList_zEnd");//Z End
	HashMap<String, String> peList = new HashMap<String, String>();
	peList = (HashMap<String, String>) request.getAttribute("peList");

	String selected_trunktype = "";
	HashMap<String, String> peList_zEnd = new HashMap<String, String>();
	peList_zEnd = (HashMap<String, String>) request.getAttribute("peList_zEnd");
	List<String> iplist = new ArrayList<String>();
	iplist = (List<String>) request.getAttribute("iplist");
	List<String> iplist_zEnd = new ArrayList<String>();
	iplist_zEnd = (List<String>) request.getAttribute("iplist_zEnd");

	LinkedHashMap<String, String> trunkList = new LinkedHashMap<String, String>();
	trunkList = (LinkedHashMap<String, String>) request.getAttribute("trunkList");

	HashMap<String, HashMap<String, String>> sub_interface_list = (HashMap<String, HashMap<String, String>>) session.getAttribute("sub_interface_list");

	String SP_ip_submask_aEnd = (String) request.getAttribute("SP_ip_submask_aEnd");
	String SP_ip_submask_zEnd = (String) request.getAttribute("SP_ip_submask_zEnd");

	String Site_Service_ID_aEnd = (String) request.getAttribute("SP_Site_Service_ID_aEnd");

	String Site_Service_ID_zEnd = (String) request.getAttribute("SP_Site_Service_ID_zEnd");

	String SP_trunk_policy_aside = (String) request.getAttribute("SP_trunk_policy_aside");
	if (SP_trunk_policy_aside == null || "null".equals(SP_trunk_policy_aside))
		SP_trunk_policy_aside = "";

	String SP_trunk_policy_zside = (String) request.getAttribute("SP_trunk_policy_zside");
	if (SP_trunk_policy_zside == null || "null".equals(SP_trunk_policy_zside))
		SP_trunk_policy_zside = "";
	
	List<String> SP_QOS_PROFILE_list = new ArrayList<String>();
	SP_QOS_PROFILE_list = (List<String>) request.getAttribute("SP_QOS_PROFILE_list");
	String SP_QOS_PROFILE = (String) request.getAttribute("SP_QOS_PROFILE");

	String trunkdescription = (String) request.getAttribute("trunkdescription");
	String trunk_description_aEnd = (String) request.getAttribute("SP_trunk_description_aEnd");
	String trunk_description_zEnd = (String) request.getAttribute("SP_trunk_description_zEnd");

	if (trunk_description_aEnd == null)
		trunk_description_aEnd = "";
	if (trunk_description_zEnd == null)
		trunk_description_zEnd = "";

	String Interface_description_aEnd = (String) request.getAttribute("SP_Interface_description_aEnd");
	String Interface_description_zEnd = (String) request.getAttribute("SP_Interface_description_zEnd");

	if (Interface_description_aEnd == null || "null".equals(Interface_description_zEnd))
		Interface_description_aEnd = "";
	if (Interface_description_zEnd == null || "null".equals(Interface_description_zEnd))
		Interface_description_zEnd = "";

	String Trunk_bandwidth_aEnd = (String) request.getAttribute("SP_Trunk_bandwidth_aEnd");
	String Trunk_bandwidth_zEnd = (String) request.getAttribute("SP_Trunk_bandwidth_zEnd");
	if (Trunk_bandwidth_aEnd == null)
	  Trunk_bandwidth_aEnd = "2480000";
	if (Trunk_bandwidth_zEnd == null)
	  Trunk_bandwidth_zEnd = "2480000";
	
	String Trunk_rsvp_bandwidth_aEnd = (String) request.getAttribute("SP_Trunk_rsvp_bandwidth_aEnd");
	String Trunk_rsvp_bandwidth_zEnd = (String) request.getAttribute("SP_Trunk_rsvp_bandwidth_zEnd");
	if (Trunk_rsvp_bandwidth_aEnd == null)
	  Trunk_rsvp_bandwidth_aEnd = "2480000";
	if (Trunk_rsvp_bandwidth_zEnd == null)
	  Trunk_rsvp_bandwidth_zEnd = "2480000";

	String area_number_aend = (String) request.getAttribute("SP_area_number_aEnd");
	String area_number_zend = (String) request.getAttribute("SP_area_number_zEnd");

	if (area_number_aend == null)
		area_number_aend = "";
	if (area_number_zend == null)
		area_number_zend = "";

	String trunk_memberdescription = (String) request.getAttribute("trunk_memberdescription");
	//ends 
	DatabasePool dbp = null;
	Connection con = null;

	ServiceParameter[] available_regions = (ServiceParameter[]) request.getAttribute("available_regions");
	ServiceParameter[] available_locations = (ServiceParameter[]) request.getAttribute("available_locations");

	Location[] locations_aEnd = (Location[]) request.getAttribute("locations_aEnd");
	Location[] locations_zEnd = (Location[]) request.getAttribute("locations_zEnd");
	Region[] regions = (Region[]) request.getAttribute("regions");
	IPAddrPool[] pools = (IPAddrPool[]) request.getAttribute("pools");
	String pool_aEnd = (String) request.getAttribute("pool_aEnd");
	String pool_zEnd = (String) request.getAttribute("pool_zEnd");
	String ipaddrlist = (String) request.getAttribute("ipaddrlist");
	String ipaddrlist_zEnd = (String) request.getAttribute("ipaddrlist_zEnd");
	String trunktype = (String) request.getAttribute("trunktype");
	String include_aEnd = (String) request.getAttribute("include_aEnd");
	String include_zEnd = (String) request.getAttribute("include_zEnd");
	String EndA_name = (String) request.getAttribute("EndA_name");
	String EndB_name = (String) request.getAttribute("EndB_name");

	String addressFamily = (String) request.getAttribute("AddressFamily");

	String ip_networkIP_aEnd = (String) request.getAttribute("ip_networkIP_aEnd");
	String ip_networkIP_zEnd = (String) request.getAttribute("ip_networkIP_zEnd");
	String wildcard_aEnd = (String) request.getAttribute("wildcard_aEnd");
	String wildcard_zEnd = (String) request.getAttribute("wildcard_zEnd");
	//Region and locations
	String PW_aEnd_region = (String) request.getAttribute("PW_aEnd_region");
	String PW_zEnd_region = (String) request.getAttribute("PW_zEnd_region");
	String PW_aEnd_location = (String) request.getAttribute("PW_aEnd_location");
	String PW_zEnd_location = (String) request.getAttribute("PW_zEnd_location");
	String session_var = (String) session.getAttribute(Constants.USER);

	if (PW_aEnd_location == null)
		PW_aEnd_location = (String) serviceform.getSP_PW_aEnd_location();

	if (PW_zEnd_location == null)
		PW_zEnd_location = (String) serviceform.getSP_PW_zEnd_location();
	//Changes made to fix PR 14304 -- Divya

	String presname = serviceform.getPresname();
	//added for trunk testing.
	String transfer_mode = null;
	String area_number = null;
	//end code testing

	String SP_pim_name_aside = (String) request.getAttribute("SP_pim_name_aside");
	String SP_pim_name_zside = (String) request.getAttribute("SP_pim_name_zside");
	if (SP_pim_name_aside == null)
		SP_pim_name_aside = "true";
	if (SP_pim_name_zside == null)
		SP_pim_name_zside = "true";

	String SP_lnk_Protocol_aside = (String) request.getAttribute("SP_lnk_Protocol_aside");
	String SP_lnk_Protocol_zside = (String) request.getAttribute("SP_lnk_Protocol_zside");

	if (SP_lnk_Protocol_aside == null)
		SP_lnk_Protocol_aside = "PPP";
	if (SP_lnk_Protocol_zside == null)
		SP_lnk_Protocol_zside = "PPP";

	String SP_network_type_aside = (String) request.getAttribute("SP_network_type_aside");
	String SP_network_type_zside = (String) request.getAttribute("SP_network_type_zside");
	if (SP_network_type_aside == null)
		SP_network_type_aside = "true";
	if (SP_network_type_zside == null)
		SP_network_type_zside = "true";
	
	String SP_ospf_aside = (String) request.getAttribute("SP_ospf_aside");
	String SP_ospf_zside = (String) request.getAttribute("SP_ospf_zside");
	if (SP_ospf_aside == null)
	  SP_ospf_aside = "true";
	if (SP_ospf_zside == null)
	  SP_ospf_zside = "true";

	String SP_trunk_ldp_aside = (String) request.getAttribute("SP_trunk_ldp_aside");
	String SP_trunk_ldp_zside = (String) request.getAttribute("SP_trunk_ldp_zside");
	if (SP_trunk_ldp_aside == null)
		SP_trunk_ldp_aside = "true";
	if (SP_trunk_ldp_zside == null)
		SP_trunk_ldp_zside = "true";
	
	String SP_LDP_aPassword = (String) request.getAttribute("SP_LDP_aPassword");
	String SP_LDP_zPassword = (String) request.getAttribute("SP_LDP_zPassword");
	if (SP_LDP_aPassword == null)
		SP_LDP_aPassword = "";
	if (SP_LDP_zPassword == null)
		SP_LDP_zPassword = "";

	String SP_trunk_aside_processid = (String) request.getAttribute("SP_trunk_aside_processid");
	if (SP_trunk_aside_processid == null)
		SP_trunk_aside_processid = "100";
	String SP_trunk_zside_processid = (String) request.getAttribute("SP_trunk_zside_processid");
	if (SP_trunk_zside_processid == null)
		SP_trunk_zside_processid = "100";

	String SP_trunk_aside_ospf_cost = (String) request.getAttribute("SP_trunk_aside_ospf_cost");
	if (SP_trunk_aside_ospf_cost == null || "".equals(SP_trunk_aside_ospf_cost))
		SP_trunk_aside_ospf_cost = "200";
	String SP_trunk_zside_ospf_cost = (String) request.getAttribute("SP_trunk_zside_ospf_cost");
	if (SP_trunk_zside_ospf_cost == null || "".equals(SP_trunk_zside_ospf_cost))
		SP_trunk_zside_ospf_cost = "200";
	String SP_OSPF_aPassword = (String) request.getAttribute("SP_OSPF_aPassword");
	String SP_OSPF_zPassword = (String) request.getAttribute("SP_OSPF_zPassword");
	if (SP_OSPF_aPassword == null)
		SP_OSPF_aPassword = "";
	if (SP_OSPF_zPassword == null)
		SP_OSPF_zPassword = "";

	// IPV6 Code    
	String Ipv6Check_aEnd = (String) request.getAttribute("SP_IPv6_family_aEnd");
	if (Ipv6Check_aEnd == null) {
		Ipv6Check_aEnd = "false";
	}
	String Ipv6Check_zEnd = "true";
	
	Ipv6Check_zEnd = (String) request.getAttribute("SP_IPv6_family_zEnd");	
	Ipv6Check_zEnd = "true";
	
	String SP_trunk_negotiation_aside = (String) request.getAttribute("SP_trunk_negotiation_aside");
	if (SP_trunk_negotiation_aside == null) {
		SP_trunk_negotiation_aside = "true";
	}

	String SP_trunk_negotiation_zside = (String) request.getAttribute("SP_trunk_negotiation_zside");
	if (SP_trunk_negotiation_zside == null) {
		SP_trunk_negotiation_zside = "true";
	}

	String Ipv6_pool_aEnd = (String) request.getAttribute("SP_IPv6_Pool_aEnd");
	String Ipv6_pool_zEnd = (String) request.getAttribute("SP_IPv6_Pool_zEnd");
	Ipv6_pool_zEnd="";
	String SP_IPv6_Address_aEnd = (String) request.getAttribute("SP_IPv6_Address_aEnd");
	String SP_IPv6_Address_zEnd = "";	
	List<String> Ipv6_iplist_aEnd = new ArrayList<String>();
	Ipv6_iplist_aEnd = (List<String>) request.getAttribute("Ipv6_iplist_aEnd");

	List<String> Ipv6_iplist_zEnd = new ArrayList<String>();
	Ipv6_iplist_zEnd = (List<String>) request.getAttribute("Ipv6_iplist_zEnd");
	String SP_link_type = (String) request.getAttribute("SP_link_type");
	String[] SP_link_types = (String[]) request.getAttribute("SP_link_types");
	
	String SP_trunk_aIPbinding = (String) request.getAttribute("SP_trunk_aIPbinding");
	String SP_trunk_zIPbinding = (String) request.getAttribute("SP_trunk_zIPbinding");
	if (SP_trunk_aIPbinding == null) {
	  SP_trunk_aIPbinding = "";
	}
	if (SP_trunk_zIPbinding == null) {
	  SP_trunk_zIPbinding = "";
	}
	
	String SP_trunk_aside_mtu = (String) request.getAttribute("SP_trunk_aside_mtu");
	if (SP_trunk_aside_mtu == null)
		SP_trunk_aside_mtu = "1700";
	String SP_trunk_zside_mtu = (String) request.getAttribute("SP_trunk_zside_mtu");
	if (SP_trunk_zside_mtu == null)
		SP_trunk_zside_mtu = "1700";

	// end ipv6 	  
	//pagination
	int cpage = 1;
			int totalPages = 1 ;
			int currentRs=0;
			int lastRs=0;	
			int vPageNo = 1;


	String strcpage = (String)request.getAttribute("cpage");
	if(strcpage!=null)
	  cpage  = Integer.parseInt(strcpage);
    String strcurrentRs  =  (String)request.getAttribute("currentRs");
	if(strcurrentRs!=null)
	  currentRs  = Integer.parseInt(strcurrentRs);
	String strlastRs	 =  (String)request.getAttribute("lastRs");
	if(strlastRs!=null)
	  lastRs = Integer.parseInt(strlastRs);
	String strtotalPages =  (String)request.getAttribute("totalPages");
	if(strtotalPages!=null&&!strtotalPages.equalsIgnoreCase(""))
	  totalPages = Integer.parseInt(strtotalPages);
	String strvPageNo	 =  (String)request.getAttribute("vPageNo");
	if(strvPageNo!=null)
	  vPageNo = Integer.parseInt(strvPageNo);

	String strSort	 =  (String)request.getAttribute("sort");
	if(strSort==null)
	  strSort = "desc";

String currentSort = "desc";
	if(strSort.equalsIgnoreCase("asc"))
		currentSort = "desc";
	else if (strSort.equalsIgnoreCase("desc"))
     	currentSort = "asc";
	//end pagination

	Service[] sites = (Service[]) request.getAttribute("available_sites");

	// avoid combox lose selected value when refresh
	String PW_aEndlist = (String) request.getParameter("SP_PW_aEndlist");
	String PW_zEndlist = (String) request.getParameter("SP_PW_zEndlist");

	String ServiceMultiplexing_aEnd = (String) request.getAttribute("ServiceMultiplexing_aEnd");
	String ServiceMultiplexing_zEnd = (String) request.getAttribute("ServiceMultiplexing_zEnd");

	if (session_var != null) {
		logger.debug("Trunk jsp : Valid Session for user: " + session_var);
		session.setAttribute(Constants.USER, session_var);
	}

	String link_part_1 = "'/crm/CreateService.do?serviceid=" + serviceid + "&customerid=" + customerId
		+ "&SP_Site_Service_ID_aEnd=" + Site_Service_ID_aEnd + "&SP_Site_Service_ID_zEnd="
		+ Site_Service_ID_zEnd + "&mv=" + mv + "&currentPageNo=" + currentPageNo + "&viewPageNo="
		+ viewPageNo + "&resend=" + resendCreate + "&reselect=" + resend + "&type=" + "Trunk"
		+ "&presname=' + ServiceForm.presname.value + "
		+ "'&SP_Trunk_Type=' + ServiceForm.SP_Trunk_Type.options[ServiceForm.SP_Trunk_Type.selectedIndex].value + "
		+ "'&SP_PW_aEnd_location=' + ServiceForm.SP_PW_aEnd_location.options[SP_PW_aEnd_location.selectedIndex].value + "
		+ "'&SP_PW_zEnd_location=' + ServiceForm.SP_PW_zEnd_location.options[SP_PW_zEnd_location.selectedIndex].value + "
		+ "'&SP_PW_aEnd_region=' + ServiceForm.SP_PW_aEnd_region.options[SP_PW_aEnd_region.selectedIndex].value + "
		+ "'&SP_PW_zEnd_region=' + ServiceForm.SP_PW_zEnd_region.options[SP_PW_zEnd_region.selectedIndex].value + "
		+ "'&SP_trunk_policy_aside=' + ServiceForm.SP_trunk_policy_aside.value + "
		+ "'&SP_trunk_policy_zside=' + ServiceForm.SP_trunk_policy_zside.value + "
		+ "'&SP_QOS_PROFILE=' + ServiceForm.SP_QOS_PROFILE.value + "
		+ "'&SP_trunk_description_aEnd=' + ServiceForm.SP_trunk_description_aEnd.value + "
		+ "'&SP_trunk_description_zEnd=' + ServiceForm.SP_trunk_description_zEnd.value + "
		+ "'&SP_trunk_aside_mtu=' + ServiceForm.SP_trunk_aside_mtu.value + "
		+ "'&SP_trunk_zside_mtu=' + ServiceForm.SP_trunk_zside_mtu.value + "
		+ "'&SP_area_number_aEnd=' + ServiceForm.SP_area_number_aEnd.value + "
		+ "'&SP_area_number_zEnd=' + ServiceForm.SP_area_number_zEnd.value + "
		+ "'&SP_network_type_aside=' + ServiceForm.SP_network_type_aside.value + "
		+ "'&SP_network_type_zside=' + ServiceForm.SP_network_type_zside.value + "
		+ "'&SP_ospf_aside=' + ServiceForm.SP_ospf_aside.value + "
		+ "'&SP_ospf_zside=' + ServiceForm.SP_ospf_zside.value + "
		+ "'&SP_trunk_ldp_aside=' + ServiceForm.SP_trunk_ldp_aside.value + "
		+ "'&SP_trunk_ldp_zside=' + ServiceForm.SP_trunk_ldp_zside.value + "
		+ "'&SP_LDP_aPassword=' + ServiceForm.SP_LDP_aPassword.value + "
		+ "'&SP_LDP_zPassword=' + ServiceForm.SP_LDP_zPassword.value + "
		+ "'&SP_pim_name_aside=' + ServiceForm.SP_pim_name_aside.value + "
		+ "'&SP_pim_name_zside=' + ServiceForm.SP_pim_name_zside.value + "
		+ "'&SP_Interface_description_aEnd=' + ServiceForm.SP_Interface_description_aEnd.value + "
		+ "'&SP_Interface_description_zEnd=' + ServiceForm.SP_Interface_description_zEnd.value + "
		+ "'&SP_Trunk_bandwidth_aEnd=' + ServiceForm.SP_Trunk_bandwidth_aEnd.value + "
		+ "'&SP_Trunk_bandwidth_zEnd=' + ServiceForm.SP_Trunk_bandwidth_zEnd.value + "
		+ "'&SP_Trunk_rsvp_bandwidth_aEnd=' + ServiceForm.SP_Trunk_rsvp_bandwidth_aEnd.value + "
		+ "'&SP_Trunk_rsvp_bandwidth_zEnd=' + ServiceForm.SP_Trunk_rsvp_bandwidth_zEnd.value + "
		+ "'&SP_PERouter_aEnd=' + ServiceForm.SP_PERouter_aEnd.options[ServiceForm.SP_PERouter_aEnd.selectedIndex].value + "
		+ "'&SP_PERouter_zEnd=' + ServiceForm.SP_PERouter_zEnd.options[ServiceForm.SP_PERouter_zEnd.selectedIndex].value + "
		+ "'&SP_PEInterface_aEnd=' + getAllSelectedOptions(ServiceForm.SP_PEInterface_aEnd) + "
		+ "'&SP_PEInterface_zEnd=' + getAllSelectedOptions(ServiceForm.SP_PEInterface_zEnd) + "
		//+ "'&SP_AddressPool_aEnd=' + ServiceForm.SP_AddressPool_aEnd.value + "
		//+ "'&SP_AddressPool_zEnd=' + ServiceForm.SP_AddressPool_zEnd.value + "
		//+ "'&SP_trunk_ipaddress_zEnd=' + ServiceForm.SP_trunk_ipaddress_zEnd.value + "
		//+ "'&SP_trunk_ipaddress_aEnd=' + ServiceForm.SP_trunk_ipaddress_aEnd.value + "
		+ "'&SP_IPv6_family_aEnd=' + ServiceForm.SP_IPv6_family_aEnd.value + "
		+ "'&SP_IPv6_family_zEnd=' + ServiceForm.SP_IPv6_family_zEnd.value + "
		+ "'&SP_link_type=' + ServiceForm.SP_link_type.value + "
		//+ "'&SP_IPv6_Pool_aEnd=' + ServiceForm.SP_IPv6_Pool_aEnd.value + "
		//+ "'&SP_IPv6_Pool_zEnd=' + ServiceForm.SP_IPv6_Pool_zEnd.value + "
		//+ "'&SP_IPv6_Address_aEnd=' + ServiceForm.SP_IPv6_Address_aEnd.value + "
		//+ "'&SP_IPv6_Address_zEnd=' + ServiceForm.SP_IPv6_Address_zEnd.value + "
	    + "'&SP_trunk_aIPbinding=' + ServiceForm.SP_trunk_aIPbinding.value + "
		+ "'&SP_trunk_zIPbinding=' + ServiceForm.SP_trunk_zIPbinding.value + "
		+ "'&SP_trunk_aside_processid=' + ServiceForm.SP_trunk_aside_processid.value + "
		+ "'&SP_trunk_zside_processid=' + ServiceForm.SP_trunk_zside_processid.value + "
		+ "'&SP_trunk_aside_ospf_cost=' + ServiceForm.SP_trunk_aside_ospf_cost.value + "
		+ "'&SP_trunk_zside_ospf_cost=' + ServiceForm.SP_trunk_zside_ospf_cost.value + "
		+ "'&SP_OSPF_aPassword=' + ServiceForm.SP_OSPF_aPassword.value + "
		+ "'&SP_OSPF_zPassword=' + ServiceForm.SP_OSPF_zPassword.value";

	int rowCounter;

	try {
		rowCounter = request.getParameter("rowCounter") == null
			? 0
			: Integer.parseInt(request.getParameter("rowCounter"));
	} catch (Exception e) {
		rowCounter = 0;
	}

	String reqtype = (String) request.getAttribute("reqtype");
	if (reqtype == null) {
		reqtype = "";
	}
	// TODO Check possible reqtypes
	if (!"".equals(reqtype) && "newTrunk,creatingSub,cancelingSub,modifysubinterface".contains(reqtype)) {
	//if (!reqtype.equals("subinterface") && !reqtype.equals("showsubinterface")) {
%>
<%-- Trunk name added --%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left><b><bean:message key="label.trunk.type" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="100%">
					<select name="SP_Trunk_Type" id="SP_Trunk_Type" onchange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';">
<%
						if (trunkList != null) {
							for (Map.Entry<String, String> entry : trunkList.entrySet()) {
								String attr = entry.getKey();
								String val = entry.getValue();
	
								if (trunktype != null && trunktype.equals(attr)) {
									selected_trunktype = val;
%>
									<option value="<%=attr%>" selected><%=val%></option>
<%
								} else {
%>
									<option value="<%=attr%>"><%=val%></option>
<%
						  		}
							}
						}
%>
					</select>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;

  if (!selected_trunktype.equals(Constants.TRUNK_TYPE_ETHTRUNK)) {
    link_part_1 += "+'&SP_lnk_Protocol_aside='+ ServiceForm.SP_lnk_Protocol_aside.options[SP_lnk_Protocol_aside.selectedIndex].value + "
  		+ "'&SP_lnk_Protocol_zside='+ ServiceForm.SP_lnk_Protocol_zside.options[SP_lnk_Protocol_zside.selectedIndex].value";
  } else {
	link_part_1 += "+'&SP_trunk_negotiation_aside=' + ServiceForm.SP_trunk_negotiation_aside.value  + "
		+ "'&SP_trunk_negotiation_zside=' + ServiceForm.SP_trunk_negotiation_zside.value";
  }
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left><b>
		<bean:message key="label.trunk.name" /></b>
	</td>
	<td class="list<%=(rowCounter % 2)%>" align=left>
		<input type="text" id="presname" name="presname" maxlength="32" size="32" value="<%=presname%>" disabled>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;

  if (selected_trunktype.equals(Constants.TRUNK_TYPE_ETHTRUNK)) {
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left><b><bean:message key="label.trunk.link.type" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" align=left>
		<select name="SP_link_type" id="SP_link_type" onChange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';">
			<%
			  for (int i = 0; SP_link_types != null && i < SP_link_types.length; i++) {
			%>
			<option
				<%=SP_link_types[i].equals(SP_link_type) ? " selected" : ""%>
				value="<%=SP_link_types[i]%>"><%=SP_link_types[i]%></option>
			<%
			  }
			%>
	</select></td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;

  } else if (selected_trunktype.equals(Constants.TRUNK_TYPE_STM16)) {
%>
<input type="hidden" id="SP_link_type" value="2.5G POS">
<%
  } else {
%>
<input type="hidden" id="SP_link_type" value="0">
<%
  }

  rowCounter++;
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%">
		<b><bean:message key="label.trunk.qos.policy" /></b>
	</td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<select name="SP_QOS_PROFILE" id="SP_QOS_PROFILE">
<%
						if (SP_QOS_PROFILE_list != null) {
							for (int i = 0; SP_QOS_PROFILE_list != null && i < SP_QOS_PROFILE_list.size(); i++) {
%>
								<option <%=SP_QOS_PROFILE_list.get(i).equals(SP_QOS_PROFILE) ? " selected" : ""%> value="<%=SP_QOS_PROFILE_list.get(i)%>"><%=SP_QOS_PROFILE_list.get(i)%></option>
<%
							}
						} else {
%>
							<option value="none">-none-</option>
<%
						}
%>
					</select>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>
<tr>
	<td class="title" align="left" colspan="2" width="40%"><bean:message
			key="label.siteinfo" /></td>
	<td class="title" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="title" align="left" width="50%"><bean:message
						key="label.aend" /></td>
				<td class="title" align="left" width="50%"><bean:message
						key="label.zend" /></td>
			</tr>
		</table>
	</td>
	<td class="title">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message
				key="label.trunk.serviceid" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_Site_Service_ID_aEnd"
					name="SP_Site_Service_ID_aEnd" value="<%=Site_Service_ID_aEnd%>"
					readonly>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_Site_Service_ID_zEnd"
					name="SP_Site_Service_ID_zEnd" value="<%=Site_Service_ID_zEnd%>"
					readonly>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message
				key="label.trunk.sidename" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_EndA_name" name="SP_EndA_name"
					value="<%=EndA_name%>" readonly>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_EndZ_name" name="SP_EndZ_name"
					value="<%=EndB_name%>" readonly>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>
<%--The condition for Eth trunk and IP trunk --%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td align=left class="list<%=(rowCounter % 2)%>" width=40>
		<b><bean:message key="label.vpws.region" /></b>
	</td>
	<td style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td align=left class="list<%=(rowCounter % 2)%>" width="50%">
					<select name="SP_PW_aEnd_region" id="SP_PW_aEnd_region" onChange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';">
<%
						if (regions != null) {
							if (PW_aEnd_region == null) {
								PW_aEnd_region = regions[0].getPrimaryKey();
							}
							for (int i = 0; regions != null && i < regions.length; i++) {
%>
								<option <%=regions[i].getName().equals(PW_aEnd_region) ? " selected" : ""%> value="<%=regions[i].getName()%>"><%=regions[i].getName()%></option>
<%
							}
						}
%>
				</select>
				</td>
				<td align=left class="list<%=(rowCounter % 2)%>" width="50%">
					<select name="SP_PW_zEnd_region" id="SP_PW_zEnd_region" onChange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';">
<%
						if (regions != null) {
							if (PW_zEnd_region == null) {
								PW_zEnd_region = regions[0].getPrimaryKey();
							}
							for (int i = 0; regions != null && i < regions.length; i++) {
%>
								<option <%=regions[i].getName().equals(PW_zEnd_region) ? " selected" : ""%>	value="<%=regions[i].getName()%>"><%=regions[i].getName()%></option>
<%
							}
						}
%>
				</select>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td align=left class="list<%=(rowCounter % 2)%>" width=40>
		<b><bean:message key="label.vpws.loc" /></b>
	</td>
	<td style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td align=left class="list<%=(rowCounter % 2)%>" width="50%">
					<select name="SP_PW_aEnd_location" id="SP_PW_aEnd_location" onChange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';">
<%
						if (locations_aEnd != null) {
							if (PW_aEnd_location == null) {
								PW_aEnd_location = locations_aEnd[0].getPrimaryKey();
							}
							for (int i = 0; locations_aEnd != null && i < locations_aEnd.length; i++) {
%>
								<option <%=locations_aEnd[i].getName().equals(PW_aEnd_location) ? " selected" : ""%> value="<%=locations_aEnd[i].getName()%>"><%=locations_aEnd[i].getName()%></option>
<%
							}
						}
%>
				</select>
				</td>
				<td align=left class="list<%=(rowCounter % 2)%>" width="50%">
					<select name="SP_PW_zEnd_location" id="SP_PW_zEnd_location" onChange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';">
<%
						if (locations_zEnd != null) {
							if (PW_zEnd_location == null) {
								PW_zEnd_location = locations_zEnd[0].getPrimaryKey();
							}
							for (int i = 0; locations_zEnd != null && i < locations_zEnd.length; i++) {
%>
								<option <%=locations_zEnd[i].getName().equals(PW_zEnd_location) ? " selected" : ""%> value="<%=locations_zEnd[i].getName()%>"><%=locations_zEnd[i].getName()%></option>
<%
							}
						}
%>
				</select>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%">
		<b><bean:message key="label.trunk.routers.list" /></b>
	</td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<select name="SP_PERouter_aEnd" id="SP_PERouter_aEnd" onchange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';"
					<%=(peList != null && !peList.isEmpty()) ? "" : "disabled"%>>
						<option value="" selected></option>
						<%
						  if (peList != null && !peList.isEmpty()) {
							for (Map.Entry<String, String> entry : peList.entrySet()) {
								String attr = entry.getKey();
								String val = entry.getValue();

								if (peRouter_aEnd != null && peRouter_aEnd.equals(attr)) {
						%>
									<option value="<%=attr%>" selected><%=val%></option>
						<%
						  		} else {
						%>
									<option value="<%=attr%>"><%=val%></option>
						<%
						  		}
							}
						  } else {
						%>
							<option value="none">-none-</option>
						<%
						 }
						%>
				</select>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<select name="SP_PERouter_zEnd" id="SP_PERouter_zEnd" onchange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';"
					<%=(peList_zEnd != null && !peList_zEnd.isEmpty()) ? "" : "disabled"%>>
						<option value="" selected></option>
<%
						if (peList_zEnd != null && !peList_zEnd.isEmpty()) {
							for (Map.Entry<String, String> entry : peList_zEnd.entrySet()) {
								String attr = entry.getKey();
								String val = entry.getValue();

								if (peRouter_zEnd != null && peRouter_zEnd.equals(attr)) {
%>
									<option value="<%=attr%>" selected><%=val%></option>
<%
						  		} else {
%>
									<option value="<%=attr%>"><%=val%></option>
<%
						  		}
							}
						} else {
%>
							<option value="none">-none-</option>
<%
						}
%>
				</select>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>

<%
  rowCounter++;
%>

<%-- <%
  if ("true".equals(Ipv6Check_aEnd)) {
%>
	<input type="hidden" id="SP_AddressPool_aEnd" name="SP_AddressPool_aEnd">
	<input type="hidden" id="SP_trunk_ipaddress_aEnd" name="SP_trunk_ipaddress_aEnd">
<%
  }

  if ("true".equals(Ipv6Check_zEnd)) {
%>
	<input type="hidden" id="SP_AddressPool_zEnd" name="SP_AddressPool_zEnd">
	<input type="hidden" id="SP_trunk_ipaddress_zEnd" name="SP_trunk_ipaddress_zEnd">
<%
  }
%> --%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%">
		<b><bean:message key="label.trunk.ipaddressPool" /></b>
	</td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
<%
  				//	if (!"true".equals(Ipv6Check_aEnd)) {
  						link_part_1 += "+'&SP_AddressPool_aEnd=' + ServiceForm.SP_AddressPool_aEnd.options[ServiceForm.SP_AddressPool_aEnd.selectedIndex].value";  
%>
						<select id="SP_AddressPool_aEnd" name="SP_AddressPool_aEnd" onChange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';">
<%
							if (pools != null) {
								if (pool_aEnd == null) {
									pool_aEnd = pools[0].getPrimaryKey();
								}
								
								for (int i = 0; pools != null && i < pools.length; i++) {
									if (pools[i].getAddressfamily().equals(addressFamily)) {
%>
										<option <%=pools[i].getName().equals(pool_aEnd) ? " selected" : ""%> value="<%=pools[i].getName()%>"><%=pools[i].getName()%></option>
<%
									}
								}
							} else {
%>
								<option value="none">-none-</option>
<%
							}
%>
						</select>
<%-- <%
  					} else {
%>
						<select style="width: 100%" disabled>
							<option value=""></option>
						</select>
<%
  					}
%> --%>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
<%
  					//if (!"true".equals(Ipv6Check_zEnd)) {
  						link_part_1 += "+'&SP_AddressPool_zEnd=' + ServiceForm.SP_AddressPool_zEnd.options[ServiceForm.SP_AddressPool_zEnd.selectedIndex].value";
%>
						<select id="SP_AddressPool_zEnd" style="display:none" name="SP_AddressPool_zEnd" onChange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';">

<%
							if (pools != null) {
								if (pool_zEnd == null) {
									pool_zEnd = pools[0].getPrimaryKey();
								}

								for (int i = 0; pools != null && i < pools.length; i++) {
									if (pools[i].getAddressfamily().equals(addressFamily)) {
%>
										<option <%=pools[i].getName().equals(pool_zEnd) ? " selected" : ""%> value="<%=pools[i].getName()%>"><%=pools[i].getName()%></option>
<%
						  			}
								}
							} else {
%>
								<option value="none">-none-</option>
<%
							}
%>
						</select>
<%-- <%
  					} else {
%>
						<select style="width: 100%" disabled>
							<option value=""></option>
						</select>
<%
  					}
%> --%>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>

<%
  rowCounter++;
%>

<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%">
		<b><bean:message key="label.trunk.ipaddress" /></b>
	</td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="25%">
<%
  				//	if (!"true".equals(Ipv6Check_aEnd)) {
  						link_part_1 += "+'&SP_trunk_ipaddress_aEnd=' + ServiceForm.SP_trunk_ipaddress_aEnd.options[ServiceForm.SP_trunk_ipaddress_aEnd.selectedIndex].value";
%>
						<select id="SP_trunk_ipaddress_aEnd" name="SP_trunk_ipaddress_aEnd" onChange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';">
							<option value=""></option>
<%
							if (iplist != null && !iplist.isEmpty()) {
								for (int i = 0; i < iplist.size(); i++) {
									if (ipaddrlist != null && ipaddrlist.equals(iplist.get(i))) {
%>
										<option value="<%=iplist.get(i)%>" selected><%=iplist.get(i).split("@")[1]%></option>
<%
						  			} else {
%>
										<option value="<%=iplist.get(i)%>"><%=iplist.get(i).split("@")[1]%></option>
<%
							  		}
								}
							}
%>
						</select>
<%-- <%
  					} else {
%>
						<select style="width: 100%" disabled>
							<option value=""></option>
						</select>
<%
  					}
%> --%>
				</td>
<%
				if (SP_ip_submask_aEnd != null) {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="25%">
						<input type="hidden" id="SP_ip_submask_aEnd" name="SP_ip_submask_aEnd" value="<%=SP_ip_submask_aEnd%>" readonly>
					</td>
<%
				} else {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="25%">
					</td>
<%
				}
%>
				<td class="list<%=(rowCounter % 2)%>" align=left width="25%">
<%
  				//	if (!"true".equals(Ipv6Check_zEnd)) {
  					//	link_part_1 += "+'&SP_trunk_ipaddress_zEnd=' + //ServiceForm.SP_trunk_ipaddress_zEnd.options[ServiceForm.SP_trunk_ipaddress_zEnd.selectedIndex].value";
%>
						<select id="SP_trunk_ipaddress_zEnd" style="display:none" name="SP_trunk_ipaddress_zEnd" onChange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';">
							<option value=""></option>
<%
							if (iplist_zEnd != null && !iplist_zEnd.isEmpty()) {
								for (int i = 0; i < iplist_zEnd.size(); i++) {
									if (ipaddrlist_zEnd != null && ipaddrlist_zEnd.equals(iplist_zEnd.get(i))) {
%>
										<option value="<%=iplist_zEnd.get(i)%>" selected><%=iplist_zEnd.get(i).split("@")[1]%></option>
<%
							  		} else {
%>
										<option value="<%=iplist_zEnd.get(i)%>"><%=iplist_zEnd.get(i).split("@")[1]%></option>
<%
						  			}
								}
							}
%>
						</select>
<%-- <%
  					} else {
%>
						<select style="width: 100%" disabled>
							<option value=""></option>
						</select>
<%
  					}
%> --%>
				</td>
<%
				if (SP_ip_submask_zEnd != null) {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="25%">
						<input type="hidden" id="SP_ip_submask_zEnd" name="SP_ip_submask_zEnd" value="<%=SP_ip_submask_zEnd%>" readonly>
					</td>
<%
				} else {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="25%">
					</td>
<%
				}
%>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>

<%
  rowCounter++;
%>

<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message
				key="label.trunk.description" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_trunk_description_aEnd"
					name="SP_trunk_description_aEnd" maxlength="242" size="32"
					value="<%=trunk_description_aEnd%>">
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_trunk_description_zEnd"
					name="SP_trunk_description_zEnd" maxlength="242" size="32"
					value="<%=trunk_description_zEnd%>">
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%">
		<b><bean:message key="label.trunk.traffic.policy" /></b>
	</td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<select name="SP_trunk_policy_aside" id="SP_trunk_policy_aside">
						<option
							<%=SP_trunk_policy_aside != null && SP_trunk_policy_aside.equals("inbound/outbound")
						? " selected"
						: ""%>
							value="inbound/outbound">inbound/outbound</option>
						<option
							<%=SP_trunk_policy_aside != null && SP_trunk_policy_aside.equals("inbound") ? " selected" : ""%>
							value="inbound">inbound</option>
						<option
							<%=SP_trunk_policy_aside != null && SP_trunk_policy_aside.equals("outbound") ? " selected" : ""%>
							value="outbound">outbound</option>
				</select>
				</td>

				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<select name="SP_trunk_policy_zside" id="SP_trunk_policy_zside">
						<option
							<%=SP_trunk_policy_zside != null && SP_trunk_policy_zside.equals("inbound/outbound")
						? " selected"
						: ""%>
							value="inbound/outbound">inbound/outbound</option>
						<option
							<%=SP_trunk_policy_zside != null && SP_trunk_policy_zside.equals("inbound") ? " selected" : ""%>
							value="inbound">inbound</option>
						<option
							<%=SP_trunk_policy_zside != null && SP_trunk_policy_zside.equals("outbound") ? " selected" : ""%>
							value="outbound">outbound</option>
				</select>
				</td>

			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>

<%
  logger.debug("Trunk Type selected in jsp is : " + selected_trunktype);
  if (selected_trunktype.equals(Constants.TRUNK_TYPE_ETHTRUNK)) {
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%">
		<b><bean:message key="label.trunk.negotiation" /></b>
	</td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="checkbox" id="SP_trunk_negotiation_aside"
					name="SP_trunk_negotiation_aside"
					value="<%=SP_trunk_negotiation_aside%>"
					<%=SP_trunk_negotiation_aside.equals("true") ? " CHECKED" : " "%>
					onchange="setcheckbox('SP_trunk_negotiation_aside')"> <bean:message
						key="label.trunk.negotiation.auto" /><BR>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="checkbox" id="SP_trunk_negotiation_zside"
					name="SP_trunk_negotiation_zside"
					value="<%=SP_trunk_negotiation_zside%>"
					<%=SP_trunk_negotiation_zside.equals("true") ? " CHECKED" : " "%>
					onchange="setcheckbox('SP_trunk_negotiation_zside')"> <bean:message
						key="label.trunk.negotiation.auto" /><BR>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>

<%
  rowCounter++;
%>


<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%">
		<b><bean:message key="label.trunk.mtu" /></b>
	</td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_trunk_aside_mtu"
					name="SP_trunk_aside_mtu" maxlength="32" size="32"
					value=<%=SP_trunk_aside_mtu%>>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_trunk_zside_mtu"
					name="SP_trunk_zside_mtu" maxlength="32" size="32"
					value=<%=SP_trunk_zside_mtu%>>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>

<%
  } else {
%>
	<input type="hidden" id="SP_trunk_negotiation_aside" name="SP_trunk_negotiation_aside" value=<%=SP_trunk_negotiation_aside%>>
	<input type="hidden" id="SP_trunk_negotiation_zside" name="SP_trunk_negotiation_zside" value=<%=SP_trunk_negotiation_zside%>>
	<input type="hidden" id="SP_trunk_aside_mtu" name="SP_trunk_aside_mtu" value=<%=SP_trunk_aside_mtu%>>
	<input type="hidden" id="SP_trunk_zside_mtu" name="SP_trunk_zside_mtu" value=<%=SP_trunk_zside_mtu%>>
<%
  }
%>

<%
  if (ip_networkIP_aEnd != null) {
%>
	<input type="hidden" id="SP_ip_networkIP_aEnd" name="SP_ip_networkIP_aEnd" value="<%=ip_networkIP_aEnd%>" readonly>
	<input type="hidden" id="SP_wildcard_aEnd" name="SP_wildcard_aEnd" value="<%=wildcard_aEnd%>" readonly>
<%
  }

  if (ip_networkIP_zEnd != null) {
%>
	<input type="hidden" id="SP_ip_networkIP_zEnd" name="SP_ip_networkIP_zEnd" value="<%=ip_networkIP_zEnd%>" readonly>
	<input type="hidden" id="SP_wildcard_zEnd" name="SP_wildcard_zEnd" value="<%=wildcard_zEnd%>" readonly>
<%
  }
%>

<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<!--td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message key="label.trunk.family.IPv6" /></b></td-->
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="15%">
					<input type="checkbox" id="SP_IPv6_family_aEnd"
					name="SP_IPv6_family_aEnd" value="<%=Ipv6Check_aEnd%>"
					<%=Ipv6Check_aEnd.equals("true") ? " CHECKED" : " "%>
					onChange="setcheckbox('SP_IPv6_family_aEnd');location.href = <%=link_part_1%> + '&reqtype=newTrunk';">
					IPv6 <BR>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="15%">
					<input type="checkbox" id="SP_IPv6_family_zEnd"  style="display:none" 
					name="SP_IPv6_family_zEnd" value="<%=Ipv6Check_zEnd%>"
					<%=(Ipv6Check_zEnd.equals("true")) ? " CHECKED" : " "%>
					onChange="setcheckbox('SP_IPv6_family_zEnd');location.href = <%=link_part_1%> + '&reqtype=newTrunk';">
					IPv6 <BR>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  if (!"true".equals(Ipv6Check_aEnd)) {
%>
	<input type="hidden" id="SP_IPv6_Pool_aEnd" name="SP_IPv6_Pool_aEnd">
	<input type="hidden" id="SP_IPv6_Address_aEnd" name="SP_IPv6_Address_aEnd">
	<input type="hidden" id="SP_trunk_aIPbinding" name="SP_trunk_aIPbinding" value="<%=SP_trunk_aIPbinding %>">
	<input type="hidden" id="SP_trunk_zIPbinding" name="SP_trunk_zIPbinding" value="<%=SP_trunk_zIPbinding %>">
	
<%
  }

  if (!"true".equals(Ipv6Check_zEnd)) {
%>
	<input type="hidden" id="SP_IPv6_Pool_zEnd" name="SP_IPv6_Pool_zEnd">
	<input type="hidden" id="SP_IPv6_Address_zEnd" name="SP_IPv6_Address_zEnd">
	<input type="hidden" id="SP_trunk_zIPbinding" name="SP_trunk_zIPbinding" value="<%=SP_trunk_zIPbinding %>">
<%
  }

  if (Ipv6Check_aEnd.equals("true") || Ipv6Check_zEnd.equals("true")) {

  rowCounter++;
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message key="label.trunk.ipaddressPool" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="15%">
<%
					if (Ipv6Check_aEnd.equals("true")) {
						link_part_1 += "+'&SP_IPv6_Pool_aEnd=' + ServiceForm.SP_IPv6_Pool_aEnd.options[ServiceForm.SP_IPv6_Pool_aEnd.selectedIndex].value";
%>
						<select id="SP_IPv6_Pool_aEnd" name="SP_IPv6_Pool_aEnd" onChange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';" style="width: 100%">
<%
						if (pools != null) {
							for (int i = 0; pools != null && i < pools.length; i++) {
								if (pools[i].getAddressfamily().equals("IPv6")) {
									if (Ipv6_pool_aEnd == null) {
										Ipv6_pool_aEnd = pools[i].getPrimaryKey();
									}
%>
									<option <%=pools[i].getName().equals(Ipv6_pool_aEnd) ? " selected" : ""%> value="<%=pools[i].getName()%>"><%=pools[i].getName()%></option>
<%
						  		}
							}
						} else {
%>
							<option value="none">-none-</option>
<%
						}
%>
						</select>
<%
					} else {
%>
					  <select style="width: 100%" disabled>
					  	<option value=""></option>
					  </select>
<%
					}
%>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="15%">
<%
					//if (Ipv6Check_zEnd.equals("true")) {
					if (true) {
						link_part_1 += "+'&SP_IPv6_Pool_zEnd=' + ServiceForm.SP_IPv6_Pool_zEnd.options[ServiceForm.SP_IPv6_Pool_zEnd.selectedIndex].value";
%>
						<select id="SP_IPv6_Pool_zEnd" style="display:none" name="SP_IPv6_Pool_zEnd" onChange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';" style="width: 100%">
<%
						if (pools != null) {
							for (int i = 0; pools != null && i < pools.length; i++) {
								if (pools[i].getAddressfamily().equals("IPv6")) {
									if (Ipv6_pool_zEnd == null) {
										Ipv6_pool_zEnd = pools[i].getPrimaryKey();
									}
%>
									<option <%=pools[i].getName().equals(Ipv6_pool_zEnd) ? " selected" : ""%> value="<%=pools[i].getName()%>"><%=pools[i].getName()%></option>
<%
								}
							}
						} else {
%>
							<option value="none">-none-</option>
<%
						}
%>
						</select>
<%
					} else {
%>
					  <select style="width: 100%" disabled>
					  	<option value=""></option>
					  </select>
<%
					}
%>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message key="label.trunk.ipv6.ip" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="15%">
<%
					if (Ipv6Check_aEnd.equals("true")) {
						link_part_1 += "+'&SP_IPv6_Address_aEnd=' + ServiceForm.SP_IPv6_Address_aEnd.options[ServiceForm.SP_IPv6_Address_aEnd.selectedIndex].value";
%>
						<select id="SP_IPv6_Address_aEnd" name="SP_IPv6_Address_aEnd" onChange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';" style="width: 100%">
						<option value=""></option>
<%
						if (Ipv6_iplist_aEnd != null && !Ipv6_iplist_aEnd.isEmpty()) {
							for (int i = 0; i < Ipv6_iplist_aEnd.size(); i++) {
								if (SP_IPv6_Address_aEnd != null && SP_IPv6_Address_aEnd.equals(Ipv6_iplist_aEnd.get(i))) {
%>
									<option value="<%=Ipv6_iplist_aEnd.get(i)%>" selected><%=Ipv6_iplist_aEnd.get(i).split("@")[1]%></option>
<%
								} else {
%>
									<option value="<%=Ipv6_iplist_aEnd.get(i)%>"><%=Ipv6_iplist_aEnd.get(i).split("@")[1]%></option>
<%
						  		}
							}
						}
%>
						</select>
<%
   					} else {
%>
					  <select style="width: 100%" disabled>
					  	<option value=""></option>
					  </select>
					  
<%
					}
%>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="15%">
<%
					//if (Ipv6Check_zEnd.equals("true")) {
					if (true) {
						link_part_1 += "+'&SP_IPv6_Address_zEnd=' + ServiceForm.SP_IPv6_Address_zEnd.options[ServiceForm.SP_IPv6_Address_zEnd.selectedIndex].value";
%>
						<select id="SP_IPv6_Address_zEnd" style="display:none" name="SP_IPv6_Address_zEnd" onChange="location.href = <%=link_part_1%> + '&reqtype=newTrunk';" style="width: 100%">
						<option value=""></option>
<%
						if (Ipv6_iplist_zEnd != null && !Ipv6_iplist_zEnd.isEmpty()) {
							for (int i = 0; i < Ipv6_iplist_zEnd.size(); i++) {
								if (SP_IPv6_Address_zEnd != null && SP_IPv6_Address_zEnd.equals(Ipv6_iplist_zEnd.get(i))) {
%>
									<option value="<%=Ipv6_iplist_zEnd.get(i)%>" selected><%=Ipv6_iplist_zEnd.get(i).split("@")[1]%></option>
<%
						  		} else {
%>
									<option value="<%=Ipv6_iplist_zEnd.get(i)%>"><%=Ipv6_iplist_zEnd.get(i).split("@")[1]%></option>
<%
						  		}
							}
						}
%>
						</select>
<%
					} else {
%>
						  <select style="width: 100%" disabled>
						  	<option value=""></option>
						  </select>
<%
						}
 %>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message key="label.trunk.ip.binding" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="15%">
<%
					if (Ipv6Check_aEnd.equals("true")) {
%>
						<!--<input type="checkbox" id="SP_trunk_aIPbinding" name="SP_trunk_aIPbinding" 
							<%=SP_trunk_aIPbinding.equals("true") ? " CHECKED" : " "%>
							value="<%=SP_trunk_aIPbinding%>"
							onChange="setcheckbox('SP_trunk_aIPbinding');location.href = <%=link_part_1%> + '&reqtype=newTrunk';">-->
							<input type="text" id="SP_trunk_aIPbinding"
								name="SP_trunk_aIPbinding" maxlength="32" size="32"
								value=<%=SP_trunk_aIPbinding%>>
<%
   					} else {
%>
  					  	<input type="text" disabled>
<%
  					}
 %>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="15%">
<%
					if (Ipv6Check_aEnd!=null && Ipv6Check_aEnd.equals("true")) {
%>
						<!--input type="checkbox" id="SP_trunk_zIPbinding" name="SP_trunk_zIPbinding" 
							<%=SP_trunk_zIPbinding.equals("true") ? " CHECKED" : " "%>
							value="<%=SP_trunk_zIPbinding%>"
							onChange="setcheckbox('SP_trunk_zIPbinding');location.href = <%=link_part_1%> + '&reqtype=newTrunk';"-->
							<input type="text" id="SP_trunk_zIPbinding"
								name="SP_trunk_zIPbinding" maxlength="32" size="32"
								value=<%=SP_trunk_zIPbinding%>>
<%
					} else {
%>
					  	<input type="text" disabled>
<%
					}
%>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  }

  rowCounter++;
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message
				key="label.trunk.processid" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_trunk_aside_processid"
					name="SP_trunk_aside_processid" maxlength="32" size="15"
					value=<%=SP_trunk_aside_processid%>
					onChange="checkNumValue('SP_trunk_aside_processid','100')">
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_trunk_zside_processid"
					name="SP_trunk_zside_processid" maxlength="32" size="15"
					value=<%=SP_trunk_zside_processid%>
					onChange="checkNumValue('SP_trunk_zside_processid','100')">
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message
				key="label.trunk.areanumber" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_area_number_aEnd"
					name="SP_area_number_aEnd" maxlength="32" size="15"
					<%=area_number_aend == null ? "" : "value=\"" + area_number_aend + "\""%>>
					
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_area_number_zEnd"
					name="SP_area_number_zEnd" maxlength="32" size="15"
					<%=area_number_zend == null ? "" : "value=\"" + area_number_zend + "\""%>>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>

<%
  rowCounter++;
%>

<%
  if (!selected_trunktype.equals(Constants.TRUNK_TYPE_ETHTRUNK)) {
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message
				key="label.trunk.linkprotocol" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<select name="SP_lnk_Protocol_aside" id="SP_lnk_Protocol_aside">
						<option
							<%=SP_lnk_Protocol_aside != null && SP_lnk_Protocol_aside.equals("PPP") ? " selected" : ""%>
							value="PPP">PPP</option>
						<option
							<%=SP_lnk_Protocol_aside != null && SP_lnk_Protocol_aside.equals("hdlc") ? " selected" : ""%>
							value="hdlc">HDLC</option>
				</select>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<select name="SP_lnk_Protocol_zside" id="SP_lnk_Protocol_zside">
						<option
							<%=SP_lnk_Protocol_zside != null && SP_lnk_Protocol_zside.equals("PPP") ? " selected" : ""%>
							value="PPP">PPP</option>
						<option
							<%=SP_lnk_Protocol_zside != null && SP_lnk_Protocol_zside.equals("hdlc") ? " selected" : ""%>
							value="hdlc">HDLC</option>
				</select>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>
<%
  }
%>

<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message
				key="label.trunk.pim" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="checkbox" id="SP_pim_name_aside"
					name="SP_pim_name_aside" value="<%=SP_pim_name_aside%>"
					<%=SP_pim_name_aside.equals("true") ? " checked" : ""%>
					onchange="setcheckbox('SP_pim_name_aside')"> SM <BR>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="checkbox" id="SP_pim_name_zside"
					name="SP_pim_name_zside" value="<%=SP_pim_name_zside%>"
					<%=SP_pim_name_zside.equals("true") ? " checked" : ""%>
					onchange="setcheckbox('SP_pim_name_zside')"> SM <BR>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>

<%
  rowCounter++;
%>

<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%">
		<b><bean:message key="label.trunk.p2p" /></b>
	</td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="checkbox" id="SP_network_type_aside"
					name="SP_network_type_aside" value="<%=SP_network_type_aside%>"
					<%=SP_network_type_aside.equals("true") ? " checked" : ""%>
					onchange="setcheckbox('SP_network_type_aside')"> P2P <BR>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="checkbox" id="SP_network_type_zside"
					name="SP_network_type_zside" value="<%=SP_network_type_zside%>"
					<%=SP_network_type_zside.equals("true") ? " checked" : ""%>
					onchange="setcheckbox('SP_network_type_zside')"> P2P <BR>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>

<%
  rowCounter++;
%>

<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%">
		<b><bean:message key="label.trunk.ospf" /></b>
	</td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="checkbox" id="SP_ospf_aside"
					name="SP_ospf_aside" value="<%=SP_ospf_aside%>"
					<%=SP_ospf_aside.equals("true") ? " checked" : ""%>
					onchange="setcheckbox('SP_ospf_aside');location.href = <%=link_part_1%> + '&reqtype=newTrunk';"> OSPF <BR>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="checkbox" id="SP_ospf_zside"
					name="SP_ospf_zside" value="<%=SP_ospf_zside%>"
					<%=SP_ospf_zside.equals("true") ? " checked" : ""%>
					onchange="setcheckbox('SP_ospf_zside');location.href = <%=link_part_1%> + '&reqtype=newTrunk';"> OSPF <BR>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>

<%
  rowCounter++;
%>

<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%">
		<b><bean:message key="label.trunk.ospf.cost" /></b>
	</td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
<%
				if ("true".equals(SP_ospf_aside)) {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="text" id="SP_trunk_aside_ospf_cost"
						name="SP_trunk_aside_ospf_cost" maxlength="32" size="32"
						value=<%=SP_trunk_aside_ospf_cost%>>
					</td>
<%
				} else {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="text" id="SP_trunk_aside_ospf_cost"
						name="SP_trunk_aside_ospf_cost" maxlength="32" size="32" disabled>
					</td>
<%
				}
%>
<%
				if ("true".equals(SP_ospf_zside)) {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="text" id="SP_trunk_zside_ospf_cost"
						name="SP_trunk_zside_ospf_cost" maxlength="32" size="32"
						value=<%=SP_trunk_zside_ospf_cost%>>
					</td>
<%
				} else {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="text" id="SP_trunk_zside_ospf_cost"
						name="SP_trunk_zside_ospf_cost" maxlength="32" size="32" disabled>
					</td>
<%
				}
%>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>

<%
  rowCounter++;
%>

<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message
				key="label.trunk.ospf.cost.password" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
<%
				if ("true".equals(SP_ospf_aside)) {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="password" id="SP_OSPF_aPassword"
						name="SP_OSPF_aPassword" maxlength="32" size="32"
						value=<%=SP_OSPF_aPassword%>>
					</td>
<%
				} else {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="password" id="SP_OSPF_aPassword"
						name="SP_OSPF_aPassword" maxlength="32" size="32" disabled>
					</td>
<%
				}
%>
<%
				if ("true".equals(SP_ospf_zside)) {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="password" id="SP_OSPF_zPassword"
						name="SP_OSPF_zPassword" maxlength="32" size="32"
						value=<%=SP_OSPF_zPassword%>>
					</td>
<%
				} else {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="password" id="SP_OSPF_zPassword"
						name="SP_OSPF_zPassword" maxlength="32" size="32" disabled>
					</td>
<%
				}
%>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>

<%
  rowCounter++;
%>

<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message
				key="label.trunk.ldp" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="checkbox" id="SP_trunk_ldp_aside"
					name="SP_trunk_ldp_aside" value="<%=SP_trunk_ldp_aside%>"
					<%=SP_trunk_ldp_aside.equals("true") ? " checked" : ""%>
					onchange="setcheckbox('SP_trunk_ldp_aside');location.href = <%=link_part_1%> + '&reqtype=newTrunk';"> LDP <BR>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="checkbox" id="SP_trunk_ldp_zside"
					name="SP_trunk_ldp_zside" value="<%=SP_trunk_ldp_zside%>"
					<%=SP_trunk_ldp_zside.equals("true") ? " checked" : ""%>
					onchange="setcheckbox('SP_trunk_ldp_zside');location.href = <%=link_part_1%> + '&reqtype=newTrunk';"> LDP <BR>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>

<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message
				key="label.trunk.ldp.password" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
<%
				if ("true".equals(SP_trunk_ldp_aside)) {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="password" id="SP_LDP_aPassword"
						name="SP_LDP_aPassword" maxlength="32" size="32"
						value=<%=SP_LDP_aPassword%>>
					</td>
<%
				} else {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="password" id="SP_LDP_aPassword"
						name="SP_LDP_aPassword" maxlength="32" size="32" disabled>
					</td>
<%
				}
%>
<%
				if ("true".equals(SP_trunk_ldp_zside)) {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="password" id="SP_LDP_zPassword"
						name="SP_LDP_zPassword" maxlength="32" size="32"
						value=<%=SP_LDP_zPassword%>>
					</td>
<%
				} else {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="password" id="SP_LDP_zPassword"
						name="SP_LDP_zPassword" maxlength="32" size="32" disabled>
					</td>
<%
				}
%>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>

<%
  rowCounter++;
%>

<tr height="30">
	<td class="title" align="left" colspan="2" width="40%"><bean:message
			key="label.trunk.addmember" /></td>
	<td class="title" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="title" align="left" width="50%"><bean:message
						key="label.trunk.aEndMember" /></td>
				<td class="title" align="left" width="50%"><bean:message
						key="label.trunk.zEndMember" /></td>
			</tr>
		</table>
	</td>
	<td class="title">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message key="label.trunk.End.member.interfacename" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<select <%=selected_trunktype.equals(Constants.TRUNK_TYPE_ETHTRUNK) ? " multiple" : "" %> onClick="location.href = <%=link_part_1%> + '&reqtype=newTrunk';" size="6" id="SP_PEInterface_aEnd" name="SP_PEInterface_aEnd">
<%
					if (ifList != null && !ifList.isEmpty()) {
						for (Map.Entry<String, String> entry : ifList.entrySet()) {
							String attr = entry.getKey();
							String val = entry.getValue();
							if (peInterface_aEnd != null && peInterface_aEnd.contains(attr)) {
%>
								<option value="<%=attr%>" selected><%=val%></option>
<%
						  	} else {
								if (val == null) {
									val = "NA";
								}
%>
								<option value="<%=attr%>"><%=val%></option>
<%
						  	}
						}
					} else {
%>
						<option value="" selected>-none-</option>
<%
					}
%>
					</select>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<select <%=selected_trunktype.equals(Constants.TRUNK_TYPE_ETHTRUNK) ? " multiple" : "" %> onClick="location.href = <%=link_part_1%> + '&reqtype=newTrunk';" size="6" id="SP_PEInterface_zEnd" name="SP_PEInterface_zEnd">
<%
						if (ifList_zEnd != null && !ifList_zEnd.isEmpty()) {
							for (Map.Entry<String, String> entry : ifList_zEnd.entrySet()) {
								String attr = entry.getKey();
								String val = entry.getValue();
								if (peInterface_zEnd != null && peInterface_zEnd.contains(attr)) {
%>
									<option value="<%=attr%>" selected><%=val%></option>
<%
						  		} else {
									if (val == null) {
										val = "NA";
									}
%>
									<option value="<%=attr%>"><%=val%></option>
<%
						  		}
							}
						} else {
%>
							<option value="" selected>-none-</option>
<%
						}
%>
					</select>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>

<%
  rowCounter++;
%>

<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%"><b><bean:message
				key="label.trunk.End.member.description" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_Interface_description_aEnd"
					name="SP_Interface_description_aEnd" maxlength="242" size="32"
					value="<%=Interface_description_aEnd%>">
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_Interface_description_zEnd"
					name="SP_Interface_description_zEnd" maxlength="242" size="32"
					value="<%=Interface_description_zEnd%>">
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>

<%
  rowCounter++;

  if (selected_trunktype.equals(Constants.TRUNK_TYPE_STM16)) {
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="30%"><b><bean:message
				key="label.trunk.bandwidth" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_Trunk_bandwidth_aEnd"
					name="SP_Trunk_bandwidth_aEnd" maxlength="32" size="32"
					value="<%=Trunk_bandwidth_aEnd%>">
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_Trunk_bandwidth_zEnd"
					name="SP_Trunk_bandwidth_zEnd" maxlength="32" size="32"
					value="<%=Trunk_bandwidth_zEnd%>">
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>

<%
  rowCounter++;
%>

<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="30%"><b><bean:message
				key="label.trunk.rsvp.bandwidth" /></b></td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_Trunk_rsvp_bandwidth_aEnd"
					name="SP_Trunk_rsvp_bandwidth_aEnd" maxlength="32" size="32"
					value="<%=Trunk_rsvp_bandwidth_aEnd%>">
				</td>
				<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					<input type="text" id="SP_Trunk_rsvp_bandwidth_zEnd"
					name="SP_Trunk_rsvp_bandwidth_zEnd" maxlength="32" size="32"
					value="<%=Trunk_rsvp_bandwidth_zEnd%>">
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>

<%
	rowCounter++;
  } else {
%>
	<input type="hidden" id="SP_Trunk_bandwidth_aEnd" name="SP_Trunk_bandwidth_aEnd" value="<%=Trunk_bandwidth_aEnd%>">
	<input type="hidden" id="SP_Trunk_bandwidth_zEnd" name="SP_Trunk_bandwidth_zEnd" value="<%=Trunk_bandwidth_zEnd%>">
	<input type="hidden" id="SP_Trunk_rsvp_bandwidth_aEnd" name="SP_Trunk_rsvp_bandwidth_aEnd" value="<%=Trunk_rsvp_bandwidth_aEnd%>">
	<input type="hidden" id="SP_Trunk_rsvp_bandwidth_zEnd" name="SP_Trunk_rsvp_bandwidth_zEnd" value="<%=Trunk_rsvp_bandwidth_zEnd%>">
<%
  }

  if (selected_trunktype.equals(Constants.TRUNK_TYPE_ETHTRUNK)) {
%>
<tr height="30">
	<td class="title" align="left" colspan="2" width="40%">SubInterfaces</td>
	<td class="title" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="title" align="left" width="50%"></td>
				<td class="title" align="left" width="50%"></td>
			</tr>
		</table>
	</td>
	<td class="title">&nbsp;</td>
</tr>
<%
  rowCounter++;
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
	<td class="list<%=(rowCounter % 2)%>" align=left width="40%">
		<input type="button" id="button" value="Create-Subinterface" onClick="submitNewSubinterface();" />
	</td>
	<td class="list<%=(rowCounter % 2)%>" style="padding: 0px">
		<table border="0" width=80% cellpadding=2 cellspacing=1 width="80%">
<%
			if (sub_interface_list != null && !sub_interface_list.isEmpty()) {
				Set<Entry<String, HashMap<String, String>>> hashMaps = sub_interface_list.entrySet();
				Iterator<Entry<String, HashMap<String, String>>> hashMapsIterator = hashMaps.iterator();
				
				while (hashMapsIterator.hasNext()) {
					Entry<String, HashMap<String, String>> hashMapValue = hashMapsIterator.next();
					HashMap<String, String> hashMap = hashMapValue.getValue();
					Iterator<String> keyIterator = hashMap.keySet().iterator();
					String subinterface_name_tmp = "";
					String link_part_tmp = link_part_1;
					while (keyIterator.hasNext()) {						
						String key = keyIterator.next();
						String value = hashMap.get(key);
						link_part_tmp += " + '&SP_" + key + "=" + value + "' ";
						if (Constants.XSLPARAM_SUBINTERFACENAME.equals(key)) {
						  subinterface_name_tmp = value;
			  			}
					}
%>
					<tr>
						<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
							<a href="#" onclick="location.href = <%=link_part_tmp%>+'&reqtype=showsubinterface';"><%=subinterface_name_tmp%></a>
						</td>
					</tr>
<%
				}
			} else {
%>
				<tr>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
					</td>
				</tr>
<%
			}
%>
		</table>
	</td>
	<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
</tr>
<%
  	rowCounter++;
  }
%>
<tr height="30">
	<td class="list<%=(rowCounter % 2)%>" align="left" colspan="4"></td>
</tr>
<%
  rowCounter++;
%>
<tr>
	<td align="left" class="list<%=(rowCounter % 2)%>">
	
		<html:link href="javascript:submitBack();">
			<html:img imageName="submitObject" onclick="this.style.visibility='hidden'" page="/images/back.gif" border="0" align="right" />
		</html:link>
	</td>
	<td align="right" class="list<%=(rowCounter % 2)%>" colspan="3">
		<input type="hidden" id="reqtype" name="reqtype" value="createTrunk">
		<input type="hidden" id="mv" name="mv" value=<%=mv%>>
		<input type="hidden" id="currentPageNo" name="currentPageNo" value=<%=cpage%>>
		<input type="hidden" id="viewPageNo" name="viewPageNo" value=<%=viewPageNo%>>
		<input type="hidden" id="currentRs" name="currentRs" value=<%=strcurrentRs%>>
		<input type="hidden" id="lastRs" name="lastRs" value=<%=strlastRs%>>
		<input type="hidden" id="totalPages" name="totalPages" value=<%=strtotalPages%>>
		
		
		<html:link href="javascript:submitAddForm();">
			<html:img imageName="submitObject" onclick="this.style.visibility='hidden'" page="/images/arrow_submit.gif" border="0" align="right" />
		</html:link>
	</td>
</tr>
<%
  rowCounter++;
%>
<input type="hidden" id="manualSet">
<input type="hidden" id="SP_AddressFamily" value=<%=addressFamily%>>
<%
	} else if (!"".equals(reqtype) && "showsubinterface,createsubinterface".contains(reqtype)) {
		try {
			String serviceFormFileName1 = "";
			if ("subinterface".equalsIgnoreCase(reqtype)) {
				serviceFormFileName1 = "../forms/AddSubInterface.jsp";
			} else {
			  	// TODO finally is the same jsp, so this condition is not necessary
			  	serviceFormFileName1 = "../forms/AddSubInterface.jsp";
			}
%>
			<jsp:include page="<%=serviceFormFileName1%>" flush="true">
				<jsp:param name="serviceid" value="<%=serviceid%>" />
				<jsp:param name="parentserviceid" value="<%=parentserviceid%>" />
				<jsp:param name="type" value="<%=type%>" />
				<jsp:param name="customerid" value="<%=customerId%>" />
				<jsp:param name="mv" value="<%=mv%>" />
				<jsp:param name="currentPageNo" value="<%=currentPageNo%>" />
				<jsp:param name="viewPageNo" value="<%=viewPageNo%>" />
				<jsp:param name="messageid" value="<%=messageid%>" />
				<jsp:param name="rowCounter" value="<%=rowCounter%>" />
			</jsp:include>
<%
  		} catch (Exception e) {
			out.println(e.getMessage());
		}
	} else if (!"".equals(reqtype) && "detailTrunk".contains(reqtype)) {
%>
<tr>
<td class="title" colspan="3" align="left">Site Information</td>
</tr>

<tr>
	<th class="left">Parameter</th>
    <th class="left">Site aEnd</th>
	<th class="left">Site zEnd</th>
</tr>
<% 
	// Loop allTrunksData
	List<HashMap<String,String>> allTrunks = (List<HashMap<String,String>>)request.getAttribute("allTrunksData");
			
	HashMap<String, String> trunksa = allTrunks.get(0);
	HashMap<String, String> trunksz = allTrunks.get(1);
		
	Iterator<Map.Entry<String,String>> ita = trunksa.entrySet().iterator();
	Iterator<Map.Entry<String,String>> itz = trunksz.entrySet().iterator();
%>
	<tr align="left">
		<td class="list<%=(rowCounter % 2)%>" align="middle" class="list<%=(rowCounter % 2)%>" >
			<b>NAME</b>
		</td>
		<td class="list<%=(rowCounter % 2)%>" align="middel" class="list<%=(rowCounter % 2)%>" >
			<b><%=trunksa.get("SIDE_NAME")%></b>
		</td>
		<td class="list<%=(rowCounter % 2)%>" align="middel" class="list<%=(rowCounter % 2)%>" >
			<b><%=trunksz.get("SIDE_NAME")%></b>
		</td>
	</tr>
<%
	rowCounter++;

	while (ita.hasNext()) {				
		Entry ea = ita.next();
		Entry ez = itz.next();
%>
		<tr align="left">	
			<td class="list<%=(rowCounter % 2)%>" align="middle" class="list<%=(rowCounter % 2)%>" >
				<%=ea.getKey()%>
			</td>
			<td class="list<%=(rowCounter % 2)%>" align="middel" class="list<%=(rowCounter % 2)%>" >
				<%=(ea.getValue() != null) ? ea.getValue() : ""%>
			</td>
			<td class="list<%=(rowCounter % 2)%>" align="middel" class="list<%=(rowCounter % 2)%>" >
				<%=(ez.getValue() != null) ? ez.getValue() : ""%>
			</td>
		</tr>
<%
		rowCounter++;
	}
	
	if (allTrunks.size() > 2) {
%>
		<tr>
			<td class="title" colspan="3" align="left">Subinterfaces</td>
		</tr>
<%
		for (int i = 2; i < allTrunks.size() - 1; i++) {
			trunksa = allTrunks.get(i);
			trunksz = allTrunks.get(i + 1);
			i++;
			ita = trunksa.entrySet().iterator();
			itz = trunksz.entrySet().iterator();
%>
			<tr align="left">	
				<td class="list<%=(rowCounter % 2)%>" align="middle" class="list<%=(rowCounter % 2)%>" >
					<b>NAME</b>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align="middel" class="list<%=(rowCounter % 2)%>" >
					<b><%=trunksa.get("SIDE_NAME")%></b>
				</td>
				<td class="list<%=(rowCounter % 2)%>" align="middel" class="list<%=(rowCounter % 2)%>" >
					<b><%=trunksz.get("SIDE_NAME")%></b>
				</td>
			</tr>
<%
			rowCounter++;
	
			while (ita.hasNext()) {				
				Entry ea = ita.next();
				Entry ez = itz.next();
%>
					<tr align="left">
						<td class="list<%=(rowCounter % 2)%>" align="middle" class="list<%=(rowCounter % 2)%>" >
							<%=ea.getKey()%>
						</td>
						<td class="list<%=(rowCounter % 2)%>" align="middel" class="list<%=(rowCounter % 2)%>" >
							<%=(ea.getValue() != null) ? ea.getValue() : ""%>
						</td>
						<td class="list<%=(rowCounter % 2)%>" align="middel" class="list<%=(rowCounter % 2)%>" >
							<%=(ez.getValue() != null) ? ez.getValue() : ""%>
						</td>
					</tr>
<%
				rowCounter++;
			}
%>
			<tr>
				<td class="title" colspan="3"  />
			</tr>
<%
		}
	}
%>

<tr>
	<td align="left" class="list<%=(rowCounter % 2)%>" colspan="3">
	
		<html:link href="javascript:submitBack();">
			<html:img imageName="submitObject" onclick="this.style.visibility='hidden'" page="/images/back.gif" border="0" align="left" />
		</html:link>
	</td>
</tr>
<%
	} else {
		String SP_trunk_id = (String)request.getAttribute("SP_trunk_id");
		List<HashMap<String, String>> allTrunks = (List<HashMap<String, String>>)request.getAttribute("allTrunksPage");
		List<HashMap<String, String>> allTrunksTotal = (List<HashMap<String, String>>)request.getAttribute("allTrunks");
		if (allTrunks != null ){
%>
	<table width="100%" cellspacing="0" cellpadding="2" border="0" align="center">

	<tr>
              <td class="title"><font color ="white" size="2pt"><bean:message key="label.existing.serv"/> (<%=allTrunksTotal.size()%>)</font>
			  </td>
			  <td width="14%"class="title" align="Right">
			   <font color ="white" size="1pt"><bean:message key="label.page.service"/> <%=cpage%>/<%=totalPages%></font>
			   </td>   
			   
			   <%		
				String stsCurrPg = String.valueOf(cpage);
			    String strViewPgNo = String.valueOf(vPageNo);
				String viewPgNo=strViewPgNo;

				HashMap navigationparams = new HashMap();
			    navigationparams.put("customerid",customerId);
		        navigationparams.put("doResetReload","true");
			  	navigationparams.put("currentPageNo",stsCurrPg);	
				//navigationparams.put("hidautoRefreshOn",autoRefreshOn);
                navigationparams.put("currentRs",String.valueOf(currentRs));
			    navigationparams.put("lastRs",String.valueOf(lastRs));
				navigationparams.put("sort",strSort);
				navigationparams.put("type","Trunk");
				%>
				 <input type="hidden" name="customerid" value="<%=customerId%>">
				  <input type="hidden" name="doResetReload" value="true">
				  <input type="hidden" name="mv" value="viewpageno">
				  <input type="hidden" name="currentPageNo" value="<%=stsCurrPg%>">
                
				  <input type="hidden" name="viewPageNo" value="<%=strViewPgNo%>">				
                  <input type="hidden" name="hidviewPageNo" value="<%=vPageNo%>">
				  <input type="hidden" name="sort" value="<%=strSort%>">
				  
				  <%
	                 
                          if(  totalPages > 0)
				  { 
		               navigationparams.put("mv","viewpageno");
					   pageContext.setAttribute("paramsMap", navigationparams);

		%>
                  <td width="25%" class="title" align="Right"> 
				   <html:link  href="javascript:callviewByPageNo();" >
					<font color = "white" size="1pt"><bean:message key="label.gotopage"/></font>
				   </html:link>				   
				   <input type="text" size="3" name="txtviewPageNo" value="<%=String.valueOf(cpage)%>">
				   </td>
										
	   <%          } 
	   
					if( cpage >1 )
				{
		               navigationparams.put("mv","first");
					   pageContext.setAttribute("paramsMap", navigationparams);

		         
	   %>			
	            <td width="5%" class="title" align="Left">                     
				    <html:link page="/CreateService.do" name="paramsMap" scope="page">
						 <font color = "white" size="1pt"><bean:message key="label.first"/> </font>
				    </html:link>
				</td>  

	<%          }   
				else
				{
	 %>            
	               <td width="5%" class="title" align="Left">   
					 <font color = "#C0C0C0" size="1pt"><bean:message key="label.first"/> </font>
				 </td>

	 <%         } 
				if( cpage > 1 )
				{
                       navigationparams.put("mv","prev");
					   pageContext.setAttribute("paramsMap", navigationparams);

	%>				<td  width="8%"class="title"  align="Left">                     
						  <html:link page="/CreateService.do" name="paramsMap" scope="page" >
						 <font color = "white" size="1pt"> <bean:message key="label.prev"/>  </font>
						 </html:link>
					</td>  
	<%          }   
				else
				{
	 %>             <td  width="8%"class="title"  align="Left">   
					    <font color = "#C0C0C0" size="1pt"> <bean:message key="label.prev"/> </font>
					</td>
	 <%         }    
				if( cpage < totalPages ) 
				{ 
                       navigationparams.put("mv","next");
					   pageContext.setAttribute("paramsMap", navigationparams);

					
	%>                <td  width="5%"class="title"  align="Right">                                      
     				  <html:link page="/CreateService.do" name="paramsMap" scope="page" >
						  <font color = "white" size="1pt"> <bean:message key="label.next"/> </font>
					   </html:link>
					  </td>
	<%                         
		        } 
				else
				{
	%>            <td width="5%" class="title"  align="Right">
					  <font color = "#C0C0C0" size="1pt"> <bean:message key="label.next"/> </font>
				  </td>
	<%          }

	
				if( cpage < totalPages )
				{
		               navigationparams.put("mv","last");
					   pageContext.setAttribute("paramsMap", navigationparams);
	   %>					
	            <td  width="5%" class="title"  align="Right">                     
				  <html:link page="/CreateService.do" name="paramsMap" scope="page" >
				 <font color = "white" size="1pt"> <bean:message key="label.last"/> </font>
				 </html:link>
				</td> 
	<%       
		          }   
				else
				{
	 %>             <td  width="5%" class="title"  align="Right">   
					 <font color = "#C0C0C0"size="1pt"> <bean:message key="label.last"/> </font>
					 </td> 
	 <%         } 
	
	 %>
	 </tr>
			  
	</table>
<%
		}
		
%>
<table width="100%" cellspacing="1" cellpadding="2" border="0" align="center">
	<tr>
		<th class="left" width="1%"></th>
        <th class="left">&nbsp;&nbsp;<bean:message key="label.Id"/>&nbsp;</th>
		<th class="center"><bean:message key="label.trunk.name"/></th>
		<th class="center"><bean:message key="label.State"/>&nbsp;</th>
		<th class="center"><bean:message key="label.Type"/>&nbsp;</th>
		<th class="center"><bean:message key="label.Submitdate"/>&nbsp;</th>
		<th class="center"><bean:message key="label.routerA"/>&nbsp;</th>
		<th class="center"><bean:message key="label.routerZ"/>&nbsp;</th>
		<th class="left">&nbsp;&nbsp;<bean:message key="label.Action"/>&nbsp;</th>
		<th class="center">&nbsp;</th>
	</tr>
<%
		//String SP_trunk_id = (String)request.getAttribute("SP_trunk_id");
		//List<HashMap<String, String>> allTrunks = (List<HashMap<String, String>>)request.getAttribute("allTrunksPage");
		if (allTrunks != null && allTrunks.size() != 0) {
			for (HashMap<String, String> trunk : allTrunks) {
%>
				<tr height="30">
					<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
					<td class="list<%=(rowCounter % 2)%>" valign="middle"><%= Utils.escapeXml(trunk.get("trunk_id")) %>&nbsp;</td>
					<td class="list<%=(rowCounter % 2)%>" valign="middle">
						<a id="<%=trunk.get("trunk_id") %>" href="#" onclick="submitDetail(this.id,<%=customerId%>,<%=vPageNo%>,<%=cpage%>);"><%=Utils.escapeXml(trunk.get("name") ) %>&nbsp;</a>
					</td>
					<td class="list<%=(rowCounter % 2)%>" valign="middle"><%=Utils.escapeXml(trunk.get("status") ) %>&nbsp;</td>
					<td class="list<%=(rowCounter % 2)%>" valign="middle"><%=Utils.escapeXml(trunk.get("link_type") ) %>&nbsp;</td>
					<td class="list<%=(rowCounter % 2)%>" valign="middle"><%=Utils.escapeXml(trunk.get("submit_data") ) %>&nbsp;</td>
					<td class="list<%=(rowCounter % 2)%>" valign="middle"><%=Utils.escapeXml(trunk.get("router_a") ) %>&nbsp;</td>
					<td class="list<%=(rowCounter % 2)%>" valign="middle"><%=Utils.escapeXml(trunk.get("router_z") ) %>&nbsp;</td>
					<td class="list<%=(rowCounter % 2)%>" valign="middle">
					<input type="hidden" id="reqtype" name="reqtype" value="deleteTrunk">
					<input type="hidden" id="SP_trunk_id" name="SP_trunk_id" value="DEFAULT">
<%
						if (!"In process".equals(trunk.get("status")) && !trunk.get("trunk_id").equals(SP_trunk_id)) {
					%>			
								<input type="hidden" id="mv" name="mv" value=<%=mv%>>
								<input type="hidden" id="currentPageNo" name="currentPageNo" value=<%=mv%>>
								<input type="hidden" id="viewPageNo" name="viewPageNo" value=<%=viewPageNo%>>
								<input type="hidden" id="currentRs" name="currentRs" value=<%=strcurrentRs%>>
								<input type="hidden" id="lastRs" name="lastRs" value=<%=strlastRs%>>
								<input type="hidden" id="totalPages" name="totalPages" value=<%=strtotalPages%>>

							<img id="<%=trunk.get("trunk_id") %>" src="images/Delete.gif" onClick="submitDelForm(this.id);" title="Drop service"/>
<%
						}
%>
					</td>
					<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
				</tr>
<%
  rowCounter++;
%>
<%
			}
		} else {
%>
				<tr height="30">
					<td class="list<%=(rowCounter % 2)%>" align=center width="10%" colspan=10>No services</td>
				</tr>
<%
  rowCounter++;
%>
<%			
		}
				
		String link_to_newTrunk = "'/crm/CreateService.do?serviceid=" + serviceid + "&customerid=" + customerId
			+ "&SP_Site_Service_ID_aEnd=" + Site_Service_ID_aEnd + "&SP_Site_Service_ID_zEnd="
			+ Site_Service_ID_zEnd + "&mv=" + mv + "&currentPageNo=" + cpage + "&viewPageNo="
			+ viewPageNo + "&resend=" + resendCreate + "&reselect=" + resend + "&type=" + "Trunk" + "&reqtype=" + "newTrunk"+
			"&currentRs="+strcurrentRs+"&lastRs="+strlastRs+"&totalPages="+strtotalPages+"'";		
			
%>
		<tr height="30">
			<td class="list<%=(rowCounter % 2)%>">&nbsp;</td>
			<td class="list<%=(rowCounter % 2)%>" align=left width="40%" colspan=9>
				<input type="button" id="button" value="Create-Trunk" onClick="location.href=<%=link_to_newTrunk%>"/>
			</td>
		</tr>
<%
	}
%>
<input type="hidden" name="resend" value=<%=resendCreate%>>

<script>
	function setcheckbox(id) {		
		if (document.getElementById(id).checked) {
 			document.getElementById(id).value="true";
 		} else {
	 		document.getElementById(id).value="false";
	 	}
	}

	function checkNumValue(input,defaultvalue){
		var str = document.getElementById(input).value;
		var newStr = "";
		for (i = 0; i < str.length; i++) {
			if (str.charAt(i) >= '0' && str.charAt(i) <= '9') {
				newStr = newStr + str.charAt(i);
	  		}
  		}
  		if (str != newStr || newStr.length == 0) {
	  		alert("You must enter a number");
	  		document.getElementById(input).value = defaultvalue;
	  		return false;
  		}
  		return true;
	}
	
	function checkNumValueOrSpace(input, prompt){
  		var str = input.value;
  		var newStr = "";
		for (i = 0; i < str.length; i++){
			if (str.charAt(i) >= '0' && str.charAt(i) <= '9') {
		  		newStr = newStr + str.charAt(i);
		 	}
		}
		if (str != newStr) {
		 	alert(prompt);
		 	input.value = newStr;
		 	return false;
		}
		return true;
	}
			
	function submitAddForm() {
		if ("none" == ServiceForm.SP_PERouter_aEnd.value || "none" == ServiceForm.SP_PERouter_zEnd.value
				|| "" == ServiceForm.SP_PERouter_aEnd.value || "" == ServiceForm.SP_PERouter_zEnd.value) {
			alert('Routers can not be empty, please select them before submit');	
		} 
		/* else if ("" == ServiceForm.SP_trunk_ipaddress_aEnd.value && "" == ServiceForm.SP_IPv6_Address_aEnd.value) {
			alert('IP or IPv6 is a mandatory value for A side');
		} else if ("" == ServiceForm.SP_trunk_ipaddress_zEnd.value && "" == ServiceForm.SP_IPv6_Address_zEnd.value) {
			alert('IP or IPv6 is a mandatory value for Z side');
		} */
		else if (ServiceForm.SP_Trunk_Type.value == 2 && 
				("none" == ServiceForm.SP_PEInterface_aEnd.value || "none" == ServiceForm.SP_PEInterface_zEnd.value
				|| "" == ServiceForm.SP_PEInterface_aEnd.value || "" == ServiceForm.SP_PEInterface_zEnd.value)) {
			alert('Interfaces A and Z can not be empty for STM16, please select them before submit');
		} else {						
			document.ServiceForm.action = "CommitTrunkService.do";
			document.ServiceForm.submit();
			return true;
		}
	}
	
	function submitBack() {
		window.location.href = "CreateService.do?sort=desc&customerid=<%=customerId%>&mv=viewpageno&viewPageNo=<%=vPageNo%>&type=Trunk&currentPageNo=<%=cpage%>";
	}
	
	function submitDetail(id,customerid,vPageNo,cpage) {
		window.location.href = "CreateService.do?sort=desc&customerid="+customerid+"&mv=viewpageno&viewPageNo="+vPageNo+"&type=Trunk&currentPageNo="+cpage+"&reqtype=detailTrunk&serviceId=" + id;
	}
	
	function submitNewSubinterface() {
		if ("none" == ServiceForm.SP_PERouter_aEnd.value || "none" == ServiceForm.SP_PERouter_zEnd.value
				|| "" == ServiceForm.SP_PERouter_aEnd.value || "" == ServiceForm.SP_PERouter_zEnd.value) {
			alert('Please select the routers before create subinterfaces');
		} else {
			window.location.href = <%=link_part_1%> + '&reqtype=createsubinterface';	
		}
	}
	
	function submitDelForm(id) {
		document.getElementById("SP_trunk_id").value = id;
		var e = document.getElementById(id);
		e.style.display = ((e.style.display != 'none') ? 'none' : 'block');
		document.ServiceForm.action = "CommitTrunkService.do";
		document.ServiceForm.submit();
		return true;
	}

	function isIE_browser() {
    	if (window.XMLHttpRequest) {
			return false;
  		} else {
			return true;
  		}
	}

	function getObjectById(objID) {
		if (document.getElementById  &&  document.getElementById(objID)) {
    		return document.getElementById(objID);
  		} else {
    		if (document.all  &&  document.all(objID)) {
      			return document.all(objID);
    		} else {
      			if (document.layers  &&  document.layers[objID]) {
        			return document.layers[objID];
      			} else {
        			return document.ServiceForm.elements[objID];
      			}
    		}
  		}
	}

	function setVisible(Id) {
   		if(isIE_browser()) {
			document.getElementById(Id).style.visibility = 'visible';
		} else {
	        document.getElementsByName(Id)[0].style.visibility = 'visible';
		}
	}

	function myFunction() {
		alert("Entering the function");
	    var x = document.getElementById('data-table');
	    if (x.style.display == 'none') {
    		alert("Display is 'none' initally");
        	x.style.display = 'block';
    	} else {
	    	alert("Display is 'block' initally");
        	x.style.display = 'none';
    	}
	}

	function getAllSelectedOptions(select) {
		var result = "";
		for (var i = 0; i < select.options.length; i++) {
			var o = select.options[i];
			if ( select.options[i].selected) {
				if (result == "") {
					result = o.value;
				} else {
					result += ";" + o.value;
				}
			}
		}
		return result;
	}
	
	function trim(str){      		
      		return str.replace(/^\s*(.*?)[\s\n]*$/g, '$1'); 
      		} 
	
	 function callviewByPageNo()
	{
		
	    var error = false;
		var customerid='<%=customerId%>';
		var currentPageNo='<%=cpage%>';	
		var totalNoOfPages='<%=totalPages%>';	
		var sort = '<%=strSort%>'
		document.forms[0].customerid.value = customerid;
		document.forms[0].currentPageNo.value = currentPageNo;

		var viewPageNo = trim(document.forms[0].txtviewPageNo.value);
		
		if(viewPageNo==null||viewPageNo=="")
		{
			alert(' <bean:message key="js.enter.number" /> ');
			error = true;
		}
		else
		{
		     if( parseInt(parseFloat(viewPageNo)) > parseInt(parseFloat(totalNoOfPages)))
		    {
			alert('<bean:message key="js.enter.number.hint" />'+viewPageNo+' <bean:message key="js.greater.number" />'+totalNoOfPages);
			error = true;
		     }
		    if(parseInt(parseFloat(viewPageNo))<=0)
		     {
			alert('<bean:message key="js.enter.number.hint" />'+viewPageNo+' <bean:message key="js.unavailable.number" />');
			error = true;
		     }
		}

		if(error==true)
		{
		
	      document.forms[0].txtviewPageNo.select();
         document.forms[0].txtviewPageNo.focus();
	   }
        else
		{
		 document.forms[0].txtviewPageNo.value = viewPageNo;
		                

		var page = "CreateService.do?mv=viewpageno&doResetReload=true&customerid="+customerid+"&currentPageNo="+currentPageNo+"&viewPageNo="+viewPageNo+"&sort="+sort+"&type=Trunk";
        self.location.href = page;
		}
	}
</script>
