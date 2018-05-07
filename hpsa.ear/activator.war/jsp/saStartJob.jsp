<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page import="com.hp.ov.activator.mwfm.*, 
                 com.hp.ov.activator.mwfm.servlet.*,
                 java.net.*,
                 java.util.HashMap,
                 com.hp.ov.activator.mwfm.engine.object.ObjectConstants" 
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
    final static String selectFirst = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("160", "You must first select a workflow to start.");
    final static String successMsg  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("161", "Workflow successfully started");
    final static String errMsg      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("176", "Unable to start workflow");
    final static String jobID       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("5", "Job ID");
%>

<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<%
    // get the name of the workflow to start
    String wfName = (String)URLDecoder.decode(request.getParameter("workflowName"),"UTF-8"); 
    String startMode=request.getParameter(Constants.START_MODE);

    if (wfName == null || wfName.equals("")) {
%>
       <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
           alert("<%=selectFirst%>");
       </script>
<%
    }
    else {
       try { 
            WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
            long id=0;
            if(startMode.equals(Constants.STARTMODE_NORMAL)) {
               id = wfm.startJob (wfName);
            } else if(startMode.equals(Constants.STARTMODE_DEBUG)) {
                HashMap casepacket=new HashMap();
                casepacket.put(ObjectConstants.BREAK_POINT,ObjectConstants.FIRST_NODE_BREAK_POINT);
                id = wfm.startJob (wfName,casepacket);
            }
%>

       <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
           writeToMsgLine("<%=successMsg%>: <%= wfName %><br><%=jobID%>: <%=id%><br>");
       </script>

<%     } 
       catch (Exception e) {
         String err = "";
         String nErr = "";
         
         if (e.getMessage() != null) {
           err = e.getMessage().replace('\n',' ');
           
         }
         else{
           err = e.toString().replace('\n',' ');
         }
         nErr = err.replace('"',' ');
%>
         <SCRIPT LANGUAGE="JavaScript">
           alert("HP Service Activator" + "\n\n" + "<%=errMsg%> : <%= nErr%>");
         </SCRIPT>
<% 
       }
    }
%>
</body>
</html>
