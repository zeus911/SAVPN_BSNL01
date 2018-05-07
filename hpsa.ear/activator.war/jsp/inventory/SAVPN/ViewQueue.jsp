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

String refreshTree = (String) request.getAttribute(QueueConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="QueueApplicationResources" key="<%= QueueConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.Queue beanQueue = (com.hp.ov.activator.vpn.inventory.Queue) request.getAttribute(QueueConstants.QUEUE_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String Name = StringFacility.replaceAllByHTMLCharacter(beanQueue.getName());
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanQueue.getType());
                      String State = StringFacility.replaceAllByHTMLCharacter(beanQueue.getState());
                      String EmailServer = StringFacility.replaceAllByHTMLCharacter(beanQueue.getEmailserver());
                      String NB_Service = StringFacility.replaceAllByHTMLCharacter(beanQueue.getNb_service());
                      String SleepTime = "" + beanQueue.getSleeptime();
      SleepTime = (SleepTime != null && !(SleepTime.trim().equals(""))) ? nfA.format(beanQueue.getSleeptime()) : "";
              if( beanQueue.getSleeptime()==Integer.MIN_VALUE)
  SleepTime = "";
          %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="QueueApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="QueueApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="QueueApplicationResources" key="field.name.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="QueueApplicationResources" key="field.type.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Workorder" ,"Workorder");
                                            valueShowMap.put("NA" ,"NA");
                                            valueShowMap.put("NNM" ,"NNM");
                                          if(Type!=null)
                     Type=(String)valueShowMap.get(Type);
              %>
              <%= Type != null? Type : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="QueueApplicationResources" key="field.type.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="QueueApplicationResources" key="field.state.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("active" ,"active");
                                            valueShowMap.put("disabled" ,"disabled");
                                            valueShowMap.put("suspended" ,"suspended");
                                          if(State!=null)
                     State=(String)valueShowMap.get(State);
              %>
              <%= State != null? State : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="QueueApplicationResources" key="field.state.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="QueueApplicationResources" key="field.emailserver.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= EmailServer != null? EmailServer : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="QueueApplicationResources" key="field.emailserver.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="QueueApplicationResources" key="field.sleeptime.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= SleepTime != null? SleepTime : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="QueueApplicationResources" key="field.sleeptime.description"/>
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
