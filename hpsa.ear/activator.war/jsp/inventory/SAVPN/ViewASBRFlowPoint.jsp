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

String refreshTree = (String) request.getAttribute(ASBRFlowPointConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="ASBRFlowPointApplicationResources" key="<%= ASBRFlowPointConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.ASBRFlowPoint beanASBRFlowPoint = (com.hp.ov.activator.vpn.inventory.ASBRFlowPoint) request.getAttribute(ASBRFlowPointConstants.ASBRFLOWPOINT_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String TerminationPointId = StringFacility.replaceAllByHTMLCharacter(beanASBRFlowPoint.getTerminationpointid());
                      String ASBRServiceId = StringFacility.replaceAllByHTMLCharacter(beanASBRFlowPoint.getAsbrserviceid());
                      String VRFName = StringFacility.replaceAllByHTMLCharacter(beanASBRFlowPoint.getVrfname());
                      String QoSProfile_in = StringFacility.replaceAllByHTMLCharacter(beanASBRFlowPoint.getQosprofile_in());
                      String QoSProfile_out = StringFacility.replaceAllByHTMLCharacter(beanASBRFlowPoint.getQosprofile_out());
                      String RateLimit_in = StringFacility.replaceAllByHTMLCharacter(beanASBRFlowPoint.getRatelimit_in());
                      String RateLimit_out = StringFacility.replaceAllByHTMLCharacter(beanASBRFlowPoint.getRatelimit_out());
                      String Protocol = StringFacility.replaceAllByHTMLCharacter(beanASBRFlowPoint.getProtocol());
                      String PE_InterfaceIP = StringFacility.replaceAllByHTMLCharacter(beanASBRFlowPoint.getPe_interfaceip());
                      String CE_InterfaceIP = StringFacility.replaceAllByHTMLCharacter(beanASBRFlowPoint.getCe_interfaceip());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="ASBRFlowPointApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="ASBRFlowPointApplicationResources" key="field.terminationpointid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= TerminationPointId != null? TerminationPointId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRFlowPointApplicationResources" key="field.terminationpointid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRFlowPointApplicationResources" key="field.asbrserviceid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= ASBRServiceId != null? ASBRServiceId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRFlowPointApplicationResources" key="field.asbrserviceid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRFlowPointApplicationResources" key="field.vrfname.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VRFName != null? VRFName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRFlowPointApplicationResources" key="field.vrfname.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRFlowPointApplicationResources" key="field.qosprofile_in.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= QoSProfile_in != null? QoSProfile_in : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRFlowPointApplicationResources" key="field.qosprofile_in.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRFlowPointApplicationResources" key="field.qosprofile_out.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= QoSProfile_out != null? QoSProfile_out : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRFlowPointApplicationResources" key="field.qosprofile_out.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRFlowPointApplicationResources" key="field.ratelimit_in.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= RateLimit_in != null? RateLimit_in : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRFlowPointApplicationResources" key="field.ratelimit_in.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRFlowPointApplicationResources" key="field.ratelimit_out.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= RateLimit_out != null? RateLimit_out : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRFlowPointApplicationResources" key="field.ratelimit_out.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRFlowPointApplicationResources" key="field.protocol.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Protocol != null? Protocol : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRFlowPointApplicationResources" key="field.protocol.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRFlowPointApplicationResources" key="field.pe_interfaceip.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= PE_InterfaceIP != null? PE_InterfaceIP : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRFlowPointApplicationResources" key="field.pe_interfaceip.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRFlowPointApplicationResources" key="field.ce_interfaceip.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= CE_InterfaceIP != null? CE_InterfaceIP : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRFlowPointApplicationResources" key="field.ce_interfaceip.description"/>
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
