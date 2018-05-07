<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
				com.hp.ov.activator.nnmi.dl.inventory.*,
				com.hp.ov.activator.inventory.CRModel.*,
				org.apache.struts.util.LabelValueBean,
				org.apache.struts.action.Action,
				java.text.NumberFormat,
				org.apache.struts.action.ActionErrors,
				com.hp.ov.activator.inventory.facilities.StringFacility " %>

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

%>

<%
/** For Struts module concept **/
org.apache.struts.config.ModuleConfig strutsModuleConfig =
            org.apache.struts.util.ModuleUtils.getInstance().getModuleConfig(null,
                (HttpServletRequest) pageContext.getRequest(),
                pageContext.getServletContext()); 
// module name that can be used as solution name               
String moduleConfig = strutsModuleConfig.getPrefix();
%>

<%
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(DL_ConfigurationConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitDL_ConfigurationActionExt.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
	exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
	pk = request.getParameter("key") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");

if ( _location_ == null ) {
}

boolean readonly = Boolean.valueOf(request.getParameter("readonly")).booleanValue();
if (!readonly) {
%>

<script>
	function sendthis(focusthis) {
		window.document.DL_ConfigurationFormExt.action = '/activator<%=moduleConfig%>/UpdateCommitDL_ConfigurationActionExt.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
		window.document.DL_ConfigurationFormExt.submit();
	}
	function confirmCommit() {
		var alert = new HPSAConfirm(
			'<bean:message bundle="CompareDL_CRApplicationResources" key="confirm.comparison.titlemessage"/>',
			'<bean:message bundle="CompareDL_CRApplicationResources" key="confirm.update"/>',
			'performCommit();',
			'enableOKButton();');
		alert.setBounds(400, 120);
		alert.setAcceptButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
		alert.setCancelButtonText('<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
		alert.show();
	}
	function enableOKButton() {
		document.getElementsByName("enviando")[0].disabled = false;
	}
	function performCommit() {
		window.document.DL_ConfigurationFormExt.action = '/activator<%=moduleConfig%>/UpdateCommitDL_ConfigurationActionExt.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
		window.document.DL_ConfigurationFormExt.submit();
	}
</script>

<%
}

com.hp.ov.activator.nnmi.dl.inventory.DL_Configuration beanDL_Configuration = (com.hp.ov.activator.nnmi.dl.inventory.DL_Configuration) request.getAttribute(DL_ConfigurationConstants.DL_CONFIGURATION_BEAN);
if(beanDL_Configuration==null)
   beanDL_Configuration = (com.hp.ov.activator.nnmi.dl.inventory.DL_Configuration) request.getSession().getAttribute(DL_ConfigurationConstants.DL_CONFIGURATION_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
DL_ConfigurationForm form = (DL_ConfigurationForm) request.getAttribute("DL_ConfigurationFormExt");
String Type;
String XMLConfiguration;
if (beanDL_Configuration != null) {
	Type = beanDL_Configuration.getKey();
	XMLConfiguration = beanDL_Configuration.getValue();
} else {
	Type = form.getKey();
	XMLConfiguration = form.getValue();
	__HASH_CODE = request.getParameter("__HASH_CODE");
}
%>

<html>
<head>
	<title><bean:message bundle="DL_ConfigurationApplicationResources" key="<%= DL_ConfigurationConstants.JSP_CREATION_TITLE %>"/></title>
	<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
	<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
	<script src="/activator/javascript/hputils/alerts.js"></script>
	<script>
	function init() {
<%
if ("OnlyNetworkAttachments".equals(Type) && !readonly) {
%>
		document.forms[0].value[<%= XMLConfiguration.equalsIgnoreCase("true") ? "0" : "1" %>].checked = true;
<%
}
%>
	}
	</script>
	<style type="text/css">
		A.nodec { text-decoration: none; }
		H1 { color: red; font-size: 13px }
	</style>
</head>
	
<body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;" onload="init()">
	
<center> 
  <h2>
<%
if (readonly) {
%>
    <bean:message bundle="DL_ConfigurationApplicationResources" key="jsp.view.title"/>: <%= Type %>
<%
} else {
%>
    <bean:message bundle="DL_ConfigurationApplicationResources" key="jsp.update.title"/>: <%= Type %>
<%
}
%>
  </h2> 
</center>

<html:form action="<%= formAction %>">
<center>
<table:table>
	<table:header>
		<table:cell>
			<%= Type %><% if ("OnlyNetworkAttachments".equals(Type)) { %> - <bean:message bundle="CompareDL_CRApplicationResources" key="only.network.attachments.description" /><% } %>
		</table:cell>
	</table:header>
	<html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
	<html:hidden property="key" value="<%= Type %>"/>
	<input type=hidden name="__HASH_CODE" value="<%= __HASH_CODE %>">
	<table:row>
		<table:cell align="center">
<%
if ("OnlyNetworkAttachments".equals(Type)) {
	if (readonly) {
		if (XMLConfiguration.equalsIgnoreCase("true")) {
%>
		<bean:message bundle="CompareDL_CRApplicationResources" key="yes" />
<%
		} else {
%>
		<bean:message bundle="CompareDL_CRApplicationResources" key="no" />
<%
		}
%>
		
<%
	} else {
%>
		<html:radio property="value" value="true" style="border:0 solid" disabled="<%= readonly %>"/>
		&nbsp;<bean:message bundle="CompareDL_CRApplicationResources" key="yes" />&nbsp;&nbsp;&nbsp;&nbsp;
		<html:radio property="value" value="false" style="border:0 solid" disabled="<%= readonly %>"/>
		&nbsp;<bean:message bundle="CompareDL_CRApplicationResources" key="no" />&nbsp;
<%
	}
}
else {
%>
		<textarea name="value" rows=20 cols=100 <%= readonly ? "readonly" : ""%>><%= (XMLConfiguration == null ? "" : XMLConfiguration ) %></textarea>
<%
}
%>
		</table:cell>
	</table:row>
<%
if (!readonly) {
%>
	<table:row>
		<table:cell align="center">
			<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; confirmCommit();">&nbsp;
			<input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
		</table:cell>
	</table:row>
<%
}
%>
</table:table>
</center>
</html:form>

</body>
<%
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
<script>
	var alert = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="CompareDL_CRApplicationResources" key="<%= errorMessage %>"/>');
	alert.setBounds(400, 120);
	alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
	alert.show();
</script>
<%
}
%>
</html>
