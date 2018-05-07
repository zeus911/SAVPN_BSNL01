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
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitSh_CERouterAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("networkelementid") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                    _location_ = "networkid";
                                                                                                                                                                                    }

%>

<html>
  <head>
    <title><bean:message bundle="Sh_CERouterApplicationResources" key="<%= Sh_CERouterConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.Sh_CERouterForm.action = '/activator<%=moduleConfig%>/UpdateFormSh_CERouterAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.Sh_CERouterForm.submit();
    }
    function performCommit()
    {
      window.document.Sh_CERouterForm.action = '/activator<%=moduleConfig%>/UpdateCommitSh_CERouterAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.Sh_CERouterForm.submit();
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
      var alert = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
      alert.setBounds(400, 120);
      alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
      alert.show();
<%
}
%>
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">

<%
com.hp.ov.activator.vpn.inventory.Sh_CERouter beanSh_CERouter = (com.hp.ov.activator.vpn.inventory.Sh_CERouter) request.getAttribute(Sh_CERouterConstants.SH_CEROUTER_BEAN);
if(beanSh_CERouter==null)
   beanSh_CERouter = (com.hp.ov.activator.vpn.inventory.Sh_CERouter) request.getSession().getAttribute(Sh_CERouterConstants.SH_CEROUTER_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
Sh_CERouterForm form = (Sh_CERouterForm) request.getAttribute("Sh_CERouterForm");

  String resourceCount = NumberFormat.getInstance().format(1);

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String NetworkElementID = beanSh_CERouter.getNetworkelementid();
        
            
                            
            
                
                String NetworkID = beanSh_CERouter.getNetworkid();
        
            
                            
            
                
                String Name = beanSh_CERouter.getName();
        
            
                            
            
                
                String Description = beanSh_CERouter.getDescription();
        
            
                            
            
                
                String Location = beanSh_CERouter.getLocation();
        
            
                            
            
                
                String IP = beanSh_CERouter.getIp();
        
            
                            
            
                
                String management_IP = beanSh_CERouter.getManagement_ip();
        
            
                            
            
                
                String ManagementInterface = beanSh_CERouter.getManagementinterface();
        
            
                            
            
                
              boolean UsernameEnabled = new Boolean(beanSh_CERouter.getUsernameenabled()).booleanValue();
    
            
                            
            
                
                String Username = beanSh_CERouter.getUsername();
        
            
                            
            
                
                String Password = beanSh_CERouter.getPassword();
        
            
                            
            
                
                String EnablePassword = beanSh_CERouter.getEnablepassword();
        
            
                            
            
                
                String Vendor = beanSh_CERouter.getVendor();
        
            
                            
            
                
                String OSversion = beanSh_CERouter.getOsversion();
        
            
                            
            
                
                String ElementType = beanSh_CERouter.getElementtype();
        
            
                            
            
                
                String SerialNumber = beanSh_CERouter.getSerialnumber();
        
            
                            
            
                
                String Role = beanSh_CERouter.getRole();
        
            
                            
            
                
                String State = beanSh_CERouter.getState();
        
            
                            
            
                
                String LifeCycleState = beanSh_CERouter.getLifecyclestate();
        
            
                            
            
                
              boolean Backup = new Boolean(beanSh_CERouter.getBackup()).booleanValue();
    
            
                            
            
                
                String SchPolicyName = beanSh_CERouter.getSchpolicyname();
        
            
                            
            
                
                String ROCommunity = beanSh_CERouter.getRocommunity();
        
            
                            
            
                
                String RWCommunity = beanSh_CERouter.getRwcommunity();
        
            
                            
            
                
                String Managed = beanSh_CERouter.getManaged();
        
            
                            
            
                
                String Present = beanSh_CERouter.getPresent();
        
            
                            
            
                
                String Marker = beanSh_CERouter.getMarker();
        
            
                            
            
                
                String UploadStatus = beanSh_CERouter.getUploadstatus();
        
            
                            
            
                
                String DBPrimaryKey = beanSh_CERouter.getDbprimarykey();
        
            
                            
            
                
              String __count = "" + beanSh_CERouter.get__count();
              __count = (__count != null && !(__count.trim().equals(""))) ? nfA.format(beanSh_CERouter.get__count()) : "";
          
            
            if( beanSh_CERouter.get__count()==Integer.MIN_VALUE)
         __count = "";
                            
            
                
                String CE_LoopbackPool = beanSh_CERouter.getCe_loopbackpool();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_CERouterApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
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
          <html:errors bundle="Sh_CERouterApplicationResources" property="CE_LoopbackPool"/>
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
<input type="hidden" name="_update_commit_" value="true"/> 
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
                <bean:message bundle="Sh_CERouterApplicationResources" key="field.networkelementid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="networkelementid" value="<%= NetworkElementID %>"/>
                                                        <html:text disabled="true" property="networkelementid" size="24" value="<%= NetworkElementID %>"/>
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
                                                                        <html:text  property="networkid" size="24" value="<%= NetworkID %>"/>
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
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
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
                                                                        <html:text  property="description" size="24" value="<%= Description %>"/>
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
                                                                        <html:text  property="location" size="24" value="<%= Location %>"/>
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
                                                                        <html:text  property="ip" size="24" value="<%= IP %>"/>
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
                                                                        <html:text  property="management_ip" size="24" value="<%= management_IP %>"/>
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
                        String selValue=null;                                    
                        if(ManagementInterface==null||ManagementInterface.trim().equals(""))
                           selValue="telnet";
                        else
                        selValue=ManagementInterface.toString();    
                          %>

                    <html:select  property="managementinterface" value="<%= selValue %>" >
                                            <html:option value="telnet" >telnet</html:option>
                                            <html:option value="ssh" >ssh</html:option>
                                          </html:select>
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
                                  <html:checkbox  property="usernameenabled" value="true"/>
                  <html:hidden  property="usernameenabled" value="false"/>
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
                                                                        <html:text  property="username" size="24" value="<%= Username %>"/>
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
                                                                         <html:password  property="password" size="24" value="<%= Password %>"/>
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
                                                                         <html:password  property="enablepassword" size="24" value="<%= EnablePassword %>"/>
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
                                                                        <html:text  property="vendor" size="24" value="<%= Vendor %>"/>
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
                                                                        <html:text  property="osversion" size="24" value="<%= OSversion %>"/>
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
                                                                        <html:text  property="elementtype" size="24" value="<%= ElementType %>"/>
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
                                                                        <html:text  property="serialnumber" size="24" value="<%= SerialNumber %>"/>
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
                        String selValue=null;                                    
                        if(Role==null||Role.trim().equals(""))
                           selValue="PE";
                        else
                        selValue=Role.toString();    
                          %>

                    <html:select  property="role" value="<%= selValue %>" >
                                            <html:option value="PE" >PE</html:option>
                                            <html:option value="CE" >CE</html:option>
                                            <html:option value="P" >P</html:option>
                                            <html:option value="Access_Switch" >Access_Switch</html:option>
                                            <html:option value="Aggregation_Switch" >Aggregation_Switch</html:option>
                                            <html:option value="ASBR" >ASBR</html:option>
                                          </html:select>
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
                        String selValue=null;                                    
                        if(State==null||State.trim().equals(""))
                           selValue="Up";
                        else
                        selValue=State.toString();    
                          %>

                    <html:select  property="state" value="<%= selValue %>" >
                                            <html:option value="Up" >Up</html:option>
                                            <html:option value="Down" >Down</html:option>
                                            <html:option value="Unknown" >Unknown</html:option>
                                            <html:option value="Reserved" >Reserved</html:option>
                                          </html:select>
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
                        String selValue=null;                                    
                        if(LifeCycleState==null||LifeCycleState.trim().equals(""))
                           selValue="Ready";
                        else
                        selValue=LifeCycleState.toString();    
                          %>

                    <html:select  property="lifecyclestate" value="<%= selValue %>" >
                                            <html:option value="Planned" >Planned</html:option>
                                            <html:option value="Accessible" >Accessible</html:option>
                                            <html:option value="Preconfigured" >Preconfigured</html:option>
                                            <html:option value="Ready" >Ready</html:option>
                                          </html:select>
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
                                  <html:checkbox  property="backup" value="true"/>
                  <html:hidden  property="backup" value="false"/>
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
                                                                        <html:text  property="schpolicyname" size="24" value="<%= SchPolicyName %>"/>
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
                                                                        <html:text  property="rocommunity" size="24" value="<%= ROCommunity %>"/>
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
                                                                        <html:text  property="rwcommunity" size="24" value="<%= RWCommunity %>"/>
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
                                                                        <html:text  property="managed" size="24" value="<%= Managed %>"/>
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
                                                                        <html:text  property="present" size="24" value="<%= Present %>"/>
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
                                                                        <html:text  property="marker" size="24" value="<%= Marker %>"/>
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
                                                                        <html:text  property="uploadstatus" size="24" value="<%= UploadStatus %>"/>
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
                                                                        <html:text  property="dbprimarykey" size="24" value="<%= DBPrimaryKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_CERouterApplicationResources" key="field.dbprimarykey.description"/>
                                                                        </table:cell>
            </table:row>
                                
                        
         <table:row>
              <table:cell>  
                <bean:message bundle="Sh_CERouterApplicationResources" key="field.__count.alias"/>
              </table:cell>
              <table:cell>
                       <html:text  disabled="true"  property="__count" size="24" value="<%= __count %>"/>
              </table:cell>
              <table:cell>
                <bean:message bundle="Sh_CERouterApplicationResources" key="field.__count.description"/>
              </table:cell>
      </table:row>
                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_CERouterApplicationResources" key="field.ce_loopbackpool.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ce_loopbackpool" size="24" value="<%= CE_LoopbackPool %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_CERouterApplicationResources" key="field.ce_loopbackpool.description"/>
                                                                        </table:cell>
            </table:row>
                                
                    
      <html:hidden property="__HASH_CODE" value="<%= __HASH_CODE %>"/>            
            
      
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
