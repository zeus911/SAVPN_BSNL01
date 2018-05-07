<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page import="com.hp.ov.activator.mwfm.servlet.*"
         info="Display counter of available jobs"
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
%>

<%!
//I18N strings
final static String search              = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("119", "Search");
final static String searchMsg           = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("329", "Finished searching the document.");
%>

<!doctype html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
<link rel="stylesheet" type="text/css" href="/activator/css/saNavigation.css">
<script src="/activator/javascript/saNavigation.js"></script>
<script src="/activator/javascript/saUtilities.js"></script>
<style type="text/css">
#searchFooter {
  width: 100%; 
  text-align: center;
}
</style>
<script language="JavaScript">
var pos=0;
function searchForTxt(doneMsg) {
  if (document.search.searchText.value == '') {
      return;
  }
  // Internet Explorer
  if (document.all) {
    var found = false;
    var text;
    if (parent.main.displayFrame.logDisplayFrame) {
      text = parent.main.displayFrame.logDisplayFrame.document.body.createTextRange();
    } else if(parent.main.displayFrame.msgDisplayFrame) {
     text = parent.main.displayFrame.msgDisplayFrame.document.body.createTextRange();
    } else {
      text = parent.main.displayFrame.document.body.createTextRange();
    }
    for (var i=0; i<=pos && (found=text.findText(document.search.searchText.value)) != false; i++) {
      text.moveStart("character", 1);
      text.moveEnd("textedit");
    }
    if (found) {
      text.moveStart("character", -1);
      text.findText(document.search.searchText.value);
      text.select();
      text.scrollIntoView();
      pos++;
    } else {
      alert(doneMsg);
      pos = 0;
    }
  }
  //Netscape
  else {
    var bool=false;
    if (parent.main.displayFrame.logDisplayFrame) {
      if (parent.main.displayFrame.logDisplayFrame.find(document.search.searchText.value) == false) {
        bool=true;
      }
    } else if(parent.main.displayFrame.msgDisplayFrame) {
      if (parent.main.displayFrame.msgDisplayFrame.find(document.search.searchText.value) == false) {
        bool=true;
      }
    } else if (parent.main.displayFrame.find(document.search.searchText.value) == false) {
      bool=true;
    }
    if (bool){
      alert(doneMsg);
    }
  }
}
</script>
</head>
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();" style="margin:0px; padding:0px; overflow:hidden;">
  <div id="searchFooter">
    <form name="search" onSubmit="btnSearch.click(); return false;">
      <center><input name="searchText" type="text" size=16 maxlength=30></center>
      <center><input name="btnSearch" type="button" value="<%=search%>" onClick="searchForTxt('<%=searchMsg%>')"></center>
    </form>
  </div>
</body>
</html>
