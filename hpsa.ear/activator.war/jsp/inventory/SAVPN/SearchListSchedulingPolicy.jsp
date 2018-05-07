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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(SchedulingPolicyConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(SchedulingPolicyConstants.DATASOURCE);
String tabName = request.getParameter(SchedulingPolicyConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

SchedulingPolicyForm form = (SchedulingPolicyForm) request.getAttribute("SchedulingPolicyForm");


String SchedulingPolicyName___hide = null;
String StartingTime___hide = null;
String Periodicity___hide = null;
String RefreshInterval___hide = null;
String BackupsNumber___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListSchedulingPolicy.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  SchedulingPolicyName___hide = form.getSchedulingpolicyname___hide();
  StartingTime___hide = form.getStartingtime___hide();
  Periodicity___hide = form.getPeriodicity___hide();
  RefreshInterval___hide = form.getRefreshinterval___hide();
  BackupsNumber___hide = form.getBackupsnumber___hide();

  if ( SchedulingPolicyName___hide != null )
    requestURI.append("schedulingpolicyname___hide=" + SchedulingPolicyName___hide);
  if ( StartingTime___hide != null )
    requestURI.append("startingtime___hide=" + StartingTime___hide);
  if ( Periodicity___hide != null )
    requestURI.append("periodicity___hide=" + Periodicity___hide);
  if ( RefreshInterval___hide != null )
    requestURI.append("refreshinterval___hide=" + RefreshInterval___hide);
  if ( BackupsNumber___hide != null )
    requestURI.append("backupsnumber___hide=" + BackupsNumber___hide);

} else {

    SchedulingPolicyName___hide = request.getParameter("schedulingpolicyname___hide");
    StartingTime___hide = request.getParameter("startingtime___hide");
    Periodicity___hide = request.getParameter("periodicity___hide");
    RefreshInterval___hide = request.getParameter("refreshinterval___hide");
    BackupsNumber___hide = request.getParameter("backupsnumber___hide");

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
    <title><bean:message bundle="SchedulingPolicyApplicationResources" key="<%= SchedulingPolicyConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="SchedulingPolicyApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitSchedulingPolicyAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( SchedulingPolicyName___hide == null || SchedulingPolicyName___hide.equals("null") ) {
%>
      <display:column property="schedulingpolicyname" sortable="true" titleKey="SchedulingPolicyApplicationResources:field.schedulingpolicyname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( StartingTime___hide == null || StartingTime___hide.equals("null") ) {
%>
      <display:column property="startingtime" sortable="true" titleKey="SchedulingPolicyApplicationResources:field.startingtime.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Periodicity___hide == null || Periodicity___hide.equals("null") ) {
%>
      <display:column property="periodicity" sortable="true" titleKey="SchedulingPolicyApplicationResources:field.periodicity.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RefreshInterval___hide == null || RefreshInterval___hide.equals("null") ) {
%>
      <display:column property="refreshinterval" sortable="true" titleKey="SchedulingPolicyApplicationResources:field.refreshinterval.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( BackupsNumber___hide == null || BackupsNumber___hide.equals("null") ) {
%>
      <display:column property="backupsnumber" sortable="true" titleKey="SchedulingPolicyApplicationResources:field.backupsnumber.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormSchedulingPolicyAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="schedulingpolicyname" value="<%= form.getSchedulingpolicyname() %>"/>
                <html:hidden property="schedulingpolicyname___hide" value="<%= form.getSchedulingpolicyname___hide() %>"/>
                        <html:hidden property="startingtime" value="<%= form.getStartingtime() %>"/>
                  <html:hidden property="startingtime___" value="<%= form.getStartingtime___() %>"/>
                <html:hidden property="startingtime___hide" value="<%= form.getStartingtime___hide() %>"/>
                        <html:hidden property="periodicity" value="<%= form.getPeriodicity() %>"/>
                  <html:hidden property="periodicity___" value="<%= form.getPeriodicity___() %>"/>
                <html:hidden property="periodicity___hide" value="<%= form.getPeriodicity___hide() %>"/>
                        <html:hidden property="refreshinterval" value="<%= form.getRefreshinterval() %>"/>
                  <html:hidden property="refreshinterval___" value="<%= form.getRefreshinterval___() %>"/>
                <html:hidden property="refreshinterval___hide" value="<%= form.getRefreshinterval___hide() %>"/>
                        <html:hidden property="backupsnumber" value="<%= form.getBackupsnumber() %>"/>
                  <html:hidden property="backupsnumber___" value="<%= form.getBackupsnumber___() %>"/>
                <html:hidden property="backupsnumber___hide" value="<%= form.getBackupsnumber___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="schedulingpolicyname" value="<%= request.getParameter(\"schedulingpolicyname\") %>"/>
                <html:hidden property="schedulingpolicyname___hide" value="<%= request.getParameter(\"schedulingpolicyname___hide\") %>"/>
                        <html:hidden property="startingtime" value="<%= request.getParameter(\"startingtime\") %>"/>
                  <html:hidden property="startingtime___" value="<%= request.getParameter(\"startingtime___\") %>"/>
                <html:hidden property="startingtime___hide" value="<%= request.getParameter(\"startingtime___hide\") %>"/>
                        <html:hidden property="periodicity" value="<%= request.getParameter(\"periodicity\") %>"/>
                  <html:hidden property="periodicity___" value="<%= request.getParameter(\"periodicity___\") %>"/>
                <html:hidden property="periodicity___hide" value="<%= request.getParameter(\"periodicity___hide\") %>"/>
                        <html:hidden property="refreshinterval" value="<%= request.getParameter(\"refreshinterval\") %>"/>
                  <html:hidden property="refreshinterval___" value="<%= request.getParameter(\"refreshinterval___\") %>"/>
                <html:hidden property="refreshinterval___hide" value="<%= request.getParameter(\"refreshinterval___hide\") %>"/>
                        <html:hidden property="backupsnumber" value="<%= request.getParameter(\"backupsnumber\") %>"/>
                  <html:hidden property="backupsnumber___" value="<%= request.getParameter(\"backupsnumber___\") %>"/>
                <html:hidden property="backupsnumber___hide" value="<%= request.getParameter(\"backupsnumber___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.SchedulingPolicyForm.submit()"/>
  </html:form>

  </body>
</html>
  
