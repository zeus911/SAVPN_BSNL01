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

String refreshTree = (String) request.getAttribute(DL_VendorMappingConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="DL_VendorMappingApplicationResources" key="<%= DL_VendorMappingConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.cr.inventory.DL_VendorMapping beanDL_VendorMapping = (com.hp.ov.activator.cr.inventory.DL_VendorMapping) request.getAttribute(DL_VendorMappingConstants.DL_VENDORMAPPING_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String NNMi_Vendor = StringFacility.replaceAllByHTMLCharacter(beanDL_VendorMapping.getNnmi_vendor());
                  String HPSA_Vendor = (String) request.getAttribute(DL_VendorMappingConstants.HPSA_VENDOR_LABEL);
HPSA_Vendor= StringFacility.replaceAllByHTMLCharacter(HPSA_Vendor);
            %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_VendorMappingApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="DL_VendorMappingApplicationResources" key="field.nnmi_vendor.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= NNMi_Vendor != null? NNMi_Vendor : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_VendorMappingApplicationResources" key="field.nnmi_vendor.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="DL_VendorMappingApplicationResources" key="field.hpsa_vendor.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= HPSA_Vendor != null? HPSA_Vendor : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="DL_VendorMappingApplicationResources" key="field.hpsa_vendor.description"/>
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
