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
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
</head>
<body>
  
    <script type="text/javascript">
        var falert = new HPSAAlert("ERROR","<%= request.getAttribute(NNMiAbstractCrossLaunchAction.ERROR_MESSAGE.toString()) %>");
        falert.setBounds(400, 120);
        falert.show();
    </script>
  
</body>
</html>
