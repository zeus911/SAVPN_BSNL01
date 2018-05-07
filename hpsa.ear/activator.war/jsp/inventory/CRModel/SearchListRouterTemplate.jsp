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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(RouterTemplateConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(RouterTemplateConstants.DATASOURCE);
String tabName = request.getParameter(RouterTemplateConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

RouterTemplateForm form = (RouterTemplateForm) request.getAttribute("RouterTemplateForm");


String ElementTypeGroupName___hide = null;
String OSVersionGroup___hide = null;
String Name___hide = null;
String Parser___hide = null;
String CLITemplate___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListRouterTemplate.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  ElementTypeGroupName___hide = form.getElementtypegroupname___hide();
  OSVersionGroup___hide = form.getOsversiongroup___hide();
  Name___hide = form.getName___hide();
  Parser___hide = form.getParser___hide();
  CLITemplate___hide = form.getClitemplate___hide();

  if ( ElementTypeGroupName___hide != null )
    requestURI.append("elementtypegroupname___hide=" + ElementTypeGroupName___hide);
  if ( OSVersionGroup___hide != null )
    requestURI.append("osversiongroup___hide=" + OSVersionGroup___hide);
  if ( Name___hide != null )
    requestURI.append("name___hide=" + Name___hide);
  if ( Parser___hide != null )
    requestURI.append("parser___hide=" + Parser___hide);
  if ( CLITemplate___hide != null )
    requestURI.append("clitemplate___hide=" + CLITemplate___hide);

} else {

    ElementTypeGroupName___hide = request.getParameter("elementtypegroupname___hide");
    OSVersionGroup___hide = request.getParameter("osversiongroup___hide");
    Name___hide = request.getParameter("name___hide");
    Parser___hide = request.getParameter("parser___hide");
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
    <title><bean:message bundle="RouterTemplateApplicationResources" key="<%= RouterTemplateConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="RouterTemplateApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitRouterTemplateAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( ElementTypeGroupName___hide == null || ElementTypeGroupName___hide.equals("null") ) {
%>
      <display:column property="elementtypegroupname" sortable="true" titleKey="RouterTemplateApplicationResources:field.elementtypegroupname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( OSVersionGroup___hide == null || OSVersionGroup___hide.equals("null") ) {
%>
      <display:column property="osversiongroup" sortable="true" titleKey="RouterTemplateApplicationResources:field.osversiongroup.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Name___hide == null || Name___hide.equals("null") ) {
%>
      <display:column property="name" sortable="true" titleKey="RouterTemplateApplicationResources:field.name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Parser___hide == null || Parser___hide.equals("null") ) {
%>
      <display:column property="parser" sortable="true" titleKey="RouterTemplateApplicationResources:field.parser.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CLITemplate___hide == null || CLITemplate___hide.equals("null") ) {
%>
      <display:column property="clitemplate" sortable="true" titleKey="RouterTemplateApplicationResources:field.clitemplate.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormRouterTemplateAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="elementtypegroupname" value="<%= form.getElementtypegroupname() %>"/>
                <html:hidden property="elementtypegroupname___hide" value="<%= form.getElementtypegroupname___hide() %>"/>
                        <html:hidden property="osversiongroup" value="<%= form.getOsversiongroup() %>"/>
                <html:hidden property="osversiongroup___hide" value="<%= form.getOsversiongroup___hide() %>"/>
                        <html:hidden property="name" value="<%= form.getName() %>"/>
                <html:hidden property="name___hide" value="<%= form.getName___hide() %>"/>
                        <html:hidden property="parser" value="<%= form.getParser() %>"/>
                <html:hidden property="parser___hide" value="<%= form.getParser___hide() %>"/>
                        <html:hidden property="clitemplate" value="<%= form.getClitemplate() %>"/>
                <html:hidden property="clitemplate___hide" value="<%= form.getClitemplate___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="elementtypegroupname" value="<%= request.getParameter(\"elementtypegroupname\") %>"/>
                <html:hidden property="elementtypegroupname___hide" value="<%= request.getParameter(\"elementtypegroupname___hide\") %>"/>
                        <html:hidden property="osversiongroup" value="<%= request.getParameter(\"osversiongroup\") %>"/>
                <html:hidden property="osversiongroup___hide" value="<%= request.getParameter(\"osversiongroup___hide\") %>"/>
                        <html:hidden property="name" value="<%= request.getParameter(\"name\") %>"/>
                <html:hidden property="name___hide" value="<%= request.getParameter(\"name___hide\") %>"/>
                        <html:hidden property="parser" value="<%= request.getParameter(\"parser\") %>"/>
                <html:hidden property="parser___hide" value="<%= request.getParameter(\"parser___hide\") %>"/>
                        <html:hidden property="clitemplate" value="<%= request.getParameter(\"clitemplate\") %>"/>
                <html:hidden property="clitemplate___hide" value="<%= request.getParameter(\"clitemplate___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.RouterTemplateForm.submit()"/>
  </html:form>

  </body>
</html>
  
