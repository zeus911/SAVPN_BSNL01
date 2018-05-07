<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.net.URLDecoder" %>
<%@ page import="com.hp.ov.activator.xmaps.utils.CoordinatesManager" %>

<%
String sessionKey = URLDecoder.decode(request.getParameter("sessionKey"), "UTF-8");
String databaseKey = URLDecoder.decode(request.getParameter("databaseKey"), "UTF-8");
String coordinates = URLDecoder.decode(request.getParameter("coordinates"), "UTF-8");
CoordinatesManager.save(sessionKey, databaseKey, coordinates, session);
%>