<!DOCTYPE html>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page  import="java.util.ArrayList,java.util.Date,java.text.DateFormat,com.hp.ov.activator.resmgr.kernel.ActivationQueueBean,com.hp.ov.activator.mwfm.servlet.Constants " %>

<%!
//I18N strings
final static String noActivations = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1019", "No Active Transactions.");
final static String activations = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("142", "Track Activations");
final static String viewActivations = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1020", "View Activation Details");
final String tooManyWindows =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("332", "You may only interact with one job at a time.  ");
final String closeWindow    =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("321", "Please either close or submit the open interact window.");
%>

<%
// Check if there is a valid session available.
if (session == null || session.getAttribute(Constants.USER) == null) {
%>
<script>
window.top.topFrame.location = window.top.topFrame.location;
</script>
<%
  return;
}
response.setDateHeader("Expires", 0);
response.setHeader("Pragma",  "no-cache");
request.setCharacterEncoding("UTF-8");
String transSeqId = request.getParameter("transactionSeqId"); 
String jobId = request.getParameter("jobId");
String url = "/activator/track?transactionSeqId=" + (transSeqId == null || transSeqId.trim().isEmpty() ? "" : transSeqId.trim()) + (jobId != null ? "&jobId=" + jobId : "");
%>

<html>

<head>
<title>HP Service Activator</title>
<link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
<link rel="stylesheet" type="text/css" href="/activator/css/saContextMenu.css">
<script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<script>
function init()
{
  document.location.href = "<%= url %>";
}
</script>
</head>

<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();" onload="init()">

</body>

</html>
