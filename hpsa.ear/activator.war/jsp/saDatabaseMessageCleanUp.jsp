<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="java.net.*,
                 java.text.*,
                 java.util.*,
                 com.hp.ov.activator.mwfm.servlet.*,
                 com.hp.ov.activator.mwfm.engine.module.*,
                 com.hp.ov.activator.mwfm.*"
         info="Database Messages clean up." 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%!
    //I18N strings
    final static String header          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1137", "Database Messages clean up filter");
    final static String select          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("586", "Select");
    final static String textMsg         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("885", "Delete data in this range");
    final static String note            = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("886", "Note: if the begin date is not specified, filter will delete all data up to the end date.");
    final static String beginDate       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("573", "From");
    final static String beginDateTitle  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("574", "From date, format: {0}");
    final static String endDate         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("575", "To");
    final static String endDateTitle    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("576", "To date, format: {0}");
    final static String time            = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("577", "Time");
    final static String timeTitle       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("578", "Time format: {0}");

    final static String submitForm      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("16", "Submit");
    final static String clearForm       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("595", "Clear form");
    final static String confirmMsg      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1138", "Are you sure you want to delete all database messages data in range:");
    final static String confirmMsg2     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1139", "Are you sure you want to delete all database messages data up to:");
    final static String dateMissingMsg  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("612", "Date must be specified");
    final static String notAdmin        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("596", "You are not administrator.");

    final static String hostName        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("597", "Host");
    final static String allHosts        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("613", "All Hosts");
    final static String alert2          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("599", "Please select a host.");
%>
<%
    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
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
      alert("<%= ExceptionHandler.handle(e) %>");
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

<jsp:useBean id="dbMsgClnFilter" scope="session" class="com.hp.ov.activator.mwfm.servlet.operatorFilterBean"/>

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
  <tr align="left">
    <td nowrap="nowrap" class="pageHead"><%=header%></td>
  </tr>
<%
    if(!errorMsg.equals("")){
%>
  <Script LANGUAGE="JavaScript">
    window.resizeTo(360,370);
  </Script> 
  <tr align="left">
    <td nowrap="nowrap" class="error"><%=errorMsg%></td>
  </tr>
<%
    }
%>
</table>
<form name="inputForm" action="/activator/jsp/saDatabaseMessageCleanUpRedirect.jsp" method="POST" onSubmit="return askConfirm();">
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
    <td colspan="4" class="filterTextTd_left"><%=textMsg%>:</td>
</tr>
<tr>
  <td class="filterTextTd" title="<%=hostName%>"><%=hostName%>:</td><td class="filterText">
<%
  String selHost=dbMsgClnFilter.getHostName(), name;

  if (vct.size()==1) {
    cnb=(ClusterNodeBean)vct.get(0);
%>
<%= cnb.getHostName() %>
<%
  } else {
%>
      <select name="hostName" size="1">
<%
    if (selHost=="") {
%>
      <option value="" selected="selected"><%=allHosts%></option>
<%
    } else {
%>
      <option value=""><%=allHosts%></option>
<%
    }

    Iterator it=vct.iterator();

    while (it.hasNext()) {
      cnb=(ClusterNodeBean)it.next();
      name=cnb.getHostName();
      if (name.compareToIgnoreCase(selHost)==0) {
%><option value="<%=name%>" selected="selected"><%=name%></option><%
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
    <td  class="filterTextTd" title="<%=MessageFormat.format(beginDateTitle,new Object[]{df.toPattern()})%>"><%=beginDate%>:</td>
    <td nowrap="nowrap" title="<%=MessageFormat.format(beginDateTitle,new Object[]{df.toPattern()})%>">
        <input type="text" size="8" name="beginDate" id='inputBeginDate' 
            title="<%=MessageFormat.format(beginDateTitle,new Object[]{df.toPattern()})%>" value="<jsp:getProperty name="dbMsgClnFilter" property="beginDate" />"/>
        <img src="/activator/images/date_select.gif" id="buttonBeginDate" class="dateInputTriger"/>
    </td>
    <td class="filterTextTd" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>"><%=time%>:</td>
    <td title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>">
        <input type="text" size="8" name="beginTime" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>" value="<jsp:getProperty name="dbMsgClnFilter" property="beginTime" />"/></td>
</tr>
<tr>
    <td  class="filterTextTd" title="<%=MessageFormat.format(endDateTitle,new Object[]{df.toPattern()})%>"><%=endDate%>:</td>
    <td nowrap="nowrap" title="<%=MessageFormat.format(endDateTitle,new Object[]{df.toPattern()})%>">
        <input type="text" size="8" name="endDate" id='inputEndDate' title="<%=MessageFormat.format(endDateTitle,new Object[]{df.toPattern()})%>" value="<jsp:getProperty name="dbMsgClnFilter" property="endDate" />"/>
        <img src="/activator/images/date_select.gif" id="buttonEndDate" class="dateInputTriger"/>
    </td>
    <td class="filterTextTd" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>"><%=time%>:</td>
    <td title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>">
        <input type="text" size="8" name="endTime" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>" value="<jsp:getProperty name="dbMsgClnFilter" property="endTime" />"/></td>
</tr>
<tr>
    <td colspan="4" class="filterTextTd_small"><%=note%></td>
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
    document.inputForm.beginDate.value   = " ";
    document.inputForm.beginTime.value   = " ";
    document.inputForm.endDate.value   = " ";
    document.inputForm.endTime.value   = " ";
  }
  
  function TrimString(sInString) {
    sInString = sInString.replace( /^\s+/g, "" );// strip leading
    return sInString.replace( /\s+$/g, "" );// strip trailing
  }
  
  function askConfirm(){
    if(document.inputForm.endDate.value == null ||
        TrimString(document.inputForm.endDate.value) == ""){
        document.inputForm.endDate.focus();
        alert("<%=dateMissingMsg%>");
        return false;
    } else {
        if(document.inputForm.beginDate.value == null ||
           TrimString(document.inputForm.beginDate.value) == ""){
           document.inputForm.beginDate.focus();
            return confirm('<%=confirmMsg2%>'+ document.inputForm.endDate.value+' '+document.inputForm.endTime.value);
        } else {
            return confirm('<%=confirmMsg%>\n'+ document.inputForm.beginDate.value+' '+document.inputForm.beginTime.value +
            ' - ' + document.inputForm.endDate.value+' '+document.inputForm.endTime.value);
        }
    }

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
