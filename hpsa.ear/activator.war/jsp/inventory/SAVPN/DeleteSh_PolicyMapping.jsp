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
String datasource = (String) request.getParameter(Sh_PolicyMappingConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="Sh_PolicyMappingApplicationResources" key="<%= Sh_PolicyMappingConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.Sh_PolicyMappingForm.action = '/activator<%=moduleConfig%>/DeleteCommitSh_PolicyMappingAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_PolicyMappingForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="Sh_PolicyMappingApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.Sh_PolicyMapping beanSh_PolicyMapping = (com.hp.ov.activator.vpn.inventory.Sh_PolicyMapping) request.getAttribute(Sh_PolicyMappingConstants.SH_POLICYMAPPING_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String TClassName = StringFacility.replaceAllByHTMLCharacter(beanSh_PolicyMapping.getTclassname());
                        
                                  
                      String ProfileName = StringFacility.replaceAllByHTMLCharacter(beanSh_PolicyMapping.getProfilename());
                        
                                  
                      String Exp = StringFacility.replaceAllByHTMLCharacter(beanSh_PolicyMapping.getExp());
                        
                                  
                      String Dscp = StringFacility.replaceAllByHTMLCharacter(beanSh_PolicyMapping.getDscp());
                        
                                  
                      String Percentage = StringFacility.replaceAllByHTMLCharacter(beanSh_PolicyMapping.getPercentage());
                        
                                  
                      String Position = StringFacility.replaceAllByHTMLCharacter(beanSh_PolicyMapping.getPosition());
                        
                                  
                      String PLP = StringFacility.replaceAllByHTMLCharacter(beanSh_PolicyMapping.getPlp());
                        
                                  
                      String queueName = StringFacility.replaceAllByHTMLCharacter(beanSh_PolicyMapping.getQueuename());
                        
                                  
                      String CoSName = StringFacility.replaceAllByHTMLCharacter(beanSh_PolicyMapping.getCosname());
                        
                                  
                      String Marker = StringFacility.replaceAllByHTMLCharacter(beanSh_PolicyMapping.getMarker());
                        
                                  
                      String UploadStatus = StringFacility.replaceAllByHTMLCharacter(beanSh_PolicyMapping.getUploadstatus());
                        
                                  
                      String DBPrimaryKey = StringFacility.replaceAllByHTMLCharacter(beanSh_PolicyMapping.getDbprimarykey());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="Sh_PolicyMappingApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.tclassname.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= TClassName != null? TClassName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.tclassname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.profilename.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= ProfileName != null? ProfileName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.profilename.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.exp.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Exp != null? Exp : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.exp.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.dscp.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Dscp != null? Dscp : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.dscp.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.percentage.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Percentage != null? Percentage : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.percentage.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.position.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Position != null? Position : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.position.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.plp.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= PLP != null? PLP : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.plp.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.queuename.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= queueName != null? queueName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.queuename.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.cosname.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= CoSName != null? CoSName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.cosname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.marker.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Marker != null? Marker : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.marker.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.uploadstatus.alias"/>
                          </table:cell>
            <table:cell>
                            <%= UploadStatus != null? UploadStatus : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.uploadstatus.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.dbprimarykey.alias"/>
                          </table:cell>
            <table:cell>
                            <%= DBPrimaryKey != null? DBPrimaryKey : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_PolicyMappingApplicationResources" key="field.dbprimarykey.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitSh_PolicyMappingAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="profilename" value="<%= String.valueOf(ProfileName) %>"/>
                        <html:hidden property="tclassname" value="<%= String.valueOf(TClassName) %>"/>
              </html:form>
  </body>
</html>

