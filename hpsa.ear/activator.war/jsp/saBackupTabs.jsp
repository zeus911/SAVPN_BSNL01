<!---------------------------------------------------------------------------

###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

----------------------------------------------------------------------------->

<%@ page import="com.hp.ov.activator.mwfm.*, 
                 com.hp.ov.activator.mwfm.servlet.*, 
                 java.io.*,
                 java.net.*"
         info="Display all active jobs." 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
    // Check if there is a valid session available.
    if (session == null || session.getValue (Constants.USER) == null) {
       response.sendRedirect ("sessionError.jsp");
       return;
    }

    request.setCharacterEncoding ("UTF-8");
%>

<%!
    //I18N strings
    final static String noLogs 	= "No Backup";		
    final static String logs 	= "Backup";
%>
 

<html>
<head>
    <base target="_top">
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
    <link rel="stylesheet" type="text/css" href="/activator/css/saTabs.css">
    <script language="JavaScript" src="../javascript/saUtilities.js"></script>
    <script language="JavaScript" src="../javascript/saNavigation.js"></script>
</head>

<body>
<table cellpadding="0" cellspacing="0">
   <div>
      <tr align=left>
          <td nowrap align=center class="frameHead"><%=logs%></td>
      </tr>
   </div>
   
   <table border=0 cellpadding="1" cellspacing="0" >
       <tr id="toprow">
            <td id="tab0" class="tabSelected"   nowrap
                       onMouseOver="highlightTab(this);"
                       onMouseOut="unHighlightTab(this);"
                       onClick="selectTab(this);parent.displayFrame.location='../backup/jsp/CreationFormEquipmentConfiguration.jsp';"
                       >&nbsp; Insert Config</td>
       	    <td width=1 bgcolor=#ffffff><img width=1 height=1 alt=""></td>        	    
       	    <td id="tab1" class="tabUnSelected"  nowrap
	                           onMouseOver="highlightTab(this);"
	                           onMouseOut="unHighlightTab(this);"
	                           onClick="selectTab(this);parent.displayFrame.location='../backup/jsp/FindEquipmentList.jsp'"
	                           >&nbsp; List Configs</td>
       	    <td width=1 bgcolor=#ffffff><img width=1 height=1 alt=""></td>        	    
       	    <td id="tab2" class="tabUnSelected"  nowrap
	                           onMouseOver="highlightTab(this);"
	                           onMouseOut="unHighlightTab(this);"
	                           onClick="selectTab(this);parent.displayFrame.location='../backup/jsp/FindSelectedEquipmentConfiguration.jsp'"
	                           >&nbsp; Find Config</td>
       	    <td width=1 bgcolor=#ffffff><img width=1 height=1 alt=""></td> 
       	    <td id="tab3" class="tabUnSelected"  nowrap
	                           onMouseOver="highlightTab(this);"
	                           onMouseOut="unHighlightTab(this);"
	                           onClick="selectTab(this);parent.displayFrame.location='../backup/jsp/BackupEquipmentConfiguration.jsp'"
	                           >&nbsp; Manual Backup</td>
       	    <td width=1 bgcolor=#ffffff><img width=1 height=1 alt=""></td> 
       </tr> 
   </table>


</table>
</body>
</html>
