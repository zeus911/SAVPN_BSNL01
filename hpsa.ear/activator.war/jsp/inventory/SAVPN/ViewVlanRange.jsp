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

String refreshTree = (String) request.getAttribute(VlanRangeConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="VlanRangeApplicationResources" key="<%= VlanRangeConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.VlanRange beanVlanRange = (com.hp.ov.activator.vpn.inventory.VlanRange) request.getAttribute(VlanRangeConstants.VLANRANGE_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String VlanRangeID = StringFacility.replaceAllByHTMLCharacter(beanVlanRange.getVlanrangeid());
                      String Usage = StringFacility.replaceAllByHTMLCharacter(beanVlanRange.getUsage());
                      String Allocation = StringFacility.replaceAllByHTMLCharacter(beanVlanRange.getAllocation());
                      String StartValue = "" + beanVlanRange.getStartvalue();
              if( beanVlanRange.getStartvalue()==Integer.MIN_VALUE)
  StartValue = "";
                String EndValue = "" + beanVlanRange.getEndvalue();
              if( beanVlanRange.getEndvalue()==Integer.MIN_VALUE)
  EndValue = "";
                String Description = StringFacility.replaceAllByHTMLCharacter(beanVlanRange.getDescription());
                      String Region = StringFacility.replaceAllByHTMLCharacter(beanVlanRange.getRegion());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="VlanRangeApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="VlanRangeApplicationResources" key="field.usage.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Usage != null? Usage : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="VlanRangeApplicationResources" key="field.usage.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="VlanRangeApplicationResources" key="field.allocation.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("Internal" ,"Internal");
                                            valueShowMap.put("External" ,"External");
                                          if(Allocation!=null)
                     Allocation=(String)valueShowMap.get(Allocation);
              %>
              <%= Allocation != null? Allocation : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="VlanRangeApplicationResources" key="field.allocation.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="VlanRangeApplicationResources" key="field.startvalue.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= StartValue != null? StartValue : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="VlanRangeApplicationResources" key="field.startvalue.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="VlanRangeApplicationResources" key="field.endvalue.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= EndValue != null? EndValue : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="VlanRangeApplicationResources" key="field.endvalue.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="VlanRangeApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="VlanRangeApplicationResources" key="field.description.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="VlanRangeApplicationResources" key="field.region.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= Region != null? Region : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="VlanRangeApplicationResources" key="field.region.description"/>
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