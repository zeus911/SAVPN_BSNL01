<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page import=" com.hp.ov.activator.mwfm.servlet.*,
                  com.hp.ov.activator.mwfm.*,                 
                  com.hp.ov.activator.mwfm.engine.object.ObjectConstants,                  
                  java.util.Vector,
                  java.util.Enumeration,
                  java.rmi.RemoteException"
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java" %>

<%
  // Setup response parameters
  response.setDateHeader("Expires", 0);
  response.setHeader    ("Pragma",  "no-cache");

  request.setCharacterEncoding ("UTF-8"); %>

<%!
	// Setup strings that will be displayed
	final static String selectJobFirst = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1029", "You must first select a job to change priority on.");
	final static String currentPriority = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1030", "Current Priority");
	final static String newPriority     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1031", "New Priority");
	final static String invalidPriority = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1032", "Invalid Priority");
    final static String numberException = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("661", "Numberformat exception invalid jobId:");
	final static String windowTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1033", "Change Priority on job:");
	final static String currentPriorityText = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1030", "Current Priority");
	final static String newPriorityText = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1031", "New Priority");
	final static String newPriorityTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1034", "Change the priority for the job");
	final static String listOfAvailPriorities = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1035", "List of available priorities that can be selected.");
	final static String submitButton = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("16", "Submit");
	final static String noConnectionToMwfm = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("659", "Could not get connection to the Workflow Manager.");
  	final static String numberFormatException = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1036", "Priority value should be in integer");
  	final static String priorityShudGreaterThanZero = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1037", "Priority value should be greater than 0");
  	final static String unableToGetCurrentPriority = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1038", "Unable to get the current priority for the job ");
  	final static String priorityShudNotBeEmpty = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1039", "Priority value should not be empty");
%>

<%  
  String jobId = request.getParameter("jobId");   
  long jobIdLong; 
  String currentPriority = "0";
  Vector priorityNameList = null;
  Vector priorityValueList = null;
  boolean isPriorityConfigured = false;
  String newPriorityValue = null;
  boolean errMsgSet = false;	
%>

<html>
  <head>
    <title>HP Service Activator</title>
    <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">

    <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">

    <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
      function closeChangePriorityWindow() {
        window.close();        
        return true;
      }
    </script>    
    
    <!--
    ##################### 
    # Validation checks #
    ##################### -->

<% 
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(Constants.USER) == null) {
      return;
    }   
%>
    
<%
    // Check that the jobId is supplied    
    if (jobId == null || jobId.equals("")) { %>
      <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
        alert("<%=selectJobFirst%>");
        closeChangePriorityWindow();
      </script>
<%    	return;
    } 
%> 
  
<%
    // Check that the jobId is valid   
    try {
      jobIdLong = Long.parseLong(jobId);
    } catch (NumberFormatException e) { 
%>
      <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
        alert("<%=numberException%> <%=e.getMessage()%>");
        closeChangePriorityWindow();
      </script>
<%    return;
    } 
%>   

<%	if (request.getParameter("callState") == null) {
		// Check and get the reference to the MWFM
		try {
			WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);		
    		if (wfm == null) { %>
    			<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
        			alert("<%=noConnectionToMwfm%>");
	        	</script>
<% 				return; 
    		} 
    		CasePacket cp = wfm.getCasePacketForJob(jobIdLong);    		
			Long tempPriority = (Long)cp.getCPVariableValue("PRIORITY");			
			if (tempPriority != null) {
				currentPriority = tempPriority.toString();
			}
    	} catch (Exception excep) { 
    		String err = null;
            if (excep.getMessage() != null) {
                String tmp = excep.getMessage().replace('\n',' ');
                err = tmp.replace('"',' ');
            }
            else {
                err = excep.toString().replace('\n',' ');
            }
%>
			<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
        		alert("HP Service Activator" + "\n\n" + <%=unableToGetCurrentPriority%> + <%=jobId%> + ":" <%=err%>");
	        </script>    		
<%    	} %>
    
<%  	// check whether the priorities are configured in web.xml
    	priorityValueList = (Vector) session.getAttribute(Constants.PRIORITY_VALUE);
    	if (priorityValueList != null && priorityValueList.size() > 0) {
	    	priorityNameList = (Vector) session.getAttribute(Constants.PRIORITY_NAME);
    		isPriorityConfigured = true;
    	} 
	 }
	 if (request.getParameter("callState") != null && request.getParameter("callState").equals("commit")) {
	 	try {	 	 			
			if (request.getParameter("newPriorityValue") != null) {
				int newPriorityIntValue = -1;
				try {
					String newPriorityStringValue = request.getParameter("newPriorityValue");
					if (newPriorityStringValue.length() == 0 || newPriorityStringValue.equals(" ")) {
						errMsgSet = true;
%>
						<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">	    				
	    					alert("HP Service Activator" + "\n\n" + "<%=priorityShudNotBeEmpty%>");	    						
    	    			</script>
<%					} else {
						newPriorityIntValue = Integer.parseInt(newPriorityStringValue);				
					}
				} catch(NumberFormatException numberFormatExcep) {
					if (!errMsgSet) {
						errMsgSet = true;
%>
						<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">	    				
	    					alert("HP Service Activator" + "\n\n" + "<%=numberFormatException%>");	    						
    	    			</script>
<%    	    		}
				}
				WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);		
    			if (wfm == null) { %>
    				<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
        				alert("<%=noConnectionToMwfm%>");
        				closeChangePriorityWindow();
	        		</script>
<% 										
					return;
    			} 
    			if (newPriorityIntValue > 0) {
	    			wfm.changePriority(jobIdLong, newPriorityIntValue); 
%>
					<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">						
						alert("Priority for Job with jobid " + <%=jobId%> + " changed successfully! ");       					
						closeChangePriorityWindow();
        			</script>
<%        		} else { 
					if (!errMsgSet) {
						errMsgSet = true;
%>
						<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
	    					alert("HP Service Activator" + "\n\n" + "<%=priorityShudGreaterThanZero%>"); 	    				        		
    	    			</script>
<%    	    		}
				}
	   		}    		
    	} catch (Exception e) {
    	  	String err = null;
            if (e.getMessage() != null) {
                String tmp = e.getMessage().replace('\n',' ');
                err = tmp.replace('"',' ');
            }
            else {
                err = e.toString().replace('\n',' ');
            }
%>    		
			<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
	    		alert("HP Service Activator" + "\n\n" + "Change Priority failed : <%=err%>");
    	        closeChangePriorityWindow();
    	    </script>
<%   	} 
    }	%>		
  </head> 
  
  <body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
   <h3>
        <img src="/activator/images/HPlogo-black.gif" valign="top" align="right"><%=windowTitle%> <%=jobId%>
  </h3>   
  <br>
  <br>
  <center>
  	<form name="form" action="/activator/jsp/saChangePriority.jsp?jobId=<%=jobId%>" method="POST"> 
  		<input type="hidden" name="callState" value="commit"> 		
  		<table width="100%" border=0 cellpadding=0>
  			<tr>
		  		<td class="tableRow"><%=currentPriorityText%>
  	 			</td>
	 			<td class="tableRow"><%=currentPriority%>
  	 			</td>
			</tr>
  			
  			<tr>
  	 			<td class="tableRow" title="<%=newPriorityTitle%>"><%=newPriorityText%>
  	 			</td>
<%   			if (isPriorityConfigured) { %>
  	 				<td class="tableRow" title="<%=listOfAvailPriorities%>">  	 
     					<select name="newPriorityValue">
<%							int i = 0;
    						Enumeration enumObj = priorityNameList.elements();
		        			while(enumObj.hasMoreElements()) {
    	  						String priorityName = (String)enumObj.nextElement();
      							String priorityValue = (String)priorityValueList.get(i); 
								if(currentPriority.equals(priorityValue)) {
%>
									<option selected="selected" value="<%=priorityValue%>"><%=priorityName%></option>
<%								} else { %>
									<option value="<%=priorityValue%>"><%=priorityName%></option>  
<%								} 								
								i ++;
			 				} %>					                   
	         			</select>
     				</td>
<%	 			} else { %>   
					<td class="tableRow" title="<%=newPriorityTitle%>">
        				<input type="text" size="8" name="newPriorityValue"> </td>
<%   			} %>	
   			</tr>
   			
   			<tr>
   				<td colspan="2">&nbsp;</td>
   			</tr>
   	
   			<tr>
   				<td align="center" colspan="2">
    				<input type="submit" value="<%=submitButton%>" >
   				</td>
   			</tr>
  		</table>
  	</form>
  </center>
  </body>
</html>