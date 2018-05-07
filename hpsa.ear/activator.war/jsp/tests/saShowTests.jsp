<!---------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
----------------------------------------------------------------------->

<%@ page import="com.hp.ov.activator.mwfm.*, 
                 com.hp.ov.activator.mwfm.servlet.*, 
                 java.net.*, java.io.*" 
                 session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(Constants.USER) == null) {
       response.sendRedirect ("/activator/jsp/sessionError.jsp");
       return;
    }   

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    request.setCharacterEncoding ("UTF-8");
%>

<html>
<head>
    <title>HP Service Activator</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
    <link rel="stylesheet" type="text/css" href="/activator/css/saTabs.css">
    <link rel="stylesheet" type="text/css" href="/activator/css/saContextMenu.css">
    <script language="JavaScript" src="/activator/javascript/table.js"></script>
    <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
    <script language="JavaScript" src="/activator/javascript/saContextMenu.js"></script>
    <base target="main">

  <script language="JavaScript">

    if (document.all) {
       var menuName = window.menuName;
       document.onclick = "hideContextMenu(menuName)";
    }

    window.onload = function () {
       window.menuName = "testMsgsMenu";
       document.getElementById('testMsgs').oncontextmenu = showContextMenu;
    }
    
    function startTestMsg() {
       var cookieName = window.menuName;
       var testMsg = getCookie(cookieName);
       top.messageLine.location.href = "/activator/jsp/tests/saStartTest.jsp?test=" + testMsg+"&type=socket";
    }

    function startJmsTestMsg() {
       var cookieName = window.menuName;
       var testMsg = getCookie(cookieName);
       top.messageLine.location.href = "/activator/jsp/tests/saStartTest.jsp?test=" + testMsg+"&type=jms";
    }    

  </script>

</head>

<%!
    // I18N strings
    final static String testName     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("128", "Test Name");
    final static String availMsgs    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("129", "Available Messages");
    final static String description  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("9", "Description");
    final static String noTests      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("130", "No tests available.");
    final static String errMsg       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("131", "Unable to retrieve a valid path to the test message files.");
    final static String errMsg1      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("132", "Please check the test_dir parameter in the web.xml file.");
    final static String testTitle    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("144", "Test Messaging");
    final static String startTest    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1553", "Socket Listener Test");
    final static String startJmsTest = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1554", "JMS Listener Test");    
%>

<body onclick="rowUnSelect();hideContextMenu('workflowMenu');" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">

<table cellpadding="0" cellspacing="0" width="100%">
  <tr align=left><td nowrap class="frameHead"><%=testTitle%></td></tr> 
</table>

<table class="activatorTable" id="testMsgs">
  <tr>
    <td width="20%" class="mainHeading"> <%= testName %></td>
    <td width="30%" class="mainHeading"> <%= availMsgs%></td>
    <td width="50%" class="mainHeading"> <%= description%></td>
  </tr>

<%
    String path= (String) session.getAttribute(Constants.TEST_DIRECTORY);
    File[] af = null;

    if (path == null || path.equals("")) {
%>
       <SCRIPT LANGUAGE="JavaScript">
          alert("<%= errMsg %>" + "\n" + "<%= errMsg1 %>")
       </SCRIPT>
<%
    }
    else {      
       af = new File (path).listFiles();
       java.util.Arrays.sort(af);
    }

   if ((af == null) || (af.length == 0)) {
%>
       <SCRIPT LANGUAGE="JavaScript">
           top.messageLine.location.href = encodeURI('/activator/jsp/saDisplayMsg.jsp?Msg=<%= noTests %>');
       </SCRIPT>
<%
   }
   else {

     int numRows=1;

     for (int i = 0; i < af.length; i++) {
       if (af[i].isDirectory()) {

         // Read description
         BufferedReader br = null;
         String description;
         try {
             br = new BufferedReader(
                      new InputStreamReader(
                         new FileInputStream(
                             new File(af[i], "description")),"UTF-8"));
             description = br.readLine();
         } catch (FileNotFoundException e) {
             description = null;
         } catch (Exception e) {
             description = "<i>Error reading description file:</i> " + e;
         }
      
         File[] files = af[i].listFiles();
         java.util.Arrays.sort(files);
         String prevTestName = "";
         String currTestName = "";

         for (int j = 0; j < files.length; j++) {
       if (files[j].getName().endsWith(".xml")) {
               String style = (numRows%2 == 0) ? "class=\"tableEvenRow\"" : "class=\"tableOddRow\"";
               currTestName = af[i].getName();
           String encFileName = URLEncoder.encode(files[j].toString(),"UTF-8");
%>
               <tr id="<%=encFileName%>" <%=style%>
                    onClick="hideContextMenu('testMsgsMenu');"
                    onMouseOver="mouseOver(this);"
                    onMouseOut="mouseOut(this);" >
                 <td class="tableCell"><%= (prevTestName.equals(currTestName)) ? "&nbsp;" : currTestName %></td>
                 <td class="tableCell"><%=files[j].getName()%></td>
                 <td class="tableCell"><%= description == null ? "&nbsp;" : description %></td>
              </tr>
<%         
             prevTestName = af[i].getName();
             ++numRows; 
          }
         }
       }
    }
  }
%>
</table>

<!-- This table is hidden until selected for viewing with a right click -->

<div id="testMsgsMenu" class="contextMenu" onclick="hideContextMenu('testMsgsMenu');">
         <a href="#" class="menuItem" target="displayFrame"
            onclick="startTestMsg();return false;"
            onmouseover="toggleHighlight(event)"
            class="menuItem"
            onmouseout="toggleHighlight(event)"><%=startTest%></a>
         <hr>   
         <a href="#" class="menuItem" target="displayFrame"
            onclick="startJmsTestMsg();return false;"
            onmouseover="toggleHighlight(event)"
            class="menuItem"
            onmouseout="toggleHighlight(event)"><%=startJmsTest%></a>            
</div>

</body>
</html>
