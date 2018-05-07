<%@ page import="com.hp.ov.activator.mwfm.servlet.*"
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
final static String badBeginDate = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("690", "Wrong begin date or time.");
final static String badEndDate = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("601", "Wrong end date or time.");
final static String success = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("615", "Database updated successfuly.");
final static String endDateIsLessThanBegin = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("603", "Begin date is bigger than end date.");
final static String notAdmin = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("596", "You are not administrator.");
final static String closeButton = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("436", "Close");
final static String closeerror  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("608", "Error occurred. Probably you navigated out of main SA page.");
%>

<% 
request.setCharacterEncoding ("UTF-8");
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");
session.removeAttribute("auditClnFilter");
%>

<jsp:useBean id="auditExpFilter" scope="session" class="com.hp.ov.activator.audit.AuditFilterContent" />
<jsp:setProperty name="auditExpFilter" property="*" />

<%
if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == false) {
%>
<script>
alert("<%=notAdmin%>");
</script>
<%
   return;
}
String formType = request.getParameter("formType");
// validate form
String errorMessage = null;
// check that begin date is corect
if(errorMessage == null){
  errorMessage = auditExpFilter.getBeginDate() == null ? badBeginDate : null;
}
// check that end date is corect
if(errorMessage == null){
  errorMessage = auditExpFilter.getEndDate() == null ? badEndDate : null;
}
// check that end date is greater than begin date
if(errorMessage == null && auditExpFilter.getBeginDate().compareTo(auditExpFilter.getEndDate()) > 0){
  errorMessage = endDateIsLessThanBegin;
}
if(errorMessage == null){
%>
<script>
window.onerror = handleError;
function handleError(){
  document.write("<%=closeerror%><br>");
  document.write("<input type='button' onclick='window.close();' value='<%=closeButton%>'>");
  return true;
}
opener.top.location.href="/activator/msgExport/<%=formType+"_export.csv"%>?formType=<%=formType%>"; 
window.close();
</script>
<%
}else{
  //forward back
%>
<script>
location.href="saAuditExport.jsp?errorMsg=<%=errorMessage%>&formType=<%=formType%>";
</script>
<%
}
%>
