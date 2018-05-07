<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.               --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>               
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/ErrorHandler/Update_Delayed_Activation/delayed_activation_jobs.jsp,v $                                                                   --%>
<%-- $Revision: 1.6 $                                                                 --%>
<%-- $Date: 2010-11-15 07:37:45 $                                                                     --%>
<%-- $Author: tanye $                                                                   --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- Queue: 'delayed_activation_jobs' --%>

<%@ page contentType="text/html; charset=UTF-8"
         import="javax.sql.DataSource,java.sql.Connection,
                 java.sql.*,com.hp.ov.activator.mwfm.JobRequestDescriptor,
                 com.hp.ov.activator.mwfm.servlet.Constants,
                 com.hp.ov.activator.mwfm.AttributeDescriptor,
                 java.util.ArrayList,
                 com.hp.ov.activator.vpn.inventory.*,
                 java.text.*,
                 java.util.*" %>

<%
    
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");

%>

<html>
<head>
  <title>hp OpenView service activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
   <script language="JavaScript">       
    window.resizeTo(800,500);
  </script>
</head>


<body onUnLoad="opener.window.top.interactWindow=null">
<h3><img src="/activator/images/HPLogo.png" valign="top" align="right">Interact with job: ErrorHandler</h3>
<center>
<table width="100%" border=0 cellpadding=0>
<tr>
   <th class="tableHeading">Job ID</th>
   <th class="tableHeading">Workflow</th>
   <th class="tableHeading">Start Date & Time</th>
   <th class="tableHeading">Post Date & Time</th>
   <th class="tableHeading">Step Name</th>
   <th class="tableHeading">Description</th>
   <th class="tableHeading">Status</th>
</tr>


<%-- Get the job descriptor to enable access to general job information --%>
<% JobRequestDescriptor jd= (JobRequestDescriptor) session.getAttribute(Constants.MWFM_JOB_DESCRIPTOR); %>

<tr>
    <td class="tableRow"> <%= jd.jobId %> </td>
    <td class="tableRow"> <%= jd.name %> </td>
    <td class="tableRow"> <%= jd.startTime %> </td>
    <td class="tableRow"> <%= jd.postDate %> </td>
    <td class="tableRow"> <%= jd.stepName == null ? "&nbsp;" : jd.stepName %> </td>
    <td class="tableRow"> <%= jd.description == null ? "&nbsp;" : jd.description %> </td>
    <td class="tableRow"> <%= jd.status == null ? "&nbsp;" : jd.status %> </td>
</tr>
</table>

<%
    String ip = request.getRemoteAddr();
    AttributeDescriptor ad0 = jd.attributes[0]; // return_code
    AttributeDescriptor ad1 = jd.attributes[1]; // VPN_Info
    AttributeDescriptor ad2 = jd.attributes[2]; // messafe_file_data
    AttributeDescriptor ad6 = jd.attributes[6]; // message_file
    AttributeDescriptor ad7 = jd.attributes[7]; //retries
    AttributeDescriptor ad8 = jd.attributes[8]; //days
    AttributeDescriptor ad9 = jd.attributes[9]; //hours
    AttributeDescriptor ad10 = jd.attributes[10]; //minutes
    AttributeDescriptor ad12 = jd.attributes[12]; //default_retries
    AttributeDescriptor ad13 = jd.attributes[13]; //default_days
    AttributeDescriptor ad14 = jd.attributes[14]; //default_hours
    AttributeDescriptor ad15 = jd.attributes[15]; //default_minutes

    String return_code = request.getParameter("return_code");
    if ( return_code == null ) {
      return_code = ad0.value == null ? "" : ad0.value;
    }

    String VPN_Info = request.getParameter("VPN_Info");
    if ( VPN_Info == null ) {
      VPN_Info = ad1.value == null ? "" : ad1.value;
    }

    String message_file_data = request.getParameter("message_file_data");
    if ( message_file_data == null ) {
      message_file_data = ad2.value == null ? "" : ad2.value;
    }

    String message_file = request.getParameter("message_file");
    if ( message_file == null ) {
      message_file = ad6.value == null ? "" : ad6.value;
    }

    String da_retries = request.getParameter("da_retries");
    if ( da_retries == null ) {
      da_retries = ad7.value == null ? "" : ad7.value;
    }

    String da_timePeriodDays = request.getParameter("da_timePeriodDays");
    if ( da_timePeriodDays == null ) {
      da_timePeriodDays = ad8.value == null ? "" : ad8.value;
    }

    String da_timePeriodHours = request.getParameter("da_timePeriodHours");
    if ( da_timePeriodHours == null ) {
      da_timePeriodHours = ad9.value == null ? "" : ad9.value;
    }

    String da_timePeriodMins = request.getParameter("da_timePeriodMins");
    if ( da_timePeriodMins == null ) {
      da_timePeriodMins = ad10.value == null ? "" : ad10.value;
    }

    String default_retries = request.getParameter("default_retries");
    if ( default_retries == null ) {
      default_retries = ad12.value == null ? "" : ad12.value;
    }

    String default_timePeriodDays = request.getParameter("default_timePeriodDays");
    if ( default_timePeriodDays == null ) {
      default_timePeriodDays = ad13.value == null ? "" : ad13.value;
    }

    String default_timePeriodHours = request.getParameter("default_timePeriodHours");
    if ( default_timePeriodHours == null ) {
      default_timePeriodHours = ad14.value == null ? "" : ad14.value;
    }

    String default_timePeriodMins = request.getParameter("default_timePeriodMins");
    if ( default_timePeriodMins == null ) {
      default_timePeriodMins = ad15.value == null ? "" : ad15.value;
    }
    boolean show = "true".equals(request.getParameter("show"));

%>

    <p>
    <!--table border="1"-->
<table border="0">
<tr>
   <td><b>VPN Info </b></td>
   <td colspan="3"><%= VPN_Info %></td>
</tr>

<form name="rsform" action="/activator/customJSP/ErrorHandler/Update_Error_Handler/delayed_activation_jobs.jsp" method="POST">

<tr>
   <td><b>Description </b></td>
   <td colspan="3">
     <textarea cols="60" rows="4" name="errorhandler_description" id="errorhandler_description"></textarea>
   </td>
</tr>

<tr>
   <td><b>Retries Pending </b></td>
   <td colspan="3">
   <input  class='inputField' type=text name="Retries"  value="<%= da_retries%>" size="2">    
   </td>
</tr>
<tr>
    <td align="left"> 
        <b> 
        Time Period </b>(DD:HH:MM) 
    </td>
    <td align="left" colspan="3"> 
        <b>
            <input  class='inputField' type=text name="Days"  value="<%= Long.parseLong(da_timePeriodDays)/86400000%>" size="2">:
            <input  class='inputField' type=text name="Hours"  value="<%= Long.parseLong(da_timePeriodHours)/3600000%>" size="2">:
            <input  class='inputField' type=text name="Minutes"  value="<%= Long.parseLong(da_timePeriodMins)/60000%>" size="2">
        </b>
      </td>
</tr>


</form>

<%-- Concrete job information: attributes --%>
<form name="form" action="/activator/sendCasePacket" method="POST"
onsubmit="errorhandler_description.value=document.rsform.errorhandler_description.value">
    <input type="hidden" name="id" value="<%= jd.jobId %>">
    <input type="hidden" name="workflow" value="<%= jd.name %>">
    <input type="hidden" name="queue" value="delayed_activation_jobs">
    <input type="hidden" name="return_code" value="<%= return_code%>">
    <input type="hidden" name="operator_name" value="<%= session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) %>">
    <input type="hidden" name="errorhandler_description" value="">
    <input type="hidden" name="clientip" value="<%= ip %>">
    <input type="hidden" name="da_retries" value="<%= da_retries %>">
    <input type="hidden" name="da_timePeriodDays" value="<%= da_timePeriodDays %>">
    <input type="hidden" name="da_timePeriodHours" value="<%= da_timePeriodHours %>">
    <input type="hidden" name="da_timePeriodMins" value="<%= da_timePeriodMins %>">
    <input type="hidden" name="default_retries" value="<%= default_retries %>">
    <input type="hidden" name="default_timePeriodDays" value="<%= default_timePeriodDays %>">
    <input type="hidden" name="default_timePeriodHours" value="<%= default_timePeriodHours %>">
    <input type="hidden" name="default_timePeriodMins" value="<%= default_timePeriodMins %>">
    <input type="hidden" name="user_input" value="0">
    <script>
    function validateAll() 
    {
        var submitted = true;
        var retries = document.rsform.Retries.value;
        var days =document.rsform.Days.value;
        var hours =document.rsform.Hours.value;
        var minutes = document.rsform.Minutes.value;
        if (retries.length < 1 ){
            alert ("Retries should have a value");
            submitted = false;
            document.rsform.Retries.focus();
        }
        else if (days.length < 1 ){
            alert ("Days should have a value");
            submitted = false;
            document.rsform.Days.focus();
        }
        else if (hours.length < 1 ){
            alert ("Hours should have a value");
            submitted = false;
            document.rsform.Hours.focus();
        }
        else if (minutes.length < 1 ){
            alert ("Minutes should have a value");
            submitted = false;
            document.rsform.Minutes.focus();
        }
        else if(isNaN(retries)){
            alert ("Retries should be a non negative number");
            submitted = false;
            document.rsform.Retries.focus();
        }
        else if(isNaN(days)){
            alert ("Days should be a non negative number");
            submitted = false;
            document.rsform.Days.focus();
        }
        else if(isNaN(hours)){
            alert ("Hours should be a non negative number");
            submitted = false;
            document.rsform.Hours.focus();
        }
        else if(isNaN(minutes)){
            alert ("Minutes should be a non negative number");
            submitted = false;
            document.rsform.Minutes.focus();
        }
        else if(parseInt(retries) < 0){
            alert ("Retries should be non negative number");
            submitted = false;
            document.rsform.Retries.focus();
        }
        else if(parseInt(days) < 0){
            alert ("Days should be non negative number");
            submitted = false;
            document.rsform.Days.focus();
        }
        else if(parseInt(hours) < 0){
            alert ("Hours should be non negative number");
            submitted = false;
            document.rsform.Hours.focus();
        }
        else if(parseInt(minutes) < 0){
            alert ("Minutes should be non negative number");
            submitted = false;
            document.rsform.Minutes.focus();
        }
        else if (parseInt(hours) > 23)
        {
            alert ("Hours values should be non negative number less than 24");
            submitted = false;
            document.rsform.Hours.focus();
        }
        else if (parseInt(minutes) > 59)
        {
            alert ("Hours values should be non negative number less than 60");
            submitted = false;
            document.rsform.Minutes.focus();
        }

        if(submitted){
            document.form.user_input.value='2';
            document.form.da_retries.value=retries;
            document.form.da_timePeriodDays.value=days;
            document.form.da_timePeriodHours.value=hours;
            document.form.da_timePeriodMins.value=minutes;
            document.form.submit();
        }
        return submitted; 
    }
    </script>
    <%-- Common trailer --%>
    <tr>
      <td colspan="2">&nbsp;</td>
    </tr>

    <tr>
      <td align="center" colspan="4">
        <!--input type="submit" width="100" value="  Reset  " onclick="user_input.value='0'"-->
        <input type="button" width="100" value="  Reset  " onclick=";
                document.rsform.Retries.value=default_retries.value;
                document.rsform.Days.value=default_timePeriodDays.value;
                document.rsform.Hours.value=default_timePeriodHours.value;
                document.rsform.Minutes.value=default_timePeriodMins.value;">
        &nbsp;&nbsp;
        <input type="button" width="100" value="   OK   " onclick="javascript:validateAll();">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" width="100" value="  Fail  " onclick="user_input.value='1'">
    </tr>
</form>

</table>
</center>
</body>
</html>
