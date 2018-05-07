<!------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
------------------------------------------------------------------------->
<%@ page import = "com.hp.ov.activator.mwfm.servlet.inventory.wflt.struts.WFLTStrutsConstants" %>

<jsp:useBean id="interactBean" scope="session" class="com.hp.ov.activator.mwfm.servlet.inventory.wflt.struts.interact.interactBean"/>
<jsp:useBean id="spainInventoryBean" scope="session" class="com.hp.ov.activator.mwfm.servlet.inventory.wflt.struts.interact.spainInventoryBean"/>

<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%
interactBean.setJobID((String) request.getAttribute(WFLTStrutsConstants.WF_JOBID));
interactBean.setJobQueue((String) request.getAttribute(WFLTStrutsConstants.WF_JOB_QUEUE));
interactBean.useBean();
spainInventoryBean.setTrue();
String url = "/activator/GenericCheckJobActionWFLT.do";
url += "?" + WFLTStrutsConstants.WF_JOBID + "=" + ((String) request.getAttribute(WFLTStrutsConstants.WF_JOBID));
if (request.getAttribute(WFLTStrutsConstants.WF_SERVICE_NAME) != null) {
	url += "&" + WFLTStrutsConstants.WF_SERVICE_NAME + "=" + ((String) request.getAttribute(WFLTStrutsConstants.WF_SERVICE_NAME));
}
if (request.getAttribute(WFLTStrutsConstants.WF_SERVICE_PK) != null) {
	url += "&" + WFLTStrutsConstants.WF_SERVICE_PK + "=" + ((String) request.getAttribute(WFLTStrutsConstants.WF_SERVICE_PK));
}
spainInventoryBean.setURL(url);
%>

<jsp:include page="checker.jsp" flush="true"/>

<script>
setTimeout("doInteract()", 1000);
running = false;
function doInteract() {
	parent.wfFinish(<%= (String) request.getAttribute(WFLTStrutsConstants.WF_JOBID) %>);
	parent.document.getElementById("fofo").style.visibility = "visible";
	location.href = '/activator/interact';
}
</script>