<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="com.hp.ov.activator.mwfm.*, 
                 com.hp.ov.activator.mwfm.servlet.*,
                 com.hp.ov.activator.mwfm.component.WFException,
                 java.net.*,
                 java.text.SimpleDateFormat,
                 java.text.DateFormat,
                 java.util.*,
                 com.hp.ov.activator.mwfm.engine.object.ObjectConstants"
         info="" 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader    ("Pragma",  "no-cache");

    request.setCharacterEncoding ("UTF-8");
%>

<%!
    //I18N strings
    final static String noSuchJob = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("805", "Can not get the scheduled job: ");
    // Labels
    final static String sjTitle_str = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("806", "Schedule job: ");
    final static String jobId_str = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("5", "Job ID");
    final static String workflow_str = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("6", "Workflow");
    final static String scheduleTime_str = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("807", "Schedule Time");
    final static String repeatingPeriod_str = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("768", "Repeating Period");
    final static String repeatingEnd_str = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("808", "Repeating End");
    final static String groupId_str = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("767", "Group Id");
    final static String description_str = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("9", "Description");
    final static String status_str = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("10", "Status");
    final static String submitBtn_str = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("16", "Submit");
    final static String clearBtn_str = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("17", "Clear");
    final static String serviceId_str = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("415", "Service Id");
    final static String repeatingType = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1310", "Repeating Type");
    final static String handlePastSchedulings_str = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1312", "Start missed Scheduled instances");
%>
<html>
<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
  <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
  <meta http-equiv="content-type" content="text/html; charset=utf-8">
</head>

<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<%
    // get the name of the workflow to schedule
    String operation = (String)URLDecoder.decode(request.getParameter(Constants.OPERATION),"UTF-8");
    ScheduledJobDescriptor sjd = null;
    SimpleDateFormat sdf = (SimpleDateFormat)SimpleDateFormat.getDateTimeInstance(DateFormat.MEDIUM, DateFormat.MEDIUM);
    String pattern = sdf.toPattern();
    long jobId = 0;
    String queryJobId = request.getParameter("queryJobId");
    String queryServiceId = request.getParameter("queryServiceId");
    String queryOrderId = request.getParameter("queryOrderId");
    String queryType = request.getParameter("queryType");
    String queryState = request.getParameter("queryState");
    if (operation.equals(Constants.OPERATION_EDIT)) {
      try { 
        jobId = Long.parseLong((String)URLDecoder.decode(request.getParameter("jobId"),"UTF-8")); 
        WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
        sjd = wfm.getScheduledJobDescriptor(jobId);
      } catch (WFException e) {
%>        
<a><%=noSuchJob%><%=String.valueOf(jobId)%></a>
</body>
</html>
<%
        return;
      }
    } else {
      String wf = (String)URLDecoder.decode(request.getParameter(Constants.WORKFLOW),"UTF-8");
      ScheduleInfo si = new ScheduleInfo(System.currentTimeMillis(), 0, 0, 0, 0, null, null, null, true);
      sjd = new ScheduledJobDescriptor(0, wf, null, null, si, null, null);
    }
    
    long rep = sjd.getScheduleInfo().getRepeatingPeriod();
    long repUnit = sjd.getScheduleInfo().getRepeatingPeriodUnit();
    int repType = sjd.getScheduleInfo().getRepeatingType();
%>

<h3><img src="/activator/images/HPlogo-black.gif" valign="top" align="right"><%=sjTitle_str%><%=(sjd.name == null)?"":sjd.name%></h3> 
<br>
<%
    String tmp = request.getParameter("Msg");
    String msg = (String)URLDecoder.decode((tmp!=null?tmp:""), "UTF-8");
    if (!msg.equals("")) {
%>    
<table cellpadding="0" cellspacing="0">
  <tr align=left>
    <td class="error"><%=msg%></td>
  </tr>
</table>
<%      
    } else {
      session.removeAttribute("scheduledJob");
    }
%>
<jsp:useBean id="scheduledJob" scope="session" class="com.hp.ov.activator.mwfm.servlet.scheduledJobBean">
  <jsp:setProperty name="scheduledJob" property="jobId" value="<%=(sjd.jobId == 0)?\"0\":String.valueOf(sjd.jobId)%>"/>
  <jsp:setProperty name="scheduledJob" property="workflowName" value="<%=(sjd.name == null)?\"\":sjd.name%>"/>
  <jsp:setProperty name="scheduledJob" property="operation" value="<%=operation%>"/>
  <jsp:setProperty name="scheduledJob" property="scheduleTime" value="<%=(sjd.getScheduleInfo().getScheduleTime() == 0)?\"\":sdf.format(new Date(sjd.getScheduleInfo().getScheduleTime()))%>"/>
  <jsp:setProperty name="scheduledJob" property="repeatingPeriod" value="<%=(rep == 0)?\"\":String.valueOf(rep)%>"/>
  <jsp:setProperty name="scheduledJob" property="repeatingPeriodUnit" value="<%=(repUnit == 0)?\"\":String.valueOf(repUnit)%>"/>
  <!-- if the operation is a non-edit one, set the date pattern in the text field so that the user knows the format to enter the date else if it is EDIT operation, populate the field with the value in the database. This fix is part of gnat # 12913 - 1st issue -->
  <jsp:setProperty name="scheduledJob" property="endRepeating" value="<%=(sjd.getScheduleInfo().getEndRepeating() == 0)?pattern:sdf.format(new Date(sjd.getScheduleInfo().getEndRepeating()))%>"/>
  <jsp:setProperty name="scheduledJob" property="groupId" value="<%=(sjd.getScheduleInfo().getGroupId() == null)?\"\":sjd.getScheduleInfo().getGroupId()%>"/>
  <jsp:setProperty name="scheduledJob" property="description" value="<%=(sjd.getScheduleInfo().getDescription() == null)?\"\":sjd.getScheduleInfo().getDescription()%>"/>
  <jsp:setProperty name="scheduledJob" property="status" value="<%=(sjd.getScheduleInfo().getStatus() == null)?\"\":sjd.getScheduleInfo().getStatus()%>"/>
  <jsp:setProperty name="scheduledJob" property="current" value="<%=(sjd.getScheduleInfo().isCurrent())?ObjectConstants.TRUE:ObjectConstants.FALSE%>"/>  
  <jsp:setProperty name="scheduledJob" property="serviceId" value="<%=(sjd.getServiceId() == null)?\"\":sjd.getServiceId()%>"/>
  <jsp:setProperty name="scheduledJob" property="repeatingType" value="<%=(repType == 0)?\"\":String.valueOf(repType)%>"/>
  <jsp:setProperty name="scheduledJob" property="handlePastSchedulings" value="<%=(sjd.getScheduleInfo().isHandlePastSchedulings())?ObjectConstants.TRUE:ObjectConstants.FALSE%>"/>  
</jsp:useBean>

<br>
<script>
  function clearForm() {
	// on click of 'Clear' button, make the date formats visible to the user in both the fields
    document.form.schedule_time.value = "<%=pattern%>";
    document.form.reoccurrence_period.value = "";
    document.form.reoccurrence_period_unit.options[0].selected = true;
    document.form.reoccurrence_end.value = "<%=pattern%>";
    document.form.group_id.value = "";
    document.form.description.value = "";
    document.form.status.value = "";
    document.form.service_id.value = "";
    var rad = document.getElementById('reoccurrence_type_rel'); 
    rad.checked = true;
    //document.form.handle_past_schedulings.checked = true;
    rad = document.getElementById('handle_past_schedulings_yes'); 
    rad.checked = true;
  }
  function validate() {
    var repeatingPeriod = document.form.reoccurrence_period.value;
    var repeatingPeriodUnit = document.form.reoccurrence_period_unit.value;
    if (repeatingPeriod <= 10 && repeatingPeriodUnit == 1 && repeatingPeriod != '') {
      input_box=confirm("Are you sure the workflow is to be scheduled to repeat every "+repeatingPeriod+" second(s) ?");
      if(input_box == true){
        return true;
      }else {
       document.form.reoccurrence_period.value = "";
       document.form.reoccurrence_period_unit.options[0].selected = true;
       return false;
      }
    }else {
      return true;
    }
  }
  
</script>

<center>
<table width="100%" border=0 cellpadding=0>
  <tr>
     <th class="tableHeading"><%=jobId_str%></th>
     <th class="tableHeading"><%=workflow_str%></th>
  </tr>
  <tr>
      <td class="tableRow"><%=(sjd.jobId == 0)?"":String.valueOf(sjd.jobId)%></td>
      <td class="tableRow"><%=(sjd.name == null)?"":sjd.name%></td>
  </tr>
</table>
<p>
<form name="form" action="/activator/ScheduleJob" onsubmit="return validate();" method="POST">
<table>
<%

if (queryJobId != null && !queryJobId.equals("")) {
%>
    <input type="hidden" name="<%=Constants.URL_PARAM_JOB_ID%>" value="<%=queryJobId%>" />
<%
}
if (queryServiceId != null && !queryServiceId.equals("")) {
%>
  <input type="hidden" name="<%=Constants.URL_PARAM_SERVICE_ID%>" value="<%=queryServiceId%>" />
<%
}
if (queryOrderId != null && !queryOrderId.equals("")) {
%>
  <input type="hidden" name="<%=Constants.URL_PARAM_ORDER_ID%>" value="<%=queryOrderId%>" />
<%
}
if (queryState != null && !queryState.equals("")) {
%>
  <input type="hidden" name="<%=Constants.URL_PARAM_STATE%>" value="<%=queryState%>" />
<%
}
if (queryType != null && !queryType.equals("")) {
%>
  <input type="hidden" name="<%=Constants.URL_PARAM_TYPE%>" value="<%=queryType%>" />
<%
}
%>
<input type="hidden" name="<%=Constants.ID%>" value="<jsp:getProperty name="scheduledJob" property="jobId" />"/>
<input type="hidden" name="<%=Constants.WORKFLOW%>" value="<jsp:getProperty name="scheduledJob" property="workflowName" />"/>
<input type="hidden" name="<%=Constants.OPERATION%>" value="<jsp:getProperty name="scheduledJob" property="operation" />"/>
<input type="hidden" name="current" value="<jsp:getProperty name="scheduledJob" property="current" />"/>
<tr>
   <td><b><%=scheduleTime_str%></b></td>
   <td><input type="text" size="30" id='inputScheduleTime' name="schedule_time" 
       value="<jsp:getProperty name="scheduledJob" property="scheduleTime" />"/>
   <td><i>&nbsp;</i></td>
</tr>
<%
    if (!scheduledJob.getCurrent().equals(ObjectConstants.TRUE)) {
%>    
<tr>
   <td><b><%=repeatingPeriod_str%></b></td>
   <td><input type="text" size="15" name="reoccurrence_period" 
       value="<jsp:getProperty name="scheduledJob" property="repeatingPeriod" />"/>
       <%  int x = 0;
           try {
             x = Integer.parseInt(scheduledJob.getRepeatingPeriodUnit());
           } catch (NumberFormatException e) {
             x = Constants.PERIOD_SEC_VAL;
           }         
       %>
      <SELECT size="1" name="reoccurrence_period_unit">
        <OPTION <%=x==Constants.PERIOD_SEC_VAL?"selected":""%> value="<%=Constants.PERIOD_SEC_VAL%>"><%=Constants.PERIOD_SEC%></OPTION>
        <OPTION <%=x==Constants.PERIOD_MIN_VAL?"selected":""%> value="<%=Constants.PERIOD_MIN_VAL%>"><%=Constants.PERIOD_MIN%></OPTION>
        <OPTION <%=x==Constants.PERIOD_HOUR_VAL?"selected":""%> value="<%=Constants.PERIOD_HOUR_VAL%>"><%=Constants.PERIOD_HOUR%></OPTION>
        <OPTION <%=x==Constants.PERIOD_DAY_VAL?"selected":""%> value="<%=Constants.PERIOD_DAY_VAL%>"><%=Constants.PERIOD_DAY%></OPTION>
        <OPTION <%=x==Constants.PERIOD_WEEK_VAL?"selected":""%> value="<%=Constants.PERIOD_WEEK_VAL%>"><%=Constants.PERIOD_WEEK%></OPTION>
        <OPTION <%=x==Constants.PERIOD_MONTH_VAL?"selected":""%> value="<%=Constants.PERIOD_MONTH_VAL%>"><%=Constants.PERIOD_MONTH%></OPTION>
      </SELECT> 
    
   </td>
   <td><i>&nbsp;</i></td>
</tr>
<tr>
   <td><b><%=repeatingEnd_str%></b></td>
   <td><input type="text" size="30" id="inputReoccurenceEnd" name="reoccurrence_end" 
       value="<jsp:getProperty name="scheduledJob" property="endRepeating" />"/>
   <td><i>&nbsp;</i></td>
</tr>
<tr>
   <%
      int tempType = 0;
      try{
         tempType=Integer.parseInt(scheduledJob.getRepeatingType());
      } catch (NumberFormatException e) {
         tempType = Constants.REPEATING_RELATIVE_VAL;
      }
   %>
   <td><b><%=repeatingType%></b></td>
   <td>
      <input type="radio" id="reoccurrence_type_rel" name="reoccurrence_type" value="<%=Constants.REPEATING_RELATIVE_VAL%>" <%=tempType==Constants.REPEATING_RELATIVE_VAL?"checked":""%> /><%=Constants.REPEATING_RELATIVE%>
      <input type="radio" id="reoccurrence_type_abs" name="reoccurrence_type" value="<%=Constants.REPEATING_ABSOLUTE_VAL%>" <%=tempType==Constants.REPEATING_ABSOLUTE_VAL?"checked":""%> /><%=Constants.REPEATING_ABSOLUTE%>
   </td>
   <td><i>&nbsp;</i></td>
</tr>
<tr>
   <%
      String tempHandlePastSchedulings = scheduledJob.getHandlePastSchedulings();      
   %>
   <td><b><%=handlePastSchedulings_str%></b></td>
   <td>
      <input type="radio" id="handle_past_schedulings_yes" name="handle_past_schedulings" value="<%=ObjectConstants.TRUE%>" <%=tempHandlePastSchedulings.equals(ObjectConstants.TRUE)?"checked":""%> /><%=ObjectConstants.YES%>   
      <input type="radio" id="handle_past_schedulings_no" name="handle_past_schedulings" value="<%=ObjectConstants.FALSE%>" <%=tempHandlePastSchedulings.equals(ObjectConstants.FALSE)?"checked":""%> /><%=ObjectConstants.NO%>         
   </td>
   <td><i>&nbsp;</i></td>   
</tr>
<%
    } else {
%>    
<input type="hidden" name="reoccurrence_period" value="<jsp:getProperty name="scheduledJob" property="repeatingPeriod" />"/>
<input type="hidden" name="reoccurrence_period_unit" value="<jsp:getProperty name="scheduledJob" property="repeatingPeriodUnit" />"/>
<input type="hidden" name="reoccurrence_end" value="<jsp:getProperty name="scheduledJob" property="endRepeating" />"/>
<input type="hidden" name="reoccurrence_type" value="<jsp:getProperty name="scheduledJob" property="repeatingType" />"/>
<input type="hidden" name="handle_past_schedulings" value="<jsp:getProperty name="scheduledJob" property="handlePastSchedulings" />"/>
<%
    }
%>    
<tr>
   <td><b><%=groupId_str%></b></td>
   <td><input type="text" size="30" name="group_id" 
       value="<jsp:getProperty name="scheduledJob" property="groupId" />"/>
   <td><i>&nbsp;</i></td>
</tr>
<tr>
   <td><b><%=serviceId_str%></b></td>
   <td><input type="text" size="30" name="service_id" 
       value="<jsp:getProperty name="scheduledJob" property="serviceId" />"/>
   <td><i>&nbsp;</i></td>
</tr>
<tr>
   <td><b><%=description_str%></b></td>
   <td><TEXTAREA name="description" rows="3" cols="22"><jsp:getProperty name="scheduledJob" property="description"/></TEXTAREA></td>
   <td><i>&nbsp;</i></td>
</tr>
<tr>
   <td><b><%=status_str%></b></td>
   <td><input type="text" size="30" name="status" 
       value="<jsp:getProperty name="scheduledJob" property="status" />"/>
   <td><i>&nbsp;</i></td>
</tr>


<!-- Common trailer -->
<tr><td colspan="2">&nbsp;</td></tr>
<tr>
    <td align="center" colspan="3">
       <input type="submit" value="<%=submitBtn_str%>">
       <input type="button" value="<%=clearBtn_str%>" onClick="clearForm()">
    </td>
</tr>
</table>
</form>
</center>

</body>
</html>
