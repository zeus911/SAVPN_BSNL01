<%@ page import="java.util.Random,
                 java.text.DateFormat,
                 java.text.SimpleDateFormat,
                 java.sql.*,
                 javax.sql.*,
                 com.hp.ov.activator.logger.*,
                 com.hp.ov.activator.mwfm.servlet.*"
         info="Checks for valid submit data." 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%!
//I18N strings
final static String badBeginDate    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("614", "Wrong date or time.");
final static String success         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("615", "Database updated successfuly.");
final static String notAdmin        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("596", "You are not administrator.");
final static String dateRequired    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1549", "A date is required.");
%>

<%
request.setCharacterEncoding ("UTF-8");
// don't cache the page
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");
session.removeAttribute("logClnFilter");
session.removeAttribute("LogFilterInSession");
%>

<jsp:useBean id="logClnFilter" scope="session" class="com.hp.ov.activator.logger.LogFilterBean"/>
<jsp:setProperty name="logClnFilter" property="*" />

<%
SimpleDateFormat df = (SimpleDateFormat)DateFormat.getDateInstance(DateFormat.SHORT);
SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);
String errorMessage = "";
String url = "";
if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == false) {
   errorMessage = notAdmin;
} else {
   if(!logClnFilter.getBeginDate().equals("")){
      try{
         errorMessage = logClnFilter.parseBeginDate(df, tf) ? "" : badBeginDate;
      } catch (Exception e) {
         errorMessage = badBeginDate;
      }
   }
   if(errorMessage.equals("")){
      if (logClnFilter.getBeginDate().equals("") && !logClnFilter.getBeginTime().equals("")) {
         errorMessage = dateRequired;
      }
   }
}
//perform delete
if(errorMessage.equals("")){
   url = "saDeleteLogs.jsp?hostName=" + logClnFilter.getHostName() +
         "&fromDate=" + logClnFilter.getBeginDate() +
         "&fromTime=" + logClnFilter.getBeginTime();
%>
<SCRIPT LANGUAGE="JavaScript"> 
location.href = '<%= url %>';
</script>
<%
} else {
%>
<script>
location.href="saDeleteLogsFilter.jsp?errorMsg=<%= errorMessage %>";
</script>
<%
}
%>
