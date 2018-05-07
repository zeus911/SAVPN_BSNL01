<%@ page import="java.sql.*,
                 javax.sql.*,
                 com.hp.ov.activator.audit.*,
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
final static String badEndDate = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("614", "Wrong date or time.");
final static String success = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("615", "Database updated successfuly.");
final static String notAdmin = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("596", "You are not administrator.");
final static String waitAudit = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("616", "Please wait while deleting Audit records ...");
final static String errMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("617", "Unable to clean up audit messages");
%>

<% 
request.setCharacterEncoding ("UTF-8");
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");
session.removeAttribute("auditClnFilter");
%>

<jsp:useBean id="auditClnFilter" scope="session" class="com.hp.ov.activator.audit.AuditFilterContent"/>
<jsp:setProperty name="auditClnFilter" property="*" />

<%
if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == false) {
%>
<script>
alert("<%=notAdmin%>");
</script>
<%
  return;
}
// check if end date is corect
String errorMessage = auditClnFilter.getEndDate() == null ? badEndDate : null;
if (errorMessage == null) {
  DataSource dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
  Connection con = null;
  try { 
    con = (Connection) dataSource.getConnection();
    Audit.deleteFiltered(con, auditClnFilter);
%>
<script>
parent.window.opener.parent.main.location.href = "/activator/jsf/audit/audit.jsf";
</script>
<%
  } catch(Exception e) {
    e.printStackTrace();
    String err = e.getMessage() == null ? e.toString().replace('\n',' ') : e.getMessage().replace('\n',' ').replace('"',' ');
%>
<script>
alert("HP Service Activator" + "\n\n" + "<%=errMsg%> :  <%=err%>");
parent.window.opener.parent.main.location.href = "/activator/jsf/jobs/jobs.jsf";
parent.window.close();
</script>
<%
  } finally {
    if (con != null) {
      con.close(); 
    }
  }
%>
<script>
//parent.window.opener.parent.main.location.href = "saCreateFrame.jsp?jsp=saAuditMsgs.jsp?recStart=1";
parent.window.close();
</script>
<%
}else{
  //forward back
%>
<script>
location.href="saAuditCleanUp.jsp?errorMsg=<%=errorMessage%>";
</script>
<%
}
%>
