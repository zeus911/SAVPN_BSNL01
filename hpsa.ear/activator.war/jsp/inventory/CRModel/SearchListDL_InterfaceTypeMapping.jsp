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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(DL_InterfaceTypeMappingConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(DL_InterfaceTypeMappingConstants.DATASOURCE);
String tabName = request.getParameter(DL_InterfaceTypeMappingConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

DL_InterfaceTypeMappingForm form = (DL_InterfaceTypeMappingForm) request.getAttribute("DL_InterfaceTypeMappingForm");


String Id___hide = null;
String ifType___hide = null;
String Vendor___hide = null;
String ElementType_Regexp___hide = null;
String OSVersion_Regexp___hide = null;
String ifDescr_Regexp___hide = null;
String HPSAType___hide = null;
String Description___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListDL_InterfaceTypeMapping.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  Id___hide = form.getId___hide();
  ifType___hide = form.getIftype___hide();
  Vendor___hide = form.getVendor___hide();
  ElementType_Regexp___hide = form.getElementtype_regexp___hide();
  OSVersion_Regexp___hide = form.getOsversion_regexp___hide();
  ifDescr_Regexp___hide = form.getIfdescr_regexp___hide();
  HPSAType___hide = form.getHpsatype___hide();
  Description___hide = form.getDescription___hide();

  if ( Id___hide != null )
    requestURI.append("id___hide=" + Id___hide);
  if ( ifType___hide != null )
    requestURI.append("iftype___hide=" + ifType___hide);
  if ( Vendor___hide != null )
    requestURI.append("vendor___hide=" + Vendor___hide);
  if ( ElementType_Regexp___hide != null )
    requestURI.append("elementtype_regexp___hide=" + ElementType_Regexp___hide);
  if ( OSVersion_Regexp___hide != null )
    requestURI.append("osversion_regexp___hide=" + OSVersion_Regexp___hide);
  if ( ifDescr_Regexp___hide != null )
    requestURI.append("ifdescr_regexp___hide=" + ifDescr_Regexp___hide);
  if ( HPSAType___hide != null )
    requestURI.append("hpsatype___hide=" + HPSAType___hide);
  if ( Description___hide != null )
    requestURI.append("description___hide=" + Description___hide);

} else {

    Id___hide = request.getParameter("id___hide");
    ifType___hide = request.getParameter("iftype___hide");
    Vendor___hide = request.getParameter("vendor___hide");
    ElementType_Regexp___hide = request.getParameter("elementtype_regexp___hide");
    OSVersion_Regexp___hide = request.getParameter("osversion_regexp___hide");
    ifDescr_Regexp___hide = request.getParameter("ifdescr_regexp___hide");
    HPSAType___hide = request.getParameter("hpsatype___hide");
    Description___hide = request.getParameter("description___hide");

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
    <title><bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="<%= DL_InterfaceTypeMappingConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitDL_InterfaceTypeMappingAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( Id___hide == null || Id___hide.equals("null") ) {
%>
      <display:column property="id" sortable="true" titleKey="DL_InterfaceTypeMappingApplicationResources:field.id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ifType___hide == null || ifType___hide.equals("null") ) {
%>
      <display:column property="iftype" sortable="true" titleKey="DL_InterfaceTypeMappingApplicationResources:field.iftype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Vendor___hide == null || Vendor___hide.equals("null") ) {
%>
      <display:column property="vendor" sortable="true" titleKey="DL_InterfaceTypeMappingApplicationResources:field.vendor.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ElementType_Regexp___hide == null || ElementType_Regexp___hide.equals("null") ) {
%>
      <display:column property="elementtype_regexp" sortable="true" titleKey="DL_InterfaceTypeMappingApplicationResources:field.elementtype_regexp.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( OSVersion_Regexp___hide == null || OSVersion_Regexp___hide.equals("null") ) {
%>
      <display:column property="osversion_regexp" sortable="true" titleKey="DL_InterfaceTypeMappingApplicationResources:field.osversion_regexp.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ifDescr_Regexp___hide == null || ifDescr_Regexp___hide.equals("null") ) {
%>
      <display:column property="ifdescr_regexp" sortable="true" titleKey="DL_InterfaceTypeMappingApplicationResources:field.ifdescr_regexp.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( HPSAType___hide == null || HPSAType___hide.equals("null") ) {
%>
      <display:column property="hpsatype" sortable="true" titleKey="DL_InterfaceTypeMappingApplicationResources:field.hpsatype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Description___hide == null || Description___hide.equals("null") ) {
%>
      <display:column property="description" sortable="true" titleKey="DL_InterfaceTypeMappingApplicationResources:field.description.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormDL_InterfaceTypeMappingAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="id" value="<%= form.getId() %>"/>
                <html:hidden property="id___hide" value="<%= form.getId___hide() %>"/>
                        <html:hidden property="iftype" value="<%= form.getIftype() %>"/>
                <html:hidden property="iftype___hide" value="<%= form.getIftype___hide() %>"/>
                        <html:hidden property="vendor" value="<%= form.getVendor() %>"/>
                <html:hidden property="vendor___hide" value="<%= form.getVendor___hide() %>"/>
                        <html:hidden property="elementtype_regexp" value="<%= form.getElementtype_regexp() %>"/>
                <html:hidden property="elementtype_regexp___hide" value="<%= form.getElementtype_regexp___hide() %>"/>
                        <html:hidden property="osversion_regexp" value="<%= form.getOsversion_regexp() %>"/>
                <html:hidden property="osversion_regexp___hide" value="<%= form.getOsversion_regexp___hide() %>"/>
                        <html:hidden property="ifdescr_regexp" value="<%= form.getIfdescr_regexp() %>"/>
                <html:hidden property="ifdescr_regexp___hide" value="<%= form.getIfdescr_regexp___hide() %>"/>
                        <html:hidden property="hpsatype" value="<%= form.getHpsatype() %>"/>
                <html:hidden property="hpsatype___hide" value="<%= form.getHpsatype___hide() %>"/>
                        <html:hidden property="description" value="<%= form.getDescription() %>"/>
                <html:hidden property="description___hide" value="<%= form.getDescription___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="id" value="<%= request.getParameter(\"id\") %>"/>
                <html:hidden property="id___hide" value="<%= request.getParameter(\"id___hide\") %>"/>
                        <html:hidden property="iftype" value="<%= request.getParameter(\"iftype\") %>"/>
                <html:hidden property="iftype___hide" value="<%= request.getParameter(\"iftype___hide\") %>"/>
                        <html:hidden property="vendor" value="<%= request.getParameter(\"vendor\") %>"/>
                <html:hidden property="vendor___hide" value="<%= request.getParameter(\"vendor___hide\") %>"/>
                        <html:hidden property="elementtype_regexp" value="<%= request.getParameter(\"elementtype_regexp\") %>"/>
                <html:hidden property="elementtype_regexp___hide" value="<%= request.getParameter(\"elementtype_regexp___hide\") %>"/>
                        <html:hidden property="osversion_regexp" value="<%= request.getParameter(\"osversion_regexp\") %>"/>
                <html:hidden property="osversion_regexp___hide" value="<%= request.getParameter(\"osversion_regexp___hide\") %>"/>
                        <html:hidden property="ifdescr_regexp" value="<%= request.getParameter(\"ifdescr_regexp\") %>"/>
                <html:hidden property="ifdescr_regexp___hide" value="<%= request.getParameter(\"ifdescr_regexp___hide\") %>"/>
                        <html:hidden property="hpsatype" value="<%= request.getParameter(\"hpsatype\") %>"/>
                <html:hidden property="hpsatype___hide" value="<%= request.getParameter(\"hpsatype___hide\") %>"/>
                        <html:hidden property="description" value="<%= request.getParameter(\"description\") %>"/>
                <html:hidden property="description___hide" value="<%= request.getParameter(\"description___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.DL_InterfaceTypeMappingForm.submit()"/>
  </html:form>

  </body>
</html>
  
