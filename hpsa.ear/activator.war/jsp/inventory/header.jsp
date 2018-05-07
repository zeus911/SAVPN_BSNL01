<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->

<%@ page session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%!
        //I18N strings
        final static String[] headers 		= { 
						    com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("145", "Inventory"),
						    com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("36", "Service Instances")
                                                   };
%>

<%-- This is the common header for all the documents --%>
<html>
<head>
<base target="_top">
  <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
</head>

<body>
<h2> <%= headers[Integer.parseInt(request.getParameter("value"))] %> </h2>
</body>
</html>
