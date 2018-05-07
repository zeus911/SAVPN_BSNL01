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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(AdminVPNConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(AdminVPNConstants.DATASOURCE);
String tabName = request.getParameter(AdminVPNConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

AdminVPNForm form = (AdminVPNForm) request.getAttribute("AdminVPNForm");


String VRFID___hide = null;
String AdminVRFName___hide = null;
String RD___hide = null;
String RTExport___hide = null;
String RTImport___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListAdminVPN.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  VRFID___hide = form.getVrfid___hide();
  AdminVRFName___hide = form.getAdminvrfname___hide();
  RD___hide = form.getRd___hide();
  RTExport___hide = form.getRtexport___hide();
  RTImport___hide = form.getRtimport___hide();

  if ( VRFID___hide != null )
    requestURI.append("vrfid___hide=" + VRFID___hide);
  if ( AdminVRFName___hide != null )
    requestURI.append("adminvrfname___hide=" + AdminVRFName___hide);
  if ( RD___hide != null )
    requestURI.append("rd___hide=" + RD___hide);
  if ( RTExport___hide != null )
    requestURI.append("rtexport___hide=" + RTExport___hide);
  if ( RTImport___hide != null )
    requestURI.append("rtimport___hide=" + RTImport___hide);

} else {

    VRFID___hide = request.getParameter("vrfid___hide");
    AdminVRFName___hide = request.getParameter("adminvrfname___hide");
    RD___hide = request.getParameter("rd___hide");
    RTExport___hide = request.getParameter("rtexport___hide");
    RTImport___hide = request.getParameter("rtimport___hide");

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
    <title><bean:message bundle="AdminVPNApplicationResources" key="<%= AdminVPNConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="AdminVPNApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitAdminVPNAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( VRFID___hide == null || VRFID___hide.equals("null") ) {
%>
      <display:column property="vrfid" sortable="true" titleKey="AdminVPNApplicationResources:field.vrfid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( AdminVRFName___hide == null || AdminVRFName___hide.equals("null") ) {
%>
      <display:column property="adminvrfname" sortable="true" titleKey="AdminVPNApplicationResources:field.adminvrfname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RD___hide == null || RD___hide.equals("null") ) {
%>
      <display:column property="rd" sortable="true" titleKey="AdminVPNApplicationResources:field.rd.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RTExport___hide == null || RTExport___hide.equals("null") ) {
%>
      <display:column property="rtexport" sortable="true" titleKey="AdminVPNApplicationResources:field.rtexport.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RTImport___hide == null || RTImport___hide.equals("null") ) {
%>
      <display:column property="rtimport" sortable="true" titleKey="AdminVPNApplicationResources:field.rtimport.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormAdminVPNAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="vrfid" value="<%= form.getVrfid() %>"/>
                <html:hidden property="vrfid___hide" value="<%= form.getVrfid___hide() %>"/>
                        <html:hidden property="adminvrfname" value="<%= form.getAdminvrfname() %>"/>
                <html:hidden property="adminvrfname___hide" value="<%= form.getAdminvrfname___hide() %>"/>
                        <html:hidden property="rd" value="<%= form.getRd() %>"/>
                <html:hidden property="rd___hide" value="<%= form.getRd___hide() %>"/>
                        <html:hidden property="rtexport" value="<%= form.getRtexport() %>"/>
                <html:hidden property="rtexport___hide" value="<%= form.getRtexport___hide() %>"/>
                        <html:hidden property="rtimport" value="<%= form.getRtimport() %>"/>
                <html:hidden property="rtimport___hide" value="<%= form.getRtimport___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="vrfid" value="<%= request.getParameter(\"vrfid\") %>"/>
                <html:hidden property="vrfid___hide" value="<%= request.getParameter(\"vrfid___hide\") %>"/>
                        <html:hidden property="adminvrfname" value="<%= request.getParameter(\"adminvrfname\") %>"/>
                <html:hidden property="adminvrfname___hide" value="<%= request.getParameter(\"adminvrfname___hide\") %>"/>
                        <html:hidden property="rd" value="<%= request.getParameter(\"rd\") %>"/>
                <html:hidden property="rd___hide" value="<%= request.getParameter(\"rd___hide\") %>"/>
                        <html:hidden property="rtexport" value="<%= request.getParameter(\"rtexport\") %>"/>
                <html:hidden property="rtexport___hide" value="<%= request.getParameter(\"rtexport___hide\") %>"/>
                        <html:hidden property="rtimport" value="<%= request.getParameter(\"rtimport\") %>"/>
                <html:hidden property="rtimport___hide" value="<%= request.getParameter(\"rtimport___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.AdminVPNForm.submit()"/>
  </html:form>

  </body>
</html>
  
