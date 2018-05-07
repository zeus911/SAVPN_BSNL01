<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ taglib uri="/WEB-INF/xmaps-taglib.tld" prefix="xmaps" %>

<%@ page import="java.net.URLDecoder" %>

<%
String name = URLDecoder.decode(request.getParameter("name"), "UTF-8");
String solution = URLDecoder.decode(request.getParameter("solution"), "UTF-8");
String sessionKey = URLDecoder.decode(request.getParameter("sessionKey"), "UTF-8");
boolean storeInSession = sessionKey != null && !sessionKey.trim().isEmpty();
%>

<html>
<head>

</head>
<body>

<xmaps:update scope="database" name="<%= name %>" solution="<%= solution %>" store_in_session="<%= storeInSession %>" session_key="<%= sessionKey %>" />

</body>
</html>