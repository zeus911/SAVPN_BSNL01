<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors " %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table" %>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn" %>

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
Sh_InterfaceForm form = (Sh_InterfaceForm) request.getAttribute("Sh_InterfaceForm");
if(form==null) {
 form=new Sh_InterfaceForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(Sh_InterfaceConstants.DATASOURCE);
String tabName = (String) request.getParameter(Sh_InterfaceConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.Sh_InterfaceFormSearch;
var formEl = formObj.elements;
for (var i=0; i<formEl.length; i++)
{
var element = formEl[i];
if (element.type == 'submit') { continue; }
if (element.type == 'reset') { continue; }
if (element.type == 'button') { continue; }
if (element.type == 'hidden') { continue; }
if (element.type == 'text') { element.value = ''; }
if (element.type == 'textarea') { element.value = ''; }
if (element.type == 'checkbox') {  element.checked = false;  }
if (element.type == 'radio') {if(element.value == '') element.checked=true; else element.checked=false;}
if (element.type == 'select-multiple') { element.selectedIndex = -1; }
if (element.type == 'select-one') { element.selectedIndex = -1; }
}
}
  function performCommit() {
  var checkfalse=false;
                    if(document.getElementsByName("terminationpointid___hide")[0].checked) {
                            if(document.getElementsByName("name___hide")[0].checked) {
                            if(document.getElementsByName("ne_id___hide")[0].checked) {
                            if(document.getElementsByName("ec_id___hide")[0].checked) {
                            if(document.getElementsByName("state___hide")[0].checked) {
                            if(document.getElementsByName("marker___hide")[0].checked) {
                            if(document.getElementsByName("uploadstatus___hide")[0].checked) {
                            if(document.getElementsByName("dbprimarykey___hide")[0].checked) {
                                      if(document.getElementsByName("type___hide")[0].checked) {
                            if(document.getElementsByName("parentif___hide")[0].checked) {
                            if(document.getElementsByName("ipaddr___hide")[0].checked) {
                            if(document.getElementsByName("subtype___hide")[0].checked) {
                            if(document.getElementsByName("encapsulation___hide")[0].checked) {
                            if(document.getElementsByName("ifindex___hide")[0].checked) {
                            if(document.getElementsByName("activestate___hide")[0].checked) {
                            if(document.getElementsByName("usagestate___hide")[0].checked) {
                            if(document.getElementsByName("vlanid___hide")[0].checked) {
                            if(document.getElementsByName("dlci___hide")[0].checked) {
                            if(document.getElementsByName("timeslots___hide")[0].checked) {
                            if(document.getElementsByName("slotsnumber___hide")[0].checked) {
                            if(document.getElementsByName("bandwidth___hide")[0].checked) {
                            if(document.getElementsByName("lmitype___hide")[0].checked) {
                            if(document.getElementsByName("intftype___hide")[0].checked) {
                            if(document.getElementsByName("bundlekey___hide")[0].checked) {
                            if(document.getElementsByName("bundleid___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                                      }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="Sh_InterfaceApplicationResources" key="<%= Sh_InterfaceConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.Sh_InterfaceFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitSh_InterfaceAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.Sh_InterfaceFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="Sh_InterfaceApplicationResources" key="<%= Sh_InterfaceConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(Sh_InterfaceConstants.USER) == null) {
  response.sendRedirect(Sh_InterfaceConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "terminationpointid";
                                                        %>

    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function init()
    {
<%
if ( _location_ != null ) {
%>
      var elems = document.getElementsByName("<%=_location_%>");
      var elem = elems == null || elems.length == 0 ? null : elems[0];
      if (elem != null) {
        elem.focus();
      }
<%
}
%>
    }
    </script>
  </head>

  <body style="overflow:auto;" onload="init();">

<%
      String TerminationPointID = form.getTerminationpointid();
            String Name = form.getName();
            String NE_ID = form.getNe_id();
            String EC_ID = form.getEc_id();
            String State = form.getState();
            String Marker = form.getMarker();
            String UploadStatus = form.getUploadstatus();
            String DBPrimaryKey = form.getDbprimarykey();
              String Type = form.getType();
            String ParentIf = form.getParentif();
            String IPAddr = form.getIpaddr();
            String SubType = form.getSubtype();
            String Encapsulation = form.getEncapsulation();
            String ifIndex = form.getIfindex();
            String ActiveState = form.getActivestate();
            String UsageState = form.getUsagestate();
            String VlanId = form.getVlanid();
            String DLCI = form.getDlci();
          String DLCI___ = form.getDlci___();
            String Timeslots = form.getTimeslots();
            String SlotsNumber = form.getSlotsnumber();
          String SlotsNumber___ = form.getSlotsnumber___();
            String Bandwidth = form.getBandwidth();
          String Bandwidth___ = form.getBandwidth___();
            String LmiType = form.getLmitype();
            String IntfType = form.getIntftype();
            String BundleKey = form.getBundlekey();
            String BundleId = form.getBundleid();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_InterfaceApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="Sh_InterfaceApplicationResources" property="TerminationPointID"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="Name"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="NE_ID"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="EC_ID"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="State"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="DBPrimaryKey"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="__count"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="Type"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="ParentIf"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="IPAddr"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="SubType"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="Encapsulation"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="ifIndex"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="ActiveState"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="UsageState"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="VlanId"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="DLCI"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="Timeslots"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="SlotsNumber"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="Bandwidth"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="LmiType"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="IntfType"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="BundleKey"/>
        <html:errors bundle="Sh_InterfaceApplicationResources" property="BundleId"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitSh_InterfaceAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

  <html:form action="<%=searchFormAction%>" style="text-align:center;">
    <table:table>
      <table:header>
        <table:cell>
          <bean:message bundle="InventoryResources" key="hide.heading"/>
        </table:cell>

        <table:cell>
          <bean:message bundle="InventoryResources" key="name.heading"/>
        </table:cell>

        <table:cell>
          <bean:message bundle="InventoryResources" key="value.heading"/>
        </table:cell>

        <table:cell>
          <bean:message bundle="InventoryResources" key="description.heading"/>
        </table:cell>
      </table:header>      

                        <table:row>
            <table:cell>
              <center>
                <html:checkbox property="terminationpointid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.terminationpointid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="terminationpointid" size="16" value="<%= TerminationPointID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.terminationpointid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="name___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.name.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="name" size="16" value="<%= Name %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.name.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ne_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ne_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ne_id" size="16" value="<%= NE_ID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ne_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ec_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ec_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ec_id" size="16" value="<%= EC_ID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ec_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="state___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.state.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="state" size="16" value="<%= State %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.state.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="marker___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.marker.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="marker" size="16" value="<%= Marker %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.marker.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="uploadstatus___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.uploadstatus.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="uploadstatus" size="16" value="<%= UploadStatus %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.uploadstatus.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="dbprimarykey___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.dbprimarykey.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="dbprimarykey" size="16" value="<%= DBPrimaryKey %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.dbprimarykey.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="type___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.type.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="type" size="16" value="<%= Type %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.type.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="parentif___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.parentif.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="parentif" size="16" value="<%= ParentIf %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.parentif.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ipaddr___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ipaddr.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ipaddr" size="16" value="<%= IPAddr %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ipaddr.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="subtype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.subtype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="subtype" size="16" value="<%= SubType %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.subtype.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="encapsulation___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.encapsulation.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="encapsulation" size="16" value="<%= Encapsulation %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.encapsulation.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ifindex___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ifindex.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ifindex" size="16" value="<%= ifIndex %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.ifindex.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="activestate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.activestate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="activestate" size="16" value="<%= ActiveState %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.activestate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="usagestate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.usagestate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="usagestate" size="16" value="<%= UsageState %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.usagestate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="vlanid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.vlanid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="vlanid" size="16" value="<%= VlanId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.vlanid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="dlci___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.dlci.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="dlci" size="16" value="<%= DLCI %>"/>
                                  -
                  <html:text property="dlci___" size="16" value="<%= DLCI___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.dlci.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="timeslots___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.timeslots.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="timeslots" size="16" value="<%= Timeslots %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.timeslots.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="slotsnumber___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.slotsnumber.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="slotsnumber" size="16" value="<%= SlotsNumber %>"/>
                                  -
                  <html:text property="slotsnumber___" size="16" value="<%= SlotsNumber___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.slotsnumber.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="bandwidth___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bandwidth.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="bandwidth" size="16" value="<%= Bandwidth %>"/>
                                  -
                  <html:text property="bandwidth___" size="16" value="<%= Bandwidth___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bandwidth.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="lmitype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.lmitype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="lmitype" size="16" value="<%= LmiType %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.lmitype.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="intftype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.intftype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="intftype" size="16" value="<%= IntfType %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.intftype.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="bundlekey___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bundlekey.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="bundlekey" size="16" value="<%= BundleKey %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bundlekey.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="bundleid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bundleid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="bundleid" size="16" value="<%= BundleId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_InterfaceApplicationResources" key="field.bundleid.description"/>
                          </table:cell>
          </table:row>
              
  
            <table:row>
              <table:cell colspan="4" align="center">
              <br>
              </table:cell>
            </table:row>
            <table:row>
              <table:cell colspan="4" align="center">
              <input type="button" value="<bean:message bundle="InventoryResources" key="search.submit.button"/>" name="enviando" class="ButtonSubmit" onclick="performCommit();">&nbsp;
              <input type="button" value="<bean:message bundle="InventoryResources" key="search.reset.button"/>" class="ButtonReset" onclick="clearForm();">
              </table:cell>
            </table:row>
    </table:table>

  </html:form>

  </body>

</html>
