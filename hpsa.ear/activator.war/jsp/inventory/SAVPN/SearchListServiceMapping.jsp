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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(ServiceMappingConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(ServiceMappingConstants.DATASOURCE);
String tabName = request.getParameter(ServiceMappingConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

ServiceMappingForm form = (ServiceMappingForm) request.getAttribute("ServiceMappingForm");


String actionName___hide = null;
String service_name___hide = null;
String workflow_name___hide = null;
String autoundo___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListServiceMapping.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  actionName___hide = form.getActionname___hide();
  service_name___hide = form.getService_name___hide();
  workflow_name___hide = form.getWorkflow_name___hide();
  autoundo___hide = form.getAutoundo___hide();

  if ( actionName___hide != null )
    requestURI.append("actionname___hide=" + actionName___hide);
  if ( service_name___hide != null )
    requestURI.append("service_name___hide=" + service_name___hide);
  if ( workflow_name___hide != null )
    requestURI.append("workflow_name___hide=" + workflow_name___hide);
  if ( autoundo___hide != null )
    requestURI.append("autoundo___hide=" + autoundo___hide);

} else {

    actionName___hide = request.getParameter("actionname___hide");
    service_name___hide = request.getParameter("service_name___hide");
    workflow_name___hide = request.getParameter("workflow_name___hide");
    autoundo___hide = request.getParameter("autoundo___hide");

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
    <title><bean:message bundle="ServiceMappingApplicationResources" key="<%= ServiceMappingConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="ServiceMappingApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitServiceMappingAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( actionName___hide == null || actionName___hide.equals("null") ) {
%>
      <display:column property="actionname" sortable="true" titleKey="ServiceMappingApplicationResources:field.actionname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( service_name___hide == null || service_name___hide.equals("null") ) {
%>
      <display:column property="service_name" sortable="true" titleKey="ServiceMappingApplicationResources:field.service_name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( workflow_name___hide == null || workflow_name___hide.equals("null") ) {
%>
      <display:column property="workflow_name" sortable="true" titleKey="ServiceMappingApplicationResources:field.workflow_name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( autoundo___hide == null || autoundo___hide.equals("null") ) {
%>
      <display:column property="autoundo" sortable="true" titleKey="ServiceMappingApplicationResources:field.autoundo.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormServiceMappingAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="actionname" value="<%= form.getActionname() %>"/>
                <html:hidden property="actionname___hide" value="<%= form.getActionname___hide() %>"/>
                        <html:hidden property="service_name" value="<%= form.getService_name() %>"/>
                <html:hidden property="service_name___hide" value="<%= form.getService_name___hide() %>"/>
                        <html:hidden property="workflow_name" value="<%= form.getWorkflow_name() %>"/>
                <html:hidden property="workflow_name___hide" value="<%= form.getWorkflow_name___hide() %>"/>
                        <html:hidden property="autoundo" value="<%= form.getAutoundo() %>"/>
                <html:hidden property="autoundo___hide" value="<%= form.getAutoundo___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="actionname" value="<%= request.getParameter(\"actionname\") %>"/>
                <html:hidden property="actionname___hide" value="<%= request.getParameter(\"actionname___hide\") %>"/>
                        <html:hidden property="service_name" value="<%= request.getParameter(\"service_name\") %>"/>
                <html:hidden property="service_name___hide" value="<%= request.getParameter(\"service_name___hide\") %>"/>
                        <html:hidden property="workflow_name" value="<%= request.getParameter(\"workflow_name\") %>"/>
                <html:hidden property="workflow_name___hide" value="<%= request.getParameter(\"workflow_name___hide\") %>"/>
                        <html:hidden property="autoundo" value="<%= request.getParameter(\"autoundo\") %>"/>
                <html:hidden property="autoundo___hide" value="<%= request.getParameter(\"autoundo___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.ServiceMappingForm.submit()"/>
  </html:form>

  </body>
</html>
  
