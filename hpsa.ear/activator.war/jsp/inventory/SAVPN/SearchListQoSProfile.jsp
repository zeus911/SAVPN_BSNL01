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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(QoSProfileConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(QoSProfileConstants.DATASOURCE);
String tabName = request.getParameter(QoSProfileConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

QoSProfileForm form = (QoSProfileForm) request.getAttribute("QoSProfileForm");


String CustomerId___hide = null;
String QoSProfileName___hide = null;
String Prefix___hide = null;
String Layer___hide = null;
String PEQoSProfileName___hide = null;
String Profilename_in___hide = null;
String Profilename_out___hide = null;
String Compliant___hide = null;
String Description___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListQoSProfile.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  CustomerId___hide = form.getCustomerid___hide();
  QoSProfileName___hide = form.getQosprofilename___hide();
  Prefix___hide = form.getPrefix___hide();
  Layer___hide = form.getLayer___hide();
  PEQoSProfileName___hide = form.getPeqosprofilename___hide();
  Profilename_in___hide = form.getProfilename_in___hide();
  Profilename_out___hide = form.getProfilename_out___hide();
  Compliant___hide = form.getCompliant___hide();
  Description___hide = form.getDescription___hide();

  if ( CustomerId___hide != null )
    requestURI.append("customerid___hide=" + CustomerId___hide);
  if ( QoSProfileName___hide != null )
    requestURI.append("qosprofilename___hide=" + QoSProfileName___hide);
  if ( Prefix___hide != null )
    requestURI.append("prefix___hide=" + Prefix___hide);
  if ( Layer___hide != null )
    requestURI.append("layer___hide=" + Layer___hide);
  if ( PEQoSProfileName___hide != null )
    requestURI.append("peqosprofilename___hide=" + PEQoSProfileName___hide);
  if ( Profilename_in___hide != null )
    requestURI.append("profilename_in___hide=" + Profilename_in___hide);
  if ( Profilename_out___hide != null )
    requestURI.append("profilename_out___hide=" + Profilename_out___hide);
  if ( Compliant___hide != null )
    requestURI.append("compliant___hide=" + Compliant___hide);
  if ( Description___hide != null )
    requestURI.append("description___hide=" + Description___hide);

} else {

    CustomerId___hide = request.getParameter("customerid___hide");
    QoSProfileName___hide = request.getParameter("qosprofilename___hide");
    Prefix___hide = request.getParameter("prefix___hide");
    Layer___hide = request.getParameter("layer___hide");
    PEQoSProfileName___hide = request.getParameter("peqosprofilename___hide");
    Profilename_in___hide = request.getParameter("profilename_in___hide");
    Profilename_out___hide = request.getParameter("profilename_out___hide");
    Compliant___hide = request.getParameter("compliant___hide");
    Description___hide = request.getParameter("description___hide");

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
    <title><bean:message bundle="QoSProfileApplicationResources" key="<%= QoSProfileConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="QoSProfileApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitQoSProfileAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( CustomerId___hide == null || CustomerId___hide.equals("null") ) {
%>
      <display:column property="customerid" sortable="true" titleKey="QoSProfileApplicationResources:field.customerid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( QoSProfileName___hide == null || QoSProfileName___hide.equals("null") ) {
%>
      <display:column property="qosprofilename" sortable="true" titleKey="QoSProfileApplicationResources:field.qosprofilename.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Prefix___hide == null || Prefix___hide.equals("null") ) {
%>
      <display:column property="prefix" sortable="true" titleKey="QoSProfileApplicationResources:field.prefix.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Layer___hide == null || Layer___hide.equals("null") ) {
%>
      <display:column property="layer" sortable="true" titleKey="QoSProfileApplicationResources:field.layer.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PEQoSProfileName___hide == null || PEQoSProfileName___hide.equals("null") ) {
%>
      <display:column property="peqosprofilename" sortable="true" titleKey="QoSProfileApplicationResources:field.peqosprofilename.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Profilename_in___hide == null || Profilename_in___hide.equals("null") ) {
%>
      <display:column property="profilename_in" sortable="true" titleKey="QoSProfileApplicationResources:field.profilename_in.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Profilename_out___hide == null || Profilename_out___hide.equals("null") ) {
%>
      <display:column property="profilename_out" sortable="true" titleKey="QoSProfileApplicationResources:field.profilename_out.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Compliant___hide == null || Compliant___hide.equals("null") ) {
%>
      <display:column property="compliant" sortable="true" titleKey="QoSProfileApplicationResources:field.compliant.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Description___hide == null || Description___hide.equals("null") ) {
%>
      <display:column property="description" sortable="true" titleKey="QoSProfileApplicationResources:field.description.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormQoSProfileAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="customerid" value="<%= form.getCustomerid() %>"/>
                <html:hidden property="customerid___hide" value="<%= form.getCustomerid___hide() %>"/>
                        <html:hidden property="qosprofilename" value="<%= form.getQosprofilename() %>"/>
                <html:hidden property="qosprofilename___hide" value="<%= form.getQosprofilename___hide() %>"/>
                        <html:hidden property="prefix" value="<%= form.getPrefix() %>"/>
                <html:hidden property="prefix___hide" value="<%= form.getPrefix___hide() %>"/>
                        <html:hidden property="layer" value="<%= form.getLayer() %>"/>
                <html:hidden property="layer___hide" value="<%= form.getLayer___hide() %>"/>
                        <html:hidden property="peqosprofilename" value="<%= form.getPeqosprofilename() %>"/>
                <html:hidden property="peqosprofilename___hide" value="<%= form.getPeqosprofilename___hide() %>"/>
                        <html:hidden property="profilename_in" value="<%= form.getProfilename_in() %>"/>
                <html:hidden property="profilename_in___hide" value="<%= form.getProfilename_in___hide() %>"/>
                        <html:hidden property="profilename_out" value="<%= form.getProfilename_out() %>"/>
                <html:hidden property="profilename_out___hide" value="<%= form.getProfilename_out___hide() %>"/>
                        <html:hidden property="compliant" value="<%= form.getCompliant() %>"/>
                <html:hidden property="compliant___hide" value="<%= form.getCompliant___hide() %>"/>
                        <html:hidden property="description" value="<%= form.getDescription() %>"/>
                <html:hidden property="description___hide" value="<%= form.getDescription___hide() %>"/>
                    <%
}
  else {    
%>
                  <html:hidden property="customerid" value="<%= request.getParameter(\"customerid\") %>"/>
                <html:hidden property="customerid___hide" value="<%= request.getParameter(\"customerid___hide\") %>"/>
                        <html:hidden property="qosprofilename" value="<%= request.getParameter(\"qosprofilename\") %>"/>
                <html:hidden property="qosprofilename___hide" value="<%= request.getParameter(\"qosprofilename___hide\") %>"/>
                        <html:hidden property="prefix" value="<%= request.getParameter(\"prefix\") %>"/>
                <html:hidden property="prefix___hide" value="<%= request.getParameter(\"prefix___hide\") %>"/>
                        <html:hidden property="layer" value="<%= request.getParameter(\"layer\") %>"/>
                <html:hidden property="layer___hide" value="<%= request.getParameter(\"layer___hide\") %>"/>
                        <html:hidden property="peqosprofilename" value="<%= request.getParameter(\"peqosprofilename\") %>"/>
                <html:hidden property="peqosprofilename___hide" value="<%= request.getParameter(\"peqosprofilename___hide\") %>"/>
                        <html:hidden property="profilename_in" value="<%= request.getParameter(\"profilename_in\") %>"/>
                <html:hidden property="profilename_in___hide" value="<%= request.getParameter(\"profilename_in___hide\") %>"/>
                        <html:hidden property="profilename_out" value="<%= request.getParameter(\"profilename_out\") %>"/>
                <html:hidden property="profilename_out___hide" value="<%= request.getParameter(\"profilename_out___hide\") %>"/>
                        <html:hidden property="compliant" value="<%= request.getParameter(\"compliant\") %>"/>
                <html:hidden property="compliant___hide" value="<%= request.getParameter(\"compliant___hide\") %>"/>
                        <html:hidden property="description" value="<%= request.getParameter(\"description\") %>"/>
                <html:hidden property="description___hide" value="<%= request.getParameter(\"description___hide\") %>"/>
                    <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.QoSProfileForm.submit()"/>
  </html:form>

  </body>
</html>
  
