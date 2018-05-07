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
String datasource = (String) request.getParameter(NetworkAttachmentConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="NetworkAttachmentApplicationResources" key="<%= NetworkAttachmentConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.NetworkAttachmentForm.action = '/activator<%=moduleConfig%>/DeleteCommitNetworkAttachmentAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.NetworkAttachmentForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="NetworkAttachmentApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.cr.inventory.NetworkAttachment beanNetworkAttachment = (com.hp.ov.activator.cr.inventory.NetworkAttachment) request.getAttribute(NetworkAttachmentConstants.NETWORKATTACHMENT_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

          String NetworkElementId = (String) request.getAttribute(NetworkAttachmentConstants.NETWORKELEMENTID_LABEL);
      NetworkElementId = StringFacility.replaceAllByHTMLCharacter(NetworkElementId);
      String NetworkElementId_key = beanNetworkAttachment.getNetworkelementid();
      NetworkElementId_key = StringFacility.replaceAllByHTMLCharacter(NetworkElementId_key);
          
                                  
              String NetworkId = (String) request.getAttribute(NetworkAttachmentConstants.NETWORKID_LABEL);
      NetworkId = StringFacility.replaceAllByHTMLCharacter(NetworkId);
      String NetworkId_key = beanNetworkAttachment.getNetworkid();
      NetworkId_key = StringFacility.replaceAllByHTMLCharacter(NetworkId_key);
          
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="NetworkAttachmentApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="NetworkAttachmentApplicationResources" key="field.networkelementid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= NetworkElementId != null? NetworkElementId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="NetworkAttachmentApplicationResources" key="field.networkelementid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="NetworkAttachmentApplicationResources" key="field.networkid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= NetworkId != null? NetworkId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="NetworkAttachmentApplicationResources" key="field.networkid.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitNetworkAttachmentAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="networkelementid" value="<%= String.valueOf(NetworkElementId_key) %>"/>  
                        <html:hidden property="networkid" value="<%= String.valueOf(NetworkId_key) %>"/>  
              </html:form>
  </body>
</html>

