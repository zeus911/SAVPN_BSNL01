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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(IPHostConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(IPHostConstants.DATASOURCE);
String tabName = request.getParameter(IPHostConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

IPHostForm form = (IPHostForm) request.getAttribute("IPHostForm");


String IP___hide = null;
String PoolName___hide = null;
String IPStr___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListIPHost.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  IP___hide = form.getIp___hide();
  PoolName___hide = form.getPoolname___hide();
  IPStr___hide = form.getIpstr___hide();

  if ( IP___hide != null )
    requestURI.append("ip___hide=" + IP___hide);
  if ( PoolName___hide != null )
    requestURI.append("poolname___hide=" + PoolName___hide);
  if ( IPStr___hide != null )
    requestURI.append("ipstr___hide=" + IPStr___hide);

} else {

    IP___hide = request.getParameter("ip___hide");
    PoolName___hide = request.getParameter("poolname___hide");
    IPStr___hide = request.getParameter("ipstr___hide");

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
    <title><bean:message bundle="IPHostApplicationResources" key="<%= IPHostConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="IPHostApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitIPHostAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( IP___hide == null || IP___hide.equals("null") ) {
%>
      <display:column property="ip" sortable="true" titleKey="IPHostApplicationResources:field.ip.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PoolName___hide == null || PoolName___hide.equals("null") ) {
%>
      <display:column property="poolname" sortable="true" titleKey="IPHostApplicationResources:field.poolname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( IPStr___hide == null || IPStr___hide.equals("null") ) {
%>
      <display:column property="ipstr" sortable="true" titleKey="IPHostApplicationResources:field.ipstr.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormIPHostAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="ip" value="<%= form.getIp() %>"/>
                <html:hidden property="ip___hide" value="<%= form.getIp___hide() %>"/>
                        <html:hidden property="poolname" value="<%= form.getPoolname() %>"/>
                <html:hidden property="poolname___hide" value="<%= form.getPoolname___hide() %>"/>
                        <html:hidden property="ipstr" value="<%= form.getIpstr() %>"/>
                <html:hidden property="ipstr___hide" value="<%= form.getIpstr___hide() %>"/>
                                                            <%
}
  else {    
%>
                  <html:hidden property="ip" value="<%= request.getParameter(\"ip\") %>"/>
                <html:hidden property="ip___hide" value="<%= request.getParameter(\"ip___hide\") %>"/>
                        <html:hidden property="poolname" value="<%= request.getParameter(\"poolname\") %>"/>
                <html:hidden property="poolname___hide" value="<%= request.getParameter(\"poolname___hide\") %>"/>
                        <html:hidden property="ipstr" value="<%= request.getParameter(\"ipstr\") %>"/>
                <html:hidden property="ipstr___hide" value="<%= request.getParameter(\"ipstr___hide\") %>"/>
                                                            <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.IPHostForm.submit()"/>
  </html:form>

  </body>
</html>
  
