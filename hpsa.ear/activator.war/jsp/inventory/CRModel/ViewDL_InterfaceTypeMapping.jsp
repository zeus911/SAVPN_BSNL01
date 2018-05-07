<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.cr.inventory.*,
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

String refreshTree = (String) request.getAttribute(DL_InterfaceTypeMappingConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="<%= DL_InterfaceTypeMappingConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.cr.inventory.DL_InterfaceTypeMapping beanDL_InterfaceTypeMapping = (com.hp.ov.activator.cr.inventory.DL_InterfaceTypeMapping) request.getAttribute(DL_InterfaceTypeMappingConstants.DL_INTERFACETYPEMAPPING_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String Id = StringFacility.replaceAllByHTMLCharacter(beanDL_InterfaceTypeMapping.getId());
                      String ifType = StringFacility.replaceAllByHTMLCharacter(beanDL_InterfaceTypeMapping.getIftype());
                  String Vendor = (String) request.getAttribute(DL_InterfaceTypeMappingConstants.VENDOR_LABEL);
Vendor= StringFacility.replaceAllByHTMLCharacter(Vendor);
                  String ElementType_Regexp = StringFacility.replaceAllByHTMLCharacter(beanDL_InterfaceTypeMapping.getElementtype_regexp());
                      String OSVersion_Regexp = StringFacility.replaceAllByHTMLCharacter(beanDL_InterfaceTypeMapping.getOsversion_regexp());
                      String ifDescr_Regexp = StringFacility.replaceAllByHTMLCharacter(beanDL_InterfaceTypeMapping.getIfdescr_regexp());
                      String HPSAType = StringFacility.replaceAllByHTMLCharacter(beanDL_InterfaceTypeMapping.getHpsatype());
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanDL_InterfaceTypeMapping.getDescription());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.iftype.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= ifType != null? ifType : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.iftype.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.vendor.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Vendor != null? Vendor : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.vendor.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.elementtype_regexp.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= ElementType_Regexp != null? ElementType_Regexp : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.elementtype_regexp.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.osversion_regexp.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= OSVersion_Regexp != null? OSVersion_Regexp : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.osversion_regexp.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.ifdescr_regexp.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= ifDescr_Regexp != null? ifDescr_Regexp : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.ifdescr_regexp.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.hpsatype.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= HPSAType != null? HPSAType : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.hpsatype.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.description.description"/>
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
