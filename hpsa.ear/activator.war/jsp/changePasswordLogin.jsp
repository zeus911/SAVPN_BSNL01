<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page session="true"
     import="com.hp.ov.activator.license.*, java.net.*"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<html>
<head>
    <title>HP Service Activator</title>
    <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
    <LINK REL="SHORTCUT ICON" HREF="/activator/images/servact.ico">
    <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
    <base target="_top" >
</head>

<%!   
   static String warning = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("254", "WARNING: ");
   static String browser = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("277", "You are using an unsupported browser:  ");
   static String noSupportMsg= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("256", "Certain areas of Service Activator may not function correctly.");
%>

<!-- Check browser type -- only IE is supported -->
<script language="JavaScript" type="text/JavaScript">
    if(navigator.appName != "Netscape" && navigator.appName != "Microsoft Internet Explorer") {
        alert ("<%=warning%>" + "\n" + "<%=browser%>"  + navigator.appName + ".  " + "<%=noSupportMsg%>");
    }
</script>

<%!
    //I18N strings
    final static String userName    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("257", "User Name");
    final static String password    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("258", "Password"); 
    final static String oldPassword    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("995", "Old Password"); 
    final static String newPassword    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("996", "New Password"); 
    final static String confirmNewPassword    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("997", "Confirm New Password"); 
    final static String login   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("998", "Change Password and Log In");
    final static String noLicenseManagerException = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("549", "The license manager could not be created, please check your license settings!");
    final static String unknownLicenseProblem = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("550", "An unknown problem occured during the license check!");
%>

<%
     System.setProperty("MWFM_ETC",application.getInitParameter("ACTIVATOR_ETC"));
%>     

<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();"
  onLoad="if (self != top) top.location = self.location; document.login.user.focus()">

<!-- Start login table -->
<center>
<form action="/activator/jsp/changePassword.jsp" method="post" name="login">
	<input type=hidden name="changepassword" value="true"/>
<div align="center">
<img src="/activator/images/splash.png"><table border="0" cellpadding="0" cellspacing="0">
  <tr>
      <td class=tableHeading colspan="4" align="left" color=white>&nbsp;&nbsp;&nbsp;&nbsp;<%=login%></td>
  </tr>
  <tr>
      <td class=tableRow colspan="4">&nbsp;</td>
  </tr>
  <tr>
     <td class=tableRow width="56" height="36">&nbsp;</td>
     <td class=tableRow width="100" valign="middle" align="right"><%=userName%>&nbsp;</td>
     <td class=tableRow width="280" height="36">&nbsp;
        <input style="width=80%" type=text size=30 name=user maxlength="30"></td>
     <td class=tableRow width="56" height="36">&nbsp;</td>
  </tr>    
  <tr>
     <td class=tableRow width="56" height="36">&nbsp;</td>
     <td class=tableRow width="100" valign="middle" align="right"><%=oldPassword%>&nbsp;</td>
     <td class=tableRow width="280" height="36">&nbsp;
        <input style="width=80%" type=password size=30 name=password maxlength=30></td>
     <td class=tableRow width="56" height="36">&nbsp;</td>
  </tr>
  <tr>
     <td class=tableRow width="56" height="36">&nbsp;</td>
     <td class=tableRow width="100" valign="middle" align="right"><%=newPassword%>&nbsp;</td>
     <td class=tableRow width="280" height="36">&nbsp;
        <input style="width=80%" type=password size=30 name=newpassword maxlength=30></td>
     <td class=tableRow width="56" height="36">&nbsp;</td>
  </tr>
  <tr>
     <td class=tableRow width="56" height="36">&nbsp;</td>
     <td class=tableRow width="100" valign="middle" align="right"><%=confirmNewPassword%>&nbsp;</td>
     <td class=tableRow width="280" height="36">&nbsp;
        <input style="width=80%" type=password size=30 name=confirmpassword maxlength=30></td>
     <td class=tableRow width="56" height="36">&nbsp;</td>
  </tr>  
  <tr>
     <td class=tableRow colspan="4">&nbsp;</td>
  </tr>
  <tr>
     <td class=tableRow colspan="4" align="center" valign="top">&nbsp;
        <input type=submit value="<%=login%>">
  </tr>
  <tr>
      <td class=tableRow colspan="4">&nbsp;</td>
  </tr>
</table>
</div>
<div align="center">
<%
   // if the still using an instant-on license check the expiration date.
   // print a message if the license expires within 30 days 
   try {
     licenseManager lm;
     lm=licenseManager.getInstance(application.getInitParameter("ACTIVATOR_ETC"));
     
     if (lm == null) {
       throw new Exception(noLicenseManagerException);
     }
     
     lm.init();

     if (lm.usingInstantOnLicense()) {
      // license check can be for 30, 60 or 120 days
        String licMsg = lm.print60DayWarning();
        if (licMsg != null) {
%>
      <h2><font color=red><%= warning + licMsg %></font>
<%
        }
      }
    } catch (Exception e) {
      // The URLEncoder actually throws an NullPointerException if the argument given is null, therefore
      // we need to ensure that null is not handed over to the URLEncoder!
      String errMessage = e.getMessage();
      if (errMessage == null) {
        errMessage = unknownLicenseProblem;
      }
      response.sendRedirect ("loginError.jsp?errorType=license&licMsg=" + URLEncoder.encode(errMessage));
    }
%>
</div>
<div class="about" align="center">
  <br>
  <b><%=com.hp.ov.activator.util.ActivatorVersion.getVersion()%></b>
</div>
</center>
<br>
</form>
</body>
</html>
