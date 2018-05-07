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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(DLCIRangeConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(DLCIRangeConstants.DATASOURCE);
String tabName = request.getParameter(DLCIRangeConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

DLCIRangeForm form = (DLCIRangeForm) request.getAttribute("DLCIRangeForm");


String DLCIRangeID___hide = null;
String Usage___hide = null;
String Allocation___hide = null;
String StartValue___hide = null;
String EndValue___hide = null;
String Description___hide = null;
String Region___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListDLCIRange.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  DLCIRangeID___hide = form.getDlcirangeid___hide();
  Usage___hide = form.getUsage___hide();
  Allocation___hide = form.getAllocation___hide();
  StartValue___hide = form.getStartvalue___hide();
  EndValue___hide = form.getEndvalue___hide();
  Description___hide = form.getDescription___hide();
  Region___hide = form.getRegion___hide();

  if ( DLCIRangeID___hide != null )
    requestURI.append("dlcirangeid___hide=" + DLCIRangeID___hide);
  if ( Usage___hide != null )
    requestURI.append("usage___hide=" + Usage___hide);
  if ( Allocation___hide != null )
    requestURI.append("allocation___hide=" + Allocation___hide);
  if ( StartValue___hide != null )
    requestURI.append("startvalue___hide=" + StartValue___hide);
  if ( EndValue___hide != null )
    requestURI.append("endvalue___hide=" + EndValue___hide);
  if ( Description___hide != null )
    requestURI.append("description___hide=" + Description___hide);
  if ( Region___hide != null )
    requestURI.append("region___hide=" + Region___hide);

} else {

    DLCIRangeID___hide = request.getParameter("dlcirangeid___hide");
    Usage___hide = request.getParameter("usage___hide");
    Allocation___hide = request.getParameter("allocation___hide");
    StartValue___hide = request.getParameter("startvalue___hide");
    EndValue___hide = request.getParameter("endvalue___hide");
    Description___hide = request.getParameter("description___hide");
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

  //alert(rowId);
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
      //openBranch(row_pk);
  }  
}  
</script>

<html>
  <head>
    <title><bean:message bundle="DLCIRangeApplicationResources" key="<%= DLCIRangeConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="DLCIRangeApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitDLCIRangeAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( Usage___hide == null || Usage___hide.equals("null") ) {
%>
      <display:column property="usage" sortable="true" titleKey="DLCIRangeApplicationResources:field.usage.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Allocation___hide == null || Allocation___hide.equals("null") ) {
%>
      <display:column property="allocation" sortable="true" titleKey="DLCIRangeApplicationResources:field.allocation.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( StartValue___hide == null || StartValue___hide.equals("null") ) {
%>
      <display:column property="startvalue" sortable="true" titleKey="DLCIRangeApplicationResources:field.startvalue.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( EndValue___hide == null || EndValue___hide.equals("null") ) {
%>
      <display:column property="endvalue" sortable="true" titleKey="DLCIRangeApplicationResources:field.endvalue.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Description___hide == null || Description___hide.equals("null") ) {
%>
      <display:column property="description" sortable="true" titleKey="DLCIRangeApplicationResources:field.description.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormDLCIRangeAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="dlcirangeid" value="<%= form.getDlcirangeid() %>"/>
                <html:hidden property="dlcirangeid___hide" value="<%= form.getDlcirangeid___hide() %>"/>
                        <html:hidden property="usage" value="<%= form.getUsage() %>"/>
                <html:hidden property="usage___hide" value="<%= form.getUsage___hide() %>"/>
                        <html:hidden property="allocation" value="<%= form.getAllocation() %>"/>
                <html:hidden property="allocation___hide" value="<%= form.getAllocation___hide() %>"/>
                        <html:hidden property="startvalue" value="<%= form.getStartvalue() %>"/>
                  <html:hidden property="startvalue___" value="<%= form.getStartvalue___() %>"/>
                <html:hidden property="startvalue___hide" value="<%= form.getStartvalue___hide() %>"/>
                        <html:hidden property="endvalue" value="<%= form.getEndvalue() %>"/>
                  <html:hidden property="endvalue___" value="<%= form.getEndvalue___() %>"/>
                <html:hidden property="endvalue___hide" value="<%= form.getEndvalue___hide() %>"/>
                        <html:hidden property="description" value="<%= form.getDescription() %>"/>
                <html:hidden property="description___hide" value="<%= form.getDescription___hide() %>"/>
                        <html:hidden property="region" value="<%= form.getRegion() %>"/>
                <html:hidden property="region___hide" value="<%= form.getRegion___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="dlcirangeid" value="<%= request.getParameter(\"dlcirangeid\") %>"/>
                <html:hidden property="dlcirangeid___hide" value="<%= request.getParameter(\"dlcirangeid___hide\") %>"/>
                        <html:hidden property="usage" value="<%= request.getParameter(\"usage\") %>"/>
                <html:hidden property="usage___hide" value="<%= request.getParameter(\"usage___hide\") %>"/>
                        <html:hidden property="allocation" value="<%= request.getParameter(\"allocation\") %>"/>
                <html:hidden property="allocation___hide" value="<%= request.getParameter(\"allocation___hide\") %>"/>
                        <html:hidden property="startvalue" value="<%= request.getParameter(\"startvalue\") %>"/>
                  <html:hidden property="startvalue___" value="<%= request.getParameter(\"startvalue___\") %>"/>
                <html:hidden property="startvalue___hide" value="<%= request.getParameter(\"startvalue___hide\") %>"/>
                        <html:hidden property="endvalue" value="<%= request.getParameter(\"endvalue\") %>"/>
                  <html:hidden property="endvalue___" value="<%= request.getParameter(\"endvalue___\") %>"/>
                <html:hidden property="endvalue___hide" value="<%= request.getParameter(\"endvalue___hide\") %>"/>
                        <html:hidden property="description" value="<%= request.getParameter(\"description\") %>"/>
                <html:hidden property="description___hide" value="<%= request.getParameter(\"description___hide\") %>"/>
                        <html:hidden property="region" value="<%= request.getParameter(\"region\") %>"/>
                <html:hidden property="region___hide" value="<%= request.getParameter(\"region___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.DLCIRangeForm.submit()"/>
  </html:form>

  </body>
</html>
  
