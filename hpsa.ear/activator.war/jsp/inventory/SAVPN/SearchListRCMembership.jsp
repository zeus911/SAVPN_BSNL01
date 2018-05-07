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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(RCMembershipConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(RCMembershipConstants.DATASOURCE);
String tabName = request.getParameter(RCMembershipConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

RCMembershipForm form = (RCMembershipForm) request.getAttribute("RCMembershipForm");


String RCName___hide = null;
String NE_ID___hide = null;
String VRFName___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListRCMembership.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  RCName___hide = form.getRcname___hide();
  NE_ID___hide = form.getNe_id___hide();
  VRFName___hide = form.getVrfname___hide();

  if ( RCName___hide != null )
    requestURI.append("rcname___hide=" + RCName___hide);
  if ( NE_ID___hide != null )
    requestURI.append("ne_id___hide=" + NE_ID___hide);
  if ( VRFName___hide != null )
    requestURI.append("vrfname___hide=" + VRFName___hide);

} else {

    RCName___hide = request.getParameter("rcname___hide");
    NE_ID___hide = request.getParameter("ne_id___hide");
    VRFName___hide = request.getParameter("vrfname___hide");

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
    <title><bean:message bundle="RCMembershipApplicationResources" key="<%= RCMembershipConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="RCMembershipApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitRCMembershipAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( RCName___hide == null || RCName___hide.equals("null") ) {
%>
      <display:column property="rcname" sortable="true" titleKey="RCMembershipApplicationResources:field.rcname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NE_ID___hide == null || NE_ID___hide.equals("null") ) {
%>
      <display:column property="ne_id" sortable="true" titleKey="RCMembershipApplicationResources:field.ne_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VRFName___hide == null || VRFName___hide.equals("null") ) {
%>
      <display:column property="vrfname" sortable="true" titleKey="RCMembershipApplicationResources:field.vrfname.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormRCMembershipAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="rcname" value="<%= form.getRcname() %>"/>
                <html:hidden property="rcname___hide" value="<%= form.getRcname___hide() %>"/>
                        <html:hidden property="ne_id" value="<%= form.getNe_id() %>"/>
                <html:hidden property="ne_id___hide" value="<%= form.getNe_id___hide() %>"/>
                        <html:hidden property="vrfname" value="<%= form.getVrfname() %>"/>
                <html:hidden property="vrfname___hide" value="<%= form.getVrfname___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="rcname" value="<%= request.getParameter(\"rcname\") %>"/>
                <html:hidden property="rcname___hide" value="<%= request.getParameter(\"rcname___hide\") %>"/>
                        <html:hidden property="ne_id" value="<%= request.getParameter(\"ne_id\") %>"/>
                <html:hidden property="ne_id___hide" value="<%= request.getParameter(\"ne_id___hide\") %>"/>
                        <html:hidden property="vrfname" value="<%= request.getParameter(\"vrfname\") %>"/>
                <html:hidden property="vrfname___hide" value="<%= request.getParameter(\"vrfname___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.RCMembershipForm.submit()"/>
  </html:form>

  </body>
</html>
  
