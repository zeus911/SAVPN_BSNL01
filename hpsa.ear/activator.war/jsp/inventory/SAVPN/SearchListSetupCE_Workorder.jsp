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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(SetupCE_WorkorderConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(SetupCE_WorkorderConstants.DATASOURCE);
String tabName = request.getParameter(SetupCE_WorkorderConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

SetupCE_WorkorderForm form = (SetupCE_WorkorderForm) request.getAttribute("SetupCE_WorkorderForm");


String ServiceId___hide = null;
String WOName___hide = null;
String creationtime___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListSetupCE_Workorder.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  ServiceId___hide = form.getServiceid___hide();
  WOName___hide = form.getWoname___hide();
  creationtime___hide = form.getCreationtime___hide();

  if ( ServiceId___hide != null )
    requestURI.append("serviceid___hide=" + ServiceId___hide);
  if ( WOName___hide != null )
    requestURI.append("woname___hide=" + WOName___hide);
  if ( creationtime___hide != null )
    requestURI.append("creationtime___hide=" + creationtime___hide);

} else {

    ServiceId___hide = request.getParameter("serviceid___hide");
    WOName___hide = request.getParameter("woname___hide");
    creationtime___hide = request.getParameter("creationtime___hide");

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
    <title><bean:message bundle="SetupCE_WorkorderApplicationResources" key="<%= SetupCE_WorkorderConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="SetupCE_WorkorderApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitSetupCE_WorkorderAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( ServiceId___hide == null || ServiceId___hide.equals("null") ) {
%>
      <display:column property="serviceid" sortable="true" titleKey="SetupCE_WorkorderApplicationResources:field.serviceid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( WOName___hide == null || WOName___hide.equals("null") ) {
%>
      <display:column property="woname" sortable="true" titleKey="SetupCE_WorkorderApplicationResources:field.woname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( creationtime___hide == null || creationtime___hide.equals("null") ) {
%>
      <display:column property="creationtime" sortable="true" titleKey="SetupCE_WorkorderApplicationResources:field.creationtime.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormSetupCE_WorkorderAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="serviceid" value="<%= form.getServiceid() %>"/>
                <html:hidden property="serviceid___hide" value="<%= form.getServiceid___hide() %>"/>
                        <html:hidden property="woname" value="<%= form.getWoname() %>"/>
                <html:hidden property="woname___hide" value="<%= form.getWoname___hide() %>"/>
                                  <html:hidden property="creationtime" value="<%= form.getCreationtime() %>"/>
                  <html:hidden property="creationtime___" value="<%= form.getCreationtime___() %>"/>
                <html:hidden property="creationtime___hide" value="<%= form.getCreationtime___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="serviceid" value="<%= request.getParameter(\"serviceid\") %>"/>
                <html:hidden property="serviceid___hide" value="<%= request.getParameter(\"serviceid___hide\") %>"/>
                        <html:hidden property="woname" value="<%= request.getParameter(\"woname\") %>"/>
                <html:hidden property="woname___hide" value="<%= request.getParameter(\"woname___hide\") %>"/>
                                  <html:hidden property="creationtime" value="<%= request.getParameter(\"creationtime\") %>"/>
                  <html:hidden property="creationtime___" value="<%= request.getParameter(\"creationtime___\") %>"/>
                <html:hidden property="creationtime___hide" value="<%= request.getParameter(\"creationtime___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.SetupCE_WorkorderForm.submit()"/>
  </html:form>

  </body>
</html>
  
