<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.nnmi.dl.inventory.*,
        com.hp.ov.activator.inventory.CRModel.*,
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
String datasource = (String) request.getParameter(DL_NetworkElementConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="DL_NetworkElementApplicationResources" key="<%= DL_NetworkElementConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.DL_NetworkElementForm.action = '/activator<%=moduleConfig%>/DeleteCommitDL_NetworkElementAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.DL_NetworkElementForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="DL_NetworkElementApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.nnmi.dl.inventory.DL_NetworkElement beanDL_NetworkElement = (com.hp.ov.activator.nnmi.dl.inventory.DL_NetworkElement) request.getAttribute(DL_NetworkElementConstants.DL_NETWORKELEMENT_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String NNMi_Id = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getNnmi_id());
                        
                                  
              String Network = (String) request.getAttribute(DL_NetworkElementConstants.NETWORK_LABEL);
      Network = StringFacility.replaceAllByHTMLCharacter(Network);
      String Network_key = beanDL_NetworkElement.getNetwork();
      Network_key = StringFacility.replaceAllByHTMLCharacter(Network_key);
          
                                  
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getName());
                        
                                  
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getDescription());
                        
                                  
                      String Location = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getLocation());
                        
                                  
                      String IP = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getIp());
                        
                                  
                      String Management_IP = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getManagement_ip());
                        
                                  
                      String ManagementInterface = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getManagementinterface());
                        
                                  
                      boolean PWPolicyEnabled = new Boolean(beanDL_NetworkElement.getPwpolicyenabled()).booleanValue();
                  
                                  
                      String PWPolicy = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getPwpolicy());
                        
                                  
                      boolean UsernameEnabled = new Boolean(beanDL_NetworkElement.getUsernameenabled()).booleanValue();
                  
                                  
                      String Username = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getUsername());
                        
                                  
                      String Password = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getPassword());
                        
                                  
                      String EnablePassword = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getEnablepassword());
                        
                                  
                      String Vendor = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getVendor());
                        
                                  
                      String OSVersionGroup = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getOsversiongroup());
                        
                                  
                      String OSVersion = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getOsversion());
                        
                                  
                      String ElementTypeGroup = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getElementtypegroup());
                        
                                  
                      String ElementType = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getElementtype());
                        
                                  
                      String SerialNumber = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getSerialnumber());
                        
                                  
                      String Role = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getRole());
                        
                                  
                      String AdminState = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getAdminstate());
                        
                                  
                      String LifeCycleState = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getLifecyclestate());
                        
                                  
                      String ROCommunity = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getRocommunity());
                        
                                  
                      String RWCommunity = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getRwcommunity());
                        
                                  
                      String NNMi_UUId = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getNnmi_uuid());
                        
                                  
                      String NNMi_LastUpdate = (beanDL_NetworkElement.getNnmi_lastupdate() == null) ? "" : beanDL_NetworkElement.getNnmi_lastupdate();
        NNMi_LastUpdate= StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
                            java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
                                String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
                sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
                  
                                  
                      String StateName = StringFacility.replaceAllByHTMLCharacter(beanDL_NetworkElement.getStatename());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="DL_NetworkElementApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= NNMi_Id != null? NNMi_Id : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.network.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Network != null? Network : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.network.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.name.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.name.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.description.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.location.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Location != null? Location : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.location.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.ip.alias"/>
                          </table:cell>
            <table:cell>
                            <%= IP != null? IP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.ip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.management_ip.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Management_IP != null? Management_IP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.management_ip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.managementinterface.alias"/>
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
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.managementinterface.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                                                                                                                                                                                                                                         <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.vendor.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Vendor != null? Vendor : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.vendor.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.osversion.alias"/>
                          </table:cell>
            <table:cell>
                            <%= OSVersion != null? OSVersion : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.osversion.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.elementtype.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ElementType != null? ElementType : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.elementtype.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.serialnumber.alias"/>
                          </table:cell>
            <table:cell>
                            <%= SerialNumber != null? SerialNumber : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.serialnumber.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.role.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("PE" ,"PE");
                                            valueShowMap.put("CE" ,"CE");
                                            valueShowMap.put("AccessSwitch" ,"AccessSwitch");
                                            valueShowMap.put("AggregationSwitch" ,"AggregationSwitch");
                                          if(Role!=null)
                     Role=(String)valueShowMap.get(Role);
              %>
              <%= Role != null? Role : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.role.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.adminstate.alias"/>
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
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.adminstate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.lifecyclestate.alias"/>
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
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.lifecyclestate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.rocommunity.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ROCommunity != null? ROCommunity : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.rocommunity.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.rwcommunity.alias"/>
                          </table:cell>
            <table:cell>
                            <%= RWCommunity != null? RWCommunity : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.rwcommunity.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_uuid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= NNMi_UUId != null? NNMi_UUId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_uuid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_lastupdate.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= NNMi_LastUpdate != null? NNMi_LastUpdate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_lastupdate.description"/>
              <%=sdfNNMi_LastUpdateDesc%>                                                        </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.statename.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= StateName != null? StateName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DL_NetworkElementApplicationResources" key="field.statename.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitDL_NetworkElementAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="nnmi_id" value="<%= String.valueOf(NNMi_Id) %>"/>
              </html:form>
  </body>
</html>

