<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.net.URLDecoder" %>
<%@ page import="com.hp.ov.activator.xmaps.utils.SessionManager" %>

<%
String sessionKey = URLDecoder.decode(request.getParameter("sessionKey"), "UTF-8");
if (sessionKey != null && !sessionKey.trim().isEmpty()) {
  //System.out.println("Removing diagram " + sessionKey + " from session");
  SessionManager.removeDiagram(session, sessionKey);
}
%>