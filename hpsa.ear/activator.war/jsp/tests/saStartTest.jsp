<!-----------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
------------------------------------------------------------------------->

<%@ page import="com.hp.ov.activator.mwfm.*, 
                 com.hp.ov.activator.mwfm.util.*,
                 com.hp.ov.activator.mwfm.servlet.*, 
                 java.net.*, java.io.*" 
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(Constants.USER) == null) {
       response.sendRedirect ("/activator/jsp/sessionError.jsp");
       return;
    }   

    request.setCharacterEncoding ("UTF-8");
%>


<%!
    // I18N strings
    final static String selectTest   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("133", "You must first select a test to start.");
    final static String msgSent  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("134", "Test message sent: ");
    final static String errMsg       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("135", "Unable to start requested test.");
    final static String verifyConfig = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("136", "Please verify that the SocketListenerModule is correctly configured.  This module is configured in the micro-workflow engine configuration file (mwfm.xml).  ");
    final static String errInfo      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("137", "To re-establish the micro-workflow engine connection please log back into the Operator UI.");
%>


<html>
<head>
    <title>HP Service Activator</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
    <script language="JavaScript" src="/activator/javascript/table.js"></script>
    <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
</head>

<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">

<%
   String testName = URLDecoder.decode(request.getParameter("test"),"UTF-8");
   if (testName == null || testName.equals("")) {
%>
       <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
           alert("<%=selectTest%>"); 
       </script>
<%
   }
   else {
      String testType=URLDecoder.decode(request.getParameter("type"),"UTF-8");
      try {
          if(testType.equals("socket")) {
              // send the message test to the socket module
              String port = (String)session.getAttribute(Constants.TEST_PORT); 
              Sender.sendMessageToSocket("localhost", port, testName);
          } else if(testType.equals("jms")) {
              String initialContextFactory = (String)session.getAttribute(Constants.TEST_JMS_INITIALCONTEXT_FACTORY);
              String jndiURL = (String)session.getAttribute(Constants.TEST_JMS_JNDI_URL);
              String connectionFactory = (String)session.getAttribute(Constants.TEST_JMS_CONNECTION_FACTORY);
              String destination = (String)session.getAttribute(Constants.TEST_JMS_DESTINATION);
              Sender.sendMessageToJMSDestination(initialContextFactory, jndiURL, connectionFactory, destination, testName);
          }
%>
          <%=msgSent%> <%= testName %> 
<%
      }
      catch (Exception e) {
%>
      <SCRIPT LANGUAGE="JavaScript"> alert("<%= ExceptionHandler.handle(e) %>"); </SCRIPT>
<%
      }
   }
%>

</body>
</html>
