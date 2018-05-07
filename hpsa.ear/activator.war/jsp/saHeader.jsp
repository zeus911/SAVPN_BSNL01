<!DOCTYPE html>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page session="true" contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.LoginServlet" %>

<%
// Check if there is a valid session available.
if (session == null || session.getAttribute(Constants.USER) == null) {
  response.sendRedirect("sessionError.jsp");
  return;
}
request.setCharacterEncoding("UTF-8");
%>

<%!//I18N strings
final static String welcome = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("279", "Welcome ");
final static String help = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("157", "Help");
final static String logOut = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("159", "Log Out");
final static String helpTT = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("280", "Get Help on Service Activator");
final static String logOutTT = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("281", "Log Out of Service Activator");

final static String introPDF = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("192", "Introduction");
final static String workflowPDF = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("141", "Workflows");
final static String inventoryPDF = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("145", "Inventory");
final static String pluginPDF = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("193", "Plug-ins");
final static String libraryPDF = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("271", "Plug-in Lib");
final static String examplePDF = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("194", "Examples");

final static String operUI = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1130", "User's and Administrator's Guide");
final static String about = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1131", "About Service Activator");
final static String automaticLogoutPrefix = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1342", "Automatic logout in");
final static String automaticLogoutSuffix = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1343", "seconds due to inactivity");
final static String automaticLogoutAbort = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1344", "User activity registered - aborting automatic logout");
%>

<%
String id = (String)session.getAttribute(Constants.CUSTOM_UI_ID);
%>

<head>
<title><%= LoginServlet.getMainTitle(id) %></title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/activator/css/saHeader.css">
<script src="/activator/javascript/saHeader.js"></script>
<style>
table, tr, td
{
  padding:0px;
}
</style>
<script>
function showMenu() {
  document.getElementById("helpMenu").style.visibility = "visible";
}

// Inactivity logout timer

// Possible values for 'logoutState':
//   1 : Count down (don't display anything on UI)
//   2 : Warning (display a warning message on UI)
//   3 : Logout Abort (display a "logout abort" message on UI)
// Possible state transitions:
//   1 -> 2 -> 3 -> 1 ...
var logoutState = 1;

var logoutInitTime = <%=session.getAttribute(Constants.AUTO_LOGOUT_TIME)%> * 10;
var logoutAbortTime = <%=session.getAttribute(Constants.AUTO_LOGOUT_ABORT_TIME)%> * 10;
var logoutWarningThreshold = <%=session.getAttribute(Constants.AUTO_LOGOUT_WARNING_TIME)%> * 10;
var logoutTimer = logoutInitTime;
var logoutAbortTimer = logoutAbortTime;

// Call the countDown() function once every 100 ms (i.e. 10 times per second)
if (logoutInitTime > 0) {
  setInterval("countDown()", 100);
}

function countDown() {
  var oSpan = document.getElementById("countDownTime");
  if (logoutTimer <= 0) {
    window.location = "/activator/jsp/logout.jsp?logout_reason=inactivity";
  } else {
    if (logoutState == 1) {
      if (logoutTimer <= logoutWarningThreshold) {
        logoutState = 2;
      }
    } if (logoutState == 2) {
      oSpan.innerHTML = "<table class=\"warning\" style=\"padding:4px; border-spacing:0px; border-collapse:collapse;\"><tr><td>"
          + "<%=automaticLogoutPrefix%> " + (logoutTimer / 10).toFixed(0)
          + " <%=automaticLogoutSuffix%></td></tr></table>";
    } if (logoutState == 3) {
      logoutAbortTimer--;
      oSpan.innerHTML = "<table class=\"warning\" style=\"padding:4px; border-spacing:0px; border-collapse:collapse;\"><tr><td>"
          + "<%=automaticLogoutAbort%></td></tr></table>";
      if (logoutAbortTimer <= 0) {
        oSpan.innerHTML = "&nbsp;";
        logoutState = 1;
        logoutTimer = logoutInitTime;
      }
    }
  }
  logoutTimer--;
}
function resetLogoutTimer() {
  logoutTimer = logoutInitTime;
  if (logoutState == 2) {
    logoutAbortTimer = logoutAbortTime;
    logoutState = 3
  }
}
</script>
</head>

<body onmousemove="resetLogoutTimer();" style="margin:0px; padding:0px; overflow:hidden;" >

  <table style="width:100%; border-spacing:0px; border-collapse:collapse;" class="header">
  <tr>
    <td style="width:52px; vertical-align:top;">
      <table style="width:52px; border-spacing:0px; border-collapse:collapse;">
        <tr>
          <td><img src="/activator/images/HPLogo-small.png" style="height:45px; width:47px;"/></td>
        </tr>
      </table>
    </td>
    <td style="vertical-align:top;">
      <table style="width:100%; border-spacing:0px; border-collapse:collapse;">
        <tr>
          <td><img src="<%= LoginServlet.getMainName(id) %>" style="height:45px; width:270px;"/></td>
          <td style="text-align:center; vertical-align:center;"><span id="countDownTime">&nbsp;</span></td>
        </tr>
      </table>
    </td>
    <td style="width:250px; vertical-align:top;">
      <table style="width:100%; border-spacing:0px; border-collapse:collapse;">
        <tr style="white-space:nowrap;">
          <td><img src="<%= LoginServlet.getMainSplash(id) %>" style="height:45px; width:250px;"/></td>
        </tr>
      </table>
    </td>
    <td style="width:140px; text-align:center;">
      <table style="width:100%; border-spacing:0px; border-collapse:collapse;">
        <tr>
          <td title="<%=helpTT%>" style="white-space:nowrap;" class="btn"
              onClick="showMenu();"><%=help%></td> 
          <td>&nbsp;</td>
          <td title="<%=logOutTT%>" style="white-space:nowrap;" class="btn"
              onClick="location.href='logout.jsp<%= id == null || id.trim().isEmpty() ? "" : "?" + Constants.CUSTOM_UI_ID + "=" + id %>';"><%=logOut%></td>
        </tr>
      </table>
      <table style="width:100%; border-spacing:0px; border-collapse:collapse;">
        <tr style="text-align:right;">
          <td style="white-space:nowrap; text-align:center;" class="welcome">
            &nbsp;<%=welcome%>&nbsp;<%=session.getAttribute(Constants.USER)%>&nbsp;
          </td>
        </tr>
      </table>
    </td>
  </tr>
  </table>

  <!-- hidden until selected -->
  <div id="helpMenu" style="position:absolute; right:50px; top:0px;" class="menu" onclick="event.cancelBubble=true;this.style.visibility='hidden';">
    <a href="/activator/docs/HPSA-User.pdf" target="_blank" class="item"><%=operUI%></a>
    <hr style="width:98%">
    <!-- Place customized help documents here... -->
    <a href="javascript:popUpAbout();" class="item"><%=about%></a>
  </div>
  
</body>
<%
if (session.getAttribute("expiry_alert_days") != null && !session.getAttribute("expiry_alert_days").equals("")) {
%>
<script>
  alert("You have to change password in " + <%=session.getAttribute("expiry_alert_days")%> + " days.");
</script>
<%
}
%>

</html>
