<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.net.URLDecoder" %>
<%@ page import="com.hp.ov.activator.xmaps.utils.CoordinatesManager" %>

<%@ taglib uri="/WEB-INF/xmaps-taglib.tld" prefix="xmaps" %>

<%
String id = request.getParameter("id") == null ? null : URLDecoder.decode(request.getParameter("id"), "UTF-8");
String scope = request.getParameter("scope") == null ? null : URLDecoder.decode(request.getParameter("scope"), "UTF-8");
String name = request.getParameter("name") == null ? null : URLDecoder.decode(request.getParameter("name"), "UTF-8");
String solution = request.getParameter("solution") == null ? null : URLDecoder.decode(request.getParameter("solution"), "UTF-8");
String file = request.getParameter("file") == null ? null : URLDecoder.decode(request.getParameter("file"), "UTF-8");
String sort = request.getParameter("sort") == null ? null : URLDecoder.decode(request.getParameter("sort"), "UTF-8");
String gap = request.getParameter("gap") == null ? null : URLDecoder.decode(request.getParameter("gap"), "UTF-8");
String animate = request.getParameter("animate") == null ? null : URLDecoder.decode(request.getParameter("animate"), "UTF-8");
String storeInSession = request.getParameter("store_in_session") == null ? null : URLDecoder.decode(request.getParameter("store_in_session"), "UTF-8");
String sessionKey = request.getParameter("session_key") == null ? null : URLDecoder.decode(request.getParameter("session_key"), "UTF-8");
%>

<html>
<head>

</head>
<body>

<xmaps:draw
    scope="<%= scope == null || scope.trim().isEmpty() ? \"\" : scope.trim() %>"
    id="<%= id == null || id.trim().isEmpty() ? \"\" : id.trim() %>"
    name="<%= name == null || name.trim().isEmpty() ? \"\" : name.trim() %>"
    solution="<%= solution == null || solution.trim().isEmpty() ? \"\" : solution.trim() %>"
    file="<%= file == null || file.trim().isEmpty() ? \"\" : file.trim() %>"
    sort="<%= sort == null || sort.trim().isEmpty() ? \"\" : sort.trim() %>"
    gap="<%= gap == null || gap.trim().isEmpty() ? \"\" : gap.trim() %>"
    animate="<%= animate == null || animate.trim().isEmpty() ? \"\" : animate.trim() %>"
    store_in_session="<%= storeInSession == null || storeInSession.trim().isEmpty() ? \"\" : storeInSession.trim() %>"
    session_key="<%= sessionKey == null || sessionKey.trim().isEmpty() ? \"\" : sessionKey.trim() %>" />

</body>
</html>