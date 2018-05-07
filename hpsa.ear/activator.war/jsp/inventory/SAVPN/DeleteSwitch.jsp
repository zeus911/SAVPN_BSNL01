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
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(SwitchConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="SwitchApplicationResources" key="<%= SwitchConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.SwitchForm.action = '/activator<%=moduleConfig%>/DeleteCommitSwitchAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.SwitchForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="SwitchApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.Switch beanSwitch = (com.hp.ov.activator.vpn.inventory.Switch) request.getAttribute(SwitchConstants.SWITCH_BEAN);

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

          String NetworkId = (String) request.getAttribute(SwitchConstants.NETWORKID_LABEL);
      NetworkId = StringFacility.replaceAllByHTMLCharacter(NetworkId);
      String NetworkId_key = beanSwitch.getNetworkid();
      NetworkId_key = StringFacility.replaceAllByHTMLCharacter(NetworkId_key);
          
                                  
                      String NetworkElementId = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getNetworkelementid());
                        
                                  
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getName());
                        
                                  
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getDescription());
                        
                                  
                      String Region = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getRegion());
                        
                                  
                      String RegionSwitch = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getRegionswitch());
                        
                                  
              String Location = (String) request.getAttribute(SwitchConstants.LOCATION_LABEL);
      Location = StringFacility.replaceAllByHTMLCharacter(Location);
      String Location_key = beanSwitch.getLocation();
      Location_key = StringFacility.replaceAllByHTMLCharacter(Location_key);
          
                                  
                      String IP = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getIp());
                        
                                  
                      String Management_IP = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getManagement_ip());
                        
                                  
                      String ManagementInterface = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getManagementinterface());
                        
                                  
                      boolean PWPolicyEnabled = new Boolean(beanSwitch.getPwpolicyenabled()).booleanValue();
                  
                                  
                      String PWPolicyEnabledC = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getPwpolicyenabledc());
                        
                                  
              String PWPolicy = (String) request.getAttribute(SwitchConstants.PWPOLICY_LABEL);
      PWPolicy = StringFacility.replaceAllByHTMLCharacter(PWPolicy);
      String PWPolicy_key = beanSwitch.getPwpolicy();
      PWPolicy_key = StringFacility.replaceAllByHTMLCharacter(PWPolicy_key);
          
                                  
                      boolean UsernameEnabled = new Boolean(beanSwitch.getUsernameenabled()).booleanValue();
                  
                                  
                      String UsernameEnabledC = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getUsernameenabledc());
                        
                                  
                      String Username = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getUsername());
                        
                                  
                      String Password = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getPassword());
                        
                                  
                      String EnablePassword = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getEnablepassword());
                        
                                  
              String Vendor = (String) request.getAttribute(SwitchConstants.VENDOR_LABEL);
      Vendor = StringFacility.replaceAllByHTMLCharacter(Vendor);
      String Vendor_key = beanSwitch.getVendor();
      Vendor_key = StringFacility.replaceAllByHTMLCharacter(Vendor_key);
          
                                  
              String OSVersion = (String) request.getAttribute(SwitchConstants.OSVERSION_LABEL);
      OSVersion = StringFacility.replaceAllByHTMLCharacter(OSVersion);
      String OSVersion_key = beanSwitch.getOsversion();
      OSVersion_key = StringFacility.replaceAllByHTMLCharacter(OSVersion_key);
          
                                  
              String ElementType = (String) request.getAttribute(SwitchConstants.ELEMENTTYPE_LABEL);
      ElementType = StringFacility.replaceAllByHTMLCharacter(ElementType);
      String ElementType_key = beanSwitch.getElementtype();
      ElementType_key = StringFacility.replaceAllByHTMLCharacter(ElementType_key);
          
                                  
                      String SerialNumber = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getSerialnumber());
                        
                                  
                      String Role = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getRole());
                        
                                  
                      String AdminState = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getAdminstate());
                        
                                  
                      String LifeCycleState = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getLifecyclestate());
                        
                                  
                      boolean Backup = new Boolean(beanSwitch.getBackup()).booleanValue();
                  
                                  
                      String BackupC = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getBackupc());
                        
                                  
              String SchPolicyName = (String) request.getAttribute(SwitchConstants.SCHPOLICYNAME_LABEL);
      SchPolicyName = StringFacility.replaceAllByHTMLCharacter(SchPolicyName);
      String SchPolicyName_key = beanSwitch.getSchpolicyname();
      SchPolicyName_key = StringFacility.replaceAllByHTMLCharacter(SchPolicyName_key);
          
                                  
                      boolean SkipActivation = new Boolean(beanSwitch.getSkipactivation()).booleanValue();
                  
                                  
                      String ROCommunity = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getRocommunity());
                        
                                  
                      String RWCommunity = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getRwcommunity());
                        
                                  
                      String NNMi_UUId = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getNnmi_uuid());
                        
                                  
                      String NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getNnmi_id());
                        
                                  
                      String NNMi_LastUpdate = (beanSwitch.getNnmi_lastupdate() == null) ? "" : beanSwitch.getNnmi_lastupdate();
        NNMi_LastUpdate= StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
                            java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
                                String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
                sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
                  
                                  
                      String EffectivePassword = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getEffectivepassword());
                        
                                  
                      boolean EffectiveUsernameEnabled = new Boolean(beanSwitch.getEffectiveusernameenabled()).booleanValue();
                  
                                  
                      String EffectiveUsername = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getEffectiveusername());
                        
                                  
                      String EffectiveEnablePassword = StringFacility.replaceAllByHTMLCharacter(beanSwitch.getEffectiveenablepassword());
                        
                                  
                        String __count = "" + beanSwitch.get__count();
                      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSwitch.get__count()) : "";
                          
                  if( beanSwitch.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
                      boolean isDynamic = new Boolean(beanSwitch.getIsdynamic()).booleanValue();
                  
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="SwitchApplicationResources" key="jsp.delete.title"/>
</h2> 

<%
%>

    <div style="width:100%; text-align:center;">
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
      
                                      <table:row>
            <table:cell>  
              <bean:message bundle="SwitchApplicationResources" key="field.networkid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NetworkId != null? NetworkId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="SwitchApplicationResources" key="field.networkid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="SwitchApplicationResources" key="field.networkelementid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= NetworkElementId != null? NetworkElementId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="SwitchApplicationResources" key="field.networkelementid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="SwitchApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Name != null? Name : "" %>
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
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="SwitchApplicationResources" key="field.description.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="SwitchApplicationResources" key="field.regionswitch.alias"/>
                          </table:cell>
            <table:cell>
                            <%= RegionSwitch != null? RegionSwitch : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="SwitchApplicationResources" key="field.regionswitch.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="SwitchApplicationResources" key="field.location.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Location != null? Location : "" %>
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
                            <%= IP != null? IP : "" %>
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
                            <%= Management_IP != null? Management_IP : "" %>
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
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("telnet" ,"telnet");
                                            valueShowMap.put("ssh" ,"ssh");
                                          if(ManagementInterface!=null)
                     ManagementInterface=(String)valueShowMap.get(ManagementInterface);
              %>
              <%= ManagementInterface != null? ManagementInterface : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="SwitchApplicationResources" key="field.managementinterface.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="SwitchApplicationResources" key="field.pwpolicyenabledc.alias"/>
                          </table:cell>
            <table:cell>
                            <%= PWPolicyEnabledC != null? PWPolicyEnabledC : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="SwitchApplicationResources" key="field.pwpolicyenabledc.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="SwitchApplicationResources" key="field.pwpolicy.alias"/>
                          </table:cell>
            <table:cell>
                            <%= PWPolicy != null? PWPolicy : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="SwitchApplicationResources" key="field.pwpolicy.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="SwitchApplicationResources" key="field.usernameenabledc.alias"/>
                          </table:cell>
            <table:cell>
                            <%= UsernameEnabledC != null? UsernameEnabledC : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="SwitchApplicationResources" key="field.usernameenabledc.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="SwitchApplicationResources" key="field.username.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Username != null? Username : "" %>
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
                            <%= Password != null && !Password.equals("")? "**********" : "" %>
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
                            <%= EnablePassword != null && !EnablePassword.equals("")? "**********" : "" %>
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
                            <%= Vendor != null? Vendor : "" %>
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
                            <%= OSVersion != null? OSVersion : "" %>
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
                            <%= ElementType != null? ElementType : "" %>
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
                            <%= SerialNumber != null? SerialNumber : "" %>
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
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("PE" ,"PE");
                                            valueShowMap.put("CE" ,"CE");
                                            valueShowMap.put("P" ,"P");
                                            valueShowMap.put("AccessSwitch" ,"AccessSwitch");
                                            valueShowMap.put("AggregationSwitch" ,"AggregationSwitch");
                                            valueShowMap.put("ASBR" ,"ASBR");
                                          if(Role!=null)
                     Role=(String)valueShowMap.get(Role);
              %>
              <%= Role != null? Role : "" %>
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
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Up" ,"Up");
                                            valueShowMap.put("Down" ,"Down");
                                            valueShowMap.put("Unknown" ,"Unknown");
                                            valueShowMap.put("Reserved" ,"Reserved");
                                          if(AdminState!=null)
                     AdminState=(String)valueShowMap.get(AdminState);
              %>
              <%= AdminState != null? AdminState : "" %>
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
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Planned" ,"Planned");
                                            valueShowMap.put("Preconfigured" ,"Preconfigured");
                                            valueShowMap.put("Accessible" ,"Accessible");
                                            valueShowMap.put("Ready" ,"Ready");
                                          if(LifeCycleState!=null)
                     LifeCycleState=(String)valueShowMap.get(LifeCycleState);
              %>
              <%= LifeCycleState != null? LifeCycleState : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="SwitchApplicationResources" key="field.lifecyclestate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="SwitchApplicationResources" key="field.backupc.alias"/>
                          </table:cell>
            <table:cell>
                            <%= BackupC != null? BackupC : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="SwitchApplicationResources" key="field.backupc.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="SwitchApplicationResources" key="field.schpolicyname.alias"/>
                          </table:cell>
            <table:cell>
                            <%= SchPolicyName != null? SchPolicyName : "" %>
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
              <%= SkipActivation %>
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
                            <%= ROCommunity != null? ROCommunity : "" %>
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
                            <%= RWCommunity != null? RWCommunity : "" %>
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
                            <%= NNMi_UUId != null? NNMi_UUId : "" %>
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
                            <%= NNMi_Id != null? NNMi_Id : "" %>
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
                            <%= NNMi_LastUpdate != null? NNMi_LastUpdate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="SwitchApplicationResources" key="field.nnmi_lastupdate.description"/>
              <%=sdfNNMi_LastUpdateDesc%>                                                        </table:cell>
          </table:row>
                                                                                                                                                                                                                                                                                    <table:row>
            <table:cell>  
              <bean:message bundle="SwitchApplicationResources" key="field.isdynamic.alias"/>
                          </table:cell>
            <table:cell>
              <%= isDynamic %>
            </table:cell>
            <table:cell>
              <bean:message bundle="SwitchApplicationResources" key="field.isdynamic.description"/>
            </table:cell>
          </table:row>
                                               
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitSwitchAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="networkelementid" value="<%= String.valueOf(NetworkElementId) %>"/>
              </html:form>
  </body>
</html>

