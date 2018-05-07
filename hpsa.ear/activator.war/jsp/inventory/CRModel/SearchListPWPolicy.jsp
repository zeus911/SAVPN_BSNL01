<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        java.lang.reflect.Method,
        com.hp.ov.activator.cr.inventory.*,
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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(PWPolicyConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(PWPolicyConstants.DATASOURCE);
String tabName = request.getParameter(PWPolicyConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

PWPolicyForm form = (PWPolicyForm) request.getAttribute("PWPolicyForm");


String PWPolicyId___hide = null;
String Name___hide = null;
String Description___hide = null;
String UsernameEnabled___hide = null;
String Username___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListPWPolicy.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  PWPolicyId___hide = form.getPwpolicyid___hide();
  Name___hide = form.getName___hide();
  Description___hide = form.getDescription___hide();
  UsernameEnabled___hide = form.getUsernameenabled___hide();
  Username___hide = form.getUsername___hide();

  if ( PWPolicyId___hide != null )
    requestURI.append("pwpolicyid___hide=" + PWPolicyId___hide);
  if ( Name___hide != null )
    requestURI.append("name___hide=" + Name___hide);
  if ( Description___hide != null )
    requestURI.append("description___hide=" + Description___hide);
  if ( UsernameEnabled___hide != null )
    requestURI.append("usernameenabled___hide=" + UsernameEnabled___hide);
  if ( Username___hide != null )
    requestURI.append("username___hide=" + Username___hide);

} else {

    PWPolicyId___hide = request.getParameter("pwpolicyid___hide");
    Name___hide = request.getParameter("name___hide");
    Description___hide = request.getParameter("description___hide");
    UsernameEnabled___hide = request.getParameter("usernameenabled___hide");
    Username___hide = request.getParameter("username___hide");

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
    <title><bean:message bundle="PWPolicyApplicationResources" key="<%= PWPolicyConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="PWPolicyApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitPWPolicyAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( PWPolicyId___hide == null || PWPolicyId___hide.equals("null") ) {
%>
      <display:column property="pwpolicyid" sortable="true" titleKey="PWPolicyApplicationResources:field.pwpolicyid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Name___hide == null || Name___hide.equals("null") ) {
%>
      <display:column property="name" sortable="true" titleKey="PWPolicyApplicationResources:field.name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Description___hide == null || Description___hide.equals("null") ) {
%>
      <display:column property="description" sortable="true" titleKey="PWPolicyApplicationResources:field.description.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UsernameEnabled___hide == null || UsernameEnabled___hide.equals("null") ) {
%>
      <display:column property="usernameenabled" sortable="true" titleKey="PWPolicyApplicationResources:field.usernameenabled.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Username___hide == null || Username___hide.equals("null") ) {
%>
      <display:column property="username" sortable="true" titleKey="PWPolicyApplicationResources:field.username.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormPWPolicyAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="pwpolicyid" value="<%= form.getPwpolicyid() %>"/>
                <html:hidden property="pwpolicyid___hide" value="<%= form.getPwpolicyid___hide() %>"/>
                        <html:hidden property="name" value="<%= form.getName() %>"/>
                <html:hidden property="name___hide" value="<%= form.getName___hide() %>"/>
                        <html:hidden property="description" value="<%= form.getDescription() %>"/>
                <html:hidden property="description___hide" value="<%= form.getDescription___hide() %>"/>
                        <html:hidden property="usernameenabled" value="<%= form.getUsernameenabled() %>"/>
                <html:hidden property="usernameenabled___hide" value="<%= form.getUsernameenabled___hide() %>"/>
                        <html:hidden property="username" value="<%= form.getUsername() %>"/>
                <html:hidden property="username___hide" value="<%= form.getUsername___hide() %>"/>
                              <%
}
  else {    
%>
                  <html:hidden property="pwpolicyid" value="<%= request.getParameter(\"pwpolicyid\") %>"/>
                <html:hidden property="pwpolicyid___hide" value="<%= request.getParameter(\"pwpolicyid___hide\") %>"/>
                        <html:hidden property="name" value="<%= request.getParameter(\"name\") %>"/>
                <html:hidden property="name___hide" value="<%= request.getParameter(\"name___hide\") %>"/>
                        <html:hidden property="description" value="<%= request.getParameter(\"description\") %>"/>
                <html:hidden property="description___hide" value="<%= request.getParameter(\"description___hide\") %>"/>
                        <html:hidden property="usernameenabled" value="<%= request.getParameter(\"usernameenabled\") %>"/>
                <html:hidden property="usernameenabled___hide" value="<%= request.getParameter(\"usernameenabled___hide\") %>"/>
                        <html:hidden property="username" value="<%= request.getParameter(\"username\") %>"/>
                <html:hidden property="username___hide" value="<%= request.getParameter(\"username___hide\") %>"/>
                              <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.PWPolicyForm.submit()"/>
  </html:form>

  </body>
</html>
  
