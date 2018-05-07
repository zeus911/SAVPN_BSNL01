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
String datasource = (String) request.getParameter(Sh_RCMembershipConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="Sh_RCMembershipApplicationResources" key="<%= Sh_RCMembershipConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.Sh_RCMembershipForm.action = '/activator<%=moduleConfig%>/DeleteCommitSh_RCMembershipAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_RCMembershipForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="Sh_RCMembershipApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.Sh_RCMembership beanSh_RCMembership = (com.hp.ov.activator.vpn.inventory.Sh_RCMembership) request.getAttribute(Sh_RCMembershipConstants.SH_RCMEMBERSHIP_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String RCName = StringFacility.replaceAllByHTMLCharacter(beanSh_RCMembership.getRcname());
                        
                                  
                      String NE_ID = StringFacility.replaceAllByHTMLCharacter(beanSh_RCMembership.getNe_id());
                        
                                  
                      String VRFName = StringFacility.replaceAllByHTMLCharacter(beanSh_RCMembership.getVrfname());
                        
                                  
                      String Marker = StringFacility.replaceAllByHTMLCharacter(beanSh_RCMembership.getMarker());
                        
                                  
                      String UploadStatus = StringFacility.replaceAllByHTMLCharacter(beanSh_RCMembership.getUploadstatus());
                        
                                  
                      String DBPrimaryKey = StringFacility.replaceAllByHTMLCharacter(beanSh_RCMembership.getDbprimarykey());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="Sh_RCMembershipApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="Sh_RCMembershipApplicationResources" key="field.rcname.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= RCName != null? RCName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_RCMembershipApplicationResources" key="field.rcname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_RCMembershipApplicationResources" key="field.ne_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= NE_ID != null? NE_ID : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_RCMembershipApplicationResources" key="field.ne_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_RCMembershipApplicationResources" key="field.vrfname.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= VRFName != null? VRFName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_RCMembershipApplicationResources" key="field.vrfname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_RCMembershipApplicationResources" key="field.marker.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Marker != null? Marker : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_RCMembershipApplicationResources" key="field.marker.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_RCMembershipApplicationResources" key="field.uploadstatus.alias"/>
                          </table:cell>
            <table:cell>
                            <%= UploadStatus != null? UploadStatus : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_RCMembershipApplicationResources" key="field.uploadstatus.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_RCMembershipApplicationResources" key="field.dbprimarykey.alias"/>
                          </table:cell>
            <table:cell>
                            <%= DBPrimaryKey != null? DBPrimaryKey : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_RCMembershipApplicationResources" key="field.dbprimarykey.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitSh_RCMembershipAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="rcname" value="<%= String.valueOf(RCName) %>"/>
                        <html:hidden property="ne_id" value="<%= String.valueOf(NE_ID) %>"/>
                        <html:hidden property="vrfname" value="<%= String.valueOf(VRFName) %>"/>
              </html:form>
  </body>
</html>

