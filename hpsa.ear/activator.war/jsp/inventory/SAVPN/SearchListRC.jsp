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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(RCConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(RCConstants.DATASOURCE);
String tabName = request.getParameter(RCConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

RCForm form = (RCForm) request.getAttribute("RCForm");


String RCName___hide = null;
String L3VPNId___hide = null;
String RTExport___hide = null;
String RTImport___hide = null;
String Type___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListRC.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  RCName___hide = form.getRcname___hide();
  L3VPNId___hide = form.getL3vpnid___hide();
  RTExport___hide = form.getRtexport___hide();
  RTImport___hide = form.getRtimport___hide();
  Type___hide = form.getType___hide();

  if ( RCName___hide != null )
    requestURI.append("rcname___hide=" + RCName___hide);
  if ( L3VPNId___hide != null )
    requestURI.append("l3vpnid___hide=" + L3VPNId___hide);
  if ( RTExport___hide != null )
    requestURI.append("rtexport___hide=" + RTExport___hide);
  if ( RTImport___hide != null )
    requestURI.append("rtimport___hide=" + RTImport___hide);
  if ( Type___hide != null )
    requestURI.append("type___hide=" + Type___hide);

} else {

    RCName___hide = request.getParameter("rcname___hide");
    L3VPNId___hide = request.getParameter("l3vpnid___hide");
    RTExport___hide = request.getParameter("rtexport___hide");
    RTImport___hide = request.getParameter("rtimport___hide");
    Type___hide = request.getParameter("type___hide");

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
    <title><bean:message bundle="RCApplicationResources" key="<%= RCConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="RCApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitRCAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( RCName___hide == null || RCName___hide.equals("null") ) {
%>
      <display:column property="rcname" sortable="true" titleKey="RCApplicationResources:field.rcname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( L3VPNId___hide == null || L3VPNId___hide.equals("null") ) {
%>
      <display:column property="l3vpnid" sortable="true" titleKey="RCApplicationResources:field.l3vpnid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RTExport___hide == null || RTExport___hide.equals("null") ) {
%>
      <display:column property="rtexport" sortable="true" titleKey="RCApplicationResources:field.rtexport.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RTImport___hide == null || RTImport___hide.equals("null") ) {
%>
      <display:column property="rtimport" sortable="true" titleKey="RCApplicationResources:field.rtimport.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Type___hide == null || Type___hide.equals("null") ) {
%>
      <display:column property="type" sortable="true" titleKey="RCApplicationResources:field.type.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormRCAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="rcname" value="<%= form.getRcname() %>"/>
                <html:hidden property="rcname___hide" value="<%= form.getRcname___hide() %>"/>
                                  <html:hidden property="l3vpnid" value="<%= form.getL3vpnid() %>"/>
                <html:hidden property="l3vpnid___hide" value="<%= form.getL3vpnid___hide() %>"/>
                                  <html:hidden property="rtexport" value="<%= form.getRtexport() %>"/>
                <html:hidden property="rtexport___hide" value="<%= form.getRtexport___hide() %>"/>
                        <html:hidden property="rtimport" value="<%= form.getRtimport() %>"/>
                <html:hidden property="rtimport___hide" value="<%= form.getRtimport___hide() %>"/>
                        <html:hidden property="type" value="<%= form.getType() %>"/>
                <html:hidden property="type___hide" value="<%= form.getType___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="rcname" value="<%= request.getParameter(\"rcname\") %>"/>
                <html:hidden property="rcname___hide" value="<%= request.getParameter(\"rcname___hide\") %>"/>
                                  <html:hidden property="l3vpnid" value="<%= request.getParameter(\"l3vpnid\") %>"/>
                <html:hidden property="l3vpnid___hide" value="<%= request.getParameter(\"l3vpnid___hide\") %>"/>
                                  <html:hidden property="rtexport" value="<%= request.getParameter(\"rtexport\") %>"/>
                <html:hidden property="rtexport___hide" value="<%= request.getParameter(\"rtexport___hide\") %>"/>
                        <html:hidden property="rtimport" value="<%= request.getParameter(\"rtimport\") %>"/>
                <html:hidden property="rtimport___hide" value="<%= request.getParameter(\"rtimport___hide\") %>"/>
                        <html:hidden property="type" value="<%= request.getParameter(\"type\") %>"/>
                <html:hidden property="type___hide" value="<%= request.getParameter(\"type___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.RCForm.submit()"/>
  </html:form>

  </body>
</html>
  
