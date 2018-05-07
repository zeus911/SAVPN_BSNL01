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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(ISPConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(ISPConstants.DATASOURCE);
String tabName = request.getParameter(ISPConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

ISPForm form = (ISPForm) request.getAttribute("ISPForm");


String IDName___hide = null;
String SPName___hide = null;
String IP___hide = null;
String BackupDirectory___hide = null;
String ASN___hide = null;
String AdminVPNEnabled___hide = null;
String ErrorQueue___hide = null;
String NotificationQueue___hide = null;
String ConfirmationQueue___hide = null;
String TimedServiceQueue___hide = null;
String Timeout___hide = null;
String Version___hide = null;
String DemoMode___hide = null;
String NAParentGroupName___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListISP.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  IDName___hide = form.getIdname___hide();
  SPName___hide = form.getSpname___hide();
  IP___hide = form.getIp___hide();
  BackupDirectory___hide = form.getBackupdirectory___hide();
  ASN___hide = form.getAsn___hide();
  AdminVPNEnabled___hide = form.getAdminvpnenabled___hide();
  ErrorQueue___hide = form.getErrorqueue___hide();
  NotificationQueue___hide = form.getNotificationqueue___hide();
  ConfirmationQueue___hide = form.getConfirmationqueue___hide();
  TimedServiceQueue___hide = form.getTimedservicequeue___hide();
  Timeout___hide = form.getTimeout___hide();
  Version___hide = form.getVersion___hide();
  DemoMode___hide = form.getDemomode___hide();
  NAParentGroupName___hide = form.getNaparentgroupname___hide();

  if ( IDName___hide != null )
    requestURI.append("idname___hide=" + IDName___hide);
  if ( SPName___hide != null )
    requestURI.append("spname___hide=" + SPName___hide);
  if ( IP___hide != null )
    requestURI.append("ip___hide=" + IP___hide);
  if ( BackupDirectory___hide != null )
    requestURI.append("backupdirectory___hide=" + BackupDirectory___hide);
  if ( ASN___hide != null )
    requestURI.append("asn___hide=" + ASN___hide);
  if ( AdminVPNEnabled___hide != null )
    requestURI.append("adminvpnenabled___hide=" + AdminVPNEnabled___hide);
  if ( ErrorQueue___hide != null )
    requestURI.append("errorqueue___hide=" + ErrorQueue___hide);
  if ( NotificationQueue___hide != null )
    requestURI.append("notificationqueue___hide=" + NotificationQueue___hide);
  if ( ConfirmationQueue___hide != null )
    requestURI.append("confirmationqueue___hide=" + ConfirmationQueue___hide);
  if ( TimedServiceQueue___hide != null )
    requestURI.append("timedservicequeue___hide=" + TimedServiceQueue___hide);
  if ( Timeout___hide != null )
    requestURI.append("timeout___hide=" + Timeout___hide);
  if ( Version___hide != null )
    requestURI.append("version___hide=" + Version___hide);
  if ( DemoMode___hide != null )
    requestURI.append("demomode___hide=" + DemoMode___hide);
  if ( NAParentGroupName___hide != null )
    requestURI.append("naparentgroupname___hide=" + NAParentGroupName___hide);

} else {

    IDName___hide = request.getParameter("idname___hide");
    SPName___hide = request.getParameter("spname___hide");
    IP___hide = request.getParameter("ip___hide");
    BackupDirectory___hide = request.getParameter("backupdirectory___hide");
    ASN___hide = request.getParameter("asn___hide");
    AdminVPNEnabled___hide = request.getParameter("adminvpnenabled___hide");
    ErrorQueue___hide = request.getParameter("errorqueue___hide");
    NotificationQueue___hide = request.getParameter("notificationqueue___hide");
    ConfirmationQueue___hide = request.getParameter("confirmationqueue___hide");
    TimedServiceQueue___hide = request.getParameter("timedservicequeue___hide");
    Timeout___hide = request.getParameter("timeout___hide");
    Version___hide = request.getParameter("version___hide");
    DemoMode___hide = request.getParameter("demomode___hide");
    NAParentGroupName___hide = request.getParameter("naparentgroupname___hide");

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
    <title><bean:message bundle="ISPApplicationResources" key="<%= ISPConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="ISPApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitISPAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( IDName___hide == null || IDName___hide.equals("null") ) {
%>
      <display:column property="idname" sortable="true" titleKey="ISPApplicationResources:field.idname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SPName___hide == null || SPName___hide.equals("null") ) {
%>
      <display:column property="spname" sortable="true" titleKey="ISPApplicationResources:field.spname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IP___hide == null || IP___hide.equals("null") ) {
%>
      <display:column property="ip" sortable="true" titleKey="ISPApplicationResources:field.ip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( BackupDirectory___hide == null || BackupDirectory___hide.equals("null") ) {
%>
      <display:column property="backupdirectory" sortable="true" titleKey="ISPApplicationResources:field.backupdirectory.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ASN___hide == null || ASN___hide.equals("null") ) {
%>
      <display:column property="asn" sortable="true" titleKey="ISPApplicationResources:field.asn.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( AdminVPNEnabled___hide == null || AdminVPNEnabled___hide.equals("null") ) {
%>
      <display:column property="adminvpnenabled" sortable="true" titleKey="ISPApplicationResources:field.adminvpnenabled.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ErrorQueue___hide == null || ErrorQueue___hide.equals("null") ) {
%>
      <display:column property="errorqueue" sortable="true" titleKey="ISPApplicationResources:field.errorqueue.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NotificationQueue___hide == null || NotificationQueue___hide.equals("null") ) {
%>
      <display:column property="notificationqueue" sortable="true" titleKey="ISPApplicationResources:field.notificationqueue.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ConfirmationQueue___hide == null || ConfirmationQueue___hide.equals("null") ) {
%>
      <display:column property="confirmationqueue" sortable="true" titleKey="ISPApplicationResources:field.confirmationqueue.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( TimedServiceQueue___hide == null || TimedServiceQueue___hide.equals("null") ) {
%>
      <display:column property="timedservicequeue" sortable="true" titleKey="ISPApplicationResources:field.timedservicequeue.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Timeout___hide == null || Timeout___hide.equals("null") ) {
%>
      <display:column property="timeout" sortable="true" titleKey="ISPApplicationResources:field.timeout.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Version___hide == null || Version___hide.equals("null") ) {
%>
      <display:column property="version" sortable="true" titleKey="ISPApplicationResources:field.version.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( DemoMode___hide == null || DemoMode___hide.equals("null") ) {
%>
      <display:column property="demomode" sortable="true" titleKey="ISPApplicationResources:field.demomode.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NAParentGroupName___hide == null || NAParentGroupName___hide.equals("null") ) {
%>
      <display:column property="naparentgroupname" sortable="true" titleKey="ISPApplicationResources:field.naparentgroupname.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormISPAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="idname" value="<%= form.getIdname() %>"/>
                <html:hidden property="idname___hide" value="<%= form.getIdname___hide() %>"/>
                        <html:hidden property="spname" value="<%= form.getSpname() %>"/>
                <html:hidden property="spname___hide" value="<%= form.getSpname___hide() %>"/>
                        <html:hidden property="ip" value="<%= form.getIp() %>"/>
                <html:hidden property="ip___hide" value="<%= form.getIp___hide() %>"/>
                        <html:hidden property="backupdirectory" value="<%= form.getBackupdirectory() %>"/>
                <html:hidden property="backupdirectory___hide" value="<%= form.getBackupdirectory___hide() %>"/>
                        <html:hidden property="asn" value="<%= form.getAsn() %>"/>
                <html:hidden property="asn___hide" value="<%= form.getAsn___hide() %>"/>
                        <html:hidden property="adminvpnenabled" value="<%= form.getAdminvpnenabled() %>"/>
                <html:hidden property="adminvpnenabled___hide" value="<%= form.getAdminvpnenabled___hide() %>"/>
                        <html:hidden property="errorqueue" value="<%= form.getErrorqueue() %>"/>
                <html:hidden property="errorqueue___hide" value="<%= form.getErrorqueue___hide() %>"/>
                        <html:hidden property="notificationqueue" value="<%= form.getNotificationqueue() %>"/>
                <html:hidden property="notificationqueue___hide" value="<%= form.getNotificationqueue___hide() %>"/>
                        <html:hidden property="confirmationqueue" value="<%= form.getConfirmationqueue() %>"/>
                <html:hidden property="confirmationqueue___hide" value="<%= form.getConfirmationqueue___hide() %>"/>
                        <html:hidden property="timedservicequeue" value="<%= form.getTimedservicequeue() %>"/>
                <html:hidden property="timedservicequeue___hide" value="<%= form.getTimedservicequeue___hide() %>"/>
                        <html:hidden property="timeout" value="<%= form.getTimeout() %>"/>
                  <html:hidden property="timeout___" value="<%= form.getTimeout___() %>"/>
                <html:hidden property="timeout___hide" value="<%= form.getTimeout___hide() %>"/>
                        <html:hidden property="version" value="<%= form.getVersion() %>"/>
                <html:hidden property="version___hide" value="<%= form.getVersion___hide() %>"/>
                        <html:hidden property="demomode" value="<%= form.getDemomode() %>"/>
                <html:hidden property="demomode___hide" value="<%= form.getDemomode___hide() %>"/>
                        <html:hidden property="naparentgroupname" value="<%= form.getNaparentgroupname() %>"/>
                <html:hidden property="naparentgroupname___hide" value="<%= form.getNaparentgroupname___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="idname" value="<%= request.getParameter(\"idname\") %>"/>
                <html:hidden property="idname___hide" value="<%= request.getParameter(\"idname___hide\") %>"/>
                        <html:hidden property="spname" value="<%= request.getParameter(\"spname\") %>"/>
                <html:hidden property="spname___hide" value="<%= request.getParameter(\"spname___hide\") %>"/>
                        <html:hidden property="ip" value="<%= request.getParameter(\"ip\") %>"/>
                <html:hidden property="ip___hide" value="<%= request.getParameter(\"ip___hide\") %>"/>
                        <html:hidden property="backupdirectory" value="<%= request.getParameter(\"backupdirectory\") %>"/>
                <html:hidden property="backupdirectory___hide" value="<%= request.getParameter(\"backupdirectory___hide\") %>"/>
                        <html:hidden property="asn" value="<%= request.getParameter(\"asn\") %>"/>
                <html:hidden property="asn___hide" value="<%= request.getParameter(\"asn___hide\") %>"/>
                        <html:hidden property="adminvpnenabled" value="<%= request.getParameter(\"adminvpnenabled\") %>"/>
                <html:hidden property="adminvpnenabled___hide" value="<%= request.getParameter(\"adminvpnenabled___hide\") %>"/>
                        <html:hidden property="errorqueue" value="<%= request.getParameter(\"errorqueue\") %>"/>
                <html:hidden property="errorqueue___hide" value="<%= request.getParameter(\"errorqueue___hide\") %>"/>
                        <html:hidden property="notificationqueue" value="<%= request.getParameter(\"notificationqueue\") %>"/>
                <html:hidden property="notificationqueue___hide" value="<%= request.getParameter(\"notificationqueue___hide\") %>"/>
                        <html:hidden property="confirmationqueue" value="<%= request.getParameter(\"confirmationqueue\") %>"/>
                <html:hidden property="confirmationqueue___hide" value="<%= request.getParameter(\"confirmationqueue___hide\") %>"/>
                        <html:hidden property="timedservicequeue" value="<%= request.getParameter(\"timedservicequeue\") %>"/>
                <html:hidden property="timedservicequeue___hide" value="<%= request.getParameter(\"timedservicequeue___hide\") %>"/>
                        <html:hidden property="timeout" value="<%= request.getParameter(\"timeout\") %>"/>
                  <html:hidden property="timeout___" value="<%= request.getParameter(\"timeout___\") %>"/>
                <html:hidden property="timeout___hide" value="<%= request.getParameter(\"timeout___hide\") %>"/>
                        <html:hidden property="version" value="<%= request.getParameter(\"version\") %>"/>
                <html:hidden property="version___hide" value="<%= request.getParameter(\"version___hide\") %>"/>
                        <html:hidden property="demomode" value="<%= request.getParameter(\"demomode\") %>"/>
                <html:hidden property="demomode___hide" value="<%= request.getParameter(\"demomode___hide\") %>"/>
                        <html:hidden property="naparentgroupname" value="<%= request.getParameter(\"naparentgroupname\") %>"/>
                <html:hidden property="naparentgroupname___hide" value="<%= request.getParameter(\"naparentgroupname___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.ISPForm.submit()"/>
  </html:form>

  </body>
</html>
  
