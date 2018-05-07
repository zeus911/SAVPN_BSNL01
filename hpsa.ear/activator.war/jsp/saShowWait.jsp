<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page autoFlush="true" 
         import="java.net.URLDecoder"
         info="Shows wait message" 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%!
    //I18N strings
    final static String defaultMsg       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("872", "Please wait ...");
%>
<%
    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    // Check if there is a valid session available.
    if (session == null) {
%>
    <script>
        window.top.topFrame.location = window.top.topFrame.location;
    </script>
<%
       return;
    }
    
    String msg = request.getParameter("msg");
    if (msg == null) {
        msg = defaultMsg;
    } else {
        msg = URLDecoder.decode(msg, "UTF-8");
    }
%>
<html>
<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
  <link rel="stylesheet" type="text/css" href="/activator/css/saTabs.css">
  <link rel="stylesheet" type="text/css" href="/activator/css/saContextMenu.css">
  <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
</head>
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<table cellpadding="0" cellspacing="0">
  <tr align="left">
    <td nowrap class="pageHead">&nbsp;</td>
  </tr>
</table>
<p><%= msg%></p>
</body>
