<%@ page pageEncoding="utf-8"%>

<%@ page
	import="com.hp.ov.activator.cr.struts.na.cl.NAAbstractCrossLaunchAction"%>


<%
  // These lines below prevent catching at the browser and eventual proxy servers
			response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
			response.setHeader("Pragma", "no-cache"); //HTTP 1.0
			response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<html>

<head>

<style type="text/css">
html {
	overflow: hidden;
}
</style>

<script type="text/javascript"
	src="/activator/javascript/CRModel/utils.js"></script>
</head>

<body>

<div id="newDiv" style="text-align: center;"><script
	type="text/javascript">

var URL = "<%=request.getAttribute("URL")%>";

if(isFirefox()){
	 window.open(URL);
	 var rimMenu = window.parent.document.getElementById("rimMenu4");
	 var selected = rimMenu.menu.selectedRim;
	 rimMenu.menu.rims[selected].removeRim();
	}else{
	var newIframe = document.createElement("iframe");
	newIframe.src = URL;
  	newIframe.width="98%";
  	newIframe.height="98%";
  	document.getElementById("newDiv").appendChild(newIframe);
	}
</script></div>

</body>
</html>