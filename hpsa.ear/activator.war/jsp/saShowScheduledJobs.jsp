<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants" %>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<script>
window.onload = function () {
  window.menuName = "scheduledJobsMenu";
  document.getElementById('scheduledJobs').oncontextmenu = showContextMenu;
  scrollTo(0,top.scrollY);
  recalculateDiv();
  scrollToTab();
  if(document.all){
    var tr_header = document.getElementById("header");
    tr_header.style.position = "relative";
  }
}
window.onresize = function () {
  recalculateDiv();
} 
function startScheduledJob() {
  var job =  getCookie(window.menuName);
  if (job == null)  {
    writeToMsgLine("Please select a job."); 
    return false;
  }
  top.messageLine.location.href = 'saStartScheduledJob.jsp?jobID=' + job;
  return true;
}
function modifyScheduledJob() {
  var cookieName = window.menuName;
  var job = getCookie(cookieName);
  var winLink = "saShowScheduledJob.jsp?jobId=" + job + "&<%=Constants.OPERATION%>=<%=Constants.OPERATION_EDIT%>";
  window.open(winLink,'schedule','resizable=yes,status=yes,width=500,height=545,scrollbars=yes');
  return true;
}
function deleteScheduledJob() {
  var job =  getCookie(window.menuName);
  if (job == null)  {
    writeToMsgLine("Please select a job."); 
    return false;
  }
  if (confirm("<%=deleteMsg%>" + job + "?")) {
    top.messageLine.location.href = 'saDeleteScheduledJob.jsp?jobID=' + job;
    return true;
  }
  else {
    writeToMsgLine("<%=deleteCancelMsg%>");
  }
  return true;
}
if (document.all) {
  document.onclick = "hideContextMenu(window.menuName)";
}
</script>
<%
try {
  Vector casePacketNames = (Vector)session.getAttribute(Constants.CASEPACKET_NAME);
  Vector casePacketLabels = (Vector)session.getAttribute(Constants.CASEPACKET_LABEL);
  HashMap hash = (HashMap)session.getAttribute(Constants.JOB_FIELD_ORDER);
  Vector jobFieldOrder = null;
  if (hash != null) {
    jobFieldOrder = (Vector)hash.get(Constants.SCHEDULED_JOBS);
  }
  if (jobFieldOrder == null) {
    jobFieldOrder = new Vector();
    jobFieldOrder.add(jobID);
    jobFieldOrder.add(serviceID);
    jobFieldOrder.add(workflow);
    jobFieldOrder.add(startTime);
    jobFieldOrder.add(repeating);
    jobFieldOrder.add(endRepeating);
    jobFieldOrder.add(repeatingType);      
    jobFieldOrder.add(groupId);
    jobFieldOrder.add(status);
    jobFieldOrder.add(description);
    jobFieldOrder.add(startMissedJobs);
  }
  String sortDes = "<img src='/activator/images/down.gif' align='absmiddle' border='0'/>";
  String sortAsc = "<img src='/activator/images/up.gif' align='absmiddle' border='0'/>";
  String resortLink = "saShowJobs.jsp?sort=";
%>
<table class="activatorTable" id="scheduledJobs">
<thead>
<tr id="header">
<%
  int columns = 0;
  if (jobFieldOrder != null) {
    for (int k=0; k<jobFieldOrder.size(); k++) {
      if (jobID.equals(jobFieldOrder.get(k))) { 
        columns ++;
%>
  <td width="7%" colspan="2" class="mainHeading"><a TARGET="_self" href="<%= resortLink+JOB_ID_DES%>"><%=jobID%>&nbsp;<%=(currentSort==JOB_ID_DES?sortDes:"")%><%=(currentSort==JOB_ID_ASC?sortAsc:"")%></a></td>
<%
      } else if (serviceID.equals(jobFieldOrder.get(k))) { 
        columns ++;
%>
  <td width="9%"class="mainHeading"><a TARGET="_self" href="<%= resortLink+SERVICE_ID_DES%>"><%=serviceID%>&nbsp;<%=(currentSort==SERVICE_ID_DES?sortDes:"")%><%=(currentSort==SERVICE_ID_ASC?sortAsc:"")%></a></td>                
<%
      } else if (workflow.equals(jobFieldOrder.get(k))) { 
        columns ++;
%>
  <td width="12%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+WORKFLOW_DES%>"><%=workflow%>&nbsp;<%=(currentSort==WORKFLOW_DES?sortDes:"")%><%=(currentSort==WORKFLOW_ASC?sortAsc:"")%></a></td>
<%
      } else if (startTime.equals(jobFieldOrder.get(k))) { 
        columns ++;
%>
  <td width="12%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+START_TIME_DES%>"><%=startTime%>&nbsp;<%=(currentSort==START_TIME_DES?sortDes:"")%><%=(currentSort==START_TIME_ASC?sortAsc:"")%></a></td>
<%
      } else if (repeating.equals(jobFieldOrder.get(k))) { 
        columns ++;
%>
  <td width="12%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+REPEATING_DES%>"><%=repeating%>&nbsp;<%=(currentSort==REPEATING_DES?sortDes:"")%><%=(currentSort==REPEATING_ASC?sortAsc:"")%></a></td>
<%
      } else if (endRepeating.equals(jobFieldOrder.get(k))) { 
        columns ++;
%>
  <td width="12%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+END_REPEATING_DES%>"><%=endRepeating%>&nbsp;<%=(currentSort==END_REPEATING_DES?sortDes:"")%><%=(currentSort==END_REPEATING_ASC?sortAsc:"")%></a></td>
<%
      } else if (repeatingType.equals(jobFieldOrder.get(k))) { 
        columns ++;
%>
  <td width="12%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+REPEATING_TYPE_DES%>"><%=repeatingType%>&nbsp;<%=(currentSort==REPEATING_TYPE_DES?sortDes:"")%><%=(currentSort==REPEATING_TYPE_ASC?sortAsc:"")%></a></td>
<%
      } else if (groupId.equals(jobFieldOrder.get(k))) { 
        columns ++;
%>
  <td width="12%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+GROUP_DES%>"><%=groupId%>&nbsp;<%=(currentSort==GROUP_DES?sortDes:"")%><%=(currentSort==GROUP_ASC?sortAsc:"")%></a></td>
<%
      } else if (status.equals(jobFieldOrder.get(k))) { 
        columns ++;
%>
  <td width="7%"  class="mainHeading"><a TARGET="_self" href="<%= resortLink+STATUS_DES%>"><%=status%>&nbsp;<%=(currentSort==STATUS_DES?sortDes:"")%><%=(currentSort==STATUS_ASC?sortAsc:"")%></a></td>
<%
      } else if (description.equals(jobFieldOrder.get(k))) { 
        columns ++;
%>
  <td width="33%"class="mainHeading"><a TARGET="_self" href="<%= resortLink+DESCR_DES%>"><%=description%>&nbsp;<%=(currentSort==DESCR_DES?sortDes:"")%><%=(currentSort==DESCR_ASC?sortAsc:"")%></a></td>
<%
      } else if (startMissedJobs.equals(jobFieldOrder.get(k))) { 
        columns ++;            
%>
  <td width="12%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+START_MISSED_JOBS_DES%>"><%=startMissedJobs%>&nbsp;<%=(currentSort==START_MISSED_JOBS_DES?sortDes:"")%><%=(currentSort==START_MISSED_JOBS_ASC?sortAsc:"")%></a></td>
<%
      } else if (workflowOrderID.equals(jobFieldOrder.get(k))) {
        columns ++;
%>
  <td width="9%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+ORDER_ID_DES%>"><%=workflowOrderID%>&nbsp;<%=(currentSort==ORDER_ID_DES?sortDes:"")%><%=(currentSort==ORDER_ID_ASC?sortAsc:"")%></a></td>      
<%
      } else if(workflowType.equals(jobFieldOrder.get(k))) {
        columns ++;
%>
  <td width="9%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+TYPE_DES%>"><%=workflowType%>&nbsp;<%=(currentSort==TYPE_DES?sortDes:"")%><%=(currentSort==TYPE_ASC?sortAsc:"")%></a></td>      
<%
      } else if(workflowState.equals(jobFieldOrder.get(k))) {
        columns ++;
%>                
  <td width="9%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+STATE_DES%>"><%=workflowState%>&nbsp;<%=(currentSort==STATE_DES?sortDes:"")%><%=(currentSort==STATE_ASC?sortAsc:"")%></a></td>      
<%
      } else if (casePacketLabels != null) {
        for (int i=0; i<casePacketLabels.size(); i++) {
          if (jobFieldOrder.get(k).equals(casePacketLabels.get(i))) { 
            columns ++;
%>
  <td class="mainHeading"><a TARGET="_self" href="<%= resortLink+(NEXT_SORTING_CONSTANT+(i*2))%>"><%=casePacketLabels.get(i)%>&nbsp;<%=(currentSort-NEXT_SORTING_CONSTANT==i*2?sortDes:"")%><%=(currentSort-NEXT_SORTING_CONSTANT==(i*2)+1?sortAsc:"")%></a></td>
<%
          }
        }
      }
    }
  }
%>
</tr>
</thead>
<tbody>
<%
  // get all of the scheduled jobs
  String order = "";
  switch(currentSort){
    case JOB_ID_DES:            order = "job_id desc"; break;
    case JOB_ID_ASC:            order = "job_id asc"; break;
    case WORKFLOW_DES:          order = "workflow_name desc"; break;
    case WORKFLOW_ASC:          order = "workflow_name asc"; break;
    case STATUS_DES:            order = "status desc"; break;
    case STATUS_ASC:            order = "status asc"; break;
    case START_TIME_DES:        order = "schedule_time desc"; break;
    case START_TIME_ASC:        order = "schedule_time asc"; break;
    case REPEATING_DES:         order = "REOCCURING_PERIOD_UNIT desc, reoccuring_period desc"; break;
    case REPEATING_ASC:         order = "REOCCURING_PERIOD_UNIT asc, reoccuring_period asc"; break;
    case END_REPEATING_DES:     order = "reoccurence_end_time desc"; break;
    case END_REPEATING_ASC:     order = "reoccurence_end_time asc"; break;
    case GROUP_DES:             order = "group_id desc"; break;
    case GROUP_ASC:             order = "group_id asc"; break;
    case DESCR_DES:             order = "description desc"; break;
    case DESCR_ASC:             order = "description asc"; break;
    case SERVICE_ID_DES:        order = "service_id desc"; break;
    case SERVICE_ID_ASC:        order = "service_id asc"; break;  
    case ORDER_ID_DES:          order = "workflow_order_id desc"; break;
    case ORDER_ID_ASC:          order = "workflow_order_id asc"; break;      
    case TYPE_DES:              order = "workflow_type desc"; break;
    case TYPE_ASC:              order = "workflow_type asc"; break;
    case STATE_DES:             order = "workflow_state desc"; break;
    case STATE_ASC:             order = "workflow_state asc"; break; 
    case REPEATING_TYPE_DES:    order = "REOCCURING_TYPE desc";break;
    case REPEATING_TYPE_ASC:    order = "REOCCURING_TYPE asc";break;
    case START_MISSED_JOBS_DES: order = "HANDLE_MISSED_SCHEDULINGS desc";break;
    case START_MISSED_JOBS_ASC: order = "HANDLE_MISSED_SCHEDULINGS asc";break;
    default:
      int j = currentSort - NEXT_SORTING_CONSTANT;
      if(j%2 == 1){
        wfm.setComparator("JobDescriptor", "CPVar"+casePacketNames.get(j/2), false);
      }else{
        wfm.setComparator("JobDescriptor", "CPVar"+casePacketNames.get(j/2), true);
      }
  }
  order = (order.equals("")?"":order+", schedule_time asc");
  String [] casePacketArray = {};
  if (casePacketNames != null && casePacketNames.size()>0) {
    casePacketArray = new String [casePacketNames.size()];
    casePacketArray = (String [])casePacketNames.toArray(casePacketArray);
  }
  ScheduledJobDescriptor[] jobs = null;
  try {
    if (jobMax < Integer.MAX_VALUE) {
      jobs = wfm.getScheduledJobs("", order, jobMax);
    } else {
      jobs = wfm.getScheduledJobs("", order);
    }
  } catch (Exception e1) { 
    // Ignore
  }
  // see if we have data to display
  if (jobs == null) {
    String excMsg = "Cannot get scheduled jobs.";
%>
<script>
writeToMsgLine("<%=excMsg%>");
</script>
<%
  } else if (jobs.length == 0) {
%>
<tr class="tableRowInfo">
  <td class="tableRowInfo" colspan="<%= columns+1%>"><%=noJobs%></td>
</tr>
<%
  } else {
    // set initial values
    String formatTag=(((Boolean)session.getAttribute(Constants.FORMAT_TEXT)).booleanValue() == true ? "<pre>" : "");
    int numRows=1;
    // display any scheduled jobs
    for (int k=0; k<jobs.length; k++) {
      String rowClass= (numRows%2 == 0) ? "tableEvenRow" : "tableOddRow";
      boolean first=true;
      if (jobFieldOrder != null) {
        for (int j=0; j<jobFieldOrder.size(); j++) {
          if (first) {
            first=false;
%>
<tr id="<%=jobs[k].jobId%>" class="<%=rowClass%>" onClick="hideContextMenu('scheduledJobsMenu');" onMouseOver="mouseOver(this);" onMouseOut= "mouseOut(this);">
<%
          }
          if (jobID.equals(jobFieldOrder.get(j))) {
%>
  <td width="7%" class="tableCell" colspan="2" nowrap align="center"><%= jobs[k].jobId %></td>
<%
          } else if (serviceID.equals(jobFieldOrder.get(j))) { 
%>
  <td width="7%" class="tableCell">
  <%= formatTag%><%=jobs[k].getServiceId() == null ? "&nbsp;" : jobs[k].getServiceId()%> 
  </td>          
<%
          } else if (workflow.equals(jobFieldOrder.get(j))) {
%>
  <td width="12%" class="tableCell" ><%= jobs[k].name %></td>
<%
          } else if (startTime.equals(jobFieldOrder.get(j))) {
%>
  <td width="12%" class="tableCell" >
  <%= (jobs[k].getScheduleInfo().getScheduleTime() == 0) ? "&nbsp;" : SimpleDateFormat.getDateTimeInstance().format(new Date(jobs[k].getScheduleInfo().getScheduleTime())) %>
  </td>
<%
          } else if (repeating.equals(jobFieldOrder.get(j))) {
%>
  <td width="12%" class="tableCell" >
<%
            String repType = "";
            long rep = jobs[k].getScheduleInfo().getRepeatingPeriod();
            long rep_unit = jobs[k].getScheduleInfo().getRepeatingPeriodUnit();
            repType = makeRepeatingString(rep, rep_unit);
%>
  <%= (rep == 0) ? "&nbsp;" : repType %>
  </td>
<%
          } else if (endRepeating.equals(jobFieldOrder.get(j))) {
%>
  <td width="12%" class="tableCell" >
  <%= (jobs[k].getScheduleInfo().getEndRepeating() == 0) ? "&nbsp;" : SimpleDateFormat.getDateTimeInstance().format(new Date(jobs[k].getScheduleInfo().getEndRepeating()))%></td>
<%
          } else if (repeatingType.equals(jobFieldOrder.get(j))) { %>
  <td width="12%" class="tableCell" >
<%
            String repeatingTypeStr="";
            if(jobs[k].getScheduleInfo().getRepeatingType() == Constants.REPEATING_RELATIVE_VAL) {
              repeatingTypeStr = Constants.REPEATING_RELATIVE;
            } else if(jobs[k].getScheduleInfo().getRepeatingType() == Constants.REPEATING_ABSOLUTE_VAL) {
              repeatingTypeStr = Constants.REPEATING_ABSOLUTE;
            }
%>
  <%= (jobs[k].getScheduleInfo().getRepeatingType() == 0) ? "&nbsp;" : repeatingTypeStr%></td>          
<%
          } else if (groupId.equals(jobFieldOrder.get(j))) {
%>
  <td width="12%" class="tableCell" >
  <%= (jobs[k].getScheduleInfo().getGroupId() == null) ? "&nbsp;" : jobs[k].getScheduleInfo().getGroupId()%></td>
<%
          } else if (status.equals(jobFieldOrder.get(j))) { %>
  <td width="12%" class="tableCell" >
  <%= (jobs[k].getScheduleInfo().getStatus() == null) ? "&nbsp;" : jobs[k].getScheduleInfo().getStatus()%></td>
<%
          } else if (description.equals(jobFieldOrder.get(j))) { %>
  <td width="33%" class="tableCell">
  <%= formatTag%><%=jobs[k].getScheduleInfo().getDescription() == null ? "&nbsp;" : jobs[k].getScheduleInfo().getDescription()%> </td>
<%
          } else if (startMissedJobs.equals(jobFieldOrder.get(j))) { %>
  <td width="12%" class="tableCell" >
<%
            String startMissedJobsStr = "";
            if(jobs[k].getScheduleInfo().isHandlePastSchedulings()) {
              startMissedJobsStr = Constants.START_MISSED_SCHEDULINGS_YES;
            } else {
              startMissedJobsStr = Constants.START_MISSED_SCHEDULINGS_NO;
            }
%>
  <%= startMissedJobsStr%>
  </td>   
<%
          } else if(workflowOrderID.equals(jobFieldOrder.get(j))) { %>
  <td width="7%" class="tableCell">
  <%= formatTag%><%=jobs[k].workflowOrderId == null ? "&nbsp;" : jobs[k].workflowOrderId%> 
  </td>
<%
          } else if(workflowType.equals(jobFieldOrder.get(j))) { %>
  <td width="7%" class="tableCell">
  <%= formatTag%><%=jobs[k].workflowType == null ? "&nbsp;" : jobs[k].workflowType%> 
  </td>
<%
          } else if(workflowState.equals(jobFieldOrder.get(j))) { %>
  <td width="7%" class="tableCell">
  <%= formatTag%><%=jobs[k].workflowState == null ? "&nbsp;" : jobs[k].workflowState%> 
  </td>              
<%
          } else if (casePacketNames != null) {
            for (int i=0; i<casePacketNames.size(); i++) {
              if (jobFieldOrder.get(j).equals(casePacketLabels.get(i))) { %>
  <td class="tableCell">
  <%= formatTag%><%= (jobs[k].getSelectedCasePacketVars() == null)?"&nbsp;":
                     jobs[k].getSelectedCasePacketVars().get((String)casePacketNames.get(i)) == null ? "&nbsp;":
                     jobs[k].getSelectedCasePacketVars().get((String)casePacketNames.get(i)) %></td>
<%
              }
            }
          }
        }
      }
%>
</tr>
<%
      ++numRows;       
    }   //  done processing all jobs
 } // done with check for jobs
%>
</tbody>
</table>
<!-- Update the result count in the tab/header frame -->
<script>
document.getElementById("resultCnt").innerHTML = <%=(jobs != null && jobs.length>0?"'1 - "+jobs.length+"'":"'0'")%>;
</script>
<!-- This table is hidden until selected for viewing with a right click -->
<div id="scheduledJobsMenu" class="contextMenu" onclick="hideContextMenu(window.menuName);">
<a href="saShowJobs.jsp" class="menuItem" target="displayFrame"
   onclick="return startScheduledJob();"
   onmouseover="toggleHighlight(event)"
   onmouseout="toggleHighlight(event)"> <%=startScheduledJob%></a>
<hr>
<a href="saShowJobs.jsp" class="menuItem" target="displayFrame"
   onclick="return modifyScheduledJob();"
   onmouseover="toggleHighlight(event)"
   onmouseout="toggleHighlight(event)"> <%=modifyScheduledJob%></a>
<hr>
<a href="saShowJobs.jsp" class="menuItem" target="displayFrame"
   onclick="return deleteScheduledJob();"
   onmouseover="toggleHighlight(event)"
   onmouseout="toggleHighlight(event)"> <%=deleteScheduledJob%></a>
</div>
<%
  } catch (Exception ex) {
%>
<script>
alert("<%= ExceptionHandler.handle(ex) %>"); 
top.location.href = "..";
</script>
<%
  }
%>
<%!
public String makeRepeatingString(long period, long unit)
{
  String result = "";
  final int MULT_M = 60;
  final int MULT_H = 60;
  final int MULT_D = 24;
  final int MULT_W = 7;
  long x;
  long y;
  if (unit == Constants.PERIOD_MONTH_VAL) {
    result = period + " " + Constants.PERIOD_MONTH;
  } else if (unit == Constants.PERIOD_WEEK_VAL) {
    result = period + " " + Constants.PERIOD_WEEK;
  } else if (unit == Constants.PERIOD_DAY_VAL) {
    x = period / MULT_W;
    if (x > 0) {
      result = makeRepeatingString(x, Constants.PERIOD_WEEK_VAL);
      y = period % MULT_W;
      if (y != 0) {
        result = result + " " + y + " " + Constants.PERIOD_DAY;
      }
    } else {
      result = period + " " + Constants.PERIOD_DAY;
    }
  } else if (unit == Constants.PERIOD_HOUR_VAL) {
    x = period / MULT_D;
    if (x > 0) {
      result = makeRepeatingString(x, Constants.PERIOD_DAY_VAL);
      y = period % MULT_D;
      if (y != 0) {
        result = result + " " + y + " " + Constants.PERIOD_HOUR;
      }
    } else {
      result = period + " " + Constants.PERIOD_HOUR;
    }
  } else if (unit == Constants.PERIOD_MIN_VAL) {
    x = period / MULT_H;
    if (x > 0) {
      result = makeRepeatingString(x, Constants.PERIOD_HOUR_VAL);
      y = period % MULT_H;
      if (y != 0) {
        result = result + " " + y + " " + Constants.PERIOD_MIN;
      }
    } else {
      result = period + " " + Constants.PERIOD_MIN;
    }
  } else if (unit == Constants.PERIOD_SEC_VAL) {
    x = period / MULT_M;
    if (x > 0) {
      result = makeRepeatingString(x, Constants.PERIOD_MIN_VAL);
      y = period % MULT_M;
      if (y != 0) {
        result = result + " " + y + " " + Constants.PERIOD_SEC;
      }
    } else {
      result = period + " " + Constants.PERIOD_SEC;
    }
  }
  return result;
}
%>
