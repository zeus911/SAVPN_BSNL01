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

String refreshTree = (String) request.getAttribute(NetworkElementConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="NetworkElementApplicationResources" key="<%= NetworkElementConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.NetworkElement beanNetworkElement = (com.hp.ov.activator.vpn.inventory.NetworkElement) request.getAttribute(NetworkElementConstants.NETWORKELEMENT_BEAN);
String resourceCount = NumberFormat.getInstance().format(1);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
  String NetworkId = (String) request.getAttribute(NetworkElementConstants.NETWORKID_LABEL);
NetworkId= StringFacility.replaceAllByHTMLCharacter(NetworkId);
                  String NetworkElementId = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getNetworkelementid());
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getName());
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getDescription());
                      String Region = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getRegion());
                      String RegionNE = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getRegionne());
                  String Location = (String) request.getAttribute(NetworkElementConstants.LOCATION_LABEL);
Location= StringFacility.replaceAllByHTMLCharacter(Location);
                  String IP = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getIp());
                      String Management_IP = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getManagement_ip());
                      String ManagementInterface = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getManagementinterface());
                      boolean PWPolicyEnabled = new Boolean(beanNetworkElement.getPwpolicyenabled()).booleanValue();
                      String PWPolicyEnabledC = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getPwpolicyenabledc());
                  String PWPolicy = (String) request.getAttribute(NetworkElementConstants.PWPOLICY_LABEL);
PWPolicy= StringFacility.replaceAllByHTMLCharacter(PWPolicy);
                  boolean UsernameEnabled = new Boolean(beanNetworkElement.getUsernameenabled()).booleanValue();
                      String UsernameEnabledC = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getUsernameenabledc());
                      String Username = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getUsername());
                      String Password = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getPassword());
                      String EnablePassword = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getEnablepassword());
                  String Vendor = (String) request.getAttribute(NetworkElementConstants.VENDOR_LABEL);
Vendor= StringFacility.replaceAllByHTMLCharacter(Vendor);
              String OSVersion = (String) request.getAttribute(NetworkElementConstants.OSVERSION_LABEL);
OSVersion= StringFacility.replaceAllByHTMLCharacter(OSVersion);
              String ElementType = (String) request.getAttribute(NetworkElementConstants.ELEMENTTYPE_LABEL);
ElementType= StringFacility.replaceAllByHTMLCharacter(ElementType);
                  String SerialNumber = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getSerialnumber());
                      String Role = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getRole());
                      String AdminState = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getAdminstate());
                      String LifeCycleState = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getLifecyclestate());
                      String ROCommunity = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getRocommunity());
                      String RWCommunity = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getRwcommunity());
                      String NNMi_UUId = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getNnmi_uuid());
                      String NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getNnmi_id());
                      String NNMi_LastUpdate = (beanNetworkElement.getNnmi_lastupdate() == null) ? "" : beanNetworkElement.getNnmi_lastupdate();
NNMi_LastUpdate= StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
      java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
      String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
                      String EffectivePassword = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getEffectivepassword());
                      boolean EffectiveUsernameEnabled = new Boolean(beanNetworkElement.getEffectiveusernameenabled()).booleanValue();
                      String EffectiveUsername = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getEffectiveusername());
                      String EffectiveEnablePassword = StringFacility.replaceAllByHTMLCharacter(beanNetworkElement.getEffectiveenablepassword());
                      String __count = "" + beanNetworkElement.get__count();
      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanNetworkElement.get__count()) : "";
              if( beanNetworkElement.get__count()==Integer.MIN_VALUE)
  __count = "";
          %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="NetworkElementApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="NetworkElementApplicationResources" key="field.networkid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NetworkId != null? NetworkId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.networkid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.networkelementid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= NetworkElementId != null? NetworkElementId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.networkelementid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.name.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.description.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.regionne.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= RegionNE != null? RegionNE : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.regionne.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.location.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Location != null? Location : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.location.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.ip.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= IP != null? IP : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.ip.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.management_ip.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Management_IP != null? Management_IP : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.management_ip.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.managementinterface.alias"/>
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
                      <bean:message bundle="NetworkElementApplicationResources" key="field.managementinterface.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.pwpolicyenabledc.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= PWPolicyEnabledC != null? PWPolicyEnabledC : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.pwpolicyenabledc.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.pwpolicy.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= PWPolicy != null? PWPolicy : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.pwpolicy.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.usernameenabledc.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= UsernameEnabledC != null? UsernameEnabledC : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.usernameenabledc.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.username.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Username != null? Username : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.username.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.password.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Password != null && !Password.equals("")? "**********" : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.password.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.enablepassword.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= EnablePassword != null && !EnablePassword.equals("")? "**********" : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.enablepassword.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.vendor.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Vendor != null? Vendor : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.vendor.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.osversion.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= OSVersion != null? OSVersion : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.osversion.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.elementtype.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ElementType != null? ElementType : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.elementtype.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.serialnumber.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= SerialNumber != null? SerialNumber : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.serialnumber.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.role.alias"/>
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
                      <bean:message bundle="NetworkElementApplicationResources" key="field.role.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.adminstate.alias"/>
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
                      <bean:message bundle="NetworkElementApplicationResources" key="field.adminstate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.lifecyclestate.alias"/>
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
                      <bean:message bundle="NetworkElementApplicationResources" key="field.lifecyclestate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.rocommunity.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ROCommunity != null? ROCommunity : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.rocommunity.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.rwcommunity.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= RWCommunity != null? RWCommunity : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.rwcommunity.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.nnmi_uuid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_UUId != null? NNMi_UUId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.nnmi_uuid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.nnmi_id.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_Id != null? NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.nnmi_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.nnmi_lastupdate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_LastUpdate != null? NNMi_LastUpdate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.nnmi_lastupdate.description"/>
                      <%=sdfNNMi_LastUpdateDesc%>                                                        </table:cell>
          </table:row>
                                                           
                                                 
                                                 
                                                 
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NetworkElementApplicationResources" key="field.__count.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= __count != null? __count : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NetworkElementApplicationResources" key="field.__count.description"/>
                                            <span style='font:italic'>(initially <%=resourceCount%>).</span>                                  </table:cell>
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
