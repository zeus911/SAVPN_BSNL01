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
String datasource = (String) request.getParameter(LSPProfileConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="LSPProfileApplicationResources" key="<%= LSPProfileConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.LSPProfileForm.action = '/activator<%=moduleConfig%>/DeleteCommitLSPProfileAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.LSPProfileForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="LSPProfileApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.LSPProfile beanLSPProfile = (com.hp.ov.activator.vpn.inventory.LSPProfile) request.getAttribute(LSPProfileConstants.LSPPROFILE_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String LSPProfileName = StringFacility.replaceAllByHTMLCharacter(beanLSPProfile.getLspprofilename());
                        
                                  
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanLSPProfile.getType());
                        
                                  
                      String CT = StringFacility.replaceAllByHTMLCharacter(beanLSPProfile.getCt());
                        
                                  
                      String bwAllocation = StringFacility.replaceAllByHTMLCharacter(beanLSPProfile.getBwallocation());
                        
                                  
                      String bwAlgorithm = StringFacility.replaceAllByHTMLCharacter(beanLSPProfile.getBwalgorithm());
                        
                                  
                      String CoS = StringFacility.replaceAllByHTMLCharacter(beanLSPProfile.getCos());
                        
                                  
                      String LSPFilter = StringFacility.replaceAllByHTMLCharacter(beanLSPProfile.getLspfilter());
                        
                                  
                      String LSPProfileVersion = StringFacility.replaceAllByHTMLCharacter(beanLSPProfile.getLspprofileversion());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="LSPProfileApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="LSPProfileApplicationResources" key="field.lspprofilename.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= LSPProfileName != null? LSPProfileName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.lspprofilename.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPProfileApplicationResources" key="field.type.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("VPN" ,"VPN");
                                          if(Type!=null)
                     Type=(String)valueShowMap.get(Type);
              %>
              <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.type.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPProfileApplicationResources" key="field.ct.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("ct0" ,"ct0");
                                            valueShowMap.put("ct1" ,"ct1");
                                            valueShowMap.put("ct2" ,"ct2");
                                            valueShowMap.put("ct3" ,"ct3");
                                          if(CT!=null)
                     CT=(String)valueShowMap.get(CT);
              %>
              <%= CT != null? CT : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.ct.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPProfileApplicationResources" key="field.bwallocation.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("manual" ,"manual");
                                            valueShowMap.put("auto" ,"auto");
                                          if(bwAllocation!=null)
                     bwAllocation=(String)valueShowMap.get(bwAllocation);
              %>
              <%= bwAllocation != null? bwAllocation : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.bwallocation.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPProfileApplicationResources" key="field.bwalgorithm.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Sum" ,"Sum");
                                            valueShowMap.put("manual" ,"manual");
                                          if(bwAlgorithm!=null)
                     bwAlgorithm=(String)valueShowMap.get(bwAlgorithm);
              %>
              <%= bwAlgorithm != null? bwAlgorithm : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.bwalgorithm.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPProfileApplicationResources" key="field.cos.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= CoS != null? CoS : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.cos.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPProfileApplicationResources" key="field.lspfilter.alias"/>
                          </table:cell>
            <table:cell>
                            <%= LSPFilter != null? LSPFilter : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.lspfilter.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="LSPProfileApplicationResources" key="field.lspprofileversion.alias"/>
                          </table:cell>
            <table:cell>
                            <%= LSPProfileVersion != null? LSPProfileVersion : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.lspprofileversion.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitLSPProfileAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="lspprofilename" value="<%= String.valueOf(LSPProfileName) %>"/>
              </html:form>
  </body>
</html>

