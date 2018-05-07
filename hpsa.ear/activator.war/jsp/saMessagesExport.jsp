<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="java.net.*,
                 java.text.*,
                 java.util.*,
                 com.hp.ov.activator.mwfm.*,
                 com.hp.ov.activator.mwfm.engine.module.*,
                 com.hp.ov.activator.mwfm.servlet.*"
         info="Display audit filter." 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%!
    //I18N strings
    final static String header          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("898", "Messages Export Filter");

    final static String beginDate       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("573", "From");
    final static String beginDateTitle  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("574", "From date, format: {0}");
    final static String endDate         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("575", "To");
    final static String endDateTitle    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("576", "To date, format: {0}");
    final static String time            = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("577", "Time");
    final static String timeTitle       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("578", "Time format: {0}");
    final static String notAdmin        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("596", "You are not administrator.");

    final static String submitForm      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("16", "Submit");
    final static String clearForm       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("595", "Clear form");

    final static String hostName        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("597", "Host");
    final static String allHosts        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("613", "All Hosts");
    final static String alert2          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("599", "Please select a host.");
    
    final static String queueName       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("147", "Queue");
    final static String allQueues       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("899", "All Queues");
    final static String queueAlert      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("900", "Please select a Queue.");
    final static String hostNameCol     = "HOSTNAME";
    final static String selQry          = "select "+hostNameCol+" from CLUSTERNODELIST";
%>
<%
    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    String formType = request.getParameter("formType");
    
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(Constants.USER) == null) {
%>
    <script>
        opener.top.topFrame.location = opener.top.topFrame.location;       
        window.close();
    </script>
<%
       return;
    }

    if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == false) {
%>
    <script>
        alert("<%=notAdmin%>");
        window.close();
    </script>
<%
       return;
    }

    WFManager wfm=null;
    try {
      wfm=(WFManager)session.getAttribute(Constants.MWFM_SESSION);
    } catch (Exception e) {
%>
    <SCRIPT LANGUAGE="JavaScript">
      alert("<%=ExceptionHandler.handle(e) %>");
      top.location.href="..";
    </SCRIPT>
<%
      return;
    }

    Vector vct=wfm.getAllClusterNodes();

    SimpleDateFormat df = (SimpleDateFormat)DateFormat.getDateInstance(DateFormat.SHORT);
    SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);
    String tmp = request.getParameter("errorMsg");
    String errorMsg = URLDecoder.decode((tmp!=null?tmp:""), "UTF-8");
%>

<jsp:useBean id="msgExpFilter" scope="session" class="com.hp.ov.activator.mwfm.servlet.MessageFilterBean"/>
<html>
<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
  <!-- calendar stylesheet -->
  <link rel="stylesheet" type="text/css" media="all" href="/activator/css/calendar-win2k-1.css" title="win2k-cold-1" />

  <!-- main calendar program -->
  <script type="text/javascript" src="/activator/javascript/calendar.js"></script>

  <!-- language for the calendar -->
  <script type="text/javascript" src="/activator/javascript/calendar-en.js"></script>

  <!-- the following script defines the Calendar.setup helper function, which makes
       adding a calendar a matter of 1 or 2 lines of code. -->
  <script type="text/javascript" src="/activator/javascript/calendar-setup.js"></script>
  <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
</head>
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<table cellpadding="0" cellspacing="0">
  <tr align=left>
    <td nowrap class="pageHead"><%=header%></td>
  </tr>
<%
    if(!errorMsg.equals("")){
%>
  <Script LANGUAGE="JavaScript">
    window.resizeTo(365,340);
  </Script>
  <tr align=left>
    <td nowrap class="error"><%=errorMsg%></td>
  </tr>
<%
    }
%>
</table>
<form name="inputForm" action="/activator/jsp/saMessageExportRedirect.jsp?formType=<%=formType %>" method="POST" onsubmit="return checkForm()">
<%
  ClusterNodeBean cnb=null;

  if (vct.size()==1) {
    cnb=(ClusterNodeBean)vct.get(0);
%>
<input type="hidden" name="hostName" value="<%=cnb.getHostName() %>">
<%
  }
%>
<table class="filterTable">

<tr>
    <td colspan="1" class="filterTextTd"><%=hostName%>:</td><td colspan="3" class="filterTextTd_left">
<%
  String selHost=msgExpFilter.getHostName(), name;
  msgExpFilter.setHostName("");
  if (vct.size()==1) {
    cnb=(ClusterNodeBean)vct.get(0);
%>
<%= cnb.getHostName() %>
<%
  } else {
%>
    <select name="hostName" size="1">
<%
    if (selHost=="") { %>
      <option value="" selected><%=allHosts%></option>
<%
    } else { %>
      <option value=""><%=allHosts%></option>
<%
    }

    Iterator it=vct.iterator();

    while (it.hasNext()) {
      cnb=(ClusterNodeBean)it.next();
      name=cnb.getHostName();
      if (name.compareToIgnoreCase(selHost)==0) {
%><option value="<%=name%>" selected><%=name%></option><%
      } else {
%><option value="<%=name%>"><%=name%></option><%
      }
    }
%>
    </select>
<%
  }
%>
</td>
</tr>

<tr>
    <td colspan="1" class="filterTextTd"><%=queueName%>:</td><td colspan="3" class="filterTextTd_left">
<%
  String selQueue=msgExpFilter.getQueueName(), queuename;
  msgExpFilter.setQueueName("");
  String selectedHost=msgExpFilter.getHostName();
  
  // get all data from queues  
  String[] availQueues = wfm.listMessageQueues();
  if (availQueues.length == 1) {
    queuename = availQueues[0];
    msgExpFilter.setQueueName(queuename);
%>
<%= queuename %>
<%
  } else {
%>
    <select name="queueName" size="1">
<%
    if (selQueue=="") { %>
      <option value="" selected><%=allQueues%></option>
<%
    } else { %>
      <option value=""><%=allQueues%></option>
<%
    }
    
    for (int i=0; i<availQueues.length; i++) {
      queuename = availQueues[i];
      if (queuename.compareToIgnoreCase(selQueue)==0) {
%><option value="<%=queuename%>" selected><%=queuename%></option><%
      } else {
%><option value="<%=queuename%>"><%=queuename%></option><%
      }
    }
%>
    </select>
<%
  }
%>
</td>
</tr>

<tr>
    <td title="<%=MessageFormat.format(beginDateTitle,new Object[]{df.toPattern()})%>" class="filterTextTd"><%=beginDate%>:</td>
    <td nowrap title="<%=MessageFormat.format(beginDateTitle,new Object[]{df.toPattern()})%>"><input type="text" size="8" name="beginDate" 
        title="<%=MessageFormat.format(beginDateTitle,new Object[]{df.toPattern()})%>" id='inputBeginDate' value="<jsp:getProperty name="msgExpFilter" property="beginDate" />"/>
        <img src="/activator/images/date_select.gif" id="buttonBeginDate" class="dateInputTriger"/>
    </td>
    <td class="filterTextTd" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>"><%=time%>:</td>
    <td title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>">
    <input type="text" size="8" name="beginTime" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>" value="<jsp:getProperty name="msgExpFilter" property="beginTime" />"/></td>
</tr>
<tr>
    <td  class="filterTextTd" title="<%=MessageFormat.format(endDateTitle,new Object[]{df.toPattern()})%>"><%=endDate%>:</td>
    <td nowrap title="<%=MessageFormat.format(endDateTitle,new Object[]{df.toPattern()})%>">
        <input type="text" size="8" name="endDate" id='inputEndDate' title="<%=MessageFormat.format(endDateTitle,new Object[]{df.toPattern()})%>" value="<jsp:getProperty name="msgExpFilter" property="endDate" />"/>
        <img src="/activator/images/date_select.gif" id="buttonEndDate" class="dateInputTriger"/>
    </td>
    <td class="filterTextTd" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>"><%=time%>:</td>
    <td title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>">
        <input type="text" size="8" name="endTime" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>" value="<jsp:getProperty name="msgExpFilter" property="endTime" />"/></td>
</tr>
</table>
<br/>
<br/>
<input type="button" value="<%=clearForm%>" onclick="clearForm()">
<input type="submit" value="<%=submitForm%>">
</form>
<script>
  Calendar.setup({
    inputField     :    "inputEndDate",
    ifFormat       :    "<%=df.toPattern()%>", 
    daFormat       :    "<%=df.toPattern()%>",
    firstDay       :    1,
    showsTime      :    false,
    timeFormat     :    "24",
    button         :    "buttonEndDate",
    align          :    "Bl",
    singleClick    :    true
  });

  Calendar.setup({
    inputField     :    "inputBeginDate",
    ifFormat       :    "<%=df.toPattern()%>", 
    daFormat       :    "<%=df.toPattern()%>",
    firstDay       :    1,
    showsTime      :    false,
    timeFormat     :    "24",
    button         :    "buttonBeginDate",
    align          :    "Bl",
    singleClick    :    true
  });

  function clearForm(){
<%
  if (vct.size()!=1) { %>
    document.inputForm.hostName.selectedIndex = 0;    
<%
  }
%>
<%
  if (availQueues.length != 1) { %>
    document.inputForm.queueName.selectedIndex = 0;    
<%
  }
%>
    document.inputForm.beginDate.value   = " ";
    document.inputForm.beginTime.value   = " ";
    document.inputForm.endDate.value   = " ";
    document.inputForm.endTime.value   = " ";
  }
 
  function checkForm() {
<%
  if (vct.size()!=1) { %>
    if (document.inputForm.hostName.selectedIndex==-1) {
      alert('<%=alert2%>');
      return false;
    }
<%
  }
%>
  }
</script>
</body>
</html>
