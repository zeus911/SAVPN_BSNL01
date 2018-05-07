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
    final static String inventory   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("547", "HP Service Activator Inventory");
    final static String instances   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("546", "HP Service Activator Service Instances");
    final static String noNodeSel	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("118", "No node selected");
%>

<%
    request.setCharacterEncoding("UTF-8");
    String displayType = (String) request.getParameter("displayType");
    if (displayType == null) {
       displayType= "inventory";
    }
%>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
</head>

<body>
<center>
<h2><%= (displayType.equals("inventory")) ? inventory : instances %></h2>
<p class="invField" align="center"><%=noNodeSel%>
</center>
</body>
</html>
