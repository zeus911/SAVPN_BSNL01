<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page contentType="text/html; charset=UTF-8" %>
<%
//I18n strings
final  String futuretreesearch_no_results=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("542", "No search results") ;
%>
<html>
<head>
<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
<script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
</head>
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<p class=p1><%=futuretreesearch_no_results%></p>
</body>
</html>