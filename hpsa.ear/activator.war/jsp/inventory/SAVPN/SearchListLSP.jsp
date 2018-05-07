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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(LSPConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(LSPConstants.DATASOURCE);
String tabName = request.getParameter(LSPConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

LSPForm form = (LSPForm) request.getAttribute("LSPForm");


String LSPId___hide = null;
String TunnelId___hide = null;
String headPE___hide = null;
String tailPE___hide = null;
String headIP___hide = null;
String tailIP___hide = null;
String headVPNIP___hide = null;
String tailVPNIP___hide = null;
String Bandwidth___hide = null;
String TerminationPointID___hide = null;
String ActivationState___hide = null;
String AdminState___hide = null;
String ActivationDate___hide = null;
String ModificationDate___hide = null;
String LSPProfileName___hide = null;
String UsageMode___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListLSP.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  LSPId___hide = form.getLspid___hide();
  TunnelId___hide = form.getTunnelid___hide();
  headPE___hide = form.getHeadpe___hide();
  tailPE___hide = form.getTailpe___hide();
  headIP___hide = form.getHeadip___hide();
  tailIP___hide = form.getTailip___hide();
  headVPNIP___hide = form.getHeadvpnip___hide();
  tailVPNIP___hide = form.getTailvpnip___hide();
  Bandwidth___hide = form.getBandwidth___hide();
  TerminationPointID___hide = form.getTerminationpointid___hide();
  ActivationState___hide = form.getActivationstate___hide();
  AdminState___hide = form.getAdminstate___hide();
  ActivationDate___hide = form.getActivationdate___hide();
  ModificationDate___hide = form.getModificationdate___hide();
  LSPProfileName___hide = form.getLspprofilename___hide();
  UsageMode___hide = form.getUsagemode___hide();

  if ( LSPId___hide != null )
    requestURI.append("lspid___hide=" + LSPId___hide);
  if ( TunnelId___hide != null )
    requestURI.append("tunnelid___hide=" + TunnelId___hide);
  if ( headPE___hide != null )
    requestURI.append("headpe___hide=" + headPE___hide);
  if ( tailPE___hide != null )
    requestURI.append("tailpe___hide=" + tailPE___hide);
  if ( headIP___hide != null )
    requestURI.append("headip___hide=" + headIP___hide);
  if ( tailIP___hide != null )
    requestURI.append("tailip___hide=" + tailIP___hide);
  if ( headVPNIP___hide != null )
    requestURI.append("headvpnip___hide=" + headVPNIP___hide);
  if ( tailVPNIP___hide != null )
    requestURI.append("tailvpnip___hide=" + tailVPNIP___hide);
  if ( Bandwidth___hide != null )
    requestURI.append("bandwidth___hide=" + Bandwidth___hide);
  if ( TerminationPointID___hide != null )
    requestURI.append("terminationpointid___hide=" + TerminationPointID___hide);
  if ( ActivationState___hide != null )
    requestURI.append("activationstate___hide=" + ActivationState___hide);
  if ( AdminState___hide != null )
    requestURI.append("adminstate___hide=" + AdminState___hide);
  if ( ActivationDate___hide != null )
    requestURI.append("activationdate___hide=" + ActivationDate___hide);
  if ( ModificationDate___hide != null )
    requestURI.append("modificationdate___hide=" + ModificationDate___hide);
  if ( LSPProfileName___hide != null )
    requestURI.append("lspprofilename___hide=" + LSPProfileName___hide);
  if ( UsageMode___hide != null )
    requestURI.append("usagemode___hide=" + UsageMode___hide);

} else {

    LSPId___hide = request.getParameter("lspid___hide");
    TunnelId___hide = request.getParameter("tunnelid___hide");
    headPE___hide = request.getParameter("headpe___hide");
    tailPE___hide = request.getParameter("tailpe___hide");
    headIP___hide = request.getParameter("headip___hide");
    tailIP___hide = request.getParameter("tailip___hide");
    headVPNIP___hide = request.getParameter("headvpnip___hide");
    tailVPNIP___hide = request.getParameter("tailvpnip___hide");
    Bandwidth___hide = request.getParameter("bandwidth___hide");
    TerminationPointID___hide = request.getParameter("terminationpointid___hide");
    ActivationState___hide = request.getParameter("activationstate___hide");
    AdminState___hide = request.getParameter("adminstate___hide");
    ActivationDate___hide = request.getParameter("activationdate___hide");
    ModificationDate___hide = request.getParameter("modificationdate___hide");
    LSPProfileName___hide = request.getParameter("lspprofilename___hide");
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
    <title><bean:message bundle="LSPApplicationResources" key="<%= LSPConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="LSPApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitLSPAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( LSPId___hide == null || LSPId___hide.equals("null") ) {
%>
      <display:column property="lspid" sortable="true" titleKey="LSPApplicationResources:field.lspid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( TunnelId___hide == null || TunnelId___hide.equals("null") ) {
%>
      <display:column property="tunnelid" sortable="true" titleKey="LSPApplicationResources:field.tunnelid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( headPE___hide == null || headPE___hide.equals("null") ) {
%>
      <display:column property="headpe" sortable="true" titleKey="LSPApplicationResources:field.headpe.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( tailPE___hide == null || tailPE___hide.equals("null") ) {
%>
      <display:column property="tailpe" sortable="true" titleKey="LSPApplicationResources:field.tailpe.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( headIP___hide == null || headIP___hide.equals("null") ) {
%>
      <display:column property="headip" sortable="true" titleKey="LSPApplicationResources:field.headip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( tailIP___hide == null || tailIP___hide.equals("null") ) {
%>
      <display:column property="tailip" sortable="true" titleKey="LSPApplicationResources:field.tailip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( headVPNIP___hide == null || headVPNIP___hide.equals("null") ) {
%>
      <display:column property="headvpnip" sortable="true" titleKey="LSPApplicationResources:field.headvpnip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( tailVPNIP___hide == null || tailVPNIP___hide.equals("null") ) {
%>
      <display:column property="tailvpnip" sortable="true" titleKey="LSPApplicationResources:field.tailvpnip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Bandwidth___hide == null || Bandwidth___hide.equals("null") ) {
%>
      <display:column property="bandwidth" sortable="true" titleKey="LSPApplicationResources:field.bandwidth.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( TerminationPointID___hide == null || TerminationPointID___hide.equals("null") ) {
%>
      <display:column property="terminationpointid" sortable="true" titleKey="LSPApplicationResources:field.terminationpointid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ActivationState___hide == null || ActivationState___hide.equals("null") ) {
%>
      <display:column property="activationstate" sortable="true" titleKey="LSPApplicationResources:field.activationstate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( AdminState___hide == null || AdminState___hide.equals("null") ) {
%>
      <display:column property="adminstate" sortable="true" titleKey="LSPApplicationResources:field.adminstate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ActivationDate___hide == null || ActivationDate___hide.equals("null") ) {
%>
      <display:column property="activationdate" sortable="true" titleKey="LSPApplicationResources:field.activationdate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ModificationDate___hide == null || ModificationDate___hide.equals("null") ) {
%>
      <display:column property="modificationdate" sortable="true" titleKey="LSPApplicationResources:field.modificationdate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( LSPProfileName___hide == null || LSPProfileName___hide.equals("null") ) {
%>
      <display:column property="lspprofilename" sortable="true" titleKey="LSPApplicationResources:field.lspprofilename.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UsageMode___hide == null || UsageMode___hide.equals("null") ) {
%>
      <display:column property="usagemode" sortable="true" titleKey="LSPApplicationResources:field.usagemode.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormLSPAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="lspid" value="<%= form.getLspid() %>"/>
                <html:hidden property="lspid___hide" value="<%= form.getLspid___hide() %>"/>
                        <html:hidden property="tunnelid" value="<%= form.getTunnelid() %>"/>
                <html:hidden property="tunnelid___hide" value="<%= form.getTunnelid___hide() %>"/>
                        <html:hidden property="headpe" value="<%= form.getHeadpe() %>"/>
                <html:hidden property="headpe___hide" value="<%= form.getHeadpe___hide() %>"/>
                                  <html:hidden property="tailpe" value="<%= form.getTailpe() %>"/>
                <html:hidden property="tailpe___hide" value="<%= form.getTailpe___hide() %>"/>
                                  <html:hidden property="headip" value="<%= form.getHeadip() %>"/>
                <html:hidden property="headip___hide" value="<%= form.getHeadip___hide() %>"/>
                        <html:hidden property="tailip" value="<%= form.getTailip() %>"/>
                <html:hidden property="tailip___hide" value="<%= form.getTailip___hide() %>"/>
                        <html:hidden property="headvpnip" value="<%= form.getHeadvpnip() %>"/>
                <html:hidden property="headvpnip___hide" value="<%= form.getHeadvpnip___hide() %>"/>
                        <html:hidden property="tailvpnip" value="<%= form.getTailvpnip() %>"/>
                <html:hidden property="tailvpnip___hide" value="<%= form.getTailvpnip___hide() %>"/>
                        <html:hidden property="bandwidth" value="<%= form.getBandwidth() %>"/>
                <html:hidden property="bandwidth___hide" value="<%= form.getBandwidth___hide() %>"/>
                        <html:hidden property="terminationpointid" value="<%= form.getTerminationpointid() %>"/>
                <html:hidden property="terminationpointid___hide" value="<%= form.getTerminationpointid___hide() %>"/>
                        <html:hidden property="activationstate" value="<%= form.getActivationstate() %>"/>
                <html:hidden property="activationstate___hide" value="<%= form.getActivationstate___hide() %>"/>
                        <html:hidden property="adminstate" value="<%= form.getAdminstate() %>"/>
                <html:hidden property="adminstate___hide" value="<%= form.getAdminstate___hide() %>"/>
                        <html:hidden property="activationdate" value="<%= form.getActivationdate() %>"/>
                <html:hidden property="activationdate___hide" value="<%= form.getActivationdate___hide() %>"/>
                        <html:hidden property="modificationdate" value="<%= form.getModificationdate() %>"/>
                <html:hidden property="modificationdate___hide" value="<%= form.getModificationdate___hide() %>"/>
                        <html:hidden property="lspprofilename" value="<%= form.getLspprofilename() %>"/>
                <html:hidden property="lspprofilename___hide" value="<%= form.getLspprofilename___hide() %>"/>
                        <html:hidden property="usagemode" value="<%= form.getUsagemode() %>"/>
                <html:hidden property="usagemode___hide" value="<%= form.getUsagemode___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="lspid" value="<%= request.getParameter(\"lspid\") %>"/>
                <html:hidden property="lspid___hide" value="<%= request.getParameter(\"lspid___hide\") %>"/>
                        <html:hidden property="tunnelid" value="<%= request.getParameter(\"tunnelid\") %>"/>
                <html:hidden property="tunnelid___hide" value="<%= request.getParameter(\"tunnelid___hide\") %>"/>
                        <html:hidden property="headpe" value="<%= request.getParameter(\"headpe\") %>"/>
                <html:hidden property="headpe___hide" value="<%= request.getParameter(\"headpe___hide\") %>"/>
                                  <html:hidden property="tailpe" value="<%= request.getParameter(\"tailpe\") %>"/>
                <html:hidden property="tailpe___hide" value="<%= request.getParameter(\"tailpe___hide\") %>"/>
                                  <html:hidden property="headip" value="<%= request.getParameter(\"headip\") %>"/>
                <html:hidden property="headip___hide" value="<%= request.getParameter(\"headip___hide\") %>"/>
                        <html:hidden property="tailip" value="<%= request.getParameter(\"tailip\") %>"/>
                <html:hidden property="tailip___hide" value="<%= request.getParameter(\"tailip___hide\") %>"/>
                        <html:hidden property="headvpnip" value="<%= request.getParameter(\"headvpnip\") %>"/>
                <html:hidden property="headvpnip___hide" value="<%= request.getParameter(\"headvpnip___hide\") %>"/>
                        <html:hidden property="tailvpnip" value="<%= request.getParameter(\"tailvpnip\") %>"/>
                <html:hidden property="tailvpnip___hide" value="<%= request.getParameter(\"tailvpnip___hide\") %>"/>
                        <html:hidden property="bandwidth" value="<%= request.getParameter(\"bandwidth\") %>"/>
                <html:hidden property="bandwidth___hide" value="<%= request.getParameter(\"bandwidth___hide\") %>"/>
                        <html:hidden property="terminationpointid" value="<%= request.getParameter(\"terminationpointid\") %>"/>
                <html:hidden property="terminationpointid___hide" value="<%= request.getParameter(\"terminationpointid___hide\") %>"/>
                        <html:hidden property="activationstate" value="<%= request.getParameter(\"activationstate\") %>"/>
                <html:hidden property="activationstate___hide" value="<%= request.getParameter(\"activationstate___hide\") %>"/>
                        <html:hidden property="adminstate" value="<%= request.getParameter(\"adminstate\") %>"/>
                <html:hidden property="adminstate___hide" value="<%= request.getParameter(\"adminstate___hide\") %>"/>
                        <html:hidden property="activationdate" value="<%= request.getParameter(\"activationdate\") %>"/>
                <html:hidden property="activationdate___hide" value="<%= request.getParameter(\"activationdate___hide\") %>"/>
                        <html:hidden property="modificationdate" value="<%= request.getParameter(\"modificationdate\") %>"/>
                <html:hidden property="modificationdate___hide" value="<%= request.getParameter(\"modificationdate___hide\") %>"/>
                        <html:hidden property="lspprofilename" value="<%= request.getParameter(\"lspprofilename\") %>"/>
                <html:hidden property="lspprofilename___hide" value="<%= request.getParameter(\"lspprofilename___hide\") %>"/>
                        <html:hidden property="usagemode" value="<%= request.getParameter(\"usagemode\") %>"/>
                <html:hidden property="usagemode___hide" value="<%= request.getParameter(\"usagemode___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.LSPForm.submit()"/>
  </html:form>

  </body>
</html>
  
