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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(Sh_CERouterConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(Sh_CERouterConstants.DATASOURCE);
String tabName = request.getParameter(Sh_CERouterConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

Sh_CERouterForm form = (Sh_CERouterForm) request.getAttribute("Sh_CERouterForm");


String NetworkElementID___hide = null;
String NetworkID___hide = null;
String Name___hide = null;
String Description___hide = null;
String Location___hide = null;
String IP___hide = null;
String management_IP___hide = null;
String ManagementInterface___hide = null;
String UsernameEnabled___hide = null;
String Username___hide = null;
String Vendor___hide = null;
String OSversion___hide = null;
String ElementType___hide = null;
String SerialNumber___hide = null;
String Role___hide = null;
String State___hide = null;
String LifeCycleState___hide = null;
String Backup___hide = null;
String SchPolicyName___hide = null;
String ROCommunity___hide = null;
String RWCommunity___hide = null;
String Managed___hide = null;
String Present___hide = null;
String Marker___hide = null;
String UploadStatus___hide = null;
String DBPrimaryKey___hide = null;
String CE_LoopbackPool___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListSh_CERouter.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  NetworkElementID___hide = form.getNetworkelementid___hide();
  NetworkID___hide = form.getNetworkid___hide();
  Name___hide = form.getName___hide();
  Description___hide = form.getDescription___hide();
  Location___hide = form.getLocation___hide();
  IP___hide = form.getIp___hide();
  management_IP___hide = form.getManagement_ip___hide();
  ManagementInterface___hide = form.getManagementinterface___hide();
  UsernameEnabled___hide = form.getUsernameenabled___hide();
  Username___hide = form.getUsername___hide();
  Vendor___hide = form.getVendor___hide();
  OSversion___hide = form.getOsversion___hide();
  ElementType___hide = form.getElementtype___hide();
  SerialNumber___hide = form.getSerialnumber___hide();
  Role___hide = form.getRole___hide();
  State___hide = form.getState___hide();
  LifeCycleState___hide = form.getLifecyclestate___hide();
  Backup___hide = form.getBackup___hide();
  SchPolicyName___hide = form.getSchpolicyname___hide();
  ROCommunity___hide = form.getRocommunity___hide();
  RWCommunity___hide = form.getRwcommunity___hide();
  Managed___hide = form.getManaged___hide();
  Present___hide = form.getPresent___hide();
  Marker___hide = form.getMarker___hide();
  UploadStatus___hide = form.getUploadstatus___hide();
  DBPrimaryKey___hide = form.getDbprimarykey___hide();
  CE_LoopbackPool___hide = form.getCe_loopbackpool___hide();

  if ( NetworkElementID___hide != null )
    requestURI.append("networkelementid___hide=" + NetworkElementID___hide);
  if ( NetworkID___hide != null )
    requestURI.append("networkid___hide=" + NetworkID___hide);
  if ( Name___hide != null )
    requestURI.append("name___hide=" + Name___hide);
  if ( Description___hide != null )
    requestURI.append("description___hide=" + Description___hide);
  if ( Location___hide != null )
    requestURI.append("location___hide=" + Location___hide);
  if ( IP___hide != null )
    requestURI.append("ip___hide=" + IP___hide);
  if ( management_IP___hide != null )
    requestURI.append("management_ip___hide=" + management_IP___hide);
  if ( ManagementInterface___hide != null )
    requestURI.append("managementinterface___hide=" + ManagementInterface___hide);
  if ( UsernameEnabled___hide != null )
    requestURI.append("usernameenabled___hide=" + UsernameEnabled___hide);
  if ( Username___hide != null )
    requestURI.append("username___hide=" + Username___hide);
  if ( Vendor___hide != null )
    requestURI.append("vendor___hide=" + Vendor___hide);
  if ( OSversion___hide != null )
    requestURI.append("osversion___hide=" + OSversion___hide);
  if ( ElementType___hide != null )
    requestURI.append("elementtype___hide=" + ElementType___hide);
  if ( SerialNumber___hide != null )
    requestURI.append("serialnumber___hide=" + SerialNumber___hide);
  if ( Role___hide != null )
    requestURI.append("role___hide=" + Role___hide);
  if ( State___hide != null )
    requestURI.append("state___hide=" + State___hide);
  if ( LifeCycleState___hide != null )
    requestURI.append("lifecyclestate___hide=" + LifeCycleState___hide);
  if ( Backup___hide != null )
    requestURI.append("backup___hide=" + Backup___hide);
  if ( SchPolicyName___hide != null )
    requestURI.append("schpolicyname___hide=" + SchPolicyName___hide);
  if ( ROCommunity___hide != null )
    requestURI.append("rocommunity___hide=" + ROCommunity___hide);
  if ( RWCommunity___hide != null )
    requestURI.append("rwcommunity___hide=" + RWCommunity___hide);
  if ( Managed___hide != null )
    requestURI.append("managed___hide=" + Managed___hide);
  if ( Present___hide != null )
    requestURI.append("present___hide=" + Present___hide);
  if ( Marker___hide != null )
    requestURI.append("marker___hide=" + Marker___hide);
  if ( UploadStatus___hide != null )
    requestURI.append("uploadstatus___hide=" + UploadStatus___hide);
  if ( DBPrimaryKey___hide != null )
    requestURI.append("dbprimarykey___hide=" + DBPrimaryKey___hide);
  if ( CE_LoopbackPool___hide != null )
    requestURI.append("ce_loopbackpool___hide=" + CE_LoopbackPool___hide);

} else {

    NetworkElementID___hide = request.getParameter("networkelementid___hide");
    NetworkID___hide = request.getParameter("networkid___hide");
    Name___hide = request.getParameter("name___hide");
    Description___hide = request.getParameter("description___hide");
    Location___hide = request.getParameter("location___hide");
    IP___hide = request.getParameter("ip___hide");
    management_IP___hide = request.getParameter("management_ip___hide");
    ManagementInterface___hide = request.getParameter("managementinterface___hide");
    UsernameEnabled___hide = request.getParameter("usernameenabled___hide");
    Username___hide = request.getParameter("username___hide");
    Vendor___hide = request.getParameter("vendor___hide");
    OSversion___hide = request.getParameter("osversion___hide");
    ElementType___hide = request.getParameter("elementtype___hide");
    SerialNumber___hide = request.getParameter("serialnumber___hide");
    Role___hide = request.getParameter("role___hide");
    State___hide = request.getParameter("state___hide");
    LifeCycleState___hide = request.getParameter("lifecyclestate___hide");
    Backup___hide = request.getParameter("backup___hide");
    SchPolicyName___hide = request.getParameter("schpolicyname___hide");
    ROCommunity___hide = request.getParameter("rocommunity___hide");
    RWCommunity___hide = request.getParameter("rwcommunity___hide");
    Managed___hide = request.getParameter("managed___hide");
    Present___hide = request.getParameter("present___hide");
    Marker___hide = request.getParameter("marker___hide");
    UploadStatus___hide = request.getParameter("uploadstatus___hide");
    DBPrimaryKey___hide = request.getParameter("dbprimarykey___hide");
    CE_LoopbackPool___hide = request.getParameter("ce_loopbackpool___hide");

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
    <title><bean:message bundle="Sh_CERouterApplicationResources" key="<%= Sh_CERouterConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_CERouterApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitSh_CERouterAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( NetworkElementID___hide == null || NetworkElementID___hide.equals("null") ) {
%>
      <display:column property="networkelementid" sortable="true" titleKey="Sh_CERouterApplicationResources:field.networkelementid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NetworkID___hide == null || NetworkID___hide.equals("null") ) {
%>
      <display:column property="networkid" sortable="true" titleKey="Sh_CERouterApplicationResources:field.networkid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Name___hide == null || Name___hide.equals("null") ) {
%>
      <display:column property="name" sortable="true" titleKey="Sh_CERouterApplicationResources:field.name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Description___hide == null || Description___hide.equals("null") ) {
%>
      <display:column property="description" sortable="true" titleKey="Sh_CERouterApplicationResources:field.description.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Location___hide == null || Location___hide.equals("null") ) {
%>
      <display:column property="location" sortable="true" titleKey="Sh_CERouterApplicationResources:field.location.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IP___hide == null || IP___hide.equals("null") ) {
%>
      <display:column property="ip" sortable="true" titleKey="Sh_CERouterApplicationResources:field.ip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( management_IP___hide == null || management_IP___hide.equals("null") ) {
%>
      <display:column property="management_ip" sortable="true" titleKey="Sh_CERouterApplicationResources:field.management_ip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ManagementInterface___hide == null || ManagementInterface___hide.equals("null") ) {
%>
      <display:column property="managementinterface" sortable="true" titleKey="Sh_CERouterApplicationResources:field.managementinterface.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UsernameEnabled___hide == null || UsernameEnabled___hide.equals("null") ) {
%>
      <display:column property="usernameenabled" sortable="true" titleKey="Sh_CERouterApplicationResources:field.usernameenabled.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Username___hide == null || Username___hide.equals("null") ) {
%>
      <display:column property="username" sortable="true" titleKey="Sh_CERouterApplicationResources:field.username.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Vendor___hide == null || Vendor___hide.equals("null") ) {
%>
      <display:column property="vendor" sortable="true" titleKey="Sh_CERouterApplicationResources:field.vendor.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( OSversion___hide == null || OSversion___hide.equals("null") ) {
%>
      <display:column property="osversion" sortable="true" titleKey="Sh_CERouterApplicationResources:field.osversion.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ElementType___hide == null || ElementType___hide.equals("null") ) {
%>
      <display:column property="elementtype" sortable="true" titleKey="Sh_CERouterApplicationResources:field.elementtype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SerialNumber___hide == null || SerialNumber___hide.equals("null") ) {
%>
      <display:column property="serialnumber" sortable="true" titleKey="Sh_CERouterApplicationResources:field.serialnumber.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Role___hide == null || Role___hide.equals("null") ) {
%>
      <display:column property="role" sortable="true" titleKey="Sh_CERouterApplicationResources:field.role.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( State___hide == null || State___hide.equals("null") ) {
%>
      <display:column property="state" sortable="true" titleKey="Sh_CERouterApplicationResources:field.state.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( LifeCycleState___hide == null || LifeCycleState___hide.equals("null") ) {
%>
      <display:column property="lifecyclestate" sortable="true" titleKey="Sh_CERouterApplicationResources:field.lifecyclestate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Backup___hide == null || Backup___hide.equals("null") ) {
%>
      <display:column property="backup" sortable="true" titleKey="Sh_CERouterApplicationResources:field.backup.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SchPolicyName___hide == null || SchPolicyName___hide.equals("null") ) {
%>
      <display:column property="schpolicyname" sortable="true" titleKey="Sh_CERouterApplicationResources:field.schpolicyname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ROCommunity___hide == null || ROCommunity___hide.equals("null") ) {
%>
      <display:column property="rocommunity" sortable="true" titleKey="Sh_CERouterApplicationResources:field.rocommunity.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RWCommunity___hide == null || RWCommunity___hide.equals("null") ) {
%>
      <display:column property="rwcommunity" sortable="true" titleKey="Sh_CERouterApplicationResources:field.rwcommunity.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Managed___hide == null || Managed___hide.equals("null") ) {
%>
      <display:column property="managed" sortable="true" titleKey="Sh_CERouterApplicationResources:field.managed.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Present___hide == null || Present___hide.equals("null") ) {
%>
      <display:column property="present" sortable="true" titleKey="Sh_CERouterApplicationResources:field.present.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Marker___hide == null || Marker___hide.equals("null") ) {
%>
      <display:column property="marker" sortable="true" titleKey="Sh_CERouterApplicationResources:field.marker.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UploadStatus___hide == null || UploadStatus___hide.equals("null") ) {
%>
      <display:column property="uploadstatus" sortable="true" titleKey="Sh_CERouterApplicationResources:field.uploadstatus.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( DBPrimaryKey___hide == null || DBPrimaryKey___hide.equals("null") ) {
%>
      <display:column property="dbprimarykey" sortable="true" titleKey="Sh_CERouterApplicationResources:field.dbprimarykey.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CE_LoopbackPool___hide == null || CE_LoopbackPool___hide.equals("null") ) {
%>
      <display:column property="ce_loopbackpool" sortable="true" titleKey="Sh_CERouterApplicationResources:field.ce_loopbackpool.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormSh_CERouterAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="networkelementid" value="<%= form.getNetworkelementid() %>"/>
                <html:hidden property="networkelementid___hide" value="<%= form.getNetworkelementid___hide() %>"/>
                        <html:hidden property="networkid" value="<%= form.getNetworkid() %>"/>
                <html:hidden property="networkid___hide" value="<%= form.getNetworkid___hide() %>"/>
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
                        <html:hidden property="serialnumber" value="<%= form.getSerialnumber() %>"/>
                <html:hidden property="serialnumber___hide" value="<%= form.getSerialnumber___hide() %>"/>
                        <html:hidden property="role" value="<%= form.getRole() %>"/>
                <html:hidden property="role___hide" value="<%= form.getRole___hide() %>"/>
                        <html:hidden property="state" value="<%= form.getState() %>"/>
                <html:hidden property="state___hide" value="<%= form.getState___hide() %>"/>
                        <html:hidden property="lifecyclestate" value="<%= form.getLifecyclestate() %>"/>
                <html:hidden property="lifecyclestate___hide" value="<%= form.getLifecyclestate___hide() %>"/>
                        <html:hidden property="backup" value="<%= form.getBackup() %>"/>
                <html:hidden property="backup___hide" value="<%= form.getBackup___hide() %>"/>
                        <html:hidden property="schpolicyname" value="<%= form.getSchpolicyname() %>"/>
                <html:hidden property="schpolicyname___hide" value="<%= form.getSchpolicyname___hide() %>"/>
                        <html:hidden property="rocommunity" value="<%= form.getRocommunity() %>"/>
                <html:hidden property="rocommunity___hide" value="<%= form.getRocommunity___hide() %>"/>
                        <html:hidden property="rwcommunity" value="<%= form.getRwcommunity() %>"/>
                <html:hidden property="rwcommunity___hide" value="<%= form.getRwcommunity___hide() %>"/>
                        <html:hidden property="managed" value="<%= form.getManaged() %>"/>
                <html:hidden property="managed___hide" value="<%= form.getManaged___hide() %>"/>
                        <html:hidden property="present" value="<%= form.getPresent() %>"/>
                <html:hidden property="present___hide" value="<%= form.getPresent___hide() %>"/>
                        <html:hidden property="marker" value="<%= form.getMarker() %>"/>
                <html:hidden property="marker___hide" value="<%= form.getMarker___hide() %>"/>
                        <html:hidden property="uploadstatus" value="<%= form.getUploadstatus() %>"/>
                <html:hidden property="uploadstatus___hide" value="<%= form.getUploadstatus___hide() %>"/>
                        <html:hidden property="dbprimarykey" value="<%= form.getDbprimarykey() %>"/>
                <html:hidden property="dbprimarykey___hide" value="<%= form.getDbprimarykey___hide() %>"/>
                                  <html:hidden property="ce_loopbackpool" value="<%= form.getCe_loopbackpool() %>"/>
                <html:hidden property="ce_loopbackpool___hide" value="<%= form.getCe_loopbackpool___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="networkelementid" value="<%= request.getParameter(\"networkelementid\") %>"/>
                <html:hidden property="networkelementid___hide" value="<%= request.getParameter(\"networkelementid___hide\") %>"/>
                        <html:hidden property="networkid" value="<%= request.getParameter(\"networkid\") %>"/>
                <html:hidden property="networkid___hide" value="<%= request.getParameter(\"networkid___hide\") %>"/>
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
                        <html:hidden property="serialnumber" value="<%= request.getParameter(\"serialnumber\") %>"/>
                <html:hidden property="serialnumber___hide" value="<%= request.getParameter(\"serialnumber___hide\") %>"/>
                        <html:hidden property="role" value="<%= request.getParameter(\"role\") %>"/>
                <html:hidden property="role___hide" value="<%= request.getParameter(\"role___hide\") %>"/>
                        <html:hidden property="state" value="<%= request.getParameter(\"state\") %>"/>
                <html:hidden property="state___hide" value="<%= request.getParameter(\"state___hide\") %>"/>
                        <html:hidden property="lifecyclestate" value="<%= request.getParameter(\"lifecyclestate\") %>"/>
                <html:hidden property="lifecyclestate___hide" value="<%= request.getParameter(\"lifecyclestate___hide\") %>"/>
                        <html:hidden property="backup" value="<%= request.getParameter(\"backup\") %>"/>
                <html:hidden property="backup___hide" value="<%= request.getParameter(\"backup___hide\") %>"/>
                        <html:hidden property="schpolicyname" value="<%= request.getParameter(\"schpolicyname\") %>"/>
                <html:hidden property="schpolicyname___hide" value="<%= request.getParameter(\"schpolicyname___hide\") %>"/>
                        <html:hidden property="rocommunity" value="<%= request.getParameter(\"rocommunity\") %>"/>
                <html:hidden property="rocommunity___hide" value="<%= request.getParameter(\"rocommunity___hide\") %>"/>
                        <html:hidden property="rwcommunity" value="<%= request.getParameter(\"rwcommunity\") %>"/>
                <html:hidden property="rwcommunity___hide" value="<%= request.getParameter(\"rwcommunity___hide\") %>"/>
                        <html:hidden property="managed" value="<%= request.getParameter(\"managed\") %>"/>
                <html:hidden property="managed___hide" value="<%= request.getParameter(\"managed___hide\") %>"/>
                        <html:hidden property="present" value="<%= request.getParameter(\"present\") %>"/>
                <html:hidden property="present___hide" value="<%= request.getParameter(\"present___hide\") %>"/>
                        <html:hidden property="marker" value="<%= request.getParameter(\"marker\") %>"/>
                <html:hidden property="marker___hide" value="<%= request.getParameter(\"marker___hide\") %>"/>
                        <html:hidden property="uploadstatus" value="<%= request.getParameter(\"uploadstatus\") %>"/>
                <html:hidden property="uploadstatus___hide" value="<%= request.getParameter(\"uploadstatus___hide\") %>"/>
                        <html:hidden property="dbprimarykey" value="<%= request.getParameter(\"dbprimarykey\") %>"/>
                <html:hidden property="dbprimarykey___hide" value="<%= request.getParameter(\"dbprimarykey___hide\") %>"/>
                                  <html:hidden property="ce_loopbackpool" value="<%= request.getParameter(\"ce_loopbackpool\") %>"/>
                <html:hidden property="ce_loopbackpool___hide" value="<%= request.getParameter(\"ce_loopbackpool___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.Sh_CERouterForm.submit()"/>
  </html:form>

  </body>
</html>
  
