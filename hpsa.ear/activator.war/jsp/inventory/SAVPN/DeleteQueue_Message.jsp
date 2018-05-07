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
String datasource = (String) request.getParameter(Queue_MessageConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="Queue_MessageApplicationResources" key="<%= Queue_MessageConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.Queue_MessageForm.action = '/activator<%=moduleConfig%>/DeleteCommitQueue_MessageAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Queue_MessageForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="Queue_MessageApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.Queue_Message beanQueue_Message = (com.hp.ov.activator.vpn.inventory.Queue_Message) request.getAttribute(Queue_MessageConstants.QUEUE_MESSAGE_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String MessageId = StringFacility.replaceAllByHTMLCharacter(beanQueue_Message.getMessageid());
                        
                                  
                      String QueueName = StringFacility.replaceAllByHTMLCharacter(beanQueue_Message.getQueuename());
                        
                                  
                      String MessageState = StringFacility.replaceAllByHTMLCharacter(beanQueue_Message.getMessagestate());
                        
                                  
                      String Destination = StringFacility.replaceAllByHTMLCharacter(beanQueue_Message.getDestination());
                        
                                  
                      String MessageName = StringFacility.replaceAllByHTMLCharacter(beanQueue_Message.getMessagename());
                        
                                  
                      String Message = StringFacility.replaceAllByHTMLCharacter(beanQueue_Message.getMessage());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="Queue_MessageApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="Queue_MessageApplicationResources" key="field.messageid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= MessageId != null? MessageId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Queue_MessageApplicationResources" key="field.messageid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Queue_MessageApplicationResources" key="field.queuename.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= QueueName != null? QueueName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Queue_MessageApplicationResources" key="field.queuename.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Queue_MessageApplicationResources" key="field.messagestate.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= MessageState != null? MessageState : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Queue_MessageApplicationResources" key="field.messagestate.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Queue_MessageApplicationResources" key="field.destination.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Destination != null? Destination : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Queue_MessageApplicationResources" key="field.destination.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Queue_MessageApplicationResources" key="field.messagename.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= MessageName != null? MessageName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="Queue_MessageApplicationResources" key="field.messagename.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="Queue_MessageApplicationResources" key="field.message.alias"/>
                          </table:cell>
            <table:cell>
                              <%= Message == null ? "" : (Message.length() <= 200 ? Message : (Message.substring(0, 200) + "<span style='font:italic'> ... [Truncated]</span>")) %>              
                          </table:cell>
            <table:cell>
              <bean:message bundle="Queue_MessageApplicationResources" key="field.message.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitQueue_MessageAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="messageid" value="<%= String.valueOf(MessageId) %>"/>
              </html:form>
  </body>
</html>

