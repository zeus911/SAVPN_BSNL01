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

<jsp:include page="checker.jsp" flush="true"/>

<script>
parent.wfError(<%= (String) request.getAttribute(WFLTStrutsConstants.WF_JOBID) %>, "<%= (String) request.getAttribute(WFLTStrutsConstants.WF_ERROR) %>");
</script>