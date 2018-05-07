<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
				com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.ConstantsFTStruts; " %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table" %>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn" %>


<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

String title=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("535", "Release Bean");
String maxcntfdtext=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("536", "Unused");
String descriptiontile=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("537", "Units available for reservation");
%>
<script>
	function performCommit() {
		window.document.InventoryTreeForm.submit();
	}
</script>


<html>
<head>
		<title><%=title %></title>
		<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
   		<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
		<script src="/activator/javascript/hputils/alerts.js"></script>
        <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
		<style type="text/css">
			A.nodec { text-decoration: none; }
		</style>
</head>
<body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
	<center>	
		<html:form action="/inventory/InstanceReserveCommitAction.do">
		<html:hidden property="refreshTreeRimid" value='<%= request.getParameter("refreshTreeRimid")  %>'/>
		<html:hidden property="vi" value='<%= request.getParameter("vi")  %>'/>
		<html:hidden property="ndid" value='<%= request.getParameter("ndid")  %>'/>
		<html:hidden property="<%= ConstantsFTStruts.DATASOURCE %>" value="<%= request.getParameter(ConstantsFTStruts.DATASOURCE) %>"/> 
		<html:hidden property="PrimaryKey" value='<%= (String)request.getAttribute("PrimaryKey")  %>'/>
		<html:hidden property="__HASH_CODE" value='<%= (String)request.getAttribute("__HASH_CODE") %>'/>

		<table:table>
			 <table:row>
				 <table:cell colspan="3" align="left">
					<%=maxcntfdtext %>
				</table:cell>
				<table:cell colspan="3" align="left">
					<html:text readonly="true" property="__Current_Count" value='<%= ((Integer)request.getAttribute("__Current_Count")).toString() %>'/>
				</table:cell>
				<table:cell colspan="3" align="left">
					<%=descriptiontile%>
				</table:cell>
			 </table:row>
		</table:table>
		</html:form>
	</center>
	 
</body>
</html>
<% 
String msgtitle=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("510", "Confirm");
String msgtext=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("539", "Are you sure you want to reserve this bean");
String msgaccept=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("508", "Accept");
String msgcancel=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("509", "Cancel");
%>
<script>
			var confirm = new HPSAConfirm('<%=msgtitle%>','<%=msgtext%> ', '<%=msgaccept%>', '<%=msgcancel%>');
			confirm.setAcceptButtonFunction('performCommit()');
			confirm.setCancelButtonFunction('');			
			confirm.setBounds(400, 120);
			confirm.show();
</script>
