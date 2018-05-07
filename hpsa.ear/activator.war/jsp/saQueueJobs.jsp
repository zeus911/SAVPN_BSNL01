<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

  <script language="JavaScript">
    window.onload = function () {
        window.menuName = "jobsMenu";
        document.getElementById('jobsTable').oncontextmenu = showContextMenu;
        scrollTo(0,top.scrollY);
        recalculateDiv();
        scrollToTab();
        if(document.all){
          var tr_header = document.getElementById("header");
          tr_header.style.position = "relative";
        }
    }

    if (document.all) {
        var menuName = window.menuName;
        document.onclick = "hideContextMenu(menuName)";
    }

    window.onresize = function () {
        recalculateDiv();
    }

    var rowInfoArray = null;
    var job = null;
    var interactionType=null;
    function interactWithJob(queue) {
        var widthvar=750;
        var heightvar=300;
        var cookieName = window.menuName;
        rowInfoArray = new Array();
        rowInfoArray = getCookie(cookieName).split(",");
        job=rowInfoArray[0];
        interactionType=rowInfoArray[1];
        var winLink = "saInteractWithJob.jsp?queueName=" + queue + "&jobId=" + job+"&interactionType="+interactionType;
        if(interactionType==1){
            widthvar=850;
            heightvar=600;
        }
        window.open(winLink,'interact','resizable=yes,status=yes,width='+widthvar+',height='+heightvar+',scrollbars=yes');
        return true;
    }
    
    function viewActivationDetails() {
        var cookieName = window.menuName;
        rowInfoArray = new Array();
        rowInfoArray = getCookie(cookieName).split(",");
        //var jobid = getCookie(cookieName);
        jobid=rowInfoArray[0];        
        var winLink = "saActivationDetails.jsp?jobId=" + jobid;
        window.open(winLink,'','resizable=yes,status=yes,width=750,height=300,scrollbars=yes');
        return true;
    }

    function debugJob(queue){
        var cookieName = window.menuName;
        rowInfoArray = new Array();
        rowInfoArray = getCookie(cookieName).split(",");
        job=rowInfoArray[0];
        interactionType=rowInfoArray[1];      
        window.open("/activator/jsf/debugGUI/saDebugUI.jsf?jobId="+job+"&queueName="+queue,'debugview','resizable=yes,status=yes,width=1130,height=870,scrollbars=yes');
        return true;
    } 
  </script>
<%
    Vector casePacketNames = (Vector)session.getAttribute(Constants.CASEPACKET_NAME);
    Vector casePacketLabels = (Vector)session.getAttribute(Constants.CASEPACKET_LABEL);
    HashMap hash = (HashMap)session.getAttribute(Constants.JOB_FIELD_ORDER);

    Vector jobFieldOrder = null;
    boolean ConfigurationFound = true;
    if (hash != null){    // if any configuration exists
        jobFieldOrder = (Vector)hash.get(selectedQueueName);
        if (jobFieldOrder == null){         // configuration for particular queue was not found in web.xml
            jobFieldOrder = (Vector)hash.get(Constants.RUNNING_JOBS);   // try to get "Running jobs" configuration
            if (jobFieldOrder == null){
                ConfigurationFound = false;     //Load deafault configuration
            }
        }
    }else // no configuration found in web.xml
    {
      ConfigurationFound = false;
    }

    if (!ConfigurationFound){
      jobFieldOrder = new Vector();
      jobFieldOrder.add(jobID);
      jobFieldOrder.add(serviceID);
      jobFieldOrder.add(hostName);
      jobFieldOrder.add(workflow);
      jobFieldOrder.add(status);
      jobFieldOrder.add(startTime);
      jobFieldOrder.add(postTime);
      jobFieldOrder.add(step);
      jobFieldOrder.add(description);
    }

    String sortDes = "<img src='/activator/images/down.gif' align='absmiddle' border='0'/>";
    String sortAsc = "<img src='/activator/images/up.gif' align='absmiddle' border='0'/>";
    String resortLink = "saShowJobs.jsp?sort=";
%>
<table class="activatorTable" id="jobsTable">
<THEAD>
  <tr id="header">
<%  int columns = 0;
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
<%      } else if (workflow.equals(jobFieldOrder.get(k))) {
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
        } else if (postTime.equals(jobFieldOrder.get(k))) {
            columns ++;
%>
    <td width="12%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+POST_TIME_DES%>"><%=postTime%>&nbsp;<%=(currentSort==POST_TIME_DES?sortDes:"")%><%=(currentSort==POST_TIME_ASC?sortAsc:"")%></a></td>
<%
        } else if (step.equals(jobFieldOrder.get(k))) {
            columns ++;
%>
    <td width="12%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+STEP_DES%>"><%=step%>&nbsp;<%=(currentSort==STEP_DES?sortDes:"")%><%=(currentSort==STEP_ASC?sortAsc:"")%></a></td>
<%
        } else if (description.equals(jobFieldOrder.get(k))) {
            columns ++;
%>
    <td class="mainHeading"><a TARGET="_self" href="<%= resortLink+DESCR_DES%>"><%=nodeDescription%>&nbsp;<%=(currentSort==DESCR_DES?sortDes:"")%><%=(currentSort==DESCR_ASC?sortAsc:"")%></a></td>
<%
        } else if (serviceID.equals(jobFieldOrder.get(k))) {
            columns ++;
%>
    <td width="9%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+SERVICE_ID_DES%>"><%=serviceID%>&nbsp;<%=(currentSort==SERVICE_ID_DES?sortDes:"")%><%=(currentSort==SERVICE_ID_ASC?sortAsc:"")%></a></td>
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
<%      } else if(workflowState.equals(jobFieldOrder.get(k))) {
            columns ++;
%>                
        <td width="9%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+STATE_DES%>"><%=workflowState%>&nbsp;<%=(currentSort==STATE_DES?sortDes:"")%><%=(currentSort==STATE_ASC?sortAsc:"")%></a></td>      
<%      } else if (casePacketLabels != null) {
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
           case POST_TIME_DES: wfm.setComparator("JobDescriptor", "PostDate", true); break;
           case POST_TIME_ASC: wfm.setComparator("JobDescriptor", "PostDate", false); break;
           case STEP_DES:      wfm.setComparator("JobDescriptor", "StepName", true); break;
           case STEP_ASC:      wfm.setComparator("JobDescriptor", "StepName", false); break;
           case DESCR_DES:     wfm.setComparator("JobDescriptor", "Description", true); break;
           case DESCR_ASC:     wfm.setComparator("JobDescriptor", "Description", false); break;
           case SERVICE_ID_DES:     wfm.setComparator("JobDescriptor", "ServiceId", true); break;
           case SERVICE_ID_ASC:     wfm.setComparator("JobDescriptor", "ServiceId", false); break;
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
        JobRequestDescriptor[] jobs  = null;
        QueueResponseDescriptor  queueResponseDescriptor = null;
        if (jobMax <= Integer.MAX_VALUE) {
          queueResponseDescriptor = wfm.getQueue(selectedQueueName, casePacketArray, jobMax,null);
        } else {
          queueResponseDescriptor = wfm.getQueue(selectedQueueName, casePacketArray);
        }
        if (queueResponseDescriptor != null) {
          TreeMap mapTemp = (TreeMap) queueResponseDescriptor.getQueueDescriptorsAsMap();
          if(mapTemp != null){
            TreeSet jobDescSet = (TreeSet) mapTemp.get(selectedQueueName);
            if (jobDescSet != null) {
              jobs = (JobRequestDescriptor[]) jobDescSet.toArray(new JobRequestDescriptor[0]);
            }
          }
         }// see if we have data to display
        if (jobs == null || jobs.length == 0) {
%>
          <tr class="tableRowInfo">
          <td class="tableRowInfo" colspan="<%= columns+1%>"><%=noJobs%></td>
          </tr>
<%
            return;
        }

    // set initial values
    String formatTag = (((Boolean)session.getAttribute(Constants.FORMAT_TEXT)).booleanValue() == true ? "<pre>" : "");
    int numRows=1;

    if (jobs != null) {
        String rowInfo=null;
        for (int j = 0; j < jobs.length; j++) {
           String rowClass= (numRows%2 == 0) ? "tableEvenRow" : "tableOddRow";
           long jobId= jobs[j].jobId;
           int interactionType=jobs[j].interactionType;
           rowInfo=jobId+","+interactionType;
           boolean first=true;
           if (jobFieldOrder != null) {
             for (int k=0; k<jobFieldOrder.size(); k++) {
               if (first) {
                 first=false; %>

                 <tr id="<%=rowInfo%>" class="<%=rowClass%>"
                    onClick="hideContextMenu('jobsMenu');"
                    onMouseOver="mouseOver(this);"
                    onMouseOut="mouseOut(this);" >
<%             }

               if (jobID.equals(jobFieldOrder.get(k))) { %>

              <td width="7%" class="tableCell" colspan="2" nowrap align="center">
                <%=jobs[j].runtimeInfo == "Waiting" ? "&nbsp;" : " <img src='/activator/images/operAction.gif' align='absmiddle'"%>>
                  <%=jobId%></td>
<%
  } else if (hostName.equals(jobFieldOrder.get(k))) {
%>

              <td width="12%" class="tableCell" ><%=jobs[j].hostName%></td>

<%
  } else if (workflow.equals(jobFieldOrder.get(k))) {
%>

              <td width="12%" class="tableCell"><%=jobs[j].name%></a></td>

<%
  } else if (status.equals(jobFieldOrder.get(k))) {
%>

              <td width="12%" class="tableCell">
                  <%=jobs[j].runtimeInfo == "Waiting" ? jobs[j].runtimeInfo : waiting%></a></td>

<%             } else if (startTime.equals(jobFieldOrder.get(k))) { %>

              <td width="12%" class="tableCell"><%= DateFormat.getDateTimeInstance().format(jobs[j].startTime) %></a></td>

<%             } else if (postTime.equals(jobFieldOrder.get(k))) { %>

              <td width="12%" class="tableCell"><%= DateFormat.getDateTimeInstance().format(jobs[j].postDate)%></a></td>

<%             } else if (step.equals(jobFieldOrder.get(k))) { %>

              <td width="12%" class="tableCell">
                  <%= jobs[j].stepName==null ? "&nbsp;":jobs[j].stepName%></td>

<%             } else if (description.equals(jobFieldOrder.get(k))) { %>

              <td class="tableCell">
                <%= formatTag%><%= jobs[j].description == null ? "&nbsp;":jobs[j].description %></td>
<%
               } else if (serviceID.equals(jobFieldOrder.get(k))) {
%>
              <td width="7%" class="tableCell">
                  <%= formatTag%><%= jobs[j].serviceId == null ? "&nbsp;":jobs[j].serviceId %>
              </td>
<%             } else if(workflowOrderID.equals(jobFieldOrder.get(k))) {
%>
              <td width="7%" class="tableCell">
                  <%= formatTag%><%=jobs[j].workflowOrderId == null ? "&nbsp;" : jobs[j].workflowOrderId%> 
              </td>
<%             } else if(workflowType.equals(jobFieldOrder.get(k))) {
%>
              <td width="7%" class="tableCell">
                  <%= formatTag%><%=jobs[j].workflowType == null ? "&nbsp;" : jobs[j].workflowType%> 
              </td>
<%             } else if(workflowState.equals(jobFieldOrder.get(k))) {
%>
              <td width="7%" class="tableCell">
                  <%= formatTag%><%=jobs[j].workflowState == null ? "&nbsp;" : jobs[j].workflowState%> 
              </td>              
<%             } else if (casePacketNames != null) {
                 for (int i=0; i<casePacketNames.size(); i++) {
                   if (jobFieldOrder.get(k).equals(casePacketLabels.get(i))) { %>

                  <td class="tableCell">
                  <%= formatTag%><%= jobs[j].getSelectedCasePacketVars().get((String)casePacketNames.get(i)) == null ? "&nbsp;":jobs[j].getSelectedCasePacketVars().get((String)casePacketNames.get(i)) %></td>
<%                 }
                 }
               }
             }
           }
%>
           </tr>
<%
           ++numRows;
       } // end of job loop
    }    // empty queue check

    // Set the results count
%>
</TBODY>
</table>
    <script language="JavaScript">
        document.getElementById("resultCnt").innerHTML = <%=jobs.length>0?"'1 - "+jobs.length+"'":"'0'"%>;
    </script>

<!-- This table is hidden until selected for viewing with a right click -->

<div id="jobsMenu" class="contextMenu" onclick="hideContextMenu('jobsMenu');">
<%      if(queueInteractable){%>
     <a id="interactjob" href="saShowJobs.jsp" target="_self"
        class="menuItem" target="displayFrame"
          onclick="return interactWithJob('<%=encQueueName%>');"
          onmouseover="toggleHighlight(event)"
          onmouseout="toggleHighlight(event)"><%=interact%></a>
        <hr id="interactjobhr">
<%      }%>
        <!-- Prior to deleting user will be informed if they do not have permission -->
        <a href="saShowJobs.jsp" target="_self"
           class="menuItem" target='displayFrame'
           onclick="return stopJobConfirm('<%=stopMsg%>','<%=cancelMsg%>','<%=resetMsg%>','false');"
           onmouseover="toggleHighlight(event)"
           onmouseout="toggleHighlight(event)"><%=stopJob%></a>


<%      if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == true) {%>
          
<%      if (((Boolean) session.getAttribute(Constants.USE_AUTH)).booleanValue() == true) {%>
          <hr id="changerolehr">
          <a id="changerole" href="saShowJobs.jsp" target="_self"
            class="menuItem" target="displayFrame"
            onclick="return changeRoles('<%=encQueueName%>');"
            onmouseover="toggleHighlight(event)"
            onmouseout="toggleHighlight(event)"><%=changeRoles%></a>
       <% } %>

           <hr>
           <a href="saShowJobs.jsp" target="_self"
              class="menuItem" target="displayFrame"
              onclick="return stopJobConfirm('<%=forceStopMsg%>','<%=cancelMsg%>','<%=resetMsg%>','true');"
              onmouseover="toggleHighlight(event)"
              onmouseout="toggleHighlight(event)"><%=forceStopJob%></a>
           <hr id="changepriorityhr">
           <a id="changepriority" href="saShowJobs.jsp" target="_self"
              class="menuItem" target="displayFrame"
              onclick="return changePriority('<%=selectedQueueName%>');"
              onmouseover="toggleHighlight(event)"
              onmouseout="toggleHighlight(event)"><%=changePriority%></a>
<%      } %>
<%   if(selectedQueueName.equalsIgnoreCase(Constants.ACTIVATION)) {%>
          <hr>
  <a href="saShowJobs.jsp" target="_self"
              class="menuItem" target="displayFrame"
  onclick="return viewActivationDetails();"
              onmouseover="toggleHighlight(event)"
              onmouseout="toggleHighlight(event)"><%=viewActivations%></a>
<% } %>
<%
     Vector<ClusterNodeBean> dbConnectedNodes=(Vector<ClusterNodeBean>)session.getAttribute(Constants.ONLINENODES_CONENCTEDDB);       
     if(dbConnectedNodes!=null && dbConnectedNodes.size()!=0){	
%>
        <hr id="debugjobhr">
        <a id="debugjob" href="saShowJobs.jsp" target="_self"
           class="menuItem" target="displayFrame"
           onclick="return debugJob('<%=encQueueName%>');"                      
           onmouseover="toggleHighlight(event)"
           onmouseout="toggleHighlight(event)"><%=debugJob%></a>
<% } %>            
  </div>
