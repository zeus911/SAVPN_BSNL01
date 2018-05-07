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
String datasource = (String) request.getParameter(DL_LinkConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitDL_LinkAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
	exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
	pk = request.getParameter("nnmi_id");
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");

if ( _location_ == null ) {
	_location_ = "name";
}
%>

<script>
	function sendthis(focusthis) {
		window.document.DL_LinkForm.action = '/activator<%=moduleConfig%>/UpdateFormDL_LinkAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
		window.document.DL_LinkForm.submit();
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
		window.document.DL_LinkForm.action = '/activator<%=moduleConfig%>/UpdateCommitDL_LinkAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
		window.document.DL_LinkForm.submit();
	}
</script>

<html>
	<head>
		<title><bean:message bundle="DL_LinkApplicationResources" key="<%= DL_LinkConstants.JSP_CREATION_TITLE %>"/></title>
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
			var textb = ie ? document.getElementById("crb" + crindex).innerText : document.getElementById("crb" + crindex).textContent;
			if (elem.value == text) {
				document.getElementById("cr" + crindex).parentNode.style.backgroundColor = crindex % 2 == 0 ? "#cccccc" : "#e3e3e3";
			} else {
				document.getElementById("cr" + crindex).parentNode.style.backgroundColor="#ddaaaa";
			}
			if (elem.value == textb) {
				document.getElementById("crb" + crindex).parentNode.style.backgroundColor = crindex % 2 == 0 ? "#cccccc" : "#e3e3e3";
			} else {
				document.getElementById("crb" + crindex).parentNode.style.backgroundColor="#ddaaaa";
			}
		}
		function compared(elem, crindex) {
			var text = ie ? document.getElementById("cr" + crindex).innerText : document.getElementById("cr" + crindex).textContent;
			var textb = ie ? document.getElementById("crb" + crindex).innerText : document.getElementById("crb" + crindex).textContent;
			if (Date.parse(elem.value) == Date.parse(text)) {
				document.getElementById("cr" + crindex).parentNode.style.backgroundColor = crindex % 2 == 0 ? "#cccccc" : "#e3e3e3";
			} else {
				document.getElementById("cr" + crindex).parentNode.style.backgroundColor="#ddaaaa";
			}
			if (Date.parse(elem.value) == Date.parse(textb)) {
				document.getElementById("crb" + crindex).parentNode.style.backgroundColor = crindex % 2 == 0 ? "#cccccc" : "#e3e3e3";
			} else {
				document.getElementById("crb" + crindex).parentNode.style.backgroundColor="#ddaaaa";
			}
		}
		function copyToRight(property, crindex, isBoolean) {
			var text = ie ? document.getElementById("cr" + crindex).innerText : document.getElementById("cr" + crindex).textContent;
			if (!isBoolean) {
				document.getElementsByName(property)[0].value = text;
				compare(document.getElementsByName(property)[0], crindex);
			}
		}
		function copyToRightB(property, crindex, isBoolean) {
			var textb = ie ? document.getElementById("crb" + crindex).innerText : document.getElementById("crb" + crindex).textContent;
			if (!isBoolean) {
				document.getElementsByName(property)[0].value = textb;
				compare(document.getElementsByName(property)[0], crindex);
			}
		}
		</script>
		<script>
		function init() {
			compare(document.getElementsByName("name")[0], 2);
			compare(document.getElementsByName("type")[0], 7);
			compare(document.getElementsByName("nnmi_uuid")[0], 8);
		}
		</script>
	</head>
	
	<body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;">
	
<%
com.hp.ov.activator.nnmi.dl.inventory.DL_Link beanDL_Link = (com.hp.ov.activator.nnmi.dl.inventory.DL_Link) request.getAttribute(DL_LinkConstants.DL_LINK_BEAN);
if(beanDL_Link==null)
   beanDL_Link = (com.hp.ov.activator.nnmi.dl.inventory.DL_Link) request.getSession().getAttribute(DL_LinkConstants.DL_LINK_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
DL_LinkForm form = (DL_LinkForm) request.getAttribute("DL_LinkForm");

NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);	
nfB.setMaximumFractionDigits(6);

String NNMi_Id = beanDL_Link.getNnmi_id();
String Name = beanDL_Link.getName();
String NE1_NNMi_Id = beanDL_Link.getNe1_nnmi_id();
String TP1_NNMi_Id = beanDL_Link.getTp1_nnmi_id();
String NE2_NNMi_Id = beanDL_Link.getNe2_nnmi_id();
String TP2_NNMi_Id = beanDL_Link.getTp2_nnmi_id();
String Type = beanDL_Link.getType();
String NNMi_UUId = beanDL_Link.getNnmi_uuid();
String NNMi_LastUpdateData = (beanDL_Link.getNnmi_lastupdatedata() == null) ? "" : beanDL_Link.getNnmi_lastupdatedata();
NNMi_LastUpdateData = StringFacility.replaceAllByHTMLCharacter(NNMi_LastUpdateData);
java.text.SimpleDateFormat sdfNNMi_LastUpdateData = new java.text.SimpleDateFormat();
String sdfNNMi_LastUpdateDataDesc = "Format: [" + sdfNNMi_LastUpdateData.toPattern() + "]. Example: [" + sdfNNMi_LastUpdateData.format(new Date()) + "]";
sdfNNMi_LastUpdateDataDesc = StringFacility.replaceAllByHTMLCharacter(sdfNNMi_LastUpdateDataDesc);
String StateName = beanDL_Link.getStatename();

com.hp.ov.activator.mwfm.engine.module.dataload.topology.cr.CRLink crLink =
	(com.hp.ov.activator.mwfm.engine.module.dataload.topology.cr.CRLink) request.getAttribute("CR_LINK");
com.hp.ov.activator.mwfm.engine.module.dataload.topology.cr.CRLink crLink2 =
	(com.hp.ov.activator.mwfm.engine.module.dataload.topology.cr.CRLink) request.getAttribute("CR_LINK2");
%>

<center> 
  <h2>
    <bean:message bundle="CompareDL_CRApplicationResources" key="jsp.compare.title.link"/>
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
			<bean:message bundle="CompareDL_CRApplicationResources" key="value.heading.cr.link1" />
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<bean:message bundle="CompareDL_CRApplicationResources" key="value.heading.cr.link2" />
		</table:cell>
	</table:header>
	<html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_LinkApplicationResources" key="field.nnmi_id.alias"/>*
		</table:cell>
		<table:cell>
			<html:hidden property="nnmi_id" value="<%= NNMi_Id %>"/>
			<html:text disabled="true" property="nnmi_id" size="24" value="<%= NNMi_Id %>"/>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<%= crLink.getNnmi_id() %>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<%= crLink2.getNnmi_id() %>
		</table:cell>
	</table:row>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_LinkApplicationResources" key="field.name.alias"/>
		</table:cell>
		<table:cell>
			<html:text  property="name" size="24" value="<%= Name %>" onkeyup="compare(this, 2)" onchange="compare(this, 2)"/>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRight('name', 2, false)"></table:cell>
		<table:cell>
			<span id="cr2"><%= crLink.getName() == null ? "" : crLink.getName() %></span>
		</table:cell>
		<table:cell><input type="button" value="&lt;&lt;" onclick="copyToRightB('name', 2, false)"></table:cell>
		<table:cell>
			<span id="crb2"><%= crLink2.getName() == null ? "" : crLink2.getName() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("name")[0], 2);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="CompareDL_CRApplicationResources" key="field.ne1_nnmi_name.alias"/>*
		</table:cell>
		<table:cell>
			<html:hidden property="ne1_nnmi_id" value="<%= NE1_NNMi_Id %>"/>
			<html:text disabled="true" property="ne1_nnmi_id" size="24" value="<%= (String) request.getAttribute(\"DL_NE\") %>"/>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<span id="cr3"><%= request.getAttribute("crNE_A1") %></span>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<span id="crb3"><%= request.getAttribute("crNE_B1") %></span>
		</table:cell>
	</table:row>�<script>compare(document.getElementsByName("ne1_nnmi_id")[1], 3);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="CompareDL_CRApplicationResources" key="field.tp1_nnmi_name.alias"/>*
		</table:cell>
		<table:cell>
			<html:hidden property="tp1_nnmi_id" value="<%= TP1_NNMi_Id %>"/>
			<html:text disabled="true" property="tp1_nnmi_id" size="24" value="<%= (String) request.getAttribute(\"DL_TP\") %>"/>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<span id="cr4"><%= request.getAttribute("crTP_A1") %></span>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<span id="crb4"><%= request.getAttribute("crTP_B1") %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("tp1_nnmi_id")[1], 4);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="CompareDL_CRApplicationResources" key="field.ne2_nnmi_name.alias"/>*
		</table:cell>
		<table:cell>
			<html:hidden property="ne2_nnmi_id" value="<%= NE2_NNMi_Id %>"/>
			<html:text disabled="true" property="ne2_nnmi_id" size="24" value="<%= (String) request.getAttribute(\"DL_NE2\") %>"/>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<span id="cr5"><%= request.getAttribute("crNE_A2") %></span>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<span id="crb5"><%= request.getAttribute("crNE_B2") %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("ne2_nnmi_id")[1], 5);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="CompareDL_CRApplicationResources" key="field.tp2_nnmi_name.alias"/>*
		</table:cell>
		<table:cell>
			<html:hidden property="tp2_nnmi_id" value="<%= TP2_NNMi_Id %>"/>
			<html:text disabled="true" property="tp2_nnmi_id" size="24" value="<%= (String) request.getAttribute(\"DL_TP2\") %>"/>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<span id="cr6"><%= request.getAttribute("crTP_A2") %></span>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<span id="crb6"><%= request.getAttribute("crTP_B2") %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("tp2_nnmi_id")[1], 6);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_LinkApplicationResources" key="field.type.alias"/>
		</table:cell>
		<table:cell>
			<html:hidden property="type" value="<%= Type %>"/>
			<html:text disabled="true" property="type" size="24" value="<%= Type %>"/>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<%= crLink.getType() %>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<%= crLink2.getType() %>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("type")[0], 7);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_LinkApplicationResources" key="field.nnmi_uuid.alias"/>*
		</table:cell>
		<table:cell>
			<html:hidden property="nnmi_uuid" value="<%= NNMi_UUId %>"/>
			<html:text disabled="true" property="nnmi_uuid" size="24" value="<%= NNMi_UUId %>"/>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<span id="cr8"><%= crLink.getNnmi_uuid() == null ? "" : crLink.getNnmi_uuid() %></span>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
		<table:cell>
			<span id="crb8"><%= crLink2.getNnmi_uuid() == null ? "" : crLink2.getNnmi_uuid() %></span>
		</table:cell>
	</table:row>
	<script>compare(document.getElementsByName("nnmi_uuid")[0], 8);</script>
	<table:row>
		<table:cell>	
			<bean:message bundle="DL_LinkApplicationResources" key="field.nnmi_lastupdatedata.alias"/>*
		</table:cell>
		<table:cell>
			<html:hidden property="nnmi_lastupdatedata" value="<%= NNMi_LastUpdateData %>"/>
			<html:text disabled="true" property="nnmi_lastupdatedata" size="24" value="<%= NNMi_LastUpdateData %>"/>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
<%
Date d = crLink.getNnmi_lastupdatedata();
String value = "";
try {
	if (d != null) {
		Calendar c = Calendar.getInstance();
		c.setTime((Date) d);
		value +=
			c.get(Calendar.DAY_OF_MONTH) + "/" +
			(c.get(Calendar.MONTH) + 1 < 10 ? "0" + (c.get(Calendar.MONTH) + 1) : c.get(Calendar.MONTH) + 1) + "/" +
			(c.get(Calendar.YEAR) + "").substring(2) + " " +
			c.get(Calendar.HOUR_OF_DAY) + ":" +
			c.get(Calendar.MINUTE);
	}
} catch (Exception e) {
}
%>
		<table:cell>
			<span id="cr9"><%= value %></span>
		</table:cell>
		<table:cell width="25">&nbsp;</table:cell>
<%
Date d2 = crLink2.getNnmi_lastupdatedata();
String value2 = "";
try {
	if (d != null) {
		Calendar c = Calendar.getInstance();
		c.setTime((Date) d2);
		value2 +=
			c.get(Calendar.DAY_OF_MONTH) + "/" +
			(c.get(Calendar.MONTH) + 1 < 10 ? "0" + (c.get(Calendar.MONTH) + 1) : c.get(Calendar.MONTH) + 1) + "/" +
			(c.get(Calendar.YEAR) + "").substring(2) + " " +
			c.get(Calendar.HOUR_OF_DAY) + ":" +
			c.get(Calendar.MINUTE);
	}
} catch (Exception e) {
}
%>
		<table:cell>
			<span id="crb9"><%= value2 %></span>
		</table:cell>
	</table:row>
	<script>compared(document.getElementsByName("nnmi_lastupdatedata")[0], 9);</script>
	<html:hidden property="statename" value="<%= StateName %>"/>
	<html:hidden property="__HASH_CODE" value="<%= __HASH_CODE %>"/>
	<table:row>
		<table:cell colspan="6" align="center">
			<br>
		</table:cell>
	</table:row>
	<table:row>
		<table:cell colspan="6" align="center">
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
