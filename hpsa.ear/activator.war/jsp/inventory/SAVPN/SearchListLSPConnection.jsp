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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(LSPConnectionConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(LSPConnectionConstants.DATASOURCE);
String tabName = request.getParameter(LSPConnectionConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

LSPConnectionForm form = (LSPConnectionForm) request.getAttribute("LSPConnectionForm");


String headPE___hide = null;
String tailPE___hide = null;
String UsageMode___hide = null;
String VpnId___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListLSPConnection.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  headPE___hide = form.getHeadpe___hide();
  tailPE___hide = form.getTailpe___hide();
  UsageMode___hide = form.getUsagemode___hide();
  VpnId___hide = form.getVpnid___hide();

  if ( headPE___hide != null )
    requestURI.append("headpe___hide=" + headPE___hide);
  if ( tailPE___hide != null )
    requestURI.append("tailpe___hide=" + tailPE___hide);
  if ( UsageMode___hide != null )
    requestURI.append("usagemode___hide=" + UsageMode___hide);
  if ( VpnId___hide != null )
    requestURI.append("vpnid___hide=" + VpnId___hide);

} else {

    headPE___hide = request.getParameter("headpe___hide");
    tailPE___hide = request.getParameter("tailpe___hide");
    UsageMode___hide = request.getParameter("usagemode___hide");
    VpnId___hide = request.getParameter("vpnid___hide");

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
    <title><bean:message bundle="LSPConnectionApplicationResources" key="<%= LSPConnectionConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="LSPConnectionApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitLSPConnectionAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( headPE___hide == null || headPE___hide.equals("null") ) {
%>
      <display:column property="headpe" sortable="true" titleKey="LSPConnectionApplicationResources:field.headpe.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( tailPE___hide == null || tailPE___hide.equals("null") ) {
%>
      <display:column property="tailpe" sortable="true" titleKey="LSPConnectionApplicationResources:field.tailpe.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UsageMode___hide == null || UsageMode___hide.equals("null") ) {
%>
      <display:column property="usagemode" sortable="true" titleKey="LSPConnectionApplicationResources:field.usagemode.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VpnId___hide == null || VpnId___hide.equals("null") ) {
%>
      <display:column property="vpnid" sortable="true" titleKey="LSPConnectionApplicationResources:field.vpnid.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormLSPConnectionAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="headpe" value="<%= form.getHeadpe() %>"/>
                <html:hidden property="headpe___hide" value="<%= form.getHeadpe___hide() %>"/>
                        <html:hidden property="tailpe" value="<%= form.getTailpe() %>"/>
                <html:hidden property="tailpe___hide" value="<%= form.getTailpe___hide() %>"/>
                        <html:hidden property="usagemode" value="<%= form.getUsagemode() %>"/>
                <html:hidden property="usagemode___hide" value="<%= form.getUsagemode___hide() %>"/>
                        <html:hidden property="vpnid" value="<%= form.getVpnid() %>"/>
                <html:hidden property="vpnid___hide" value="<%= form.getVpnid___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="headpe" value="<%= request.getParameter(\"headpe\") %>"/>
                <html:hidden property="headpe___hide" value="<%= request.getParameter(\"headpe___hide\") %>"/>
                        <html:hidden property="tailpe" value="<%= request.getParameter(\"tailpe\") %>"/>
                <html:hidden property="tailpe___hide" value="<%= request.getParameter(\"tailpe___hide\") %>"/>
                        <html:hidden property="usagemode" value="<%= request.getParameter(\"usagemode\") %>"/>
                <html:hidden property="usagemode___hide" value="<%= request.getParameter(\"usagemode___hide\") %>"/>
                        <html:hidden property="vpnid" value="<%= request.getParameter(\"vpnid\") %>"/>
                <html:hidden property="vpnid___hide" value="<%= request.getParameter(\"vpnid___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.LSPConnectionForm.submit()"/>
  </html:form>

  </body>
</html>
  
