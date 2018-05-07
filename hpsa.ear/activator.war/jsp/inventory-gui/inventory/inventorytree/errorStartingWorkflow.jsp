<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page pageEncoding="utf-8"%>


 <%@ page import = "com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.ConstantsFTStruts" %>
<%@ page import = "com.hp.ov.activator.inventory.facilities.StringFacility" %>


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

String title=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("999", "Start Workflow From Inventory");
String errtitle=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("504", "Error");
String errorAction = (String) request.getAttribute(ConstantsFTStruts.ERROR_ACTION);
String errorMessage = (String) request.getAttribute(ConstantsFTStruts.ERROR_MESSAGE);
String exceptionMessage = (String) request.getAttribute(ConstantsFTStruts.EXCEPTION_MESSAGE);
errorMessage=StringFacility.replaceAllByHTMLCharacter(errorMessage);
exceptionMessage=StringFacility.replaceAllByHTMLCharacter(exceptionMessage);
if (exceptionMessage==null){
	exceptionMessage="";
}
%>

<html>

<head>
<title><%=title %></title>
<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
<script src="/activator/javascript/hputils/alerts.js"></script>
<style type="text/css">
A.nodec { text-decoration: none; }
H1 { color: red; font-size: 13px }
</style>
<script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
</head>
	
<body style="overflow:auto; text-align:center;" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<h2><%= request.getParameter("opname") + " Error" %></h2> 
</body>

</html>

<%
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
<script>
var alert = new HPSAAlert('<%=errtitle%>','<%= errorMessage %><br><br>*<%= exceptionMessage %>');
alert.setBounds(400, 120);
alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
alert.show();
</script>
<%
}
%>
