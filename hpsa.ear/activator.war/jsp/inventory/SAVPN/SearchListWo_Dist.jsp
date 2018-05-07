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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(Wo_DistConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(Wo_DistConstants.DATASOURCE);
String tabName = request.getParameter(Wo_DistConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

Wo_DistForm form = (Wo_DistForm) request.getAttribute("Wo_DistForm");


String Manual___hide = null;
String Email___hide = null;
String WebServer___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListWo_Dist.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  Manual___hide = form.getManual___hide();
  Email___hide = form.getEmail___hide();
  WebServer___hide = form.getWebserver___hide();

  if ( Manual___hide != null )
    requestURI.append("manual___hide=" + Manual___hide);
  if ( Email___hide != null )
    requestURI.append("email___hide=" + Email___hide);
  if ( WebServer___hide != null )
    requestURI.append("webserver___hide=" + WebServer___hide);

} else {

    Manual___hide = request.getParameter("manual___hide");
    Email___hide = request.getParameter("email___hide");
    WebServer___hide = request.getParameter("webserver___hide");

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
    <title><bean:message bundle="Wo_DistApplicationResources" key="<%= Wo_DistConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="Wo_DistApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitWo_DistAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( Manual___hide == null || Manual___hide.equals("null") ) {
%>
      <display:column property="manual" sortable="true" titleKey="Wo_DistApplicationResources:field.manual.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Email___hide == null || Email___hide.equals("null") ) {
%>
      <display:column property="email" sortable="true" titleKey="Wo_DistApplicationResources:field.email.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( WebServer___hide == null || WebServer___hide.equals("null") ) {
%>
      <display:column property="webserver" sortable="true" titleKey="Wo_DistApplicationResources:field.webserver.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormWo_DistAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="manual" value="<%= form.getManual() %>"/>
                <html:hidden property="manual___hide" value="<%= form.getManual___hide() %>"/>
                        <html:hidden property="email" value="<%= form.getEmail() %>"/>
                <html:hidden property="email___hide" value="<%= form.getEmail___hide() %>"/>
                        <html:hidden property="webserver" value="<%= form.getWebserver() %>"/>
                <html:hidden property="webserver___hide" value="<%= form.getWebserver___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="manual" value="<%= request.getParameter(\"manual\") %>"/>
                <html:hidden property="manual___hide" value="<%= request.getParameter(\"manual___hide\") %>"/>
                        <html:hidden property="email" value="<%= request.getParameter(\"email\") %>"/>
                <html:hidden property="email___hide" value="<%= request.getParameter(\"email___hide\") %>"/>
                        <html:hidden property="webserver" value="<%= request.getParameter(\"webserver\") %>"/>
                <html:hidden property="webserver___hide" value="<%= request.getParameter(\"webserver___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.Wo_DistForm.submit()"/>
  </html:form>

  </body>
</html>
  
