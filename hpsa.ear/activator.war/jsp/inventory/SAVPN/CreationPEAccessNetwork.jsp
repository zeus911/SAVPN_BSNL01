<!------------------------------------------------------------------------
   hp OpenView service activator
   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
------------------------------------------------------------------------->

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
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);
nfB.setMaximumFractionDigits(6);



String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(PEAccessNetworkConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String location = (String) request.getParameter("_location_");
String formAction = "/CreationCommitPEAccessNetworkAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");

%>



<html>
<head>
<title><bean:message bundle="PEAccessNetworkApplicationResources" key="<%= PEAccessNetworkConstants.JSP_CREATION_TITLE %>"/></title>
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

String submit_string = (String)request.getAttribute("submitFlag");

%>
<center>
  <h2>
    <bean:message bundle="PEAccessNetworkApplicationResources" key="jsp.creation.title"/>
  </h2>
</center>

<H1>
<html:errors bundle="PEAccessNetworkApplicationResources" property="ConnectionID"/>
<html:errors bundle="PEAccessNetworkApplicationResources" property="NetworkID1"/>
<html:errors bundle="PEAccessNetworkApplicationResources" property="NetworkName1"/>
<html:errors bundle="PEAccessNetworkApplicationResources" property="PE"/>
<html:errors bundle="PEAccessNetworkApplicationResources" property="NeID1"/>
<html:errors bundle="PEAccessNetworkApplicationResources" property="TerminationPoint1"/>
<html:errors bundle="PEAccessNetworkApplicationResources" property="AccessNetwork"/>
<html:errors bundle="PEAccessNetworkApplicationResources" property="AggregationSwitch"/>
<html:errors bundle="PEAccessNetworkApplicationResources" property="TerminationPoint2"/>
</H1>


<%

if(submit_string == null)
 return;

boolean submitFlag = Boolean.valueOf(submit_string).booleanValue();
if (exceptionMessage==null){
exceptionMessage="";
}
if ( location == null ) {
location = "connectionid";
}
com.hp.ov.activator.inventory.SAVPN.PEAccessNetworkHelperBean beanPEAccessNetwork = (com.hp.ov.activator.inventory.SAVPN.PEAccessNetworkHelperBean) request.getAttribute(PEAccessNetworkConstants.PEACCESSNETWORK_BEAN);
boolean attcahFlag = beanPEAccessNetwork.getAttachpe();
session.setAttribute("attachpe",beanPEAccessNetwork.getAttachpe());

String ConnectionID = StringFacility.replaceAllByHTMLCharacter(beanPEAccessNetwork.getConnectionid());
String Name = StringFacility.replaceAllByHTMLCharacter(beanPEAccessNetwork.getName());
String NetworkID1 = StringFacility.replaceAllByHTMLCharacter(beanPEAccessNetwork.getNetworkid1());
String NetworkName1 = StringFacility.replaceAllByHTMLCharacter(beanPEAccessNetwork.getNetworkname1());
String PE = StringFacility.replaceAllByHTMLCharacter(beanPEAccessNetwork.getPe());
String NeID1 = StringFacility.replaceAllByHTMLCharacter(beanPEAccessNetwork.getNeid1());
String TerminationPoint1 = StringFacility.replaceAllByHTMLCharacter(beanPEAccessNetwork.getTerminationpoint1());
String AccessNetwork = StringFacility.replaceAllByHTMLCharacter(beanPEAccessNetwork.getAccessnetwork());
String AttachDevice = StringFacility.replaceAllByHTMLCharacter(beanPEAccessNetwork.getAttachdevice());
//System.out.println("AttachDevice@@@@@@@@"+AttachDevice);
String AggregationSwitch = StringFacility.replaceAllByHTMLCharacter( beanPEAccessNetwork.getAggregationswitch());
String TerminationPoint2 = StringFacility.replaceAllByHTMLCharacter(beanPEAccessNetwork.getTerminationpoint2());
%>



<script>

function change(val)
{
    window.document.PEAccessNetworkForm.action = '/activator<%=moduleConfig%>/AttachFormPEAccessNetworkAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&attachpe=<%= attcahFlag%>&terminationpoint1='+window.document.PEAccessNetworkForm.terminationpoint1.value+'&change='+val;
    //alert(window.document.PEAccessNetworkForm.action);

window.document.PEAccessNetworkForm.submit();

}

function performCommit() {
window.document.PEAccessNetworkForm.action = '/activator<%=moduleConfig%>/AttachCommitPEAccessNetworkAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
window.document.PEAccessNetworkForm.submit();
}
</script>

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

<table:row>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.connectionid.alias"/>
*
</table:cell>
<table:cell>
<html:text  disabled="true" property="connectionid" size="24"  value="<%= ConnectionID %>"/>
</table:cell>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.connectionid.description"/>
</table:cell>
</table:row>
<html:hidden property="connectionid" value="<%= ConnectionID %>"/>

<input type="hidden" name="Name" value="<%=Name%>">

<html:hidden property="networkid1" value="<%= NetworkID1 %>"/>
<table:row>

<!--Display if Attach PE-->
<logic:equal name="PEAccessNetwork" property="attachpe" value="true">
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.networkname1.alias"/>
</table:cell>
<table:cell>
<html:text  disabled="true" property="networkname1" size="24" value="<%= NetworkName1 %>"/>
</table:cell>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.networkname1.description"/>
</table:cell>
</logic:equal>

<!-- Display if Attach AGSwitch-->
<logic:equal name="PEAccessNetwork" property="attachpe" value="false">
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.aggregationswitch.alias"/>
</table:cell>
<table:cell>
<html:text  disabled="true" property="networkname1" size="24" value="<%= PE%>"/>
</table:cell>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.aggregationswitch.description"/>
</table:cell>
</logic:equal>

</table:row>


<!--Display only if Attach PE-->
<logic:equal name="PEAccessNetwork" property="attachpe" value="true">
<table:row>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.pe.alias"/>
</table:cell>
<table:cell>
<html:text disabled="true"  property="pe" size="24" value="<%= PE %>"/>
</table:cell>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.pe.description"/>
</table:cell>
</table:row>
</logic:equal>



<html:hidden property="neid1" value="<%= NeID1 %>"/>
<table:row>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.terminationpoint1.alias"/>
</table:cell>
<table:cell>
<html:select  property="terminationpoint1" value="<%TerminationPoint1%>" >
<html:optionsCollection name="PEAccessNetwork" property="terminationpoint1list" />
</html:select>
</table:cell>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.terminationpoint1.description"/>
</table:cell>
</table:row>

<!--Display only if Attach PE-->
<logic:equal name="PEAccessNetwork" property="attachpe" value="true">
<table:row>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.portmode.alias" />
</table:cell>
<table:cell>
<html:select property="portmode">
    <html:option value="Trunk">SubInterface</html:option>
    <html:option value="SwitchPort">SwitchPort</html:option>
</html:select>
</table:cell>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.portmode.description" />
</table:cell>
</table:row>
</logic:equal>

<table:row>


<!--Display only if Attach PE-->
<logic:equal name="PEAccessNetwork" property="attachpe" value="true">
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.accessnetwork.alias"/>
</table:cell>
<table:cell>
<html:select  property="accessnetwork" value="<% AccessNetwork%>" onchange="change('true')">
<html:optionsCollection name="PEAccessNetwork" property="accessnetworklist"/>
</html:select>
</table:cell>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.accessnetwork.description"/>
</table:cell>
</logic:equal>

<!-- Display if Attach AGSwitch-->
<logic:equal name="PEAccessNetwork" property="attachpe" value="false">
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.topology.alias"/>
</table:cell>
<table:cell>
<html:select  property="accessnetwork" value="<% AccessNetwork%>" onchange="change('true')">
<html:optionsCollection name="PEAccessNetwork"  property="accessnetworklist" label="label"/>
</html:select>
</table:cell>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.topology.description"/>
</table:cell>
</logic:equal>

</table:row>
<table:row>


<!--Display only if Attach PE-->
<logic:equal name="PEAccessNetwork" property="attachpe" value="true">
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.aggregationswitch.alias"/>
</table:cell>
<table:cell>
<html:select  property="aggregationswitch" value="<% AggregationSwitch%>" onchange="change('false')">
<html:optionsCollection name="PEAccessNetwork" property="aggregationswitchlist"/>
</html:select>
</table:cell>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.aggregationswitch.description"/>
</table:cell>
</logic:equal>

<!-- Display if Attach AGSwitch-->
<logic:equal name="PEAccessNetwork" property="attachpe" value="false">
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.accessswitch.alias"/>
</table:cell>
<table:cell>
<html:select  property="aggregationswitch" value="<% AggregationSwitch%>" onchange="change('false')">
<html:optionsCollection name="PEAccessNetwork" property="aggregationswitchlist"/>
</html:select>
</table:cell>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.accessswitch.description"/>
</table:cell>
</logic:equal>

</table:row>
<table:row>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.terminationpoint2.alias"/>
</table:cell>
<table:cell>
<html:select  property="terminationpoint2" value="<% TerminationPoint2%>">
<html:optionsCollection name="PEAccessNetwork" property="terminationpoint2list"/>
</html:select>
</table:cell>
<table:cell>
<bean:message bundle="PEAccessNetworkApplicationResources" key="field.terminationpoint2.description"/>
</table:cell>
</table:row>


<table:row>
<table:cell colspan="3" align="center">
<br>
</table:cell>
</table:row>
<table:row>
<table:cell colspan="3" align="center">
<%
if(submitFlag)
{
    %>
<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
<input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
<%}%>
</table:cell>
</table:row>
</table:table>
</center>
</html:form>

</body>
<%

if ( location != null ) {
%>

<script type="text/javascript">
document.all("<%=location%>").focus();
</script>
<%
}
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
<script>
var alertMsg = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
alertMsg.setBounds(400, 120);
alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
alertMsg.show();
</script>
<%
}
%>

</html>
