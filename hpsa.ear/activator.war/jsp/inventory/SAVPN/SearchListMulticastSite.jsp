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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(MulticastSiteConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(MulticastSiteConstants.DATASOURCE);
String tabName = request.getParameter(MulticastSiteConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

MulticastSiteForm form = (MulticastSiteForm) request.getAttribute("MulticastSiteForm");


String AttachmentId___hide = null;
String MulticastLoopbackAddress___hide = null;
String VirtualTunnelId___hide = null;
String RPMode___hide = null;
String RPAddress___hide = null;
String MSDPLocalAddress___hide = null;
String MSDPPeerAddress___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListMulticastSite.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  AttachmentId___hide = form.getAttachmentid___hide();
  MulticastLoopbackAddress___hide = form.getMulticastloopbackaddress___hide();
  VirtualTunnelId___hide = form.getVirtualtunnelid___hide();
  RPMode___hide = form.getRpmode___hide();
  RPAddress___hide = form.getRpaddress___hide();
  MSDPLocalAddress___hide = form.getMsdplocaladdress___hide();
  MSDPPeerAddress___hide = form.getMsdppeeraddress___hide();

  if ( AttachmentId___hide != null )
    requestURI.append("attachmentid___hide=" + AttachmentId___hide);
  if ( MulticastLoopbackAddress___hide != null )
    requestURI.append("multicastloopbackaddress___hide=" + MulticastLoopbackAddress___hide);
  if ( VirtualTunnelId___hide != null )
    requestURI.append("virtualtunnelid___hide=" + VirtualTunnelId___hide);
  if ( RPMode___hide != null )
    requestURI.append("rpmode___hide=" + RPMode___hide);
  if ( RPAddress___hide != null )
    requestURI.append("rpaddress___hide=" + RPAddress___hide);
  if ( MSDPLocalAddress___hide != null )
    requestURI.append("msdplocaladdress___hide=" + MSDPLocalAddress___hide);
  if ( MSDPPeerAddress___hide != null )
    requestURI.append("msdppeeraddress___hide=" + MSDPPeerAddress___hide);

} else {

    AttachmentId___hide = request.getParameter("attachmentid___hide");
    MulticastLoopbackAddress___hide = request.getParameter("multicastloopbackaddress___hide");
    VirtualTunnelId___hide = request.getParameter("virtualtunnelid___hide");
    RPMode___hide = request.getParameter("rpmode___hide");
    RPAddress___hide = request.getParameter("rpaddress___hide");
    MSDPLocalAddress___hide = request.getParameter("msdplocaladdress___hide");
    MSDPPeerAddress___hide = request.getParameter("msdppeeraddress___hide");

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
    <title><bean:message bundle="MulticastSiteApplicationResources" key="<%= MulticastSiteConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="MulticastSiteApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitMulticastSiteAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( AttachmentId___hide == null || AttachmentId___hide.equals("null") ) {
%>
      <display:column property="attachmentid" sortable="true" titleKey="MulticastSiteApplicationResources:field.attachmentid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( MulticastLoopbackAddress___hide == null || MulticastLoopbackAddress___hide.equals("null") ) {
%>
      <display:column property="multicastloopbackaddress" sortable="true" titleKey="MulticastSiteApplicationResources:field.multicastloopbackaddress.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VirtualTunnelId___hide == null || VirtualTunnelId___hide.equals("null") ) {
%>
      <display:column property="virtualtunnelid" sortable="true" titleKey="MulticastSiteApplicationResources:field.virtualtunnelid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RPMode___hide == null || RPMode___hide.equals("null") ) {
%>
      <display:column property="rpmode" sortable="true" titleKey="MulticastSiteApplicationResources:field.rpmode.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RPAddress___hide == null || RPAddress___hide.equals("null") ) {
%>
      <display:column property="rpaddress" sortable="true" titleKey="MulticastSiteApplicationResources:field.rpaddress.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( MSDPLocalAddress___hide == null || MSDPLocalAddress___hide.equals("null") ) {
%>
      <display:column property="msdplocaladdress" sortable="true" titleKey="MulticastSiteApplicationResources:field.msdplocaladdress.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( MSDPPeerAddress___hide == null || MSDPPeerAddress___hide.equals("null") ) {
%>
      <display:column property="msdppeeraddress" sortable="true" titleKey="MulticastSiteApplicationResources:field.msdppeeraddress.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormMulticastSiteAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="attachmentid" value="<%= form.getAttachmentid() %>"/>
                <html:hidden property="attachmentid___hide" value="<%= form.getAttachmentid___hide() %>"/>
                        <html:hidden property="multicastloopbackaddress" value="<%= form.getMulticastloopbackaddress() %>"/>
                <html:hidden property="multicastloopbackaddress___hide" value="<%= form.getMulticastloopbackaddress___hide() %>"/>
                        <html:hidden property="virtualtunnelid" value="<%= form.getVirtualtunnelid() %>"/>
                <html:hidden property="virtualtunnelid___hide" value="<%= form.getVirtualtunnelid___hide() %>"/>
                        <html:hidden property="rpmode" value="<%= form.getRpmode() %>"/>
                <html:hidden property="rpmode___hide" value="<%= form.getRpmode___hide() %>"/>
                        <html:hidden property="rpaddress" value="<%= form.getRpaddress() %>"/>
                <html:hidden property="rpaddress___hide" value="<%= form.getRpaddress___hide() %>"/>
                        <html:hidden property="msdplocaladdress" value="<%= form.getMsdplocaladdress() %>"/>
                <html:hidden property="msdplocaladdress___hide" value="<%= form.getMsdplocaladdress___hide() %>"/>
                        <html:hidden property="msdppeeraddress" value="<%= form.getMsdppeeraddress() %>"/>
                <html:hidden property="msdppeeraddress___hide" value="<%= form.getMsdppeeraddress___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="attachmentid" value="<%= request.getParameter(\"attachmentid\") %>"/>
                <html:hidden property="attachmentid___hide" value="<%= request.getParameter(\"attachmentid___hide\") %>"/>
                        <html:hidden property="multicastloopbackaddress" value="<%= request.getParameter(\"multicastloopbackaddress\") %>"/>
                <html:hidden property="multicastloopbackaddress___hide" value="<%= request.getParameter(\"multicastloopbackaddress___hide\") %>"/>
                        <html:hidden property="virtualtunnelid" value="<%= request.getParameter(\"virtualtunnelid\") %>"/>
                <html:hidden property="virtualtunnelid___hide" value="<%= request.getParameter(\"virtualtunnelid___hide\") %>"/>
                        <html:hidden property="rpmode" value="<%= request.getParameter(\"rpmode\") %>"/>
                <html:hidden property="rpmode___hide" value="<%= request.getParameter(\"rpmode___hide\") %>"/>
                        <html:hidden property="rpaddress" value="<%= request.getParameter(\"rpaddress\") %>"/>
                <html:hidden property="rpaddress___hide" value="<%= request.getParameter(\"rpaddress___hide\") %>"/>
                        <html:hidden property="msdplocaladdress" value="<%= request.getParameter(\"msdplocaladdress\") %>"/>
                <html:hidden property="msdplocaladdress___hide" value="<%= request.getParameter(\"msdplocaladdress___hide\") %>"/>
                        <html:hidden property="msdppeeraddress" value="<%= request.getParameter(\"msdppeeraddress\") %>"/>
                <html:hidden property="msdppeeraddress___hide" value="<%= request.getParameter(\"msdppeeraddress___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.MulticastSiteForm.submit()"/>
  </html:form>

  </body>
</html>
  
