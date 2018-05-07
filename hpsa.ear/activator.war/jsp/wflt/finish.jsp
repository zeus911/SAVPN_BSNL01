<!------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
------------------------------------------------------------------------->
<%@ page import = "com.hp.ov.activator.mwfm.servlet.inventory.wflt.struts.WFLTStrutsConstants" %>
<%@ page import = "java.util.Vector" %>
<%@ page import = "com.hp.ov.activator.mwfm.MessageDescriptor" %>

<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<html>
<head>
<script src="/activator/javascript/wflt/jobMessages.js"></script>
<script>
<%
Vector messagesVector = (Vector) request.getAttribute(WFLTStrutsConstants.MESSAGES_VECTOR);
System.out.println("MESSAGES: " + messagesVector);
if ( messagesVector != null && messagesVector.size() > 0 ) {
	System.out.println("MESSAGES2: " + messagesVector);
	for ( int ii=0; ii < messagesVector.size(); ii++) {
		MessageDescriptor md = (MessageDescriptor) messagesVector.get(ii);
		System.out.println("md: " + md.message);
%>
	parent.jm.addMessage('<%= md.message %>', '<%= md.postDate %>', '<%= md.stepName %>', '<%= md.queue %>');
<%
	}
}
%>
parent.wfFinish(<%= (String) request.getAttribute(WFLTStrutsConstants.WF_JOBID) %>, "<%= (String) request.getAttribute(WFLTStrutsConstants.WF_SERVICE_NAME) %>", "<%= (String) request.getAttribute(WFLTStrutsConstants.WF_SERVICE_PK) %>");
</script>

</head>

<body>
</body>

</html>
