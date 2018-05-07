<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page import="com.hp.ov.activator.mwfm.*,
                 com.hp.ov.activator.mwfm.servlet.*,
                 com.hp.ov.activator.utils.*,
                 com.hp.ov.activator.audit.*,
                 com.hp.ov.activator.mwfm.component.*,
                 com.hp.ov.activator.util.LogFileInfo,
                 com.hp.ov.activator.util.LogFileFilterInfo,
                 com.hp.ov.activator.mwfm.engine.module.ClusterNodeBean,
                 java.io.*,
                 java.util.*,
                 java.net.*,
                 java.util.regex.*"
         info="Display all active jobs."
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
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

request.setCharacterEncoding ("UTF-8");
WFManager wfm = (WFManager)session.getAttribute(Constants.MWFM_SESSION);
Vector<ClusterNodeBean> vct=wfm.getPrimaryClusterNodes();
String[] hostNames = new String[vct.size()];
for (int i = 0 ; i < vct.size() ; i++ ) {
   hostNames[i] = ((ClusterNodeBean) vct.get(i)).getHostName();
}
String nodeName = "";
String filterName = "";
String tabNameParam = (String)request.getParameter ("tab");
String SESSION_LOG_FILE = "tab_in_saLogFiles.jsp_";
boolean removeSessionAttribute = false;
String exceptionMessage = "" ;
if (session.getAttribute("EXCEPTION_MESSAGE") != null) {
   exceptionMessage = (String)session.getAttribute("EXCEPTION_MESSAGE");
}
if(session.getAttribute("NODE_NAME") != null && !"".equals((String)session.getAttribute("NODE_NAME"))) {
   nodeName = (String)session.getAttribute("NODE_NAME");
}
if(request.getParameter("nodeName")!=null && !"".equals((String) request.getParameter("nodeName"))){
   nodeName = (String)request.getParameter("nodeName");
}
if(session.getAttribute("FILTER_NAME") != null && !"".equals((String)session.getAttribute("FILTER_NAME"))) {
   filterName = (String)session.getAttribute("FILTER_NAME");
}
if(request.getParameter("filterName")!=null && !"".equals((String) request.getParameter("filterName"))){
   filterName = (String)request.getParameter("filterName");
}
if ("".equalsIgnoreCase(nodeName)){
   try {
      nodeName = wfm.getHostName();
   } catch (Exception exc) {
%>
<script>alert("<%= ExceptionHandler.handle(exc) %>");</script>
<%
   }
}
SESSION_LOG_FILE = SESSION_LOG_FILE + nodeName +"_";
session.setAttribute("NODE_NAME",nodeName);
session.setAttribute("FILTER_NAME",filterName);
LogFileFilterInfo[] filterList = null;
try {
   filterList = wfm.getLogFilterList(nodeName);
} catch (com.hp.ov.activator.mwfm.component.WFLogException e) {
   filterList = null;
}
%>

<%!
//I18N strings
final static String noLogs  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("319", "No logs available.");
final static String logs    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("139", "Logs");
final static String SYSTEM_TAB = "SYSTEM";
final static String hostName = "Hostname";
final static String hostNameTitle = "Hostname ";
final static String logFilter = "Filter";
final static String logFilterTitle = "Filter";
final static String SESSION_TAB = "tab_in_saLogTabs.jsp";
%>

<html>
<head>
   <base target="_top">
   <meta http-equiv="content-type" content="text/html; charset=utf-8">
   <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
   <link rel="stylesheet" type="text/css" href="/activator/css/saTabs.css">
   <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
   <script language="JavaScript" src="/activator/javascript/saNavigation.js"></script>
   <script language="JavaScript">
   //set the current tab name on load
   function setCurrentTab(tabName) {
      if(tabName!="null") {
         top.leftFrame.setCurrentTab(tabName);
      }
   }
   // set the current tab on click of a tab
   function doTabClick(tabName) {
      top.leftFrame.setCurrentTab(tabName);
   }
   </script>
</head>

<body onLoad="setCurrentTab('<%=tabNameParam%>')" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<form name="InputForm">
<table cellpadding="0" cellspacing="0" width="100%">
   <div>
      <tr align=left width="100%">
<%
if(!"".equals(exceptionMessage) ){
   session.removeAttribute("EXCEPTION_MESSAGE");
%>
      <td nowrap align=center class="error"><%=exceptionMessage%> </td>
<%
} else {
%>
      <td nowrap align=center class="frameHead"><%=logs%></td>
<%
}
%>
      <td nowrap="nowrap" align="right" class = "filterTextTd" width="20%" title="<%=logFilterTitle%>"><%=logFilter%>:
      <select name="filterName" onchange="hostFilter()">
<%
if (filterList != null) {
   for (int j = 0; j < filterList.length ; j++) {
      LogFileFilterInfo filterInfo = (LogFileFilterInfo)filterList[j];
      if(filterName.equalsIgnoreCase(filterInfo.getFilterFilePath())){
%>
      <option value="<%=filterInfo.getFilterFilePath()%>" selected = "selected"><%=filterInfo.getFilterName()%></option>
<%
      } else {
%>
      <option value="<%=filterInfo.getFilterFilePath()%>" ><%=filterInfo.getFilterName()%></option>
<%
      }
   }
}
%>
      </select>
      </td>
      <td nowrap="nowrap" align="right" class = "filterTextTd" width="20%" title="<%=hostNameTitle%>"><%=hostName%>:
      <select name="hostName" onchange="hostFilter()">
<%
for (int j = 0; j < hostNames.length; j++) {
   if(nodeName.equalsIgnoreCase((String)hostNames[j])){
%>
      <option value="<%=hostNames[j]%>" selected = "selected"><%=hostNames[j]%></option>
<%
   } else {
%>
      <option value="<%=hostNames[j]%>" ><%=hostNames[j]%></option>
<%
   }
}
%>
      </select>
      </td>
      </tr>
   </div>
</table>
<%
String currentTab = SYSTEM_TAB;
String fileName ="" ;
try {
   //Geting available tabs
   HashSet<String> tabList = new HashSet<String>();
   //tab SYSTEM is always available
   LogFileInfo [] fullArray = wfm.getLogFilesInfo(nodeName);
   session.setAttribute("FILE_ARRAY",fullArray);
   Pattern p = Pattern.compile(".*.log\\.xml");
   Matcher m = null;
   for (int i = 0; i < fullArray.length; i++ ) {
      fileName = fullArray[i].getFileName();
      m = p.matcher(fileName);
      // only select the log if the file name contains pattern: "*.log.xml"
      if (m.matches()) {
         tabList.add(fileName.substring(0, fileName.indexOf('_')).toUpperCase());
      }
   }
   tabList.add(SYSTEM_TAB);
   //seting up current tab
   if (tabNameParam != null && !tabNameParam.equals("")){
      currentTab = tabNameParam;
      session.setAttribute(SESSION_TAB,currentTab);
   } else {
      currentTab = (String)session.getAttribute(SESSION_TAB);
      if (currentTab == null || !tabList.contains(currentTab)){
         currentTab = SYSTEM_TAB;
      }
   }
      
%>
<table border=0 cellpadding="1" cellspacing="0" >
   <tr id="toprow">
<%
   //this variable needed for file selection frame update
   String javaScript = "";
   Iterator iter = tabList.iterator();
   int i=0;
   while(iter.hasNext()){
      String tabName = (String)iter.next();
      boolean tabSelected = tabName.equalsIgnoreCase(currentTab);
      if (tabSelected){
         javaScript = "parent.parent.parent.messageLine.location='saLogFiles.jsp?tab="+tabName+"';"+
                      "setSelectedTab(document.getElementById('tab"+i+"'))";
      }
%>
   <td id="tab<%=i%>" class=<%=tabSelected ? "tabSelected" : "tabUnSelected"%> nowrap
       onMouseOver="highlightTab(this);"
       onMouseOut="unHighlightTab(this);"
       onClick="doTabClick('<%=tabName%>');selectTab(this);parent.parent.parent.messageLine.location='saLogFiles.jsp?tab=<%=tabName%>';
                parent.logDisplayFrame.location='/activator/blank.html'"
   ><%=tabName%></td>
   <td width=1 bgcolor=#ffffff><img width=1 height=1 src="/activator/images/1x1.gif" alt=""></td>
<%
      i++;
   }
%>
   </tr>
</table>
<script>
<%=javaScript%>
function hostFilter(){
   var hostNodeName = document.InputForm.hostName.value;
   var filterName = document.InputForm.filterName.value;
   document.location='saLogTabs.jsp?nodeName='+hostNodeName+'&filterName='+filterName;
}
</script>
<table border=0 cellpadding=1 cellspacing=2 width="100%" class=bottomTab>
   <tr>
   <td class=bottomTab nowrap>
   <table border=0 cellpadding=1 cellspacing=0 width="100%">
      <tr>
      <td align=right class=bottomTab nowrap>&nbsp;</td>
      </tr>
   </table>
   </td>
   </tr>
</table>
<%
} // end of try
catch (WFLogException WFLoge) {
   session.setAttribute("EXCEPTION_MESSAGE",WFLoge.getMessage());
   session.removeAttribute("NODE_NAME");
%>
<script>
top.main.location.href = 'saLogFrame.jsp';
</script>
<%
}
catch (Exception e) {
%>
<script>alert("<%= ExceptionHandler.handle(e) %>");</script>
<%
}
%>
</body>
</html>
