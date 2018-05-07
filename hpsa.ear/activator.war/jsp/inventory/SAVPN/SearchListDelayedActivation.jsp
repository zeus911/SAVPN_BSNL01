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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(DelayedActivationConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(DelayedActivationConstants.DATASOURCE);
String tabName = request.getParameter(DelayedActivationConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

DelayedActivationForm form = (DelayedActivationForm) request.getAttribute("DelayedActivationForm");


String DAName___hide = null;
String NumberOfRetries___hide = null;
String Days___hide = null;
String Hours___hide = null;
String Minutes___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListDelayedActivation.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  DAName___hide = form.getDaname___hide();
  NumberOfRetries___hide = form.getNumberofretries___hide();
  Days___hide = form.getDays___hide();
  Hours___hide = form.getHours___hide();
  Minutes___hide = form.getMinutes___hide();

  if ( DAName___hide != null )
    requestURI.append("daname___hide=" + DAName___hide);
  if ( NumberOfRetries___hide != null )
    requestURI.append("numberofretries___hide=" + NumberOfRetries___hide);
  if ( Days___hide != null )
    requestURI.append("days___hide=" + Days___hide);
  if ( Hours___hide != null )
    requestURI.append("hours___hide=" + Hours___hide);
  if ( Minutes___hide != null )
    requestURI.append("minutes___hide=" + Minutes___hide);

} else {

    DAName___hide = request.getParameter("daname___hide");
    NumberOfRetries___hide = request.getParameter("numberofretries___hide");
    Days___hide = request.getParameter("days___hide");
    Hours___hide = request.getParameter("hours___hide");
    Minutes___hide = request.getParameter("minutes___hide");

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
    <title><bean:message bundle="DelayedActivationApplicationResources" key="<%= DelayedActivationConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="DelayedActivationApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitDelayedActivationAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( DAName___hide == null || DAName___hide.equals("null") ) {
%>
      <display:column property="daname" sortable="true" titleKey="DelayedActivationApplicationResources:field.daname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NumberOfRetries___hide == null || NumberOfRetries___hide.equals("null") ) {
%>
      <display:column property="numberofretries" sortable="true" titleKey="DelayedActivationApplicationResources:field.numberofretries.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Days___hide == null || Days___hide.equals("null") ) {
%>
      <display:column property="days" sortable="true" titleKey="DelayedActivationApplicationResources:field.days.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Hours___hide == null || Hours___hide.equals("null") ) {
%>
      <display:column property="hours" sortable="true" titleKey="DelayedActivationApplicationResources:field.hours.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Minutes___hide == null || Minutes___hide.equals("null") ) {
%>
      <display:column property="minutes" sortable="true" titleKey="DelayedActivationApplicationResources:field.minutes.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormDelayedActivationAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="daname" value="<%= form.getDaname() %>"/>
                <html:hidden property="daname___hide" value="<%= form.getDaname___hide() %>"/>
                        <html:hidden property="numberofretries" value="<%= form.getNumberofretries() %>"/>
                  <html:hidden property="numberofretries___" value="<%= form.getNumberofretries___() %>"/>
                <html:hidden property="numberofretries___hide" value="<%= form.getNumberofretries___hide() %>"/>
                        <html:hidden property="days" value="<%= form.getDays() %>"/>
                  <html:hidden property="days___" value="<%= form.getDays___() %>"/>
                <html:hidden property="days___hide" value="<%= form.getDays___hide() %>"/>
                        <html:hidden property="hours" value="<%= form.getHours() %>"/>
                  <html:hidden property="hours___" value="<%= form.getHours___() %>"/>
                <html:hidden property="hours___hide" value="<%= form.getHours___hide() %>"/>
                        <html:hidden property="minutes" value="<%= form.getMinutes() %>"/>
                  <html:hidden property="minutes___" value="<%= form.getMinutes___() %>"/>
                <html:hidden property="minutes___hide" value="<%= form.getMinutes___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="daname" value="<%= request.getParameter(\"daname\") %>"/>
                <html:hidden property="daname___hide" value="<%= request.getParameter(\"daname___hide\") %>"/>
                        <html:hidden property="numberofretries" value="<%= request.getParameter(\"numberofretries\") %>"/>
                  <html:hidden property="numberofretries___" value="<%= request.getParameter(\"numberofretries___\") %>"/>
                <html:hidden property="numberofretries___hide" value="<%= request.getParameter(\"numberofretries___hide\") %>"/>
                        <html:hidden property="days" value="<%= request.getParameter(\"days\") %>"/>
                  <html:hidden property="days___" value="<%= request.getParameter(\"days___\") %>"/>
                <html:hidden property="days___hide" value="<%= request.getParameter(\"days___hide\") %>"/>
                        <html:hidden property="hours" value="<%= request.getParameter(\"hours\") %>"/>
                  <html:hidden property="hours___" value="<%= request.getParameter(\"hours___\") %>"/>
                <html:hidden property="hours___hide" value="<%= request.getParameter(\"hours___hide\") %>"/>
                        <html:hidden property="minutes" value="<%= request.getParameter(\"minutes\") %>"/>
                  <html:hidden property="minutes___" value="<%= request.getParameter(\"minutes___\") %>"/>
                <html:hidden property="minutes___hide" value="<%= request.getParameter(\"minutes___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.DelayedActivationForm.submit()"/>
  </html:form>

  </body>
</html>
  
