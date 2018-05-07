<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        org.apache.struts.action.ActionErrors,
        java.text.NumberFormat,
com.hp.ov.activator.cr.inventory.Network,
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
//System.out.println("refreshTreeRimid:"+refreshTreeRimid );

String refreshTree = (String) request.getAttribute(ASBRAccessFlowConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="ASBRAccessFlowApplicationResources" key="<%= ASBRAccessFlowConstants.JSP_VIEW_TITLE %>"/></title>
 
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

com.hp.ov.activator.vpn.inventory.ASBRAccessFlow beanASBRAccessFlow = (com.hp.ov.activator.vpn.inventory.ASBRAccessFlow) request.getAttribute(ASBRAccessFlowConstants.ASBRACCESSFLOW_BEAN);

com.hp.ov.activator.cr.inventory.Network beanNW1 = (com.hp.ov.activator.cr.inventory.Network) request.getAttribute("Network1");
com.hp.ov.activator.cr.inventory.Network beanNW2 = (com.hp.ov.activator.cr.inventory.Network) request.getAttribute("Network2");
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

      String ASBRServiceId = StringFacility.replaceAllByHTMLCharacter(beanASBRAccessFlow.getAsbrserviceid());
              
                                
                      String ConnectionID = StringFacility.replaceAllByHTMLCharacter(beanASBRAccessFlow.getConnectionid());
              
                                
                      String VPNId = StringFacility.replaceAllByHTMLCharacter(beanASBRAccessFlow.getVpnid());
              
                                
                      String NetworkId1 = StringFacility.replaceAllByHTMLCharacter(beanASBRAccessFlow.getNetworkid1());
              
                                
                      String Topology1 = StringFacility.replaceAllByHTMLCharacter(beanASBRAccessFlow.getTopology1());
              
                                
                      String NetworkId2 = StringFacility.replaceAllByHTMLCharacter(beanASBRAccessFlow.getNetworkid2());
              
                                
                      String Topology2 = StringFacility.replaceAllByHTMLCharacter(beanASBRAccessFlow.getTopology2());
              
                                
                      String VlanId = StringFacility.replaceAllByHTMLCharacter(beanASBRAccessFlow.getVlanid());
              
                                
                      String IPNet = StringFacility.replaceAllByHTMLCharacter(beanASBRAccessFlow.getIpnet());
              
                                
                      String Netmask = StringFacility.replaceAllByHTMLCharacter(beanASBRAccessFlow.getNetmask());
              
                                
                      String Status = StringFacility.replaceAllByHTMLCharacter(beanASBRAccessFlow.getStatus());
              
String NW1_Name = StringFacility.replaceAllByHTMLCharacter(beanNW1.getName());
String NW2_Name = StringFacility.replaceAllByHTMLCharacter(beanNW2.getName());

                                
    
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="ASBRAccessFlowApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.asbrserviceid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= ASBRServiceId != null? ASBRServiceId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.asbrserviceid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.connectionid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= ConnectionID != null? ConnectionID : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.connectionid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.vpnid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= VPNId != null? VPNId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.vpnid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
<bean:message bundle="ASBRAccessFlowApplicationResources" key="field.network1.alias"/>
                          </table:cell>
            <table:cell>
            
              
<%=( NetworkId1 != null)&&(!NW1_Name.equals(""))? NW1_Name +" ("+ NetworkId1+ ")" : "" %>
                          </table:cell>
            <table:cell>
<bean:message bundle="ASBRAccessFlowApplicationResources" key="field.network1.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.topology1.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Topology1 != null? Topology1 : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.topology1.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
<bean:message bundle="ASBRAccessFlowApplicationResources" key="field.network2.alias"/>
                          </table:cell>
            <table:cell>
            
              
<%= (NetworkId2 != null)&&(!NW2_Name.equals(""))? NW2_Name +" ("+ NetworkId2+ ")"  : "" %>
                          </table:cell>
            <table:cell>
<bean:message bundle="ASBRAccessFlowApplicationResources" key="field.network2.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.topology2.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Topology2 != null? Topology2 : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.topology2.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.vlanid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VlanId != null? VlanId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.vlanid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.ipnet.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= IPNet != null? IPNet : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.ipnet.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.netmask.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Netmask != null? Netmask : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.netmask.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.status.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Status != null? Status : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.status.description"/>
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
