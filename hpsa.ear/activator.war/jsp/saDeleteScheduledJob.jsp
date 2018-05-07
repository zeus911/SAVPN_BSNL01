<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page import="com.hp.ov.activator.mwfm.*, 
                 com.hp.ov.activator.mwfm.servlet.*,
                 java.net.*" 
         info="" 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>

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

    request.setCharacterEncoding ("UTF-8");

    response.setDateHeader("Expires", 0);
    response.setHeader    ("Pragma",  "no-cache");
%>

<html>
<head>
    <title>HP Service Activator</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
    <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
</head>

<%!
    //I18N strings
    final static String selectFirst     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("684", "You must first select a job to delete.");
    final static String successMsg      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("685", "Scheduled job deleted successfully.");
    final static String errMsg          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("686", "Unable to delete scheduled job: ");
    final static String jobMsg          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("687", "Job ID: ");
%>

<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<%
    //get job id to delete
    String jobParam = (String)URLDecoder.decode(request.getParameter("jobID"),"UTF-8");
    long job = 0;
    if (jobParam == null || jobParam.equals("")) {
%>
       <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
           alert("<%=selectFirst%>");
       </script>
<%
    }
    else {
       try { 
            job = Long.parseLong(jobParam);
            WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION); 
            //delete the job
            wfm.deleteScheduledJob(job);
%>

       <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
          writeToMsgLine("<%=successMsg%><br><%=jobMsg%><%=job%><br>");
          //reload the page
          window.top.main.location = window.top.main.location;
       </script>

<%     } 
       catch (Exception e) { 
         String err = "";
         String nErr = "";
         if (e.getMessage() != null) {
           err = e.getMessage().replace('\n',' ');
          } else {
                err = e.toString().replace('\n',' ');
          }
            nErr = err.replace('"',' ');
%>
         <SCRIPT LANGUAGE="JavaScript">
            alert("HP Service Activator" + "\n\n" + "<%=errMsg%> <%=job%>. <%= nErr%>");
            //reload the page
            window.top.main.location = window.top.main.location;
         </SCRIPT>
<% 
       }
    }
%>
</body>
</html>
