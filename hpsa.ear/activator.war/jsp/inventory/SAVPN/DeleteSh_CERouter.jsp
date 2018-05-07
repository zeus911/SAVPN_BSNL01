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
String datasource = (String) request.getParameter(Sh_CERouterConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="Sh_CERouterApplicationResources" key="<%= Sh_CERouterConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.Sh_CERouterForm.action = '/activator<%=moduleConfig%>/DeleteCommitSh_CERouterAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_CERouterForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="Sh_CERouterApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.Sh_CERouter beanSh_CERouter = (com.hp.ov.activator.vpn.inventory.Sh_CERouter) request.getAttribute(Sh_CERouterConstants.SH_CEROUTER_BEAN);

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String NetworkElementID = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getNetworkelementid());
                        
                                  
                      String NetworkID = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getNetworkid());
                        
                                  
                      String Name = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getName());
                        
                                  
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getDescription());
                        
                                  
                      String Location = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getLocation());
                        
                                  
                      String IP = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getIp());
                        
                                  
                      String management_IP = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getManagement_ip());
                        
                                  
                      String ManagementInterface = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getManagementinterface());
                        
                                  
                      boolean UsernameEnabled = new Boolean(beanSh_CERouter.getUsernameenabled()).booleanValue();
                  
                                  
                      String Username = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getUsername());
                        
                                  
                      String Password = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getPassword());
                        
                                  
                      String EnablePassword = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getEnablepassword());
                        
                                  
                      String Vendor = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getVendor());
                        
                                  
                      String OSversion = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getOsversion());
                        
                                  
                      String ElementType = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getElementtype());
                        
                                  
                      String SerialNumber = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getSerialnumber());
                        
                                  
                      String Role = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getRole());
                        
                                  
                      String State = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getState());
                        
                                  
                      String LifeCycleState = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getLifecyclestate());
                        
                                  
                      boolean Backup = new Boolean(beanSh_CERouter.getBackup()).booleanValue();
                  
                                  
                      String SchPolicyName = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getSchpolicyname());
                        
                                  
                      String ROCommunity = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getRocommunity());
                        
                                  
                      String RWCommunity = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getRwcommunity());
                        
                                  
                      String Managed = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getManaged());
                        
                                  
                      String Present = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getPresent());
                        
                                  
                      String Marker = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getMarker());
                        
                                  
                      String UploadStatus = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getUploadstatus());
                        
                                  
                      String DBPrimaryKey = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getDbprimarykey());
                        
                                  
                        String __count = "" + beanSh_CERouter.get__count();
                      __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSh_CERouter.get__count()) : "";
                          
                  if( beanSh_CERouter.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
                      String CE_LoopbackPool = StringFacility.replaceAllByHTMLCharacter(beanSh_CERouter.getCe_loopbackpool());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="Sh_CERouterApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.networkelementid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= NetworkElementID != null? NetworkElementID : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.networkelementid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.networkid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NetworkID != null? NetworkID : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.networkid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.name.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.description.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.location.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Location != null? Location : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.location.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.ip.alias"/>
                          </table:cell>
            <table:cell>
                            <%= IP != null? IP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.ip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.management_ip.alias"/>
                          </table:cell>
            <table:cell>
                            <%= management_IP != null? management_IP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.management_ip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.managementinterface.alias"/>
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
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.managementinterface.description"/>
                                                                      </table:cell>
          </table:row>
                                                                       <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.usernameenabled.alias"/>
                          </table:cell>
            <table:cell>
              <%= UsernameEnabled %>
            </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.usernameenabled.description"/>
            </table:cell>
          </table:row>
                                                                         <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.username.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Username != null? Username : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.username.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.password.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Password != null && !Password.equals("")? "**********" : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.password.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.enablepassword.alias"/>
                          </table:cell>
            <table:cell>
                            <%= EnablePassword != null && !EnablePassword.equals("")? "**********" : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.enablepassword.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.vendor.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Vendor != null? Vendor : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.vendor.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.osversion.alias"/>
                          </table:cell>
            <table:cell>
                            <%= OSversion != null? OSversion : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.osversion.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.elementtype.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ElementType != null? ElementType : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.elementtype.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.serialnumber.alias"/>
                          </table:cell>
            <table:cell>
                            <%= SerialNumber != null? SerialNumber : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.serialnumber.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.role.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("PE" ,"PE");
                                            valueShowMap.put("CE" ,"CE");
                                            valueShowMap.put("P" ,"P");
                                            valueShowMap.put("Access_Switch" ,"Access_Switch");
                                            valueShowMap.put("Aggregation_Switch" ,"Aggregation_Switch");
                                            valueShowMap.put("ASBR" ,"ASBR");
                                          if(Role!=null)
                     Role=(String)valueShowMap.get(Role);
              %>
              <%= Role != null? Role : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.role.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Up" ,"Up");
                                            valueShowMap.put("Down" ,"Down");
                                            valueShowMap.put("Unknown" ,"Unknown");
                                            valueShowMap.put("Reserved" ,"Reserved");
                                          if(State!=null)
                     State=(String)valueShowMap.get(State);
              %>
              <%= State != null? State : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.state.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.lifecyclestate.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Planned" ,"Planned");
                                            valueShowMap.put("Accessible" ,"Accessible");
                                            valueShowMap.put("Preconfigured" ,"Preconfigured");
                                            valueShowMap.put("Ready" ,"Ready");
                                          if(LifeCycleState!=null)
                     LifeCycleState=(String)valueShowMap.get(LifeCycleState);
              %>
              <%= LifeCycleState != null? LifeCycleState : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.lifecyclestate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                       <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.backup.alias"/>
                          </table:cell>
            <table:cell>
              <%= Backup %>
            </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.backup.description"/>
            </table:cell>
          </table:row>
                                                                         <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.schpolicyname.alias"/>
                          </table:cell>
            <table:cell>
                            <%= SchPolicyName != null? SchPolicyName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.schpolicyname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.rocommunity.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ROCommunity != null? ROCommunity : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.rocommunity.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.rwcommunity.alias"/>
                          </table:cell>
            <table:cell>
                            <%= RWCommunity != null? RWCommunity : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.rwcommunity.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.managed.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Managed != null? Managed : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.managed.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.present.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Present != null? Present : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.present.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.marker.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Marker != null? Marker : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.marker.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.uploadstatus.alias"/>
                          </table:cell>
            <table:cell>
                            <%= UploadStatus != null? UploadStatus : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.uploadstatus.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.dbprimarykey.alias"/>
                          </table:cell>
            <table:cell>
                            <%= DBPrimaryKey != null? DBPrimaryKey : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.dbprimarykey.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.__count.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= __count != null? __count : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.__count.description"/>
                                    <span style='font:italic'>(initially <%=resourceCount%>).</span>                                  </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.ce_loopbackpool.alias"/>
                          </table:cell>
            <table:cell>
                            <%= CE_LoopbackPool != null? CE_LoopbackPool : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CERouterApplicationResources" key="field.ce_loopbackpool.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitSh_CERouterAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="networkelementid" value="<%= String.valueOf(NetworkElementID) %>"/>
              </html:form>
  </body>
</html>

