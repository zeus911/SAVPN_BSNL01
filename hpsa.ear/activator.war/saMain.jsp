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
// the lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<html>
<head>
<title><%= LoginServlet.getMainTitle((String)session.getAttribute(Constants.CUSTOM_UI_ID)) %></title>
<script>
// time in millis to keep the messages frame visible when the URL in the main area refers to a JSF
var SMF_VISIBLE_PERIOD = 10000; // 10 seconds = 10000 milliseconds
var smfDate = null; // last date when the messages frame was forced to be visible
// This function will show/hide the messages area depending on:
//   1. If the URL in the main area refers to a JSF then:
//      1.1. Show the messages area only if it is less than 10 seconds from smfDate, otherwise hide it
//   2. If the URL in the main area does not refer to a JSF then show the messages area
function resize()
{
  var forceSMF = smfDate == null ? false : (new Date().getTime() - smfDate.getTime() <= SMF_VISIBLE_PERIOD);
  var cw = document.body.clientWidth;
  var ch = document.documentElement.clientHeight;
  var w = Math.max(cw - parseInt(document.getElementsByName("leftFrame")[0].style.width), 100) + "px";
  var h = Math.max(ch - parseInt(document.getElementsByName("leftFrame")[0].style.top) - parseInt(document.getElementsByName("counterFrame")[0].style.height), 100) + "px";
  var win = window.frames["main"];
  document.getElementsByName("main")[0].style.width = w;
  document.getElementsByName("sep")[0].style.width = w;
  document.getElementsByName("messageLine")[0].style.width = w;
  document.getElementsByName("processFrame")[0].style.width = w;
  document.getElementsByName("leftFrame")[0].style.height = h;
  if (!forceSMF && win != null && (win.location.pathname.indexOf(".jsf") >= 0 || (win.location.href.indexOf("saCreateFrame.jsp") >= 0 && win.location.href.indexOf(".jsf") >= 0))) {
    document.getElementsByName("main")[0].style.height = Math.max(ch - parseInt(document.getElementsByName("leftFrame")[0].style.top) - 5, 100) + "px";
    document.getElementsByName("sep")[0].style.display = "none";
    document.getElementsByName("messageLine")[0].style.display = "none";
    document.getElementsByName("processFrame")[0].style.display = "none";
  } else {
    document.getElementsByName("main")[0].style.height =
        (ch - parseInt(document.getElementsByName("main")[0].style.top) - parseInt(document.getElementsByName("messageLine")[0].style.height) - parseInt(document.getElementsByName("processFrame")[0].style.height) - 16) + "px";
    document.getElementsByName("sep")[0].style.display = "inherit";
    document.getElementsByName("messageLine")[0].style.display = "inherit";
    document.getElementsByName("processFrame")[0].style.display = "inherit";
  }
  setTimeout("resize()", 500);
}
// Force show the messages area for 10 seconds if the URL in the main area refers to a JSF.
function showMessagesFrame()
{
  smfDate = new Date();
}
// windows array for audit message details (see /activator/jsf/audit/audit.jsf)
var auditWindowsArray = new Array();
</script>
</head>

<body onload="resize();" onresize="resize();" style="margin:0px; padding:0px;">
  <iframe src="jsp/saHeader.jsp" name="topFrame" style="position:fixed; top:0px; left:0px; width:100%; height:45px; border:0px none;" ></iframe>
  <iframe src="jsp/saLeftNavigation.jsp" name="leftFrame" style="position:fixed; top:45px; left:0px; width:140px; height:800px; border:0px none;" ></iframe>
  <iframe src="jsf/misc/saJobCounters.jsf" name="counterFrame" style="position:fixed; bottom:0px; left:0px; width:140px; height:88px; border:0px none;" ></iframe>
  <iframe src="blank.html" id="main" name="main" style="position:fixed; top:45px; left:140px; width:1000px; height:800px; border:0px none;" ></iframe>
  <iframe src="saLine.html" name="sep" style="position:fixed; bottom:138px; left:140px; width:1000px; height:8px; border:0px none;" ></iframe>
  <iframe src="blank.html" name="messageLine" style="position:fixed; bottom:10px; left:140px; width:1000px; height:120px; border:0px none;" ></iframe>
  <iframe src="blank.html" name="processFrame" style="position:fixed; bottom:0px; left:140px; width:1000px; height:10px; border:0px none;" ></iframe>
</body>

</html>