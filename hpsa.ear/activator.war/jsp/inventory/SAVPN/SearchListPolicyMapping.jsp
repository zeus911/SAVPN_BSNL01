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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(PolicyMappingConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(PolicyMappingConstants.DATASOURCE);
String tabName = request.getParameter(PolicyMappingConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

PolicyMappingForm form = (PolicyMappingForm) request.getAttribute("PolicyMappingForm");


String TClassName___hide = null;
String ProfileName___hide = null;
String Exp___hide = null;
String Dscp___hide = null;
String Percentage___hide = null;
String Position___hide = null;
String PLP___hide = null;
String queueName___hide = null;
String CoSName___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListPolicyMapping.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  TClassName___hide = form.getTclassname___hide();
  ProfileName___hide = form.getProfilename___hide();
  Exp___hide = form.getExp___hide();
  Dscp___hide = form.getDscp___hide();
  Percentage___hide = form.getPercentage___hide();
  Position___hide = form.getPosition___hide();
  PLP___hide = form.getPlp___hide();
  queueName___hide = form.getQueuename___hide();
  CoSName___hide = form.getCosname___hide();

  if ( TClassName___hide != null )
    requestURI.append("tclassname___hide=" + TClassName___hide);
  if ( ProfileName___hide != null )
    requestURI.append("profilename___hide=" + ProfileName___hide);
  if ( Exp___hide != null )
    requestURI.append("exp___hide=" + Exp___hide);
  if ( Dscp___hide != null )
    requestURI.append("dscp___hide=" + Dscp___hide);
  if ( Percentage___hide != null )
    requestURI.append("percentage___hide=" + Percentage___hide);
  if ( Position___hide != null )
    requestURI.append("position___hide=" + Position___hide);
  if ( PLP___hide != null )
    requestURI.append("plp___hide=" + PLP___hide);
  if ( queueName___hide != null )
    requestURI.append("queuename___hide=" + queueName___hide);
  if ( CoSName___hide != null )
    requestURI.append("cosname___hide=" + CoSName___hide);

} else {

    TClassName___hide = request.getParameter("tclassname___hide");
    ProfileName___hide = request.getParameter("profilename___hide");
    Exp___hide = request.getParameter("exp___hide");
    Dscp___hide = request.getParameter("dscp___hide");
    Percentage___hide = request.getParameter("percentage___hide");
    Position___hide = request.getParameter("position___hide");
    PLP___hide = request.getParameter("plp___hide");
    queueName___hide = request.getParameter("queuename___hide");
    CoSName___hide = request.getParameter("cosname___hide");

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
    <title><bean:message bundle="PolicyMappingApplicationResources" key="<%= PolicyMappingConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="PolicyMappingApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitPolicyMappingAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( TClassName___hide == null || TClassName___hide.equals("null") ) {
%>
      <display:column property="tclassname" sortable="true" titleKey="PolicyMappingApplicationResources:field.tclassname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ProfileName___hide == null || ProfileName___hide.equals("null") ) {
%>
      <display:column property="profilename" sortable="true" titleKey="PolicyMappingApplicationResources:field.profilename.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Exp___hide == null || Exp___hide.equals("null") ) {
%>
      <display:column property="exp" sortable="true" titleKey="PolicyMappingApplicationResources:field.exp.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Dscp___hide == null || Dscp___hide.equals("null") ) {
%>
      <display:column property="dscp" sortable="true" titleKey="PolicyMappingApplicationResources:field.dscp.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Percentage___hide == null || Percentage___hide.equals("null") ) {
%>
      <display:column property="percentage" sortable="true" titleKey="PolicyMappingApplicationResources:field.percentage.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Position___hide == null || Position___hide.equals("null") ) {
%>
      <display:column property="position" sortable="true" titleKey="PolicyMappingApplicationResources:field.position.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PLP___hide == null || PLP___hide.equals("null") ) {
%>
      <display:column property="plp" sortable="true" titleKey="PolicyMappingApplicationResources:field.plp.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( queueName___hide == null || queueName___hide.equals("null") ) {
%>
      <display:column property="queuename" sortable="true" titleKey="PolicyMappingApplicationResources:field.queuename.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CoSName___hide == null || CoSName___hide.equals("null") ) {
%>
      <display:column property="cosname" sortable="true" titleKey="PolicyMappingApplicationResources:field.cosname.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormPolicyMappingAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="tclassname" value="<%= form.getTclassname() %>"/>
                <html:hidden property="tclassname___hide" value="<%= form.getTclassname___hide() %>"/>
                        <html:hidden property="profilename" value="<%= form.getProfilename() %>"/>
                <html:hidden property="profilename___hide" value="<%= form.getProfilename___hide() %>"/>
                        <html:hidden property="exp" value="<%= form.getExp() %>"/>
                <html:hidden property="exp___hide" value="<%= form.getExp___hide() %>"/>
                        <html:hidden property="dscp" value="<%= form.getDscp() %>"/>
                <html:hidden property="dscp___hide" value="<%= form.getDscp___hide() %>"/>
                        <html:hidden property="percentage" value="<%= form.getPercentage() %>"/>
                <html:hidden property="percentage___hide" value="<%= form.getPercentage___hide() %>"/>
                        <html:hidden property="position" value="<%= form.getPosition() %>"/>
                <html:hidden property="position___hide" value="<%= form.getPosition___hide() %>"/>
                        <html:hidden property="plp" value="<%= form.getPlp() %>"/>
                <html:hidden property="plp___hide" value="<%= form.getPlp___hide() %>"/>
                        <html:hidden property="queuename" value="<%= form.getQueuename() %>"/>
                <html:hidden property="queuename___hide" value="<%= form.getQueuename___hide() %>"/>
                        <html:hidden property="cosname" value="<%= form.getCosname() %>"/>
                <html:hidden property="cosname___hide" value="<%= form.getCosname___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="tclassname" value="<%= request.getParameter(\"tclassname\") %>"/>
                <html:hidden property="tclassname___hide" value="<%= request.getParameter(\"tclassname___hide\") %>"/>
                        <html:hidden property="profilename" value="<%= request.getParameter(\"profilename\") %>"/>
                <html:hidden property="profilename___hide" value="<%= request.getParameter(\"profilename___hide\") %>"/>
                        <html:hidden property="exp" value="<%= request.getParameter(\"exp\") %>"/>
                <html:hidden property="exp___hide" value="<%= request.getParameter(\"exp___hide\") %>"/>
                        <html:hidden property="dscp" value="<%= request.getParameter(\"dscp\") %>"/>
                <html:hidden property="dscp___hide" value="<%= request.getParameter(\"dscp___hide\") %>"/>
                        <html:hidden property="percentage" value="<%= request.getParameter(\"percentage\") %>"/>
                <html:hidden property="percentage___hide" value="<%= request.getParameter(\"percentage___hide\") %>"/>
                        <html:hidden property="position" value="<%= request.getParameter(\"position\") %>"/>
                <html:hidden property="position___hide" value="<%= request.getParameter(\"position___hide\") %>"/>
                        <html:hidden property="plp" value="<%= request.getParameter(\"plp\") %>"/>
                <html:hidden property="plp___hide" value="<%= request.getParameter(\"plp___hide\") %>"/>
                        <html:hidden property="queuename" value="<%= request.getParameter(\"queuename\") %>"/>
                <html:hidden property="queuename___hide" value="<%= request.getParameter(\"queuename___hide\") %>"/>
                        <html:hidden property="cosname" value="<%= request.getParameter(\"cosname\") %>"/>
                <html:hidden property="cosname___hide" value="<%= request.getParameter(\"cosname___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.PolicyMappingForm.submit()"/>
  </html:form>

  </body>
</html>
  
