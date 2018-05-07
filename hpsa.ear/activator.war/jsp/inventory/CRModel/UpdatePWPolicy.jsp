<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.cr.inventory.*,
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
String datasource = (String) request.getParameter(PWPolicyConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitPWPolicyAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("pwpolicyid") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                    _location_ = "name";
                                          }

%>

<html>
  <head>
    <title><bean:message bundle="PWPolicyApplicationResources" key="<%= PWPolicyConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.PWPolicyForm.action = '/activator<%=moduleConfig%>/UpdateFormPWPolicyAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.PWPolicyForm.submit();
    }
    function performCommit()
    {
      window.document.PWPolicyForm.action = '/activator<%=moduleConfig%>/UpdateCommitPWPolicyAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.PWPolicyForm.submit();
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
com.hp.ov.activator.cr.inventory.PWPolicy beanPWPolicy = (com.hp.ov.activator.cr.inventory.PWPolicy) request.getAttribute(PWPolicyConstants.PWPOLICY_BEAN);
if(beanPWPolicy==null)
   beanPWPolicy = (com.hp.ov.activator.cr.inventory.PWPolicy) request.getSession().getAttribute(PWPolicyConstants.PWPOLICY_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
PWPolicyForm form = (PWPolicyForm) request.getAttribute("PWPolicyForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String PWPolicyId = beanPWPolicy.getPwpolicyid();
        
            
                            
            
                
                String Name = beanPWPolicy.getName();
        
            
                            
            
                
                String Description = beanPWPolicy.getDescription();
        
            
                            
            
                
              boolean UsernameEnabled = new Boolean(beanPWPolicy.getUsernameenabled()).booleanValue();
    
            
                            
            
                
                String Username = beanPWPolicy.getUsername();
        
            
                            
            
                
                String Password = beanPWPolicy.getPassword();
        
            
                            
            
                  String PasswordCurrent = "" + beanPWPolicy.getPasswordCurrent();
                
                String EnablePassword = beanPWPolicy.getEnablepassword();
        
            
                            
            
                  String EnablePasswordCurrent = "" + beanPWPolicy.getEnablePasswordCurrent();
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="PWPolicyApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="PWPolicyApplicationResources" property="PWPolicyId"/>
        <html:errors bundle="PWPolicyApplicationResources" property="Name"/>
        <html:errors bundle="PWPolicyApplicationResources" property="Description"/>
        <html:errors bundle="PWPolicyApplicationResources" property="UsernameEnabled"/>
        <html:errors bundle="PWPolicyApplicationResources" property="Username"/>
        <html:errors bundle="PWPolicyApplicationResources" property="Password"/>
        <html:errors bundle="PWPolicyApplicationResources" property="EnablePassword"/>
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
                <bean:message bundle="PWPolicyApplicationResources" key="field.pwpolicyid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="pwpolicyid" value="<%= PWPolicyId %>"/>
                                                        <html:text disabled="true" property="pwpolicyid" size="24" value="<%= PWPolicyId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PWPolicyApplicationResources" key="field.pwpolicyid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PWPolicyApplicationResources" key="field.name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PWPolicyApplicationResources" key="field.name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PWPolicyApplicationResources" key="field.description.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="description" size="24" value="<%= Description %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PWPolicyApplicationResources" key="field.description.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PWPolicyApplicationResources" key="field.usernameenabled.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="usernameenabled" value="true"/>
                  <html:hidden  property="usernameenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="PWPolicyApplicationResources" key="field.usernameenabled.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PWPolicyApplicationResources" key="field.username.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="username" size="24" value="<%= Username %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PWPolicyApplicationResources" key="field.username.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PWPolicyApplicationResources" key="field.password.alias"/>
                              </table:cell>
              <table:cell>
                                                                         <html:password  property="password" size="24" value="<%= Password %>"/>
                                          <html:hidden property="passwordcurrent" value="<%= PasswordCurrent %>"/>
                                                                     </table:cell>
              <table:cell>
                <bean:message bundle="PWPolicyApplicationResources" key="field.password.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PWPolicyApplicationResources" key="field.enablepassword.alias"/>
                              </table:cell>
              <table:cell>
                                                                         <html:password  property="enablepassword" size="24" value="<%= EnablePassword %>"/>
                                          <html:hidden property="enablepasswordcurrent" value="<%= EnablePasswordCurrent %>"/>
                                                                     </table:cell>
              <table:cell>
                <bean:message bundle="PWPolicyApplicationResources" key="field.enablepassword.description"/>
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
