<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.na.common.*,
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
String datasource = (String) request.getParameter(NAConfigurationConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitNAConfigurationAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("id") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                                                        _location_ = "cl_hostname";
                                    }

%>

<html>
  <head>
    <title><bean:message bundle="NAConfigurationApplicationResources" key="<%= NAConfigurationConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.NAConfigurationForm.action = '/activator<%=moduleConfig%>/UpdateFormNAConfigurationAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.NAConfigurationForm.submit();
    }
    function performCommit()
    {
      window.document.NAConfigurationForm.action = '/activator<%=moduleConfig%>/UpdateCommitNAConfigurationAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.NAConfigurationForm.submit();
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
com.hp.ov.activator.na.common.NAConfiguration beanNAConfiguration = (com.hp.ov.activator.na.common.NAConfiguration) request.getAttribute(NAConfigurationConstants.NACONFIGURATION_BEAN);
if(beanNAConfiguration==null)
   beanNAConfiguration = (com.hp.ov.activator.na.common.NAConfiguration) request.getSession().getAttribute(NAConfigurationConstants.NACONFIGURATION_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
NAConfigurationForm form = (NAConfigurationForm) request.getAttribute("NAConfigurationForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

            boolean enable_proxy = new Boolean(beanNAConfiguration.getEnable_proxy()).booleanValue();
    
            
                            
            
                
                String Id = beanNAConfiguration.getId();
        
            
                            
            
                
                String proxy_hostname = beanNAConfiguration.getProxy_hostname();
        
            
                            
            
                
                String proxy_port = beanNAConfiguration.getProxy_port();
        
            
                            
            
                
                String proxy_username = beanNAConfiguration.getProxy_username();
        
            
                            
            
                
                String proxy_password = beanNAConfiguration.getProxy_password();
        
            
                            
            
                
              boolean cl_protocol = new Boolean(beanNAConfiguration.getCl_protocol()).booleanValue();
    
            
                            
            
                
                String cl_hostname = beanNAConfiguration.getCl_hostname();
        
            
                            
            
                
                String cl_port = beanNAConfiguration.getCl_port();
        
            
                            
            
                
                String cl_username = beanNAConfiguration.getCl_username();
        
            
                            
            
                
                String cl_password = beanNAConfiguration.getCl_password();
        
            
                            
            
                
              boolean enable_cl = new Boolean(beanNAConfiguration.getEnable_cl()).booleanValue();
    
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="NAConfigurationApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="NAConfigurationApplicationResources" property="enable_proxy"/>
        <html:errors bundle="NAConfigurationApplicationResources" property="Id"/>
        <html:errors bundle="NAConfigurationApplicationResources" property="proxy_hostname"/>
        <html:errors bundle="NAConfigurationApplicationResources" property="proxy_port"/>
        <html:errors bundle="NAConfigurationApplicationResources" property="proxy_username"/>
        <html:errors bundle="NAConfigurationApplicationResources" property="proxy_password"/>
        <html:errors bundle="NAConfigurationApplicationResources" property="cl_protocol"/>
        <html:errors bundle="NAConfigurationApplicationResources" property="cl_hostname"/>
        <html:errors bundle="NAConfigurationApplicationResources" property="cl_port"/>
        <html:errors bundle="NAConfigurationApplicationResources" property="cl_username"/>
        <html:errors bundle="NAConfigurationApplicationResources" property="cl_password"/>
        <html:errors bundle="NAConfigurationApplicationResources" property="enable_cl"/>
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
                <bean:message bundle="NAConfigurationApplicationResources" key="field.enable_proxy.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                  <html:checkbox disabled="true" property="enable_proxy" value="true"/>
                  <html:hidden disabled="true" property="enable_proxy" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="NAConfigurationApplicationResources" key="field.enable_proxy.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="id" value="<%= Id %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_hostname.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="proxy_hostname" value="<%= proxy_hostname %>"/>
                                                        <html:text disabled="true" property="proxy_hostname" size="24" value="<%= proxy_hostname %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_hostname.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_port.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="proxy_port" value="<%= proxy_port %>"/>
                                                        <html:text disabled="true" property="proxy_port" size="24" value="<%= proxy_port %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_port.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_username.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="proxy_username" value="<%= proxy_username %>"/>
                                                        <html:text disabled="true" property="proxy_username" size="24" value="<%= proxy_username %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_username.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_password.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="proxy_password" value="<%= proxy_password %>"/>
                                                         <html:password disabled="true" property="proxy_password" size="24" value="<%= proxy_password %>"/>
                                                                     </table:cell>
              <table:cell>
                <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_password.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NAConfigurationApplicationResources" key="field.cl_protocol.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="cl_protocol" value="true"/>
                  <html:hidden  property="cl_protocol" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="NAConfigurationApplicationResources" key="field.cl_protocol.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NAConfigurationApplicationResources" key="field.cl_hostname.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="cl_hostname" size="24" value="<%= cl_hostname %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NAConfigurationApplicationResources" key="field.cl_hostname.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NAConfigurationApplicationResources" key="field.cl_port.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="cl_port" size="24" value="<%= cl_port %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="NAConfigurationApplicationResources" key="field.cl_port.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="cl_username" value="<%= cl_username %>"/>            
				                                            
                                                    <html:hidden property="cl_password" value="<%= cl_password %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="NAConfigurationApplicationResources" key="field.enable_cl.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="enable_cl" value="true"/>
                  <html:hidden  property="enable_cl" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="NAConfigurationApplicationResources" key="field.enable_cl.description"/>
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
