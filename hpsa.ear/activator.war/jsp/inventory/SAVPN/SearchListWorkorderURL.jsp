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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(WorkorderURLConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(WorkorderURLConstants.DATASOURCE);
String tabName = request.getParameter(WorkorderURLConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

WorkorderURLForm form = (WorkorderURLForm) request.getAttribute("WorkorderURLForm");


String WODistributionID___hide = null;
String Webserver___hide = null;
String Email___hide = null;
String Location___hide = null;
String Region___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListWorkorderURL.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  WODistributionID___hide = form.getWodistributionid___hide();
  Webserver___hide = form.getWebserver___hide();
  Email___hide = form.getEmail___hide();
  Location___hide = form.getLocation___hide();
  Region___hide = form.getRegion___hide();

  if ( WODistributionID___hide != null )
    requestURI.append("wodistributionid___hide=" + WODistributionID___hide);
  if ( Webserver___hide != null )
    requestURI.append("webserver___hide=" + Webserver___hide);
  if ( Email___hide != null )
    requestURI.append("email___hide=" + Email___hide);
  if ( Location___hide != null )
    requestURI.append("location___hide=" + Location___hide);
  if ( Region___hide != null )
    requestURI.append("region___hide=" + Region___hide);

} else {

    WODistributionID___hide = request.getParameter("wodistributionid___hide");
    Webserver___hide = request.getParameter("webserver___hide");
    Email___hide = request.getParameter("email___hide");
    Location___hide = request.getParameter("location___hide");
    Region___hide = request.getParameter("region___hide");

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
    <title><bean:message bundle="WorkorderURLApplicationResources" key="<%= WorkorderURLConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="WorkorderURLApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitWorkorderURLAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( WODistributionID___hide == null || WODistributionID___hide.equals("null") ) {
%>
      <display:column property="wodistributionid" sortable="true" titleKey="WorkorderURLApplicationResources:field.wodistributionid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Webserver___hide == null || Webserver___hide.equals("null") ) {
%>
      <display:column property="webserver" sortable="true" titleKey="WorkorderURLApplicationResources:field.webserver.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Email___hide == null || Email___hide.equals("null") ) {
%>
      <display:column property="email" sortable="true" titleKey="WorkorderURLApplicationResources:field.email.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Location___hide == null || Location___hide.equals("null") ) {
%>
      <display:column property="location" sortable="true" titleKey="WorkorderURLApplicationResources:field.location.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Region___hide == null || Region___hide.equals("null") ) {
%>
      <display:column property="region" sortable="true" titleKey="WorkorderURLApplicationResources:field.region.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormWorkorderURLAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="wodistributionid" value="<%= form.getWodistributionid() %>"/>
                  <html:hidden property="wodistributionid___" value="<%= form.getWodistributionid___() %>"/>
                <html:hidden property="wodistributionid___hide" value="<%= form.getWodistributionid___hide() %>"/>
                        <html:hidden property="webserver" value="<%= form.getWebserver() %>"/>
                <html:hidden property="webserver___hide" value="<%= form.getWebserver___hide() %>"/>
                        <html:hidden property="email" value="<%= form.getEmail() %>"/>
                <html:hidden property="email___hide" value="<%= form.getEmail___hide() %>"/>
                        <html:hidden property="location" value="<%= form.getLocation() %>"/>
                <html:hidden property="location___hide" value="<%= form.getLocation___hide() %>"/>
                        <html:hidden property="region" value="<%= form.getRegion() %>"/>
                <html:hidden property="region___hide" value="<%= form.getRegion___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="wodistributionid" value="<%= request.getParameter(\"wodistributionid\") %>"/>
                  <html:hidden property="wodistributionid___" value="<%= request.getParameter(\"wodistributionid___\") %>"/>
                <html:hidden property="wodistributionid___hide" value="<%= request.getParameter(\"wodistributionid___hide\") %>"/>
                        <html:hidden property="webserver" value="<%= request.getParameter(\"webserver\") %>"/>
                <html:hidden property="webserver___hide" value="<%= request.getParameter(\"webserver___hide\") %>"/>
                        <html:hidden property="email" value="<%= request.getParameter(\"email\") %>"/>
                <html:hidden property="email___hide" value="<%= request.getParameter(\"email___hide\") %>"/>
                        <html:hidden property="location" value="<%= request.getParameter(\"location\") %>"/>
                <html:hidden property="location___hide" value="<%= request.getParameter(\"location___hide\") %>"/>
                        <html:hidden property="region" value="<%= request.getParameter(\"region\") %>"/>
                <html:hidden property="region___hide" value="<%= request.getParameter(\"region___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.WorkorderURLForm.submit()"/>
  </html:form>

  </body>
</html>
  
