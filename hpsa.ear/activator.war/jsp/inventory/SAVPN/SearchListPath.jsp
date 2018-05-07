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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(PathConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(PathConstants.DATASOURCE);
String tabName = request.getParameter(PathConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

PathForm form = (PathForm) request.getAttribute("PathForm");


String PathID___hide = null;
String TPOrigin___hide = null;
String TPDestination___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListPath.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  PathID___hide = form.getPathid___hide();
  TPOrigin___hide = form.getTporigin___hide();
  TPDestination___hide = form.getTpdestination___hide();

  if ( PathID___hide != null )
    requestURI.append("pathid___hide=" + PathID___hide);
  if ( TPOrigin___hide != null )
    requestURI.append("tporigin___hide=" + TPOrigin___hide);
  if ( TPDestination___hide != null )
    requestURI.append("tpdestination___hide=" + TPDestination___hide);

} else {

    PathID___hide = request.getParameter("pathid___hide");
    TPOrigin___hide = request.getParameter("tporigin___hide");
    TPDestination___hide = request.getParameter("tpdestination___hide");

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
    <title><bean:message bundle="PathApplicationResources" key="<%= PathConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="PathApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitPathAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( PathID___hide == null || PathID___hide.equals("null") ) {
%>
      <display:column property="pathid" sortable="true" titleKey="PathApplicationResources:field.pathid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( TPOrigin___hide == null || TPOrigin___hide.equals("null") ) {
%>
      <display:column property="tporigin" sortable="true" titleKey="PathApplicationResources:field.tporigin.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( TPDestination___hide == null || TPDestination___hide.equals("null") ) {
%>
      <display:column property="tpdestination" sortable="true" titleKey="PathApplicationResources:field.tpdestination.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormPathAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="pathid" value="<%= form.getPathid() %>"/>
                <html:hidden property="pathid___hide" value="<%= form.getPathid___hide() %>"/>
                        <html:hidden property="tporigin" value="<%= form.getTporigin() %>"/>
                <html:hidden property="tporigin___hide" value="<%= form.getTporigin___hide() %>"/>
                        <html:hidden property="tpdestination" value="<%= form.getTpdestination() %>"/>
                <html:hidden property="tpdestination___hide" value="<%= form.getTpdestination___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="pathid" value="<%= request.getParameter(\"pathid\") %>"/>
                <html:hidden property="pathid___hide" value="<%= request.getParameter(\"pathid___hide\") %>"/>
                        <html:hidden property="tporigin" value="<%= request.getParameter(\"tporigin\") %>"/>
                <html:hidden property="tporigin___hide" value="<%= request.getParameter(\"tporigin___hide\") %>"/>
                        <html:hidden property="tpdestination" value="<%= request.getParameter(\"tpdestination\") %>"/>
                <html:hidden property="tpdestination___hide" value="<%= request.getParameter(\"tpdestination___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.PathForm.submit()"/>
  </html:form>

  </body>
</html>
  
