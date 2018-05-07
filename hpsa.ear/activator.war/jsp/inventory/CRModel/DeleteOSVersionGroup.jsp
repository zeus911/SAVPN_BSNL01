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
String datasource = (String) request.getParameter(OSVersionGroupConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="OSVersionGroupApplicationResources" key="<%= OSVersionGroupConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.OSVersionGroupForm.action = '/activator<%=moduleConfig%>/DeleteCommitOSVersionGroupAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.OSVersionGroupForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="OSVersionGroupApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.cr.inventory.OSVersionGroup beanOSVersionGroup = (com.hp.ov.activator.cr.inventory.OSVersionGroup) request.getAttribute(OSVersionGroupConstants.OSVERSIONGROUP_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String OSVersionGroupName = StringFacility.replaceAllByHTMLCharacter(beanOSVersionGroup.getOsversiongroupname());
                        
                                  
              String Vendor = (String) request.getAttribute(OSVersionGroupConstants.VENDOR_LABEL);
      Vendor = StringFacility.replaceAllByHTMLCharacter(Vendor);
      String Vendor_key = beanOSVersionGroup.getVendor();
      Vendor_key = StringFacility.replaceAllByHTMLCharacter(Vendor_key);
          
                                  
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanOSVersionGroup.getDescription());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="OSVersionGroupApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="OSVersionGroupApplicationResources" key="field.osversiongroupname.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= OSVersionGroupName != null? OSVersionGroupName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="OSVersionGroupApplicationResources" key="field.osversiongroupname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="OSVersionGroupApplicationResources" key="field.vendor.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Vendor != null? Vendor : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="OSVersionGroupApplicationResources" key="field.vendor.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="OSVersionGroupApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="OSVersionGroupApplicationResources" key="field.description.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitOSVersionGroupAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="osversiongroupname" value="<%= String.valueOf(OSVersionGroupName) %>"/>
              </html:form>
  </body>
</html>

