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
String datasource = (String) request.getParameter(DelayedActivationConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitDelayedActivationAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("daname") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                    _location_ = "numberofretries";
                              }

%>

<html>
  <head>
    <title><bean:message bundle="DelayedActivationApplicationResources" key="<%= DelayedActivationConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.DelayedActivationForm.action = '/activator<%=moduleConfig%>/UpdateFormDelayedActivationAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.DelayedActivationForm.submit();
    }
    function performCommit()
    {
      window.document.DelayedActivationForm.action = '/activator<%=moduleConfig%>/UpdateCommitDelayedActivationAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.DelayedActivationForm.submit();
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
com.hp.ov.activator.vpn.inventory.DelayedActivation beanDelayedActivation = (com.hp.ov.activator.vpn.inventory.DelayedActivation) request.getAttribute(DelayedActivationConstants.DELAYEDACTIVATION_BEAN);
if(beanDelayedActivation==null)
   beanDelayedActivation = (com.hp.ov.activator.vpn.inventory.DelayedActivation) request.getSession().getAttribute(DelayedActivationConstants.DELAYEDACTIVATION_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
DelayedActivationForm form = (DelayedActivationForm) request.getAttribute("DelayedActivationForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String DAName = beanDelayedActivation.getDaname();
        
            
                            
            
                
              String NumberOfRetries = "" + beanDelayedActivation.getNumberofretries();
              NumberOfRetries = (NumberOfRetries != null && !(NumberOfRetries.trim().equals(""))) ? nfA.format(beanDelayedActivation.getNumberofretries()) : "";
          
            
            if( beanDelayedActivation.getNumberofretries()==Integer.MIN_VALUE)
         NumberOfRetries = "";
                            
            
                
              String Days = "" + beanDelayedActivation.getDays();
              Days = (Days != null && !(Days.trim().equals(""))) ? nfA.format(beanDelayedActivation.getDays()) : "";
          
            
            if( beanDelayedActivation.getDays()==Integer.MIN_VALUE)
         Days = "";
                            
            
                
              String Hours = "" + beanDelayedActivation.getHours();
              Hours = (Hours != null && !(Hours.trim().equals(""))) ? nfA.format(beanDelayedActivation.getHours()) : "";
          
            
            if( beanDelayedActivation.getHours()==Integer.MIN_VALUE)
         Hours = "";
                            
            
                
              String Minutes = "" + beanDelayedActivation.getMinutes();
              Minutes = (Minutes != null && !(Minutes.trim().equals(""))) ? nfA.format(beanDelayedActivation.getMinutes()) : "";
          
            
            if( beanDelayedActivation.getMinutes()==Integer.MIN_VALUE)
         Minutes = "";
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DelayedActivationApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="DelayedActivationApplicationResources" property="DAName"/>
        <html:errors bundle="DelayedActivationApplicationResources" property="NumberOfRetries"/>
        <html:errors bundle="DelayedActivationApplicationResources" property="Days"/>
        <html:errors bundle="DelayedActivationApplicationResources" property="Hours"/>
        <html:errors bundle="DelayedActivationApplicationResources" property="Minutes"/>
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
                <bean:message bundle="DelayedActivationApplicationResources" key="field.daname.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="daname" value="<%= DAName %>"/>
                                                        <html:text disabled="true" property="daname" size="24" value="<%= DAName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DelayedActivationApplicationResources" key="field.daname.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DelayedActivationApplicationResources" key="field.numberofretries.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="numberofretries" size="24" value="<%= NumberOfRetries %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DelayedActivationApplicationResources" key="field.numberofretries.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DelayedActivationApplicationResources" key="field.days.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="days" size="24" value="<%= Days %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DelayedActivationApplicationResources" key="field.days.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DelayedActivationApplicationResources" key="field.hours.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="hours" size="24" value="<%= Hours %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DelayedActivationApplicationResources" key="field.hours.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="DelayedActivationApplicationResources" key="field.minutes.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="minutes" size="24" value="<%= Minutes %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="DelayedActivationApplicationResources" key="field.minutes.description"/>
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
