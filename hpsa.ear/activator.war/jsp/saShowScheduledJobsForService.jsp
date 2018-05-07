<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="com.hp.ov.activator.mwfm.*, 
             com.hp.ov.activator.mwfm.servlet.*,
             java.util.*,
             java.text.SimpleDateFormat,
             java.net.*" 
         info="Show all services." 
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%!
    //I18N strings
    final static String jobID       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("146", "Job Id");
    final static String hostName    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("416", "Host Name");
    final static String workflow    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("6", "Workflow");
    final static String status      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("10", "Status");
    final static String startTime   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("164", "Start Time");
    final static String postTime    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("148", "Post Time");
    final static String step        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("149", "Step");
    final static String description = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("9", "Description");
    final static String serviceID   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("415", "Service Id");
    final static String noJobs      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("809", "No Scheduled jobs available");
    final static String runningJobsMessage = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("787", "Jobs could not be retrieved from the nodes");
    final static String repeating   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("768", "Repeating Period");
    final static String endRepeating= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("769", "End Repeating");
    final static String groupId     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("767", "Group Id");
    final static String repeatingType = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1310", "Repeating Type");
    final static String startMissedJobs = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1311", "Start Missed Jobs");    

    final static String RUNNING_JOBS ="RJ";
    final static String SCHEDULED_JOBS = "SJ";

    //sorting
    final static int JOB_ID_DES = 0;
    final static int JOB_ID_ASC = 1;
    
    final static int WORKFLOW_DES = 2;
    final static int WORKFLOW_ASC = 3;
    final static int STATUS_DES = 4;
    final static int STATUS_ASC = 5;
    final static int START_TIME_DES = 6;
    final static int START_TIME_ASC = 7;
    final static int POST_TIME_DES = 8;
    final static int POST_TIME_ASC = 9;
    final static int STEP_DES = 10;
    final static int STEP_ASC = 11;
    final static int DESCR_DES = 12;
    final static int DESCR_ASC = 13;
    final static int GROUP_DES = 14;
    final static int GROUP_ASC = 15;
    final static int REPEATING_DES = 16;
    final static int REPEATING_ASC = 17;
    final static int END_REPEATING_DES = 18;
    final static int END_REPEATING_ASC = 19;
    final static int HOST_NAME_DES = 20;
    final static int HOST_NAME_ASC = 21;
    final static int NEXT_SORTING_CONSTANT = 22;
    
    final static int SERVICE_ID_DES = 23;
    final static int SERVICE_ID_ASC = 24;
    
    final static int REPEATING_TYPE_DES = 25;
    final static int REPEATING_TYPE_ASC = 26;
    final static int START_MISSED_JOBS_DES = 27;
    final static int START_MISSED_JOBS_ASC = 28;    
%>

<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute (Constants.USER) == null) {
%>
    <script>
        window.top.topFrame.location = window.top.topFrame.location;
    </script>
<%
       return;
    }
    
    final String SESSION_SERVICE_ID = "srvcid_saShowScheduledJobsForService.jsp";
    String srvcId = (String)request.getParameter("serviceid");
    String encSrvcId = URLEncoder.encode(srvcId, "UTF-8");
    session.setAttribute(SESSION_SERVICE_ID, encSrvcId);

    final String SESSION_SORTING = "saShowScheduledJobsForService.jsp"+"_"+srvcId;

    //default sorting criteria
    int currentSort = JOB_ID_ASC;

    try 
    {
        currentSort = ((Integer)session.getAttribute(SESSION_SORTING)).intValue();
    }
    catch(Exception e) {
    }
    try {
        int newSorting = Integer.parseInt(request.getParameter("sort"));
        if( (newSorting == currentSort || newSorting == currentSort+1) && (currentSort%2 == 0)){
            if(newSorting == currentSort) currentSort = newSorting + 1;
            else currentSort = newSorting - 1;
        }else{
            currentSort = newSorting;
        }
        session.setAttribute(SESSION_SORTING,new Integer(currentSort));
    }catch(Exception e){;}
 
    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader    ("Pragma",  "no-cache");

    request.setCharacterEncoding ("UTF-8");

    Vector casePacketNames = (Vector)session.getAttribute(Constants.CASEPACKET_NAME);
    Vector casePacketLabels = (Vector)session.getAttribute(Constants.CASEPACKET_LABEL);
    HashMap hash = (HashMap)session.getAttribute(Constants.JOB_FIELD_ORDER);
    Vector jobFieldOrder = null;
    if (hash != null)
        jobFieldOrder = (Vector)hash.get(Constants.SCHEDULED_JOBS);
    
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
    String resortLink = "saShowScheduledJobsForService.jsp?serviceid="+encSrvcId+"&sort=";
%>

<html>
    <head>
        <title>HP Service Activator</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
        <link rel="stylesheet" type="text/css" href="/activator/css/saContextMenu.css">
        <script language="JavaScript" src="/activator/javascript/table.js"></script>
        <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
        <script language="JavaScript" src="/activator/javascript/saContextMenu.js"></script>
    </head>
    <body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
        <h2>Scheduled Jobs for Service  <%=srvcId%></h2>
        <table class="activatorTable" id="scheduledJobs">
            <THEAD>
                <tr id="header">
                <%      
                    int columns = 0;
                        if (jobFieldOrder != null) {
                            for (int k=0; k<jobFieldOrder.size(); k++) {
                                if (jobID.equals(jobFieldOrder.get(k))) { 
                                    columns ++;
                %>
                <td width="7%" colspan="2" class="mainHeading" ><a TARGET="_self" href="<%= resortLink+JOB_ID_DES%>"><%=jobID%>&nbsp;<%=(currentSort==JOB_ID_DES?sortDes:"")%><%=(currentSort==JOB_ID_ASC?sortAsc:"")%></a></td>
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
                                } else if (serviceID.equals(jobFieldOrder.get(k))) { 
                                    columns ++;
                %>
                <td width="7%"class="mainHeading"><a TARGET="_self" href="<%= resortLink+SERVICE_ID_DES%>"><%=serviceID%>&nbsp;<%=(currentSort==SERVICE_ID_DES?sortDes:"")%><%=(currentSort==SERVICE_ID_ASC?sortAsc:"")%></a></td>
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
            </THEAD>
            <TBODY>
            <%
            // get all of the scheduled jobs
                WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
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
                    jobs = wfm.getScheduledJobsForService(srvcId, order);
                    // see if we have data to display
                    if (jobs == null) {
            %>
            <SCRIPT LANGUAGE="JavaScript">
                writeToMsgLine("<%=noJobs%>");
            </SCRIPT>
            <%
                    } else if(jobs.length == 0){
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
            <tr id="<%=jobs[k].jobId%>" class="<%=rowClass%>" onMouseOver="mouseOver(this);"                 onMouseOut= "mouseOut(this);">
            <%            
                                    }
                                    if (jobID.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="7%" class="tableCell" colspan="2" nowrap align="center"><%= jobs[k].jobId %></td>
            <%            
                                    } else if (workflow.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="12%" class="tableCell" ><%= jobs[k].name %></td>
            <%            
                                    } else if (startTime.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="12%" class="tableCell" >
                <%= (jobs[k].getScheduleInfo().getScheduleTime() == 0) ? "&nbsp;" :                           SimpleDateFormat.getDateTimeInstance().format(new Date(jobs[k].getScheduleInfo().getScheduleTime())) 
            %>
            </td>
            <%            
                                    } else if (repeating.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="12%" class="tableCell">
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
                <%= (jobs[k].getScheduleInfo().getEndRepeating() == 0) ? "&nbsp;" : SimpleDateFormat.getDateTimeInstance().format(new Date(jobs[k].getScheduleInfo().getEndRepeating()))%>
            </td>
            <%
                                    } else if (repeatingType.equals(jobFieldOrder.get(j))) { 
            %>              
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
                <%= (jobs[k].getScheduleInfo().getGroupId() == null) ? "&nbsp;" : jobs[k].getScheduleInfo().getGroupId()%>
            </td>
            <%            
                                    } else if (status.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="12%" class="tableCell" >
                <%= (jobs[k].getScheduleInfo().getStatus() == null) ? "&nbsp;" : jobs[k].getScheduleInfo().getStatus()%>
            </td>
            <%            
                                    } else if (description.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="33%" class="tableCell">
                <%= formatTag%><%=jobs[k].getScheduleInfo().getDescription() == null ? "&nbsp;" : jobs[k].getScheduleInfo().getDescription()%>
            </td>
            <% 
                                    } else if (startMissedJobs.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="12%" class="tableCell" >
            <%
                 String startMissedJobsStr = "";
                 if(jobs[k].getScheduleInfo().isHandlePastSchedulings()) {
                     startMissedJobsStr = Constants.START_MISSED_SCHEDULINGS_YES;
                 } else {
                     startMissedJobsStr = Constants.START_MISSED_SCHEDULINGS_NO;
                 }
            %>                 
            <%= startMissedJobsStr%></td>            
            <%            
                                    } else if (serviceID.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="7%" class="tableCell">
                <%= formatTag%><%=jobs[k].getServiceId() == null ? "&nbsp;" : jobs[k].getServiceId()%>
            </td>
            <%            
                                    } else if (casePacketNames != null) {
                                        for (int i=0; i<casePacketNames.size(); i++) {
                                            if (jobFieldOrder.get(j).equals(casePacketLabels.get(i))) { 
            %>
            <td class="tableCell">
                <%= formatTag%><%= (jobs[k].getSelectedCasePacketVars() == null)?"&nbsp;":                                  jobs[k].getSelectedCasePacketVars().get((String)casePacketNames.get(i)) == null ? "&nbsp;":              jobs[k].getSelectedCasePacketVars().get((String)casePacketNames.get(i)) %>
            </td>
            <%                                }
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
                } catch (Exception e1) {
                    e1.printStackTrace();
            %>
            <SCRIPT LANGUAGE="JavaScript"> 
                alert("<%= ExceptionHandler.handle(e1) %>"); 
                top.location.href = "..";
            </SCRIPT>
            <%
                } 
            %>
            </TBODY>
            <%!
                public String makeRepeatingString(long period, long unit) {
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
        </table>
    </body>
</html>
