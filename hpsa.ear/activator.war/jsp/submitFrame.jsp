<!---------------------------------------------------------------------------

###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

----------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.servlet.*,
              com.hp.ov.activator.cr.inventory.*,
							com.hp.ov.activator.inventory.CRModel.*,
              com.hp.ov.activator.inventory.facilities.StringFacility,
              javax.sql.DataSource,
              java.sql.*,
              java.util.HashMap,
              java.util.Vector,
              java.util.regex.Matcher"
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
	String ne_id = (String) request.getParameter("NE_ID");
	String location = request.getParameter("location");
%>

<html>
<head>
  <title>hp service activator</title>
  <link rel="stylesheet" type="text/css" href="../css/activator.css">
</head>
 <body>  
 	<form name="blankform" method="POST" action="ExitFrame.jsp?&location=<%= location %>&NE_ID=<%=ne_id%>">
 	<table  align="center">	
<tr>
<td  align="center">
   <input type="submit" name="submit" id="submit" value="Submit" disabled = "false" >&nbsp
</td>
</tr>
  </table>	
</body>
 
</html>
