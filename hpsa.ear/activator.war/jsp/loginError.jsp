<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page session="true"
         import="java.net.URLEncoder"
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

<%!
	//I18N strings
	final static String loginMsg	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("262", "Please try logging back into Service Activator...");
	final static String invalidLogin= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("263", "Unable to authenticate user.  Your login/password may be either empty or invalid.") ;
	final static String noWFM	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("264", "Unable to connect to the micro-workflow engine.");
	final static String startWFM	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("265", "Please start the micro-workflow engine and try logging back into Service Activator");
	final static String coreMenuException	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1014", "Unable to display application menus. Please refer to server logs.");
  final static String velidationError	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1015", "Validation Error.");
	final static String userIsDisabled	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1016", "User is disabled.");
	final static String passwordReuse	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1017", "Password can not be used, please contact system administrator.");
	final static String passwordExpired	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1018", "Password is expired, please contact system administrator to change password.");
	final static String invalidSSOLogin = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1294", "Unable to authenticate user.  The SSO user may not be configured or the user may not have right privileges");
	final static String noSSOUserFoundInContext = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1295", "No SSO User found in the LWSSO Security Context");
	%>

<%
    request.setCharacterEncoding("UTF-8");
    String redirect = request.getParameter("redirect");
    if (redirect != null) {
      redirect = URLEncoder.encode(redirect, "UTF-8");
    }
    String messageString = "";
    String loginPage = "login.jsp" + ((redirect == null) ? "" : "?redirect=" + redirect);
    String redirectPage = loginPage;
    
    String errType = (String) request.getParameter("errorType");
    if (errType.indexOf("password_validation")>=0) {
        redirectPage = "changePasswordLogin.jsp";
	if (errType.indexOf("password_validation_user_disabled")>=0){
	redirectPage = loginPage;
	messageString = "<h2>"+userIsDisabled+"</h2>"+"<h2>"+loginMsg+"</h2>";
	}else if (errType.indexOf("password_validation_password_reuse")>=0){
        messageString = "<h2>"+passwordReuse+"</h2>"+"<h2>"+loginMsg+"</h2>";
	}else if (errType.indexOf("password_validation_password_expiried")>=0){
        messageString = "<h2>"+passwordExpired+"</h2>"+"<h2>"+loginMsg+"</h2>";
      }else{
         messageString = "<h2>"+velidationError+"</h2>"+"<h2>"+loginMsg+"</h2>";
      }

     }
%>
<html>
<head>
    <title>HP Service Activator</title>
    <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
    <meta http-equiv="refresh" content="5; url=<%=redirectPage%>"/>
</head>

<body>
<h1 align="center"><img src="/activator/images/splash.png"></h1>
<center>

<%

	if (errType.equals("mwfm")) {
%>
		<h2> <%=noWFM%></h2>
		<h2> <%=startWFM%></h2>
<%
        }
	else if (errType.equals("user")) {
%>
		<h2> <%=invalidLogin%></h2>
		<h2> <%=loginMsg%></h2>
<%
    }
	else if (errType.equals("ssoUser")) {
%>	
        <h2> <%=invalidSSOLogin%></h2>
		<h2> <%=loginMsg%></h2>
<%  
	}
	else if (errType.equals("noSSOUserFoundInContext")) {
%>	
        <h2> <%=noSSOUserFoundInContext%></h2>
   		<h2> <%=loginMsg%></h2>
<%  
	  	}

        // print out the returned error
	else if (errType.equals("license")) {
	        String licMsg = (String)request.getParameter("licMsg");
%>
		<h2> <%=licMsg%></h2>
<%
	}
	else if (errType.equals("coreMenuException")){
%>
		<h2> <%=coreMenuException%></h2>
		<h2> <%=loginMsg%></h2>
<% } %>

	<%=messageString%>

</center>
</body>
</html>
<% messageString = ""; %>
