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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(GISFlowPointConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(GISFlowPointConstants.DATASOURCE);
String tabName = request.getParameter(GISFlowPointConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

GISFlowPointForm form = (GISFlowPointForm) request.getAttribute("GISFlowPointForm");


String TerminationPointId___hide = null;
String AttachmentId___hide = null;
String VRFName___hide = null;
String PE_InterfaceIP___hide = null;
String PE_InterfaceSecondaryIP___hide = null;
String CE_InterfaceIP___hide = null;
String CE_InterfaceSecondaryIP___hide = null;
String Protocol___hide = null;
String OSPF_id___hide = null;
String Rip_id___hide = null;
String Maximum_Prefix___hide = null;
String StaticRoutes___hide = null;
String IPPrefixRoutes___hide = null;
String SOO_Configured___hide = null;
String RateLimit_in___hide = null;
String QoSProfile_in___hide = null;
String RateLimit_out___hide = null;
String QoSProfile_out___hide = null;
String QoSChildEnabled___hide = null;
String mCAR___hide = null;
String mCoS___hide = null;
String LoopbackId___hide = null;
String Master___hide = null;
String Priority___hide = null;
String VRRP_Group_Id___hide = null;
String UsageMode___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListGISFlowPoint.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  TerminationPointId___hide = form.getTerminationpointid___hide();
  AttachmentId___hide = form.getAttachmentid___hide();
  VRFName___hide = form.getVrfname___hide();
  PE_InterfaceIP___hide = form.getPe_interfaceip___hide();
  PE_InterfaceSecondaryIP___hide = form.getPe_interfacesecondaryip___hide();
  CE_InterfaceIP___hide = form.getCe_interfaceip___hide();
  CE_InterfaceSecondaryIP___hide = form.getCe_interfacesecondaryip___hide();
  Protocol___hide = form.getProtocol___hide();
  OSPF_id___hide = form.getOspf_id___hide();
  Rip_id___hide = form.getRip_id___hide();
  Maximum_Prefix___hide = form.getMaximum_prefix___hide();
  StaticRoutes___hide = form.getStaticroutes___hide();
  IPPrefixRoutes___hide = form.getIpprefixroutes___hide();
  SOO_Configured___hide = form.getSoo_configured___hide();
  RateLimit_in___hide = form.getRatelimit_in___hide();
  QoSProfile_in___hide = form.getQosprofile_in___hide();
  RateLimit_out___hide = form.getRatelimit_out___hide();
  QoSProfile_out___hide = form.getQosprofile_out___hide();
  QoSChildEnabled___hide = form.getQoschildenabled___hide();
  mCAR___hide = form.getMcar___hide();
  mCoS___hide = form.getMcos___hide();
  LoopbackId___hide = form.getLoopbackid___hide();
  Master___hide = form.getMaster___hide();
  Priority___hide = form.getPriority___hide();
  VRRP_Group_Id___hide = form.getVrrp_group_id___hide();
  UsageMode___hide = form.getUsagemode___hide();

  if ( TerminationPointId___hide != null )
    requestURI.append("terminationpointid___hide=" + TerminationPointId___hide);
  if ( AttachmentId___hide != null )
    requestURI.append("attachmentid___hide=" + AttachmentId___hide);
  if ( VRFName___hide != null )
    requestURI.append("vrfname___hide=" + VRFName___hide);
  if ( PE_InterfaceIP___hide != null )
    requestURI.append("pe_interfaceip___hide=" + PE_InterfaceIP___hide);
  if ( PE_InterfaceSecondaryIP___hide != null )
    requestURI.append("pe_interfacesecondaryip___hide=" + PE_InterfaceSecondaryIP___hide);
  if ( CE_InterfaceIP___hide != null )
    requestURI.append("ce_interfaceip___hide=" + CE_InterfaceIP___hide);
  if ( CE_InterfaceSecondaryIP___hide != null )
    requestURI.append("ce_interfacesecondaryip___hide=" + CE_InterfaceSecondaryIP___hide);
  if ( Protocol___hide != null )
    requestURI.append("protocol___hide=" + Protocol___hide);
  if ( OSPF_id___hide != null )
    requestURI.append("ospf_id___hide=" + OSPF_id___hide);
  if ( Rip_id___hide != null )
    requestURI.append("rip_id___hide=" + Rip_id___hide);
  if ( Maximum_Prefix___hide != null )
    requestURI.append("maximum_prefix___hide=" + Maximum_Prefix___hide);
  if ( StaticRoutes___hide != null )
    requestURI.append("staticroutes___hide=" + StaticRoutes___hide);
  if ( IPPrefixRoutes___hide != null )
    requestURI.append("ipprefixroutes___hide=" + IPPrefixRoutes___hide);
  if ( SOO_Configured___hide != null )
    requestURI.append("soo_configured___hide=" + SOO_Configured___hide);
  if ( RateLimit_in___hide != null )
    requestURI.append("ratelimit_in___hide=" + RateLimit_in___hide);
  if ( QoSProfile_in___hide != null )
    requestURI.append("qosprofile_in___hide=" + QoSProfile_in___hide);
  if ( RateLimit_out___hide != null )
    requestURI.append("ratelimit_out___hide=" + RateLimit_out___hide);
  if ( QoSProfile_out___hide != null )
    requestURI.append("qosprofile_out___hide=" + QoSProfile_out___hide);
  if ( QoSChildEnabled___hide != null )
    requestURI.append("qoschildenabled___hide=" + QoSChildEnabled___hide);
  if ( mCAR___hide != null )
    requestURI.append("mcar___hide=" + mCAR___hide);
  if ( mCoS___hide != null )
    requestURI.append("mcos___hide=" + mCoS___hide);
  if ( LoopbackId___hide != null )
    requestURI.append("loopbackid___hide=" + LoopbackId___hide);
  if ( Master___hide != null )
    requestURI.append("master___hide=" + Master___hide);
  if ( Priority___hide != null )
    requestURI.append("priority___hide=" + Priority___hide);
  if ( VRRP_Group_Id___hide != null )
    requestURI.append("vrrp_group_id___hide=" + VRRP_Group_Id___hide);
  if ( UsageMode___hide != null )
    requestURI.append("usagemode___hide=" + UsageMode___hide);

} else {

    TerminationPointId___hide = request.getParameter("terminationpointid___hide");
    AttachmentId___hide = request.getParameter("attachmentid___hide");
    VRFName___hide = request.getParameter("vrfname___hide");
    PE_InterfaceIP___hide = request.getParameter("pe_interfaceip___hide");
    PE_InterfaceSecondaryIP___hide = request.getParameter("pe_interfacesecondaryip___hide");
    CE_InterfaceIP___hide = request.getParameter("ce_interfaceip___hide");
    CE_InterfaceSecondaryIP___hide = request.getParameter("ce_interfacesecondaryip___hide");
    Protocol___hide = request.getParameter("protocol___hide");
    OSPF_id___hide = request.getParameter("ospf_id___hide");
    Rip_id___hide = request.getParameter("rip_id___hide");
    Maximum_Prefix___hide = request.getParameter("maximum_prefix___hide");
    StaticRoutes___hide = request.getParameter("staticroutes___hide");
    IPPrefixRoutes___hide = request.getParameter("ipprefixroutes___hide");
    SOO_Configured___hide = request.getParameter("soo_configured___hide");
    RateLimit_in___hide = request.getParameter("ratelimit_in___hide");
    QoSProfile_in___hide = request.getParameter("qosprofile_in___hide");
    RateLimit_out___hide = request.getParameter("ratelimit_out___hide");
    QoSProfile_out___hide = request.getParameter("qosprofile_out___hide");
    QoSChildEnabled___hide = request.getParameter("qoschildenabled___hide");
    mCAR___hide = request.getParameter("mcar___hide");
    mCoS___hide = request.getParameter("mcos___hide");
    LoopbackId___hide = request.getParameter("loopbackid___hide");
    Master___hide = request.getParameter("master___hide");
    Priority___hide = request.getParameter("priority___hide");
    VRRP_Group_Id___hide = request.getParameter("vrrp_group_id___hide");
    UsageMode___hide = request.getParameter("usagemode___hide");

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
    <title><bean:message bundle="GISFlowPointApplicationResources" key="<%= GISFlowPointConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="GISFlowPointApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitGISFlowPointAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( TerminationPointId___hide == null || TerminationPointId___hide.equals("null") ) {
%>
      <display:column property="terminationpointid" sortable="true" titleKey="GISFlowPointApplicationResources:field.terminationpointid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( AttachmentId___hide == null || AttachmentId___hide.equals("null") ) {
%>
      <display:column property="attachmentid" sortable="true" titleKey="GISFlowPointApplicationResources:field.attachmentid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VRFName___hide == null || VRFName___hide.equals("null") ) {
%>
      <display:column property="vrfname" sortable="true" titleKey="GISFlowPointApplicationResources:field.vrfname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PE_InterfaceIP___hide == null || PE_InterfaceIP___hide.equals("null") ) {
%>
      <display:column property="pe_interfaceip" sortable="true" titleKey="GISFlowPointApplicationResources:field.pe_interfaceip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PE_InterfaceSecondaryIP___hide == null || PE_InterfaceSecondaryIP___hide.equals("null") ) {
%>
      <display:column property="pe_interfacesecondaryip" sortable="true" titleKey="GISFlowPointApplicationResources:field.pe_interfacesecondaryip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CE_InterfaceIP___hide == null || CE_InterfaceIP___hide.equals("null") ) {
%>
      <display:column property="ce_interfaceip" sortable="true" titleKey="GISFlowPointApplicationResources:field.ce_interfaceip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CE_InterfaceSecondaryIP___hide == null || CE_InterfaceSecondaryIP___hide.equals("null") ) {
%>
      <display:column property="ce_interfacesecondaryip" sortable="true" titleKey="GISFlowPointApplicationResources:field.ce_interfacesecondaryip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Protocol___hide == null || Protocol___hide.equals("null") ) {
%>
      <display:column property="protocol" sortable="true" titleKey="GISFlowPointApplicationResources:field.protocol.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( OSPF_id___hide == null || OSPF_id___hide.equals("null") ) {
%>
      <display:column property="ospf_id" sortable="true" titleKey="GISFlowPointApplicationResources:field.ospf_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Rip_id___hide == null || Rip_id___hide.equals("null") ) {
%>
      <display:column property="rip_id" sortable="true" titleKey="GISFlowPointApplicationResources:field.rip_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Maximum_Prefix___hide == null || Maximum_Prefix___hide.equals("null") ) {
%>
      <display:column property="maximum_prefix" sortable="true" titleKey="GISFlowPointApplicationResources:field.maximum_prefix.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( StaticRoutes___hide == null || StaticRoutes___hide.equals("null") ) {
%>
      <display:column property="staticroutes" sortable="true" titleKey="GISFlowPointApplicationResources:field.staticroutes.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IPPrefixRoutes___hide == null || IPPrefixRoutes___hide.equals("null") ) {
%>
      <display:column property="ipprefixroutes" sortable="true" titleKey="GISFlowPointApplicationResources:field.ipprefixroutes.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SOO_Configured___hide == null || SOO_Configured___hide.equals("null") ) {
%>
      <display:column property="soo_configured" sortable="true" titleKey="GISFlowPointApplicationResources:field.soo_configured.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RateLimit_in___hide == null || RateLimit_in___hide.equals("null") ) {
%>
      <display:column property="ratelimit_in" sortable="true" titleKey="GISFlowPointApplicationResources:field.ratelimit_in.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( QoSProfile_in___hide == null || QoSProfile_in___hide.equals("null") ) {
%>
      <display:column property="qosprofile_in" sortable="true" titleKey="GISFlowPointApplicationResources:field.qosprofile_in.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RateLimit_out___hide == null || RateLimit_out___hide.equals("null") ) {
%>
      <display:column property="ratelimit_out" sortable="true" titleKey="GISFlowPointApplicationResources:field.ratelimit_out.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( QoSProfile_out___hide == null || QoSProfile_out___hide.equals("null") ) {
%>
      <display:column property="qosprofile_out" sortable="true" titleKey="GISFlowPointApplicationResources:field.qosprofile_out.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( QoSChildEnabled___hide == null || QoSChildEnabled___hide.equals("null") ) {
%>
      <display:column property="qoschildenabled" sortable="true" titleKey="GISFlowPointApplicationResources:field.qoschildenabled.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( mCAR___hide == null || mCAR___hide.equals("null") ) {
%>
      <display:column property="mcar" sortable="true" titleKey="GISFlowPointApplicationResources:field.mcar.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( mCoS___hide == null || mCoS___hide.equals("null") ) {
%>
      <display:column property="mcos" sortable="true" titleKey="GISFlowPointApplicationResources:field.mcos.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( LoopbackId___hide == null || LoopbackId___hide.equals("null") ) {
%>
      <display:column property="loopbackid" sortable="true" titleKey="GISFlowPointApplicationResources:field.loopbackid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Master___hide == null || Master___hide.equals("null") ) {
%>
      <display:column property="master" sortable="true" titleKey="GISFlowPointApplicationResources:field.master.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Priority___hide == null || Priority___hide.equals("null") ) {
%>
      <display:column property="priority" sortable="true" titleKey="GISFlowPointApplicationResources:field.priority.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VRRP_Group_Id___hide == null || VRRP_Group_Id___hide.equals("null") ) {
%>
      <display:column property="vrrp_group_id" sortable="true" titleKey="GISFlowPointApplicationResources:field.vrrp_group_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UsageMode___hide == null || UsageMode___hide.equals("null") ) {
%>
      <display:column property="usagemode" sortable="true" titleKey="GISFlowPointApplicationResources:field.usagemode.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormGISFlowPointAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="terminationpointid" value="<%= form.getTerminationpointid() %>"/>
                <html:hidden property="terminationpointid___hide" value="<%= form.getTerminationpointid___hide() %>"/>
                        <html:hidden property="attachmentid" value="<%= form.getAttachmentid() %>"/>
                <html:hidden property="attachmentid___hide" value="<%= form.getAttachmentid___hide() %>"/>
                        <html:hidden property="vrfname" value="<%= form.getVrfname() %>"/>
                <html:hidden property="vrfname___hide" value="<%= form.getVrfname___hide() %>"/>
                        <html:hidden property="pe_interfaceip" value="<%= form.getPe_interfaceip() %>"/>
                <html:hidden property="pe_interfaceip___hide" value="<%= form.getPe_interfaceip___hide() %>"/>
                        <html:hidden property="pe_interfacesecondaryip" value="<%= form.getPe_interfacesecondaryip() %>"/>
                <html:hidden property="pe_interfacesecondaryip___hide" value="<%= form.getPe_interfacesecondaryip___hide() %>"/>
                        <html:hidden property="ce_interfaceip" value="<%= form.getCe_interfaceip() %>"/>
                <html:hidden property="ce_interfaceip___hide" value="<%= form.getCe_interfaceip___hide() %>"/>
                        <html:hidden property="ce_interfacesecondaryip" value="<%= form.getCe_interfacesecondaryip() %>"/>
                <html:hidden property="ce_interfacesecondaryip___hide" value="<%= form.getCe_interfacesecondaryip___hide() %>"/>
                        <html:hidden property="protocol" value="<%= form.getProtocol() %>"/>
                <html:hidden property="protocol___hide" value="<%= form.getProtocol___hide() %>"/>
                        <html:hidden property="ospf_id" value="<%= form.getOspf_id() %>"/>
                <html:hidden property="ospf_id___hide" value="<%= form.getOspf_id___hide() %>"/>
                        <html:hidden property="rip_id" value="<%= form.getRip_id() %>"/>
                <html:hidden property="rip_id___hide" value="<%= form.getRip_id___hide() %>"/>
                        <html:hidden property="maximum_prefix" value="<%= form.getMaximum_prefix() %>"/>
                  <html:hidden property="maximum_prefix___" value="<%= form.getMaximum_prefix___() %>"/>
                <html:hidden property="maximum_prefix___hide" value="<%= form.getMaximum_prefix___hide() %>"/>
                        <html:hidden property="staticroutes" value="<%= form.getStaticroutes() %>"/>
                <html:hidden property="staticroutes___hide" value="<%= form.getStaticroutes___hide() %>"/>
                        <html:hidden property="ipprefixroutes" value="<%= form.getIpprefixroutes() %>"/>
                <html:hidden property="ipprefixroutes___hide" value="<%= form.getIpprefixroutes___hide() %>"/>
                        <html:hidden property="soo_configured" value="<%= form.getSoo_configured() %>"/>
                <html:hidden property="soo_configured___hide" value="<%= form.getSoo_configured___hide() %>"/>
                        <html:hidden property="ratelimit_in" value="<%= form.getRatelimit_in() %>"/>
                <html:hidden property="ratelimit_in___hide" value="<%= form.getRatelimit_in___hide() %>"/>
                        <html:hidden property="qosprofile_in" value="<%= form.getQosprofile_in() %>"/>
                <html:hidden property="qosprofile_in___hide" value="<%= form.getQosprofile_in___hide() %>"/>
                        <html:hidden property="ratelimit_out" value="<%= form.getRatelimit_out() %>"/>
                <html:hidden property="ratelimit_out___hide" value="<%= form.getRatelimit_out___hide() %>"/>
                        <html:hidden property="qosprofile_out" value="<%= form.getQosprofile_out() %>"/>
                <html:hidden property="qosprofile_out___hide" value="<%= form.getQosprofile_out___hide() %>"/>
                        <html:hidden property="qoschildenabled" value="<%= form.getQoschildenabled() %>"/>
                <html:hidden property="qoschildenabled___hide" value="<%= form.getQoschildenabled___hide() %>"/>
                        <html:hidden property="mcar" value="<%= form.getMcar() %>"/>
                <html:hidden property="mcar___hide" value="<%= form.getMcar___hide() %>"/>
                        <html:hidden property="mcos" value="<%= form.getMcos() %>"/>
                <html:hidden property="mcos___hide" value="<%= form.getMcos___hide() %>"/>
                        <html:hidden property="loopbackid" value="<%= form.getLoopbackid() %>"/>
                <html:hidden property="loopbackid___hide" value="<%= form.getLoopbackid___hide() %>"/>
                        <html:hidden property="master" value="<%= form.getMaster() %>"/>
                <html:hidden property="master___hide" value="<%= form.getMaster___hide() %>"/>
                        <html:hidden property="priority" value="<%= form.getPriority() %>"/>
                  <html:hidden property="priority___" value="<%= form.getPriority___() %>"/>
                <html:hidden property="priority___hide" value="<%= form.getPriority___hide() %>"/>
                        <html:hidden property="vrrp_group_id" value="<%= form.getVrrp_group_id() %>"/>
                  <html:hidden property="vrrp_group_id___" value="<%= form.getVrrp_group_id___() %>"/>
                <html:hidden property="vrrp_group_id___hide" value="<%= form.getVrrp_group_id___hide() %>"/>
                        <html:hidden property="usagemode" value="<%= form.getUsagemode() %>"/>
                <html:hidden property="usagemode___hide" value="<%= form.getUsagemode___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="terminationpointid" value="<%= request.getParameter(\"terminationpointid\") %>"/>
                <html:hidden property="terminationpointid___hide" value="<%= request.getParameter(\"terminationpointid___hide\") %>"/>
                        <html:hidden property="attachmentid" value="<%= request.getParameter(\"attachmentid\") %>"/>
                <html:hidden property="attachmentid___hide" value="<%= request.getParameter(\"attachmentid___hide\") %>"/>
                        <html:hidden property="vrfname" value="<%= request.getParameter(\"vrfname\") %>"/>
                <html:hidden property="vrfname___hide" value="<%= request.getParameter(\"vrfname___hide\") %>"/>
                        <html:hidden property="pe_interfaceip" value="<%= request.getParameter(\"pe_interfaceip\") %>"/>
                <html:hidden property="pe_interfaceip___hide" value="<%= request.getParameter(\"pe_interfaceip___hide\") %>"/>
                        <html:hidden property="pe_interfacesecondaryip" value="<%= request.getParameter(\"pe_interfacesecondaryip\") %>"/>
                <html:hidden property="pe_interfacesecondaryip___hide" value="<%= request.getParameter(\"pe_interfacesecondaryip___hide\") %>"/>
                        <html:hidden property="ce_interfaceip" value="<%= request.getParameter(\"ce_interfaceip\") %>"/>
                <html:hidden property="ce_interfaceip___hide" value="<%= request.getParameter(\"ce_interfaceip___hide\") %>"/>
                        <html:hidden property="ce_interfacesecondaryip" value="<%= request.getParameter(\"ce_interfacesecondaryip\") %>"/>
                <html:hidden property="ce_interfacesecondaryip___hide" value="<%= request.getParameter(\"ce_interfacesecondaryip___hide\") %>"/>
                        <html:hidden property="protocol" value="<%= request.getParameter(\"protocol\") %>"/>
                <html:hidden property="protocol___hide" value="<%= request.getParameter(\"protocol___hide\") %>"/>
                        <html:hidden property="ospf_id" value="<%= request.getParameter(\"ospf_id\") %>"/>
                <html:hidden property="ospf_id___hide" value="<%= request.getParameter(\"ospf_id___hide\") %>"/>
                        <html:hidden property="rip_id" value="<%= request.getParameter(\"rip_id\") %>"/>
                <html:hidden property="rip_id___hide" value="<%= request.getParameter(\"rip_id___hide\") %>"/>
                        <html:hidden property="maximum_prefix" value="<%= request.getParameter(\"maximum_prefix\") %>"/>
                  <html:hidden property="maximum_prefix___" value="<%= request.getParameter(\"maximum_prefix___\") %>"/>
                <html:hidden property="maximum_prefix___hide" value="<%= request.getParameter(\"maximum_prefix___hide\") %>"/>
                        <html:hidden property="staticroutes" value="<%= request.getParameter(\"staticroutes\") %>"/>
                <html:hidden property="staticroutes___hide" value="<%= request.getParameter(\"staticroutes___hide\") %>"/>
                        <html:hidden property="ipprefixroutes" value="<%= request.getParameter(\"ipprefixroutes\") %>"/>
                <html:hidden property="ipprefixroutes___hide" value="<%= request.getParameter(\"ipprefixroutes___hide\") %>"/>
                        <html:hidden property="soo_configured" value="<%= request.getParameter(\"soo_configured\") %>"/>
                <html:hidden property="soo_configured___hide" value="<%= request.getParameter(\"soo_configured___hide\") %>"/>
                        <html:hidden property="ratelimit_in" value="<%= request.getParameter(\"ratelimit_in\") %>"/>
                <html:hidden property="ratelimit_in___hide" value="<%= request.getParameter(\"ratelimit_in___hide\") %>"/>
                        <html:hidden property="qosprofile_in" value="<%= request.getParameter(\"qosprofile_in\") %>"/>
                <html:hidden property="qosprofile_in___hide" value="<%= request.getParameter(\"qosprofile_in___hide\") %>"/>
                        <html:hidden property="ratelimit_out" value="<%= request.getParameter(\"ratelimit_out\") %>"/>
                <html:hidden property="ratelimit_out___hide" value="<%= request.getParameter(\"ratelimit_out___hide\") %>"/>
                        <html:hidden property="qosprofile_out" value="<%= request.getParameter(\"qosprofile_out\") %>"/>
                <html:hidden property="qosprofile_out___hide" value="<%= request.getParameter(\"qosprofile_out___hide\") %>"/>
                        <html:hidden property="qoschildenabled" value="<%= request.getParameter(\"qoschildenabled\") %>"/>
                <html:hidden property="qoschildenabled___hide" value="<%= request.getParameter(\"qoschildenabled___hide\") %>"/>
                        <html:hidden property="mcar" value="<%= request.getParameter(\"mcar\") %>"/>
                <html:hidden property="mcar___hide" value="<%= request.getParameter(\"mcar___hide\") %>"/>
                        <html:hidden property="mcos" value="<%= request.getParameter(\"mcos\") %>"/>
                <html:hidden property="mcos___hide" value="<%= request.getParameter(\"mcos___hide\") %>"/>
                        <html:hidden property="loopbackid" value="<%= request.getParameter(\"loopbackid\") %>"/>
                <html:hidden property="loopbackid___hide" value="<%= request.getParameter(\"loopbackid___hide\") %>"/>
                        <html:hidden property="master" value="<%= request.getParameter(\"master\") %>"/>
                <html:hidden property="master___hide" value="<%= request.getParameter(\"master___hide\") %>"/>
                        <html:hidden property="priority" value="<%= request.getParameter(\"priority\") %>"/>
                  <html:hidden property="priority___" value="<%= request.getParameter(\"priority___\") %>"/>
                <html:hidden property="priority___hide" value="<%= request.getParameter(\"priority___hide\") %>"/>
                        <html:hidden property="vrrp_group_id" value="<%= request.getParameter(\"vrrp_group_id\") %>"/>
                  <html:hidden property="vrrp_group_id___" value="<%= request.getParameter(\"vrrp_group_id___\") %>"/>
                <html:hidden property="vrrp_group_id___hide" value="<%= request.getParameter(\"vrrp_group_id___hide\") %>"/>
                        <html:hidden property="usagemode" value="<%= request.getParameter(\"usagemode\") %>"/>
                <html:hidden property="usagemode___hide" value="<%= request.getParameter(\"usagemode___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.GISFlowPointForm.submit()"/>
  </html:form>

  </body>
</html>
  
