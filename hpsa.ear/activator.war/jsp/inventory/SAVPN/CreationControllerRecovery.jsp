<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
com.hp.ov.activator.cr.inventory.*,
com.hp.ov.activator.vpn.inventory.*,
com.hp.ov.activator.inventory.SAVPN.*,
org.apache.struts.util.LabelValueBean,
org.apache.struts.action.Action,
java.sql.Connection,
java.sql.PreparedStatement,
javax.sql.DataSource,
java.text.NumberFormat,
java.util.Set,
org.apache.struts.action.ActionErrors,
com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet,
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
String datasource = (String) request.getParameter(ControllerRecoveryConstants.DATASOURCE);

String instance = (String) request.getParameter("instance");
String opname = (String)request.getParameter("opname");
String refreshTreeRimid = (String)request.getParameter("refreshTreeRimid");
String tab_name = (String)request.getParameter("tab_name");
String terminationpointid = (String)request.getParameter("terminationpointid");
String vi = (String)request.getParameter("vi");
String view = (String)request.getParameter("view");

String rimid = (String) request.getParameter("rimid");
String location = (String) request.getParameter("_location_");
String formAction = "/CreationCommitControllerRecoveryAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null) {
       exceptionMessage="";
}
if (location == null) {
       location = "sourceinterface";
}

String mode = "";
if (request.getParameter("mode") != null)
{
	if (!"".equals(request.getParameter("mode")))
	{
		mode = request.getParameter("mode"); 
	}
}
else
{
	mode = "initial";
}

boolean targetSelected = false; 

String selectedTargetRegion = "";
if (request.getParameter("targetRegion") != null)
{
	if (!"".equals(request.getParameter("targetRegion")))
	{
		selectedTargetRegion = request.getParameter("targetRegion"); 
	}
}

String selectedTargetNetwork = "";
if (request.getParameter("targetNetwork") != null)
{
	if (!"".equals(request.getParameter("targetNetwork")))
	{
		selectedTargetNetwork = request.getParameter("targetNetwork"); 
	}
}

String selectedTargetPE = "";
if (request.getParameter("targetPE") != null)
{
	if (!"".equals(request.getParameter("targetPE")))
	{
		selectedTargetPE = request.getParameter("targetPE"); 
	}
}

String selectedTargetEC = "";
if (request.getParameter("targetEC") != null)
{
	if (!"".equals(request.getParameter("targetEC")))
	{
		selectedTargetEC = request.getParameter("targetEC");
		mode = "preLoadControllers";
		targetSelected = true;
	}
}

String TargetNetworkName = ""; 
String TargetPEName = ""; 
String TargetECName = ""; 

if (targetSelected)
{
	Connection con = null;

	try 
	{
		DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
			
		if (ds != null) 
		{
			con = ds.getConnection();
			
			com.hp.ov.activator.cr.inventory.Network networkObj = com.hp.ov.activator.cr.inventory.Network.findByNetworkid(con, selectedTargetNetwork);
			TargetNetworkName = networkObj.getName();
			
			com.hp.ov.activator.cr.inventory.NetworkElement neObj = com.hp.ov.activator.cr.inventory.NetworkElement.findByNetworkelementid(con, selectedTargetPE);
			TargetPEName = neObj.getName();
			
			com.hp.ov.activator.cr.inventory.ElementComponent ecObj = com.hp.ov.activator.cr.inventory.ElementComponent.findByElementcomponentid(con, selectedTargetEC);
			TargetECName = ecObj.getName();
		}
	}
	catch(Exception ex) {
		System.out.println("Exception " + ex);
		ex.printStackTrace();
	}
	finally
	{
		if (con != null) 
		{
			try { con.close(); } catch (Exception rollbackex) {}
		}
	}
}

String loadedControllers = "";
if (request.getParameter("loadControllers") != null)
{
	loadedControllers = request.getParameter("loadControllers"); 
	mode = "readyToSubmit";
}

String count = (String) String.valueOf(request.getAttribute("PREVIOUS_EXECUTION_FAILED"));
if ("1".equals(count)) {
       // remove old failed execution
       Connection con = null;
       try {
               DataSource ds = (DataSource)session.getAttribute("datasource");
               if (ds != null) {
                       con = ds.getConnection();
                       PreparedStatement ps = con.prepareStatement(
                               " DELETE FROM V_INTERFACERECOVERED " +
                               " WHERE SOURCETPID = '" + terminationpointid + "' ");
                       ps.executeUpdate();
               }
       }
       catch(Exception e) {}
       finally {
               if (con != null) {
                       try {
                               con.close();
                       } catch (Exception rollbackex) {}
               }
       }
}


com.hp.ov.activator.inventory.SAVPN.ControllerRecoveryBean beanControllerRecovery = (com.hp.ov.activator.inventory.SAVPN.ControllerRecoveryBean) request.getAttribute(ControllerRecoveryConstants.CONTROLLERRECOVERY_BEAN);

ArrayList Services = (ArrayList)beanControllerRecovery.getServices();

String region = beanControllerRecovery.getTargetRegion();
String network = beanControllerRecovery.getTargetNetwork();
Boolean noInterfaces = (Boolean)request.getAttribute(ControllerRecoveryConstants.NO_INTERFACES);
if (noInterfaces != null && noInterfaces)
{
       errorMessage = "search.results.empty";
       exceptionMessage = "There are no interfaces availables for the selected router, please select other.";
}

String TerminationId = StringFacility.replaceAllByHTMLCharacter(beanControllerRecovery.getTerminationid());
String ElementComponentId = StringFacility.replaceAllByHTMLCharacter(beanControllerRecovery.getElementComponentId());
String ElementComponentName = StringFacility.replaceAllByHTMLCharacter(beanControllerRecovery.getElementComponentName());
String SourceNe = StringFacility.replaceAllByHTMLCharacter(beanControllerRecovery.getSourcene());
String SourceNeId = StringFacility.replaceAllByHTMLCharacter(beanControllerRecovery.getSourceneid());
String SourceRegion = StringFacility.replaceAllByHTMLCharacter(beanControllerRecovery.getSourceregion());
String SourceNetwork = StringFacility.replaceAllByHTMLCharacter(beanControllerRecovery.getSourcenetwork());
session.setAttribute("Services", Services);
%>

<script>
function performCommit() {
       if (document.getElementsByName("prevExecFail")[0].value == '1') {
               if (!confirm('<bean:message bundle="ControllerRecoveryApplicationResources" key="previous.execution.failed"/>')) {
                       return;
               }
       }
	   
       var action = '/activator<%=moduleConfig%>/CreationCommitControllerRecoveryAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
       for (i = 0; i < document.getElementsByName("interfacesContainer").length; i++) {
               var sourceInterfaceName = "sourceinterface" + i;
               var targetInterfaceName = "targetinterface" + i;
               action += '&sourceInterface' + i + '=' + document.getElementsByName(sourceInterfaceName)[0].value;
               action += '&targetInterface' + i + '=' + document.getElementsByName(targetInterfaceName)[0].value;
       }
       action += '&interfacesnum=' + i;

       if (window.document.ControllerRecoveryForm.targetNetwork.selectedIndex != 0 &&
               window.document.ControllerRecoveryForm.targetNetwork.selectedIndex != -1 &&
               window.document.ControllerRecoveryForm.targetPE.selectedIndex != 0 &&
			   window.document.ControllerRecoveryForm.targetPE.selectedIndex != -1 &&
			   window.document.ControllerRecoveryForm.targetEC.selectedIndex != 0 &&
			   window.document.ControllerRecoveryForm.targetEC.selectedIndex != -1) {

               window.document.ControllerRecoveryForm.enviando.disabled='true';
               window.document.ControllerRecoveryForm.action = action;
               window.document.ControllerRecoveryForm.submit();
       } else {
               alert('<bean:message bundle="ControllerRecoveryApplicationResources" key="selects.not.empty.router.controller.error"/>');
       }
}

function reload(){
	window.document.ControllerRecoveryForm.action = '/activator<%=moduleConfig%>/CreationFormControllerRecoveryAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&refreshTreeRimid=<%=refreshTreeRimid%>'; 
	window.document.ControllerRecoveryForm.submit();
}

function performReset() {
       window.document.ControllerRecoveryForm.targetRegion.selectedIndex = -1;
       window.document.ControllerRecoveryForm.targetNetwork.selectedIndex = -1;
       window.document.ControllerRecoveryForm.targetPE.selectedIndex = -1;
	   window.document.ControllerRecoveryForm.targetEC.selectedIndex = -1;
}

function goBack()
{
	var mode = "<%=mode%>";

	window.document.ControllerRecoveryForm.targetRegion.value = "";
	window.document.ControllerRecoveryForm.targetNetwork.value = "";
	window.document.ControllerRecoveryForm.targetPE.value = "";
	window.document.ControllerRecoveryForm.targetEC.value = "";
	window.document.ControllerRecoveryForm.mode.value = "initial";

	window.reload();
}

function changeSelect(event) {
       var selectObj = null;
       if (event.target != null) {
               selectObj = event.target.name;
       } else if (event.srcElement != null) {
               selectObj = event.srcElement.name;
       }
       var action = '/activator<%=moduleConfig%>/CreationFormControllerRecoveryAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&instance=<%=instance %>&opname=<%=opname %>&refreshTreeRimid=<%=refreshTreeRimid %>&tab_name=<%=tab_name %>&terminationpointid=<%=terminationpointid %>&vi=<%=vi %>&view=<%=view %>';
       if (selectObj == "targetRegion") {
               document.getElementsByName("targetNetwork")[0].value = "";
               document.getElementsByName("targetPE")[0].value = "";
       } else if (selectObj == "targetNetwork") {
               document.getElementsByName("targetPE")[0].value = "";
       }
       window.document.ControllerRecoveryForm.action = action;
       window.document.ControllerRecoveryForm.submit();
}

function loadControllers() {
	var action = '/activator<%=moduleConfig%>/CreationFormControllerRecoveryAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&instance=<%=instance %>&opname=<%=opname %>&refreshTreeRimid=<%=refreshTreeRimid %>&tab_name=<%=tab_name %>&terminationpointid=<%=terminationpointid %>&vi=<%=vi %>&view=<%=view %>';
    action += '&loadControllers=true';
    //window.document.ControllerRecoveryForm.enviando.disabled='true';
    window.document.ControllerRecoveryForm.action = action;
    window.document.ControllerRecoveryForm.submit();
}
</script>

<html>
<head>
<title><bean:message bundle="ControllerRecoveryApplicationResources" key="<%= ControllerRecoveryConstants.JSP_CREATION_TITLE %>"/></title>
<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
<script src="/activator/javascript/hputils/alerts.js"></script>
<style type="text/css">
A.nodec { text-decoration: none; }
H1 { color: red; font-size: 13px }
</style>
</head>
<body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;">

<center>
  <h2>
    <bean:message bundle="ControllerRecoveryApplicationResources" key="jsp.creation.title"/>
  </h2>
</center>
<H1>
<html:errors bundle="ControllerRecoveryApplicationResources" property="SourceInterface"/>
<html:errors bundle="ControllerRecoveryApplicationResources" property="Services"/>
<html:errors bundle="ControllerRecoveryApplicationResources" property="TargetInterface"/>
</H1>

<html:form action="<%= formAction %>">
<center>

	<html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
	
	<table:table>
		<table:row>
			 <table:cell colspan="3" align="center">
				<% if ("initial".equals(mode)) { %>
					<b><bean:message bundle="ControllerRecoveryApplicationResources" key="message.initialmode"/></b>
				<% } %>
				<% if ("preLoadControllers".equals(mode)) { %>
					<b><bean:message bundle="ControllerRecoveryApplicationResources" key="message.preloadcontrollers"/></b>
				<% } %>
				<% if ("readyToSubmit".equals(mode)) { %>
					<b><bean:message bundle="ControllerRecoveryApplicationResources" key="message.readyToSubmit"/></b>
				<% } %>
			</table:cell>
		</table:row>
	</table:table>
	
	<br>

<table:table>

	<table:header>
		   <table:cell>
				   <bean:message bundle="InventoryResources" key="name.heading"/>
		   </table:cell>
		   <table:cell>
				   <bean:message bundle="InventoryResources" key="sources.heading"/>
		   </table:cell>
		   <table:cell>
				   <bean:message bundle="InventoryResources" key="targets.heading"/>
		   </table:cell>
	</table:header>

	<html:hidden property="elementcomponentid" value="<%= ElementComponentId %>"/>
	<html:hidden property="terminationId" value="<%= TerminationId %>"/>
	<html:hidden property="prevExecFail" value="<%= count %>"/>
	<!-- Regions -->

	<table:row>
		   <table:cell>
				   <bean:message bundle="ControllerRecoveryApplicationResources" key="field.regions.alias"/>*
		   </table:cell>
		   <table:cell>
				   <%= SourceRegion %>
		   </table:cell>
		   <table:cell>
				<% if (targetSelected) { %>
					<%= selectedTargetRegion %>
					<html:hidden property="targetRegion" value="<%= selectedTargetRegion %>"/>
				<% } else { %>
				   <logic:notEmpty name="ControllerRecoveryBean" property="targetRegionOptions">
						   <html:select property="targetRegion" onchange="changeSelect(event)">
								   <html:optionsCollection name="ControllerRecoveryBean" property="targetRegionOptions" />
						   </html:select>
				   </logic:notEmpty>
				   <logic:empty name="ControllerRecoveryBean" property="targetRegionOptions">
						   <html:select property="targetRegion"></html:select>
				   </logic:empty>
				<% } %>
		   </table:cell>
	</table:row>
	<!-- Networks -->
	<table:row>
		   <table:cell>
				   <bean:message bundle="ControllerRecoveryApplicationResources" key="field.networks.alias"/>*
		   </table:cell>
		   <table:cell>
				   <%= SourceNetwork %>
		   </table:cell>
		   <table:cell>
				<% if (targetSelected) { %>
					<%= TargetNetworkName %>
					<html:hidden property="targetNetwork" value="<%= selectedTargetNetwork %>"/>
				<% } else { %>
				   <logic:notEmpty name="ControllerRecoveryBean" property="targetNetworkOptions">
						   <html:select property="targetNetwork" onchange="changeSelect(event)">
								   <html:optionsCollection name="ControllerRecoveryBean" property="targetNetworkOptions" />
						   </html:select>
				   </logic:notEmpty>
				   <logic:empty name="ControllerRecoveryBean" property="targetNetworkOptions">
						   <html:select property="targetNetwork"></html:select>
				   </logic:empty>
				<% } %>
		   </table:cell>
	</table:row>
	<!-- Routers -->
	<table:row>
		   <table:cell>
				   <bean:message bundle="ControllerRecoveryApplicationResources" key="field.routers.alias"/>*
		   </table:cell>
		   <table:cell>
				   <%= SourceNe %>
				   <html:hidden property="sourceneid" value="<%= SourceNeId%>"/>
		   </table:cell>
		   <table:cell>
				<% if (targetSelected) { %>
					<%= TargetPEName %>
					<html:hidden property="targetPE" value="<%= selectedTargetPE %>"/>
				<% } else { %>
				   <logic:notEmpty name="ControllerRecoveryBean" property="targetPEOptions">
						   <html:select property="targetPE" onchange="changeSelect(event)">
								   <html:optionsCollection name="ControllerRecoveryBean" property="targetPEOptions" />
						   </html:select>
				   </logic:notEmpty>
				   <logic:empty name="ControllerRecoveryBean" property="targetPEOptions">
						   <html:select property="targetPE"></html:select>
				   </logic:empty>
				<% } %>
		   </table:cell>
	</table:row>
	<!-- Elements Component -->
	<table:row>
		   <table:cell>
				   <bean:message bundle="ControllerRecoveryApplicationResources" key="field.controllers.alias"/>*
		   </table:cell>
		   <table:cell>
				   <%=ElementComponentName %>
				   <html:hidden property="sourceEC" value="<%= ElementComponentId%>"/>
		   </table:cell>
		   <table:cell>
				<% if (targetSelected) { %>
					<%= TargetECName %>
					<html:hidden property="targetEC" value="<%= selectedTargetEC %>"/>
					<html:hidden property="mode" value="<%= mode %>"/>
				<% } else { %>
				   <logic:notEmpty name="ControllerRecoveryBean" property="targetECOptions">
						   <html:select property="targetEC" onchange="changeSelect(event)">
								   <html:optionsCollection name="ControllerRecoveryBean" property="targetECOptions" />
						   </html:select>
				   </logic:notEmpty>
				   <logic:empty name="ControllerRecoveryBean" property="targetECOptions">
						   <html:select property="targetEC"></html:select>
				   </logic:empty>
				<% } %>
		   </table:cell>
	</table:row>
</table:table>

<% if ("preLoadControllers".equals(mode)) { %>
	
	<br>

	<%
		if (beanControllerRecovery.getSourceControllerOptions().size() == 0) {
	%>
	<table:table>
		<table:header>
		</table:header>
		<table:row>
			   <table:cell colspan="3" align="center">
				   <input type="button" value="<bean:message bundle="InventoryResources" key="confirm.load_controllers.label"/>" onclick="loadControllers();">&nbsp;
				   <input type="button" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonSubmit" onclick="goBack();">
			   </table:cell>
		</table:row>
	</table:table>
	<%
		}
	%>

<% } %>

<% if ("readyToSubmit".equals(mode)) { %>

	<br>
	
	<table:table>
		<table:header>
		   <table:cell>
				   <bean:message bundle="ControllerRecoveryApplicationResources" key="field.e1.name"/>
		   </table:cell>
		   <table:cell>
				   <bean:message bundle="ControllerRecoveryApplicationResources" key="field.framing.name"/>
		   </table:cell>
		   <table:cell>
				   <bean:message bundle="ControllerRecoveryApplicationResources" key="field.clocksource.name"/>
		   </table:cell>
		</table:header>
		
		<%
		Connection con = null;

		try 
		{
			DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
				
			if (ds != null) 
			{
				con = ds.getConnection();
				
				HashMap<String, ControllerInterfaceBean> controllerData = beanControllerRecovery.getSourceControllerOptions();
				
				boolean isSonet = false;
				boolean dataNotAvailable = false;
				
				com.hp.ov.activator.cr.inventory.ElementComponent ecObj = com.hp.ov.activator.cr.inventory.ElementComponent.findByElementcomponentid(con, ElementComponentId);
				com.hp.ov.activator.cr.inventory.ElementComponent parentEcObj = com.hp.ov.activator.cr.inventory.ElementComponent.findByElementcomponentid(con, ecObj.getParentec_id());
				
				String parentEcName = parentEcObj.getName();
				
				if (parentEcName.contains("SONET")) isSonet = true;
				
				com.hp.ov.activator.cr.inventory.NetworkElement neObj = com.hp.ov.activator.cr.inventory.NetworkElement.findByNetworkelementid(con, SourceNeId);
				
				if (isSonet)
				{
					com.hp.ov.activator.cr.inventory.Interface[] interfacesObj = com.hp.ov.activator.cr.inventory.Interface.findByEc_id(con, ElementComponentId);
					
					interfacesObj = interfacesObj != null ? interfacesObj : new com.hp.ov.activator.cr.inventory.Interface[0];
					
					HashMap<Integer, Boolean> e1Found = new HashMap<Integer, Boolean>();
					
					// Initialize e1Found hashmap
					for (int i = 0; i < 64; i++)
					{
						e1Found.put(i, false);
					}
					
					for (int i = 0; i < interfacesObj.length; i++) 
					{
						com.hp.ov.activator.cr.inventory.Interface interfaceObj = interfacesObj[i];
			
						String e1Str = beanControllerRecovery.getE1FromInterfaceName(interfaceObj.getName(), neObj.getVendor(), neObj.getOsversion(), isSonet);
						Integer e1Num = Integer.parseInt(e1Str);
						
						if (e1Found.get(e1Num))
						{
							continue;
						}
						else
						{
							e1Found.put(e1Num, true);
						}
						
						dataNotAvailable = false;
						
						%> 
						<table:row>
						<%
						if (controllerData != null)
						{
							com.hp.ov.activator.inventory.SAVPN.ControllerInterfaceBean contIfBean = controllerData.get(e1Str);
						
							if (contIfBean != null)
							{%>
								<table:cell><%= e1Str %></table:cell>
								<table:cell><%= contIfBean.getFraming() %></table:cell> <input name="framing<%= e1Str %>" type="hidden" value="<%= contIfBean.getFraming() %>">
								<table:cell><%= contIfBean.getClockSource() %></table:cell> <input name="clocksource<%= e1Str %>" type="hidden" value="<%= contIfBean.getClockSource() %>">
							<%}
							else 
							{
								dataNotAvailable = true;
							}
						}
						else
						{
							dataNotAvailable = true;
						}
						
						if (dataNotAvailable)
						{%>
							<table:cell><%= e1Str %></table:cell>
							<table:cell>
								<select name="framing<%= e1Str %>">
									<option value="crc4" >crc4</option>
									<option value="no-crc4" >no-crc4</option>
								<select>
							</table:cell>
							<table:cell>
								<select name="clocksource<%= e1Str %>">
									<option value="internal" >internal</option>
									<option value="line" >line</option>
								</select>
							</table:cell>			
						<%}
					%>
					</table:row>					
					<%}
				}
				else
				{%>
					<table:row>   
					<%
						if (controllerData != null)
						{
							com.hp.ov.activator.inventory.SAVPN.ControllerInterfaceBean contIfBean = controllerData.get(ecObj.getName());
							
							if (contIfBean != null)
							{%>
								<table:cell><%= ecObj.getName() %></table:cell>
								<table:cell><%= contIfBean.getFraming() %></table:cell> <html:hidden property="framing0" value="<%= contIfBean.getFraming() %>"/>
								<table:cell><%= contIfBean.getClockSource() %></table:cell> <html:hidden property="clocksource0" value="<%= contIfBean.getClockSource() %>"/>
							<%}
							else 
							{
								dataNotAvailable = true;
							}
						}
						else
						{
							dataNotAvailable = true;
						}
						
						if (dataNotAvailable)
						{%>
							<table:cell><%= ecObj.getName() %></table:cell>
							<table:cell>
								<select name="framing0">
									<option value="crc4" >crc4</option>
									<option value="no-crc4" >no-crc4</option>
								<select>
							</table:cell>
							<table:cell>
								<select name="clocksource0">
									<option value="internal" >internal</option>
									<option value="line" >line</option>
								</select>
							</table:cell>			
						<%}
					%>
					</table:row>					
					<%
				}	
			}
		}
		catch(Exception ex) {
			System.out.println("Exception " + ex);
			ex.printStackTrace();
		}
		finally 
		{
			if (con != null) 
			{
				try { con.close(); } catch (Exception rollbackex) {}
			}
		}
		%>
				
	</table:table>
	
	<br>
		
	<table:table>
		<table:header>
		</table:header>
		<table:row>
			   <table:cell colspan="3" align="center">
					<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="performCommit();">&nbsp;
					<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonSubmit" onclick="goBack();">
			   </table:cell>
		</table:row>
	</table:table>
	
<% } %>
</center>

</html:form>

</body>
<%
if ( errorMessage != null && !errorMessage.equals("") ) {
	System.out.println("errorMessage: " + errorMessage + " exceptionMessage: " + exceptionMessage);
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
