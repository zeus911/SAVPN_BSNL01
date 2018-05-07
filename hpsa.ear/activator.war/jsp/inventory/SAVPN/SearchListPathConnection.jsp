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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(PathConnectionConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(PathConnectionConstants.DATASOURCE);
String tabName = request.getParameter(PathConnectionConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

PathConnectionForm form = (PathConnectionForm) request.getAttribute("PathConnectionForm");


String ConnectionID___hide = null;
String PathID___hide = null;
String OrderNumber___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListPathConnection.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  ConnectionID___hide = form.getConnectionid___hide();
  PathID___hide = form.getPathid___hide();
  OrderNumber___hide = form.getOrdernumber___hide();

  if ( ConnectionID___hide != null )
    requestURI.append("connectionid___hide=" + ConnectionID___hide);
  if ( PathID___hide != null )
    requestURI.append("pathid___hide=" + PathID___hide);
  if ( OrderNumber___hide != null )
    requestURI.append("ordernumber___hide=" + OrderNumber___hide);

} else {

    ConnectionID___hide = request.getParameter("connectionid___hide");
    PathID___hide = request.getParameter("pathid___hide");
    OrderNumber___hide = request.getParameter("ordernumber___hide");

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
    <title><bean:message bundle="PathConnectionApplicationResources" key="<%= PathConnectionConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="PathConnectionApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitPathConnectionAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( ConnectionID___hide == null || ConnectionID___hide.equals("null") ) {
%>
      <display:column property="connectionid" sortable="true" titleKey="PathConnectionApplicationResources:field.connectionid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PathID___hide == null || PathID___hide.equals("null") ) {
%>
      <display:column property="pathid" sortable="true" titleKey="PathConnectionApplicationResources:field.pathid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( OrderNumber___hide == null || OrderNumber___hide.equals("null") ) {
%>
      <display:column property="ordernumber" sortable="true" titleKey="PathConnectionApplicationResources:field.ordernumber.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormPathConnectionAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="connectionid" value="<%= form.getConnectionid() %>"/>
                <html:hidden property="connectionid___hide" value="<%= form.getConnectionid___hide() %>"/>
                        <html:hidden property="pathid" value="<%= form.getPathid() %>"/>
                <html:hidden property="pathid___hide" value="<%= form.getPathid___hide() %>"/>
                        <html:hidden property="ordernumber" value="<%= form.getOrdernumber() %>"/>
                  <html:hidden property="ordernumber___" value="<%= form.getOrdernumber___() %>"/>
                <html:hidden property="ordernumber___hide" value="<%= form.getOrdernumber___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="connectionid" value="<%= request.getParameter(\"connectionid\") %>"/>
                <html:hidden property="connectionid___hide" value="<%= request.getParameter(\"connectionid___hide\") %>"/>
                        <html:hidden property="pathid" value="<%= request.getParameter(\"pathid\") %>"/>
                <html:hidden property="pathid___hide" value="<%= request.getParameter(\"pathid___hide\") %>"/>
                        <html:hidden property="ordernumber" value="<%= request.getParameter(\"ordernumber\") %>"/>
                  <html:hidden property="ordernumber___" value="<%= request.getParameter(\"ordernumber___\") %>"/>
                <html:hidden property="ordernumber___hide" value="<%= request.getParameter(\"ordernumber___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.PathConnectionForm.submit()"/>
  </html:form>

  </body>
</html>
  
