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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(QueueConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(QueueConstants.DATASOURCE);
String tabName = request.getParameter(QueueConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

QueueForm form = (QueueForm) request.getAttribute("QueueForm");


String Name___hide = null;
String Type___hide = null;
String State___hide = null;
String EmailServer___hide = null;
String NB_Service___hide = null;
String SleepTime___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListQueue.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  Name___hide = form.getName___hide();
  Type___hide = form.getType___hide();
  State___hide = form.getState___hide();
  EmailServer___hide = form.getEmailserver___hide();
  NB_Service___hide = form.getNb_service___hide();
  SleepTime___hide = form.getSleeptime___hide();

  if ( Name___hide != null )
    requestURI.append("name___hide=" + Name___hide);
  if ( Type___hide != null )
    requestURI.append("type___hide=" + Type___hide);
  if ( State___hide != null )
    requestURI.append("state___hide=" + State___hide);
  if ( EmailServer___hide != null )
    requestURI.append("emailserver___hide=" + EmailServer___hide);
  if ( NB_Service___hide != null )
    requestURI.append("nb_service___hide=" + NB_Service___hide);
  if ( SleepTime___hide != null )
    requestURI.append("sleeptime___hide=" + SleepTime___hide);

} else {

    Name___hide = request.getParameter("name___hide");
    Type___hide = request.getParameter("type___hide");
    State___hide = request.getParameter("state___hide");
    EmailServer___hide = request.getParameter("emailserver___hide");
    NB_Service___hide = request.getParameter("nb_service___hide");
    SleepTime___hide = request.getParameter("sleeptime___hide");

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
    <title><bean:message bundle="QueueApplicationResources" key="<%= QueueConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="QueueApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitQueueAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( Name___hide == null || Name___hide.equals("null") ) {
%>
      <display:column property="name" sortable="true" titleKey="QueueApplicationResources:field.name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Type___hide == null || Type___hide.equals("null") ) {
%>
      <display:column property="type" sortable="true" titleKey="QueueApplicationResources:field.type.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( State___hide == null || State___hide.equals("null") ) {
%>
      <display:column property="state" sortable="true" titleKey="QueueApplicationResources:field.state.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( EmailServer___hide == null || EmailServer___hide.equals("null") ) {
%>
      <display:column property="emailserver" sortable="true" titleKey="QueueApplicationResources:field.emailserver.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NB_Service___hide == null || NB_Service___hide.equals("null") ) {
%>
      <display:column property="nb_service" sortable="true" titleKey="QueueApplicationResources:field.nb_service.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SleepTime___hide == null || SleepTime___hide.equals("null") ) {
%>
      <display:column property="sleeptime" sortable="true" titleKey="QueueApplicationResources:field.sleeptime.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormQueueAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="name" value="<%= form.getName() %>"/>
                <html:hidden property="name___hide" value="<%= form.getName___hide() %>"/>
                        <html:hidden property="type" value="<%= form.getType() %>"/>
                <html:hidden property="type___hide" value="<%= form.getType___hide() %>"/>
                        <html:hidden property="state" value="<%= form.getState() %>"/>
                <html:hidden property="state___hide" value="<%= form.getState___hide() %>"/>
                        <html:hidden property="emailserver" value="<%= form.getEmailserver() %>"/>
                <html:hidden property="emailserver___hide" value="<%= form.getEmailserver___hide() %>"/>
                        <html:hidden property="nb_service" value="<%= form.getNb_service() %>"/>
                <html:hidden property="nb_service___hide" value="<%= form.getNb_service___hide() %>"/>
                        <html:hidden property="sleeptime" value="<%= form.getSleeptime() %>"/>
                  <html:hidden property="sleeptime___" value="<%= form.getSleeptime___() %>"/>
                <html:hidden property="sleeptime___hide" value="<%= form.getSleeptime___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="name" value="<%= request.getParameter(\"name\") %>"/>
                <html:hidden property="name___hide" value="<%= request.getParameter(\"name___hide\") %>"/>
                        <html:hidden property="type" value="<%= request.getParameter(\"type\") %>"/>
                <html:hidden property="type___hide" value="<%= request.getParameter(\"type___hide\") %>"/>
                        <html:hidden property="state" value="<%= request.getParameter(\"state\") %>"/>
                <html:hidden property="state___hide" value="<%= request.getParameter(\"state___hide\") %>"/>
                        <html:hidden property="emailserver" value="<%= request.getParameter(\"emailserver\") %>"/>
                <html:hidden property="emailserver___hide" value="<%= request.getParameter(\"emailserver___hide\") %>"/>
                        <html:hidden property="nb_service" value="<%= request.getParameter(\"nb_service\") %>"/>
                <html:hidden property="nb_service___hide" value="<%= request.getParameter(\"nb_service___hide\") %>"/>
                        <html:hidden property="sleeptime" value="<%= request.getParameter(\"sleeptime\") %>"/>
                  <html:hidden property="sleeptime___" value="<%= request.getParameter(\"sleeptime___\") %>"/>
                <html:hidden property="sleeptime___hide" value="<%= request.getParameter(\"sleeptime___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.QueueForm.submit()"/>
  </html:form>

  </body>
</html>
  
