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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(Sh_TMNConnectionConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(Sh_TMNConnectionConstants.DATASOURCE);
String tabName = request.getParameter(Sh_TMNConnectionConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

Sh_TMNConnectionForm form = (Sh_TMNConnectionForm) request.getAttribute("Sh_TMNConnectionForm");


String ConnectionID___hide = null;
String NetworkID1___hide = null;
String NetworkID2___hide = null;
String NE1___hide = null;
String TP1___hide = null;
String NE2___hide = null;
String TP2___hide = null;
String Marker___hide = null;
String UploadStatus___hide = null;
String DBPrimaryKey___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListSh_TMNConnection.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  ConnectionID___hide = form.getConnectionid___hide();
  NetworkID1___hide = form.getNetworkid1___hide();
  NetworkID2___hide = form.getNetworkid2___hide();
  NE1___hide = form.getNe1___hide();
  TP1___hide = form.getTp1___hide();
  NE2___hide = form.getNe2___hide();
  TP2___hide = form.getTp2___hide();
  Marker___hide = form.getMarker___hide();
  UploadStatus___hide = form.getUploadstatus___hide();
  DBPrimaryKey___hide = form.getDbprimarykey___hide();

  if ( ConnectionID___hide != null )
    requestURI.append("connectionid___hide=" + ConnectionID___hide);
  if ( NetworkID1___hide != null )
    requestURI.append("networkid1___hide=" + NetworkID1___hide);
  if ( NetworkID2___hide != null )
    requestURI.append("networkid2___hide=" + NetworkID2___hide);
  if ( NE1___hide != null )
    requestURI.append("ne1___hide=" + NE1___hide);
  if ( TP1___hide != null )
    requestURI.append("tp1___hide=" + TP1___hide);
  if ( NE2___hide != null )
    requestURI.append("ne2___hide=" + NE2___hide);
  if ( TP2___hide != null )
    requestURI.append("tp2___hide=" + TP2___hide);
  if ( Marker___hide != null )
    requestURI.append("marker___hide=" + Marker___hide);
  if ( UploadStatus___hide != null )
    requestURI.append("uploadstatus___hide=" + UploadStatus___hide);
  if ( DBPrimaryKey___hide != null )
    requestURI.append("dbprimarykey___hide=" + DBPrimaryKey___hide);

} else {

    ConnectionID___hide = request.getParameter("connectionid___hide");
    NetworkID1___hide = request.getParameter("networkid1___hide");
    NetworkID2___hide = request.getParameter("networkid2___hide");
    NE1___hide = request.getParameter("ne1___hide");
    TP1___hide = request.getParameter("tp1___hide");
    NE2___hide = request.getParameter("ne2___hide");
    TP2___hide = request.getParameter("tp2___hide");
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
    <title><bean:message bundle="Sh_TMNConnectionApplicationResources" key="<%= Sh_TMNConnectionConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_TMNConnectionApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitSh_TMNConnectionAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( ConnectionID___hide == null || ConnectionID___hide.equals("null") ) {
%>
      <display:column property="connectionid" sortable="true" titleKey="Sh_TMNConnectionApplicationResources:field.connectionid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NetworkID1___hide == null || NetworkID1___hide.equals("null") ) {
%>
      <display:column property="networkid1" sortable="true" titleKey="Sh_TMNConnectionApplicationResources:field.networkid1.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NetworkID2___hide == null || NetworkID2___hide.equals("null") ) {
%>
      <display:column property="networkid2" sortable="true" titleKey="Sh_TMNConnectionApplicationResources:field.networkid2.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NE1___hide == null || NE1___hide.equals("null") ) {
%>
      <display:column property="ne1" sortable="true" titleKey="Sh_TMNConnectionApplicationResources:field.ne1.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( TP1___hide == null || TP1___hide.equals("null") ) {
%>
      <display:column property="tp1" sortable="true" titleKey="Sh_TMNConnectionApplicationResources:field.tp1.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NE2___hide == null || NE2___hide.equals("null") ) {
%>
      <display:column property="ne2" sortable="true" titleKey="Sh_TMNConnectionApplicationResources:field.ne2.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( TP2___hide == null || TP2___hide.equals("null") ) {
%>
      <display:column property="tp2" sortable="true" titleKey="Sh_TMNConnectionApplicationResources:field.tp2.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Marker___hide == null || Marker___hide.equals("null") ) {
%>
      <display:column property="marker" sortable="true" titleKey="Sh_TMNConnectionApplicationResources:field.marker.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UploadStatus___hide == null || UploadStatus___hide.equals("null") ) {
%>
      <display:column property="uploadstatus" sortable="true" titleKey="Sh_TMNConnectionApplicationResources:field.uploadstatus.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( DBPrimaryKey___hide == null || DBPrimaryKey___hide.equals("null") ) {
%>
      <display:column property="dbprimarykey" sortable="true" titleKey="Sh_TMNConnectionApplicationResources:field.dbprimarykey.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormSh_TMNConnectionAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="connectionid" value="<%= form.getConnectionid() %>"/>
                <html:hidden property="connectionid___hide" value="<%= form.getConnectionid___hide() %>"/>
                        <html:hidden property="networkid1" value="<%= form.getNetworkid1() %>"/>
                <html:hidden property="networkid1___hide" value="<%= form.getNetworkid1___hide() %>"/>
                        <html:hidden property="networkid2" value="<%= form.getNetworkid2() %>"/>
                <html:hidden property="networkid2___hide" value="<%= form.getNetworkid2___hide() %>"/>
                        <html:hidden property="ne1" value="<%= form.getNe1() %>"/>
                <html:hidden property="ne1___hide" value="<%= form.getNe1___hide() %>"/>
                        <html:hidden property="tp1" value="<%= form.getTp1() %>"/>
                <html:hidden property="tp1___hide" value="<%= form.getTp1___hide() %>"/>
                        <html:hidden property="ne2" value="<%= form.getNe2() %>"/>
                <html:hidden property="ne2___hide" value="<%= form.getNe2___hide() %>"/>
                        <html:hidden property="tp2" value="<%= form.getTp2() %>"/>
                <html:hidden property="tp2___hide" value="<%= form.getTp2___hide() %>"/>
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
                  <html:hidden property="connectionid" value="<%= request.getParameter(\"connectionid\") %>"/>
                <html:hidden property="connectionid___hide" value="<%= request.getParameter(\"connectionid___hide\") %>"/>
                        <html:hidden property="networkid1" value="<%= request.getParameter(\"networkid1\") %>"/>
                <html:hidden property="networkid1___hide" value="<%= request.getParameter(\"networkid1___hide\") %>"/>
                        <html:hidden property="networkid2" value="<%= request.getParameter(\"networkid2\") %>"/>
                <html:hidden property="networkid2___hide" value="<%= request.getParameter(\"networkid2___hide\") %>"/>
                        <html:hidden property="ne1" value="<%= request.getParameter(\"ne1\") %>"/>
                <html:hidden property="ne1___hide" value="<%= request.getParameter(\"ne1___hide\") %>"/>
                        <html:hidden property="tp1" value="<%= request.getParameter(\"tp1\") %>"/>
                <html:hidden property="tp1___hide" value="<%= request.getParameter(\"tp1___hide\") %>"/>
                        <html:hidden property="ne2" value="<%= request.getParameter(\"ne2\") %>"/>
                <html:hidden property="ne2___hide" value="<%= request.getParameter(\"ne2___hide\") %>"/>
                        <html:hidden property="tp2" value="<%= request.getParameter(\"tp2\") %>"/>
                <html:hidden property="tp2___hide" value="<%= request.getParameter(\"tp2___hide\") %>"/>
                        <html:hidden property="marker" value="<%= request.getParameter(\"marker\") %>"/>
                <html:hidden property="marker___hide" value="<%= request.getParameter(\"marker___hide\") %>"/>
                        <html:hidden property="uploadstatus" value="<%= request.getParameter(\"uploadstatus\") %>"/>
                <html:hidden property="uploadstatus___hide" value="<%= request.getParameter(\"uploadstatus___hide\") %>"/>
                        <html:hidden property="dbprimarykey" value="<%= request.getParameter(\"dbprimarykey\") %>"/>
                <html:hidden property="dbprimarykey___hide" value="<%= request.getParameter(\"dbprimarykey___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.Sh_TMNConnectionForm.submit()"/>
  </html:form>

  </body>
</html>
  
