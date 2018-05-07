<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page autoFlush="true" 
         import="
                 com.hp.ov.activator.stats.DatasetProducer,
                 com.hp.ov.activator.mwfm.servlet.Constants,
                 com.hp.ov.activator.utils.*"
         info="Shows progess of statistical datasetProducer" 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%!
    //I18N strings
    final static String threadStoped = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1345", "Process successfully stopped");
    final static String threadNotFound = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("893", "Process not found");
%>
<html>
<head>
  <title>HP Service Activator</title>
  <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
</head>
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute (Constants.USER) == null) {
%>
    <script>
        window.top.topFrame.location = window.top.topFrame.location;
    </script>
<%
       return;
    }
    
    String threadName = request.getParameter("thread");
    String beanName = request.getParameter("bean");
    ThreadGroup gr = Thread.currentThread().getThreadGroup();
    Thread[] list = new Thread[gr.activeCount()];
    int total = gr.enumerate(list);
    boolean threadFound = false;
    if(threadName != null){
        for(int i=0;i<total;i++){
            if(threadName.equals(list[i].getName())){
                ((DatasetProducer)list[i]).stopProducer();
                threadFound = true;
                break;
            }
        }
    //}
    //if(threadFound){
        out.println("\t<script>");
        out.println("\t\talert('"+threadStoped+"');");
        out.println("\t\tlocation.href='/activator/jsf/jobs/jobs.jsf';");
        out.println("\t</script>");
    }else{
        out.println("\t<script>");
        out.println("\t\talert('"+threadNotFound+"');");
        out.println("\t\tlocation.href='/activator/jsf/jobs/jobs.jsf';");
        out.println("\t</script>");
    }
    session.removeAttribute(beanName);
   
%>
<script>
    function stopThread(){
        location.href='stopStatThread.jsp'
    }
</script>
</body>
