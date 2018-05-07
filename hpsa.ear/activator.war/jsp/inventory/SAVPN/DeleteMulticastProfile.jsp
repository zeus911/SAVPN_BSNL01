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
String datasource = (String) request.getParameter(MulticastProfileConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="MulticastProfileApplicationResources" key="<%= MulticastProfileConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.MulticastProfileForm.action = '/activator<%=moduleConfig%>/DeleteCommitMulticastProfileAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.MulticastProfileForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="MulticastProfileApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.MulticastProfile beanMulticastProfile = (com.hp.ov.activator.vpn.inventory.MulticastProfile) request.getAttribute(MulticastProfileConstants.MULTICASTPROFILE_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String MCastProfileId = StringFacility.replaceAllByHTMLCharacter(beanMulticastProfile.getMcastprofileid());
                        
                                  
                      String VPNId = StringFacility.replaceAllByHTMLCharacter(beanMulticastProfile.getVpnid());
                        
                                  
                      String MulticastSource = StringFacility.replaceAllByHTMLCharacter(beanMulticastProfile.getMulticastsource());
                        
                                  
                      String MulticastGroup = StringFacility.replaceAllByHTMLCharacter(beanMulticastProfile.getMulticastgroup());
                        
                                  
              String Bandwidth = (String) request.getAttribute(MulticastProfileConstants.BANDWIDTH_LABEL);
      Bandwidth = StringFacility.replaceAllByHTMLCharacter(Bandwidth);
      String Bandwidth_key = beanMulticastProfile.getBandwidth();
      Bandwidth_key = StringFacility.replaceAllByHTMLCharacter(Bandwidth_key);
          
                                  
                      String CoS = StringFacility.replaceAllByHTMLCharacter(beanMulticastProfile.getCos());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="MulticastProfileApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="MulticastProfileApplicationResources" key="field.mcastprofileid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= MCastProfileId != null? MCastProfileId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.mcastprofileid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="MulticastProfileApplicationResources" key="field.vpnid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= VPNId != null? VPNId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.vpnid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastsource.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= MulticastSource != null? MulticastSource : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastsource.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastgroup.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= MulticastGroup != null? MulticastGroup : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastgroup.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="MulticastProfileApplicationResources" key="field.bandwidth.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Bandwidth != null? Bandwidth : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.bandwidth.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="MulticastProfileApplicationResources" key="field.cos.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= CoS != null? CoS : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.cos.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitMulticastProfileAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="multicastsource" value="<%= String.valueOf(MulticastSource) %>"/>
                        <html:hidden property="multicastgroup" value="<%= String.valueOf(MulticastGroup) %>"/>
                        <html:hidden property="vpnid" value="<%= String.valueOf(VPNId) %>"/>
              </html:form>
  </body>
</html>

