<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page pageEncoding="utf-8"%>

<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.lang.reflect.Method" %>
<%@ taglib uri = "http://displaytag.sf.net" prefix = "display" %>

<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

ArrayList al = (ArrayList) session.getAttribute(request.getParameter("tabname"));
String[] colnames = (String[]) session.getAttribute(request.getParameter("tabname") + "colnames");
String view = request.getParameter("view");
%>

<html>
<head>
<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
<script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
<script>
function openBranch(pk) {
	var WDW = 3;
	var tabTitle = "<%= view.substring(view.indexOf("||")+2) %>";
	var wdwSelected = true;
	var url = "<%=request.getContextPath()%>/GetPartialTreeInstanceAction.do";
	url += "?ndid=<%= request.getParameter("ndid") %>";
	url += "&vi=<%= request.getParameter("vi") %>";
	url += "&pk=" + pk;
	url += "&view=<%= view %>";
	url += "&rmn=" + WDW;
	parent.parent.addRimToMenu(WDW, tabTitle, wdwSelected, url);
}
function onClickedRow(rowId) {
	openBranch(document.getElementById(rowId).pk);
}
function init() {
<%
final String UND = "undefined";
String rowid = UND;
for (int i = 0; i < al.size(); i++) {
	rowid = UND;
	try {
		Method m = al.get(i).getClass().getMethod("getPrimaryKey", null);
		rowid = (String) m.invoke(al.get(i), null);
	} catch(Exception e) {
		rowid = UND;
	}
%>
	if (document.getElementById("asd_<%= rowid %>")) {
		document.getElementById("asd_<%= rowid %>").pk = "<%= rowid %>";
	}
<%
}
%>
	parent.parent.setSessionAttribute(2, parent.rid, "<%= request.getParameter("tabname") + "colnames" %>");
}
</script>
</head>

<body style="margin0px; padding:0px; overflow:auto; background:#f6f6f6" onload="init();" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<display:table id="asd" style="width:100%"
    name='<%= "sessionScope." + request.getParameter("tabname") %>'
    pagesize="10" export="true" sort="list"
    requestURI='<%="/jsp/inventory-gui/inventory/inventorytree/inventoryTreeSearchResults.jsp?view=" + request.getParameter("view") + "&tabname=" + request.getParameter("tabname") + "&ndid=" + request.getParameter("ndid") + "&vi=" + request.getParameter("vi")%>'
    decorator="com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.taglib.displaytag.decorator.InventoryGUITableDecorator">
<%
for (int i = 0; i < colnames.length; i++) {
%>
	<display:column property="<%= colnames[i].toLowerCase() %>" sortable="true" escapeXml="true"
      title="<%= colnames[i] %>" headerClass="tableTitle" class="tableCell"/>
<%
}
%>
</display:table>
</body>

</html>