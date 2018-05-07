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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(ASBRFlowPointConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(ASBRFlowPointConstants.DATASOURCE);
String tabName = request.getParameter(ASBRFlowPointConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

ASBRFlowPointForm form = (ASBRFlowPointForm) request.getAttribute("ASBRFlowPointForm");


String TerminationPointId___hide = null;
String ASBRServiceId___hide = null;
String VRFName___hide = null;
String QoSProfile_in___hide = null;
String QoSProfile_out___hide = null;
String RateLimit_in___hide = null;
String RateLimit_out___hide = null;
String Protocol___hide = null;
String PE_InterfaceIP___hide = null;
String CE_InterfaceIP___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListASBRFlowPoint.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  TerminationPointId___hide = form.getTerminationpointid___hide();
  ASBRServiceId___hide = form.getAsbrserviceid___hide();
  VRFName___hide = form.getVrfname___hide();
  QoSProfile_in___hide = form.getQosprofile_in___hide();
  QoSProfile_out___hide = form.getQosprofile_out___hide();
  RateLimit_in___hide = form.getRatelimit_in___hide();
  RateLimit_out___hide = form.getRatelimit_out___hide();
  Protocol___hide = form.getProtocol___hide();
  PE_InterfaceIP___hide = form.getPe_interfaceip___hide();
  CE_InterfaceIP___hide = form.getCe_interfaceip___hide();

  if ( TerminationPointId___hide != null )
    requestURI.append("terminationpointid___hide=" + TerminationPointId___hide);
  if ( ASBRServiceId___hide != null )
    requestURI.append("asbrserviceid___hide=" + ASBRServiceId___hide);
  if ( VRFName___hide != null )
    requestURI.append("vrfname___hide=" + VRFName___hide);
  if ( QoSProfile_in___hide != null )
    requestURI.append("qosprofile_in___hide=" + QoSProfile_in___hide);
  if ( QoSProfile_out___hide != null )
    requestURI.append("qosprofile_out___hide=" + QoSProfile_out___hide);
  if ( RateLimit_in___hide != null )
    requestURI.append("ratelimit_in___hide=" + RateLimit_in___hide);
  if ( RateLimit_out___hide != null )
    requestURI.append("ratelimit_out___hide=" + RateLimit_out___hide);
  if ( Protocol___hide != null )
    requestURI.append("protocol___hide=" + Protocol___hide);
  if ( PE_InterfaceIP___hide != null )
    requestURI.append("pe_interfaceip___hide=" + PE_InterfaceIP___hide);
  if ( CE_InterfaceIP___hide != null )
    requestURI.append("ce_interfaceip___hide=" + CE_InterfaceIP___hide);

} else {

    TerminationPointId___hide = request.getParameter("terminationpointid___hide");
    ASBRServiceId___hide = request.getParameter("asbrserviceid___hide");
    VRFName___hide = request.getParameter("vrfname___hide");
    QoSProfile_in___hide = request.getParameter("qosprofile_in___hide");
    QoSProfile_out___hide = request.getParameter("qosprofile_out___hide");
    RateLimit_in___hide = request.getParameter("ratelimit_in___hide");
    RateLimit_out___hide = request.getParameter("ratelimit_out___hide");
    Protocol___hide = request.getParameter("protocol___hide");
    PE_InterfaceIP___hide = request.getParameter("pe_interfaceip___hide");
    CE_InterfaceIP___hide = request.getParameter("ce_interfaceip___hide");

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
    <title><bean:message bundle="ASBRFlowPointApplicationResources" key="<%= ASBRFlowPointConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="ASBRFlowPointApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitASBRFlowPointAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( TerminationPointId___hide == null || TerminationPointId___hide.equals("null") ) {
%>
      <display:column property="terminationpointid" sortable="true" titleKey="ASBRFlowPointApplicationResources:field.terminationpointid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ASBRServiceId___hide == null || ASBRServiceId___hide.equals("null") ) {
%>
      <display:column property="asbrserviceid" sortable="true" titleKey="ASBRFlowPointApplicationResources:field.asbrserviceid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VRFName___hide == null || VRFName___hide.equals("null") ) {
%>
      <display:column property="vrfname" sortable="true" titleKey="ASBRFlowPointApplicationResources:field.vrfname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( QoSProfile_in___hide == null || QoSProfile_in___hide.equals("null") ) {
%>
      <display:column property="qosprofile_in" sortable="true" titleKey="ASBRFlowPointApplicationResources:field.qosprofile_in.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( QoSProfile_out___hide == null || QoSProfile_out___hide.equals("null") ) {
%>
      <display:column property="qosprofile_out" sortable="true" titleKey="ASBRFlowPointApplicationResources:field.qosprofile_out.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RateLimit_in___hide == null || RateLimit_in___hide.equals("null") ) {
%>
      <display:column property="ratelimit_in" sortable="true" titleKey="ASBRFlowPointApplicationResources:field.ratelimit_in.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RateLimit_out___hide == null || RateLimit_out___hide.equals("null") ) {
%>
      <display:column property="ratelimit_out" sortable="true" titleKey="ASBRFlowPointApplicationResources:field.ratelimit_out.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Protocol___hide == null || Protocol___hide.equals("null") ) {
%>
      <display:column property="protocol" sortable="true" titleKey="ASBRFlowPointApplicationResources:field.protocol.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PE_InterfaceIP___hide == null || PE_InterfaceIP___hide.equals("null") ) {
%>
      <display:column property="pe_interfaceip" sortable="true" titleKey="ASBRFlowPointApplicationResources:field.pe_interfaceip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CE_InterfaceIP___hide == null || CE_InterfaceIP___hide.equals("null") ) {
%>
      <display:column property="ce_interfaceip" sortable="true" titleKey="ASBRFlowPointApplicationResources:field.ce_interfaceip.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormASBRFlowPointAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="terminationpointid" value="<%= form.getTerminationpointid() %>"/>
                <html:hidden property="terminationpointid___hide" value="<%= form.getTerminationpointid___hide() %>"/>
                        <html:hidden property="asbrserviceid" value="<%= form.getAsbrserviceid() %>"/>
                <html:hidden property="asbrserviceid___hide" value="<%= form.getAsbrserviceid___hide() %>"/>
                        <html:hidden property="vrfname" value="<%= form.getVrfname() %>"/>
                <html:hidden property="vrfname___hide" value="<%= form.getVrfname___hide() %>"/>
                        <html:hidden property="qosprofile_in" value="<%= form.getQosprofile_in() %>"/>
                <html:hidden property="qosprofile_in___hide" value="<%= form.getQosprofile_in___hide() %>"/>
                        <html:hidden property="qosprofile_out" value="<%= form.getQosprofile_out() %>"/>
                <html:hidden property="qosprofile_out___hide" value="<%= form.getQosprofile_out___hide() %>"/>
                        <html:hidden property="ratelimit_in" value="<%= form.getRatelimit_in() %>"/>
                <html:hidden property="ratelimit_in___hide" value="<%= form.getRatelimit_in___hide() %>"/>
                        <html:hidden property="ratelimit_out" value="<%= form.getRatelimit_out() %>"/>
                <html:hidden property="ratelimit_out___hide" value="<%= form.getRatelimit_out___hide() %>"/>
                        <html:hidden property="protocol" value="<%= form.getProtocol() %>"/>
                <html:hidden property="protocol___hide" value="<%= form.getProtocol___hide() %>"/>
                        <html:hidden property="pe_interfaceip" value="<%= form.getPe_interfaceip() %>"/>
                <html:hidden property="pe_interfaceip___hide" value="<%= form.getPe_interfaceip___hide() %>"/>
                        <html:hidden property="ce_interfaceip" value="<%= form.getCe_interfaceip() %>"/>
                <html:hidden property="ce_interfaceip___hide" value="<%= form.getCe_interfaceip___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="terminationpointid" value="<%= request.getParameter(\"terminationpointid\") %>"/>
                <html:hidden property="terminationpointid___hide" value="<%= request.getParameter(\"terminationpointid___hide\") %>"/>
                        <html:hidden property="asbrserviceid" value="<%= request.getParameter(\"asbrserviceid\") %>"/>
                <html:hidden property="asbrserviceid___hide" value="<%= request.getParameter(\"asbrserviceid___hide\") %>"/>
                        <html:hidden property="vrfname" value="<%= request.getParameter(\"vrfname\") %>"/>
                <html:hidden property="vrfname___hide" value="<%= request.getParameter(\"vrfname___hide\") %>"/>
                        <html:hidden property="qosprofile_in" value="<%= request.getParameter(\"qosprofile_in\") %>"/>
                <html:hidden property="qosprofile_in___hide" value="<%= request.getParameter(\"qosprofile_in___hide\") %>"/>
                        <html:hidden property="qosprofile_out" value="<%= request.getParameter(\"qosprofile_out\") %>"/>
                <html:hidden property="qosprofile_out___hide" value="<%= request.getParameter(\"qosprofile_out___hide\") %>"/>
                        <html:hidden property="ratelimit_in" value="<%= request.getParameter(\"ratelimit_in\") %>"/>
                <html:hidden property="ratelimit_in___hide" value="<%= request.getParameter(\"ratelimit_in___hide\") %>"/>
                        <html:hidden property="ratelimit_out" value="<%= request.getParameter(\"ratelimit_out\") %>"/>
                <html:hidden property="ratelimit_out___hide" value="<%= request.getParameter(\"ratelimit_out___hide\") %>"/>
                        <html:hidden property="protocol" value="<%= request.getParameter(\"protocol\") %>"/>
                <html:hidden property="protocol___hide" value="<%= request.getParameter(\"protocol___hide\") %>"/>
                        <html:hidden property="pe_interfaceip" value="<%= request.getParameter(\"pe_interfaceip\") %>"/>
                <html:hidden property="pe_interfaceip___hide" value="<%= request.getParameter(\"pe_interfaceip___hide\") %>"/>
                        <html:hidden property="ce_interfaceip" value="<%= request.getParameter(\"ce_interfaceip\") %>"/>
                <html:hidden property="ce_interfaceip___hide" value="<%= request.getParameter(\"ce_interfaceip___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.ASBRFlowPointForm.submit()"/>
  </html:form>

  </body>
</html>
  
