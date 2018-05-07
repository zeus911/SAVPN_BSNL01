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
String datasource = (String) request.getParameter(ISPConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="ISPApplicationResources" key="<%= ISPConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.ISPForm.action = '/activator<%=moduleConfig%>/DeleteCommitISPAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.ISPForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="ISPApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.ISP beanISP = (com.hp.ov.activator.vpn.inventory.ISP) request.getAttribute(ISPConstants.ISP_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String IDName = StringFacility.replaceAllByHTMLCharacter(beanISP.getIdname());
                        
                                  
                      String SPName = StringFacility.replaceAllByHTMLCharacter(beanISP.getSpname());
                        
                                  
                      String IP = StringFacility.replaceAllByHTMLCharacter(beanISP.getIp());
                        
                                  
                      String BackupDirectory = StringFacility.replaceAllByHTMLCharacter(beanISP.getBackupdirectory());
                        
                                  
                      String ASN = StringFacility.replaceAllByHTMLCharacter(beanISP.getAsn());
                        
                                  
                      boolean AdminVPNEnabled = new Boolean(beanISP.getAdminvpnenabled()).booleanValue();
                  
                                  
                      String ErrorQueue = StringFacility.replaceAllByHTMLCharacter(beanISP.getErrorqueue());
                        
                                  
                      String NotificationQueue = StringFacility.replaceAllByHTMLCharacter(beanISP.getNotificationqueue());
                        
                                  
                      String ConfirmationQueue = StringFacility.replaceAllByHTMLCharacter(beanISP.getConfirmationqueue());
                        
                                  
                      String TimedServiceQueue = StringFacility.replaceAllByHTMLCharacter(beanISP.getTimedservicequeue());
                        
                                  
                        String Timeout = "" + beanISP.getTimeout();
                      Timeout = (Timeout != null && !(Timeout.trim().equals(""))) ? nfA.format(beanISP.getTimeout()) : "";
                          
                  if( beanISP.getTimeout()==Integer.MIN_VALUE)
         Timeout = "";
                            
                      String Version = StringFacility.replaceAllByHTMLCharacter(beanISP.getVersion());
                        
                                  
                      boolean DemoMode = new Boolean(beanISP.getDemomode()).booleanValue();
                  
                                  
                      String NAParentGroupName = StringFacility.replaceAllByHTMLCharacter(beanISP.getNaparentgroupname());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="ISPApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="ISPApplicationResources" key="field.idname.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= IDName != null? IDName : "" %>
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
                            <%= SPName != null? SPName : "" %>
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
                            <%= IP != null? IP : "" %>
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
                            <%= BackupDirectory != null? BackupDirectory : "" %>
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
                            <%= ASN != null? ASN : "" %>
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
              <%= AdminVPNEnabled %>
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
                            <%= ErrorQueue != null? ErrorQueue : "" %>
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
                            <%= NotificationQueue != null? NotificationQueue : "" %>
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
                            <%= ConfirmationQueue != null? ConfirmationQueue : "" %>
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
                            <%= TimedServiceQueue != null? TimedServiceQueue : "" %>
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
                            <%= Timeout != null? Timeout : "" %>
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
                            <%= Version != null? Version : "" %>
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
              <%= DemoMode %>
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
                            <%= NAParentGroupName != null? NAParentGroupName : "" %>
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
    </table:table>
    </div>

    <html:form action="/DeleteCommitISPAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="idname" value="<%= String.valueOf(IDName) %>"/>
              </html:form>
  </body>
</html>

