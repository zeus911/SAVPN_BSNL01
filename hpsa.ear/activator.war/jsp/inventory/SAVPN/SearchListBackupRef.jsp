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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(BackupRefConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(BackupRefConstants.DATASOURCE);
String tabName = request.getParameter(BackupRefConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

BackupRefForm form = (BackupRefForm) request.getAttribute("BackupRefForm");


String eqid___hide = null;
String creationtime___hide = null;
String createdby___hide = null;
String configtime___hide = null;
String retrievalname___hide = null;
String comments___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListBackupRef.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  eqid___hide = form.getEqid___hide();
  creationtime___hide = form.getCreationtime___hide();
  createdby___hide = form.getCreatedby___hide();
  configtime___hide = form.getConfigtime___hide();
  retrievalname___hide = form.getRetrievalname___hide();
  comments___hide = form.getComments___hide();

  if ( eqid___hide != null )
    requestURI.append("eqid___hide=" + eqid___hide);
  if ( creationtime___hide != null )
    requestURI.append("creationtime___hide=" + creationtime___hide);
  if ( createdby___hide != null )
    requestURI.append("createdby___hide=" + createdby___hide);
  if ( configtime___hide != null )
    requestURI.append("configtime___hide=" + configtime___hide);
  if ( retrievalname___hide != null )
    requestURI.append("retrievalname___hide=" + retrievalname___hide);
  if ( comments___hide != null )
    requestURI.append("comments___hide=" + comments___hide);

} else {

    eqid___hide = request.getParameter("eqid___hide");
    creationtime___hide = request.getParameter("creationtime___hide");
    createdby___hide = request.getParameter("createdby___hide");
    configtime___hide = request.getParameter("configtime___hide");
    retrievalname___hide = request.getParameter("retrievalname___hide");
    comments___hide = request.getParameter("comments___hide");

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
    <title><bean:message bundle="BackupRefApplicationResources" key="<%= BackupRefConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="BackupRefApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitBackupRefAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( eqid___hide == null || eqid___hide.equals("null") ) {
%>
      <display:column property="eqid" sortable="true" titleKey="BackupRefApplicationResources:field.eqid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( creationtime___hide == null || creationtime___hide.equals("null") ) {
%>
      <display:column property="creationtime" sortable="true" titleKey="BackupRefApplicationResources:field.creationtime.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( createdby___hide == null || createdby___hide.equals("null") ) {
%>
      <display:column property="createdby" sortable="true" titleKey="BackupRefApplicationResources:field.createdby.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( configtime___hide == null || configtime___hide.equals("null") ) {
%>
      <display:column property="configtime" sortable="true" titleKey="BackupRefApplicationResources:field.configtime.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( retrievalname___hide == null || retrievalname___hide.equals("null") ) {
%>
      <display:column property="retrievalname" sortable="true" titleKey="BackupRefApplicationResources:field.retrievalname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( comments___hide == null || comments___hide.equals("null") ) {
%>
      <display:column property="comments" sortable="true" titleKey="BackupRefApplicationResources:field.comments.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormBackupRefAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="eqid" value="<%= form.getEqid() %>"/>
                <html:hidden property="eqid___hide" value="<%= form.getEqid___hide() %>"/>
                        <html:hidden property="creationtime" value="<%= form.getCreationtime() %>"/>
                  <html:hidden property="creationtime___" value="<%= form.getCreationtime___() %>"/>
                <html:hidden property="creationtime___hide" value="<%= form.getCreationtime___hide() %>"/>
                        <html:hidden property="createdby" value="<%= form.getCreatedby() %>"/>
                <html:hidden property="createdby___hide" value="<%= form.getCreatedby___hide() %>"/>
                        <html:hidden property="configtime" value="<%= form.getConfigtime() %>"/>
                  <html:hidden property="configtime___" value="<%= form.getConfigtime___() %>"/>
                <html:hidden property="configtime___hide" value="<%= form.getConfigtime___hide() %>"/>
                        <html:hidden property="retrievalname" value="<%= form.getRetrievalname() %>"/>
                <html:hidden property="retrievalname___hide" value="<%= form.getRetrievalname___hide() %>"/>
                        <html:hidden property="comments" value="<%= form.getComments() %>"/>
                <html:hidden property="comments___hide" value="<%= form.getComments___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="eqid" value="<%= request.getParameter(\"eqid\") %>"/>
                <html:hidden property="eqid___hide" value="<%= request.getParameter(\"eqid___hide\") %>"/>
                        <html:hidden property="creationtime" value="<%= request.getParameter(\"creationtime\") %>"/>
                  <html:hidden property="creationtime___" value="<%= request.getParameter(\"creationtime___\") %>"/>
                <html:hidden property="creationtime___hide" value="<%= request.getParameter(\"creationtime___hide\") %>"/>
                        <html:hidden property="createdby" value="<%= request.getParameter(\"createdby\") %>"/>
                <html:hidden property="createdby___hide" value="<%= request.getParameter(\"createdby___hide\") %>"/>
                        <html:hidden property="configtime" value="<%= request.getParameter(\"configtime\") %>"/>
                  <html:hidden property="configtime___" value="<%= request.getParameter(\"configtime___\") %>"/>
                <html:hidden property="configtime___hide" value="<%= request.getParameter(\"configtime___hide\") %>"/>
                        <html:hidden property="retrievalname" value="<%= request.getParameter(\"retrievalname\") %>"/>
                <html:hidden property="retrievalname___hide" value="<%= request.getParameter(\"retrievalname___hide\") %>"/>
                        <html:hidden property="comments" value="<%= request.getParameter(\"comments\") %>"/>
                <html:hidden property="comments___hide" value="<%= request.getParameter(\"comments___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.BackupRefForm.submit()"/>
  </html:form>

  </body>
</html>
  
