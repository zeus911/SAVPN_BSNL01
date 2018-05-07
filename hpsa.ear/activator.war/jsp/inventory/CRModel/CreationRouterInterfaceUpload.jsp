<!------------------------------------------------------------------------
   hp OpenView service activator
   (c) Copyright 2003-2009 Hewlett-Packard Development Company, L.P.
------------------------------------------------------------------------->

<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
                com.hp.ov.activator.cr.inventory.*,
                com.hp.ov.activator.inventory.CRModel.*,
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
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);    
nfB.setMaximumFractionDigits(6);

                
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(RouterInterfaceUploadConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String location = (String) request.getParameter("_location_");
String formAction = "/CreationCommitRouterInterfaceUploadAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
    exceptionMessage="";
}
if ( location == null ) {
                            location = "networkelementid";
                                                            }
%>

<script>
    function sendthis(focusthis) {
    /*window.document.RouterInterfaceUploadForm.action = '/activator<%=moduleConfig%>/CreationFormRouterInterfaceUploadAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
    window.document.RouterInterfaceUploadForm.submit();*/
    }

    function performCommit() 
    {
        window.document.RouterInterfaceUploadForm.action = '/activator<%=moduleConfig%>/CreationCommitRouterInterfaceUploadAction.do?datasource=<%= datasource %>';
        window.document.RouterInterfaceUploadForm.submit();
    }
</script>

<html>
    <head>
        <title><bean:message bundle="RouterInterfaceUploadApplicationResources" key="<%= RouterInterfaceUploadConstants.JSP_CREATION_TITLE %>"/></title>
        <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
        <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
        <script src="/activator/javascript/hputils/alerts.js"></script>
        <style type="text/css">
            A.nodec { text-decoration: none; }
            H1 { color: red; font-size: 13px }
        </style>
    </head>
    <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;">
<%

String NetworkElementID =(String)request.getParameter("networkelementid");
String Slot = " ";
                    
%>

<center> 
  <h2>
    <bean:message bundle="RouterInterfaceUploadApplicationResources" key="jsp.creation.title"/>
  </h2> 
</center>

<html:form action="<%= formAction %>">
        <center>
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
            <html:hidden  property="networkelementid" value="<%= NetworkElementID %>"/>
            </table:cell>
            </table:row>
            <table:row>
            <table:cell>    
            <bean:message bundle="RouterInterfaceUploadApplicationResources" key="field.slot.alias"/>
            </table:cell>
            <table:cell>
            <html:text  property="slot" size="24" value="<%= Slot %>"/>
            </table:cell>
            <table:cell>
            <bean:message bundle="RouterInterfaceUploadApplicationResources" key="field.slot.description"/>
            </table:cell>
            </table:row>
                                                                                                                    
            
            <table:row>
                <table:cell colspan="3" align="center">
                <br>
                </table:cell>
            </table:row>
            <table:row>
                <table:cell colspan="3" align="center">
                    <input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
                    <input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
                </table:cell>
            </table:row>
        </table:table>
        </center>
    </html:form>

    </body>
<%
    if ( errorMessage != null && !errorMessage.equals("") ) {
%>
        <script>
            var alertMsg = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
            alertMsg.setBounds(400, 120);
            alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
            alertMsg.show();
        </script>
<%
    }
%>

</html>
