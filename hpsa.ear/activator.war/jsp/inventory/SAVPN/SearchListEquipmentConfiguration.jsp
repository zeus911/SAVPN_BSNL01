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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(EquipmentConfigurationConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(EquipmentConfigurationConstants.DATASOURCE);
String tabName = request.getParameter(EquipmentConfigurationConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

EquipmentConfigurationForm form = (EquipmentConfigurationForm) request.getAttribute("EquipmentConfigurationForm");


String EquipmentID___hide = null;
String TimeStamp___hide = null;
String Version___hide = null;
String LastAccessTime___hide = null;
String MemoryType___hide = null;
String CreatedBy___hide = null;
String ModifiedBy___hide = null;
String DirtyFlag___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListEquipmentConfiguration.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  EquipmentID___hide = form.getEquipmentid___hide();
  TimeStamp___hide = form.getTimestamp___hide();
  Version___hide = form.getVersion___hide();
  LastAccessTime___hide = form.getLastaccesstime___hide();
  MemoryType___hide = form.getMemorytype___hide();
  CreatedBy___hide = form.getCreatedby___hide();
  ModifiedBy___hide = form.getModifiedby___hide();
  DirtyFlag___hide = form.getDirtyflag___hide();

  if ( EquipmentID___hide != null )
    requestURI.append("equipmentid___hide=" + EquipmentID___hide);
  if ( TimeStamp___hide != null )
    requestURI.append("timestamp___hide=" + TimeStamp___hide);
  if ( Version___hide != null )
    requestURI.append("version___hide=" + Version___hide);
  if ( LastAccessTime___hide != null )
    requestURI.append("lastaccesstime___hide=" + LastAccessTime___hide);
  if ( MemoryType___hide != null )
    requestURI.append("memorytype___hide=" + MemoryType___hide);
  if ( CreatedBy___hide != null )
    requestURI.append("createdby___hide=" + CreatedBy___hide);
  if ( ModifiedBy___hide != null )
    requestURI.append("modifiedby___hide=" + ModifiedBy___hide);
  if ( DirtyFlag___hide != null )
    requestURI.append("dirtyflag___hide=" + DirtyFlag___hide);

} else {

    EquipmentID___hide = request.getParameter("equipmentid___hide");
    TimeStamp___hide = request.getParameter("timestamp___hide");
    Version___hide = request.getParameter("version___hide");
    LastAccessTime___hide = request.getParameter("lastaccesstime___hide");
    MemoryType___hide = request.getParameter("memorytype___hide");
    CreatedBy___hide = request.getParameter("createdby___hide");
    ModifiedBy___hide = request.getParameter("modifiedby___hide");
    DirtyFlag___hide = request.getParameter("dirtyflag___hide");

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
    <title><bean:message bundle="EquipmentConfigurationApplicationResources" key="<%= EquipmentConfigurationConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="EquipmentConfigurationApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitEquipmentConfigurationAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( EquipmentID___hide == null || EquipmentID___hide.equals("null") ) {
%>
      <display:column property="equipmentid" sortable="true" titleKey="EquipmentConfigurationApplicationResources:field.equipmentid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( TimeStamp___hide == null || TimeStamp___hide.equals("null") ) {
%>
      <display:column property="timestamp" sortable="true" titleKey="EquipmentConfigurationApplicationResources:field.timestamp.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Version___hide == null || Version___hide.equals("null") ) {
%>
      <display:column property="version" sortable="true" titleKey="EquipmentConfigurationApplicationResources:field.version.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( LastAccessTime___hide == null || LastAccessTime___hide.equals("null") ) {
%>
      <display:column property="lastaccesstime" sortable="true" titleKey="EquipmentConfigurationApplicationResources:field.lastaccesstime.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( MemoryType___hide == null || MemoryType___hide.equals("null") ) {
%>
      <display:column property="memorytype" sortable="true" titleKey="EquipmentConfigurationApplicationResources:field.memorytype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CreatedBy___hide == null || CreatedBy___hide.equals("null") ) {
%>
      <display:column property="createdby" sortable="true" titleKey="EquipmentConfigurationApplicationResources:field.createdby.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ModifiedBy___hide == null || ModifiedBy___hide.equals("null") ) {
%>
      <display:column property="modifiedby" sortable="true" titleKey="EquipmentConfigurationApplicationResources:field.modifiedby.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( DirtyFlag___hide == null || DirtyFlag___hide.equals("null") ) {
%>
      <display:column property="dirtyflag" sortable="true" titleKey="EquipmentConfigurationApplicationResources:field.dirtyflag.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormEquipmentConfigurationAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="equipmentid" value="<%= form.getEquipmentid() %>"/>
                <html:hidden property="equipmentid___hide" value="<%= form.getEquipmentid___hide() %>"/>
                        <html:hidden property="timestamp" value="<%= form.getTimestamp() %>"/>
                <html:hidden property="timestamp___hide" value="<%= form.getTimestamp___hide() %>"/>
                        <html:hidden property="version" value="<%= form.getVersion() %>"/>
                <html:hidden property="version___hide" value="<%= form.getVersion___hide() %>"/>
                                  <html:hidden property="lastaccesstime" value="<%= form.getLastaccesstime() %>"/>
                <html:hidden property="lastaccesstime___hide" value="<%= form.getLastaccesstime___hide() %>"/>
                        <html:hidden property="memorytype" value="<%= form.getMemorytype() %>"/>
                <html:hidden property="memorytype___hide" value="<%= form.getMemorytype___hide() %>"/>
                        <html:hidden property="createdby" value="<%= form.getCreatedby() %>"/>
                <html:hidden property="createdby___hide" value="<%= form.getCreatedby___hide() %>"/>
                        <html:hidden property="modifiedby" value="<%= form.getModifiedby() %>"/>
                <html:hidden property="modifiedby___hide" value="<%= form.getModifiedby___hide() %>"/>
                        <html:hidden property="dirtyflag" value="<%= form.getDirtyflag() %>"/>
                <html:hidden property="dirtyflag___hide" value="<%= form.getDirtyflag___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="equipmentid" value="<%= request.getParameter(\"equipmentid\") %>"/>
                <html:hidden property="equipmentid___hide" value="<%= request.getParameter(\"equipmentid___hide\") %>"/>
                        <html:hidden property="timestamp" value="<%= request.getParameter(\"timestamp\") %>"/>
                <html:hidden property="timestamp___hide" value="<%= request.getParameter(\"timestamp___hide\") %>"/>
                        <html:hidden property="version" value="<%= request.getParameter(\"version\") %>"/>
                <html:hidden property="version___hide" value="<%= request.getParameter(\"version___hide\") %>"/>
                                  <html:hidden property="lastaccesstime" value="<%= request.getParameter(\"lastaccesstime\") %>"/>
                <html:hidden property="lastaccesstime___hide" value="<%= request.getParameter(\"lastaccesstime___hide\") %>"/>
                        <html:hidden property="memorytype" value="<%= request.getParameter(\"memorytype\") %>"/>
                <html:hidden property="memorytype___hide" value="<%= request.getParameter(\"memorytype___hide\") %>"/>
                        <html:hidden property="createdby" value="<%= request.getParameter(\"createdby\") %>"/>
                <html:hidden property="createdby___hide" value="<%= request.getParameter(\"createdby___hide\") %>"/>
                        <html:hidden property="modifiedby" value="<%= request.getParameter(\"modifiedby\") %>"/>
                <html:hidden property="modifiedby___hide" value="<%= request.getParameter(\"modifiedby___hide\") %>"/>
                        <html:hidden property="dirtyflag" value="<%= request.getParameter(\"dirtyflag\") %>"/>
                <html:hidden property="dirtyflag___hide" value="<%= request.getParameter(\"dirtyflag___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.EquipmentConfigurationForm.submit()"/>
  </html:form>

  </body>
</html>
  
