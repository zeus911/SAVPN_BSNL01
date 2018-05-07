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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(ElementComponentConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(ElementComponentConstants.DATASOURCE);
String tabName = request.getParameter(ElementComponentConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

ElementComponentForm form = (ElementComponentForm) request.getAttribute("ElementComponentForm");


String ElementComponentId___hide = null;
String NE_Id___hide = null;
String ParentEC_Id___hide = null;
String Name___hide = null;
String Description___hide = null;
String State___hide = null;
String ECType___hide = null;
String Type___hide = null;
String ComponentNumber___hide = null;
String Capacity___hide = null;
String NNMi_UUId___hide = null;
String NNMi_Id___hide = null;
String NNMi_LastUpdate___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListElementComponent.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  ElementComponentId___hide = form.getElementcomponentid___hide();
  NE_Id___hide = form.getNe_id___hide();
  ParentEC_Id___hide = form.getParentec_id___hide();
  Name___hide = form.getName___hide();
  Description___hide = form.getDescription___hide();
  State___hide = form.getState___hide();
  ECType___hide = form.getEctype___hide();
  Type___hide = form.getType___hide();
  ComponentNumber___hide = form.getComponentnumber___hide();
  Capacity___hide = form.getCapacity___hide();
  NNMi_UUId___hide = form.getNnmi_uuid___hide();
  NNMi_Id___hide = form.getNnmi_id___hide();
  NNMi_LastUpdate___hide = form.getNnmi_lastupdate___hide();

  if ( ElementComponentId___hide != null )
    requestURI.append("elementcomponentid___hide=" + ElementComponentId___hide);
  if ( NE_Id___hide != null )
    requestURI.append("ne_id___hide=" + NE_Id___hide);
  if ( ParentEC_Id___hide != null )
    requestURI.append("parentec_id___hide=" + ParentEC_Id___hide);
  if ( Name___hide != null )
    requestURI.append("name___hide=" + Name___hide);
  if ( Description___hide != null )
    requestURI.append("description___hide=" + Description___hide);
  if ( State___hide != null )
    requestURI.append("state___hide=" + State___hide);
  if ( ECType___hide != null )
    requestURI.append("ectype___hide=" + ECType___hide);
  if ( Type___hide != null )
    requestURI.append("type___hide=" + Type___hide);
  if ( ComponentNumber___hide != null )
    requestURI.append("componentnumber___hide=" + ComponentNumber___hide);
  if ( Capacity___hide != null )
    requestURI.append("capacity___hide=" + Capacity___hide);
  if ( NNMi_UUId___hide != null )
    requestURI.append("nnmi_uuid___hide=" + NNMi_UUId___hide);
  if ( NNMi_Id___hide != null )
    requestURI.append("nnmi_id___hide=" + NNMi_Id___hide);
  if ( NNMi_LastUpdate___hide != null )
    requestURI.append("nnmi_lastupdate___hide=" + NNMi_LastUpdate___hide);

} else {

    ElementComponentId___hide = request.getParameter("elementcomponentid___hide");
    NE_Id___hide = request.getParameter("ne_id___hide");
    ParentEC_Id___hide = request.getParameter("parentec_id___hide");
    Name___hide = request.getParameter("name___hide");
    Description___hide = request.getParameter("description___hide");
    State___hide = request.getParameter("state___hide");
    ECType___hide = request.getParameter("ectype___hide");
    Type___hide = request.getParameter("type___hide");
    ComponentNumber___hide = request.getParameter("componentnumber___hide");
    Capacity___hide = request.getParameter("capacity___hide");
    NNMi_UUId___hide = request.getParameter("nnmi_uuid___hide");
    NNMi_Id___hide = request.getParameter("nnmi_id___hide");
    NNMi_LastUpdate___hide = request.getParameter("nnmi_lastupdate___hide");

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
    <title><bean:message bundle="ElementComponentApplicationResources" key="<%= ElementComponentConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="ElementComponentApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitElementComponentAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( ElementComponentId___hide == null || ElementComponentId___hide.equals("null") ) {
%>
      <display:column property="elementcomponentid" sortable="true" titleKey="ElementComponentApplicationResources:field.elementcomponentid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NE_Id___hide == null || NE_Id___hide.equals("null") ) {
%>
      <display:column property="ne_id" sortable="true" titleKey="ElementComponentApplicationResources:field.ne_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ParentEC_Id___hide == null || ParentEC_Id___hide.equals("null") ) {
%>
      <display:column property="parentec_id" sortable="true" titleKey="ElementComponentApplicationResources:field.parentec_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Name___hide == null || Name___hide.equals("null") ) {
%>
      <display:column property="name" sortable="true" titleKey="ElementComponentApplicationResources:field.name.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Description___hide == null || Description___hide.equals("null") ) {
%>
      <display:column property="description" sortable="true" titleKey="ElementComponentApplicationResources:field.description.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( State___hide == null || State___hide.equals("null") ) {
%>
      <display:column property="state" sortable="true" titleKey="ElementComponentApplicationResources:field.state.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ECType___hide == null || ECType___hide.equals("null") ) {
%>
      <display:column property="ectype" sortable="true" titleKey="ElementComponentApplicationResources:field.ectype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Type___hide == null || Type___hide.equals("null") ) {
%>
      <display:column property="type" sortable="true" titleKey="ElementComponentApplicationResources:field.type.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ComponentNumber___hide == null || ComponentNumber___hide.equals("null") ) {
%>
      <display:column property="componentnumber" sortable="true" titleKey="ElementComponentApplicationResources:field.componentnumber.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Capacity___hide == null || Capacity___hide.equals("null") ) {
%>
      <display:column property="capacity" sortable="true" titleKey="ElementComponentApplicationResources:field.capacity.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NNMi_UUId___hide == null || NNMi_UUId___hide.equals("null") ) {
%>
      <display:column property="nnmi_uuid" sortable="true" titleKey="ElementComponentApplicationResources:field.nnmi_uuid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NNMi_Id___hide == null || NNMi_Id___hide.equals("null") ) {
%>
      <display:column property="nnmi_id" sortable="true" titleKey="ElementComponentApplicationResources:field.nnmi_id.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( NNMi_LastUpdate___hide == null || NNMi_LastUpdate___hide.equals("null") ) {
%>
      <display:column property="nnmi_lastupdate" sortable="true" titleKey="ElementComponentApplicationResources:field.nnmi_lastupdate.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormElementComponentAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="elementcomponentid" value="<%= form.getElementcomponentid() %>"/>
                <html:hidden property="elementcomponentid___hide" value="<%= form.getElementcomponentid___hide() %>"/>
                        <html:hidden property="ne_id" value="<%= form.getNe_id() %>"/>
                <html:hidden property="ne_id___hide" value="<%= form.getNe_id___hide() %>"/>
                        <html:hidden property="parentec_id" value="<%= form.getParentec_id() %>"/>
                <html:hidden property="parentec_id___hide" value="<%= form.getParentec_id___hide() %>"/>
                        <html:hidden property="name" value="<%= form.getName() %>"/>
                <html:hidden property="name___hide" value="<%= form.getName___hide() %>"/>
                        <html:hidden property="description" value="<%= form.getDescription() %>"/>
                <html:hidden property="description___hide" value="<%= form.getDescription___hide() %>"/>
                        <html:hidden property="state" value="<%= form.getState() %>"/>
                <html:hidden property="state___hide" value="<%= form.getState___hide() %>"/>
                        <html:hidden property="ectype" value="<%= form.getEctype() %>"/>
                <html:hidden property="ectype___hide" value="<%= form.getEctype___hide() %>"/>
                        <html:hidden property="type" value="<%= form.getType() %>"/>
                <html:hidden property="type___hide" value="<%= form.getType___hide() %>"/>
                                  <html:hidden property="componentnumber" value="<%= form.getComponentnumber() %>"/>
                <html:hidden property="componentnumber___hide" value="<%= form.getComponentnumber___hide() %>"/>
                        <html:hidden property="capacity" value="<%= form.getCapacity() %>"/>
                  <html:hidden property="capacity___" value="<%= form.getCapacity___() %>"/>
                <html:hidden property="capacity___hide" value="<%= form.getCapacity___hide() %>"/>
                        <html:hidden property="nnmi_uuid" value="<%= form.getNnmi_uuid() %>"/>
                <html:hidden property="nnmi_uuid___hide" value="<%= form.getNnmi_uuid___hide() %>"/>
                        <html:hidden property="nnmi_id" value="<%= form.getNnmi_id() %>"/>
                <html:hidden property="nnmi_id___hide" value="<%= form.getNnmi_id___hide() %>"/>
                        <html:hidden property="nnmi_lastupdate" value="<%= form.getNnmi_lastupdate() %>"/>
                  <html:hidden property="nnmi_lastupdate___" value="<%= form.getNnmi_lastupdate___() %>"/>
                <html:hidden property="nnmi_lastupdate___hide" value="<%= form.getNnmi_lastupdate___hide() %>"/>
                    <%
}
  else {    
%>
                  <html:hidden property="elementcomponentid" value="<%= request.getParameter(\"elementcomponentid\") %>"/>
                <html:hidden property="elementcomponentid___hide" value="<%= request.getParameter(\"elementcomponentid___hide\") %>"/>
                        <html:hidden property="ne_id" value="<%= request.getParameter(\"ne_id\") %>"/>
                <html:hidden property="ne_id___hide" value="<%= request.getParameter(\"ne_id___hide\") %>"/>
                        <html:hidden property="parentec_id" value="<%= request.getParameter(\"parentec_id\") %>"/>
                <html:hidden property="parentec_id___hide" value="<%= request.getParameter(\"parentec_id___hide\") %>"/>
                        <html:hidden property="name" value="<%= request.getParameter(\"name\") %>"/>
                <html:hidden property="name___hide" value="<%= request.getParameter(\"name___hide\") %>"/>
                        <html:hidden property="description" value="<%= request.getParameter(\"description\") %>"/>
                <html:hidden property="description___hide" value="<%= request.getParameter(\"description___hide\") %>"/>
                        <html:hidden property="state" value="<%= request.getParameter(\"state\") %>"/>
                <html:hidden property="state___hide" value="<%= request.getParameter(\"state___hide\") %>"/>
                        <html:hidden property="ectype" value="<%= request.getParameter(\"ectype\") %>"/>
                <html:hidden property="ectype___hide" value="<%= request.getParameter(\"ectype___hide\") %>"/>
                        <html:hidden property="type" value="<%= request.getParameter(\"type\") %>"/>
                <html:hidden property="type___hide" value="<%= request.getParameter(\"type___hide\") %>"/>
                                  <html:hidden property="componentnumber" value="<%= request.getParameter(\"componentnumber\") %>"/>
                <html:hidden property="componentnumber___hide" value="<%= request.getParameter(\"componentnumber___hide\") %>"/>
                        <html:hidden property="capacity" value="<%= request.getParameter(\"capacity\") %>"/>
                  <html:hidden property="capacity___" value="<%= request.getParameter(\"capacity___\") %>"/>
                <html:hidden property="capacity___hide" value="<%= request.getParameter(\"capacity___hide\") %>"/>
                        <html:hidden property="nnmi_uuid" value="<%= request.getParameter(\"nnmi_uuid\") %>"/>
                <html:hidden property="nnmi_uuid___hide" value="<%= request.getParameter(\"nnmi_uuid___hide\") %>"/>
                        <html:hidden property="nnmi_id" value="<%= request.getParameter(\"nnmi_id\") %>"/>
                <html:hidden property="nnmi_id___hide" value="<%= request.getParameter(\"nnmi_id___hide\") %>"/>
                        <html:hidden property="nnmi_lastupdate" value="<%= request.getParameter(\"nnmi_lastupdate\") %>"/>
                  <html:hidden property="nnmi_lastupdate___" value="<%= request.getParameter(\"nnmi_lastupdate___\") %>"/>
                <html:hidden property="nnmi_lastupdate___hide" value="<%= request.getParameter(\"nnmi_lastupdate___hide\") %>"/>
                    <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.ElementComponentForm.submit()"/>
  </html:form>

  </body>
</html>
  
