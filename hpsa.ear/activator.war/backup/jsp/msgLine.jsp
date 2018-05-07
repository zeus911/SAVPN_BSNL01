<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->

<%@ page import="com.hp.ov.activator.mwfm.*, 
                 com.hp.ov.activator.mwfm.servlet.*, com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,com.hp.ov.activator.vpn.backup.servlet.*,
                 java.net.*"
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    }
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<html>
<head>
  <script language="JavaScript" src="../../javascript/menu.js"></script>
  <script language="JavaScript" src="../../javascript/backup.js"></script>
  <title>hp service activator</title>
  <link rel="stylesheet" type="text/css" href="../css/activator.css">
  <base target="_self">
<%
    response.setDateHeader("Expires", 0);
    response.setHeader    ("Pragma",  "no-cache");
%>
</head>

<jsp:useBean id="menuBackupBean" scope="session" class="com.hp.ov.activator.vpn.backup.servlet.menuBackupBean" />

<%
    // set parameters for display/delete messages menu options
    String menu = request.getParameter("menuType");
%>

<body>
<%
    // menu options for Equipment Selected
    if (menu.equals("1")) {
       if (request.getParameter("equipmentID") != null && request.getParameter("timestamp") != null && request.getParameter("equipmentName") != null) {
           menuBackupBean.setEquipmentID(URLDecoder.decode(request.getParameter("equipmentID"),"UTF-8"));
           menuBackupBean.setEquipmentName(URLDecoder.decode(request.getParameter("equipmentName"),"UTF-8"));
           menuBackupBean.setTimestamp(URLDecoder.decode(request.getParameter("timestamp"),"UTF-8"));
       }
    }
    // menu options for Scheduling 
    else if (menu.equals("2")) {
       if (request.getParameter("schedulingName") != null) {
           menuBackupBean.setSchedulingPolicy(URLDecoder.decode(request.getParameter("schedulingName"),"UTF-8"));
       }
    }
    // menu options for Retrieval 
    else if (menu.equals("3")) {
       if (request.getParameter("retrievalName") != null) {
           menuBackupBean.setRetrievalPolicy(URLDecoder.decode(request.getParameter("retrievalName"),"UTF-8"));
       }
	   
    } 
    // menu options for Equipment List 
    else if (menu.equals("4")) {
       if (request.getParameter("equipmentID") != null && request.getParameter("equipmentName") != null) {
           menuBackupBean.setEquipmentID(URLDecoder.decode(request.getParameter("equipmentID"),"UTF-8"));
           menuBackupBean.setEquipmentName(URLDecoder.decode(request.getParameter("equipmentName"),"UTF-8"));
       }
    } 
%>
</body>
</html>
