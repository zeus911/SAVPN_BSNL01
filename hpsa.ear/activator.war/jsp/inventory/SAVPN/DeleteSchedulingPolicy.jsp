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
String datasource = (String) request.getParameter(SchedulingPolicyConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="SchedulingPolicyApplicationResources" key="<%= SchedulingPolicyConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.SchedulingPolicyForm.action = '/activator<%=moduleConfig%>/DeleteCommitSchedulingPolicyAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.SchedulingPolicyForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="SchedulingPolicyApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.SchedulingPolicy beanSchedulingPolicy = (com.hp.ov.activator.vpn.inventory.SchedulingPolicy) request.getAttribute(SchedulingPolicyConstants.SCHEDULINGPOLICY_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String SchedulingPolicyName = StringFacility.replaceAllByHTMLCharacter(beanSchedulingPolicy.getSchedulingpolicyname());
                        
                                  
                      String StartingTime = (beanSchedulingPolicy.getStartingtime() == null) ? "" : beanSchedulingPolicy.getStartingtime();
        StartingTime= StringFacility.replaceAllByHTMLCharacter(StartingTime);
                            java.text.SimpleDateFormat sdfStartingTime = new java.text.SimpleDateFormat("dd-MM-yyyy");
                                String sdfStartingTimeDesc = "Format: [" + sdfStartingTime.toPattern() + "]. Example: [" + sdfStartingTime.format(new Date()) + "]";
                sdfStartingTimeDesc = StringFacility.replaceAllByHTMLCharacter(sdfStartingTimeDesc);
                  
                                  
                        String Periodicity = "" + beanSchedulingPolicy.getPeriodicity();
                      Periodicity = (Periodicity != null && !(Periodicity.trim().equals(""))) ? nfA.format(beanSchedulingPolicy.getPeriodicity()) : "";
                          
                  if( beanSchedulingPolicy.getPeriodicity()==Integer.MIN_VALUE)
         Periodicity = "";
                            
                        String RefreshInterval = "" + beanSchedulingPolicy.getRefreshinterval();
                      RefreshInterval = (RefreshInterval != null && !(RefreshInterval.trim().equals(""))) ? nfA.format(beanSchedulingPolicy.getRefreshinterval()) : "";
                          
                  if( beanSchedulingPolicy.getRefreshinterval()==Integer.MIN_VALUE)
         RefreshInterval = "";
                            
                        String BackupsNumber = "" + beanSchedulingPolicy.getBackupsnumber();
                      BackupsNumber = (BackupsNumber != null && !(BackupsNumber.trim().equals(""))) ? nfA.format(beanSchedulingPolicy.getBackupsnumber()) : "";
                          
                  if( beanSchedulingPolicy.getBackupsnumber()==Integer.MIN_VALUE)
         BackupsNumber = "";
                            
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="SchedulingPolicyApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="SchedulingPolicyApplicationResources" key="field.schedulingpolicyname.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= SchedulingPolicyName != null? SchedulingPolicyName : "" %>
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
                            <%= StartingTime != null? StartingTime : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="SchedulingPolicyApplicationResources" key="field.startingtime.description"/>
              <%=sdfStartingTimeDesc%>                                                        </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="SchedulingPolicyApplicationResources" key="field.periodicity.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Periodicity != null? Periodicity : "" %>
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
                            <%= RefreshInterval != null? RefreshInterval : "" %>
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
                            <%= BackupsNumber != null? BackupsNumber : "" %>
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
    </table:table>
    </div>

    <html:form action="/DeleteCommitSchedulingPolicyAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="schedulingpolicyname" value="<%= String.valueOf(SchedulingPolicyName) %>"/>
              </html:form>
  </body>
</html>

