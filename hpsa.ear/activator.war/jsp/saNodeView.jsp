<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="com.hp.ov.activator.mwfm.*,
                 com.hp.ov.activator.mwfm.engine.object.*,
                 com.hp.ov.activator.mwfm.servlet.*,
                 java.sql.*,
                 java.util.*,
                 java.net.*,
                 javax.sql.*,
                 java.net.URLEncoder,
                 com.hp.ov.activator.mwfm.engine.module.ClusterNodeBean"
         info="Show Status Information of entire Cluster System."
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%><%
// Check if there is a valid session available.
if (session == null || session.getAttribute(Constants.USER) == null) {
%>
<html><head>
<script type="text/javascript">
  window.top.topFrame.location = window.top.topFrame.location;
</script>
</head></html>
<%
  return;
}

// don't cache the page
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");

request.setCharacterEncoding ("UTF-8");

String width = request.getParameter("framewidth");
String height = request.getParameter("frameheight");
String message = (String)session.getAttribute(Constants.MESSAGE);
if (width == null) {
  width = "800"; // default value
}
if (height == null) {
  height = "600"; // default value
}
%>
<jsp:include page="/nodeInformation">
<jsp:param name="framewidth" value="<%=width%>" />
<jsp:param name="frameheight" value="<%=height%>" />
</jsp:include>
<jsp:include page="saNodeInformation.jsp" />
