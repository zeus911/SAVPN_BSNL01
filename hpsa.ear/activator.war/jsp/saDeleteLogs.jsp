<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="com.hp.ov.activator.mwfm.*,
                 com.hp.ov.activator.mwfm.servlet.*,
                 com.hp.ov.activator.mwfm.component.*,
                 com.hp.ov.activator.mwfm.engine.module.ClusterNodeBean,
                 com.hp.ov.activator.util.Dates,
                 java.text.DateFormat,
                 java.text.SimpleDateFormat,
                 java.io.*,
                 java.net.*,
                 java.util.Vector,
                 java.util.Date,
                 java.util.regex.*"
         info="Shows logs."
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
%>

<%!
//I18N strings
final static String successMsg  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("208", "Log file successfully deleted ");
final static String securityErr = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("209", "Security violation - unable to delete log ");
final static String allLogMsg   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("210", "All non-active logs successfully deleted.");
final static String delErr      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("211", "Unable to delete logs");
final static String permissions = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("212", "You do not have sufficient rights to delete log files.");
%>

<%
request.setCharacterEncoding ("UTF-8");
String returnMsg = "";
String hostName = request.getParameter("hostName");
String fromDate = request.getParameter("fromDate");
String fromTime = request.getParameter("fromTime") == null ? "" : request.getParameter("fromTime");
SimpleDateFormat df = (SimpleDateFormat)DateFormat.getDateInstance(DateFormat.SHORT);
SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);
WFManager wfm = (WFManager)session.getAttribute(Constants.MWFM_SESSION);
Vector vct = wfm.getPrimaryClusterNodes();
String[] hostNames = new String[vct.size()];
Date parsedEndDate;
for (int i = 0 ; i < vct.size() ; i++ ) {
   hostNames[i] = ((ClusterNodeBean) vct.get(i)).getHostName();
}
String[] hostDeleteList = "ALL".equalsIgnoreCase(hostName) ? hostNames : new String[] {hostName};
// check for user permission to delete
if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue()) {
   try {
      parsedEndDate = Dates.convertCheckDate(df, fromDate, tf, fromTime, false);
      returnMsg = wfm.deleteLogFiles(hostDeleteList, parsedEndDate);
	   session.setAttribute("DELETE_LOGS", returnMsg);
   } catch (Exception e) {
%>
<script>
alert("<%= ExceptionHandler.handle(e) %>");
</script>
<%
   }
%>
<script>
parent.window.opener.parent.main.location.href = "saCreateFrame.jsp?jsp=/activator/jsp/saLogFrame.jsp";
parent.window.close();
</script>
<%
} else {
%>
<script type="text/JavaScript">
alert("<%=permissions%>");
</script>
<%
}
%>

