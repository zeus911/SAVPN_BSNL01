<!---------------------------------------------------------------------------

###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

----------------------------------------------------------------------------->
<%@ page  import="com.hp.ov.activator.mwfm.servlet.*,    java.net.*"
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
	String ne_id = (String) request.getParameter("NE_ID");
	String rateLimit = (String) request.getParameter("rateLimit");
        String location = request.getParameter("location");
%>

<html>
<head>
  <title>hp service activator</title>
  <link rel="stylesheet" type="text/css" href="../css/activator.css">
</head>
   
   <frameset rows="100%" frameborder="0" framespacing="1">
      <frame src="CreateChannel.jsp?NE_ID=<%=ne_id %>&rateLimit=<%=rateLimit%>&location=<%= location %>" name="main" topmargin="0" marginwidth="10" marginheight="10"  scrolling="auto">
   </frameset>

</html>
