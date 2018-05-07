	<%@ page pageEncoding="utf-8"%>

	<%@ page import="java.util.*,
	com.hp.ov.activator.vpn.inventory.*,
	com.hp.ov.activator.inventory.SAVPN.*,
	org.apache.struts.util.LabelValueBean,
	org.apache.struts.action.Action,
	java.text.NumberFormat,
	org.apache.struts.action.ActionErrors,
	com.hp.ov.activator.inventory.facilities.StringFacility " %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
	<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
	<%@ taglib uri = "/WEB-INF/table-taglib.tld" prefix="table" %>
	<%@ taglib uri = "/WEB-INF/button-taglib.tld" prefix="btn" %>

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
	String datasource = (String) request.getParameter(ASBRRateLimitConstants.DATASOURCE);
	String rimid = (String) request.getParameter("rimid");
	String _location_ = (String) request.getParameter("_location_");
	String formAction = "/UpdateCommitASBRRateLimitAction.do?datasource=" + datasource + "&rimid=" + rimid;

	String errorAction = (String)request.getAttribute("ERROR_ACTION");
	String errorMessage = (String)request.getAttribute("ERROR_MESSAGE");
	String exceptionMessage = (String)request.getAttribute("EXCEPTION_MESSAGE");
	if (exceptionMessage==null){
	exceptionMessage="";
	}
	String pk = request.getParameter("_pk_");
	if ( pk == null || pk.equals("") ) {
	pk =  request.getParameter("asbrserviceid") ;
	}

	pk = java.net.URLEncoder.encode( pk ,"UTF-8");


	if ( _location_ == null ) {
	_location_ = "ratelimit";
	}

	%>

	<script>
	function sendthis(focusthis) {
	window.document.ASBRRateLimitForm.action = '/activator<%=moduleConfig%>/UpdateFormASBRRateLimitAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
	window.document.ASBRRateLimitForm.submit();
	}
	function performCommit() {
	window.document.ASBRRateLimitForm.action = '/activator<%=moduleConfig%>/UpdateCommitASBRRateLimitAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
	window.document.ASBRRateLimitForm.submit();
	}
	</script>

	<html>
	<head>
	<title><bean:message bundle="ASBRRateLimitApplicationResources" key="<%= ASBRRateLimitConstants.JSP_CREATION_TITLE %>"/></title>
	<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
	<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
	<script src="/activator/javascript/hputils/alerts.js"></script>
	<style type="text/css">
	A.nodec { text-decoration: none; }
	H1 { color: red; font-size: 13px }
	</style>
	</head>

	<body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;">

	<%

	ASBRRateLimitForm beanASBRRateLimit = (ASBRRateLimitForm) request.getAttribute(ASBRRateLimitConstants.ASBRRATELIMIT_BEAN);
	if(beanASBRRateLimit==null)
	beanASBRRateLimit = (ASBRRateLimitForm) request.getSession().getAttribute(ASBRRateLimitConstants.ASBRRATELIMIT_BEAN);
	String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
	ASBRRateLimitForm form = (ASBRRateLimitForm) request.getAttribute("ASBRRateLimitForm");

	NumberFormat nfA = NumberFormat.getNumberInstance();
	NumberFormat nfB = NumberFormat.getNumberInstance();
	nfB.setMinimumFractionDigits(1);
	nfB.setMaximumFractionDigits(6);

	String ASBRServiceId = beanASBRRateLimit.getAsbrserviceid();


	ArrayList RateLimitArray = 	beanASBRRateLimit.getRlist();
	ArrayList QosArray = 	beanASBRRateLimit.getQlist();

	String RateLimit = beanASBRRateLimit.getRatelimit();
//PR 15820
  boolean sharedVlan = beanASBRRateLimit.getsharedVlan();
  String StrsharedVlan = String.valueOf(sharedVlan);
  String OldRateLimit = beanASBRRateLimit.getOldratelimit();
  String Qos = beanASBRRateLimit.getQos();
  String oldQos = beanASBRRateLimit.getOldqos();
//End of PR 15820
	%>

	<center>
	<h2>
  <!--PR 15820-->
  <logic:equal name="ASBRRateLimit" property="sharedVlan" value="true">
	<bean:message bundle="ASBRRateLimitApplicationResources" key="jsp.modify.title"/>
  </logic:equal>
  <logic:notEqual name="ASBRRateLimit" property="sharedVlan" value="true">
	<bean:message bundle="ASBRRateLimitApplicationResources" key="jsp.update.title"/>
  </logic:notEqual>
  <!--End of PR 15820-->
	</h2>
	</center>

	<H1>
	<html:errors bundle="ASBRRateLimitApplicationResources" property="ASBRServiceId"/>
	<html:errors bundle="ASBRRateLimitApplicationResources" property="RateLimit"/>
	</H1>

	<html:form action="<%= formAction %>">
	<center>
	<table:table>
	<table:header>
	<table:cell>
	<bean:message bundle="InventoryResources" key="name.heading"/>
	</table:cell>
	<table:cell>
	<bean:message bundle="InventoryResources" key="value.heading"/>
	</table:cell>
	<table:cell>
	<bean:message bundle="InventoryResources" key="description.heading"/>
	</table:cell>
	</table:header>

	<html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
	<html:hidden property="oldqos" value="<%= oldQos %>"/>
	<html:hidden property="oldratelimit" value="<%= OldRateLimit %>"/>
	<html:hidden property="jspsharedvlan" value="<%= StrsharedVlan %>"/>

	<table:row>
	<table:cell>
  <!--PR 15820-->
  <logic:equal name="ASBRRateLimit" property="sharedVlan" value="true">
	<bean:message bundle="ASBRRateLimitApplicationResources" key="field.TerminationPointId.alias"/>
	*
  </logic:equal>
  <logic:notEqual name="ASBRRateLimit" property="sharedVlan" value="true">
	<bean:message bundle="ASBRRateLimitApplicationResources" key="field.asbrserviceid.alias"/>
	*
  </logic:notEqual>
	</table:cell>
  <!--End of PR 15820-->
	<table:cell>
	<html:hidden property="asbrserviceid" value="<%= ASBRServiceId %>"/>
	<html:text disabled="true" property="asbrserviceid" size="24" value="<%= ASBRServiceId %>"/>
	</table:cell>
	<table:cell>
  <!--PR 15820-->
  <logic:equal name="ASBRRateLimit" property="sharedVlan" value="true">
	<bean:message bundle="ASBRRateLimitApplicationResources" key="field.TerminationPointId.description"/>
  </logic:equal>
  <logic:notEqual name="ASBRRateLimit" property="sharedVlan" value="true">
	<bean:message bundle="ASBRRateLimitApplicationResources" key="field.asbrserviceid.description"/>
  </logic:notEqual>
  <!--End of PR 15820-->
	</table:cell>
	</table:row>

	<table:row>
	<table:cell>
	<bean:message bundle="ASBRRateLimitApplicationResources" key="field.ratelimit.alias"/>
	</table:cell>

	<table:cell>
	<html:select name="ASBRRateLimitForm" property="ratelimit">
	<html:optionsCollection name="ASBRRateLimitForm" property="rlist"/>
	</html:select>

	</table:cell>
	<table:cell>
	<bean:message bundle="ASBRRateLimitApplicationResources" key="field.ratelimit.description"/>
	</table:cell>
	</table:row>

	<table:row>
	<table:cell>
	<bean:message bundle="ASBRRateLimitApplicationResources" key="field.qos.alias"/>
	</table:cell>

	<table:cell>
	<html:select name="ASBRRateLimitForm" property="qos">
	<html:optionsCollection name="ASBRRateLimitForm" property="qlist"/>
	</html:select>

	</table:cell>
	<table:cell>
	<bean:message bundle="ASBRRateLimitApplicationResources" key="field.qos.description"/>
	</table:cell>
	</table:row>


	<table:row>
	<table:cell colspan="3" align="center">
	<br>
	</table:cell>
	</table:row>
	<table:row>
	<table:cell colspan="3" align="center">
	<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
	<input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
	</table:cell>
	</table:row>
	</table:table>
	</center>
	</html:form>
	</body>
	<%
	if ( _location_ != null ) {
	%>
	<script type="text/javascript">
	document.all("<%=_location_%>").focus();
	</script>
	<%
	}
	if ( errorMessage != null && !errorMessage.equals("") ) {
	%>
	<script>
	var alert = new HPSAAlert('<%= errorAction %>','<bean:message bundle="ASBRRateLimitApplicationResources" key="<%= errorMessage %>"/><br><br>*<bean:message bundle="ASBRRateLimitApplicationResources" key="<%= exceptionMessage %>"/>');
	alert.setBounds(400, 120);
	alert.setButtonText('<bean:message bundle="ASBRRateLimitApplicationResources" key="confirm.ok_button.label"/>');
	alert.show();
	</script>
	<%
	}
	%>
	</html>
