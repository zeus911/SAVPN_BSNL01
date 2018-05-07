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
String datasource = (String) request.getParameter(DL_NetworkElementConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitDL_NetworkElementAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
	exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
	pk = request.getParameter("nnmi_id") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
	_location_ = "network";
}
com.hp.ov.activator.nnmi.dl.inventory.DL_NetworkElement beanDL_NetworkElement = (com.hp.ov.activator.nnmi.dl.inventory.DL_NetworkElement) request.getAttribute(DL_NetworkElementConstants.DL_NETWORKELEMENT_BEAN);
if(beanDL_NetworkElement==null)
   beanDL_NetworkElement = (com.hp.ov.activator.nnmi.dl.inventory.DL_NetworkElement) request.getSession().getAttribute(DL_NetworkElementConstants.DL_NETWORKELEMENT_BEAN);
%>

<script>
	function sendthis(focusthis) {
		window.document.DL_NetworkElementForm.action = '/activator<%=moduleConfig%>/UpdateFormDL_NetworkElementAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
		window.document.DL_NetworkElementForm.submit();
	}
	function confirmCommit() {
		var alert = new HPSAConfirm(
			'<bean:message bundle="CompareDL_CRApplicationResources" key="confirm.comparison.titlemessage"/>',
			'<bean:message bundle="CompareDL_CRApplicationResources" key="confirm.comparison"/>',
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
		window.document.DL_NetworkElementForm.action = '/activator<%=moduleConfig%>/UpdateCommitDL_NetworkElementAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
		window.document.DL_NetworkElementForm.submit();
	}
</script>

<html>
	<head>
		<title><bean:message bundle="DL_NetworkElementApplicationResources" key="<%= DL_NetworkElementConstants.JSP_CREATION_TITLE %>"/></title>
		<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
   		<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
		<script src="/activator/javascript/hputils/alerts.js"></script>
		<style type="text/css">
			A.nodec { text-decoration: none; }
			H1 { color: red; font-size: 13px }
		</style>
		<script>
		var ie = document.all;
		function compare(elem, crindex) {
			var text = ie ? document.getElementById("cr" + crindex).innerText : document.getElementById("cr" + crindex).textContent;
			if (elem.value == text) {
				elem.parentNode.parentNode.style.backgroundColor = crindex % 2 == 0 ? "#cccccc" : "#e3e3e3";
			} else {
				elem.parentNode.parentNode.style.backgroundColor="#ddaaaa";
			}
		}
		function compares(elem, crindex) {
			var text = ie ? document.getElementById("cr" + crindex).innerText : document.getElementById("cr" + crindex).textContent;
			var equals = elem.value == text;
			if (!equals) {
				equals = elem.options[elem.options.selectedIndex].text == text;
			}
			if (equals) {
				elem.parentNode.parentNode.style.backgroundColor = crindex % 2 == 0 ? "#cccccc" : "#e3e3e3";
			} else {
				elem.parentNode.parentNode.style.backgroundColor="#ddaaaa";
			}
		}
		function compareb(elem, crindex) {
			var text = ie ? document.getElementById("cr" + crindex).innerText : document.getElementById("cr" + crindex).textContent;
			if (elem.checked && text == "<bean:message bundle="CompareDL_CRApplicationResources" key="yes" />") {
				elem.parentNode.parentNode.style.backgroundColor = crindex % 2 == 0 ? "#cccccc" : "#e3e3e3";
			} else if (!elem.checked && text == "<bean:message bundle="CompareDL_CRApplicationResources" key="no" />") {
				elem.parentNode.parentNode.style.backgroundColor = crindex % 2 == 0 ? "#cccccc" : "#e3e3e3";
			} else {
				elem.parentNode.parentNode.style.backgroundColor="#ddaaaa";
			}
		}
		function compared(elem, crindex) {
			var text = ie ? document.getElementById("cr" + crindex).innerText : document.getElementById("cr" + crindex).textContent;
			if (Date.parse(elem.value) == Date.parse(text)) {
				elem.parentNode.parentNode.style.backgroundColor = crindex % 2 == 0 ? "#cccccc" : "#e3e3e3";
			} else {
				elem.parentNode.parentNode.style.backgroundColor="#ddaaaa";
			}
		}
		function copyToRight(property, crindex, isBoolean) {
			var text = ie ? document.getElementById("cr" + crindex).innerText : document.getElementById("cr" + crindex).textContent;
			if (isBoolean) {
				if (text == "<bean:message bundle="CompareDL_CRApplicationResources" key="yes" />") {
					document.getElementsByName(property)[0].checked = true;
				} else {
					document.getElementsByName(property)[0].checked = false;
				}
				compareb(document.getElementsByName(property)[0], crindex);
			} else {
				document.getElementsByName(property)[0].value = text;
				if (crindex == 2) {
					compares(document.getElementsByName(property)[0], crindex);
				} else {
					compare(document.getElementsByName(property)[0], crindex);
				}
			}
		}
		</script>
		<script>
		function init() {
			document.getElementsByName("usernameenabled")[0].checked = <%= beanDL_NetworkElement.getUsernameenabled() ? "true" : "false" %>;
			compares(document.getElementsByName("network")[0], 2);
			compare(document.getElementsByName("name")[0], 3);
			compare(document.getElementsByName("description")[0], 4);
			compare(document.getElementsByName("location")[0], 5);
			compare(document.getElementsByName("ip")[0], 6);
			compare(document.getElementsByName("management_ip")[0], 7);
			compare(document.getElementsByName("managementinterface")[0], 8);
			compareb(document.getElementsByName("usernameenabled")[0], 9);
			compare(document.getElementsByName("password")[0], 10);
			compare(document.getElementsByName("enablepassword")[0], 11);
			compare(document.getElementsByName("vendor")[0], 12);
			compare(document.getElementsByName("osversion")[0], 13);
			compare(document.getElementsByName("elementtype")[0], 14);
			compare(document.getElementsByName("serialnumber")[0], 15);
			compare(document.getElementsByName("role")[0], 16);
			compare(document.getElementsByName("adminstate")[0], 17);
			compare(document.getElementsByName("lifecyclestate")[0], 18);
			compare(document.getElementsByName("rocommunity")[0], 19);
			compare(document.getElementsByName("rwcommunity")[0], 20);
			compare(document.getElementsByName("nnmi_uuid")[0], 21);
		}
		</script>
	</head>
	
	<body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;" onload="init()">
	
<%
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
DL_NetworkElementForm form = (DL_NetworkElementForm) request.getAttribute("DL_NetworkElementForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);	
nfB.setMaximumFractionDigits(6);

String NNMi_Id = beanDL_NetworkElement.getNnmi_id();
String Network = beanDL_NetworkElement.getNetwork();
String Name = beanDL_NetworkElement.getName();
String Description = beanDL_NetworkElement.getDescription();
String Location = beanDL_NetworkElement.getLocation();
String IP = beanDL_NetworkElement.getIp();
String Management_IP = beanDL_NetworkElement.getManagement_ip();
String ManagementInterface = beanDL_NetworkElement.getManagementinterface();
boolean UsernameEnabled = new Boolean(beanDL_NetworkElement.getUsernameenabled()).booleanValue();
String Password = beanDL_NetworkElement.getPassword();
String PasswordCurrent = "" + beanDL_NetworkElement.getPasswordCurrent();
String EnablePassword = beanDL_NetworkElement.getEnablepassword();
String EnablePasswordCurrent = "" + beanDL_NetworkElement.getEnablePasswordCurrent();
String Vendor = beanDL_NetworkElement.getVendor();
String OSVersion = beanDL_NetworkElement.getOsversion();
String ElementType = beanDL_NetworkElement.getElementtype();
String SerialNumber = beanDL_NetworkElement.getSerialnumber();
String Role = beanDL_NetworkElement.getRole();
String AdminState = beanDL_NetworkElement.getAdminstate();
String LifeCycleState = beanDL_NetworkElement.getLifecyclestate();
String ROCommunity = beanDL_NetworkElement.getRocommunity();
String RWCommunity = beanDL_NetworkElement.getRwcommunity();
String NNMi_UUId = beanDL_NetworkElement.getNnmi_uuid();
String NNMi_LastUpdate = beanDL_NetworkElement.getNnmi_lastupdate(); NNMi_LastUpdate= NNMi_LastUpdate==null? "": NNMi_LastUpdate;
NNMi_LastUpdate = StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
java.text.SimpleDateFormat sdfNNMi_LastUpdate = beanDL_NetworkElement.get_sdfNNMi_LastUpdate();
String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);
String StateName = beanDL_NetworkElement.getStatename();

com.hp.ov.activator.mwfm.engine.module.dataload.topology.cr.CRNetworkElement crNetworkElement =
	(com.hp.ov.activator.mwfm.engine.module.dataload.topology.cr.CRNetworkElement) request.getAttribute("CR_NE");
%>

<center>
<h2><bean:message bundle="CompareDL_CRApplicationResources" key="jsp.compare.title.ne" /></h2>
</center>

<html:form action="<%= formAction %>">
<center>
<table:table>
	<table:header>
		<table:cell>
        	<bean:message bundle="CompareDL_CRApplicationResources" key="name.heading.dl" />
		</table:cell>
		<table:cell>
			<bean:message bundle="CompareDL_CRApplicationResources" key="value.heading.dl" />
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<bean:message bundle="CompareDL_CRApplicationResources" key="value.heading.cr" />
		</table:cell>
	</table:header>
	<html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_id.alias"/>*
		</table:cell>
		<table:cell>
			<html:hidden property="nnmi_id" value="<%= NNMi_Id %>"/>
			<html:text disabled="true" property="nnmi_id" size="24" value="<%= NNMi_Id %>"/>
		</table:cell>
		<table:cell>&nbsp;</table:cell>
		<table:cell>
			<%= crNetworkElement.getNnmi_id() %>
		</table:cell>
	</table:row>
	<table:row>
		<table:cell>
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.network.alias"/>
		</table:cell>
		<table:cell>
			<html:select property="network" value="<%= Network %>" onchange="compares(this, 2)">
				<html:options collection="NetworkListOfValues" property="value" labelProperty="label" />
			</html:select>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('network', 2, false)"></table:cell>
		<table:cell>
			<span id="cr2"><%= crNetworkElement.getOwnerNetwork() == null ? "" : crNetworkElement.getOwnerNetwork().getName() %></span>
		</table:cell>
	</table:row>
	<script>compares(document.getElementsByName("network")[0], 2);</script>
	<table:row>
		<table:cell>
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.name.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="name" size="24" value="<%= Name %>" onkeyup="compare(this, 3)" onchange="compare(this, 3)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('name', 3, false)"></table:cell>
		<table:cell>
			<span id="cr3"><%= crNetworkElement.getName() == null ? "" : crNetworkElement.getName() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("name")[0], 3);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.description.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="description" size="24" value="<%= Description %>" onkeyup="compare(this, 4)" onchange="compare(this, 4)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('description', 4, false)"></table:cell>
		<table:cell>
			<span id="cr4"><%= crNetworkElement.getDescription() == null ? "" : crNetworkElement.getDescription() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("description")[0], 4);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.location.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="location" size="24" value="<%= Location %>" onkeyup="compare(this, 5)" onchange="compare(this, 5)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('location', 5, false)"></table:cell>
		<table:cell>
<%
String attvalue = "";
try {
	attvalue = crNetworkElement.getLocation();
} catch (Exception e) {
	attvalue = "";
}
%>
			<span id="cr5"><%= attvalue == null ? "" : attvalue %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("location")[0], 5);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.ip.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="ip" size="24" value="<%= IP %>" onkeyup="compare(this, 6)" onchange="compare(this, 6)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('ip', 6, false)"></table:cell>
		<table:cell>
<%
String attvalue = "";
try {
	attvalue = crNetworkElement.getIp();
} catch (Exception e) {
	attvalue = "";
}
%>
			<span id="cr6"><%= attvalue == null ? "" : attvalue %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("ip")[0], 6);</script>
	<table:row>
		<table:cell>
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.management_ip.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="management_ip" size="24" value="<%= Management_IP %>" onkeyup="compare(this, 7)" onchange="compare(this, 7)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('management_ip', 7, false)"></table:cell>
		<table:cell>
<%
String attvalue = "";
try {
	attvalue = crNetworkElement.getManagement_ip();
} catch (Exception e) {
	attvalue = "";
}
%>
			<span id="cr7"><%= attvalue == null ? "" : attvalue %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("management_ip")[0], 7);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.managementinterface.alias"/>
		</table:cell>
		<table:cell>
<%
String selValue=null;
if(ManagementInterface==null||ManagementInterface.trim().equals(""))
	selValue="telnet";
else
	selValue=ManagementInterface.toString();
%>
			<html:select  property="managementinterface" value="<%= selValue %>" onchange="compare(this, 8)">
				<html:option value="telnet" >telnet</html:option>
				<html:option value="ssh" >ssh</html:option>
			</html:select>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('managementinterface', 8, false)"></table:cell>
		<table:cell>
			<span id="cr8"><%= crNetworkElement.getManagementinterface() == null ? "" : crNetworkElement.getManagementinterface() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("managementinterface")[0], 8);</script>
	<!-- 
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.usernameenabled.alias"/>
		</table:cell>
		<table:cell>
			<html:checkbox  property="usernameenabled" value="true" onclick="compareb(this, 9)" onchange="compareb(this, 9)"/>
			<html:hidden  property="usernameenabled" value="false"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('usernameenabled', 9, true)"></table:cell>
		<table:cell>
			<span id="cr9"><% if (crNetworkElement.getUsernameenabled()) { %><bean:message bundle="CompareDL_CRApplicationResources" key="yes" /><% } else { %><bean:message bundle="CompareDL_CRApplicationResources" key="no" /><% } %></span>
		</table:cell>
	</table:row>
	<script>compareb(document.getElementsByName("usernameenabled")[0], 9);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.password.alias"/>
		</table:cell>
		<table:cell>
			<html:password  property="password" size="24" value="<%= Password %>" onkeyup="compare(this, 10)" onchange="compare(this, 10)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('password', 10, false)"></table:cell>
		<table:cell>
			<span id="cr10"><%= crNetworkElement.getPassword() == null ? "" : crNetworkElement.getPassword() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("password")[0], 10);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.enablepassword.alias"/>
		</table:cell>
		<table:cell>
			<html:password  property="enablepassword" size="24" value="<%= EnablePassword %>" onkeyup="compare(this, 11)" onchange="compare(this, 11)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('enablepassword', 11, false)"></table:cell>
		<table:cell>
			<span id="cr11"><%= crNetworkElement.getEnablepassword() == null ? "" : crNetworkElement.getEnablepassword() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("enablepassword")[0], 11);</script>
	 -->
	                                                     <html:hidden property="password" value="<%= Password %>"/>            
								<html:hidden property="passwordcurrent" value="<%= PasswordCurrent %>"/>
				                                            
                                                    <html:hidden property="enablepassword" value="<%= EnablePassword %>"/>            
								<html:hidden property="enablepasswordcurrent" value="<%= EnablePasswordCurrent %>"/>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.vendor.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="vendor" size="24" value="<%= Vendor %>" onkeyup="compare(this, 12)" onchange="compare(this, 12)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('vendor', 12, false)"></table:cell>
		<table:cell>
			<span id="cr12"><%= crNetworkElement.getVendor() == null ? "" : crNetworkElement.getVendor() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("vendor")[0], 12);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.osversion.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="osversion" size="24" value="<%= OSVersion %>" onkeyup="compare(this, 13)" onchange="compare(this, 13)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('osversion', 13, false)"></table:cell>
		<table:cell>
<%
String attvalue = "";
try {
	attvalue = crNetworkElement.getOsversion();
} catch (Exception e) {
e.printStackTrace();
	attvalue = "";
}
%>
			<span id="cr13"><%= attvalue == null ? "" : attvalue %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("osversion")[0], 13);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.elementtype.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="elementtype" size="24" value="<%= ElementType %>" onkeyup="compare(this, 14)" onchange="compare(this, 14)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('elementtype', 14, false)"></table:cell>
		<table:cell>
<%
String attvalue = "";
try {
	attvalue = crNetworkElement.getElementType();
} catch (Exception e) {
	attvalue = "";
}
%>
			<span id="cr14"><%= attvalue == null ? "" : attvalue %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("elementtype")[0], 14);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.serialnumber.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="serialnumber" size="24" value="<%= SerialNumber %>" onkeyup="compare(this, 15)" onchange="compare(this, 15)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('serialnumber', 15, false)"></table:cell>
		<table:cell>
			<span id="cr15"><%= crNetworkElement.getSerialnumber() == null ? "" : crNetworkElement.getSerialnumber()%></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("serialnumber")[0], 15);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.role.alias"/>
		</table:cell>
		<table:cell>
<%
String selValue=null;
if(Role==null||Role.trim().equals(""))
	selValue="PE";
else
	selValue=Role.toString();
%>
			<html:select  property="role" value="<%= selValue %>" onchange="compare(this, 16)">
				<html:option value="PE" >PE</html:option>
				<html:option value="CE" >CE</html:option>
				<html:option value="AccessSwitch" >AccessSwitch</html:option>
				<html:option value="AggregationSwitch" >AggregationSwitch</html:option>
			</html:select>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('role', 16, false)"></table:cell>
		<table:cell>
			<span id="cr16"><%= crNetworkElement.getRole() == null ? "" : crNetworkElement.getRole() %></span>
        </table:cell>
	</table:row>
	<script>compare(document.getElementsByName("role")[0], 16);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.adminstate.alias"/>
		</table:cell>
		<table:cell>
<%
String selValue=null;
if(AdminState==null||AdminState.trim().equals(""))
	selValue="Up";
else
	selValue=AdminState.toString();
%>
			<html:select  property="adminstate" value="<%= selValue %>" onchange="compare(this, 17)">
				<html:option value="Up" >Up</html:option>
				<html:option value="Down" >Down</html:option>
				<html:option value="Unknown" >Unknown</html:option>
				<html:option value="Reserved" >Reserved</html:option>
			</html:select>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('adminstate', 17, false)"></table:cell>
		<table:cell>
			<span id="cr17"><%= crNetworkElement.getAdminstate() == null ? "" : crNetworkElement.getAdminstate() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("adminstate")[0], 17);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.lifecyclestate.alias"/>
		</table:cell>
		<table:cell>
<%
String selValue=null;
if(LifeCycleState==null||LifeCycleState.trim().equals(""))
	selValue="Planned";
else
	selValue=LifeCycleState.toString();
%>
			<html:select  property="lifecyclestate" value="<%= selValue %>" onchange="compare(this, 18)">
				<html:option value="Planned" >Planned</html:option>
				<html:option value="Preconfigured" >Preconfigured</html:option>
				<html:option value="Accessible" >Accessible</html:option>
				<html:option value="Ready" >Ready</html:option>
			</html:select>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('lifecyclestate', 18, false)"></table:cell>
		<table:cell>
			<span id="cr18"><%= crNetworkElement.getLifecyclestate() == null ? "" : crNetworkElement.getLifecyclestate() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("lifecyclestate")[0], 18);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.rocommunity.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="rocommunity" size="24" value="<%= ROCommunity %>" onkeyup="compare(this, 19)" onchange="compare(this, 19)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('rocommunity', 19, false)"></table:cell>
		<table:cell>
			<span id="cr19"><%= crNetworkElement.getRocommunity() == null ? "" : crNetworkElement.getRocommunity()%></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("rocommunity")[0], 19);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.rwcommunity.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="rwcommunity" size="24" value="<%= RWCommunity %>" onkeyup="compare(this, 20)" onchange="compare(this, 20)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('rwcommunity', 20, false)"></table:cell>
		<table:cell>
			<span id="cr20"><%= crNetworkElement.getRwcommunity() == null ? "" : crNetworkElement.getRwcommunity() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("rwcommunity")[0], 20);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_uuid.alias"/>*
		</table:cell>
		<table:cell>
			<html:hidden property="nnmi_uuid" value="<%= NNMi_UUId %>"/>
			<html:text disabled="true" property="nnmi_uuid" size="24" value="<%= NNMi_UUId %>"/>
		</table:cell>
		<table:cell>&nbsp;</table:cell>
		<table:cell>
			<span id="cr21"><%= crNetworkElement.getNnmi_uuid() == null ? "" : crNetworkElement.getNnmi_uuid() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("nnmi_uuid")[0], 21);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_NetworkElementApplicationResources" key="field.nnmi_lastupdate.alias"/>*
		</table:cell>
		<table:cell>
			<html:hidden property="nnmi_lastupdate" value="<%= NNMi_LastUpdate %>"/>
			<html:text disabled="true" property="nnmi_lastupdate" size="24" value="<%= NNMi_LastUpdate %>"/>
		</table:cell>
		<table:cell>&nbsp;</table:cell>
<%
String value = (crNetworkElement.getNnmi_lastupdate_as_date() == null) ? "" : beanDL_NetworkElement.get_sdfNNMi_LastUpdate().format(crNetworkElement.getNnmi_lastupdate_as_date());
%>
		<table:cell>
			<span id="cr22"><%= value %></span>
		</table:cell>
	</table:row>
	<script>compared(document.getElementsByName("nnmi_lastupdate")[0], 22);</script>
	<html:hidden property="statename" value="<%= StateName %>"/>
	<input type=hidden name="__HASH_CODE" value="<%= __HASH_CODE %>">
	<table:row>
		<table:cell colspan="4" align="center">
			<br>
		</table:cell>
	</table:row>
	<table:row>
		<table:cell colspan="4" align="center">
			<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; confirmCommit();">&nbsp;
			<input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset" onclick="setTimeout('init()', 100)">
		</table:cell>
	</table:row>
</table:table>
</center>
</html:form>

</body>
<%
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
<script>
	var alert = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
	alert.setBounds(400, 120);
	alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
	alert.show();
</script>
<%
}
%>
</html>
