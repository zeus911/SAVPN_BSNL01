<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors,
        com.hp.ov.activator.inventory.facilities.StringFacility " %>

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
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                                                                                   java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
            String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
              
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(SwitchConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitSwitchAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
                          _location_ = "name";
                                                                                                                                                                                                                                          }
%>

<html>
  <head>
    <title><bean:message bundle="SwitchApplicationResources" key="<%= SwitchConstants.JSP_CREATION_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
      H1 { color: red; font-size: 13px }
    </style>
    <script>
    function sendthis(focusthis)
    {
      window.document.SwitchForm.action = '/activator<%=moduleConfig%>/CreationFormSwitchAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.SwitchForm.submit();
    }
    function performCommit()
    {
      window.document.SwitchForm.action = '/activator<%=moduleConfig%>/CreationCommitSwitchAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.SwitchForm.submit();
    }
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
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
      var alertMsg = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
      alertMsg.setBounds(400, 120);
      alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
      alertMsg.show();
<%
}
%>
    }
    </script>
  </head>
  <body style="overflow:auto;" onload="init();">
<%

com.hp.ov.activator.vpn.inventory.Switch beanSwitch = (com.hp.ov.activator.vpn.inventory.Switch) request.getAttribute(SwitchConstants.SWITCH_BEAN);

      String NetworkId = beanSwitch.getNetworkid();
        String NetworkIdLabel = (String) request.getAttribute(SwitchConstants.NETWORKID_LABEL);
ArrayList NetworkIdListOfValues = (ArrayList) request.getAttribute(SwitchConstants.NETWORKID_LIST_OF_VALUES);
            String NetworkElementId = beanSwitch.getNetworkelementid();
                String Name = beanSwitch.getName();
                String Description = beanSwitch.getDescription();
                String Region = beanSwitch.getRegion();
                String RegionSwitch = beanSwitch.getRegionswitch();
                String Location = beanSwitch.getLocation();
        String LocationLabel = (String) request.getAttribute(SwitchConstants.LOCATION_LABEL);
ArrayList LocationListOfValues = (ArrayList) request.getAttribute(SwitchConstants.LOCATION_LIST_OF_VALUES);
            String IP = beanSwitch.getIp();
                String Management_IP = beanSwitch.getManagement_ip();
                String ManagementInterface = beanSwitch.getManagementinterface();
                boolean PWPolicyEnabled = new Boolean(beanSwitch.getPwpolicyenabled()).booleanValue();
                String PWPolicyEnabledC = beanSwitch.getPwpolicyenabledc();
                String PWPolicy = beanSwitch.getPwpolicy();
        String PWPolicyLabel = (String) request.getAttribute(SwitchConstants.PWPOLICY_LABEL);
ArrayList PWPolicyListOfValues = (ArrayList) request.getAttribute(SwitchConstants.PWPOLICY_LIST_OF_VALUES);
            boolean UsernameEnabled = new Boolean(beanSwitch.getUsernameenabled()).booleanValue();
                String UsernameEnabledC = beanSwitch.getUsernameenabledc();
                String Username = beanSwitch.getUsername();
                String Password = beanSwitch.getPassword();
                String EnablePassword = beanSwitch.getEnablepassword();
                String Vendor = beanSwitch.getVendor();
        String VendorLabel = (String) request.getAttribute(SwitchConstants.VENDOR_LABEL);
ArrayList VendorListOfValues = (ArrayList) request.getAttribute(SwitchConstants.VENDOR_LIST_OF_VALUES);
            String OSVersion = beanSwitch.getOsversion();
        String OSVersionLabel = (String) request.getAttribute(SwitchConstants.OSVERSION_LABEL);
ArrayList OSVersionListOfValues = (ArrayList) request.getAttribute(SwitchConstants.OSVERSION_LIST_OF_VALUES);
            String ElementType = beanSwitch.getElementtype();
        String ElementTypeLabel = (String) request.getAttribute(SwitchConstants.ELEMENTTYPE_LABEL);
ArrayList ElementTypeListOfValues = (ArrayList) request.getAttribute(SwitchConstants.ELEMENTTYPE_LIST_OF_VALUES);
            String SerialNumber = beanSwitch.getSerialnumber();
                String Role = beanSwitch.getRole();
                String AdminState = beanSwitch.getAdminstate();
                String LifeCycleState = beanSwitch.getLifecyclestate();
                boolean Backup = new Boolean(beanSwitch.getBackup()).booleanValue();
                String BackupC = beanSwitch.getBackupc();
                String SchPolicyName = beanSwitch.getSchpolicyname();
        String SchPolicyNameLabel = (String) request.getAttribute(SwitchConstants.SCHPOLICYNAME_LABEL);
ArrayList SchPolicyNameListOfValues = (ArrayList) request.getAttribute(SwitchConstants.SCHPOLICYNAME_LIST_OF_VALUES);
            boolean SkipActivation = new Boolean(beanSwitch.getSkipactivation()).booleanValue();
                String ROCommunity = beanSwitch.getRocommunity();
                String RWCommunity = beanSwitch.getRwcommunity();
                String NNMi_UUId = beanSwitch.getNnmi_uuid();
                String NNMi_Id = beanSwitch.getNnmi_id();
                String NNMi_LastUpdate = (beanSwitch.getNnmi_lastupdate() == null) ? "" : beanSwitch.getNnmi_lastupdate();
                String EffectivePassword = beanSwitch.getEffectivepassword();
                boolean EffectiveUsernameEnabled = new Boolean(beanSwitch.getEffectiveusernameenabled()).booleanValue();
                String EffectiveUsername = beanSwitch.getEffectiveusername();
                String EffectiveEnablePassword = beanSwitch.getEffectiveenablepassword();
                  boolean isDynamic = new Boolean(beanSwitch.getIsdynamic()).booleanValue();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="SwitchApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="SwitchApplicationResources" property="NetworkId"/>
        <html:errors bundle="SwitchApplicationResources" property="NetworkElementId"/>
        <html:errors bundle="SwitchApplicationResources" property="Name"/>
        <html:errors bundle="SwitchApplicationResources" property="Description"/>
        <html:errors bundle="SwitchApplicationResources" property="Region"/>
        <html:errors bundle="SwitchApplicationResources" property="RegionSwitch"/>
        <html:errors bundle="SwitchApplicationResources" property="Location"/>
        <html:errors bundle="SwitchApplicationResources" property="IP"/>
        <html:errors bundle="SwitchApplicationResources" property="Management_IP"/>
        <html:errors bundle="SwitchApplicationResources" property="ManagementInterface"/>
        <html:errors bundle="SwitchApplicationResources" property="PWPolicyEnabled"/>
        <html:errors bundle="SwitchApplicationResources" property="PWPolicyEnabledC"/>
        <html:errors bundle="SwitchApplicationResources" property="PWPolicy"/>
        <html:errors bundle="SwitchApplicationResources" property="UsernameEnabled"/>
        <html:errors bundle="SwitchApplicationResources" property="UsernameEnabledC"/>
        <html:errors bundle="SwitchApplicationResources" property="Username"/>
        <html:errors bundle="SwitchApplicationResources" property="Password"/>
        <html:errors bundle="SwitchApplicationResources" property="EnablePassword"/>
        <html:errors bundle="SwitchApplicationResources" property="Vendor"/>
        <html:errors bundle="SwitchApplicationResources" property="OSVersion"/>
        <html:errors bundle="SwitchApplicationResources" property="ElementType"/>
        <html:errors bundle="SwitchApplicationResources" property="SerialNumber"/>
        <html:errors bundle="SwitchApplicationResources" property="Role"/>
        <html:errors bundle="SwitchApplicationResources" property="AdminState"/>
        <html:errors bundle="SwitchApplicationResources" property="LifeCycleState"/>
        <html:errors bundle="SwitchApplicationResources" property="Backup"/>
        <html:errors bundle="SwitchApplicationResources" property="BackupC"/>
        <html:errors bundle="SwitchApplicationResources" property="SchPolicyName"/>
        <html:errors bundle="SwitchApplicationResources" property="SkipActivation"/>
        <html:errors bundle="SwitchApplicationResources" property="ROCommunity"/>
        <html:errors bundle="SwitchApplicationResources" property="RWCommunity"/>
        <html:errors bundle="SwitchApplicationResources" property="NNMi_UUId"/>
        <html:errors bundle="SwitchApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="SwitchApplicationResources" property="NNMi_LastUpdate"/>
        <html:errors bundle="SwitchApplicationResources" property="EffectivePassword"/>
        <html:errors bundle="SwitchApplicationResources" property="EffectiveUsernameEnabled"/>
        <html:errors bundle="SwitchApplicationResources" property="EffectiveUsername"/>
        <html:errors bundle="SwitchApplicationResources" property="EffectiveEnablePassword"/>
          <html:errors bundle="SwitchApplicationResources" property="isDynamic"/>
  </h1>
<script>
var allEvents = "";
function addListener(element,eventName,functionName){
  if(element.addEventListener){
    element.addEventListener(eventName,functionName,false);
  } else {
    element.attachEvent("on" + eventName,functionName);
  }
}
</script>
<script>
function doOnLoad()
{
  // hide field
                                                                                                                                                                                                                                                    // check hiding rules
  eval(allEvents);
}
addListener(window, "load", doOnLoad);
</script>
<html:form action="<%= formAction %>" style="text-align:center;">
    <table:table>
      <table:header>
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
      
      <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
      
                                    <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.networkid.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="networkid" value="<%= NetworkId %>"/>
                                                        <html:select disabled="true" property="networkid" value="<%= NetworkId %>" onchange="sendthis('networkid');">
                      <html:options collection="NetworkIdListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.networkid.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="networkelementid" value="<%= NetworkElementId %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.name.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.description.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="description" size="24" value="<%= Description %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.description.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="region" value="<%= Region %>"/>            
                                                                                <html:hidden property="regionswitch" value="<%= RegionSwitch %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.location.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="location" value="<%= Location %>" >
                      <html:options collection="LocationListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.location.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.ip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ip" size="24" value="<%= IP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.ip.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.management_ip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="management_ip" size="24" value="<%= Management_IP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.management_ip.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.managementinterface.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(ManagementInterface==null||ManagementInterface.trim().equals("")) {
                          selValue="telnet";
                        } else {
                          selValue=ManagementInterface.toString();
                        }    
                    %>

                    <html:select  property="managementinterface" value="<%= selValue %>" >
                                            <html:option value="telnet" >telnet</html:option>
                                            <html:option value="ssh" >ssh</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.managementinterface.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.pwpolicyenabled.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="pwpolicyenabled" value="true"/>
                  <html:hidden  property="pwpolicyenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.pwpolicyenabled.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="pwpolicyenabledc" value="<%= PWPolicyEnabledC %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.pwpolicy.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="pwpolicy" value="<%= PWPolicy %>" >
                      <html:options collection="PWPolicyListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.pwpolicy.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.usernameenabled.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="usernameenabled" value="true"/>
                  <html:hidden  property="usernameenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.usernameenabled.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="usernameenabledc" value="<%= UsernameEnabledC %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.username.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="username" size="24" value="<%= Username %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.username.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.password.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:password  property="password" size="24" value="<%= Password %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.password.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.enablepassword.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:password  property="enablepassword" size="24" value="<%= EnablePassword %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.enablepassword.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.vendor.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="vendor" value="<%= Vendor %>" onchange="sendthis('vendor');">
                      <html:options collection="VendorListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.vendor.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.osversion.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="osversion" value="<%= OSVersion %>" >
                      <html:options collection="OSVersionListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.osversion.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.elementtype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="elementtype" value="<%= ElementType %>" >
                      <html:options collection="ElementTypeListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.elementtype.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.serialnumber.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="serialnumber" size="24" value="<%= SerialNumber %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.serialnumber.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.role.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="role" value="<%= Role %>"/>
                                                        <%                        
                        String selValue=null;                                    
                        if(Role==null||Role.trim().equals("")) {
                          selValue="PE";
                        } else {
                          selValue=Role.toString();
                        }    
                    %>

                    <html:select disabled="true" property="role" value="<%= selValue %>" >
                                            <html:option value="PE" >PE</html:option>
                                            <html:option value="CE" >CE</html:option>
                                            <html:option value="P" >P</html:option>
                                            <html:option value="AccessSwitch" >AccessSwitch</html:option>
                                            <html:option value="AggregationSwitch" >AggregationSwitch</html:option>
                                            <html:option value="ASBR" >ASBR</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.role.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.adminstate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(AdminState==null||AdminState.trim().equals("")) {
                          selValue="Up";
                        } else {
                          selValue=AdminState.toString();
                        }    
                    %>

                    <html:select  property="adminstate" value="<%= selValue %>" >
                                            <html:option value="Up" >Up</html:option>
                                            <html:option value="Down" >Down</html:option>
                                            <html:option value="Unknown" >Unknown</html:option>
                                            <html:option value="Reserved" >Reserved</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.adminstate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.lifecyclestate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(LifeCycleState==null||LifeCycleState.trim().equals("")) {
                          selValue="Planned";
                        } else {
                          selValue=LifeCycleState.toString();
                        }    
                    %>

                    <html:select  property="lifecyclestate" value="<%= selValue %>" >
                                            <html:option value="Planned" >Planned</html:option>
                                            <html:option value="Preconfigured" >Preconfigured</html:option>
                                            <html:option value="Accessible" >Accessible</html:option>
                                            <html:option value="Ready" >Ready</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.lifecyclestate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.backup.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="backup" value="true"/>
                  <html:hidden  property="backup" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.backup.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="backupc" value="<%= BackupC %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.schpolicyname.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="schpolicyname" value="<%= SchPolicyName %>" >
                      <html:options collection="SchPolicyNameListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.schpolicyname.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.skipactivation.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="skipactivation" value="true"/>
                  <html:hidden  property="skipactivation" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.skipactivation.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.rocommunity.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rocommunity" size="24" value="<%= ROCommunity %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.rocommunity.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.rwcommunity.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rwcommunity" size="24" value="<%= RWCommunity %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.rwcommunity.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.nnmi_uuid.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_uuid" value="<%= NNMi_UUId %>"/>
                                                        <html:text disabled="true" property="nnmi_uuid" size="24" value="<%= NNMi_UUId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.nnmi_uuid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.nnmi_id.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_id" value="<%= NNMi_Id %>"/>
                                                        <html:text disabled="true" property="nnmi_id" size="24" value="<%= NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.nnmi_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SwitchApplicationResources" key="field.nnmi_lastupdate.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_lastupdate" value="<%= NNMi_LastUpdate %>"/>
                                                        <html:text disabled="true" property="nnmi_lastupdate" size="24" value="<%= NNMi_LastUpdate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SwitchApplicationResources" key="field.nnmi_lastupdate.description"/>
                <%=sdfNNMi_LastUpdateDesc%>              </table:cell>
            </table:row>
                                                                    <html:hidden property="effectivepassword" value="<%= EffectivePassword %>"/>            
                                                                                <input type="hidden" name="effectiveusernameenabled" value="<%= EffectiveUsernameEnabled %>"/>  
                                                                                <html:hidden property="effectiveusername" value="<%= EffectiveUsername %>"/>            
                                                                                <html:hidden property="effectiveenablepassword" value="<%= EffectiveEnablePassword %>"/>            
                                                                                              <input type="hidden" name="isdynamic" value="<%= isDynamic %>"/>  
                                          
      
      <table:row>
        <table:cell colspan="3" align="center">
        <br>
        </table:cell>
      </table:row>
      <table:row>
        <table:cell colspan="3" align="center">
          <input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
          <input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
        </table:cell>
      </table:row>
    </table:table>
  </html:form>

  </body>

</html>
