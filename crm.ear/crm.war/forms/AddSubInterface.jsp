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
	import="com.hp.ov.activator.crmportal.action.*, java.sql.*, javax.sql.*,com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*, java.text.*, java.net.*,com.hp.ov.activator.crmportal.utils.DatabasePool,com.hp.ov.activator.crmportal.utils.*,org.apache.log4j.Logger"%>
<%
  String ua = request.getHeader("User-Agent");
  boolean isFirefox = (ua != null && ua.indexOf("Firefox/") != -1);
  boolean isMSIE = (ua != null && ua.indexOf("MSIE") != -1);
  response.setHeader("Vary", "User-Agent");

  HashSet roles = (HashSet) session.getAttribute(Constants.ROLES_KEY);
  boolean isOperator = false;
  boolean isAdministrator = false;
  if (roles.contains(Constants.ROLE_ADMIN)) {
    isAdministrator = true;
  }
  if (roles.contains(Constants.ROLE_OPERATOR)) {
    isOperator = true;
  }

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
  
  String SP_SubInterfaceName = (String) request.getAttribute("SP_SubInterfaceName");
  String reqtype = (String) request.getAttribute("reqtype");
  boolean modify = false;
  String presname = serviceform.getPresname();
  HashMap<String, HashMap<String, String>> sub_interface_list = (HashMap<String, HashMap<String, String>>) session.getAttribute("sub_interface_list");

  if ("showsubinterface".equals(reqtype) && SP_SubInterfaceName != null) {
    modify = true;
  } else {
    if (sub_interface_list == null || sub_interface_list.isEmpty()) {
      SP_SubInterfaceName = presname + ".1";
    } else {
      SP_SubInterfaceName = presname + "." + (sub_interface_list.size() + 1);
    }
  }
  
  String mv = (String) request.getAttribute("mv");
  String currentPageNo = (String) request.getAttribute("currentPageNo");
  String viewPageNo = (String) request.getAttribute("viewPageNo");
  String resendCreate = (String) request.getAttribute("resend");
  Boolean resend = resendCreate != null && resendCreate.equals("true");

  String ipaddrlist = (String) request.getAttribute("ipaddrlist");
  String ipaddrlist_zEnd = (String) request.getAttribute("ipaddrlist_zEnd");
  String Subipaddrlist = (String) request.getAttribute("SP_Sub_ipaddress_aEnd");
  String Subipaddrlist_zEnd = (String) request.getAttribute("SP_Sub_ipaddress_zEnd");

  List<String> iplist = new ArrayList<String>();
  iplist = (List<String>) request.getAttribute("Subiplist");
  List<String> iplist_zEnd = new ArrayList<String>();
  iplist_zEnd = (List<String>) request.getAttribute("Subiplist_zEnd");

  ServiceParameter[] available_regions = (ServiceParameter[]) request.getAttribute("available_regions");
  ServiceParameter[] available_locations = (ServiceParameter[]) request.getAttribute("available_locations");

  Location[] locations_aEnd = (Location[]) request.getAttribute("locations_aEnd");
  Location[] locations_zEnd = (Location[]) request.getAttribute("locations_zEnd");
  Region[] regions = (Region[]) request.getAttribute("regions");
  IPAddrPool[] Subpools = (IPAddrPool[]) request.getAttribute("pools");
  String pool_aEnd = (String) request.getAttribute("Subpool_aEnd");
  String pool_zEnd = (String) request.getAttribute("Subpool_zEnd");
  String SP_Sub_IPv6_family_aEnd = (String) request.getAttribute("SP_Sub_IPv6_family_aEnd");
  if (SP_Sub_IPv6_family_aEnd == null) {
    SP_Sub_IPv6_family_aEnd = "false";
  }
  String SP_Sub_IPv6_family_zEnd = (String) request.getAttribute("SP_Sub_IPv6_family_zEnd");
  if (SP_Sub_IPv6_family_zEnd == null) {
    SP_Sub_IPv6_family_zEnd = "false";
  }

  String vendor_name = (String) request.getAttribute("vendor_name");
  String trunktype = (String) request.getAttribute("trunktype");
  String include_aEnd = (String) request.getAttribute("include_aEnd");
  String include_zEnd = (String) request.getAttribute("include_zEnd");
  String trunkname = (String) request.getAttribute("trunkname");

  String SubEndA_name = (String) request.getAttribute("SubEndA_name");
  if (SubEndA_name == null) {
    SubEndA_name = SP_SubInterfaceName + "-aEnd";
  }
  String SubEndB_name = (String) request.getAttribute("SubEndB_name");
  if (SubEndB_name == null) {
    SubEndB_name = SP_SubInterfaceName + "-zEnd";
  }
  String addressFamily = (String) request.getAttribute("AddressFamily");

  //added for trunk testing.
  String transfer_mode = null;
  String area_number_aend = (String) request.getAttribute("SP_SubArea_number_aEnd");
  String area_number_zend = (String) request.getAttribute("SP_SubArea_number_zEnd");
  //end code testing
  // PW_Type states the type of service: FR, PPP, Ethernet
  String PW_Type_aEnd = (String) request.getAttribute("PW_Type_aEnd");
  String PW_Type_zEnd = (String) request.getAttribute("PW_Type_zEnd");

  // EthType states the type of service: port or port-vlan
  String EthType_aEnd = (String) request.getAttribute("EthType_aEnd");
  String EthType_zEnd = (String) request.getAttribute("EthType_zEnd");

  String UNIType_aEnd = (String) request.getAttribute("UNIType_aEnd");
  String UNIType_zEnd = (String) request.getAttribute("UNIType_zEnd");

  String SubSite_Service_ID_aEnd = (String) request.getAttribute("SP_SubSite_Service_ID_aEnd");
  String SubSite_Service_ID_zEnd = (String) request.getAttribute("SP_SubSite_Service_ID_zEnd");
  
  String SP_SubInt_description_aEnd = (String) request.getAttribute("SP_SubInt_description_aEnd");
  String SP_SubInt_description_zEnd = (String) request.getAttribute("SP_SubInt_description_zEnd");

  if (SP_SubInt_description_aEnd == null)
    SP_SubInt_description_aEnd = "";
  if (SP_SubInt_description_zEnd == null)
    SP_SubInt_description_zEnd = "";  

  String SP_SubNegotiation_aend = (String) request.getAttribute("SP_SubNegotiation_aend");
  String SP_SubNegotiation_zend = (String) request.getAttribute("SP_SubNegotiation_zend");
  if (SP_SubNegotiation_aend == null)
    SP_SubNegotiation_aend = "true";
  if (SP_SubNegotiation_zend == null)
    SP_SubNegotiation_zend = "true";

  String SP_Sub_pim_name_aside = (String) request.getAttribute("SP_Sub_pim_name_aside");
  String SP_Sub_pim_name_zside = (String) request.getAttribute("SP_Sub_pim_name_zside");
  if (SP_Sub_pim_name_aside == null)
    SP_Sub_pim_name_aside = "true";
  if (SP_Sub_pim_name_zside == null)
    SP_Sub_pim_name_zside = "true";

  String SP_Sub_network_type_aside = (String) request.getAttribute("SP_Sub_network_type_aside");
  String SP_Sub_network_type_zside = (String) request.getAttribute("SP_Sub_network_type_zside");
  if (SP_Sub_network_type_aside == null)
    SP_Sub_network_type_aside = "true";
  if (SP_Sub_network_type_zside == null)
    SP_Sub_network_type_zside = "true";
  
  String SP_Sub_ospf_aside = (String) request.getAttribute("SP_Sub_ospf_aside");
  String SP_Sub_ospf_zside = (String) request.getAttribute("SP_Sub_ospf_zside");
  if (SP_Sub_ospf_aside == null)
    SP_Sub_ospf_aside = "true";
  if (SP_Sub_ospf_zside == null)
    SP_Sub_ospf_zside = "true";

  String SP_Subldp_aend = (String) request.getAttribute("SP_Subldp_aend");
  String SP_Subldp_zend = (String) request.getAttribute("SP_Subldp_zend");
  if (SP_Subldp_aend == null)
    SP_Subldp_aend = "true";
  if (SP_Subldp_zend == null)
    SP_Subldp_zend = "true";

  String SP_Sub_ip_submask_aEnd = (String) request.getAttribute("SP_Sub_ip_submask_aEnd");
  String SP_Sub_ip_submask_zEnd = (String) request.getAttribute("SP_Sub_ip_submask_zEnd");

  String SP_Sub_ip_networkIP_aEnd = (String) request.getAttribute("SP_Sub_ip_networkIP_aEnd");
  String SP_Sub_ip_networkIP_zEnd = (String) request.getAttribute("SP_Sub_ip_networkIP_zEnd");
  String SP_Sub_wildcard_aEnd = (String) request.getAttribute("SP_Sub_wildcard_aEnd");
  String SP_Sub_wildcard_zEnd = (String) request.getAttribute("SP_Sub_wildcard_zEnd");

  Service[] sites = (Service[]) request.getAttribute("available_sites");

  /************** GET Trunk Details *****************************/
  String Site_Service_ID_aEnd = (String) request.getAttribute("SP_Site_Service_ID_aEnd");
  String Site_Service_ID_zEnd = (String) request.getAttribute("SP_Site_Service_ID_zEnd");
  String SP_trunk_policy_aside = (String) request.getAttribute("SP_trunk_policy_aside");
  String SP_trunk_policy_zside = (String) request.getAttribute("SP_trunk_policy_zside");
  String SP_QOS_PROFILE = (String) request.getAttribute("SP_QOS_PROFILE");
  String Traffic_policy_io_aend = (String) request.getAttribute("SP_Traffic_policy_io_aend");
  String Traffic_policy_io_zend = (String) request.getAttribute("SP_Traffic_policy_io_zend");
  String trunk_description_aEnd = (String) request.getAttribute("SP_trunk_description_aEnd");
  String trunk_description_zEnd = (String) request.getAttribute("SP_trunk_description_zEnd");
  String PW_aEnd_region = (String) serviceform.getSP_PW_aEnd_region();
  String PW_zEnd_region = (String) serviceform.getSP_PW_zEnd_region();
  String PW_aEnd_location = (String) serviceform.getSP_PW_aEnd_location();
  String PW_zEnd_location = (String) serviceform.getSP_PW_zEnd_location();
  String SP_AddressPool_aEnd = (String) serviceform.getSP_AddressPool_aEnd();
  String SP_AddressPool_zEnd = (String) serviceform.getSP_AddressPool_zEnd();
  String SP_trunk_ipaddress_aEnd = (String) serviceform.getSP_trunk_ipaddress_aEnd();
  String SP_trunk_ipaddress_zEnd = (String) serviceform.getSP_trunk_ipaddress_zEnd();
  String SP_trunk_negotiation_aside = (String) serviceform.getSP_trunk_negotiation_aside();
  String SP_trunk_negotiation_zside = (String) serviceform.getSP_trunk_negotiation_zside();
  String SP_trunk_aside_mtu = (String) serviceform.getSP_trunk_aside_mtu();
  String SP_trunk_zside_mtu = (String) serviceform.getSP_trunk_zside_mtu();
  String SP_IPv6_family_aEnd = (String) serviceform.getSP_IPv6_family_aEnd();
  String SP_IPv6_family_zEnd = (String) serviceform.getSP_IPv6_family_zEnd();
  String SP_IPv6_Pool_aEnd = (String) serviceform.getSP_IPv6_Pool_aEnd();
  String SP_IPv6_Pool_zEnd = (String) serviceform.getSP_IPv6_Pool_zEnd();
  String SP_IPv6_Address_aEnd = (String) serviceform.getSP_IPv6_Address_aEnd();
  String SP_IPv6_Address_zEnd = (String) serviceform.getSP_IPv6_Address_zEnd();
  String SP_trunk_aIPbinding = (String) serviceform.getSP_trunk_aIPbinding();
  String SP_trunk_zIPbinding = (String) serviceform.getSP_trunk_zIPbinding();
  String SP_trunk_aside_processid = (String) serviceform.getSP_trunk_aside_processid();
  String SP_trunk_zside_processid = (String) serviceform.getSP_trunk_zside_processid();
  String SP_ospf_aside = (String) serviceform.getSP_ospf_aside();
  String SP_ospf_zside = (String) serviceform.getSP_ospf_zside();
  String SP_trunk_aside_ospf_cost = (String) serviceform.getSP_trunk_aside_ospf_cost();
  String SP_trunk_zside_ospf_cost = (String) serviceform.getSP_trunk_zside_ospf_cost();
  String SP_OSPF_aPassword = (String) serviceform.getSP_OSPF_aPassword();
  String SP_OSPF_zPassword = (String) serviceform.getSP_OSPF_zPassword();
  String SP_LDP_aPassword = (String) serviceform.getSP_LDP_aPassword();
  String SP_LDP_zPassword = (String) serviceform.getSP_LDP_zPassword();
  String perouter_aEnd = (String) request.getAttribute("PERouter_aEnd");
  String perouter_zEnd = (String) request.getAttribute("PERouter_zEnd");
  String peinterface_aEnd = (String) request.getAttribute("peinterface_aEnd");
  String peinterface_zEnd = (String) request.getAttribute("peinterface_zEnd");
  String SP_area_number_aEnd = (String) request.getAttribute("SP_area_number_aEnd");
  String SP_area_number_zEnd = (String) request.getAttribute("SP_area_number_aEnd");
  String SP_network_type_aside = (String) request.getAttribute("SP_network_type_aside");
  String SP_network_type_zside = (String) request.getAttribute("SP_network_type_zside");
  String SP_trunk_ldp_aside = (String) request.getAttribute("SP_trunk_ldp_aside");
  String SP_trunk_ldp_zside = (String) request.getAttribute("SP_trunk_ldp_zside");
  String SP_SubLDP_aPassword = (String) request.getAttribute("SP_SubLDP_aPassword");
  String SP_SubLDP_zPassword = (String) request.getAttribute("SP_SubLDP_zPassword");
  if (SP_SubLDP_aPassword == null)
    SP_SubLDP_aPassword = "";
  if (SP_SubLDP_zPassword == null)
    SP_SubLDP_zPassword = "";
  String SP_lnk_Protocol_aside = (String) request.getAttribute("SP_lnk_Protocol_aside");
  String SP_lnk_Protocol_zside = (String) request.getAttribute("SP_lnk_Protocol_zside");
  String SP_pim_name_aside = (String) request.getAttribute("SP_pim_name_aside");
  String SP_pim_name_zside = (String) request.getAttribute("SP_pim_name_zside");
  String Interface_description_aEnd = (String) request.getAttribute("SP_Interface_description_aEnd");
  String Interface_description_zEnd = (String) request.getAttribute("SP_Interface_description_zEnd");
  String Trunk_bandwidth_aEnd = (String) request.getAttribute("SP_Trunk_bandwidth_aEnd");
  String Trunk_bandwidth_zEnd = (String) request.getAttribute("SP_Trunk_bandwidth_zEnd");
  String Trunk_rsvp_bandwidth_aEnd = (String) request.getAttribute("SP_Trunk_rsvp_bandwidth_aEnd");
  String Trunk_rsvp_bandwidth_zEnd = (String) request.getAttribute("SP_Trunk_rsvp_bandwidth_zEnd");
  String SP_link_type = (String) request.getAttribute("SP_link_type");
  String SP_Subtrunk_mtu_aend = (String) request.getAttribute("SP_Subtrunk_mtu_aend");
  if (SP_Subtrunk_mtu_aend == null)
    SP_Subtrunk_mtu_aend = "1700";
  String SP_Subtrunk_mtu_zend = (String) request.getAttribute("SP_Subtrunk_mtu_zend");
  if (SP_Subtrunk_mtu_zend == null)
    SP_Subtrunk_mtu_zend = "1700";
  String SP_Subtrunk_ospf_cost_aend = (String) request.getAttribute("SP_Subtrunk_ospf_cost_aend");
  if (SP_Subtrunk_ospf_cost_aend == null || "".equals(SP_Subtrunk_ospf_cost_aend))
    SP_Subtrunk_ospf_cost_aend = "200";
  String SP_Subtrunk_ospf_cost_zend = (String) request.getAttribute("SP_Subtrunk_ospf_cost_zend");
  if (SP_Subtrunk_ospf_cost_zend == null || "".equals(SP_Subtrunk_ospf_cost_zend))
    SP_Subtrunk_ospf_cost_zend = "200";
  String SP_SubOSPF_aPassword = (String) request.getAttribute("SP_SubOSPF_aPassword");
  String SP_SubOSPF_zPassword = (String) request.getAttribute("SP_SubOSPF_zPassword");
  if (SP_SubOSPF_aPassword == null)
    SP_SubOSPF_aPassword = "";
  if (SP_SubOSPF_zPassword == null)
    SP_SubOSPF_zPassword = "";
  String SP_Subtrunk_policy_aside = (String) request.getAttribute("SP_Subtrunk_policy_aside");
  if (SP_Subtrunk_policy_aside == null)
    SP_Subtrunk_policy_aside = "";

  String SP_Subtrunk_policy_zside = (String) request.getAttribute("SP_Subtrunk_policy_zside");
  if (SP_Subtrunk_policy_zside == null)
    SP_Subtrunk_policy_zside = "";

  String SP_Subtrunk_processid_aEnd = (String) request.getAttribute("SP_Subtrunk_processid_aEnd");
  if (SP_Subtrunk_processid_aEnd == null)
    SP_Subtrunk_processid_aEnd = "100";
  String SP_Subtrunk_processid_zEnd = (String) request.getAttribute("SP_Subtrunk_processid_zEnd");
  if (SP_Subtrunk_processid_zEnd == null)
    SP_Subtrunk_processid_zEnd = "100";

  // IPv6
  List<String> SubIpv6_iplist_aEnd = (List<String>) request.getAttribute("SubIpv6_iplist_aEnd");
  List<String> SubIpv6_iplist_zEnd = (List<String>) request.getAttribute("SubIpv6_iplist_zEnd");
  
  String SubIpv6_pool_aEnd = (String) request.getAttribute("SP_Sub_IPv6_Pool_aEnd");
  String SubIpv6_pool_zEnd = (String) request.getAttribute("SP_Sub_IPv6_Pool_zEnd");
  
  String SubIpv6_ipaddrlist_aEnd = (String) request.getAttribute("SP_Sub_IPv6_Address_aEnd");
  String SubIpv6_ipaddrlist_zEnd = (String) request.getAttribute("SP_Sub_IPv6_Address_zEnd");
  
  String SP_Sub_IPv6_encap_aEnd = (String) request.getAttribute("SP_Sub_IPv6_encap_aEnd");
  String SP_Sub_IPv6_encap_zEnd = (String) request.getAttribute("SP_Sub_IPv6_encap_zEnd");
  if (SP_Sub_IPv6_encap_aEnd == null)
    SP_Sub_IPv6_encap_aEnd = "";
  if (SP_Sub_IPv6_encap_zEnd == null)
    SP_Sub_IPv6_encap_zEnd = "";

  String SP_Sub_IPv6_binding_aEnd = (String) request.getAttribute("SP_Sub_IPv6_binding_aEnd");
  String SP_Sub_IPv6_binding_zEnd = (String) request.getAttribute("SP_Sub_IPv6_binding_zEnd");
  if (SP_Sub_IPv6_binding_aEnd == null)
    SP_Sub_IPv6_binding_aEnd = "";
  if (SP_Sub_IPv6_binding_zEnd == null)
    SP_Sub_IPv6_binding_zEnd = "";
  
  /*********************end***************************************/

  String link_part = "'/crm/CreateService.do?serviceid=" + serviceid 
  + "&customerid=" + customerId 
  + "&presname=" + presname
  + "&SP_SubSite_Service_ID_aEnd=" + SubSite_Service_ID_aEnd 
  + "&SP_SubSite_Service_ID_zEnd=" + SubSite_Service_ID_zEnd 
  + "&SP_Site_Service_ID_aEnd=" + Site_Service_ID_aEnd 
  + "&SP_Site_Service_ID_zEnd=" + Site_Service_ID_zEnd 
  + "&SP_trunk_policy_aside=" + SP_trunk_policy_aside 
  + "&SP_trunk_policy_zside=" + SP_trunk_policy_zside
  + "&SP_trunk_policy_aside=" + SP_trunk_policy_aside 
  + "&SP_trunk_policy_zside=" + SP_trunk_policy_zside
  + "&SP_QOS_PROFILE=" + SP_QOS_PROFILE
  + "&SP_Traffic_policy_io_aend=" + Traffic_policy_io_aend
  + "&SP_Traffic_policy_io_zend=" + Traffic_policy_io_zend 
  + "&SP_trunk_description_aEnd=" + trunk_description_aEnd 
  + "&SP_trunk_description_zEnd=" + trunk_description_zEnd 
  + "&SP_area_number_aEnd=" + SP_area_number_aEnd 
  + "&SP_area_number_zEnd=" + SP_area_number_zEnd 
  + "&SP_network_type_aside=" + SP_network_type_aside 
  + "&SP_network_type_zside=" + SP_network_type_zside 
/*  + "&SP_trunk_ldp_aside=" + SP_trunk_ldp_aside 
  + "&SP_trunk_ldp_zside=" + SP_trunk_ldp_zside */
  + "&SP_lnk_Protocol_aside=" + SP_lnk_Protocol_aside 
  + "&SP_lnk_Protocol_zside=" + SP_lnk_Protocol_zside
/*  + "&SP_Trunk_bandwidth_aEnd=" + Trunk_bandwidth_aEnd
  + "&SP_Trunk_bandwidth_zEnd=" + Trunk_bandwidth_zEnd
  + "&SP_Trunk_rsvp_bandwidth_aEnd=" + Trunk_rsvp_bandwidth_aEnd
  + "&SP_Trunk_rsvp_bandwidth_zEnd=" + Trunk_rsvp_bandwidth_zEnd */
  + "&SP_Interface_description_aEnd=" + Interface_description_aEnd 
  + "&SP_Interface_description_zEnd=" + Interface_description_zEnd
  + "&SP_pim_name_aside=" + SP_pim_name_aside 
  + "&SP_pim_name_zside=" + SP_pim_name_zside
  + "&PW_aEnd_region=" + PW_aEnd_region 
  + "&PW_zEnd_region=" + PW_zEnd_region 
  + "&PW_aEnd_location=" + PW_aEnd_location
  + "&PW_zEnd_location=" + PW_zEnd_location 
  + "&SP_AddressPool_aEnd=" + SP_AddressPool_aEnd 
  + "&SP_AddressPool_zEnd=" + SP_AddressPool_zEnd
  + "&SP_trunk_ipaddress_aEnd=" + SP_trunk_ipaddress_aEnd 
  + "&SP_trunk_ipaddress_zEnd=" + SP_trunk_ipaddress_zEnd
  + "&SP_trunk_negotiation_aside=" + SP_trunk_negotiation_aside 
  + "&SP_trunk_negotiation_zside=" + SP_trunk_negotiation_zside
/*  + "&SP_trunk_aside_mtu=" + SP_trunk_aside_mtu 
  + "&SP_trunk_zside_mtu=" + SP_trunk_zside_mtu*/
  + "&SP_IPv6_family_aEnd=" + SP_IPv6_family_aEnd
  + "&SP_IPv6_family_zEnd=" + SP_IPv6_family_zEnd
  + "&SP_IPv6_Pool_aEnd=" + SP_IPv6_Pool_aEnd
  + "&SP_IPv6_Pool_zEnd=" + SP_IPv6_Pool_zEnd
  + "&SP_IPv6_Address_aEnd=" + SP_IPv6_Address_aEnd
  + "&SP_IPv6_Address_zEnd=" + SP_IPv6_Address_zEnd
  + "&SP_trunk_aIPbinding=" + SP_trunk_aIPbinding
  + "&SP_trunk_zIPbinding=" + SP_trunk_zIPbinding
/*  + "&SP_trunk_aside_processid=" + SP_trunk_aside_processid
  + "&SP_trunk_zside_processid=" + SP_trunk_zside_processid
  + "&SP_ospf_aside=" + SP_ospf_aside
  + "&SP_ospf_zside=" + SP_ospf_zside
  + "&SP_trunk_aside_ospf_cost=" + SP_trunk_aside_ospf_cost
  + "&SP_trunk_zside_ospf_cost=" + SP_trunk_zside_ospf_cost
  + "&SP_OSPF_aPassword=" + SP_OSPF_aPassword
  + "&SP_OSPF_zPassword=" + SP_OSPF_zPassword
  + "&SP_LDP_aPassword=" + SP_LDP_aPassword
  + "&SP_LDP_zPassword=" + SP_LDP_zPassword*/
  + "&SP_PERouter_aEnd=" + perouter_aEnd 
  + "&SP_PERouter_zEnd=" + perouter_zEnd 
  + "&peinterface_aEnd=" + peinterface_aEnd 
  + "&peinterface_zEnd=" + peinterface_zEnd 
  + "&mv=" + mv 
  + "&currentPageNo=" + currentPageNo 
  + "&viewPageNo=" + viewPageNo 
  + "&resend=" + resendCreate
  + "&reselect=" + resend 
  + "&type=" + "Trunk" 
  + "&SubEndA_name=" + SubEndA_name
  + "&SubEndB_name=" + SubEndB_name 
  + "&SP_link_type=" + SP_link_type
  + "&SP_SubInterfaceName=' + ServiceForm.SP_SubInterfaceName.value + "
  + "'&SP_PW_aEnd_location=' + ServiceForm.SP_PW_aEnd_location.value + "
  + "'&SP_PW_zEnd_location=' + ServiceForm.SP_PW_zEnd_location.value + "
  + "'&SP_PW_aEnd_region=' + ServiceForm.SP_PW_aEnd_region.value + "
  + "'&SP_PW_zEnd_region=' + ServiceForm.SP_PW_zEnd_region.value + "
 // + "'&SP_SubAddressPool_aEnd=' + ServiceForm.SP_SubAddressPool_aEnd.value + "
 /*  + "'&SP_SubAddressPool_aEnd=' +ServiceForm.SP_SubAddressPool_aEnd.options[ServiceForm.SP_SubAddressPool_aEnd.selectedIndex].value +"
   + "'&SP_SubAddressPool_zEnd=' +ServiceForm.SP_SubAddressPool_zEnd.options[ServiceForm.SP_SubAddressPool_zEnd.selectedIndex].value +"
   + "'&SP_Sub_ipaddress_aEnd=' + ServiceForm.SP_Sub_ipaddress_aEnd.options[ServiceForm.SP_Sub_ipaddress_aEnd.selectedIndex].value +"
   + "'&SP_Sub_ipaddress_zEnd=' + ServiceForm.SP_Sub_ipaddress_zEnd.options[ServiceForm.SP_Sub_ipaddress_zEnd.selectedIndex].value +" */
 // + "'&SP_SubAddressPool_zEnd=' + ServiceForm.SP_SubAddressPool_zEnd.value + "
 // + "'&SP_Sub_ipaddress_aEnd=' + ServiceForm.SP_Sub_ipaddress_aEnd.value + "
  //+ "'&SP_Sub_ipaddress_zEnd=' + ServiceForm.SP_Sub_ipaddress_zEnd.value + " 
  + "'&SP_SubInt_description_aEnd=' + ServiceForm.SP_SubInt_description_aEnd.value + "
  + "'&SP_SubInt_description_zEnd=' + ServiceForm.SP_SubInt_description_zEnd.value + "
  + "'&SP_SubNegotiation_aend=' + ServiceForm.SP_SubNegotiation_aend.value + "
  + "'&SP_SubNegotiation_zend=' + ServiceForm.SP_SubNegotiation_zend.value + "
  + "'&SP_Subtrunk_mtu_aend=' + ServiceForm.SP_Subtrunk_mtu_aend.value + "
  + "'&SP_Subtrunk_mtu_zend=' + ServiceForm.SP_Subtrunk_mtu_zend.value + "
  + "'&SP_Sub_pim_name_aside=' + ServiceForm.SP_Sub_pim_name_aside.value + " 
  + "'&SP_Sub_pim_name_zside=' + ServiceForm.SP_Sub_pim_name_zside.value + "
  + "'&SP_Sub_network_type_aside=' + ServiceForm.SP_Sub_network_type_aside.value + "
  + "'&SP_Sub_network_type_zside=' + ServiceForm.SP_Sub_network_type_zside.value + "
  + "'&SP_Sub_ospf_aside=' + ServiceForm.SP_Sub_ospf_aside.value + "
  + "'&SP_Sub_ospf_zside=' + ServiceForm.SP_Sub_ospf_zside.value + "
  + "'&SP_Subtrunk_ospf_cost_aend=' + ServiceForm.SP_Subtrunk_ospf_cost_aend.value + "
  + "'&SP_Subtrunk_ospf_cost_zend=' + ServiceForm.SP_Subtrunk_ospf_cost_zend.value + "
  + "'&SP_Subldp_aend=' + ServiceForm.SP_Subldp_aend.value + "
  + "'&SP_Subldp_zend=' + ServiceForm.SP_Subldp_zend.value + "
  + "'&SP_SubArea_number_aEnd=' + ServiceForm.SP_SubArea_number_aEnd.value + "
  + "'&SP_SubArea_number_zEnd=' + ServiceForm.SP_SubArea_number_zEnd.value +"
  + "'&SP_Subtrunk_policy_aside=' + ServiceForm.SP_Subtrunk_policy_aside.value + "
  + "'&SP_Subtrunk_policy_zside=' + ServiceForm.SP_Subtrunk_policy_zside.value +"
  + "'&SP_Subtrunk_processid_aEnd=' + ServiceForm.SP_Subtrunk_processid_aEnd.value + "
  + "'&SP_Subtrunk_processid_zEnd=' + ServiceForm.SP_Subtrunk_processid_zEnd.value +"
  + "'&SP_SubOSPF_aPassword=' + ServiceForm.SP_SubOSPF_aPassword.value  +"
  + "'&SP_SubOSPF_zPassword=' + ServiceForm.SP_SubOSPF_zPassword.value  +"
  + "'&SP_SubLDP_aPassword=' + ServiceForm.SP_SubLDP_aPassword.value  +"
  + "'&SP_SubLDP_zPassword=' + ServiceForm.SP_SubLDP_zPassword.value  +"
  + "'&SP_Sub_IPv6_family_aEnd=' + ServiceForm.SP_Sub_IPv6_family_aEnd.value  + "
  + "'&SP_Sub_IPv6_family_zEnd=' + ServiceForm.SP_Sub_IPv6_family_zEnd.value + "
  + "'&SP_Sub_IPv6_Pool_aEnd=' + ServiceForm.SP_Sub_IPv6_Pool_aEnd.value + "
  + "'&SP_Sub_IPv6_Pool_zEnd=' + ServiceForm.SP_Sub_IPv6_Pool_zEnd.value + "
  + "'&SP_Sub_IPv6_Address_aEnd=' + ServiceForm.SP_Sub_IPv6_Address_aEnd.value + "
  + "'&SP_Sub_IPv6_Address_zEnd=' + ServiceForm.SP_Sub_IPv6_Address_zEnd.value + "
  + "'&SP_Sub_IPv6_encap_aEnd=' + ServiceForm.SP_Sub_IPv6_encap_aEnd.value + "
  + "'&SP_Sub_IPv6_encap_zEnd=' + ServiceForm.SP_Sub_IPv6_encap_zEnd.value + "
  + "'&SP_Sub_IPv6_binding_aEnd=' + ServiceForm.SP_Sub_IPv6_binding_aEnd.value + "
  + "'&SP_Sub_IPv6_binding_zEnd=' + ServiceForm.SP_Sub_IPv6_binding_zEnd.value "
  ;

  //System.out.println("Link "+link_part);
  System.out.println("Link Length "+link_part.length());
  int rowCounter;

  try {
    rowCounter = request.getParameter("rowCounter") == null ? 0
        : Integer.parseInt(request.getParameter("rowCounter"));
  } catch (Exception e) {
    rowCounter = 0;
  }
%>

<%-- Trunk name added --%>
<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.sub.interface.name" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" align=left>
<%
		if (modify) {
%>
			<input type="text" id="SP_SubInterfaceName" name="SP_SubInterfaceName" maxlength="32" size="32" value="<%= SP_SubInterfaceName %>" disabled>
<%
		} else {
%>
			<input type="text" id="SP_SubInterfaceName" name="SP_SubInterfaceName" maxlength="32" size="32" value="<%= SP_SubInterfaceName %>">
<%
		}
%>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.trunk.link.type" /></b></td>
	<td class="list<%= (rowCounter % 2) %>"><%= SP_link_type %></td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

</tr>

<% rowCounter++; %>

<tr>
	<td class="title" align="left" colspan="2" width="40%"><bean:message key="label.siteinfo" /></td>
	<td class="title" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="title" align="left" width="50%">
					<bean:message key="label.aend" />
				</td>
				<td class="title" align="left" width="50%">
					<bean:message key="label.zend" />
				</td>
			</tr>
		</table>
	</td>
	<td class="title">&nbsp;</td>
</tr>
<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message key="label.trunk.serviceid" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<%= SubSite_Service_ID_aEnd %>
				</td>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<%= SubSite_Service_ID_zEnd %>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message
				key="label.trunk.sidename" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<%=SubEndA_name %>
				</td>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<%=SubEndB_name %>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<input type="hidden" id="SP_PW_aEnd_location" name="SP_PW_aEnd_location" value="<%=PW_aEnd_location%>"/>
<input type="hidden" id="SP_PW_zEnd_location" name="SP_PW_zEnd_location" value="<%=PW_zEnd_location%>"/>
<input type="hidden" id="SP_PW_aEnd_region" name="SP_PW_aEnd_region" value="<%=PW_aEnd_region%>"/>
<input type="hidden" id="SP_PW_zEnd_region" name="SP_PW_zEnd_region" value="<%=PW_zEnd_region%>"/>
<input type="hidden" id="SP_PERouter_aEnd" name="SP_PERouter_aEnd" value="<%=perouter_aEnd%>"/>
<input type="hidden" id="SP_PERouter_zEnd" name="SP_PERouter_zEnd" value="<%=perouter_zEnd%>"/>
<input type="hidden" id="SP_AddressPool_aEnd" name="SP_AddressPool_aEnd" value="<%=SP_AddressPool_aEnd%>"/>
<input type="hidden" id="SP_AddressPool_zEnd" name="SP_AddressPool_zEnd" value="<%=SP_AddressPool_aEnd%>"/>
<input type="hidden" id="SP_trunk_ipaddress_aEnd" name="SP_trunk_ipaddress_aEnd" value="<%=SP_trunk_ipaddress_aEnd%>"/>
<input type="hidden" id="SP_trunk_ipaddress_zEnd" name="SP_trunk_ipaddress_zEnd" value="<%=SP_trunk_ipaddress_zEnd%>"/>
<input type="hidden" id="SP_trunk_negotiation_aside" name="SP_trunk_negotiation_aside" value="<%=SP_trunk_negotiation_aside%>"/>
<input type="hidden" id="SP_trunk_negotiation_zside" name="SP_trunk_negotiation_zside" value="<%=SP_trunk_negotiation_zside%>"/>
<input type="hidden" id="SP_trunk_aside_mtu" name="SP_trunk_aside_mtu" value="<%=SP_trunk_aside_mtu%>"/>
<input type="hidden" id="SP_trunk_zside_mtu" name="SP_trunk_zside_mtu" value="<%=SP_trunk_zside_mtu%>"/>
<input type="hidden" id="SP_IPv6_family_aEnd" name="SP_IPv6_family_aEnd" value="<%=SP_IPv6_family_aEnd%>"/>
<input type="hidden" id="SP_IPv6_family_zEnd" name="SP_IPv6_family_aEnd" value="<%=SP_IPv6_family_aEnd%>"/>
<input type="hidden" id="SP_IPv6_Pool_aEnd" name="SP_IPv6_Pool_aEnd" value="<%=SP_IPv6_Pool_aEnd%>"/>
<input type="hidden" id="SP_IPv6_Pool_zEnd" name="SP_IPv6_Pool_zEnd" value="<%=SP_IPv6_Pool_zEnd%>"/>
<input type="hidden" id="SP_IPv6_Address_aEnd" name="SP_IPv6_Address_aEnd" value="<%=SP_IPv6_Address_aEnd%>"/>
<input type="hidden" id="SP_IPv6_Address_zEnd" name="SP_IPv6_Address_zEnd" value="<%=SP_IPv6_Address_zEnd%>"/>
<input type="hidden" id="SP_trunk_aIPbinding" name="SP_trunk_aIPbinding" value="<%=SP_trunk_aIPbinding%>"/>
<input type="hidden" id="SP_trunk_zIPbinding" name="SP_trunk_zIPbinding" value="<%=SP_trunk_zIPbinding%>"/>
<input type="hidden" id="SP_trunk_aside_processid" name="SP_trunk_aside_processid" value="<%=SP_trunk_aside_processid%>"/>
<input type="hidden" id="SP_trunk_zside_processid" name="SP_trunk_zside_processid" value="<%=SP_trunk_zside_processid%>"/>
<input type="hidden" id="SP_ospf_aside" name="SP_ospf_aside" value="<%=SP_ospf_aside%>"/>
<input type="hidden" id="SP_ospf_zside" name="SP_ospf_zside" value="<%=SP_ospf_zside%>"/>
<input type="hidden" id="SP_trunk_aside_ospf_cost" name="SP_trunk_aside_ospf_cost" value="<%=SP_trunk_aside_ospf_cost%>"/>
<input type="hidden" id="SP_trunk_zside_ospf_cost" name="SP_trunk_zside_ospf_cost" value="<%=SP_trunk_zside_ospf_cost%>"/>
<input type="hidden" id="SP_OSPF_aPassword" name="SP_OSPF_aPassword" value="<%=SP_OSPF_aPassword%>"/>
<input type="hidden" id="SP_OSPF_zPassword" name="SP_OSPF_zPassword" value="<%=SP_OSPF_zPassword%>"/>
<input type="hidden" id="SP_LDP_aPassword" name="SP_LDP_aPassword" value="<%=SP_LDP_aPassword%>"/>
<input type="hidden" id="SP_LDP_zPassword" name="SP_LDP_zPassword" value="<%=SP_LDP_zPassword%>"/>

<%--The condition for Eth trunk and IP trunk --%>

<%-- <%
  if ("true".equals(SP_Sub_IPv6_family_aEnd)) {
%>
	<input type="hidden" id="SP_SubAddressPool_aEnd" name="SP_SubAddressPool_aEnd">
	<input type="hidden" id="SP_Sub_ipaddress_aEnd" name="SP_Sub_ipaddress_aEnd">
<%
  }

  if ("true".equals(SP_Sub_IPv6_family_zEnd)) {
%>
	<input type="hidden" id="SP_SubAddressPool_zEnd" name="SP_SubAddressPool_zEnd">
	<input type="hidden" id="SP_Sub_ipaddress_zEnd" name="SP_Sub_ipaddress_zEnd">
<%
  }
%> --%>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message key="label.trunk.ipaddressPool" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
<%
					//if (!"true".equals(SP_Sub_IPv6_family_aEnd)) {
						
						link_part += "+'&SP_SubAddressPool_aEnd=' + ServiceForm.SP_SubAddressPool_aEnd.options[ServiceForm.SP_SubAddressPool_aEnd.selectedIndex].value";
%>
						<select id="SP_SubAddressPool_aEnd" name="SP_SubAddressPool_aEnd" onChange="location.href = <%= link_part %>+'&reqtype=<%=reqtype%>';">
<%
							if (Subpools != null) {
          						if (pool_aEnd == null) {
        	  						pool_aEnd = Subpools[0].getPrimaryKey();
          						}

								for (int i=0; Subpools != null && i < Subpools.length; i++) { 
        	  						if (Subpools[i].getAddressfamily().equals(addressFamily)) {
%>
										<option <%= Subpools[i].getName().equals (pool_aEnd) ? " selected": "" %> value="<%=Subpools[i].getName() %>"><%= Subpools[i].getName() %></option>
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
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
<%
				//	if (!"true".equals(SP_Sub_IPv6_family_zEnd)) {
					link_part += "+'&SP_SubAddressPool_zEnd=' + ServiceForm.SP_SubAddressPool_zEnd.options[ServiceForm.SP_SubAddressPool_zEnd.selectedIndex].value";
%>
						<select id="SP_SubAddressPool_zEnd" style="display:none" name="SP_SubAddressPool_zEnd" onChange="location.href = <%= link_part %>+'&reqtype=<%=reqtype%>';">
<%
							if (Subpools != null) {
          						if (pool_zEnd == null) {
        	  						pool_zEnd = Subpools[0].getPrimaryKey();
          						}

								for (int i=0; Subpools != null && i < Subpools.length; i++) { 
        	  						if (Subpools[i].getAddressfamily().equals(addressFamily)) {
%>
										<option <%= Subpools[i].getName().equals (pool_zEnd) ? " selected": "" %> value="<%=Subpools[i].getName() %>"><%= Subpools[i].getName() %></option>
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
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%">
		<b><bean:message key="label.trunk.ipaddress" /></b>
	</td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="25%">
<%
					//if (!"true".equals(SP_Sub_IPv6_family_aEnd)) {
						link_part += "+'&SP_Sub_ipaddress_aEnd=' + ServiceForm.SP_Sub_ipaddress_aEnd.options[ServiceForm.SP_Sub_ipaddress_aEnd.selectedIndex].value";
%>
						<select id="SP_Sub_ipaddress_aEnd" name="SP_Sub_ipaddress_aEnd" onChange="location.href = <%= link_part %>+'&reqtype=<%=reqtype%>';">
							<option value=""></option>
<%
     						if (iplist!=null && !iplist.isEmpty()) {
		      					for (int i = 0; i < iplist.size(); i++) {  
		    						if (Subipaddrlist != null && Subipaddrlist.equals(iplist.get(i))) {
%>
										<option value="<%=iplist.get(i)%>" selected><%=iplist.get(i).split("@")[1]%></option>
<%
									} else {
%>
										<option value="<%=iplist.get(i) %>"><%=iplist.get(i).split("@")[1]%></option>
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
     				if (SP_Sub_ip_submask_aEnd != null) {
%>
						<td class="list<%= (rowCounter % 2) %>" align=left width="25%">
							<input type="hidden" id="SP_Sub_ip_submask_aEnd" name="SP_Sub_ip_submask_aEnd" value="<%=SP_Sub_ip_submask_aEnd%>" readonly>
						</td>
<%
     				} else {
%>
						<td class="list<%= (rowCounter % 2) %>" align=left width="25%">
						</td>
<%
					}
%>
				<td class="list<%= (rowCounter % 2) %>" align=left width="25%">
<%
					//if (!"true".equals(SP_Sub_IPv6_family_zEnd)) {
						link_part += "+'&SP_Sub_ipaddress_zEnd=' + ServiceForm.SP_Sub_ipaddress_zEnd.options[ServiceForm.SP_Sub_ipaddress_zEnd.selectedIndex].value";
%>
						<select id="SP_Sub_ipaddress_zEnd" style="display:none"  name="SP_Sub_ipaddress_zEnd" onChange="location.href = <%= link_part %>+'&reqtype=<%=reqtype%>';">
							<option value=""></option>
<%
     						if (iplist_zEnd!=null && !iplist_zEnd.isEmpty()) {
	      						for (int i = 0; i < iplist_zEnd.size(); i++) {    	  
	    							if (Subipaddrlist_zEnd != null && Subipaddrlist_zEnd.equals(iplist_zEnd.get(i))) {	    			
%>
										<option value="<%=iplist_zEnd.get(i)%>" selected><%=iplist_zEnd.get(i).split("@")[1]%></option>
<%
									} else {
%>
										<option value="<%=iplist_zEnd.get(i) %>"><%=iplist_zEnd.get(i).split("@")[1]%></option>
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
     				if (SP_Sub_ip_submask_zEnd != null) {
%>
						<td class="list<%= (rowCounter % 2) %>" align=left width="25%">
							<input type="hidden" id="SP_Sub_ip_submask_zEnd" name="SP_Sub_ip_submask_zEnd" value="<%=SP_Sub_ip_submask_zEnd%>" readonly>
						</td>
<%
     				} else {
%>
						<td class="list<%= (rowCounter % 2) %>" align=left width="25%">
						</td>
<%
     				}
%>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>
<%
  rowCounter++;    
     	if (SP_Sub_ip_networkIP_aEnd != null) {
%>
		<input type="hidden" id="SP_Sub_ip_networkIP_aEnd" name="SP_Sub_ip_networkIP_aEnd" value="<%=SP_Sub_ip_networkIP_aEnd%>" readonly>
		<input type="hidden" id="SP_Sub_wildcard_aEnd" name="SP_Sub_wildcard_aEnd" value="<%=SP_Sub_wildcard_aEnd%>" readonly>
<%
     	}
     	
     	if (SP_Sub_ip_networkIP_zEnd != null) {
%>
		<input type="hidden" id="SP_Sub_ip_networkIP_zEnd" name="SP_Sub_ip_networkIP_zEnd" value="<%=SP_Sub_ip_networkIP_zEnd%>" readonly>
		<input type="hidden" id="SP_Sub_wildcard_zEnd" name="SP_Sub_wildcard_zEnd" value="<%=SP_Sub_wildcard_zEnd%>" readonly>
<%
     	}
%>
<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message
				key="label.trunk.description" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="text" id="SP_SubInt_description_aEnd"
					name="SP_SubInt_description_aEnd" maxlength="32" size="32"
					value="<%=SP_SubInt_description_aEnd%>">
				</td>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="text" id="SP_SubInt_description_zEnd"
					name="SP_SubInt_description_zEnd" maxlength="32" size="32"
					value="<%=SP_SubInt_description_zEnd%>">
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message
				key="label.trunk.traffic.policy" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<select name="SP_Subtrunk_policy_aside"
					id="SP_Subtrunk_policy_aside">
						<option
							<%= SP_Subtrunk_policy_aside != null && SP_Subtrunk_policy_aside.equals("inbound/outbound") ? " selected": "" %>
							value="inbound/outbound">inbound/outbound</option>
						<option
							<%= SP_Subtrunk_policy_aside != null && SP_Subtrunk_policy_aside.equals("inbound") ? " selected": "" %>
							value="inbound">inbound</option>
						<option
							<%= SP_Subtrunk_policy_aside != null && SP_Subtrunk_policy_aside.equals("outbound") ? " selected": "" %>
							value="outbound">outbound</option>
				</select>
				</td>

				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<select name="SP_Subtrunk_policy_zside"
					id="SP_Subtrunk_policy_zside">
						<option
							<%= SP_Subtrunk_policy_zside != null && SP_Subtrunk_policy_zside.equals("inbound/outbound") ? " selected": "" %>
							value="inbound/outbound">inbound/outbound</option>
						<option
							<%= SP_Subtrunk_policy_zside != null && SP_Subtrunk_policy_zside.equals("inbound") ? " selected": "" %>
							value="inbound">inbound</option>
						<option
							<%= SP_Subtrunk_policy_zside != null && SP_Subtrunk_policy_zside.equals("outbound") ? " selected": "" %>
							value="outbound">outbound</option>
				</select>
				</td>

			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message
				key="label.trunk.negotiation" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="checkbox" id="SP_SubNegotiation_aend"
					name="SP_SubNegotiation_aend"
					<%=SP_SubNegotiation_aend.equals("true") ? " checked": "" %>
					value="<%= SP_SubNegotiation_aend%>"
					onchange="setcheckbox('SP_SubNegotiation_aend')"> <bean:message
						key="label.trunk.negotiation.auto" /> <BR>
				</td>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="checkbox" id="SP_SubNegotiation_zend"
					name="SP_SubNegotiation_zend"
					<%=SP_SubNegotiation_zend.equals("true") ? " checked": "" %>
					value="<%=SP_SubNegotiation_zend %>"
					onchange="setcheckbox('SP_SubNegotiation_zend')"> <bean:message
						key="label.trunk.negotiation.auto" /> <BR>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>



<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%">
		<b><bean:message key="label.trunk.mtu" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="text" id="SP_Subtrunk_mtu_aend"
					name="SP_Subtrunk_mtu_aend" maxlength="32" size="32"
					value=<%=SP_Subtrunk_mtu_aend%>>
				</td>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="text" id="SP_Subtrunk_mtu_zend"
					name="SP_Subtrunk_mtu_zend" maxlength="32" size="32"
					value=<%=SP_Subtrunk_mtu_zend%>>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%">
		<b><bean:message key="label.trunk.pim" /></b>
	</td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="checkbox" id="SP_Sub_pim_name_aside" name="SP_Sub_pim_name_aside"
					<%=SP_Sub_pim_name_aside.equals("true") ? " checked": "" %>
					value="<%=SP_Sub_pim_name_aside%>" onchange="setcheckbox('SP_Sub_pim_name_aside')">
					SM <BR>
				</td>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="checkbox" id="SP_Sub_pim_name_zside" name="SP_Sub_pim_name_zside"
					<%=SP_Sub_pim_name_zside.equals("true") ? " checked": "" %>
					value="<%=SP_Sub_pim_name_zside %>" onchange="setcheckbox('SP_Sub_pim_name_zside')">
					SM <BR>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%">
		<b><bean:message key="label.trunk.p2p" /></b>
	</td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="checkbox" id="SP_Sub_network_type_aside"
					name="SP_Sub_network_type_aside"
					<%=SP_Sub_network_type_aside.equals("true") ? " checked": "" %>
					value="<%=SP_Sub_network_type_aside %>"
					onchange="setcheckbox('SP_Sub_network_type_aside')"> P2P <BR>
				</td>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="checkbox" id="SP_Sub_network_type_zside"
					name="SP_Sub_network_type_zside"
					<%=SP_Sub_network_type_zside.equals("true") ? " checked": "" %>
					value="<%= SP_Sub_network_type_zside%>"
					onchange="setcheckbox('SP_Sub_network_type_zside')"> P2P <BR>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%">
		<b><bean:message key="label.trunk.ospf.cost" /></b>
	</td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="checkbox" id="SP_Sub_ospf_aside"
					name="SP_Sub_ospf_aside"
					<%=SP_Sub_ospf_aside.equals("true") ? " checked": "" %>
					value="<%=SP_Sub_ospf_aside %>"
					onchange="setcheckboxSub('SP_Sub_ospf_aside');location.href = <%=link_part%>+'&reqtype=<%=reqtype%>';"> OSPF <BR>
				</td>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="checkbox" id="SP_Sub_ospf_zside"
					name="SP_Sub_ospf_zside"
					<%=SP_Sub_ospf_zside.equals("true") ? " checked": "" %>
					value="<%= SP_Sub_ospf_zside%>"
					onchange="setcheckboxSub('SP_Sub_ospf_zside');location.href = <%=link_part%>+'&reqtype=<%=reqtype%>';"> OSPF <BR>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%">
		<b><bean:message key="label.trunk.ospf.cost" /></b>
	</td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
<%
				if ("true".equals(SP_Sub_ospf_aside)) {
%>
					<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
						<input type="text" id="SP_Subtrunk_ospf_cost_aend"
						name="SP_Subtrunk_ospf_cost_aend" size="32"
						value=<%=SP_Subtrunk_ospf_cost_aend%>>
					</td>
<%
				} else {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="text" id="SP_Subtrunk_ospf_cost_aend"
						name="SP_Subtrunk_ospf_cost_aend" size="32" disabled>
					</td>
<%
				}
%>
<%
				if ("true".equals(SP_Sub_ospf_zside)) {
%>
					<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
						<input type="text" id="SP_Subtrunk_ospf_cost_zend"
						name="SP_Subtrunk_ospf_cost_zend" size="32"
						value=<%=SP_Subtrunk_ospf_cost_zend%>>
					</td>
<%
				} else {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="text" id="SP_Subtrunk_ospf_cost_zend"
						name="SP_Subtrunk_ospf_cost_zend" size="32" disabled>
					</td>
<%
				}
%>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%">
		<b><bean:message key="label.trunk.ospf.cost.password" /></b>
	</td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
<%
				if ("true".equals(SP_Sub_ospf_aside)) {
%>
					<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
						<input type="password" id="SP_SubOSPF_aPassword"
						name="SP_SubOSPF_aPassword" maxlength="32" size="32"
						value=<%=SP_SubOSPF_aPassword%>>
					</td>
<%
				} else {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="password" id="SP_SubOSPF_aPassword"
						name="SP_SubOSPF_aPassword" maxlength="32" size="32" disabled>
					</td>
<%
				}
%>
<%
				if ("true".equals(SP_Sub_ospf_zside)) {
%>
					<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
						<input type="password" id="SP_SubOSPF_zPassword"
						name="SP_SubOSPF_zPassword" maxlength="32" size="32"
						value=<%=SP_SubOSPF_zPassword%>>
					</td>
<%
				} else {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="password" id="SP_SubOSPF_zPassword"
						name="SP_SubOSPF_zPassword" maxlength="32" size="32" disabled>
					</td>
<%
				}
%>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message
				key="label.trunk.ldp" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="checkbox" id="SP_Subldp_aend" name="SP_Subldp_aend"
					<%=SP_Subldp_aend.equals("true") ? " checked": "" %>
					value="<%=SP_Subldp_aend %>"
					onchange="setcheckbox('SP_Subldp_aend');location.href = <%=link_part%>+'&reqtype=<%=reqtype%>';"> LDP <BR>
				</td>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="checkbox" id="SP_Subldp_zend" name="SP_Subldp_zend"
					<%=SP_Subldp_zend.equals("true") ? " checked": "" %>
					value="<%=SP_Subldp_aend %>"
					onchange="setcheckbox('SP_Subldp_zend');location.href = <%=link_part%>+'&reqtype=<%=reqtype%>';"> LDP <BR>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%">
		<b><bean:message key="label.trunk.ldp.password" /></b>
	</td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
<%
				if ("true".equals(SP_Subldp_aend)) {
%>
					<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
						<input type="password" id="SP_SubLDP_aPassword"
						name="SP_SubLDP_aPassword" maxlength="32" size="32"
						value=<%=SP_SubLDP_aPassword%>>
					</td>
<%
				} else {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="password" id="SP_SubLDP_aPassword"
						name="SP_SubLDP_aPassword" maxlength="32" size="32" disabled>
					</td>
<%
				}
%>
<%
				if ("true".equals(SP_Subldp_zend)) {
%>
					<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
						<input type="password" id="SP_SubLDP_zPassword"
						name="SP_SubLDP_zPassword" maxlength="32" size="32"
						value=<%=SP_SubLDP_zPassword%>>
					</td>
<%
				} else {
%>
					<td class="list<%=(rowCounter % 2)%>" align=left width="50%">
						<input type="password" id="SP_SubLDP_zPassword"
						name="SP_SubLDP_zPassword" maxlength="32" size="32" disabled>
					</td>
<%
				}
%>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message key="label.trunk.family.IPv6" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="15%">
					<input type="checkbox" id="SP_Sub_IPv6_family_aEnd"
					name="SP_Sub_IPv6_family_aEnd" value="<%=SP_Sub_IPv6_family_aEnd%>"
					<%= SP_Sub_IPv6_family_aEnd.equals("true") ? " CHECKED":" " %>
					onChange="setcheckboxSub('SP_Sub_IPv6_family_aEnd');location.href = <%=link_part%>+'&reqtype=<%=reqtype%>';">
					IPv6 <BR>
				</td>
				<td class="list<%= (rowCounter % 2) %>" align=left width="15%">
					<input type="checkbox" id="SP_Sub_IPv6_family_zEnd"
					name="SP_Sub_IPv6_family_zEnd" value="<%=SP_Sub_IPv6_family_zEnd%>"
					<%= SP_Sub_IPv6_family_zEnd.equals("true") ? " CHECKED":" " %>
					onChange="setcheckboxSub('SP_Sub_IPv6_family_zEnd');location.href = <%=link_part%>+'&reqtype=<%=reqtype%>';">
					IPv6 <BR>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>
<%
  if (!"true".equals(SP_Sub_IPv6_family_aEnd)) {
%>
	<input type="hidden" id="SP_Sub_IPv6_Pool_aEnd" name="SP_Sub_IPv6_Pool_aEnd">
	<input type="hidden" id="SP_Sub_IPv6_Address_aEnd" name="SP_Sub_IPv6_Address_aEnd">
	<input type="hidden" id="SP_Sub_IPv6_encap_aEnd" name="SP_Sub_IPv6_encap_aEnd" value="<%=SP_Sub_IPv6_encap_aEnd %>">
	<input type="hidden" id="SP_Sub_IPv6_binding_aEnd" name="SP_Sub_IPv6_binding_aEnd" value="<%=SP_Sub_IPv6_binding_aEnd %>">
<%
  }

  if (!"true".equals(SP_Sub_IPv6_family_zEnd)) {
%>
	<input type="hidden" id="SP_Sub_IPv6_Pool_zEnd" name="SP_Sub_IPv6_Pool_zEnd">
	<input type="hidden" id="SP_Sub_IPv6_Address_zEnd" name="SP_Sub_IPv6_Address_zEnd">
	<input type="hidden" id="SP_Sub_IPv6_encap_zEnd" name="SP_Sub_IPv6_encap_zEnd" value="<%=SP_Sub_IPv6_encap_zEnd %>">
	<input type="hidden" id="SP_Sub_IPv6_binding_zEnd" name="SP_Sub_IPv6_binding_zEnd" value="<%=SP_Sub_IPv6_binding_zEnd %>">
<%
  }

  rowCounter++;
  
  if (SP_Sub_IPv6_family_aEnd.equals("true") || SP_Sub_IPv6_family_zEnd.equals("true")) {	 
			   
 %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message key="label.trunk.ipaddressPool" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="15%">
<%
					if (SP_Sub_IPv6_family_aEnd.equals("true")) {
						
						//link_part += "+'&SP_Sub_IPv6_Pool_aEnd=' + ServiceForm.SP_Sub_IPv6_Pool_aEnd.options[ServiceForm.SP_Sub_IPv6_Pool_aEnd.selectedIndex].value";
%>
						<select id="SP_Sub_IPv6_Pool_aEnd" name="SP_Sub_IPv6_Pool_aEnd" onChange="location.href = <%= link_part%>+'&reqtype=<%=reqtype%>';" style="width: 100%" >
<%
						if (Subpools != null) {          
          					for (int i=0; Subpools != null && i < Subpools.length; i++) { 
        	  					if (Subpools[i].getAddressfamily().equals("IPv6")) {
									if (SubIpv6_pool_aEnd == null) {
										SubIpv6_pool_aEnd = Subpools[i].getPrimaryKey();
									}				
%>
									<option <%= Subpools[i].getName().equals (SubIpv6_pool_aEnd) ? " selected": "" %> value="<%=Subpools[i].getName() %>"><%= Subpools[i].getName() %></option>
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
				<td class="list<%= (rowCounter % 2) %>" align=left width="15%">
<%
					//if (SP_Sub_IPv6_family_zEnd.equals("true")) {
					if (true) {
%>
						<select id="SP_Sub_IPv6_Pool_zEnd" style="display:none" name="SP_Sub_IPv6_Pool_zEnd" onChange="location.href = <%= link_part%>+'&reqtype=<%=reqtype%>';" style="width: 100%" >
<%
						if (Subpools != null) {
          					for (int i=0; Subpools != null && i < Subpools.length; i++) { 
        	  					if (Subpools[i].getAddressfamily().equals("IPv6")) {
				  					if (SubIpv6_pool_zEnd == null) {
										SubIpv6_pool_zEnd = Subpools[i].getPrimaryKey();
									}
%>
									<option <%= Subpools[i].getName().equals (SubIpv6_pool_zEnd) ? " selected": "" %> value="<%=Subpools[i].getName() %>"><%= Subpools[i].getName() %></option>
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
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>
<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message key="label.trunk.ipv6.ip" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="15%">
<%
					if (SP_Sub_IPv6_family_aEnd.equals("true")) {
%>
						<select id="SP_Sub_IPv6_Address_aEnd" name="SP_Sub_IPv6_Address_aEnd" onChange="location.href = <%= link_part%>+'&reqtype=<%=reqtype%>';" style="width: 100%" >
						<option value=""></option>
<%
						if (SubIpv6_iplist_aEnd!=null && !SubIpv6_iplist_aEnd.isEmpty()) {
	      					for (int i = 0; i < SubIpv6_iplist_aEnd.size(); i++) {
	    						if (SubIpv6_ipaddrlist_aEnd != null && SubIpv6_ipaddrlist_aEnd.equals(SubIpv6_iplist_aEnd.get(i))) {
%>
									<option value="<%=SubIpv6_iplist_aEnd.get(i)%>" selected><%=SubIpv6_iplist_aEnd.get(i).split("@")[1]%></option>
<%
								} else {
%>
									<option value="<%=SubIpv6_iplist_aEnd.get(i) %>"><%=SubIpv6_iplist_aEnd.get(i).split("@")[1]%></option>
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
				<td class="list<%= (rowCounter % 2) %>" align=left width="15%">
<%
					//if (SP_Sub_IPv6_family_zEnd.equals("true")) {
						if (true) {
%>					
						<select id="SP_Sub_IPv6_Address_zEnd" style="display:none" name="SP_Sub_IPv6_Address_zEnd" onChange="location.href = <%= link_part%>+'&reqtype=<%=reqtype%>';" style="width: 100%" >
						<option value=""></option>
<%   
     	 				if (SubIpv6_iplist_zEnd!=null && !SubIpv6_iplist_zEnd.isEmpty()) {
	      					for (int i = 0; i < SubIpv6_iplist_zEnd.size(); i++) {
	    						if (SubIpv6_ipaddrlist_zEnd != null && SubIpv6_ipaddrlist_zEnd.equals(SubIpv6_iplist_zEnd.get(i))) {
%>
									<option value="<%=SubIpv6_iplist_zEnd.get(i)%>" selected><%=SubIpv6_iplist_zEnd.get(i).split("@")[1]%></option>
<%
								} else {
%>
									<option value="<%=SubIpv6_iplist_zEnd.get(i) %>"><%=SubIpv6_iplist_zEnd.get(i).split("@")[1]%></option>
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
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message key="label.sub.encapsulation" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
<%
					if (SP_Sub_IPv6_family_aEnd.equals("true")) {
%>
						<input type="text" id="SP_Sub_IPv6_encap_aEnd" name="SP_Sub_IPv6_encap_aEnd" value="<%=SP_Sub_IPv6_encap_aEnd %>" maxlength="32" size="32">
<%
					} else {
%>
						<input type="text" maxlength="32" size="32" disabled>
<%					  
					}
%>
				</td>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
<%
					if (SP_Sub_IPv6_family_zEnd.equals("true")) {
%>
						<input type="text" id="SP_Sub_IPv6_encap_zEnd" name="SP_Sub_IPv6_encap_zEnd" value="<%=SP_Sub_IPv6_encap_zEnd %>" maxlength="32" size="32">
<%
					} else {
%>
						<input type="text" maxlength="32" size="32" disabled>
<%					  
					}
%>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message key="label.trunk.ip.binding" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="15%">
<%
					if (SP_Sub_IPv6_family_aEnd.equals("true")) {
%>
						<!--input type="checkbox" id="SP_Sub_IPv6_binding_aEnd" name="SP_Sub_IPv6_binding_aEnd" <%=SP_Sub_IPv6_binding_aEnd.equals("true") ? " CHECKED" : " "%> 
							value="<%= SP_Sub_IPv6_binding_aEnd %>"
							onChange="setcheckboxSub('SP_Sub_IPv6_binding_aEnd');location.href = <%=link_part%>+'&reqtype=<%=reqtype%>';"-->
							<input type="text" id="SP_Sub_IPv6_binding_aEnd"
								name="SP_Sub_IPv6_binding_aEnd" maxlength="32" size="32"
								value=<%=SP_Sub_IPv6_binding_aEnd%>>
<%
					} else {
%>
						<input type="checkbox" disabled>
<%					  
					}
%>
				</td>
				<td class="list<%= (rowCounter % 2) %>" align=left width="15%">
<%
					if (SP_Sub_IPv6_family_zEnd.equals("true")) { 
%>
						<!--input type="checkbox" id="SP_Sub_IPv6_binding_zEnd" name="SP_Sub_IPv6_binding_zEnd" <%=SP_Sub_IPv6_binding_zEnd.equals("true") ? " CHECKED" : " "%> 
						value="<%= SP_Sub_IPv6_binding_zEnd %>"
						onChange="setcheckboxSub('SP_Sub_IPv6_binding_zEnd');location.href = <%=link_part%>+'&reqtype=<%=reqtype%>';"-->
						<input type="text" id="SP_Sub_IPv6_binding_zEnd"
								name="SP_Sub_IPv6_binding_zEnd" maxlength="32" size="32"
								value=<%=SP_Sub_IPv6_binding_zEnd%>>
<%
					} else {
%>
						<input type="checkbox" disabled>
<%					  
					}
%>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>
<% rowCounter++; %>
<%
		   }
%>
<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message
				key="label.trunk.processid" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%"
			height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="text" id="SP_Subtrunk_processid_aEnd"
					name="SP_Subtrunk_processid_aEnd" maxlength="32" size="10"
					value=<%=SP_Subtrunk_processid_aEnd%>
					onChange="checkNumValue('SP_Subtrunk_processid_aEnd','100')">
				</td>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="text" id="SP_Subtrunk_processid_zEnd"
					name="SP_Subtrunk_processid_zEnd" maxlength="32" size="10"
					value=<%=SP_Subtrunk_processid_zEnd%>
					onChange="checkNumValue('SP_Subtrunk_processid_zEnd','100')">
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message key="label.trunk.areanumber" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" style="padding: 0px">
		<table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
			<tr>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="text" id="SP_SubArea_number_aEnd"
					name="SP_SubArea_number_aEnd" maxlength="32" size="10"
					<%= area_number_aend == null ? "" : "value=\"" + area_number_aend + "\"" %>>
				</td>
				<td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="text" id="SP_SubArea_number_zEnd"
					name="SP_SubArea_number_zEnd" maxlength="32" size="10"
					<%= area_number_zend == null ? "" : "value=\"" + area_number_zend + "\"" %>>
				</td>
			</tr>
		</table>
	</td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="40">
	<td class="list<%= (rowCounter % 2) %>" colspan="2">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>">
		<div style="padding-left: 2px; float: left;">
<%
			if (modify) {
%>
				<input type="button" name="mod-interface" id="mod-interface" value="Modify" onClick="submitSubinterface(<%=link_part%>+'&reqtype=modifysubinterface');" />
<%
			} else {
%>
				<input type="button" name="add-interface" id="add-interface" value="Create" onClick="submitSubinterface(<%=link_part%>+'&reqtype=creatingSub');" />
<%
			}
%>
		</div>
		<div style="padding-left: 20px; float: left;">
			<input type="button" name="cancel-interface" id="cancel-interface" value="Cancel" onClick="location.href = <%=link_part%>+'&reqtype=cancelingSub';" />
		</div>
	</td>
	<td class="list<%= (rowCounter % 2) %>" colspan="2"></td>
</tr>
<% rowCounter++; %>
<input type="hidden" id="SP_Region">
<input type="hidden" id="manualSet">
<input type="hidden" name="resend" value=<%= resendCreate %>>
<script>

function submitSubinterface(location) {
	/* if ("" == ServiceForm.SP_Sub_ipaddress_aEnd.value && "" == ServiceForm.SP_Sub_IPv6_Address_aEnd.value &&
			"" == ServiceForm.SP_Sub_ipaddress_zEnd.value && "" == ServiceForm.SP_Sub_IPv6_Address_zEnd.value) {
		alert('IP or IPv6 is a mandatory value for A or Z side');
	} else { */
		window.location.href = location;
	//}
}

function setcheckboxSub(id) {

    if (document.getElementById(id).checked) {
        //alert('true');

        document.getElementById(id).value = "true";

    } else {
        document.getElementById(id).value = "false";

    }
}

function checkNumValue(input, defaultvalue) {
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

function checkNumValueOrSpace(input, prompt) {
    var str = input.value;
    var newStr = "";
    for (i = 0; i < str.length; i++) {
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

function handleReusedLocation(siteid, side) {
    var SP_Region = getObjectById("SP_PW_" + side + "_region");
    var SP_Location = getObjectById("SP_PW_" + side + "_location");
    if (siteid != null && siteid != "") {
        SP_Region.disabled = "true";
        SP_Location.disabled = "true"; <%
        if (available_regions != null) {
            for (ServiceParameter r: available_regions) { %>
                if (siteid == <%= r.getServiceid() %> ) {
                    for (j = 0; j < SP_Region.length; j++) {
                        if (SP_Region.options[j].value == "<%=r.getValue()%>") {
                            SP_Region.selectedIndex = j;
                        } // if
                    } //  for     
                } //if
                <%
            } //for
        } //if
        %>

        <%
        if (available_locations != null) {
            for (ServiceParameter l: available_locations) { %>
                if (siteid == <%= l.getServiceid() %> ) {
                    SP_Location.options.length = 0;
                    SP_Location.options.add(new Option("<%=l.getValue()%>", "<%=l.getValue()%>"));
                } //if
                <%
            } //for
        } //if
        %>

    } else {
        //SP_Region.selectedIndex = 0;
        SP_Region.disabled = "";
        //SP_Location.selectedIndex = 0;
        SP_Location.disabled = "";
    } //if (siteid != null && siteid != "")

}

function checkAll() {
    var submitted = true;

    var presname = getObjectById('presname');
    
    if (submitted) {
        document.write( <%= link_part %> );
        // document.ServiceForm.submit();
    } else {
        setVisible("submitObject");
    }

}

function isIE_browser() {
    if (window.XMLHttpRequest) {
        return false;
    } else {
        return true;
    }
}

function getObjectById(objID) {
    if (document.getElementById && document.getElementById(objID)) {
        return document.getElementById(objID);
    } else {
        if (document.all && document.all(objID)) {
            return document.all(objID);
        } else {
            if (document.layers && document.layers[objID]) {
                return document.layers[objID];
            } else {
                return document.ServiceForm.elements[objID];
            }
        }
    }
}

function setVisible(Id) {
    if (isIE_browser()) {
        document.getElementById(Id).style.visibility = 'visible';
    } else {
        document.getElementsByName(Id)[0].style.visibility = 'visible';
    }
}

</script>
