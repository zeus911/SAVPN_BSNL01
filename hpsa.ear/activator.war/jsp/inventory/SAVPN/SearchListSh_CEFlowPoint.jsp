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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(Sh_CEFlowPointConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(Sh_CEFlowPointConstants.DATASOURCE);
String tabName = request.getParameter(Sh_CEFlowPointConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

Sh_CEFlowPointForm form = (Sh_CEFlowPointForm) request.getAttribute("Sh_CEFlowPointForm");


String TerminationPointID___hide = null;
String AttachmentId___hide = null;
String QoSProfile_in___hide = null;
String QoSProfile_out___hide = null;
String RateLimit_in___hide = null;
String RateLimit_out___hide = null;
String Marker___hide = null;
String UploadStatus___hide = null;
String DBPrimaryKey___hide = null;
String NE_ID___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListSh_CEFlowPoint.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  TerminationPointID___hide = form.getTerminationpointid___hide();
  AttachmentId___hide = form.getAttachmentid___hide();
  QoSProfile_in___hide = form.getQosprofile_in___hide();
  QoSProfile_out___hide = form.getQosprofile_out___hide();
  RateLimit_in___hide = form.getRatelimit_in___hide();
  RateLimit_out___hide = form.getRatelimit_out___hide();
  Marker___hide = form.getMarker___hide();
  UploadStatus___hide = form.getUploadstatus___hide();
  DBPrimaryKey___hide = form.getDbprimarykey___hide();
  NE_ID___hide = form.getNe_id___hide();

  if ( TerminationPointID___hide != null )
    requestURI.append("terminationpointid___hide=" + TerminationPointID___hide);
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
  if ( Marker___hide != null )
    requestURI.append("marker___hide=" + Marker___hide);
  if ( UploadStatus___hide != null )
    requestURI.append("uploadstatus___hide=" + UploadStatus___hide);
  if ( DBPrimaryKey___hide != null )
    requestURI.append("dbprimarykey___hide=" + DBPrimaryKey___hide);
  if ( NE_ID___hide != null )
    requestURI.append("ne_id___hide=" + NE_ID___hide);

} else {

    TerminationPointID___hide = request.getParameter("terminationpointid___hide");
    AttachmentId___hide = request.getParameter("attachmentid___hide");
    QoSProfile_in___hide = request.getParameter("qosprofile_in___hide");
    QoSProfile_out___hide = request.getParameter("qosprofile_out___hide");
    RateLimit_in___hide = request.getParameter("ratelimit_in___hide");
    RateLimit_out___hide = request.getParameter("ratelimit_out___hide");
    Marker___hide = request.getParameter("marker___hide");
    UploadStatus___hide = request.getParameter("uploadstatus___hide");
    DBPrimaryKey___hide = request.getParameter("dbprimarykey___hide");
    NE_ID___hide = request.getParameter("ne_id___hide");

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
    <title><bean:message bundle="Sh_CEFlowPointApplicationResources" key="<%= Sh_CEFlowPointConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_CEFlowPointApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitSh_CEFlowPointAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( TerminationPointID___hide == null || TerminationPointID___hide.equals("null") ) {
%>
      <display:column property="terminationpointid" sortable="true" titleKey="Sh_CEFlowPointApplicationResources:field.terminationpointid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( AttachmentId___hide == null || AttachmentId___hide.equals("null") ) {
%>
      <display:column property="attachmentid" sortable="true" titleKey="Sh_CEFlowPointApplicationResources:field.attachmentid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( QoSProfile_in___hide == null || QoSProfile_in___hide.equals("null") ) {
%>
      <display:column property="qosprofile_in" sortable="true" titleKey="Sh_CEFlowPointApplicationResources:field.qosprofile_in.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( QoSProfile_out___hide == null || QoSProfile_out___hide.equals("null") ) {
%>
      <display:column property="qosprofile_out" sortable="true" titleKey="Sh_CEFlowPointApplicationResources:field.qosprofile_out.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RateLimit_in___hide == null || RateLimit_in___hide.equals("null") ) {
%>
      <display:column property="ratelimit_in" sortable="true" titleKey="Sh_CEFlowPointApplicationResources:field.ratelimit_in.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RateLimit_out___hide == null || RateLimit_out___hide.equals("null") ) {
%>
      <display:column property="ratelimit_out" sortable="true" titleKey="Sh_CEFlowPointApplicationResources:field.ratelimit_out.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Marker___hide == null || Marker___hide.equals("null") ) {
%>
      <display:column property="marker" sortable="true" titleKey="Sh_CEFlowPointApplicationResources:field.marker.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UploadStatus___hide == null || UploadStatus___hide.equals("null") ) {
%>
      <display:column property="uploadstatus" sortable="true" titleKey="Sh_CEFlowPointApplicationResources:field.uploadstatus.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( DBPrimaryKey___hide == null || DBPrimaryKey___hide.equals("null") ) {
%>
      <display:column property="dbprimarykey" sortable="true" titleKey="Sh_CEFlowPointApplicationResources:field.dbprimarykey.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NE_ID___hide == null || NE_ID___hide.equals("null") ) {
%>
      <display:column property="ne_id" sortable="true" titleKey="Sh_CEFlowPointApplicationResources:field.ne_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormSh_CEFlowPointAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
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
                        <html:hidden property="marker" value="<%= form.getMarker() %>"/>
                <html:hidden property="marker___hide" value="<%= form.getMarker___hide() %>"/>
                        <html:hidden property="uploadstatus" value="<%= form.getUploadstatus() %>"/>
                <html:hidden property="uploadstatus___hide" value="<%= form.getUploadstatus___hide() %>"/>
                        <html:hidden property="dbprimarykey" value="<%= form.getDbprimarykey() %>"/>
                <html:hidden property="dbprimarykey___hide" value="<%= form.getDbprimarykey___hide() %>"/>
                        <html:hidden property="ne_id" value="<%= form.getNe_id() %>"/>
                <html:hidden property="ne_id___hide" value="<%= form.getNe_id___hide() %>"/>
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
                        <html:hidden property="marker" value="<%= request.getParameter(\"marker\") %>"/>
                <html:hidden property="marker___hide" value="<%= request.getParameter(\"marker___hide\") %>"/>
                        <html:hidden property="uploadstatus" value="<%= request.getParameter(\"uploadstatus\") %>"/>
                <html:hidden property="uploadstatus___hide" value="<%= request.getParameter(\"uploadstatus___hide\") %>"/>
                        <html:hidden property="dbprimarykey" value="<%= request.getParameter(\"dbprimarykey\") %>"/>
                <html:hidden property="dbprimarykey___hide" value="<%= request.getParameter(\"dbprimarykey___hide\") %>"/>
                        <html:hidden property="ne_id" value="<%= request.getParameter(\"ne_id\") %>"/>
                <html:hidden property="ne_id___hide" value="<%= request.getParameter(\"ne_id___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.Sh_CEFlowPointForm.submit()"/>
  </html:form>

  </body>
</html>
  
