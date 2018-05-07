<!DOCTYPE html>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page session="true" contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.text.MessageFormat" %>
<%@ page import="com.hp.ov.activator.license.licenseManager" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.LoginServlet" %>
<%@ page import="com.hp.ov.activator.util.ActivatorVersion" %>
<%@ page import="com.hp.ov.activator.util.Banner" %>

<%
// check if there is a valid session available
if (session != null) {
  session.invalidate();
  session = null;
}
%>

<%!
//I18N strings
final static String warning = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("254", "WARNING: ");
final static String browser = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("277", "You are using an unsupported browser:  ");
final static String noSupportMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("256", "Certain areas of Service Activator may not function correctly.");
final static String moreBannerInfo = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1293", "Please click here for more information");
final static String userName = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("257", "User Name");
final static String password = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("258", "Password");  
final static String login = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("278", "Log In");
final static String noLicenseManagerException = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("549", "The license manager could not be created, please check your license settings!");
final static String unknownLicenseProblem = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("550", "An unknown problem occured during the license check!");
final static String instantOnLicenseExpire = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1341", "Instant on license will expire in {0} days.");
final static String autoLogoutInactivity = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1346", "You have been logged out due to inactivity.");
final static String licenseInfo = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1634", "License Information");
final static String xssWarningMessage = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1713", "Illegal redirect URL found. Skipping redirect.");
%>

<%
request.setCharacterEncoding("UTF-8");
System.setProperty("MWFM_ETC",application.getInitParameter("ACTIVATOR_ETC"));
String redirect = request.getParameter("redirect") == null ? "" : request.getParameter("redirect");
boolean xssWarning = redirect != null && (redirect.indexOf(">") >= 0 || redirect.indexOf("<") >= 0 || redirect.indexOf("&lt;") >= 0 || redirect.indexOf("&gt;") >= 0);
String logoutReason = request.getParameter("logout_reason") == null ? "" : request.getParameter("logout_reason");
String id = request.getParameter("id") == null || request.getParameter("id").trim().isEmpty() ? null : request.getParameter("id");
licenseManager licenseInstance;
String warning;
Banner banner;
%>

<html>
<head>
<title><%= LoginServlet.getMainTitle(id) %></title>
<link rel="shortcut icon" href="/activator/images/servact.ico">
<link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
<script type="text/JavaScript" src="/activator/javascript/saUtilities.js"></script>
<!-- Check browser type - only IE 9+, Firefox, and Chrome are supported -->
<script type="text/JavaScript">
function hideBannerBody()
{
  var bannerBody = document.getElementById("bannerBody");
  if (bannerBody != null) {
    bannerBody.style.visibility = "hidden";
  }
}

function toggleBannerBody()
{
  var bannerBody = document.getElementById("bannerBody");
  var bannerArrowImg = document.getElementById("bannerArrowImg");
  var bannerHeadingTable = document.getElementById("bannerHeadingTable");
  if (bannerBody != null) {
    if (bannerBody.style.visibility == "visible") {
      bannerBody.style.visibility = "hidden";
      bannerArrowImg.src = "/activator/images/up.gif";
      bannerHeadingTable.title = "<%=moreBannerInfo%>";
    } else {
      bannerBody.style.visibility = "visible";
      bannerArrowImg.src = "/activator/images/down.gif";
      bannerHeadingTable.title = "";
    }
  }
}
</script>
<style>
.xss_warning
{
  color:/*c:red*/ #ff0000;
  font-weight:bold;
}
</style>
<base target="_top" >
</head>

<body onload="if (self != top) top.location = self.location; document.login.user.focus(); hideBannerBody();">

<!-- Start login table -->
<form action="/activator/login" method="post" name="login">
  <div style="text-align:center">
    <img src="<%= LoginServlet.getLoginSplash(id) %>">
    <table style="margin-left:auto; margin-right:auto; width:492px; padding:0px; border-spacing:0px; border-collapse:collapse;">
      <tr>
        <td class="tableHeading" style="height:18px; text-align:left;" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;<%=login%></td>
      </tr>
      <tr>
        <td class="tableRow" colspan="4">&nbsp;<input type="hidden" name="redirect" value="<%= xssWarning ? "" : redirect %>"/></td>
      </tr>
      <tr>
        <td class="tableRow" style="width:64px; height:36px;">&nbsp;</td>
        <td class="tableRow" style="width:92px; vertical-align:middle; text-align:right;"><%=userName%>&nbsp;</td>
        <td class="tableRow" style="width:272px; height:36px;">&nbsp;<input type="text" style="width:220px;" name="user" maxlength="30"/></td>
        <td class="tableRow" style="width:64px; height:36px;">&nbsp;</td>
      </tr>    
      <tr>
        <td class="tableRow" style="width:64px; height:36px;">&nbsp;</td>
        <td class="tableRow" style="width:92px; vertical-align:middle; text-align:right;"><%=password%>&nbsp;</td>
        <td class="tableRow" style="width:272px; height:36px;">&nbsp;<input type="password" style="width:220px;" name="password" maxlength="30"/></td>
        <td class="tableRow" style="width:64px; height:36px;">&nbsp;</td>
      </tr>
      <tr>
        <td class="tableRow" colspan="4">&nbsp;</td>
      </tr>
<%
if (xssWarning) {
%>
      <tr>
        <td class="tableRow xss_warning" colspan="4"><%= xssWarningMessage %></td>
      </tr>
      <tr>
        <td class="tableRow" colspan="4">&nbsp;</td>
      </tr>
<%
}
%>
      <tr>
        <td class="tableRow" colspan="4" style="text-align:center; vertical-align:top;">&nbsp;<input type="submit" value="<%=login%>"></td>
      </tr>
      <tr>
        <td class="tableRow" colspan="4" style="text-align:right;">&nbsp;<a href="/activator/jsp/licenseInfo.jsp"><small class="link"><%=licenseInfo%></small></a>&nbsp;</td>
      </tr>
    </table>
  </div>
<%
if (logoutReason.equals("inactivity")) {
%>
  <div style="text-align:center">
    <h2 style="color:red"><%=autoLogoutInactivity%></h2>
  </div>
<%
}
%>
  <div style="text-align:center">
<%
// if still using an instant-on license check the expiration date.
// print a message if the license expires within 60 days 
try {
  licenseInstance = licenseManager.getInstance(application.getInitParameter("ACTIVATOR_ETC"), application.getInitParameter("ACTIVATOR_VAR"));
  warning = licenseInstance.print60DayWarning();
  if (warning != null) {
%>
    <h2 style="color:red"><%= warning %></h2>
<%
  }
} catch (Exception e) {
  response.sendRedirect("loginError.jsp?errorType=license&licMsg=" + URLEncoder.encode(e.getMessage() == null ? unknownLicenseProblem : e.getMessage(), "UTF-8"));
}
%>
  </div>
  <div style="text-align:center;" class="about">
    <br>
    <b title="<%=ActivatorVersion.getFullVersion()%>"><%=ActivatorVersion.getVersion()%></b>
  </div>
  <input type="hidden" name="<%= Constants.CUSTOM_UI_ID %>" value="<%= id %>">
</form>
<%
  banner = new Banner();
  if (banner.headingExists() && banner.bodyExists()) {
%>
<br>
<div style="text-align:center;">
  <table id="bannerHeadingTable"
<%
    if (!banner.isBodyPermanent()) {
%>
      title="<%=moreBannerInfo%>"
<%
    }
%>
       style="margin-left:auto; margin-right:auto; width:492px; padding:0px; border-spacing:0px; border-collapse:collapse;" onClick="javascript:toggleBannerBody();">
    <tr style="vertical-align:middle">
      <td class="tableHeading" style="width:11px"><img style="width:11px; height:11px" src="/activator/images/1x1.gif"></td>
      <td class="tableHeading"><%=banner.getHeading()%></td>
      <td class="tableHeading" style="vertical-align:middle; width:11px;">
        <img style="width:11px; height:11px"
<%
    if (banner.isBodyPermanent()) {
%>
            src="/activator/images/1x1.gif"
<%
    } else {
%>
            src="/activator/images/up.gif" id="bannerArrowImg"
<%
    }
%>
        >
      </td>
    </tr>
  </table>
</div>
<div style="text-align:center;"
<%
    if (banner.isBodyPermanent()) {
%>
    id="bannerBodyPermanent"
<%
    } else {
%>
    id="bannerBody" style="visibility:hidden"
<%
    }
%>
>
  <table style="margin-left:auto; margin-right:auto; width:492px; padding:0px; border-spacing:0px; border-collapse:collapse;">
    <tr><td class="tableRow"><%=banner.getBody()%></td></tr>
  </table>
</div>
<%
  } else if (banner.headingExists()) {
%>
<br>
<div style="text-align:center">
  <table style="margin-left:auto; margin-right:auto; width:492px; padding:0px; border-spacing:0px; border-collapse:collapse;">
    <tr><td class="tableHeading"><%=banner.getHeading()%></td></tr>
  </table>
</div>
<%
  } else if (banner.bodyExists()) {
%>
<br>
<div style="text-align:center">
  <table style="margin-left:auto; margin-right:auto; width:492px; padding:0px; border-spacing:0px; border-collapse:collapse;">
    <tr><td class="tableRow"><%=banner.getBody()%></td></tr>
  </table>
</div>
<%
  }
%>
</body>
</html>
