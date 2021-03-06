<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ taglib uri = "/WEB-INF/struts-bean.tld" prefix="bean" %>


<%@page import="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.ConstantsFTStruts"%><html>

<%
String errorAction = (String) request.getAttribute(ConstantsFTStruts.ERROR_ACTION);
String errorMessage = (String) request.getAttribute(ConstantsFTStruts.ERROR_MESSAGE);
String exceptionMessage = (String) request.getAttribute(ConstantsFTStruts.EXCEPTION_MESSAGE);
String msgtitle=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("504", "Error");
String msgOk=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("505", "OK");
%>
<html>
<head>
<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
<script src="/activator/javascript/hputils/alerts.js"></script>
<script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
</head>
<body style="overflow:auto;" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
</body>
</html>

<%
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
<script>
var alert = new HPSAAlert('<%=msgtitle%>','<%= errorMessage %><br><br>*<%= exceptionMessage %>');
alert.setBounds(400, 120);
alert.setButtonText('<%=msgOk%>');
alert.show();
</script>
<%
}
%>
