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
var name = "<%= request.getAttribute(NNMiAbstractCrossLaunchAction.NNMI_NAME) %>";

var identification_method;

// NNMi does not allow filtering by IP on INTERFACE's operations. That is why we don't take IP into account in this JSP      
if (uuid != "null" && uuid != "") identification_method = "objuuid="+uuid;
else identification_method = "objattrs=name="+name;


var operation = "cmd=showForm&objtype=Interface&menus=true";

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
