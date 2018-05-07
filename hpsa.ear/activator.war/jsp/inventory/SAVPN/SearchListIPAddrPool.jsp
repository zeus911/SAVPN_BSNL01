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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(IPAddrPoolConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(IPAddrPoolConstants.DATASOURCE);
String tabName = request.getParameter(IPAddrPoolConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

IPAddrPoolForm form = (IPAddrPoolForm) request.getAttribute("IPAddrPoolForm");


String Name___hide = null;
String IPNet___hide = null;
String Mask___hide = null;
String Type___hide = null;
String AddressFamily___hide = null;
String isDynamic___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListIPAddrPool.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  Name___hide = form.getName___hide();
  IPNet___hide = form.getIpnet___hide();
  Mask___hide = form.getMask___hide();
  Type___hide = form.getType___hide();
  AddressFamily___hide = form.getAddressfamily___hide();
  isDynamic___hide = form.getIsdynamic___hide();

  if ( Name___hide != null )
    requestURI.append("name___hide=" + Name___hide);
  if ( IPNet___hide != null )
    requestURI.append("ipnet___hide=" + IPNet___hide);
  if ( Mask___hide != null )
    requestURI.append("mask___hide=" + Mask___hide);
  if ( Type___hide != null )
    requestURI.append("type___hide=" + Type___hide);
  if ( AddressFamily___hide != null )
    requestURI.append("addressfamily___hide=" + AddressFamily___hide);
  if ( isDynamic___hide != null )
    requestURI.append("isdynamic___hide=" + isDynamic___hide);

} else {

    Name___hide = request.getParameter("name___hide");
    IPNet___hide = request.getParameter("ipnet___hide");
    Mask___hide = request.getParameter("mask___hide");
    Type___hide = request.getParameter("type___hide");
    AddressFamily___hide = request.getParameter("addressfamily___hide");
    isDynamic___hide = request.getParameter("isdynamic___hide");

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
    <title><bean:message bundle="IPAddrPoolApplicationResources" key="<%= IPAddrPoolConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="IPAddrPoolApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitIPAddrPoolAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( Name___hide == null || Name___hide.equals("null") ) {
%>
      <display:column property="name" sortable="true" titleKey="IPAddrPoolApplicationResources:field.name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IPNet___hide == null || IPNet___hide.equals("null") ) {
%>
      <display:column property="ipnet" sortable="true" titleKey="IPAddrPoolApplicationResources:field.ipnet.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Mask___hide == null || Mask___hide.equals("null") ) {
%>
      <display:column property="mask" sortable="true" titleKey="IPAddrPoolApplicationResources:field.mask.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Type___hide == null || Type___hide.equals("null") ) {
%>
      <display:column property="type" sortable="true" titleKey="IPAddrPoolApplicationResources:field.type.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( AddressFamily___hide == null || AddressFamily___hide.equals("null") ) {
%>
      <display:column property="addressfamily" sortable="true" titleKey="IPAddrPoolApplicationResources:field.addressfamily.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( isDynamic___hide == null || isDynamic___hide.equals("null") ) {
%>
      <display:column property="isdynamic" sortable="true" titleKey="IPAddrPoolApplicationResources:field.isdynamic.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormIPAddrPoolAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="name" value="<%= form.getName() %>"/>
                <html:hidden property="name___hide" value="<%= form.getName___hide() %>"/>
                        <html:hidden property="ipnet" value="<%= form.getIpnet() %>"/>
                <html:hidden property="ipnet___hide" value="<%= form.getIpnet___hide() %>"/>
                        <html:hidden property="mask" value="<%= form.getMask() %>"/>
                <html:hidden property="mask___hide" value="<%= form.getMask___hide() %>"/>
                                  <html:hidden property="type" value="<%= form.getType() %>"/>
                <html:hidden property="type___hide" value="<%= form.getType___hide() %>"/>
                        <html:hidden property="addressfamily" value="<%= form.getAddressfamily() %>"/>
                <html:hidden property="addressfamily___hide" value="<%= form.getAddressfamily___hide() %>"/>
                        <html:hidden property="isdynamic" value="<%= form.getIsdynamic() %>"/>
                <html:hidden property="isdynamic___hide" value="<%= form.getIsdynamic___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="name" value="<%= request.getParameter(\"name\") %>"/>
                <html:hidden property="name___hide" value="<%= request.getParameter(\"name___hide\") %>"/>
                        <html:hidden property="ipnet" value="<%= request.getParameter(\"ipnet\") %>"/>
                <html:hidden property="ipnet___hide" value="<%= request.getParameter(\"ipnet___hide\") %>"/>
                        <html:hidden property="mask" value="<%= request.getParameter(\"mask\") %>"/>
                <html:hidden property="mask___hide" value="<%= request.getParameter(\"mask___hide\") %>"/>
                                  <html:hidden property="type" value="<%= request.getParameter(\"type\") %>"/>
                <html:hidden property="type___hide" value="<%= request.getParameter(\"type___hide\") %>"/>
                        <html:hidden property="addressfamily" value="<%= request.getParameter(\"addressfamily\") %>"/>
                <html:hidden property="addressfamily___hide" value="<%= request.getParameter(\"addressfamily___hide\") %>"/>
                        <html:hidden property="isdynamic" value="<%= request.getParameter(\"isdynamic\") %>"/>
                <html:hidden property="isdynamic___hide" value="<%= request.getParameter(\"isdynamic___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.IPAddrPoolForm.submit()"/>
  </html:form>

  </body>
</html>
  