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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(ASBRAccessFlowConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(ASBRAccessFlowConstants.DATASOURCE);
String tabName = request.getParameter(ASBRAccessFlowConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

ASBRAccessFlowForm form = (ASBRAccessFlowForm) request.getAttribute("ASBRAccessFlowForm");


String ASBRServiceId___hide = null;
String ConnectionID___hide = null;
String VPNId___hide = null;
String NetworkId1___hide = null;
String Topology1___hide = null;
String NetworkId2___hide = null;
String Topology2___hide = null;
String VlanId___hide = null;
String IPNet___hide = null;
String Netmask___hide = null;
String Status___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListASBRAccessFlow.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  ASBRServiceId___hide = form.getAsbrserviceid___hide();
  ConnectionID___hide = form.getConnectionid___hide();
  VPNId___hide = form.getVpnid___hide();
  NetworkId1___hide = form.getNetworkid1___hide();
  Topology1___hide = form.getTopology1___hide();
  NetworkId2___hide = form.getNetworkid2___hide();
  Topology2___hide = form.getTopology2___hide();
  VlanId___hide = form.getVlanid___hide();
  IPNet___hide = form.getIpnet___hide();
  Netmask___hide = form.getNetmask___hide();
  Status___hide = form.getStatus___hide();

  if ( ASBRServiceId___hide != null )
    requestURI.append("asbrserviceid___hide=" + ASBRServiceId___hide);
  if ( ConnectionID___hide != null )
    requestURI.append("connectionid___hide=" + ConnectionID___hide);
  if ( VPNId___hide != null )
    requestURI.append("vpnid___hide=" + VPNId___hide);
  if ( NetworkId1___hide != null )
    requestURI.append("networkid1___hide=" + NetworkId1___hide);
  if ( Topology1___hide != null )
    requestURI.append("topology1___hide=" + Topology1___hide);
  if ( NetworkId2___hide != null )
    requestURI.append("networkid2___hide=" + NetworkId2___hide);
  if ( Topology2___hide != null )
    requestURI.append("topology2___hide=" + Topology2___hide);
  if ( VlanId___hide != null )
    requestURI.append("vlanid___hide=" + VlanId___hide);
  if ( IPNet___hide != null )
    requestURI.append("ipnet___hide=" + IPNet___hide);
  if ( Netmask___hide != null )
    requestURI.append("netmask___hide=" + Netmask___hide);
  if ( Status___hide != null )
    requestURI.append("status___hide=" + Status___hide);

} else {

    ASBRServiceId___hide = request.getParameter("asbrserviceid___hide");
    ConnectionID___hide = request.getParameter("connectionid___hide");
    VPNId___hide = request.getParameter("vpnid___hide");
    NetworkId1___hide = request.getParameter("networkid1___hide");
    Topology1___hide = request.getParameter("topology1___hide");
    NetworkId2___hide = request.getParameter("networkid2___hide");
    Topology2___hide = request.getParameter("topology2___hide");
    VlanId___hide = request.getParameter("vlanid___hide");
    IPNet___hide = request.getParameter("ipnet___hide");
    Netmask___hide = request.getParameter("netmask___hide");
    Status___hide = request.getParameter("status___hide");

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
    <title><bean:message bundle="ASBRAccessFlowApplicationResources" key="<%= ASBRAccessFlowConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="ASBRAccessFlowApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitASBRAccessFlowAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( ASBRServiceId___hide == null || ASBRServiceId___hide.equals("null") ) {
%>
      <display:column property="asbrserviceid" sortable="true" titleKey="ASBRAccessFlowApplicationResources:field.asbrserviceid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ConnectionID___hide == null || ConnectionID___hide.equals("null") ) {
%>
      <display:column property="connectionid" sortable="true" titleKey="ASBRAccessFlowApplicationResources:field.connectionid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VPNId___hide == null || VPNId___hide.equals("null") ) {
%>
      <display:column property="vpnid" sortable="true" titleKey="ASBRAccessFlowApplicationResources:field.vpnid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NetworkId1___hide == null || NetworkId1___hide.equals("null") ) {
%>
      <display:column property="networkid1" sortable="true" titleKey="ASBRAccessFlowApplicationResources:field.networkid1.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Topology1___hide == null || Topology1___hide.equals("null") ) {
%>
      <display:column property="topology1" sortable="true" titleKey="ASBRAccessFlowApplicationResources:field.topology1.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NetworkId2___hide == null || NetworkId2___hide.equals("null") ) {
%>
      <display:column property="networkid2" sortable="true" titleKey="ASBRAccessFlowApplicationResources:field.networkid2.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Topology2___hide == null || Topology2___hide.equals("null") ) {
%>
      <display:column property="topology2" sortable="true" titleKey="ASBRAccessFlowApplicationResources:field.topology2.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VlanId___hide == null || VlanId___hide.equals("null") ) {
%>
      <display:column property="vlanid" sortable="true" titleKey="ASBRAccessFlowApplicationResources:field.vlanid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IPNet___hide == null || IPNet___hide.equals("null") ) {
%>
      <display:column property="ipnet" sortable="true" titleKey="ASBRAccessFlowApplicationResources:field.ipnet.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Netmask___hide == null || Netmask___hide.equals("null") ) {
%>
      <display:column property="netmask" sortable="true" titleKey="ASBRAccessFlowApplicationResources:field.netmask.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Status___hide == null || Status___hide.equals("null") ) {
%>
      <display:column property="status" sortable="true" titleKey="ASBRAccessFlowApplicationResources:field.status.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormASBRAccessFlowAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="asbrserviceid" value="<%= form.getAsbrserviceid() %>"/>
                <html:hidden property="asbrserviceid___hide" value="<%= form.getAsbrserviceid___hide() %>"/>
                        <html:hidden property="connectionid" value="<%= form.getConnectionid() %>"/>
                <html:hidden property="connectionid___hide" value="<%= form.getConnectionid___hide() %>"/>
                        <html:hidden property="vpnid" value="<%= form.getVpnid() %>"/>
                <html:hidden property="vpnid___hide" value="<%= form.getVpnid___hide() %>"/>
                        <html:hidden property="networkid1" value="<%= form.getNetworkid1() %>"/>
                <html:hidden property="networkid1___hide" value="<%= form.getNetworkid1___hide() %>"/>
                                  <html:hidden property="topology1" value="<%= form.getTopology1() %>"/>
                <html:hidden property="topology1___hide" value="<%= form.getTopology1___hide() %>"/>
                        <html:hidden property="networkid2" value="<%= form.getNetworkid2() %>"/>
                <html:hidden property="networkid2___hide" value="<%= form.getNetworkid2___hide() %>"/>
                                  <html:hidden property="topology2" value="<%= form.getTopology2() %>"/>
                <html:hidden property="topology2___hide" value="<%= form.getTopology2___hide() %>"/>
                        <html:hidden property="vlanid" value="<%= form.getVlanid() %>"/>
                <html:hidden property="vlanid___hide" value="<%= form.getVlanid___hide() %>"/>
                        <html:hidden property="ipnet" value="<%= form.getIpnet() %>"/>
                <html:hidden property="ipnet___hide" value="<%= form.getIpnet___hide() %>"/>
                        <html:hidden property="netmask" value="<%= form.getNetmask() %>"/>
                <html:hidden property="netmask___hide" value="<%= form.getNetmask___hide() %>"/>
                        <html:hidden property="status" value="<%= form.getStatus() %>"/>
                <html:hidden property="status___hide" value="<%= form.getStatus___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="asbrserviceid" value="<%= request.getParameter(\"asbrserviceid\") %>"/>
                <html:hidden property="asbrserviceid___hide" value="<%= request.getParameter(\"asbrserviceid___hide\") %>"/>
                        <html:hidden property="connectionid" value="<%= request.getParameter(\"connectionid\") %>"/>
                <html:hidden property="connectionid___hide" value="<%= request.getParameter(\"connectionid___hide\") %>"/>
                        <html:hidden property="vpnid" value="<%= request.getParameter(\"vpnid\") %>"/>
                <html:hidden property="vpnid___hide" value="<%= request.getParameter(\"vpnid___hide\") %>"/>
                        <html:hidden property="networkid1" value="<%= request.getParameter(\"networkid1\") %>"/>
                <html:hidden property="networkid1___hide" value="<%= request.getParameter(\"networkid1___hide\") %>"/>
                                  <html:hidden property="topology1" value="<%= request.getParameter(\"topology1\") %>"/>
                <html:hidden property="topology1___hide" value="<%= request.getParameter(\"topology1___hide\") %>"/>
                        <html:hidden property="networkid2" value="<%= request.getParameter(\"networkid2\") %>"/>
                <html:hidden property="networkid2___hide" value="<%= request.getParameter(\"networkid2___hide\") %>"/>
                                  <html:hidden property="topology2" value="<%= request.getParameter(\"topology2\") %>"/>
                <html:hidden property="topology2___hide" value="<%= request.getParameter(\"topology2___hide\") %>"/>
                        <html:hidden property="vlanid" value="<%= request.getParameter(\"vlanid\") %>"/>
                <html:hidden property="vlanid___hide" value="<%= request.getParameter(\"vlanid___hide\") %>"/>
                        <html:hidden property="ipnet" value="<%= request.getParameter(\"ipnet\") %>"/>
                <html:hidden property="ipnet___hide" value="<%= request.getParameter(\"ipnet___hide\") %>"/>
                        <html:hidden property="netmask" value="<%= request.getParameter(\"netmask\") %>"/>
                <html:hidden property="netmask___hide" value="<%= request.getParameter(\"netmask___hide\") %>"/>
                        <html:hidden property="status" value="<%= request.getParameter(\"status\") %>"/>
                <html:hidden property="status___hide" value="<%= request.getParameter(\"status___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.ASBRAccessFlowForm.submit()"/>
  </html:form>

  </body>
</html>
  
