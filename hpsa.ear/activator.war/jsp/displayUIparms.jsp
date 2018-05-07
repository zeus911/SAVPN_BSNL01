<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page import="com.hp.ov.activator.mwfm.*, 
                 com.hp.ov.activator.mwfm.servlet.*, 
                 java.net.*" 
         info="Displays UI configuraion data" 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<html>
<head>
   <title>HP Service Activator</title>
   <script language="JavaScript" src="/activator/javascript/table.js"></script>
   <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
   <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(Constants.USER) == null) {
%>
    <script>
        window.top.topFrame.location = window.top.topFrame.location;
    </script>
<%
       return;
    }   

%>
</head>

<%!
    //I18n strings
    final static String operatorUI      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("276", "Operator UI Configuration");
    final static String functionality   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("226", "Functionality");
    final static String configurable    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("227", "Configurable");
    final static String paramName       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("228", "Parameter Name");
    final static String value       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("96", "Value");
    final static String description     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("9", "Description");
    final static String appServer       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("229", "Application Server");
    final static String appServerDesc   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("230", "Name and version of application server being used");
    final static String general     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("231", "General");
    final static String refreshRate     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("232", "Refresh rate for Active Job page");
    final static String logDir      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("233", "Directory for Log files");  
    final static String sessionTimeout  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("234", "Default session timeout value");
    final static String inventory       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("145", "Inventory");
    final static String displayInventory    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("235", "Display Inventory");
    final static String userFormat      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("236", "Use format defined in the workflow xml file.  Used to display Job, Workflow and Message descriptions");
    final static String imageSize       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("241", "Indication of either 16x16 or 32x32 icon use");
    final static String testMessages    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("242", "Test Messages");
    final static String testJSP     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("243", "Enable testing inventoryBuilder generated JSPs");
    final static String jspLocation     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("244", "Location of inventoryBuilder generated JSPs");
    final static String auditTrail      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("245", "Enable display of audit trail information");
    final static String testMsgs        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("246", "Enable test message functionality");
    final static String testMsgLocation = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("247", "Directory for Test Message files");
    final static String socketListenerPort  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("248", "Port the socketListener module uses");
    final static String tracking        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("249", "Tracking");
    final static String trackRefreshRate    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("250", "Refresh rate used on the Activation Tracking page");
    final static String user        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("88", "User");
    final static String userLoggedin    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("251", "Name of user logged into Service Activator");
    final static String adminRights     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("252", "Logged in user has adminstrative rights - set in mwfm.xml");
        final static String seconds     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("253", "seconds");
%>
 
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<h2 class="mainSubHeading"><%=operatorUI%></h2>
<center>
<table class="activatorTable" width="75%">
   <tr class="mainHeading">
      <td class="mainHeading" width="10%"> <%=functionality%></td>
      <td class="mainHeading" width="10%"> <%=configurable%></td>
      <td class="mainHeading" width="15%"> <%=paramName%></td>
      <td class="mainHeading" width="30%"> <%=value%></td>
      <td class="mainHeading" width="35%"> <%=description%></td>
   </tr>
    <tr class="tableEvenRow">
    <td class="tableCell"> <%=appServer%></td>
    <td class="tableCell"> &nbsp;</td>
    <td class="tableCell"> &nbsp;</td>
        <td class="tableCell"> <%= application.getServerInfo() %></td>
    <td class="tableCell"> <%=appServerDesc%></td>
    </tr>
    <tr class="tableOddRow">
    <td class="tableCell"> <%=general%> </td>
    <td class="tableCell" align="center"> <img src="/activator/images/ckmark.gif"></td>
    <td class="tableCell"> job_refresh_rate</td>
        <td class="tableCell"> <%=session.getAttribute(Constants.JOB_REFRESH_RATE)%> (<%=seconds%>)</td>
    <td class="tableCell"> <%=refreshRate%></td>
    <tr class="tableEvenRow">
    <td class="tableCell"> &nbsp;</td>
    <td class="tableCell"> &nbsp;</td>
    <td class="tableCell"> log_dir</td>
        <td class="tableCell"> <%=session.getAttribute(Constants.LOG_DIRECTORY) %></td>
    <td class="tableCell"> <%=logDir%></td>
    </tr>
    <tr class="tableOddRow">
    <td class="tableCell"> &nbsp;</td>
    <td class="tableCell" align="center"> <img src="/activator/images/ckmark.gif"></td>
    <td class="tableCell"> session-timeout</td>
        <td class="tableCell"> <%=session.getMaxInactiveInterval() %> (<%=seconds%>)</td>
    <td class="tableCell"> <%=sessionTimeout%></td>
    </tr>
    <tr class="tableEvenRow">
    <td class="tableCell"> &nbsp;</td>
    <td class="tableCell" align="center"><img src="/activator/images/ckmark.gif"></td>
    <td class="tableCell"> format_text</td>
        <td class="tableCell"><%=session.getAttribute(Constants.FORMAT_TEXT)%></td>
    <td class="tableCell"> <%=userFormat%></td>
    </tr>
    
    <tr class="tableOddRow">
    <td class="tableCell"> <%=inventory%></td>
    <td class="tableCell" align="center"> <img src="/activator/images/ckmark.gif"></td>
    <td class="tableCell"> db_mwfm_only_flag</td>
        <td class="tableCell"> <%=session.getAttribute(Constants.USE_IA_DB) %></td>
    <td class="tableCell"> <%=displayInventory%></td>
    </tr>
    <tr class="tableEvenRow">
    <td class="tableCell"> &nbsp;</td>
    <td class="tableCell" align="center"><img src="/activator/images/ckmark.gif"></td>
    <td class="tableCell"> image_size_directory</td>
        <td class="tableCell"> <%=getServletContext().getAttribute(Constants.IMAGE_SIZE_DIR) %></td>
    <td class="tableCell"> <%=imageSize%></td>
    </tr>
    <tr class="tableOddRow">
    <td class="tableCell"> &nbsp;</td>
    <td class="tableCell" align="center"><img src="/activator/images/ckmark.gif"></td>
    <td class="tableCell"> test_jsp</td>
        <td class="tableCell"> <%=getServletContext().getAttribute(Constants.TEST_JSP) %></td>
    <td class="tableCell"> <%=testJSP%></td>
    </tr>
    <tr class="tableEvenRow">
    <td class="tableCell"> &nbsp;</td>
    <td class="tableCell"> &nbsp;</td>
    <td class="tableCell"> jsp_dir</td>
        <td class="tableCell"><%=getServletContext().getAttribute(Constants.INV_JSP_DIR)%></td>
    <td class="tableCell"> <%=jspLocation%></td>
    </tr>
    <tr class="tableOddRow">
    <td class="tableCell"> &nbsp;</td>
    <td class="tableCell" align="center"><img src="/activator/images/ckmark.gif"></td>
    <td class="tableCell"> display_auditInfo</td>
        <td class="tableCell"><%=getServletContext().getAttribute(Constants.AUDIT_TRAIL)%></td>
    <td class="tableCell"> <%=auditTrail%></td>
    </tr>
    <tr class="tableEvenRow">
    <td class="tableCell"> <%=testMessages%></td>
    <td class="tableCell" align="center"><img src="/activator/images/ckmark.gif"></td>
    <td class="tableCell"> tests</td>
        <td class="tableCell"> <%= (session.getAttribute(Constants.MWFM_TESTS))%></td>
    <td class="tableCell"> <%=testMsgs%></td>
    </tr>
    <tr class="tableOddRow">
    <td class="tableCell"> &nbsp;</td>
    <td class="tableCell" align="center"><img src="/activator/images/ckmark.gif"></td>
    <td class="tableCell"> tests_dir</td>
        <td class="tableCell"> <%=session.getAttribute(Constants.TEST_DIRECTORY) %></td>
    <td class="tableCell"> <%=testMsgLocation%></td>
    </tr>
    <tr class="tableEvenRow">
    <td class="tableCell"> &nbsp;</td>
    <td class="tableCell" align="center"><img src="/activator/images/ckmark.gif"></td>
    <td class="tableCell"> socketListener_port</td>
        <td class="tableCell"> <%=session.getAttribute(Constants.TEST_PORT) %></td>
    <td class="tableCell"> <%=socketListenerPort%></td>
    </tr>
    <tr class="tableOddRow">
    <td class="tableCell"> <%=tracking%></td>
    <td class="tableCell" align="center"><img src="/activator/images/ckmark.gif"></td>
    <td class="tableCell"> track_refresh_rate</td>
        <td class="tableCell"><%=session.getAttribute(Constants.TRACK_REFRESH_RATE)%> (<%=seconds%>)</td>
    <td class="tableCell"> <%=trackRefreshRate%></td>
    </tr>
    <tr class="tableEvenRow">
    <td class="tableCell"> <%=user%></td>
    <td class="tableCell"> &nbsp;</td>
    <td class="tableCell"> user</td>
        <td class="tableCell"> <%=session.getAttribute(Constants.USER) %></td>
    <td class="tableCell"> <%=userLoggedin%></td>
    </tr>
    <tr class="tableOddRow">
    <td class="tableCell"> &nbsp;</td>
    <td class="tableCell"> &nbsp;</td>
    <td class="tableCell"> isAdmin</td>
        <td class="tableCell"> <%=session.getAttribute(Constants.MWFM_SERVICES) %></td>
    <td class="tableCell"> <%=adminRights%></td>
    </tr>
</table>
</center>
</body>
</html>
