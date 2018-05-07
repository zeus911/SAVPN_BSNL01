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
    final static String header           = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("880", "Loading statistical data");
    final static String time             = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("881", "Time left");
    final static String stop             = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("183", "Stop");
    final static String calculting       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("882", "calculating ...");
    final static String redir            = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("883", "Generating report, please wait...");
%>
<%
    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
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
    String redirect = request.getParameter("redirect");
    ThreadGroup gr = Thread.currentThread().getThreadGroup();
    Thread[] list = new Thread[gr.activeCount()];
    String str = "";
    int total = gr.enumerate(list);
    boolean threadFound = false;
    if(threadName != null){
        for(int i=0;i<total;i++){
            if(threadName.equals(list[i].getName())){
                long timeLeft = ((DatasetProducer)list[i]).getLeftTime();
                if(timeLeft == 0l){
                    str = calculting;
                }else{
                    str = "~"+Timer.convertLongToHumanString(timeLeft);
                }
                threadFound = true;
                break;
            }
        }
    }
%>
<html>
<head>
  <title>HP Service Activator</title>
<%if(threadFound){%>
  <meta http-equiv='refresh' content='3'>
<%}%>

  <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
  <link rel="stylesheet" type="text/css" href="/activator/css/saContextMenu.css">
  <script language="JavaScript" src="/activator/javascript/table.js"></script>
  <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
  <script language="JavaScript" src="/activator/javascript/saContextMenu.js"></script>
</head>
<body onLoad="clearMessageLine();" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<table cellpadding="0" cellspacing="0">
  <tr align=left>
    <td nowrap class="pageHead"><%=header%></td>
  </tr>
</table>
<%
    if(!str.equals("")){
%>
    <p><%=time%>: <%=str%></p>
    <input type='button' name='stop' value='<%=stop%>' onclick='stopThread()'/>     
<%
    }else{
%>
    <p><%=redir%></p>
    <input type='button' name='stop' value='<%=stop%>' onclick='stopThread()'/>     
<%
    }
    if(!threadFound){
    //lets prepare chart and imagemap
%>
  <script language="JavaScript" src="/activator/chart?width=650&height=400&bean=<%=beanName%>&prepare=1&redirect=<%=redirect%>">
  </script>
<!--
     <script>
        location.href='<%=redirect%>';
     </script>
-->
<%
    }
%>
<script>
    function stopThread(){
        location.href='stopStatThread.jsp?thread=<%=threadName%>&bean=<%=beanName+DatasetProducer.BEAN_EXTENSION%>'
    }
</script>
</body>
