<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.nnmi.dl.inventory.*,
        com.hp.ov.activator.inventory.CRModel.*,
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
DL_NetworkElementForm form = (DL_NetworkElementForm) request.getAttribute("DL_NetworkElementForm");
if(form==null) {
 form=new DL_NetworkElementForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
                 java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
            String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
      
  
String datasource = (String) request.getParameter(DL_NetworkElementConstants.DATASOURCE);
String tabName = (String) request.getParameter(DL_NetworkElementConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.DL_NetworkElementFormSearch;
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
                    if(document.getElementsByName("nnmi_id___hide")[0].checked) {
                            if(document.getElementsByName("network___hide")[0].checked) {
                            if(document.getElementsByName("name___hide")[0].checked) {
                            if(document.getElementsByName("description___hide")[0].checked) {
                            if(document.getElementsByName("location___hide")[0].checked) {
                            if(document.getElementsByName("ip___hide")[0].checked) {
                            if(document.getElementsByName("management_ip___hide")[0].checked) {
                            if(document.getElementsByName("managementinterface___hide")[0].checked) {
                            if(document.getElementsByName("pwpolicyenabled___hide")[0].checked) {
                            if(document.getElementsByName("pwpolicy___hide")[0].checked) {
                            if(document.getElementsByName("usernameenabled___hide")[0].checked) {
                            if(document.getElementsByName("username___hide")[0].checked) {
                                                if(document.getElementsByName("vendor___hide")[0].checked) {
                            if(document.getElementsByName("osversiongroup___hide")[0].checked) {
                            if(document.getElementsByName("osversion___hide")[0].checked) {
                            if(document.getElementsByName("elementtypegroup___hide")[0].checked) {
                            if(document.getElementsByName("elementtype___hide")[0].checked) {
                            if(document.getElementsByName("serialnumber___hide")[0].checked) {
                            if(document.getElementsByName("role___hide")[0].checked) {
                            if(document.getElementsByName("adminstate___hide")[0].checked) {
                            if(document.getElementsByName("lifecyclestate___hide")[0].checked) {
                            if(document.getElementsByName("rocommunity___hide")[0].checked) {
                            if(document.getElementsByName("rwcommunity___hide")[0].checked) {
                            if(document.getElementsByName("nnmi_uuid___hide")[0].checked) {
                            if(document.getElementsByName("nnmi_lastupdate___hide")[0].checked) {
                            if(document.getElementsByName("statename___hide")[0].checked) {
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
            if(checkfalse){
    alert("<bean:message bundle="DL_NetworkElementApplicationResources" key="<%= DL_NetworkElementConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.DL_NetworkElementFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitDL_NetworkElementAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.DL_NetworkElementFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="DL_NetworkElementApplicationResources" key="<%= DL_NetworkElementConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(DL_NetworkElementConstants.USER) == null) {
  response.sendRedirect(DL_NetworkElementConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "nnmi_id";
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
      String NNMi_Id = form.getNnmi_id();
            String Network = form.getNetwork();
            String Name = form.getName();
            String Description = form.getDescription();
            String Location = form.getLocation();
            String IP = form.getIp();
            String Management_IP = form.getManagement_ip();
            String ManagementInterface = form.getManagementinterface();
            String PWPolicyEnabled = form.getPwpolicyenabled();
            String PWPolicy = form.getPwpolicy();
            String UsernameEnabled = form.getUsernameenabled();
            String Username = form.getUsername();
                String Vendor = form.getVendor();
            String OSVersionGroup = form.getOsversiongroup();
            String OSVersion = form.getOsversion();
            String ElementTypeGroup = form.getElementtypegroup();
            String ElementType = form.getElementtype();
            String SerialNumber = form.getSerialnumber();
            String Role = form.getRole();
            String AdminState = form.getAdminstate();
            String LifeCycleState = form.getLifecyclestate();
            String ROCommunity = form.getRocommunity();
            String RWCommunity = form.getRwcommunity();
            String NNMi_UUId = form.getNnmi_uuid();
            String NNMi_LastUpdate = form.getNnmi_lastupdate();
          String NNMi_LastUpdate___ = form.getNnmi_lastupdate___();
            String StateName = form.getStatename();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_NetworkElementApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="DL_NetworkElementApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Network"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Name"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Description"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Location"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="IP"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Management_IP"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="ManagementInterface"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="PWPolicyEnabled"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="PWPolicy"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="UsernameEnabled"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Username"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Password"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="EnablePassword"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Vendor"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="OSVersionGroup"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="OSVersion"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="ElementTypeGroup"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="ElementType"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="SerialNumber"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="Role"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="AdminState"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="LifeCycleState"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="ROCommunity"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="RWCommunity"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="NNMi_UUId"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="NNMi_LastUpdate"/>
        <html:errors bundle="DL_NetworkElementApplicationResources" property="StateName"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitDL_NetworkElementAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="nnmi_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="nnmi_id" size="16" value="<%= NNMi_Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="network___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.network.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="network" size="16" value="<%= Network %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.network.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="name___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.name.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="name" size="16" value="<%= Name %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.name.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="description___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.description.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="description" size="16" value="<%= Description %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.description.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="location___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.location.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="location" size="16" value="<%= Location %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.location.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ip___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.ip.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ip" size="16" value="<%= IP %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.ip.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="management_ip___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.management_ip.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="management_ip" size="16" value="<%= Management_IP %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.management_ip.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="managementinterface___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.managementinterface.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="managementinterface" size="16" value="<%= ManagementInterface %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.managementinterface.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="pwpolicyenabled___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.pwpolicyenabled.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="pwpolicyenabled" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="pwpolicyenabled" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="pwpolicyenabled" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.pwpolicyenabled.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="pwpolicy___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.pwpolicy.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="pwpolicy" size="16" value="<%= PWPolicy %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.pwpolicy.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="usernameenabled___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.usernameenabled.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="usernameenabled" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="usernameenabled" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="usernameenabled" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.usernameenabled.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="username___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.username.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="username" size="16" value="<%= Username %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.username.description"/>
                          </table:cell>
          </table:row>
                                                            <table:row>
            <table:cell>
              <center>
                <html:checkbox property="vendor___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.vendor.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="vendor" size="16" value="<%= Vendor %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.vendor.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="osversiongroup___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.osversiongroup.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="osversiongroup" size="16" value="<%= OSVersionGroup %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.osversiongroup.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="osversion___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.osversion.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="osversion" size="16" value="<%= OSVersion %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.osversion.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="elementtypegroup___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.elementtypegroup.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="elementtypegroup" size="16" value="<%= ElementTypeGroup %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.elementtypegroup.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="elementtype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.elementtype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="elementtype" size="16" value="<%= ElementType %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.elementtype.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="serialnumber___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.serialnumber.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="serialnumber" size="16" value="<%= SerialNumber %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.serialnumber.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="role___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.role.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="role" size="16" value="<%= Role %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.role.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="adminstate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.adminstate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="adminstate" size="16" value="<%= AdminState %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.adminstate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="lifecyclestate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.lifecyclestate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="lifecyclestate" size="16" value="<%= LifeCycleState %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.lifecyclestate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="rocommunity___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.rocommunity.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="rocommunity" size="16" value="<%= ROCommunity %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.rocommunity.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="rwcommunity___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.rwcommunity.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="rwcommunity" size="16" value="<%= RWCommunity %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.rwcommunity.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="nnmi_uuid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_uuid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="nnmi_uuid" size="16" value="<%= NNMi_UUId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_uuid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="nnmi_lastupdate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_lastupdate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="nnmi_lastupdate" size="16" value="<%= NNMi_LastUpdate %>"/>
                                  -
                  <html:text property="nnmi_lastupdate___" size="16" value="<%= NNMi_LastUpdate___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_lastupdate.description"/>
              <%=sdfNNMi_LastUpdateDesc%>            </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="statename___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.statename.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="statename" size="16" value="<%= StateName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.statename.description"/>
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
