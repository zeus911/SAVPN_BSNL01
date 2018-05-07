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
Sh_CERouterForm form = (Sh_CERouterForm) request.getAttribute("Sh_CERouterForm");
if(form==null) {
 form=new Sh_CERouterForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(Sh_CERouterConstants.DATASOURCE);
String tabName = (String) request.getParameter(Sh_CERouterConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.Sh_CERouterFormSearch;
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
                    if(document.getElementsByName("networkelementid___hide")[0].checked) {
                            if(document.getElementsByName("networkid___hide")[0].checked) {
                            if(document.getElementsByName("name___hide")[0].checked) {
                            if(document.getElementsByName("description___hide")[0].checked) {
                            if(document.getElementsByName("location___hide")[0].checked) {
                            if(document.getElementsByName("ip___hide")[0].checked) {
                            if(document.getElementsByName("management_ip___hide")[0].checked) {
                            if(document.getElementsByName("managementinterface___hide")[0].checked) {
                            if(document.getElementsByName("usernameenabled___hide")[0].checked) {
                            if(document.getElementsByName("username___hide")[0].checked) {
                                                if(document.getElementsByName("vendor___hide")[0].checked) {
                            if(document.getElementsByName("osversion___hide")[0].checked) {
                            if(document.getElementsByName("elementtype___hide")[0].checked) {
                            if(document.getElementsByName("serialnumber___hide")[0].checked) {
                            if(document.getElementsByName("role___hide")[0].checked) {
                            if(document.getElementsByName("state___hide")[0].checked) {
                            if(document.getElementsByName("lifecyclestate___hide")[0].checked) {
                            if(document.getElementsByName("backup___hide")[0].checked) {
                            if(document.getElementsByName("schpolicyname___hide")[0].checked) {
                            if(document.getElementsByName("rocommunity___hide")[0].checked) {
                            if(document.getElementsByName("rwcommunity___hide")[0].checked) {
                            if(document.getElementsByName("managed___hide")[0].checked) {
                            if(document.getElementsByName("present___hide")[0].checked) {
                            if(document.getElementsByName("marker___hide")[0].checked) {
                            if(document.getElementsByName("uploadstatus___hide")[0].checked) {
                            if(document.getElementsByName("dbprimarykey___hide")[0].checked) {
                                      if(document.getElementsByName("ce_loopbackpool___hide")[0].checked) {
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
    alert("<bean:message bundle="Sh_CERouterApplicationResources" key="<%= Sh_CERouterConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.Sh_CERouterFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitSh_CERouterAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.Sh_CERouterFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="Sh_CERouterApplicationResources" key="<%= Sh_CERouterConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(Sh_CERouterConstants.USER) == null) {
  response.sendRedirect(Sh_CERouterConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "networkelementid";
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
      String NetworkElementID = form.getNetworkelementid();
            String NetworkID = form.getNetworkid();
            String Name = form.getName();
            String Description = form.getDescription();
            String Location = form.getLocation();
            String IP = form.getIp();
            String management_IP = form.getManagement_ip();
            String ManagementInterface = form.getManagementinterface();
            String UsernameEnabled = form.getUsernameenabled();
            String Username = form.getUsername();
                String Vendor = form.getVendor();
            String OSversion = form.getOsversion();
            String ElementType = form.getElementtype();
            String SerialNumber = form.getSerialnumber();
            String Role = form.getRole();
            String State = form.getState();
            String LifeCycleState = form.getLifecyclestate();
            String Backup = form.getBackup();
            String SchPolicyName = form.getSchpolicyname();
            String ROCommunity = form.getRocommunity();
            String RWCommunity = form.getRwcommunity();
            String Managed = form.getManaged();
            String Present = form.getPresent();
            String Marker = form.getMarker();
            String UploadStatus = form.getUploadstatus();
            String DBPrimaryKey = form.getDbprimarykey();
              String CE_LoopbackPool = form.getCe_loopbackpool();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_CERouterApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="Sh_CERouterApplicationResources" property="NetworkElementID"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="NetworkID"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="Name"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="Description"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="Location"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="IP"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="management_IP"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="ManagementInterface"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="UsernameEnabled"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="Username"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="Password"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="EnablePassword"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="Vendor"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="OSversion"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="ElementType"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="SerialNumber"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="Role"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="State"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="LifeCycleState"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="Backup"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="SchPolicyName"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="ROCommunity"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="RWCommunity"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="Managed"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="Present"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="DBPrimaryKey"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="__count"/>
        <html:errors bundle="Sh_CERouterApplicationResources" property="CE_LoopbackPool"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitSh_CERouterAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="networkelementid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.networkelementid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="networkelementid" size="16" value="<%= NetworkElementID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.networkelementid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="networkid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.networkid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="networkid" size="16" value="<%= NetworkID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.networkid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="name___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.name.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="name" size="16" value="<%= Name %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.name.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="description___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.description.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="description" size="16" value="<%= Description %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.description.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="location___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.location.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="location" size="16" value="<%= Location %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.location.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ip___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.ip.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ip" size="16" value="<%= IP %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.ip.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="management_ip___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.management_ip.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="management_ip" size="16" value="<%= management_IP %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.management_ip.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="managementinterface___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.managementinterface.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="managementinterface" size="16" value="<%= ManagementInterface %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.managementinterface.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="usernameenabled___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.usernameenabled.alias"/>
            
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
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.usernameenabled.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="username___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.username.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="username" size="16" value="<%= Username %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.username.description"/>
                          </table:cell>
          </table:row>
                                                            <table:row>
            <table:cell>
              <center>
                <html:checkbox property="vendor___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.vendor.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="vendor" size="16" value="<%= Vendor %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.vendor.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="osversion___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.osversion.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="osversion" size="16" value="<%= OSversion %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.osversion.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="elementtype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.elementtype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="elementtype" size="16" value="<%= ElementType %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.elementtype.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="serialnumber___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.serialnumber.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="serialnumber" size="16" value="<%= SerialNumber %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.serialnumber.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="role___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.role.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="role" size="16" value="<%= Role %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.role.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="state___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.state.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="state" size="16" value="<%= State %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.state.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="lifecyclestate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.lifecyclestate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="lifecyclestate" size="16" value="<%= LifeCycleState %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.lifecyclestate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="backup___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.backup.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="backup" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="backup" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="backup" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.backup.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="schpolicyname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.schpolicyname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="schpolicyname" size="16" value="<%= SchPolicyName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.schpolicyname.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="rocommunity___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.rocommunity.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="rocommunity" size="16" value="<%= ROCommunity %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.rocommunity.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="rwcommunity___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.rwcommunity.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="rwcommunity" size="16" value="<%= RWCommunity %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.rwcommunity.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="managed___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.managed.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="managed" size="16" value="<%= Managed %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.managed.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="present___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.present.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="present" size="16" value="<%= Present %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.present.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="marker___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.marker.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="marker" size="16" value="<%= Marker %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.marker.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="uploadstatus___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.uploadstatus.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="uploadstatus" size="16" value="<%= UploadStatus %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.uploadstatus.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="dbprimarykey___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.dbprimarykey.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="dbprimarykey" size="16" value="<%= DBPrimaryKey %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.dbprimarykey.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ce_loopbackpool___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.ce_loopbackpool.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ce_loopbackpool" size="16" value="<%= CE_LoopbackPool %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.ce_loopbackpool.description"/>
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
