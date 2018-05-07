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
String datasource = (String) request.getParameter(PERouterConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");

String isConfigSync = "false";
if ( request.getParameter("issync") != null ) {
	isConfigSync = request.getParameter("issync");
}
%>

<html>
  <% 
	if ("true".equals(isConfigSync))
	{
  %>
  <head>
    <title><bean:message bundle="PERouterApplicationResources" key="jsp.sync.title"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.PERouterForm.action = '/activator<%=moduleConfig%>/DeleteCommitPERouterAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.PERouterForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="PERouterApplicationResources" key="sync.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  <%
	}
	else
	{
  %>
  <head>
    <title><bean:message bundle="PERouterApplicationResources" key="<%= PERouterConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.PERouterForm.action = '/activator<%=moduleConfig%>/DeleteCommitPERouterAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.PERouterForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="PERouterApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  <% } %>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.PERouter beanPERouter = (com.hp.ov.activator.vpn.inventory.PERouter) request.getAttribute(PERouterConstants.PEROUTER_BEAN);

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

          String NetworkId = (String) request.getAttribute(PERouterConstants.NETWORKID_LABEL);
      NetworkId = StringFacility.replaceAllByHTMLCharacter(NetworkId);
      String NetworkId_key = beanPERouter.getNetworkid();
      NetworkId_key = StringFacility.replaceAllByHTMLCharacter(NetworkId_key);
          
                                  
                      String NetworkElementId = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getNetworkelementid());
                        
                                  
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getName());
                        
                                  
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getDescription());
                        
                                  
                      String Region = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getRegion());
                        
                                  
                      String RegionPE = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getRegionpe());
                        
                                  
              String Location = (String) request.getAttribute(PERouterConstants.LOCATION_LABEL);
      Location = StringFacility.replaceAllByHTMLCharacter(Location);
      String Location_key = beanPERouter.getLocation();
      Location_key = StringFacility.replaceAllByHTMLCharacter(Location_key);
          
                                  
                      String IP = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getIp());
                        
                                  
                      String Management_IP = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getManagement_ip());
                        
                                  
                      String ManagementInterface = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getManagementinterface());
                        
                                  
                      boolean PWPolicyEnabled = new Boolean(beanPERouter.getPwpolicyenabled()).booleanValue();
                  
                                  
                      String PWPolicyEnabledC = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getPwpolicyenabledc());
                        
                                  
              String PWPolicy = (String) request.getAttribute(PERouterConstants.PWPOLICY_LABEL);
      PWPolicy = StringFacility.replaceAllByHTMLCharacter(PWPolicy);
      String PWPolicy_key = beanPERouter.getPwpolicy();
      PWPolicy_key = StringFacility.replaceAllByHTMLCharacter(PWPolicy_key);
          
                                  
                      boolean UsernameEnabled = new Boolean(beanPERouter.getUsernameenabled()).booleanValue();
                  
                                  
                      String UsernameEnabledC = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getUsernameenabledc());
                        
                                  
                      String Username = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getUsername());
                        
                                  
                      String Password = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getPassword());
                        
                                  
                      String EnablePassword = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getEnablepassword());
                        
                                  
              String Vendor = (String) request.getAttribute(PERouterConstants.VENDOR_LABEL);
      Vendor = StringFacility.replaceAllByHTMLCharacter(Vendor);
      String Vendor_key = beanPERouter.getVendor();
      Vendor_key = StringFacility.replaceAllByHTMLCharacter(Vendor_key);
          
                                  
              String OSVersion = (String) request.getAttribute(PERouterConstants.OSVERSION_LABEL);
      OSVersion = StringFacility.replaceAllByHTMLCharacter(OSVersion);
      String OSVersion_key = beanPERouter.getOsversion();
      OSVersion_key = StringFacility.replaceAllByHTMLCharacter(OSVersion_key);
          
                                  
              String ElementType = (String) request.getAttribute(PERouterConstants.ELEMENTTYPE_LABEL);
      ElementType = StringFacility.replaceAllByHTMLCharacter(ElementType);
      String ElementType_key = beanPERouter.getElementtype();
      ElementType_key = StringFacility.replaceAllByHTMLCharacter(ElementType_key);
          
                                  
                      boolean BGPDiscovery = new Boolean(beanPERouter.getBgpdiscovery()).booleanValue();
                  
                                  
                      String BGPDiscoveryC = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getBgpdiscoveryc());
                        
                                  
                      String Tier = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getTier());
                        
                                  
                      String SerialNumber = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getSerialnumber());
                        
                                  
                      String Role = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getRole());
                        
                                  
                      String AdminState = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getAdminstate());
                        
                                  
                      String LifeCycleState = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getLifecyclestate());
                        
                                  
                      boolean Backup = new Boolean(beanPERouter.getBackup()).booleanValue();
                  
                                  
                      String BackupC = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getBackupc());
                        
                                  
              String SchPolicyName = (String) request.getAttribute(PERouterConstants.SCHPOLICYNAME_LABEL);
      SchPolicyName = StringFacility.replaceAllByHTMLCharacter(SchPolicyName);
      String SchPolicyName_key = beanPERouter.getSchpolicyname();
      SchPolicyName_key = StringFacility.replaceAllByHTMLCharacter(SchPolicyName_key);
          
                                  
                      boolean SkipActivation = new Boolean(beanPERouter.getSkipactivation()).booleanValue();
                  
                                  
                      String ROCommunity = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getRocommunity());
                        
                                  
                      String RWCommunity = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getRwcommunity());
                        
                                  
                      String NNMi_UUId = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getNnmi_uuid());
                        
                                  
                      String NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getNnmi_id());
                        
                                  
                      String NNMi_LastUpdate = (beanPERouter.getNnmi_lastupdate() == null) ? "" : beanPERouter.getNnmi_lastupdate();
        NNMi_LastUpdate= StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
                            java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
                                String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
                sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
                  
                                  
                      String Count = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getCount());
                        
                                  
                      String EffectivePassword = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getEffectivepassword());
                        
                                  
                      boolean EffectiveUsernameEnabled = new Boolean(beanPERouter.getEffectiveusernameenabled()).booleanValue();
                  
                                  
                      String EffectiveUsername = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getEffectiveusername());
                        
                                  
                      String EffectiveEnablePassword = StringFacility.replaceAllByHTMLCharacter(beanPERouter.getEffectiveenablepassword());
                        
                                  
                        String __count = "" + beanPERouter.get__count();
                      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanPERouter.get__count()) : "";
                          
                  if( beanPERouter.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
                      boolean isDynamic = new Boolean(beanPERouter.getIsdynamic()).booleanValue();
                  
                                  
    
%>
<h2 style="width:100%; text-align:center;">
	<% if ("true".equals(isConfigSync)) { %>
		<bean:message bundle="PERouterApplicationResources" key="jsp.sync.title"/>
	<% } else { %>
    <bean:message bundle="PERouterApplicationResources" key="jsp.delete.title"/>
	<% } %>
</h2> 

<%

boolean UsernameEnabledPass_Username = false ;
 UsernameEnabledPass_Username = java.util.regex.Pattern.compile("^true$").matcher("" + UsernameEnabled).matches();

boolean showUsername = false;
  if (true && UsernameEnabledPass_Username ){
showUsername = true;
}

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
              <bean:message bundle="PERouterApplicationResources" key="field.networkid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NetworkId != null? NetworkId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.networkid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.networkelementid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= NetworkElementId != null? NetworkElementId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.networkelementid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.name.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.description.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.regionpe.alias"/>
                          </table:cell>
            <table:cell>
                            <%= RegionPE != null? RegionPE : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.regionpe.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.location.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Location != null? Location : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.location.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.ip.alias"/>
                          </table:cell>
            <table:cell>
                            <%= IP != null? IP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.ip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.management_ip.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Management_IP != null? Management_IP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.management_ip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.managementinterface.alias"/>
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
              <bean:message bundle="PERouterApplicationResources" key="field.managementinterface.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.pwpolicyenabledc.alias"/>
                          </table:cell>
            <table:cell>
                            <%= PWPolicyEnabledC != null? PWPolicyEnabledC : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.pwpolicyenabledc.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.pwpolicy.alias"/>
                          </table:cell>
            <table:cell>
                            <%= PWPolicy != null? PWPolicy : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.pwpolicy.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.usernameenabledc.alias"/>
                          </table:cell>
            <table:cell>
                            <%= UsernameEnabledC != null? UsernameEnabledC : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.usernameenabledc.description"/>
                                                                      </table:cell>
          </table:row>
                                                   <%if(showUsername){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.username.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Username != null? Username : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.username.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                                      <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.password.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Password != null && !Password.equals("")? "**********" : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.password.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.enablepassword.alias"/>
                          </table:cell>
            <table:cell>
                            <%= EnablePassword != null && !EnablePassword.equals("")? "**********" : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.enablepassword.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.vendor.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Vendor != null? Vendor : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.vendor.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.osversion.alias"/>
                          </table:cell>
            <table:cell>
                            <%= OSVersion != null? OSVersion : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.osversion.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.elementtype.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ElementType != null? ElementType : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.elementtype.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.bgpdiscoveryc.alias"/>
                          </table:cell>
            <table:cell>
                            <%= BGPDiscoveryC != null? BGPDiscoveryC : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.bgpdiscoveryc.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.tier.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Tier != null? Tier : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.tier.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.serialnumber.alias"/>
                          </table:cell>
            <table:cell>
                            <%= SerialNumber != null? SerialNumber : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.serialnumber.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.role.alias"/>
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
              <bean:message bundle="PERouterApplicationResources" key="field.role.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.adminstate.alias"/>
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
              <bean:message bundle="PERouterApplicationResources" key="field.adminstate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.lifecyclestate.alias"/>
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
              <bean:message bundle="PERouterApplicationResources" key="field.lifecyclestate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.backupc.alias"/>
                          </table:cell>
            <table:cell>
                            <%= BackupC != null? BackupC : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.backupc.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.schpolicyname.alias"/>
                          </table:cell>
            <table:cell>
                            <%= SchPolicyName != null? SchPolicyName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.schpolicyname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                       <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.skipactivation.alias"/>
                          </table:cell>
            <table:cell>
              <%= SkipActivation %>
            </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.skipactivation.description"/>
            </table:cell>
          </table:row>
                                                                         <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.rocommunity.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ROCommunity != null? ROCommunity : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.rocommunity.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.rwcommunity.alias"/>
                          </table:cell>
            <table:cell>
                            <%= RWCommunity != null? RWCommunity : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.rwcommunity.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.nnmi_uuid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NNMi_UUId != null? NNMi_UUId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.nnmi_uuid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.nnmi_id.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NNMi_Id != null? NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.nnmi_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.nnmi_lastupdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NNMi_LastUpdate != null? NNMi_LastUpdate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.nnmi_lastupdate.description"/>
              <%=sdfNNMi_LastUpdateDesc%>                                                        </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.count.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Count != null? Count : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.count.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                                                                                                                                                                                    <table:row>
            <table:cell>  
              <bean:message bundle="PERouterApplicationResources" key="field.isdynamic.alias"/>
                          </table:cell>
            <table:cell>
              <%= isDynamic %>
            </table:cell>
            <table:cell>
              <bean:message bundle="PERouterApplicationResources" key="field.isdynamic.description"/>
            </table:cell>
          </table:row>
                                               
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitPERouterAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="networkelementid" value="<%= String.valueOf(NetworkElementId) %>"/>
				  <html:hidden property="issync" value="<%= String.valueOf(isConfigSync) %>"/>
              </html:form>
  </body>
</html>

