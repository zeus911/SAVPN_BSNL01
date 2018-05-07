<!DOCTYPE html>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page session="true"
     import="com.hp.ov.activator.license.*, com.hp.ov.activator.util.*, java.net.*"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
// Check if there is a valid session available.
if (session != null) {
    session.invalidate();
    session = null;
}
%>

<%@page import="java.text.MessageFormat"%><html>
<%!   
  //I18N strings
  final static String backLabel = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1633", "Back");
  final static String licenseInfo = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1634", "License Information");
  final static String unknownLicenseProblem = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("550", "An unknown problem occured during the license check!");

  
%>
<head>
  <title>HP Service Activator</title>
  <LINK REL="SHORTCUT ICON" HREF="/activator/images/servact.ico">
  <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
  <script type="text/JavaScript" src="/activator/javascript/saUtilities.js"></script>
  <!-- Check browser type - only IE and Firefox are supported -->
  <script type="text/JavaScript">

  </script>
  <style>
.license {
        color: #afafaf;
}
.license:hover {
        color: #000000;
        background: #CCCCCC;
}
  </style>
  <base target="_top" >
</head>

<%
     request.setCharacterEncoding("UTF-8");
     System.setProperty("MWFM_ETC",application.getInitParameter("ACTIVATOR_ETC"));
%>     

<body>

<div align="center">
<img src="/activator/images/splash.png"><table border="0" cellpadding="0" cellspacing="0">
  <tr>
      <td class="tableHeading" style="height:18px;" width="492" colspan="4" align="left">&nbsp;&nbsp;&nbsp;&nbsp;<%=licenseInfo%></td>
  </tr>
  <tr>
     <td class=tableRow width="36" height="36">&nbsp;</td>
     <td class=tableRow colspan="2" width="420" align="left">
     <%
     
     String licenseText = "";
     licenseManager lm = null;
     try {
       lm = licenseManager.getInstance(System.getProperty("ACTIVATOR_ETC"), System.getProperty("ACTIVATOR_VAR"));
     } catch (Exception e) {

       String errMessage = e.getMessage();
       if (errMessage == null) {
         errMessage = unknownLicenseProblem;
       }
       response.sendRedirect("loginError.jsp?errorType=license&licMsg=" + URLEncoder.encode(errMessage, "UTF-8"));
     }

     if (lm != null) {
       for (Pair<String, String> licPair : lm.licenseInfoPairs()) {
         licenseText += "<br />";
         for (String tok : licPair.getLeft().split("\\n")) {
           licenseText += tok + "<br />";
         }
         licenseText += licPair.getRight().replace("~", " ~ ") + "<br />";
       }
     }
     %>
     <small><%=licenseText%></small>
     </td>
     <td class=tableRow width="36" height="36">&nbsp;</td>
  </tr>    
  <tr>
     <td class=tableRow colspan="4">&nbsp;</td>
  </tr>
  <tr>
     <td class=tableRow colspan="4" align="center" valign="top">&nbsp;<input onClick="window.history.back();" type="button" value="<%=backLabel%>"></td>
  </tr>
  <tr>
      <td class=tableRow colspan="4">&nbsp;</td>
  </tr>
</table>
</div>


</body>
</html>
