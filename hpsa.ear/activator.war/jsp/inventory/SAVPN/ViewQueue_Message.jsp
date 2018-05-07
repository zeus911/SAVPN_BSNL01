<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        org.apache.struts.action.ActionErrors,
        java.text.NumberFormat,
                com.hp.ov.activator.inventory.facilities.StringFacility" %>

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

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";

String refreshTreeRimid=(String) request.getParameter("refreshTreeRimid");

String refreshTree = (String) request.getAttribute(Queue_MessageConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="Queue_MessageApplicationResources" key="<%= Queue_MessageConstants.JSP_VIEW_TITLE %>"/></title>
 
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function init()
    {
<%
if ( refreshTree != null && refreshTree.equalsIgnoreCase("true") ) {
%>
      parent.document.getElementById("ifr" + "<%=refreshTreeRimid%>").contentWindow.checkRefresh();
<%
}
%>
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
                      String Message = beanQueue_Message.getMessage();
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Queue_MessageApplicationResources" key="jsp.view.title"/>
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
            
              
                              <html:textarea disabled="true" property="message" rows="10" value="<%= Message == null ? \"\" : Message %>" style="resize:true; width:100%; color:#000000; background:transparent; border:0px solid;" />
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

  </body>
</html>
