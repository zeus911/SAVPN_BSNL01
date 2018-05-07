<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        java.lang.reflect.Method,
        com.hp.ov.activator.nnmi.dl.inventory.*,
        com.hp.ov.activator.inventory.CRModel.*,
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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(DL_InterfaceConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(DL_InterfaceConstants.DATASOURCE);
String tabName = request.getParameter(DL_InterfaceConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

DL_InterfaceForm form = (DL_InterfaceForm) request.getAttribute("DL_InterfaceForm");


String NNMi_Id___hide = null;
String Name___hide = null;
String NE_NNMi_Id___hide = null;
String EC_NNMi_Id___hide = null;
String State___hide = null;
String StateName___hide = null;
String Type___hide = null;
String ParentIf___hide = null;
String IPAddr___hide = null;
String Subtype___hide = null;
String Encapsulation___hide = null;
String Description___hide = null;
String IFIndex___hide = null;
String ActivationState___hide = null;
String UsageState___hide = null;
String VLANId___hide = null;
String VLANMode___hide = null;
String DLCI___hide = null;
String Timeslots___hide = null;
String NumberOfSlots___hide = null;
String Bandwidth___hide = null;
String LMIType___hide = null;
String IntfType___hide = null;
String BundleKey___hide = null;
String BundleId___hide = null;
String NNMi_UUId___hide = null;
String NNMi_LastUpdate___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListDL_Interface.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  NNMi_Id___hide = form.getNnmi_id___hide();
  Name___hide = form.getName___hide();
  NE_NNMi_Id___hide = form.getNe_nnmi_id___hide();
  EC_NNMi_Id___hide = form.getEc_nnmi_id___hide();
  State___hide = form.getState___hide();
  StateName___hide = form.getStatename___hide();
  Type___hide = form.getType___hide();
  ParentIf___hide = form.getParentif___hide();
  IPAddr___hide = form.getIpaddr___hide();
  Subtype___hide = form.getSubtype___hide();
  Encapsulation___hide = form.getEncapsulation___hide();
  Description___hide = form.getDescription___hide();
  IFIndex___hide = form.getIfindex___hide();
  ActivationState___hide = form.getActivationstate___hide();
  UsageState___hide = form.getUsagestate___hide();
  VLANId___hide = form.getVlanid___hide();
  VLANMode___hide = form.getVlanmode___hide();
  DLCI___hide = form.getDlci___hide();
  Timeslots___hide = form.getTimeslots___hide();
  NumberOfSlots___hide = form.getNumberofslots___hide();
  Bandwidth___hide = form.getBandwidth___hide();
  LMIType___hide = form.getLmitype___hide();
  IntfType___hide = form.getIntftype___hide();
  BundleKey___hide = form.getBundlekey___hide();
  BundleId___hide = form.getBundleid___hide();
  NNMi_UUId___hide = form.getNnmi_uuid___hide();
  NNMi_LastUpdate___hide = form.getNnmi_lastupdate___hide();

  if ( NNMi_Id___hide != null )
    requestURI.append("nnmi_id___hide=" + NNMi_Id___hide);
  if ( Name___hide != null )
    requestURI.append("name___hide=" + Name___hide);
  if ( NE_NNMi_Id___hide != null )
    requestURI.append("ne_nnmi_id___hide=" + NE_NNMi_Id___hide);
  if ( EC_NNMi_Id___hide != null )
    requestURI.append("ec_nnmi_id___hide=" + EC_NNMi_Id___hide);
  if ( State___hide != null )
    requestURI.append("state___hide=" + State___hide);
  if ( StateName___hide != null )
    requestURI.append("statename___hide=" + StateName___hide);
  if ( Type___hide != null )
    requestURI.append("type___hide=" + Type___hide);
  if ( ParentIf___hide != null )
    requestURI.append("parentif___hide=" + ParentIf___hide);
  if ( IPAddr___hide != null )
    requestURI.append("ipaddr___hide=" + IPAddr___hide);
  if ( Subtype___hide != null )
    requestURI.append("subtype___hide=" + Subtype___hide);
  if ( Encapsulation___hide != null )
    requestURI.append("encapsulation___hide=" + Encapsulation___hide);
  if ( Description___hide != null )
    requestURI.append("description___hide=" + Description___hide);
  if ( IFIndex___hide != null )
    requestURI.append("ifindex___hide=" + IFIndex___hide);
  if ( ActivationState___hide != null )
    requestURI.append("activationstate___hide=" + ActivationState___hide);
  if ( UsageState___hide != null )
    requestURI.append("usagestate___hide=" + UsageState___hide);
  if ( VLANId___hide != null )
    requestURI.append("vlanid___hide=" + VLANId___hide);
  if ( VLANMode___hide != null )
    requestURI.append("vlanmode___hide=" + VLANMode___hide);
  if ( DLCI___hide != null )
    requestURI.append("dlci___hide=" + DLCI___hide);
  if ( Timeslots___hide != null )
    requestURI.append("timeslots___hide=" + Timeslots___hide);
  if ( NumberOfSlots___hide != null )
    requestURI.append("numberofslots___hide=" + NumberOfSlots___hide);
  if ( Bandwidth___hide != null )
    requestURI.append("bandwidth___hide=" + Bandwidth___hide);
  if ( LMIType___hide != null )
    requestURI.append("lmitype___hide=" + LMIType___hide);
  if ( IntfType___hide != null )
    requestURI.append("intftype___hide=" + IntfType___hide);
  if ( BundleKey___hide != null )
    requestURI.append("bundlekey___hide=" + BundleKey___hide);
  if ( BundleId___hide != null )
    requestURI.append("bundleid___hide=" + BundleId___hide);
  if ( NNMi_UUId___hide != null )
    requestURI.append("nnmi_uuid___hide=" + NNMi_UUId___hide);
  if ( NNMi_LastUpdate___hide != null )
    requestURI.append("nnmi_lastupdate___hide=" + NNMi_LastUpdate___hide);

} else {

    NNMi_Id___hide = request.getParameter("nnmi_id___hide");
    Name___hide = request.getParameter("name___hide");
    NE_NNMi_Id___hide = request.getParameter("ne_nnmi_id___hide");
    EC_NNMi_Id___hide = request.getParameter("ec_nnmi_id___hide");
    State___hide = request.getParameter("state___hide");
    StateName___hide = request.getParameter("statename___hide");
    Type___hide = request.getParameter("type___hide");
    ParentIf___hide = request.getParameter("parentif___hide");
    IPAddr___hide = request.getParameter("ipaddr___hide");
    Subtype___hide = request.getParameter("subtype___hide");
    Encapsulation___hide = request.getParameter("encapsulation___hide");
    Description___hide = request.getParameter("description___hide");
    IFIndex___hide = request.getParameter("ifindex___hide");
    ActivationState___hide = request.getParameter("activationstate___hide");
    UsageState___hide = request.getParameter("usagestate___hide");
    VLANId___hide = request.getParameter("vlanid___hide");
    VLANMode___hide = request.getParameter("vlanmode___hide");
    DLCI___hide = request.getParameter("dlci___hide");
    Timeslots___hide = request.getParameter("timeslots___hide");
    NumberOfSlots___hide = request.getParameter("numberofslots___hide");
    Bandwidth___hide = request.getParameter("bandwidth___hide");
    LMIType___hide = request.getParameter("lmitype___hide");
    IntfType___hide = request.getParameter("intftype___hide");
    BundleKey___hide = request.getParameter("bundlekey___hide");
    BundleId___hide = request.getParameter("bundleid___hide");
    NNMi_UUId___hide = request.getParameter("nnmi_uuid___hide");
    NNMi_LastUpdate___hide = request.getParameter("nnmi_lastupdate___hide");

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
    <title><bean:message bundle="DL_InterfaceApplicationResources" key="<%= DL_InterfaceConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_InterfaceApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitDL_InterfaceAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( NNMi_Id___hide == null || NNMi_Id___hide.equals("null") ) {
%>
      <display:column property="nnmi_id" sortable="true" titleKey="DL_InterfaceApplicationResources:field.nnmi_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Name___hide == null || Name___hide.equals("null") ) {
%>
      <display:column property="name" sortable="true" titleKey="DL_InterfaceApplicationResources:field.name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NE_NNMi_Id___hide == null || NE_NNMi_Id___hide.equals("null") ) {
%>
      <display:column property="ne_nnmi_id" sortable="true" titleKey="DL_InterfaceApplicationResources:field.ne_nnmi_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( EC_NNMi_Id___hide == null || EC_NNMi_Id___hide.equals("null") ) {
%>
      <display:column property="ec_nnmi_id" sortable="true" titleKey="DL_InterfaceApplicationResources:field.ec_nnmi_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( State___hide == null || State___hide.equals("null") ) {
%>
      <display:column property="state" sortable="true" titleKey="DL_InterfaceApplicationResources:field.state.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( StateName___hide == null || StateName___hide.equals("null") ) {
%>
      <display:column property="statename" sortable="true" titleKey="DL_InterfaceApplicationResources:field.statename.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Type___hide == null || Type___hide.equals("null") ) {
%>
      <display:column property="type" sortable="true" titleKey="DL_InterfaceApplicationResources:field.type.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ParentIf___hide == null || ParentIf___hide.equals("null") ) {
%>
      <display:column property="parentif" sortable="true" titleKey="DL_InterfaceApplicationResources:field.parentif.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IPAddr___hide == null || IPAddr___hide.equals("null") ) {
%>
      <display:column property="ipaddr" sortable="true" titleKey="DL_InterfaceApplicationResources:field.ipaddr.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Subtype___hide == null || Subtype___hide.equals("null") ) {
%>
      <display:column property="subtype" sortable="true" titleKey="DL_InterfaceApplicationResources:field.subtype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Encapsulation___hide == null || Encapsulation___hide.equals("null") ) {
%>
      <display:column property="encapsulation" sortable="true" titleKey="DL_InterfaceApplicationResources:field.encapsulation.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Description___hide == null || Description___hide.equals("null") ) {
%>
      <display:column property="description" sortable="true" titleKey="DL_InterfaceApplicationResources:field.description.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IFIndex___hide == null || IFIndex___hide.equals("null") ) {
%>
      <display:column property="ifindex" sortable="true" titleKey="DL_InterfaceApplicationResources:field.ifindex.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ActivationState___hide == null || ActivationState___hide.equals("null") ) {
%>
      <display:column property="activationstate" sortable="true" titleKey="DL_InterfaceApplicationResources:field.activationstate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UsageState___hide == null || UsageState___hide.equals("null") ) {
%>
      <display:column property="usagestate" sortable="true" titleKey="DL_InterfaceApplicationResources:field.usagestate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VLANId___hide == null || VLANId___hide.equals("null") ) {
%>
      <display:column property="vlanid" sortable="true" titleKey="DL_InterfaceApplicationResources:field.vlanid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VLANMode___hide == null || VLANMode___hide.equals("null") ) {
%>
      <display:column property="vlanmode" sortable="true" titleKey="DL_InterfaceApplicationResources:field.vlanmode.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( DLCI___hide == null || DLCI___hide.equals("null") ) {
%>
      <display:column property="dlci" sortable="true" titleKey="DL_InterfaceApplicationResources:field.dlci.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Timeslots___hide == null || Timeslots___hide.equals("null") ) {
%>
      <display:column property="timeslots" sortable="true" titleKey="DL_InterfaceApplicationResources:field.timeslots.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NumberOfSlots___hide == null || NumberOfSlots___hide.equals("null") ) {
%>
      <display:column property="numberofslots" sortable="true" titleKey="DL_InterfaceApplicationResources:field.numberofslots.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Bandwidth___hide == null || Bandwidth___hide.equals("null") ) {
%>
      <display:column property="bandwidth" sortable="true" titleKey="DL_InterfaceApplicationResources:field.bandwidth.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( LMIType___hide == null || LMIType___hide.equals("null") ) {
%>
      <display:column property="lmitype" sortable="true" titleKey="DL_InterfaceApplicationResources:field.lmitype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IntfType___hide == null || IntfType___hide.equals("null") ) {
%>
      <display:column property="intftype" sortable="true" titleKey="DL_InterfaceApplicationResources:field.intftype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( BundleKey___hide == null || BundleKey___hide.equals("null") ) {
%>
      <display:column property="bundlekey" sortable="true" titleKey="DL_InterfaceApplicationResources:field.bundlekey.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( BundleId___hide == null || BundleId___hide.equals("null") ) {
%>
      <display:column property="bundleid" sortable="true" titleKey="DL_InterfaceApplicationResources:field.bundleid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NNMi_UUId___hide == null || NNMi_UUId___hide.equals("null") ) {
%>
      <display:column property="nnmi_uuid" sortable="true" titleKey="DL_InterfaceApplicationResources:field.nnmi_uuid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NNMi_LastUpdate___hide == null || NNMi_LastUpdate___hide.equals("null") ) {
%>
      <display:column property="nnmi_lastupdate" sortable="true" titleKey="DL_InterfaceApplicationResources:field.nnmi_lastupdate.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormDL_InterfaceAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="nnmi_id" value="<%= form.getNnmi_id() %>"/>
                <html:hidden property="nnmi_id___hide" value="<%= form.getNnmi_id___hide() %>"/>
                        <html:hidden property="name" value="<%= form.getName() %>"/>
                <html:hidden property="name___hide" value="<%= form.getName___hide() %>"/>
                        <html:hidden property="ne_nnmi_id" value="<%= form.getNe_nnmi_id() %>"/>
                <html:hidden property="ne_nnmi_id___hide" value="<%= form.getNe_nnmi_id___hide() %>"/>
                        <html:hidden property="ec_nnmi_id" value="<%= form.getEc_nnmi_id() %>"/>
                <html:hidden property="ec_nnmi_id___hide" value="<%= form.getEc_nnmi_id___hide() %>"/>
                        <html:hidden property="state" value="<%= form.getState() %>"/>
                <html:hidden property="state___hide" value="<%= form.getState___hide() %>"/>
                        <html:hidden property="statename" value="<%= form.getStatename() %>"/>
                <html:hidden property="statename___hide" value="<%= form.getStatename___hide() %>"/>
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
                        <html:hidden property="description" value="<%= form.getDescription() %>"/>
                <html:hidden property="description___hide" value="<%= form.getDescription___hide() %>"/>
                        <html:hidden property="ifindex" value="<%= form.getIfindex() %>"/>
                <html:hidden property="ifindex___hide" value="<%= form.getIfindex___hide() %>"/>
                        <html:hidden property="activationstate" value="<%= form.getActivationstate() %>"/>
                <html:hidden property="activationstate___hide" value="<%= form.getActivationstate___hide() %>"/>
                        <html:hidden property="usagestate" value="<%= form.getUsagestate() %>"/>
                <html:hidden property="usagestate___hide" value="<%= form.getUsagestate___hide() %>"/>
                        <html:hidden property="vlanid" value="<%= form.getVlanid() %>"/>
                <html:hidden property="vlanid___hide" value="<%= form.getVlanid___hide() %>"/>
                        <html:hidden property="vlanmode" value="<%= form.getVlanmode() %>"/>
                <html:hidden property="vlanmode___hide" value="<%= form.getVlanmode___hide() %>"/>
                        <html:hidden property="dlci" value="<%= form.getDlci() %>"/>
                <html:hidden property="dlci___hide" value="<%= form.getDlci___hide() %>"/>
                        <html:hidden property="timeslots" value="<%= form.getTimeslots() %>"/>
                <html:hidden property="timeslots___hide" value="<%= form.getTimeslots___hide() %>"/>
                        <html:hidden property="numberofslots" value="<%= form.getNumberofslots() %>"/>
                <html:hidden property="numberofslots___hide" value="<%= form.getNumberofslots___hide() %>"/>
                        <html:hidden property="bandwidth" value="<%= form.getBandwidth() %>"/>
                <html:hidden property="bandwidth___hide" value="<%= form.getBandwidth___hide() %>"/>
                        <html:hidden property="lmitype" value="<%= form.getLmitype() %>"/>
                <html:hidden property="lmitype___hide" value="<%= form.getLmitype___hide() %>"/>
                        <html:hidden property="intftype" value="<%= form.getIntftype() %>"/>
                <html:hidden property="intftype___hide" value="<%= form.getIntftype___hide() %>"/>
                        <html:hidden property="bundlekey" value="<%= form.getBundlekey() %>"/>
                <html:hidden property="bundlekey___hide" value="<%= form.getBundlekey___hide() %>"/>
                        <html:hidden property="bundleid" value="<%= form.getBundleid() %>"/>
                <html:hidden property="bundleid___hide" value="<%= form.getBundleid___hide() %>"/>
                        <html:hidden property="nnmi_uuid" value="<%= form.getNnmi_uuid() %>"/>
                <html:hidden property="nnmi_uuid___hide" value="<%= form.getNnmi_uuid___hide() %>"/>
                        <html:hidden property="nnmi_lastupdate" value="<%= form.getNnmi_lastupdate() %>"/>
                  <html:hidden property="nnmi_lastupdate___" value="<%= form.getNnmi_lastupdate___() %>"/>
                <html:hidden property="nnmi_lastupdate___hide" value="<%= form.getNnmi_lastupdate___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="nnmi_id" value="<%= request.getParameter(\"nnmi_id\") %>"/>
                <html:hidden property="nnmi_id___hide" value="<%= request.getParameter(\"nnmi_id___hide\") %>"/>
                        <html:hidden property="name" value="<%= request.getParameter(\"name\") %>"/>
                <html:hidden property="name___hide" value="<%= request.getParameter(\"name___hide\") %>"/>
                        <html:hidden property="ne_nnmi_id" value="<%= request.getParameter(\"ne_nnmi_id\") %>"/>
                <html:hidden property="ne_nnmi_id___hide" value="<%= request.getParameter(\"ne_nnmi_id___hide\") %>"/>
                        <html:hidden property="ec_nnmi_id" value="<%= request.getParameter(\"ec_nnmi_id\") %>"/>
                <html:hidden property="ec_nnmi_id___hide" value="<%= request.getParameter(\"ec_nnmi_id___hide\") %>"/>
                        <html:hidden property="state" value="<%= request.getParameter(\"state\") %>"/>
                <html:hidden property="state___hide" value="<%= request.getParameter(\"state___hide\") %>"/>
                        <html:hidden property="statename" value="<%= request.getParameter(\"statename\") %>"/>
                <html:hidden property="statename___hide" value="<%= request.getParameter(\"statename___hide\") %>"/>
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
                        <html:hidden property="description" value="<%= request.getParameter(\"description\") %>"/>
                <html:hidden property="description___hide" value="<%= request.getParameter(\"description___hide\") %>"/>
                        <html:hidden property="ifindex" value="<%= request.getParameter(\"ifindex\") %>"/>
                <html:hidden property="ifindex___hide" value="<%= request.getParameter(\"ifindex___hide\") %>"/>
                        <html:hidden property="activationstate" value="<%= request.getParameter(\"activationstate\") %>"/>
                <html:hidden property="activationstate___hide" value="<%= request.getParameter(\"activationstate___hide\") %>"/>
                        <html:hidden property="usagestate" value="<%= request.getParameter(\"usagestate\") %>"/>
                <html:hidden property="usagestate___hide" value="<%= request.getParameter(\"usagestate___hide\") %>"/>
                        <html:hidden property="vlanid" value="<%= request.getParameter(\"vlanid\") %>"/>
                <html:hidden property="vlanid___hide" value="<%= request.getParameter(\"vlanid___hide\") %>"/>
                        <html:hidden property="vlanmode" value="<%= request.getParameter(\"vlanmode\") %>"/>
                <html:hidden property="vlanmode___hide" value="<%= request.getParameter(\"vlanmode___hide\") %>"/>
                        <html:hidden property="dlci" value="<%= request.getParameter(\"dlci\") %>"/>
                <html:hidden property="dlci___hide" value="<%= request.getParameter(\"dlci___hide\") %>"/>
                        <html:hidden property="timeslots" value="<%= request.getParameter(\"timeslots\") %>"/>
                <html:hidden property="timeslots___hide" value="<%= request.getParameter(\"timeslots___hide\") %>"/>
                        <html:hidden property="numberofslots" value="<%= request.getParameter(\"numberofslots\") %>"/>
                <html:hidden property="numberofslots___hide" value="<%= request.getParameter(\"numberofslots___hide\") %>"/>
                        <html:hidden property="bandwidth" value="<%= request.getParameter(\"bandwidth\") %>"/>
                <html:hidden property="bandwidth___hide" value="<%= request.getParameter(\"bandwidth___hide\") %>"/>
                        <html:hidden property="lmitype" value="<%= request.getParameter(\"lmitype\") %>"/>
                <html:hidden property="lmitype___hide" value="<%= request.getParameter(\"lmitype___hide\") %>"/>
                        <html:hidden property="intftype" value="<%= request.getParameter(\"intftype\") %>"/>
                <html:hidden property="intftype___hide" value="<%= request.getParameter(\"intftype___hide\") %>"/>
                        <html:hidden property="bundlekey" value="<%= request.getParameter(\"bundlekey\") %>"/>
                <html:hidden property="bundlekey___hide" value="<%= request.getParameter(\"bundlekey___hide\") %>"/>
                        <html:hidden property="bundleid" value="<%= request.getParameter(\"bundleid\") %>"/>
                <html:hidden property="bundleid___hide" value="<%= request.getParameter(\"bundleid___hide\") %>"/>
                        <html:hidden property="nnmi_uuid" value="<%= request.getParameter(\"nnmi_uuid\") %>"/>
                <html:hidden property="nnmi_uuid___hide" value="<%= request.getParameter(\"nnmi_uuid___hide\") %>"/>
                        <html:hidden property="nnmi_lastupdate" value="<%= request.getParameter(\"nnmi_lastupdate\") %>"/>
                  <html:hidden property="nnmi_lastupdate___" value="<%= request.getParameter(\"nnmi_lastupdate___\") %>"/>
                <html:hidden property="nnmi_lastupdate___hide" value="<%= request.getParameter(\"nnmi_lastupdate___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.DL_InterfaceForm.submit()"/>
  </html:form>

  </body>
</html>
  
