<!---------------------------------------------------------------------
   HP OpenView Service Activator
   @ Copyright 2000-2002 Hewlett-Packard Company. All Rights Reserved
---------------------------------------------------------------------->

<%@ page session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<html>
<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="../../css/activator.css">
</head>
   
<frameset border="0" rows="10%,80%,3%,7%" frameborder="0">
   <frameset border="0" cols="90%,*" frameborder="0"> 
      <frame src="../header.jsp?value=6" name="header" marginwidth="10" 
                  noresize scrolling="no" >
      <frame src="../../images/hplogo.gif" marginheight="5" marginwidth="10" noresize scrolling="no">
   </frameset>

   <frame src="generateTests.jsp" name="availWF" scrolling="auto">
   <frame src="../../images/message_bar.gif" marginwidth="10" marginheight="0" noresize scrolling="no">
   <frame src="../../blank.html" name="messageLine" marginwidth="10" marginheight="0" 
               scrolling="auto">
</frameset>

</html>
