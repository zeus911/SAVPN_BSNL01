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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(Sh_L3AccessFlowConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(Sh_L3AccessFlowConstants.DATASOURCE);
String tabName = request.getParameter(Sh_L3AccessFlowConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

Sh_L3AccessFlowForm form = (Sh_L3AccessFlowForm) request.getAttribute("Sh_L3AccessFlowForm");


String ServiceId___hide = null;
String CustomerId___hide = null;
String ServiceName___hide = null;
String InitiationDate___hide = null;
String ActivationDate___hide = null;
String ModificationDate___hide = null;
String State___hide = null;
String Type___hide = null;
String ContactPerson___hide = null;
String Comments___hide = null;
String Marker___hide = null;
String UploadStatus___hide = null;
String DBPrimaryKey___hide = null;
String SiteId___hide = null;
String VlanId___hide = null;
String PE_Status___hide = null;
String CE_Status___hide = null;
String AccessNW_Status___hide = null;
String IPNet___hide = null;
String Netmask___hide = null;
String Domain_id___hide = null;
String MDTData___hide = null;
String LoopAddr___hide = null;
String RP___hide = null;
String CE_based_QoS___hide = null;
String AddressFamily___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListSh_L3AccessFlow.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  ServiceId___hide = form.getServiceid___hide();
  CustomerId___hide = form.getCustomerid___hide();
  ServiceName___hide = form.getServicename___hide();
  InitiationDate___hide = form.getInitiationdate___hide();
  ActivationDate___hide = form.getActivationdate___hide();
  ModificationDate___hide = form.getModificationdate___hide();
  State___hide = form.getState___hide();
  Type___hide = form.getType___hide();
  ContactPerson___hide = form.getContactperson___hide();
  Comments___hide = form.getComments___hide();
  Marker___hide = form.getMarker___hide();
  UploadStatus___hide = form.getUploadstatus___hide();
  DBPrimaryKey___hide = form.getDbprimarykey___hide();
  SiteId___hide = form.getSiteid___hide();
  VlanId___hide = form.getVlanid___hide();
  PE_Status___hide = form.getPe_status___hide();
  CE_Status___hide = form.getCe_status___hide();
  AccessNW_Status___hide = form.getAccessnw_status___hide();
  IPNet___hide = form.getIpnet___hide();
  Netmask___hide = form.getNetmask___hide();
  Domain_id___hide = form.getDomain_id___hide();
  MDTData___hide = form.getMdtdata___hide();
  LoopAddr___hide = form.getLoopaddr___hide();
  RP___hide = form.getRp___hide();
  CE_based_QoS___hide = form.getCe_based_qos___hide();
  AddressFamily___hide = form.getAddressfamily___hide();

  if ( ServiceId___hide != null )
    requestURI.append("serviceid___hide=" + ServiceId___hide);
  if ( CustomerId___hide != null )
    requestURI.append("customerid___hide=" + CustomerId___hide);
  if ( ServiceName___hide != null )
    requestURI.append("servicename___hide=" + ServiceName___hide);
  if ( InitiationDate___hide != null )
    requestURI.append("initiationdate___hide=" + InitiationDate___hide);
  if ( ActivationDate___hide != null )
    requestURI.append("activationdate___hide=" + ActivationDate___hide);
  if ( ModificationDate___hide != null )
    requestURI.append("modificationdate___hide=" + ModificationDate___hide);
  if ( State___hide != null )
    requestURI.append("state___hide=" + State___hide);
  if ( Type___hide != null )
    requestURI.append("type___hide=" + Type___hide);
  if ( ContactPerson___hide != null )
    requestURI.append("contactperson___hide=" + ContactPerson___hide);
  if ( Comments___hide != null )
    requestURI.append("comments___hide=" + Comments___hide);
  if ( Marker___hide != null )
    requestURI.append("marker___hide=" + Marker___hide);
  if ( UploadStatus___hide != null )
    requestURI.append("uploadstatus___hide=" + UploadStatus___hide);
  if ( DBPrimaryKey___hide != null )
    requestURI.append("dbprimarykey___hide=" + DBPrimaryKey___hide);
  if ( SiteId___hide != null )
    requestURI.append("siteid___hide=" + SiteId___hide);
  if ( VlanId___hide != null )
    requestURI.append("vlanid___hide=" + VlanId___hide);
  if ( PE_Status___hide != null )
    requestURI.append("pe_status___hide=" + PE_Status___hide);
  if ( CE_Status___hide != null )
    requestURI.append("ce_status___hide=" + CE_Status___hide);
  if ( AccessNW_Status___hide != null )
    requestURI.append("accessnw_status___hide=" + AccessNW_Status___hide);
  if ( IPNet___hide != null )
    requestURI.append("ipnet___hide=" + IPNet___hide);
  if ( Netmask___hide != null )
    requestURI.append("netmask___hide=" + Netmask___hide);
  if ( Domain_id___hide != null )
    requestURI.append("domain_id___hide=" + Domain_id___hide);
  if ( MDTData___hide != null )
    requestURI.append("mdtdata___hide=" + MDTData___hide);
  if ( LoopAddr___hide != null )
    requestURI.append("loopaddr___hide=" + LoopAddr___hide);
  if ( RP___hide != null )
    requestURI.append("rp___hide=" + RP___hide);
  if ( CE_based_QoS___hide != null )
    requestURI.append("ce_based_qos___hide=" + CE_based_QoS___hide);
  if ( AddressFamily___hide != null )
    requestURI.append("addressfamily___hide=" + AddressFamily___hide);

} else {

    ServiceId___hide = request.getParameter("serviceid___hide");
    CustomerId___hide = request.getParameter("customerid___hide");
    ServiceName___hide = request.getParameter("servicename___hide");
    InitiationDate___hide = request.getParameter("initiationdate___hide");
    ActivationDate___hide = request.getParameter("activationdate___hide");
    ModificationDate___hide = request.getParameter("modificationdate___hide");
    State___hide = request.getParameter("state___hide");
    Type___hide = request.getParameter("type___hide");
    ContactPerson___hide = request.getParameter("contactperson___hide");
    Comments___hide = request.getParameter("comments___hide");
    Marker___hide = request.getParameter("marker___hide");
    UploadStatus___hide = request.getParameter("uploadstatus___hide");
    DBPrimaryKey___hide = request.getParameter("dbprimarykey___hide");
    SiteId___hide = request.getParameter("siteid___hide");
    VlanId___hide = request.getParameter("vlanid___hide");
    PE_Status___hide = request.getParameter("pe_status___hide");
    CE_Status___hide = request.getParameter("ce_status___hide");
    AccessNW_Status___hide = request.getParameter("accessnw_status___hide");
    IPNet___hide = request.getParameter("ipnet___hide");
    Netmask___hide = request.getParameter("netmask___hide");
    Domain_id___hide = request.getParameter("domain_id___hide");
    MDTData___hide = request.getParameter("mdtdata___hide");
    LoopAddr___hide = request.getParameter("loopaddr___hide");
    RP___hide = request.getParameter("rp___hide");
    CE_based_QoS___hide = request.getParameter("ce_based_qos___hide");
    AddressFamily___hide = request.getParameter("addressfamily___hide");

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
    <title><bean:message bundle="Sh_L3AccessFlowApplicationResources" key="<%= Sh_L3AccessFlowConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitSh_L3AccessFlowAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( ServiceId___hide == null || ServiceId___hide.equals("null") ) {
%>
      <display:column property="serviceid" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.serviceid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CustomerId___hide == null || CustomerId___hide.equals("null") ) {
%>
      <display:column property="customerid" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.customerid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ServiceName___hide == null || ServiceName___hide.equals("null") ) {
%>
      <display:column property="servicename" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.servicename.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( InitiationDate___hide == null || InitiationDate___hide.equals("null") ) {
%>
      <display:column property="initiationdate" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.initiationdate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ActivationDate___hide == null || ActivationDate___hide.equals("null") ) {
%>
      <display:column property="activationdate" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.activationdate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ModificationDate___hide == null || ModificationDate___hide.equals("null") ) {
%>
      <display:column property="modificationdate" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.modificationdate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( State___hide == null || State___hide.equals("null") ) {
%>
      <display:column property="state" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.state.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Type___hide == null || Type___hide.equals("null") ) {
%>
      <display:column property="type" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.type.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ContactPerson___hide == null || ContactPerson___hide.equals("null") ) {
%>
      <display:column property="contactperson" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.contactperson.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Comments___hide == null || Comments___hide.equals("null") ) {
%>
      <display:column property="comments" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.comments.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Marker___hide == null || Marker___hide.equals("null") ) {
%>
      <display:column property="marker" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.marker.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UploadStatus___hide == null || UploadStatus___hide.equals("null") ) {
%>
      <display:column property="uploadstatus" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.uploadstatus.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( DBPrimaryKey___hide == null || DBPrimaryKey___hide.equals("null") ) {
%>
      <display:column property="dbprimarykey" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.dbprimarykey.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SiteId___hide == null || SiteId___hide.equals("null") ) {
%>
      <display:column property="siteid" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.siteid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VlanId___hide == null || VlanId___hide.equals("null") ) {
%>
      <display:column property="vlanid" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.vlanid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PE_Status___hide == null || PE_Status___hide.equals("null") ) {
%>
      <display:column property="pe_status" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.pe_status.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CE_Status___hide == null || CE_Status___hide.equals("null") ) {
%>
      <display:column property="ce_status" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.ce_status.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( AccessNW_Status___hide == null || AccessNW_Status___hide.equals("null") ) {
%>
      <display:column property="accessnw_status" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.accessnw_status.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IPNet___hide == null || IPNet___hide.equals("null") ) {
%>
      <display:column property="ipnet" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.ipnet.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Netmask___hide == null || Netmask___hide.equals("null") ) {
%>
      <display:column property="netmask" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.netmask.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Domain_id___hide == null || Domain_id___hide.equals("null") ) {
%>
      <display:column property="domain_id" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.domain_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( MDTData___hide == null || MDTData___hide.equals("null") ) {
%>
      <display:column property="mdtdata" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.mdtdata.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( LoopAddr___hide == null || LoopAddr___hide.equals("null") ) {
%>
      <display:column property="loopaddr" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.loopaddr.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RP___hide == null || RP___hide.equals("null") ) {
%>
      <display:column property="rp" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.rp.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CE_based_QoS___hide == null || CE_based_QoS___hide.equals("null") ) {
%>
      <display:column property="ce_based_qos" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.ce_based_qos.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( AddressFamily___hide == null || AddressFamily___hide.equals("null") ) {
%>
      <display:column property="addressfamily" sortable="true" titleKey="Sh_L3AccessFlowApplicationResources:field.addressfamily.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormSh_L3AccessFlowAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="serviceid" value="<%= form.getServiceid() %>"/>
                <html:hidden property="serviceid___hide" value="<%= form.getServiceid___hide() %>"/>
                        <html:hidden property="customerid" value="<%= form.getCustomerid() %>"/>
                <html:hidden property="customerid___hide" value="<%= form.getCustomerid___hide() %>"/>
                        <html:hidden property="servicename" value="<%= form.getServicename() %>"/>
                <html:hidden property="servicename___hide" value="<%= form.getServicename___hide() %>"/>
                        <html:hidden property="initiationdate" value="<%= form.getInitiationdate() %>"/>
                <html:hidden property="initiationdate___hide" value="<%= form.getInitiationdate___hide() %>"/>
                        <html:hidden property="activationdate" value="<%= form.getActivationdate() %>"/>
                <html:hidden property="activationdate___hide" value="<%= form.getActivationdate___hide() %>"/>
                        <html:hidden property="modificationdate" value="<%= form.getModificationdate() %>"/>
                <html:hidden property="modificationdate___hide" value="<%= form.getModificationdate___hide() %>"/>
                        <html:hidden property="state" value="<%= form.getState() %>"/>
                <html:hidden property="state___hide" value="<%= form.getState___hide() %>"/>
                        <html:hidden property="type" value="<%= form.getType() %>"/>
                <html:hidden property="type___hide" value="<%= form.getType___hide() %>"/>
                        <html:hidden property="contactperson" value="<%= form.getContactperson() %>"/>
                <html:hidden property="contactperson___hide" value="<%= form.getContactperson___hide() %>"/>
                        <html:hidden property="comments" value="<%= form.getComments() %>"/>
                <html:hidden property="comments___hide" value="<%= form.getComments___hide() %>"/>
                        <html:hidden property="marker" value="<%= form.getMarker() %>"/>
                <html:hidden property="marker___hide" value="<%= form.getMarker___hide() %>"/>
                        <html:hidden property="uploadstatus" value="<%= form.getUploadstatus() %>"/>
                <html:hidden property="uploadstatus___hide" value="<%= form.getUploadstatus___hide() %>"/>
                        <html:hidden property="dbprimarykey" value="<%= form.getDbprimarykey() %>"/>
                <html:hidden property="dbprimarykey___hide" value="<%= form.getDbprimarykey___hide() %>"/>
                                  <html:hidden property="siteid" value="<%= form.getSiteid() %>"/>
                <html:hidden property="siteid___hide" value="<%= form.getSiteid___hide() %>"/>
                        <html:hidden property="vlanid" value="<%= form.getVlanid() %>"/>
                <html:hidden property="vlanid___hide" value="<%= form.getVlanid___hide() %>"/>
                        <html:hidden property="pe_status" value="<%= form.getPe_status() %>"/>
                <html:hidden property="pe_status___hide" value="<%= form.getPe_status___hide() %>"/>
                        <html:hidden property="ce_status" value="<%= form.getCe_status() %>"/>
                <html:hidden property="ce_status___hide" value="<%= form.getCe_status___hide() %>"/>
                        <html:hidden property="accessnw_status" value="<%= form.getAccessnw_status() %>"/>
                <html:hidden property="accessnw_status___hide" value="<%= form.getAccessnw_status___hide() %>"/>
                        <html:hidden property="ipnet" value="<%= form.getIpnet() %>"/>
                <html:hidden property="ipnet___hide" value="<%= form.getIpnet___hide() %>"/>
                        <html:hidden property="netmask" value="<%= form.getNetmask() %>"/>
                <html:hidden property="netmask___hide" value="<%= form.getNetmask___hide() %>"/>
                        <html:hidden property="domain_id" value="<%= form.getDomain_id() %>"/>
                <html:hidden property="domain_id___hide" value="<%= form.getDomain_id___hide() %>"/>
                        <html:hidden property="mdtdata" value="<%= form.getMdtdata() %>"/>
                <html:hidden property="mdtdata___hide" value="<%= form.getMdtdata___hide() %>"/>
                        <html:hidden property="loopaddr" value="<%= form.getLoopaddr() %>"/>
                <html:hidden property="loopaddr___hide" value="<%= form.getLoopaddr___hide() %>"/>
                        <html:hidden property="rp" value="<%= form.getRp() %>"/>
                <html:hidden property="rp___hide" value="<%= form.getRp___hide() %>"/>
                        <html:hidden property="ce_based_qos" value="<%= form.getCe_based_qos() %>"/>
                <html:hidden property="ce_based_qos___hide" value="<%= form.getCe_based_qos___hide() %>"/>
                        <html:hidden property="addressfamily" value="<%= form.getAddressfamily() %>"/>
                <html:hidden property="addressfamily___hide" value="<%= form.getAddressfamily___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="serviceid" value="<%= request.getParameter(\"serviceid\") %>"/>
                <html:hidden property="serviceid___hide" value="<%= request.getParameter(\"serviceid___hide\") %>"/>
                        <html:hidden property="customerid" value="<%= request.getParameter(\"customerid\") %>"/>
                <html:hidden property="customerid___hide" value="<%= request.getParameter(\"customerid___hide\") %>"/>
                        <html:hidden property="servicename" value="<%= request.getParameter(\"servicename\") %>"/>
                <html:hidden property="servicename___hide" value="<%= request.getParameter(\"servicename___hide\") %>"/>
                        <html:hidden property="initiationdate" value="<%= request.getParameter(\"initiationdate\") %>"/>
                <html:hidden property="initiationdate___hide" value="<%= request.getParameter(\"initiationdate___hide\") %>"/>
                        <html:hidden property="activationdate" value="<%= request.getParameter(\"activationdate\") %>"/>
                <html:hidden property="activationdate___hide" value="<%= request.getParameter(\"activationdate___hide\") %>"/>
                        <html:hidden property="modificationdate" value="<%= request.getParameter(\"modificationdate\") %>"/>
                <html:hidden property="modificationdate___hide" value="<%= request.getParameter(\"modificationdate___hide\") %>"/>
                        <html:hidden property="state" value="<%= request.getParameter(\"state\") %>"/>
                <html:hidden property="state___hide" value="<%= request.getParameter(\"state___hide\") %>"/>
                        <html:hidden property="type" value="<%= request.getParameter(\"type\") %>"/>
                <html:hidden property="type___hide" value="<%= request.getParameter(\"type___hide\") %>"/>
                        <html:hidden property="contactperson" value="<%= request.getParameter(\"contactperson\") %>"/>
                <html:hidden property="contactperson___hide" value="<%= request.getParameter(\"contactperson___hide\") %>"/>
                        <html:hidden property="comments" value="<%= request.getParameter(\"comments\") %>"/>
                <html:hidden property="comments___hide" value="<%= request.getParameter(\"comments___hide\") %>"/>
                        <html:hidden property="marker" value="<%= request.getParameter(\"marker\") %>"/>
                <html:hidden property="marker___hide" value="<%= request.getParameter(\"marker___hide\") %>"/>
                        <html:hidden property="uploadstatus" value="<%= request.getParameter(\"uploadstatus\") %>"/>
                <html:hidden property="uploadstatus___hide" value="<%= request.getParameter(\"uploadstatus___hide\") %>"/>
                        <html:hidden property="dbprimarykey" value="<%= request.getParameter(\"dbprimarykey\") %>"/>
                <html:hidden property="dbprimarykey___hide" value="<%= request.getParameter(\"dbprimarykey___hide\") %>"/>
                                  <html:hidden property="siteid" value="<%= request.getParameter(\"siteid\") %>"/>
                <html:hidden property="siteid___hide" value="<%= request.getParameter(\"siteid___hide\") %>"/>
                        <html:hidden property="vlanid" value="<%= request.getParameter(\"vlanid\") %>"/>
                <html:hidden property="vlanid___hide" value="<%= request.getParameter(\"vlanid___hide\") %>"/>
                        <html:hidden property="pe_status" value="<%= request.getParameter(\"pe_status\") %>"/>
                <html:hidden property="pe_status___hide" value="<%= request.getParameter(\"pe_status___hide\") %>"/>
                        <html:hidden property="ce_status" value="<%= request.getParameter(\"ce_status\") %>"/>
                <html:hidden property="ce_status___hide" value="<%= request.getParameter(\"ce_status___hide\") %>"/>
                        <html:hidden property="accessnw_status" value="<%= request.getParameter(\"accessnw_status\") %>"/>
                <html:hidden property="accessnw_status___hide" value="<%= request.getParameter(\"accessnw_status___hide\") %>"/>
                        <html:hidden property="ipnet" value="<%= request.getParameter(\"ipnet\") %>"/>
                <html:hidden property="ipnet___hide" value="<%= request.getParameter(\"ipnet___hide\") %>"/>
                        <html:hidden property="netmask" value="<%= request.getParameter(\"netmask\") %>"/>
                <html:hidden property="netmask___hide" value="<%= request.getParameter(\"netmask___hide\") %>"/>
                        <html:hidden property="domain_id" value="<%= request.getParameter(\"domain_id\") %>"/>
                <html:hidden property="domain_id___hide" value="<%= request.getParameter(\"domain_id___hide\") %>"/>
                        <html:hidden property="mdtdata" value="<%= request.getParameter(\"mdtdata\") %>"/>
                <html:hidden property="mdtdata___hide" value="<%= request.getParameter(\"mdtdata___hide\") %>"/>
                        <html:hidden property="loopaddr" value="<%= request.getParameter(\"loopaddr\") %>"/>
                <html:hidden property="loopaddr___hide" value="<%= request.getParameter(\"loopaddr___hide\") %>"/>
                        <html:hidden property="rp" value="<%= request.getParameter(\"rp\") %>"/>
                <html:hidden property="rp___hide" value="<%= request.getParameter(\"rp___hide\") %>"/>
                        <html:hidden property="ce_based_qos" value="<%= request.getParameter(\"ce_based_qos\") %>"/>
                <html:hidden property="ce_based_qos___hide" value="<%= request.getParameter(\"ce_based_qos___hide\") %>"/>
                        <html:hidden property="addressfamily" value="<%= request.getParameter(\"addressfamily\") %>"/>
                <html:hidden property="addressfamily___hide" value="<%= request.getParameter(\"addressfamily___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.Sh_L3AccessFlowForm.submit()"/>
  </html:form>

  </body>
</html>
  
