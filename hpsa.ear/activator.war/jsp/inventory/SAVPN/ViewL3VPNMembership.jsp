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

String refreshTree = (String) request.getAttribute(L3VPNMembershipConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="L3VPNMembershipApplicationResources" key="<%= L3VPNMembershipConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.L3VPNMembership beanL3VPNMembership = (com.hp.ov.activator.vpn.inventory.L3VPNMembership) request.getAttribute(L3VPNMembershipConstants.L3VPNMEMBERSHIP_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String CustomerName = StringFacility.replaceAllByHTMLCharacter(beanL3VPNMembership.getCustomername());
                      String SiteName = StringFacility.replaceAllByHTMLCharacter(beanL3VPNMembership.getSitename());
                      String VPNName = StringFacility.replaceAllByHTMLCharacter(beanL3VPNMembership.getVpnname());
                      String JoinDate = StringFacility.replaceAllByHTMLCharacter(beanL3VPNMembership.getJoindate());
                      String VPNNameId = StringFacility.replaceAllByHTMLCharacter(beanL3VPNMembership.getVpnnameid());
                      String VPNId = StringFacility.replaceAllByHTMLCharacter(beanL3VPNMembership.getVpnid());
                      String ConnectivityType = StringFacility.replaceAllByHTMLCharacter(beanL3VPNMembership.getConnectivitytype());
                      String SiteNameId = StringFacility.replaceAllByHTMLCharacter(beanL3VPNMembership.getSitenameid());
                      String SiteId = StringFacility.replaceAllByHTMLCharacter(beanL3VPNMembership.getSiteid());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="L3VPNMembershipApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="L3VPNMembershipApplicationResources" key="field.customername.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= CustomerName != null? CustomerName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3VPNMembershipApplicationResources" key="field.customername.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3VPNMembershipApplicationResources" key="field.joindate.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= JoinDate != null? JoinDate : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3VPNMembershipApplicationResources" key="field.joindate.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3VPNMembershipApplicationResources" key="field.vpnnameid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= VPNNameId != null? VPNNameId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3VPNMembershipApplicationResources" key="field.vpnnameid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="L3VPNMembershipApplicationResources" key="field.sitenameid.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= SiteNameId != null? SiteNameId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="L3VPNMembershipApplicationResources" key="field.sitenameid.description"/>
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
