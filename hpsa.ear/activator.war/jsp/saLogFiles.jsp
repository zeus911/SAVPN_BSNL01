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
                 com.hp.ov.activator.util.LogFileInfo,
                 java.io.*,
                 java.util.*,
                 java.text.*,
                 java.util.regex.*"
         info="Display all log for specific tab." 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<html>
<head>
    <base target="_top">
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="/activator/css/saLogFiles.css">
    <script language="JavaScript" src="/activator/javascript/saNavigation.js"></script>
    <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
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

WFManager wfm = (WFManager)session.getAttribute(Constants.MWFM_SESSION);
boolean currentFileExists = false;
request.setCharacterEncoding ("UTF-8");
// don't cache the page
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");
String DEFAULT_LOG_FILE = "";
String SESSION_TAB = "tab_in_saLogTabs.jsp";
String tabName = (String)request.getParameter ("tab");
session.setAttribute(SESSION_TAB,tabName);
String nodeName = (String)session.getAttribute("NODE_NAME");
String SESSION_LOG_FILE = "tab_in_saLogFiles.jsp_"+nodeName+"_"+tabName;
String LOG_FILE_MESSAGE_NO = "LOG_FILE_MSG_NO";
String fileNameParam = (String)request.getParameter ("file");
String currentFile = "";
String patternString =".*.log\\.xml";
LogFileInfo[] logAllFiles = null;
LogFileInfo[] logFiles = null;
Vector<LogFileInfo> logFilesTemp = new Vector<LogFileInfo>();
int logFileCount=0;

if (tabName != null) {
   tabName = tabName.toLowerCase();
}
int messageNo = -1;
if (session.getAttribute(LOG_FILE_MESSAGE_NO) != null) {
  messageNo = (Integer)session.getAttribute(LOG_FILE_MESSAGE_NO);
  session.removeAttribute(LOG_FILE_MESSAGE_NO);
}
if(session.getAttribute("FILE_ARRAY")!=null) {
   logAllFiles = (LogFileInfo[]) session.getAttribute("FILE_ARRAY");
}
if("SYSTEM".equalsIgnoreCase(tabName)){
   patternString  = ".*.stderr|.*.stdout|.*.log";
}
try {
   Pattern p = Pattern.compile(patternString,Pattern.CASE_INSENSITIVE);
   Matcher m = null;
   String logFileInLowerCase = null;
   String fileName = null;
   for (int i = 0 ; i < logAllFiles.length ; i++) {
      fileName = logAllFiles[i].getFileName();
      m = p.matcher(fileName);
      if(m.matches()){
         if("SYSTEM".equalsIgnoreCase(tabName)){
            logFilesTemp.add(logAllFiles[i]);
         } else if (fileName.contains(tabName)) {
            logFilesTemp.add(logAllFiles[i]);
         } else {
           	logFileInLowerCase = fileName.toLowerCase();
           	if (logFileInLowerCase.contains(tabName)) {
           	 	logFilesTemp.add(logAllFiles[i]);
           	}
         }
      }
   }
   logFileCount=logFilesTemp.size();
%>
   <script>
   window.onload = function() {
      //set the number of log files for the current tab
      top.leftFrame.setLogFileCount(<%=logFileCount%>);
   }
   </script>
</head>
<body class="logFileBody" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();" onload="doOnload();">
<%
   logFiles = new LogFileInfo [logFilesTemp.size()];
   for (int j = 0 ; j < logFilesTemp.size() ; j++) {
      for (int k = 0 ; k < logFilesTemp.size() ; k++) {
         logFiles[j] = (LogFileInfo) logFilesTemp.get(j);
      }
   }
   Comparator comparator = new LogFileInfoComparator();
   Arrays.sort(logFiles, comparator);
} catch (Exception e) {
%>
<script> 
alert("<%= ExceptionHandler.handle(e) %>"); 
</script>
<%
}
//seting up current file
if (fileNameParam != null && !fileNameParam.equals("")){
   currentFile = fileNameParam;
   session.setAttribute(SESSION_LOG_FILE,currentFile);
} else {
   currentFile = (String)session.getAttribute(SESSION_LOG_FILE);
   for(int i =0; i < logFiles.length ; i++){
      if((logFiles[i].getFileName()).equalsIgnoreCase(currentFile)){
         currentFileExists = true;
      }
   }
   if (currentFile == null || !currentFileExists){
      currentFile = DEFAULT_LOG_FILE;
   }
}
//total columns
int cols = 5;
//how many rows will we have?
int rows = logFiles.length / cols;
rows += logFiles.length % cols > 0 ? 1 : 0;
//starting to write table
out.println("<div class='logFileDiv' id='file_div'>");
out.println("<table class=\"logFileTable\" id=\"availableLogFiles\">");
out.println("<tr id='files_tr_id0' class='FileTr'>");
int currentCol = 0;
int currentRow = 0;
String javaScript = "";
for(int i=0; i<logFiles.length; i++){
   currentCol ++;
   boolean isSelectedFile = currentFile.equalsIgnoreCase(logFiles[i].getFileName());
   if (isSelectedFile) {
     if (messageNo < 0) {
      javaScript = "top.main.displayFrame.logDisplayFrame.location='saShowLog.jsp?name="+logFiles[i].getFileName()+"';\n"+
                   "setSelectedLogFile(document.getElementById('file"+i+"'));\n"+
                   "updateScrollBar(document.getElementById('files_tr_id"+currentRow+"'));\n";
     } else {
       String htmlAnchor = "_log_entry_no_" + messageNo + "_";
       javaScript = "top.main.displayFrame.logDisplayFrame.location='saShowLog.jsp?name="+logFiles[i].getFileName()+"#" + htmlAnchor + "';\n"+
           "setSelectedLogFile(document.getElementById('file"+i+"'));\n";
     }
   }
   if("".equalsIgnoreCase(currentFile)){
      if(!currentFileExists) {
         javaScript = "top.main.displayFrame.logDisplayFrame.location='saShowLog.jsp?name="+"blank"+"';\n"+
                      "setSelectedLogFile(document.getElementById('file"+i+"'));\n"+
                      "updateScrollBar(document.getElementById('files_tr_id"+currentRow+"'));\n";
      }
   }
   int eIndex = logFiles[i].getFileName().indexOf(".log.xml");
   String displayLogName = (eIndex==-1 ? logFiles[i].getFileName() : logFiles[i].getFileName().substring(0,eIndex));
   SimpleDateFormat sdf = new SimpleDateFormat("MMM dd,yyyy HH:mm");
   Date resultdate = new Date(logFiles[i].getLastModified());
   String timeStamp = sdf.format(resultdate);  
%>
<td id="file<%=i%>" class=<%=isSelectedFile ? "fileSelected" : "fileUnSelected"%> nowrap 
    onMouseOver="highlightLogFile(this);"
    onMouseOut="unhighlightLogFile(this);"
    onclick="top.leftFrame.setLogFile('<%=logFiles[i].getFileName()%>');top.leftFrame.resetLogPos();top.main.displayFrame.logDisplayFrame.location='saShowLog.jsp?name=<%=logFiles[i].getFileName()%>&tab=<%=tabName%>';
            activeLogFile(document.getElementById('file<%=i%>'));">
    <a href="#" title="<%=timeStamp%>" target="_self"><%=displayLogName%></a>
</td>
<%
   if (currentCol == cols){
      currentCol = 0;
      currentRow ++;
      out.println("</tr>");
      if (i-1 != logFiles.length) {
         out.println("<tr id='files_tr_id"+currentRow+"'>");
      }
   }
}
for(int i=currentCol; i<cols; i++){
   out.println("<td width=\"20%\"></td>");
}
out.println("</tr>");
out.println("</table>");
out.println("</div>");
%>
<div class="separator"/>
<script>
function doOnload() {
   if (top.main.displayFrame) {
<%=javaScript %>
   }
}
</script>
</body>
</html>
