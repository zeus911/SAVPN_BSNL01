<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        java.lang.reflect.Method,
        com.hp.ov.activator.nnmi.dl.inventory.*,
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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(DL_LinkConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(DL_LinkConstants.DATASOURCE);
String tabName = request.getParameter(DL_LinkConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

DL_LinkForm form = (DL_LinkForm) request.getAttribute("DL_LinkForm");


String NNMi_Id___hide = null;
String Name___hide = null;
String NE1_NNMi_Id___hide = null;
String TP1_NNMi_Id___hide = null;
String NE2_NNMi_Id___hide = null;
String TP2_NNMi_Id___hide = null;
String Type___hide = null;
String NNMi_UUId___hide = null;
String NNMi_LastUpdateData___hide = null;
String StateName___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListDL_Link.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  NNMi_Id___hide = form.getNnmi_id___hide();
  Name___hide = form.getName___hide();
  NE1_NNMi_Id___hide = form.getNe1_nnmi_id___hide();
  TP1_NNMi_Id___hide = form.getTp1_nnmi_id___hide();
  NE2_NNMi_Id___hide = form.getNe2_nnmi_id___hide();
  TP2_NNMi_Id___hide = form.getTp2_nnmi_id___hide();
  Type___hide = form.getType___hide();
  NNMi_UUId___hide = form.getNnmi_uuid___hide();
  NNMi_LastUpdateData___hide = form.getNnmi_lastupdatedata___hide();
  StateName___hide = form.getStatename___hide();

  if ( NNMi_Id___hide != null )
    requestURI.append("nnmi_id___hide=" + NNMi_Id___hide);
  if ( Name___hide != null )
    requestURI.append("name___hide=" + Name___hide);
  if ( NE1_NNMi_Id___hide != null )
    requestURI.append("ne1_nnmi_id___hide=" + NE1_NNMi_Id___hide);
  if ( TP1_NNMi_Id___hide != null )
    requestURI.append("tp1_nnmi_id___hide=" + TP1_NNMi_Id___hide);
  if ( NE2_NNMi_Id___hide != null )
    requestURI.append("ne2_nnmi_id___hide=" + NE2_NNMi_Id___hide);
  if ( TP2_NNMi_Id___hide != null )
    requestURI.append("tp2_nnmi_id___hide=" + TP2_NNMi_Id___hide);
  if ( Type___hide != null )
    requestURI.append("type___hide=" + Type___hide);
  if ( NNMi_UUId___hide != null )
    requestURI.append("nnmi_uuid___hide=" + NNMi_UUId___hide);
  if ( NNMi_LastUpdateData___hide != null )
    requestURI.append("nnmi_lastupdatedata___hide=" + NNMi_LastUpdateData___hide);
  if ( StateName___hide != null )
    requestURI.append("statename___hide=" + StateName___hide);

} else {

    NNMi_Id___hide = request.getParameter("nnmi_id___hide");
    Name___hide = request.getParameter("name___hide");
    NE1_NNMi_Id___hide = request.getParameter("ne1_nnmi_id___hide");
    TP1_NNMi_Id___hide = request.getParameter("tp1_nnmi_id___hide");
    NE2_NNMi_Id___hide = request.getParameter("ne2_nnmi_id___hide");
    TP2_NNMi_Id___hide = request.getParameter("tp2_nnmi_id___hide");
    Type___hide = request.getParameter("type___hide");
    NNMi_UUId___hide = request.getParameter("nnmi_uuid___hide");
    NNMi_LastUpdateData___hide = request.getParameter("nnmi_lastupdatedata___hide");
    StateName___hide = request.getParameter("statename___hide");

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
    <title><bean:message bundle="DL_LinkApplicationResources" key="<%= DL_LinkConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_LinkApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitDL_LinkAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( NNMi_Id___hide == null || NNMi_Id___hide.equals("null") ) {
%>
      <display:column property="nnmi_id" sortable="true" titleKey="DL_LinkApplicationResources:field.nnmi_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Name___hide == null || Name___hide.equals("null") ) {
%>
      <display:column property="name" sortable="true" titleKey="DL_LinkApplicationResources:field.name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NE1_NNMi_Id___hide == null || NE1_NNMi_Id___hide.equals("null") ) {
%>
      <display:column property="ne1_nnmi_id" sortable="true" titleKey="DL_LinkApplicationResources:field.ne1_nnmi_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( TP1_NNMi_Id___hide == null || TP1_NNMi_Id___hide.equals("null") ) {
%>
      <display:column property="tp1_nnmi_id" sortable="true" titleKey="DL_LinkApplicationResources:field.tp1_nnmi_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NE2_NNMi_Id___hide == null || NE2_NNMi_Id___hide.equals("null") ) {
%>
      <display:column property="ne2_nnmi_id" sortable="true" titleKey="DL_LinkApplicationResources:field.ne2_nnmi_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( TP2_NNMi_Id___hide == null || TP2_NNMi_Id___hide.equals("null") ) {
%>
      <display:column property="tp2_nnmi_id" sortable="true" titleKey="DL_LinkApplicationResources:field.tp2_nnmi_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Type___hide == null || Type___hide.equals("null") ) {
%>
      <display:column property="type" sortable="true" titleKey="DL_LinkApplicationResources:field.type.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NNMi_UUId___hide == null || NNMi_UUId___hide.equals("null") ) {
%>
      <display:column property="nnmi_uuid" sortable="true" titleKey="DL_LinkApplicationResources:field.nnmi_uuid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NNMi_LastUpdateData___hide == null || NNMi_LastUpdateData___hide.equals("null") ) {
%>
      <display:column property="nnmi_lastupdatedata" sortable="true" titleKey="DL_LinkApplicationResources:field.nnmi_lastupdatedata.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( StateName___hide == null || StateName___hide.equals("null") ) {
%>
      <display:column property="statename" sortable="true" titleKey="DL_LinkApplicationResources:field.statename.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormDL_LinkAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="nnmi_id" value="<%= form.getNnmi_id() %>"/>
                <html:hidden property="nnmi_id___hide" value="<%= form.getNnmi_id___hide() %>"/>
                        <html:hidden property="name" value="<%= form.getName() %>"/>
                <html:hidden property="name___hide" value="<%= form.getName___hide() %>"/>
                        <html:hidden property="ne1_nnmi_id" value="<%= form.getNe1_nnmi_id() %>"/>
                <html:hidden property="ne1_nnmi_id___hide" value="<%= form.getNe1_nnmi_id___hide() %>"/>
                        <html:hidden property="tp1_nnmi_id" value="<%= form.getTp1_nnmi_id() %>"/>
                <html:hidden property="tp1_nnmi_id___hide" value="<%= form.getTp1_nnmi_id___hide() %>"/>
                        <html:hidden property="ne2_nnmi_id" value="<%= form.getNe2_nnmi_id() %>"/>
                <html:hidden property="ne2_nnmi_id___hide" value="<%= form.getNe2_nnmi_id___hide() %>"/>
                        <html:hidden property="tp2_nnmi_id" value="<%= form.getTp2_nnmi_id() %>"/>
                <html:hidden property="tp2_nnmi_id___hide" value="<%= form.getTp2_nnmi_id___hide() %>"/>
                        <html:hidden property="type" value="<%= form.getType() %>"/>
                <html:hidden property="type___hide" value="<%= form.getType___hide() %>"/>
                        <html:hidden property="nnmi_uuid" value="<%= form.getNnmi_uuid() %>"/>
                <html:hidden property="nnmi_uuid___hide" value="<%= form.getNnmi_uuid___hide() %>"/>
                        <html:hidden property="nnmi_lastupdatedata" value="<%= form.getNnmi_lastupdatedata() %>"/>
                  <html:hidden property="nnmi_lastupdatedata___" value="<%= form.getNnmi_lastupdatedata___() %>"/>
                <html:hidden property="nnmi_lastupdatedata___hide" value="<%= form.getNnmi_lastupdatedata___hide() %>"/>
                        <html:hidden property="statename" value="<%= form.getStatename() %>"/>
                <html:hidden property="statename___hide" value="<%= form.getStatename___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="nnmi_id" value="<%= request.getParameter(\"nnmi_id\") %>"/>
                <html:hidden property="nnmi_id___hide" value="<%= request.getParameter(\"nnmi_id___hide\") %>"/>
                        <html:hidden property="name" value="<%= request.getParameter(\"name\") %>"/>
                <html:hidden property="name___hide" value="<%= request.getParameter(\"name___hide\") %>"/>
                        <html:hidden property="ne1_nnmi_id" value="<%= request.getParameter(\"ne1_nnmi_id\") %>"/>
                <html:hidden property="ne1_nnmi_id___hide" value="<%= request.getParameter(\"ne1_nnmi_id___hide\") %>"/>
                        <html:hidden property="tp1_nnmi_id" value="<%= request.getParameter(\"tp1_nnmi_id\") %>"/>
                <html:hidden property="tp1_nnmi_id___hide" value="<%= request.getParameter(\"tp1_nnmi_id___hide\") %>"/>
                        <html:hidden property="ne2_nnmi_id" value="<%= request.getParameter(\"ne2_nnmi_id\") %>"/>
                <html:hidden property="ne2_nnmi_id___hide" value="<%= request.getParameter(\"ne2_nnmi_id___hide\") %>"/>
                        <html:hidden property="tp2_nnmi_id" value="<%= request.getParameter(\"tp2_nnmi_id\") %>"/>
                <html:hidden property="tp2_nnmi_id___hide" value="<%= request.getParameter(\"tp2_nnmi_id___hide\") %>"/>
                        <html:hidden property="type" value="<%= request.getParameter(\"type\") %>"/>
                <html:hidden property="type___hide" value="<%= request.getParameter(\"type___hide\") %>"/>
                        <html:hidden property="nnmi_uuid" value="<%= request.getParameter(\"nnmi_uuid\") %>"/>
                <html:hidden property="nnmi_uuid___hide" value="<%= request.getParameter(\"nnmi_uuid___hide\") %>"/>
                        <html:hidden property="nnmi_lastupdatedata" value="<%= request.getParameter(\"nnmi_lastupdatedata\") %>"/>
                  <html:hidden property="nnmi_lastupdatedata___" value="<%= request.getParameter(\"nnmi_lastupdatedata___\") %>"/>
                <html:hidden property="nnmi_lastupdatedata___hide" value="<%= request.getParameter(\"nnmi_lastupdatedata___hide\") %>"/>
                        <html:hidden property="statename" value="<%= request.getParameter(\"statename\") %>"/>
                <html:hidden property="statename___hide" value="<%= request.getParameter(\"statename___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.DL_LinkForm.submit()"/>
  </html:form>

  </body>
</html>
  
