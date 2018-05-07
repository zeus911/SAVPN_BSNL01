<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        java.lang.reflect.Method,
        com.hp.ov.activator.cr.common.ifaceupload.*,
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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(IfaceUploadConfigurationConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(IfaceUploadConfigurationConstants.DATASOURCE);
String tabName = request.getParameter(IfaceUploadConfigurationConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

IfaceUploadConfigurationForm form = (IfaceUploadConfigurationForm) request.getAttribute("IfaceUploadConfigurationForm");


String Id___hide = null;
String Demo_mode___hide = null;
String Message_queue___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListIfaceUploadConfiguration.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  Id___hide = form.getId___hide();
  Demo_mode___hide = form.getDemo_mode___hide();
  Message_queue___hide = form.getMessage_queue___hide();

  if ( Id___hide != null )
    requestURI.append("id___hide=" + Id___hide);
  if ( Demo_mode___hide != null )
    requestURI.append("demo_mode___hide=" + Demo_mode___hide);
  if ( Message_queue___hide != null )
    requestURI.append("message_queue___hide=" + Message_queue___hide);

} else {

    Id___hide = request.getParameter("id___hide");
    Demo_mode___hide = request.getParameter("demo_mode___hide");
    Message_queue___hide = request.getParameter("message_queue___hide");

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
    <title><bean:message bundle="IfaceUploadConfigurationApplicationResources" key="<%= IfaceUploadConfigurationConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="IfaceUploadConfigurationApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitIfaceUploadConfigurationAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( Id___hide == null || Id___hide.equals("null") ) {
%>
      <display:column property="id" sortable="true" titleKey="IfaceUploadConfigurationApplicationResources:field.id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Demo_mode___hide == null || Demo_mode___hide.equals("null") ) {
%>
      <display:column property="demo_mode" sortable="true" titleKey="IfaceUploadConfigurationApplicationResources:field.demo_mode.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Message_queue___hide == null || Message_queue___hide.equals("null") ) {
%>
      <display:column property="message_queue" sortable="true" titleKey="IfaceUploadConfigurationApplicationResources:field.message_queue.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormIfaceUploadConfigurationAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="id" value="<%= form.getId() %>"/>
                <html:hidden property="id___hide" value="<%= form.getId___hide() %>"/>
                        <html:hidden property="demo_mode" value="<%= form.getDemo_mode() %>"/>
                <html:hidden property="demo_mode___hide" value="<%= form.getDemo_mode___hide() %>"/>
                        <html:hidden property="message_queue" value="<%= form.getMessage_queue() %>"/>
                <html:hidden property="message_queue___hide" value="<%= form.getMessage_queue___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="id" value="<%= request.getParameter(\"id\") %>"/>
                <html:hidden property="id___hide" value="<%= request.getParameter(\"id___hide\") %>"/>
                        <html:hidden property="demo_mode" value="<%= request.getParameter(\"demo_mode\") %>"/>
                <html:hidden property="demo_mode___hide" value="<%= request.getParameter(\"demo_mode___hide\") %>"/>
                        <html:hidden property="message_queue" value="<%= request.getParameter(\"message_queue\") %>"/>
                <html:hidden property="message_queue___hide" value="<%= request.getParameter(\"message_queue___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.IfaceUploadConfigurationForm.submit()"/>
  </html:form>

  </body>
</html>
  
