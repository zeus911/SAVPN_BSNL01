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

String refreshTree = (String) request.getAttribute(EquipmentConfigurationConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="EquipmentConfigurationApplicationResources" key="<%= EquipmentConfigurationConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.EquipmentConfiguration beanEquipmentConfiguration = (com.hp.ov.activator.vpn.inventory.EquipmentConfiguration) request.getAttribute(EquipmentConfigurationConstants.EQUIPMENTCONFIGURATION_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String EquipmentID = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getEquipmentid());
                      String TimeStamp = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getTimestamp());
                      String Version = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getVersion());
                      String Data = beanEquipmentConfiguration.getData();
                      String LastAccessTime = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getLastaccesstime());
                      String MemoryType = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getMemorytype());
                      String CreatedBy = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getCreatedby());
                      String ModifiedBy = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getModifiedby());
                      String DirtyFlag = StringFacility.replaceAllByHTMLCharacter(beanEquipmentConfiguration.getDirtyflag());
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="EquipmentConfigurationApplicationResources" key="jsp.view.title"/>
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
            
              
                              <html:textarea disabled="true" property="data" rows="10" value="<%= Data == null ? \"\" : Data %>" style="resize:true; width:100%; color:#000000; background:transparent; border:0px solid;" />
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

  </body>
</html>
