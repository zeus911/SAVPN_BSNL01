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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(DL_ElementCompTypeMappingConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(DL_ElementCompTypeMappingConstants.DATASOURCE);
String tabName = request.getParameter(DL_ElementCompTypeMappingConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

DL_ElementCompTypeMappingForm form = (DL_ElementCompTypeMappingForm) request.getAttribute("DL_ElementCompTypeMappingForm");


String Id___hide = null;
String CardType___hide = null;
String ElementCompType___hide = null;
String ElementTypeGroupName___hide = null;
String ECType___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListDL_ElementCompTypeMapping.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  Id___hide = form.getId___hide();
  CardType___hide = form.getCardtype___hide();
  ElementCompType___hide = form.getElementcomptype___hide();
  ElementTypeGroupName___hide = form.getElementtypegroupname___hide();
  ECType___hide = form.getEctype___hide();

  if ( Id___hide != null )
    requestURI.append("id___hide=" + Id___hide);
  if ( CardType___hide != null )
    requestURI.append("cardtype___hide=" + CardType___hide);
  if ( ElementCompType___hide != null )
    requestURI.append("elementcomptype___hide=" + ElementCompType___hide);
  if ( ElementTypeGroupName___hide != null )
    requestURI.append("elementtypegroupname___hide=" + ElementTypeGroupName___hide);
  if ( ECType___hide != null )
    requestURI.append("ectype___hide=" + ECType___hide);

} else {

    Id___hide = request.getParameter("id___hide");
    CardType___hide = request.getParameter("cardtype___hide");
    ElementCompType___hide = request.getParameter("elementcomptype___hide");
    ElementTypeGroupName___hide = request.getParameter("elementtypegroupname___hide");
    ECType___hide = request.getParameter("ectype___hide");

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
    <title><bean:message bundle="DL_ElementCompTypeMappingApplicationResources" key="<%= DL_ElementCompTypeMappingConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_ElementCompTypeMappingApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitDL_ElementCompTypeMappingAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( Id___hide == null || Id___hide.equals("null") ) {
%>
      <display:column property="id" sortable="true" titleKey="DL_ElementCompTypeMappingApplicationResources:field.id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CardType___hide == null || CardType___hide.equals("null") ) {
%>
      <display:column property="cardtype" sortable="true" titleKey="DL_ElementCompTypeMappingApplicationResources:field.cardtype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ElementCompType___hide == null || ElementCompType___hide.equals("null") ) {
%>
      <display:column property="elementcomptype" sortable="true" titleKey="DL_ElementCompTypeMappingApplicationResources:field.elementcomptype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ElementTypeGroupName___hide == null || ElementTypeGroupName___hide.equals("null") ) {
%>
      <display:column property="elementtypegroupname" sortable="true" titleKey="DL_ElementCompTypeMappingApplicationResources:field.elementtypegroupname.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ECType___hide == null || ECType___hide.equals("null") ) {
%>
      <display:column property="ectype" sortable="true" titleKey="DL_ElementCompTypeMappingApplicationResources:field.ectype.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormDL_ElementCompTypeMappingAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="id" value="<%= form.getId() %>"/>
                <html:hidden property="id___hide" value="<%= form.getId___hide() %>"/>
                        <html:hidden property="cardtype" value="<%= form.getCardtype() %>"/>
                <html:hidden property="cardtype___hide" value="<%= form.getCardtype___hide() %>"/>
                        <html:hidden property="elementcomptype" value="<%= form.getElementcomptype() %>"/>
                <html:hidden property="elementcomptype___hide" value="<%= form.getElementcomptype___hide() %>"/>
                        <html:hidden property="elementtypegroupname" value="<%= form.getElementtypegroupname() %>"/>
                <html:hidden property="elementtypegroupname___hide" value="<%= form.getElementtypegroupname___hide() %>"/>
                        <html:hidden property="ectype" value="<%= form.getEctype() %>"/>
                <html:hidden property="ectype___hide" value="<%= form.getEctype___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="id" value="<%= request.getParameter(\"id\") %>"/>
                <html:hidden property="id___hide" value="<%= request.getParameter(\"id___hide\") %>"/>
                        <html:hidden property="cardtype" value="<%= request.getParameter(\"cardtype\") %>"/>
                <html:hidden property="cardtype___hide" value="<%= request.getParameter(\"cardtype___hide\") %>"/>
                        <html:hidden property="elementcomptype" value="<%= request.getParameter(\"elementcomptype\") %>"/>
                <html:hidden property="elementcomptype___hide" value="<%= request.getParameter(\"elementcomptype___hide\") %>"/>
                        <html:hidden property="elementtypegroupname" value="<%= request.getParameter(\"elementtypegroupname\") %>"/>
                <html:hidden property="elementtypegroupname___hide" value="<%= request.getParameter(\"elementtypegroupname___hide\") %>"/>
                        <html:hidden property="ectype" value="<%= request.getParameter(\"ectype\") %>"/>
                <html:hidden property="ectype___hide" value="<%= request.getParameter(\"ectype___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.DL_ElementCompTypeMappingForm.submit()"/>
  </html:form>

  </body>
</html>
  
