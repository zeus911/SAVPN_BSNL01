<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="com.hp.ov.activator.mwfm.*,
                 com.hp.ov.activator.mwfm.engine.object.*,
                 com.hp.ov.activator.mwfm.servlet.*,
                 java.text.DateFormat,
                 java.sql.*,
                 java.util.*,
                 java.net.*,
                 javax.sql.*,
                 java.net.URLEncoder,
                 com.hp.ov.activator.mwfm.engine.module.ClusterNodeBean"
         info="Show Status Information of entire Cluster System."
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%><%
// Check if there is a valid session available.
if (session == null || session.getAttribute(Constants.USER) == null) {
%>
<html><head>
<script type="text/javascript">
  window.top.topFrame.location = window.top.topFrame.location;
</script>
</head></html>
<%
  return;
}

// don't cache the page
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");

request.setCharacterEncoding ("UTF-8");

String width = request.getParameter("framewidth");
String height = request.getParameter("frameheight");
String message = (String)session.getAttribute(Constants.MESSAGE);
%>
<%!
  //I18N strings

  final static String statusInformation       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("717", "Node Information");
  final static String nodeName                = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("95", "Name");
  final static String nodeIP                  = "IP";
  final static String onlineState             = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("814", "Online State");
  final static String statusState             = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("815", "Node Status");
  final static String suspendState            = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("816", "Suspend State");
  final static String heartbeat               = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1588", "Heart Beat Time");
  final static String lockState               = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("817", "Lock State");
  final static String takenOver               = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("818", "Takeover Node");
  final static String runningJobs             = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("154", "Jobs");
  final static String activationOngoing       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("759", "Activating");
  final static String internalSuspendState    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("819", "Internal Suspend State");
  final static String virtualIP               = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1317", "Virtual IP");
  final static String takenOverIP             = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1318", "Taken Over Virtual IP");
  final static String suspendNode             = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("820", "Suspend Node");
  final static String resumeNode              = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("821", "Resume Node");
  final static String lockNode                = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("822", "Lock Node");
  final static String unlockNode              = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("823", "Unlock Node");
  final static String suspendAll              = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("824", "Suspend All Nodes");
  final static String resumeAll               = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("825", "Resume All Nodes");
  final static String lockAll                 = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("826", "Lock All Nodes");
  final static String unlockAll               = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("827", "Unlock All Nodes");
  final static String confirmMsg              = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("828", "Are you sure want to ");
  final static String moveVirtualIP           = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1298", "Move Virtual IP");
  final static String makePrimarySite         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1330", "Make Primary Site");

  final static String errMsg                  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("829", "Unable to retrieve Status Information of Cluster System.");
  final static String errInfo                 = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("830", "To re-establish the connection please log back into the Operator UI.");

  final static String noClusterNodeExists     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("831", "No OVSA node exists in this System");
  final static String dbRetrievalFailed       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("832", "DB connection failed , Showing status information from each cluster node via RMI  ");
  final static String confirmSuspendNode      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("833", "Are you sure want to suspend node");
  final static String confirmResumeNode       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("834", "Are you sure want to resume node");
  final static String confirmLockNode         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("835", "Are you sure want to lock node");
  final static String confirmUnlockNode       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1080", "Are you sure want to unlock node");
  final static String confirmSuspendAll       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("837", "Are you sure want to Suspend All Nodes");
  final static String confirmResumeAll        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("838", "Are you sure want to Resume All Nodes");
  final static String confirmLockAll          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("839", "Are you sure want to Lock All Nodes");
  final static String confirmUnlockAll        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("840", "Are you sure want to Unlock All Nodes");
  final static String confirmMakePrimarySite  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1331", "Are you sure want to make the following site the primary site");
  final static String noVirtualIPToMove       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1319", "No Virtual IP are available to be moved. This node has not taken over any Virtual IP");

  final static String cancelSuspendNode       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("841", "Suspend node action cancelled");
  final static String cancelResumeNode        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("842", "Resume node action cancelled");
  final static String cancelLockNode          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("843", "Lock node action cancelled");
  final static String cancelUnlockNode        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("844", "Unlock node action cancelled");
  final static String cancelSuspendAll        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("845", "Suspend all nodes action cancelled");
  final static String cancelResumeAll         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("846", "Resume all nodes action cancelled");
  final static String cancelLockAll           = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("847", "Lock all nodes action cancelled");
  final static String cancelUnlockAll         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("848", "Unlock all nodes action cancelled"); 
  final static String cancelMakePrimarySite   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1332", "Move of primary site was cancelled");

  final static String waitSuspendNodeMsgs     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("849", "Please wait while suspending node ...");
  final static String waitResumeNodeMsgs      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("850", "Please wait while resuming node ...");
  final static String waitLockNodeMsgs        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("851", "Please wait while locking node ...");
  final static String waitUnlockNodeMsgs      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("852", "Please wait while unlocking node ...");
  final static String waitSuspendAllNodesMsgs = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("853", "Please wait while suspending all nodes ...");
  final static String waitResumeAllNodesMsgs  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("854", "Please wait while resuming all nodes ...");
  final static String waitLockAllNodesMsgs    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("855", "Please wait while locking all nodes ...");
  final static String waitUnlockAllNodesMsgs  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("856", "Please wait while unlocking all nodes ...");
  final static String waitMakePrimarySiteMsg  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1333", "Please wait while making site primary ...");

  final static String primarySite             = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1334", "Primary site: ");
  final static String standbySite             = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1335", "Standby site: ");

  final static String hostnameField     = "HOSTNAME";
  final static String onlineStateField  = "ONLINESTATE";
  final static String suspendStateField = "SUSPENDSTATE";
  final static String lockStateField    = "LOCKSTATE";
  final static String takeOverField     = "TAKEOVER";
  final static String statusField       = "STATUS";

  final static String PRIMARY_SITE = "PRIMARY";
  final static String STANDBY_SITE = "STANDBY";
  
%>
<%
    String hostName = null;
    String hostIP = null;
    String siteName = null;
    String siteState = null;
    String onlineStatus = "";
    String status = "";
    String suspendStatus = "";
    java.util.Date heartBeatTime = null;
    String lockStatus = "";
    String takeOver = "";
    int runningJobsCnt = 0;
    int activationsOngoingCnt = 0;
    String internalSuspendStatus = "";
    String virtualIPConfigured = "";
    String virtualIPTakenOver = "";    
%>
<html>
  <head>
    <title>Node Information</title>
    <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
    <link rel="stylesheet" type="text/css" href="/activator/css/saTabs.css">
    <link rel="stylesheet" type="text/css" href="/activator/css/saContextMenu.css">
    <script type="text/javascript" src="/activator/javascript/table.js"></script>
    <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
    <script type="text/javascript" src="/activator/javascript/saContextMenu.js"></script>
    <script type="text/javascript">

var selectedArea = null;
var imageArea = null;
var menuType = null;
var hostname = null;
var siteName = null;
var siteState = null;
var onlinestate = null;
var suspendstate = null;
var lockstate = null;
var ipList = null;

window.onload = function () {
  window.menuName = "clusterStatusMenu";
  window.siteMenuName = "siteStatusMenu";
  setCookie("clusterStatusMenu", "");
  document.getElementById('clusterStatusTable').oncontextmenu = showContextMenu;
}

if (document.all) {
  var menuName = window.menuName;
  document.onclick = "hideContextMenu(menuName)";
}

if (window.top.refresh == null || window.top.refresh != "OFF") {
  document.write("<meta http-equiv='refresh' content='<%=session.getAttribute(Constants.JOB_REFRESH_RATE)%>'>");
}

function showDummy(evt) {
  return false;
}

function showNodeContextMenu(evt) {
    hideContextMenu('siteStatusMenu');
    showContextMenu(evt);
}

function showSiteContextMenu(evt) {

    hideContextMenu('clusterStatusMenu');
    var menuName = window.siteMenuName;
    var menu = document.getElementById(menuName);
    var parentRow;

    // get the event regardles of IE or Netscape
    var jobEvent = evt || window.event;

    if (document.all) {
       parentRow = jobEvent.srcElement.parentElement;
       while (parentRow.tagName != "TR") { 
          parentRow = parentRow.parentElement;
       }
    } else {
       // walk the tree until we find a row
       parentRow = jobEvent.target.parentNode;
       while (parentRow.tagName != "TR") { 
          parentRow = parentRow.parentNode;
       }
    }

    // no rightclick menu if the user selected the table headers
    if (parentRow.id == "header" || parentRow.className == "tableRowWarning" || parentRow.className == "tableRowError"
            || parentRow.className == "tableRowInfo" || parentRow.className == "tableOddRowNoPointer" || parentRow.className == "tableEvenRowNoPointer") {
        return false;
    }

    // select the row
    rowSelect(parentRow);

    //Store the data in the cookie
    setCookie(menuName,parentRow.id);

    var posX = 0;
    var posY = 0;
    
    //which scroll should we use?
    //mainDiv id is used only in job screen
    var scroll_ = document.getElementById("mainDiv");
    if(scroll_ == null){
        scroll_ = document.body; 
    }

    if (jobEvent.pageX || jobEvent.pageY) {
        //netscape
        posX = jobEvent.pageX;
        posY = jobEvent.pageY;
    }
    else if (jobEvent.clientX) {
        //IE
        posX = jobEvent.clientX + scroll_.scrollLeft;
        posY = jobEvent.clientY + scroll_.scrollTop;
    }
    
    if(!jobEvent.pageX && document.getElementById("mainDiv") != null){
    //mainDiv id is used only in job screen
        posY = posY - 93;
        posX = posX - 12;
    }

    menu.style.left = posX + "px";
    menu.style.top = posY + "px";
    menu.style.visibility = "visible";

    return false;
}

function activate(rowInfo, trueorfalse, event, type) {
  //alert('activate(): "' + event + '/' + trueorfalse + '/' + rowInfo + '/' + type + '"');
  selectedArea = trueorfalse ? rowInfo : null;
  imageArea = selectedArea;
  menuType = type;
}

function nonactivate(rowInfo, trueorfalse, event) {
  selectedArea = trueorfalse ? rowInfo : null;
  //alert("nonactivate():" + rowInfo);
}

function menuPop(event, rowInfo, type) {
  //alert('menuPop1(): "' + event + '/' + type + '/' + rowInfo + '"');
  //alert('menuPop2(): "' + event.tagName + '/' + type + '/' + rowInfo + '"');
  if(event.tagName == 'AREA') {
    //alert('menuPop3(): AREA');
    activate(rowInfo,true,event,type);
  }
  //alert("menuPop4(): '" + selectedArea + "'");
  
  if (selectedArea) {
    if (menuType == 'site') {
      document.getElementById('clusterStatusGUITable').oncontextmenu = showSiteContextMenu;
    } else if (menuType == 'node') {
      document.getElementById('clusterStatusGUITable').oncontextmenu = showNodeContextMenu;
    } else {
      document.getElementById('clusterStatusGUITable').oncontextmenu = showNodeContextMenu;
    }
  } else {
    document.getElementById('clusterStatusGUITable').oncontextmenu = hideContextMenu;
  }
  selectedArea = null;
  menuType = null;
  return false;
}

function deInitializeRowInfo(){
  hostname = null;
  siteName = null;
  siteState = null;
  onlinestate = null;
  suspendstate = null;
  lockstate = null;
  ipList = null;

  imageArea = null;
}

function splitRowInfo() {
  var cookieName = window.menuName;
  var rowInfoArray = new Array();
  if (getCookie(cookieName) != "") {
    rowInfoArray = getCookie(cookieName).split(":-:");
    if (rowInfoArray.length != 7) {
	  if (imageArea != null) {
        rowInfoArray = imageArea.split(":-:");
      }
    }
  } else {
    if (imageArea != null) {
      rowInfoArray = imageArea.split(":-:");
    }
  }

  if (rowInfoArray.length == 7) {
    hostname = rowInfoArray[0];
    onlinestate = rowInfoArray[1];
    suspendstate = rowInfoArray[2];
    lockstate = rowInfoArray[3]; 
    ipList = rowInfoArray[4];
    siteName = rowInfoArray[5];
    siteState = rowInfoArray[6];
    return true;
  } else {
    return false;
  }
}

function isNodeNonActive() {
  if (onlinestate != null && onlinestate == 'Offline'){
    alert("Cannot perform this operation as Node " + hostname + " is in Offline state.");
    return true;
  }
  return false;
}

function confirmSuspendNode(confirmMsg, cancelMsg) {
  if (splitRowInfo() == false) {
    return true;
  }
  if (isNodeNonActive()) {
    deInitializeRowInfo();
    return true;
  }
  if(suspendstate != null && suspendstate == 'Suspended') {
    alert("Node already in suspended state :" + hostname);
    deInitializeRowInfo();
    return true;
  }
  confirmMsg = confirmMsg + ":" + hostname;
  if (confirm(confirmMsg)) {
    top.main.location='saShowWait.jsp?msg=<%=waitSuspendNodeMsgs%>';
    top.messageLine.location.href = "saAdminTools.jsp?action=suspendNode" + "&hostname=" + hostname;
    return true;
  }
  writeToMsgLine(cancelMsg);
  return false;
}

function confirmResumeNode(confirmMsg, cancelMsg) {
  if (splitRowInfo() == false) {
    return true;
  }
  if (isNodeNonActive()) {
    deInitializeRowInfo();
    return true;
  }
//  alert("!!! - " + suspendstate);
  if(suspendstate != null && suspendstate == 'Resumed') {
    alert("Node already in resumed state :" + hostname);
    deInitializeRowInfo();
    return true;
  }
  confirmMsg = confirmMsg + ":" + hostname;
  if (confirm(confirmMsg)) {
    top.main.location='saShowWait.jsp?msg=<%=waitResumeNodeMsgs%>';
    top.messageLine.location.href = "saAdminTools.jsp?action=resumeNode" + "&hostname=" + hostname;
    return true;
  }
  writeToMsgLine(cancelMsg);
  return false;
}

function confirmLockNode(confirmMsg, cancelMsg) {
  if (splitRowInfo() == false) {
    return true;
  }
  if (isNodeNonActive()) {
    deInitializeRowInfo();
    return true;
  }
  if (lockstate != null && lockstate == 'Locked') {
    alert("Node already in locked state :" + hostname);
    deInitializeRowInfo();
    return true;
  }
  confirmMsg = confirmMsg + ":" + hostname;
  if (confirm(confirmMsg)) {
    top.main.location='saShowWait.jsp?msg=<%=waitLockNodeMsgs%>';
    top.messageLine.location.href = "saAdminTools.jsp?action=lockNode" + "&hostname=" + hostname;
    return true;
  }
  writeToMsgLine(cancelMsg);
  return false;
}

function confirmUnlockNode(confirmMsg, cancelMsg) {
  if (splitRowInfo() == false) {
    return true;
  }
  if (isNodeNonActive()) {
    deInitializeRowInfo();
    return true;
  }
  if (lockstate != null && lockstate == 'Unlocked') {
    alert("Node already in Unlocked state :" + hostname);
    deInitializeRowInfo();
    return true;
  }
  confirmMsg = confirmMsg + ":" + hostname;
  if (confirm(confirmMsg)) {
    top.main.location='saShowWait.jsp?msg=<%=waitUnlockNodeMsgs%>';
    top.messageLine.location.href = "saAdminTools.jsp?action=unlockNode" + "&hostname=" + hostname;
    return true;
  }
  writeToMsgLine(cancelMsg);
  return false;
}

function confirmSuspendAllNodes(confirmMsg, cancelMsg) {
  if (confirm(confirmMsg)) {
    top.main.location='saShowWait.jsp?msg=<%=waitSuspendAllNodesMsgs%>';
    top.messageLine.location.href = "saAdminTools.jsp?action=suspendAllNodes";
    return true;
  }
  writeToMsgLine(cancelMsg);
  return false;
}

function confirmResumeAllNodes(confirmMsg, cancelMsg) {
  if (confirm(confirmMsg)) {
    top.main.location='saShowWait.jsp?msg=<%=waitResumeAllNodesMsgs%>';
    top.messageLine.location.href = "saAdminTools.jsp?action=resumeAllNodes";
    return true;
  }
  writeToMsgLine(cancelMsg);
  return false;
}

function confirmLockAllNodes(confirmMsg, cancelMsg) {
  if (confirm(confirmMsg)) {
    top.main.location='saShowWait.jsp?msg=<%=waitLockAllNodesMsgs%>';
    top.messageLine.location.href = "saAdminTools.jsp?action=lockAllNodes";
    return true;
  }
  writeToMsgLine(cancelMsg);
  return false;
}

function confirmUnlockAllNodes(confirmMsg, cancelMsg) {
  if (confirm(confirmMsg)) {
    top.main.location='saShowWait.jsp?msg=<%=waitUnlockAllNodesMsgs%>';
    top.messageLine.location.href = "saAdminTools.jsp?action=unlockAllNodes";
    return true;
  }
  writeToMsgLine(cancelMsg);
  return false;
}      

function makePrimarySite() {
  if (splitRowInfo() == false) {
    return true;
  }
  var confirmMsg = "<%=confirmMakePrimarySite%>: " + siteName;
  var cancelMsg = "<%=cancelMakePrimarySite%>";
  if (siteState != null && siteState == '<%=PRIMARY_SITE%>') {
    alert("Site is already the primary site:" + siteName);
    deInitializeRowInfo();
    return true;
  }
  if (confirm(confirmMsg)) {
    top.main.location='saShowWait.jsp?msg=<%=waitMakePrimarySiteMsg%>';
    top.messageLine.location.href = "saAdminTools.jsp?action=makePrimarySite&siteName=" + siteName;
    return true;
  }
  var cancelMsg = "<%=cancelMakePrimarySite%>: " + siteName;
  writeToMsgLine(cancelMsg);
  return false;
}

function moveVirtualIP() {                
  if (splitRowInfo() == false) {
    return true;
  }
  if (isNodeNonActive()) {
    deInitializeRowInfo();
    return true;
  }          
  if (ipList.length == 0) {
    alert('<%=noVirtualIPToMove%>');
    return false;
  }
  var winLink = "saMoveVirtualIP.jsp?<%=Constants.HOSTNAME%>=" + hostname;
  window.open(winLink,'movevirtualip','resizable=no,status=yes,width=424,height=200,scrollbars=yes');
  return true;           
}
    </script>
  </head>
  <body onclick="rowUnSelect();hideContextMenu('clusterStatusMenu');hideContextMenu('siteStatusMenu');"
    onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">

<!-- ************************************************************************************************ -->
<!-- **************************************** GRAPHICAL VIEW **************************************** -->
<!-- ************************************************************************************************ -->
<form name="nodeInformation">
<table id="clusterStatusGUITable" cellpadding="0" cellspacing="0" border="0">
<tr align=left><td nowrap class="frameHead"><%=statusInformation%></td></tr>
<tr>
<%
boolean isWindowsOS = com.hp.ov.activator.util.OS.OSisWindows();

String rowInfo = "";
Vector<ClusterNodeBean> clusterNodeList = (Vector)session.getAttribute(Constants.NODEINFORMATION);
HashMap<String, String> hostNameVirtualIPTakenoverMap = (HashMap<String, String>)session.getAttribute(Constants.VIRTUALIPSETUP);
virtualIPTakenOver = "";
if(clusterNodeList != null){
%>
<td><img id="nodeImage" name="nodeImage" border="0" src="/activator/nodeInformation?nodeType=nodeimage" onclick="hideContextMenu('clusterStatusMenu');hideContextMenu('siteStatusMenu');" oncontextmenu="return menuPop(this,null,'')" usemap="#nodeMap" />
<map id="nodeMap" name="nodeMap">
<%
  for (ClusterNodeBean clusterBean : clusterNodeList) {
    rowInfo = "";
    hostName = clusterBean.getHostName();
    siteName = clusterBean.getSiteName();
    siteState = (clusterBean.getSiteState() == ClusterNodeBean.SITE_STATE_PRIMARY) ? PRIMARY_SITE : STANDBY_SITE;
    onlineStatus = (clusterBean.getOnlineState() == 0) ? "Offline" : "Online";
    suspendStatus = (clusterBean.getSuspendState() == 0) ? "Resumed" : "Suspended";
    lockStatus = (clusterBean.getLockState() == 0) ? "Unlocked" : "Locked";
    if (hostNameVirtualIPTakenoverMap != null) {
      String tmp = hostNameVirtualIPTakenoverMap.get(hostName);
      virtualIPTakenOver = tmp;
    }    
    rowInfo = hostName + ":-:" + onlineStatus + ":-:" + suspendStatus + ":-:" + lockStatus + ":-:" + virtualIPTakenOver + ":-:" + siteName + ":-:" + siteState;
    if (clusterBean.getSiteState() == ClusterNodeBean.SITE_STATE_STANDBY) {
      int areaX1 = clusterBean.getSiteX();
      int areaY1 = clusterBean.getSiteY();
      int areaX2 = clusterBean.getSiteWidth() + areaX1;
      int areaY2 = clusterBean.getSiteHeight() + areaY1;
%>
<area name="siteArea" id="<%=rowInfo%>" onfocus="activate('<%=rowInfo%>',true,this,'site')" onblur="nonactivate('<%=rowInfo%>',false,this)"
oncontextmenu="return menuPop(this, '<%=rowInfo%>', 'site')" shape="rect" coords="<%=areaX1%>,<%=areaY1%>,<%=areaX2%>,<%=areaY2%>" href="#" >
<%
    } else if ((clusterBean.getSiteState() == ClusterNodeBean.SITE_STATE_PRIMARY) && (clusterBean.getOnlineState() == ClusterNodeBean.ONLINE_STATE_ON)) {
      int areaX1 = clusterBean.getNodeX();
      int areaY1 = clusterBean.getNodeY();
      int areaX2 = clusterBean.getNodeImage().getWidth() + areaX1;
      int areaY2 = clusterBean.getNodeImage().getHeight() + areaY1;
%>
<area name="nodeArea" id="<%=rowInfo%>" onfocus="activate('<%=rowInfo%>',true,this,'node')" onblur="nonactivate('<%=rowInfo%>',false,this)"
oncontextmenu="return menuPop(this, '<%=rowInfo%>', 'node')" shape="rect" coords="<%=areaX1%>,<%=areaY1%>,<%=areaX2%>,<%=areaY2%>" href="#" >
<%
    } // end if
  } // end for
%>
</map>
<% } else { %>
  <script type="text/javascript">
            writeToMsgLine("<%=noClusterNodeExists%>");
         </script>
<%
} // end if
%>
</td></tr></table>
</form>

<!-- ************************************************************************************************ -->
<!-- ****************************************** TABLE VIEW ****************************************** -->
<!-- ************************************************************************************************ -->
<form name="nodeTable">
<%
  int rowCount = 0;
  TreeMap<String, Integer> siteStates =
      (TreeMap<String, Integer>)session.getAttribute(Constants.SITESTATEINFORMATION);
  TreeMap<String, TreeMap<String, ClusterNodeBean>> siteNodes =
      (TreeMap<String, TreeMap<String, ClusterNodeBean>>)session.getAttribute(Constants.SITENODEINFORMATION);
  String clusterDBFailure = (String)session.getAttribute(Constants.DBFAILURE);
  hostNameVirtualIPTakenoverMap = (HashMap<String, String>) session.getAttribute(Constants.VIRTUALIPSETUP);
  try {
    if ((siteNodes == null) || (siteNodes.size() == 0)) {
%>
  <script type="text/javascript">
    writeToMsgLine("<%=noClusterNodeExists%>");
  </script>
<%
    }
    //Obtain Additional information such as Running Jobs Count, Activations Ongoing Count from RMI Interface
    int numRows=1;
    for (int i = 0; i <= 1; i++) {
      for (String site : siteStates.keySet()) {
        if ((i == 0) && (siteStates.get(site) == 0)) {
          continue;
        }
        if ((i == 1) && (siteStates.get(site) == 1)) {
          continue;
        }
        String tableTitle = "";
        String tableId = "";
        if (siteStates.get(site) == ClusterNodeBean.SITE_STATE_STANDBY) {
          tableTitle = standbySite + site;
          tableId = "DUMMY-" + site;
        } else {
          tableTitle = primarySite + site;
          tableId = "clusterStatusTable";
        }
%>
<h3 style="margin: 8px 0px 2px 0px"><%=tableTitle%></h3>
<table class="activatorTable" id="<%=tableId%>" border="0" width="98%">
<tr id="header">
    <td class="mainHeading"> <%=nodeName%></td>
    <td class="mainHeading"> <%=nodeIP%></td>
    <td class="mainHeading"> <%=onlineState%></td>
    <td class="mainHeading"> <%=statusState%></td>
    <td class="mainHeading"> <%=suspendState%></td>
    <td class="mainHeading"> <%=heartbeat%></td>
    <td class="mainHeading"> <%=lockState%></td>
    <td class="mainHeading"> <%=takenOver%></td>
    <td class="mainHeading"> <%=runningJobs%></td>
    <td class="mainHeading"> <%=activationOngoing%></td>
    <td class="mainHeading"> <%=internalSuspendState%></td>
<% if (!isWindowsOS) { %>    
    <td class="mainHeading"> <%=virtualIP%></td>
    <td class="mainHeading"> <%=takenOverIP%></td>
<% } %>
</tr>
<%           
        for (ClusterNodeBean clusterBean : siteNodes.get(site).values()) { 
          rowCount = rowCount + 1;
          hostName = clusterBean.getHostName();
          hostIP = clusterBean.getIpAddress();
          siteName = clusterBean.getSiteName();
          heartBeatTime = clusterBean.getHeartbeatTime();
          siteState = (clusterBean.getSiteState() == ClusterNodeBean.SITE_STATE_PRIMARY) ? PRIMARY_SITE : STANDBY_SITE;
          onlineStatus = (clusterBean.getOnlineState() == ClusterNodeBean.ONLINE_STATE_OFF) ? "Offline" : "Online";
          suspendStatus = (clusterBean.getSuspendState() == ClusterNodeBean.SUSPEND_STATE_OFF) ? "Resumed" : "Suspended";
          lockStatus = (clusterBean.getLockState() == ClusterNodeBean.LOCK_STATE_OFF) ? "Unlocked" : "Locked";
          takeOver = clusterBean.getTakeover();
          if(takeOver == null) {
            takeOver = "";
          }
          int statusValue = clusterBean.getNodeStatus();
          switch (statusValue) {
            case 10 : status = ObjectConstants.STARTING_STR;
                      break;
            case 20 : status = ObjectConstants.RUNNING_STR;
                      break;
            case 30 : status = ObjectConstants.SHUTDOWN_STR;
                      break;
            default : status = "";
                      break;
          }
          String runningJobsString = "";
          String activationsOngoingString = "";
          runningJobsCnt = clusterBean.getRunningJobs();      
          activationsOngoingCnt = clusterBean.getActivations();
          if (runningJobsCnt != 0) {
            runningJobsString = ""+runningJobsCnt;      
          }
          if (activationsOngoingCnt != 0) {
            activationsOngoingString = ""+activationsOngoingCnt;
          }
          internalSuspendStatus = clusterBean.getInternalSuspendStatus();
          virtualIPConfigured = clusterBean.getVirtualIP();
          virtualIPTakenOver = "";
          if (hostNameVirtualIPTakenoverMap != null) {
            String tmp = hostNameVirtualIPTakenoverMap.get(hostName);
            virtualIPTakenOver = tmp;
            if (tmp.length() > 0) {
              String b = null;
              String[] a = tmp.split("@");
              if (a.length == 1) {
                b = a[0];
              } else {
                StringBuffer sb1=new StringBuffer();
                for (int j = 0; j < a.length; j++) {
                  sb1.append(a[j]);
                  if (j+1 < a.length) {
                    sb1.append("\n");
                  }
                }
                b = sb1.toString();
              }
              virtualIPTakenOver = b;
            }
          }
  
          rowInfo = hostName + ":-:" + onlineStatus + ":-:" + suspendStatus + ":-:" + lockStatus + ":-:" + virtualIPTakenOver + ":-:" + siteName + ":-:" + siteState;
          String encHostName = URLEncoder.encode(hostName, "UTF-8");
          String rowClass = "";
          String colClass = "tableCell";
          if (siteStates.get(site) == ClusterNodeBean.SITE_STATE_PRIMARY) {
            rowClass = (numRows%2 == 0) ? "tableEvenRow" : "tableOddRow";
            colClass = "tableCell";
          } else {
            rowClass = (numRows%2 == 0) ? "tableEvenRowNoPointer" : "tableOddRowNoPointer";
            colClass = "tableCellNoPointer";
          }
      %>
          <tr id="<%=rowInfo%>" class="<%=rowClass%>"
              onClick="hideContextMenu('clusterStatusMenu');hideContextMenu('siteStatusMenu');"
       <% if (siteStates.get(site) == ClusterNodeBean.SITE_STATE_PRIMARY) { %>
              onMouseOver="mouseOver(this);"
              onMouseOut="mouseOut(this);"
       <% } %>
          >
            <td class="<%=colClass%>"> <%= hostName %></td>
            <td class="<%=colClass%>"> <%= hostIP == null ? "" : hostIP %></td>
            <td class="<%=colClass%>"> <%= onlineStatus %></td>
            <td class="<%=colClass%>"> <%= status %></td>
            <td class="<%=colClass%>"> <%= suspendStatus %></td>
            <td class="<%=colClass%>"> <%= heartBeatTime == null ? "" : DateFormat.getDateTimeInstance().format(heartBeatTime) %></td>
            <td class="<%=colClass%>"> <%= lockStatus %></td>
            <td class="<%=colClass%>"> <%= takeOver %></td>
            <td class="<%=colClass%>"> <%= runningJobsString %></td>
            <td class="<%=colClass%>"> <%= activationsOngoingString %></td>
            <td class="<%=colClass%>"> <%= internalSuspendStatus %></td>
<% if (!isWindowsOS) { %>    
            <td class="<%=colClass%>"> <%= virtualIPConfigured == null ? "&nbsp;" : virtualIPConfigured %></td>
            <td class="<%=colClass%>"> <%= virtualIPTakenOver %></td>
<% } %>
          </tr>
<%
          ++numRows;
        }
%>
        </table>
<%
        if(rowCount == 0) {
%>
        <script type="text/javascript">
          writeToMsgLine("<%=noClusterNodeExists%>");
        </script>
<%      }
      }
    }
    if(clusterDBFailure != null) { 
%>
       <script type="text/javascript">
         writeToMsgLine("<%=clusterDBFailure%>");
       </script>
        
<%  } else if(message != null) { %>
       <script type="text/javascript">
         writeToMsgLine("<%=message%>");
       </script>
<%  } else {
%>
       <script type="text/javascript">
         writeToMsgLine("");
       </script>
<%  } 
    session.removeAttribute(Constants.MESSAGE);        
  } catch (Exception e) {
    String err = null;
    if (e.getMessage() != null) {
      String tmp = e.getMessage().replace('\n',' ');
      err = tmp.replace('"',' ');
    } else {
      err = e.toString().replace('\n',' ');
    }
%>
      <script type="text/javascript">
        alert("HP Service Activator" + "\n\n" + "<%=errMsg%> :  <%=err%>");
        parent.displayFrame.location.href = "/activator/jsf/jobs/jobs.jsf";
      </script>
<%
  }
%>

<!-- hidden until menu is selected -->
    <div id="clusterStatusMenu" class="contextMenu" onclick="hideContextMenu('clusterStatusMenu');hideContextMenu('siteStatusMenu')">
<%      if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == true) {  %>
          <table width="140">
            <tr><td><a href="#" target="_self"
               class="menuItem" 
               onclick="return confirmSuspendNode('<%=confirmSuspendNode%>','<%=cancelSuspendNode%>');"
               onmouseover="toggleHighlight(event)"
               onmouseout="toggleHighlight(event)"><%=suspendNode%></a></td></tr>
            <tr><td><a href="#" target="_self"
               class="menuItem" 
               onclick="return confirmResumeNode('<%=confirmResumeNode%>','<%=cancelResumeNode%>');"
               onmouseover="toggleHighlight(event)"
               onmouseout="toggleHighlight(event)"><%=resumeNode%></a></td></tr>
            <tr><td><a href="#" target="_self"
               class="menuItem" 
               onclick="return confirmLockNode('<%=confirmLockNode%>','<%=cancelLockNode%>');"
               onmouseover="toggleHighlight(event)"
               onmouseout="toggleHighlight(event)"><%=lockNode%></a></td></tr>
            <tr><td><a href="#" target="_self"
                class="menuItem" 
                   onclick="return confirmUnlockNode('<%=confirmUnlockNode%>','<%=cancelUnlockNode%>');"
                   onmouseover="toggleHighlight(event)"
               onmouseout="toggleHighlight(event)"><%=unlockNode%></a></td></tr>

<%              if(rowCount> 1) { %>
            <tr><td align="left"><hr align="left" width="120" /></td></tr>

            <tr><td><a href="#" target="_self"
                        class="menuItem" 
                      onclick="return confirmSuspendAllNodes('<%=confirmSuspendAll%>','<%=cancelSuspendAll%>');"
                   onmouseover="toggleHighlight(event)"
                   onmouseout="toggleHighlight(event)"><%=suspendAll%></a></td></tr>
            <tr><td><a href="#" target="_self"
                        class="menuItem" 
                       onclick="confirmResumeAllNodes('<%=confirmResumeAll%>','<%=cancelResumeAll%>');"
                       onmouseover="toggleHighlight(event)"
                     onmouseout="toggleHighlight(event)"><%=resumeAll%></a></td></tr>
            <tr><td><a href="#" target="_self"
                     class="menuItem" 
                     onclick="confirmLockAllNodes('<%=confirmLockAll%>','<%=cancelLockAll%>');"
                     onmouseover="toggleHighlight(event)"
                   onmouseout="toggleHighlight(event)"><%=lockAll%></a></td></tr>
            <tr><td><a href="#" target="_self"
                      class="menuItem" 
                     onclick="confirmUnlockAllNodes('<%=confirmUnlockAll%>','<%=cancelUnlockAll%>');"
                     onmouseover="toggleHighlight(event)"
                   onmouseout="toggleHighlight(event)"><%=unlockAll%></a></td></tr>
<%          }    %>
<% if (!isWindowsOS) { %>    
            <tr><td align="left"><hr align="left" width="120" /></td></tr>
            <tr><td><a href="#" target="_self"
               class="menuItem" 
               onclick="return moveVirtualIP();"
               onmouseover="toggleHighlight(event)"
               onmouseout="toggleHighlight(event)"><%=moveVirtualIP%></a></td></tr>
<% } %>
          </table>
<%      } %>
    </div>

    <div id="siteStatusMenu" class="contextMenu" onclick="hideContextMenu('clusterStatusMenu');hideContextMenu('siteStatusMenu');">
<%      if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == true) {  %>
          <table width="140">
            <tr><td><a href="#" target="_self"
               class="menuItem" 
               onclick="return makePrimarySite();"
               onmouseover="toggleHighlight(event)"
               onmouseout="toggleHighlight(event)"><%=makePrimarySite%></a></td></tr>
          </table>
<%      } %>
    </div>

</form>

<br/>
</body>
</html>
