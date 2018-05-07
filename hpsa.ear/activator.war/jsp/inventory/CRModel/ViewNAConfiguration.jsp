<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.na.common.*,
        com.hp.ov.activator.inventory.CRModel.*,
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

String refreshTree = (String) request.getAttribute(NAConfigurationConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="NAConfigurationApplicationResources" key="<%= NAConfigurationConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.na.common.NAConfiguration beanNAConfiguration = (com.hp.ov.activator.na.common.NAConfiguration) request.getAttribute(NAConfigurationConstants.NACONFIGURATION_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      boolean enable_proxy = new Boolean(beanNAConfiguration.getEnable_proxy()).booleanValue();
                      String Id = StringFacility.replaceAllByHTMLCharacter(beanNAConfiguration.getId());
                      String proxy_hostname = StringFacility.replaceAllByHTMLCharacter(beanNAConfiguration.getProxy_hostname());
                      String proxy_port = StringFacility.replaceAllByHTMLCharacter(beanNAConfiguration.getProxy_port());
                      String proxy_username = StringFacility.replaceAllByHTMLCharacter(beanNAConfiguration.getProxy_username());
                      String proxy_password = StringFacility.replaceAllByHTMLCharacter(beanNAConfiguration.getProxy_password());
                      boolean cl_protocol = new Boolean(beanNAConfiguration.getCl_protocol()).booleanValue();
                      String cl_hostname = StringFacility.replaceAllByHTMLCharacter(beanNAConfiguration.getCl_hostname());
                      String cl_port = StringFacility.replaceAllByHTMLCharacter(beanNAConfiguration.getCl_port());
                      String cl_username = StringFacility.replaceAllByHTMLCharacter(beanNAConfiguration.getCl_username());
                      String cl_password = StringFacility.replaceAllByHTMLCharacter(beanNAConfiguration.getCl_password());
                      boolean enable_cl = new Boolean(beanNAConfiguration.getEnable_cl()).booleanValue();
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="NAConfigurationApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="NAConfigurationApplicationResources" key="field.enable_proxy.alias"/>
                                *
                          </table:cell>
            <table:cell>
              <%= enable_proxy %>
            </table:cell>
            <table:cell>
              <bean:message bundle="NAConfigurationApplicationResources" key="field.enable_proxy.description"/>
            </table:cell>
          </table:row>
                                                 
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_hostname.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= proxy_hostname != null? proxy_hostname : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_hostname.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_port.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= proxy_port != null? proxy_port : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_port.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_username.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= proxy_username != null? proxy_username : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_username.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_password.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= proxy_password != null && !proxy_password.equals("")? "**********" : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NAConfigurationApplicationResources" key="field.proxy_password.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                    <table:row>
            <table:cell>  
              <bean:message bundle="NAConfigurationApplicationResources" key="field.cl_protocol.alias"/>
                          </table:cell>
            <table:cell>
              <%= cl_protocol %>
            </table:cell>
            <table:cell>
              <bean:message bundle="NAConfigurationApplicationResources" key="field.cl_protocol.description"/>
            </table:cell>
          </table:row>
                                                 
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NAConfigurationApplicationResources" key="field.cl_hostname.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= cl_hostname != null? cl_hostname : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NAConfigurationApplicationResources" key="field.cl_hostname.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="NAConfigurationApplicationResources" key="field.cl_port.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= cl_port != null? cl_port : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="NAConfigurationApplicationResources" key="field.cl_port.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                                 
                                                 
                    <table:row>
            <table:cell>  
              <bean:message bundle="NAConfigurationApplicationResources" key="field.enable_cl.alias"/>
                                *
                          </table:cell>
            <table:cell>
              <%= enable_cl %>
            </table:cell>
            <table:cell>
              <bean:message bundle="NAConfigurationApplicationResources" key="field.enable_cl.description"/>
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
