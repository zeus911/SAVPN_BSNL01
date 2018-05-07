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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(MemoryTypesConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(MemoryTypesConstants.DATASOURCE);
String tabName = request.getParameter(MemoryTypesConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

MemoryTypesForm form = (MemoryTypesForm) request.getAttribute("MemoryTypesForm");


String MemoryType___hide = null;
String TargetType___hide = null;
String OS___hide = null;
String Type___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListMemoryTypes.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  MemoryType___hide = form.getMemorytype___hide();
  TargetType___hide = form.getTargettype___hide();
  OS___hide = form.getOs___hide();
  Type___hide = form.getType___hide();

  if ( MemoryType___hide != null )
    requestURI.append("memorytype___hide=" + MemoryType___hide);
  if ( TargetType___hide != null )
    requestURI.append("targettype___hide=" + TargetType___hide);
  if ( OS___hide != null )
    requestURI.append("os___hide=" + OS___hide);
  if ( Type___hide != null )
    requestURI.append("type___hide=" + Type___hide);

} else {

    MemoryType___hide = request.getParameter("memorytype___hide");
    TargetType___hide = request.getParameter("targettype___hide");
    OS___hide = request.getParameter("os___hide");
    Type___hide = request.getParameter("type___hide");

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
    <title><bean:message bundle="MemoryTypesApplicationResources" key="<%= MemoryTypesConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="MemoryTypesApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitMemoryTypesAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( MemoryType___hide == null || MemoryType___hide.equals("null") ) {
%>
      <display:column property="memorytype" sortable="true" titleKey="MemoryTypesApplicationResources:field.memorytype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( TargetType___hide == null || TargetType___hide.equals("null") ) {
%>
      <display:column property="targettype" sortable="true" titleKey="MemoryTypesApplicationResources:field.targettype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( OS___hide == null || OS___hide.equals("null") ) {
%>
      <display:column property="os" sortable="true" titleKey="MemoryTypesApplicationResources:field.os.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Type___hide == null || Type___hide.equals("null") ) {
%>
      <display:column property="type" sortable="true" titleKey="MemoryTypesApplicationResources:field.type.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormMemoryTypesAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="memorytype" value="<%= form.getMemorytype() %>"/>
                <html:hidden property="memorytype___hide" value="<%= form.getMemorytype___hide() %>"/>
                        <html:hidden property="targettype" value="<%= form.getTargettype() %>"/>
                <html:hidden property="targettype___hide" value="<%= form.getTargettype___hide() %>"/>
                        <html:hidden property="os" value="<%= form.getOs() %>"/>
                <html:hidden property="os___hide" value="<%= form.getOs___hide() %>"/>
                        <html:hidden property="type" value="<%= form.getType() %>"/>
                <html:hidden property="type___hide" value="<%= form.getType___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="memorytype" value="<%= request.getParameter(\"memorytype\") %>"/>
                <html:hidden property="memorytype___hide" value="<%= request.getParameter(\"memorytype___hide\") %>"/>
                        <html:hidden property="targettype" value="<%= request.getParameter(\"targettype\") %>"/>
                <html:hidden property="targettype___hide" value="<%= request.getParameter(\"targettype___hide\") %>"/>
                        <html:hidden property="os" value="<%= request.getParameter(\"os\") %>"/>
                <html:hidden property="os___hide" value="<%= request.getParameter(\"os___hide\") %>"/>
                        <html:hidden property="type" value="<%= request.getParameter(\"type\") %>"/>
                <html:hidden property="type___hide" value="<%= request.getParameter(\"type___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.MemoryTypesForm.submit()"/>
  </html:form>

  </body>
</html>
  
