<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page import="com.hp.ov.activator.mwfm.*,
                 com.hp.ov.activator.mwfm.engine.module.DistributedResponseContainer,
                 com.hp.ov.activator.mwfm.servlet.Constants,
                 java.util.*,
                 java.net.*,
                 javax.naming.Context,
                 javax.naming.InitialContext"

         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<html>
<head>
<title>HP Service Activator</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
<script src="/activator/javascript/saUtilities.js"></script>
<script>
function getFrameSize(frameID)
{
  var result = {height:0, width:0};
  if (document.getElementById) {
    var frame = parent.document.getElementById(frameID);
    if (frame.scrollWidth) {
      result.height = frame.scrollHeight;
      result.width = frame.scrollWidth;
    }
  }
  return result;
}
function showMessagesFrame()
{
  if (top.showMessagesFrame) {
    top.showMessagesFrame();
  }
}
</script>
</head>

<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<%
// get the parameter that indicates what action we are verifying
request.setCharacterEncoding ("UTF-8");
String req = (String)request.getParameter("action");
String wfName=null;
String confirmStopMsg  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("275", "All non-active Service Activator logs will be deleted.");
String confirmStopMsg1 = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("217", "Logs that are in use by other processes will not be removed.");
String cancelDelLogMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("218", "Delete all logs action cancelled."); 
String reconfigSuccess = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("551", "Configuration successfully reloaded.");
String reconfigWarning = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("552", "Configuration reloaded with warnings. Look at MWFM and RESMGR logs.");
String reconfigFailure = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("553", "Unable to reload configuration.");
String reloadSuccess = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("173", "Workflows successfully reloaded.");
String reloadFailure = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("309", "Unable to reload Workflows.");
String reloadQueuesSuccess = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1723", "Queues successfully reloaded");
String reloadQueuesFailure = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1724", "Unable to reload Queues");
String confirmDelMsg   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("310", "The selected message will be deleted.");
String delMsgSuccess   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("312", "Message successfully deleted."); 
String unableToDeleteMsg  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("313", "Unable to delete message: "); 
String deleteAllQueues = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("314", "Messages in ALL queues will be deleted.");
String deleteThisQueue = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("554", "Messages in selected queue will be deleted.");
String delMsgsSuccess   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("316", "All messages successfully deleted."); 
String unableToDeleteMsgs  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("317", "Unable to delete all messages: "); 
String waitLogs = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("555", "Please wait while deleting log files ...");
String unknownRequest = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("318", "Unknown Request");
String suspendAllSuccess =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("556", "All Nodes suspended successfully.");
String suspendAllFailure =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("557", "Unable to suspend all nodes.");
String resumeAllSuccesss =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("558", "All Nodes resumed successfully.");
String resumeAllFailure  =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("559", "Unable to resume all nodes.");
String lockAllSuccess    =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("560", "All Nodes Locked successfully.");
String lockAllFailure    =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("561", "Unable to Lock all nodes.");
String unlockAllSuccess  =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("562", "All Nodes unlocked successfully.");
String unlockAllFailure  =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("563", "Unable to unlock all nodes.");
String suspendNodeSuccess =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("564", "Node suspended successfully.");
String suspendNodeFailure =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("565", "Unable to suspend the node.");
String resumeNodeSuccess  =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("566", "Node resumed successfully.");
String resumeNodeFailure  =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("567", "Unable to resume the node.");
String lockNodeSuccess    =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("568", "Node Locked successfully.");
String lockNodeFailure    =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("569", "Unable to lock the node.");
String unlockNodeSuccess  =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("570", "Node Unlocked successfully.");
String unlockNodeFailure  =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("571", "Unable to unlock the node.");
String becomeMasterNodeSuccess =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1021", "Node became master successfully.");
String becomeMasterNodeFailure =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1022", "Unable to make the node as master.");
String primarySiteMoveSuccess  =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1328", "Site was successfully made primary.");
String primarySiteMoveFailure  =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1329", "Failed to turn site into primary site.");

if (req.equals("delLogs")) {
%>
<script>
  var win;
  win = window.open('saDeleteLogsFilter.jsp','filterClnWindow','resizable=yes,status=no,width=420,height=220,scrollbars=no');
  win.focus();
</script>
<%
}
else if (req.equals("reloadConfiguration")) {
  try {
    WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
    ResponseDescriptor respDesc = wfm.reloadConfiguration();
    HashMap exceptionHash = respDesc.getExceptionMap();
    StringBuffer stateChangeOperationRes = new StringBuffer();
    // everything is successful here!
    for (Iterator it = exceptionHash.keySet().iterator(); it.hasNext();) {
      String hostName = (String) it.next();
      Exception ex = (Exception) exceptionHash.get(hostName);
      stateChangeOperationRes.append("HostName - ");
      stateChangeOperationRes.append(hostName);
      if (ex == null) {
        stateChangeOperationRes.append(" ; Message - Configuration Successfully Reloaded");
      } else {
        stateChangeOperationRes.append(" ; Reload Configuration Failed - Exception - ");
        stateChangeOperationRes.append(ex.getMessage());
        stateChangeOperationRes.append("<br> Please check the log for more information! ");
      }
      stateChangeOperationRes.append("<br>");
    }
%>
<script>
  showMessagesFrame();
  writeToMsgLine("<%=stateChangeOperationRes.substring(0, stateChangeOperationRes.length() - 1)%>");
</script>
<%           
  } catch (Exception e) {
    String err = null;
    if (e.getMessage() != null) {
      String tmp = e.getMessage().replace('\n',' ');
      err = tmp.replace('"',' ');
    } else {
      err = e.toString().replace('\n',' ');
    }
%>
<script>
   alert("HP Service Activator" + "\n\n" + "<%=reconfigFailure%> :  <%=err%>");
</script>
<%
  }
} else if (req.equals("reloadWorkflows")) {
  try {
    WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
    wfm.loadWorkflows();
%>
<script>
  showMessagesFrame();
  writeToMsgLine("<%=reloadSuccess%>");
  parent.main.location.href='/activator/jsf/wf/workflows.jsf';
</script>
<%
  } catch (Exception e) {
    String err = null;
    if (e.getMessage() != null) {
      String tmp = e.getMessage().replace('\n',' ');
      err = tmp.replace('"',' ');
    } else {
      err = e.toString().replace('\n',' ');
    }
%>
<script>
  alert("HP Service Activator" + "\n\n" + "<%=reloadFailure%>:  <%=err%>");
</script>
<%
  }
} else if (req.equals("reloadQueues")) {
  try {
    WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
    wfm.reloadQueuesConf();
%>
<script>
  showMessagesFrame();
  writeToMsgLine("<%=reloadQueuesSuccess%>");
  parent.main.location.href='/activator/jsf/wfmqueues/queues.jsf';
</script>
<%
  } catch (Exception e) {
    String err = null;
    if (e.getMessage() != null) {
      String tmp = e.getMessage().replace('\n',' ');
      err = tmp.replace('"',' ');
    } else {
      err = e.toString().replace('\n',' ');
    }
%>
<script>
  alert("HP Service Activator" + "\n\n" + "<%=reloadQueuesFailure%>:  <%=err%>");
</script>
<%
  }
} else if (req.equals("delMsg")) {
  String msgId = (String)request.getParameter("msgId");
  String queue= URLDecoder.decode(request.getParameter("queue"),"UTF-8");
  String fromCount  = (String) request.getParameter("fromCount");
  String numberOfMessages  = (String) request.getParameter("numberOfMessages");
  String maxRec = (String) request.getParameter("maxRec");
  int fromCountInt = 1;
  if(maxRec != null && fromCount != null && numberOfMessages != null ) {
    fromCountInt = Integer.parseInt(fromCount);
    int numberOfMessagesInt = Integer.parseInt(numberOfMessages);
    int maxRecInt = Integer.parseInt(maxRec);
    if (numberOfMessagesInt - 1 > 0) {
      if (fromCountInt > (numberOfMessagesInt-1)) {
        if (fromCountInt >= maxRecInt) {
          fromCountInt = fromCountInt - maxRecInt;
        } else {
          fromCountInt = 1;
        }
      }
    }
    session.removeAttribute("REC_START_NUM");
    session.setAttribute("REC_START_NUM",fromCountInt+"");
  }
  try {
    WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
    long id = Long.parseLong(msgId);
    wfm.deleteMessage(queue,id);
%>
<script> 
  writeToMsgLine("<%=delMsgSuccess%>");
  top.processFrame.location.href = '/activator/blank.html';
</script>
<%
  }
  catch (Exception e) {
    String err = null;
    if (e.getMessage() != null) {
      String tmp = e.getMessage().replace('\n',' ');
      err = tmp.replace('"',' ');
    } else {
      err = e.toString().replace('\n',' ');
%>
<script>
  alert("HP Service Activator" + "\n\n" + "<%=unableToDeleteMsg%>" +  "<%=err%>");
</script>
<%
    } 
  }
} else if (req.equals("delMsgs")) {
  String queue = null;
  if (request.getParameter("queue") != null) {
    queue = URLDecoder.decode(request.getParameter("queue"), "UTF-8");
  }
  try {
    WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
    Date priorToDate  = null;
    wfm.deleteAllMessages(queue, priorToDate);
    session.setAttribute("REC_START_NUM","1");
%>
<script>
  writeToMsgLine("<%=delMsgsSuccess%>");
  top.processFrame.location.href = '/activator/blank.html';
  parent.main.location.href='../jsf/messages/messages.jsf';
</script>
<%
  }
  catch (Exception e) {
    String err = null;
    if (e.getMessage() != null) {
      String tmp = e.getMessage().replace('\n',' ');
      err = tmp.replace('"',' ');
    } else {
      err = e.toString().replace('\n',' ');
    }
%>
<script>
  alert("HP Service Activator" + "\n\n" + "<%=unableToDeleteMsgs%>" +  "<%=err%>");
  parent.main.location.href='../jsf/jobs/jobs.jsf';
</script>
<%
  }
} else if (req.equals("becomeMasterNode")) {
  String hostnameToBecomeMaster = (String)request.getParameter("hostname");
  String moduleName=(String)request.getParameter("moduleName");
  boolean isNodeBecomeMaster = false;
  try {
    WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
    if(hostnameToBecomeMaster != null && !hostnameToBecomeMaster.equals("") && hostnameToBecomeMaster.length() >0) {
      isNodeBecomeMaster = wfm.becomeMasterNode(hostnameToBecomeMaster,moduleName);                            
    }
    if(isNodeBecomeMaster) {
%>
<script>
  writeToMsgLine("<%=becomeMasterNodeSuccess%>");
  parent.main.location.href='saMasterSlaves.jsp';
</script>
<%            
    }
  } catch (Exception e) {
    String err = null;
    if (e.getMessage() != null) {
      String tmp = e.getMessage().replace('\n',' ');
      err = tmp.replace('"',' ');
    } else {
      err = e.toString().replace('\n',' ');
    }
%>        
<script>
  alert("HP Service Activator" + "\n\n" + "<%=becomeMasterNodeFailure%> " +  "<%=err%>");
  parent.main.location.href='saMasterSlaves.jsp';
</script>            
<%
  } 
} else if (req.equals("suspendNode")) {
  String hostnameToSuspend = (String)request.getParameter("hostname");        
  boolean isNodeSuspended = false;
  try {
    WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
    if(hostnameToSuspend != null && !hostnameToSuspend.equals("") && hostnameToSuspend.length() >0) {
        isNodeSuspended = wfm.suspendNode(hostnameToSuspend);                            
    }            
    if(isNodeSuspended) {
      session.setAttribute(Constants.MESSAGE,suspendNodeSuccess);
%>
<script>
  writeToMsgLine("<%=suspendNodeSuccess%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
    }
  } catch (Exception e) {
    String err = null;
    if (e.getMessage() != null) {
      String tmp = e.getMessage().replace('\n',' ');
      err = tmp.replace('"',' ');
    } else {
      err = e.toString().replace('\n',' ');
    }
%>        
<script>
  alert("HP Service Activator" + "\n\n" + "<%=suspendNodeFailure%>" +  "<%=err%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
  }
} else if (req.equals("resumeNode")) {
  String hostnameToResume = (String)request.getParameter("hostname");        
  boolean isNodeResumed = false;
  try {
    WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
    if(hostnameToResume != null && !hostnameToResume.equals("") && hostnameToResume.length() >0) {
        isNodeResumed = wfm.resumeNode(hostnameToResume);                            
    } 
    if(isNodeResumed) {
      session.setAttribute(Constants.MESSAGE,resumeNodeSuccess);
%>
<script>
  writeToMsgLine("<%=resumeNodeSuccess%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
    }
  } catch (Exception e) {
    String err = null;
    if (e.getMessage() != null) {
      String tmp = e.getMessage().replace('\n',' ');
      err = tmp.replace('"',' ');
    } else {
      err = e.toString().replace('\n',' ');
    }
%>        
<script>
  alert("HP Service Activator" + "\n\n" + "<%=resumeNodeFailure%>" +  "<%=err%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
  }
} else if (req.equals("lockNode")) {
  String hostnameToLock = (String)request.getParameter("hostname");
  boolean isNodeLocked = false;
  try {
    WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
    if(hostnameToLock != null && !hostnameToLock.equals("") && hostnameToLock.length() >0) {
      isNodeLocked = wfm.lock(hostnameToLock);
    }            
    if(isNodeLocked) {
      session.setAttribute(Constants.MESSAGE,lockNodeSuccess);
%>
<script>
  writeToMsgLine("<%=lockNodeSuccess%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
    }
  } catch (Exception e) {
    String err = null;
    if (e.getMessage() != null) {
      String tmp = e.getMessage().replace('\n',' ');
      err = tmp.replace('"',' ');
    } else {
      err = e.toString().replace('\n',' ');
    }
%>        
<script>
  alert("HP Service Activator" + "\n\n" + "<%=lockNodeFailure%>" +  "<%=err%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
  }
} else if (req.equals("unlockNode")) {
  String hostnameToUnlock = (String)request.getParameter("hostname");        
  boolean isNodeUnlocked = false;
  try {
    WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
    if(hostnameToUnlock != null && !hostnameToUnlock.equals("") && hostnameToUnlock.length() >0) {
        isNodeUnlocked = wfm.unlock(hostnameToUnlock);                            
    }            
    if(isNodeUnlocked) {
      session.setAttribute(Constants.MESSAGE,unlockNodeSuccess);
%>
<script>
  writeToMsgLine("<%=unlockNodeSuccess%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
    }
  } catch (Exception e) {
    String err = null;
    if (e.getMessage() != null) {
      String tmp = e.getMessage().replace('\n',' ');
      err = tmp.replace('"',' ');
    } else {
      err = e.toString().replace('\n',' ');
    }
%>        
<script>
  alert("HP Service Activator" + "\n\n" + "<%=unlockNodeFailure%>" +  "<%=err%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
  }
} else if (req.equals("makePrimarySite")) {
  String siteToMakePrimary = (String)request.getParameter("siteName");
  try {
    WFManager wfm = (WFManager)session.getAttribute(Constants.MWFM_SESSION);
    boolean success = false; 
    if (siteToMakePrimary != null && !siteToMakePrimary.equals("") && siteToMakePrimary.length() > 0) {
      System.out.println("Making site primary: " + siteToMakePrimary);
      success = wfm.makePrimarySite(siteToMakePrimary);                            
      System.out.println("Making site primary: DONE!");
    }            
    if (success) {
      session.setAttribute(Constants.MESSAGE, primarySiteMoveSuccess);
%>
<script>
  writeToMsgLine("<%=primarySiteMoveSuccess%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
    }
  }    
  catch (Exception e) {
    String err = null;
    if (e.getMessage() != null) {
      String tmp = e.getMessage().replace('\n',' ');
      err = tmp.replace('"',' ');
    } else {
      err = e.toString().replace('\n',' ');
    }
%>        
<script>
  alert("HP Service Activator" + "\n\n" + "<%=primarySiteMoveFailure%>" +  "<%=err%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
  }
} else if (req.equals("suspendAllNodes")) {
  try {
    WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
    ResponseDescriptor respDesc = wfm.suspendAllNodes();
    HashMap exceptionHash = respDesc.getExceptionMap();
    StringBuffer stateChangeOperationRes = new StringBuffer();
    // everything is successful here!
    for (Iterator it = exceptionHash.keySet().iterator(); it.hasNext();) {
      String hostName = (String) it.next();
      Exception ex = (Exception) exceptionHash.get(hostName);
      stateChangeOperationRes.append("HostName - ");
      stateChangeOperationRes.append(hostName);
      stateChangeOperationRes.append("; Message - ");
      if (ex == null) {
        stateChangeOperationRes.append("Successfully Suspended");
      } else {
        stateChangeOperationRes.append(ex.getMessage());
      }
      stateChangeOperationRes.append("<br>");
    }
    session.setAttribute(Constants.MESSAGE,stateChangeOperationRes.toString());
%>                
<script>
  writeToMsgLine("<%=stateChangeOperationRes.toString()%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%                        
  } catch (Exception e) {
    String err = null;
    if (e.getMessage() != null) {
      String tmp = e.getMessage().replace('\n',' ');
      err = tmp.replace('"',' ');
    } else {
      err = e.toString().replace('\n',' ');
    }
%>
<script>
  alert("HP Service Activator" + "\n\n" + "<%=suspendAllFailure%> :  <%=err%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
  }
} else if (req.equals("resumeAllNodes")) {
  try {
    WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
    ResponseDescriptor respDesc = wfm.resumeAllNodes();
    HashMap exceptionHash = respDesc.getExceptionMap();
    StringBuffer stateChangeOperationRes = new StringBuffer();
    // everything is successful here!
    for (Iterator it = exceptionHash.keySet().iterator(); it.hasNext();) {
      String hostName = (String) it.next();
      Exception ex = (Exception) exceptionHash.get(hostName);
      stateChangeOperationRes.append("HostName - ");
      stateChangeOperationRes.append(hostName);
      stateChangeOperationRes.append("; Message - ");
      if (ex == null) {
        stateChangeOperationRes.append("Successfully Resumed");
      } else {
        stateChangeOperationRes.append(ex.getMessage());
      }
      stateChangeOperationRes.append("<br>");
    }
    session.setAttribute(Constants.MESSAGE,stateChangeOperationRes.toString());
%>                
<script>
  writeToMsgLine("<%=stateChangeOperationRes.toString()%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
  } catch (Exception e) {
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
  alert("HP Service Activator" + "\n\n" + "<%=resumeAllFailure%> :  <%=err%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
  }
} else if (req.equals("lockAllNodes")) {
  try {
    WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
    ResponseDescriptor respDesc = wfm.lockAllNodes();
    HashMap exceptionHash = respDesc.getExceptionMap();
    StringBuffer stateChangeOperationRes = new StringBuffer();
    // everything is successful here!
    for (Iterator it = exceptionHash.keySet().iterator(); it.hasNext();) {
      String hostName = (String) it.next();
      Exception ex = (Exception) exceptionHash.get(hostName);
      stateChangeOperationRes.append("HostName - ");
      stateChangeOperationRes.append(hostName);
      stateChangeOperationRes.append("; Message - ");
      if (ex == null) {
        stateChangeOperationRes.append("Successfully Locked");
      } else {
        stateChangeOperationRes.append(ex.getMessage());
      }
      stateChangeOperationRes.append("<br>");
    }
    session.setAttribute(Constants.MESSAGE,stateChangeOperationRes.toString());
%>                
<script>
  writeToMsgLine("<%=stateChangeOperationRes.toString()%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
  }
  catch (Exception e) {
    String err = null;
    if (e.getMessage() != null) {
      String tmp = e.getMessage().replace('\n',' ');
      err = tmp.replace('"',' ');
    } else {
      err = e.toString().replace('\n',' ');
    }
%>
<script>
  alert("HP Service Activator" + "\n\n" + "<%=lockAllFailure%> :  <%=err%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
  }
} else if (req.equals("unlockAllNodes")) {
  try {
    WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
    ResponseDescriptor respDesc = wfm.unlockAllNodes();
    HashMap exceptionHash = respDesc.getExceptionMap();
    StringBuffer stateChangeOperationRes = new StringBuffer();
    // everything is successful here!
    for (Iterator it = exceptionHash.keySet().iterator(); it.hasNext();) {
      String hostName = (String) it.next();
      Exception ex = (Exception) exceptionHash.get(hostName);
      stateChangeOperationRes.append("HostName - ");
      stateChangeOperationRes.append(hostName);
      stateChangeOperationRes.append("; Message - ");
      if (ex == null) {
        stateChangeOperationRes.append("Successfully Unlocked");
      } else {
        stateChangeOperationRes.append(ex.getMessage());
      }
      stateChangeOperationRes.append("<br>");
    }
    session.setAttribute(Constants.MESSAGE,stateChangeOperationRes.toString());
%>                
<script>
  writeToMsgLine("<%=stateChangeOperationRes.toString()%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
  }
  catch (Exception e) {
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
  alert("HP Service Activator" + "\n\n" + "<%=unlockAllFailure%> :  <%=err%>");
  var dim = getFrameSize("main");
  parent.main.location.href='saNodeView.jsp?framewidth=' + (dim.width - 20) + '&frameheight=' + dim.height; 
</script>
<%
  }
} else { 
%>
<script>
  writeToMsgLine("<%=unknownRequest%>");
</script>
<%
    }
%>
</body>
</html>
