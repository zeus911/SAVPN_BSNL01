<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
%>

<html>
<head>
    <title>HP Service Activator</title>
    <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
</head>

<%!
	//I18N strings
	final static String logBackIn	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("266", "Please log back into the Service Activator Operator UI.");
	final static String sessionExp	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("267", "Your session has expired.");
%>

<body>
<script language="JavaScript" type="text/JavaScript">
    alert("<%=logBackIn%>\n<%=sessionExp%>");
    top.window.location = "login.jsp"; 
</script>

</body>
</html>
