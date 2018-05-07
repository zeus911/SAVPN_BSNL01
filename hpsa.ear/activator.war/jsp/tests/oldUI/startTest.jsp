<!-----------------------------------------------------------------------
   HP OpenView Service Activator
   @ Copyright 2000-2002 Hewlett-Packard Company. All Rights Reserved
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
       response.sendRedirect ("../sessionError.jsp");
       return;
    }   
%>


<%!
        // I18N strings
        final static String selectTest   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("133", "You must first select a test to start.");
        final static String msgSent  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("134", "Test message sent: ");
        final static String errMsg       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("135", "Unable to start requested test.");
        final static String verifyConfig = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("136", "Please verify that the SocketListenerModule is correctly configured.  This module is configured in the micro-workflow engine configuration file (mwfm.xml).  ");
        final static String errInfo      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("137", "To re-establish the micro-workflow engine connection please log back into the Operator UI.");
%>

<jsp:useBean id="menuDataBean" scope="session" class="com.hp.ov.activator.mwfm.servlet.menuDataBean"/>

<html>
<head>
  <title>HP Service Activator</title>
  <script language="JavaScript" src="../../javascript/table.js"></script>
  <script language="JavaScript" src="../../javascript/utilities.js"></script>
  <link rel="stylesheet" type="text/css" href="../../css/activator.css">
</head>
<body>

<%
   String testName = menuDataBean.getTestID();
   if (testName == null || testName.equals("")) {
%>
       <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
           alert("<%=selectTest%>"); 
       </script>
<%
   }
   else {
      try {
          // send the message test to the socket module
          String port = (String)session.getAttribute(Constants.TEST_PORT); 
          Sender.main (new String[] { "localhost", port, testName });
%>
          <%=msgSent%> <%= testName %> 
<%
      }
      catch (Exception e) {

          String err = e.getMessage().replace('\n',' ');
%>
          <SCRIPT LANGUAGE="JavaScript">
               processErrorMsg("<%= err %>", "<%=errMsg%>", "<%=verifyConfig%>\n<%=errInfo%>");
          </SCRIPT>
<%
      }
   }
%>

</body>
</html>
