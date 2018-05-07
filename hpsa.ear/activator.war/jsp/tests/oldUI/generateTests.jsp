<!---------------------------------------------------------------------
   HP OpenView Service Activator
   @ Copyright 2000-2002 Hewlett-Packard Company. All Rights Reserved
----------------------------------------------------------------------->

<%@ page import="com.hp.ov.activator.mwfm.*, 
                 com.hp.ov.activator.mwfm.servlet.*, 
                 java.net.*, java.io.*" 
                 session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<html>
<head>
  <title>HP Service Activator</title>
  <script language="JavaScript" src="../../javascript/table.js"></script>
  <script language="JavaScript" src="../../javascript/utilities.js"></script>
  <link rel="stylesheet" type="text/css" href="../../css/activator.css">
  <base target="main">
</head>

<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(Constants.USER) == null) {
       response.sendRedirect ("../sessionError.jsp");
       return;
    }   

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader    ("Pragma",  "no-cache");
%>

<%!
        // I18N strings
        final static String testName    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("128", "Test Name");
        final static String availMsgs   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("129", "Available Messages");
        final static String description = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("9", "Description");
        final static String noTests     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("130", "No tests available.");
        final static String errMsg      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("131", "Unable to retrieve a valid path to the test message files.");
        final static String errMsg1     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("132", "Please check the test_dir parameter in the web.xml file.");
%>

<jsp:useBean id="menuDataBean" scope="session" class="com.hp.ov.activator.mwfm.servlet.menuDataBean"/>
<% menuDataBean.resetTestID(); %>

<body>
<table class="activatorTable">
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
    }

   if ((af == null) || (af.length == 0)) {
%>
       <SCRIPT LANGUAGE="JavaScript">
           writeToMsgLine("<%= noTests %>");
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
         String prevTestName = "";
         String currTestName = "";

         for (int j = 0; j < files.length; j++) {
       if (files[j].getName().endsWith(".xml")) {
               String style = (numRows%2 == 0) ? "class=\"tableEvenRow\"" : "class=\"tableOddRow\"";
               currTestName = af[i].getName();
%>
               <tr <%=style%>
                    onClick="rowSelect(this);
                    parent.frames['messageLine'].location.href=
                      '../msgLine.jsp?menuId=3&test=<%=URLEncoder.encode(files[j].toString()) %>';"
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
</body>
</html>
