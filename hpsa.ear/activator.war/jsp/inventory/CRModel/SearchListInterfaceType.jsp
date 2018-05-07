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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(InterfaceTypeConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(InterfaceTypeConstants.DATASOURCE);
String tabName = request.getParameter(InterfaceTypeConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

InterfaceTypeForm form = (InterfaceTypeForm) request.getAttribute("InterfaceTypeForm");


String InterfaceTypeName___hide = null;
String GenericType___hide = null;
String Description___hide = null;
String Vendor___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListInterfaceType.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  InterfaceTypeName___hide = form.getInterfacetypename___hide();
  GenericType___hide = form.getGenerictype___hide();
  Description___hide = form.getDescription___hide();
  Vendor___hide = form.getVendor___hide();

  if ( InterfaceTypeName___hide != null )
    requestURI.append("interfacetypename___hide=" + InterfaceTypeName___hide);
  if ( GenericType___hide != null )
    requestURI.append("generictype___hide=" + GenericType___hide);
  if ( Description___hide != null )
    requestURI.append("description___hide=" + Description___hide);
  if ( Vendor___hide != null )
    requestURI.append("vendor___hide=" + Vendor___hide);

} else {

    InterfaceTypeName___hide = request.getParameter("interfacetypename___hide");
    GenericType___hide = request.getParameter("generictype___hide");
    Description___hide = request.getParameter("description___hide");
    Vendor___hide = request.getParameter("vendor___hide");

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
    <title><bean:message bundle="InterfaceTypeApplicationResources" key="<%= InterfaceTypeConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="InterfaceTypeApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitInterfaceTypeAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( InterfaceTypeName___hide == null || InterfaceTypeName___hide.equals("null") ) {
%>
      <display:column property="interfacetypename" sortable="true" titleKey="InterfaceTypeApplicationResources:field.interfacetypename.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( GenericType___hide == null || GenericType___hide.equals("null") ) {
%>
      <display:column property="generictype" sortable="true" titleKey="InterfaceTypeApplicationResources:field.generictype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Description___hide == null || Description___hide.equals("null") ) {
%>
      <display:column property="description" sortable="true" titleKey="InterfaceTypeApplicationResources:field.description.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Vendor___hide == null || Vendor___hide.equals("null") ) {
%>
      <display:column property="vendor" sortable="true" titleKey="InterfaceTypeApplicationResources:field.vendor.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormInterfaceTypeAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="interfacetypename" value="<%= form.getInterfacetypename() %>"/>
                <html:hidden property="interfacetypename___hide" value="<%= form.getInterfacetypename___hide() %>"/>
                        <html:hidden property="generictype" value="<%= form.getGenerictype() %>"/>
                <html:hidden property="generictype___hide" value="<%= form.getGenerictype___hide() %>"/>
                        <html:hidden property="description" value="<%= form.getDescription() %>"/>
                <html:hidden property="description___hide" value="<%= form.getDescription___hide() %>"/>
                        <html:hidden property="vendor" value="<%= form.getVendor() %>"/>
                <html:hidden property="vendor___hide" value="<%= form.getVendor___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="interfacetypename" value="<%= request.getParameter(\"interfacetypename\") %>"/>
                <html:hidden property="interfacetypename___hide" value="<%= request.getParameter(\"interfacetypename___hide\") %>"/>
                        <html:hidden property="generictype" value="<%= request.getParameter(\"generictype\") %>"/>
                <html:hidden property="generictype___hide" value="<%= request.getParameter(\"generictype___hide\") %>"/>
                        <html:hidden property="description" value="<%= request.getParameter(\"description\") %>"/>
                <html:hidden property="description___hide" value="<%= request.getParameter(\"description___hide\") %>"/>
                        <html:hidden property="vendor" value="<%= request.getParameter(\"vendor\") %>"/>
                <html:hidden property="vendor___hide" value="<%= request.getParameter(\"vendor___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.InterfaceTypeForm.submit()"/>
  </html:form>

  </body>
</html>
  
