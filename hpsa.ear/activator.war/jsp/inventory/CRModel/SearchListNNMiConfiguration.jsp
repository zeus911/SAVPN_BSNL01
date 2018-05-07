<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        java.lang.reflect.Method,
        com.hp.ov.activator.nnm.common.*,
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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(NNMiConfigurationConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(NNMiConfigurationConstants.DATASOURCE);
String tabName = request.getParameter(NNMiConfigurationConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

NNMiConfigurationForm form = (NNMiConfigurationForm) request.getAttribute("NNMiConfigurationForm");


String Id___hide = null;
String Protocol___hide = null;
String Hostname___hide = null;
String Port___hide = null;
String Rediscover_enable___hide = null;
String CustomAttributes_enable___hide = null;
String InterfaceGroup_enable___hide = null;
String enable_cl___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListNNMiConfiguration.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  Id___hide = form.getId___hide();
  Protocol___hide = form.getProtocol___hide();
  Hostname___hide = form.getHostname___hide();
  Port___hide = form.getPort___hide();
  Rediscover_enable___hide = form.getRediscover_enable___hide();
  CustomAttributes_enable___hide = form.getCustomattributes_enable___hide();
  InterfaceGroup_enable___hide = form.getInterfacegroup_enable___hide();
  enable_cl___hide = form.getEnable_cl___hide();

  if ( Id___hide != null )
    requestURI.append("id___hide=" + Id___hide);
  if ( Protocol___hide != null )
    requestURI.append("protocol___hide=" + Protocol___hide);
  if ( Hostname___hide != null )
    requestURI.append("hostname___hide=" + Hostname___hide);
  if ( Port___hide != null )
    requestURI.append("port___hide=" + Port___hide);
  if ( Rediscover_enable___hide != null )
    requestURI.append("rediscover_enable___hide=" + Rediscover_enable___hide);
  if ( CustomAttributes_enable___hide != null )
    requestURI.append("customattributes_enable___hide=" + CustomAttributes_enable___hide);
  if ( InterfaceGroup_enable___hide != null )
    requestURI.append("interfacegroup_enable___hide=" + InterfaceGroup_enable___hide);
  if ( enable_cl___hide != null )
    requestURI.append("enable_cl___hide=" + enable_cl___hide);

} else {

    Id___hide = request.getParameter("id___hide");
    Protocol___hide = request.getParameter("protocol___hide");
    Hostname___hide = request.getParameter("hostname___hide");
    Port___hide = request.getParameter("port___hide");
    Rediscover_enable___hide = request.getParameter("rediscover_enable___hide");
    CustomAttributes_enable___hide = request.getParameter("customattributes_enable___hide");
    InterfaceGroup_enable___hide = request.getParameter("interfacegroup_enable___hide");
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
    <title><bean:message bundle="NNMiConfigurationApplicationResources" key="<%= NNMiConfigurationConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="NNMiConfigurationApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitNNMiConfigurationAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( Id___hide == null || Id___hide.equals("null") ) {
%>
      <display:column property="id" sortable="true" titleKey="NNMiConfigurationApplicationResources:field.id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Protocol___hide == null || Protocol___hide.equals("null") ) {
%>
      <display:column property="protocol" sortable="true" titleKey="NNMiConfigurationApplicationResources:field.protocol.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Hostname___hide == null || Hostname___hide.equals("null") ) {
%>
      <display:column property="hostname" sortable="true" titleKey="NNMiConfigurationApplicationResources:field.hostname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Port___hide == null || Port___hide.equals("null") ) {
%>
      <display:column property="port" sortable="true" titleKey="NNMiConfigurationApplicationResources:field.port.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Rediscover_enable___hide == null || Rediscover_enable___hide.equals("null") ) {
%>
      <display:column property="rediscover_enable" sortable="true" titleKey="NNMiConfigurationApplicationResources:field.rediscover_enable.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CustomAttributes_enable___hide == null || CustomAttributes_enable___hide.equals("null") ) {
%>
      <display:column property="customattributes_enable" sortable="true" titleKey="NNMiConfigurationApplicationResources:field.customattributes_enable.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( InterfaceGroup_enable___hide == null || InterfaceGroup_enable___hide.equals("null") ) {
%>
      <display:column property="interfacegroup_enable" sortable="true" titleKey="NNMiConfigurationApplicationResources:field.interfacegroup_enable.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( enable_cl___hide == null || enable_cl___hide.equals("null") ) {
%>
      <display:column property="enable_cl" sortable="true" titleKey="NNMiConfigurationApplicationResources:field.enable_cl.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormNNMiConfigurationAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="id" value="<%= form.getId() %>"/>
                <html:hidden property="id___hide" value="<%= form.getId___hide() %>"/>
                        <html:hidden property="protocol" value="<%= form.getProtocol() %>"/>
                <html:hidden property="protocol___hide" value="<%= form.getProtocol___hide() %>"/>
                        <html:hidden property="hostname" value="<%= form.getHostname() %>"/>
                <html:hidden property="hostname___hide" value="<%= form.getHostname___hide() %>"/>
                        <html:hidden property="port" value="<%= form.getPort() %>"/>
                <html:hidden property="port___hide" value="<%= form.getPort___hide() %>"/>
                        <html:hidden property="rediscover_enable" value="<%= form.getRediscover_enable() %>"/>
                <html:hidden property="rediscover_enable___hide" value="<%= form.getRediscover_enable___hide() %>"/>
                        <html:hidden property="customattributes_enable" value="<%= form.getCustomattributes_enable() %>"/>
                <html:hidden property="customattributes_enable___hide" value="<%= form.getCustomattributes_enable___hide() %>"/>
                        <html:hidden property="interfacegroup_enable" value="<%= form.getInterfacegroup_enable() %>"/>
                <html:hidden property="interfacegroup_enable___hide" value="<%= form.getInterfacegroup_enable___hide() %>"/>
                        <html:hidden property="enable_cl" value="<%= form.getEnable_cl() %>"/>
                <html:hidden property="enable_cl___hide" value="<%= form.getEnable_cl___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="id" value="<%= request.getParameter(\"id\") %>"/>
                <html:hidden property="id___hide" value="<%= request.getParameter(\"id___hide\") %>"/>
                        <html:hidden property="protocol" value="<%= request.getParameter(\"protocol\") %>"/>
                <html:hidden property="protocol___hide" value="<%= request.getParameter(\"protocol___hide\") %>"/>
                        <html:hidden property="hostname" value="<%= request.getParameter(\"hostname\") %>"/>
                <html:hidden property="hostname___hide" value="<%= request.getParameter(\"hostname___hide\") %>"/>
                        <html:hidden property="port" value="<%= request.getParameter(\"port\") %>"/>
                <html:hidden property="port___hide" value="<%= request.getParameter(\"port___hide\") %>"/>
                        <html:hidden property="rediscover_enable" value="<%= request.getParameter(\"rediscover_enable\") %>"/>
                <html:hidden property="rediscover_enable___hide" value="<%= request.getParameter(\"rediscover_enable___hide\") %>"/>
                        <html:hidden property="customattributes_enable" value="<%= request.getParameter(\"customattributes_enable\") %>"/>
                <html:hidden property="customattributes_enable___hide" value="<%= request.getParameter(\"customattributes_enable___hide\") %>"/>
                        <html:hidden property="interfacegroup_enable" value="<%= request.getParameter(\"interfacegroup_enable\") %>"/>
                <html:hidden property="interfacegroup_enable___hide" value="<%= request.getParameter(\"interfacegroup_enable___hide\") %>"/>
                        <html:hidden property="enable_cl" value="<%= request.getParameter(\"enable_cl\") %>"/>
                <html:hidden property="enable_cl___hide" value="<%= request.getParameter(\"enable_cl___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.NNMiConfigurationForm.submit()"/>
  </html:form>

  </body>
</html>
  
