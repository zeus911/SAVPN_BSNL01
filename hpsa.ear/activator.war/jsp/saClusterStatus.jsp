<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="com.hp.ov.activator.mwfm.*,
             com.hp.ov.activator.mwfm.engine.object.*,
             com.hp.ov.activator.mwfm.servlet.*,
             com.hp.ov.activator.mwfm.engine.module.ClusterNodeBean"
         info="Show Status Information of entire Cluster System."
         session="true"
         language="java"
%>

<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute (Constants.USER) == null) {
%>
    <script>
        window.top.topFrame.location = window.top.topFrame.location;
    </script>
<%
       return;
    }

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader    ("Pragma",  "no-cache");
	String refreshRate = (String) session.getAttribute(Constants.JOB_REFRESH_RATE);
%>
<%!
    //I18N strings
    final static String statusInformation = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("10", "Status");
%>

<html>
 <head>
  <title>Status</title>
  <meta http-equiv='refresh' content='<%=refreshRate%>'>
  <link rel="stylesheet" type="text/css" href="/activator/css/saNavigation.css">
  <script language="JavaScript">
if (window.top.refresh==null || window.top.refresh != "OFF") {
  document.write("<meta http-equiv='refresh' content='<%=refreshRate%>'>");
}
 </script>
 <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
 </head>
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<div align="center">
<div class="separator"></div>
<table width="95%" class="counterTable">
<tr>
<td class="counterTable"><%=statusInformation%>:</td>
<td class="counterTableNumber"><img id="nodeImage" border="0" src="/activator/nodeInformation?nodeType=clusterstatus" /></td>
</tr>
</table>
</div>
</body>
</html>
