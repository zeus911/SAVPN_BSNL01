<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page import="com.hp.ov.activator.mwfm.*, 
			 com.hp.ov.activator.mwfm.servlet.*,              
             java.sql.*,
             java.util.*,
             java.net.*,
             javax.sql.*"
         info="Show Master Slaves Information of entire Cluster System." 
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute (Constants.USER) == null) {
%>
    <script>
        window.top.topFrame.location = window.top.topFrame.location;
    </script>
<%
       return;
    }   
 
    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader    ("Pragma",  "no-cache");

    request.setCharacterEncoding ("UTF-8");
%>

<%!
    //I18N strings        
    final static String masterSlaves     	 = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("722", "Master Slaves");   
    final static String nodeNameTitle  	     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("416", "Host Name");
    final static String moduleNameTitle	     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("724", "Module Name");
    final static String masterSlaveStateTitle= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("725", "Master/Slave State");      
    final static String noMasterSlaveExists  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("726", "No Master/Slaves Exists");
    final static String errMsg               = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("727", "Unable to retrieve Master Slave information");
    
    final static String becomeMasterNode         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1044", "Become Master Node");
    final static String confirmBecomeMasterNode  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1045", "Are you sure want make this node as to master node");     
    final static String cancelBecomeMasterNode   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1046", "Become Master node action cancelled");    
    final static String waitBecomeMasterNodeMsgs = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1047", "Please wait while node becomes master...");   
    final static String confirmMsg               = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1048", "Are you sure want to");

    final static String hostNameField = "HOSTNAME";
    final static String moduleNameField = "MODULENAME";
    final static String masterSlaveStateField = "MASTERSLAVESTATE";
    final static String selQry  = "select HOSTNAME, MODULENAME, MASTERSLAVESTATE from MODULES ORDER BY MODULENAME ASC, MASTERSLAVESTATE DESC";
    
    String hostName = null;
    String moduleName = null;
    String masterSlaveStateValue = null;
%>


<html>
<head>
    <title>HP Service Activator</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
    <link rel="stylesheet" type="text/css" href="/activator/css/saTabs.css">
    <link rel="stylesheet" type="text/css" href="/activator/css/saContextMenu.css">
    <script language="JavaScript" src="/activator/javascript/table.js"></script>
    <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
    <script language="JavaScript" src="/activator/javascript/saContextMenu.js"></script>
    <script language="JavaScript">	  
      if (window.top.refresh==null || window.top.refresh != "OFF") {
             document.write(
              "<meta http-equiv='refresh' content='<%=session.getAttribute(Constants.JOB_REFRESH_RATE)%>'>");
      }

      window.onload = function () {
        window.menuName = "masterSlaveStatusMenu";
        document.getElementById('masterSlavesTable').oncontextmenu = showContextMenu;
      }
      
      var rowInfoArray = null;
      var selectedHostname = null;
      var selectedModule=null;
      var selectedMasterSlaveState=null;

      function splitRowInfo() {
          var cookieName = window.menuName;
          rowInfoArray = new Array();
          rowInfoArray = getCookie(cookieName).split(",");
          selectedHostname = rowInfoArray[0];
          selectedModule = rowInfoArray[1];
          selectedMasterSlaveState = rowInfoArray[2];
      }

      function deInitializeRowInfo(){
          rowInfoArray = null;
          selectedHostname = null;
          selectedModule = null;
          selectedMasterSlaveState = null;
      }
      
      function confirmBecomeMasterNode(confirmMsg, cancelMsg){
        splitRowInfo();  
        if(selectedMasterSlaveState != null && selectedMasterSlaveState == 'Master'){
                alert("The cluster node "+selectedHostname+" is already the master for the module:" + selectedModule);
                deInitializeRowInfo();
                return true;
        }

        confirmMsg = confirmMsg + ":" + selectedHostname;
        if (confirm(confirmMsg)) {
                top.main.location='saShowWait.jsp?msg=<%=waitBecomeMasterNodeMsgs%>';
                top.messageLine.location.href = "saAdminTools.jsp?action=becomeMasterNode" + "&hostname=" + selectedHostname+"&moduleName="+selectedModule;
                return true;
        }
        
        writeToMsgLine(cancelMsg);
        return false;
      }      
    </script>
</head>

<body onclick="rowUnSelect();hideContextMenu('masterSlaveStatusMenu')" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">

<table cellpadding="0" cellspacing="0" width="100%">
  <tr align=left><td nowrap class="frameHead"><%=masterSlaves%></td></tr> 
</table>

<table class="activatorTable" id="masterSlavesTable">
<tr id="header">
    <td width="40%" class="mainHeading"> <%=nodeNameTitle%></td> 
    <td width="40%" class="mainHeading"> <%=moduleNameTitle%></td> 
    <td width="20%" class="mainHeading"> <%=masterSlaveStateTitle%></td>
</tr>

<% 
   
   int rowCount = 0;
           
   DataSource dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);     
   Connection connection = null;
   Statement stmt = null;
   ResultSet rset = null;
   
   try {
      connection = (Connection) dataSource.getConnection();     
      stmt = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
      rset = stmt.executeQuery(selQry);      
      if (rset == null) {%>
         <SCRIPT LANGUAGE="JavaScript">
            writeToMsgLine("<%=noMasterSlaveExists%>");
         </SCRIPT>
<% 
      } else {    	

        int numRows=1;                
        while(rset.next()){  
        
            rowCount = rowCount + 1;
            hostName = rset.getString(hostNameField); 
		    moduleName = rset.getString(moduleNameField);
		    
		    if(hostName != null && moduleName != null) {        		
        		int state = rset.getInt(masterSlaveStateField);
	        	if(state == 1) {
	        		masterSlaveStateValue = "Master";
	        	} else {
	        		masterSlaveStateValue = "Slave";
	        	}
       	    
                String rowInfo = hostName+","+moduleName+","+masterSlaveStateValue;
            	String encHostName=URLEncoder.encode(hostName,"UTF-8");
            	String rowClass = (numRows%2 == 0) ? "tableEvenRow" : "tableOddRow";
            	String colClass = "tableCell";  %>            
            	<tr id="<%=rowInfo%>" class="<%=rowClass%>" 
                        onClick="hideContextMenu('masterSlaveStatusMenu');"
                	onMouseOver="mouseOver(this);"
                	onMouseOut="mouseOut(this);" >
                	<td class="<%=colClass%>"> <%= hostName %></td>
                	<td class="<%=colClass%>"> <%= moduleName %></td>
                	<td class="<%=colClass%>"> <%= masterSlaveStateValue %></td>                	
             	</tr>
<%
			}
            ++numRows;            
          }
       } 
       if(rowCount == 0) {%>
         <SCRIPT LANGUAGE="JavaScript">
            writeToMsgLine("<%=noMasterSlaveExists%>");
         </SCRIPT>       	
<%     }
     } 
     catch (Exception e) {
     String err = null;
            if (e.getMessage() != null) {
                String tmp = e.getMessage().replace('\n',' ');
                err = tmp.replace('"',' ');
            }
            else
                err = e.toString().replace('\n',' ');
%>
    	<SCRIPT LANGUAGE="JavaScript"> 
        	alert("HP Service Activator" + "\n\n" + "<%=errMsg%> :  <%=err%>");
        	parent.displayFrame.location.href = "/activator/jsf/jobs/jobs.jsf";
    	</SCRIPT>
<%	
   } finally{
   		if(rset != null)
       	 rset.close();
       	
       if(stmt != null)
       	 stmt.close();
       if(connection != null)
         connection.close();       	
   }
%>
</table>

<! hidden until menu is selected >
<div id="masterSlaveStatusMenu" class="contextMenu" onclick="hideContextMenu('masterSlaveStatusMenu');">
<%
        if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == true) {
%>
            <a href="#" target="_self"
               class="menuItem" target='displayFrame'
               onclick="return confirmBecomeMasterNode('<%=confirmBecomeMasterNode%>','<%=cancelBecomeMasterNode%>');"
               onmouseover="toggleHighlight(event)"
               onmouseout="toggleHighlight(event)"><%=becomeMasterNode%></a>
<%               
        }
%>
</div>

</body>
</html>
