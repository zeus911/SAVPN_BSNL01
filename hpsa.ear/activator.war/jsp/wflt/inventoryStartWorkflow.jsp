<!------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
------------------------------------------------------------------------->
<%@ page import = "com.hp.ov.activator.mwfm.servlet.inventory.wflt.struts.WFLTStrutsConstants" %>
<%@ page import = "java.util.*" %>
<%@ taglib uri = "/WEB-INF/struts-html.tld" prefix="html" %>
<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%
String wfname = request.getParameter(WFLTStrutsConstants.WF_NAME);
String datasource = request.getParameter(WFLTStrutsConstants.DATASOURCE);
StringBuffer url = new StringBuffer("/activator/CasePacketComposerActionWFLT.do?datasource=" + datasource);
Enumeration e = request.getParameterNames();
boolean first = true;
while (e.hasMoreElements()) {
	url.append("&");
	String paramName = (String) e.nextElement();
	url.append(paramName + "=" + request.getParameter(paramName));
}
%>
<html>
<head>
	<title>Inventory Workflow Starter</title>
	<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
	<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
	<script src="/activator/javascript/hputils/alerts.js"></script>
	<script src="/activator/javascript/wflt/blockingPopup.js"></script>
	<script src="/activator/javascript/wflt/jobMessages.js"></script>
    <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
	<script>
	var rid = eval(<%= request.getParameter("rimid") %>);
	function init(url, wfname) {
		jm = new JobMessages(wfname);
		bp = new BlockingPopup(wfname);
		window.open(url, 'fofo');
	}
	function wfStart(sJobId) {
		bp.addAttribute("Nombre", "");
		bp.addAttribute("Estado", "");
		bp.show();
    }
	function wfStatusUpdate(sJobId, wfName, nodeName) {
		bp.addAttribute("Nombre", wfName);
		bp.addAttribute("Estado", nodeName);
	}
	function wfFinish(sJobId, serviceName, servicePk) {
		parent.refreshParentRimTree(4, rid);
		bp.release();
		jm.setJobId(sJobId);
		jm.setServiceName(serviceName);
		jm.setServicePk(servicePk);
		jm.show();
	}
	function wfError(sJobId, msg) {
		bp.release();
		window.status = msg;
	}
	function wfStartError(sJobId, msg) {
		window.status = msg;
	    var alert = new HPSAAlert('Error', msg);
      	alert.setBounds(400, 120);
      	alert.setButtonText('OK');
      	alert.show();
	}
	</script>
</head>
<body onload="init('<%= url.toString() %>', '<%= wfname %>')" background="/activator/images/inventory-gui/fondo.gif"
  onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<iframe id=fofo name=fofo frameborder="0" style="visibility:hidden; height:100%; width:100%; position:absolute; top:0; left:0"></iframe>
</body>
</html>