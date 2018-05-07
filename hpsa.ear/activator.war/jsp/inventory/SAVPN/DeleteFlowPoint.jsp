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
String datasource = (String) request.getParameter(FlowPointConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="FlowPointApplicationResources" key="<%= FlowPointConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.FlowPointForm.action = '/activator<%=moduleConfig%>/DeleteCommitFlowPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.FlowPointForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="FlowPointApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.FlowPoint beanFlowPoint = (com.hp.ov.activator.vpn.inventory.FlowPoint) request.getAttribute(FlowPointConstants.FLOWPOINT_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String TerminationPointId = StringFacility.replaceAllByHTMLCharacter(beanFlowPoint.getTerminationpointid());
                        
                                  
                      String AttachmentId = StringFacility.replaceAllByHTMLCharacter(beanFlowPoint.getAttachmentid());
                        
                                  
                      String QoSProfile_in = StringFacility.replaceAllByHTMLCharacter(beanFlowPoint.getQosprofile_in());
                        
                                  
                      String QoSProfile_out = StringFacility.replaceAllByHTMLCharacter(beanFlowPoint.getQosprofile_out());
                        
                                  
                      boolean QoSChildEnabled = new Boolean(beanFlowPoint.getQoschildenabled()).booleanValue();
                  
                                  
                      String RateLimit_in = StringFacility.replaceAllByHTMLCharacter(beanFlowPoint.getRatelimit_in());
                        
                                  
                      String RateLimit_out = StringFacility.replaceAllByHTMLCharacter(beanFlowPoint.getRatelimit_out());
                        
                                  
                      String UsageMode = StringFacility.replaceAllByHTMLCharacter(beanFlowPoint.getUsagemode());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="FlowPointApplicationResources" key="jsp.delete.title"/>
</h2> 

<%

boolean TerminationPointIdPass_TerminationPointId = false ;
TerminationPointIdPass_TerminationPointId = java.util.regex.Pattern.compile("^\\S+$").matcher(TerminationPointId).matches();
boolean showTerminationPointId = false;
  if (true && TerminationPointIdPass_TerminationPointId ){
showTerminationPointId = true;
}


boolean AttachmentIdPass_AttachmentId = false ;
AttachmentIdPass_AttachmentId = java.util.regex.Pattern.compile("^\\S+$").matcher(AttachmentId).matches();
boolean showAttachmentId = false;
  if (true && AttachmentIdPass_AttachmentId ){
showAttachmentId = true;
}


boolean QoSProfile_inPass_QoSProfile_in = false ;
QoSProfile_inPass_QoSProfile_in = java.util.regex.Pattern.compile("^\\S+$").matcher(QoSProfile_in).matches();
boolean showQoSProfile_in = false;
  if (true && QoSProfile_inPass_QoSProfile_in ){
showQoSProfile_in = true;
}


boolean QoSProfile_outPass_QoSProfile_out = false ;
QoSProfile_outPass_QoSProfile_out = java.util.regex.Pattern.compile("^\\S+$").matcher(QoSProfile_out).matches();
boolean showQoSProfile_out = false;
  if (true && QoSProfile_outPass_QoSProfile_out ){
showQoSProfile_out = true;
}


boolean RateLimit_inPass_RateLimit_in = false ;
RateLimit_inPass_RateLimit_in = java.util.regex.Pattern.compile("^\\S+$").matcher(RateLimit_in).matches();
boolean showRateLimit_in = false;
  if (true && RateLimit_inPass_RateLimit_in ){
showRateLimit_in = true;
}


boolean RateLimit_outPass_RateLimit_out = false ;
RateLimit_outPass_RateLimit_out = java.util.regex.Pattern.compile("^\\S+$").matcher(RateLimit_out).matches();
boolean showRateLimit_out = false;
  if (true && RateLimit_outPass_RateLimit_out ){
showRateLimit_out = true;
}

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
      
      <%if(showTerminationPointId){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="FlowPointApplicationResources" key="field.terminationpointid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= TerminationPointId != null? TerminationPointId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="FlowPointApplicationResources" key="field.terminationpointid.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showAttachmentId){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="FlowPointApplicationResources" key="field.attachmentid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= AttachmentId != null? AttachmentId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="FlowPointApplicationResources" key="field.attachmentid.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showQoSProfile_in){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="FlowPointApplicationResources" key="field.qosprofile_in.alias"/>
                          </table:cell>
            <table:cell>
                            <%= QoSProfile_in != null? QoSProfile_in : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="FlowPointApplicationResources" key="field.qosprofile_in.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showQoSProfile_out){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="FlowPointApplicationResources" key="field.qosprofile_out.alias"/>
                          </table:cell>
            <table:cell>
                            <%= QoSProfile_out != null? QoSProfile_out : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="FlowPointApplicationResources" key="field.qosprofile_out.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                          <table:row>
            <table:cell>  
              <bean:message bundle="FlowPointApplicationResources" key="field.qoschildenabled.alias"/>
                          </table:cell>
            <table:cell>
              <%= QoSChildEnabled %>
            </table:cell>
            <table:cell>
              <bean:message bundle="FlowPointApplicationResources" key="field.qoschildenabled.description"/>
            </table:cell>
          </table:row>
                                         <%if(showRateLimit_in){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="FlowPointApplicationResources" key="field.ratelimit_in.alias"/>
                          </table:cell>
            <table:cell>
                            <%= RateLimit_in != null? RateLimit_in : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="FlowPointApplicationResources" key="field.ratelimit_in.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>      <%if(showRateLimit_out){%>                                <table:row>
            <table:cell>  
              <bean:message bundle="FlowPointApplicationResources" key="field.ratelimit_out.alias"/>
                          </table:cell>
            <table:cell>
                            <%= RateLimit_out != null? RateLimit_out : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="FlowPointApplicationResources" key="field.ratelimit_out.description"/>
                                                                      </table:cell>
          </table:row>
                                             <%}%>                                      <table:row>
            <table:cell>  
              <bean:message bundle="FlowPointApplicationResources" key="field.usagemode.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Service" ,"Service");
                                            valueShowMap.put("Aggregated" ,"Aggregated");
                                          if(UsageMode!=null)
                     UsageMode=(String)valueShowMap.get(UsageMode);
              %>
              <%= UsageMode != null? UsageMode : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="FlowPointApplicationResources" key="field.usagemode.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitFlowPointAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="terminationpointid" value="<%= String.valueOf(TerminationPointId) %>"/>
              </html:form>
  </body>
</html>

