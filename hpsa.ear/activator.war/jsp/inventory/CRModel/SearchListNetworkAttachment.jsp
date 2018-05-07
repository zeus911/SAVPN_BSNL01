<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        java.lang.reflect.Method,
        com.hp.ov.activator.cr.inventory.*,
        com.hp.ov.activator.inventory.CRModel.*,
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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(NetworkAttachmentConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(NetworkAttachmentConstants.DATASOURCE);
String tabName = request.getParameter(NetworkAttachmentConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

NetworkAttachmentForm form = (NetworkAttachmentForm) request.getAttribute("NetworkAttachmentForm");


String NetworkElementId___hide = null;
String NetworkId___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListNetworkAttachment.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  NetworkElementId___hide = form.getNetworkelementid___hide();
  NetworkId___hide = form.getNetworkid___hide();

  if ( NetworkElementId___hide != null )
    requestURI.append("networkelementid___hide=" + NetworkElementId___hide);
  if ( NetworkId___hide != null )
    requestURI.append("networkid___hide=" + NetworkId___hide);

} else {

    NetworkElementId___hide = request.getParameter("networkelementid___hide");
    NetworkId___hide = request.getParameter("networkid___hide");

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
    <title><bean:message bundle="NetworkAttachmentApplicationResources" key="<%= NetworkAttachmentConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="NetworkAttachmentApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitNetworkAttachmentAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( NetworkElementId___hide == null || NetworkElementId___hide.equals("null") ) {
%>
      <display:column property="networkelementid" sortable="true" titleKey="NetworkAttachmentApplicationResources:field.networkelementid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NetworkId___hide == null || NetworkId___hide.equals("null") ) {
%>
      <display:column property="networkid" sortable="true" titleKey="NetworkAttachmentApplicationResources:field.networkid.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormNetworkAttachmentAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="networkelementid" value="<%= form.getNetworkelementid() %>"/>
                <html:hidden property="networkelementid___hide" value="<%= form.getNetworkelementid___hide() %>"/>
                        <html:hidden property="networkid" value="<%= form.getNetworkid() %>"/>
                <html:hidden property="networkid___hide" value="<%= form.getNetworkid___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="networkelementid" value="<%= request.getParameter(\"networkelementid\") %>"/>
                <html:hidden property="networkelementid___hide" value="<%= request.getParameter(\"networkelementid___hide\") %>"/>
                        <html:hidden property="networkid" value="<%= request.getParameter(\"networkid\") %>"/>
                <html:hidden property="networkid___hide" value="<%= request.getParameter(\"networkid___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.NetworkAttachmentForm.submit()"/>
  </html:form>

  </body>
</html>
  
