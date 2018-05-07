<!------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
------------------------------------------------------------------------->
<%@ page import = "com.hp.ov.activator.mwfm.servlet.inventory.wflt.struts.WFLTStrutsConstants" %>

<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%
boolean bReload = new Boolean(request.getParameter("reload")).booleanValue();
%>
<script>
var running = false;
function init() {
	running = true;
	window.setTimeout("reload()" ,3000);
}
function start() {
	parent.wfStart(<%= (String) request.getAttribute(WFLTStrutsConstants.WF_JOBID) %>);
}
function reload() {
	if(running) {
		var url = "/activator/GenericCheckJobActionWFLT.do";
		url += "?rimid=<%= request.getParameter("rimid") %>"
		url += "&<%= WFLTStrutsConstants.WF_JOBID %>=<%= (String) request.getAttribute(WFLTStrutsConstants.WF_JOBID) %>";
<%
if (request.getAttribute(WFLTStrutsConstants.WF_SERVICE_NAME) != null) {
%>
		url += "&<%= WFLTStrutsConstants.WF_SERVICE_NAME %>=<%= (String) request.getAttribute(WFLTStrutsConstants.WF_SERVICE_NAME) %>";
<%
}
if (request.getAttribute(WFLTStrutsConstants.WF_SERVICE_PK) != null) {
%>
		url += "&<%= WFLTStrutsConstants.WF_SERVICE_PK %>=<%= (String) request.getAttribute(WFLTStrutsConstants.WF_SERVICE_PK) %>";
<%
}
%>
		url += "&reload=true";
		location.href = url
	}
}
<%
if (!bReload) {
%>
start();
<%
}
%>
init();
</script>