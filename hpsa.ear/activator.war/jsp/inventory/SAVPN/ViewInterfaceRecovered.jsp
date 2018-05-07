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

String refreshTree = (String) request.getAttribute(InterfaceRecoveredConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="InterfaceRecoveredApplicationResources" key="<%= InterfaceRecoveredConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.InterfaceRecovered beanInterfaceRecovered = (com.hp.ov.activator.vpn.inventory.InterfaceRecovered) request.getAttribute(InterfaceRecoveredConstants.INTERFACERECOVERED_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String SourceTPID = StringFacility.replaceAllByHTMLCharacter(beanInterfaceRecovered.getSourcetpid());
                      String TargetTPID = StringFacility.replaceAllByHTMLCharacter(beanInterfaceRecovered.getTargettpid());
                      String Total = "" + beanInterfaceRecovered.getTotal();
      Total = (Total != null && !(Total.trim().equals(""))) ? nfA.format(beanInterfaceRecovered.getTotal()) : "";
              if( beanInterfaceRecovered.getTotal()==Integer.MIN_VALUE)
  Total = "";
                String Success = "" + beanInterfaceRecovered.getSuccess();
      Success = (Success != null && !(Success.trim().equals(""))) ? nfA.format(beanInterfaceRecovered.getSuccess()) : "";
              if( beanInterfaceRecovered.getSuccess()==Integer.MIN_VALUE)
  Success = "";
                String Failed = "" + beanInterfaceRecovered.getFailed();
      Failed = (Failed != null && !(Failed.trim().equals(""))) ? nfA.format(beanInterfaceRecovered.getFailed()) : "";
              if( beanInterfaceRecovered.getFailed()==Integer.MIN_VALUE)
  Failed = "";
          %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="InterfaceRecoveredApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.sourcetpid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= SourceTPID != null? SourceTPID : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.sourcetpid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.targettpid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= TargetTPID != null? TargetTPID : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.targettpid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.total.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Total != null? Total : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.total.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.success.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Success != null? Success : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.success.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.failed.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Failed != null? Failed : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.failed.description"/>
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
