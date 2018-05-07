<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page
  import="java.util.ArrayList,
                  java.util.Date,
                  java.util.Vector,
                  java.text.DateFormat,
                  com.hp.ov.activator.resmgr.kernel.ActivationQueueBean,
                  java.sql.*,
                  java.text.DateFormat,
                  javax.sql.*,
                  com.hp.ov.activator.mwfm.servlet.Constants,
                  com.hp.ov.activator.resmgr.kernel.TransactionsBean, 
                  com.hp.ov.activator.resmgr.XIDStates"
    contentType="text/html; charset=UTF-8"
%>
<%!
//I18N strings
final static String noActivations = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1019", "No Active Transactions.");
final static String activations = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("142", "Track Activations");
final static String viewActivations = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1020", "View Activation Details");

//Table header names
final static String jobId = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("146", "Job Id");
final static String workflowName = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("6", "Workflow");
final static String activationStartTime = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("164", "Start Time");
final static String priority = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1056", "Priority");
final static String lockStatus = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1057", "Lock Status");
final static String atomicTask = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1058", "Atomic Task");
final static String lockArguments = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1059", "Lock Arguments");
final static String hostName = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("656", "Hostname");
final static String transactionState = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1061", "Transaction State");
final static String serviceId = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("415", "Service Id");
final static String workflowOrderId = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("919", "Order Id");
final static String unableToConnect = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1062", "Unable to display Service Activator data - unable to connect to the database");

//sorting
final static int JOB_ID_DES = 0;
final static int JOB_ID_ASC = 1;
final static int WORKFLOW_NAME_DESC = 2;
final static int WORKFLOW_NAME_ASC = 3;
final static int ACTIVATION_START_TIME_DES = 6;
final static int ACTIVATION_START_TIME_ASC = 7;
final static int PRIORITY_DES = 8;
final static int PRIORITY_ASC = 9;
final static int LOCK_STATUS_DES = 10;
final static int LOCK_STATUS_ASC = 11;
final static int ATOMIC_TASK_DES = 12;
final static int ATOMIC_TASK_ASC = 13;
final static int LOCK_ARGUMENTS_DES = 14;
final static int LOCK_ARGUMENTS_ASC = 15;
final static int HOST_NAME_DES = 16;
final static int HOST_NAME_ASC = 17;  
final static int TRANSACTION_STATE_DES = 20;
final static int TRANSACTION_STATE_ASC = 21;
final static int SERVICE_ID_DES = 22;
final static int SERVICE_ID_ASC = 23;
final static int ORDER_ID_DES = 24;
final static int ORDER_ID_ASC = 25;
%>

<jsp:useBean id="ActivationQueueBean" scope="session"	class="com.hp.ov.activator.resmgr.kernel.ActivationQueueBean" />
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
// don't cache the page
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");
request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<title>HP Service Activator</title>
<link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
<link rel="stylesheet" type="text/css" href="/activator/css/saContextMenu.css">
<link rel="stylesheet" type="text/css" href="/activator/css/saTabs.css">
<script src="/activator/javascript/table.js"></script>
<script src="/activator/javascript/saUtilities.js"></script>
<script src="/activator/javascript/saContextMenu.js"></script>
<script src="/activator/javascript/saNavigation.js"></script>
<script>
if (window.top.refresh==null || window.top.refresh != "OFF") {
  document.write("<meta http-equiv='refresh' content='<%=session.getAttribute(Constants.TRACK_REFRESH_RATE)%>' url='/track'>");
}
function recalculateDiv(){
  document.body.style.overflow = "auto";
}
window.onload = function () {
  window.menuName = "activationMenu";
  document.getElementById('activationsTable').oncontextmenu = showContextMenu;
  if(document.all){
    var tr_header = document.getElementById("header");
    if (tr_header != null) {
      tr_header.style.position = "relative";
    }
  }
}
if (document.all) {
  var menuName = window.menuName;
  document.onclick = "hideContextMenu(menuName)";
}
window.onresize = function () {
  recalculateDiv();
}
function viewActivationDetails() {
  var cookieName = window.menuName;
  var transseqid = getCookie(cookieName);
  var winLink = "/activator/jsp/saActivationDetails.jsp?transactionSeqId=" + transseqid;
  window.open(winLink,'','resizable=yes,status=yes,width=750,height=300,scrollbars=yes');
  return true;
}
</script>
</head>
<%
Vector transactionsFieldOrder = (Vector) session.getAttribute(Constants.TRANSACTION_FIELD_ORDER);
if (transactionsFieldOrder == null) {
  transactionsFieldOrder = new Vector();
  transactionsFieldOrder.add(jobId);
  transactionsFieldOrder.add(serviceId);
  transactionsFieldOrder.add(workflowOrderId);
  transactionsFieldOrder.add(workflowName);
  transactionsFieldOrder.add(activationStartTime);
  transactionsFieldOrder.add(priority);
  transactionsFieldOrder.add(atomicTask);
  transactionsFieldOrder.add(lockStatus);
  transactionsFieldOrder.add(lockArguments);
  transactionsFieldOrder.add(hostName);
  transactionsFieldOrder.add(transactionState);
}
String sortDes = "<img src='/activator/images/down.gif' align='absmiddle' border='0'/>";
String sortAsc = "<img src='/activator/images//up.gif' align='absmiddle' border='0'/>";
String resortLink = "/activator/jsp/saTrackActivations.jsp?sort=";
String winLink = "";
DataSource dataSource = (DataSource)session.getAttribute(Constants.DATASOURCE);
Connection connection = null;
Statement stmt = null;
ResultSet rset = null;
String sortingKey = "";

//sorting functionality
final String SESSION_SORTING = "sorting_in_saTrackActivations.jsp";
int currentSort = JOB_ID_DES;

try {
  currentSort = ((Integer)session.getAttribute(SESSION_SORTING)).intValue();
} catch (Exception e) {
  // ignore it
}

try {
  int newSorting = Integer.parseInt(request.getParameter("sort"));
  if ((newSorting == currentSort || newSorting == currentSort + 1) && (currentSort % 2 == 0)) {
    //switch between asc and des
    if (newSorting == currentSort)
      currentSort = newSorting + 1;
    else
      currentSort = newSorting - 1;
  } else {
    currentSort = newSorting;
  }
  session.setAttribute(SESSION_SORTING, new Integer(currentSort));
} catch (Exception e) {
  // ignore it
}
%>
<body onclick="rowUnSelect();hideContextMenu('activationMenu');" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
  <form name='trackActivations'>
  <table cellpadding="0" cellspacing="0" width="100%">
    <tr align=left>
      <td nowrap class="frameHead"><%=activations%></td>
    </tr>
  </table>
<%
try {
  connection = (Connection)dataSource.getConnection();
  if(connection == null) {
%>
  <script>
  alert("HP Service Activator" + "\n\n" + "<%=unableToConnect%>");
  </script>
<%
  } else {
    switch (currentSort) {
      case JOB_ID_DES:
      case JOB_ID_ASC:
        sortingKey = "JOB_ID";
        break;
      case WORKFLOW_NAME_DESC:
      case WORKFLOW_NAME_ASC:
        sortingKey = "WORKFLOW_NAME";
        break;
      case ACTIVATION_START_TIME_DES:
      case ACTIVATION_START_TIME_ASC:
        sortingKey = "ACTIVATION_START_TIME";
        break;
      case PRIORITY_DES:
      case PRIORITY_ASC:
        sortingKey = "PRIORITY";
        break;
      case LOCK_STATUS_DES:
      case LOCK_STATUS_ASC:
        sortingKey = "LOCK_STATUS";
        break;
      case ATOMIC_TASK_DES:
      case ATOMIC_TASK_ASC:
        sortingKey = "ATOMICTASK_NAME";
        break;
      case LOCK_ARGUMENTS_DES:
      case LOCK_ARGUMENTS_ASC:
        sortingKey = "LOCK_PARAMS";
        break;
      case HOST_NAME_DES:
      case HOST_NAME_ASC:
        sortingKey = "HOST_NAME";
        break;              
      case TRANSACTION_STATE_DES:
      case TRANSACTION_STATE_ASC:
          sortingKey = "TRANSACTION_STATE";
        break;
        
      case SERVICE_ID_DES:
      case SERVICE_ID_ASC:
          sortingKey = "SERVICE_ID";
        break;
        
      case ORDER_ID_DES:
      case ORDER_ID_ASC:
          sortingKey = "WORKFLOW_ORDER_ID";
        break;
    }
%>
  <table class="activatorTable" id="activationsTable">
<%
    int numRows = 0;
    ArrayList activationQueues = TransactionsBean.trackOngoingActivations(connection, sortingKey, currentSort % 2 == 0);
    if(activationQueues != null && activationQueues.size() > 0 ) {
%>
  <script>
  writeToMsgLine("");
  </script> 
<%
      numRows = activationQueues.size();
%>
    <thead>
      <tr id="header">
<%
      int columns = 0;
      if (transactionsFieldOrder != null) {
        for (int k=0; k < transactionsFieldOrder.size(); k++) {
          if (jobId.equals(transactionsFieldOrder.get(k))) { 
            columns++;
%>
        <td width="9%" class="mainHeading">
          <a target="_self" href="<%= resortLink+JOB_ID_DES%>"><%=jobId%>&nbsp;<%=(currentSort==JOB_ID_DES?sortDes:"")%><%=(currentSort==JOB_ID_ASC?sortAsc:"")%></a>
        </td>
<%
          } else if (serviceId.equals(transactionsFieldOrder.get(k))) { 
            columns++;
%>
        <td width="9%" class="mainHeading">
          <a target="_self" href="<%= resortLink+SERVICE_ID_DES%>"><%=serviceId%>&nbsp;<%=(currentSort==SERVICE_ID_DES?sortDes:"")%><%=(currentSort==SERVICE_ID_ASC?sortAsc:"")%></a>
        </td>
<% 
          } else if (workflowOrderId.equals(transactionsFieldOrder.get(k))) { 
            columns++;
%>
        <td width="9%" class="mainHeading">
          <a target="_self" href="<%= resortLink+ORDER_ID_DES%>"><%=workflowOrderId%>&nbsp;<%=(currentSort==ORDER_ID_DES?sortDes:"")%><%=(currentSort==ORDER_ID_ASC?sortAsc:"")%></a>
        </td>
<%
          } else if (workflowName.equals(transactionsFieldOrder.get(k))) { 
            columns++;
%>
        <td width="12%" class="mainHeading">
          <a target="_self" href="<%= resortLink+WORKFLOW_NAME_DESC%>"><%=workflowName%>&nbsp;<%=(currentSort==WORKFLOW_NAME_DESC?sortDes:"")%><%=(currentSort==WORKFLOW_NAME_ASC?sortAsc:"")%></a>
        </td>
<%          
          } else if (activationStartTime.equals(transactionsFieldOrder.get(k))) { 
            columns++;
%>
        <td width="12%" class="mainHeading">
          <a target="_self" href="<%= resortLink+ACTIVATION_START_TIME_DES%>"><%=activationStartTime%>&nbsp;<%=(currentSort==ACTIVATION_START_TIME_DES?sortDes:"")%><%=(currentSort==ACTIVATION_START_TIME_ASC?sortAsc:"")%></a>
        </td>
<%         
          } else if (priority.equals(transactionsFieldOrder.get(k))) { 
            columns++;
%>
        <td width="7%" class="mainHeading">
          <a target="_self" href="<%= resortLink+PRIORITY_DES%>"><%=priority%>&nbsp;<%=(currentSort==PRIORITY_DES?sortDes:"")%><%=(currentSort==PRIORITY_ASC?sortAsc:"")%></a>
        </td>
<%         
          } else if (atomicTask.equals(transactionsFieldOrder.get(k))) { 
            columns++;
%>
        <td width="12%" class="mainHeading">
          <a target="_self" href="<%= resortLink+ATOMIC_TASK_DES%>"><%=atomicTask%>&nbsp;<%=(currentSort==ATOMIC_TASK_DES?sortDes:"")%><%=(currentSort==ATOMIC_TASK_ASC?sortAsc:"")%></a>
        </td>
<%         
          } else if (lockStatus.equals(transactionsFieldOrder.get(k))) { 
            columns++;
%>
        <td width="12%" class="mainHeading">
          <a target="_self" href="<%= resortLink+LOCK_STATUS_DES%>"><%=lockStatus%>&nbsp;<%=(currentSort==LOCK_STATUS_DES?sortDes:"")%><%=(currentSort==LOCK_STATUS_ASC?sortAsc:"")%></a>
        </td>
<%         
          } else if (lockArguments.equals(transactionsFieldOrder.get(k))) { 
            columns++;
%>
        <td width="33%" class="mainHeading">
          <a target="_self" href="<%= resortLink+LOCK_ARGUMENTS_DES%>"><%=lockArguments%>&nbsp;<%=(currentSort==LOCK_ARGUMENTS_DES?sortDes:"")%><%=(currentSort==LOCK_ARGUMENTS_ASC?sortAsc:"")%></a>
        </td>
<%         
          } else if (hostName.equals(transactionsFieldOrder.get(k))) {
            columns++;
%>
        <td width="9%" class="mainHeading">
          <a target="_self" href="<%= resortLink+HOST_NAME_DES%>"><%=hostName%>&nbsp;<%=(currentSort==HOST_NAME_DES?sortDes:"")%><%=(currentSort==HOST_NAME_ASC?sortAsc:"")%></a>
        </td>
<%        
          } else if (transactionState.equals(transactionsFieldOrder.get(k))) {
            columns++;
%>
        <td width="9%" class="mainHeading">
          <a target="_self" href="<%= resortLink+TRANSACTION_STATE_DES%>"><%=transactionState%>&nbsp;<%=(currentSort==TRANSACTION_STATE_DES?sortDes:"")%><%=(currentSort==TRANSACTION_STATE_ASC?sortAsc:"")%></a>
        </td>
<%
          }
        }
      }
%>
      </tr>
    </thead>
    <tbody>
<%
      for(int i=0; i < numRows; i++) {
        ActivationQueueBean actQueueBean = (ActivationQueueBean)activationQueues.get(i);
        String rowClass = (i % 2 == 0) ? "tableEvenRow" : "tableOddRow";
        boolean first = true;
        java.util.Date d = (java.util.Date)actQueueBean.getActivationStartTime();
        String startTime = DateFormat.getDateTimeInstance().format(d);
        String lockStatusAsString = "";
        String lockParams = "";
        if(actQueueBean.getLockParams() != null && !actQueueBean.getLockParams().equals("")) {
          lockStatusAsString = actQueueBean.getLockStatusAsString();
          lockParams = actQueueBean.getLockParams();
        }
        String transactionStateString = XIDStates.stateToString(actQueueBean.getTransactionState());
        for (int j = 0; j < transactionsFieldOrder.size(); j++) {
          if (first) {
            first = false;
%>
    <tr id="<%=actQueueBean.getTransactionSequence()%>" class="<%=rowClass%>"
        onClick="hideContextMenu('activationMenu');" onMouseOver="mouseOver(this);" onMouseOut= "mouseOut(this);">
<%
          }
          if (jobId.equals(transactionsFieldOrder.get(j))) { %>
      <td width="7%" class="tableCell" nowrap align="center"><%= actQueueBean.getJobId() %></td>
<%
          }
          if (serviceId.equals(transactionsFieldOrder.get(j))) { %>
      <td width="7%" class="tableCell" nowrap align="center"><%= actQueueBean.getServiceId() == null ? "&nbsp;" : actQueueBean.getServiceId() %></td>
<%
          }
          if (workflowOrderId.equals(transactionsFieldOrder.get(j))) { %>
      <td width="7%" class="tableCell" nowrap align="center"><%= actQueueBean.getWorkflowOrderId() == null ? "&nbsp;" : actQueueBean.getWorkflowOrderId() %></td>
<%
          }
          if (workflowName.equals(transactionsFieldOrder.get(j))) { %>
      <td width="7%" class="tableCell" nowrap align="center"><%= actQueueBean.getWorkflow_name() %></td>
<%
          }
          if (activationStartTime.equals(transactionsFieldOrder.get(j))) { %>
      <td width="7%" class="tableCell" nowrap align="center"><%= startTime %></td>
<%
          }
          if (priority.equals(transactionsFieldOrder.get(j))) { %>
      <td width="7%" class="tableCell" nowrap align="center"><%= actQueueBean.getPriority() %></td>
<%
          }
          if (atomicTask.equals(transactionsFieldOrder.get(j))) { %>
      <td width="7%" class="tableCell" nowrap align="center"><%= actQueueBean.getAtomicTask() %></td>
<%
          }
          if (lockStatus.equals(transactionsFieldOrder.get(j))) { %>
      <td width="7%" class="tableCell" nowrap align="center"><%= lockStatusAsString %></td>
<%
          }
          if (lockArguments.equals(transactionsFieldOrder.get(j))) { %>
      <td width="7%" class="tableCell" nowrap align="center"><%= lockParams %></td>
<%
          }
          if (hostName.equals(transactionsFieldOrder.get(j))) { %>
      <td width="7%" class="tableCell" nowrap align="center"><%= actQueueBean.getHostName() %></td>
<%
          }
          if (transactionState.equals(transactionsFieldOrder.get(j))) { %>
      <td width="7%" class="tableCell" nowrap align="center"><%= transactionStateString %></td>
<%
          }
        }
      }
    } else {  
%>
      <script>
      writeToMsgLine("<%=noActivations%>");
      </script>
<%
    } 
  }
} catch(Exception e) {
  String err = null;
  if (e.getMessage() != null) {
    String tmp = e.getMessage().replace('\n',' ');
    err = tmp.replace('"',' ');
  }
  else {
    err = e.toString().replace('\n',' ');
  }
%>
      <script>
      alert("HP Service Activator" + "\n\n" + "<%=err%>");
      </script>
<%
} finally {
  try {
    if (rset != null) {
      rset.close();
    }
  } catch (Exception e) {
    // ignore it
  }
  try {
    if (stmt != null) {
      stmt.close();
    }
  } catch (Exception e) {
    // ignore it
  }
  if (connection != null) {
    connection.close();
  }
}
%>
    </tbody>
  </table>
  </div>
  </td>
  </tr>
</table>

<!-- hidden until menu is selected -->
<div id="activationMenu" class="contextMenu" onclick="hideContextMenu('activationMenu')">
  <a href="/activator/jsp/saTrackActivations.jsp" class="menuItem" target="displayFrame"
  onclick="return viewActivationDetails();" onmouseover="toggleHighlight(event)" onmouseout="toggleHighlight(event)">
  <%= viewActivations %>
  </a>
</div>
</form>
</body>
</html>
