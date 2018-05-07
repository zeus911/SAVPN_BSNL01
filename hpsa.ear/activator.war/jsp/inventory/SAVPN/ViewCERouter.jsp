<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        org.apache.struts.action.ActionErrors,
        java.text.NumberFormat,
                com.hp.ov.activator.inventory.facilities.StringFacility" %>

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

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";

String refreshTreeRimid=(String) request.getParameter("refreshTreeRimid");

String refreshTree = (String) request.getAttribute(CERouterConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="CERouterApplicationResources" key="<%= CERouterConstants.JSP_VIEW_TITLE %>"/></title>
 
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function init()
    {
<%
if ( refreshTree != null && refreshTree.equalsIgnoreCase("true") ) {
%>
      parent.document.getElementById("ifr" + "<%=refreshTreeRimid%>").contentWindow.checkRefresh();
<%
}
%>
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">
  

<%
com.hp.ov.activator.vpn.inventory.CERouter beanCERouter = (com.hp.ov.activator.vpn.inventory.CERouter) request.getAttribute(CERouterConstants.CEROUTER_BEAN);
String resourceCount = NumberFormat.getInstance().format(1);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
  String NetworkId = (String) request.getAttribute(CERouterConstants.NETWORKID_LABEL);
NetworkId= StringFacility.replaceAllByHTMLCharacter(NetworkId);
                  String NetworkElementId = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getNetworkelementid());
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getName());
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getDescription());
                      String Region = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getRegion());
                      String RegionCE = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getRegionce());
                  String Location = (String) request.getAttribute(CERouterConstants.LOCATION_LABEL);
Location= StringFacility.replaceAllByHTMLCharacter(Location);
                  String IP = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getIp());
                      String Management_IP = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getManagement_ip());
                      String ManagementInterface = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getManagementinterface());
                      boolean PWPolicyEnabled = new Boolean(beanCERouter.getPwpolicyenabled()).booleanValue();
                      String PWPolicyEnabledC = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getPwpolicyenabledc());
                  String PWPolicy = (String) request.getAttribute(CERouterConstants.PWPOLICY_LABEL);
PWPolicy= StringFacility.replaceAllByHTMLCharacter(PWPolicy);
                  boolean UsernameEnabled = new Boolean(beanCERouter.getUsernameenabled()).booleanValue();
                      String UsernameEnabledC = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getUsernameenabledc());
                      String Username = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getUsername());
                      String Password = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getPassword());
                      String EnablePassword = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getEnablepassword());
                  String Vendor = (String) request.getAttribute(CERouterConstants.VENDOR_LABEL);
Vendor= StringFacility.replaceAllByHTMLCharacter(Vendor);
              String OSVersion = (String) request.getAttribute(CERouterConstants.OSVERSION_LABEL);
OSVersion= StringFacility.replaceAllByHTMLCharacter(OSVersion);
              String ElementType = (String) request.getAttribute(CERouterConstants.ELEMENTTYPE_LABEL);
ElementType= StringFacility.replaceAllByHTMLCharacter(ElementType);
                  String SerialNumber = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getSerialnumber());
                      String Role = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getRole());
                      String AdminState = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getAdminstate());
                      String LifeCycleState = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getLifecyclestate());
                      boolean Backup = new Boolean(beanCERouter.getBackup()).booleanValue();
                      String BackupC = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getBackupc());
                  String SchPolicyName = (String) request.getAttribute(CERouterConstants.SCHPOLICYNAME_LABEL);
SchPolicyName= StringFacility.replaceAllByHTMLCharacter(SchPolicyName);
                  boolean SkipActivation = new Boolean(beanCERouter.getSkipactivation()).booleanValue();
                      String ROCommunity = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getRocommunity());
                      String RWCommunity = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getRwcommunity());
                      String Managed = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getManaged());
                      String ManagedC = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getManagedc());
                      String CE_LoopbackPool = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getCe_loopbackpool());
                      String NNMi_UUId = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getNnmi_uuid());
                      String NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getNnmi_id());
                      String NNMi_LastUpdate = (beanCERouter.getNnmi_lastupdate() == null) ? "" : beanCERouter.getNnmi_lastupdate();
NNMi_LastUpdate= StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
      java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
      String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
                      String EffectivePassword = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getEffectivepassword());
                      boolean EffectiveUsernameEnabled = new Boolean(beanCERouter.getEffectiveusernameenabled()).booleanValue();
                      String EffectiveUsername = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getEffectiveusername());
                      String EffectiveEnablePassword = StringFacility.replaceAllByHTMLCharacter(beanCERouter.getEffectiveenablepassword());
                      String __count = "" + beanCERouter.get__count();
      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanCERouter.get__count()) : "";
              if( beanCERouter.get__count()==Integer.MIN_VALUE)
  __count = "";
                boolean isDynamic = new Boolean(beanCERouter.getIsdynamic()).booleanValue();
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="CERouterApplicationResources" key="jsp.view.title"/>
</h2> 

<%

boolean UsernameEnabledPass_Username = false ;
 UsernameEnabledPass_Username = java.util.regex.Pattern.compile("^true$").matcher("" + UsernameEnabled).matches();

boolean showUsername = false;
  if (true && UsernameEnabledPass_Username ){
showUsername = true;
}


boolean CE_LoopbackPoolPass_CE_LoopbackPool = false ;
CE_LoopbackPoolPass_CE_LoopbackPool = java.util.regex.Pattern.compile("^\\S+$").matcher(CE_LoopbackPool).matches();
boolean showCE_LoopbackPool = false;
  if (true && CE_LoopbackPoolPass_CE_LoopbackPool ){
showCE_LoopbackPool = true;
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
              <bean:message bundle="CERouterApplicationResources" key="field.networkid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NetworkId != null? NetworkId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.networkid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.networkelementid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= NetworkElementId != null? NetworkElementId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.networkelementid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.name.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.description.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.regionce.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= RegionCE != null? RegionCE : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.regionce.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.location.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Location != null? Location : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.location.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.ip.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= IP != null? IP : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.ip.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.management_ip.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Management_IP != null? Management_IP : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.management_ip.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.managementinterface.alias"/>
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
                      <bean:message bundle="CERouterApplicationResources" key="field.managementinterface.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.pwpolicyenabledc.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= PWPolicyEnabledC != null? PWPolicyEnabledC : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.pwpolicyenabledc.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.pwpolicy.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= PWPolicy != null? PWPolicy : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.pwpolicy.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.usernameenabledc.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= UsernameEnabledC != null? UsernameEnabledC : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.usernameenabledc.description"/>
                                                                              </table:cell>
          </table:row>
                                                  <%if(showUsername){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.username.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Username != null? Username : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.username.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.password.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Password != null && !Password.equals("")? "**********" : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.password.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.enablepassword.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= EnablePassword != null && !EnablePassword.equals("")? "**********" : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.enablepassword.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.vendor.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Vendor != null? Vendor : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.vendor.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.osversion.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= OSVersion != null? OSVersion : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.osversion.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.elementtype.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ElementType != null? ElementType : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.elementtype.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.serialnumber.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= SerialNumber != null? SerialNumber : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.serialnumber.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.role.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("CE" ,"CE");
                                          if(Role!=null)
                     Role=(String)valueShowMap.get(Role);
              %>
              <%= Role != null? Role : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.role.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.adminstate.alias"/>
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
                      <bean:message bundle="CERouterApplicationResources" key="field.adminstate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.lifecyclestate.alias"/>
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
                      <bean:message bundle="CERouterApplicationResources" key="field.lifecyclestate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.backupc.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= BackupC != null? BackupC : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.backupc.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.schpolicyname.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= SchPolicyName != null? SchPolicyName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.schpolicyname.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                    <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.skipactivation.alias"/>
                          </table:cell>
            <table:cell>
              <%= SkipActivation %>
            </table:cell>
            <table:cell>
              <bean:message bundle="CERouterApplicationResources" key="field.skipactivation.description"/>
            </table:cell>
          </table:row>
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.rocommunity.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ROCommunity != null? ROCommunity : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.rocommunity.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.rwcommunity.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= RWCommunity != null? RWCommunity : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.rwcommunity.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.managedc.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ManagedC != null? ManagedC : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.managedc.description"/>
                                                                              </table:cell>
          </table:row>
                                                  <%if(showCE_LoopbackPool){%>         
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.ce_loopbackpool.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= CE_LoopbackPool != null? CE_LoopbackPool : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.ce_loopbackpool.description"/>
                                                                              </table:cell>
          </table:row>
                                            <%}%>               
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.nnmi_uuid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_UUId != null? NNMi_UUId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.nnmi_uuid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.nnmi_id.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_Id != null? NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.nnmi_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.nnmi_lastupdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_LastUpdate != null? NNMi_LastUpdate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="CERouterApplicationResources" key="field.nnmi_lastupdate.description"/>
                      <%=sdfNNMi_LastUpdateDesc%>                                                        </table:cell>
          </table:row>
                                                           
                                                 
                                                 
                                                 
                                                 
                                                 
                    <table:row>
            <table:cell>  
              <bean:message bundle="CERouterApplicationResources" key="field.isdynamic.alias"/>
                          </table:cell>
            <table:cell>
              <%= isDynamic %>
            </table:cell>
            <table:cell>
              <bean:message bundle="CERouterApplicationResources" key="field.isdynamic.description"/>
            </table:cell>
          </table:row>
                                              
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

  </body>
</html>
