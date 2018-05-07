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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(ServiceMultiplexConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(ServiceMultiplexConstants.DATASOURCE);
String tabName = request.getParameter(ServiceMultiplexConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

ServiceMultiplexForm form = (ServiceMultiplexForm) request.getAttribute("ServiceMultiplexForm");


String ServiceMultiplexId___hide = null;
String Vendor___hide = null;
String CardType___hide = null;
String ExistingServiceType___hide = null;
String RequestedServiceType___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListServiceMultiplex.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  ServiceMultiplexId___hide = form.getServicemultiplexid___hide();
  Vendor___hide = form.getVendor___hide();
  CardType___hide = form.getCardtype___hide();
  ExistingServiceType___hide = form.getExistingservicetype___hide();
  RequestedServiceType___hide = form.getRequestedservicetype___hide();

  if ( ServiceMultiplexId___hide != null )
    requestURI.append("servicemultiplexid___hide=" + ServiceMultiplexId___hide);
  if ( Vendor___hide != null )
    requestURI.append("vendor___hide=" + Vendor___hide);
  if ( CardType___hide != null )
    requestURI.append("cardtype___hide=" + CardType___hide);
  if ( ExistingServiceType___hide != null )
    requestURI.append("existingservicetype___hide=" + ExistingServiceType___hide);
  if ( RequestedServiceType___hide != null )
    requestURI.append("requestedservicetype___hide=" + RequestedServiceType___hide);

} else {

    ServiceMultiplexId___hide = request.getParameter("servicemultiplexid___hide");
    Vendor___hide = request.getParameter("vendor___hide");
    CardType___hide = request.getParameter("cardtype___hide");
    ExistingServiceType___hide = request.getParameter("existingservicetype___hide");
    RequestedServiceType___hide = request.getParameter("requestedservicetype___hide");

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
    <title><bean:message bundle="ServiceMultiplexApplicationResources" key="<%= ServiceMultiplexConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="ServiceMultiplexApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitServiceMultiplexAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( ServiceMultiplexId___hide == null || ServiceMultiplexId___hide.equals("null") ) {
%>
      <display:column property="servicemultiplexid" sortable="true" titleKey="ServiceMultiplexApplicationResources:field.servicemultiplexid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Vendor___hide == null || Vendor___hide.equals("null") ) {
%>
      <display:column property="vendor" sortable="true" titleKey="ServiceMultiplexApplicationResources:field.vendor.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CardType___hide == null || CardType___hide.equals("null") ) {
%>
      <display:column property="cardtype" sortable="true" titleKey="ServiceMultiplexApplicationResources:field.cardtype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ExistingServiceType___hide == null || ExistingServiceType___hide.equals("null") ) {
%>
      <display:column property="existingservicetype" sortable="true" titleKey="ServiceMultiplexApplicationResources:field.existingservicetype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RequestedServiceType___hide == null || RequestedServiceType___hide.equals("null") ) {
%>
      <display:column property="requestedservicetype" sortable="true" titleKey="ServiceMultiplexApplicationResources:field.requestedservicetype.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormServiceMultiplexAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="servicemultiplexid" value="<%= form.getServicemultiplexid() %>"/>
                <html:hidden property="servicemultiplexid___hide" value="<%= form.getServicemultiplexid___hide() %>"/>
                        <html:hidden property="vendor" value="<%= form.getVendor() %>"/>
                <html:hidden property="vendor___hide" value="<%= form.getVendor___hide() %>"/>
                        <html:hidden property="cardtype" value="<%= form.getCardtype() %>"/>
                <html:hidden property="cardtype___hide" value="<%= form.getCardtype___hide() %>"/>
                        <html:hidden property="existingservicetype" value="<%= form.getExistingservicetype() %>"/>
                <html:hidden property="existingservicetype___hide" value="<%= form.getExistingservicetype___hide() %>"/>
                        <html:hidden property="requestedservicetype" value="<%= form.getRequestedservicetype() %>"/>
                <html:hidden property="requestedservicetype___hide" value="<%= form.getRequestedservicetype___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="servicemultiplexid" value="<%= request.getParameter(\"servicemultiplexid\") %>"/>
                <html:hidden property="servicemultiplexid___hide" value="<%= request.getParameter(\"servicemultiplexid___hide\") %>"/>
                        <html:hidden property="vendor" value="<%= request.getParameter(\"vendor\") %>"/>
                <html:hidden property="vendor___hide" value="<%= request.getParameter(\"vendor___hide\") %>"/>
                        <html:hidden property="cardtype" value="<%= request.getParameter(\"cardtype\") %>"/>
                <html:hidden property="cardtype___hide" value="<%= request.getParameter(\"cardtype___hide\") %>"/>
                        <html:hidden property="existingservicetype" value="<%= request.getParameter(\"existingservicetype\") %>"/>
                <html:hidden property="existingservicetype___hide" value="<%= request.getParameter(\"existingservicetype___hide\") %>"/>
                        <html:hidden property="requestedservicetype" value="<%= request.getParameter(\"requestedservicetype\") %>"/>
                <html:hidden property="requestedservicetype___hide" value="<%= request.getParameter(\"requestedservicetype___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.ServiceMultiplexForm.submit()"/>
  </html:form>

  </body>
</html>
  
