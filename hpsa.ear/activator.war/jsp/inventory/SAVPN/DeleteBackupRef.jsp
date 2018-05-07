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
String datasource = (String) request.getParameter(BackupRefConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="BackupRefApplicationResources" key="<%= BackupRefConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.BackupRefForm.action = '/activator<%=moduleConfig%>/DeleteCommitBackupRefAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.BackupRefForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="BackupRefApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.BackupRef beanBackupRef = (com.hp.ov.activator.vpn.inventory.BackupRef) request.getAttribute(BackupRefConstants.BACKUPREF_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String eqid = StringFacility.replaceAllByHTMLCharacter(beanBackupRef.getEqid());
                        
                                  
                      String creationtime = (beanBackupRef.getCreationtime() == null) ? "" : beanBackupRef.getCreationtime();
        creationtime= StringFacility.replaceAllByHTMLCharacter(creationtime);
                            java.text.SimpleDateFormat sdfcreationtime = new java.text.SimpleDateFormat("dd-MM-yyyy");
                                String sdfcreationtimeDesc = "Format: [" + sdfcreationtime.toPattern() + "]. Example: [" + sdfcreationtime.format(new Date()) + "]";
                sdfcreationtimeDesc = StringFacility.replaceAllByHTMLCharacter(sdfcreationtimeDesc);
                  
                                  
                      String createdby = StringFacility.replaceAllByHTMLCharacter(beanBackupRef.getCreatedby());
                        
                                  
                      String configtime = (beanBackupRef.getConfigtime() == null) ? "" : beanBackupRef.getConfigtime();
        configtime= StringFacility.replaceAllByHTMLCharacter(configtime);
                            java.text.SimpleDateFormat sdfconfigtime = new java.text.SimpleDateFormat("dd-MM-yyyy");
                                String sdfconfigtimeDesc = "Format: [" + sdfconfigtime.toPattern() + "]. Example: [" + sdfconfigtime.format(new Date()) + "]";
                sdfconfigtimeDesc = StringFacility.replaceAllByHTMLCharacter(sdfconfigtimeDesc);
                  
                                  
                      String retrievalname = StringFacility.replaceAllByHTMLCharacter(beanBackupRef.getRetrievalname());
                        
                                  
                      String comments = StringFacility.replaceAllByHTMLCharacter(beanBackupRef.getComments());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="BackupRefApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="BackupRefApplicationResources" key="field.eqid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= eqid != null? eqid : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.eqid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="BackupRefApplicationResources" key="field.creationtime.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= creationtime != null? creationtime : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.creationtime.description"/>
              <%=sdfcreationtimeDesc%>                                                        </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="BackupRefApplicationResources" key="field.createdby.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= createdby != null? createdby : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.createdby.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="BackupRefApplicationResources" key="field.configtime.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= configtime != null? configtime : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.configtime.description"/>
              <%=sdfconfigtimeDesc%>                                                        </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="BackupRefApplicationResources" key="field.retrievalname.alias"/>
                          </table:cell>
            <table:cell>
                            <%= retrievalname != null? retrievalname : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.retrievalname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="BackupRefApplicationResources" key="field.comments.alias"/>
                          </table:cell>
            <table:cell>
                            <%= comments != null? comments : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.comments.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitBackupRefAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="creationtime" value="<%= String.valueOf(creationtime) %>"/>
                        <html:hidden property="eqid" value="<%= String.valueOf(eqid) %>"/>
              </html:form>
  </body>
</html>

