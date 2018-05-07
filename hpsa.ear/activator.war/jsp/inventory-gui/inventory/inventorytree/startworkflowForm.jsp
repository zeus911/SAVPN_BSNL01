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
				com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.ParameterExt,
				com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.ParamExtValue,
				com.hp.ov.activator.inventory.facilities.StringFacility; " %> 

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

String input_format_error=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1009", "Warning: Format is wrong!");

Integer startingworkflowid=(Integer)request.getSession().getAttribute(ConstantsFTStruts.CURRENT_OPER_WORKFLOW_ID);
WorkflowList wfl = (WorkflowList)request.getSession().getAttribute(ConstantsFTStruts.WORKFLOW_INVENTORY_TREE);
StringWorkflow swf=(StringWorkflow)wfl.workflowlist.get(startingworkflowid);
 
String errtitle=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("504", "Error");

String errorAction = (String) request.getAttribute(ConstantsFTStruts.ERROR_ACTION);
String errorMessage = (String) request.getAttribute(ConstantsFTStruts.ERROR_MESSAGE);
String exceptionMessage = (String) request.getAttribute(ConstantsFTStruts.EXCEPTION_MESSAGE);

errorMessage=StringFacility.replaceAllByHTMLCharacter(errorMessage);
exceptionMessage=StringFacility.replaceAllByHTMLCharacter(exceptionMessage);

if (exceptionMessage==null){
	exceptionMessage="";
}

%>
<script>
	function performCommit() {
		<%
				if( swf.wkf.paramext!=null) {
			%>	
			var ps=<%=swf.wkf.paramext.length%>;
			for ( j=0 ; j< ps ;  j++ ) {
					var datetype = document.getElementsByName('ParameterExt' +j+ 'dateType').item(0).value;
					var  paramType= document.getElementsByName('ParameterExt' +j+ 'paramType').item(0).value;
					var value ;
					if(paramType != "boolean") {
						value = document.getElementsByName('ParameterExt' +j+ 'value').item(0).value;
					}				
					if(paramType == "int")
					{
						if(!checkInteger(value))
							{
								alert("<%=input_format_error%>");
								return;
							}
					}
					if(paramType == "long")
					{
						if(!checkLong(value))
							{
								alert("<%=input_format_error%>");
								return;
							}
					}
					if(paramType == "float")
					{
						if(!checkFloat(value))
							{
								alert("<%=input_format_error%>");
								return;
							}
					}
					if(paramType == "double")
					{
						if(!checkDouble(value))
							{
								alert("<%=input_format_error%>");
								return;
							}
					}
					if(paramType == "Date")
					{
						//if(!checkDate(value))
							//{
							//	alert("<%=input_format_error%>");
							//	return;
						//	}
					}

			}
 		<%
					}	
		%>
			window.document.InventoryTreeForm.enviando.disabled='true';
			window.document.InventoryTreeForm.submit();
		   
	}
</script>


<html>
<head>
		<title><%=title %></title>
		<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
   		<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
		<script src="/activator/javascript/hputils/alerts.js"></script>
		<script src="/activator/javascript/inventory-gui/inventory/inventorytree/check.js"></script>
        <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
		<style type="text/css">
			A.nodec { text-decoration: none; }
			H1 { color: red; font-size: 13px }
		</style>
</head>
<body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">

<center> 
  <h2>
     <%= request.getParameter("opname")  %>
  </h2> 
</center>

	
		<html:form   action="/inventory/StartWorkflowSubmitAction.do">
		<html:hidden property="refreshTreeRimid" value="<%= request.getParameter(\"refreshTreeRimid\")  %>"/>
		<html:hidden property="vi" value="<%= request.getParameter(\"vi\")  %>"/>
		<html:hidden property="opname" value="<%= request.getParameter(\"opname\")  %>"/>
		<html:hidden property="ndid" value="<%= request.getParameter(\"ndid\")  %>"/>
		<html:hidden property="<%= ConstantsFTStruts.DATASOURCE %>" value="<%= request.getParameter(ConstantsFTStruts.DATASOURCE) %>"/> 
		<html:hidden property="<%= ConstantsFTStruts.OperationID_URL %>" value="<%= request.getParameter(ConstantsFTStruts.OperationID_URL) %>"/> 
		<html:hidden property="<%= ConstantsFTStruts.CURRENT_OPER_WORKFLOW_ID %>" value="<%= startingworkflowid.toString()%>"/> 

		<table:table>
			 <%
				if( swf.wkf.paramext!=null) {
			%>	
				<table:header>
				<table:cell>
					Name
				</table:cell>
				<table:cell>
					Value
				</table:cell>
				<table:cell>
					Description
				</table:cell>
 			</table:header>
			<%
					}	
			%>
			
			 <%
						ParameterExt ext=null;
						if( swf.wkf.paramext!=null) {
						for (int i = 0; i < swf.wkf.paramext.length; i++) {
						
							ext = swf.wkf.paramext[i];
			 %>
			 <table:row>
					<html:hidden  property="<%= \"ParameterExt\" +i+ \"name\" %>" value="<%=ext.name %>"/>

				<table:cell>
					<%=ext.displayName %>
				</table:cell>

					<html:hidden  property="<%= \"ParameterExt\" +i+ \"beanType\" %>" value="<%=ext.beanType %>"/>
					<html:hidden  property="<%= \"ParameterExt\" +i+ \"paramType\" %>" value="<%=ext.paramType %>"/>
					<html:hidden  property="<%= \"ParameterExt\" +i+ \"dateType\" %>" value="<%=ext.dateType %>"/>
					<html:hidden  property="<%= \"ParameterExt\" +i+ \"editable\" %>" value="<%=String.valueOf(ext.editable) %>"/>
					<html:hidden  property="<%= \"ParameterExt\" +i+ \"dropdown\" %>" value="<%=String.valueOf(ext.dropdown) %>"/>

				<table:cell>
					<% 
							if(ext != null && ext.dropdown != null && ext.dropdown) { 
					%>
							<select     name="<%= "ParameterExt" +i+ "value" %>" >
									<%
											if (ext.value!=null) {
													for(int j=0;j<ext.value.length;j++) {
														if (ext.value[j].isDefault) {
									%>	
												<option selected="selected"  value="<%=ext.value[j].value%>"> <%=ext.value[j].value%> </option>
									<% 
													}else{
									%>	
												<option  value="<%=ext.value[j].value%>"> <%=ext.value[j].value%> </option>
									<%
													 }	
											     	}

											 }
									%>
							</select>
					<% 
							}else if (ext.paramType.equals("boolean") ) {
										String checked="";
									    if (ext.value!=null)  {
											if(ext.value.length!=0){
												 if(ext.value[0].value.equals("true")){
													 checked="checked";
												 }
											}
									   	}
					%>
								<input type="checkbox" name="<%= "ParameterExt" +i+ "value" %>"    <%=checked%> >
					<%
							 }else {
								      String value="";
									  if (ext.value!=null)  { if(ext.value.length!=0){  value=ext.value[0].value;	} }
					%>
								<html:text  readonly="<%=!(ext.editable == null || ext.editable) %>"  property="<%= \"ParameterExt\" +i+ \"value\" %>" value="<%=value %>"/>
					<%
								}
					%>
				</table:cell>

				<table:cell>
					<%=  (ext.description==null)? "":ext.description%>
				</table:cell>

			 </table:row>
			  
			 <%
					} //end for
						} //end if
			 %>
			 <table:row>
			 </table:row>
			 <table:row>
				<table:cell colspan="3" align="center">
					<input type="button" value="<bean:message bundle='InventoryResources' key='confirm.ok_button.label'/>" name="enviando" class="ButtonSubmit" onclick="performCommit();">&nbsp;
					 <%
						if( swf.wkf.paramext!=null) {
					%>
							<input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
						<%
								}	
						%>
				</table:cell>
            </table:row>

		</table:table>

		</html:form>
 	 
</body>
</html>
	<%
	if ( errorMessage != null && !errorMessage.equals("") ) {
%>
		<script>
			var alert = new HPSAAlert('<%=errtitle%>','<%= errorMessage %><br><br>*<%= exceptionMessage %>');
			alert.setBounds(400, 120);
			alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
			alert.show();
		</script>
<%
	}
%>
