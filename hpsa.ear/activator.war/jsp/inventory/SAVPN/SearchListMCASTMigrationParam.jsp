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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(MCASTMigrationParamConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(MCASTMigrationParamConstants.DATASOURCE);
String tabName = request.getParameter(MCASTMigrationParamConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

MCASTMigrationParamForm form = (MCASTMigrationParamForm) request.getAttribute("MCASTMigrationParamForm");


String IDName___hide = null;
String MaxMigrationJobs___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListMCASTMigrationParam.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  IDName___hide = form.getIdname___hide();
  MaxMigrationJobs___hide = form.getMaxmigrationjobs___hide();

  if ( IDName___hide != null )
    requestURI.append("idname___hide=" + IDName___hide);
  if ( MaxMigrationJobs___hide != null )
    requestURI.append("maxmigrationjobs___hide=" + MaxMigrationJobs___hide);

} else {

    IDName___hide = request.getParameter("idname___hide");
    MaxMigrationJobs___hide = request.getParameter("maxmigrationjobs___hide");

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
    <title><bean:message bundle="MCASTMigrationParamApplicationResources" key="<%= MCASTMigrationParamConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="MCASTMigrationParamApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitMCASTMigrationParamAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( IDName___hide == null || IDName___hide.equals("null") ) {
%>
      <display:column property="idname" sortable="true" titleKey="MCASTMigrationParamApplicationResources:field.idname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( MaxMigrationJobs___hide == null || MaxMigrationJobs___hide.equals("null") ) {
%>
      <display:column property="maxmigrationjobs" sortable="true" titleKey="MCASTMigrationParamApplicationResources:field.maxmigrationjobs.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormMCASTMigrationParamAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="idname" value="<%= form.getIdname() %>"/>
                <html:hidden property="idname___hide" value="<%= form.getIdname___hide() %>"/>
                        <html:hidden property="maxmigrationjobs" value="<%= form.getMaxmigrationjobs() %>"/>
                  <html:hidden property="maxmigrationjobs___" value="<%= form.getMaxmigrationjobs___() %>"/>
                <html:hidden property="maxmigrationjobs___hide" value="<%= form.getMaxmigrationjobs___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="idname" value="<%= request.getParameter(\"idname\") %>"/>
                <html:hidden property="idname___hide" value="<%= request.getParameter(\"idname___hide\") %>"/>
                        <html:hidden property="maxmigrationjobs" value="<%= request.getParameter(\"maxmigrationjobs\") %>"/>
                  <html:hidden property="maxmigrationjobs___" value="<%= request.getParameter(\"maxmigrationjobs___\") %>"/>
                <html:hidden property="maxmigrationjobs___hide" value="<%= request.getParameter(\"maxmigrationjobs___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.MCASTMigrationParamForm.submit()"/>
  </html:form>

  </body>
</html>
  
