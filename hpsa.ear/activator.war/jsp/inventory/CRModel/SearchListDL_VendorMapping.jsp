<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        java.lang.reflect.Method,
        com.hp.ov.activator.cr.inventory.*,
        com.hp.ov.activator.inventory.CRModel.*,
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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(DL_VendorMappingConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(DL_VendorMappingConstants.DATASOURCE);
String tabName = request.getParameter(DL_VendorMappingConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

DL_VendorMappingForm form = (DL_VendorMappingForm) request.getAttribute("DL_VendorMappingForm");


String NNMi_Vendor___hide = null;
String HPSA_Vendor___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListDL_VendorMapping.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  NNMi_Vendor___hide = form.getNnmi_vendor___hide();
  HPSA_Vendor___hide = form.getHpsa_vendor___hide();

  if ( NNMi_Vendor___hide != null )
    requestURI.append("nnmi_vendor___hide=" + NNMi_Vendor___hide);
  if ( HPSA_Vendor___hide != null )
    requestURI.append("hpsa_vendor___hide=" + HPSA_Vendor___hide);

} else {

    NNMi_Vendor___hide = request.getParameter("nnmi_vendor___hide");
    HPSA_Vendor___hide = request.getParameter("hpsa_vendor___hide");

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
    <title><bean:message bundle="DL_VendorMappingApplicationResources" key="<%= DL_VendorMappingConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_VendorMappingApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitDL_VendorMappingAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( NNMi_Vendor___hide == null || NNMi_Vendor___hide.equals("null") ) {
%>
      <display:column property="nnmi_vendor" sortable="true" titleKey="DL_VendorMappingApplicationResources:field.nnmi_vendor.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( HPSA_Vendor___hide == null || HPSA_Vendor___hide.equals("null") ) {
%>
      <display:column property="hpsa_vendor" sortable="true" titleKey="DL_VendorMappingApplicationResources:field.hpsa_vendor.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormDL_VendorMappingAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="nnmi_vendor" value="<%= form.getNnmi_vendor() %>"/>
                <html:hidden property="nnmi_vendor___hide" value="<%= form.getNnmi_vendor___hide() %>"/>
                        <html:hidden property="hpsa_vendor" value="<%= form.getHpsa_vendor() %>"/>
                <html:hidden property="hpsa_vendor___hide" value="<%= form.getHpsa_vendor___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="nnmi_vendor" value="<%= request.getParameter(\"nnmi_vendor\") %>"/>
                <html:hidden property="nnmi_vendor___hide" value="<%= request.getParameter(\"nnmi_vendor___hide\") %>"/>
                        <html:hidden property="hpsa_vendor" value="<%= request.getParameter(\"hpsa_vendor\") %>"/>
                <html:hidden property="hpsa_vendor___hide" value="<%= request.getParameter(\"hpsa_vendor___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.DL_VendorMappingForm.submit()"/>
  </html:form>

  </body>
</html>
  
