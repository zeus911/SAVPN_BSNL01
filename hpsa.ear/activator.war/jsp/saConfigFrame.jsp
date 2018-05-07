<%@ page import="java.text.SimpleDateFormat,
                 org.apache.log4j.Logger,
                 org.apache.log4j.BasicConfigurator"%>
<!---------------------------------------------------------------------------

###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

----------------------------------------------------------------------------->
<%@ page session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%!Logger logger = Logger.getLogger("BackupTest");%>

<html>
<head>
  <title>hp service activator</title>
  <link rel="stylesheet" type="text/css" href="../css/activator.css">
</head>

<%  SimpleDateFormat sdf = new SimpleDateFormat("hh:mm:ss");     
    logger.debug(sdf.format(new java.util.Date()) + ": saConfigFrame.jsp");
%>


<frameset border="0" rows="75,*" frameborder="0" framespacing="0">      
      <frame src="saRouterTabs.jsp" name="queueFrame" topmargin="0" marginwidth="10" marginheight="0" >     
      <frame name="displayFrame" marginwidth="10" marginheight="0" noresize scrolling="auto">  
</frameset>
</html>
