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
String datasource = (String) request.getParameter(Sh_CEFlowPointConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="Sh_CEFlowPointApplicationResources" key="<%= Sh_CEFlowPointConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.Sh_CEFlowPointForm.action = '/activator<%=moduleConfig%>/DeleteCommitSh_CEFlowPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_CEFlowPointForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="Sh_CEFlowPointApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.Sh_CEFlowPoint beanSh_CEFlowPoint = (com.hp.ov.activator.vpn.inventory.Sh_CEFlowPoint) request.getAttribute(Sh_CEFlowPointConstants.SH_CEFLOWPOINT_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String TerminationPointID = StringFacility.replaceAllByHTMLCharacter(beanSh_CEFlowPoint.getTerminationpointid());
                        
                                  
                      String AttachmentId = StringFacility.replaceAllByHTMLCharacter(beanSh_CEFlowPoint.getAttachmentid());
                        
                                  
                      String QoSProfile_in = StringFacility.replaceAllByHTMLCharacter(beanSh_CEFlowPoint.getQosprofile_in());
                        
                                  
                      String QoSProfile_out = StringFacility.replaceAllByHTMLCharacter(beanSh_CEFlowPoint.getQosprofile_out());
                        
                                  
                      String RateLimit_in = StringFacility.replaceAllByHTMLCharacter(beanSh_CEFlowPoint.getRatelimit_in());
                        
                                  
                      String RateLimit_out = StringFacility.replaceAllByHTMLCharacter(beanSh_CEFlowPoint.getRatelimit_out());
                        
                                  
                      String Marker = StringFacility.replaceAllByHTMLCharacter(beanSh_CEFlowPoint.getMarker());
                        
                                  
                      String UploadStatus = StringFacility.replaceAllByHTMLCharacter(beanSh_CEFlowPoint.getUploadstatus());
                        
                                  
                      String DBPrimaryKey = StringFacility.replaceAllByHTMLCharacter(beanSh_CEFlowPoint.getDbprimarykey());
                        
                                  
                      String NE_ID = StringFacility.replaceAllByHTMLCharacter(beanSh_CEFlowPoint.getNe_id());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="Sh_CEFlowPointApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.terminationpointid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= TerminationPointID != null? TerminationPointID : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.terminationpointid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.attachmentid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= AttachmentId != null? AttachmentId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.attachmentid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.qosprofile_in.alias"/>
                          </table:cell>
            <table:cell>
                            <%= QoSProfile_in != null? QoSProfile_in : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.qosprofile_in.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.qosprofile_out.alias"/>
                          </table:cell>
            <table:cell>
                            <%= QoSProfile_out != null? QoSProfile_out : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.qosprofile_out.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ratelimit_in.alias"/>
                          </table:cell>
            <table:cell>
                            <%= RateLimit_in != null? RateLimit_in : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ratelimit_in.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ratelimit_out.alias"/>
                          </table:cell>
            <table:cell>
                            <%= RateLimit_out != null? RateLimit_out : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ratelimit_out.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.marker.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Marker != null? Marker : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.marker.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.uploadstatus.alias"/>
                          </table:cell>
            <table:cell>
                            <%= UploadStatus != null? UploadStatus : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.uploadstatus.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.dbprimarykey.alias"/>
                          </table:cell>
            <table:cell>
                            <%= DBPrimaryKey != null? DBPrimaryKey : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.dbprimarykey.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ne_id.alias"/>
                          </table:cell>
            <table:cell>
                            <%= NE_ID != null? NE_ID : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Sh_CEFlowPointApplicationResources" key="field.ne_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitSh_CEFlowPointAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="terminationpointid" value="<%= String.valueOf(TerminationPointID) %>"/>
              </html:form>
  </body>
</html>

