<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="com.hp.ov.activator.mwfm.*, 
             com.hp.ov.activator.mwfm.servlet.*,
             java.util.*,
             java.text.DateFormat,
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
    final static String noJobs      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("786", "No Running jobs available");
    final static String runningJobsMessage       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("787", "Jobs could not be retrieved from the nodes");

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
 
    final String SESSION_SERVICE_ID = "srvcid_saShowJobsForService.jsp";
    String srvcId = (String)request.getParameter("serviceid");
    String encSrvcId = URLEncoder.encode(srvcId, "UTF-8");
    session.setAttribute(SESSION_SERVICE_ID, encSrvcId);

    final String SESSION_SORTING = "sorting_in_saShowJobsForService.jsp"+"_"+srvcId;

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
        jobFieldOrder = (Vector)hash.get(Constants.RUNNING_JOBS);
    
    if (jobFieldOrder == null) {
      jobFieldOrder = new Vector();
      jobFieldOrder.add(jobID);
      jobFieldOrder.add(serviceID);
      jobFieldOrder.add(hostName);
      jobFieldOrder.add(workflow);
      jobFieldOrder.add(status);
      jobFieldOrder.add(startTime);
      jobFieldOrder.add(step);
      jobFieldOrder.add(description);      
    }

    String sortDes = "<img src='/activator/images/down.gif' align='absmiddle' border='0'/>";
    String sortAsc = "<img src='/activator/images/up.gif' align='absmiddle' border='0'/>";
    String resortLink = "saShowJobsForService.jsp?serviceid="+encSrvcId+"&sort=";
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
        <h2>Running Jobs for Service <%=srvcId%></h2>
        <table class="activatorTable" id="runningJobs">
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
                                } else if (hostName.equals(jobFieldOrder.get(k))) { 
                                    columns ++;
                    %>
                    <td width="12%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+HOST_NAME_DES%>"><%=hostName%>&nbsp;<%=(currentSort==HOST_NAME_DES?sortDes:"")%><%=(currentSort==HOST_NAME_ASC?sortAsc:"")%></a></td>      
                    <%          
                                }   else if (workflow.equals(jobFieldOrder.get(k))) { 
                                    columns ++;
                    %>
                    <td width="12%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+WORKFLOW_DES%>"><%=workflow%>&nbsp;<%=(currentSort==WORKFLOW_DES?sortDes:"")%><%=(currentSort==WORKFLOW_ASC?sortAsc:"")%></a></td>
                    <%         
                                } else if (status.equals(jobFieldOrder.get(k))) { 
                                    columns ++;
                    %>
                    <td width="7%"  class="mainHeading"><a TARGET="_self" href="<%= resortLink+STATUS_DES%>"><%=status%>&nbsp;<%=(currentSort==STATUS_DES?sortDes:"")%><%=(currentSort==STATUS_ASC?sortAsc:"")%></a></td>
                    <%         
                                } else if (startTime.equals(jobFieldOrder.get(k))) { 
                                    columns ++;
                    %>
                    <td width="12%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+START_TIME_DES%>"><%=startTime%>&nbsp;<%=(currentSort==START_TIME_DES?sortDes:"")%><%=(currentSort==START_TIME_ASC?sortAsc:"")%></a></td>
                    <%         
                                } else if (step.equals(jobFieldOrder.get(k))) { 
                                    columns ++;
                    %>
                    <td width="12%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+STEP_DES%>"><%=step%>&nbsp;<%=(currentSort==STEP_DES?sortDes:"")%><%=(currentSort==STEP_ASC?sortAsc:"")%></a></td>
                    <%         
                                } else if (description.equals(jobFieldOrder.get(k))) { 
                                    columns ++;
                    %>
                    <td width="33%"class="mainHeading"><a TARGET="_self" href="<%= resortLink+DESCR_DES%>"><%=description%>&nbsp;<%=(currentSort==DESCR_DES?sortDes:"")%><%=(currentSort==DESCR_ASC?sortAsc:"")%></a></td>
                    <%         
                                } else if (serviceID.equals(jobFieldOrder.get(k))) { 
                                    columns ++;
                    %>
                    <td width="12%"class="mainHeading"><a TARGET="_self" href="<%= resortLink+SERVICE_ID_DES%>"><%=serviceID%>&nbsp;<%=(currentSort==SERVICE_ID_DES?sortDes:"")%><%=(currentSort==SERVICE_ID_ASC?sortAsc:"")%></a></td>        
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
                WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
                switch(currentSort){
                    case JOB_ID_DES:    wfm.setComparator("JobDescriptor", "JobId", true); break;
                    case JOB_ID_ASC:    wfm.setComparator("JobDescriptor", "JobId", false); break;
                    case HOST_NAME_DES: wfm.setComparator("JobDescriptor", "HostName", true); break;
                    case HOST_NAME_ASC: wfm.setComparator("JobDescriptor", "HostName", false); break;
                    case WORKFLOW_DES:  wfm.setComparator("JobDescriptor", "WorkflowName", true); break;
                    case WORKFLOW_ASC:  wfm.setComparator("JobDescriptor", "WorkflowName", false); break;
                    case STATUS_DES:    wfm.setComparator("JobDescriptor", "Status", true); break;
                    case STATUS_ASC:    wfm.setComparator("JobDescriptor", "Status", false); break;
                    case START_TIME_DES: wfm.setComparator("JobDescriptor", "StartTime", true);break;
                    case START_TIME_ASC: wfm.setComparator("JobDescriptor", "StartTime", false);break;
                    case STEP_DES:      wfm.setComparator("JobDescriptor", "StepName", true); break;
                    case STEP_ASC:      wfm.setComparator("JobDescriptor", "StepName", false); break;
                    case DESCR_DES:     wfm.setComparator("JobDescriptor", "Description", true); break;
                    case DESCR_ASC:     wfm.setComparator("JobDescriptor", "Description", false); break;
                    case SERVICE_ID_DES:    wfm.setComparator("JobDescriptor", "ServiceId", true); break;
                    case SERVICE_ID_ASC:    wfm.setComparator("JobDescriptor", "ServiceId", false); break;
                   
                default:
                    int j = currentSort - NEXT_SORTING_CONSTANT;
                    if(j%2 == 1){
                        wfm.setComparator("JobDescriptor", "CPVar"+casePacketNames.get(j/2), false);
                    }else{
                        wfm.setComparator("JobDescriptor", "CPVar"+casePacketNames.get(j/2), true);
                    }
                }
                String [] casePacketArray = {};
                if (casePacketNames != null && casePacketNames.size()>0) {
                  casePacketArray = new String [casePacketNames.size()];
                  casePacketArray = (String [])casePacketNames.toArray(casePacketArray);
                }
                RunningJobDescriptor[] jobs = null;
                JobResponseDescriptor jobResponseDescriptor = null;
                HashMap responseMap =null;
                Exception e = null;
                
                try {
                    jobResponseDescriptor = wfm.getRunningJobs(srvcId, casePacketArray);
                    StringBuffer showJobsMessage = new StringBuffer();
                    if(jobResponseDescriptor==null){
            %>
            <SCRIPT LANGUAGE="JavaScript">
                writeToMsgLine("<%=noJobs%>");
            </SCRIPT>
            <%
                    } else{
                        if(jobResponseDescriptor.getStatus()!=0){
                            responseMap = jobResponseDescriptor.getExceptionMap();
                            for (Iterator it = responseMap.keySet().iterator(); it.hasNext();) {
                                String localHostName = (String)it.next();
                                e = (Exception) responseMap.get(localHostName);
                                if(e != null){
                                    showJobsMessage.append(runningJobsMessage);
                                    showJobsMessage.append(localHostName);
                                    showJobsMessage.append(" - Exception Received - ");
                                    showJobsMessage.append(e);
                                    showJobsMessage.append("<br>");
                                }
                            }
                            if (showJobsMessage.length() != 0) {
            %>
            <SCRIPT language="JavaScript">
                writeToMsgLine("<%=showJobsMessage%>");
            </SCRIPT>
            <%
                            }                
                        }  
                        jobs = jobResponseDescriptor.getRunningJobDescriptorsAsArray();
                        if (jobs == null || jobs.length == 0) {
            %>
            <tr class="tableRowInfo">
                <td class="tableRowInfo" colspan="<%= columns+1%>"><%=noJobs%></td>
            </tr>
            <%
                        } else {
                            // set initial values
                            String formatTag=(((Boolean)session.getAttribute(Constants.FORMAT_TEXT)).booleanValue() == true ? "<pre>" : "");
                            int numRows=1;

                            // display any running jobs
                            for (int k=0; k<jobs.length; k++) {
                                String rowClass= (numRows%2 == 0) ? "tableEvenRow" : "tableOddRow";
                                boolean first=true;
                                if (jobFieldOrder != null) {
                                    for (int j=0; j<jobFieldOrder.size(); j++) {
                                        if (first) {
                                            first=false; 
            %>
            <tr id="<%=jobs[k].jobId%>" class="<%=rowClass%>" onMouseOver="mouseOver(this);" onMouseOut="mouseOut(this);">
            <%            
                                        }
                                        if (jobID.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="7%" class="tableCell" colspan="2" nowrap align="center"><%= jobs[k].jobId %></td>
            <%            
                                        } else if (hostName.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="12%" class="tableCell" ><%= jobs[k].hostName %></td>
            <%            
                                        } else if (workflow.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="12%" class="tableCell" ><%= jobs[k].name %></td>
            <%            
                                        } else if (status.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="12%" class="tableCell" ><%= jobs[k].status %></td>
            <%            
                                        } else if (startTime.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="12%" class="tableCell" >
                <%= DateFormat.getDateTimeInstance().format(jobs[k].startTime) %></a>
            </td>
            <%            
                                        } else if (step.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="12%" class="tableCell" >
                <%= formatTag%><%=jobs[k].stepName == null ? "&nbsp;" : jobs[k].stepName%>
            </td>
            <%            
                                        } else if (description.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="33%" class="tableCell">
                <%= formatTag%><%=jobs[k].description == null ? "&nbsp;" : jobs[k].description%> 
            </td>
            <%            
                                        } else if (serviceID.equals(jobFieldOrder.get(j))) { 
            %>
            <td width="12%" class="tableCell">
                <%= formatTag%><%=jobs[k].serviceId == null ? "&nbsp;" : jobs[k].serviceId%>
            </td>
            <%            
                                        } else if (casePacketNames != null) {
                                            for (int i=0; i<casePacketNames.size(); i++) {
                                                if (jobFieldOrder.get(j).equals(casePacketLabels.get(i))) { 
            %>
            <td class="tableCell">
                <%= formatTag%><%= jobs[k].getSelectedCasePacketVars().get((String)casePacketNames.get(i)) == null ? "&nbsp;":jobs[k].getSelectedCasePacketVars().get((String)casePacketNames.get(i)) %>
            </td>
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
                    }
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
    <TBODY>
</table>
    </body>
</html>
