<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page contentType="text/html; charset=UTF-8"
    info="Logout"
    session="true"
%>
<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants" %>

<%
String id = (String)session.getAttribute(Constants.CUSTOM_UI_ID);
if (id == null || id.trim().isEmpty()) {
  id = request.getParameter(Constants.CUSTOM_UI_ID);
}
// check if there is a valid session available
if (session != null) {
  session.invalidate();
  session=null;
}
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache");
response.setDateHeader("Expires", 0);
String logoutReason = request.getParameter("logout_reason") == null ? "" : request.getParameter("logout_reason");
%>
<html>
<% if (logoutReason.equals("")) { %>
<body onload="top.location='login.jsp<%= id == null || id.trim().isEmpty() ? "" : "?id=" + id %>';"></body>
<% } else { %>
<body onload="top.location='login.jsp?logout_reason=<%=logoutReason%><%= id == null || id.trim().isEmpty() ? "" : "&id=" + id %>';"></body>
<% } %>
</html>
