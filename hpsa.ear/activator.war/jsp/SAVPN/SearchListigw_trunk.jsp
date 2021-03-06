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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(igw_trunkConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(igw_trunkConstants.DATASOURCE);
String tabName = request.getParameter(igw_trunkConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

igw_trunkForm form = (igw_trunkForm) request.getAttribute("igw_trunkForm");


String TRUNK_ID___hide = null;
String TRUNKTYPE_ID___hide = null;
String NAME___hide = null;
String LINK_TYPE___hide = null;
String STATUS___hide = null;
String SUBMIT_DATA___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListigw_trunk.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  TRUNK_ID___hide = form.getTrunk_id___hide();
  TRUNKTYPE_ID___hide = form.getTrunktype_id___hide();
  NAME___hide = form.getName___hide();
  LINK_TYPE___hide = form.getLink_type___hide();
  STATUS___hide = form.getStatus___hide();
  SUBMIT_DATA___hide = form.getSubmit_data___hide();

  if ( TRUNK_ID___hide != null )
    requestURI.append("trunk_id___hide=" + TRUNK_ID___hide);
  if ( TRUNKTYPE_ID___hide != null )
    requestURI.append("trunktype_id___hide=" + TRUNKTYPE_ID___hide);
  if ( NAME___hide != null )
    requestURI.append("name___hide=" + NAME___hide);
  if ( LINK_TYPE___hide != null )
    requestURI.append("link_type___hide=" + LINK_TYPE___hide);
  if ( STATUS___hide != null )
    requestURI.append("status___hide=" + STATUS___hide);
  if ( SUBMIT_DATA___hide != null )
    requestURI.append("submit_data___hide=" + SUBMIT_DATA___hide);

} else {

    TRUNK_ID___hide = request.getParameter("trunk_id___hide");
    TRUNKTYPE_ID___hide = request.getParameter("trunktype_id___hide");
    NAME___hide = request.getParameter("name___hide");
    LINK_TYPE___hide = request.getParameter("link_type___hide");
    STATUS___hide = request.getParameter("status___hide");
    SUBMIT_DATA___hide = request.getParameter("submit_data___hide");

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
    <title><bean:message bundle="igw_trunkApplicationResources" key="<%= igw_trunkConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="igw_trunkApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitigw_trunkAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( TRUNK_ID___hide == null || TRUNK_ID___hide.equals("null") ) {
%>
      <display:column property="trunk_id" sortable="true" titleKey="igw_trunkApplicationResources:field.trunk_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( TRUNKTYPE_ID___hide == null || TRUNKTYPE_ID___hide.equals("null") ) {
%>
      <display:column property="trunktype_id" sortable="true" titleKey="igw_trunkApplicationResources:field.trunktype_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NAME___hide == null || NAME___hide.equals("null") ) {
%>
      <display:column property="name" sortable="true" titleKey="igw_trunkApplicationResources:field.name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( LINK_TYPE___hide == null || LINK_TYPE___hide.equals("null") ) {
%>
      <display:column property="link_type" sortable="true" titleKey="igw_trunkApplicationResources:field.link_type.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( STATUS___hide == null || STATUS___hide.equals("null") ) {
%>
      <display:column property="status" sortable="true" titleKey="igw_trunkApplicationResources:field.status.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SUBMIT_DATA___hide == null || SUBMIT_DATA___hide.equals("null") ) {
%>
      <display:column property="submit_data" sortable="true" titleKey="igw_trunkApplicationResources:field.submit_data.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormigw_trunkAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="trunk_id" value="<%= form.getTrunk_id() %>"/>
                <html:hidden property="trunk_id___hide" value="<%= form.getTrunk_id___hide() %>"/>
                        <html:hidden property="trunktype_id" value="<%= form.getTrunktype_id() %>"/>
                <html:hidden property="trunktype_id___hide" value="<%= form.getTrunktype_id___hide() %>"/>
                        <html:hidden property="name" value="<%= form.getName() %>"/>
                <html:hidden property="name___hide" value="<%= form.getName___hide() %>"/>
                        <html:hidden property="link_type" value="<%= form.getLink_type() %>"/>
                <html:hidden property="link_type___hide" value="<%= form.getLink_type___hide() %>"/>
                        <html:hidden property="status" value="<%= form.getStatus() %>"/>
                <html:hidden property="status___hide" value="<%= form.getStatus___hide() %>"/>
                        <html:hidden property="submit_data" value="<%= form.getSubmit_data() %>"/>
                <html:hidden property="submit_data___hide" value="<%= form.getSubmit_data___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="trunk_id" value="<%= request.getParameter(\"trunk_id\") %>"/>
                <html:hidden property="trunk_id___hide" value="<%= request.getParameter(\"trunk_id___hide\") %>"/>
                        <html:hidden property="trunktype_id" value="<%= request.getParameter(\"trunktype_id\") %>"/>
                <html:hidden property="trunktype_id___hide" value="<%= request.getParameter(\"trunktype_id___hide\") %>"/>
                        <html:hidden property="name" value="<%= request.getParameter(\"name\") %>"/>
                <html:hidden property="name___hide" value="<%= request.getParameter(\"name___hide\") %>"/>
                        <html:hidden property="link_type" value="<%= request.getParameter(\"link_type\") %>"/>
                <html:hidden property="link_type___hide" value="<%= request.getParameter(\"link_type___hide\") %>"/>
                        <html:hidden property="status" value="<%= request.getParameter(\"status\") %>"/>
                <html:hidden property="status___hide" value="<%= request.getParameter(\"status___hide\") %>"/>
                        <html:hidden property="submit_data" value="<%= request.getParameter(\"submit_data\") %>"/>
                <html:hidden property="submit_data___hide" value="<%= request.getParameter(\"submit_data___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.igw_trunkForm.submit()"/>
  </html:form>

  </body>
</html>
  
