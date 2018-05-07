<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page import="com.hp.ov.activator.mwfm.*, 
                 com.hp.ov.activator.mwfm.servlet.*, 
                 com.hp.ov.activator.mwfm.component.WFNoSuchQueueException,
                 com.hp.ov.activator.mwfm.engine.module.MultiThreadedActivationModule,
                 com.hp.ov.activator.mwfm.component.WFNoSuchQueueException,
                 com.hp.ov.activator.mwfm.engine.object.ObjectConstants,
                 com.hp.ov.activator.mwfm.engine.object.CounterDescriptor,
                 java.text.DateFormat,
                 java.util.*,
                 java.net.*,
                 java.util.HashMap"
         info="Display counter of available jobs"
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

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    request.setCharacterEncoding ("UTF-8");
    
    String refreshRate = (String) session.getAttribute(Constants.COUNTER_REFRESH_RATE);
%>
    <%!
    //I18N strings
    final static String totalJobs            = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("757", "Total Jobs");
    final static String scheduledJobs        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("758", "Scheduled");
    final static String waitingJobs          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("165", "Waiting");
    final static String activationJobs       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("759", "Activating");
%>
<%
    int totalJobsCounter = 0;
    int scheduledJobsCounter = 0;
    int waitingJobsCounter = 0;
    int activationJobsCounter = 0;
    StringBuffer stateChangeOperationRes = new StringBuffer();
    try {
        WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
      
        HashSet hidden = (HashSet) session.getAttribute(Constants.QUEUE_HIDDEN);
        HashSet notInteractableQueues = (HashSet) session.getAttribute(Constants.QUEUE_INTERACT);
        CounterDescriptor countResp = wfm.getCounters(hidden, notInteractableQueues);
        totalJobsCounter = countResp.getRunningJobsCount();
        scheduledJobsCounter = countResp.getScheduledJobsCount();
        waitingJobsCounter = countResp.getWaitingJobsCounts();
        activationJobsCounter = countResp.getQueueCount();
        if (countResp.getStatus() == ObjectConstants.EXCEPTION) {
          HashMap exceptionMap = (HashMap) countResp.getExceptionMap();
            for (Iterator it = exceptionMap.keySet().iterator(); it.hasNext();) {
              String hostName = (String) it.next();
              Exception e = (Exception) exceptionMap.get(hostName);
              if (e != null) {
                stateChangeOperationRes.append(hostName);
                stateChangeOperationRes.append(" ");
                stateChangeOperationRes.append(e);
                stateChangeOperationRes.append("\n");
              }
            }
          }

        
        
        if (stateChangeOperationRes.length() != 0) {
%>
        <SCRIPT LANGUAGE="JavaScript"> 
          writeToMsgLine("<%= stateChangeOperationRes.toString() %>"); 
        </SCRIPT>
<%
       }
    } catch(Exception e) {
%>
    <SCRIPT LANGUAGE="JavaScript"> 
        alert("<%= ExceptionHandler.handle(e) %>"); 
        top.location.href = "..";
    </SCRIPT>
<%
    }
%>


<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="/activator/css/saNavigation.css">
    <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
    <meta http-equiv='refresh' content='<%=refreshRate%>'>
<style type="text/css">
.separator{
    padding: 0px 0px 0px 0px;
    padding-bottom: 0px;
    padding-right: 0px;
    padding-left: 0px;
    padding-top: 0px;
    margin: 0px 0px 0px 0px;
    padding-bottom: 0px;
    padding-right: 0px;
    padding-left: 0px;
    padding-top: 0px;
    margin-bottom: 0px;
    margin-left: 0px;
    margin-right: 0px;
    margin-top: 0px;
    overflow-x: hidden;
    overflow-y: hidden;
    overflow: hidden;
    width: 100%;
    height: 1px;
    background: Black;
}
</style>
</head>
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<div valign="middle" height="100%">
<div class="separator">a</div>
<table class="counterTable">
<tr><td class="counterTable" width="130px">&nbsp;<%=totalJobs%>:</td><td class="counterTableNumber"><%=totalJobsCounter%>&nbsp;</td></tr>
<tr><td class="counterTable" width="130px">&nbsp;<%=activationJobs%>:</td><td class="counterTableNumber"><%=activationJobsCounter%>&nbsp;</td></tr>
<tr><td class="counterTable" width="130px">&nbsp;<%=waitingJobs%>:</td><td class="counterTableNumber"><%=waitingJobsCounter%>&nbsp;</td></tr>
<tr><td class="counterTable" width="130px">&nbsp;<%=scheduledJobs%>:</td><td class="counterTableNumber"><%=scheduledJobsCounter%>&nbsp;</td></tr>
</table>
</div>

</body>
</html>
