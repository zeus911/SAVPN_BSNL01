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
ArrayList al = (ArrayList) session.getAttribute(request.getParameter(Sh_SiteConstants.TAB_NAME));
String useRandomColor="1";
String mainColor ="1";

String datasource = request.getParameter(Sh_SiteConstants.DATASOURCE);
String tabName = request.getParameter(Sh_SiteConstants.TAB_NAME);
String searchListName = "sessionScope." + tabName;

String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");

Sh_SiteForm form = (Sh_SiteForm) request.getAttribute("Sh_SiteForm");


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
String RemoteASN___hide = null;
String OSPF_Area___hide = null;
String SiteOfOrigin___hide = null;
String Managed___hide = null;
String Multicast___hide = null;
String PostalAddress___hide = null;

StringBuffer requestURI = new StringBuffer("/activator/jsp/inventory/SearchListSh_Site.jsp?");
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
  RemoteASN___hide = form.getRemoteasn___hide();
  OSPF_Area___hide = form.getOspf_area___hide();
  SiteOfOrigin___hide = form.getSiteoforigin___hide();
  Managed___hide = form.getManaged___hide();
  Multicast___hide = form.getMulticast___hide();
  PostalAddress___hide = form.getPostaladdress___hide();

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
  if ( RemoteASN___hide != null )
    requestURI.append("remoteasn___hide=" + RemoteASN___hide);
  if ( OSPF_Area___hide != null )
    requestURI.append("ospf_area___hide=" + OSPF_Area___hide);
  if ( SiteOfOrigin___hide != null )
    requestURI.append("siteoforigin___hide=" + SiteOfOrigin___hide);
  if ( Managed___hide != null )
    requestURI.append("managed___hide=" + Managed___hide);
  if ( Multicast___hide != null )
    requestURI.append("multicast___hide=" + Multicast___hide);
  if ( PostalAddress___hide != null )
    requestURI.append("postaladdress___hide=" + PostalAddress___hide);

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
    RemoteASN___hide = request.getParameter("remoteasn___hide");
    OSPF_Area___hide = request.getParameter("ospf_area___hide");
    SiteOfOrigin___hide = request.getParameter("siteoforigin___hide");
    Managed___hide = request.getParameter("managed___hide");
    Multicast___hide = request.getParameter("multicast___hide");
    PostalAddress___hide = request.getParameter("postaladdress___hide");

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
    <title><bean:message bundle="Sh_SiteApplicationResources" key="<%= Sh_SiteConstants.JSP_RESULTS_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>
  
  <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto; text-align:center;">

  <h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_SiteApplicationResources" key="jsp.search.results.title"/>
</h2> 

<display:table id="elementSearch" style="width:100%" requestURI="SearchCommitSh_SiteAction.do" name="<%= searchListName %>" pagesize="10" export="true" sort="list" partialList="true" size="resultSize" decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryBuilderTableDecorator">

<%
        if ( ServiceId___hide == null || ServiceId___hide.equals("null") ) {
%>
      <display:column property="serviceid" sortable="true" titleKey="Sh_SiteApplicationResources:field.serviceid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( CustomerId___hide == null || CustomerId___hide.equals("null") ) {
%>
      <display:column property="customerid" sortable="true" titleKey="Sh_SiteApplicationResources:field.customerid.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ServiceName___hide == null || ServiceName___hide.equals("null") ) {
%>
      <display:column property="servicename" sortable="true" titleKey="Sh_SiteApplicationResources:field.servicename.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( InitiationDate___hide == null || InitiationDate___hide.equals("null") ) {
%>
      <display:column property="initiationdate" sortable="true" titleKey="Sh_SiteApplicationResources:field.initiationdate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ActivationDate___hide == null || ActivationDate___hide.equals("null") ) {
%>
      <display:column property="activationdate" sortable="true" titleKey="Sh_SiteApplicationResources:field.activationdate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ModificationDate___hide == null || ModificationDate___hide.equals("null") ) {
%>
      <display:column property="modificationdate" sortable="true" titleKey="Sh_SiteApplicationResources:field.modificationdate.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( State___hide == null || State___hide.equals("null") ) {
%>
      <display:column property="state" sortable="true" titleKey="Sh_SiteApplicationResources:field.state.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Type___hide == null || Type___hide.equals("null") ) {
%>
      <display:column property="type" sortable="true" titleKey="Sh_SiteApplicationResources:field.type.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( ContactPerson___hide == null || ContactPerson___hide.equals("null") ) {
%>
      <display:column property="contactperson" sortable="true" titleKey="Sh_SiteApplicationResources:field.contactperson.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Comments___hide == null || Comments___hide.equals("null") ) {
%>
      <display:column property="comments" sortable="true" titleKey="Sh_SiteApplicationResources:field.comments.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Marker___hide == null || Marker___hide.equals("null") ) {
%>
      <display:column property="marker" sortable="true" titleKey="Sh_SiteApplicationResources:field.marker.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( UploadStatus___hide == null || UploadStatus___hide.equals("null") ) {
%>
      <display:column property="uploadstatus" sortable="true" titleKey="Sh_SiteApplicationResources:field.uploadstatus.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( DBPrimaryKey___hide == null || DBPrimaryKey___hide.equals("null") ) {
%>
      <display:column property="dbprimarykey" sortable="true" titleKey="Sh_SiteApplicationResources:field.dbprimarykey.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( RemoteASN___hide == null || RemoteASN___hide.equals("null") ) {
%>
      <display:column property="remoteasn" sortable="true" titleKey="Sh_SiteApplicationResources:field.remoteasn.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( OSPF_Area___hide == null || OSPF_Area___hide.equals("null") ) {
%>
      <display:column property="ospf_area" sortable="true" titleKey="Sh_SiteApplicationResources:field.ospf_area.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( SiteOfOrigin___hide == null || SiteOfOrigin___hide.equals("null") ) {
%>
      <display:column property="siteoforigin" sortable="true" titleKey="Sh_SiteApplicationResources:field.siteoforigin.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Managed___hide == null || Managed___hide.equals("null") ) {
%>
      <display:column property="managed" sortable="true" titleKey="Sh_SiteApplicationResources:field.managed.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( Multicast___hide == null || Multicast___hide.equals("null") ) {
%>
      <display:column property="multicast" sortable="true" titleKey="Sh_SiteApplicationResources:field.multicast.alias" headerClass="tableTitle" class="tableCell"/>
<%
        }
        if ( PostalAddress___hide == null || PostalAddress___hide.equals("null") ) {
%>
      <display:column property="postaladdress" sortable="true" titleKey="Sh_SiteApplicationResources:field.postaladdress.alias" headerClass="tableTitle" class="tableCell"/>
<%
    }
%>
</display:table>
  
<%
ResourceBundle appres = ResourceBundle.getBundle("InventoryResources", Locale.getDefault());
String backMessage = appres.getString("search.back.button");
String backAction = "SearchFormSh_SiteAction.do?datasource=" + datasource + "&tab_name=" + tabName + "&vi=" + viParameter + "&view=" + viewParameter + "&ndid=" + ndidParameter;
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
                                  <html:hidden property="remoteasn" value="<%= form.getRemoteasn() %>"/>
                <html:hidden property="remoteasn___hide" value="<%= form.getRemoteasn___hide() %>"/>
                        <html:hidden property="ospf_area" value="<%= form.getOspf_area() %>"/>
                <html:hidden property="ospf_area___hide" value="<%= form.getOspf_area___hide() %>"/>
                        <html:hidden property="siteoforigin" value="<%= form.getSiteoforigin() %>"/>
                <html:hidden property="siteoforigin___hide" value="<%= form.getSiteoforigin___hide() %>"/>
                        <html:hidden property="managed" value="<%= form.getManaged() %>"/>
                <html:hidden property="managed___hide" value="<%= form.getManaged___hide() %>"/>
                        <html:hidden property="multicast" value="<%= form.getMulticast() %>"/>
                <html:hidden property="multicast___hide" value="<%= form.getMulticast___hide() %>"/>
                        <html:hidden property="postaladdress" value="<%= form.getPostaladdress() %>"/>
                <html:hidden property="postaladdress___hide" value="<%= form.getPostaladdress___hide() %>"/>
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
                                  <html:hidden property="remoteasn" value="<%= request.getParameter(\"remoteasn\") %>"/>
                <html:hidden property="remoteasn___hide" value="<%= request.getParameter(\"remoteasn___hide\") %>"/>
                        <html:hidden property="ospf_area" value="<%= request.getParameter(\"ospf_area\") %>"/>
                <html:hidden property="ospf_area___hide" value="<%= request.getParameter(\"ospf_area___hide\") %>"/>
                        <html:hidden property="siteoforigin" value="<%= request.getParameter(\"siteoforigin\") %>"/>
                <html:hidden property="siteoforigin___hide" value="<%= request.getParameter(\"siteoforigin___hide\") %>"/>
                        <html:hidden property="managed" value="<%= request.getParameter(\"managed\") %>"/>
                <html:hidden property="managed___hide" value="<%= request.getParameter(\"managed___hide\") %>"/>
                        <html:hidden property="multicast" value="<%= request.getParameter(\"multicast\") %>"/>
                <html:hidden property="multicast___hide" value="<%= request.getParameter(\"multicast___hide\") %>"/>
                        <html:hidden property="postaladdress" value="<%= request.getParameter(\"postaladdress\") %>"/>
                <html:hidden property="postaladdress___hide" value="<%= request.getParameter(\"postaladdress___hide\") %>"/>
          <%
  }
%>
    <input type="submit" value="<%= backMessage %>" onclick="window.document.Sh_SiteForm.submit()"/>
  </html:form>

  </body>
</html>
  
