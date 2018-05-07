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

String refreshTree = (String) request.getAttribute(SetupCE_WorkorderConstants.REFRESH_TREE);
%>

<html>
  <head>
    <title><bean:message bundle="SetupCE_WorkorderApplicationResources" key="<%= SetupCE_WorkorderConstants.JSP_VIEW_TITLE %>"/></title>
 
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
com.hp.ov.activator.vpn.inventory.SetupCE_Workorder beanSetupCE_Workorder = (com.hp.ov.activator.vpn.inventory.SetupCE_Workorder) request.getAttribute(SetupCE_WorkorderConstants.SETUPCE_WORKORDER_BEAN);
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);
      String ServiceId = StringFacility.replaceAllByHTMLCharacter(beanSetupCE_Workorder.getServiceid());
                      String WOName = StringFacility.replaceAllByHTMLCharacter(beanSetupCE_Workorder.getWoname());
                      String WO_Content = beanSetupCE_Workorder.getWo_content();
                      String creationtime = (beanSetupCE_Workorder.getCreationtime() == null) ? "" : beanSetupCE_Workorder.getCreationtime();
creationtime= StringFacility.replaceAllByHTMLCharacter(creationtime);
      java.text.SimpleDateFormat sdfcreationtime = new java.text.SimpleDateFormat("dd-MM-yyyy");
      String sdfcreationtimeDesc = "Format: [" + sdfcreationtime.toPattern() + "]. Example: [" + sdfcreationtime.format(new Date()) + "]";
sdfcreationtimeDesc = StringFacility.replaceAllByHTMLCharacter(sdfcreationtimeDesc);
                %>
<h2 style="width:100%; text-align:center;">
  <bean:message bundle="SetupCE_WorkorderApplicationResources" key="jsp.view.title"/>
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
              <bean:message bundle="SetupCE_WorkorderApplicationResources" key="field.serviceid.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= ServiceId != null? ServiceId : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="SetupCE_WorkorderApplicationResources" key="field.serviceid.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="SetupCE_WorkorderApplicationResources" key="field.woname.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= WOName != null? WOName : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="SetupCE_WorkorderApplicationResources" key="field.woname.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="SetupCE_WorkorderApplicationResources" key="field.wo_content.alias"/>
                          </table:cell>
            <table:cell>
            
              
                              <html:textarea disabled="true" property="wo_content" rows="10" value="<%= WO_Content == null ? \"\" : WO_Content %>" style="resize:true; width:100%; color:#000000; background:transparent; border:0px solid;" />
                                                      </table:cell>
            <table:cell>
                      <bean:message bundle="SetupCE_WorkorderApplicationResources" key="field.wo_content.description"/>
                                                                              </table:cell>
          </table:row>
                                                           
                                 <table:row>
            <table:cell>  
              <bean:message bundle="SetupCE_WorkorderApplicationResources" key="field.creationtime.alias"/>
                                *
                          </table:cell>
            <table:cell>
            
              
                            <%= creationtime != null? creationtime : "" %>
                          </table:cell>
            <table:cell>
                      <bean:message bundle="SetupCE_WorkorderApplicationResources" key="field.creationtime.description"/>
                      <%=sdfcreationtimeDesc%>                                                        </table:cell>
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