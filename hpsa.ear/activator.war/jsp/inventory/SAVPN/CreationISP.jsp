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
String datasource = (String) request.getParameter(ISPConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitISPAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "idname";
                                                                                          }
%>

<html>
  <head>
    <title><bean:message bundle="ISPApplicationResources" key="<%= ISPConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.ISPForm.action = '/activator<%=moduleConfig%>/CreationFormISPAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.ISPForm.submit();
    }
    function performCommit()
    {
      window.document.ISPForm.action = '/activator<%=moduleConfig%>/CreationCommitISPAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.ISPForm.submit();
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

com.hp.ov.activator.vpn.inventory.ISP beanISP = (com.hp.ov.activator.vpn.inventory.ISP) request.getAttribute(ISPConstants.ISP_BEAN);

      String IDName = beanISP.getIdname();
                String SPName = beanISP.getSpname();
                String IP = beanISP.getIp();
                String BackupDirectory = beanISP.getBackupdirectory();
                String ASN = beanISP.getAsn();
                boolean AdminVPNEnabled = new Boolean(beanISP.getAdminvpnenabled()).booleanValue();
                String ErrorQueue = beanISP.getErrorqueue();
                String NotificationQueue = beanISP.getNotificationqueue();
                String ConfirmationQueue = beanISP.getConfirmationqueue();
                String TimedServiceQueue = beanISP.getTimedservicequeue();
                String Timeout = "" + beanISP.getTimeout();
      Timeout = (Timeout != null && !(Timeout.trim().equals(""))) ? nfA.format(beanISP.getTimeout()) : "";
                      String Version = beanISP.getVersion();
                boolean DemoMode = new Boolean(beanISP.getDemomode()).booleanValue();
                String NAParentGroupName = beanISP.getNaparentgroupname();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="ISPApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="ISPApplicationResources" property="IDName"/>
        <html:errors bundle="ISPApplicationResources" property="SPName"/>
        <html:errors bundle="ISPApplicationResources" property="IP"/>
        <html:errors bundle="ISPApplicationResources" property="BackupDirectory"/>
        <html:errors bundle="ISPApplicationResources" property="ASN"/>
        <html:errors bundle="ISPApplicationResources" property="AdminVPNEnabled"/>
        <html:errors bundle="ISPApplicationResources" property="ErrorQueue"/>
        <html:errors bundle="ISPApplicationResources" property="NotificationQueue"/>
        <html:errors bundle="ISPApplicationResources" property="ConfirmationQueue"/>
        <html:errors bundle="ISPApplicationResources" property="TimedServiceQueue"/>
        <html:errors bundle="ISPApplicationResources" property="Timeout"/>
        <html:errors bundle="ISPApplicationResources" property="Version"/>
        <html:errors bundle="ISPApplicationResources" property="DemoMode"/>
        <html:errors bundle="ISPApplicationResources" property="NAParentGroupName"/>
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
                <bean:message bundle="ISPApplicationResources" key="field.idname.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="idname" size="24" value="<%= IDName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ISPApplicationResources" key="field.idname.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ISPApplicationResources" key="field.spname.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="spname" size="24" value="<%= SPName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ISPApplicationResources" key="field.spname.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ISPApplicationResources" key="field.ip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ip" size="24" value="<%= IP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ISPApplicationResources" key="field.ip.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ISPApplicationResources" key="field.backupdirectory.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="backupdirectory" size="24" value="<%= BackupDirectory %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ISPApplicationResources" key="field.backupdirectory.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ISPApplicationResources" key="field.asn.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="asn" size="24" value="<%= ASN %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ISPApplicationResources" key="field.asn.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ISPApplicationResources" key="field.adminvpnenabled.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="adminvpnenabled" value="true"/>
                  <html:hidden  property="adminvpnenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="ISPApplicationResources" key="field.adminvpnenabled.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ISPApplicationResources" key="field.errorqueue.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="errorqueue" size="24" value="<%= ErrorQueue %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ISPApplicationResources" key="field.errorqueue.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ISPApplicationResources" key="field.notificationqueue.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="notificationqueue" size="24" value="<%= NotificationQueue %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ISPApplicationResources" key="field.notificationqueue.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ISPApplicationResources" key="field.confirmationqueue.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="confirmationqueue" size="24" value="<%= ConfirmationQueue %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ISPApplicationResources" key="field.confirmationqueue.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ISPApplicationResources" key="field.timedservicequeue.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="timedservicequeue" size="24" value="<%= TimedServiceQueue %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ISPApplicationResources" key="field.timedservicequeue.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ISPApplicationResources" key="field.timeout.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="timeout" size="24" value="<%= Timeout %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ISPApplicationResources" key="field.timeout.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ISPApplicationResources" key="field.version.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="version" size="24" value="<%= Version %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ISPApplicationResources" key="field.version.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ISPApplicationResources" key="field.demomode.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="demomode" value="true"/>
                  <html:hidden  property="demomode" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="ISPApplicationResources" key="field.demomode.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="ISPApplicationResources" key="field.naparentgroupname.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="naparentgroupname" size="24" value="<%= NAParentGroupName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ISPApplicationResources" key="field.naparentgroupname.description"/>
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
