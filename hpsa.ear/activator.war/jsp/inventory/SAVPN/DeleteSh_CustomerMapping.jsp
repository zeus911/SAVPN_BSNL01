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
String datasource = (String) request.getParameter(Sh_CustomerMappingConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="Sh_CustomerMappingApplicationResources" key="<%= Sh_CustomerMappingConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.Sh_CustomerMappingForm.action = '/activator<%=moduleConfig%>/DeleteCommitSh_CustomerMappingAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_CustomerMappingForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="Sh_CustomerMappingApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.Sh_CustomerMapping beanSh_CustomerMapping = (com.hp.ov.activator.vpn.inventory.Sh_CustomerMapping) request.getAttribute(Sh_CustomerMappingConstants.SH_CUSTOMERMAPPING_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String Sh_CustomerId = StringFacility.replaceAllByHTMLCharacter(beanSh_CustomerMapping.getSh_customerid());
                        
                                  
                      String CustomerId = StringFacility.replaceAllByHTMLCharacter(beanSh_CustomerMapping.getCustomerid());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="Sh_CustomerMappingApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="Sh_CustomerMappingApplicationResources" key="field.sh_customerid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Sh_CustomerId != null? Sh_CustomerId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CustomerMappingApplicationResources" key="field.sh_customerid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CustomerMappingApplicationResources" key="field.customerid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= CustomerId != null? CustomerId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CustomerMappingApplicationResources" key="field.customerid.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitSh_CustomerMappingAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="sh_customerid" value="<%= String.valueOf(Sh_CustomerId) %>"/>
              </html:form>
  </body>
</html>

