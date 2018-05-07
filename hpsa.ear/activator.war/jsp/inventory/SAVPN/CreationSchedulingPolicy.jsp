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

                   java.text.SimpleDateFormat sdfStartingTime = new java.text.SimpleDateFormat("dd-MM-yyyy");
            String sdfStartingTimeDesc = "Format: [" + sdfStartingTime.toPattern() + "]. Example: [" + sdfStartingTime.format(new Date()) + "]";
        
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(SchedulingPolicyConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitSchedulingPolicyAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "schedulingpolicyname";
                                    }
%>

<html>
  <head>
    <title><bean:message bundle="SchedulingPolicyApplicationResources" key="<%= SchedulingPolicyConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.SchedulingPolicyForm.action = '/activator<%=moduleConfig%>/CreationFormSchedulingPolicyAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.SchedulingPolicyForm.submit();
    }
    function performCommit()
    {
      window.document.SchedulingPolicyForm.action = '/activator<%=moduleConfig%>/CreationCommitSchedulingPolicyAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.SchedulingPolicyForm.submit();
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

com.hp.ov.activator.vpn.inventory.SchedulingPolicy beanSchedulingPolicy = (com.hp.ov.activator.vpn.inventory.SchedulingPolicy) request.getAttribute(SchedulingPolicyConstants.SCHEDULINGPOLICY_BEAN);

      String SchedulingPolicyName = beanSchedulingPolicy.getSchedulingpolicyname();
                String StartingTime = (beanSchedulingPolicy.getStartingtime() == null) ? "" : beanSchedulingPolicy.getStartingtime();
                String Periodicity = "" + beanSchedulingPolicy.getPeriodicity();
      Periodicity = (Periodicity != null && !(Periodicity.trim().equals(""))) ? nfA.format(beanSchedulingPolicy.getPeriodicity()) : "";
                      String RefreshInterval = "" + beanSchedulingPolicy.getRefreshinterval();
      RefreshInterval = (RefreshInterval != null && !(RefreshInterval.trim().equals(""))) ? nfA.format(beanSchedulingPolicy.getRefreshinterval()) : "";
                      String BackupsNumber = "" + beanSchedulingPolicy.getBackupsnumber();
      BackupsNumber = (BackupsNumber != null && !(BackupsNumber.trim().equals(""))) ? nfA.format(beanSchedulingPolicy.getBackupsnumber()) : "";
                
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="SchedulingPolicyApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="SchedulingPolicyApplicationResources" property="SchedulingPolicyName"/>
        <html:errors bundle="SchedulingPolicyApplicationResources" property="StartingTime"/>
        <html:errors bundle="SchedulingPolicyApplicationResources" property="Periodicity"/>
        <html:errors bundle="SchedulingPolicyApplicationResources" property="RefreshInterval"/>
        <html:errors bundle="SchedulingPolicyApplicationResources" property="BackupsNumber"/>
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
                <bean:message bundle="SchedulingPolicyApplicationResources" key="field.schedulingpolicyname.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="schedulingpolicyname" size="24" value="<%= SchedulingPolicyName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SchedulingPolicyApplicationResources" key="field.schedulingpolicyname.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SchedulingPolicyApplicationResources" key="field.startingtime.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="startingtime" size="24" value="<%= StartingTime %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SchedulingPolicyApplicationResources" key="field.startingtime.description"/>
                <%=sdfStartingTimeDesc%>              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SchedulingPolicyApplicationResources" key="field.periodicity.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="periodicity" size="24" value="<%= Periodicity %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SchedulingPolicyApplicationResources" key="field.periodicity.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SchedulingPolicyApplicationResources" key="field.refreshinterval.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="refreshinterval" size="24" value="<%= RefreshInterval %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SchedulingPolicyApplicationResources" key="field.refreshinterval.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="SchedulingPolicyApplicationResources" key="field.backupsnumber.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="backupsnumber" size="24" value="<%= BackupsNumber %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="SchedulingPolicyApplicationResources" key="field.backupsnumber.description"/>
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
