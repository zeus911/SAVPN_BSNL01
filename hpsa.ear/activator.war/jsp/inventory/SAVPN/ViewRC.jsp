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

String refreshTree = (String) request.getAttribute(RCConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="RCApplicationResources" key="<%= RCConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.RC beanRC = (com.hp.ov.activator.vpn.inventory.RC) request.getAttribute(RCConstants.RC_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String RCName = StringFacility.replaceAllByHTMLCharacter(beanRC.getRcname());
                      String VPNName = StringFacility.replaceAllByHTMLCharacter(beanRC.getVpnname());
                      String L3VPNId = StringFacility.replaceAllByHTMLCharacter(beanRC.getL3vpnid());
                      String ASN = StringFacility.replaceAllByHTMLCharacter(beanRC.getAsn());
                      String RTExport = StringFacility.replaceAllByHTMLCharacter(beanRC.getRtexport());
                      String RTImport = StringFacility.replaceAllByHTMLCharacter(beanRC.getRtimport());
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanRC.getType());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="RCApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="RCApplicationResources" key="field.rcname.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= RCName != null? RCName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="RCApplicationResources" key="field.rcname.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="RCApplicationResources" key="field.vpnname.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VPNName != null? VPNName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="RCApplicationResources" key="field.vpnname.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="RCApplicationResources" key="field.rtexport.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= RTExport != null? RTExport : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="RCApplicationResources" key="field.rtexport.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="RCApplicationResources" key="field.rtimport.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= RTImport != null? RTImport : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="RCApplicationResources" key="field.rtimport.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="RCApplicationResources" key="field.type.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("mesh" ,"mesh");
                                            valueShowMap.put("hub" ,"hub");
                                            valueShowMap.put("spoke" ,"spoke");
                                            valueShowMap.put("multicast" ,"multicast");
                                          if(Type!=null)
                     Type=(String)valueShowMap.get(Type);
              %>
              <%= Type != null? Type : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="RCApplicationResources" key="field.type.description"/>
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
