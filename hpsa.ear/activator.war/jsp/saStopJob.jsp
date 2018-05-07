<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page import="com.hp.ov.activator.mwfm.*, 
                 com.hp.ov.activator.mwfm.servlet.*,
                 com.hp.ov.activator.mwfm.component.WFAlreadyKilledException, 
                 java.net.*" 
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

    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
%>

<%!
    //I18N strings
    final static String noJobSelected   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("219", "Possibly the active jobs list has refreshed and your selection has been lost.");
    final static String reselectMsg     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("220", "Please reselect the job you wish to stop.");
    final static String unableToKill    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("307", "Unable to stop job: ");
    final static String reasons     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("222", "Possible reasons include: ");
    final static String reason1     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("223", "Job has already finished executing");
    final static String reason2     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("224", "User does not have permission to stop the selected job");
    final static String successMsg      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("890", "Job successfully requested to stop: ");
    final static String forceSuccessMsg      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("891", "Job successfully requested to stop with force: ");
    
%>

<html>
<head>
    <title>HP Service Activator</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
    <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
</head>

<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">

<%
    // get the parameter that indicates which job to stop
    String jobID= (String)request.getParameter("jobID");
    
    // indicates what kill method to use
    String useForce = (String)request.getParameter("useForce");
    
    if (jobID==null || jobID.equals("")) {
%>
        <SCRIPT LANGUAGE="JavaScript">
            alert("HP Service Activator" + "\n\n" + "<%=noJobSelected%>" + "\n" + "<%=reselectMsg%>");
        </SCRIPT>
<% 
     }
     else { 
        try { 
        WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION); 
        long id = Long.valueOf(jobID).longValue();
        boolean bUseForce = (new Boolean(useForce)).booleanValue();
            if (wfm.canKillJob(id) == true) {
              if (bUseForce) {
                wfm.forceKillJob(id);
%>
                <SCRIPT LANGUAGE="JavaScript">
                  top.main.displayFrame.location = top.main.displayFrame.location; 
                  writeToMsgLine("<%=forceSuccessMsg%>" + "<%=jobID%>");
                </SCRIPT>
<%            } else {
                wfm.killJob(id);
%>
                <SCRIPT LANGUAGE="JavaScript">
                  top.main.displayFrame.location = top.main.displayFrame.location; 
                  writeToMsgLine("<%=successMsg%>" + "<%=jobID%>");
                </SCRIPT>
<% 
              }
            } else {
%>
              <SCRIPT LANGUAGE="JavaScript">
                alert("<%=unableToKill%>" + "<%=reason2%>");
              </SCRIPT>
<%          }
        } catch (WFAlreadyKilledException e) {
            String err = "";
         
         if (e.getMessage() != null) {
           err = e.getMessage().replace('\n',' ');
           
         } else {
           err = e.toString().replace('\n',' ');
         }
%>
            <SCRIPT LANGUAGE="JavaScript">
                 alert("<%=err%>");
            </SCRIPT>
<%      } catch (Exception e) {
            String err = "";
         
         if (e.getMessage() != null) {
           err = e.getMessage().replace('\n',' ');
           
         } else {
           err = e.toString().replace('\n',' ');
         }
%>
            <SCRIPT LANGUAGE="JavaScript">
                 alert("HP Service Activator" + "\n\n" + "<%=unableToKill%> <%=jobID%>:  <%=err%>"
                                              + "\n" + "<%=reasons%>: "
                                              + "\n\t" + "* <%=reason1%>"
                                              + "\n\t" + "* <%=reason2%>" );
            </SCRIPT>
<% 
        }
     }
%>

</body>
</html>
