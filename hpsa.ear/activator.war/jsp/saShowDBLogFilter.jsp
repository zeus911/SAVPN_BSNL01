<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="java.text.DateFormat"
         info="Display audit filter." 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%!
    //I18N strings
    final static String header          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("760", "Applied Filter");
    final static String hostName        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("416", "Host Name");
    final static String logLevel        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("761", "Log Level");
    final static String beginDate       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("573", "From");
    final static String endDate         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("575", "To");
    final static String partName        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("762", "Part Name");
    final static String componentName   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("763", "Component Name");
    final static String topicName       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("764", "Topic Name");
    final static String moduleName      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("724", "Module Name");
    final static String jobId           = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("146", "Job Id");
%>

<jsp:useBean id="logFilter" scope="session" class="com.hp.ov.activator.mwfm.servlet.LogFilterBean"/>
<%
    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

  String dateBegin = "";
  try{
    dateBegin = DateFormat.getDateTimeInstance().format(logFilter.getParsedBeginDate());
  }catch(Exception e){;}
  String dateEnd = "";
  try{
    dateEnd = DateFormat.getDateTimeInstance().format(logFilter.getParsedEndDate());
  }catch(Exception e){;}
  System.out.println();
%>

<html>
<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
  <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
</head>
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<table class="filterShowTable">
<tr>
  <td class="filterShowTdHeader"colspan="2"><%=header%></td>
  <td class="filterShowTd"><%=hostName%>:</td><td class="filterShowTdValue"><jsp:getProperty name="logFilter" property="hostName" /></td>
  <td class="filterShowTd"><%=logLevel%>:</td><td class="filterShowTdValue"><jsp:getProperty name="logFilter" property="logLevel" /></td>
  <td class="filterShowTd"><%=beginDate%>:</td><td class="filterShowTdValue"><%=dateBegin%></td>
  <td class="filterShowTd"><%=endDate%>:</td><td class="filterShowTdValue"><%=dateEnd%></td>
</tr>
<tr>
  <td class="filterShowTd"><%=partName%>:</td><td class="filterShowTdValue"><jsp:getProperty name="logFilter" property="partName" /></td>
  <td class="filterShowTd"><%=jobId%>:</td><td class="filterShowTdValue"><jsp:getProperty name="logFilter" property="jobId" /></td>
  <td class="filterShowTd"><%=componentName%>:</td><td class="filterShowTdValue"><jsp:getProperty name="logFilter" property="componentName" /></td>
  <td class="filterShowTd"><%=topicName%>:</td><td class="filterShowTdValue"><jsp:getProperty name="logFilter" property="topicName" /></td>
  <td class="filterShowTd"><%=moduleName%>:</td><td class="filterShowTdValue"><jsp:getProperty name="logFilter" property="moduleName" /></td>
</tr>

</table>
</body>
</html>
