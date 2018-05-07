<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

  <script language="JavaScript">

    window.onload = function () {
       window.menuName = "runningJobsMenu";
       document.getElementById('runningJobs').oncontextmenu = showContextMenu;
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
    
    if (document.all) {
        document.onclick = "hideContextMenu(window.menuName)";
    }
  </script>
<% 
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
    String resortLink = "saShowJobs.jsp?sort=";
%> 
   <table class="activatorTable" id="runningJobs">

    <THEAD>
     <tr id="header">
<%      int columns = 0;
        if (jobFieldOrder != null) {
          for (int k=0; k<jobFieldOrder.size(); k++) {
            if (jobID.equals(jobFieldOrder.get(k))) { 
                columns ++;
%>
        <td width="7%" colspan="2" class="mainHeading" ><a TARGET="_self" href="<%= resortLink+JOB_ID_DES%>"><%=jobID%>&nbsp;<%=(currentSort==JOB_ID_DES?sortDes:"")%><%=(currentSort==JOB_ID_ASC?sortAsc:"")%></a></td>
<%
        } else if (serviceID.equals(jobFieldOrder.get(k))) { 
              columns ++;
%>
        <td width="9%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+SERVICE_ID_DES%>"><%=serviceID%>&nbsp;<%=(currentSort==SERVICE_ID_DES?sortDes:"")%><%=(currentSort==SERVICE_ID_ASC?sortAsc:"")%></a></td>      
<%         
            } else if (hostName.equals(jobFieldOrder.get(k))) { 
              columns ++;
%>
        <td width="12%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+HOST_NAME_DES%>"><%=hostName%>&nbsp;<%=(currentSort==HOST_NAME_DES?sortDes:"")%><%=(currentSort==HOST_NAME_ASC?sortAsc:"")%></a></td>      
<%          }   else if (workflow.equals(jobFieldOrder.get(k))) { 
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
            } else if (workflowOrderID.equals(jobFieldOrder.get(k))) {
                columns ++;
%>
        <td width="9%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+ORDER_ID_DES%>"><%=workflowOrderID%>&nbsp;<%=(currentSort==ORDER_ID_DES?sortDes:"")%><%=(currentSort==ORDER_ID_ASC?sortAsc:"")%></a></td>      
<%        
            } else if(workflowType.equals(jobFieldOrder.get(k))) {
                columns ++;
%>          
        <td width="9%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+TYPE_DES%>"><%=workflowType%>&nbsp;<%=(currentSort==TYPE_DES?sortDes:"")%><%=(currentSort==TYPE_ASC?sortAsc:"")%></a></td>      
<%          } else if(workflowState.equals(jobFieldOrder.get(k))) {
                columns ++;
%>                
        <td width="9%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+STATE_DES%>"><%=workflowState%>&nbsp;<%=(currentSort==STATE_DES?sortDes:"")%><%=(currentSort==STATE_ASC?sortAsc:"")%></a></td>      
<%          } else if (casePacketLabels != null) {
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
//System.out.println("The current ort in saRunningJobs.jsp is" + currentSort);
    // get all of the running jobs - these are jobs that the user has permission to stop
    // If a job is returned from getRunningJobs, the user has permission to stop it 
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
        case ORDER_ID_DES:    wfm.setComparator("JobDescriptor", "OrderId", true); break;
        case ORDER_ID_ASC:    wfm.setComparator("JobDescriptor", "OrderId", false); break; 
        case TYPE_DES:    wfm.setComparator("JobDescriptor", "Type", true); break;
        case TYPE_ASC:    wfm.setComparator("JobDescriptor", "Type", false); break;
        case STATE_DES:    wfm.setComparator("JobDescriptor", "State", true); break;
        case STATE_ASC:    wfm.setComparator("JobDescriptor", "State", false); break;        
       
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
    //ResponseDescriptor responseDescriptor = null;
    JobResponseDescriptor jobResponseDescriptor = null;
    HashMap responseMap = null;
    Exception e = null;
    if (jobMax <= Integer.MAX_VALUE) {
      jobResponseDescriptor = wfm.getRunningJobs(casePacketArray, jobMax,null);
    } else {
      jobResponseDescriptor = wfm.getRunningJobs(casePacketArray);
    }
   
    String runningJobsMessage = " Job(s) could not be retrieved from the node(s) ";
    if(jobResponseDescriptor != null){
      if(jobResponseDescriptor.getStatus()!=0){
        responseMap = jobResponseDescriptor.getExceptionMap();
        Set x = responseMap.keySet();
        Iterator iter = x.iterator();
        while(iter.hasNext()){
          String localHostName = (String)iter.next();
          e = (Exception) responseMap.get(localHostName);
          if(e != null){
            runningJobsMessage =runningJobsMessage+" "+localHostName;
          }
        }
    %>
    <script language="JavaScript">
    writeToMsgLine("<%=runningJobsMessage%>");
    //parent.main.location.href='saShowAvailWF.jsp';
  </script>
  <%}  
    jobs = jobResponseDescriptor.getRunningJobDescriptorsAsArray();
  }
    // see if we have data to display
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
                first=false; %>

          <tr id="<%=jobs[k].jobId%>" class="<%=rowClass%>"
                onClick="hideContextMenu('runningJobsMenu');"
                onMouseOver="mouseOver(this);"
                onMouseOut= "mouseOut(this);" >

<%            }

              if (jobID.equals(jobFieldOrder.get(j))) { %>

          <td width="7%" class="tableCell" colspan="2" nowrap align="center"><%= jobs[k].jobId %></td>
<%
              } else if (serviceID.equals(jobFieldOrder.get(j))) {
%>
          <td width="7%" class="tableCell">
          <%= formatTag%><%=jobs[k].serviceId == null ? "&nbsp;" : jobs[k].serviceId%> 
          </td>
<%            } else if (hostName.equals(jobFieldOrder.get(j))) { %>

          <td width="12%" class="tableCell" ><%= jobs[k].hostName %></td>

<%            } else if (workflow.equals(jobFieldOrder.get(j))) { %>

          <td width="12%" class="tableCell" ><%= jobs[k].name %></td>

<%            } else if (status.equals(jobFieldOrder.get(j))) { %>

          <td width="12%" class="tableCell" ><%=jobs[k].runtimeInfo%></td>

<%            } else if (startTime.equals(jobFieldOrder.get(j))) { %>
          <td width="12%" class="tableCell" >
              <%= DateFormat.getDateTimeInstance().format(jobs[k].startTime) %></a></td>

<%            } else if (step.equals(jobFieldOrder.get(j))) { %>

          <td width="12%" class="tableCell" >
              <%= formatTag%><%=jobs[k].stepName == null ? "&nbsp;" : jobs[k].stepName%> 
          </td>

<%            } else if (description.equals(jobFieldOrder.get(j))) { %>

          <td width="33%" class="tableCell">
              <%= formatTag%><%=jobs[k].description == null ? "&nbsp;" : jobs[k].description%> 
          </td>             
<%            } else if(workflowOrderID.equals(jobFieldOrder.get(j))) {
%>
          <td width="7%" class="tableCell">
          <%= formatTag%><%=jobs[k].workflowOrderId == null ? "&nbsp;" : jobs[k].workflowOrderId%> 
          </td>
<%            } else if(workflowType.equals(jobFieldOrder.get(j))) {
%>
          <td width="7%" class="tableCell">
          <%= formatTag%><%=jobs[k].workflowType == null ? "&nbsp;" : jobs[k].workflowType%> 
          </td>
<%            } else if(workflowState.equals(jobFieldOrder.get(j))) {
%>
          <td width="7%" class="tableCell">
          <%= formatTag%><%=jobs[k].workflowState == null ? "&nbsp;" : jobs[k].workflowState%> 
          </td>
<%            } else if (casePacketNames != null) {
                for (int i=0; i<casePacketNames.size(); i++) {
                  if (jobFieldOrder.get(j).equals(casePacketLabels.get(i))) { %>

                 <td class="tableCell">
                 <%= formatTag%><%= jobs[k].getSelectedCasePacketVars().get((String)casePacketNames.get(i)) == null ? "&nbsp;":jobs[k].getSelectedCasePacketVars().get((String)casePacketNames.get(i)) %></td>
<%                 }
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
    <TBODY>
</table>
     <!-- Update the result count in the tab/header frame -->
     <script language="JavaScript">
        document.getElementById("resultCnt").innerHTML = <%=(jobs != null && jobs.length>0?"'1 - "+jobs.length+"'":"'0'")%>;
     </script>

<!-- This table is hidden until selected for viewing with a right click -->

<div id="runningJobsMenu" class="contextMenu" onclick="hideContextMenu(window.menuName);">
         <a href="saShowJobs.jsp" target="_self"
            class="menuItem" target="displayFrame"
            onclick="return stopJobConfirm('<%=stopMsg%>','<%=cancelMsg%>','<%=resetMsg%>','false');"
            onmouseover="toggleHighlight(event)"
            onmouseout="toggleHighlight(event)"><%=stopJob%></a>

<%       if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == true) {%>
           
<%       if (((Boolean) session.getAttribute(Constants.USE_AUTH)).booleanValue() == true) {%>
           <hr>
           <a href="saShowJobs.jsp" target="_self"
              class="menuItem" target="displayFrame"
              onclick="return changeRoles('RunningJobs');"
              onmouseover="toggleHighlight(event)"
              onmouseout="toggleHighlight(event)"><%=changeRoles%></a>
<%       } %>
           <hr>
           <a href="saShowJobs.jsp" target="_self"
              class="menuItem" target="displayFrame"
              onclick="return stopJobConfirm('<%=forceStopMsg%>','<%=cancelMsg%>','<%=resetMsg%>','true');"
              onmouseover="toggleHighlight(event)"
              onmouseout="toggleHighlight(event)"><%=forceStopJob%></a>
              
           <hr>
           <a href="saShowJobs.jsp" target="_self"
              class="menuItem" target="displayFrame"
              onclick="return changePriority('RunningJobs');"
              onmouseover="toggleHighlight(event)"
              onmouseout="toggleHighlight(event)"><%=changePriority%></a>
<%       } %>            
</div>

</body>
</html>
