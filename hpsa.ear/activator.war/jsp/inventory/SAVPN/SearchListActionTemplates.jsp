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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(ActionTemplatesConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(ActionTemplatesConstants.DATASOURCE);
String tabName = request.getParameter(ActionTemplatesConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

ActionTemplatesForm form = (ActionTemplatesForm) request.getAttribute("ActionTemplatesForm");


String ElementType___hide = null;
String OSversion___hide = null;
String Role___hide = null;
String ActivationName___hide = null;
String CLITemplate___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListActionTemplates.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  ElementType___hide = form.getElementtype___hide();
  OSversion___hide = form.getOsversion___hide();
  Role___hide = form.getRole___hide();
  ActivationName___hide = form.getActivationname___hide();
  CLITemplate___hide = form.getClitemplate___hide();

  if ( ElementType___hide != null )
    requestURI.append("elementtype___hide=" + ElementType___hide);
  if ( OSversion___hide != null )
    requestURI.append("osversion___hide=" + OSversion___hide);
  if ( Role___hide != null )
    requestURI.append("role___hide=" + Role___hide);
  if ( ActivationName___hide != null )
    requestURI.append("activationname___hide=" + ActivationName___hide);
  if ( CLITemplate___hide != null )
    requestURI.append("clitemplate___hide=" + CLITemplate___hide);

} else {

    ElementType___hide = request.getParameter("elementtype___hide");
    OSversion___hide = request.getParameter("osversion___hide");
    Role___hide = request.getParameter("role___hide");
    ActivationName___hide = request.getParameter("activationname___hide");
    CLITemplate___hide = request.getParameter("clitemplate___hide");

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
    <title><bean:message bundle="ActionTemplatesApplicationResources" key="<%= ActionTemplatesConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="ActionTemplatesApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitActionTemplatesAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( ElementType___hide == null || ElementType___hide.equals("null") ) {
%>
      <display:column property="elementtype" sortable="true" titleKey="ActionTemplatesApplicationResources:field.elementtype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( OSversion___hide == null || OSversion___hide.equals("null") ) {
%>
      <display:column property="osversion" sortable="true" titleKey="ActionTemplatesApplicationResources:field.osversion.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Role___hide == null || Role___hide.equals("null") ) {
%>
      <display:column property="role" sortable="true" titleKey="ActionTemplatesApplicationResources:field.role.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ActivationName___hide == null || ActivationName___hide.equals("null") ) {
%>
      <display:column property="activationname" sortable="true" titleKey="ActionTemplatesApplicationResources:field.activationname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CLITemplate___hide == null || CLITemplate___hide.equals("null") ) {
%>
      <display:column property="clitemplate" sortable="true" titleKey="ActionTemplatesApplicationResources:field.clitemplate.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormActionTemplatesAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="elementtype" value="<%= form.getElementtype() %>"/>
                <html:hidden property="elementtype___hide" value="<%= form.getElementtype___hide() %>"/>
                        <html:hidden property="osversion" value="<%= form.getOsversion() %>"/>
                <html:hidden property="osversion___hide" value="<%= form.getOsversion___hide() %>"/>
                        <html:hidden property="role" value="<%= form.getRole() %>"/>
                <html:hidden property="role___hide" value="<%= form.getRole___hide() %>"/>
                        <html:hidden property="activationname" value="<%= form.getActivationname() %>"/>
                <html:hidden property="activationname___hide" value="<%= form.getActivationname___hide() %>"/>
                        <html:hidden property="clitemplate" value="<%= form.getClitemplate() %>"/>
                <html:hidden property="clitemplate___hide" value="<%= form.getClitemplate___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="elementtype" value="<%= request.getParameter(\"elementtype\") %>"/>
                <html:hidden property="elementtype___hide" value="<%= request.getParameter(\"elementtype___hide\") %>"/>
                        <html:hidden property="osversion" value="<%= request.getParameter(\"osversion\") %>"/>
                <html:hidden property="osversion___hide" value="<%= request.getParameter(\"osversion___hide\") %>"/>
                        <html:hidden property="role" value="<%= request.getParameter(\"role\") %>"/>
                <html:hidden property="role___hide" value="<%= request.getParameter(\"role___hide\") %>"/>
                        <html:hidden property="activationname" value="<%= request.getParameter(\"activationname\") %>"/>
                <html:hidden property="activationname___hide" value="<%= request.getParameter(\"activationname___hide\") %>"/>
                        <html:hidden property="clitemplate" value="<%= request.getParameter(\"clitemplate\") %>"/>
                <html:hidden property="clitemplate___hide" value="<%= request.getParameter(\"clitemplate___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.ActionTemplatesForm.submit()"/>
  </html:form>

  </body>
</html>
  
