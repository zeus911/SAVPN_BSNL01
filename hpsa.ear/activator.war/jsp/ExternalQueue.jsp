<!---------------------------------------------------------------------
   HP OpenView Service Activator
   @(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
---------------------------------------------------------------------->

<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants"
		 session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%     
	String refreshRate= (String)session.getAttribute(Constants.JOB_REFRESH_RATE);
%>


<html>
<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="../css/activator.css">
  <script language="JavaScript">
	if (window.top.refresh==null || window.top.refresh != "OFF") {
	  document.write("<meta http-equiv='refresh' content='<%=refreshRate%>'>");
	}
  </script>
</head>
   
<frameset border="0" rows="88,*" frameborder="0" framespacing="0">
      <frame src="tab.jsp" name="queueFrame" topmargin="0" marginwidth="10" marginheight="0" >
      <frame src="../blank.html" name="displayFrame" marginwidth="10" marginheight="0" noresize scrolling="auto">
</frameset>




</html>
