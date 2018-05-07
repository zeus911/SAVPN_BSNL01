<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page import=" com.hp.ov.activator.mwfm.servlet.*,
                  java.net.*, 
                  com.hp.ov.activator.mwfm.engine.object.ObjectConstants"
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

    response.setDateHeader("Expires", 0);
    response.setHeader    ("Pragma",  "no-cache");

    request.setCharacterEncoding ("UTF-8");
%>

<%!
    String tooManyWindows =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("332", "You may only interact with one job at a time.  ");
    String closeWindow    =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("321", "Please either close or submit the open interact window."); 
%>

<html>
<head>
    <title>HP Service Activator</title>
    <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
    <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
</head>


<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">

<jsp:useBean id="interactBean" scope="session" class="com.hp.ov.activator.mwfm.servlet.interactBean"/>

<%
     // get the name of the workflow to start
     String jobId = request.getParameter("jobId");
     String interactionType=request.getParameter("interactionType"); 
     String queueName  = URLDecoder.decode(request.getParameter("queueName"),"UTF-8");
     String queryJobId = request.getParameter("queryJobId");
     String queryServiceId = request.getParameter("queryServiceId");
     String queryOrderId = request.getParameter("queryOrderId");
     String queryType = request.getParameter("queryType");
     String queryState = request.getParameter("queryState");


     if (jobId == null || jobId.equals("")) {
         interactBean.freeBean();
         String selectJobFirst = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("207", "You must first select a job to interact with.");
%>
         <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
             alert("<%=selectJobFirst%>");
         </script>
<%
     }
     else {
         // set the interact bean which is used by the pageGenerator servlet
         interactBean.setJobID(jobId);
         interactBean.setJobQueue(queueName);
         interactBean.useBean();
         if (queryJobId != null && !queryJobId.equals("")) {
           interactBean.setQueryJobId(queryJobId);
         }
         if (queryServiceId != null && !queryServiceId.equals("")) {
           interactBean.setQueryServiceId(queryServiceId);
         }
         if (queryOrderId != null && !queryOrderId.equals("")) {
           interactBean.setQueryOrderId(queryOrderId);
         }
         if (queryState != null && !queryState.equals("")) {
           interactBean.setQueryState(queryState);
         }
         if (queryType != null && !queryType.equals("")) {
           interactBean.setQueryType(queryType);
         }
         if(interactionType.equals(""+ObjectConstants.ASKFOR_USER_INTERACTION)){
%>
         <script>
             if (isInteractWinOpen()) {
               alert("<%=tooManyWindows%>" + "<%=closeWindow%>");
             } else {
               document.location.href = '/activator/interact';
             }
         </script>
<%
         } else if(interactionType.equals(""+ObjectConstants.GENERIC_UIDIALOG_USER_INTERACTION)){
%>
         <script>
             if (isInteractWinOpen()) {
               alert("<%=tooManyWindows%>" + "<%=closeWindow%>");
             } else {
               document.location.href = '/activator/uidialoginteract';
             }
         </script>
<%
         }
     }
%>

</body>
</html>