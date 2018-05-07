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

String refreshTree = (String) request.getAttribute(igw_trunkConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="igw_trunkApplicationResources" key="<%= igw_trunkConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.igw_trunk beanigw_trunk = (com.hp.ov.activator.vpn.inventory.igw_trunk) request.getAttribute(igw_trunkConstants.IGW_TRUNK_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String TRUNK_ID = StringFacility.replaceAllByHTMLCharacter(beanigw_trunk.getTrunk_id());
                      String TRUNKTYPE_ID = StringFacility.replaceAllByHTMLCharacter(beanigw_trunk.getTrunktype_id());
                      String NAME = StringFacility.replaceAllByHTMLCharacter(beanigw_trunk.getName());
                      String LINK_TYPE = StringFacility.replaceAllByHTMLCharacter(beanigw_trunk.getLink_type());
                      String STATUS = StringFacility.replaceAllByHTMLCharacter(beanigw_trunk.getStatus());
                      String SUBMIT_DATA = StringFacility.replaceAllByHTMLCharacter(beanigw_trunk.getSubmit_data());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="igw_trunkApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="igw_trunkApplicationResources" key="field.trunk_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= TRUNK_ID != null? TRUNK_ID : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="igw_trunkApplicationResources" key="field.trunk_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="igw_trunkApplicationResources" key="field.trunktype_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= TRUNKTYPE_ID != null? TRUNKTYPE_ID : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="igw_trunkApplicationResources" key="field.trunktype_id.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="igw_trunkApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= NAME != null? NAME : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="igw_trunkApplicationResources" key="field.name.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="igw_trunkApplicationResources" key="field.link_type.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= LINK_TYPE != null? LINK_TYPE : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="igw_trunkApplicationResources" key="field.link_type.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="igw_trunkApplicationResources" key="field.status.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= STATUS != null? STATUS : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="igw_trunkApplicationResources" key="field.status.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="igw_trunkApplicationResources" key="field.submit_data.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= SUBMIT_DATA != null? SUBMIT_DATA : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="igw_trunkApplicationResources" key="field.submit_data.description"/>
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
