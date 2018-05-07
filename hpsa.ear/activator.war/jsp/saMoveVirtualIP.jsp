<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="com.hp.ov.activator.mwfm.servlet.*,
                 java.net.URLDecoder,
                 java.util.HashMap,
                 java.util.Vector,
                 com.hp.ov.activator.mwfm.engine.module.ClusterNodeBean,
                 com.hp.ov.activator.mwfm.*"
         info="Move Virtual Ip." 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%!
    //I18N strings
    final static String moveVirtualIP        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1298", "Move Virtual IP");
    final static String selectVirtualIP      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1299", "Select Virtual IP");
    final static String selectNode           = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1300", "Select Cluster Node");
    final static String submitBtn_str        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("16", "Submit");
    final static String cancelBtn_str        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("509", "Cancel");    
    final static String confirmMoveVirtualIP = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1301", "Are you sure you want to move Virtual IP");
    final static String cancelMoveVirtualIP  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1302", "Move Virtual IP action cancelled");
    final static String virtualIPMissingMsg  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1303", "Select a Virtual IP to be moved");
    final static String nodeMissingMsg       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1304", "Select the recipient Cluster node");
    final static String notAdmin             = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("596", "You are not administrator.");
%>
<%
    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader    ("Pragma",  "no-cache");

    request.setCharacterEncoding ("UTF-8");
    if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == false) {
%>
    <script>
        alert("<%=notAdmin%>");
        window.close();
    </script>
<%
       return;
    }
%>
    
<jsp:useBean id="moveVirtualIPFilter" scope="session" class="com.hp.ov.activator.mwfm.servlet.moveVirtualIPFilterBean"/>
<html>
	<head>
	  <title>HP Service Activator</title>
	  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
	  <meta http-equiv="content-type" content="text/html; charset=utf-8">
	  <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
	</head>
    <body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
		<table cellpadding="0" cellspacing="0">
		  <tr align="left">
		    <td nowrap="nowrap" class="pageHead"><%=moveVirtualIP%></td>
		  </tr>
		</table>
	<%
	    String currentHostname = (String)URLDecoder.decode(request.getParameter(Constants.HOSTNAME),"UTF-8");
	    HashMap<String, String> hostNameVirtualIPTakenoverMap = (HashMap<String, String>) session.getAttribute(Constants.VIRTUALIPSETUP);
	    String ipList=hostNameVirtualIPTakenoverMap.get(currentHostname);	    
	    Vector clusterNodeList = (Vector) session.getAttribute(Constants.NODEINFORMATION);
	%>	
		<center>
		<form name="inputForm" action="/activator/jsp/saMoveVirtualIPRedirect.jsp" method="POST" onSubmit="return validate();" >
			<input type="hidden" name="nodeCurrentlyConfigured" value="<%=currentHostname%>">
			<table class="pageTable">
				<tr>
					<td class="pageText"><%=selectVirtualIP%>:</td>
					<td>
						<select name="<%=Constants.VIRTUAL_IP_MOVED%>">
        <%
            String[] a = ipList.split("@");
            if (a.length == 1) {
        %>
                                        		<option value="<%=a[0]%>"><%=a[0]%></option>
        <%
            } else {
            	for (int j = 0; j < a.length; j++) {
        %>
        						<option value="<%=a[j]%>"><%=a[j]%></option>
        <%
            	}
            }
        %>
        					</select>
					</td>
				</tr>
				<tr>
					<td class="pageText"><%=selectNode%>:</td>
					<td>
						<select name="<%=Constants.RECEPIENT_HOST%>">
        <%
            ClusterNodeBean clusterBean = null;
            String hostName=null;
            for (int j = 0; j < clusterNodeList.size(); j++) {
            	clusterBean = (ClusterNodeBean)clusterNodeList.get(j);
            	hostName = clusterBean.getHostName();
            	if(!hostName.equals(currentHostname)){
        %>    	
            						<option value="<%=hostName%>"><%=hostName%></option>
        <%            						
            	}
            }
        %>
						</select>
					</td>
				</tr>
				<!-- Common trailer -->
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr>
				    <td align="center" colspan="3">
				       <input type="submit" value="<%=submitBtn_str%>">
				       <input type="button" value="<%=cancelBtn_str%>" onClick="window.close();">
				    </td>
				</tr>				
			</table>
		</form>
	  <script>
	      function validate() {
	         if(document.inputForm.virtualIPMoved.value == null){
                    alert("<%=virtualIPMissingMsg%>");
                    return false;	        
	         }
	         if(document.inputForm.recipientHost.value == null){
                    alert("<%=nodeMissingMsg%>");
                    return false;	        
	         }	
	         if (confirm('<%=confirmMoveVirtualIP%>')) {
	            return true;
	         } else {
	            writeToMsgLine('<%=cancelMoveVirtualIP%>');
                    return false;
	         }
	      }
	  </script>		
		</center>		
	</body>
</html>