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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(EXPMappingConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(EXPMappingConstants.DATASOURCE);
String tabName = request.getParameter(EXPMappingConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

EXPMappingForm form = (EXPMappingForm) request.getAttribute("EXPMappingForm");


String ClassName___hide = null;
String ExpValue___hide = null;
String DSCPValue___hide = null;
String PLP___hide = null;
String QueueName___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListEXPMapping.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  ClassName___hide = form.getClassname___hide();
  ExpValue___hide = form.getExpvalue___hide();
  DSCPValue___hide = form.getDscpvalue___hide();
  PLP___hide = form.getPlp___hide();
  QueueName___hide = form.getQueuename___hide();

  if ( ClassName___hide != null )
    requestURI.append("classname___hide=" + ClassName___hide);
  if ( ExpValue___hide != null )
    requestURI.append("expvalue___hide=" + ExpValue___hide);
  if ( DSCPValue___hide != null )
    requestURI.append("dscpvalue___hide=" + DSCPValue___hide);
  if ( PLP___hide != null )
    requestURI.append("plp___hide=" + PLP___hide);
  if ( QueueName___hide != null )
    requestURI.append("queuename___hide=" + QueueName___hide);

} else {

    ClassName___hide = request.getParameter("classname___hide");
    ExpValue___hide = request.getParameter("expvalue___hide");
    DSCPValue___hide = request.getParameter("dscpvalue___hide");
    PLP___hide = request.getParameter("plp___hide");
    QueueName___hide = request.getParameter("queuename___hide");

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

  //alert(rowId);
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
	  //customized -- do nothing when clicked
      //openBranch(row_pk);
  }  
}  
</script>

<html>
  <head>
    <title><bean:message bundle="EXPMappingApplicationResources" key="<%= EXPMappingConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="EXPMappingApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitEXPMappingAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( ClassName___hide == null || ClassName___hide.equals("null") ) {
%>
      <display:column property="classname" sortable="true" titleKey="EXPMappingApplicationResources:field.classname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ExpValue___hide == null || ExpValue___hide.equals("null") ) {
%>
      <display:column property="expvalue" sortable="true" titleKey="EXPMappingApplicationResources:field.expvalue.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( DSCPValue___hide == null || DSCPValue___hide.equals("null") ) {
%>
      <display:column property="dscpvalue" sortable="true" titleKey="EXPMappingApplicationResources:field.dscpvalue.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PLP___hide == null || PLP___hide.equals("null") ) {
%>
      <display:column property="plp" sortable="true" titleKey="EXPMappingApplicationResources:field.plp.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( QueueName___hide == null || QueueName___hide.equals("null") ) {
%>
      <display:column property="queuename" sortable="true" titleKey="EXPMappingApplicationResources:field.queuename.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormEXPMappingAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                            <html:hidden property="classname" value="<%= form.getClassname() %>"/>
                <html:hidden property="classname___hide" value="<%= form.getClassname___hide() %>"/>
                        <html:hidden property="expvalue" value="<%= form.getExpvalue() %>"/>
                <html:hidden property="expvalue___hide" value="<%= form.getExpvalue___hide() %>"/>
                        <html:hidden property="dscpvalue" value="<%= form.getDscpvalue() %>"/>
                <html:hidden property="dscpvalue___hide" value="<%= form.getDscpvalue___hide() %>"/>
                        <html:hidden property="plp" value="<%= form.getPlp() %>"/>
                <html:hidden property="plp___hide" value="<%= form.getPlp___hide() %>"/>
                        <html:hidden property="queuename" value="<%= form.getQueuename() %>"/>
                <html:hidden property="queuename___hide" value="<%= form.getQueuename___hide() %>"/>
          <%
}
  else {    
%>
                            <html:hidden property="classname" value="<%= request.getParameter(\"classname\") %>"/>
                <html:hidden property="classname___hide" value="<%= request.getParameter(\"classname___hide\") %>"/>
                        <html:hidden property="expvalue" value="<%= request.getParameter(\"expvalue\") %>"/>
                <html:hidden property="expvalue___hide" value="<%= request.getParameter(\"expvalue___hide\") %>"/>
                        <html:hidden property="dscpvalue" value="<%= request.getParameter(\"dscpvalue\") %>"/>
                <html:hidden property="dscpvalue___hide" value="<%= request.getParameter(\"dscpvalue___hide\") %>"/>
                        <html:hidden property="plp" value="<%= request.getParameter(\"plp\") %>"/>
                <html:hidden property="plp___hide" value="<%= request.getParameter(\"plp___hide\") %>"/>
                        <html:hidden property="queuename" value="<%= request.getParameter(\"queuename\") %>"/>
                <html:hidden property="queuename___hide" value="<%= request.getParameter(\"queuename___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.EXPMappingForm.submit()"/>
  </html:form>

  </body>
</html>
  
