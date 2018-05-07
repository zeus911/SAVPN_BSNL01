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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(DL_ElementTypeMappingConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(DL_ElementTypeMappingConstants.DATASOURCE);
String tabName = request.getParameter(DL_ElementTypeMappingConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

DL_ElementTypeMappingForm form = (DL_ElementTypeMappingForm) request.getAttribute("DL_ElementTypeMappingForm");


String Id___hide = null;
String deviceModel___hide = null;
String ElementTypeGroup___hide = null;
String ElementType___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListDL_ElementTypeMapping.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  Id___hide = form.getId___hide();
  deviceModel___hide = form.getDevicemodel___hide();
  ElementTypeGroup___hide = form.getElementtypegroup___hide();
  ElementType___hide = form.getElementtype___hide();

  if ( Id___hide != null )
    requestURI.append("id___hide=" + Id___hide);
  if ( deviceModel___hide != null )
    requestURI.append("devicemodel___hide=" + deviceModel___hide);
  if ( ElementTypeGroup___hide != null )
    requestURI.append("elementtypegroup___hide=" + ElementTypeGroup___hide);
  if ( ElementType___hide != null )
    requestURI.append("elementtype___hide=" + ElementType___hide);

} else {

    Id___hide = request.getParameter("id___hide");
    deviceModel___hide = request.getParameter("devicemodel___hide");
    ElementTypeGroup___hide = request.getParameter("elementtypegroup___hide");
    ElementType___hide = request.getParameter("elementtype___hide");

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
    <title><bean:message bundle="DL_ElementTypeMappingApplicationResources" key="<%= DL_ElementTypeMappingConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_ElementTypeMappingApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitDL_ElementTypeMappingAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( Id___hide == null || Id___hide.equals("null") ) {
%>
      <display:column property="id" sortable="true" titleKey="DL_ElementTypeMappingApplicationResources:field.id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( deviceModel___hide == null || deviceModel___hide.equals("null") ) {
%>
      <display:column property="devicemodel" sortable="true" titleKey="DL_ElementTypeMappingApplicationResources:field.devicemodel.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ElementTypeGroup___hide == null || ElementTypeGroup___hide.equals("null") ) {
%>
      <display:column property="elementtypegroup" sortable="true" titleKey="DL_ElementTypeMappingApplicationResources:field.elementtypegroup.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ElementType___hide == null || ElementType___hide.equals("null") ) {
%>
      <display:column property="elementtype" sortable="true" titleKey="DL_ElementTypeMappingApplicationResources:field.elementtype.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormDL_ElementTypeMappingAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="id" value="<%= form.getId() %>"/>
                <html:hidden property="id___hide" value="<%= form.getId___hide() %>"/>
                        <html:hidden property="devicemodel" value="<%= form.getDevicemodel() %>"/>
                <html:hidden property="devicemodel___hide" value="<%= form.getDevicemodel___hide() %>"/>
                        <html:hidden property="elementtypegroup" value="<%= form.getElementtypegroup() %>"/>
                <html:hidden property="elementtypegroup___hide" value="<%= form.getElementtypegroup___hide() %>"/>
                        <html:hidden property="elementtype" value="<%= form.getElementtype() %>"/>
                <html:hidden property="elementtype___hide" value="<%= form.getElementtype___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="id" value="<%= request.getParameter(\"id\") %>"/>
                <html:hidden property="id___hide" value="<%= request.getParameter(\"id___hide\") %>"/>
                        <html:hidden property="devicemodel" value="<%= request.getParameter(\"devicemodel\") %>"/>
                <html:hidden property="devicemodel___hide" value="<%= request.getParameter(\"devicemodel___hide\") %>"/>
                        <html:hidden property="elementtypegroup" value="<%= request.getParameter(\"elementtypegroup\") %>"/>
                <html:hidden property="elementtypegroup___hide" value="<%= request.getParameter(\"elementtypegroup___hide\") %>"/>
                        <html:hidden property="elementtype" value="<%= request.getParameter(\"elementtype\") %>"/>
                <html:hidden property="elementtype___hide" value="<%= request.getParameter(\"elementtype___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.DL_ElementTypeMappingForm.submit()"/>
  </html:form>

  </body>
</html>
  
