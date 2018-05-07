<!DOCTYPE html>
<%@ page info="" session="true" contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.LoginServlet" %>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%
//refresh on/off functionality
boolean isRefreshON = true;
String tmpStr = request.getParameter("refresh_state");
if (tmpStr != null && !tmpStr.trim().isEmpty()) {
  session.setAttribute(Constants.REFRESH_FUNCTIONALITY_SWITCHER, tmpStr.trim());
}
%>

<html>

<head>
<title><%= LoginServlet.getMainTitle((String)session.getAttribute(Constants.CUSTOM_UI_ID)) %></title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<script>
function init()
{
<%
if (tmpStr != null && !tmpStr.trim().isEmpty()) {
%>
  top.leftFrame.toggledRefresh("<%= tmpStr %>");
<%
}
%>
}
</script>
</head>

<body onload="init();">

</body>

</html>
