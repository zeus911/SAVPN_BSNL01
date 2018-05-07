<!DOCTYPE html>
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
         info="Display audit filter." 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%!
//I18N strings
final static String header          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("609", "Audit messages clean up filter");
final static String select          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("586", "Select");
final static String textMsg         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("610", "Delete records upto");
final static String endDate         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("575", "To");
final static String endDateTitle    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("576", "To date, format: {0}");
final static String time            = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("577", "Time");
final static String timeTitle       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("578", "Time format: {0}");
final static String submitForm      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("16", "Submit");
final static String clearForm       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("595", "Clear form");
final static String confirmMsg      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("611", "Are you sure you want to delete all audit messages up to:");
final static String dateMissingMsg  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("612", "Date must be specified");
final static String notAdmin        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("596", "You are not administrator.");
final static String hostName        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("597", "Host");
final static String allHosts        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("613", "All Hosts");
final static String alert2          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("599", "Please select a host.");
%>
<%
request.setCharacterEncoding ("UTF-8");
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");
%>

<jsp:useBean id="auditClnFilter" scope="session" class="com.hp.ov.activator.audit.AuditFilterContent"/>

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
<%
// check if there is a valid session available.
if (session == null || session.getAttribute (Constants.USER) == null) {
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
  <script>
  alert("<%= ExceptionHandler.handle(e) %>");
  top.location.href="..";
  </script>
<%
  return;
}
Vector vct=wfm.getAllClusterNodes();
SimpleDateFormat df = (SimpleDateFormat)DateFormat.getDateInstance(DateFormat.SHORT);
SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);
String tmp = request.getParameter("errorMsg");
String errorMsg = URLDecoder.decode((tmp!=null?tmp:""), "UTF-8");
%>
</head>
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<table style="border:0px !important; border-collapse:collapse; padding:0px !important;">
  <tr>
    <td class="pageHead" style="text-align:left; white-space:nowrap;"><%=header%></td>
  </tr>
<%
if(!errorMsg.equals("")){
%> 
  <script>
    window.resizeTo(355,285);
  </script> 
  <tr>
    <td class="error" style="text-align:left; white-space:nowrap;"><%=errorMsg%></td>
  </tr>
<%
}
%>
</table>
<form name="inputForm" action="/activator/jsp/saAuditClnFilterRedirect.jsp" method="POST" onSubmit="return askConfirm();">
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
    <td class="filterTextTd" title="<%=hostName%>"><%=hostName%>:</td><td class="filterText">
<%
String selHost=auditClnFilter.getHostName(), name;

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
    <option value="" selected><%=allHosts%></option>
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
    if (selHost !=null && name.compareToIgnoreCase(selHost)==0) {
%>
    <option value="<%=name%>" selected><%=name%></option>
<%
    } else {
%>
    <option value="<%=name%>"><%=name%></option>
<%
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
  <td class="filterTextTd" ><%=textMsg%>:</td>
  <td title="<%=MessageFormat.format(endDateTitle,new Object[]{df.toPattern()})%>" style="text-align:left; white-space:nowrap;">
    <input type="text" size="8" name="endDateAsString" id='inputEndDate' title="<%=MessageFormat.format(endDateTitle,new Object[]{df.toPattern()})%>" 
        value="<jsp:getProperty name="auditClnFilter" property="endDateAsString" />"/>
      <img src="/activator/images/date_select.gif" id="buttonEndDate" class="dateInputTriger"/>
  </td>
</tr>
<tr>
  <td class="filterTextTd" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>"><%=time%>:</td>
  <td title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>">
    <input type="text" size="8" name="endTimeAsString" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>"
        value="<jsp:getProperty name="auditClnFilter" property="endTimeAsString" />"/>
  </td>
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
  singleClick    :    true,
  position       :    [145, 90]
});
function clearForm(){
<%
if (vct.size()!=1) {
%>
  document.inputForm.hostName.selectedIndex = 0;
<%
}
%>
  document.inputForm.endDateAsString.value = " ";
  document.inputForm.endTimeAsString.value = " ";
}
function TrimString(sInString) {
  sInString = sInString.replace( /^\s+/g, "" );// strip leading
  return sInString.replace( /\s+$/g, "" );// strip trailing
}
function askConfirm(){
  if (document.inputForm.endDateAsString.value == null || TrimString(document.inputForm.endDateAsString.value) == "") {
     document.inputForm.endDateAsString.focus();
     alert("<%=dateMissingMsg%>");
     return false;
  }
<%
if (vct.size()!=1) {
%>
  if (document.inputForm.hostName.selectedIndex==-1) {
    alert('<%=alert2%>');
    return false;
  }
<%
}
%>
  return confirm('<%=confirmMsg%>\n'+ document.inputForm.endDateAsString.value+' '+document.inputForm.endTimeAsString.value);
}
</script>
</body>
</html>
