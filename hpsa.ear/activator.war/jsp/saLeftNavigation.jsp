<!DOCTYPE html>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page info="Display left side menu, show only options available to the user" session="true"
    contentType="text/html; charset=UTF-8" language="java"%>

<%@ page import="javax.jms.Session" %>
<%@ page import="java.util.TreeMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.regex.*" %>
<%@ page import="com.hp.ov.activator.jsf.wfm.queues.WfmQueueManager" %>
<%@ page import="com.hp.ov.activator.mwfm.WFManager" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.LoginServlet" %>
<%@ page import="com.hp.ov.activator.mwfm.servlet.menus.MenuBean" %>

<%!
//I18N strings
final static String workArea = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("153", "Work Area");
final static String administration = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("691", "Self Management");
final static String tools = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("291", "Tools");
final static String test = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("144", "Test Messaging");
final static String reloadConfiguration = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("143", "Configuration");
final static String reloadWorkflows = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("141", "Workflows");
final static String audit = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("633", "Audit Messages");
final static String auditCln = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("694", "Audit Clean Up");
final static String statistic = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("695", "Statistics");
final static String operatorView = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("696", "Operator View");
final static String operatorExport = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("359", "Operator Statistics");
final static String administratorView = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("697", "Admin View");
final static String administratorExport = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("698", "Admin Statistics");

final static String hide = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("699", "Hide");

final static String refresh = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("295", "Refresh");
final static String ON = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("296", "ON");
final static String OFF = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("297", "OFF");
final static String displayRefresh = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("700", "Turn Auto Refresh ON or OFF");

final static String confirmMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("314", "Messages in ALL queues will be deleted.");
final static String cancelMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("311", "Delete message action cancelled.");

final static String displayTest = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("326", "Test Service Activator Messaging");

final static String reloadWF = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("323", "Reload all Workflows");
final static String reloadCfg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("701", "Reload configuration for Micro-Workflow Manager and Resource Manager");
final static String displayConf = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("322", "Display the UI Configuration");
final static String displayUMM = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("702", "Display User Management");

final static String reloadQs = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1725", "Reload queues configuration");
final static String reloadQueues = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1726", "Reload Queues");

final static String viewLicense = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1296", "View License Info");
final static String paygLicense = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1645", "Usage Information");
final static String userManagement = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("708", "User Management");
final static String addUser = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("709", "Add User");
final static String addRole = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("710", "Add Role");
final static String addTeam = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1297", "Add Team");
final static String changePasswd = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("711", "Change Password");
final static String passwordManagement = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1040", "Password Dict");
final static String createPassword = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1105", "Add Unpassword");
final static String maintainPassword = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1106", "Unpassword Management");

final static String selfMonitor = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1585", "Self Monitor");
final static String openConsole = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1586", "Open Self Monitor");
final static String threadDump = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1629", "Thread Dump");

final static String poolManagement = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1550", "Pool Management");
final static String listPools = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1551", "List Pools");
final static String addPool = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1552", "Add Pool");

final static String queueManagement = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1727", "Queue Management");
final static String listQueues = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1728", "List Queues");
final static String addQueue = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1729", "Add Queue");

final static String cleanup = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("712", "Clean Up");
final static String cleanupMsgs = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("140", "Messages");
final static String cleanupLogMsgs = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("713", "Log Messages");
final static String cleanupAuditMsgs = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("633", "Audit Messages");
final static String cleanupStatisInfo = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("714", "Statistics Information");
final static String cleanupDatabaseMessages = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1043", "Database Messages");
final static String reload = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("715", "Reload");
final static String distribution = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("716", "Distribution");
final static String statusInformation = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("717", "Node Information");
final static String activation = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("345", "Activation");
final static String jobOngoing = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("142", "Track Activations");
final static String manageLocks = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("718", "Manage Locks");
final static String export = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("719", "Export");
final static String logExport = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("720", "Log");
final static String waitMsgs = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("721", "Please wait while deleting messages ...");
final static String masterSlaves = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("722", "Master Slaves");
final static String log_data_retrieval_msg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("723", "Retrieving log data, please wait...");
final static String messagesExport = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("140", "Messages");
final static String auditMessagesExport = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("633", "Audit Messages");
%>

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

request.setCharacterEncoding("UTF-8");

final String SUBMENU_ID = "sm";

//refresh on/off functionality
boolean isRefreshON = true;
String tmpStr = (String)session.getAttribute(Constants.JOB_REFRESH_FLAG);
session.removeAttribute(Constants.JOB_REFRESH_FLAG);
if (tmpStr == null || tmpStr.equals("")) {
  tmpStr = (String)session.getAttribute(Constants.REFRESH_FUNCTIONALITY_SWITCHER);
  if (tmpStr == null || tmpStr.equals("")) {
    session.setAttribute(Constants.REFRESH_FUNCTIONALITY_SWITCHER, "ON");
    isRefreshON = true;
  } else {
    isRefreshON = tmpStr.equalsIgnoreCase("ON");
  }
} else {
  isRefreshON = tmpStr.equalsIgnoreCase("ON");
}
TreeMap<Integer, ArrayList<MenuBean>> workAreaMenu = (TreeMap<Integer, ArrayList<MenuBean>>)session.getAttribute(Constants.WORKAREA_MENU);
TreeMap<Integer, ArrayList<MenuBean>> toolsMenu = (TreeMap<Integer, ArrayList<MenuBean>>)session.getAttribute(Constants.TOOLS_MENU);
WFManager wfm = (WFManager)session.getAttribute("mwfm_session");
String user = (String)session.getAttribute("user");
String LOG_PERSISTENCE_TYPE = "log_persistence_type";
String logPath = "saLogFrame.jsp";

boolean hasAuth = ((Boolean)session.getAttribute(Constants.USE_AUTH)).booleanValue();
boolean hasDBAuth = ((Boolean)session.getAttribute(Constants.IS_DB_AUTH)).booleanValue();
boolean isAdmin = ((Boolean)session.getAttribute(Constants.IS_ADMIN)).booleanValue();
boolean isSSOUser = ((Boolean)session.getAttribute(Constants.SSO_SESSION)).booleanValue();

boolean hasTeam = false;
boolean isTeamAdmin = false;

if (session.getAttribute(Constants.TEAM_ENABLED) != null && ((Boolean)session.getAttribute(Constants.TEAM_ENABLED)).booleanValue()) {
  hasTeam = ((Boolean)session.getAttribute(Constants.TEAM_ENABLED)).booleanValue();
  isTeamAdmin = ((Boolean)session.getAttribute(Constants.TEAM_ADMIN)).booleanValue();
}

// Make it possible to display the left-navigation menu and at the same time directly select a menu item
String selectMenuOnloadJS = "";
if (session.getAttribute(Constants.SELECT_MENU) != null) {
  String selected = (String)session.getAttribute(Constants.SELECT_MENU);
  session.removeAttribute(Constants.SELECT_MENU);
  
  // Add more if statements here if we need the ability to cross launch the main UI with specific context
  if (selected.equals("LOGS")) {
    selectMenuOnloadJS = ";document.getElementById('_menu_id_/activator/jsp/saLogFrame.jsp').click()";
  }
}
%>

<html>
<head>
<title><%= LoginServlet.getMainTitle((String)session.getAttribute(Constants.CUSTOM_UI_ID)) %></title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
<link rel="stylesheet" type="text/css" href="/activator/css/saNavigation.css">
<script src="/activator/javascript/saNavigation.js"></script>
<script src="/activator/javascript/saUtilities.js"></script>
<script>
function getXMLObject()  //XML OBJECT
{
  var xmlHttp = false;
  try {
   xmlHttp = new ActiveXObject("Msxml2.XMLHTTP")  // For Old Microsoft Browsers
  }
  catch (e) {
   try {
     xmlHttp = new ActiveXObject("Microsoft.XMLHTTP")  // For Microsoft IE 6.0+
   }
   catch (e2) {
     xmlHttp = false   // No Browser accepts the XMLHTTP Object then false
   }
  }
  if (!xmlHttp && typeof XMLHttpRequest != 'undefined') {
   xmlHttp = new XMLHttpRequest();        //For Mozilla, Opera Browsers
  }
  return xmlHttp;  // Mandatory Statement returning the ajax object created
}
 
var xmlhttp;
 
function ajaxFunction(url, id) {
  xmlhttp = new getXMLObject();	//xmlhttp holds the ajax object
  if (xmlhttp) { 
    xmlhttp.open("GET", url+"?mode=toggle", true); 
    xmlhttp.onreadystatechange  = function() {
      if (xmlhttp.readyState == 4) {
        if (xmlhttp.status == 200) {
          document.getElementById(id).innerHTML= xmlhttp.responseText;
        } else {
          alert("Error during AJAX response call. Please try again. Status = " + xmlhttp.status);
        }
      }
    }
    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xmlhttp.send();
  }
}
 
function callJsp(url, id) {
	ajaxFunction(url, id);
}

function UMMMenu(){
  var menu = document.getElementById("UMMMenu");
  var img = document.getElementById("umm_img");
  //determine if menu is currently shown
  if (menu.style.visibility == "visible") {
    // close menu
    menu.style.visibility = "hidden";
    menu.style.display = "none";
    //change image
    img.src = "/activator/images/collapsed.gif";
  } else {
    // open menu
    menu.style.display = 'block';
    menu.style.visibility = "visible";
    //change image
    img.src = "/activator/images/expanded.gif";
  }
}

function toggleNavMenu(arrowId, menuId) {
  var menu = document.getElementById(menuId);
  var arrow = document.getElementById(arrowId);
  //determine if menu is currently shown
  if (arrow.src.indexOf("up.png") >= 0) {
    // open menu
    arrow.src = "/activator/images/down.png";
    menu.style.display = 'block';
    menu.style.visibility = "visible";
  } else {
    // close menu
    arrow.src = "/activator/images/up.png";
    menu.style.display = "none";
    menu.style.visibility = "hidden";
  }
}

function hideNavMenu(menuElem, menuName) {
  var menu = document.getElementById(menuName);
  if (menu != null){
    menuElem.id = "up";
    menuElem.src = "/activator/images/up.png";
    menu.style.visibility = "hidden";
    menu.style.display = "none";
  }
}

var pos = 0;

function init(){
  window.top.refresh = '<%=isRefreshON ? ON : OFF%>';
  window.top.logFile = '';
  var newText = document.createTextNode('<%=isRefreshON ? ON : OFF%>');
  var elem = document.getElementById("refreshSpan");
  top.main.location = top.main.location;
  while (elem.childNodes.length > 0) {
      elem.removeChild(elem.firstChild);
  }
  elem.appendChild(newText);
  //refresh main frame
  window.top.main.location = 'saCreateFrame.jsp?jsp=/activator/jsf/jobs/jobs.jsf';
}

var result;
function getFrameSize(frameID) {
  result = {height:0, width:0};
  if (document.getElementById) {
    var frame = parent.document.getElementById(frameID);
    if (frame.scrollWidth) {
      result.height = frame.scrollHeight;
      result.width = frame.scrollWidth;
    }
  }
  return result;
}

function nodeView()
{
  getFrameSize("main");
  var nodeURL = 'saCreateFrame.jsp?jsp=saNodeView.jsp&framewidth='+(result.width-20)+'&frameheight='+result.height;
  parent.main.location = nodeURL;
}

function toggleRefresh()
{
  var status = window.top.refresh;
  var refreshActive = (status == null || status == "<%=ON%>"); // current value
  updateSession(!refreshActive); // toggled value = !current value
}
function toggledRefresh(refreshActive)
{
  // this function must be called from saUpdateSession.jsp once the session has been updated
  window.top.refresh = refreshActive;
  document.getElementById("refreshSpan").innerHTML = refreshActive;
  top.main.location = top.main.location;
  top.counterFrame.location = top.counterFrame.location;
}

function updateSession(isRefreshActive)
{
  var val = "saUpdateSession.jsp?refresh_state="+(isRefreshActive?"<%=ON%>":"<%=OFF%>");
  top.processFrame.location.href= val;
}

function refreshStatus() {
  var status;
  var newText;
  if (window.top.refresh == null) {
    status = "<%=ON%>"
  } else {
    status = window.top.refresh;
  }
  return status;
}

function confirmDeleteMessage(confirmMsg, cancelMsg) {
  if (confirm(confirmMsg)) {
    top.main.location='saShowWait.jsp?msg=<%=waitMsgs%>';
    top.processFrame.location.href = "saAdminTools.jsp?action=delMsgs";
    return true;
  }
  writeToMsgLine(cancelMsg);
  return false;
}

function toggleHighlight (evt) {
  evt = (evt) ? evt : ((event) ? event : null);
  if (evt) {
    var elem = (evt.target) ? evt.target : evt.srcElement;
    if (elem.nodeType == 3)  { // textvalue of the element
      elem = elem.parentNode;
    }
    elem.className = (evt.type == "mouseover") ? "menuItemOn" : "menuItem_";
  }
}

function openNewWindow(url,winName,location,menubar,resizable,scrollbars,status,width,height,left,top) {
  var temp;
  var windowAttributes = "location="+booleanAttributeInterpreter(location);
  windowAttributes += ",menubar="+booleanAttributeInterpreter(menubar);
  windowAttributes += ",resizable="+booleanAttributeInterpreter(resizable);
  windowAttributes += ",scrollbars="+booleanAttributeInterpreter(scrollbars);
  windowAttributes += ",status="+booleanAttributeInterpreter(status);
  windowAttributes += ",width="+width+",height="+height+",left="+left+",top="+top+"";
  if (winName != null){
    winName = winName.split(' ').join('');
    var existingWindowRef = get(winName);
    if (existingWindowRef != null){
      if (!(existingWindowRef.closed)){
        existingWindowRef.focus();
      } else {
        remove(existingWindowRef);
        temp = window.open(url, winName, windowAttributes);
        put(winName,temp);
        temp.focus();
      }
    } else {
      temp = window.open(url, winName, windowAttributes);
      put(winName,temp);
      temp.focus();
    }
  } else {
    temp = window.open(url, '', windowAttributes);
    temp.focus();
  }
}

function booleanAttributeInterpreter(value) {
  return (value == "1" || value == "yes" || value == "true") ? "1" : "0";
}

function closeSubMenu() {
  var menu;
  var toolsSubMenuArr = new Array();
  for (var i = 0; document.getElementById("<%= SUBMENU_ID %>" + i) != null; i++) {
    document.getElementById("<%= SUBMENU_ID %>" + i).style.visibility = "hidden";
    document.getElementById("<%= SUBMENU_ID %>" + i).style.display = "none";
  }
}

function showHideMenu(divElementId, imgElementId){
  var menu = document.getElementById(divElementId);
  var img = document.getElementById(imgElementId);
  //determine if menu is currently shown
  if (menu.style.visibility == "visible") {
    // close menu
    menu.style.visibility = "hidden";
    menu.style.display = "none";
    // change image
    img.src = "/activator/images/collapsed.gif";
  } else {
    // open menu
    menu.style.display = 'block';
    menu.style.visibility = "visible";
    // change image
    img.src = "/activator/images/expanded.gif";
  }
}

function closeMenu(menuid) {
  var menu = document.getElementById(menuid);
  if (menu != null){
    menu.style.visibility = "hidden";
    menu.style.display = "none";
  }
}

function closeAllMenus() {
  closeSubMenu();
  closeMenu('statisticMenu');
  closeMenu('cleanupMenu');
  closeMenu('reloadMenu');
  closeMenu('distributionMenu');
  closeMenu('activationMenu');
  closeMenu('exportMenu');
  closeMenu('UMMMenu');
}

function popupOperatorFilter(){
  var win;
  win = window.open('saOperatorFilter.jsp','OperatorFilterWindow','resizable=no,status=no,width=429,height=703,scrollbars=no');
  win.focus();
}

function popupExport(formType){
  var win;
  win = window.open('saExportFilter.jsp?formType='+formType,'ExportWindow','resizable=no,status=no,width=365,height=260,scrollbars=no');
  win.focus();
}

function popupMessagesExport(formType){
  var win;
  win = window.open('saMessagesExport.jsp?formType='+formType,'ExportWindow','resizable=no,status=no,width=365,height=260,scrollbars=no');
  win.focus();
}

function popupAuditMessagesExport(formType){
  var win;
  win = window.open('saAuditExport.jsp?formType='+formType,'ExportWindow','resizable=no,status=no,width=365,height=280,scrollbars=no');
  win.focus();
}

function popupAdministratorFilter(){
  var win;
  win = window.open('saAdministratorFilter.jsp','AdministratorFilterWindow','resizable=no,status=no,width=425,height=525,scrollbars=no');
  win.focus();
}

function popupStatisticCln(){
  var win;
  win = window.open('saStatisticCleanUp.jsp','statCln','resizable=no,status=no,width=400,height=400,scrollbars=no');
  win.focus();
}

function popupDatabaseMessageCln(){
  var win;
  win = window.open('saDatabaseMessageCleanUp.jsp','dbMsgCln','resizable=no,status=no,width=400,height=400,scrollbars=no');
  win.focus();
}

function popupClnFilter(){
  var win;
  win = window.open('saAuditCleanUp.jsp','filterClnWindow','resizable=no,status=no,width=360,height=250,scrollbars=no');
  win.focus();
}

function popupClnLogsFilter(){
  var win;
  win = window.open('saDeleteLogsFilter.jsp','filterClnWindow','resizable=no,status=no,width=425,height=225,scrollbars=no');
  win.focus();
}

//These methods are for storing/restoring log file scroll position
var savedXPos = 0;
var savedYPos = 0;
var initNumRows;
var logFileSelected="";
var initLogFileCount;
var tabName="";
var currentLogFileCount;
//map objects which hold the values per tab
//map object for holding the vertical scrollbar rows for the scrolled height
var mapVertical = new Object();
//map object for holding the horizontal scrollbar coordinates
var mapHorizontal = new Object();
//map object to store the total number of rows in the page for a tab
var mapRows=new Object();
//map object to store the log file viewed when the position was saved.
var mapCurrLogFile=new Object();
//map object to store the log file count in the tab when the position was saved.
var mapLogFileCount=new Object();

function saveLogPos(valX, valY, numRows){
  //set values in the map objects
  eval("mapHorizontal['"+tabName+"']=valX;");
  eval("mapVertical['"+tabName+"']=valY;");
  eval("mapRows['"+tabName+"']=numRows;");
  eval("mapCurrLogFile['"+tabName+"']=window.top.logFile;");
  eval("mapLogFileCount['"+tabName+"']=currentLogFileCount;");
}

function setLogFileCount(logFileCount) {
  currentLogFileCount=logFileCount;
}

function restoreLogPos(){
  top.main.displayFrame.logDisplayFrame.scrollTo(savedXPos,savedYPos);
}

function restoreLogPos(scrollHeight,numrows){
  //retrieve values from the map objects for the current tab
  eval("savedXPos=mapHorizontal."+tabName+";");
  eval("savedYPos=mapVertical."+tabName);
  eval("numRows=mapRows."+tabName+";");
  eval("initLogFileCount=mapLogFileCount."+tabName);
  eval("logFileSelected=mapCurrLogFile."+tabName);
  //get the relative height for the current page((total current height/total number of rows)* number of rows to which the scrollbar position needs to be set)
  var rowFac=savedYPos/numrows;
  var pos=rowFac*scrollHeight;
  //if the current file is the active file and the log file count while restoring is greater than that when
  //it was saved then reset the scrollbar to the top.
  if(logFileSelected.indexOf('active')!=-1 && currentLogFileCount>initLogFileCount) {
    resetLogPos();
  } else {
    top.main.displayFrame.logDisplayFrame.scrollTo(savedXPos,pos);
  }
}

function resetLogPos(){
  //scroll to the top of the page
  top.main.displayFrame.scrollTo(0,0);
}

function setLogFile(fileName){
  window.top.logFile = fileName;
  eval("mapCurrLogFile['"+tabName+"']=window.top.logFile;");
}

function getJobRefreshRate(){
  return <%=session.getAttribute(Constants.JOB_REFRESH_RATE)%>*1000;
}

//These methods are for storing/restoring track scroll position
var savedTrackXPos = 0;
var savedTrackYPos = 0;
function saveTrackPos(valX, valY){
  savedTrackXPos = valX;
  savedTrackYPos = valY;
}

function restoreTrackPos(){
  top.main.displayFrame.scrollTo(savedTrackXPos,savedTrackYPos);
}

//set the current tab name
function setCurrentTab(currTabName) {
  tabName=currTabName;
}

</script>

</head>

<body class="bodyClass" style="margin:0px; padding:0px; overflow-y:auto;" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();"
  onload="init();closeAllMenus();hideNavMenu(this, 'utilityMenu');Map();<%=selectMenuOnloadJS%>">
<input type="hidden" name="tab">
<table>
  <tr style="vertical-align:top;">
    <td style="width:100%">
<%
TreeMap<Integer, ArrayList<MenuBean>>map = null;
String areaId = "";
int menucount = 1;
String menuidvalue = "";
int counter = 0;
for (int k=0; k<2; k++) {
  // Work Area
  if (k == 0) {
%>
    <table class="menuHead" onclick="toggleNavMenu('workspaceArrow', 'workspaceMenu');" style="margin-top:5px;">
      <tr id="menu" class="menuHead" style="line-height:15px;">
        <td style="width:95%"><%=workArea%></td>
        <td><img src="/activator/images/down.png" id="workspaceArrow" /></td>
      </tr>
    </table>
<%
    map = workAreaMenu;
    areaId ="workspaceMenu";
  }
  // Tools area
  if (k == 1) {
%>
    <table class="menuHead" onclick="toggleNavMenu('toolsArrow', 'toolsMenu');" style="margin-top:5px;">
      <tr style="line-height:15px;">
        <td style="width:95%"><%=tools%></td>
        <td><img src="/activator/images/down.png" id="toolsArrow" /></td>
      </tr>
    </table>
    <table style="width:100%">
      <tr>
        <td title="<%=displayRefresh%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
            onMouseOut="unhighlightMenu(this);" onclick="menuSelect(this);toggleRefresh();"><%=refresh%></td>
        <td style="text-align:right;" class="menuUnselected">
          <span id="refreshSpan" class="menuItem"><script>document.write(refreshStatus());</script></span>
        </td>
      </tr>
    </table>
<%
    map = toolsMenu;
    areaId ="toolsMenu";
  }
%>
    <div id="<%=areaId%>" class="menuItems">
    <table style="width:100%">
<%
  if (map !=null) {
    try {
      for (Iterator<Integer> it = map.keySet().iterator(); it.hasNext();) {
        Integer menuId = it.next();
        ArrayList<MenuBean> menuBeanArray = map.get(menuId);
        for (int i = 0; i < menuBeanArray.size(); i++) {
          MenuBean menuBean = menuBeanArray.get(i);
          String menuRole = menuBean.getRole();
          boolean menuRoleAccess = false;
          if (menuRole != null) {
            menuRoleAccess = wfm.isInRole(menuRole);
          } else {
            menuRoleAccess = true;
          }

          String sessionKeys = menuBean.getSessionKeys();
          String url = menuBean.getURL();
          if (sessionKeys != null && !"".equals(sessionKeys)) {
            String[] keys = sessionKeys.split(",");
            for (int j = 0; j < keys.length; j++) {
              String key = keys[j];
              String value = (String)session.getAttribute(key);
              if (value != null && !"".equals(value)) {
                String patt = "#" + key + "#"; // replace text within the delimiter #
                Pattern r = Pattern.compile(patt);
                Matcher m = r.matcher(url);
                url = m.replaceAll(java.net.URLEncoder.encode(value, "UTF-8"));
              }
            }
          }

          if (menuRoleAccess) {
            menuidvalue = "menuid_" + menucount++;
            TreeMap<Integer, MenuBean> submenuMap = menuBean.getSubMenus();
            if (submenuMap != null && submenuMap.size() > 0) {
              String divId = SUBMENU_ID + counter;
              String imgId = "img" + counter;
              counter++;
%>
      <tr>
        <td title="<%=menuBean.getLabel()%>" class="menuUnselected" style="vertical-align:middle;" onMouseOver="highlightMenu(this);"
            onMouseOut="unhighlightMenu(this);" onclick="menuSelect(this);showHideMenu('<%=divId%>','<%=imgId%>');">
        <img src="/activator/images/collapsed.gif" id="<%=imgId%>" class="menuImage"><span style="position:relative; top:-1px;">&nbsp;<%=menuBean.getLabel()%></span>
        <input type="hidden" name="menu_id" value="<%=menuBean.getId()%>">
        </td>
      </tr>
      <tr>
        <td>
        <div id="<%=divId%>" class="invMenuItems" style="display:none; visibility:hidden;">
        <table style="width:100%">
<%
              for (Iterator<Integer> subMenuIt = submenuMap.keySet().iterator(); subMenuIt.hasNext();) {
                Integer submenuId = subMenuIt.next();
                menuidvalue = "menuid_" + menucount++;
                MenuBean submenuBean = submenuMap.get(submenuId);
                String submenuRole = submenuBean.getRole();
                boolean submenuRoleAccess = false;
                if (submenuRole != null) {
                  submenuRoleAccess = wfm.isInRole(submenuRole);
                } else {
                  submenuRoleAccess = true;
                }
                sessionKeys = submenuBean.getSessionKeys();
                url = submenuBean.getURL();
                if (sessionKeys != null && !"".equals(sessionKeys)) {
                  String[] keys = sessionKeys.split(",");
                  for (int j = 0; j < keys.length; j++) {
                    String key = keys[j];
                    String value = (String)session.getAttribute(key);
                    if (value != null && !"".equals(value)) {
                      String patt = "#" + key + "#"; // replace text within the delimiter #
                      Pattern r = Pattern.compile(patt);
                      Matcher m = r.matcher(url);
                      url = m.replaceAll(java.net.URLEncoder.encode(value, "UTF-8"));
                    }
                  }
                }
                if (submenuRoleAccess) {
                  if (submenuBean.isPopup()) {
%>
          <tr>
            <td title="<%=submenuBean.getLabel()%>" class="menuUnselected" style="width:100%"
              onMouseOver="highlightMenu(this);" onMouseOut="unhighlightMenu(this);"
<%
                    if (submenuBean.isMultiple()) {
%>
              onClick="clearMessageLine();menuSelect(this);openNewWindow('<%=url%>', null, '<%=submenuBean.getLocation()%>', '<%=submenuBean.getMenubar()%>', '<%=submenuBean.getResizable()%>', '<%=submenuBean.getScrollbars()%>', '<%=submenuBean.getStatus()%>', '<%=submenuBean.getWidth()%>', '<%=submenuBean.getHeight()%>', '<%=submenuBean.getLeft()%>', '<%=submenuBean.getTop()%>');">
            <%=submenuBean.getLabel()%>
<%
                    } else {
%>
              onClick="clearMessageLine();menuSelect(this);openNewWindow('<%=url%>', '<%=submenuBean.getLabel()%>', '<%=submenuBean.getLocation()%>',
                      '<%=submenuBean.getMenubar()%>', '<%=submenuBean.getResizable()%>', '<%=submenuBean.getScrollbars()%>', '<%=submenuBean.getStatus()%>',
                      '<%=submenuBean.getWidth()%>', '<%=submenuBean.getHeight()%>', '<%=submenuBean.getLeft()%>', '<%=submenuBean.getTop()%>');">
            <%=submenuBean.getLabel()%>
<%
                    }
%>
              <input type="hidden" name="submenu_id" value="<%=submenuBean.getId()%>">
            </td>
          </tr>
<%
                  } else if (submenuBean.isToggle()) {
                    String toggleValue = (String)session.getAttribute(submenuBean.getToggleValue());
                    if (toggleValue == null || "".equals(toggleValue)) {
                      toggleValue = submenuBean.getToggleDefault();
                    }
                    if (toggleValue == null || "".equals(toggleValue)) {
%>
	          <jsp:include page="<%=url.substring(10)%>" flush="true">
              <jsp:param name="mode" value="init" />
            </jsp:include>
<%
                      toggleValue = (String)session.getAttribute(submenuBean.getToggleValue());
                    }
%>
          <tr>
            <td>
              <table style="width:124px;">
              <tr>
              <td title="<%=submenuBean.getLabel()%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
                  onMouseOut="unhighlightMenu(this);" onClick="callJsp('<%=url%>', '<%=menuidvalue%>');">
              <%=menuBean.getLabel()%>
              <input type="hidden" name="submenu_id" value="<%=submenuBean.getId()%>">
              </td>
              <td class="menuItem" style="text-align:right;"><span id="<%=menuidvalue%>"><%=toggleValue%></span>
              </td>
              <td style="width:10px; text-align:right;">
              </td>
              </tr>
              </table>
            </td>
          </tr>
<%
                    } else {
%> 
          <tr>
            <td title="<%=submenuBean.getLabel()%>" class="menuUnselected" style="width:100%"
                onMouseOver="highlightMenu(this);" onMouseOut="unhighlightMenu(this);"
                onClick="menuSelect(this);clearMessageLine();parent.main.location='saCreateFrame.jsp?jsp=<%=url%>';">
              <%=submenuBean.getLabel()%>
              <input type="hidden" name="submenu_id" value="<%=submenuBean.getId()%>">
            </td>
          </tr>
<%
                    }
                  }
                }
%>
        </table>
        </div>
        </td>
      </tr>
<%
              } else if (menuBean.isPopup()) {
%>
      <tr>
        <td title="<%=menuBean.getLabel()%>" class="menuUnselected" onMouseOver="highlightMenu(this);" onMouseOut="unhighlightMenu(this);" 
<%
                if (menuBean.isMultiple()) { 
%>
            onClick="clearMessageLine();menuSelect(this);openNewWindow('<%=url%>', null, '<%=menuBean.getLocation()%>', '<%=menuBean.getMenubar()%>', '<%=menuBean.getResizable()%>', '<%=menuBean.getScrollbars()%>', '<%=menuBean.getStatus()%>', '<%=menuBean.getWidth()%>', '<%=menuBean.getHeight()%>', '<%=menuBean.getLeft()%>', '<%=menuBean.getTop()%>');">
        <%=menuBean.getLabel()%>
<%
                } else {
%>
            onClick="clearMessageLine();menuSelect(this);openNewWindow('<%=url%>', '<%=menuBean.getLabel()%>', '<%=menuBean.getLocation()%>',
                    '<%=menuBean.getMenubar()%>', '<%=menuBean.getResizable()%>', '<%=menuBean.getScrollbars()%>', '<%=menuBean.getStatus()%>',
                    '<%=menuBean.getWidth()%>', '<%=menuBean.getHeight()%>', '<%=menuBean.getLeft()%>', '<%=menuBean.getTop()%>');">
        <%=menuBean.getLabel()%>
<%
                }
%>
          <input type="hidden" name="menu_id" value="<%=menuBean.getId()%>">
        </td>
      </tr>
<%
              } else if (menuBean.isToggle()) {
                String toggleValue = (String)session.getAttribute(menuBean.getToggleValue());
                if (toggleValue == null || "".equals(toggleValue)) {
                  toggleValue = menuBean.getToggleDefault();
                }
                if (toggleValue == null || "".equals(toggleValue)) {
%>
		  <jsp:include page="<%=url.substring(10)%>" flush="true">
        <jsp:param name="mode" value="init" />
      </jsp:include>
<%
                  toggleValue = (String)session.getAttribute(menuBean.getToggleValue());
                }
%>
      <tr>
        <td>
        <table style="padding:0px; width:133px;">
          <tr>
            <td title="<%=menuBean.getLabel()%>" class="menuUnselected" onMouseOver="highlightMenu(this);" onMouseOut="unhighlightMenu(this);" 
                onClick="callJsp('<%=url%>', '<%=menuidvalue%>');">
              <%=menuBean.getLabel()%>
              <input type="hidden" name="menu_id" value="<%=menuBean.getId()%>">
            </td>
            <td class="menuItem" style="text-align:right;"><span id="<%=menuidvalue%>"><%=toggleValue%></span>
            </td>
            <td style="width:10px; text-align:right;">
            </td>
          </tr>
        </table>
        </td>
      </tr>
<%
              } else {
%> 
      <tr>
        <td title="<%=menuBean.getLabel()%>" id="_menu_id_<%=url%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
            onMouseOut="unhighlightMenu(this);" 
            onClick="menuSelect(this);clearMessageLine();parent.main.location='saCreateFrame.jsp?jsp=<%=url%>';">
          <%=menuBean.getLabel()%>
          <input type="hidden" name="menu_id" value="<%=menuBean.getId()%>">
        </td>
      </tr>
<%
              }
            }
          }
        }
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
%>
    </table>
    </div>
<%
  }
  if (hasDBAuth || isAdmin) {
%>
    <div>
    <table class="menuHead" onclick="toggleNavMenu('utilityArrow', 'utilityMenu');" style="margin-top:5px;">
      <tr class="menuHead" style="line-height:15px;">
        <td style="width:95%"><%=administration%></td>
        <td><img src="/activator/images/up.png" id="utilityArrow" /></td>
      </tr>
    </table>
    </div>
    <div id="utilityMenu" class="menuItems">
    <table style="width:100%">
      <!--  This menu is only available if the user has administrative rights -->
<%
    if (hasAuth) {
      if (hasDBAuth) {
%>
      <tr>
        <td title="<%=changePasswd%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
            onMouseOut="unhighlightMenu(this);" onclick="clearMessageLine();menuSelect(this);parent.main.location='/activator/jsf/umm/password.jsf';">
        <%=changePasswd%>
        </td>
      </tr>
<%
      }
      if ((isAdmin || isTeamAdmin) && (!isSSOUser)) {
%>
      <tr>
        <td title="<%=displayUMM%>" class="menuUnselected" style="vertical-align:middle;" onMouseOver="highlightMenu(this);"
            onMouseOut="unhighlightMenu(this);" onclick="menuSelect(this);UMMMenu();">
        <img src="/activator/images/collapsed.gif" id="umm_img" class="menuImage"><span style="position:relative; top:-1px;">&nbsp;<%=userManagement%></span>
        </td>
      </tr>
      <tr>
        <td>
        <div id="UMMMenu" class="UMMMenuItems">
        <table style="width:120px">
          <tr>
            <td class="menuUnselected" style="width:100%" onMouseOver="highlightMenu(this);" onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);parent.main.location='/activator/jsf/umm/umm.jsf'">
            &nbsp;<%=userManagement%></td>
          </tr>
<%
        if (isAdmin) {
%>
          <tr>
            <td class="menuUnselected" onMouseOver="highlightMenu(this);" onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);parent.main.location='/activator/jsf/umm/umm.jsf?add_role=true';">&nbsp;<%=addRole%></td>
          </tr>
<%
        }
        if ((hasDBAuth) && (isAdmin || isTeamAdmin)) {
%>
          <tr>
            <td class="menuUnselected" onMouseOver="highlightMenu(this);" onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);parent.main.location='/activator/jsf/umm/umm.jsf?add_user=true';">&nbsp;<%=addUser%></td>
          </tr>
<%
        }
        if ((hasDBAuth) && (isAdmin)) {
          if (hasTeam) {
%>
          <tr>
            <td class="menuUnselected" onMouseOver="highlightMenu(this);" onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);parent.main.location='/activator/jsf/umm/umm.jsf?add_team=true';">&nbsp;<%=addTeam%></td>
          </tr>
<%
          }
%>
          <tr>
            <td class="menuUnselected" onMouseOver="highlightMenu(this);" onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);parent.main.location='/activator/jsf/umm/unpassword.jsf?add_upwd=true';">&nbsp;<%=createPassword%></td>
          </tr>
          <tr>
            <td class="menuUnselected" onMouseOver="highlightMenu(this);" onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);parent.main.location='/activator/jsf/umm/unpassword.jsf';">&nbsp;<%=maintainPassword%></td>
          </tr>
<%
        }
%>
        </table>
        </div>
        </td>
      </tr>
<%
      }
    }
    if (isAdmin) {
%>
      <tr>
        <td title="<%=selfMonitor%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
          onMouseOut="unhighlightMenu(this);" onclick="menuSelect(this);clearMessageLine();showHideMenu('selfMonitorMenu','syscon_img');">
        <img src="/activator/images/collapsed.gif" id="syscon_img" class="menuImage"><span style="position:relative; top:-1px;">&nbsp;<%=selfMonitor%></span>
        </td>
      </tr>
      <tr>
        <td>
        <div id="selfMonitorMenu" class="invMenuItems" style="visibility:hidden; display:none;">
        <table style="width:120px;">
          <tr>
            <td title="<%=openConsole%>" style="width:100%" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onclick="menuSelect(this);parent.main.location='/activator/jsf/selfmonitor/console.jsf';"><%=openConsole%></td>
          </tr>
          <tr>
            <td title="<%=threadDump%>" style="width:100%" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onclick="menuSelect(this);parent.main.location='/activator/jsf/selfmonitor/threaddump.jsf';"><%=threadDump%></td>
          </tr>
        </table>
        </div>
        </td>
      </tr>
      <tr>
        <td title="<%=poolManagement%>" class="menuUnselected" style="vertical-align:middle;" onMouseOver="highlightMenu(this);"
          onMouseOut="unhighlightMenu(this);" onclick="menuSelect(this);clearMessageLine();showHideMenu('poolMenu','pool_img');">
        <img src="/activator/images/collapsed.gif" id="pool_img" class="menuImage"><span style="position:relative; top:-1px;">&nbsp;<%=poolManagement%></span>
        </td>
      </tr>
      <tr>
        <td>
        <div id="poolMenu" class="invMenuItems" style="visibility:hidden; display:none;">
        <table style="width:120px">
          <tr>
            <td title="<%=listPools%>" style="width:100%" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onclick="menuSelect(this);parent.main.location='/activator/jsf/resmgr/pools/lazypoollist.jsf';"><%=listPools%></td>
          </tr>
          <tr>
            <td class="menuUnselected" onMouseOver="highlightMenu(this);" onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);openPool();"><%=addPool%></td>
          </tr>
        </table>
        </div>
        </td>
      </tr>
      <tr>
        <td title="<%=queueManagement%>" class="menuUnselected" style="vertical-align:middle;" onMouseOver="highlightMenu(this);"
          onMouseOut="unhighlightMenu(this);" onclick="menuSelect(this);clearMessageLine();showHideMenu('queueMenu','queue_img');">
        <img src="/activator/images/collapsed.gif" id="queue_img" class="menuImage"><span style="position:relative; top:-1px;">&nbsp;<%=queueManagement%></span>
        </td>
      </tr>
      <tr>
        <td>
        <div id="queueMenu" class="invMenuItems" style="visibility:hidden; display:none;">
        <table style="width:120px">
          <tr>
            <td title="<%=listQueues%>" style="width:100%" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onclick="menuSelect(this);parent.main.location='/activator/jsf/wfmqueues/queues.jsf';"><%=listQueues%></td>
          </tr>
          <tr>
            <td class="menuUnselected" onMouseOver="highlightMenu(this);" onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);parent.main.location='/activator/jsf/wfmqueues/queues.jsf?create=true';"><%=addQueue%></td>
          </tr>
        </table>
        </div>
        </td>
      </tr>
<%
    }
%>
      <!--  CleanUp -->
<%
    if (isAdmin == true) {
%>
      <tr>
        <td title="<%=cleanup%>" class="menuUnselected" style="vertical-align:middle;" onMouseOver="highlightMenu(this);"
          onMouseOut="unhighlightMenu(this);" onclick="menuSelect(this);clearMessageLine();showHideMenu('cleanupMenu','cleanup_img');">
        <img src="/activator/images/collapsed.gif" id="cleanup_img" class="menuImage"><span style="position:relative; top:-1px;">&nbsp;<%=cleanup%></span>
        </td>
      </tr>
      <tr>
        <td>
        <div id="cleanupMenu" class="invMenuItems">
        <table style="width:120px">
          <tr>
            <td title="<%=cleanupMsgs%>" style="width:100%" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onclick="menuSelect(this);confirmDeleteMessage('<%=confirmMsg%>','<%=cancelMsg%>');"><%=cleanupMsgs%></td>
          </tr>
          <tr>
            <td title="<%=cleanupLogMsgs%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);" onclick="menuSelect(this);popupClnLogsFilter();"><%=cleanupLogMsgs%></td>
          </tr>
          <tr>
            <td title="<%=cleanupAuditMsgs%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onclick="menuSelect(this);clearMessageLine();popupClnFilter();"><%=cleanupAuditMsgs%></td>
          </tr>
          <tr>
            <td title="<%=cleanupStatisInfo%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);popupStatisticCln();"><%=cleanupStatisInfo%></td>
          </tr>
          <tr>
            <td title="<%=cleanupDatabaseMessages%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);popupDatabaseMessageCln();"><%=cleanupDatabaseMessages%></td>
          </tr>
        </table>
        </div>
        </td>
      </tr>
      <!--  Reload -->
      <tr>
        <td title="<%=reload%>" class="menuUnselected" style="vertical-align:middle;" onMouseOver="highlightMenu(this);"
          onMouseOut="unhighlightMenu(this);" onclick="menuSelect(this);clearMessageLine();showHideMenu('reloadMenu','reload_img');">
        <img src="/activator/images/collapsed.gif" id="reload_img" class="menuImage"><span style="position:relative; top:-1px;">&nbsp;<%=reload%></span>
        </td>
      </tr>
      <tr>
        <td>
        <div id="reloadMenu" class="invMenuItems">
        <table style="width:120px;">
          <tr>
            <td title="<%=reloadCfg%>" style="width:100%" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onclick="menuSelect(this);top.messageLine.location.href='saAdminTools.jsp?action=reloadConfiguration';">
            <%=reloadConfiguration%></td>
          </tr>
          <tr>
            <td title="<%=reloadWF%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onclick="menuSelect(this);clearMessageLine();top.messageLine.location.href='saAdminTools.jsp?action=reloadWorkflows';">
            <%=reloadWorkflows%></td>
          </tr>
          <tr>
            <td title="<%=reloadQs%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onclick="menuSelect(this);clearMessageLine();top.messageLine.location.href='saAdminTools.jsp?action=reloadQueues';">
            <%=reloadQueues%></td>
          </tr>
        </table>
        </div>
        </td>
      </tr>
      <!-- Statistics -->
      <tr>
        <td title="<%=statistic%>" class="menuUnselected" style="vertical-align:middle;" onMouseOver="highlightMenu(this);"
          onMouseOut="unhighlightMenu(this);" onclick="menuSelect(this);clearMessageLine();showHideMenu('statisticMenu','stat_img');">
        <img src="/activator/images/collapsed.gif" id="stat_img" class="menuImage"><span style="position:relative; top:-1px;">&nbsp;<%=statistic%></span>
        </td>
      </tr>
      <tr>
        <td>
        <div id="statisticMenu" class="invMenuItems">
        <table style="width:120px">
          <tr>
            <td title="<%=operatorView%>" style="width:100%" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);popupOperatorFilter();"><%=operatorView%></td>
          </tr>
          <tr>
            <td title="<%=administratorView%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);popupAdministratorFilter();"><%=administratorView%></td>
          </tr>
        </table>
        </div>
        </td>
      </tr>
      <!-- Distribution-->
      <tr>
        <td title="<%=distribution%>" class="menuUnselected" style="vertical-align:middle;" onMouseOver="highlightMenu(this);"
            onMouseOut="unhighlightMenu(this);" onclick="menuSelect(this);clearMessageLine();showHideMenu('distributionMenu','dist_img');">
        <img src="/activator/images/collapsed.gif" id="dist_img" class="menuImage"><span style="position:relative; top:-1px;">&nbsp;<%=distribution%></span>
        </td>
      </tr>
      <tr>
        <td>
        <div id="distributionMenu" class="invMenuItems">
        <table style="width:120px">
          <tr>
            <td title="<%=statusInformation%>" style="width:100%" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);" onClick="menuSelect(this);clearMessageLine();nodeView();">
            <%=statusInformation%></td>
          </tr>
          <tr>
            <td title="<%=masterSlaves%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onClick="menuSelect(this);clearMessageLine();parent.main.location='saCreateFrame.jsp?jsp=saMasterSlaves.jsp';">
            <%=masterSlaves%></td>
          </tr>
        </table>
        </div>
        </td>
      </tr>
      <!-- Export -->
      <tr>
        <td title="<%=export%>" class="menuUnselected" style="vertical-align:middle;" onMouseOver="highlightMenu(this);"
          onMouseOut="unhighlightMenu(this);" onclick="menuSelect(this);clearMessageLine();showHideMenu('exportMenu','export_img');">
        <img src="/activator/images/collapsed.gif" id="export_img" class="menuImage"><span style="position:relative; top:-1px;">&nbsp;<%=export%></span>
        </td>
      </tr>
      <tr>
        <td>
        <div id="exportMenu" class="invMenuItems">
        <table style="width:120px">
          <tr>
            <td title="<%=operatorExport%>" style="width:100%" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);popupExport('operator');"><%=operatorExport%></td>
          </tr>
          <tr>
            <td title="<%=administratorExport%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);popupExport('admin');"><%=administratorExport%></td>
          </tr>
          <tr>
            <td title="<%=messagesExport%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);popupMessagesExport('messages');"><%=messagesExport%></td>
          </tr>
          <tr>
            <td title="<%=auditMessagesExport%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
              onMouseOut="unhighlightMenu(this);"
              onClick="clearMessageLine();menuSelect(this);popupAuditMessagesExport('auditMessages');">
            <%=auditMessagesExport%></td>
          </tr>
        </table>
        </div>
        </td>
      </tr>
      <tr>
        <td class="menuUnselected" style="width:100%" onMouseOver="highlightMenu(this);" onMouseOut="unhighlightMenu(this);"
          onClick="clearMessageLine();menuSelect(this);parent.main.location='/activator/jsf/licenseView/saViewLicense.jsf'">
        &nbsp;<%=viewLicense%></td>
      </tr>
      <tr>
        <td class="menuUnselected" style="width:100%" onMouseOver="highlightMenu(this);" onMouseOut="unhighlightMenu(this);"
          onClick="clearMessageLine();menuSelect(this);parent.main.location='/activator/jsf/licenseView/payg.jsf'">
        &nbsp;<%=paygLicense%></td>
      </tr>
<%
    if (((Boolean)session.getAttribute(Constants.MWFM_TESTS)).booleanValue() == true) {
%>
      <tr>
        <td>
        <hr style="width:96%">
        </td>
      </tr>
      <tr>
        <td title="<%=displayTest%>" class="menuUnselected" onMouseOver="highlightMenu(this);"
          onMouseOut="unhighlightMenu(this);"
          onclick="menuSelect(this);clearMessageLine();parent.main.location='saCreateFrame.jsp?jsp=tests/saShowTests.jsp';">
        <%=test%></td>
      </tr>
<%
    }
%>
    </table>
    </div>
<%
  }
}
 %>
    </td>
  </tr>
</table>
</body>
</html>
