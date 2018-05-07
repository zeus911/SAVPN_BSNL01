<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,java.text.DateFormat,java.util.Date,java.net.*"
info="Display all messages." session="true"
contentType="text/html; charset=UTF-8" language="java"%>

<%
// Check if there is a valid session available.
if (session == null || session.getAttribute(Constants.USER) == null) 
{
%>
<script>
window.top.topFrame.location = window.top.topFrame.location;
</script>
<%
return;
}

request.setCharacterEncoding("UTF-8");

// don't cache the page
response.setDateHeader("Expires", 0);
response.setHeader("Pragma", "no-cache");
String SESSION_TAB_PAGE = "session_tab_name_";

int tabSelected = -1;
%>

<%!//I18N strings
final static String noMessages = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("151", "No messages available.");
final static String errMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("152", "Unable to retrieve messages from the micro-workflow engine.");
final static String invalidGoToEntry = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("635", "Please enter a record num between 1 and ");

final static String message = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("140", "Messages");
final static String results = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("288", "Results ");

final static String SESSION_MSG_QUEUE = "msg_queue_saMsgQueues.jsp";

final static String prevPageLink = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("728", "&lt;Prev");
final static String nextPageLink = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("729", "Next&gt;");
final static String firstPageLabel = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("640", "&lt;&lt;");
final static String lastPageLabel = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("641", "&gt;&gt;");
final static String gotoLabel = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("642", "Go");

final static String prevPageTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("643", "Show Previous Page");
final static String nextPageTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("644", "Show Next Page");
final static String firstPageTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("645", "Show First Page");
final static String lastPageTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("646", "Show Last Page");
final static String gotoTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("647", " Go To Any Record Number");%>
<html>
<head>
<base target="_top">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css"
href="/activator/css/activator.css">
<link rel="stylesheet" type="text/css" href="/activator/css/saTabs.css">
<script language="JavaScript" src="/activator/javascript/table.js"></script>
<script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
<script language="JavaScript" src="/activator/javascript/saNavigation.js"></script>
</head>

<body onload="scrollToTab()" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">

<table cellpadding="0" cellspacing="0" >
<div>
<tr align=left>
<td nowrap align=center class="frameHead"><%=message%></td>
</tr>
</div>
<%
String SESSION_TAB_GOTO = "session_tab_goto_";
String gotoValue = "";
try 
{
// get all data from queues - these are the messages the user has permission to interact with
WFManager wfm = (WFManager)session.getAttribute(Constants.MWFM_SESSION);
String[] availQueues = wfm.listMessageQueues();
// see if we have data to display
if (availQueues == null || availQueues.length == 0) 
{
%>
<SCRIPT LANGUAGE="JavaScript">
writeToMsgLine("<%=noMessages%>");
</SCRIPT>
<%
} else 
{
String selectedQueue = (String)session.getAttribute(SESSION_MSG_QUEUE);  
if (selectedQueue == null)
{
try 
{
selectedQueue = availQueues[0];
}catch (ArrayIndexOutOfBoundsException e) 
{
//no queues available
}
} else 
{
//Check if queue is still exist
boolean found = false;
for (int i = 0; i < availQueues.length; i++) 
{
if (availQueues[i].equals(selectedQueue)) 
{
found = true;
break;
}
}
if (!found) 
{
selectedQueue = availQueues[0];
}
}
%>
<table border="0" cellpadding="1" cellspacing="0" id="resultTable">
<tr id="toprow">
<%
// Display tabs for all queues with messages assigned
if (availQueues != null) 
{
for (int i = 0; i < availQueues.length; i++) 
{
String encQueueName = URLEncoder.encode(availQueues[i], "UTF-8");
if (selectedQueue.equals(availQueues[i])) 
{
tabSelected = i;
}
SESSION_TAB_GOTO = "session_tab_goto_";
SESSION_TAB_GOTO = SESSION_TAB_GOTO + encQueueName ;

if (session.getAttribute(SESSION_TAB_GOTO) != null){
  gotoValue = (String)session.getAttribute(SESSION_TAB_GOTO);
}

%>


<td id="tab<%=i%>" class="<%=tabSelected == i ? "tabSelected" : "tabUnSelected"%>"nowrap onMouseOver="highlightTab(this);"
onMouseOut="unHighlightTab(this);"onClick="unselectTabs(<%=availQueues.length%>);selectTab(this);
 parent.msgDisplayFrame.location = 'saShowMsgs.jsp?page=<%=(String)session.getAttribute(SESSION_TAB_PAGE+encQueueName)%>&displayQueue=<%=encQueueName%>';">
<%=availQueues[i]%>
</td>

<td width="1" bgcolor="#ffffff"><img width="1" height="1" alt=""></td>
<%
}
}
%>

<table border="0" cellpadding="0" cellspacing="0" width="100%"
class="bottomTab">
<tr>
<td class="bottomTab" nowrap align="right" >
<table border="0" cellpadding="0" cellspacing="0" >
<tr>
<td align="right" nowrap class="bottomTabLink" onclick="first()"   id="firstPageLink"
title="<%=firstPageTitle%>">&nbsp;&nbsp;<%=firstPageLabel%>
</td>

<td>&nbsp;&nbsp;</td>
<td align="right" nowrap class="bottomTabLink" onclick="prev()"      id="prevLink"
title="<%=prevPageTitle%>">&nbsp;&nbsp;<%=prevPageLink%>
</td>

<td>&nbsp;&nbsp;</td>
<td align="right" class="bottomTab" nowrap>&nbsp;<span id="resultCnt"></span>
</td>

<td>&nbsp;&nbsp;</td>
<td align="right" nowrap class="bottomTabLink" onclick="next()"  id="nextLink"
title="<%=nextPageTitle%>">&nbsp;&nbsp;<%=nextPageLink%>
</td>

<td>&nbsp;&nbsp;</td>
<td align="right" nowrap class="bottomTabLink" onclick="last()"  id="lastPageLink"
title="<%=lastPageTitle%>">&nbsp;&nbsp;<%=lastPageLabel%>
</td>
<td>&nbsp;&nbsp;</td>
<%
if ("".equalsIgnoreCase(gotoValue) ) {
%>
<td align="right" nowrap> 
<Input type ="text" id="gotoTxtBox" size = "6" class = "bottomTabTxtBox"  title="<%=gotoTitle%>">
</td>
<% } else {%>
<td align="right" nowrap> 
<Input type ="text" id="gotoTxtBox" size = "6" value ="<%=gotoValue%>"class = "bottomTabTxtBox"  title="<%=gotoTitle%>">
</td>
<%}%>
<td>&nbsp;&nbsp;</td>
<td align="right" nowrap class="bottomTabLink" onclick="submitPage()"  id="gotoLink"
title="<%=gotoTitle%>">&nbsp;&nbsp;<%=gotoLabel%>
</td>
<td>&nbsp;&nbsp;</td>
</tr>
</table>
</td>
</tr>
</table>
<%
// If we are initiated from the menu, then restore previously displayed queue
String menuInit = (String)request.getParameter("menuInit");
if (menuInit == null) 
{
String encQueueName = URLEncoder.encode(selectedQueue, "UTF-8");
%>
<script>
parent.msgDisplayFrame.location = 'saShowMsgs.jsp?page=<%=(String)session.getAttribute(SESSION_TAB_PAGE+encQueueName)%>&displayQueue=<%=encQueueName%>';
</script>
<%
}

} // end of processing queues

} // end of try
catch (Exception e) 
{
 String err = null;
            if (e.getMessage() != null) {
                String tmp = e.getMessage().replace('\n',' ');
                err = tmp.replace('"',' ');
            }
            else
                err = e.toString().replace('\n',' ');
%>
<SCRIPT LANGUAGE="JavaScript"> 
alert("HP Service Activator" + "\n\n" + "<%=errMsg%> :  <%=err%>");
</SCRIPT>
<%
} // end of catch
%> 

</table>

</table>
<SCRIPT LANGUAGE="JavaScript">

function scrollToTab()
{ 
<% 
if(tabSelected>0)
{ 
%>
var selTab = document.getElementById("tab<%=tabSelected%>");
var resultTable = document.getElementById("resultTable");
var divToScroll = document.body;
if(selTab != null)
{
if(document.all)
{
divToScroll.scrollLeft=(selTab.offsetLeft+selTab.offsetWidth) - document.body.clientWidth + 9 ;
} else 
{
divToScroll.scrollLeft=(selTab.offsetLeft+selTab.offsetWidth) - self.innerWidth + 9;
}
}
<% 
}
%>
}

var nextLink = document.getElementById('nextLink');
var prevLink = document.getElementById('prevLink');
var firstPageLink = document.getElementById('firstPageLink');
var lastPageLink = document.getElementById('lastPageLink');
var gotoLink = document.getElementById('gotoLink');
var gotoTxtBox = document.getElementById('gotoTxtBox');
var nextPage ;  
var prevPage ;
var firstpage;
var lastPage; 
var goto ; 
var totalNoOfMessages;
function navigationFunctionality(queueName, pageNm, maxRec, totalNumberOfPages,totalNumberOfMessages)
{  

prevLink.className = 'bottomTabLink';
nextLink.className = 'bottomTabLink';
gotoLink.className = 'bottomTabLink';
firstPageLink.className = 'bottomTabLink';
lastPageLink.className = 'bottomTabLink';
gotoTxtBox.className = 'bottomTabTxtBox';
gotoTxtBox.disabled = false;

var result   = document.getElementById('resultCnt').innerHTML;
var fromCount = result.substring(0,result.indexOf('-'));
var endCount = result.substring(result.indexOf('-')+1,result.indexOf('/'));
var maxNumber = maxRec * 1;

totalNoOfMessages = totalNumberOfMessages * 1;
var remainder = totalNoOfMessages % maxRec ;
    if (remainder < 1){
      remainder = maxRec;
    }
   
    
var lastPageStartRec = totalNoOfMessages - remainder + 1 ;

var endCountNumber = endCount * 1;
var fromCountNumber = fromCount * 1;
var numberOfRecords = (endCountNumber - fromCountNumber) + 1;

if(totalNoOfMessages > 0){
goto = 'saShowMsgs.jsp?displayQueue='+queueName ;
}
else {
gotoLink.className = 'bottomTabLinkDisabled';
gotoTxtBox.disabled=true;
goto = '#';
}

var nextPageStartRec = endCountNumber + 1;
// 2nd and 3rd condition check is the solution for the gnat 12737
if(numberOfRecords == maxNumber && totalNoOfMessages > maxNumber && totalNoOfMessages > endCountNumber)
{
var pageNumber = pageNm *1;
pageNumber = pageNumber +1;
lastPage = 'saShowMsgs.jsp?page='+ totalNumberOfPages +'&displayQueue='+queueName+'&recStart='+lastPageStartRec ;
if(nextPageStartRec < totalNoOfMessages){
nextPage = 'saShowMsgs.jsp?displayQueue='+queueName+'&recStart='+nextPageStartRec ;
} 
else {
nextPage = lastPage;
}

}
else 
{
nextLink.className = 'bottomTabLinkDisabled';
nextPage = '#';
lastPageLink.className = 'bottomTabLinkDisabled';
lastPage = '#';
}

var temp = fromCountNumber - maxNumber;

var pageNumber = pageNm * 1;  
      
if(fromCountNumber > 1)
{
  firstPage = 'saShowMsgs.jsp?page=0&displayQueue='+queueName+'&recStart=1' ;
  if(temp > 0){
  
  
  prevPage =  'saShowMsgs.jsp?displayQueue='+queueName+'&recStart='+temp;
  }else{
  prevPage = firstPage;
  }

}
else
{
prevLink.className = 'bottomTabLinkDisabled';
prevPage = '#';
firstPageLink.className = 'bottomTabLinkDisabled';
firstPage = '#';
}



}

function next()
{

if (nextPage == "#"){
return false;
}
writeToMsgLine("<%="][Retrieving Message data, please wait...."%>");
parent.msgDisplayFrame.location.href=nextPage;
}



function prev()
{

if (prevPage == "#"){
return false;
}
writeToMsgLine("<%="][Retrieving Message data, please wait...."%>");
parent.msgDisplayFrame.location.href=prevPage;
}

function last()
{

if (lastPage == "#"){
return false;
}
writeToMsgLine("<%="][Retrieving Message data, please wait...."%>");
parent.msgDisplayFrame.location.href=lastPage;
}

function first()
{

if (firstPage == "#"){
return false;
}
writeToMsgLine("<%="][Retrieving Message data, please wait...."%>");
parent.msgDisplayFrame.location.href=firstPage;
}
function gotoPage(recStartVar){

if (goto == '#'){
  return false;
} 
recStartVar = recStartVar * 1;
var gotoRedirect = goto+'&recStart='+recStartVar+'&goto=true';

if(recStartVar > totalNoOfMessages || recStartVar < 1 )
{
alert( '<%=invalidGoToEntry%>' + totalNoOfMessages);
return false;
}else {
 parent.msgDisplayFrame.location.href=gotoRedirect;
} 
}
function submitPage(){
var recStart = document.getElementById('gotoTxtBox').value;
var isNumber = IsNumeric(recStart);

if (isNumber == false){
recStart = '0';
}
recStartValue = recStart *1;

gotoPage(recStartValue);
}  


function IsNumeric(sText)

{ 
   var ValidChars = "0123456789";
   var IsNumber=true;
   var Char;

 
   for (i = 0; i < sText.length && IsNumber == true; i++) 
      { 
      Char = sText.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
         {
         IsNumber = false;
         }
      }
   return IsNumber;
   
   }
</SCRIPT>
</body>
</html>
