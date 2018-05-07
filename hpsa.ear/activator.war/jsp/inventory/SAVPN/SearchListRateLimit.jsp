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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(RateLimitConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(RateLimitConstants.DATASOURCE);
String tabName = request.getParameter(RateLimitConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

RateLimitForm form = (RateLimitForm) request.getAttribute("RateLimitForm");


String RateLimitName___hide = null;
String Description___hide = null;
String BurstMaximum___hide = null;
String BurstNormal___hide = null;
String AverageBW___hide = null;
String Compliant___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListRateLimit.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  RateLimitName___hide = form.getRatelimitname___hide();
  Description___hide = form.getDescription___hide();
  BurstMaximum___hide = form.getBurstmaximum___hide();
  BurstNormal___hide = form.getBurstnormal___hide();
  AverageBW___hide = form.getAveragebw___hide();
  Compliant___hide = form.getCompliant___hide();

  if ( RateLimitName___hide != null )
    requestURI.append("ratelimitname___hide=" + RateLimitName___hide);
  if ( Description___hide != null )
    requestURI.append("description___hide=" + Description___hide);
  if ( BurstMaximum___hide != null )
    requestURI.append("burstmaximum___hide=" + BurstMaximum___hide);
  if ( BurstNormal___hide != null )
    requestURI.append("burstnormal___hide=" + BurstNormal___hide);
  if ( AverageBW___hide != null )
    requestURI.append("averagebw___hide=" + AverageBW___hide);
  if ( Compliant___hide != null )
    requestURI.append("compliant___hide=" + Compliant___hide);

} else {

    RateLimitName___hide = request.getParameter("ratelimitname___hide");
    Description___hide = request.getParameter("description___hide");
    BurstMaximum___hide = request.getParameter("burstmaximum___hide");
    BurstNormal___hide = request.getParameter("burstnormal___hide");
    AverageBW___hide = request.getParameter("averagebw___hide");
    Compliant___hide = request.getParameter("compliant___hide");

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
    <title><bean:message bundle="RateLimitApplicationResources" key="<%= RateLimitConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="RateLimitApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitRateLimitAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( RateLimitName___hide == null || RateLimitName___hide.equals("null") ) {
%>
      <display:column property="ratelimitname" sortable="true" titleKey="RateLimitApplicationResources:field.ratelimitname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Description___hide == null || Description___hide.equals("null") ) {
%>
      <display:column property="description" sortable="true" titleKey="RateLimitApplicationResources:field.description.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( BurstMaximum___hide == null || BurstMaximum___hide.equals("null") ) {
%>
      <display:column property="burstmaximum" sortable="true" titleKey="RateLimitApplicationResources:field.burstmaximum.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( BurstNormal___hide == null || BurstNormal___hide.equals("null") ) {
%>
      <display:column property="burstnormal" sortable="true" titleKey="RateLimitApplicationResources:field.burstnormal.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( AverageBW___hide == null || AverageBW___hide.equals("null") ) {
%>
      <display:column property="averagebw" sortable="true" titleKey="RateLimitApplicationResources:field.averagebw.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Compliant___hide == null || Compliant___hide.equals("null") ) {
%>
      <display:column property="compliant" sortable="true" titleKey="RateLimitApplicationResources:field.compliant.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormRateLimitAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="ratelimitname" value="<%= form.getRatelimitname() %>"/>
                <html:hidden property="ratelimitname___hide" value="<%= form.getRatelimitname___hide() %>"/>
                        <html:hidden property="description" value="<%= form.getDescription() %>"/>
                <html:hidden property="description___hide" value="<%= form.getDescription___hide() %>"/>
                        <html:hidden property="burstmaximum" value="<%= form.getBurstmaximum() %>"/>
                  <html:hidden property="burstmaximum___" value="<%= form.getBurstmaximum___() %>"/>
                <html:hidden property="burstmaximum___hide" value="<%= form.getBurstmaximum___hide() %>"/>
                        <html:hidden property="burstnormal" value="<%= form.getBurstnormal() %>"/>
                  <html:hidden property="burstnormal___" value="<%= form.getBurstnormal___() %>"/>
                <html:hidden property="burstnormal___hide" value="<%= form.getBurstnormal___hide() %>"/>
                        <html:hidden property="averagebw" value="<%= form.getAveragebw() %>"/>
                  <html:hidden property="averagebw___" value="<%= form.getAveragebw___() %>"/>
                <html:hidden property="averagebw___hide" value="<%= form.getAveragebw___hide() %>"/>
                        <html:hidden property="compliant" value="<%= form.getCompliant() %>"/>
                <html:hidden property="compliant___hide" value="<%= form.getCompliant___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="ratelimitname" value="<%= request.getParameter(\"ratelimitname\") %>"/>
                <html:hidden property="ratelimitname___hide" value="<%= request.getParameter(\"ratelimitname___hide\") %>"/>
                        <html:hidden property="description" value="<%= request.getParameter(\"description\") %>"/>
                <html:hidden property="description___hide" value="<%= request.getParameter(\"description___hide\") %>"/>
                        <html:hidden property="burstmaximum" value="<%= request.getParameter(\"burstmaximum\") %>"/>
                  <html:hidden property="burstmaximum___" value="<%= request.getParameter(\"burstmaximum___\") %>"/>
                <html:hidden property="burstmaximum___hide" value="<%= request.getParameter(\"burstmaximum___hide\") %>"/>
                        <html:hidden property="burstnormal" value="<%= request.getParameter(\"burstnormal\") %>"/>
                  <html:hidden property="burstnormal___" value="<%= request.getParameter(\"burstnormal___\") %>"/>
                <html:hidden property="burstnormal___hide" value="<%= request.getParameter(\"burstnormal___hide\") %>"/>
                        <html:hidden property="averagebw" value="<%= request.getParameter(\"averagebw\") %>"/>
                  <html:hidden property="averagebw___" value="<%= request.getParameter(\"averagebw___\") %>"/>
                <html:hidden property="averagebw___hide" value="<%= request.getParameter(\"averagebw___hide\") %>"/>
                        <html:hidden property="compliant" value="<%= request.getParameter(\"compliant\") %>"/>
                <html:hidden property="compliant___hide" value="<%= request.getParameter(\"compliant___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.RateLimitForm.submit()"/>
  </html:form>

  </body>
</html>
  
