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

                                                          
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(Sh_NetworkElementConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitSh_NetworkElementAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "networkelementid";
                                                                                                                                                                                    }
%>

<html>
  <head>
    <title><bean:message bundle="Sh_NetworkElementApplicationResources" key="<%= Sh_NetworkElementConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.Sh_NetworkElementForm.action = '/activator<%=moduleConfig%>/CreationFormSh_NetworkElementAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.Sh_NetworkElementForm.submit();
    }
    function performCommit()
    {
      window.document.Sh_NetworkElementForm.action = '/activator<%=moduleConfig%>/CreationCommitSh_NetworkElementAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_NetworkElementForm.submit();
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

com.hp.ov.activator.vpn.inventory.Sh_NetworkElement beanSh_NetworkElement = (com.hp.ov.activator.vpn.inventory.Sh_NetworkElement) request.getAttribute(Sh_NetworkElementConstants.SH_NETWORKELEMENT_BEAN);

      String NetworkElementID = beanSh_NetworkElement.getNetworkelementid();
                String NetworkID = beanSh_NetworkElement.getNetworkid();
                String Name = beanSh_NetworkElement.getName();
                String Description = beanSh_NetworkElement.getDescription();
                String Location = beanSh_NetworkElement.getLocation();
                String IP = beanSh_NetworkElement.getIp();
                String management_IP = beanSh_NetworkElement.getManagement_ip();
                String ManagementInterface = beanSh_NetworkElement.getManagementinterface();
                boolean UsernameEnabled = new Boolean(beanSh_NetworkElement.getUsernameenabled()).booleanValue();
                String Username = beanSh_NetworkElement.getUsername();
                String Password = beanSh_NetworkElement.getPassword();
                String EnablePassword = beanSh_NetworkElement.getEnablepassword();
                String Vendor = beanSh_NetworkElement.getVendor();
                String OSversion = beanSh_NetworkElement.getOsversion();
                String ElementType = beanSh_NetworkElement.getElementtype();
                String SerialNumber = beanSh_NetworkElement.getSerialnumber();
                String Role = beanSh_NetworkElement.getRole();
                String State = beanSh_NetworkElement.getState();
                String LifeCycleState = beanSh_NetworkElement.getLifecyclestate();
                boolean Backup = new Boolean(beanSh_NetworkElement.getBackup()).booleanValue();
                String SchPolicyName = beanSh_NetworkElement.getSchpolicyname();
                String ROCommunity = beanSh_NetworkElement.getRocommunity();
                String RWCommunity = beanSh_NetworkElement.getRwcommunity();
                String Managed = beanSh_NetworkElement.getManaged();
                String Present = beanSh_NetworkElement.getPresent();
                String Marker = beanSh_NetworkElement.getMarker();
                String UploadStatus = beanSh_NetworkElement.getUploadstatus();
                String DBPrimaryKey = beanSh_NetworkElement.getDbprimarykey();
            
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_NetworkElementApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="Sh_NetworkElementApplicationResources" property="NetworkElementID"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="NetworkID"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="Name"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="Description"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="Location"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="IP"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="management_IP"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="ManagementInterface"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="UsernameEnabled"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="Username"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="Password"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="EnablePassword"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="Vendor"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="OSversion"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="ElementType"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="SerialNumber"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="Role"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="State"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="LifeCycleState"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="Backup"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="SchPolicyName"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="ROCommunity"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="RWCommunity"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="Managed"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="Present"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_NetworkElementApplicationResources" property="DBPrimaryKey"/>
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
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.networkelementid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="networkelementid" size="24" value="<%= NetworkElementID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.networkelementid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.networkid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="networkid" size="24" value="<%= NetworkID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.networkid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.name.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.description.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="description" size="24" value="<%= Description %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.description.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.location.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="location" size="24" value="<%= Location %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.location.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.ip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ip" size="24" value="<%= IP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.ip.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.management_ip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="management_ip" size="24" value="<%= management_IP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.management_ip.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.managementinterface.alias"/>
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
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.managementinterface.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.usernameenabled.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="usernameenabled" value="true"/>
                  <html:hidden  property="usernameenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.usernameenabled.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.username.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="username" size="24" value="<%= Username %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.username.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.password.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:password  property="password" size="24" value="<%= Password %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.password.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.enablepassword.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:password  property="enablepassword" size="24" value="<%= EnablePassword %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.enablepassword.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.vendor.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vendor" size="24" value="<%= Vendor %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.vendor.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.osversion.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="osversion" size="24" value="<%= OSversion %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.osversion.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.elementtype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="elementtype" size="24" value="<%= ElementType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.elementtype.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.serialnumber.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="serialnumber" size="24" value="<%= SerialNumber %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.serialnumber.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.role.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(Role==null||Role.trim().equals("")) {
                          selValue="PE";
                        } else {
                          selValue=Role.toString();
                        }    
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
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.role.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(State==null||State.trim().equals("")) {
                          selValue="Up";
                        } else {
                          selValue=State.toString();
                        }    
                    %>

                    <html:select  property="state" value="<%= selValue %>" >
                                            <html:option value="Up" >Up</html:option>
                                            <html:option value="Down" >Down</html:option>
                                            <html:option value="Unknown" >Unknown</html:option>
                                            <html:option value="Reserved" >Reserved</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.state.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.lifecyclestate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(LifeCycleState==null||LifeCycleState.trim().equals("")) {
                          selValue="Ready";
                        } else {
                          selValue=LifeCycleState.toString();
                        }    
                    %>

                    <html:select  property="lifecyclestate" value="<%= selValue %>" >
                                            <html:option value="Planned" >Planned</html:option>
                                            <html:option value="Accessible" >Accessible</html:option>
                                            <html:option value="Preconfigured" >Preconfigured</html:option>
                                            <html:option value="Ready" >Ready</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.lifecyclestate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.backup.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="backup" value="true"/>
                  <html:hidden  property="backup" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.backup.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.schpolicyname.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="schpolicyname" size="24" value="<%= SchPolicyName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.schpolicyname.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.rocommunity.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rocommunity" size="24" value="<%= ROCommunity %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.rocommunity.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.rwcommunity.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rwcommunity" size="24" value="<%= RWCommunity %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.rwcommunity.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.managed.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="managed" size="24" value="<%= Managed %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.managed.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.present.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="present" size="24" value="<%= Present %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.present.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.marker.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="marker" size="24" value="<%= Marker %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.marker.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.uploadstatus.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="uploadstatus" size="24" value="<%= UploadStatus %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.uploadstatus.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.dbprimarykey.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dbprimarykey" size="24" value="<%= DBPrimaryKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_NetworkElementApplicationResources" key="field.dbprimarykey.description"/>
                              </table:cell>
            </table:row>
                                            
      
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
