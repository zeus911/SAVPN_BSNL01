<%@ page pageEncoding="utf-8"%>

<%@ page import="com.hp.ov.activator.cr.struts.nnm.cl.NNMiAbstractCrossLaunchAction"%>


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

<script type="text/javascript" src="/activator/javascript/CRModel/utils.js"></script>

</head>

<body>

<div id="newDiv" style="text-align:center;"> 

<script type="text/javascript">

var protocol = "<%= request.getAttribute(NNMiAbstractCrossLaunchAction.PROTOCOL) %>";
var host = "<%= request.getAttribute(NNMiAbstractCrossLaunchAction.HOSTNAME) %>";
var port = "<%= request.getAttribute(NNMiAbstractCrossLaunchAction.PORT) %>";

var uuid = "<%= request.getAttribute(NNMiAbstractCrossLaunchAction.NNMI_UUID) %>";
var ip = "<%= request.getAttribute(NNMiAbstractCrossLaunchAction.NNMI_IP) %>";
var name = "<%= request.getAttribute(NNMiAbstractCrossLaunchAction.NNMI_NAME) %>";


var identification_method;

if (uuid != "null" && uuid != "") identification_method = "objuuid="+uuid;
else if (ip != "null" && ip != "") identification_method = "nodename="+ip;
else identification_method = "nodename="+name;


var operation = "cmd=showLayer3Neighbors&hops=2&menus=true"; 

var URL = protocol + "://" + host + ":" + port + "/nnm/launch?" + operation + "&" + identification_method;

if(isIE7())
  window.open(URL);
else {
  var newIframe = document.createElement("iframe");
  newIframe.src = URL;
  newIframe.width="98%";
  newIframe.height="98%";
  document.getElementById("newDiv").appendChild(newIframe);
}

</script>

</div>


</body>
</html>
