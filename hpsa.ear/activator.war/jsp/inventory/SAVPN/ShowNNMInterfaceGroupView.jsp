<%@ page pageEncoding="utf-8"%>

<%@ page import="com.hp.ov.activator.inventory.SAVPN.NNMiInterfaceGroupViewFormAction"%>


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

var protocol = "<%= request.getAttribute(NNMiInterfaceGroupViewFormAction.PROTOCOL) %>";
var host = "<%= request.getAttribute(NNMiInterfaceGroupViewFormAction.HOSTNAME) %>";
var port = "<%= request.getAttribute(NNMiInterfaceGroupViewFormAction.PORT) %>";

var vpn_id = "<%= request.getAttribute(NNMiInterfaceGroupViewFormAction.VPN_ID) %>";
var customer_id = "<%= request.getAttribute(NNMiInterfaceGroupViewFormAction.CUSTOMER_ID) %>";


// NNMi does not allow filtering by IP on INTERFACE's operations. That is why we don't take IP into account in this JSP
var identification_method = "MPLS_VPN_" + customer_id + "_" + vpn_id;

http://iaperf.ind.hp.com:80/nnm/launch?cmd=showView&view=allInterfacesTableView&objtype=InterfaceGroup&ifgroup=MPLS_VPN_1013_1



var operation = "cmd=showView&view=allInterfacesTableView&objtype=InterfaceGroup&ifgroup";

var URL = protocol + "://" + host + ":" + port + "/nnm/launch?" + operation + "=" + identification_method;

//alert(URL);

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
