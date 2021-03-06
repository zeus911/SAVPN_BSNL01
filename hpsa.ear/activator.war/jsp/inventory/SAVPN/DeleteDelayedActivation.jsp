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
%>

<html>
  <head>
    <title><bean:message bundle="DelayedActivationApplicationResources" key="<%= DelayedActivationConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.DelayedActivationForm.action = '/activator<%=moduleConfig%>/DeleteCommitDelayedActivationAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.DelayedActivationForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="DelayedActivationApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.DelayedActivation beanDelayedActivation = (com.hp.ov.activator.vpn.inventory.DelayedActivation) request.getAttribute(DelayedActivationConstants.DELAYEDACTIVATION_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String DAName = StringFacility.replaceAllByHTMLCharacter(beanDelayedActivation.getDaname());
                        
                                  
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
    <bean:message bundle="DelayedActivationApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="DelayedActivationApplicationResources" key="field.daname.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= DAName != null? DAName : "" %>
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
                            <%= NumberOfRetries != null? NumberOfRetries : "" %>
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
                            <%= Days != null? Days : "" %>
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
                            <%= Hours != null? Hours : "" %>
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
                            <%= Minutes != null? Minutes : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DelayedActivationApplicationResources" key="field.minutes.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitDelayedActivationAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="daname" value="<%= String.valueOf(DAName) %>"/>
              </html:form>
  </body>
</html>

