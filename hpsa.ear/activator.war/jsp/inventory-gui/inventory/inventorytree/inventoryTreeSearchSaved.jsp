<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
                com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.ConstantsFTStruts,
                com.hp.ov.activator.inventory.views.TreeViewStructure" %>

<%
String title=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1291", "Stored Search");
TreeViewStructure tvs = (TreeViewStructure)session.getAttribute("treeView_structure");
boolean classic_inventory_view = ((Boolean) request.getSession().getAttribute("classic_inventory_view")).booleanValue();
boolean hasClassView = InventoryTreeServlet.hasAllowClassView();
String contextPath = request.getContextPath();
int color = 0;
%>

<%@page import="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.TreeViewStructureCodeWriter"%>
<%@page import="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet"%>
<html>
<head>
  <title><%=title%></title>
  <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
  <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
  <script src="/activator/javascript/hputils/alerts.js"></script>
  <script>
  var useRandomColor = false;
  </script>
  <script src="/activator/javascript/inventory-gui/constants.js"></script>
  <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
  <style type="text/css">
      A.nodec { text-decoration: none; }
  </style>
</head>
<body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
</body>
</html>

<%
String msgtitle=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("510", "Confirm");
String msgOk=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("505", "OK");
String msg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1292", "Search stored succesfully");
%>
<script>
function reloadGeneralMenu() {
<%
if (tvs != null) {
%>
    <%= TreeViewStructureCodeWriter.writeMenus(tvs, contextPath, hasClassView, classic_inventory_view, color) %>
<%
}
%>
}
var falert = new HPSAAlert("<%=msgtitle%>","<%=msg%>");
falert.setBounds(400, 120);
falert.setButtonText("<%=msgOk%>");
falert.show();
reloadGeneralMenu();
</script>
