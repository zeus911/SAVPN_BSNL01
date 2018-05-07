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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(MulticastProfileConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(MulticastProfileConstants.DATASOURCE);
String tabName = request.getParameter(MulticastProfileConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

MulticastProfileForm form = (MulticastProfileForm) request.getAttribute("MulticastProfileForm");


String MCastProfileId___hide = null;
String VPNId___hide = null;
String MulticastSource___hide = null;
String MulticastGroup___hide = null;
String Bandwidth___hide = null;
String CoS___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListMulticastProfile.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  MCastProfileId___hide = form.getMcastprofileid___hide();
  VPNId___hide = form.getVpnid___hide();
  MulticastSource___hide = form.getMulticastsource___hide();
  MulticastGroup___hide = form.getMulticastgroup___hide();
  Bandwidth___hide = form.getBandwidth___hide();
  CoS___hide = form.getCos___hide();

  if ( MCastProfileId___hide != null )
    requestURI.append("mcastprofileid___hide=" + MCastProfileId___hide);
  if ( VPNId___hide != null )
    requestURI.append("vpnid___hide=" + VPNId___hide);
  if ( MulticastSource___hide != null )
    requestURI.append("multicastsource___hide=" + MulticastSource___hide);
  if ( MulticastGroup___hide != null )
    requestURI.append("multicastgroup___hide=" + MulticastGroup___hide);
  if ( Bandwidth___hide != null )
    requestURI.append("bandwidth___hide=" + Bandwidth___hide);
  if ( CoS___hide != null )
    requestURI.append("cos___hide=" + CoS___hide);

} else {

    MCastProfileId___hide = request.getParameter("mcastprofileid___hide");
    VPNId___hide = request.getParameter("vpnid___hide");
    MulticastSource___hide = request.getParameter("multicastsource___hide");
    MulticastGroup___hide = request.getParameter("multicastgroup___hide");
    Bandwidth___hide = request.getParameter("bandwidth___hide");
    CoS___hide = request.getParameter("cos___hide");

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
    <title><bean:message bundle="MulticastProfileApplicationResources" key="<%= MulticastProfileConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="MulticastProfileApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitMulticastProfileAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( MCastProfileId___hide == null || MCastProfileId___hide.equals("null") ) {
%>
      <display:column property="mcastprofileid" sortable="true" titleKey="MulticastProfileApplicationResources:field.mcastprofileid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VPNId___hide == null || VPNId___hide.equals("null") ) {
%>
      <display:column property="vpnid" sortable="true" titleKey="MulticastProfileApplicationResources:field.vpnid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( MulticastSource___hide == null || MulticastSource___hide.equals("null") ) {
%>
      <display:column property="multicastsource" sortable="true" titleKey="MulticastProfileApplicationResources:field.multicastsource.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( MulticastGroup___hide == null || MulticastGroup___hide.equals("null") ) {
%>
      <display:column property="multicastgroup" sortable="true" titleKey="MulticastProfileApplicationResources:field.multicastgroup.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Bandwidth___hide == null || Bandwidth___hide.equals("null") ) {
%>
      <display:column property="bandwidth" sortable="true" titleKey="MulticastProfileApplicationResources:field.bandwidth.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CoS___hide == null || CoS___hide.equals("null") ) {
%>
      <display:column property="cos" sortable="true" titleKey="MulticastProfileApplicationResources:field.cos.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormMulticastProfileAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="mcastprofileid" value="<%= form.getMcastprofileid() %>"/>
                <html:hidden property="mcastprofileid___hide" value="<%= form.getMcastprofileid___hide() %>"/>
                        <html:hidden property="vpnid" value="<%= form.getVpnid() %>"/>
                <html:hidden property="vpnid___hide" value="<%= form.getVpnid___hide() %>"/>
                        <html:hidden property="multicastsource" value="<%= form.getMulticastsource() %>"/>
                <html:hidden property="multicastsource___hide" value="<%= form.getMulticastsource___hide() %>"/>
                        <html:hidden property="multicastgroup" value="<%= form.getMulticastgroup() %>"/>
                <html:hidden property="multicastgroup___hide" value="<%= form.getMulticastgroup___hide() %>"/>
                        <html:hidden property="bandwidth" value="<%= form.getBandwidth() %>"/>
                <html:hidden property="bandwidth___hide" value="<%= form.getBandwidth___hide() %>"/>
                        <html:hidden property="cos" value="<%= form.getCos() %>"/>
                <html:hidden property="cos___hide" value="<%= form.getCos___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="mcastprofileid" value="<%= request.getParameter(\"mcastprofileid\") %>"/>
                <html:hidden property="mcastprofileid___hide" value="<%= request.getParameter(\"mcastprofileid___hide\") %>"/>
                        <html:hidden property="vpnid" value="<%= request.getParameter(\"vpnid\") %>"/>
                <html:hidden property="vpnid___hide" value="<%= request.getParameter(\"vpnid___hide\") %>"/>
                        <html:hidden property="multicastsource" value="<%= request.getParameter(\"multicastsource\") %>"/>
                <html:hidden property="multicastsource___hide" value="<%= request.getParameter(\"multicastsource___hide\") %>"/>
                        <html:hidden property="multicastgroup" value="<%= request.getParameter(\"multicastgroup\") %>"/>
                <html:hidden property="multicastgroup___hide" value="<%= request.getParameter(\"multicastgroup___hide\") %>"/>
                        <html:hidden property="bandwidth" value="<%= request.getParameter(\"bandwidth\") %>"/>
                <html:hidden property="bandwidth___hide" value="<%= request.getParameter(\"bandwidth___hide\") %>"/>
                        <html:hidden property="cos" value="<%= request.getParameter(\"cos\") %>"/>
                <html:hidden property="cos___hide" value="<%= request.getParameter(\"cos___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.MulticastProfileForm.submit()"/>
  </html:form>

  </body>
</html>
  
