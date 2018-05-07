<!--
******************************************************************
HP OpenView Service Activator
(c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.ConstantsFTStruts;" %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table" %>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn" %>

<%
String refreshTreeRimid=(String) request.getParameter("refreshTreeRimid");
String errorAction = (String) request.getAttribute(ConstantsFTStruts.ERROR_ACTION);
String errorMessage = (String) request.getAttribute(ConstantsFTStruts.ERROR_MESSAGE);
String exceptionMessage = (String) request.getAttribute(ConstantsFTStruts.EXCEPTION_MESSAGE);
String mstitle=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("504", "Error");
String ok=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("505", "OK");
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
var alert = new HPSAAlert('<%=mstitle%>','<%= errorMessage %><br><br>*<%= exceptionMessage %>');
alert.setBounds(400, 120);
alert.setButtonText('<%=ok%>');
alert.show();
</script>
<%
}
%>
<script>
parent.document.getElementById("ifr" + "<%=refreshTreeRimid%>").contentWindow.checkRefresh();
</script>
