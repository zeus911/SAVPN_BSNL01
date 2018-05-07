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
String datasource = (String) request.getParameter(LSPConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="LSPApplicationResources" key="<%= LSPConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.LSPForm.action = '/activator<%=moduleConfig%>/DeleteCommitLSPAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.LSPForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="LSPApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.LSP beanLSP = (com.hp.ov.activator.vpn.inventory.LSP) request.getAttribute(LSPConstants.LSP_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String LSPId = StringFacility.replaceAllByHTMLCharacter(beanLSP.getLspid());
                        
                                  
                      String TunnelId = StringFacility.replaceAllByHTMLCharacter(beanLSP.getTunnelid());
                        
                                  
                      String headPE = StringFacility.replaceAllByHTMLCharacter(beanLSP.getHeadpe());
                        
                                  
                      String headPEName = StringFacility.replaceAllByHTMLCharacter(beanLSP.getHeadpename());
                        
                                  
                      String tailPE = StringFacility.replaceAllByHTMLCharacter(beanLSP.getTailpe());
                        
                                  
                      String tailPEName = StringFacility.replaceAllByHTMLCharacter(beanLSP.getTailpename());
                        
                                  
                      String headIP = StringFacility.replaceAllByHTMLCharacter(beanLSP.getHeadip());
                        
                                  
                      String tailIP = StringFacility.replaceAllByHTMLCharacter(beanLSP.getTailip());
                        
                                  
                      String headVPNIP = StringFacility.replaceAllByHTMLCharacter(beanLSP.getHeadvpnip());
                        
                                  
                      String tailVPNIP = StringFacility.replaceAllByHTMLCharacter(beanLSP.getTailvpnip());
                        
                                  
              String Bandwidth = (String) request.getAttribute(LSPConstants.BANDWIDTH_LABEL);
      Bandwidth = StringFacility.replaceAllByHTMLCharacter(Bandwidth);
      String Bandwidth_key = beanLSP.getBandwidth();
      Bandwidth_key = StringFacility.replaceAllByHTMLCharacter(Bandwidth_key);
          
                                  
                      String TerminationPointID = StringFacility.replaceAllByHTMLCharacter(beanLSP.getTerminationpointid());
                        
                                  
                      String ActivationState = StringFacility.replaceAllByHTMLCharacter(beanLSP.getActivationstate());
                        
                                  
                      String AdminState = StringFacility.replaceAllByHTMLCharacter(beanLSP.getAdminstate());
                        
                                  
                      String ActivationDate = StringFacility.replaceAllByHTMLCharacter(beanLSP.getActivationdate());
                        
                                  
                      String ModificationDate = StringFacility.replaceAllByHTMLCharacter(beanLSP.getModificationdate());
                        
                                  
                      String LSPProfileName = StringFacility.replaceAllByHTMLCharacter(beanLSP.getLspprofilename());
                        
                                  
                      String UsageMode = StringFacility.replaceAllByHTMLCharacter(beanLSP.getUsagemode());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="LSPApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="LSPApplicationResources" key="field.lspid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= LSPId != null? LSPId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPApplicationResources" key="field.lspid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.tunnelid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= TunnelId != null? TunnelId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPApplicationResources" key="field.tunnelid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.headpename.alias"/>
                          </table:cell>
            <table:cell>
                            <%= headPEName != null? headPEName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPApplicationResources" key="field.headpename.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.tailpename.alias"/>
                          </table:cell>
            <table:cell>
                            <%= tailPEName != null? tailPEName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPApplicationResources" key="field.tailpename.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.headip.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= headIP != null? headIP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPApplicationResources" key="field.headip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.tailip.alias"/>
                          </table:cell>
            <table:cell>
                            <%= tailIP != null? tailIP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPApplicationResources" key="field.tailip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.headvpnip.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= headVPNIP != null? headVPNIP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPApplicationResources" key="field.headvpnip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.tailvpnip.alias"/>
                          </table:cell>
            <table:cell>
                            <%= tailVPNIP != null? tailVPNIP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPApplicationResources" key="field.tailvpnip.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.bandwidth.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Bandwidth != null? Bandwidth : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPApplicationResources" key="field.bandwidth.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.activationstate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ActivationState != null? ActivationState : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPApplicationResources" key="field.activationstate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.adminstate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= AdminState != null? AdminState : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPApplicationResources" key="field.adminstate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.activationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ActivationDate != null? ActivationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPApplicationResources" key="field.activationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.modificationdate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ModificationDate != null? ModificationDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPApplicationResources" key="field.modificationdate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.lspprofilename.alias"/>
                          </table:cell>
            <table:cell>
                            <%= LSPProfileName != null? LSPProfileName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPApplicationResources" key="field.lspprofilename.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPApplicationResources" key="field.usagemode.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Service" ,"Service");
                                            valueShowMap.put("Manual" ,"Manual");
                                            valueShowMap.put("Aggregated" ,"Aggregated");
                                          if(UsageMode!=null)
                     UsageMode=(String)valueShowMap.get(UsageMode);
              %>
              <%= UsageMode != null? UsageMode : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPApplicationResources" key="field.usagemode.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitLSPAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="lspid" value="<%= String.valueOf(LSPId) %>"/>
              </html:form>
  </body>
</html>

