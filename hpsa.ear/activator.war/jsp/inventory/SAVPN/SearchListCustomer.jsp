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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(CustomerConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(CustomerConstants.DATASOURCE);
String tabName = request.getParameter(CustomerConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

CustomerForm form = (CustomerForm) request.getAttribute("CustomerForm");


String CustomerId___hide = null;
String CustomerName___hide = null;
String CustomerContact___hide = null;
String CustomerEmail___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListCustomer.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  CustomerId___hide = form.getCustomerid___hide();
  CustomerName___hide = form.getCustomername___hide();
  CustomerContact___hide = form.getCustomercontact___hide();
  CustomerEmail___hide = form.getCustomeremail___hide();

  if ( CustomerId___hide != null )
    requestURI.append("customerid___hide=" + CustomerId___hide);
  if ( CustomerName___hide != null )
    requestURI.append("customername___hide=" + CustomerName___hide);
  if ( CustomerContact___hide != null )
    requestURI.append("customercontact___hide=" + CustomerContact___hide);
  if ( CustomerEmail___hide != null )
    requestURI.append("customeremail___hide=" + CustomerEmail___hide);

} else {

    CustomerId___hide = request.getParameter("customerid___hide");
    CustomerName___hide = request.getParameter("customername___hide");
    CustomerContact___hide = request.getParameter("customercontact___hide");
    CustomerEmail___hide = request.getParameter("customeremail___hide");

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
    <title><bean:message bundle="CustomerApplicationResources" key="<%= CustomerConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="CustomerApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitCustomerAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( CustomerId___hide == null || CustomerId___hide.equals("null") ) {
%>
      <display:column property="customerid" sortable="true" titleKey="CustomerApplicationResources:field.customerid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CustomerName___hide == null || CustomerName___hide.equals("null") ) {
%>
      <display:column property="customername" sortable="true" titleKey="CustomerApplicationResources:field.customername.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CustomerContact___hide == null || CustomerContact___hide.equals("null") ) {
%>
      <display:column property="customercontact" sortable="true" titleKey="CustomerApplicationResources:field.customercontact.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CustomerEmail___hide == null || CustomerEmail___hide.equals("null") ) {
%>
      <display:column property="customeremail" sortable="true" titleKey="CustomerApplicationResources:field.customeremail.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormCustomerAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="customerid" value="<%= form.getCustomerid() %>"/>
                <html:hidden property="customerid___hide" value="<%= form.getCustomerid___hide() %>"/>
                        <html:hidden property="customername" value="<%= form.getCustomername() %>"/>
                <html:hidden property="customername___hide" value="<%= form.getCustomername___hide() %>"/>
                                  <html:hidden property="customercontact" value="<%= form.getCustomercontact() %>"/>
                <html:hidden property="customercontact___hide" value="<%= form.getCustomercontact___hide() %>"/>
                        <html:hidden property="customeremail" value="<%= form.getCustomeremail() %>"/>
                <html:hidden property="customeremail___hide" value="<%= form.getCustomeremail___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="customerid" value="<%= request.getParameter(\"customerid\") %>"/>
                <html:hidden property="customerid___hide" value="<%= request.getParameter(\"customerid___hide\") %>"/>
                        <html:hidden property="customername" value="<%= request.getParameter(\"customername\") %>"/>
                <html:hidden property="customername___hide" value="<%= request.getParameter(\"customername___hide\") %>"/>
                                  <html:hidden property="customercontact" value="<%= request.getParameter(\"customercontact\") %>"/>
                <html:hidden property="customercontact___hide" value="<%= request.getParameter(\"customercontact___hide\") %>"/>
                        <html:hidden property="customeremail" value="<%= request.getParameter(\"customeremail\") %>"/>
                <html:hidden property="customeremail___hide" value="<%= request.getParameter(\"customeremail___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.CustomerForm.submit()"/>
  </html:form>

  </body>
</html>
  
