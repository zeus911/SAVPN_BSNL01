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
String datasource = (String) request.getParameter(RetrievalPolicyConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="RetrievalPolicyApplicationResources" key="<%= RetrievalPolicyConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.RetrievalPolicyForm.action = '/activator<%=moduleConfig%>/DeleteCommitRetrievalPolicyAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.RetrievalPolicyForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="RetrievalPolicyApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.RetrievalPolicy beanRetrievalPolicy = (com.hp.ov.activator.vpn.inventory.RetrievalPolicy) request.getAttribute(RetrievalPolicyConstants.RETRIEVALPOLICY_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String RetrievalPolicyName = StringFacility.replaceAllByHTMLCharacter(beanRetrievalPolicy.getRetrievalpolicyname());
                        
                                  
                      String FirstMethod = StringFacility.replaceAllByHTMLCharacter(beanRetrievalPolicy.getFirstmethod());
                        
                                  
                      String SecondMethod = StringFacility.replaceAllByHTMLCharacter(beanRetrievalPolicy.getSecondmethod());
                        
                                  
                      String ThirdMethod = StringFacility.replaceAllByHTMLCharacter(beanRetrievalPolicy.getThirdmethod());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="RetrievalPolicyApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="RetrievalPolicyApplicationResources" key="field.retrievalpolicyname.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= RetrievalPolicyName != null? RetrievalPolicyName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="RetrievalPolicyApplicationResources" key="field.retrievalpolicyname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="RetrievalPolicyApplicationResources" key="field.firstmethod.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= FirstMethod != null? FirstMethod : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="RetrievalPolicyApplicationResources" key="field.firstmethod.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="RetrievalPolicyApplicationResources" key="field.secondmethod.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= SecondMethod != null? SecondMethod : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="RetrievalPolicyApplicationResources" key="field.secondmethod.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="RetrievalPolicyApplicationResources" key="field.thirdmethod.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= ThirdMethod != null? ThirdMethod : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="RetrievalPolicyApplicationResources" key="field.thirdmethod.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitRetrievalPolicyAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="retrievalpolicyname" value="<%= String.valueOf(RetrievalPolicyName) %>"/>
              </html:form>
  </body>
</html>

