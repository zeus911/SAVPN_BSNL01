<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        java.lang.reflect.Method,
        com.hp.ov.activator.na.common.*,
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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(NAConfigurationConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(NAConfigurationConstants.DATASOURCE);
String tabName = request.getParameter(NAConfigurationConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

NAConfigurationForm form = (NAConfigurationForm) request.getAttribute("NAConfigurationForm");


String enable_proxy___hide = null;
String Id___hide = null;
String proxy_hostname___hide = null;
String proxy_port___hide = null;
String proxy_username___hide = null;
String cl_protocol___hide = null;
String cl_hostname___hide = null;
String cl_port___hide = null;
String cl_username___hide = null;
String enable_cl___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListNAConfiguration.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  enable_proxy___hide = form.getEnable_proxy___hide();
  Id___hide = form.getId___hide();
  proxy_hostname___hide = form.getProxy_hostname___hide();
  proxy_port___hide = form.getProxy_port___hide();
  proxy_username___hide = form.getProxy_username___hide();
  cl_protocol___hide = form.getCl_protocol___hide();
  cl_hostname___hide = form.getCl_hostname___hide();
  cl_port___hide = form.getCl_port___hide();
  cl_username___hide = form.getCl_username___hide();
  enable_cl___hide = form.getEnable_cl___hide();

  if ( enable_proxy___hide != null )
    requestURI.append("enable_proxy___hide=" + enable_proxy___hide);
  if ( Id___hide != null )
    requestURI.append("id___hide=" + Id___hide);
  if ( proxy_hostname___hide != null )
    requestURI.append("proxy_hostname___hide=" + proxy_hostname___hide);
  if ( proxy_port___hide != null )
    requestURI.append("proxy_port___hide=" + proxy_port___hide);
  if ( proxy_username___hide != null )
    requestURI.append("proxy_username___hide=" + proxy_username___hide);
  if ( cl_protocol___hide != null )
    requestURI.append("cl_protocol___hide=" + cl_protocol___hide);
  if ( cl_hostname___hide != null )
    requestURI.append("cl_hostname___hide=" + cl_hostname___hide);
  if ( cl_port___hide != null )
    requestURI.append("cl_port___hide=" + cl_port___hide);
  if ( cl_username___hide != null )
    requestURI.append("cl_username___hide=" + cl_username___hide);
  if ( enable_cl___hide != null )
    requestURI.append("enable_cl___hide=" + enable_cl___hide);

} else {

    enable_proxy___hide = request.getParameter("enable_proxy___hide");
    Id___hide = request.getParameter("id___hide");
    proxy_hostname___hide = request.getParameter("proxy_hostname___hide");
    proxy_port___hide = request.getParameter("proxy_port___hide");
    proxy_username___hide = request.getParameter("proxy_username___hide");
    cl_protocol___hide = request.getParameter("cl_protocol___hide");
    cl_hostname___hide = request.getParameter("cl_hostname___hide");
    cl_port___hide = request.getParameter("cl_port___hide");
    cl_username___hide = request.getParameter("cl_username___hide");
    enable_cl___hide = request.getParameter("enable_cl___hide");

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
    <title><bean:message bundle="NAConfigurationApplicationResources" key="<%= NAConfigurationConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="NAConfigurationApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitNAConfigurationAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( enable_proxy___hide == null || enable_proxy___hide.equals("null") ) {
%>
      <display:column property="enable_proxy" sortable="true" titleKey="NAConfigurationApplicationResources:field.enable_proxy.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Id___hide == null || Id___hide.equals("null") ) {
%>
      <display:column property="id" sortable="true" titleKey="NAConfigurationApplicationResources:field.id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( proxy_hostname___hide == null || proxy_hostname___hide.equals("null") ) {
%>
      <display:column property="proxy_hostname" sortable="true" titleKey="NAConfigurationApplicationResources:field.proxy_hostname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( proxy_port___hide == null || proxy_port___hide.equals("null") ) {
%>
      <display:column property="proxy_port" sortable="true" titleKey="NAConfigurationApplicationResources:field.proxy_port.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( proxy_username___hide == null || proxy_username___hide.equals("null") ) {
%>
      <display:column property="proxy_username" sortable="true" titleKey="NAConfigurationApplicationResources:field.proxy_username.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( cl_protocol___hide == null || cl_protocol___hide.equals("null") ) {
%>
      <display:column property="cl_protocol" sortable="true" titleKey="NAConfigurationApplicationResources:field.cl_protocol.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( cl_hostname___hide == null || cl_hostname___hide.equals("null") ) {
%>
      <display:column property="cl_hostname" sortable="true" titleKey="NAConfigurationApplicationResources:field.cl_hostname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( cl_port___hide == null || cl_port___hide.equals("null") ) {
%>
      <display:column property="cl_port" sortable="true" titleKey="NAConfigurationApplicationResources:field.cl_port.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( cl_username___hide == null || cl_username___hide.equals("null") ) {
%>
      <display:column property="cl_username" sortable="true" titleKey="NAConfigurationApplicationResources:field.cl_username.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( enable_cl___hide == null || enable_cl___hide.equals("null") ) {
%>
      <display:column property="enable_cl" sortable="true" titleKey="NAConfigurationApplicationResources:field.enable_cl.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormNAConfigurationAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="enable_proxy" value="<%= form.getEnable_proxy() %>"/>
                <html:hidden property="enable_proxy___hide" value="<%= form.getEnable_proxy___hide() %>"/>
                        <html:hidden property="id" value="<%= form.getId() %>"/>
                <html:hidden property="id___hide" value="<%= form.getId___hide() %>"/>
                        <html:hidden property="proxy_hostname" value="<%= form.getProxy_hostname() %>"/>
                <html:hidden property="proxy_hostname___hide" value="<%= form.getProxy_hostname___hide() %>"/>
                        <html:hidden property="proxy_port" value="<%= form.getProxy_port() %>"/>
                <html:hidden property="proxy_port___hide" value="<%= form.getProxy_port___hide() %>"/>
                        <html:hidden property="proxy_username" value="<%= form.getProxy_username() %>"/>
                <html:hidden property="proxy_username___hide" value="<%= form.getProxy_username___hide() %>"/>
                                  <html:hidden property="cl_protocol" value="<%= form.getCl_protocol() %>"/>
                <html:hidden property="cl_protocol___hide" value="<%= form.getCl_protocol___hide() %>"/>
                        <html:hidden property="cl_hostname" value="<%= form.getCl_hostname() %>"/>
                <html:hidden property="cl_hostname___hide" value="<%= form.getCl_hostname___hide() %>"/>
                        <html:hidden property="cl_port" value="<%= form.getCl_port() %>"/>
                <html:hidden property="cl_port___hide" value="<%= form.getCl_port___hide() %>"/>
                        <html:hidden property="cl_username" value="<%= form.getCl_username() %>"/>
                <html:hidden property="cl_username___hide" value="<%= form.getCl_username___hide() %>"/>
                                  <html:hidden property="enable_cl" value="<%= form.getEnable_cl() %>"/>
                <html:hidden property="enable_cl___hide" value="<%= form.getEnable_cl___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="enable_proxy" value="<%= request.getParameter(\"enable_proxy\") %>"/>
                <html:hidden property="enable_proxy___hide" value="<%= request.getParameter(\"enable_proxy___hide\") %>"/>
                        <html:hidden property="id" value="<%= request.getParameter(\"id\") %>"/>
                <html:hidden property="id___hide" value="<%= request.getParameter(\"id___hide\") %>"/>
                        <html:hidden property="proxy_hostname" value="<%= request.getParameter(\"proxy_hostname\") %>"/>
                <html:hidden property="proxy_hostname___hide" value="<%= request.getParameter(\"proxy_hostname___hide\") %>"/>
                        <html:hidden property="proxy_port" value="<%= request.getParameter(\"proxy_port\") %>"/>
                <html:hidden property="proxy_port___hide" value="<%= request.getParameter(\"proxy_port___hide\") %>"/>
                        <html:hidden property="proxy_username" value="<%= request.getParameter(\"proxy_username\") %>"/>
                <html:hidden property="proxy_username___hide" value="<%= request.getParameter(\"proxy_username___hide\") %>"/>
                                  <html:hidden property="cl_protocol" value="<%= request.getParameter(\"cl_protocol\") %>"/>
                <html:hidden property="cl_protocol___hide" value="<%= request.getParameter(\"cl_protocol___hide\") %>"/>
                        <html:hidden property="cl_hostname" value="<%= request.getParameter(\"cl_hostname\") %>"/>
                <html:hidden property="cl_hostname___hide" value="<%= request.getParameter(\"cl_hostname___hide\") %>"/>
                        <html:hidden property="cl_port" value="<%= request.getParameter(\"cl_port\") %>"/>
                <html:hidden property="cl_port___hide" value="<%= request.getParameter(\"cl_port___hide\") %>"/>
                        <html:hidden property="cl_username" value="<%= request.getParameter(\"cl_username\") %>"/>
                <html:hidden property="cl_username___hide" value="<%= request.getParameter(\"cl_username___hide\") %>"/>
                                  <html:hidden property="enable_cl" value="<%= request.getParameter(\"enable_cl\") %>"/>
                <html:hidden property="enable_cl___hide" value="<%= request.getParameter(\"enable_cl___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.NAConfigurationForm.submit()"/>
  </html:form>

  </body>
</html>
  
