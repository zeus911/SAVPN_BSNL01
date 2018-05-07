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

String refreshTree = (String) request.getAttribute(Sh_TMNConnectionConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="Sh_TMNConnectionApplicationResources" key="<%= Sh_TMNConnectionConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.Sh_TMNConnection beanSh_TMNConnection = (com.hp.ov.activator.vpn.inventory.Sh_TMNConnection) request.getAttribute(Sh_TMNConnectionConstants.SH_TMNCONNECTION_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String ConnectionID = StringFacility.replaceAllByHTMLCharacter(beanSh_TMNConnection.getConnectionid());
                      String NetworkID1 = StringFacility.replaceAllByHTMLCharacter(beanSh_TMNConnection.getNetworkid1());
                      String NetworkID2 = StringFacility.replaceAllByHTMLCharacter(beanSh_TMNConnection.getNetworkid2());
                      String NE1 = StringFacility.replaceAllByHTMLCharacter(beanSh_TMNConnection.getNe1());
                      String TP1 = StringFacility.replaceAllByHTMLCharacter(beanSh_TMNConnection.getTp1());
                      String NE2 = StringFacility.replaceAllByHTMLCharacter(beanSh_TMNConnection.getNe2());
                      String TP2 = StringFacility.replaceAllByHTMLCharacter(beanSh_TMNConnection.getTp2());
                      String Marker = StringFacility.replaceAllByHTMLCharacter(beanSh_TMNConnection.getMarker());
                      String UploadStatus = StringFacility.replaceAllByHTMLCharacter(beanSh_TMNConnection.getUploadstatus());
                      String DBPrimaryKey = StringFacility.replaceAllByHTMLCharacter(beanSh_TMNConnection.getDbprimarykey());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_TMNConnectionApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.connectionid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= ConnectionID != null? ConnectionID : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.connectionid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.networkid1.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NetworkID1 != null? NetworkID1 : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.networkid1.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.networkid2.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NetworkID2 != null? NetworkID2 : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.networkid2.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.ne1.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NE1 != null? NE1 : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.ne1.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.tp1.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= TP1 != null? TP1 : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.tp1.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.ne2.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= NE2 != null? NE2 : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.ne2.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.tp2.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= TP2 != null? TP2 : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.tp2.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.marker.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Marker != null? Marker : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.marker.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.uploadstatus.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= UploadStatus != null? UploadStatus : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.uploadstatus.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.dbprimarykey.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= DBPrimaryKey != null? DBPrimaryKey : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Sh_TMNConnectionApplicationResources" key="field.dbprimarykey.description"/>
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
