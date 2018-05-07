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
String datasource = (String) request.getParameter(OSVersionConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="OSVersionApplicationResources" key="<%= OSVersionConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.OSVersionForm.action = '/activator<%=moduleConfig%>/DeleteCommitOSVersionAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.OSVersionForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="OSVersionApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.cr.inventory.OSVersion beanOSVersion = (com.hp.ov.activator.cr.inventory.OSVersion) request.getAttribute(OSVersionConstants.OSVERSION_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String OSVersionName = StringFacility.replaceAllByHTMLCharacter(beanOSVersion.getOsversionname());
                        
                                  
              String OSVersionGroup = (String) request.getAttribute(OSVersionConstants.OSVERSIONGROUP_LABEL);
      OSVersionGroup = StringFacility.replaceAllByHTMLCharacter(OSVersionGroup);
      String OSVersionGroup_key = beanOSVersion.getOsversiongroup();
      OSVersionGroup_key = StringFacility.replaceAllByHTMLCharacter(OSVersionGroup_key);
          
                                  
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanOSVersion.getDescription());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="OSVersionApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="OSVersionApplicationResources" key="field.osversionname.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= OSVersionName != null? OSVersionName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="OSVersionApplicationResources" key="field.osversionname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="OSVersionApplicationResources" key="field.osversiongroup.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= OSVersionGroup != null? OSVersionGroup : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="OSVersionApplicationResources" key="field.osversiongroup.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="OSVersionApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="OSVersionApplicationResources" key="field.description.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitOSVersionAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="osversionname" value="<%= String.valueOf(OSVersionName) %>"/>
              </html:form>
  </body>
</html>

