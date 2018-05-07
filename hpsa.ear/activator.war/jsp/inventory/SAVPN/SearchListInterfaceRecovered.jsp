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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(InterfaceRecoveredConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(InterfaceRecoveredConstants.DATASOURCE);
String tabName = request.getParameter(InterfaceRecoveredConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

InterfaceRecoveredForm form = (InterfaceRecoveredForm) request.getAttribute("InterfaceRecoveredForm");


String SourceTPID___hide = null;
String TargetTPID___hide = null;
String Total___hide = null;
String Success___hide = null;
String Failed___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListInterfaceRecovered.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  SourceTPID___hide = form.getSourcetpid___hide();
  TargetTPID___hide = form.getTargettpid___hide();
  Total___hide = form.getTotal___hide();
  Success___hide = form.getSuccess___hide();
  Failed___hide = form.getFailed___hide();

  if ( SourceTPID___hide != null )
    requestURI.append("sourcetpid___hide=" + SourceTPID___hide);
  if ( TargetTPID___hide != null )
    requestURI.append("targettpid___hide=" + TargetTPID___hide);
  if ( Total___hide != null )
    requestURI.append("total___hide=" + Total___hide);
  if ( Success___hide != null )
    requestURI.append("success___hide=" + Success___hide);
  if ( Failed___hide != null )
    requestURI.append("failed___hide=" + Failed___hide);

} else {

    SourceTPID___hide = request.getParameter("sourcetpid___hide");
    TargetTPID___hide = request.getParameter("targettpid___hide");
    Total___hide = request.getParameter("total___hide");
    Success___hide = request.getParameter("success___hide");
    Failed___hide = request.getParameter("failed___hide");

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
    <title><bean:message bundle="InterfaceRecoveredApplicationResources" key="<%= InterfaceRecoveredConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="InterfaceRecoveredApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitInterfaceRecoveredAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( SourceTPID___hide == null || SourceTPID___hide.equals("null") ) {
%>
      <display:column property="sourcetpid" sortable="true" titleKey="InterfaceRecoveredApplicationResources:field.sourcetpid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( TargetTPID___hide == null || TargetTPID___hide.equals("null") ) {
%>
      <display:column property="targettpid" sortable="true" titleKey="InterfaceRecoveredApplicationResources:field.targettpid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Total___hide == null || Total___hide.equals("null") ) {
%>
      <display:column property="total" sortable="true" titleKey="InterfaceRecoveredApplicationResources:field.total.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Success___hide == null || Success___hide.equals("null") ) {
%>
      <display:column property="success" sortable="true" titleKey="InterfaceRecoveredApplicationResources:field.success.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Failed___hide == null || Failed___hide.equals("null") ) {
%>
      <display:column property="failed" sortable="true" titleKey="InterfaceRecoveredApplicationResources:field.failed.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormInterfaceRecoveredAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="sourcetpid" value="<%= form.getSourcetpid() %>"/>
                <html:hidden property="sourcetpid___hide" value="<%= form.getSourcetpid___hide() %>"/>
                        <html:hidden property="targettpid" value="<%= form.getTargettpid() %>"/>
                <html:hidden property="targettpid___hide" value="<%= form.getTargettpid___hide() %>"/>
                        <html:hidden property="total" value="<%= form.getTotal() %>"/>
                  <html:hidden property="total___" value="<%= form.getTotal___() %>"/>
                <html:hidden property="total___hide" value="<%= form.getTotal___hide() %>"/>
                        <html:hidden property="success" value="<%= form.getSuccess() %>"/>
                  <html:hidden property="success___" value="<%= form.getSuccess___() %>"/>
                <html:hidden property="success___hide" value="<%= form.getSuccess___hide() %>"/>
                        <html:hidden property="failed" value="<%= form.getFailed() %>"/>
                  <html:hidden property="failed___" value="<%= form.getFailed___() %>"/>
                <html:hidden property="failed___hide" value="<%= form.getFailed___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="sourcetpid" value="<%= request.getParameter(\"sourcetpid\") %>"/>
                <html:hidden property="sourcetpid___hide" value="<%= request.getParameter(\"sourcetpid___hide\") %>"/>
                        <html:hidden property="targettpid" value="<%= request.getParameter(\"targettpid\") %>"/>
                <html:hidden property="targettpid___hide" value="<%= request.getParameter(\"targettpid___hide\") %>"/>
                        <html:hidden property="total" value="<%= request.getParameter(\"total\") %>"/>
                  <html:hidden property="total___" value="<%= request.getParameter(\"total___\") %>"/>
                <html:hidden property="total___hide" value="<%= request.getParameter(\"total___hide\") %>"/>
                        <html:hidden property="success" value="<%= request.getParameter(\"success\") %>"/>
                  <html:hidden property="success___" value="<%= request.getParameter(\"success___\") %>"/>
                <html:hidden property="success___hide" value="<%= request.getParameter(\"success___hide\") %>"/>
                        <html:hidden property="failed" value="<%= request.getParameter(\"failed\") %>"/>
                  <html:hidden property="failed___" value="<%= request.getParameter(\"failed___\") %>"/>
                <html:hidden property="failed___hide" value="<%= request.getParameter(\"failed___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.InterfaceRecoveredForm.submit()"/>
  </html:form>

  </body>
</html>
  
