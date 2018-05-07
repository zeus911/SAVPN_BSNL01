<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,
		  com.hp.ov.activator.vpn.backup.servlet.*,
                java.sql.*, 
				javax.sql.DataSource,
                java.util.*, 
                java.text.*,
                java.lang.*" 
         info="View Equipment List" 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<% /* JPM New */ %>
<%
    // Check if there is a valid session available.
    if (session == null || session.getValue (com.hp.ov.activator.mwfm.servlet.Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    }
	response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<html>
<head>
<% /* JPM New */ %>
	<script language="JavaScript" src="../../javascript/table.js"></script>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
</head>
<body>

<%	//<h2 class="mainSubHeading"><center>Delete Retrieval Policy</center></h2> %>

<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.backup.RetrievalPolicy" />
<jsp:setProperty name="bean" property="retrievalpolicyname"/>

<%  DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE); 
	String RetrievalPolicy = request.getParameter("retrievalpolicyname");
   	Connection con = null;
   try {
     con = (Connection)dataSource.getConnection(); 	
     com.hp.ov.activator.vpn.backup.RetrievalPolicy.delete (con, RetrievalPolicy.trim());
	
 %>
             <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
                     var fPtr = parent.frames['messageLine'].document;
                     fPtr.open();
                     fPtr.write("RetrievalPolicy <%= RetrievalPolicy%> removed");
                     fPtr.close();                     
             </script>
		<script>
			parent.frames['main'].location='FindRetrievalPolicy.jsp'				
		</script>

<%  } catch (Exception e) { %>
       <b>Error deleting RetrievalPolicy information:</b> <%= e.getMessage() %>
<% } finally {
	if (con!=null)
       con.close();
   } %>
</table>
</body>
</html>