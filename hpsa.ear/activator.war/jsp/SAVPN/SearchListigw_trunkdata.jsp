<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        java.lang.reflect.Method,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        org.apache.struts.action.ActionErrors" %>

<%@ page import = "java.util.Locale" %>
<%@ page import = "java.util.ResourceBundle" %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table" %>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>

<%@ page buffer="32kb" %>

<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%
/** For Struts module concept **/
org.apache.struts.config.ModuleConfig strutsModuleConfig =
            org.apache.struts.util.ModuleUtils.getInstance().getModuleConfig(null,
                (HttpServletRequest) pageContext.getRequest(),
                pageContext.getServletContext()); 
// module name that can be used as solution name               
String moduleConfig = strutsModuleConfig.getPrefix();
%>

<%
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(igw_trunkdataConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(igw_trunkdataConstants.DATASOURCE);
String tabName = request.getParameter(igw_trunkdataConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

igw_trunkdataForm form = (igw_trunkdataForm) request.getAttribute("igw_trunkdataForm");


String TRUNKDATA_ID___hide = null;
String PARENT_TRUNKDATA___hide = null;
String TRUNK_ID___hide = null;
String SIDE_SERVICE_ID___hide = null;
String SIDE_NAME___hide = null;
String SIDE_SORT_NAME___hide = null;
String ROUTER_ID___hide = null;
String INTERFACES_ID___hide = null;
String IPNET_POOL___hide = null;
String IPNET_ADDRESS___hide = null;
String IPNET_SUBMASK___hide = null;
String SIDE_DESCRIPTION___hide = null;
String NEGO_FLAG___hide = null;
String LINKPROTOCOL___hide = null;
String MTU___hide = null;
String PIM_FLAG___hide = null;
String OSPFNET_TYPE_FLAG___hide = null;
String OSPF_COST___hide = null;
String OSPF_PASSWORD___hide = null;
String LDP_FLAG___hide = null;
String LDP_PASSWORD___hide = null;
String INTERFACE_DESCRIPTION___hide = null;
String TRAFFIC_POLICYNAME___hide = null;
String POLICY_TYPE___hide = null;
String IPV6_POOL___hide = null;
String IPV6_ADDRESS___hide = null;
String ENCAPSULATION___hide = null;
String IPBINDING_FLAG___hide = null;
String OSPF_PROCESSID___hide = null;
String AREA___hide = null;
String BANDWIDTH___hide = null;
String RSVP_BANDWIDTH___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListigw_trunkdata.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  TRUNKDATA_ID___hide = form.getTrunkdata_id___hide();
  PARENT_TRUNKDATA___hide = form.getParent_trunkdata___hide();
  TRUNK_ID___hide = form.getTrunk_id___hide();
  SIDE_SERVICE_ID___hide = form.getSide_service_id___hide();
  SIDE_NAME___hide = form.getSide_name___hide();
  SIDE_SORT_NAME___hide = form.getSide_sort_name___hide();
  ROUTER_ID___hide = form.getRouter_id___hide();
  INTERFACES_ID___hide = form.getInterfaces_id___hide();
  IPNET_POOL___hide = form.getIpnet_pool___hide();
  IPNET_ADDRESS___hide = form.getIpnet_address___hide();
  IPNET_SUBMASK___hide = form.getIpnet_submask___hide();
  SIDE_DESCRIPTION___hide = form.getSide_description___hide();
  NEGO_FLAG___hide = form.getNego_flag___hide();
  LINKPROTOCOL___hide = form.getLinkprotocol___hide();
  MTU___hide = form.getMtu___hide();
  PIM_FLAG___hide = form.getPim_flag___hide();
  OSPFNET_TYPE_FLAG___hide = form.getOspfnet_type_flag___hide();
  OSPF_COST___hide = form.getOspf_cost___hide();
  OSPF_PASSWORD___hide = form.getOspf_password___hide();
  LDP_FLAG___hide = form.getLdp_flag___hide();
  LDP_PASSWORD___hide = form.getLdp_password___hide();
  INTERFACE_DESCRIPTION___hide = form.getInterface_description___hide();
  TRAFFIC_POLICYNAME___hide = form.getTraffic_policyname___hide();
  POLICY_TYPE___hide = form.getPolicy_type___hide();
  IPV6_POOL___hide = form.getIpv6_pool___hide();
  IPV6_ADDRESS___hide = form.getIpv6_address___hide();
  ENCAPSULATION___hide = form.getEncapsulation___hide();
  IPBINDING_FLAG___hide = form.getIpbinding_flag___hide();
  OSPF_PROCESSID___hide = form.getOspf_processid___hide();
  AREA___hide = form.getArea___hide();
  BANDWIDTH___hide = form.getBandwidth___hide();
  RSVP_BANDWIDTH___hide = form.getRsvp_bandwidth___hide();

  if ( TRUNKDATA_ID___hide != null )
    requestURI.append("trunkdata_id___hide=" + TRUNKDATA_ID___hide);
  if ( PARENT_TRUNKDATA___hide != null )
    requestURI.append("parent_trunkdata___hide=" + PARENT_TRUNKDATA___hide);
  if ( TRUNK_ID___hide != null )
    requestURI.append("trunk_id___hide=" + TRUNK_ID___hide);
  if ( SIDE_SERVICE_ID___hide != null )
    requestURI.append("side_service_id___hide=" + SIDE_SERVICE_ID___hide);
  if ( SIDE_NAME___hide != null )
    requestURI.append("side_name___hide=" + SIDE_NAME___hide);
  if ( SIDE_SORT_NAME___hide != null )
    requestURI.append("side_sort_name___hide=" + SIDE_SORT_NAME___hide);
  if ( ROUTER_ID___hide != null )
    requestURI.append("router_id___hide=" + ROUTER_ID___hide);
  if ( INTERFACES_ID___hide != null )
    requestURI.append("interfaces_id___hide=" + INTERFACES_ID___hide);
  if ( IPNET_POOL___hide != null )
    requestURI.append("ipnet_pool___hide=" + IPNET_POOL___hide);
  if ( IPNET_ADDRESS___hide != null )
    requestURI.append("ipnet_address___hide=" + IPNET_ADDRESS___hide);
  if ( IPNET_SUBMASK___hide != null )
    requestURI.append("ipnet_submask___hide=" + IPNET_SUBMASK___hide);
  if ( SIDE_DESCRIPTION___hide != null )
    requestURI.append("side_description___hide=" + SIDE_DESCRIPTION___hide);
  if ( NEGO_FLAG___hide != null )
    requestURI.append("nego_flag___hide=" + NEGO_FLAG___hide);
  if ( LINKPROTOCOL___hide != null )
    requestURI.append("linkprotocol___hide=" + LINKPROTOCOL___hide);
  if ( MTU___hide != null )
    requestURI.append("mtu___hide=" + MTU___hide);
  if ( PIM_FLAG___hide != null )
    requestURI.append("pim_flag___hide=" + PIM_FLAG___hide);
  if ( OSPFNET_TYPE_FLAG___hide != null )
    requestURI.append("ospfnet_type_flag___hide=" + OSPFNET_TYPE_FLAG___hide);
  if ( OSPF_COST___hide != null )
    requestURI.append("ospf_cost___hide=" + OSPF_COST___hide);
  if ( OSPF_PASSWORD___hide != null )
    requestURI.append("ospf_password___hide=" + OSPF_PASSWORD___hide);
  if ( LDP_FLAG___hide != null )
    requestURI.append("ldp_flag___hide=" + LDP_FLAG___hide);
  if ( LDP_PASSWORD___hide != null )
    requestURI.append("ldp_password___hide=" + LDP_PASSWORD___hide);
  if ( INTERFACE_DESCRIPTION___hide != null )
    requestURI.append("interface_description___hide=" + INTERFACE_DESCRIPTION___hide);
  if ( TRAFFIC_POLICYNAME___hide != null )
    requestURI.append("traffic_policyname___hide=" + TRAFFIC_POLICYNAME___hide);
  if ( POLICY_TYPE___hide != null )
    requestURI.append("policy_type___hide=" + POLICY_TYPE___hide);
  if ( IPV6_POOL___hide != null )
    requestURI.append("ipv6_pool___hide=" + IPV6_POOL___hide);
  if ( IPV6_ADDRESS___hide != null )
    requestURI.append("ipv6_address___hide=" + IPV6_ADDRESS___hide);
  if ( ENCAPSULATION___hide != null )
    requestURI.append("encapsulation___hide=" + ENCAPSULATION___hide);
  if ( IPBINDING_FLAG___hide != null )
    requestURI.append("ipbinding_flag___hide=" + IPBINDING_FLAG___hide);
  if ( OSPF_PROCESSID___hide != null )
    requestURI.append("ospf_processid___hide=" + OSPF_PROCESSID___hide);
  if ( AREA___hide != null )
    requestURI.append("area___hide=" + AREA___hide);
  if ( BANDWIDTH___hide != null )
    requestURI.append("bandwidth___hide=" + BANDWIDTH___hide);
  if ( RSVP_BANDWIDTH___hide != null )
    requestURI.append("rsvp_bandwidth___hide=" + RSVP_BANDWIDTH___hide);

} else {

    TRUNKDATA_ID___hide = request.getParameter("trunkdata_id___hide");
    PARENT_TRUNKDATA___hide = request.getParameter("parent_trunkdata___hide");
    TRUNK_ID___hide = request.getParameter("trunk_id___hide");
    SIDE_SERVICE_ID___hide = request.getParameter("side_service_id___hide");
    SIDE_NAME___hide = request.getParameter("side_name___hide");
    SIDE_SORT_NAME___hide = request.getParameter("side_sort_name___hide");
    ROUTER_ID___hide = request.getParameter("router_id___hide");
    INTERFACES_ID___hide = request.getParameter("interfaces_id___hide");
    IPNET_POOL___hide = request.getParameter("ipnet_pool___hide");
    IPNET_ADDRESS___hide = request.getParameter("ipnet_address___hide");
    IPNET_SUBMASK___hide = request.getParameter("ipnet_submask___hide");
    SIDE_DESCRIPTION___hide = request.getParameter("side_description___hide");
    NEGO_FLAG___hide = request.getParameter("nego_flag___hide");
    LINKPROTOCOL___hide = request.getParameter("linkprotocol___hide");
    MTU___hide = request.getParameter("mtu___hide");
    PIM_FLAG___hide = request.getParameter("pim_flag___hide");
    OSPFNET_TYPE_FLAG___hide = request.getParameter("ospfnet_type_flag___hide");
    OSPF_COST___hide = request.getParameter("ospf_cost___hide");
    OSPF_PASSWORD___hide = request.getParameter("ospf_password___hide");
    LDP_FLAG___hide = request.getParameter("ldp_flag___hide");
    LDP_PASSWORD___hide = request.getParameter("ldp_password___hide");
    INTERFACE_DESCRIPTION___hide = request.getParameter("interface_description___hide");
    TRAFFIC_POLICYNAME___hide = request.getParameter("traffic_policyname___hide");
    POLICY_TYPE___hide = request.getParameter("policy_type___hide");
    IPV6_POOL___hide = request.getParameter("ipv6_pool___hide");
    IPV6_ADDRESS___hide = request.getParameter("ipv6_address___hide");
    ENCAPSULATION___hide = request.getParameter("encapsulation___hide");
    IPBINDING_FLAG___hide = request.getParameter("ipbinding_flag___hide");
    OSPF_PROCESSID___hide = request.getParameter("ospf_processid___hide");
    AREA___hide = request.getParameter("area___hide");
    BANDWIDTH___hide = request.getParameter("bandwidth___hide");
    RSVP_BANDWIDTH___hide = request.getParameter("rsvp_bandwidth___hide");

}

%>

<script>
  function openBranch(pk) {
    var WDW = 3;
    var tabTitle = "<%= viewParameter %>";
    var wdwSelected = true;
    var url = "/activator/GetPartialTreeInstanceAction.do";
    url += "?ndid=<%= ndidParameter %>";
    url += "&vi=<%= viParameter %>";
    url += "&pk=" + pk;
    url += "&view=<%= viewParameter %>";
    url += "&rmn=" + WDW;
    parent.parent.addRimToMenu(WDW, tabTitle, wdwSelected, url);
  }
  function onClickedRow(rowId) {

  var row_pk=null;
<%
  final String UND = "undefined";
  String rowid = UND;
  for (int i = 0; i < al.size(); i++) {
  rowid = UND;
  try {
    Method m = al.get(i).getClass().getMethod("getPrimaryKey", null);
    rowid = (String) m.invoke(al.get(i), null);
  } catch(Exception e) {
    rowid = UND;
  }
%>
  if (rowId=="elementSearch_<%= rowid %>") {
    row_pk="<%= rowid %>";
  }
<%
}
%>
  if(row_pk!=null) {
    openBranch(row_pk);
  }  
}  
</script>

<html>
  <head>
    <title><bean:message bundle="igw_trunkdataApplicationResources" key="<%= igw_trunkdataConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="igw_trunkdataApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitigw_trunkdataAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( TRUNKDATA_ID___hide == null || TRUNKDATA_ID___hide.equals("null") ) {
%>
      <display:column property="trunkdata_id" sortable="true" titleKey="igw_trunkdataApplicationResources:field.trunkdata_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PARENT_TRUNKDATA___hide == null || PARENT_TRUNKDATA___hide.equals("null") ) {
%>
      <display:column property="parent_trunkdata" sortable="true" titleKey="igw_trunkdataApplicationResources:field.parent_trunkdata.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( TRUNK_ID___hide == null || TRUNK_ID___hide.equals("null") ) {
%>
      <display:column property="trunk_id" sortable="true" titleKey="igw_trunkdataApplicationResources:field.trunk_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SIDE_SERVICE_ID___hide == null || SIDE_SERVICE_ID___hide.equals("null") ) {
%>
      <display:column property="side_service_id" sortable="true" titleKey="igw_trunkdataApplicationResources:field.side_service_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SIDE_NAME___hide == null || SIDE_NAME___hide.equals("null") ) {
%>
      <display:column property="side_name" sortable="true" titleKey="igw_trunkdataApplicationResources:field.side_name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SIDE_SORT_NAME___hide == null || SIDE_SORT_NAME___hide.equals("null") ) {
%>
      <display:column property="side_sort_name" sortable="true" titleKey="igw_trunkdataApplicationResources:field.side_sort_name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ROUTER_ID___hide == null || ROUTER_ID___hide.equals("null") ) {
%>
      <display:column property="router_id" sortable="true" titleKey="igw_trunkdataApplicationResources:field.router_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( INTERFACES_ID___hide == null || INTERFACES_ID___hide.equals("null") ) {
%>
      <display:column property="interfaces_id" sortable="true" titleKey="igw_trunkdataApplicationResources:field.interfaces_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IPNET_POOL___hide == null || IPNET_POOL___hide.equals("null") ) {
%>
      <display:column property="ipnet_pool" sortable="true" titleKey="igw_trunkdataApplicationResources:field.ipnet_pool.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IPNET_ADDRESS___hide == null || IPNET_ADDRESS___hide.equals("null") ) {
%>
      <display:column property="ipnet_address" sortable="true" titleKey="igw_trunkdataApplicationResources:field.ipnet_address.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IPNET_SUBMASK___hide == null || IPNET_SUBMASK___hide.equals("null") ) {
%>
      <display:column property="ipnet_submask" sortable="true" titleKey="igw_trunkdataApplicationResources:field.ipnet_submask.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SIDE_DESCRIPTION___hide == null || SIDE_DESCRIPTION___hide.equals("null") ) {
%>
      <display:column property="side_description" sortable="true" titleKey="igw_trunkdataApplicationResources:field.side_description.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NEGO_FLAG___hide == null || NEGO_FLAG___hide.equals("null") ) {
%>
      <display:column property="nego_flag" sortable="true" titleKey="igw_trunkdataApplicationResources:field.nego_flag.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( LINKPROTOCOL___hide == null || LINKPROTOCOL___hide.equals("null") ) {
%>
      <display:column property="linkprotocol" sortable="true" titleKey="igw_trunkdataApplicationResources:field.linkprotocol.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( MTU___hide == null || MTU___hide.equals("null") ) {
%>
      <display:column property="mtu" sortable="true" titleKey="igw_trunkdataApplicationResources:field.mtu.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PIM_FLAG___hide == null || PIM_FLAG___hide.equals("null") ) {
%>
      <display:column property="pim_flag" sortable="true" titleKey="igw_trunkdataApplicationResources:field.pim_flag.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( OSPFNET_TYPE_FLAG___hide == null || OSPFNET_TYPE_FLAG___hide.equals("null") ) {
%>
      <display:column property="ospfnet_type_flag" sortable="true" titleKey="igw_trunkdataApplicationResources:field.ospfnet_type_flag.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( OSPF_COST___hide == null || OSPF_COST___hide.equals("null") ) {
%>
      <display:column property="ospf_cost" sortable="true" titleKey="igw_trunkdataApplicationResources:field.ospf_cost.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( OSPF_PASSWORD___hide == null || OSPF_PASSWORD___hide.equals("null") ) {
%>
      <display:column property="ospf_password" sortable="true" titleKey="igw_trunkdataApplicationResources:field.ospf_password.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( LDP_FLAG___hide == null || LDP_FLAG___hide.equals("null") ) {
%>
      <display:column property="ldp_flag" sortable="true" titleKey="igw_trunkdataApplicationResources:field.ldp_flag.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( LDP_PASSWORD___hide == null || LDP_PASSWORD___hide.equals("null") ) {
%>
      <display:column property="ldp_password" sortable="true" titleKey="igw_trunkdataApplicationResources:field.ldp_password.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( INTERFACE_DESCRIPTION___hide == null || INTERFACE_DESCRIPTION___hide.equals("null") ) {
%>
      <display:column property="interface_description" sortable="true" titleKey="igw_trunkdataApplicationResources:field.interface_description.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( TRAFFIC_POLICYNAME___hide == null || TRAFFIC_POLICYNAME___hide.equals("null") ) {
%>
      <display:column property="traffic_policyname" sortable="true" titleKey="igw_trunkdataApplicationResources:field.traffic_policyname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( POLICY_TYPE___hide == null || POLICY_TYPE___hide.equals("null") ) {
%>
      <display:column property="policy_type" sortable="true" titleKey="igw_trunkdataApplicationResources:field.policy_type.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IPV6_POOL___hide == null || IPV6_POOL___hide.equals("null") ) {
%>
      <display:column property="ipv6_pool" sortable="true" titleKey="igw_trunkdataApplicationResources:field.ipv6_pool.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IPV6_ADDRESS___hide == null || IPV6_ADDRESS___hide.equals("null") ) {
%>
      <display:column property="ipv6_address" sortable="true" titleKey="igw_trunkdataApplicationResources:field.ipv6_address.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ENCAPSULATION___hide == null || ENCAPSULATION___hide.equals("null") ) {
%>
      <display:column property="encapsulation" sortable="true" titleKey="igw_trunkdataApplicationResources:field.encapsulation.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IPBINDING_FLAG___hide == null || IPBINDING_FLAG___hide.equals("null") ) {
%>
      <display:column property="ipbinding_flag" sortable="true" titleKey="igw_trunkdataApplicationResources:field.ipbinding_flag.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( OSPF_PROCESSID___hide == null || OSPF_PROCESSID___hide.equals("null") ) {
%>
      <display:column property="ospf_processid" sortable="true" titleKey="igw_trunkdataApplicationResources:field.ospf_processid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( AREA___hide == null || AREA___hide.equals("null") ) {
%>
      <display:column property="area" sortable="true" titleKey="igw_trunkdataApplicationResources:field.area.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( BANDWIDTH___hide == null || BANDWIDTH___hide.equals("null") ) {
%>
      <display:column property="bandwidth" sortable="true" titleKey="igw_trunkdataApplicationResources:field.bandwidth.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RSVP_BANDWIDTH___hide == null || RSVP_BANDWIDTH___hide.equals("null") ) {
%>
      <display:column property="rsvp_bandwidth" sortable="true" titleKey="igw_trunkdataApplicationResources:field.rsvp_bandwidth.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormigw_trunkdataAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="trunkdata_id" value="<%= form.getTrunkdata_id() %>"/>
                <html:hidden property="trunkdata_id___hide" value="<%= form.getTrunkdata_id___hide() %>"/>
                        <html:hidden property="parent_trunkdata" value="<%= form.getParent_trunkdata() %>"/>
                <html:hidden property="parent_trunkdata___hide" value="<%= form.getParent_trunkdata___hide() %>"/>
                        <html:hidden property="trunk_id" value="<%= form.getTrunk_id() %>"/>
                <html:hidden property="trunk_id___hide" value="<%= form.getTrunk_id___hide() %>"/>
                        <html:hidden property="side_service_id" value="<%= form.getSide_service_id() %>"/>
                <html:hidden property="side_service_id___hide" value="<%= form.getSide_service_id___hide() %>"/>
                        <html:hidden property="side_name" value="<%= form.getSide_name() %>"/>
                <html:hidden property="side_name___hide" value="<%= form.getSide_name___hide() %>"/>
                        <html:hidden property="side_sort_name" value="<%= form.getSide_sort_name() %>"/>
                <html:hidden property="side_sort_name___hide" value="<%= form.getSide_sort_name___hide() %>"/>
                        <html:hidden property="router_id" value="<%= form.getRouter_id() %>"/>
                <html:hidden property="router_id___hide" value="<%= form.getRouter_id___hide() %>"/>
                        <html:hidden property="interfaces_id" value="<%= form.getInterfaces_id() %>"/>
                <html:hidden property="interfaces_id___hide" value="<%= form.getInterfaces_id___hide() %>"/>
                        <html:hidden property="ipnet_pool" value="<%= form.getIpnet_pool() %>"/>
                <html:hidden property="ipnet_pool___hide" value="<%= form.getIpnet_pool___hide() %>"/>
                        <html:hidden property="ipnet_address" value="<%= form.getIpnet_address() %>"/>
                <html:hidden property="ipnet_address___hide" value="<%= form.getIpnet_address___hide() %>"/>
                        <html:hidden property="ipnet_submask" value="<%= form.getIpnet_submask() %>"/>
                <html:hidden property="ipnet_submask___hide" value="<%= form.getIpnet_submask___hide() %>"/>
                        <html:hidden property="side_description" value="<%= form.getSide_description() %>"/>
                <html:hidden property="side_description___hide" value="<%= form.getSide_description___hide() %>"/>
                        <html:hidden property="nego_flag" value="<%= form.getNego_flag() %>"/>
                <html:hidden property="nego_flag___hide" value="<%= form.getNego_flag___hide() %>"/>
                        <html:hidden property="linkprotocol" value="<%= form.getLinkprotocol() %>"/>
                <html:hidden property="linkprotocol___hide" value="<%= form.getLinkprotocol___hide() %>"/>
                        <html:hidden property="mtu" value="<%= form.getMtu() %>"/>
                  <html:hidden property="mtu___" value="<%= form.getMtu___() %>"/>
                <html:hidden property="mtu___hide" value="<%= form.getMtu___hide() %>"/>
                        <html:hidden property="pim_flag" value="<%= form.getPim_flag() %>"/>
                <html:hidden property="pim_flag___hide" value="<%= form.getPim_flag___hide() %>"/>
                        <html:hidden property="ospfnet_type_flag" value="<%= form.getOspfnet_type_flag() %>"/>
                <html:hidden property="ospfnet_type_flag___hide" value="<%= form.getOspfnet_type_flag___hide() %>"/>
                        <html:hidden property="ospf_cost" value="<%= form.getOspf_cost() %>"/>
                  <html:hidden property="ospf_cost___" value="<%= form.getOspf_cost___() %>"/>
                <html:hidden property="ospf_cost___hide" value="<%= form.getOspf_cost___hide() %>"/>
                        <html:hidden property="ospf_password" value="<%= form.getOspf_password() %>"/>
                <html:hidden property="ospf_password___hide" value="<%= form.getOspf_password___hide() %>"/>
                        <html:hidden property="ldp_flag" value="<%= form.getLdp_flag() %>"/>
                <html:hidden property="ldp_flag___hide" value="<%= form.getLdp_flag___hide() %>"/>
                        <html:hidden property="ldp_password" value="<%= form.getLdp_password() %>"/>
                <html:hidden property="ldp_password___hide" value="<%= form.getLdp_password___hide() %>"/>
                        <html:hidden property="interface_description" value="<%= form.getInterface_description() %>"/>
                <html:hidden property="interface_description___hide" value="<%= form.getInterface_description___hide() %>"/>
                        <html:hidden property="traffic_policyname" value="<%= form.getTraffic_policyname() %>"/>
                <html:hidden property="traffic_policyname___hide" value="<%= form.getTraffic_policyname___hide() %>"/>
                        <html:hidden property="policy_type" value="<%= form.getPolicy_type() %>"/>
                <html:hidden property="policy_type___hide" value="<%= form.getPolicy_type___hide() %>"/>
                        <html:hidden property="ipv6_pool" value="<%= form.getIpv6_pool() %>"/>
                <html:hidden property="ipv6_pool___hide" value="<%= form.getIpv6_pool___hide() %>"/>
                        <html:hidden property="ipv6_address" value="<%= form.getIpv6_address() %>"/>
                <html:hidden property="ipv6_address___hide" value="<%= form.getIpv6_address___hide() %>"/>
                        <html:hidden property="encapsulation" value="<%= form.getEncapsulation() %>"/>
                <html:hidden property="encapsulation___hide" value="<%= form.getEncapsulation___hide() %>"/>
                        <html:hidden property="ipbinding_flag" value="<%= form.getIpbinding_flag() %>"/>
                <html:hidden property="ipbinding_flag___hide" value="<%= form.getIpbinding_flag___hide() %>"/>
                        <html:hidden property="ospf_processid" value="<%= form.getOspf_processid() %>"/>
                  <html:hidden property="ospf_processid___" value="<%= form.getOspf_processid___() %>"/>
                <html:hidden property="ospf_processid___hide" value="<%= form.getOspf_processid___hide() %>"/>
                        <html:hidden property="area" value="<%= form.getArea() %>"/>
                <html:hidden property="area___hide" value="<%= form.getArea___hide() %>"/>
                        <html:hidden property="bandwidth" value="<%= form.getBandwidth() %>"/>
                <html:hidden property="bandwidth___hide" value="<%= form.getBandwidth___hide() %>"/>
                        <html:hidden property="rsvp_bandwidth" value="<%= form.getRsvp_bandwidth() %>"/>
                <html:hidden property="rsvp_bandwidth___hide" value="<%= form.getRsvp_bandwidth___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="trunkdata_id" value="<%= request.getParameter(\"trunkdata_id\") %>"/>
                <html:hidden property="trunkdata_id___hide" value="<%= request.getParameter(\"trunkdata_id___hide\") %>"/>
                        <html:hidden property="parent_trunkdata" value="<%= request.getParameter(\"parent_trunkdata\") %>"/>
                <html:hidden property="parent_trunkdata___hide" value="<%= request.getParameter(\"parent_trunkdata___hide\") %>"/>
                        <html:hidden property="trunk_id" value="<%= request.getParameter(\"trunk_id\") %>"/>
                <html:hidden property="trunk_id___hide" value="<%= request.getParameter(\"trunk_id___hide\") %>"/>
                        <html:hidden property="side_service_id" value="<%= request.getParameter(\"side_service_id\") %>"/>
                <html:hidden property="side_service_id___hide" value="<%= request.getParameter(\"side_service_id___hide\") %>"/>
                        <html:hidden property="side_name" value="<%= request.getParameter(\"side_name\") %>"/>
                <html:hidden property="side_name___hide" value="<%= request.getParameter(\"side_name___hide\") %>"/>
                        <html:hidden property="side_sort_name" value="<%= request.getParameter(\"side_sort_name\") %>"/>
                <html:hidden property="side_sort_name___hide" value="<%= request.getParameter(\"side_sort_name___hide\") %>"/>
                        <html:hidden property="router_id" value="<%= request.getParameter(\"router_id\") %>"/>
                <html:hidden property="router_id___hide" value="<%= request.getParameter(\"router_id___hide\") %>"/>
                        <html:hidden property="interfaces_id" value="<%= request.getParameter(\"interfaces_id\") %>"/>
                <html:hidden property="interfaces_id___hide" value="<%= request.getParameter(\"interfaces_id___hide\") %>"/>
                        <html:hidden property="ipnet_pool" value="<%= request.getParameter(\"ipnet_pool\") %>"/>
                <html:hidden property="ipnet_pool___hide" value="<%= request.getParameter(\"ipnet_pool___hide\") %>"/>
                        <html:hidden property="ipnet_address" value="<%= request.getParameter(\"ipnet_address\") %>"/>
                <html:hidden property="ipnet_address___hide" value="<%= request.getParameter(\"ipnet_address___hide\") %>"/>
                        <html:hidden property="ipnet_submask" value="<%= request.getParameter(\"ipnet_submask\") %>"/>
                <html:hidden property="ipnet_submask___hide" value="<%= request.getParameter(\"ipnet_submask___hide\") %>"/>
                        <html:hidden property="side_description" value="<%= request.getParameter(\"side_description\") %>"/>
                <html:hidden property="side_description___hide" value="<%= request.getParameter(\"side_description___hide\") %>"/>
                        <html:hidden property="nego_flag" value="<%= request.getParameter(\"nego_flag\") %>"/>
                <html:hidden property="nego_flag___hide" value="<%= request.getParameter(\"nego_flag___hide\") %>"/>
                        <html:hidden property="linkprotocol" value="<%= request.getParameter(\"linkprotocol\") %>"/>
                <html:hidden property="linkprotocol___hide" value="<%= request.getParameter(\"linkprotocol___hide\") %>"/>
                        <html:hidden property="mtu" value="<%= request.getParameter(\"mtu\") %>"/>
                  <html:hidden property="mtu___" value="<%= request.getParameter(\"mtu___\") %>"/>
                <html:hidden property="mtu___hide" value="<%= request.getParameter(\"mtu___hide\") %>"/>
                        <html:hidden property="pim_flag" value="<%= request.getParameter(\"pim_flag\") %>"/>
                <html:hidden property="pim_flag___hide" value="<%= request.getParameter(\"pim_flag___hide\") %>"/>
                        <html:hidden property="ospfnet_type_flag" value="<%= request.getParameter(\"ospfnet_type_flag\") %>"/>
                <html:hidden property="ospfnet_type_flag___hide" value="<%= request.getParameter(\"ospfnet_type_flag___hide\") %>"/>
                        <html:hidden property="ospf_cost" value="<%= request.getParameter(\"ospf_cost\") %>"/>
                  <html:hidden property="ospf_cost___" value="<%= request.getParameter(\"ospf_cost___\") %>"/>
                <html:hidden property="ospf_cost___hide" value="<%= request.getParameter(\"ospf_cost___hide\") %>"/>
                        <html:hidden property="ospf_password" value="<%= request.getParameter(\"ospf_password\") %>"/>
                <html:hidden property="ospf_password___hide" value="<%= request.getParameter(\"ospf_password___hide\") %>"/>
                        <html:hidden property="ldp_flag" value="<%= request.getParameter(\"ldp_flag\") %>"/>
                <html:hidden property="ldp_flag___hide" value="<%= request.getParameter(\"ldp_flag___hide\") %>"/>
                        <html:hidden property="ldp_password" value="<%= request.getParameter(\"ldp_password\") %>"/>
                <html:hidden property="ldp_password___hide" value="<%= request.getParameter(\"ldp_password___hide\") %>"/>
                        <html:hidden property="interface_description" value="<%= request.getParameter(\"interface_description\") %>"/>
                <html:hidden property="interface_description___hide" value="<%= request.getParameter(\"interface_description___hide\") %>"/>
                        <html:hidden property="traffic_policyname" value="<%= request.getParameter(\"traffic_policyname\") %>"/>
                <html:hidden property="traffic_policyname___hide" value="<%= request.getParameter(\"traffic_policyname___hide\") %>"/>
                        <html:hidden property="policy_type" value="<%= request.getParameter(\"policy_type\") %>"/>
                <html:hidden property="policy_type___hide" value="<%= request.getParameter(\"policy_type___hide\") %>"/>
                        <html:hidden property="ipv6_pool" value="<%= request.getParameter(\"ipv6_pool\") %>"/>
                <html:hidden property="ipv6_pool___hide" value="<%= request.getParameter(\"ipv6_pool___hide\") %>"/>
                        <html:hidden property="ipv6_address" value="<%= request.getParameter(\"ipv6_address\") %>"/>
                <html:hidden property="ipv6_address___hide" value="<%= request.getParameter(\"ipv6_address___hide\") %>"/>
                        <html:hidden property="encapsulation" value="<%= request.getParameter(\"encapsulation\") %>"/>
                <html:hidden property="encapsulation___hide" value="<%= request.getParameter(\"encapsulation___hide\") %>"/>
                        <html:hidden property="ipbinding_flag" value="<%= request.getParameter(\"ipbinding_flag\") %>"/>
                <html:hidden property="ipbinding_flag___hide" value="<%= request.getParameter(\"ipbinding_flag___hide\") %>"/>
                        <html:hidden property="ospf_processid" value="<%= request.getParameter(\"ospf_processid\") %>"/>
                  <html:hidden property="ospf_processid___" value="<%= request.getParameter(\"ospf_processid___\") %>"/>
                <html:hidden property="ospf_processid___hide" value="<%= request.getParameter(\"ospf_processid___hide\") %>"/>
                        <html:hidden property="area" value="<%= request.getParameter(\"area\") %>"/>
                <html:hidden property="area___hide" value="<%= request.getParameter(\"area___hide\") %>"/>
                        <html:hidden property="bandwidth" value="<%= request.getParameter(\"bandwidth\") %>"/>
                <html:hidden property="bandwidth___hide" value="<%= request.getParameter(\"bandwidth___hide\") %>"/>
                        <html:hidden property="rsvp_bandwidth" value="<%= request.getParameter(\"rsvp_bandwidth\") %>"/>
                <html:hidden property="rsvp_bandwidth___hide" value="<%= request.getParameter(\"rsvp_bandwidth___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.igw_trunkdataForm.submit()"/>
  </html:form>

  </body>
</html>
  
