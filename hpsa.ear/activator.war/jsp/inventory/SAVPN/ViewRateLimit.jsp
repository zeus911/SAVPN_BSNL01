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

String refreshTree = (String) request.getAttribute(RateLimitConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="RateLimitApplicationResources" key="<%= RateLimitConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.RateLimit beanRateLimit = (com.hp.ov.activator.vpn.inventory.RateLimit) request.getAttribute(RateLimitConstants.RATELIMIT_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String RateLimitName = StringFacility.replaceAllByHTMLCharacter(beanRateLimit.getRatelimitname());
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanRateLimit.getDescription());
                      String BurstMaximum = "" + beanRateLimit.getBurstmaximum();
      BurstMaximum = (BurstMaximum != null && !(BurstMaximum.trim().equals(""))) ? nfA.format(beanRateLimit.getBurstmaximum()) : "";
                    if( beanRateLimit.getBurstmaximum()==Long.MIN_VALUE)
  BurstMaximum = "";
          String BurstNormal = "" + beanRateLimit.getBurstnormal();
      BurstNormal = (BurstNormal != null && !(BurstNormal.trim().equals(""))) ? nfA.format(beanRateLimit.getBurstnormal()) : "";
                    if( beanRateLimit.getBurstnormal()==Long.MIN_VALUE)
  BurstNormal = "";
          String AverageBW = "" + beanRateLimit.getAveragebw();
      AverageBW = (AverageBW != null && !(AverageBW.trim().equals(""))) ? nfA.format(beanRateLimit.getAveragebw()) : "";
                    if( beanRateLimit.getAveragebw()==Long.MIN_VALUE)
  AverageBW = "";
          String Compliant = StringFacility.replaceAllByHTMLCharacter(beanRateLimit.getCompliant());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="RateLimitApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="RateLimitApplicationResources" key="field.ratelimitname.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= RateLimitName != null? RateLimitName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="RateLimitApplicationResources" key="field.ratelimitname.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="RateLimitApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="RateLimitApplicationResources" key="field.description.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="RateLimitApplicationResources" key="field.burstmaximum.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= BurstMaximum != null? BurstMaximum : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="RateLimitApplicationResources" key="field.burstmaximum.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="RateLimitApplicationResources" key="field.burstnormal.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= BurstNormal != null? BurstNormal : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="RateLimitApplicationResources" key="field.burstnormal.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="RateLimitApplicationResources" key="field.averagebw.alias"/>
                          </table:cell>
            <table:cell>
            
              
                            <%= AverageBW != null? AverageBW : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="RateLimitApplicationResources" key="field.averagebw.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="RateLimitApplicationResources" key="field.compliant.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("compliant" ,"compliant");
                                            valueShowMap.put("partial compliant" ,"partial compliant");
                                            valueShowMap.put("non compliant" ,"non compliant");
                                          if(Compliant!=null)
                     Compliant=(String)valueShowMap.get(Compliant);
              %>
              <%= Compliant != null? Compliant : "" %>
                            </table:cell>
            <table:cell>
                      <bean:message bundle="RateLimitApplicationResources" key="field.compliant.description"/>
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
