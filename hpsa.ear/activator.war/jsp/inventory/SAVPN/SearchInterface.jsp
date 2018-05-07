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
InterfaceForm form = (InterfaceForm) request.getAttribute("InterfaceForm");
if(form==null) {
 form=new InterfaceForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
                 java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
            String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
      
  
String datasource = (String) request.getParameter(InterfaceConstants.DATASOURCE);
String tabName = (String) request.getParameter(InterfaceConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.InterfaceFormSearch;
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
                            if(document.getElementsByName("type___hide")[0].checked) {
                            if(document.getElementsByName("parentif___hide")[0].checked) {
                                      if(document.getElementsByName("ipaddr___hide")[0].checked) {
                            if(document.getElementsByName("subtype___hide")[0].checked) {
                            if(document.getElementsByName("encapsulation___hide")[0].checked) {
                            if(document.getElementsByName("description___hide")[0].checked) {
                            if(document.getElementsByName("ifindex___hide")[0].checked) {
                            if(document.getElementsByName("activationstate___hide")[0].checked) {
                            if(document.getElementsByName("usagestate___hide")[0].checked) {
                            if(document.getElementsByName("vlanid___hide")[0].checked) {
                            if(document.getElementsByName("vlanmode___hide")[0].checked) {
                            if(document.getElementsByName("dlci___hide")[0].checked) {
                            if(document.getElementsByName("bundlekey___hide")[0].checked) {
                            if(document.getElementsByName("bundleid___hide")[0].checked) {
                            if(document.getElementsByName("timeslots___hide")[0].checked) {
                            if(document.getElementsByName("numberofslots___hide")[0].checked) {
                            if(document.getElementsByName("bandwidth___hide")[0].checked) {
                            if(document.getElementsByName("lmitype___hide")[0].checked) {
                            if(document.getElementsByName("intftype___hide")[0].checked) {
                                                if(document.getElementsByName("nnmi_uuid___hide")[0].checked) {
                            if(document.getElementsByName("nnmi_id___hide")[0].checked) {
                            if(document.getElementsByName("nnmi_lastupdate___hide")[0].checked) {
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
                            }
                            }
                      if(checkfalse){
    alert("<bean:message bundle="InterfaceApplicationResources" key="<%= InterfaceConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.InterfaceFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitInterfaceAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.InterfaceFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="InterfaceApplicationResources" key="<%= InterfaceConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(InterfaceConstants.USER) == null) {
  response.sendRedirect(InterfaceConstants.NULL_SESSION);
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
      String TerminationPointId = form.getTerminationpointid();
            String Name = form.getName();
            String NE_Id = form.getNe_id();
              String EC_Id = form.getEc_id();
              String State = form.getState();
            String Type = form.getType();
            String ParentIf = form.getParentif();
              String IPAddr = form.getIpaddr();
            String Subtype = form.getSubtype();
            String Encapsulation = form.getEncapsulation();
            String Description = form.getDescription();
            String IFIndex = form.getIfindex();
            String ActivationState = form.getActivationstate();
            String UsageState = form.getUsagestate();
            String VLANId = form.getVlanid();
            String VLANMode = form.getVlanmode();
            String DLCI = form.getDlci();
            String BundleKey = form.getBundlekey();
            String BundleId = form.getBundleid();
            String Timeslots = form.getTimeslots();
            String NumberOfSlots = form.getNumberofslots();
            String Bandwidth = form.getBandwidth();
            String LMIType = form.getLmitype();
            String IntfType = form.getIntftype();
                String NNMi_UUId = form.getNnmi_uuid();
            String NNMi_Id = form.getNnmi_id();
            String NNMi_LastUpdate = form.getNnmi_lastupdate();
          String NNMi_LastUpdate___ = form.getNnmi_lastupdate___();
        
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="InterfaceApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="InterfaceApplicationResources" property="TerminationPointId"/>
        <html:errors bundle="InterfaceApplicationResources" property="Name"/>
        <html:errors bundle="InterfaceApplicationResources" property="NE_Id"/>
          <html:errors bundle="InterfaceApplicationResources" property="EC_Id"/>
          <html:errors bundle="InterfaceApplicationResources" property="State"/>
        <html:errors bundle="InterfaceApplicationResources" property="Type"/>
        <html:errors bundle="InterfaceApplicationResources" property="ParentIf"/>
          <html:errors bundle="InterfaceApplicationResources" property="IPAddr"/>
        <html:errors bundle="InterfaceApplicationResources" property="Subtype"/>
        <html:errors bundle="InterfaceApplicationResources" property="Encapsulation"/>
        <html:errors bundle="InterfaceApplicationResources" property="Description"/>
        <html:errors bundle="InterfaceApplicationResources" property="IFIndex"/>
        <html:errors bundle="InterfaceApplicationResources" property="ActivationState"/>
        <html:errors bundle="InterfaceApplicationResources" property="UsageState"/>
        <html:errors bundle="InterfaceApplicationResources" property="VLANId"/>
        <html:errors bundle="InterfaceApplicationResources" property="VLANMode"/>
        <html:errors bundle="InterfaceApplicationResources" property="DLCI"/>
        <html:errors bundle="InterfaceApplicationResources" property="BundleKey"/>
        <html:errors bundle="InterfaceApplicationResources" property="BundleId"/>
        <html:errors bundle="InterfaceApplicationResources" property="Timeslots"/>
        <html:errors bundle="InterfaceApplicationResources" property="NumberOfSlots"/>
        <html:errors bundle="InterfaceApplicationResources" property="Bandwidth"/>
        <html:errors bundle="InterfaceApplicationResources" property="LMIType"/>
        <html:errors bundle="InterfaceApplicationResources" property="IntfType"/>
            <html:errors bundle="InterfaceApplicationResources" property="NNMi_UUId"/>
        <html:errors bundle="InterfaceApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="InterfaceApplicationResources" property="NNMi_LastUpdate"/>
        <html:errors bundle="InterfaceApplicationResources" property="__count"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitInterfaceAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
              <bean:message bundle="InterfaceApplicationResources" key="field.terminationpointid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="terminationpointid" size="16" value="<%= TerminationPointId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.terminationpointid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="name___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.name.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="name" size="16" value="<%= Name %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.name.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ne_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.ne_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ne_id" size="16" value="<%= NE_Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.ne_id.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ec_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.ec_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ec_id" size="16" value="<%= EC_Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.ec_id.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="state___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.state.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="state" size="16" value="<%= State %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.state.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="type___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.type.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="type" size="16" value="<%= Type %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.type.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="parentif___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.parentif.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="parentif" size="16" value="<%= ParentIf %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.parentif.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ipaddr___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.ipaddr.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ipaddr" size="16" value="<%= IPAddr %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.ipaddr.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="subtype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.subtype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="subtype" size="16" value="<%= Subtype %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.subtype.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="encapsulation___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.encapsulation.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="encapsulation" size="16" value="<%= Encapsulation %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.encapsulation.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="description___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.description.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="description" size="16" value="<%= Description %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.description.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ifindex___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.ifindex.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ifindex" size="16" value="<%= IFIndex %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.ifindex.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="activationstate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.activationstate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="activationstate" size="16" value="<%= ActivationState %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.activationstate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="usagestate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.usagestate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="usagestate" size="16" value="<%= UsageState %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.usagestate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="vlanid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.vlanid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="vlanid" size="16" value="<%= VLANId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.vlanid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="vlanmode___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.vlanmode.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="vlanmode" size="16" value="<%= VLANMode %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.vlanmode.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="dlci___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.dlci.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="dlci" size="16" value="<%= DLCI %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.dlci.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="bundlekey___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.bundlekey.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="bundlekey" size="16" value="<%= BundleKey %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.bundlekey.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="bundleid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.bundleid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="bundleid" size="16" value="<%= BundleId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.bundleid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="timeslots___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.timeslots.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="timeslots" size="16" value="<%= Timeslots %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.timeslots.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="numberofslots___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.numberofslots.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="numberofslots" size="16" value="<%= NumberOfSlots %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.numberofslots.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="bandwidth___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.bandwidth.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="bandwidth" size="16" value="<%= Bandwidth %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.bandwidth.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="lmitype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.lmitype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="lmitype" size="16" value="<%= LMIType %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.lmitype.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="intftype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.intftype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="intftype" size="16" value="<%= IntfType %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.intftype.description"/>
                          </table:cell>
          </table:row>
                                                            <table:row>
            <table:cell>
              <center>
                <html:checkbox property="nnmi_uuid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_uuid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="nnmi_uuid" size="16" value="<%= NNMi_UUId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_uuid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="nnmi_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="nnmi_id" size="16" value="<%= NNMi_Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="nnmi_lastupdate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_lastupdate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="nnmi_lastupdate" size="16" value="<%= NNMi_LastUpdate %>"/>
                                  -
                  <html:text property="nnmi_lastupdate___" size="16" value="<%= NNMi_LastUpdate___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_lastupdate.description"/>
              <%=sdfNNMi_LastUpdateDesc%>            </table:cell>
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
