<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->

<%@ page session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>


<%
   request.setCharacterEncoding("UTF-8");
   String displayType = (String) request.getParameter("displayType");
%>

<html>
<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
  <script language="JavaScript" src="/activator/javascript/tree.js"></script>
</head>

      <frameset rows="90%,3%,*" border="0" frameborder="0" >
          <frame src="/activator/jsp/inventory/invMsg.jsp?displayType=<%=displayType%>" name="invSubmit" scrolling="auto"></frame>
          <frame src="/activator/images/message_bar.gif" marginwidth="10" marginheight="0"
                  noresize scrolling= "no"></frame>
          <frame src="/activator/blank.html" name="messageLine" marginwidth="10" 
                 noresize marginheight="0" scrolling="auto"></frame>
      </frameset>

</html>

