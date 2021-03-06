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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(L3VPNMembershipConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(L3VPNMembershipConstants.DATASOURCE);
String tabName = request.getParameter(L3VPNMembershipConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

L3VPNMembershipForm form = (L3VPNMembershipForm) request.getAttribute("L3VPNMembershipForm");


String CustomerName___hide = null;
String SiteName___hide = null;
String VPNName___hide = null;
String JoinDate___hide = null;
String VPNId___hide = null;
String SiteId___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListL3VPNMembership.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  CustomerName___hide = form.getCustomername___hide();
  SiteName___hide = form.getSitename___hide();
  VPNName___hide = form.getVpnname___hide();
  JoinDate___hide = form.getJoindate___hide();
  VPNId___hide = form.getVpnid___hide();
  SiteId___hide = form.getSiteid___hide();

  if ( CustomerName___hide != null )
    requestURI.append("customername___hide=" + CustomerName___hide);
  if ( SiteName___hide != null )
    requestURI.append("sitename___hide=" + SiteName___hide);
  if ( VPNName___hide != null )
    requestURI.append("vpnname___hide=" + VPNName___hide);
  if ( JoinDate___hide != null )
    requestURI.append("joindate___hide=" + JoinDate___hide);
  if ( VPNId___hide != null )
    requestURI.append("vpnid___hide=" + VPNId___hide);
  if ( SiteId___hide != null )
    requestURI.append("siteid___hide=" + SiteId___hide);

} else {

    CustomerName___hide = request.getParameter("customername___hide");
    SiteName___hide = request.getParameter("sitename___hide");
    VPNName___hide = request.getParameter("vpnname___hide");
    JoinDate___hide = request.getParameter("joindate___hide");
    VPNId___hide = request.getParameter("vpnid___hide");
    SiteId___hide = request.getParameter("siteid___hide");

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
    <title><bean:message bundle="L3VPNMembershipApplicationResources" key="<%= L3VPNMembershipConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="L3VPNMembershipApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitL3VPNMembershipAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( CustomerName___hide == null || CustomerName___hide.equals("null") ) {
%>
      <display:column property="customername" sortable="true" titleKey="L3VPNMembershipApplicationResources:field.customername.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SiteName___hide == null || SiteName___hide.equals("null") ) {
%>
      <display:column property="sitename" sortable="true" titleKey="L3VPNMembershipApplicationResources:field.sitename.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VPNName___hide == null || VPNName___hide.equals("null") ) {
%>
      <display:column property="vpnname" sortable="true" titleKey="L3VPNMembershipApplicationResources:field.vpnname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( JoinDate___hide == null || JoinDate___hide.equals("null") ) {
%>
      <display:column property="joindate" sortable="true" titleKey="L3VPNMembershipApplicationResources:field.joindate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VPNId___hide == null || VPNId___hide.equals("null") ) {
%>
      <display:column property="vpnid" sortable="true" titleKey="L3VPNMembershipApplicationResources:field.vpnid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SiteId___hide == null || SiteId___hide.equals("null") ) {
%>
      <display:column property="siteid" sortable="true" titleKey="L3VPNMembershipApplicationResources:field.siteid.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormL3VPNMembershipAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="customername" value="<%= form.getCustomername() %>"/>
                <html:hidden property="customername___hide" value="<%= form.getCustomername___hide() %>"/>
                        <html:hidden property="sitename" value="<%= form.getSitename() %>"/>
                <html:hidden property="sitename___hide" value="<%= form.getSitename___hide() %>"/>
                        <html:hidden property="vpnname" value="<%= form.getVpnname() %>"/>
                <html:hidden property="vpnname___hide" value="<%= form.getVpnname___hide() %>"/>
                        <html:hidden property="joindate" value="<%= form.getJoindate() %>"/>
                <html:hidden property="joindate___hide" value="<%= form.getJoindate___hide() %>"/>
                                  <html:hidden property="vpnid" value="<%= form.getVpnid() %>"/>
                <html:hidden property="vpnid___hide" value="<%= form.getVpnid___hide() %>"/>
                                            <html:hidden property="siteid" value="<%= form.getSiteid() %>"/>
                <html:hidden property="siteid___hide" value="<%= form.getSiteid___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="customername" value="<%= request.getParameter(\"customername\") %>"/>
                <html:hidden property="customername___hide" value="<%= request.getParameter(\"customername___hide\") %>"/>
                        <html:hidden property="sitename" value="<%= request.getParameter(\"sitename\") %>"/>
                <html:hidden property="sitename___hide" value="<%= request.getParameter(\"sitename___hide\") %>"/>
                        <html:hidden property="vpnname" value="<%= request.getParameter(\"vpnname\") %>"/>
                <html:hidden property="vpnname___hide" value="<%= request.getParameter(\"vpnname___hide\") %>"/>
                        <html:hidden property="joindate" value="<%= request.getParameter(\"joindate\") %>"/>
                <html:hidden property="joindate___hide" value="<%= request.getParameter(\"joindate___hide\") %>"/>
                                  <html:hidden property="vpnid" value="<%= request.getParameter(\"vpnid\") %>"/>
                <html:hidden property="vpnid___hide" value="<%= request.getParameter(\"vpnid___hide\") %>"/>
                                            <html:hidden property="siteid" value="<%= request.getParameter(\"siteid\") %>"/>
                <html:hidden property="siteid___hide" value="<%= request.getParameter(\"siteid___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.L3VPNMembershipForm.submit()"/>
  </html:form>

  </body>
</html>
  
