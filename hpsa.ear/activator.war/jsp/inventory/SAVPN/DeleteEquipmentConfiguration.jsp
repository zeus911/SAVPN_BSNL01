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
String datasource = (String) request.getParameter(EquipmentConfigurationConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="EquipmentConfigurationApplicationResources" key="<%= EquipmentConfigurationConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.EquipmentConfigurationForm.action = '/activator<%=moduleConfig%>/DeleteCommitEquipmentConfigurationAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.EquipmentConfigurationForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="EquipmentConfigurationApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.EquipmentConfiguration beanEquipmentConfiguration = (com.hp.ov.activator.vpn.inventory.EquipmentConfiguration) request.getAttribute(EquipmentConfigurationConstants.EQUIPMENTCONFIGURATION_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String EquipmentID = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getEquipmentid());
                        
                                  
                      String TimeStamp = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getTimestamp());
                        
                                  
                      String Version = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getVersion());
                        
                                  
                      String Data = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getData());
                        
                                  
                      String LastAccessTime = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getLastaccesstime());
                        
                                  
                      String MemoryType = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getMemorytype());
                        
                                  
                      String CreatedBy = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getCreatedby());
                        
                                  
                      String ModifiedBy = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getModifiedby());
                        
                                  
                      String DirtyFlag = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getDirtyflag());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="EquipmentConfigurationApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.equipmentid.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= EquipmentID != null? EquipmentID : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.equipmentid.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.timestamp.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= TimeStamp != null? TimeStamp : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.timestamp.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.version.alias"/>
                          </table:cell>
            <table:cell>
                            <%= Version != null? Version : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.version.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.data.alias"/>
                          </table:cell>
            <table:cell>
                              <%= Data == null ? "" : (Data.length() <= 200 ? Data : (Data.substring(0, 200) + "<span style='font:italic'> ... [Truncated]</span>")) %>              
                          </table:cell>
            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.data.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.lastaccesstime.alias"/>
                          </table:cell>
            <table:cell>
                            <%= LastAccessTime != null? LastAccessTime : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.lastaccesstime.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.memorytype.alias"/>
                          </table:cell>
            <table:cell>
                            <%= MemoryType != null? MemoryType : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.memorytype.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.createdby.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= CreatedBy != null? CreatedBy : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.createdby.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.modifiedby.alias"/>
                          </table:cell>
            <table:cell>
                            <%= ModifiedBy != null? ModifiedBy : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.modifiedby.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.dirtyflag.alias"/>
                          </table:cell>
            <table:cell>
                            <%= DirtyFlag != null? DirtyFlag : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.dirtyflag.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitEquipmentConfigurationAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="equipmentid" value="<%= String.valueOf(EquipmentID) %>"/>
                        <html:hidden property="timestamp" value="<%= String.valueOf(TimeStamp) %>"/>
              </html:form>
  </body>
</html>

