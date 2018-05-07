<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        java.lang.reflect.Method,
        com.hp.ov.activator.nnmi.dl.inventory.*,
        com.hp.ov.activator.inventory.CRModel.*,
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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(DL_NetworkElementConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(DL_NetworkElementConstants.DATASOURCE);
String tabName = request.getParameter(DL_NetworkElementConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

DL_NetworkElementForm form = (DL_NetworkElementForm) request.getAttribute("DL_NetworkElementForm");


String NNMi_Id___hide = null;
String Network___hide = null;
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
String OSVersionGroup___hide = null;
String OSVersion___hide = null;
String ElementTypeGroup___hide = null;
String ElementType___hide = null;
String SerialNumber___hide = null;
String Role___hide = null;
String AdminState___hide = null;
String LifeCycleState___hide = null;
String ROCommunity___hide = null;
String RWCommunity___hide = null;
String NNMi_UUId___hide = null;
String NNMi_LastUpdate___hide = null;
String StateName___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListDL_NetworkElement.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  NNMi_Id___hide = form.getNnmi_id___hide();
  Network___hide = form.getNetwork___hide();
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
  OSVersionGroup___hide = form.getOsversiongroup___hide();
  OSVersion___hide = form.getOsversion___hide();
  ElementTypeGroup___hide = form.getElementtypegroup___hide();
  ElementType___hide = form.getElementtype___hide();
  SerialNumber___hide = form.getSerialnumber___hide();
  Role___hide = form.getRole___hide();
  AdminState___hide = form.getAdminstate___hide();
  LifeCycleState___hide = form.getLifecyclestate___hide();
  ROCommunity___hide = form.getRocommunity___hide();
  RWCommunity___hide = form.getRwcommunity___hide();
  NNMi_UUId___hide = form.getNnmi_uuid___hide();
  NNMi_LastUpdate___hide = form.getNnmi_lastupdate___hide();
  StateName___hide = form.getStatename___hide();

  if ( NNMi_Id___hide != null )
    requestURI.append("nnmi_id___hide=" + NNMi_Id___hide);
  if ( Network___hide != null )
    requestURI.append("network___hide=" + Network___hide);
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
  if ( OSVersionGroup___hide != null )
    requestURI.append("osversiongroup___hide=" + OSVersionGroup___hide);
  if ( OSVersion___hide != null )
    requestURI.append("osversion___hide=" + OSVersion___hide);
  if ( ElementTypeGroup___hide != null )
    requestURI.append("elementtypegroup___hide=" + ElementTypeGroup___hide);
  if ( ElementType___hide != null )
    requestURI.append("elementtype___hide=" + ElementType___hide);
  if ( SerialNumber___hide != null )
    requestURI.append("serialnumber___hide=" + SerialNumber___hide);
  if ( Role___hide != null )
    requestURI.append("role___hide=" + Role___hide);
  if ( AdminState___hide != null )
    requestURI.append("adminstate___hide=" + AdminState___hide);
  if ( LifeCycleState___hide != null )
    requestURI.append("lifecyclestate___hide=" + LifeCycleState___hide);
  if ( ROCommunity___hide != null )
    requestURI.append("rocommunity___hide=" + ROCommunity___hide);
  if ( RWCommunity___hide != null )
    requestURI.append("rwcommunity___hide=" + RWCommunity___hide);
  if ( NNMi_UUId___hide != null )
    requestURI.append("nnmi_uuid___hide=" + NNMi_UUId___hide);
  if ( NNMi_LastUpdate___hide != null )
    requestURI.append("nnmi_lastupdate___hide=" + NNMi_LastUpdate___hide);
  if ( StateName___hide != null )
    requestURI.append("statename___hide=" + StateName___hide);

} else {

    NNMi_Id___hide = request.getParameter("nnmi_id___hide");
    Network___hide = request.getParameter("network___hide");
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
    OSVersionGroup___hide = request.getParameter("osversiongroup___hide");
    OSVersion___hide = request.getParameter("osversion___hide");
    ElementTypeGroup___hide = request.getParameter("elementtypegroup___hide");
    ElementType___hide = request.getParameter("elementtype___hide");
    SerialNumber___hide = request.getParameter("serialnumber___hide");
    Role___hide = request.getParameter("role___hide");
    AdminState___hide = request.getParameter("adminstate___hide");
    LifeCycleState___hide = request.getParameter("lifecyclestate___hide");
    ROCommunity___hide = request.getParameter("rocommunity___hide");
    RWCommunity___hide = request.getParameter("rwcommunity___hide");
    NNMi_UUId___hide = request.getParameter("nnmi_uuid___hide");
    NNMi_LastUpdate___hide = request.getParameter("nnmi_lastupdate___hide");
    StateName___hide = request.getParameter("statename___hide");

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
    <title><bean:message bundle="DL_NetworkElementApplicationResources" key="<%= DL_NetworkElementConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_NetworkElementApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitDL_NetworkElementAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( NNMi_Id___hide == null || NNMi_Id___hide.equals("null") ) {
%>
      <display:column property="nnmi_id" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.nnmi_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Network___hide == null || Network___hide.equals("null") ) {
%>
      <display:column property="network" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.network.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Name___hide == null || Name___hide.equals("null") ) {
%>
      <display:column property="name" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Description___hide == null || Description___hide.equals("null") ) {
%>
      <display:column property="description" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.description.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Location___hide == null || Location___hide.equals("null") ) {
%>
      <display:column property="location" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.location.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IP___hide == null || IP___hide.equals("null") ) {
%>
      <display:column property="ip" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.ip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Management_IP___hide == null || Management_IP___hide.equals("null") ) {
%>
      <display:column property="management_ip" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.management_ip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ManagementInterface___hide == null || ManagementInterface___hide.equals("null") ) {
%>
      <display:column property="managementinterface" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.managementinterface.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PWPolicyEnabled___hide == null || PWPolicyEnabled___hide.equals("null") ) {
%>
      <display:column property="pwpolicyenabled" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.pwpolicyenabled.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PWPolicy___hide == null || PWPolicy___hide.equals("null") ) {
%>
      <display:column property="pwpolicy" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.pwpolicy.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UsernameEnabled___hide == null || UsernameEnabled___hide.equals("null") ) {
%>
      <display:column property="usernameenabled" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.usernameenabled.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Username___hide == null || Username___hide.equals("null") ) {
%>
      <display:column property="username" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.username.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Vendor___hide == null || Vendor___hide.equals("null") ) {
%>
      <display:column property="vendor" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.vendor.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( OSVersionGroup___hide == null || OSVersionGroup___hide.equals("null") ) {
%>
      <display:column property="osversiongroup" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.osversiongroup.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( OSVersion___hide == null || OSVersion___hide.equals("null") ) {
%>
      <display:column property="osversion" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.osversion.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ElementTypeGroup___hide == null || ElementTypeGroup___hide.equals("null") ) {
%>
      <display:column property="elementtypegroup" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.elementtypegroup.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ElementType___hide == null || ElementType___hide.equals("null") ) {
%>
      <display:column property="elementtype" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.elementtype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SerialNumber___hide == null || SerialNumber___hide.equals("null") ) {
%>
      <display:column property="serialnumber" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.serialnumber.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Role___hide == null || Role___hide.equals("null") ) {
%>
      <display:column property="role" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.role.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( AdminState___hide == null || AdminState___hide.equals("null") ) {
%>
      <display:column property="adminstate" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.adminstate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( LifeCycleState___hide == null || LifeCycleState___hide.equals("null") ) {
%>
      <display:column property="lifecyclestate" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.lifecyclestate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ROCommunity___hide == null || ROCommunity___hide.equals("null") ) {
%>
      <display:column property="rocommunity" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.rocommunity.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RWCommunity___hide == null || RWCommunity___hide.equals("null") ) {
%>
      <display:column property="rwcommunity" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.rwcommunity.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NNMi_UUId___hide == null || NNMi_UUId___hide.equals("null") ) {
%>
      <display:column property="nnmi_uuid" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.nnmi_uuid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NNMi_LastUpdate___hide == null || NNMi_LastUpdate___hide.equals("null") ) {
%>
      <display:column property="nnmi_lastupdate" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.nnmi_lastupdate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( StateName___hide == null || StateName___hide.equals("null") ) {
%>
      <display:column property="statename" sortable="true" titleKey="DL_NetworkElementApplicationResources:field.statename.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormDL_NetworkElementAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="nnmi_id" value="<%= form.getNnmi_id() %>"/>
                <html:hidden property="nnmi_id___hide" value="<%= form.getNnmi_id___hide() %>"/>
                        <html:hidden property="network" value="<%= form.getNetwork() %>"/>
                <html:hidden property="network___hide" value="<%= form.getNetwork___hide() %>"/>
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
                        <html:hidden property="osversiongroup" value="<%= form.getOsversiongroup() %>"/>
                <html:hidden property="osversiongroup___hide" value="<%= form.getOsversiongroup___hide() %>"/>
                        <html:hidden property="osversion" value="<%= form.getOsversion() %>"/>
                <html:hidden property="osversion___hide" value="<%= form.getOsversion___hide() %>"/>
                        <html:hidden property="elementtypegroup" value="<%= form.getElementtypegroup() %>"/>
                <html:hidden property="elementtypegroup___hide" value="<%= form.getElementtypegroup___hide() %>"/>
                        <html:hidden property="elementtype" value="<%= form.getElementtype() %>"/>
                <html:hidden property="elementtype___hide" value="<%= form.getElementtype___hide() %>"/>
                        <html:hidden property="serialnumber" value="<%= form.getSerialnumber() %>"/>
                <html:hidden property="serialnumber___hide" value="<%= form.getSerialnumber___hide() %>"/>
                        <html:hidden property="role" value="<%= form.getRole() %>"/>
                <html:hidden property="role___hide" value="<%= form.getRole___hide() %>"/>
                        <html:hidden property="adminstate" value="<%= form.getAdminstate() %>"/>
                <html:hidden property="adminstate___hide" value="<%= form.getAdminstate___hide() %>"/>
                        <html:hidden property="lifecyclestate" value="<%= form.getLifecyclestate() %>"/>
                <html:hidden property="lifecyclestate___hide" value="<%= form.getLifecyclestate___hide() %>"/>
                        <html:hidden property="rocommunity" value="<%= form.getRocommunity() %>"/>
                <html:hidden property="rocommunity___hide" value="<%= form.getRocommunity___hide() %>"/>
                        <html:hidden property="rwcommunity" value="<%= form.getRwcommunity() %>"/>
                <html:hidden property="rwcommunity___hide" value="<%= form.getRwcommunity___hide() %>"/>
                        <html:hidden property="nnmi_uuid" value="<%= form.getNnmi_uuid() %>"/>
                <html:hidden property="nnmi_uuid___hide" value="<%= form.getNnmi_uuid___hide() %>"/>
                        <html:hidden property="nnmi_lastupdate" value="<%= form.getNnmi_lastupdate() %>"/>
                  <html:hidden property="nnmi_lastupdate___" value="<%= form.getNnmi_lastupdate___() %>"/>
                <html:hidden property="nnmi_lastupdate___hide" value="<%= form.getNnmi_lastupdate___hide() %>"/>
                        <html:hidden property="statename" value="<%= form.getStatename() %>"/>
                <html:hidden property="statename___hide" value="<%= form.getStatename___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="nnmi_id" value="<%= request.getParameter(\"nnmi_id\") %>"/>
                <html:hidden property="nnmi_id___hide" value="<%= request.getParameter(\"nnmi_id___hide\") %>"/>
                        <html:hidden property="network" value="<%= request.getParameter(\"network\") %>"/>
                <html:hidden property="network___hide" value="<%= request.getParameter(\"network___hide\") %>"/>
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
                        <html:hidden property="osversiongroup" value="<%= request.getParameter(\"osversiongroup\") %>"/>
                <html:hidden property="osversiongroup___hide" value="<%= request.getParameter(\"osversiongroup___hide\") %>"/>
                        <html:hidden property="osversion" value="<%= request.getParameter(\"osversion\") %>"/>
                <html:hidden property="osversion___hide" value="<%= request.getParameter(\"osversion___hide\") %>"/>
                        <html:hidden property="elementtypegroup" value="<%= request.getParameter(\"elementtypegroup\") %>"/>
                <html:hidden property="elementtypegroup___hide" value="<%= request.getParameter(\"elementtypegroup___hide\") %>"/>
                        <html:hidden property="elementtype" value="<%= request.getParameter(\"elementtype\") %>"/>
                <html:hidden property="elementtype___hide" value="<%= request.getParameter(\"elementtype___hide\") %>"/>
                        <html:hidden property="serialnumber" value="<%= request.getParameter(\"serialnumber\") %>"/>
                <html:hidden property="serialnumber___hide" value="<%= request.getParameter(\"serialnumber___hide\") %>"/>
                        <html:hidden property="role" value="<%= request.getParameter(\"role\") %>"/>
                <html:hidden property="role___hide" value="<%= request.getParameter(\"role___hide\") %>"/>
                        <html:hidden property="adminstate" value="<%= request.getParameter(\"adminstate\") %>"/>
                <html:hidden property="adminstate___hide" value="<%= request.getParameter(\"adminstate___hide\") %>"/>
                        <html:hidden property="lifecyclestate" value="<%= request.getParameter(\"lifecyclestate\") %>"/>
                <html:hidden property="lifecyclestate___hide" value="<%= request.getParameter(\"lifecyclestate___hide\") %>"/>
                        <html:hidden property="rocommunity" value="<%= request.getParameter(\"rocommunity\") %>"/>
                <html:hidden property="rocommunity___hide" value="<%= request.getParameter(\"rocommunity___hide\") %>"/>
                        <html:hidden property="rwcommunity" value="<%= request.getParameter(\"rwcommunity\") %>"/>
                <html:hidden property="rwcommunity___hide" value="<%= request.getParameter(\"rwcommunity___hide\") %>"/>
                        <html:hidden property="nnmi_uuid" value="<%= request.getParameter(\"nnmi_uuid\") %>"/>
                <html:hidden property="nnmi_uuid___hide" value="<%= request.getParameter(\"nnmi_uuid___hide\") %>"/>
                        <html:hidden property="nnmi_lastupdate" value="<%= request.getParameter(\"nnmi_lastupdate\") %>"/>
                  <html:hidden property="nnmi_lastupdate___" value="<%= request.getParameter(\"nnmi_lastupdate___\") %>"/>
                <html:hidden property="nnmi_lastupdate___hide" value="<%= request.getParameter(\"nnmi_lastupdate___hide\") %>"/>
                        <html:hidden property="statename" value="<%= request.getParameter(\"statename\") %>"/>
                <html:hidden property="statename___hide" value="<%= request.getParameter(\"statename___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.DL_NetworkElementForm.submit()"/>
  </html:form>

  </body>
</html>
  
