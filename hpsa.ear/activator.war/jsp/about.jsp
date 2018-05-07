<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page session="true" contentType="text/html; charset=UTF-8" language="java" %>

<%!
// I18N strings
final static String aboutTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("502", "About HP Service Activator");
final static String version = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("269", "Version ");
%>

<html>
<head>
  <title><%=aboutTitle%></title>
  <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
  <link rel="stylesheet" type="text/css" href="/activator/css/saHeader.css">
</head>

<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();" style="">
<center>
<table style="padding:0px; border-spacing:0px; border-collapse:collapse;">
  <tr><td><img src="/activator/images/splash.png"></td>
  <tr><td class="about"><%=com.hp.ov.activator.util.ActivatorVersion.getVersion()%></td>
</table>
</center>
</body>
</html>
