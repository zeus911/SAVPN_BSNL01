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
String datasource = (String) request.getParameter(ServiceMultiplexConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="ServiceMultiplexApplicationResources" key="<%= ServiceMultiplexConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.ServiceMultiplexForm.action = '/activator<%=moduleConfig%>/DeleteCommitServiceMultiplexAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.ServiceMultiplexForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="ServiceMultiplexApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.ServiceMultiplex beanServiceMultiplex = (com.hp.ov.activator.vpn.inventory.ServiceMultiplex) request.getAttribute(ServiceMultiplexConstants.SERVICEMULTIPLEX_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String ServiceMultiplexId = StringFacility.replaceAllByHTMLCharacter(beanServiceMultiplex.getServicemultiplexid());
                        
                                  
              String Vendor = (String) request.getAttribute(ServiceMultiplexConstants.VENDOR_LABEL);
      Vendor = StringFacility.replaceAllByHTMLCharacter(Vendor);
      String Vendor_key = beanServiceMultiplex.getVendor();
      Vendor_key = StringFacility.replaceAllByHTMLCharacter(Vendor_key);
          
                                  
              String CardType = (String) request.getAttribute(ServiceMultiplexConstants.CARDTYPE_LABEL);
      CardType = StringFacility.replaceAllByHTMLCharacter(CardType);
      String CardType_key = beanServiceMultiplex.getCardtype();
      CardType_key = StringFacility.replaceAllByHTMLCharacter(CardType_key);
          
                                  
                      String ExistingServiceType = StringFacility.replaceAllByHTMLCharacter(beanServiceMultiplex.getExistingservicetype());
                        
                                  
                      String RequestedServiceType = StringFacility.replaceAllByHTMLCharacter(beanServiceMultiplex.getRequestedservicetype());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="ServiceMultiplexApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="ServiceMultiplexApplicationResources" key="field.servicemultiplexid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= ServiceMultiplexId != null? ServiceMultiplexId : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ServiceMultiplexApplicationResources" key="field.servicemultiplexid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="ServiceMultiplexApplicationResources" key="field.vendor.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Vendor != null? Vendor : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ServiceMultiplexApplicationResources" key="field.vendor.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="ServiceMultiplexApplicationResources" key="field.cardtype.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= CardType != null? CardType : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ServiceMultiplexApplicationResources" key="field.cardtype.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="ServiceMultiplexApplicationResources" key="field.existingservicetype.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("L2VPN" ,"L2VPN");
                                            valueShowMap.put("L2VPWS" ,"L2VPWS");
                                            valueShowMap.put("L3VPN" ,"L3VPN");
                                          if(ExistingServiceType!=null)
                     ExistingServiceType=(String)valueShowMap.get(ExistingServiceType);
              %>
              <%= ExistingServiceType != null? ExistingServiceType : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ServiceMultiplexApplicationResources" key="field.existingservicetype.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="ServiceMultiplexApplicationResources" key="field.requestedservicetype.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("L2VPN" ,"L2VPN");
                                            valueShowMap.put("L2VPWS" ,"L2VPWS");
                                            valueShowMap.put("L3VPN" ,"L3VPN");
                                          if(RequestedServiceType!=null)
                     RequestedServiceType=(String)valueShowMap.get(RequestedServiceType);
              %>
              <%= RequestedServiceType != null? RequestedServiceType : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="ServiceMultiplexApplicationResources" key="field.requestedservicetype.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitServiceMultiplexAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="servicemultiplexid" value="<%= String.valueOf(ServiceMultiplexId) %>"/>
              </html:form>
  </body>
</html>

