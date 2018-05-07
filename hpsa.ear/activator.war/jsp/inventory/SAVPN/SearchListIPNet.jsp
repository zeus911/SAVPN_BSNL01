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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(IPNetConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(IPNetConstants.DATASOURCE);
String tabName = request.getParameter(IPNetConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

IPNetForm form = (IPNetForm) request.getAttribute("IPNetForm");


String IPNetAddr___hide = null;
String PE1_IPAddr___hide = null;
String CE1_IPAddr___hide = null;
String PE2_IPAddr___hide = null;
String CE2_IPAddr___hide = null;
String Netmask___hide = null;
String Hostmask___hide = null;
String PoolName___hide = null;
String IPNetAddrStr___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListIPNet.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  IPNetAddr___hide = form.getIpnetaddr___hide();
  PE1_IPAddr___hide = form.getPe1_ipaddr___hide();
  CE1_IPAddr___hide = form.getCe1_ipaddr___hide();
  PE2_IPAddr___hide = form.getPe2_ipaddr___hide();
  CE2_IPAddr___hide = form.getCe2_ipaddr___hide();
  Netmask___hide = form.getNetmask___hide();
  Hostmask___hide = form.getHostmask___hide();
  PoolName___hide = form.getPoolname___hide();
  IPNetAddrStr___hide = form.getIpnetaddrstr___hide();

  if ( IPNetAddr___hide != null )
    requestURI.append("ipnetaddr___hide=" + IPNetAddr___hide);
  if ( PE1_IPAddr___hide != null )
    requestURI.append("pe1_ipaddr___hide=" + PE1_IPAddr___hide);
  if ( CE1_IPAddr___hide != null )
    requestURI.append("ce1_ipaddr___hide=" + CE1_IPAddr___hide);
  if ( PE2_IPAddr___hide != null )
    requestURI.append("pe2_ipaddr___hide=" + PE2_IPAddr___hide);
  if ( CE2_IPAddr___hide != null )
    requestURI.append("ce2_ipaddr___hide=" + CE2_IPAddr___hide);
  if ( Netmask___hide != null )
    requestURI.append("netmask___hide=" + Netmask___hide);
  if ( Hostmask___hide != null )
    requestURI.append("hostmask___hide=" + Hostmask___hide);
  if ( PoolName___hide != null )
    requestURI.append("poolname___hide=" + PoolName___hide);
  if ( IPNetAddrStr___hide != null )
    requestURI.append("ipnetaddrstr___hide=" + IPNetAddrStr___hide);

} else {

    IPNetAddr___hide = request.getParameter("ipnetaddr___hide");
    PE1_IPAddr___hide = request.getParameter("pe1_ipaddr___hide");
    CE1_IPAddr___hide = request.getParameter("ce1_ipaddr___hide");
    PE2_IPAddr___hide = request.getParameter("pe2_ipaddr___hide");
    CE2_IPAddr___hide = request.getParameter("ce2_ipaddr___hide");
    Netmask___hide = request.getParameter("netmask___hide");
    Hostmask___hide = request.getParameter("hostmask___hide");
    PoolName___hide = request.getParameter("poolname___hide");
    IPNetAddrStr___hide = request.getParameter("ipnetaddrstr___hide");

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
    <title><bean:message bundle="IPNetApplicationResources" key="<%= IPNetConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="IPNetApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitIPNetAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( IPNetAddr___hide == null || IPNetAddr___hide.equals("null") ) {
%>
      <display:column property="ipnetaddr" sortable="true" titleKey="IPNetApplicationResources:field.ipnetaddr.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PE1_IPAddr___hide == null || PE1_IPAddr___hide.equals("null") ) {
%>
      <display:column property="pe1_ipaddr" sortable="true" titleKey="IPNetApplicationResources:field.pe1_ipaddr.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CE1_IPAddr___hide == null || CE1_IPAddr___hide.equals("null") ) {
%>
      <display:column property="ce1_ipaddr" sortable="true" titleKey="IPNetApplicationResources:field.ce1_ipaddr.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PE2_IPAddr___hide == null || PE2_IPAddr___hide.equals("null") ) {
%>
      <display:column property="pe2_ipaddr" sortable="true" titleKey="IPNetApplicationResources:field.pe2_ipaddr.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CE2_IPAddr___hide == null || CE2_IPAddr___hide.equals("null") ) {
%>
      <display:column property="ce2_ipaddr" sortable="true" titleKey="IPNetApplicationResources:field.ce2_ipaddr.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Netmask___hide == null || Netmask___hide.equals("null") ) {
%>
      <display:column property="netmask" sortable="true" titleKey="IPNetApplicationResources:field.netmask.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Hostmask___hide == null || Hostmask___hide.equals("null") ) {
%>
      <display:column property="hostmask" sortable="true" titleKey="IPNetApplicationResources:field.hostmask.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PoolName___hide == null || PoolName___hide.equals("null") ) {
%>
      <display:column property="poolname" sortable="true" titleKey="IPNetApplicationResources:field.poolname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IPNetAddrStr___hide == null || IPNetAddrStr___hide.equals("null") ) {
%>
      <display:column property="ipnetaddrstr" sortable="true" titleKey="IPNetApplicationResources:field.ipnetaddrstr.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormIPNetAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="ipnetaddr" value="<%= form.getIpnetaddr() %>"/>
                <html:hidden property="ipnetaddr___hide" value="<%= form.getIpnetaddr___hide() %>"/>
                        <html:hidden property="pe1_ipaddr" value="<%= form.getPe1_ipaddr() %>"/>
                <html:hidden property="pe1_ipaddr___hide" value="<%= form.getPe1_ipaddr___hide() %>"/>
                        <html:hidden property="ce1_ipaddr" value="<%= form.getCe1_ipaddr() %>"/>
                <html:hidden property="ce1_ipaddr___hide" value="<%= form.getCe1_ipaddr___hide() %>"/>
                        <html:hidden property="pe2_ipaddr" value="<%= form.getPe2_ipaddr() %>"/>
                <html:hidden property="pe2_ipaddr___hide" value="<%= form.getPe2_ipaddr___hide() %>"/>
                        <html:hidden property="ce2_ipaddr" value="<%= form.getCe2_ipaddr() %>"/>
                <html:hidden property="ce2_ipaddr___hide" value="<%= form.getCe2_ipaddr___hide() %>"/>
                        <html:hidden property="netmask" value="<%= form.getNetmask() %>"/>
                <html:hidden property="netmask___hide" value="<%= form.getNetmask___hide() %>"/>
                        <html:hidden property="hostmask" value="<%= form.getHostmask() %>"/>
                <html:hidden property="hostmask___hide" value="<%= form.getHostmask___hide() %>"/>
                        <html:hidden property="poolname" value="<%= form.getPoolname() %>"/>
                <html:hidden property="poolname___hide" value="<%= form.getPoolname___hide() %>"/>
                        <html:hidden property="ipnetaddrstr" value="<%= form.getIpnetaddrstr() %>"/>
                <html:hidden property="ipnetaddrstr___hide" value="<%= form.getIpnetaddrstr___hide() %>"/>
                                                            <%
}
  else {    
%>
                  <html:hidden property="ipnetaddr" value="<%= request.getParameter(\"ipnetaddr\") %>"/>
                <html:hidden property="ipnetaddr___hide" value="<%= request.getParameter(\"ipnetaddr___hide\") %>"/>
                        <html:hidden property="pe1_ipaddr" value="<%= request.getParameter(\"pe1_ipaddr\") %>"/>
                <html:hidden property="pe1_ipaddr___hide" value="<%= request.getParameter(\"pe1_ipaddr___hide\") %>"/>
                        <html:hidden property="ce1_ipaddr" value="<%= request.getParameter(\"ce1_ipaddr\") %>"/>
                <html:hidden property="ce1_ipaddr___hide" value="<%= request.getParameter(\"ce1_ipaddr___hide\") %>"/>
                        <html:hidden property="pe2_ipaddr" value="<%= request.getParameter(\"pe2_ipaddr\") %>"/>
                <html:hidden property="pe2_ipaddr___hide" value="<%= request.getParameter(\"pe2_ipaddr___hide\") %>"/>
                        <html:hidden property="ce2_ipaddr" value="<%= request.getParameter(\"ce2_ipaddr\") %>"/>
                <html:hidden property="ce2_ipaddr___hide" value="<%= request.getParameter(\"ce2_ipaddr___hide\") %>"/>
                        <html:hidden property="netmask" value="<%= request.getParameter(\"netmask\") %>"/>
                <html:hidden property="netmask___hide" value="<%= request.getParameter(\"netmask___hide\") %>"/>
                        <html:hidden property="hostmask" value="<%= request.getParameter(\"hostmask\") %>"/>
                <html:hidden property="hostmask___hide" value="<%= request.getParameter(\"hostmask___hide\") %>"/>
                        <html:hidden property="poolname" value="<%= request.getParameter(\"poolname\") %>"/>
                <html:hidden property="poolname___hide" value="<%= request.getParameter(\"poolname___hide\") %>"/>
                        <html:hidden property="ipnetaddrstr" value="<%= request.getParameter(\"ipnetaddrstr\") %>"/>
                <html:hidden property="ipnetaddrstr___hide" value="<%= request.getParameter(\"ipnetaddrstr___hide\") %>"/>
                                                            <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.IPNetForm.submit()"/>
  </html:form>

  </body>
</html>
  
