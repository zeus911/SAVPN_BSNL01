<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page pageEncoding="utf-8"%>
<%@ page import = "com.hp.ov.activator.inventory.facilities.StringFacility" %>
<%@ page import = "com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.ConstantsFTStruts" %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table" %>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn" %>

<%
String errtitle=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("504", "Error");
String errOK=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("505", "OK");
String errorAction = (String) request.getAttribute(ConstantsFTStruts.ERROR_ACTION);
String errorMessage = (String) request.getAttribute(ConstantsFTStruts.ERROR_MESSAGE);
String exceptionMessage = (String) request.getAttribute(ConstantsFTStruts.EXCEPTION_MESSAGE);
if ( errorMessage == null || errorMessage.equals("") ) {
  errorAction = request.getParameter(ConstantsFTStruts.ERROR_ACTION);
  errorMessage = request.getParameter(ConstantsFTStruts.ERROR_MESSAGE);
  exceptionMessage = request.getParameter(ConstantsFTStruts.EXCEPTION_MESSAGE);
}
errorAction=StringFacility.replaceAllByHTMLCharacter(errorAction);
errorMessage=StringFacility.replaceAllByHTMLCharacter(errorMessage);
exceptionMessage=StringFacility.replaceAllByHTMLCharacter(exceptionMessage);
%>
<html>
<head>
<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
<script src="/activator/javascript/hputils/alerts.js"></script>
<script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
<style type="text/css">
A.nodec { text-decoration: none; }
</style>
</head>
<body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
</body>
</html>

<%
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
<script>
var alert = new HPSAAlert('<%=errtitle%>','<%= errorMessage %><br><br>*<%= exceptionMessage %>');
alert.setBounds(400, 120);
alert.setButtonText('<%=errOK%>');
alert.show();
</script>
<%
}
%>
