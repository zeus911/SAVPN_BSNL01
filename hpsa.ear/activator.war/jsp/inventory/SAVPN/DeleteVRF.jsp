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
String datasource = (String) request.getParameter(VRFConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="VRFApplicationResources" key="<%= VRFConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.VRFForm.action = '/activator<%=moduleConfig%>/DeleteCommitVRFAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.VRFForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="VRFApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.VRF beanVRF = (com.hp.ov.activator.vpn.inventory.VRF) request.getAttribute(VRFConstants.VRF_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String VRFName = StringFacility.replaceAllByHTMLCharacter(beanVRF.getVrfname());
                        
                                  
                      String NE_ID = StringFacility.replaceAllByHTMLCharacter(beanVRF.getNe_id());
                        
                                  
                      String RD = StringFacility.replaceAllByHTMLCharacter(beanVRF.getRd());
                        
                                  
                      String RD_ASN = StringFacility.replaceAllByHTMLCharacter(beanVRF.getRd_asn());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="VRFApplicationResources" key="jsp.delete.title"/>
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
              <bean:message bundle="VRFApplicationResources" key="field.vrfname.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= VRFName != null? VRFName : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="VRFApplicationResources" key="field.vrfname.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="VRFApplicationResources" key="field.ne_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= NE_ID != null? NE_ID : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="VRFApplicationResources" key="field.ne_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                                                            <table:row>
            <table:cell>  
              <bean:message bundle="VRFApplicationResources" key="field.rd_asn.alias"/>
                          </table:cell>
            <table:cell>
                            <%= RD_ASN != null? RD_ASN : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="VRFApplicationResources" key="field.rd_asn.description"/>
                                                                      </table:cell>
          </table:row>
                                                         
      
      
      <table:row>
        <table:cell colspan="3" align="center">
          <br>
        </table:cell>
      </table:row>
    </table:table>
    </div>

    <html:form action="/DeleteCommitVRFAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="ne_id" value="<%= String.valueOf(NE_ID) %>"/>
                        <html:hidden property="vrfname" value="<%= String.valueOf(VRFName) %>"/>
              </html:form>
  </body>
</html>

