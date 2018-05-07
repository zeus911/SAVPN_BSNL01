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
String datasource = (String) request.getParameter(DLCIRangeConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="DLCIRangeApplicationResources" key="<%= DLCIRangeConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.DLCIRangeForm.action = '/activator<%=moduleConfig%>/DeleteCommitDLCIRangeAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.DLCIRangeForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="DLCIRangeApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.DLCIRange beanDLCIRange = (com.hp.ov.activator.vpn.inventory.DLCIRange) request.getAttribute(DLCIRangeConstants.DLCIRANGE_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String DLCIRangeID = StringFacility.replaceAllByHTMLCharacter(beanDLCIRange.getDlcirangeid());
                        
                                  
                      String Usage = StringFacility.replaceAllByHTMLCharacter(beanDLCIRange.getUsage());
                        
                                  
                      String Allocation = StringFacility.replaceAllByHTMLCharacter(beanDLCIRange.getAllocation());
                        
                                  
                        String StartValue = "" + beanDLCIRange.getStartvalue();
                            
                  if( beanDLCIRange.getStartvalue()==Integer.MIN_VALUE)
         StartValue = "";
                            
                        String EndValue = "" + beanDLCIRange.getEndvalue();
                            
                  if( beanDLCIRange.getEndvalue()==Integer.MIN_VALUE)
         EndValue = "";
                            
                      String Description = StringFacility.replaceAllByHTMLCharacter(beanDLCIRange.getDescription());
                        
                                  
                      String Region = StringFacility.replaceAllByHTMLCharacter(beanDLCIRange.getRegion());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="DLCIRangeApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="DLCIRangeApplicationResources" key="field.usage.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Usage != null? Usage : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.usage.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DLCIRangeApplicationResources" key="field.allocation.alias"/>
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
              <bean:message bundle="DLCIRangeApplicationResources" key="field.allocation.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DLCIRangeApplicationResources" key="field.startvalue.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= StartValue != null? StartValue : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.startvalue.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DLCIRangeApplicationResources" key="field.endvalue.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= EndValue != null? EndValue : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.endvalue.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DLCIRangeApplicationResources" key="field.description.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Description != null? Description : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.description.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="DLCIRangeApplicationResources" key="field.region.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= Region != null? Region : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.region.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitDLCIRangeAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="region" value="<%= String.valueOf(Region) %>"/>
                        <html:hidden property="dlcirangeid" value="<%= String.valueOf(DLCIRangeID) %>"/>
                        <html:hidden property="allocation" value="<%= String.valueOf(Allocation) %>"/>
                        <html:hidden property="usage" value="<%= String.valueOf(Usage) %>"/>
              </html:form>
  </body>
</html>
