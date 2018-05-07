<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page
    import="java.net.*,java.text.*,java.util.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.logger.*,com.hp.ov.activator.mwfm.engine.module.ClusterNodeBean,com.hp.ov.activator.mwfm.*"
    info="Display Log Clean Up filter." session="true"
    contentType="text/html; charset=UTF-8" language="java"%>
<%!//I18N strings
final static String header          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("682", "Log messages clean up filter");
final static String select          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("586", "Select");
final static String hostName        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("656", "Hostname");
final static String hostNameTextMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1129", "Delete records with the hostname");
final static String textMsg         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("610", "Delete records upto");
final static String beginDate       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("573", "From");
final static String beginDateTitle  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("574", "From date, format: {0}");
final static String time            = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("577", "Time");
final static String timeTitle       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("578", "Time format: {0}");
final static String allHosts        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("613", "All Hosts");
final static String submitForm      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("16", "Submit");
final static String clearForm       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("595", "Clear form");
final static String confirmMsg      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("275", "All non-active Service Activator logs will be deleted.");
final static String confirmMsg1     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("217", "Logs that are in use by other processes will not be removed.");
final static String notAdmin        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("212", "You do not have sufficient rights to delete log files.");
final static String waitLogs        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("555", "Please wait while deleting log files ...");
final static String cancelDelLogMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("218", "Delete all logs action cancelled.");
%>
<%
request.setCharacterEncoding("UTF-8");
WFManager wfm = (WFManager)session.getAttribute(Constants.MWFM_SESSION);
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
if (((Boolean)session.getAttribute(Constants.IS_ADMIN)).booleanValue() == false) {
%>
<script>
   alert("<%= notAdmin %>");
   window.close();
</script>
<%
   return;
}
Vector vct=wfm.getPrimaryClusterNodes();
String[] hostNames = new String[vct.size()];
for (int i = 0 ; i < vct.size() ; i++ ) {
   hostNames[i] = ((ClusterNodeBean) vct.get(i)).getHostName();
}
String nodeName = "";
try {
   nodeName = wfm.getHostName();
} catch (Exception e) {
%>
<script language="JavaScript"> 
alert("<%= ExceptionHandler.handle(e) %>"); 
</script>
<%
}
SimpleDateFormat df = (SimpleDateFormat)DateFormat.getDateInstance(DateFormat.SHORT);
SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);
String tmp = request.getParameter("errorMsg");
String errorMsg = URLDecoder.decode((tmp != null ? tmp : ""), "UTF-8");
%>

<jsp:useBean id="logClnFilter" scope="session" class="com.hp.ov.activator.logger.LogFilterBean" />

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
   <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
   <script>
   function clearForm() {
      document.inputForm.hostName.value = "All";
      document.inputForm.beginDate.value = "";
      document.inputForm.beginTime.value = "";
   }
  </script>
</head>
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<table cellpadding="0" cellspacing="0">
   <tr align=left>
      <td nowrap class="pageHead"><%= header %></td>
   </tr>
<%
if (!errorMsg.equals("")) {
%>
   <tr align=left>
      <td nowrap class="error"><%= errorMsg %></td>
   </tr>
<%
}
%>
</table>

<form name="inputForm" action="/activator/jsp/saDeleteLogsFilterRedirect.jsp"
    method="POST" onSubmit="return askLogConfirm();">
<table class="filterTable">
   <tr>
      <td class="filterTextTd"><%= hostNameTextMsg %>:</td>
      <td><select name="hostName">
          <option value="All" selected="selected"><%= allHosts %></option>
<%
for (int i = 0; i < hostNames.length; i++) {
%>
          <option value="<%= hostNames[i] %>"><%= hostNames[i] %></option>
<%
}
%>
          </select>
      </td>
   </tr>
   <tr>
      <td class="filterTextTd" ><%= textMsg %>:</td>
      <td nowrap title="<%= MessageFormat.format(beginDateTitle,new Object[]{df.toPattern()}) %>">
      <input type="text" size="8" name="beginDate" id='inputBeginDate' title="<%= MessageFormat.format(beginDateTitle,new Object[]{df.toPattern()}) %>" 
         value="<jsp:getProperty name="logClnFilter" property="beginDate" />"/>
      <img src="/activator/images/date_select.gif" id="buttonBeginDate" class="dateInputTriger"/>
      </td>
   </tr>
   <tr>
      <td class="filterTextTd" title="<%= MessageFormat.format(timeTitle,new Object[]{tf.toPattern()}) %>"><%= time %>:</td>
      <td title="<%= MessageFormat.format(timeTitle,new Object[]{tf.toPattern()}) %>">
      <input type="text" size="8" name="beginTime" title="<%= MessageFormat.format(timeTitle,new Object[]{tf.toPattern()}) %>"
         value="<jsp:getProperty name="logClnFilter" property="beginTime" />"/>
      </td>
   </tr>
</table>
<br />
<input type="button" value="<%=clearForm%>" onclick="clearForm()">&nbsp;&nbsp;<input type="submit" value="<%= submitForm %>" ></form>
<script>
Calendar.setup({
    inputField     :    "inputBeginDate",
    ifFormat       :    "<%= df.toPattern() %>", 
    daFormat       :    "<%= df.toPattern() %>",
    firstDay       :    1,
    showsTime      :    false,
    timeFormat     :    "24",
    button         :    "buttonBeginDate",
    align          :    "Bl",
    singleClick    :    true
  });
function askLogConfirm(){
   if (confirm("<%= confirmMsg %>" + "\n\n" + "<%= confirmMsg1 %>")) {
      return true;
   } else { 
      return false;
   }
}
</script>
</body>
</html>
