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
String datasource = (String) request.getParameter(IPAddrPoolConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="IPAddrPoolApplicationResources" key="<%= IPAddrPoolConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.IPAddrPoolForm.action = '/activator<%=moduleConfig%>/DeleteCommitIPAddrPoolAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.IPAddrPoolForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="IPAddrPoolApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.IPAddrPool beanIPAddrPool = (com.hp.ov.activator.vpn.inventory.IPAddrPool) request.getAttribute(IPAddrPoolConstants.IPADDRPOOL_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String Name = StringFacility.replaceAllByHTMLCharacter(beanIPAddrPool.getName());
                        
                                  
                      String IPNet = StringFacility.replaceAllByHTMLCharacter(beanIPAddrPool.getIpnet());
                        
                                  
                      String Mask = StringFacility.replaceAllByHTMLCharacter(beanIPAddrPool.getMask());
                        
                                  
                      String IPNetAddress = StringFacility.replaceAllByHTMLCharacter(beanIPAddrPool.getIpnetaddress());
                        
                                  
                      String Type = StringFacility.replaceAllByHTMLCharacter(beanIPAddrPool.getType());
                        
                                  
                      String AddressFamily = StringFacility.replaceAllByHTMLCharacter(beanIPAddrPool.getAddressfamily());
                        
                                  
                      boolean isDynamic = new Boolean(beanIPAddrPool.getIsdynamic()).booleanValue();
                  
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="IPAddrPoolApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="IPAddrPoolApplicationResources" key="field.name.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Name != null? Name : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="IPAddrPoolApplicationResources" key="field.name.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                                                                     <table:row>
            <table:cell>  
              <bean:message bundle="IPAddrPoolApplicationResources" key="field.ipnetaddress.alias"/>
                          </table:cell>
            <table:cell>
                            <%= IPNetAddress != null? IPNetAddress : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="IPAddrPoolApplicationResources" key="field.ipnetaddress.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="IPAddrPoolApplicationResources" key="field.type.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%
                  java.util.HashMap<Object,Object>  valueShowMap=new java.util.HashMap<Object,Object> ();
                                            valueShowMap.put("LSP" ,"LSP");
                                            valueShowMap.put("IPNet" ,"IPNet");
                                            valueShowMap.put("IPHost" ,"IPHost");
                                            valueShowMap.put("MDT Default" ,"MDT Default");
                                            valueShowMap.put("MDT Data" ,"MDT Data");
                                            valueShowMap.put("Multicast loopback" ,"Multicast loopback");
                                          if(Type!=null)
                     Type=(String)valueShowMap.get(Type);
              %>
              <%= Type != null? Type : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="IPAddrPoolApplicationResources" key="field.type.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="IPAddrPoolApplicationResources" key="field.addressfamily.alias"/>
                                *
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
              <bean:message bundle="IPAddrPoolApplicationResources" key="field.addressfamily.description"/>
                                                                      </table:cell>
          </table:row>
                                                                       <table:row>
            <table:cell>  
              <bean:message bundle="IPAddrPoolApplicationResources" key="field.isdynamic.alias"/>
                          </table:cell>
            <table:cell>
              <%= isDynamic %>
            </table:cell>
            <table:cell>
              <bean:message bundle="IPAddrPoolApplicationResources" key="field.isdynamic.description"/>
            </table:cell>
          </table:row>
                                               
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitIPAddrPoolAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="name" value="<%= String.valueOf(Name) %>"/>
              </html:form>
  </body>
</html>

