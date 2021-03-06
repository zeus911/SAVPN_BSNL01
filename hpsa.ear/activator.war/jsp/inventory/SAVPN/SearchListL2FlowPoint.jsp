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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(L2FlowPointConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(L2FlowPointConstants.DATASOURCE);
String tabName = request.getParameter(L2FlowPointConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

L2FlowPointForm form = (L2FlowPointForm) request.getAttribute("L2FlowPointForm");


String TerminationPointId___hide = null;
String AttachmentId___hide = null;
String QoSProfile_in___hide = null;
String QoSProfile_out___hide = null;
String RateLimit_in___hide = null;
String RateLimit_out___hide = null;
String UsageMode___hide = null;
String ConnectionId___hide = null;
String Facing___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListL2FlowPoint.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  TerminationPointId___hide = form.getTerminationpointid___hide();
  AttachmentId___hide = form.getAttachmentid___hide();
  QoSProfile_in___hide = form.getQosprofile_in___hide();
  QoSProfile_out___hide = form.getQosprofile_out___hide();
  RateLimit_in___hide = form.getRatelimit_in___hide();
  RateLimit_out___hide = form.getRatelimit_out___hide();
  UsageMode___hide = form.getUsagemode___hide();
  ConnectionId___hide = form.getConnectionid___hide();
  Facing___hide = form.getFacing___hide();

  if ( TerminationPointId___hide != null )
    requestURI.append("terminationpointid___hide=" + TerminationPointId___hide);
  if ( AttachmentId___hide != null )
    requestURI.append("attachmentid___hide=" + AttachmentId___hide);
  if ( QoSProfile_in___hide != null )
    requestURI.append("qosprofile_in___hide=" + QoSProfile_in___hide);
  if ( QoSProfile_out___hide != null )
    requestURI.append("qosprofile_out___hide=" + QoSProfile_out___hide);
  if ( RateLimit_in___hide != null )
    requestURI.append("ratelimit_in___hide=" + RateLimit_in___hide);
  if ( RateLimit_out___hide != null )
    requestURI.append("ratelimit_out___hide=" + RateLimit_out___hide);
  if ( UsageMode___hide != null )
    requestURI.append("usagemode___hide=" + UsageMode___hide);
  if ( ConnectionId___hide != null )
    requestURI.append("connectionid___hide=" + ConnectionId___hide);
  if ( Facing___hide != null )
    requestURI.append("facing___hide=" + Facing___hide);

} else {

    TerminationPointId___hide = request.getParameter("terminationpointid___hide");
    AttachmentId___hide = request.getParameter("attachmentid___hide");
    QoSProfile_in___hide = request.getParameter("qosprofile_in___hide");
    QoSProfile_out___hide = request.getParameter("qosprofile_out___hide");
    RateLimit_in___hide = request.getParameter("ratelimit_in___hide");
    RateLimit_out___hide = request.getParameter("ratelimit_out___hide");
    UsageMode___hide = request.getParameter("usagemode___hide");
    ConnectionId___hide = request.getParameter("connectionid___hide");
    Facing___hide = request.getParameter("facing___hide");

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
    <title><bean:message bundle="L2FlowPointApplicationResources" key="<%= L2FlowPointConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="L2FlowPointApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitL2FlowPointAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( TerminationPointId___hide == null || TerminationPointId___hide.equals("null") ) {
%>
      <display:column property="terminationpointid" sortable="true" titleKey="L2FlowPointApplicationResources:field.terminationpointid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( AttachmentId___hide == null || AttachmentId___hide.equals("null") ) {
%>
      <display:column property="attachmentid" sortable="true" titleKey="L2FlowPointApplicationResources:field.attachmentid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( QoSProfile_in___hide == null || QoSProfile_in___hide.equals("null") ) {
%>
      <display:column property="qosprofile_in" sortable="true" titleKey="L2FlowPointApplicationResources:field.qosprofile_in.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( QoSProfile_out___hide == null || QoSProfile_out___hide.equals("null") ) {
%>
      <display:column property="qosprofile_out" sortable="true" titleKey="L2FlowPointApplicationResources:field.qosprofile_out.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RateLimit_in___hide == null || RateLimit_in___hide.equals("null") ) {
%>
      <display:column property="ratelimit_in" sortable="true" titleKey="L2FlowPointApplicationResources:field.ratelimit_in.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RateLimit_out___hide == null || RateLimit_out___hide.equals("null") ) {
%>
      <display:column property="ratelimit_out" sortable="true" titleKey="L2FlowPointApplicationResources:field.ratelimit_out.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UsageMode___hide == null || UsageMode___hide.equals("null") ) {
%>
      <display:column property="usagemode" sortable="true" titleKey="L2FlowPointApplicationResources:field.usagemode.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ConnectionId___hide == null || ConnectionId___hide.equals("null") ) {
%>
      <display:column property="connectionid" sortable="true" titleKey="L2FlowPointApplicationResources:field.connectionid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Facing___hide == null || Facing___hide.equals("null") ) {
%>
      <display:column property="facing" sortable="true" titleKey="L2FlowPointApplicationResources:field.facing.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormL2FlowPointAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="terminationpointid" value="<%= form.getTerminationpointid() %>"/>
                <html:hidden property="terminationpointid___hide" value="<%= form.getTerminationpointid___hide() %>"/>
                        <html:hidden property="attachmentid" value="<%= form.getAttachmentid() %>"/>
                <html:hidden property="attachmentid___hide" value="<%= form.getAttachmentid___hide() %>"/>
                        <html:hidden property="qosprofile_in" value="<%= form.getQosprofile_in() %>"/>
                <html:hidden property="qosprofile_in___hide" value="<%= form.getQosprofile_in___hide() %>"/>
                        <html:hidden property="qosprofile_out" value="<%= form.getQosprofile_out() %>"/>
                <html:hidden property="qosprofile_out___hide" value="<%= form.getQosprofile_out___hide() %>"/>
                        <html:hidden property="ratelimit_in" value="<%= form.getRatelimit_in() %>"/>
                <html:hidden property="ratelimit_in___hide" value="<%= form.getRatelimit_in___hide() %>"/>
                        <html:hidden property="ratelimit_out" value="<%= form.getRatelimit_out() %>"/>
                <html:hidden property="ratelimit_out___hide" value="<%= form.getRatelimit_out___hide() %>"/>
                        <html:hidden property="usagemode" value="<%= form.getUsagemode() %>"/>
                <html:hidden property="usagemode___hide" value="<%= form.getUsagemode___hide() %>"/>
                        <html:hidden property="connectionid" value="<%= form.getConnectionid() %>"/>
                <html:hidden property="connectionid___hide" value="<%= form.getConnectionid___hide() %>"/>
                                  <html:hidden property="facing" value="<%= form.getFacing() %>"/>
                <html:hidden property="facing___hide" value="<%= form.getFacing___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="terminationpointid" value="<%= request.getParameter(\"terminationpointid\") %>"/>
                <html:hidden property="terminationpointid___hide" value="<%= request.getParameter(\"terminationpointid___hide\") %>"/>
                        <html:hidden property="attachmentid" value="<%= request.getParameter(\"attachmentid\") %>"/>
                <html:hidden property="attachmentid___hide" value="<%= request.getParameter(\"attachmentid___hide\") %>"/>
                        <html:hidden property="qosprofile_in" value="<%= request.getParameter(\"qosprofile_in\") %>"/>
                <html:hidden property="qosprofile_in___hide" value="<%= request.getParameter(\"qosprofile_in___hide\") %>"/>
                        <html:hidden property="qosprofile_out" value="<%= request.getParameter(\"qosprofile_out\") %>"/>
                <html:hidden property="qosprofile_out___hide" value="<%= request.getParameter(\"qosprofile_out___hide\") %>"/>
                        <html:hidden property="ratelimit_in" value="<%= request.getParameter(\"ratelimit_in\") %>"/>
                <html:hidden property="ratelimit_in___hide" value="<%= request.getParameter(\"ratelimit_in___hide\") %>"/>
                        <html:hidden property="ratelimit_out" value="<%= request.getParameter(\"ratelimit_out\") %>"/>
                <html:hidden property="ratelimit_out___hide" value="<%= request.getParameter(\"ratelimit_out___hide\") %>"/>
                        <html:hidden property="usagemode" value="<%= request.getParameter(\"usagemode\") %>"/>
                <html:hidden property="usagemode___hide" value="<%= request.getParameter(\"usagemode___hide\") %>"/>
                        <html:hidden property="connectionid" value="<%= request.getParameter(\"connectionid\") %>"/>
                <html:hidden property="connectionid___hide" value="<%= request.getParameter(\"connectionid___hide\") %>"/>
                                  <html:hidden property="facing" value="<%= request.getParameter(\"facing\") %>"/>
                <html:hidden property="facing___hide" value="<%= request.getParameter(\"facing___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.L2FlowPointForm.submit()"/>
  </html:form>

  </body>
</html>
  
