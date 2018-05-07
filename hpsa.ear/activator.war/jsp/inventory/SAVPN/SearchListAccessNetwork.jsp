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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(AccessNetworkConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(AccessNetworkConstants.DATASOURCE);
String tabName = request.getParameter(AccessNetworkConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

AccessNetworkForm form = (AccessNetworkForm) request.getAttribute("AccessNetworkForm");


String NetworkId___hide = null;
String Name___hide = null;
String Type___hide = null;
String ASN___hide = null;
String Region___hide = null;
String ParentNetworkId___hide = null;
String State___hide = null;
String ManagementVlans___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListAccessNetwork.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  NetworkId___hide = form.getNetworkid___hide();
  Name___hide = form.getName___hide();
  Type___hide = form.getType___hide();
  ASN___hide = form.getAsn___hide();
  Region___hide = form.getRegion___hide();
  ParentNetworkId___hide = form.getParentnetworkid___hide();
  State___hide = form.getState___hide();
  ManagementVlans___hide = form.getManagementvlans___hide();

  if ( NetworkId___hide != null )
    requestURI.append("networkid___hide=" + NetworkId___hide);
  if ( Name___hide != null )
    requestURI.append("name___hide=" + Name___hide);
  if ( Type___hide != null )
    requestURI.append("type___hide=" + Type___hide);
  if ( ASN___hide != null )
    requestURI.append("asn___hide=" + ASN___hide);
  if ( Region___hide != null )
    requestURI.append("region___hide=" + Region___hide);
  if ( ParentNetworkId___hide != null )
    requestURI.append("parentnetworkid___hide=" + ParentNetworkId___hide);
  if ( State___hide != null )
    requestURI.append("state___hide=" + State___hide);
  if ( ManagementVlans___hide != null )
    requestURI.append("managementvlans___hide=" + ManagementVlans___hide);

} else {

    NetworkId___hide = request.getParameter("networkid___hide");
    Name___hide = request.getParameter("name___hide");
    Type___hide = request.getParameter("type___hide");
    ASN___hide = request.getParameter("asn___hide");
    Region___hide = request.getParameter("region___hide");
    ParentNetworkId___hide = request.getParameter("parentnetworkid___hide");
    State___hide = request.getParameter("state___hide");
    ManagementVlans___hide = request.getParameter("managementvlans___hide");

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
    <title><bean:message bundle="AccessNetworkApplicationResources" key="<%= AccessNetworkConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="AccessNetworkApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitAccessNetworkAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( NetworkId___hide == null || NetworkId___hide.equals("null") ) {
%>
      <display:column property="networkid" sortable="true" titleKey="AccessNetworkApplicationResources:field.networkid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Name___hide == null || Name___hide.equals("null") ) {
%>
      <display:column property="name" sortable="true" titleKey="AccessNetworkApplicationResources:field.name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Type___hide == null || Type___hide.equals("null") ) {
%>
      <display:column property="type" sortable="true" titleKey="AccessNetworkApplicationResources:field.type.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ASN___hide == null || ASN___hide.equals("null") ) {
%>
      <display:column property="asn" sortable="true" titleKey="AccessNetworkApplicationResources:field.asn.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Region___hide == null || Region___hide.equals("null") ) {
%>
      <display:column property="region" sortable="true" titleKey="AccessNetworkApplicationResources:field.region.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ParentNetworkId___hide == null || ParentNetworkId___hide.equals("null") ) {
%>
      <display:column property="parentnetworkid" sortable="true" titleKey="AccessNetworkApplicationResources:field.parentnetworkid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( State___hide == null || State___hide.equals("null") ) {
%>
      <display:column property="state" sortable="true" titleKey="AccessNetworkApplicationResources:field.state.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ManagementVlans___hide == null || ManagementVlans___hide.equals("null") ) {
%>
      <display:column property="managementvlans" sortable="true" titleKey="AccessNetworkApplicationResources:field.managementvlans.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormAccessNetworkAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="networkid" value="<%= form.getNetworkid() %>"/>
                <html:hidden property="networkid___hide" value="<%= form.getNetworkid___hide() %>"/>
                        <html:hidden property="name" value="<%= form.getName() %>"/>
                <html:hidden property="name___hide" value="<%= form.getName___hide() %>"/>
                        <html:hidden property="type" value="<%= form.getType() %>"/>
                <html:hidden property="type___hide" value="<%= form.getType___hide() %>"/>
                        <html:hidden property="asn" value="<%= form.getAsn() %>"/>
                <html:hidden property="asn___hide" value="<%= form.getAsn___hide() %>"/>
                        <html:hidden property="region" value="<%= form.getRegion() %>"/>
                <html:hidden property="region___hide" value="<%= form.getRegion___hide() %>"/>
                        <html:hidden property="parentnetworkid" value="<%= form.getParentnetworkid() %>"/>
                <html:hidden property="parentnetworkid___hide" value="<%= form.getParentnetworkid___hide() %>"/>
                        <html:hidden property="state" value="<%= form.getState() %>"/>
                <html:hidden property="state___hide" value="<%= form.getState___hide() %>"/>
                        <html:hidden property="managementvlans" value="<%= form.getManagementvlans() %>"/>
                <html:hidden property="managementvlans___hide" value="<%= form.getManagementvlans___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="networkid" value="<%= request.getParameter(\"networkid\") %>"/>
                <html:hidden property="networkid___hide" value="<%= request.getParameter(\"networkid___hide\") %>"/>
                        <html:hidden property="name" value="<%= request.getParameter(\"name\") %>"/>
                <html:hidden property="name___hide" value="<%= request.getParameter(\"name___hide\") %>"/>
                        <html:hidden property="type" value="<%= request.getParameter(\"type\") %>"/>
                <html:hidden property="type___hide" value="<%= request.getParameter(\"type___hide\") %>"/>
                        <html:hidden property="asn" value="<%= request.getParameter(\"asn\") %>"/>
                <html:hidden property="asn___hide" value="<%= request.getParameter(\"asn___hide\") %>"/>
                        <html:hidden property="region" value="<%= request.getParameter(\"region\") %>"/>
                <html:hidden property="region___hide" value="<%= request.getParameter(\"region___hide\") %>"/>
                        <html:hidden property="parentnetworkid" value="<%= request.getParameter(\"parentnetworkid\") %>"/>
                <html:hidden property="parentnetworkid___hide" value="<%= request.getParameter(\"parentnetworkid___hide\") %>"/>
                        <html:hidden property="state" value="<%= request.getParameter(\"state\") %>"/>
                <html:hidden property="state___hide" value="<%= request.getParameter(\"state___hide\") %>"/>
                        <html:hidden property="managementvlans" value="<%= request.getParameter(\"managementvlans\") %>"/>
                <html:hidden property="managementvlans___hide" value="<%= request.getParameter(\"managementvlans___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.AccessNetworkForm.submit()"/>
  </html:form>

  </body>
</html>
  
