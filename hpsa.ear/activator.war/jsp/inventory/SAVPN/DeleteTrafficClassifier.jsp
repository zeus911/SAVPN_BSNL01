<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors,
        com.hp.ov.activator.inventory.facilities.StringFacility " %>

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
%>

<%
/** For Struts module concept **/
org.apache.struts.config.ModuleConfig strutsModuleConfig =
            org.apache.struts.util.ModuleUtils.getInstance().getModuleConfig(null,
                (HttpServletRequest) pageContext.getRequest(),
                pageContext.getServletContext()); 
// module name that can be used as solution name               
String moduleConfig = strutsModuleConfig.getPrefix();
%>

<%
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(TrafficClassifierConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="TrafficClassifierApplicationResources" key="<%= TrafficClassifierConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.TrafficClassifierForm.action = '/activator<%=moduleConfig%>/DeleteCommitTrafficClassifierAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.TrafficClassifierForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="TrafficClassifierApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.TrafficClassifier beanTrafficClassifier = (com.hp.ov.activator.vpn.inventory.TrafficClassifier) request.getAttribute(TrafficClassifierConstants.TRAFFICCLASSIFIER_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String Name = StringFacility.replaceAllByHTMLCharacter(beanTrafficClassifier.getName());
                        
                                  
                      String CustomerId = StringFacility.replaceAllByHTMLCharacter(beanTrafficClassifier.getCustomerid());
                        
                                  
                      String Layer = StringFacility.replaceAllByHTMLCharacter(beanTrafficClassifier.getLayer());
                        
                                  
                      String DSCPs = StringFacility.replaceAllByHTMLCharacter(beanTrafficClassifier.getDscps());
                        
                                  
                      String Filter = StringFacility.replaceAllByHTMLCharacter(beanTrafficClassifier.getFilter());
                        
                                  
                      String CoSs = StringFacility.replaceAllByHTMLCharacter(beanTrafficClassifier.getCoss());
                        
                                  
                      String Compliant = StringFacility.replaceAllByHTMLCharacter(beanTrafficClassifier.getCompliant());
                        
                                  
                      String AddressFamily = StringFacility.replaceAllByHTMLCharacter(beanTrafficClassifier.getAddressfamily());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="TrafficClassifierApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.name.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.customerid.alias"/>
                          </table:cell>
            <table:cell>
                            <%= CustomerId != null? CustomerId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.customerid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.layer.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("layer 3" ,"layer 3");
                                            valueShowMap.put("layer 2" ,"layer 2");
                                          if(Layer!=null)
                     Layer=(String)valueShowMap.get(Layer);
              %>
              <%= Layer != null? Layer : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.layer.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.dscps.alias"/>
                          </table:cell>
            <table:cell>
                            <%= DSCPs != null? DSCPs : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.dscps.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.filter.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Filter != null? Filter : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.filter.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.coss.alias"/>
                          </table:cell>
            <table:cell>
                            <%= CoSs != null? CoSs : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.coss.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.compliant.alias"/>
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
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.compliant.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.addressfamily.alias"/>
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("IPv4" ,"IPv4");
                                            valueShowMap.put("IPv6" ,"IPv6");
                                          if(AddressFamily!=null)
                     AddressFamily=(String)valueShowMap.get(AddressFamily);
              %>
              <%= AddressFamily != null? AddressFamily : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.addressfamily.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitTrafficClassifierAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="name" value="<%= String.valueOf(Name) %>"/>
              </html:form>
  </body>
</html>

