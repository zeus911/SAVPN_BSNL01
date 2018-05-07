/**********************************************************************

   hp OpenView service activator
   (c) Copyright 2014 Hewlett-Packard Development Company, L.P.

**********************************************************************/

function promptAndInsert (serviceID, fieldName, fieldValue)
{
  clearMessageLine();
  var fieldValue = prompt (serviceID + ":  New value for field '" + fieldName + "'?", fieldValue);
  if (fieldValue != null && fieldValue.length > 0) {
    location = 'UpdateField.jsp?serviceID=' + serviceID + '&fieldName=' + 
    fieldName + '&fieldValue=' + fieldValue;
  }
}

function changeRoles(queue)
{
  var cookieName = window.menuName;
  var job = getCookie(cookieName);
  var aPosition = job.indexOf(",");
  if (aPosition > 0) {
    var rowInfoArray = new Array();
    rowInfoArray = job.split(",");
    job=rowInfoArray[0];
  }
  var url = "saChangeRoles.jsp?callState=initialize&queueName="+queue+"&jobId="+job;
  var win = window.open(url,'changeRolesWindow','resizable=no,status=yes,width=400,height=250');
  window.top.changeRolesWindow = win;
  win.focus();
  return true;
}

function isInteractWinOpen()
{
  // if win and win.open exist and win.closed isn't true -- the window is still open
  var win = window.top.interactWindow;
  return win && win.open && !win.closed;
}

function isChangeRolesWinOpen()
{
  // if win and win.open exist and win.closed isn't true -- the window is still open
  var win = window.top.changeRolesWindow;
  return win && win.open && !win.closed;
}

function clearMessageLine()
{
  var fPtr=top.messageLine.document;
  fPtr.open();
  fPtr.write("");
  fPtr.close();
}

function writeToMsgLine(msg)
{
  top.messageLine.location.href = 'saDisplayMsg.jsp?Msg=' + encodeURIComponent(msg);
}

function setResultCount(numRows, fromCount, queueName, pageNm, maxRec, totalNumberOfMessages, totalNumberOfPages) 
{
  var newText;
  var cnt ;
  if (numRows != 0) {
    cnt = fromCount + " - " + numRows + " / " + totalNumberOfMessages;
  } else {
    cnt ="0 - 0 / 0 ";  
  }
  parent.queueFrame.document.getElementById("resultCnt").innerHTML = cnt;
  parent.queueFrame.navigationFunctionality(queueName, pageNm, maxRec, totalNumberOfPages, totalNumberOfMessages);
}

function setCookie(cookieName, cookieValue)
{
  document.cookie = cookieName + "=" + cookieValue;
}

function getCookie(cookieName, cookieValue)
{
  if(document.cookie) {
    var index = document.cookie.indexOf(cookieName);
    if (index != -1) {
      var start = (document.cookie.indexOf("=", index) + 1);
      var end = document.cookie.indexOf(";", index);
      if (end == -1) {
        end = document.cookie.length;
      }
      return document.cookie.substring(start, end);
    }
  }
  // cookie not found
  return null;
}

// Confirm that the user wants to cancel the selected running job
function stopJobConfirm( stopMsg, cancelMsg, reselectMsg, useForce)
{
  var jobToStop = getCookie(window.menuName);
  var aPosition = jobToStop.indexOf(",");
  if(aPosition>0){
    var rowInfoArray = new Array();
    rowInfoArray = jobToStop.split(",");
    jobToStop=rowInfoArray[0];
  }
  if (jobToStop == null)  {
    writeToMsgLine(reselectMsg);
    return false;
  }
  if (confirm(stopMsg + jobToStop)) {
    top.messageLine.location.href = 'saStopJob.jsp?jobID=' + jobToStop + '&useForce=' + useForce;
    return true;
  }
  else {
    writeToMsgLine(cancelMsg);
  }
  return false;
}

function validateDataTypes(countid, prefix) {      
  var count = document.getElementById(countid).value;
  var i = 0;
  for (i = 1; i <= count; i++) {
    var name = prefix + i;
    var inputs = document.getElementById(name).value;
    var inputValueName = inputs.substring(0, inputs.indexOf(","));
    var inputValeType = inputs.substring(inputs.indexOf(",") + 1, inputs.length);
    var inputValue = document.getElementById(inputValueName).value;
      if (inputValeType == 'Integer'){
        if (!isInteger(inputValue)) {
          alert("invalid value entered for "+inputValueName);
          return false;
        }
      } else if (inputValeType == 'Float'){
        if (!isFloat(inputValue)) {
          alert("invalid value entered for "+inputValueName);
          return false;
        }
      }
  }
  return true;
}

function isInteger(sText)
{
  var validChars = "-0123456789";
  var isNumber=true;
  var Char;
  for (i = 0; i < sText.length && isNumber; i++) { 
    isNumber = validChars.indexOf(sText.charAt(i)) >= 0;
  }
  return isNumber;
}

function isFloat(sText)
{
  var validChars = "-0123456789.";
  var isNumber = true;
  for (i = 0; i < sText.length && isNumber; i++) { 
    isNumber = validChars.indexOf(sText.charAt(i)) >= 0;
  }
  return isNumber;
}

function changePriority(queue) 
{
  var cookieName = window.menuName;
  var job = getCookie(cookieName);
  var aPosition = job.indexOf(",");
  if (aPosition > 0){
    var rowInfoArray = new Array();
    rowInfoArray = job.split(",");
    job = rowInfoArray[0];
  }
  var win = window.open('saChangePriority.jsp?jobId='+job,'changePriorityWindow','resizable=no,status=yes,width=400,height=250');
  window.top.changePriorityWindow = win;
  win.focus();
  return true;
}

function showHideRowContent(currentRowId, prefix, totalCount)
{
  var item = document.getElementById(currentRowId);
  if (item){
    item.className = 'unhidden';
  }
  var index=currentRowId.substring(currentRowId.indexOf(prefix)+prefix.length);
  for (i = 0; i < totalCount; i++) {
    if (i == index) {
      continue;
    }
    item = document.getElementById(prefix+i);
    if (item) {
      item.className = 'hidden';
    }
  }
}

function clearCookie(cookieName)
{
if(document.cookie) {
  var index = document.cookie.indexOf(cookieName);
  if (index != -1) {
     document.cookie = cookieName + '=;path=/;expires=Thu, 01-Jan-1970 00:00:01 GMT';
  }
}
}

function logoutTimerReset()
{
  try {
    if (window.opener) {
      if (!window.opener.closed) {
        if (window.opener.top != null) {
          if (window.opener.top.topFrame != null) {
            if (window.opener.top.topFrame.resetLogoutTimer) {
              window.opener.top.topFrame.resetLogoutTimer();
            }
          }
        }
      }
    } else if (top != null) {
      if (top.topFrame != null) {
        if (top.topFrame.resetLogoutTimer) {
          top.topFrame.resetLogoutTimer();
        }
      }
    }
  } catch (err) {
    // ignore
  }
}
