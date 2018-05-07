<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
				com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.ConstantsFTStruts,
				com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.action.WorkflowList,
				com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.action.StringWorkflow,
				com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.ParameterExt; " %> 

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

String title=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("999", "Start Workflow From Inventory");

Integer startingworkflowid=(Integer)request.getSession().getAttribute(ConstantsFTStruts.CURRENT_OPER_WORKFLOW_ID);
WorkflowList wfl = (WorkflowList)request.getSession().getAttribute(ConstantsFTStruts.WORKFLOW_INVENTORY_TREE);
StringWorkflow swf=(StringWorkflow)wfl.workflowlist.get(startingworkflowid);
 

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
  <h2>
     <%= request.getParameter("opname")  %> Result
  </h2> 
</center>

	<center>	
		<html:form   action="/inventory/StartWorkflowSubmitAction.do">
		<html:hidden property="refreshTreeRimid" value='<%= request.getParameter("refreshTreeRimid")  %>'/>
		<html:hidden property="vi" value='<%= request.getParameter("vi")  %>'/>
		<html:hidden property="ndid" value='<%= request.getParameter("ndid")  %>'/>
		<html:hidden property="opname" value='<%= request.getParameter("opname")  %>'/>
		<html:hidden property="<%= ConstantsFTStruts.DATASOURCE %>" value="<%= request.getParameter(ConstantsFTStruts.DATASOURCE) %>"/> 
		<html:hidden property="<%= ConstantsFTStruts.OperationID_URL %>" value="<%= request.getParameter(ConstantsFTStruts.OperationID_URL) %>"/> 
		<html:hidden property="<%= ConstantsFTStruts.CURRENT_OPER_WORKFLOW_ID %>" value="<%= startingworkflowid.toString()%>"/> 

		<table:table>
			<table:header>
			<table:cell>
			</table:cell>
				<table:cell>
					</table:cell>
 			</table:header>

			  
			 <table:row>
 
				<table:cell>
					Workflow Name
				</table:cell>
				<table:cell>
					<%=swf.wkf.name %>
				</table:cell>
 			 </table:row>
			 <table:row>
			 </table:row>
			  <table:row>
				<table:cell>
					JobId
				</table:cell>
				<table:cell>
					<%=swf.jobid %>
				</table:cell>
			 </table:row>

		</table:table>

		</html:form>
	</center>
	 
</body>
</html>

<%
//clean up
wfl.remove(startingworkflowid); 

%>
