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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(ActivePoliciesConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(ActivePoliciesConstants.DATASOURCE);
String tabName = request.getParameter(ActivePoliciesConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

ActivePoliciesForm form = (ActivePoliciesForm) request.getAttribute("ActivePoliciesForm");


String ID___hide = null;
String SchedulingPolicyName___hide = null;
String RetrievalPolicyName___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListActivePolicies.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  ID___hide = form.getId___hide();
  SchedulingPolicyName___hide = form.getSchedulingpolicyname___hide();
  RetrievalPolicyName___hide = form.getRetrievalpolicyname___hide();

  if ( ID___hide != null )
    requestURI.append("id___hide=" + ID___hide);
  if ( SchedulingPolicyName___hide != null )
    requestURI.append("schedulingpolicyname___hide=" + SchedulingPolicyName___hide);
  if ( RetrievalPolicyName___hide != null )
    requestURI.append("retrievalpolicyname___hide=" + RetrievalPolicyName___hide);

} else {

    ID___hide = request.getParameter("id___hide");
    SchedulingPolicyName___hide = request.getParameter("schedulingpolicyname___hide");
    RetrievalPolicyName___hide = request.getParameter("retrievalpolicyname___hide");

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
    <title><bean:message bundle="ActivePoliciesApplicationResources" key="<%= ActivePoliciesConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="ActivePoliciesApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitActivePoliciesAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( ID___hide == null || ID___hide.equals("null") ) {
%>
      <display:column property="id" sortable="true" titleKey="ActivePoliciesApplicationResources:field.id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SchedulingPolicyName___hide == null || SchedulingPolicyName___hide.equals("null") ) {
%>
      <display:column property="schedulingpolicyname" sortable="true" titleKey="ActivePoliciesApplicationResources:field.schedulingpolicyname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RetrievalPolicyName___hide == null || RetrievalPolicyName___hide.equals("null") ) {
%>
      <display:column property="retrievalpolicyname" sortable="true" titleKey="ActivePoliciesApplicationResources:field.retrievalpolicyname.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormActivePoliciesAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="id" value="<%= form.getId() %>"/>
                <html:hidden property="id___hide" value="<%= form.getId___hide() %>"/>
                        <html:hidden property="schedulingpolicyname" value="<%= form.getSchedulingpolicyname() %>"/>
                <html:hidden property="schedulingpolicyname___hide" value="<%= form.getSchedulingpolicyname___hide() %>"/>
                        <html:hidden property="retrievalpolicyname" value="<%= form.getRetrievalpolicyname() %>"/>
                <html:hidden property="retrievalpolicyname___hide" value="<%= form.getRetrievalpolicyname___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="id" value="<%= request.getParameter(\"id\") %>"/>
                <html:hidden property="id___hide" value="<%= request.getParameter(\"id___hide\") %>"/>
                        <html:hidden property="schedulingpolicyname" value="<%= request.getParameter(\"schedulingpolicyname\") %>"/>
                <html:hidden property="schedulingpolicyname___hide" value="<%= request.getParameter(\"schedulingpolicyname___hide\") %>"/>
                        <html:hidden property="retrievalpolicyname" value="<%= request.getParameter(\"retrievalpolicyname\") %>"/>
                <html:hidden property="retrievalpolicyname___hide" value="<%= request.getParameter(\"retrievalpolicyname___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.ActivePoliciesForm.submit()"/>
  </html:form>

  </body>
</html>
  
