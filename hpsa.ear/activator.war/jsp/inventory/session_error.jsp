<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.

   This jsp is being provided for backward compatibility with vers. 2.5 - 3.0
   It is not used by 3.5 and higher.
----------------------------------------------------------------------->
<%@ page session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
     response.sendRedirect("/activator/jsp/sessionError.jsp");
     return;
%>
