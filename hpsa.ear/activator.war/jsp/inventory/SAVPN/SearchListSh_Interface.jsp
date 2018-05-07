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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(Sh_InterfaceConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(Sh_InterfaceConstants.DATASOURCE);
String tabName = request.getParameter(Sh_InterfaceConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

Sh_InterfaceForm form = (Sh_InterfaceForm) request.getAttribute("Sh_InterfaceForm");


String TerminationPointID___hide = null;
String Name___hide = null;
String NE_ID___hide = null;
String EC_ID___hide = null;
String State___hide = null;
String Marker___hide = null;
String UploadStatus___hide = null;
String DBPrimaryKey___hide = null;
String Type___hide = null;
String ParentIf___hide = null;
String IPAddr___hide = null;
String SubType___hide = null;
String Encapsulation___hide = null;
String ifIndex___hide = null;
String ActiveState___hide = null;
String UsageState___hide = null;
String VlanId___hide = null;
String DLCI___hide = null;
String Timeslots___hide = null;
String SlotsNumber___hide = null;
String Bandwidth___hide = null;
String LmiType___hide = null;
String IntfType___hide = null;
String BundleKey___hide = null;
String BundleId___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListSh_Interface.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  TerminationPointID___hide = form.getTerminationpointid___hide();
  Name___hide = form.getName___hide();
  NE_ID___hide = form.getNe_id___hide();
  EC_ID___hide = form.getEc_id___hide();
  State___hide = form.getState___hide();
  Marker___hide = form.getMarker___hide();
  UploadStatus___hide = form.getUploadstatus___hide();
  DBPrimaryKey___hide = form.getDbprimarykey___hide();
  Type___hide = form.getType___hide();
  ParentIf___hide = form.getParentif___hide();
  IPAddr___hide = form.getIpaddr___hide();
  SubType___hide = form.getSubtype___hide();
  Encapsulation___hide = form.getEncapsulation___hide();
  ifIndex___hide = form.getIfindex___hide();
  ActiveState___hide = form.getActivestate___hide();
  UsageState___hide = form.getUsagestate___hide();
  VlanId___hide = form.getVlanid___hide();
  DLCI___hide = form.getDlci___hide();
  Timeslots___hide = form.getTimeslots___hide();
  SlotsNumber___hide = form.getSlotsnumber___hide();
  Bandwidth___hide = form.getBandwidth___hide();
  LmiType___hide = form.getLmitype___hide();
  IntfType___hide = form.getIntftype___hide();
  BundleKey___hide = form.getBundlekey___hide();
  BundleId___hide = form.getBundleid___hide();

  if ( TerminationPointID___hide != null )
    requestURI.append("terminationpointid___hide=" + TerminationPointID___hide);
  if ( Name___hide != null )
    requestURI.append("name___hide=" + Name___hide);
  if ( NE_ID___hide != null )
    requestURI.append("ne_id___hide=" + NE_ID___hide);
  if ( EC_ID___hide != null )
    requestURI.append("ec_id___hide=" + EC_ID___hide);
  if ( State___hide != null )
    requestURI.append("state___hide=" + State___hide);
  if ( Marker___hide != null )
    requestURI.append("marker___hide=" + Marker___hide);
  if ( UploadStatus___hide != null )
    requestURI.append("uploadstatus___hide=" + UploadStatus___hide);
  if ( DBPrimaryKey___hide != null )
    requestURI.append("dbprimarykey___hide=" + DBPrimaryKey___hide);
  if ( Type___hide != null )
    requestURI.append("type___hide=" + Type___hide);
  if ( ParentIf___hide != null )
    requestURI.append("parentif___hide=" + ParentIf___hide);
  if ( IPAddr___hide != null )
    requestURI.append("ipaddr___hide=" + IPAddr___hide);
  if ( SubType___hide != null )
    requestURI.append("subtype___hide=" + SubType___hide);
  if ( Encapsulation___hide != null )
    requestURI.append("encapsulation___hide=" + Encapsulation___hide);
  if ( ifIndex___hide != null )
    requestURI.append("ifindex___hide=" + ifIndex___hide);
  if ( ActiveState___hide != null )
    requestURI.append("activestate___hide=" + ActiveState___hide);
  if ( UsageState___hide != null )
    requestURI.append("usagestate___hide=" + UsageState___hide);
  if ( VlanId___hide != null )
    requestURI.append("vlanid___hide=" + VlanId___hide);
  if ( DLCI___hide != null )
    requestURI.append("dlci___hide=" + DLCI___hide);
  if ( Timeslots___hide != null )
    requestURI.append("timeslots___hide=" + Timeslots___hide);
  if ( SlotsNumber___hide != null )
    requestURI.append("slotsnumber___hide=" + SlotsNumber___hide);
  if ( Bandwidth___hide != null )
    requestURI.append("bandwidth___hide=" + Bandwidth___hide);
  if ( LmiType___hide != null )
    requestURI.append("lmitype___hide=" + LmiType___hide);
  if ( IntfType___hide != null )
    requestURI.append("intftype___hide=" + IntfType___hide);
  if ( BundleKey___hide != null )
    requestURI.append("bundlekey___hide=" + BundleKey___hide);
  if ( BundleId___hide != null )
    requestURI.append("bundleid___hide=" + BundleId___hide);

} else {

    TerminationPointID___hide = request.getParameter("terminationpointid___hide");
    Name___hide = request.getParameter("name___hide");
    NE_ID___hide = request.getParameter("ne_id___hide");
    EC_ID___hide = request.getParameter("ec_id___hide");
    State___hide = request.getParameter("state___hide");
    Marker___hide = request.getParameter("marker___hide");
    UploadStatus___hide = request.getParameter("uploadstatus___hide");
    DBPrimaryKey___hide = request.getParameter("dbprimarykey___hide");
    Type___hide = request.getParameter("type___hide");
    ParentIf___hide = request.getParameter("parentif___hide");
    IPAddr___hide = request.getParameter("ipaddr___hide");
    SubType___hide = request.getParameter("subtype___hide");
    Encapsulation___hide = request.getParameter("encapsulation___hide");
    ifIndex___hide = request.getParameter("ifindex___hide");
    ActiveState___hide = request.getParameter("activestate___hide");
    UsageState___hide = request.getParameter("usagestate___hide");
    VlanId___hide = request.getParameter("vlanid___hide");
    DLCI___hide = request.getParameter("dlci___hide");
    Timeslots___hide = request.getParameter("timeslots___hide");
    SlotsNumber___hide = request.getParameter("slotsnumber___hide");
    Bandwidth___hide = request.getParameter("bandwidth___hide");
    LmiType___hide = request.getParameter("lmitype___hide");
    IntfType___hide = request.getParameter("intftype___hide");
    BundleKey___hide = request.getParameter("bundlekey___hide");
    BundleId___hide = request.getParameter("bundleid___hide");

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
    <title><bean:message bundle="Sh_InterfaceApplicationResources" key="<%= Sh_InterfaceConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_InterfaceApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitSh_InterfaceAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( TerminationPointID___hide == null || TerminationPointID___hide.equals("null") ) {
%>
      <display:column property="terminationpointid" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.terminationpointid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Name___hide == null || Name___hide.equals("null") ) {
%>
      <display:column property="name" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NE_ID___hide == null || NE_ID___hide.equals("null") ) {
%>
      <display:column property="ne_id" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.ne_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( EC_ID___hide == null || EC_ID___hide.equals("null") ) {
%>
      <display:column property="ec_id" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.ec_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( State___hide == null || State___hide.equals("null") ) {
%>
      <display:column property="state" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.state.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Marker___hide == null || Marker___hide.equals("null") ) {
%>
      <display:column property="marker" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.marker.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UploadStatus___hide == null || UploadStatus___hide.equals("null") ) {
%>
      <display:column property="uploadstatus" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.uploadstatus.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( DBPrimaryKey___hide == null || DBPrimaryKey___hide.equals("null") ) {
%>
      <display:column property="dbprimarykey" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.dbprimarykey.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Type___hide == null || Type___hide.equals("null") ) {
%>
      <display:column property="type" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.type.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ParentIf___hide == null || ParentIf___hide.equals("null") ) {
%>
      <display:column property="parentif" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.parentif.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IPAddr___hide == null || IPAddr___hide.equals("null") ) {
%>
      <display:column property="ipaddr" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.ipaddr.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SubType___hide == null || SubType___hide.equals("null") ) {
%>
      <display:column property="subtype" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.subtype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Encapsulation___hide == null || Encapsulation___hide.equals("null") ) {
%>
      <display:column property="encapsulation" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.encapsulation.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ifIndex___hide == null || ifIndex___hide.equals("null") ) {
%>
      <display:column property="ifindex" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.ifindex.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ActiveState___hide == null || ActiveState___hide.equals("null") ) {
%>
      <display:column property="activestate" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.activestate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UsageState___hide == null || UsageState___hide.equals("null") ) {
%>
      <display:column property="usagestate" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.usagestate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VlanId___hide == null || VlanId___hide.equals("null") ) {
%>
      <display:column property="vlanid" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.vlanid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( DLCI___hide == null || DLCI___hide.equals("null") ) {
%>
      <display:column property="dlci" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.dlci.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Timeslots___hide == null || Timeslots___hide.equals("null") ) {
%>
      <display:column property="timeslots" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.timeslots.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SlotsNumber___hide == null || SlotsNumber___hide.equals("null") ) {
%>
      <display:column property="slotsnumber" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.slotsnumber.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Bandwidth___hide == null || Bandwidth___hide.equals("null") ) {
%>
      <display:column property="bandwidth" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.bandwidth.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( LmiType___hide == null || LmiType___hide.equals("null") ) {
%>
      <display:column property="lmitype" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.lmitype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IntfType___hide == null || IntfType___hide.equals("null") ) {
%>
      <display:column property="intftype" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.intftype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( BundleKey___hide == null || BundleKey___hide.equals("null") ) {
%>
      <display:column property="bundlekey" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.bundlekey.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( BundleId___hide == null || BundleId___hide.equals("null") ) {
%>
      <display:column property="bundleid" sortable="true" titleKey="Sh_InterfaceApplicationResources:field.bundleid.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormSh_InterfaceAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="terminationpointid" value="<%= form.getTerminationpointid() %>"/>
                <html:hidden property="terminationpointid___hide" value="<%= form.getTerminationpointid___hide() %>"/>
                        <html:hidden property="name" value="<%= form.getName() %>"/>
                <html:hidden property="name___hide" value="<%= form.getName___hide() %>"/>
                        <html:hidden property="ne_id" value="<%= form.getNe_id() %>"/>
                <html:hidden property="ne_id___hide" value="<%= form.getNe_id___hide() %>"/>
                        <html:hidden property="ec_id" value="<%= form.getEc_id() %>"/>
                <html:hidden property="ec_id___hide" value="<%= form.getEc_id___hide() %>"/>
                        <html:hidden property="state" value="<%= form.getState() %>"/>
                <html:hidden property="state___hide" value="<%= form.getState___hide() %>"/>
                        <html:hidden property="marker" value="<%= form.getMarker() %>"/>
                <html:hidden property="marker___hide" value="<%= form.getMarker___hide() %>"/>
                        <html:hidden property="uploadstatus" value="<%= form.getUploadstatus() %>"/>
                <html:hidden property="uploadstatus___hide" value="<%= form.getUploadstatus___hide() %>"/>
                        <html:hidden property="dbprimarykey" value="<%= form.getDbprimarykey() %>"/>
                <html:hidden property="dbprimarykey___hide" value="<%= form.getDbprimarykey___hide() %>"/>
                                  <html:hidden property="type" value="<%= form.getType() %>"/>
                <html:hidden property="type___hide" value="<%= form.getType___hide() %>"/>
                        <html:hidden property="parentif" value="<%= form.getParentif() %>"/>
                <html:hidden property="parentif___hide" value="<%= form.getParentif___hide() %>"/>
                        <html:hidden property="ipaddr" value="<%= form.getIpaddr() %>"/>
                <html:hidden property="ipaddr___hide" value="<%= form.getIpaddr___hide() %>"/>
                        <html:hidden property="subtype" value="<%= form.getSubtype() %>"/>
                <html:hidden property="subtype___hide" value="<%= form.getSubtype___hide() %>"/>
                        <html:hidden property="encapsulation" value="<%= form.getEncapsulation() %>"/>
                <html:hidden property="encapsulation___hide" value="<%= form.getEncapsulation___hide() %>"/>
                        <html:hidden property="ifindex" value="<%= form.getIfindex() %>"/>
                <html:hidden property="ifindex___hide" value="<%= form.getIfindex___hide() %>"/>
                        <html:hidden property="activestate" value="<%= form.getActivestate() %>"/>
                <html:hidden property="activestate___hide" value="<%= form.getActivestate___hide() %>"/>
                        <html:hidden property="usagestate" value="<%= form.getUsagestate() %>"/>
                <html:hidden property="usagestate___hide" value="<%= form.getUsagestate___hide() %>"/>
                        <html:hidden property="vlanid" value="<%= form.getVlanid() %>"/>
                <html:hidden property="vlanid___hide" value="<%= form.getVlanid___hide() %>"/>
                        <html:hidden property="dlci" value="<%= form.getDlci() %>"/>
                  <html:hidden property="dlci___" value="<%= form.getDlci___() %>"/>
                <html:hidden property="dlci___hide" value="<%= form.getDlci___hide() %>"/>
                        <html:hidden property="timeslots" value="<%= form.getTimeslots() %>"/>
                <html:hidden property="timeslots___hide" value="<%= form.getTimeslots___hide() %>"/>
                        <html:hidden property="slotsnumber" value="<%= form.getSlotsnumber() %>"/>
                  <html:hidden property="slotsnumber___" value="<%= form.getSlotsnumber___() %>"/>
                <html:hidden property="slotsnumber___hide" value="<%= form.getSlotsnumber___hide() %>"/>
                        <html:hidden property="bandwidth" value="<%= form.getBandwidth() %>"/>
                  <html:hidden property="bandwidth___" value="<%= form.getBandwidth___() %>"/>
                <html:hidden property="bandwidth___hide" value="<%= form.getBandwidth___hide() %>"/>
                        <html:hidden property="lmitype" value="<%= form.getLmitype() %>"/>
                <html:hidden property="lmitype___hide" value="<%= form.getLmitype___hide() %>"/>
                        <html:hidden property="intftype" value="<%= form.getIntftype() %>"/>
                <html:hidden property="intftype___hide" value="<%= form.getIntftype___hide() %>"/>
                        <html:hidden property="bundlekey" value="<%= form.getBundlekey() %>"/>
                <html:hidden property="bundlekey___hide" value="<%= form.getBundlekey___hide() %>"/>
                        <html:hidden property="bundleid" value="<%= form.getBundleid() %>"/>
                <html:hidden property="bundleid___hide" value="<%= form.getBundleid___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="terminationpointid" value="<%= request.getParameter(\"terminationpointid\") %>"/>
                <html:hidden property="terminationpointid___hide" value="<%= request.getParameter(\"terminationpointid___hide\") %>"/>
                        <html:hidden property="name" value="<%= request.getParameter(\"name\") %>"/>
                <html:hidden property="name___hide" value="<%= request.getParameter(\"name___hide\") %>"/>
                        <html:hidden property="ne_id" value="<%= request.getParameter(\"ne_id\") %>"/>
                <html:hidden property="ne_id___hide" value="<%= request.getParameter(\"ne_id___hide\") %>"/>
                        <html:hidden property="ec_id" value="<%= request.getParameter(\"ec_id\") %>"/>
                <html:hidden property="ec_id___hide" value="<%= request.getParameter(\"ec_id___hide\") %>"/>
                        <html:hidden property="state" value="<%= request.getParameter(\"state\") %>"/>
                <html:hidden property="state___hide" value="<%= request.getParameter(\"state___hide\") %>"/>
                        <html:hidden property="marker" value="<%= request.getParameter(\"marker\") %>"/>
                <html:hidden property="marker___hide" value="<%= request.getParameter(\"marker___hide\") %>"/>
                        <html:hidden property="uploadstatus" value="<%= request.getParameter(\"uploadstatus\") %>"/>
                <html:hidden property="uploadstatus___hide" value="<%= request.getParameter(\"uploadstatus___hide\") %>"/>
                        <html:hidden property="dbprimarykey" value="<%= request.getParameter(\"dbprimarykey\") %>"/>
                <html:hidden property="dbprimarykey___hide" value="<%= request.getParameter(\"dbprimarykey___hide\") %>"/>
                                  <html:hidden property="type" value="<%= request.getParameter(\"type\") %>"/>
                <html:hidden property="type___hide" value="<%= request.getParameter(\"type___hide\") %>"/>
                        <html:hidden property="parentif" value="<%= request.getParameter(\"parentif\") %>"/>
                <html:hidden property="parentif___hide" value="<%= request.getParameter(\"parentif___hide\") %>"/>
                        <html:hidden property="ipaddr" value="<%= request.getParameter(\"ipaddr\") %>"/>
                <html:hidden property="ipaddr___hide" value="<%= request.getParameter(\"ipaddr___hide\") %>"/>
                        <html:hidden property="subtype" value="<%= request.getParameter(\"subtype\") %>"/>
                <html:hidden property="subtype___hide" value="<%= request.getParameter(\"subtype___hide\") %>"/>
                        <html:hidden property="encapsulation" value="<%= request.getParameter(\"encapsulation\") %>"/>
                <html:hidden property="encapsulation___hide" value="<%= request.getParameter(\"encapsulation___hide\") %>"/>
                        <html:hidden property="ifindex" value="<%= request.getParameter(\"ifindex\") %>"/>
                <html:hidden property="ifindex___hide" value="<%= request.getParameter(\"ifindex___hide\") %>"/>
                        <html:hidden property="activestate" value="<%= request.getParameter(\"activestate\") %>"/>
                <html:hidden property="activestate___hide" value="<%= request.getParameter(\"activestate___hide\") %>"/>
                        <html:hidden property="usagestate" value="<%= request.getParameter(\"usagestate\") %>"/>
                <html:hidden property="usagestate___hide" value="<%= request.getParameter(\"usagestate___hide\") %>"/>
                        <html:hidden property="vlanid" value="<%= request.getParameter(\"vlanid\") %>"/>
                <html:hidden property="vlanid___hide" value="<%= request.getParameter(\"vlanid___hide\") %>"/>
                        <html:hidden property="dlci" value="<%= request.getParameter(\"dlci\") %>"/>
                  <html:hidden property="dlci___" value="<%= request.getParameter(\"dlci___\") %>"/>
                <html:hidden property="dlci___hide" value="<%= request.getParameter(\"dlci___hide\") %>"/>
                        <html:hidden property="timeslots" value="<%= request.getParameter(\"timeslots\") %>"/>
                <html:hidden property="timeslots___hide" value="<%= request.getParameter(\"timeslots___hide\") %>"/>
                        <html:hidden property="slotsnumber" value="<%= request.getParameter(\"slotsnumber\") %>"/>
                  <html:hidden property="slotsnumber___" value="<%= request.getParameter(\"slotsnumber___\") %>"/>
                <html:hidden property="slotsnumber___hide" value="<%= request.getParameter(\"slotsnumber___hide\") %>"/>
                        <html:hidden property="bandwidth" value="<%= request.getParameter(\"bandwidth\") %>"/>
                  <html:hidden property="bandwidth___" value="<%= request.getParameter(\"bandwidth___\") %>"/>
                <html:hidden property="bandwidth___hide" value="<%= request.getParameter(\"bandwidth___hide\") %>"/>
                        <html:hidden property="lmitype" value="<%= request.getParameter(\"lmitype\") %>"/>
                <html:hidden property="lmitype___hide" value="<%= request.getParameter(\"lmitype___hide\") %>"/>
                        <html:hidden property="intftype" value="<%= request.getParameter(\"intftype\") %>"/>
                <html:hidden property="intftype___hide" value="<%= request.getParameter(\"intftype___hide\") %>"/>
                        <html:hidden property="bundlekey" value="<%= request.getParameter(\"bundlekey\") %>"/>
                <html:hidden property="bundlekey___hide" value="<%= request.getParameter(\"bundlekey___hide\") %>"/>
                        <html:hidden property="bundleid" value="<%= request.getParameter(\"bundleid\") %>"/>
                <html:hidden property="bundleid___hide" value="<%= request.getParameter(\"bundleid___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.Sh_InterfaceForm.submit()"/>
  </html:form>

  </body>
</html>
  
