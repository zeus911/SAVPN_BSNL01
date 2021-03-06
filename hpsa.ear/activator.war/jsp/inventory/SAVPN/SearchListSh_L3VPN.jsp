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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(Sh_L3VPNConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(Sh_L3VPNConstants.DATASOURCE);
String tabName = request.getParameter(Sh_L3VPNConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

Sh_L3VPNForm form = (Sh_L3VPNForm) request.getAttribute("Sh_L3VPNForm");


String ServiceId___hide = null;
String CustomerId___hide = null;
String ServiceName___hide = null;
String InitiationDate___hide = null;
String ActivationDate___hide = null;
String ModificationDate___hide = null;
String State___hide = null;
String Type___hide = null;
String ContactPerson___hide = null;
String Comments___hide = null;
String Marker___hide = null;
String UploadStatus___hide = null;
String DBPrimaryKey___hide = null;
String VPNTopologyType___hide = null;
String QoSProfile_PE___hide = null;
String QoSProfile_CE___hide = null;
String ParentId___hide = null;
String Multicast___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListSh_L3VPN.jsp?");
requestURI.append("datasource=" + datasource);
requestURI.append("&tab_name=" + tabName);
requestURI.append("&vi=" + viParameter);
requestURI.append("&view=" + viewParameter);
requestURI.append("&ndid=" + ndidParameter);

if ( form != null ) {
  ServiceId___hide = form.getServiceid___hide();
  CustomerId___hide = form.getCustomerid___hide();
  ServiceName___hide = form.getServicename___hide();
  InitiationDate___hide = form.getInitiationdate___hide();
  ActivationDate___hide = form.getActivationdate___hide();
  ModificationDate___hide = form.getModificationdate___hide();
  State___hide = form.getState___hide();
  Type___hide = form.getType___hide();
  ContactPerson___hide = form.getContactperson___hide();
  Comments___hide = form.getComments___hide();
  Marker___hide = form.getMarker___hide();
  UploadStatus___hide = form.getUploadstatus___hide();
  DBPrimaryKey___hide = form.getDbprimarykey___hide();
  VPNTopologyType___hide = form.getVpntopologytype___hide();
  QoSProfile_PE___hide = form.getQosprofile_pe___hide();
  QoSProfile_CE___hide = form.getQosprofile_ce___hide();
  ParentId___hide = form.getParentid___hide();
  Multicast___hide = form.getMulticast___hide();

  if ( ServiceId___hide != null )
    requestURI.append("serviceid___hide=" + ServiceId___hide);
  if ( CustomerId___hide != null )
    requestURI.append("customerid___hide=" + CustomerId___hide);
  if ( ServiceName___hide != null )
    requestURI.append("servicename___hide=" + ServiceName___hide);
  if ( InitiationDate___hide != null )
    requestURI.append("initiationdate___hide=" + InitiationDate___hide);
  if ( ActivationDate___hide != null )
    requestURI.append("activationdate___hide=" + ActivationDate___hide);
  if ( ModificationDate___hide != null )
    requestURI.append("modificationdate___hide=" + ModificationDate___hide);
  if ( State___hide != null )
    requestURI.append("state___hide=" + State___hide);
  if ( Type___hide != null )
    requestURI.append("type___hide=" + Type___hide);
  if ( ContactPerson___hide != null )
    requestURI.append("contactperson___hide=" + ContactPerson___hide);
  if ( Comments___hide != null )
    requestURI.append("comments___hide=" + Comments___hide);
  if ( Marker___hide != null )
    requestURI.append("marker___hide=" + Marker___hide);
  if ( UploadStatus___hide != null )
    requestURI.append("uploadstatus___hide=" + UploadStatus___hide);
  if ( DBPrimaryKey___hide != null )
    requestURI.append("dbprimarykey___hide=" + DBPrimaryKey___hide);
  if ( VPNTopologyType___hide != null )
    requestURI.append("vpntopologytype___hide=" + VPNTopologyType___hide);
  if ( QoSProfile_PE___hide != null )
    requestURI.append("qosprofile_pe___hide=" + QoSProfile_PE___hide);
  if ( QoSProfile_CE___hide != null )
    requestURI.append("qosprofile_ce___hide=" + QoSProfile_CE___hide);
  if ( ParentId___hide != null )
    requestURI.append("parentid___hide=" + ParentId___hide);
  if ( Multicast___hide != null )
    requestURI.append("multicast___hide=" + Multicast___hide);

} else {

    ServiceId___hide = request.getParameter("serviceid___hide");
    CustomerId___hide = request.getParameter("customerid___hide");
    ServiceName___hide = request.getParameter("servicename___hide");
    InitiationDate___hide = request.getParameter("initiationdate___hide");
    ActivationDate___hide = request.getParameter("activationdate___hide");
    ModificationDate___hide = request.getParameter("modificationdate___hide");
    State___hide = request.getParameter("state___hide");
    Type___hide = request.getParameter("type___hide");
    ContactPerson___hide = request.getParameter("contactperson___hide");
    Comments___hide = request.getParameter("comments___hide");
    Marker___hide = request.getParameter("marker___hide");
    UploadStatus___hide = request.getParameter("uploadstatus___hide");
    DBPrimaryKey___hide = request.getParameter("dbprimarykey___hide");
    VPNTopologyType___hide = request.getParameter("vpntopologytype___hide");
    QoSProfile_PE___hide = request.getParameter("qosprofile_pe___hide");
    QoSProfile_CE___hide = request.getParameter("qosprofile_ce___hide");
    ParentId___hide = request.getParameter("parentid___hide");
    Multicast___hide = request.getParameter("multicast___hide");

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
    <title><bean:message bundle="Sh_L3VPNApplicationResources" key="<%= Sh_L3VPNConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_L3VPNApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitSh_L3VPNAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( ServiceId___hide == null || ServiceId___hide.equals("null") ) {
%>
      <display:column property="serviceid" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.serviceid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CustomerId___hide == null || CustomerId___hide.equals("null") ) {
%>
      <display:column property="customerid" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.customerid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ServiceName___hide == null || ServiceName___hide.equals("null") ) {
%>
      <display:column property="servicename" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.servicename.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( InitiationDate___hide == null || InitiationDate___hide.equals("null") ) {
%>
      <display:column property="initiationdate" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.initiationdate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ActivationDate___hide == null || ActivationDate___hide.equals("null") ) {
%>
      <display:column property="activationdate" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.activationdate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ModificationDate___hide == null || ModificationDate___hide.equals("null") ) {
%>
      <display:column property="modificationdate" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.modificationdate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( State___hide == null || State___hide.equals("null") ) {
%>
      <display:column property="state" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.state.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Type___hide == null || Type___hide.equals("null") ) {
%>
      <display:column property="type" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.type.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ContactPerson___hide == null || ContactPerson___hide.equals("null") ) {
%>
      <display:column property="contactperson" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.contactperson.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Comments___hide == null || Comments___hide.equals("null") ) {
%>
      <display:column property="comments" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.comments.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Marker___hide == null || Marker___hide.equals("null") ) {
%>
      <display:column property="marker" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.marker.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UploadStatus___hide == null || UploadStatus___hide.equals("null") ) {
%>
      <display:column property="uploadstatus" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.uploadstatus.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( DBPrimaryKey___hide == null || DBPrimaryKey___hide.equals("null") ) {
%>
      <display:column property="dbprimarykey" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.dbprimarykey.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( VPNTopologyType___hide == null || VPNTopologyType___hide.equals("null") ) {
%>
      <display:column property="vpntopologytype" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.vpntopologytype.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( QoSProfile_PE___hide == null || QoSProfile_PE___hide.equals("null") ) {
%>
      <display:column property="qosprofile_pe" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.qosprofile_pe.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( QoSProfile_CE___hide == null || QoSProfile_CE___hide.equals("null") ) {
%>
      <display:column property="qosprofile_ce" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.qosprofile_ce.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ParentId___hide == null || ParentId___hide.equals("null") ) {
%>
      <display:column property="parentid" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.parentid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Multicast___hide == null || Multicast___hide.equals("null") ) {
%>
      <display:column property="multicast" sortable="true" titleKey="Sh_L3VPNApplicationResources:field.multicast.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormSh_L3VPNAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
%>
  <html:form action="<%= backAction %>">
<%
  if ( form != null ) {
%>
                  <html:hidden property="serviceid" value="<%= form.getServiceid() %>"/>
                <html:hidden property="serviceid___hide" value="<%= form.getServiceid___hide() %>"/>
                        <html:hidden property="customerid" value="<%= form.getCustomerid() %>"/>
                <html:hidden property="customerid___hide" value="<%= form.getCustomerid___hide() %>"/>
                        <html:hidden property="servicename" value="<%= form.getServicename() %>"/>
                <html:hidden property="servicename___hide" value="<%= form.getServicename___hide() %>"/>
                        <html:hidden property="initiationdate" value="<%= form.getInitiationdate() %>"/>
                <html:hidden property="initiationdate___hide" value="<%= form.getInitiationdate___hide() %>"/>
                        <html:hidden property="activationdate" value="<%= form.getActivationdate() %>"/>
                <html:hidden property="activationdate___hide" value="<%= form.getActivationdate___hide() %>"/>
                        <html:hidden property="modificationdate" value="<%= form.getModificationdate() %>"/>
                <html:hidden property="modificationdate___hide" value="<%= form.getModificationdate___hide() %>"/>
                        <html:hidden property="state" value="<%= form.getState() %>"/>
                <html:hidden property="state___hide" value="<%= form.getState___hide() %>"/>
                        <html:hidden property="type" value="<%= form.getType() %>"/>
                <html:hidden property="type___hide" value="<%= form.getType___hide() %>"/>
                        <html:hidden property="contactperson" value="<%= form.getContactperson() %>"/>
                <html:hidden property="contactperson___hide" value="<%= form.getContactperson___hide() %>"/>
                        <html:hidden property="comments" value="<%= form.getComments() %>"/>
                <html:hidden property="comments___hide" value="<%= form.getComments___hide() %>"/>
                        <html:hidden property="marker" value="<%= form.getMarker() %>"/>
                <html:hidden property="marker___hide" value="<%= form.getMarker___hide() %>"/>
                        <html:hidden property="uploadstatus" value="<%= form.getUploadstatus() %>"/>
                <html:hidden property="uploadstatus___hide" value="<%= form.getUploadstatus___hide() %>"/>
                        <html:hidden property="dbprimarykey" value="<%= form.getDbprimarykey() %>"/>
                <html:hidden property="dbprimarykey___hide" value="<%= form.getDbprimarykey___hide() %>"/>
                                  <html:hidden property="vpntopologytype" value="<%= form.getVpntopologytype() %>"/>
                <html:hidden property="vpntopologytype___hide" value="<%= form.getVpntopologytype___hide() %>"/>
                        <html:hidden property="qosprofile_pe" value="<%= form.getQosprofile_pe() %>"/>
                <html:hidden property="qosprofile_pe___hide" value="<%= form.getQosprofile_pe___hide() %>"/>
                        <html:hidden property="qosprofile_ce" value="<%= form.getQosprofile_ce() %>"/>
                <html:hidden property="qosprofile_ce___hide" value="<%= form.getQosprofile_ce___hide() %>"/>
                        <html:hidden property="parentid" value="<%= form.getParentid() %>"/>
                <html:hidden property="parentid___hide" value="<%= form.getParentid___hide() %>"/>
                        <html:hidden property="multicast" value="<%= form.getMulticast() %>"/>
                <html:hidden property="multicast___hide" value="<%= form.getMulticast___hide() %>"/>
          <%
}
  else {    
%>
                  <html:hidden property="serviceid" value="<%= request.getParameter(\"serviceid\") %>"/>
                <html:hidden property="serviceid___hide" value="<%= request.getParameter(\"serviceid___hide\") %>"/>
                        <html:hidden property="customerid" value="<%= request.getParameter(\"customerid\") %>"/>
                <html:hidden property="customerid___hide" value="<%= request.getParameter(\"customerid___hide\") %>"/>
                        <html:hidden property="servicename" value="<%= request.getParameter(\"servicename\") %>"/>
                <html:hidden property="servicename___hide" value="<%= request.getParameter(\"servicename___hide\") %>"/>
                        <html:hidden property="initiationdate" value="<%= request.getParameter(\"initiationdate\") %>"/>
                <html:hidden property="initiationdate___hide" value="<%= request.getParameter(\"initiationdate___hide\") %>"/>
                        <html:hidden property="activationdate" value="<%= request.getParameter(\"activationdate\") %>"/>
                <html:hidden property="activationdate___hide" value="<%= request.getParameter(\"activationdate___hide\") %>"/>
                        <html:hidden property="modificationdate" value="<%= request.getParameter(\"modificationdate\") %>"/>
                <html:hidden property="modificationdate___hide" value="<%= request.getParameter(\"modificationdate___hide\") %>"/>
                        <html:hidden property="state" value="<%= request.getParameter(\"state\") %>"/>
                <html:hidden property="state___hide" value="<%= request.getParameter(\"state___hide\") %>"/>
                        <html:hidden property="type" value="<%= request.getParameter(\"type\") %>"/>
                <html:hidden property="type___hide" value="<%= request.getParameter(\"type___hide\") %>"/>
                        <html:hidden property="contactperson" value="<%= request.getParameter(\"contactperson\") %>"/>
                <html:hidden property="contactperson___hide" value="<%= request.getParameter(\"contactperson___hide\") %>"/>
                        <html:hidden property="comments" value="<%= request.getParameter(\"comments\") %>"/>
                <html:hidden property="comments___hide" value="<%= request.getParameter(\"comments___hide\") %>"/>
                        <html:hidden property="marker" value="<%= request.getParameter(\"marker\") %>"/>
                <html:hidden property="marker___hide" value="<%= request.getParameter(\"marker___hide\") %>"/>
                        <html:hidden property="uploadstatus" value="<%= request.getParameter(\"uploadstatus\") %>"/>
                <html:hidden property="uploadstatus___hide" value="<%= request.getParameter(\"uploadstatus___hide\") %>"/>
                        <html:hidden property="dbprimarykey" value="<%= request.getParameter(\"dbprimarykey\") %>"/>
                <html:hidden property="dbprimarykey___hide" value="<%= request.getParameter(\"dbprimarykey___hide\") %>"/>
                                  <html:hidden property="vpntopologytype" value="<%= request.getParameter(\"vpntopologytype\") %>"/>
                <html:hidden property="vpntopologytype___hide" value="<%= request.getParameter(\"vpntopologytype___hide\") %>"/>
                        <html:hidden property="qosprofile_pe" value="<%= request.getParameter(\"qosprofile_pe\") %>"/>
                <html:hidden property="qosprofile_pe___hide" value="<%= request.getParameter(\"qosprofile_pe___hide\") %>"/>
                        <html:hidden property="qosprofile_ce" value="<%= request.getParameter(\"qosprofile_ce\") %>"/>
                <html:hidden property="qosprofile_ce___hide" value="<%= request.getParameter(\"qosprofile_ce___hide\") %>"/>
                        <html:hidden property="parentid" value="<%= request.getParameter(\"parentid\") %>"/>
                <html:hidden property="parentid___hide" value="<%= request.getParameter(\"parentid___hide\") %>"/>
                        <html:hidden property="multicast" value="<%= request.getParameter(\"multicast\") %>"/>
                <html:hidden property="multicast___hide" value="<%= request.getParameter(\"multicast___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.Sh_L3VPNForm.submit()"/>
  </html:form>

  </body>
</html>
  
