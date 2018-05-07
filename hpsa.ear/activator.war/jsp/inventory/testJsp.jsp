<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->

<%@ page import="com.hp.ov.activator.mwfm.servlet.*,
                 java.io.* "
         info="Test inventoryBuilder generated JSP" 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
    if (session == null || session.getAttribute(Constants.USER) == null) {
       response.sendRedirect ("/activator/jsp/sessionError.jsp");
       return;
    }

    response.setDateHeader("Expires", 0);
    response.setHeader    ("Pragma",  "no-cache");
    request.setCharacterEncoding ("UTF-8");
%>

<%!
    //I18N strings
    final static String testHeader  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("110", "Test Inventory JSP");
    final static String noAvailable = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("111", "No JSPs are available to test.");
    final static String start   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("112", "Start");
%>

<head>
  <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
  <script language="JavaScript" src="/activator/javascript/utilities.js"></script>
  <base target=_self>
</head>

<script language="JavaScript">
    clearMessageLine();
</script>

<body>
<%
    String runJSP = (String) request.getParameter("fileName");
    if (runJSP == null || runJSP.equals("")) {

       // get a listing of all of the JSP files available
       File[] avail = new File((String)getServletContext().getAttribute(Constants.INV_JSP_DIR)).listFiles();
%> 
       <center>
       <h2><%=testHeader%></h2>
       <br>
<%
       if (avail == null) {
%>
           <h3> <%=noAvailable%></h3>
<%
       }
       else {
%>
         <form name="testJSP" method="post">
         <table>
            <tr>
              <select class="invField" name="fileName" size="1">
<%            
                  for (int i=0; i<avail.length; i++)  {
%>
                      <option class="invField"><%= avail[i].getName() %>
<%
                  }
%>
              </select>
            </tr>
            <tr>&nbsp;</tr>
            <tr>
              <td class="invField"><center><input type="submit" value="<%=start%>"></center></td>
            </tr>
         </table>
         </form>

<%
       } 
    }
    else {
%>
       <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
          location = '<%= runJSP %>';
       </script>
<%
    }
%>
</center>
</body>
</html>
