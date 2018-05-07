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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(PERouterConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(PERouterConstants.DATASOURCE);
String tabName = request.getParameter(PERouterConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

PERouterForm form = (PERouterForm) request.getAttribute("PERouterForm");


String NetworkId___hide = null;
String NetworkElementId___hide = null;
String Name___hide = null;
String Description___hide = null;
String Location___hide = null;
String IP___hide = null;
String Management_IP___hide = null;
String ManagementInterface___hide = null;
String PWPolicyEnabled___hide = null;
String PWPolicy___hide = null;
String UsernameEnabled___hide = null;
String Username___hide = null;
String Vendor___hide = null;
String OSVersion___hide = null;
String ElementType___hide = null;
String BGPDiscovery___hide = null;
String Tier___hide = null;
String SerialNumber___hide = null;
String Role___hide = null;
String AdminState___hide = null;
String LifeCycleState___hide = null;
String Backup___hide = null;
String SchPolicyName___hide = null;
String SkipActivation___hide = null;
String ROCommunity___hide = null;
String RWCommunity___hide = null;
String NNMi_UUId___hide = null;
String NNMi_Id___hide = null;
String NNMi_LastUpdate___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListPERouter.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  NetworkId___hide = form.getNetworkid___hide();
  NetworkElementId___hide = form.getNetworkelementid___hide();
  Name___hide = form.getName___hide();
  Description___hide = form.getDescription___hide();
  Location___hide = form.getLocation___hide();
  IP___hide = form.getIp___hide();
  Management_IP___hide = form.getManagement_ip___hide();
  ManagementInterface___hide = form.getManagementinterface___hide();
  PWPolicyEnabled___hide = form.getPwpolicyenabled___hide();
  PWPolicy___hide = form.getPwpolicy___hide();
  UsernameEnabled___hide = form.getUsernameenabled___hide();
  Username___hide = form.getUsername___hide();
  Vendor___hide = form.getVendor___hide();
  OSVersion___hide = form.getOsversion___hide();
  ElementType___hide = form.getElementtype___hide();
  BGPDiscovery___hide = form.getBgpdiscovery___hide();
  Tier___hide = form.getTier___hide();
  SerialNumber___hide = form.getSerialnumber___hide();
  Role___hide = form.getRole___hide();
  AdminState___hide = form.getAdminstate___hide();
  LifeCycleState___hide = form.getLifecyclestate___hide();
  Backup___hide = form.getBackup___hide();
  SchPolicyName___hide = form.getSchpolicyname___hide();
  SkipActivation___hide = form.getSkipactivation___hide();
  ROCommunity___hide = form.getRocommunity___hide();
  RWCommunity___hide = form.getRwcommunity___hide();
  NNMi_UUId___hide = form.getNnmi_uuid___hide();
  NNMi_Id___hide = form.getNnmi_id___hide();
  NNMi_LastUpdate___hide = form.getNnmi_lastupdate___hide();

  if ( NetworkId___hide != null )
    requestURI.append("networkid___hide=" + NetworkId___hide);
  if ( NetworkElementId___hide != null )
    requestURI.append("networkelementid___hide=" + NetworkElementId___hide);
  if ( Name___hide != null )
    requestURI.append("name___hide=" + Name___hide);
  if ( Description___hide != null )
    requestURI.append("description___hide=" + Description___hide);
  if ( Location___hide != null )
    requestURI.append("location___hide=" + Location___hide);
  if ( IP___hide != null )
    requestURI.append("ip___hide=" + IP___hide);
  if ( Management_IP___hide != null )
    requestURI.append("management_ip___hide=" + Management_IP___hide);
  if ( ManagementInterface___hide != null )
    requestURI.append("managementinterface___hide=" + ManagementInterface___hide);
  if ( PWPolicyEnabled___hide != null )
    requestURI.append("pwpolicyenabled___hide=" + PWPolicyEnabled___hide);
  if ( PWPolicy___hide != null )
    requestURI.append("pwpolicy___hide=" + PWPolicy___hide);
  if ( UsernameEnabled___hide != null )
    requestURI.append("usernameenabled___hide=" + UsernameEnabled___hide);
  if ( Username___hide != null )
    requestURI.append("username___hide=" + Username___hide);
  if ( Vendor___hide != null )
    requestURI.append("vendor___hide=" + Vendor___hide);
  if ( OSVersion___hide != null )
    requestURI.append("osversion___hide=" + OSVersion___hide);
  if ( ElementType___hide != null )
    requestURI.append("elementtype___hide=" + ElementType___hide);
  if ( BGPDiscovery___hide != null )
    requestURI.append("bgpdiscovery___hide=" + BGPDiscovery___hide);
  if ( Tier___hide != null )
    requestURI.append("tier___hide=" + Tier___hide);
  if ( SerialNumber___hide != null )
    requestURI.append("serialnumber___hide=" + SerialNumber___hide);
  if ( Role___hide != null )
    requestURI.append("role___hide=" + Role___hide);
  if ( AdminState___hide != null )
    requestURI.append("adminstate___hide=" + AdminState___hide);
  if ( LifeCycleState___hide != null )
    requestURI.append("lifecyclestate___hide=" + LifeCycleState___hide);
  if ( Backup___hide != null )
    requestURI.append("backup___hide=" + Backup___hide);
  if ( SchPolicyName___hide != null )
    requestURI.append("schpolicyname___hide=" + SchPolicyName___hide);
  if ( SkipActivation___hide != null )
    requestURI.append("skipactivation___hide=" + SkipActivation___hide);
  if ( ROCommunity___hide != null )
    requestURI.append("rocommunity___hide=" + ROCommunity___hide);
  if ( RWCommunity___hide != null )
    requestURI.append("rwcommunity___hide=" + RWCommunity___hide);
  if ( NNMi_UUId___hide != null )
    requestURI.append("nnmi_uuid___hide=" + NNMi_UUId___hide);
  if ( NNMi_Id___hide != null )
    requestURI.append("nnmi_id___hide=" + NNMi_Id___hide);
  if ( NNMi_LastUpdate___hide != null )
    requestURI.append("nnmi_lastupdate___hide=" + NNMi_LastUpdate___hide);

} else {

    NetworkId___hide = request.getParameter("networkid___hide");
    NetworkElementId___hide = request.getParameter("networkelementid___hide");
    Name___hide = request.getParameter("name___hide");
    Description___hide = request.getParameter("description___hide");
    Location___hide = request.getParameter("location___hide");
    IP___hide = request.getParameter("ip___hide");
    Management_IP___hide = request.getParameter("management_ip___hide");
    ManagementInterface___hide = request.getParameter("managementinterface___hide");
    PWPolicyEnabled___hide = request.getParameter("pwpolicyenabled___hide");
    PWPolicy___hide = request.getParameter("pwpolicy___hide");
    UsernameEnabled___hide = request.getParameter("usernameenabled___hide");
    Username___hide = request.getParameter("username___hide");
    Vendor___hide = request.getParameter("vendor___hide");
    OSVersion___hide = request.getParameter("osversion___hide");
    ElementType___hide = request.getParameter("elementtype___hide");
    BGPDiscovery___hide = request.getParameter("bgpdiscovery___hide");
    Tier___hide = request.getParameter("tier___hide");
    SerialNumber___hide = request.getParameter("serialnumber___hide");
    Role___hide = request.getParameter("role___hide");
    AdminState___hide = request.getParameter("adminstate___hide");
    LifeCycleState___hide = request.getParameter("lifecyclestate___hide");
    Backup___hide = request.getParameter("backup___hide");
    SchPolicyName___hide = request.getParameter("schpolicyname___hide");
    SkipActivation___hide = request.getParameter("skipactivation___hide");
    ROCommunity___hide = request.getParameter("rocommunity___hide");
    RWCommunity___hide = request.getParameter("rwcommunity___hide");
    NNMi_UUId___hide = request.getParameter("nnmi_uuid___hide");
    NNMi_Id___hide = request.getParameter("nnmi_id___hide");
    NNMi_LastUpdate___hide = request.getParameter("nnmi_lastupdate___hide");

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
    <title><bean:message bundle="PERouterApplicationResources" key="<%= PERouterConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="PERouterApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitPERouterAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( NetworkId___hide == null || NetworkId___hide.equals("null") ) {
%>
      <display:column property="networkid" sortable="true" titleKey="PERouterApplicationResources:field.networkid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NetworkElementId___hide == null || NetworkElementId___hide.equals("null") ) {
%>
      <display:column property="networkelementid" sortable="true" titleKey="PERouterApplicationResources:field.networkelementid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Name___hide == null || Name___hide.equals("null") ) {
%>
      <display:column property="name" sortable="true" titleKey="PERouterApplicationResources:field.name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Description___hide == null || Description___hide.equals("null") ) {
%>
      <display:column property="description" sortable="true" titleKey="PERouterApplicationResources:field.description.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Location___hide == null || Location___hide.equals("null") ) {
%>
      <display:column property="location" sortable="true" titleKey="PERouterApplicationResources:field.location.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IP___hide == null || IP___hide.equals("null") ) {
%>
      <display:column property="ip" sortable="true" titleKey="PERouterApplicationResources:field.ip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Management_IP___hide == null || Management_IP___hide.equals("null") ) {
%>
      <display:column property="management_ip" sortable="true" titleKey="PERouterApplicationResources:field.management_ip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ManagementInterface___hide == null || ManagementInterface___hide.equals("null") ) {
%>
      <display:column property="managementinterface" sortable="true" titleKey="PERouterApplicationResources:field.managementinterface.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PWPolicyEnabled___hide == null || PWPolicyEnabled___hide.equals("null") ) {
%>
      <display:column property="pwpolicyenabled" sortable="true" titleKey="PERouterApplicationResources:field.pwpolicyenabled.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PWPolicy___hide == null || PWPolicy___hide.equals("null") ) {
%>
      <display:column property="pwpolicy" sortable="true" titleKey="PERouterApplicationResources:field.pwpolicy.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UsernameEnabled___hide == null || UsernameEnabled___hide.equals("null") ) {
%>
      <display:column property="usernameenabled" sortable="true" titleKey="PERouterApplicationResources:field.usernameenabled.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Username___hide == null || Username___hide.equals("null") ) {
%>
      <display:column property="username" sortable="true" titleKey="PERouterApplicationResources:field.username.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Vendor___hide == null || Vendor___hide.equals("null") ) {
%>
      <display:column property="vendor" sortable="true" titleKey="PERouterApplicationResources:field.vendor.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( OSVersion___hide == null || OSVersion___hide.equals("null") ) {
%>
      <display:column property="osversion" sortable="true" titleKey="PERouterApplicationResources:field.osversion.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ElementType___hide == null || ElementType___hide.equals("null") ) {
%>
      <display:column property="elementtype" sortable="true" titleKey="PERouterApplicationResources:field.elementtype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( BGPDiscovery___hide == null || BGPDiscovery___hide.equals("null") ) {
%>
      <display:column property="bgpdiscovery" sortable="true" titleKey="PERouterApplicationResources:field.bgpdiscovery.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Tier___hide == null || Tier___hide.equals("null") ) {
%>
      <display:column property="tier" sortable="true" titleKey="PERouterApplicationResources:field.tier.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SerialNumber___hide == null || SerialNumber___hide.equals("null") ) {
%>
      <display:column property="serialnumber" sortable="true" titleKey="PERouterApplicationResources:field.serialnumber.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Role___hide == null || Role___hide.equals("null") ) {
%>
      <display:column property="role" sortable="true" titleKey="PERouterApplicationResources:field.role.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( AdminState___hide == null || AdminState___hide.equals("null") ) {
%>
      <display:column property="adminstate" sortable="true" titleKey="PERouterApplicationResources:field.adminstate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( LifeCycleState___hide == null || LifeCycleState___hide.equals("null") ) {
%>
      <display:column property="lifecyclestate" sortable="true" titleKey="PERouterApplicationResources:field.lifecyclestate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Backup___hide == null || Backup___hide.equals("null") ) {
%>
      <display:column property="backup" sortable="true" titleKey="PERouterApplicationResources:field.backup.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SchPolicyName___hide == null || SchPolicyName___hide.equals("null") ) {
%>
      <display:column property="schpolicyname" sortable="true" titleKey="PERouterApplicationResources:field.schpolicyname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SkipActivation___hide == null || SkipActivation___hide.equals("null") ) {
%>
      <display:column property="skipactivation" sortable="true" titleKey="PERouterApplicationResources:field.skipactivation.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ROCommunity___hide == null || ROCommunity___hide.equals("null") ) {
%>
      <display:column property="rocommunity" sortable="true" titleKey="PERouterApplicationResources:field.rocommunity.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RWCommunity___hide == null || RWCommunity___hide.equals("null") ) {
%>
      <display:column property="rwcommunity" sortable="true" titleKey="PERouterApplicationResources:field.rwcommunity.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NNMi_UUId___hide == null || NNMi_UUId___hide.equals("null") ) {
%>
      <display:column property="nnmi_uuid" sortable="true" titleKey="PERouterApplicationResources:field.nnmi_uuid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NNMi_Id___hide == null || NNMi_Id___hide.equals("null") ) {
%>
      <display:column property="nnmi_id" sortable="true" titleKey="PERouterApplicationResources:field.nnmi_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NNMi_LastUpdate___hide == null || NNMi_LastUpdate___hide.equals("null") ) {
%>
      <display:column property="nnmi_lastupdate" sortable="true" titleKey="PERouterApplicationResources:field.nnmi_lastupdate.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormPERouterAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="networkid" value="<%= form.getNetworkid() %>"/>
                <html:hidden property="networkid___hide" value="<%= form.getNetworkid___hide() %>"/>
                        <html:hidden property="networkelementid" value="<%= form.getNetworkelementid() %>"/>
                <html:hidden property="networkelementid___hide" value="<%= form.getNetworkelementid___hide() %>"/>
                        <html:hidden property="name" value="<%= form.getName() %>"/>
                <html:hidden property="name___hide" value="<%= form.getName___hide() %>"/>
                        <html:hidden property="description" value="<%= form.getDescription() %>"/>
                <html:hidden property="description___hide" value="<%= form.getDescription___hide() %>"/>
                                            <html:hidden property="location" value="<%= form.getLocation() %>"/>
                <html:hidden property="location___hide" value="<%= form.getLocation___hide() %>"/>
                        <html:hidden property="ip" value="<%= form.getIp() %>"/>
                <html:hidden property="ip___hide" value="<%= form.getIp___hide() %>"/>
                        <html:hidden property="management_ip" value="<%= form.getManagement_ip() %>"/>
                <html:hidden property="management_ip___hide" value="<%= form.getManagement_ip___hide() %>"/>
                        <html:hidden property="managementinterface" value="<%= form.getManagementinterface() %>"/>
                <html:hidden property="managementinterface___hide" value="<%= form.getManagementinterface___hide() %>"/>
                        <html:hidden property="pwpolicyenabled" value="<%= form.getPwpolicyenabled() %>"/>
                <html:hidden property="pwpolicyenabled___hide" value="<%= form.getPwpolicyenabled___hide() %>"/>
                                  <html:hidden property="pwpolicy" value="<%= form.getPwpolicy() %>"/>
                <html:hidden property="pwpolicy___hide" value="<%= form.getPwpolicy___hide() %>"/>
                        <html:hidden property="usernameenabled" value="<%= form.getUsernameenabled() %>"/>
                <html:hidden property="usernameenabled___hide" value="<%= form.getUsernameenabled___hide() %>"/>
                                  <html:hidden property="username" value="<%= form.getUsername() %>"/>
                <html:hidden property="username___hide" value="<%= form.getUsername___hide() %>"/>
                                            <html:hidden property="vendor" value="<%= form.getVendor() %>"/>
                <html:hidden property="vendor___hide" value="<%= form.getVendor___hide() %>"/>
                        <html:hidden property="osversion" value="<%= form.getOsversion() %>"/>
                <html:hidden property="osversion___hide" value="<%= form.getOsversion___hide() %>"/>
                        <html:hidden property="elementtype" value="<%= form.getElementtype() %>"/>
                <html:hidden property="elementtype___hide" value="<%= form.getElementtype___hide() %>"/>
                        <html:hidden property="bgpdiscovery" value="<%= form.getBgpdiscovery() %>"/>
                <html:hidden property="bgpdiscovery___hide" value="<%= form.getBgpdiscovery___hide() %>"/>
                                  <html:hidden property="tier" value="<%= form.getTier() %>"/>
                <html:hidden property="tier___hide" value="<%= form.getTier___hide() %>"/>
                        <html:hidden property="serialnumber" value="<%= form.getSerialnumber() %>"/>
                <html:hidden property="serialnumber___hide" value="<%= form.getSerialnumber___hide() %>"/>
                        <html:hidden property="role" value="<%= form.getRole() %>"/>
                <html:hidden property="role___hide" value="<%= form.getRole___hide() %>"/>
                        <html:hidden property="adminstate" value="<%= form.getAdminstate() %>"/>
                <html:hidden property="adminstate___hide" value="<%= form.getAdminstate___hide() %>"/>
                        <html:hidden property="lifecyclestate" value="<%= form.getLifecyclestate() %>"/>
                <html:hidden property="lifecyclestate___hide" value="<%= form.getLifecyclestate___hide() %>"/>
                        <html:hidden property="backup" value="<%= form.getBackup() %>"/>
                <html:hidden property="backup___hide" value="<%= form.getBackup___hide() %>"/>
                                  <html:hidden property="schpolicyname" value="<%= form.getSchpolicyname() %>"/>
                <html:hidden property="schpolicyname___hide" value="<%= form.getSchpolicyname___hide() %>"/>
                        <html:hidden property="skipactivation" value="<%= form.getSkipactivation() %>"/>
                <html:hidden property="skipactivation___hide" value="<%= form.getSkipactivation___hide() %>"/>
                        <html:hidden property="rocommunity" value="<%= form.getRocommunity() %>"/>
                <html:hidden property="rocommunity___hide" value="<%= form.getRocommunity___hide() %>"/>
                        <html:hidden property="rwcommunity" value="<%= form.getRwcommunity() %>"/>
                <html:hidden property="rwcommunity___hide" value="<%= form.getRwcommunity___hide() %>"/>
                        <html:hidden property="nnmi_uuid" value="<%= form.getNnmi_uuid() %>"/>
                <html:hidden property="nnmi_uuid___hide" value="<%= form.getNnmi_uuid___hide() %>"/>
                        <html:hidden property="nnmi_id" value="<%= form.getNnmi_id() %>"/>
                <html:hidden property="nnmi_id___hide" value="<%= form.getNnmi_id___hide() %>"/>
                        <html:hidden property="nnmi_lastupdate" value="<%= form.getNnmi_lastupdate() %>"/>
                  <html:hidden property="nnmi_lastupdate___" value="<%= form.getNnmi_lastupdate___() %>"/>
                <html:hidden property="nnmi_lastupdate___hide" value="<%= form.getNnmi_lastupdate___hide() %>"/>
                                                                                <%
}
  else {    
%>
                  <html:hidden property="networkid" value="<%= request.getParameter(\"networkid\") %>"/>
                <html:hidden property="networkid___hide" value="<%= request.getParameter(\"networkid___hide\") %>"/>
                        <html:hidden property="networkelementid" value="<%= request.getParameter(\"networkelementid\") %>"/>
                <html:hidden property="networkelementid___hide" value="<%= request.getParameter(\"networkelementid___hide\") %>"/>
                        <html:hidden property="name" value="<%= request.getParameter(\"name\") %>"/>
                <html:hidden property="name___hide" value="<%= request.getParameter(\"name___hide\") %>"/>
                        <html:hidden property="description" value="<%= request.getParameter(\"description\") %>"/>
                <html:hidden property="description___hide" value="<%= request.getParameter(\"description___hide\") %>"/>
                                            <html:hidden property="location" value="<%= request.getParameter(\"location\") %>"/>
                <html:hidden property="location___hide" value="<%= request.getParameter(\"location___hide\") %>"/>
                        <html:hidden property="ip" value="<%= request.getParameter(\"ip\") %>"/>
                <html:hidden property="ip___hide" value="<%= request.getParameter(\"ip___hide\") %>"/>
                        <html:hidden property="management_ip" value="<%= request.getParameter(\"management_ip\") %>"/>
                <html:hidden property="management_ip___hide" value="<%= request.getParameter(\"management_ip___hide\") %>"/>
                        <html:hidden property="managementinterface" value="<%= request.getParameter(\"managementinterface\") %>"/>
                <html:hidden property="managementinterface___hide" value="<%= request.getParameter(\"managementinterface___hide\") %>"/>
                        <html:hidden property="pwpolicyenabled" value="<%= request.getParameter(\"pwpolicyenabled\") %>"/>
                <html:hidden property="pwpolicyenabled___hide" value="<%= request.getParameter(\"pwpolicyenabled___hide\") %>"/>
                                  <html:hidden property="pwpolicy" value="<%= request.getParameter(\"pwpolicy\") %>"/>
                <html:hidden property="pwpolicy___hide" value="<%= request.getParameter(\"pwpolicy___hide\") %>"/>
                        <html:hidden property="usernameenabled" value="<%= request.getParameter(\"usernameenabled\") %>"/>
                <html:hidden property="usernameenabled___hide" value="<%= request.getParameter(\"usernameenabled___hide\") %>"/>
                                  <html:hidden property="username" value="<%= request.getParameter(\"username\") %>"/>
                <html:hidden property="username___hide" value="<%= request.getParameter(\"username___hide\") %>"/>
                                            <html:hidden property="vendor" value="<%= request.getParameter(\"vendor\") %>"/>
                <html:hidden property="vendor___hide" value="<%= request.getParameter(\"vendor___hide\") %>"/>
                        <html:hidden property="osversion" value="<%= request.getParameter(\"osversion\") %>"/>
                <html:hidden property="osversion___hide" value="<%= request.getParameter(\"osversion___hide\") %>"/>
                        <html:hidden property="elementtype" value="<%= request.getParameter(\"elementtype\") %>"/>
                <html:hidden property="elementtype___hide" value="<%= request.getParameter(\"elementtype___hide\") %>"/>
                        <html:hidden property="bgpdiscovery" value="<%= request.getParameter(\"bgpdiscovery\") %>"/>
                <html:hidden property="bgpdiscovery___hide" value="<%= request.getParameter(\"bgpdiscovery___hide\") %>"/>
                                  <html:hidden property="tier" value="<%= request.getParameter(\"tier\") %>"/>
                <html:hidden property="tier___hide" value="<%= request.getParameter(\"tier___hide\") %>"/>
                        <html:hidden property="serialnumber" value="<%= request.getParameter(\"serialnumber\") %>"/>
                <html:hidden property="serialnumber___hide" value="<%= request.getParameter(\"serialnumber___hide\") %>"/>
                        <html:hidden property="role" value="<%= request.getParameter(\"role\") %>"/>
                <html:hidden property="role___hide" value="<%= request.getParameter(\"role___hide\") %>"/>
                        <html:hidden property="adminstate" value="<%= request.getParameter(\"adminstate\") %>"/>
                <html:hidden property="adminstate___hide" value="<%= request.getParameter(\"adminstate___hide\") %>"/>
                        <html:hidden property="lifecyclestate" value="<%= request.getParameter(\"lifecyclestate\") %>"/>
                <html:hidden property="lifecyclestate___hide" value="<%= request.getParameter(\"lifecyclestate___hide\") %>"/>
                        <html:hidden property="backup" value="<%= request.getParameter(\"backup\") %>"/>
                <html:hidden property="backup___hide" value="<%= request.getParameter(\"backup___hide\") %>"/>
                                  <html:hidden property="schpolicyname" value="<%= request.getParameter(\"schpolicyname\") %>"/>
                <html:hidden property="schpolicyname___hide" value="<%= request.getParameter(\"schpolicyname___hide\") %>"/>
                        <html:hidden property="skipactivation" value="<%= request.getParameter(\"skipactivation\") %>"/>
                <html:hidden property="skipactivation___hide" value="<%= request.getParameter(\"skipactivation___hide\") %>"/>
                        <html:hidden property="rocommunity" value="<%= request.getParameter(\"rocommunity\") %>"/>
                <html:hidden property="rocommunity___hide" value="<%= request.getParameter(\"rocommunity___hide\") %>"/>
                        <html:hidden property="rwcommunity" value="<%= request.getParameter(\"rwcommunity\") %>"/>
                <html:hidden property="rwcommunity___hide" value="<%= request.getParameter(\"rwcommunity___hide\") %>"/>
                        <html:hidden property="nnmi_uuid" value="<%= request.getParameter(\"nnmi_uuid\") %>"/>
                <html:hidden property="nnmi_uuid___hide" value="<%= request.getParameter(\"nnmi_uuid___hide\") %>"/>
                        <html:hidden property="nnmi_id" value="<%= request.getParameter(\"nnmi_id\") %>"/>
                <html:hidden property="nnmi_id___hide" value="<%= request.getParameter(\"nnmi_id___hide\") %>"/>
                        <html:hidden property="nnmi_lastupdate" value="<%= request.getParameter(\"nnmi_lastupdate\") %>"/>
                  <html:hidden property="nnmi_lastupdate___" value="<%= request.getParameter(\"nnmi_lastupdate___\") %>"/>
                <html:hidden property="nnmi_lastupdate___hide" value="<%= request.getParameter(\"nnmi_lastupdate___hide\") %>"/>
                                                                                <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.PERouterForm.submit()"/>
  </html:form>

  </body>
</html>
  
