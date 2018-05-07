<!---------------------------------------------------------------------------

###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

----------------------------------------------------------------------------->

<%@ page import="com.hp.ov.activator.mwfm.*,
                 com.hp.ov.activator.mwfm.servlet.*"
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%!
        //I18N strings
        final static String[] headers 		= { com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("138", "Active Jobs"),
						    com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("139", "Logs"),
						    com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("140", "Messages"),
						    com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("141", "Workflows"),
						    com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("142", "Track Activations"),
						    com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("143", "Configuration"),
						    com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("144", "Test Messaging"),
						    com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("145", "Inventory"),
						    com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("36", "Service Instances"),
                                                    com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("300", "Tools")
                                                   };
%>

<%-- This is the common header for all the documents --%>
<html>
<head>
<base target="_top">
  <link rel="stylesheet" type="text/css" href="../css/activator.css">
</head>

<body>
<h2> <%= headers[Integer.parseInt(request.getParameter("value"))] %> </h2>
</body>
</html>
