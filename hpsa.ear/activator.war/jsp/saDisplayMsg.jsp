<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="java.net.*"
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<link rel='stylesheet' type='text/css' href='/activator/css/activator.css'>
<link rel='stylesheet' type='text/css' href='/activator/css/inventory.css'>
<script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
</head>
<body class="invField" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<%
if(request.getParameter("Msg")!=null){
%>
    <%= request.getParameter("Msg") %>
<%}%>
</body>
</html>