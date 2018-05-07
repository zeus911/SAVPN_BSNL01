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

String refreshTree = (String) request.getAttribute(Wo_DistConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="Wo_DistApplicationResources" key="<%= Wo_DistConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.Wo_Dist beanWo_Dist = (com.hp.ov.activator.vpn.inventory.Wo_Dist) request.getAttribute(Wo_DistConstants.WO_DIST_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String Manual = StringFacility.replaceAllByHTMLCharacter(beanWo_Dist.getManual());
                      String Email = StringFacility.replaceAllByHTMLCharacter(beanWo_Dist.getEmail());
                      String WebServer = StringFacility.replaceAllByHTMLCharacter(beanWo_Dist.getWebserver());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Wo_DistApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="Wo_DistApplicationResources" key="field.manual.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Manual != null? Manual : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="Wo_DistApplicationResources" key="field.manual.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Wo_DistApplicationResources" key="field.email.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("true" ,"true");
                                            valueShowMap.put("false" ,"false");
                                          if(Email!=null)
                     Email=(String)valueShowMap.get(Email);
              %>
              <%= Email != null? Email : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="Wo_DistApplicationResources" key="field.email.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="Wo_DistApplicationResources" key="field.webserver.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("true" ,"true");
                                            valueShowMap.put("false" ,"false");
                                          if(WebServer!=null)
                     WebServer=(String)valueShowMap.get(WebServer);
              %>
              <%= WebServer != null? WebServer : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="Wo_DistApplicationResources" key="field.webserver.description"/>
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
