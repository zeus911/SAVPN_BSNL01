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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(LSPProfileConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(LSPProfileConstants.DATASOURCE);
String tabName = request.getParameter(LSPProfileConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

LSPProfileForm form = (LSPProfileForm) request.getAttribute("LSPProfileForm");


String LSPProfileName___hide = null;
String Type___hide = null;
String CT___hide = null;
String bwAllocation___hide = null;
String bwAlgorithm___hide = null;
String CoS___hide = null;
String LSPFilter___hide = null;
String LSPProfileVersion___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListLSPProfile.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  LSPProfileName___hide = form.getLspprofilename___hide();
  Type___hide = form.getType___hide();
  CT___hide = form.getCt___hide();
  bwAllocation___hide = form.getBwallocation___hide();
  bwAlgorithm___hide = form.getBwalgorithm___hide();
  CoS___hide = form.getCos___hide();
  LSPFilter___hide = form.getLspfilter___hide();
  LSPProfileVersion___hide = form.getLspprofileversion___hide();

  if ( LSPProfileName___hide != null )
    requestURI.append("lspprofilename___hide=" + LSPProfileName___hide);
  if ( Type___hide != null )
    requestURI.append("type___hide=" + Type___hide);
  if ( CT___hide != null )
    requestURI.append("ct___hide=" + CT___hide);
  if ( bwAllocation___hide != null )
    requestURI.append("bwallocation___hide=" + bwAllocation___hide);
  if ( bwAlgorithm___hide != null )
    requestURI.append("bwalgorithm___hide=" + bwAlgorithm___hide);
  if ( CoS___hide != null )
    requestURI.append("cos___hide=" + CoS___hide);
  if ( LSPFilter___hide != null )
    requestURI.append("lspfilter___hide=" + LSPFilter___hide);
  if ( LSPProfileVersion___hide != null )
    requestURI.append("lspprofileversion___hide=" + LSPProfileVersion___hide);

} else {

    LSPProfileName___hide = request.getParameter("lspprofilename___hide");
    Type___hide = request.getParameter("type___hide");
    CT___hide = request.getParameter("ct___hide");
    bwAllocation___hide = request.getParameter("bwallocation___hide");
    bwAlgorithm___hide = request.getParameter("bwalgorithm___hide");
    CoS___hide = request.getParameter("cos___hide");
    LSPFilter___hide = request.getParameter("lspfilter___hide");
    LSPProfileVersion___hide = request.getParameter("lspprofileversion___hide");

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
    <title><bean:message bundle="LSPProfileApplicationResources" key="<%= LSPProfileConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="LSPProfileApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitLSPProfileAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( LSPProfileName___hide == null || LSPProfileName___hide.equals("null") ) {
%>
      <display:column property="lspprofilename" sortable="true" titleKey="LSPProfileApplicationResources:field.lspprofilename.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Type___hide == null || Type___hide.equals("null") ) {
%>
      <display:column property="type" sortable="true" titleKey="LSPProfileApplicationResources:field.type.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CT___hide == null || CT___hide.equals("null") ) {
%>
      <display:column property="ct" sortable="true" titleKey="LSPProfileApplicationResources:field.ct.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( bwAllocation___hide == null || bwAllocation___hide.equals("null") ) {
%>
      <display:column property="bwallocation" sortable="true" titleKey="LSPProfileApplicationResources:field.bwallocation.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( bwAlgorithm___hide == null || bwAlgorithm___hide.equals("null") ) {
%>
      <display:column property="bwalgorithm" sortable="true" titleKey="LSPProfileApplicationResources:field.bwalgorithm.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CoS___hide == null || CoS___hide.equals("null") ) {
%>
      <display:column property="cos" sortable="true" titleKey="LSPProfileApplicationResources:field.cos.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( LSPFilter___hide == null || LSPFilter___hide.equals("null") ) {
%>
      <display:column property="lspfilter" sortable="true" titleKey="LSPProfileApplicationResources:field.lspfilter.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( LSPProfileVersion___hide == null || LSPProfileVersion___hide.equals("null") ) {
%>
      <display:column property="lspprofileversion" sortable="true" titleKey="LSPProfileApplicationResources:field.lspprofileversion.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormLSPProfileAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="lspprofilename" value="<%= form.getLspprofilename() %>"/>
                <html:hidden property="lspprofilename___hide" value="<%= form.getLspprofilename___hide() %>"/>
                        <html:hidden property="type" value="<%= form.getType() %>"/>
                <html:hidden property="type___hide" value="<%= form.getType___hide() %>"/>
                        <html:hidden property="ct" value="<%= form.getCt() %>"/>
                <html:hidden property="ct___hide" value="<%= form.getCt___hide() %>"/>
                        <html:hidden property="bwallocation" value="<%= form.getBwallocation() %>"/>
                <html:hidden property="bwallocation___hide" value="<%= form.getBwallocation___hide() %>"/>
                        <html:hidden property="bwalgorithm" value="<%= form.getBwalgorithm() %>"/>
                <html:hidden property="bwalgorithm___hide" value="<%= form.getBwalgorithm___hide() %>"/>
                        <html:hidden property="cos" value="<%= form.getCos() %>"/>
                <html:hidden property="cos___hide" value="<%= form.getCos___hide() %>"/>
                        <html:hidden property="lspfilter" value="<%= form.getLspfilter() %>"/>
                <html:hidden property="lspfilter___hide" value="<%= form.getLspfilter___hide() %>"/>
                        <html:hidden property="lspprofileversion" value="<%= form.getLspprofileversion() %>"/>
                <html:hidden property="lspprofileversion___hide" value="<%= form.getLspprofileversion___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="lspprofilename" value="<%= request.getParameter(\"lspprofilename\") %>"/>
                <html:hidden property="lspprofilename___hide" value="<%= request.getParameter(\"lspprofilename___hide\") %>"/>
                        <html:hidden property="type" value="<%= request.getParameter(\"type\") %>"/>
                <html:hidden property="type___hide" value="<%= request.getParameter(\"type___hide\") %>"/>
                        <html:hidden property="ct" value="<%= request.getParameter(\"ct\") %>"/>
                <html:hidden property="ct___hide" value="<%= request.getParameter(\"ct___hide\") %>"/>
                        <html:hidden property="bwallocation" value="<%= request.getParameter(\"bwallocation\") %>"/>
                <html:hidden property="bwallocation___hide" value="<%= request.getParameter(\"bwallocation___hide\") %>"/>
                        <html:hidden property="bwalgorithm" value="<%= request.getParameter(\"bwalgorithm\") %>"/>
                <html:hidden property="bwalgorithm___hide" value="<%= request.getParameter(\"bwalgorithm___hide\") %>"/>
                        <html:hidden property="cos" value="<%= request.getParameter(\"cos\") %>"/>
                <html:hidden property="cos___hide" value="<%= request.getParameter(\"cos___hide\") %>"/>
                        <html:hidden property="lspfilter" value="<%= request.getParameter(\"lspfilter\") %>"/>
                <html:hidden property="lspfilter___hide" value="<%= request.getParameter(\"lspfilter___hide\") %>"/>
                        <html:hidden property="lspprofileversion" value="<%= request.getParameter(\"lspprofileversion\") %>"/>
                <html:hidden property="lspprofileversion___hide" value="<%= request.getParameter(\"lspprofileversion___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.LSPProfileForm.submit()"/>
  </html:form>

  </body>
</html>
  
