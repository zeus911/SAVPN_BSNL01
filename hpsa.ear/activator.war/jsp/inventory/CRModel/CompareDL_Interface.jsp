<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
				com.hp.ov.activator.nnmi.dl.inventory.*,
				com.hp.ov.activator.inventory.CRModel.*,
				org.apache.struts.util.LabelValueBean,
				org.apache.struts.action.Action,
				java.text.NumberFormat,
				org.apache.struts.action.ActionErrors,
				com.hp.ov.activator.mwfm.engine.module.dataload.topology.cr.CRTerminationPoint,
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
String datasource = (String) request.getParameter(DL_InterfaceConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitDL_InterfaceAction.do?datasource=" + datasource + "&rimid=" + rimid;

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
	_location_ = "name";
}
%>

<script>
	function sendthis(focusthis) {
		window.document.DL_InterfaceForm.action = '/activator<%=moduleConfig%>/UpdateFormDL_InterfaceAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
		window.document.DL_InterfaceForm.submit();
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
		window.document.DL_InterfaceForm.action = '/activator<%=moduleConfig%>/UpdateCommitDL_InterfaceAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
		window.document.DL_InterfaceForm.submit();
	}
</script>

<html>
	<head>
		<title><bean:message bundle="DL_InterfaceApplicationResources" key="<%= DL_InterfaceConstants.JSP_CREATION_TITLE %>"/></title>
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
				elem.parentNode.parentNode.style.backgroundColor = crindex % 2 == 0 ? "#e3e3e3" : "#dddddd";
			} else {
				elem.parentNode.parentNode.style.backgroundColor="#ddaaaa";
			}
		}
		function compared(elem, crindex) {
			var text = ie ? document.getElementById("cr" + crindex).innerText : document.getElementById("cr" + crindex).textContent;
			if (Date.parse(elem.value) == Date.parse(text)) {
				elem.parentNode.parentNode.style.backgroundColor = crindex % 2 == 0 ? "#e3e3e3" : "#dddddd";
			} else {
				elem.parentNode.parentNode.style.backgroundColor="#ddaaaa";
			}
		}
		function copyToRight(property, crindex, isBoolean) {
			var text = ie ? document.getElementById("cr" + crindex).innerText : document.getElementById("cr" + crindex).textContent;
			if (!isBoolean) {
				document.getElementsByName(property)[0].value = text;
				compare(document.getElementsByName(property)[0], crindex);
			}
		}
		</script>
		<script>
		function init() {
			compare(document.getElementsByName("name")[0], 2);
			compare(document.getElementsByName("state")[0], 5);
			compare(document.getElementsByName("type")[0], 6);
			compare(document.getElementsByName("parentif")[0], 7);
			compare(document.getElementsByName("ipaddr")[0], 8);
			compare(document.getElementsByName("subtype")[0], 9);
			compare(document.getElementsByName("encapsulation")[0], 10);
			compare(document.getElementsByName("description")[0], 11);
			compare(document.getElementsByName("ifindex")[0], 12);
			compare(document.getElementsByName("activationstate")[0], 13);
			compare(document.getElementsByName("usagestate")[0], 14);
			compare(document.getElementsByName("vlanid")[0], 15);
			compare(document.getElementsByName("vlanmode")[0], 16);
			compare(document.getElementsByName("dlci")[0], 17);
			compare(document.getElementsByName("timeslots")[0], 18);
			compare(document.getElementsByName("numberofslots")[0], 19);
			compare(document.getElementsByName("bandwidth")[0], 20);
			compare(document.getElementsByName("lmitype")[0], 21);
			compare(document.getElementsByName("intftype")[0], 22);
			compare(document.getElementsByName("bundlekey")[0], 23);
			compare(document.getElementsByName("bundleid")[0], 24);
			compare(document.getElementsByName("nnmi_uuid")[0], 25);
			compared(document.getElementsByName("nnmi_lastupdate")[0], 26);
		}
		</script>
	</head>
	
	<body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;">
	
<%

com.hp.ov.activator.nnmi.dl.inventory.DL_Interface beanDL_Interface = (com.hp.ov.activator.nnmi.dl.inventory.DL_Interface) request.getAttribute(DL_InterfaceConstants.DL_INTERFACE_BEAN);
if(beanDL_Interface==null)
   beanDL_Interface = (com.hp.ov.activator.nnmi.dl.inventory.DL_Interface) request.getSession().getAttribute(DL_InterfaceConstants.DL_INTERFACE_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
DL_InterfaceForm form = (DL_InterfaceForm) request.getAttribute("DL_InterfaceForm");

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);	
nfB.setMaximumFractionDigits(6);

String NNMi_Id = beanDL_Interface.getNnmi_id();
String Name = beanDL_Interface.getName();
String NE_NNMi_Id = beanDL_Interface.getNe_nnmi_id();
String EC_NNMi_Id = beanDL_Interface.getEc_nnmi_id();
String State = beanDL_Interface.getState();
String StateName = beanDL_Interface.getStatename();
String Type = beanDL_Interface.getType();
String ParentIf = beanDL_Interface.getParentif();
String IPAddr = beanDL_Interface.getIpaddr();
String Subtype = beanDL_Interface.getSubtype();
String Encapsulation = beanDL_Interface.getEncapsulation();
String Description = beanDL_Interface.getDescription();
String IFIndex = beanDL_Interface.getIfindex();
String ActivationState = beanDL_Interface.getActivationstate();
String UsageState = beanDL_Interface.getUsagestate();
String VLANId = beanDL_Interface.getVlanid();
String VLANMode = beanDL_Interface.getVlanmode();
String DLCI = beanDL_Interface.getDlci();
String Timeslots = beanDL_Interface.getTimeslots();
String NumberOfSlots = beanDL_Interface.getNumberofslots();
String Bandwidth = beanDL_Interface.getBandwidth();
String LMIType = beanDL_Interface.getLmitype();
String IntfType = beanDL_Interface.getIntftype();
String BundleKey = beanDL_Interface.getBundlekey();
String BundleId = beanDL_Interface.getBundleid();
String NNMi_UUId = beanDL_Interface.getNnmi_uuid();
String NNMi_LastUpdate = beanDL_Interface.getNnmi_lastupdate(); NNMi_LastUpdate= NNMi_LastUpdate==null? "": NNMi_LastUpdate;
NNMi_LastUpdate = StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdate);
java.text.SimpleDateFormat sdfNNMi_LastUpdate = beanDL_Interface.get_sdfNNMi_LastUpdate();
String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
sdfNNMi_LastUpdateDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDesc);

com.hp.ov.activator.mwfm.engine.module.dataload.topology.cr.CRTerminationPoint crTP =
	(com.hp.ov.activator.mwfm.engine.module.dataload.topology.cr.CRTerminationPoint) request.getAttribute("CR_IFACE");
	
	
String parentIfName= (String)request.getAttribute("parentIfName");
%>

<center> 
  <h2>
    <bean:message bundle="CompareDL_CRApplicationResources" key="jsp.compare.title.tp"/>
  </h2> 
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
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.nnmi_id.alias"/>*
		</table:cell>
		<table:cell>
			<html:hidden property="nnmi_id" value="<%= NNMi_Id %>"/>
			<html:text disabled="true" property="nnmi_id" size="24" value="<%= NNMi_Id %>"/>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<%= crTP.getNnmi_id() %>
		</table:cell>
	</table:row>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.name.alias"/>
		</table:cell>
		<table:cell>
		<html:hidden property="name" value="<%= Name %>"/>
			<html:text disabled="true" property="name" size="24" value="<%= Name %>" />
		</table:cell>
	<table:cell>&nbsp;</table:cell>
		<table:cell>
			<span id="cr2"><%= crTP.getName() == null ? "" : crTP.getName() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("name")[0], 2);</script>



			<html:hidden property="ne_nnmi_id" value="<%= NE_NNMi_Id %>"/>
			<html:hidden property="ec_nnmi_id" value="<%= EC_NNMi_Id %>"/>

	
	
	
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.state.alias"/>
		</table:cell>
		<table:cell>
<%
String selValue=null;
if(State==null||State.trim().equals(""))
	selValue="Up";
else
	selValue=State.toString();
%>
			<html:select  property="state" value="<%= selValue %>" onchange="compare(this, 5)">
				<html:option value="Up" >Up</html:option>
				<html:option value="Down" >Down</html:option>
				<html:option value="Unknown" >Unknown</html:option>
			</html:select>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('state', 5, false)"></table:cell>
<%
String attvalue = "";
try {
	attvalue = crTP.getComponentState();
} catch (Exception e) {
	attvalue = "";
}
%>
		<table:cell>
			<span id="cr5"><%= attvalue == null ? "" : attvalue %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("state")[0], 5);</script>
	<html:hidden property="statename" value="<%= StateName %>"/>			
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.type.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="type" size="24" value="<%= Type %>" onkeyup="compare(this, 6)" onchange="compare(this, 6)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('type', 6, false)"></table:cell>
		<table:cell>
			<span id="cr6"><%= crTP.getType() == null ? "" : crTP.getType() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("type")[0], 6);</script>
	
	
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.parentif.alias"/>
		</table:cell>
		<table:cell>
			<input type="text"  size="24" name="parentifname" value="<%= parentIfName == null ? "": parentIfName %>" disabled="true">
		</table:cell>
		<table:cell>&nbsp;</table:cell>
		<table:cell>
			<span id="cr7"><%= crTP.getParentif() == null ? "" : ((CRTerminationPoint)crTP.getOwnerTerminationPoint()).getName() %></span>
		</table:cell>
	</table:row>
		<html:hidden property="parentif" value="<%= ParentIf %>"/>
	<script>compare(document.getElementsByName("parentifname")[0], 7);</script>
	
	
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.ipaddr.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="ipaddr" size="24" value="<%= IPAddr %>" onkeyup="compare(this, 8)" onchange="compare(this, 8)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('ipaddr', 8, false)"></table:cell>
		<table:cell>
			<span id="cr8"><%= crTP.getIpaddr() == null ? "" : crTP.getIpaddr() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("ipaddr")[0], 8);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.subtype.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="subtype" size="24" value="<%= Subtype %>" onkeyup="compare(this, 9)" onchange="compare(this, 9)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('subtype', 9, false)"></table:cell>
		<table:cell>
			<span id="cr9"><%= crTP.getSubtype() == null ? "" : crTP.getSubtype() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("subtype")[0], 9);</script>
	<table:row>
		<table:cell>
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.encapsulation.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="encapsulation" size="24" value="<%= Encapsulation %>" onkeyup="compare(this, 10)" onchange="compare(this, 10)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('encapsulation', 10, false)"></table:cell>
		<table:cell>
			<span id="cr10"><%= crTP.getEncapsulation() == null ? "" : crTP.getEncapsulation() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("encapsulation")[0], 10);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.description.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="description" size="24" value="<%= Description %>" onkeyup="compare(this, 11)" onchange="compare(this, 11)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('description', 11, false)"></table:cell>
		<table:cell>
			<span id="cr11"><%= crTP.getDescription() == null ? "" : crTP.getDescription() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("description")[0], 11);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.ifindex.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="ifindex" size="24" value="<%= IFIndex %>" onkeyup="compare(this, 12)" onchange="compare(this, 12)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('ifindex', 12, false)"></table:cell>
		<table:cell>
			<span id="cr12"><%= crTP.getIfindex() == null ? "" : crTP.getIfindex() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("ifindex")[0], 12);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.activationstate.alias"/>
		</table:cell>
		<table:cell>
<%
String selValue=null;
if(ActivationState==null||ActivationState.trim().equals(""))
	selValue="Activated";
else
	selValue=ActivationState.toString();
%>
			<html:select  property="activationstate" value="<%= selValue %>" onchange="compare(this, 13)">
				<html:option value="Activated" >Activated</html:option>
				<html:option value="Failed" >Failed</html:option>
				<html:option value="Undefined" >Undefined</html:option>
				<html:option value="Ready" >Ready</html:option>
			</html:select>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('activationstate', 13, false)"></table:cell>
		<table:cell>
			<span id="cr13"><%= crTP.getActivationstate() == null ? "" : crTP.getActivationstate() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("activationstate")[0], 13);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.usagestate.alias"/>
		</table:cell>
		<table:cell>
<%
String selValue=null;
if(UsageState==null||UsageState.trim().equals(""))
	selValue="Available";
else
	selValue=UsageState.toString();
%>
			<html:select  property="usagestate" value="<%= selValue %>" onchange="compare(this, 14)">
				<html:option value="Available" >Available</html:option>
				<html:option value="SubIfPresent" >SubIfPresent</html:option>
				<html:option value="Uplink" >Uplink</html:option>
				<html:option value="Reserved" >Reserved</html:option>
				<html:option value="InBundle" >InBundle</html:option>
				<html:option value="Trunk" >Trunk</html:option>
				<html:option value="ASBRLink" >ASBRLink</html:option>
				<html:option value="SwitchPort" >SwitchPort</html:option>
			</html:select>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('usagestate', 14, false)"></table:cell>
		<table:cell>
			<span id="cr14"><%= crTP.getUsagestate() == null ? "" : crTP.getUsagestate() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("usagestate")[0], 14);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.vlanid.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="vlanid" size="24" value="<%= VLANId %>" onkeyup="compare(this, 15)" onchange="compare(this, 15)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('vlanid', 15, false)"></table:cell>
		<table:cell>
			<span id="cr15"><%= crTP.getVlanid() == null ? "" : crTP.getVlanid() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("vlanid")[0], 15);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.vlanmode.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="vlanmode" size="24" value="<%= VLANMode %>" onkeyup="compare(this, 16)" onchange="compare(this, 16)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('vlanmode', 16, false)"></table:cell>
		<table:cell>
			<span id="cr16"><%= crTP.getVlanmode() == null ? "" : crTP.getVlanmode() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("vlanmode")[0], 16);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.dlci.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="dlci" size="24" value="<%= DLCI %>" onkeyup="compare(this, 17)" onchange="compare(this, 17)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('dlci', 17, false)"></table:cell>
		<table:cell>
			<span id="cr17"><%= crTP.getDlci() == null ? "" : crTP.getDlci() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("dlci")[0], 17);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.timeslots.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="timeslots" size="24" value="<%= Timeslots %>" onkeyup="compare(this, 18)" onchange="compare(this, 18)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('timeslots', 18, false)"></table:cell>
		<table:cell>
			<span id="cr18"><%= crTP.getTimeslots() == null ? "" : crTP.getTimeslots() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("timeslots")[0], 18);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.numberofslots.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="numberofslots" size="24" value="<%= NumberOfSlots %>" onkeyup="compare(this, 19)" onchange="compare(this, 19)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('numberofslots', 19, false)"></table:cell>
		<table:cell>
			<span id="cr19"><%= crTP.getNumberofslots() == null ? "" : crTP.getNumberofslots() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("numberofslots")[0], 19);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.bandwidth.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="bandwidth" size="24" value="<%= Bandwidth %>" onkeyup="compare(this, 20)" onchange="compare(this, 20)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('bandwidth', 20, false)"></table:cell>
		<table:cell>
			<span id="cr20"><%= crTP.getBandwidth() == null ? "" : crTP.getBandwidth() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("bandwidth")[0], 20);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.lmitype.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="lmitype" size="24" value="<%= LMIType %>" onkeyup="compare(this, 21)" onchange="compare(this, 21)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('lmitype', 21, false)"></table:cell>
		<table:cell>
			<span id="cr21"><%= crTP.getLmitype() == null ? "" : crTP.getLmitype() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("lmitype")[0], 21);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.intftype.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="intftype" size="24" value="<%= IntfType %>" onkeyup="compare(this, 22)" onchange="compare(this, 22)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('intftype', 22, false)"></table:cell>
		<table:cell>
			<span id="cr22"><%= crTP.getIntftype() == null ? "" : crTP.getIntftype() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("intftype")[0], 22);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.bundlekey.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="bundlekey" size="24" value="<%= BundleKey %>" onkeyup="compare(this, 23)" onchange="compare(this, 23)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('bundlekey', 23, false)"></table:cell>
		<table:cell>
			<span id="cr23"><%= crTP.getBundlekey() == null ? "" : crTP.getBundlekey() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("bundlekey")[0], 23);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.bundleid.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="bundleid" size="24" value="<%= BundleId %>" onkeyup="compare(this, 24)" onchange="compare(this, 24)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('bundleid', 24, false)"></table:cell>
		<table:cell>
			<span id="cr24"><%= crTP.getBundleid() == null ? "" : crTP.getBundleid() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("bundleid")[0], 24);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.nnmi_uuid.alias"/>*
		</table:cell>
		<table:cell>
			<html:hidden property="nnmi_uuid" value="<%= NNMi_UUId %>"/>
			<html:text disabled="true" property="nnmi_uuid" size="24" value="<%= NNMi_UUId %>"/>
		</table:cell>
		<table:cell>&nbsp;</table:cell>
		<table:cell>
			<span id="cr25"><%= crTP.getNnmi_uuid() == null ? "" : crTP.getNnmi_uuid() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("nnmi_uuid")[0], 25);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_InterfaceApplicationResources" key="field.nnmi_lastupdate.alias"/>*
		</table:cell>
		<table:cell>
			<html:hidden property="nnmi_lastupdate" value="<%= NNMi_LastUpdate %>"/>
			<html:text disabled="true" property="nnmi_lastupdate" size="24" value="<%= NNMi_LastUpdate %>"/>
		</table:cell>
		<table:cell>&nbsp;</table:cell>
<%
String value = (crTP.getNnmi_lastupdate() == null) ? "" : beanDL_Interface.get_sdfNNMi_LastUpdate().format(crTP.getNnmi_lastupdate());
%>
		<table:cell>
			<span id="cr26"><%= value %></span>
		</table:cell>
	</table:row>
	<script>compared(document.getElementsByName("nnmi_lastupdate")[0], 26);</script>
	<html:hidden property="__HASH_CODE" value="<%= __HASH_CODE %>"/>
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
