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
String datasource = (String) request.getParameter(Sh_L3VPNMembershipConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="<%= Sh_L3VPNMembershipConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.Sh_L3VPNMembershipForm.action = '/activator<%=moduleConfig%>/DeleteCommitSh_L3VPNMembershipAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_L3VPNMembershipForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.Sh_L3VPNMembership beanSh_L3VPNMembership = (com.hp.ov.activator.vpn.inventory.Sh_L3VPNMembership) request.getAttribute(Sh_L3VPNMembershipConstants.SH_L3VPNMEMBERSHIP_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String VPNId = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPNMembership.getVpnid());
                        
                                  
                      String SiteId = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPNMembership.getSiteid());
                        
                                  
                      String SiteName = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPNMembership.getSitename());
                        
                                  
                      String VPNName = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPNMembership.getVpnname());
                        
                                  
                      String Marker = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPNMembership.getMarker());
                        
                                  
                      String UploadStatus = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPNMembership.getUploadstatus());
                        
                                  
                      String DBPrimaryKey = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPNMembership.getDbprimarykey());
                        
                                  
                      String JoinDate = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPNMembership.getJoindate());
                        
                                  
                      String CustomerName = StringFacility.replaceAllByHTMLCharacter(beanSh_L3VPNMembership.getCustomername());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.vpnid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= VPNId != null? VPNId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.vpnid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.siteid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= SiteId != null? SiteId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.siteid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.sitename.alias"/>
                          </table:cell>
            <table:cell>
                            <%= SiteName != null? SiteName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.sitename.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.vpnname.alias"/>
                          </table:cell>
            <table:cell>
                            <%= VPNName != null? VPNName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.vpnname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.marker.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Marker != null? Marker : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.marker.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.uploadstatus.alias"/>
                          </table:cell>
            <table:cell>
                            <%= UploadStatus != null? UploadStatus : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.uploadstatus.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.dbprimarykey.alias"/>
                          </table:cell>
            <table:cell>
                            <%= DBPrimaryKey != null? DBPrimaryKey : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.dbprimarykey.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.joindate.alias"/>
                          </table:cell>
            <table:cell>
                            <%= JoinDate != null? JoinDate : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.joindate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.customername.alias"/>
                          </table:cell>
            <table:cell>
                            <%= CustomerName != null? CustomerName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_L3VPNMembershipApplicationResources" key="field.customername.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitSh_L3VPNMembershipAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="vpnid" value="<%= String.valueOf(VPNId) %>"/>
                        <html:hidden property="siteid" value="<%= String.valueOf(SiteId) %>"/>
              </html:form>
  </body>
</html>

