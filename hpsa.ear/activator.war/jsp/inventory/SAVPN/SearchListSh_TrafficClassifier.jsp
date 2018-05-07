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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(Sh_TrafficClassifierConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(Sh_TrafficClassifierConstants.DATASOURCE);
String tabName = request.getParameter(Sh_TrafficClassifierConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

Sh_TrafficClassifierForm form = (Sh_TrafficClassifierForm) request.getAttribute("Sh_TrafficClassifierForm");


String Name___hide = null;
String CustomerId___hide = null;
String DSCPs___hide = null;
String Filter___hide = null;
String CoSs___hide = null;
String Layer___hide = null;
String Compliant___hide = null;
String Marker___hide = null;
String UploadStatus___hide = null;
String DBPrimaryKey___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListSh_TrafficClassifier.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  Name___hide = form.getName___hide();
  CustomerId___hide = form.getCustomerid___hide();
  DSCPs___hide = form.getDscps___hide();
  Filter___hide = form.getFilter___hide();
  CoSs___hide = form.getCoss___hide();
  Layer___hide = form.getLayer___hide();
  Compliant___hide = form.getCompliant___hide();
  Marker___hide = form.getMarker___hide();
  UploadStatus___hide = form.getUploadstatus___hide();
  DBPrimaryKey___hide = form.getDbprimarykey___hide();

  if ( Name___hide != null )
    requestURI.append("name___hide=" + Name___hide);
  if ( CustomerId___hide != null )
    requestURI.append("customerid___hide=" + CustomerId___hide);
  if ( DSCPs___hide != null )
    requestURI.append("dscps___hide=" + DSCPs___hide);
  if ( Filter___hide != null )
    requestURI.append("filter___hide=" + Filter___hide);
  if ( CoSs___hide != null )
    requestURI.append("coss___hide=" + CoSs___hide);
  if ( Layer___hide != null )
    requestURI.append("layer___hide=" + Layer___hide);
  if ( Compliant___hide != null )
    requestURI.append("compliant___hide=" + Compliant___hide);
  if ( Marker___hide != null )
    requestURI.append("marker___hide=" + Marker___hide);
  if ( UploadStatus___hide != null )
    requestURI.append("uploadstatus___hide=" + UploadStatus___hide);
  if ( DBPrimaryKey___hide != null )
    requestURI.append("dbprimarykey___hide=" + DBPrimaryKey___hide);

} else {

    Name___hide = request.getParameter("name___hide");
    CustomerId___hide = request.getParameter("customerid___hide");
    DSCPs___hide = request.getParameter("dscps___hide");
    Filter___hide = request.getParameter("filter___hide");
    CoSs___hide = request.getParameter("coss___hide");
    Layer___hide = request.getParameter("layer___hide");
    Compliant___hide = request.getParameter("compliant___hide");
    Marker___hide = request.getParameter("marker___hide");
    UploadStatus___hide = request.getParameter("uploadstatus___hide");
    DBPrimaryKey___hide = request.getParameter("dbprimarykey___hide");

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
    <title><bean:message bundle="Sh_TrafficClassifierApplicationResources" key="<%= Sh_TrafficClassifierConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_TrafficClassifierApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitSh_TrafficClassifierAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( Name___hide == null || Name___hide.equals("null") ) {
%>
      <display:column property="name" sortable="true" titleKey="Sh_TrafficClassifierApplicationResources:field.name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CustomerId___hide == null || CustomerId___hide.equals("null") ) {
%>
      <display:column property="customerid" sortable="true" titleKey="Sh_TrafficClassifierApplicationResources:field.customerid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( DSCPs___hide == null || DSCPs___hide.equals("null") ) {
%>
      <display:column property="dscps" sortable="true" titleKey="Sh_TrafficClassifierApplicationResources:field.dscps.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Filter___hide == null || Filter___hide.equals("null") ) {
%>
      <display:column property="filter" sortable="true" titleKey="Sh_TrafficClassifierApplicationResources:field.filter.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CoSs___hide == null || CoSs___hide.equals("null") ) {
%>
      <display:column property="coss" sortable="true" titleKey="Sh_TrafficClassifierApplicationResources:field.coss.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Layer___hide == null || Layer___hide.equals("null") ) {
%>
      <display:column property="layer" sortable="true" titleKey="Sh_TrafficClassifierApplicationResources:field.layer.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Compliant___hide == null || Compliant___hide.equals("null") ) {
%>
      <display:column property="compliant" sortable="true" titleKey="Sh_TrafficClassifierApplicationResources:field.compliant.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Marker___hide == null || Marker___hide.equals("null") ) {
%>
      <display:column property="marker" sortable="true" titleKey="Sh_TrafficClassifierApplicationResources:field.marker.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UploadStatus___hide == null || UploadStatus___hide.equals("null") ) {
%>
      <display:column property="uploadstatus" sortable="true" titleKey="Sh_TrafficClassifierApplicationResources:field.uploadstatus.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( DBPrimaryKey___hide == null || DBPrimaryKey___hide.equals("null") ) {
%>
      <display:column property="dbprimarykey" sortable="true" titleKey="Sh_TrafficClassifierApplicationResources:field.dbprimarykey.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormSh_TrafficClassifierAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="name" value="<%= form.getName() %>"/>
                <html:hidden property="name___hide" value="<%= form.getName___hide() %>"/>
                        <html:hidden property="customerid" value="<%= form.getCustomerid() %>"/>
                <html:hidden property="customerid___hide" value="<%= form.getCustomerid___hide() %>"/>
                        <html:hidden property="dscps" value="<%= form.getDscps() %>"/>
                <html:hidden property="dscps___hide" value="<%= form.getDscps___hide() %>"/>
                        <html:hidden property="filter" value="<%= form.getFilter() %>"/>
                <html:hidden property="filter___hide" value="<%= form.getFilter___hide() %>"/>
                        <html:hidden property="coss" value="<%= form.getCoss() %>"/>
                <html:hidden property="coss___hide" value="<%= form.getCoss___hide() %>"/>
                        <html:hidden property="layer" value="<%= form.getLayer() %>"/>
                <html:hidden property="layer___hide" value="<%= form.getLayer___hide() %>"/>
                        <html:hidden property="compliant" value="<%= form.getCompliant() %>"/>
                <html:hidden property="compliant___hide" value="<%= form.getCompliant___hide() %>"/>
                        <html:hidden property="marker" value="<%= form.getMarker() %>"/>
                <html:hidden property="marker___hide" value="<%= form.getMarker___hide() %>"/>
                        <html:hidden property="uploadstatus" value="<%= form.getUploadstatus() %>"/>
                <html:hidden property="uploadstatus___hide" value="<%= form.getUploadstatus___hide() %>"/>
                        <html:hidden property="dbprimarykey" value="<%= form.getDbprimarykey() %>"/>
                <html:hidden property="dbprimarykey___hide" value="<%= form.getDbprimarykey___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="name" value="<%= request.getParameter(\"name\") %>"/>
                <html:hidden property="name___hide" value="<%= request.getParameter(\"name___hide\") %>"/>
                        <html:hidden property="customerid" value="<%= request.getParameter(\"customerid\") %>"/>
                <html:hidden property="customerid___hide" value="<%= request.getParameter(\"customerid___hide\") %>"/>
                        <html:hidden property="dscps" value="<%= request.getParameter(\"dscps\") %>"/>
                <html:hidden property="dscps___hide" value="<%= request.getParameter(\"dscps___hide\") %>"/>
                        <html:hidden property="filter" value="<%= request.getParameter(\"filter\") %>"/>
                <html:hidden property="filter___hide" value="<%= request.getParameter(\"filter___hide\") %>"/>
                        <html:hidden property="coss" value="<%= request.getParameter(\"coss\") %>"/>
                <html:hidden property="coss___hide" value="<%= request.getParameter(\"coss___hide\") %>"/>
                        <html:hidden property="layer" value="<%= request.getParameter(\"layer\") %>"/>
                <html:hidden property="layer___hide" value="<%= request.getParameter(\"layer___hide\") %>"/>
                        <html:hidden property="compliant" value="<%= request.getParameter(\"compliant\") %>"/>
                <html:hidden property="compliant___hide" value="<%= request.getParameter(\"compliant___hide\") %>"/>
                        <html:hidden property="marker" value="<%= request.getParameter(\"marker\") %>"/>
                <html:hidden property="marker___hide" value="<%= request.getParameter(\"marker___hide\") %>"/>
                        <html:hidden property="uploadstatus" value="<%= request.getParameter(\"uploadstatus\") %>"/>
                <html:hidden property="uploadstatus___hide" value="<%= request.getParameter(\"uploadstatus___hide\") %>"/>
                        <html:hidden property="dbprimarykey" value="<%= request.getParameter(\"dbprimarykey\") %>"/>
                <html:hidden property="dbprimarykey___hide" value="<%= request.getParameter(\"dbprimarykey___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.Sh_TrafficClassifierForm.submit()"/>
  </html:form>

  </body>
</html>
  
