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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(Queue_MessageConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(Queue_MessageConstants.DATASOURCE);
String tabName = request.getParameter(Queue_MessageConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

Queue_MessageForm form = (Queue_MessageForm) request.getAttribute("Queue_MessageForm");


String MessageId___hide = null;
String QueueName___hide = null;
String MessageState___hide = null;
String Destination___hide = null;
String MessageName___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListQueue_Message.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  MessageId___hide = form.getMessageid___hide();
  QueueName___hide = form.getQueuename___hide();
  MessageState___hide = form.getMessagestate___hide();
  Destination___hide = form.getDestination___hide();
  MessageName___hide = form.getMessagename___hide();

  if ( MessageId___hide != null )
    requestURI.append("messageid___hide=" + MessageId___hide);
  if ( QueueName___hide != null )
    requestURI.append("queuename___hide=" + QueueName___hide);
  if ( MessageState___hide != null )
    requestURI.append("messagestate___hide=" + MessageState___hide);
  if ( Destination___hide != null )
    requestURI.append("destination___hide=" + Destination___hide);
  if ( MessageName___hide != null )
    requestURI.append("messagename___hide=" + MessageName___hide);

} else {

    MessageId___hide = request.getParameter("messageid___hide");
    QueueName___hide = request.getParameter("queuename___hide");
    MessageState___hide = request.getParameter("messagestate___hide");
    Destination___hide = request.getParameter("destination___hide");
    MessageName___hide = request.getParameter("messagename___hide");

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
    <title><bean:message bundle="Queue_MessageApplicationResources" key="<%= Queue_MessageConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="Queue_MessageApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitQueue_MessageAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( MessageId___hide == null || MessageId___hide.equals("null") ) {
%>
      <display:column property="messageid" sortable="true" titleKey="Queue_MessageApplicationResources:field.messageid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( QueueName___hide == null || QueueName___hide.equals("null") ) {
%>
      <display:column property="queuename" sortable="true" titleKey="Queue_MessageApplicationResources:field.queuename.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( MessageState___hide == null || MessageState___hide.equals("null") ) {
%>
      <display:column property="messagestate" sortable="true" titleKey="Queue_MessageApplicationResources:field.messagestate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Destination___hide == null || Destination___hide.equals("null") ) {
%>
      <display:column property="destination" sortable="true" titleKey="Queue_MessageApplicationResources:field.destination.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( MessageName___hide == null || MessageName___hide.equals("null") ) {
%>
      <display:column property="messagename" sortable="true" titleKey="Queue_MessageApplicationResources:field.messagename.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormQueue_MessageAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="messageid" value="<%= form.getMessageid() %>"/>
                <html:hidden property="messageid___hide" value="<%= form.getMessageid___hide() %>"/>
                        <html:hidden property="queuename" value="<%= form.getQueuename() %>"/>
                <html:hidden property="queuename___hide" value="<%= form.getQueuename___hide() %>"/>
                        <html:hidden property="messagestate" value="<%= form.getMessagestate() %>"/>
                <html:hidden property="messagestate___hide" value="<%= form.getMessagestate___hide() %>"/>
                        <html:hidden property="destination" value="<%= form.getDestination() %>"/>
                <html:hidden property="destination___hide" value="<%= form.getDestination___hide() %>"/>
                        <html:hidden property="messagename" value="<%= form.getMessagename() %>"/>
                <html:hidden property="messagename___hide" value="<%= form.getMessagename___hide() %>"/>
                    <%
}
  else {    
%>
                  <html:hidden property="messageid" value="<%= request.getParameter(\"messageid\") %>"/>
                <html:hidden property="messageid___hide" value="<%= request.getParameter(\"messageid___hide\") %>"/>
                        <html:hidden property="queuename" value="<%= request.getParameter(\"queuename\") %>"/>
                <html:hidden property="queuename___hide" value="<%= request.getParameter(\"queuename___hide\") %>"/>
                        <html:hidden property="messagestate" value="<%= request.getParameter(\"messagestate\") %>"/>
                <html:hidden property="messagestate___hide" value="<%= request.getParameter(\"messagestate___hide\") %>"/>
                        <html:hidden property="destination" value="<%= request.getParameter(\"destination\") %>"/>
                <html:hidden property="destination___hide" value="<%= request.getParameter(\"destination___hide\") %>"/>
                        <html:hidden property="messagename" value="<%= request.getParameter(\"messagename\") %>"/>
                <html:hidden property="messagename___hide" value="<%= request.getParameter(\"messagename___hide\") %>"/>
                    <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.Queue_MessageForm.submit()"/>
  </html:form>

  </body>
</html>
  
