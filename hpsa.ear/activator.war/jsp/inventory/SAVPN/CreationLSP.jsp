<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
		com.hp.ov.activator.cr.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors,
		java.sql.*,
		java.util.*,
java.sql.Connection,
java.text.NumberFormat,javax.sql.DataSource,com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet,
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
String datasource = (String) request.getParameter(LSPConstants.DATASOURCE);
String refreshTreeRimid = (String) request.getParameter("refreshTreeRimid");
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}

String isMultiDelete = "false";
if ( request.getParameter("ismulti") != null ) {
isMultiDelete = request.getParameter("ismulti");
}

String isManual = "empty";
if ( request.getParameter("vpnid") != null ) {
isManual = request.getParameter("vpnid");
                                                                                                            }

%>

<% 	// LSP Multiple deletion 
	if ("true".equals(isMultiDelete)) {%>
<html>
  <head>
		<title><bean:message bundle="InventoryResources" key="title.delete_lsps"/></title>

    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
		  
		  td {
			FONT-SIZE: 8pt; COLOR: black; FONT-FAMILY: Arial, Helvetica, Sans-serif
		  }
    </style>
    <script>
			function performCommit() {
				window.document.LSPForm.action = '/activator<%=moduleConfig%>/DeleteCommitLSPAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.LSPForm.submit();
    }

			function reload(){
				window.document.LSPForm.action = '/activator<%=moduleConfig%>/CreationFormLSPAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&refreshTreeRimid=<%=refreshTreeRimid%>'; 
      window.document.LSPForm.submit();
    }
    function init()
    {
<%
if ( _location_ != null ) {
%>
      var elems = document.getElementsByName("<%=_location_%>");
      var elem = elems == null || elems.length == 0 ? null : elems[0];
      if (elem != null) {
        elem.focus();
      }
<%
}
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
					var alert = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
					alert.setBounds(400, 120);
					alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
					alert.show();
					<%
				}
				%>
			}
		 function confirmSubmit() {
			var checkboxes=document.getElementsByName("lspid");
			var okay=false;
			
			// Check whether there is at least one LSP checked
			for(var i=0,l=checkboxes.length;i<l;i++)
			{
				if(checkboxes[i].checked)
				{
					okay=true;
				}
			}
			
			if(okay)
			{
			  var confirm = new HPSAConfirm('Confirm','<bean:message bundle="LSPApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
			  confirm.setAcceptButtonFunction('performCommit()');
			  confirm.setCancelButtonFunction('');      
			  confirm.setBounds(400, 120);
			  confirm.show();
			}
			else 
			{
			  var alertMsg = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="warning.delete_lsps.nolspselected"/>');
      alertMsg.setBounds(400, 120);
      alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
      alertMsg.show();
}
		 }

		function toggle(source) {
		  var checkboxes = document.getElementsByName('lspid');
		  
		  for(var i=0,l=checkboxes.length;i<l;i++)
		  {
			checkboxes[i].checked = source.checked;
		  }
    }
    </script>
  </head>
	  
  <body style="overflow:auto;" onload="init();">
	    
<%

String filterup = ""; 
if (request.getParameter("filterup") != null)
{
	filterup = request.getParameter("filterup");
}

String filterdown = "";
if (request.getParameter("filterdown") != null)
{
	filterdown = request.getParameter("filterdown");
}

          
String prevUsageMode = ""; 
if (request.getParameter("usagemodehidden") != null)
{
	prevUsageMode = request.getParameter("usagemodehidden");
}

String usageMode = "";
if (request.getParameter("usagemode") != null)
{	
	usageMode = request.getParameter("usagemode");
	
	if (!(usageMode.equals(prevUsageMode)))
	{
		filterup = "filterup";
		filterdown = "filterdown";
	}
}


String vpnid = ""; 
if ((("Service".equals(usageMode)) || ("Manual".equals(usageMode))) && (request.getParameter("vpnid") != null))
{
	vpnid = request.getParameter("vpnid");
}
String vpnName = "";

String networkid = ""; 
if (request.getParameter("networkid") != null)
{
	networkid = request.getParameter("networkid");
}
String networkName = "";

Connection con = null;
         
com.hp.ov.activator.vpn.inventory.LSP[] LSPList = null;
com.hp.ov.activator.cr.inventory.Network[] networkList = null;
      
try
{
	DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
	if (ds != null)
	{
		con = ds.getConnection();

		// Get Network list
		if ("Aggregated".equals(usageMode))
		{
			String whereClause = "CRModel#Network.Type='Network'";
			networkList = com.hp.ov.activator.cr.inventory.Network.findAll(con,whereClause);
		}
		
		// Get Network name if exists
		if (!("".equals(networkid)))
		{
			com.hp.ov.activator.cr.inventory.Network networkObject = com.hp.ov.activator.cr.inventory.Network.findByNetworkid(con,networkid);
			networkName = networkObject.getName();
		}
		
		// Get LSP list
		if (("".equals(vpnid)) || ("Aggregated".equals(usageMode)))
		{
			String whereClause;
			
			if (("Aggregated".equals(usageMode)) && !("".equals(networkid))) 
			{
				whereClause = "usagemode='"+usageMode+"' ";
				whereClause += "and (headpe IN (select cr_networkelement.networkelementid from cr_networkelement where cr_networkelement.networkid='"+networkid+"') ";
				whereClause += "or tailpe IN (select cr_networkelement.networkelementid from cr_networkelement where cr_networkelement.networkid='"+networkid+"'))";
			}
			else if ((("Service".equals(usageMode)) || ("Manual".equals(usageMode))) && !("".equals(filterup)) && !("".equals(filterdown)))
			{
				whereClause = "usagemode='"+usageMode+"' and (adminstate='Up' or adminstate='Down')";
			}
			else if ((("Service".equals(usageMode)) || ("Manual".equals(usageMode))) && !("".equals(filterup)) && ("".equals(filterdown)))
			{
				whereClause = "usagemode='"+usageMode+"' and adminstate='Up'";
			}
			else if ((("Service".equals(usageMode)) || ("Manual".equals(usageMode))) && ("".equals(filterup)) && !("".equals(filterdown)))
			{
				whereClause = "usagemode='"+usageMode+"' and adminstate='Down'";
			}
			else
			{
				whereClause = "usagemode='"+usageMode+"' and adminstate<>'Deleted'";
			}
			
			if (!((("Service".equals(usageMode)) || ("Manual".equals(usageMode))) && ("".equals(filterup)) && ("".equals(filterdown))))
			{
				LSPList = com.hp.ov.activator.vpn.inventory.LSP.findAll(con,whereClause);
			}
		}
		else
		{
			String whereClause;
			
			if ((("Service".equals(usageMode)) || ("Manual".equals(usageMode))) && !("".equals(filterup)) && !("".equals(filterdown)))
			{
				whereClause = "usagemode='"+usageMode+"' and (adminstate='Up' or adminstate='Down')";
				LSPList = com.hp.ov.activator.vpn.inventory.LSP.findByLsp_vpnid(con,vpnid);
			}
			else if ((("Service".equals(usageMode)) || ("Manual".equals(usageMode))) && !("".equals(filterup)) && ("".equals(filterdown)))
			{
				whereClause = "usagemode='"+usageMode+"' and adminstate='Up'";
				LSPList = com.hp.ov.activator.vpn.inventory.LSP.findByLsp_vpnid(con,vpnid,whereClause);
			}
			else if ((("Service".equals(usageMode)) || ("Manual".equals(usageMode))) && ("".equals(filterup)) && !("".equals(filterdown)))
			{
				whereClause = "usagemode='"+usageMode+"' and adminstate='Down'";
				LSPList = com.hp.ov.activator.vpn.inventory.LSP.findByLsp_vpnid(con,vpnid,whereClause);
			}
			else
			{
				// EMPTY LIST
			}
		}
		
		// Get VPN name if exists
		if (!("".equals(vpnid)))
		{
			com.hp.ov.activator.vpn.inventory.Service serviceObject = com.hp.ov.activator.vpn.inventory.Service.findByServiceid(con,vpnid);
			
			if (serviceObject != null)
			{
				vpnName = serviceObject.getServicename();
			}
		}
	}             
}
catch(Exception e)
{
	System.out.println("Exception getting LSP from database: "+e);
}
finally
{
	if (con != null)
	{
		try 
		{
			con.close();
		}
		catch (Exception rollbackex)
		{
			// Ignore
		}
	}
}
%>
<center> 
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="InventoryResources" key="title.delete_lsps"/>
</h2> 
</center>


<H1>
		<html:errors bundle="PERouterApplicationResources" property="NetworkElementID" /> 
		<html:errors bundle="PERouterApplicationResources" property="NetworkID" /> 
        <html:errors bundle="PERouterApplicationResources" property="Name"/>
        <html:errors bundle="PERouterApplicationResources" property="Description"/>
        <html:errors bundle="PERouterApplicationResources" property="Location"/>
        <html:errors bundle="PERouterApplicationResources" property="IP"/>
		<html:errors bundle="PERouterApplicationResources" property="management_IP" />
        <html:errors bundle="PERouterApplicationResources" property="ManagementInterface"/>
        <html:errors bundle="PERouterApplicationResources" property="UsernameEnabled"/>
        <html:errors bundle="PERouterApplicationResources" property="Username"/>
        <html:errors bundle="PERouterApplicationResources" property="Password"/>
        <html:errors bundle="PERouterApplicationResources" property="EnablePassword"/>
        <html:errors bundle="PERouterApplicationResources" property="Vendor"/>
		<html:errors bundle="PERouterApplicationResources" property="OSversion" />
        <html:errors bundle="PERouterApplicationResources" property="ElementType"/>
        <html:errors bundle="PERouterApplicationResources" property="SerialNumber"/>
        <html:errors bundle="PERouterApplicationResources" property="Role"/>
		<html:errors bundle="PERouterApplicationResources" property="State" />
        <html:errors bundle="PERouterApplicationResources" property="LifeCycleState"/>
        <html:errors bundle="PERouterApplicationResources" property="Backup"/>
        <html:errors bundle="PERouterApplicationResources" property="SchPolicyName"/>
        <html:errors bundle="PERouterApplicationResources" property="ROCommunity"/>
        <html:errors bundle="PERouterApplicationResources" property="RWCommunity"/>
		<html:errors bundle="PERouterApplicationResources" property="BGPDiscovery" />
        <html:errors bundle="PERouterApplicationResources" property="Tier"/>
      <html:errors bundle="LSPApplicationResources" property="LSPId"/>
        <html:errors bundle="LSPApplicationResources" property="TunnelId"/>
        <html:errors bundle="LSPApplicationResources" property="headPE"/>
        <html:errors bundle="LSPApplicationResources" property="headPEName"/>
        <html:errors bundle="LSPApplicationResources" property="tailPE"/>
        <html:errors bundle="LSPApplicationResources" property="tailPEName"/>
        <html:errors bundle="LSPApplicationResources" property="headIP"/>
        <html:errors bundle="LSPApplicationResources" property="tailIP"/>
        <html:errors bundle="LSPApplicationResources" property="headVPNIP"/>
        <html:errors bundle="LSPApplicationResources" property="tailVPNIP"/>
        <html:errors bundle="LSPApplicationResources" property="Bandwidth"/>
        <html:errors bundle="LSPApplicationResources" property="TerminationPointID"/>
        <html:errors bundle="LSPApplicationResources" property="ActivationState"/>
        <html:errors bundle="LSPApplicationResources" property="AdminState"/>
        <html:errors bundle="LSPApplicationResources" property="ActivationDate"/>
        <html:errors bundle="LSPApplicationResources" property="ModificationDate"/>
        <html:errors bundle="LSPApplicationResources" property="LSPProfileName"/>
        <html:errors bundle="LSPApplicationResources" property="UsageMode"/>
  </H1>
<script type="text/javascript">
var allEvents = "";
function addListener(element,eventName,functionName){
  if(element.addEventListener){
    element.addEventListener(eventName,functionName,false);
  } else {
    element.attachEvent("on" + eventName,functionName);
  }
}
</script>
<script>
function doOnLoad()
{
  // hide field
                                                                                                                // check hiding rules
  eval(allEvents);
}
addListener(window, "load", doOnLoad);
</script>
<% String formAction = "/DeleteCommitLSPAction.do?datasource=" + datasource + "&rimid=" + rimid; %> 
<html:form action="<%= formAction %>" style="text-align:center;">
    
    <table:table>
      <table:header>
        <table:cell colspan="3">
			<bean:message bundle="InventoryResources" key="field.delete_lsps.filter"/>
        </table:cell>
      </table:header>
		<table:row>
			<table:cell width="10%">
				<% if ("Aggregated".equals(usageMode)) { %>
					<input type="radio" name="usagemode" value="Aggregated" onchange="reload();" checked="checked">
				<% } else { %>
					<input type="radio" name="usagemode" value="Aggregated" onchange="reload();">
				<% } %>
			</table:cell>
			<table:cell width="30">
				<bean:message bundle="InventoryResources" key="field.delete_lsps.aggregated"/>
			</table:cell>
			<% if ("Aggregated".equals(usageMode)) { %>
			<table:cell width="60%">
				<bean:message bundle="InventoryResources" key="field.delete_lsps.networkid"/>:<select name="networkid" onchange="reload();">
					<option value="">All networks</option>
					<% 	networkList = networkList != null ? networkList : new com.hp.ov.activator.cr.inventory.Network[0];
      
						for( int i = 0 ; i < networkList.length ; i++ ) { 
      
							com.hp.ov.activator.cr.inventory.Network networkListObject = networkList[i];
							
							if (networkid.equals(networkListObject.getNetworkid()))  { %>
								<option value="<%= networkListObject.getNetworkid() %>" selected><%= networkListObject.getName() %></option>
						<% } else { %>
								<option value="<%= networkListObject.getNetworkid() %>"><%= networkListObject.getName() %></option>
						<% } %>
					<% } %>
				</select>
                                                </table:cell>
			<% } else { %>
				<table:cell width="60%">
                              </table:cell>
			<% } %>
            </table:row>
                                                      <table:row>
			<table:cell width="10%">
				<% if ("Service".equals(usageMode)) { %>
					<input type="radio" name="usagemode" value="Service" onchange="reload();" checked="checked">
				<% } else { %>
					<input type="radio" name="usagemode" value="Service" onchange="reload();">
				<% } %>
			</table:cell>
			<table:cell width="30%">
				<bean:message bundle="InventoryResources" key="field.delete_lsps.service"/>
			</table:cell>
			<% if ("Service".equals(usageMode)) { %>
			<table:cell width="60%">
				<% if ("".equals(vpnid)) { %>
					<bean:message bundle="InventoryResources" key="field.delete_lsps.vpnid"/>: <input type="text" size="5" name="vpnid"><input type="button" value="<bean:message bundle="InventoryResources" key="button.delete_lsps.filter"/>" class="ButtonSubmit" onclick="reload();">&nbsp;
				<% } else { %>
					<bean:message bundle="InventoryResources" key="field.delete_lsps.vpnid"/>: <input type="text" size="5" name="vpnid" value="<%=vpnid%>"><input type="button" value="<bean:message bundle="InventoryResources" key="button.delete_lsps.filter"/>" class="ButtonSubmit" onclick="reload();">&nbsp;
				<% } %>
                                                </table:cell>
			<% } else { %>
				<table:cell width="60%">
                              </table:cell>
			<% } %>
            </table:row>
                                                      <table:row>
			<table:cell width="10%">
				<% if ("Manual".equals(usageMode)) { %>
					<input type="radio" name="usagemode" value="Manual" onchange="reload();" checked="checked">
				<% } else { %>
					<input type="radio" name="usagemode" value="Manual" onchange="reload();">
				<% } %>
			</table:cell>
			<table:cell width="30%">
				<bean:message bundle="InventoryResources" key="field.delete_lsps.manual"/>
			</table:cell>
			<% if ("Manual".equals(usageMode)) { %>
			<table:cell width="60%">
				<% if ("".equals(vpnid)) { %>
					<bean:message bundle="InventoryResources" key="field.delete_lsps.vpnid"/>: <input type="text" size="5" name="vpnid"><input type="button" value="<bean:message bundle="InventoryResources" key="button.delete_lsps.filter"/>" class="ButtonSubmit" onclick="reload();">&nbsp;
				<% } else { %>
					<bean:message bundle="InventoryResources" key="field.delete_lsps.vpnid"/>: <input type="text" size="5" name="vpnid" value="<%=vpnid%>"><input type="button" value="<bean:message bundle="InventoryResources" key="button.delete_lsps.filter"/>" class="ButtonSubmit" onclick="reload();">&nbsp;
				<% } %>
                                                </table:cell>
			<% } else { %>
				<table:cell width="60%">
                              </table:cell>
			<% } %>
            </table:row>
		<% if (("Service".equals(usageMode)) || ("Manual".equals(usageMode))) { %>
                                                      <table:row>
			<table:cell width="10%">
                              </table:cell>
			<table:cell width="30%">
				<text align="right"><bean:message bundle="InventoryResources" key="label.delete_lsps.show"/></text>
                                                </table:cell>
			<table:cell width="60%">
				<% if (!("".equals(filterup))) { %>
					<input type="checkbox" name="filterup" value="filterup" onchange="reload();" checked /> <bean:message bundle="InventoryResources" key="field.delete_lsps.uplsps"/>
				<% } else { %>
					<input type="checkbox" name="filterup" value="filterup" onchange="reload();" /> <bean:message bundle="InventoryResources" key="field.delete_lsps.uplsps"/>
				<% } %>
				<% if (!("".equals(filterdown))) { %>
					<input type="checkbox" name="filterdown" value="filterdown" onchange="reload();" checked /> <bean:message bundle="InventoryResources" key="field.delete_lsps.downlsps"/>
				<% } else { %>
					<input type="checkbox" name="filterdown" value="filterdown" onchange="reload();" /> <bean:message bundle="InventoryResources" key="field.delete_lsps.downlsps"/>
				<% } %>
                              </table:cell>
            </table:row>
		<% } %>
	</table:table>
	
	<br>
	
	<table:table>
		<% if ("Aggregated".equals(usageMode)) {
			if ("".equals(networkid)) { %>
				<b><bean:message bundle="InventoryResources" key="label.delete_lsps.showing"/></b>
				<bean:message bundle="InventoryResources" key="label.delete_lsps.all"/><bean:message bundle="InventoryResources" key="label.delete_lsps.aggregated"/>
			<% } else { %>
				<b><bean:message bundle="InventoryResources" key="label.delete_lsps.showing"/></b>
				<bean:message bundle="InventoryResources" key="label.delete_lsps.aggregated"/><bean:message bundle="InventoryResources" key="label.delete_lsps.in.network"/><%=networkName%> <bean:message bundle="InventoryResources" key="label.delete_lsps.leftparenthesis"/><%=networkid%><bean:message bundle="InventoryResources" key="label.delete_lsps.rightparenthesis"/>
			<% } %>
		<% } %>
		<% if ("Service".equals(usageMode)) { 
			if ("".equals(vpnid)) { %>
				<b><bean:message bundle="InventoryResources" key="label.delete_lsps.showing"/></b>
				<bean:message bundle="InventoryResources" key="label.delete_lsps.all"/><bean:message bundle="InventoryResources" key="label.delete_lsps.service"/>
			<% } else if (!("".equals(vpnName))) { %>
				<b><bean:message bundle="InventoryResources" key="label.delete_lsps.showing"/></b>
				<bean:message bundle="InventoryResources" key="label.delete_lsps.service"/><bean:message bundle="InventoryResources" key="label.delete_lsps.in.vpn"/><%=vpnName%> <bean:message bundle="InventoryResources" key="label.delete_lsps.leftparenthesis"/><%=vpnid%><bean:message bundle="InventoryResources" key="label.delete_lsps.rightparenthesis"/>
			<% } else { %>
				<b><font color="#FF0000"><bean:message bundle="InventoryResources" key="error.delete_lsps.vpnnotfound"/></font>
			<% } %>
		<% } %>
		<% if ("Manual".equals(usageMode)) { 
			if ("".equals(vpnid)) { %>
				<b><bean:message bundle="InventoryResources" key="label.delete_lsps.showing"/></b>
				<bean:message bundle="InventoryResources" key="label.delete_lsps.all"/><bean:message bundle="InventoryResources" key="label.delete_lsps.manual"/>
			<% } else if (!("".equals(vpnName))) { %>
				<b><bean:message bundle="InventoryResources" key="label.delete_lsps.showing"/></b>
				<bean:message bundle="InventoryResources" key="label.delete_lsps.manual"/><bean:message bundle="InventoryResources" key="label.delete_lsps.in.vpn"/><%=vpnName%> <bean:message bundle="InventoryResources" key="label.delete_lsps.leftparenthesis"/><%=vpnid%><bean:message bundle="InventoryResources" key="label.delete_lsps.rightparenthesis"/>
			<% } else { %>
				<b><font color="#FF0000"><bean:message bundle="InventoryResources" key="error.delete_lsps.vpnnotfound"/></font>
			<% } %>
		<% } %>			
	</table:table>
	
	<%
		
		int counter = 0;
		
		LSPList = LSPList != null ? LSPList : new com.hp.ov.activator.vpn.inventory.LSP[0];
      
		for (int i = 0; i < LSPList.length; i++) 
		{
			com.hp.ov.activator.vpn.inventory.LSP LSPListObject = LSPList[i];
			
			if (!(LSPListObject.getUsagemode()).equals(usageMode)) continue;
			if ("Deleted".equals(LSPListObject.getAdminstate())) continue;
			
			counter++;
		}
	
	%>
	<table:table>
		<bean:message bundle="InventoryResources" key="label.delete_lsps.lspcount"/><font color="#003366"><%=counter%></font>
	</table:table>
	
	<br>

    <table:table> 
      <table:header>
        <table:cell width="10%">
			<bean:message bundle="InventoryResources" key="field.delete_lsps.lspid"/>
                              </table:cell>
        <table:cell width="10%">
			<input type="checkbox" name="togglebox" onClick="toggle(this);"/> <bean:message bundle="InventoryResources" key="field.delete_lsps.selectall"/>
                                                </table:cell>
		<table:cell width="80%">
			<bean:message bundle="InventoryResources" key="field.delete_lsps.description"/>
                              </table:cell>
      </table:header>
	  </table:table>

      <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
	  
	  <div style="height: <bean:message bundle="InventoryResources" key="size.delete_lsps.scroll"/>; overflow-y: scroll;">
	  <table:table>
	  
	  <% LSPList = LSPList != null ? LSPList : new com.hp.ov.activator.vpn.inventory.LSP[0];
      
		for (int i = 0; i < LSPList.length; i++) 
		{
			com.hp.ov.activator.vpn.inventory.LSP LSPListObject = LSPList[i];
			
			if (!(LSPListObject.getUsagemode()).equals(usageMode)) continue;
			if ("Deleted".equals(LSPListObject.getAdminstate())) continue;

			String cosName = "";
			String vpnID = ""; 
			
			try
			{
				DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
				if (ds != null)
				{
					con = ds.getConnection();

					String lspProfileString = LSPListObject.getLspprofilename();
					
					com.hp.ov.activator.vpn.inventory.LSPProfile LSPProfileObject = com.hp.ov.activator.vpn.inventory.LSPProfile.findByLspprofilename(con,lspProfileString);
					
					cosName = LSPProfileObject.getCos();
					if (("Service".equals(LSPListObject.getUsagemode())) || ("Manual".equals(LSPListObject.getUsagemode())))
					{
						com.hp.ov.activator.vpn.inventory.LSPVPNMembership[] LSPVPNMembershipList = com.hp.ov.activator.vpn.inventory.LSPVPNMembership.findByLspid(con,LSPListObject.getLspid());
						com.hp.ov.activator.vpn.inventory.LSPVPNMembership LSPVPNMembershipObject = LSPVPNMembershipList[0];
						vpnID = LSPVPNMembershipObject.getVpnid();
					}
				}      
			}
			catch(Exception e)
			{
				System.out.println("Exception getting LSP show info from database: "+e);
			}
			finally
			{
				if (con != null)
				{
					try 
					{
						con.close();
					}
					catch (Exception rollbackex)
					{
						// Ignore
					}
				}
			}
			
%>

                                                      <table:row>
				<table:cell width="10%">
					<% if ("Up".equals(LSPListObject.getAdminstate())) {%>
						<%=LSPListObject.getLspid()%>
					<% } else if ("Down".equals(LSPListObject.getAdminstate())) { %>
						<font color="#C00000"><%=LSPListObject.getLspid()%></font>
					<% } %>
				</table:cell>
				<table:cell width="10%">
					<input type="checkbox" name="lspid" value="<%=LSPListObject.getLspid()%>"/>
				</table:cell>
				<table:cell width="80%">
					<% if ("Up".equals(LSPListObject.getAdminstate())) {%>
						<%=LSPListObject.getHeadpename()%>-<%=LSPListObject.getTailpename()%> | <%=cosName%><% if (("Service".equals(LSPListObject.getUsagemode())) || ("Manual".equals(LSPListObject.getUsagemode()))) {%> | VPNID: <%=vpnID%><%}%>
					<% } else if ("Down".equals(LSPListObject.getAdminstate())) { %>
						<font color="#C00000"><%=LSPListObject.getHeadpename()%>-<%=LSPListObject.getTailpename()%> | <%=cosName%><% if (("Service".equals(LSPListObject.getUsagemode())) || ("Manual".equals(LSPListObject.getUsagemode()))) {%> | VPNID: <%=vpnID%><%}%> | <bean:message bundle="InventoryResources" key="label.delete_lsps.downlsp"/></font>
					<% } %>
                              </table:cell>
            </table:row>
			<%
		}%>
		
	</table:table>
	</div>
		
	<table:table>
                                                      <table:row>
        <table:cell colspan="3" align="center">
			<br>
                              </table:cell>
            </table:row>

                                                      <table:row>
        <table:cell colspan="3" align="center">
			<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.delete_lsps_button.label"/>" name="enviando" class="ButtonSubmit" onclick="confirmSubmit();">&nbsp;
                              </table:cell>
            </table:row>
	  
    </table:table>
	
	<html:hidden property="ismulti" value="<%= isMultiDelete %>"/>
	<html:hidden property="usagemodehidden" value="<%= usageMode %>"/>
	<html:hidden property="vpnid" value="<%= vpnid %>"/>

  </html:form>

  </body>
</html>


<% 
}
// Manual LSP Creation
else if  (!("empty".equals(isManual)))
{
%>

<%
String headPEID = "null";
String tailPEID = "null";
String selectedCOS = "null";
String selectedBW = "null";
String networkid = "null";
String headnetworkid = "null";
String tailnetworkid = "null"; 
String regionid = "null";
String mode = "null";	
boolean disableCreation = false;

%>

<html>
  <head>
	<%if (!("empty".equals(isManual)))
	{%>
		<title><bean:message bundle="InventoryResources" key="title.createmanuallsp"/></title>
	<%}
	else 
	{%>
		<title><bean:message bundle="LSPApplicationResources" key="<%= LSPConstants.JSP_CREATION_TITLE %>"/></title>
	<%}%>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
      <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
	<link rel="stylesheet" href="/activator/css/inventory-gui/jquery-ui.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
	<script src="/activator/javascript/jquery-1.10.2.js"></script>
	<script src="/activator/javascript/jquery-ui.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
      H1 { color: red; font-size: 13px }
	  .custom-combobox {
		position: relative;
		display: inline-block;
	}
	.custom-combobox-toggle {
		position: absolute;
		top: 0;
		bottom: 0;
		margin-left: -1px;
		padding: 0;
		/* support: IE7 */
		*height: 1.7em;
		*top: 0.1em;
	}
	.custom-combobox-input {
		margin: 0;
		padding: 0.3em;
	}
	.ui-state-default,
.ui-widget-content .ui-state-default,
.ui-widget-header .ui-state-default {
	border: 1px solid #d3d3d3;
	background: #ffffff;
	font-weight: normal;
	color: #555555;
}
    </style>
	<script>
	(function( $ ) {
		$.widget( "custom.combobox", {
			_create: function() {
				this.wrapper = $( "<span>" )
					.addClass( "custom-combobox" )
					.insertAfter( this.element );

				this.element.hide();
				this._createAutocomplete();
				this._createShowAllButton();
			},

			_createAutocomplete: function() {
				var org_onchange = this.element.closest("select").prop("onchange");
				var selected = this.element.children( ":selected" ),
					value = selected.val() ? selected.text() : "";

				this.input = $( "<input>" )
					.appendTo( this.wrapper )
					.val( value )
					.attr( "title", "" )
					.addClass( "custom-combobox-input ui-widget ui-widget-content ui-state-default ui-corner-left" )
					.autocomplete({
						delay: 0,
						minLength: 0,
						source: $.proxy( this, "_source" ),
						
						select: function( event, ui ) {
							org_onchange();
                             ui.item.option.selected = true;
                             /*self._trigger( "selected", event, {
                                 item: ui.item.option
                             });
                             select.trigger("change"); */                          
                         },
                         change: function( event, ui ) {
							if ( !ui.item ) {
                                 var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" ),
                                     valid = false;
                                 select.children( "option" ).each(function() {
                                     if ( $( this ).text().match( matcher ) ) {
                                         this.selected = valid = true;
                                         return false;
                                     }
                                 });
                                 if ( !valid ) {
                                     // remove invalid value, as it didn't match anything
                                     $( this ).val( "" );
                                     select.val( "" );
                                     input.data( "autocomplete" ).term = "";
                                     return false;
                                 }
                             }
                         }
					})
					.tooltip({
						tooltipClass: "ui-state-highlight"
					});

				this._on( this.input, {
					autocompleteselect: function( event, ui ) {
						ui.item.option.selected = true;
						this._trigger( "select", event, {
							item: ui.item.option
						});
					},

					autocompletechange: "_removeIfInvalid"
				});
			},

			_createShowAllButton: function() {
				var input = this.input,
					wasOpen = false;

				$( "<a>" )
					.attr( "tabIndex", -1 )
					.attr( "title", "Show All Items" )
					.tooltip()
					.appendTo( this.wrapper )
					.button({
						icons: {
							primary: "ui-icon-triangle-1-s"
						},
						text: false
					})
					.removeClass( "ui-corner-all" )
					.addClass( "custom-combobox-toggle ui-corner-right" )
					.mousedown(function() {
						wasOpen = input.autocomplete( "widget" ).is( ":visible" );
					})
					.click(function() {
						input.focus();

						// Close if already visible
						if ( wasOpen ) {
							return;
						}
      
						// Pass empty string as value to search for, displaying all results
						input.autocomplete( "search", "" );
					});
			},

			_source: function( request, response ) {
				var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
				response( this.element.children( "option" ).map(function() {
					var text = $( this ).text();
					if ( this.value && ( !request.term || matcher.test(text) ) )
						return {
							label: text,
							value: text,
							option: this
						};
				}) );
			},

			_removeIfInvalid: function( event, ui ) {

				// Selected an item, nothing to do
				if ( ui.item ) {
					return;
				}
      
				// Search for a match (case-insensitive)
				var value = this.input.val(),
					valueLowerCase = value.toLowerCase(),
					valid = false;
				this.element.children( "option" ).each(function() {
					if ( $( this ).text().toLowerCase() === valueLowerCase ) {
						this.selected = valid = true;
						return false;
					}
				});
      
				// Found a match, nothing to do
				if ( valid ) {
					return;
				}
      
				// Remove invalid value
				this.input
					.val( "" )
					.attr( "title", value + " didn't match any item" )
					.tooltip( "open" );
				this.element.val( "" );
				this._delay(function() {
					this.input.tooltip( "close" ).attr( "title", "" );
				}, 2500 );
				this.input.autocomplete( "instance" ).term = "";
			},

			_destroy: function() {
				this.wrapper.remove();
				this.element.show();
			}
		});
	})( jQuery );
      
	$(function() {
		$( "#combobox" ).combobox();
		$( "#toggle" ).click(function() {
			$( "#combobox" ).toggle();
		});
	});

	</script>
	
	<script type="text/javascript"> 
		function performCommit() {
			window.document.LSPForm.action = '/activator<%=moduleConfig%>/CreationCommitLSPAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
			window.document.LSPForm.submit();
		}

		function reload(){
			window.document.LSPForm.action = '/activator<%=moduleConfig%>/CreationFormLSPAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&refreshTreeRimid=<%=refreshTreeRimid%>'; 
			window.document.LSPForm.submit();
		}
		function init()
		{
			<%
			if ( _location_ != null ) {
%>
				var elems = document.getElementsByName("<%=_location_%>");
				var elem = elems == null || elems.length == 0 ? null : elems[0];
				if (elem != null) {
					elem.focus();
				}
				<%
			}
			if ( errorMessage != null && !errorMessage.equals("") ) {
				%>
				var alert = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
				alert.setBounds(400, 120);
				alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
				alert.show();
				<%
			}
%>
		}
		function stopRKey(evt) { 
		  var evt = (evt) ? evt : ((event) ? event : null); 
		  var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null); 
		  if ((evt.keyCode == 13) && (node.type=="text"))  {return false;} 
		} 

		document.onkeypress = stopRKey; 
	</script>

  </head>
  <body style="overflow:auto;" onload="init();">
      
<%

if ( request.getParameter("neid") != null ) {
headPEID = request.getParameter("neid");
} 

if (( "null".equals(headPEID) ) && (request.getParameter("headpeid") != null )) {
headPEID = request.getParameter("headpeid");
} 
      
if (( "null".equals(headPEID) ) && (request.getParameter("headpebox") != null )) {
headPEID = request.getParameter("headpebox");
} 
      
if ( request.getParameter("tailpebox") != null ) {
tailPEID = request.getParameter("tailpebox");
} 
      
if (( "null".equals(tailPEID) ) && (request.getParameter("tailpebox") != null )) {
tailPEID = request.getParameter("tailpebox");
} 
      
if ( request.getParameter("cosbox") != null ) {
selectedCOS = request.getParameter("cosbox");
} 
      
if ( request.getParameter("bandwidth") != null ) {
selectedBW = request.getParameter("bandwidth");
} 
      
if (request.getParameter("networkid") != null) {
networkid = request.getParameter("networkid");
} 
      
if (request.getParameter("headnetworkid") != null) {
headnetworkid = request.getParameter("headnetworkid");
} 
      
if (request.getParameter("tailnetworkid") != null) {
tailnetworkid = request.getParameter("tailnetworkid");
} 
      
if (request.getParameter("regionid") != null) {
regionid = request.getParameter("regionid");
}
      
// Define mode considering received parameters
      
if ( !("null".equals(headPEID)) 	)
{ 
	mode="HeadPE"; 
}
      
      
if ( ("null".equals(headPEID)) 		&& 
	!("null".equals(networkid)) 	)
{
	mode="Network";
}
      
      
if (!("null".equals(headPEID))  	&& 
	 ("null".equals(networkid)) 	&& 
	!("null".equals(headnetworkid)) && 
	!("null".equals(tailnetworkid)) )
{
	mode="TailNetwork";
}
      
      
if (!("null".equals(headPEID))  	&& 
	 ("null".equals(networkid)) 	&& 
	!("null".equals(headnetworkid)) && 
	 ("null".equals(tailnetworkid)) )
{
	mode="HeadPE";
}
      
      
if ( ("null".equals(headPEID))  	&& 
	 ("null".equals(networkid)) 	&& 
	!("null".equals(headnetworkid)) )
{
	mode="HeadNetwork";
}
      
if ( ("null".equals(headPEID))  	&& 
	 ("null".equals(networkid)) 	&& 
	!("null".equals(regionid)) 		)
{
	mode="Region";
}
      
if ( ("null".equals(headPEID))  	&& 
	 ("null".equals(networkid)) 	&& 
	 ("null".equals(headnetworkid)) && 
	 ("null".equals(regionid)) 		)
{
	mode="General";
}


Connection con = null;

com.hp.ov.activator.vpn.inventory.PERouter beanHeadPERouter = null;
com.hp.ov.activator.vpn.inventory.PERouter beanTailPERouter = null;

com.hp.ov.activator.vpn.inventory.PERouter[] headPEList = null;
com.hp.ov.activator.vpn.inventory.PERouter[] tailPEList = null;
                                    
com.hp.ov.activator.cr.inventory.Network[] headNetworkList = null;
com.hp.ov.activator.cr.inventory.Network headNetwork = null;
com.hp.ov.activator.cr.inventory.Network[] tailNetworkList = null;
com.hp.ov.activator.cr.inventory.Network tailNetwork = null;
                                    
ArrayList<LabelValueBean> headPEListofValues = new ArrayList<LabelValueBean>();
ArrayList<LabelValueBean> tailPEListofValues = new ArrayList<LabelValueBean>();

ArrayList<LabelValueBean> headPENetworkListofValues = new ArrayList<LabelValueBean>();
ArrayList<LabelValueBean> tailPENetworkListofValues = new ArrayList<LabelValueBean>();
                                    
com.hp.ov.activator.vpn.inventory.EXPMapping[] expMappings = null;
com.hp.ov.activator.vpn.inventory.LSPProfile[] lspProfiles = null;
com.hp.ov.activator.vpn.inventory.RateLimit[] rlList = null;
      
try
{
	DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
	if (ds != null)
	{
		con = ds.getConnection();
      
		if (!("null".equals(headPEID)))
		{ 
			beanHeadPERouter = (com.hp.ov.activator.vpn.inventory.PERouter) com.hp.ov.activator.vpn.inventory.PERouter.findByPrimaryKey(con,headPEID); 
      
			if ("TailNetwork".equals(mode))
			{
				tailPEList = com.hp.ov.activator.vpn.inventory.PERouter.findByNetworkid(con,tailnetworkid);
				headNetwork = com.hp.ov.activator.cr.inventory.Network.findByNetworkid(con,headnetworkid);
				tailNetwork = com.hp.ov.activator.cr.inventory.Network.findByNetworkid(con,tailnetworkid);
			}
			else
			{
				tailPEList = com.hp.ov.activator.vpn.inventory.PERouter.findByNetworkid(con,beanHeadPERouter.getNetworkid());
}
                                                                                                            }

		if ("HeadPE".equals(mode))
    {
			beanHeadPERouter = (com.hp.ov.activator.vpn.inventory.PERouter) com.hp.ov.activator.vpn.inventory.PERouter.findByPrimaryKey(con,headPEID);
			
			headNetwork = com.hp.ov.activator.cr.inventory.Network.findByNetworkid(con,beanHeadPERouter.getNetworkid());
			
			headnetworkid = beanHeadPERouter.getNetworkid();
			
			if ( (headNetwork.getAsn() != null) && !("".equals(headNetwork.getAsn())) )
			{
				String whereClause = "CRModel#Network.Type='Network' and CRModel#Network.Asn = "+headNetwork.getAsn();
				tailNetworkList = com.hp.ov.activator.cr.inventory.Network.findAll(con,whereClause);
    }
			else
    {
				String whereClause = "CRModel#Network.Type='Network' and (CRModel#Network.Asn is null or CRModel#Network.Asn='')";
				tailNetworkList = com.hp.ov.activator.cr.inventory.Network.findAll(con,whereClause);
    }
		}
      
		if ("HeadNetwork".equals(mode))
    {
			headPEList = com.hp.ov.activator.vpn.inventory.PERouter.findByNetworkid(con,headnetworkid);	
			headNetwork = com.hp.ov.activator.cr.inventory.Network.findByNetworkid(con,headnetworkid);
      }
      
		if ("Network".equals(mode))
		{
			headNetwork = com.hp.ov.activator.cr.inventory.Network.findByNetworkid(con,networkid);
			headPEList = com.hp.ov.activator.vpn.inventory.PERouter.findByNetworkid(con,networkid);
			headnetworkid = networkid;
			mode="HeadNetwork";
}
      
		if ("Region".equals(mode))
		{
			headNetworkList = com.hp.ov.activator.cr.inventory.Network.findByRegionandtype(con,regionid,"Network");
}
      
		if ("General".equals(mode))
		{
			headNetworkList = com.hp.ov.activator.cr.inventory.Network.findByType(con,"Network");	
			mode = "Region"; 
    }

		expMappings = com.hp.ov.activator.vpn.inventory.EXPMapping.findAll(con);
		lspProfiles = com.hp.ov.activator.vpn.inventory.LSPProfile.findAll(con);
		rlList = com.hp.ov.activator.vpn.inventory.RateLimit.findAll(con);
	}             
}
catch(Exception e)
{
	System.out.println("Exception getting beans from database: "+e);
}
finally
{
	if (con != null)
	{
		try 
		{
			con.close();
		}
		catch (Exception rollbackex)
		{
			// Ignore
		}
	}
}
      
      
if ("TailNetwork".equals(mode)) 
{
	tailPEList = tailPEList != null ? tailPEList : new com.hp.ov.activator.vpn.inventory.PERouter[0];
      
	for (int i = 0; i < tailPEList.length; i++) 
	{
		com.hp.ov.activator.vpn.inventory.PERouter tailPEListObject = tailPEList[i];
      
		// Discard head PE for tail PE list
		if (headPEID.equals(tailPEListObject.getNetworkelementid())) continue;
      
		LabelValueBean tailPEObject = new LabelValueBean(tailPEListObject.getName(),tailPEListObject.getNetworkelementid());
      
		tailPEListofValues.add(tailPEObject);
	}
}
      
if ("HeadPE".equals(mode))
{
	if (tailNetwork != null) 
	{
		LabelValueBean tailNetworkObject = new LabelValueBean(tailNetwork.getName(),tailNetwork.getNetworkid());
      
		tailPENetworkListofValues.add(tailNetworkObject);
	}
	else
	{
		tailNetworkList = tailNetworkList != null ? tailNetworkList : new com.hp.ov.activator.cr.inventory.Network[0];
      
		for (int i = 0; i < tailNetworkList.length; i++) 
		{
			com.hp.ov.activator.cr.inventory.Network tailNetworkListObject = tailNetworkList[i];
      
			LabelValueBean tailNetworkObject = new LabelValueBean(tailNetworkListObject.getName(),tailNetworkListObject.getNetworkid());
      
			tailPENetworkListofValues.add(tailNetworkObject);
		}
	}
}
      
if (("Network".equals(mode)) || ("HeadNetwork".equals(mode)))
{
	headPEList = headPEList != null ? headPEList : new com.hp.ov.activator.vpn.inventory.PERouter[0];
      
	for (int i = 0; i < headPEList.length; i++) 
	{
		com.hp.ov.activator.vpn.inventory.PERouter headPEListObject = headPEList[i];
      
		LabelValueBean headPEObject = new LabelValueBean(headPEListObject.getName(),headPEListObject.getNetworkelementid());
      
		headPEListofValues.add(headPEObject);
	}
}
      
if ("Region".equals(mode))
{
	headNetworkList = headNetworkList != null ? headNetworkList : new com.hp.ov.activator.cr.inventory.Network[0];
      
	for (int i = 0; i < headNetworkList.length; i++) 
	{
		com.hp.ov.activator.cr.inventory.Network headNetworkListObject = headNetworkList[i];
      
		LabelValueBean headNetworkObject = new LabelValueBean(headNetworkListObject.getName(),headNetworkListObject.getNetworkid());

		headPENetworkListofValues.add(headNetworkObject);
	}
}
      
      
// Get list of COS
      
ArrayList<String> COSListOfValues = new ArrayList<String>();
      
expMappings = expMappings != null ? expMappings : new com.hp.ov.activator.vpn.inventory.EXPMapping[0];
lspProfiles = lspProfiles != null ? lspProfiles : new com.hp.ov.activator.vpn.inventory.LSPProfile[0];
      
for (int i = 0; i < expMappings.length; i++) 
{
	com.hp.ov.activator.vpn.inventory.EXPMapping expMapping = expMappings[i];
	String cosName = expMapping.getClassname();
	
	for (int j = 0; j < lspProfiles.length; j++)
	{
		com.hp.ov.activator.vpn.inventory.LSPProfile lspProfile = lspProfiles[j];
		String pcosName = lspProfile.getCos();
		String pbwAlgorithm = lspProfile.getBwalgorithm();
		
		if ((cosName.equals(pcosName)) && ("manual".equals(pbwAlgorithm)))
		{
			if (!COSListOfValues.contains(cosName)) COSListOfValues.add(cosName);
}
}
    }

// Get list of BW
ArrayList<String> RLListOfValues = new ArrayList<String>();

rlList = rlList != null ? rlList : new com.hp.ov.activator.vpn.inventory.RateLimit[0];

for (int i = 0; i < rlList.length; i++) 
{
	com.hp.ov.activator.vpn.inventory.RateLimit rateLimit = rlList[i];
	RLListOfValues.add(rateLimit.getRatelimitname());
}
          
%>

<center> 
<h2 style="width:100%; text-align:center;">
	<%if (!("empty".equals(isManual)))
	{%>
		<bean:message bundle="InventoryResources" key="title.createmanuallsp"/>
	<%}
	else 
	{%>
  <bean:message bundle="LSPApplicationResources" key="jsp.creation.title"/>
	<%}%>
</h2> 
</center>


<H1>
		<html:errors bundle="PERouterApplicationResources" property="NetworkElementID" /> 
		<html:errors bundle="PERouterApplicationResources" property="NetworkID" /> 
        <html:errors bundle="PERouterApplicationResources" property="Name"/>
        <html:errors bundle="PERouterApplicationResources" property="Description"/>
        <html:errors bundle="PERouterApplicationResources" property="Location"/>
        <html:errors bundle="PERouterApplicationResources" property="IP"/>
		<html:errors bundle="PERouterApplicationResources" property="management_IP" />
        <html:errors bundle="PERouterApplicationResources" property="ManagementInterface"/>
        <html:errors bundle="PERouterApplicationResources" property="UsernameEnabled"/>
        <html:errors bundle="PERouterApplicationResources" property="Username"/>
        <html:errors bundle="PERouterApplicationResources" property="Password"/>
        <html:errors bundle="PERouterApplicationResources" property="EnablePassword"/>
        <html:errors bundle="PERouterApplicationResources" property="Vendor"/>
		<html:errors bundle="PERouterApplicationResources" property="OSversion" />
        <html:errors bundle="PERouterApplicationResources" property="ElementType"/>
        <html:errors bundle="PERouterApplicationResources" property="SerialNumber"/>
        <html:errors bundle="PERouterApplicationResources" property="Role"/>
		<html:errors bundle="PERouterApplicationResources" property="State" />
        <html:errors bundle="PERouterApplicationResources" property="LifeCycleState"/>
        <html:errors bundle="PERouterApplicationResources" property="Backup"/>
        <html:errors bundle="PERouterApplicationResources" property="SchPolicyName"/>
        <html:errors bundle="PERouterApplicationResources" property="ROCommunity"/>
        <html:errors bundle="PERouterApplicationResources" property="RWCommunity"/>
		<html:errors bundle="PERouterApplicationResources" property="BGPDiscovery" />
        <html:errors bundle="PERouterApplicationResources" property="Tier"/>
      <html:errors bundle="LSPApplicationResources" property="LSPId"/>
        <html:errors bundle="LSPApplicationResources" property="TunnelId"/>
        <html:errors bundle="LSPApplicationResources" property="headPE"/>
        <html:errors bundle="LSPApplicationResources" property="headPEName"/>
        <html:errors bundle="LSPApplicationResources" property="tailPE"/>
        <html:errors bundle="LSPApplicationResources" property="tailPEName"/>
        <html:errors bundle="LSPApplicationResources" property="headIP"/>
        <html:errors bundle="LSPApplicationResources" property="tailIP"/>
        <html:errors bundle="LSPApplicationResources" property="headVPNIP"/>
        <html:errors bundle="LSPApplicationResources" property="tailVPNIP"/>
        <html:errors bundle="LSPApplicationResources" property="Bandwidth"/>
        <html:errors bundle="LSPApplicationResources" property="TerminationPointID"/>
        <html:errors bundle="LSPApplicationResources" property="ActivationState"/>
        <html:errors bundle="LSPApplicationResources" property="AdminState"/>
        <html:errors bundle="LSPApplicationResources" property="ActivationDate"/>
        <html:errors bundle="LSPApplicationResources" property="ModificationDate"/>
        <html:errors bundle="LSPApplicationResources" property="LSPProfileName"/>
        <html:errors bundle="LSPApplicationResources" property="UsageMode"/>
  </H1>
<script type="text/javascript">
var allEvents = "";
function addListener(element,eventName,functionName){
  if(element.addEventListener){
    element.addEventListener(eventName,functionName,false);
  } else {
    element.attachEvent("on" + eventName,functionName);
  }
}
</script>
<script>
function doOnLoad()
{
  // hide field
                                                                                                                // check hiding rules
  eval(allEvents);
}
addListener(window, "load", doOnLoad);
</script>
<% String formAction = "/CreationCommitLSPAction.do?datasource=" + datasource + "&rimid=" + rimid; %>
<html:form action="<%= formAction %>" style="text-align:center;">
    <table:table>
      <table:header>
        <table:cell>
        </table:cell>
        <table:cell>
        </table:cell>
      </table:header>
      <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
      
	 <% if ("TailNetwork".equals(mode)) { %>
		 
                                                                  <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.head_pe_network.label"/>
                              </table:cell>
              <table:cell>
				<%= headNetwork.getName() %>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.head_pe.label"/>
                                                </table:cell>
              <table:cell>
				<%= beanHeadPERouter.getName() %>
                              </table:cell>
            </table:row>
                                                                  <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.tail_pe_network.label"/>
                                                </table:cell>
              <table:cell>
				<%= tailNetwork.getName() %>
                              </table:cell>
            </table:row>
                                                                  <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.tail_pe.label"/>
                                                </table:cell>
              <table:cell>
				<select name="tailpebox" id="combobox" onchange="reload();">
					
					<% if (!("null".equals(tailPEID))) { %>
					<option value=""><bean:message bundle="InventoryResources" key="combobox.select_one.label"/></option>
					<% } %>
					
					<% for( int i = 0 ; i < tailPEListofValues.size() ; i++ )
					{
							LabelValueBean tailPEObject = tailPEListofValues.get(i);
							
							if ((tailPEObject.getValue()).equals(tailPEID))
							{
							%>  
							<option selected="selected" value="<%= tailPEObject.getValue() %>"><%= tailPEObject.getLabel() %></option>
							<% } else {%>                                           
							<option value="<%= tailPEObject.getValue() %>"><%= tailPEObject.getLabel() %></option>
							<% }} %>	
				</select>
                              </table:cell>
            </table:row>
		  
			<html:hidden property="headnetworkid" value="<%= headnetworkid %>"/>
			<html:hidden property="tailnetworkid" value="<%= tailnetworkid %>"/>
			<html:hidden property="headpeid" value="<%= headPEID %>"/>
			<html:hidden property="lspid" value="1"/>
			<html:hidden property="headpe" value="<%= headPEID %>"/>
			<html:hidden property="tailpe" value="<%= tailPEID %>"/>
			<html:hidden property="vpnid" value="<%= isManual %>"/>
			<html:hidden property="headip" value="1"/>
			<html:hidden property="tailip" value="1"/>
			<html:hidden property="headvpnip" value="1"/>
			<html:hidden property="tailvpnip" value="1"/>
		  
	  <%}
		else if ("HeadPE".equals(mode)) { %>
		
                                                      <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.head_pe_network.label"/>
                              </table:cell>
              <table:cell>
				<%= headNetwork.getName() %>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.head_pe.label"/>
                                                </table:cell>
              <table:cell>
				<%= beanHeadPERouter.getName() %>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.tail_pe_network.label"/>
                              </table:cell>
              <table:cell>
				<select name="tailnetworkid" id="combobox" onchange="reload();">
					<option value=""><bean:message bundle="InventoryResources" key="combobox.select_one.label"/></option>
					<% for( int i = 0 ; i < tailPENetworkListofValues.size() ; i++ )
					{
							LabelValueBean tailPENetworkObject = tailPENetworkListofValues.get(i);%>
                                         
							<option value="<%= tailPENetworkObject.getValue() %>"><%= tailPENetworkObject.getLabel() %></option>
							
					<% } %>
				</select>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.tail_pe.label"/>
                                                </table:cell>
              <table:cell>
				<bean:message bundle="InventoryResources" key="field.select_tail_pe_network_first.label"/>
                              </table:cell>
            </table:row>
		  
		  <html:hidden property="headnetworkid" value="<%= headnetworkid %>"/>
		  <html:hidden property="headpeid" value="<%= headPEID %>"/>
		  <html:hidden property="vpnid" value="<%= isManual %>"/>
		
		<%
		}
		else if ("HeadNetwork".equals(mode)) { %>
			
                                                      <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.head_pe_network.label"/>
                              </table:cell>
              <table:cell>
				<%= headNetwork.getName() %>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.head_pe.label"/>
                                                </table:cell>
              <table:cell>
				<select name="headpebox" id="combobox" onchange="reload();">
					<option value=""><bean:message bundle="InventoryResources" key="combobox.select_one.label"/></option>
					<% for( int i = 0 ; i < headPEListofValues.size() ; i++ )
					{
							LabelValueBean headPEObject = headPEListofValues.get(i);%>
                                         
							<option value="<%= headPEObject.getValue() %>"><%= headPEObject.getLabel() %></option>
							
					<% } %>
				</select>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.tail_pe_network.label"/>
                                                </table:cell>
              <table:cell>
				<bean:message bundle="InventoryResources" key="field.select_head_pe_first.label"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.tail_pe.label"/>
                                                </table:cell>
              <table:cell>
				<bean:message bundle="InventoryResources" key="field.select_head_pe_first.label"/>
                              </table:cell>
            </table:row>
		  
		  <html:hidden property="headnetworkid" value="<%= headnetworkid %>"/>
		  <html:hidden property="vpnid" value="<%= isManual %>"/>
	  
	  <% }
		 else if ("Region".equals(mode)) {%>
		 
                                                      <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.head_pe_network.label"/>
                              </table:cell>
              <table:cell>
				<select name="headnetworkid" id="combobox" onchange="reload();">
					<option value=""><bean:message bundle="InventoryResources" key="combobox.select_one.label"/></option>
					<% for( int i = 0 ; i < headPENetworkListofValues.size() ; i++ )
					{
							LabelValueBean headPENetworkObject = headPENetworkListofValues.get(i);%>
                                         
							<option value="<%= headPENetworkObject.getValue() %>"><%= headPENetworkObject.getLabel() %></option>
							
					<% } %>
				</select>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>
				<bean:message bundle="InventoryResources" key="field.head_pe.label"/>
                                                </table:cell>
              <table:cell>
				<bean:message bundle="InventoryResources" key="field.select_head_pe_network_first.label"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.tail_pe_network.label"/>
                              </table:cell>
              <table:cell>
				<bean:message bundle="InventoryResources" key="field.select_head_pe_network_first.label"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>
				<bean:message bundle="InventoryResources" key="field.tail_pe.label"/>
                                                </table:cell>
              <table:cell>
				<bean:message bundle="InventoryResources" key="field.select_head_pe_network_first.label"/>
				
                              </table:cell>
            </table:row>
			
			<html:hidden property="vpnid" value="<%= isManual %>"/>
		 
		 <% } %> 
	  
                                                      <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.cos.label"/>
                                                </table:cell>
              <table:cell>
			<% if (COSListOfValues.size() == 0)
			{
				disableCreation = true; 
				%> <bean:message bundle="InventoryResources" key="warning.no_lsp_profiles_available.label"/> <%
                        }    
			else 
			{
                    %>
			<select name="cosbox">
				<% 				
				for( int i = 0 ; i < COSListOfValues.size() ; i++ )
				{
						String  COSValue = (COSListOfValues.get(i)).toString();

						if (COSValue.equals(selectedCOS))
						{
						%>
						<option selected="selected" value="<%= COSValue %>"><%= COSValue %></option>
						<% } else {
						%>
						<option value="<%= COSValue %>"><%= COSValue %></option>
						<% }} %>
			 </select>
			 <% } %>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
				<bean:message bundle="InventoryResources" key="field.bandwidth.label"/>
                                                </table:cell>
              <table:cell>
			<select name="bandwidth">
			<% for( int i = 0 ; i < RLListOfValues.size() ; i++ )
			{
			String rateLimit = RLListOfValues.get(i);
                              
			if (!("Unknown".equals(rateLimit)))
			{
				if (rateLimit.equals(selectedBW))
				{ %>
					<option selected="selected" value="<%=rateLimit%>"><%=rateLimit%></option>
			<%	} else
				{ %>
					<option value="<%=rateLimit%>"><%=rateLimit%></option>
			<%	}
			}			
			} %>
			</select>
                              </table:cell>
            </table:row>
                              
      
                                                      <table:row>
        <table:cell colspan="3" align="center">
        <br>
                              </table:cell>
            </table:row>
			
	   <script>
	     function goBack()
		   {
			 var mode = "<%=mode%>";
			 
			 if (mode == "HeadNetwork")
			 {
				document.getElementsByName("headnetworkid")[0].value = "null";
				document.getElementsByName("headpebox")[0].value = "null";
			 }
			 else if (mode == "HeadPE")
			 {
				document.getElementsByName("headpeid")[0].value = "null";
				document.getElementsByName("tailnetworkid")[0].value = "null";
			 }
			 else if (mode == "TailNetwork")
			 {
				document.getElementsByName("tailnetworkid")[0].value = "null";
				document.getElementsByName("tailpebox")[0].value = "null";
			 }
			 
			 window.reload();
		   }
		  function disableButtons()
		  {
			var inputs = document.getElementsByTagName("INPUT");
			for (var i = 0; i < inputs.length; i++) {
				if (inputs[i].type == 'button') {
					inputs[i].disabled = true;
				}
			}
		  }
	   </script>
	
                                                      <table:row>
        <table:cell colspan="3" align="center">
	
		  <% if ( !("null".equals(headPEID)) && !("null".equals(tailPEID)) && (!disableCreation)) { %>
				<%if (!("empty".equals(isManual)))
				{%>
					<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.create_mlsp_button.label"/>" name="enviando" class="ButtonSubmit" onclick="disableButtons(); performCommit();">&nbsp;
				<%}
				else 
				{%>
					<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.create_alsp_button.label"/>" name="enviando" class="ButtonSubmit" onclick="disableButtons(); performCommit();">&nbsp;
				<%}%>
		  <% } else { %>
				<%if (!("empty".equals(isManual)))
				{%>
					<input disabled="true" type="button" value="<bean:message bundle="InventoryResources" key="confirm.create_mlsp_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
				<%}
				else 
				{%>
					<input disabled="true" type="button" value="<bean:message bundle="InventoryResources" key="confirm.create_alsp_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
				<%}%>
		  <% } %>
		  <% if (!("Region".equals(mode))) { %>
			<input type="button" value="<bean:message bundle="InventoryResources" key="back.create_alsp_button.label"/>" onclick="goBack()">&nbsp;
		  <% } else { %>
			<input disabled="true" type="button" value="<bean:message bundle="InventoryResources" key="back.create_alsp_button.label"/>" value="Back" onclick="goBack()">&nbsp;
		  <% } %>
 
                              </table:cell>
      </table:row>
    </table:table>
  </html:form>

  </body>
</html>

<% } 
// Aggregated LSP Creation
else
{ %>

<html>
  <head>
	<%if (!("empty".equals(isManual)))
	{%>
		<title><bean:message bundle="InventoryResources" key="title.createmanuallsp"/></title>
	<%}
	else 
	{%>
		<title><bean:message bundle="LSPApplicationResources" key="<%= LSPConstants.JSP_CREATION_TITLE %>"/></title>
	<%}%>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
	<link rel="stylesheet" href="/activator/css/inventory-gui/jquery-ui.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
	<script src="/activator/javascript/jquery-1.10.2.js"></script>
	<script src="/activator/javascript/jquery-ui.js"></script>
    <style type="text/css">
		table {
		  BORDER-RIGHT: 0px;
		  BORDER-TOP: 0px;
		  BORDER-LEFT: 0px;
		  WIDTH: 100%;
		  BORDER-BOTTOM: 0px;
		  COLOR: black;
		}

		tr {
		  FONT-SIZE: 10pt;
		  FONT-FAMILY: Arial, Helvetica, Sans-serif;
		  BACKGROUND-COLOR: #e5e8e8;
		  COLOR: black;
		  TEXT-ALIGN: left;
		}
		
		td {
		  PADDING-RIGHT: 3px;
		  PADDING-LEFT: 3px;
		  FONT-SIZE: 8pt;
		  PADDING-BOTTOM: 1px;
		  COLOR: black;
		  PADDING-TOP: 1px;
		  FONT-FAMILY: Arial, Helvetica, Sans-serif;
		  TEXT-ALIGN: left;
		}
		
		th {
		  FONT-WEIGHT: bold;
		  FONT-SIZE: 10pt;
		  COLOR: black;
		  BACKGROUND-COLOR: white;
		  FONT-FAMILY: Arial, Helvetica, Sans-serif;
		  PADDING-BOTTOM: 0px;
		  MARGIN-BOTTOM: 0px;
		  TEXT-ALIGN: left;
		 }

      A.nodec { text-decoration: none; }
      H1 { color: red; font-size: 13px }
	  .custom-combobox {
		position: relative;
		display: inline-block;
	}
	.custom-combobox-toggle {
		position: absolute;
		top: 0;
		bottom: 0;
		margin-left: -1px;
		padding: 0;
		/* support: IE7 */
		*height: 1.7em;
		*top: 0.1em;
	}
	.custom-combobox-input {
		margin: 0;
		padding: 0.3em;
	}
	.ui-state-default,
.ui-widget-content .ui-state-default,
.ui-widget-header .ui-state-default {
	border: 1px solid #d3d3d3;
	background: #ffffff;
	font-weight: normal;
	color: #555555;
}
    </style>
	<script>
	(function( $ ) {
		$.widget( "custom.combobox", {
			_create: function() {
				this.wrapper = $( "<span>" )
					.addClass( "custom-combobox" )
					.insertAfter( this.element );

				this.element.hide();
				this._createAutocomplete();
				this._createShowAllButton();
			},

			_createAutocomplete: function() {
				var org_onchange = this.element.closest("select").prop("onchange");
				var selected = this.element.children( ":selected" ),
					value = selected.val() ? selected.text() : "";

				this.input = $( "<input>" )
					.appendTo( this.wrapper )
					.val( value )
					.attr( "title", "" )
					.addClass( "custom-combobox-input ui-widget ui-widget-content ui-state-default ui-corner-left" )
					.autocomplete({
						delay: 0,
						minLength: 0,
						source: $.proxy( this, "_source" ),
						
						select: function( event, ui ) {
							org_onchange();
                             ui.item.option.selected = true;
                             /*self._trigger( "selected", event, {
                                 item: ui.item.option
                             });
                             select.trigger("change"); */                          
                         },
                         change: function( event, ui ) {
							if ( !ui.item ) {
                                 var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" ),
                                     valid = false;
                                 select.children( "option" ).each(function() {
                                     if ( $( this ).text().match( matcher ) ) {
                                         this.selected = valid = true;
                                         return false;
                                     }
                                 });
                                 if ( !valid ) {
                                     // remove invalid value, as it didn't match anything
                                     $( this ).val( "" );
                                     select.val( "" );
                                     input.data( "autocomplete" ).term = "";
                                     return false;
                                 }
                             }
                         }
					})
					.tooltip({
						tooltipClass: "ui-state-highlight"
					});

				this._on( this.input, {
					autocompleteselect: function( event, ui ) {
						ui.item.option.selected = true;
						this._trigger( "select", event, {
							item: ui.item.option
						});
					},

					autocompletechange: "_removeIfInvalid"
				});
			},

			_createShowAllButton: function() {
				var input = this.input,
					wasOpen = false;

				$( "<a>" )
					.attr( "tabIndex", -1 )
					.attr( "title", "Show All Items" )
					.tooltip()
					.appendTo( this.wrapper )
					.button({
						icons: {
							primary: "ui-icon-triangle-1-s"
						},
						text: false
					})
					.removeClass( "ui-corner-all" )
					.addClass( "custom-combobox-toggle ui-corner-right" )
					.mousedown(function() {
						wasOpen = input.autocomplete( "widget" ).is( ":visible" );
					})
					.click(function() {
						input.focus();

						// Close if already visible
						if ( wasOpen ) {
							return;
						}
      
						// Pass empty string as value to search for, displaying all results
						input.autocomplete( "search", "" );
					});
			},

			_source: function( request, response ) {
				var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
				response( this.element.children( "option" ).map(function() {
					var text = $( this ).text();
					if ( this.value && ( !request.term || matcher.test(text) ) )
						return {
							label: text,
							value: text,
							option: this
						};
				}) );
			},

			_removeIfInvalid: function( event, ui ) {

				// Selected an item, nothing to do
				if ( ui.item ) {
					return;
				}
      
				// Search for a match (case-insensitive)
				var value = this.input.val(),
					valueLowerCase = value.toLowerCase(),
					valid = false;
				this.element.children( "option" ).each(function() {
					if ( $( this ).text().toLowerCase() === valueLowerCase ) {
						this.selected = valid = true;
						return false;
					}
				});
      
				// Found a match, nothing to do
				if ( valid ) {
					return;
				}
      
				// Remove invalid value
				this.input
					.val( "" )
					.attr( "title", value + " didn't match any item" )
					.tooltip( "open" );
				this.element.val( "" );
				this._delay(function() {
					this.input.tooltip( "close" ).attr( "title", "" );
				}, 2500 );
				this.input.autocomplete( "instance" ).term = "";
			},

			_destroy: function() {
				this.wrapper.remove();
				this.element.show();
			}
		});
	})( jQuery );
      
	$(function() {
		 $(".combobox").combobox();
	});

	</script>
	
	<script type="text/javascript"> 
		function performCommit() {
			
			var submit = checkComboboxes();
			
			if (submit == true)
			{
				window.document.LSPForm.action = '/activator<%=moduleConfig%>/CreationCommitLSPAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
				window.document.LSPForm.submit();
			}
		}

		function reload(){
			window.document.LSPForm.action = '/activator<%=moduleConfig%>/CreationFormLSPAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&refreshTreeRimid=<%=refreshTreeRimid%>'; 
			window.document.LSPForm.submit();
		}
		function init()
		{			
			<%
			if ( _location_ != null ) {
%>
				var elems = document.getElementsByName("<%=_location_%>");
				var elem = elems == null || elems.length == 0 ? null : elems[0];
				if (elem != null) {
					elem.focus();
				}
				<%
			}
			if ( errorMessage != null && !errorMessage.equals("") ) {
				%>
				var alert = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
				alert.setBounds(400, 120);
				alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
				alert.show();
				<%
			}
%>
		}
		function stopRKey(evt) { 
		  var evt = (evt) ? evt : ((event) ? event : null); 
		  var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null); 
		  if ((evt.keyCode == 13) && (node.type=="text"))  {return false;} 
		} 

		document.onkeypress = stopRKey; 
	</script>

  </head>
  <body style="overflow:auto;" onload="init();">
  
                                                                        <%                        
	String rowsuffix = "1"; 
	if (request.getParameter("rowsuffix") != null)
	{
		rowsuffix = request.getParameter("rowsuffix");
	}
	int suffix = Integer.parseInt(rowsuffix);
	
	boolean disableCreation = false;
	
	Connection con = null;

	com.hp.ov.activator.cr.inventory.Network[] headNetworkList = null;
	com.hp.ov.activator.cr.inventory.Network headNetwork = null;

	ArrayList<LabelValueBean> headPENetworkListofValues = new ArrayList<LabelValueBean>();
										
	com.hp.ov.activator.vpn.inventory.EXPMapping[] expMappings = null;
	com.hp.ov.activator.vpn.inventory.LSPProfile[] lspProfiles = null;
	com.hp.ov.activator.vpn.inventory.RateLimit[] rlList = null;
		  
	try
	{
		DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
		if (ds != null)
		{
			con = ds.getConnection();
			headNetworkList = com.hp.ov.activator.cr.inventory.Network.findByType(con,"Network");	
		}

		expMappings = com.hp.ov.activator.vpn.inventory.EXPMapping.findAll(con);
		lspProfiles = com.hp.ov.activator.vpn.inventory.LSPProfile.findAll(con);
		rlList = com.hp.ov.activator.vpn.inventory.RateLimit.findAll(con);
	} 
	catch(Exception e)
	{
		System.out.println("Exception getting requested data from database: "+e);
	}
	finally
	{
		if (con != null)
		{
			try 
			{
				con.close();
			}
			catch (Exception rollbackex)
			{
				// Ignore
			}
		}
	}
		  
	headNetworkList = headNetworkList != null ? headNetworkList : new com.hp.ov.activator.cr.inventory.Network[0];
	  
	for (int i = 0; i < headNetworkList.length; i++) 
	{
		com.hp.ov.activator.cr.inventory.Network headNetworkListObject = headNetworkList[i];
	  
		LabelValueBean headNetworkObject = new LabelValueBean(headNetworkListObject.getName(),headNetworkListObject.getNetworkid());

		headPENetworkListofValues.add(headNetworkObject);
	}
		  
		  
	// Get list of COS
		  
	ArrayList<String> COSListOfValues = new ArrayList<String>();
		  
	expMappings = expMappings != null ? expMappings : new com.hp.ov.activator.vpn.inventory.EXPMapping[0];
	lspProfiles = lspProfiles != null ? lspProfiles : new com.hp.ov.activator.vpn.inventory.LSPProfile[0];
		  
	for (int i = 0; i < expMappings.length; i++) 
	{
		com.hp.ov.activator.vpn.inventory.EXPMapping expMapping = expMappings[i];
		String cosName = expMapping.getClassname();
		
		for (int j = 0; j < lspProfiles.length; j++)
		{
			com.hp.ov.activator.vpn.inventory.LSPProfile lspProfile = lspProfiles[j];
			String pcosName = lspProfile.getCos();
			String pbwAlgorithm = lspProfile.getBwalgorithm();
			
			if ((cosName.equals(pcosName)) && ("manual".equals(pbwAlgorithm)))
			{
				if (!COSListOfValues.contains(cosName)) COSListOfValues.add(cosName);
			}
		}
	}

	// Get list of BW
	ArrayList<String> RLListOfValues = new ArrayList<String>();

	rlList = rlList != null ? rlList : new com.hp.ov.activator.vpn.inventory.RateLimit[0];

	for (int i = 0; i < rlList.length; i++) 
	{
		com.hp.ov.activator.vpn.inventory.RateLimit rateLimit = rlList[i];
		RLListOfValues.add(rateLimit.getRatelimitname());
	}
	
  %>
  
  <script language="javascript">
		function addRow(tableID) {

			var form = window.document.LSPForm;
			
			var table = document.getElementById(tableID);

			var rowCount = table.rows.length;
			var row = table.insertRow(rowCount);

			var cell1 = row.insertCell(0);
			var element1 = document.createElement("input");
			element1.type = "checkbox";
			element1.name="chkbox";
			cell1.appendChild(element1);
			cell1.setAttribute("width", "6%");

			var cell2 = row.insertCell(1);
							
			var element2 = document.createElement("select");
			element2.type = "select-one";
						
			var elementPrefix = "headnetworkid";
			var elementSuffix = parseInt(form.rowsuffix.value, 10);
			var elementName = elementPrefix + elementSuffix; 
			
			element2.name = elementName;
			
			element2.id = "combobox";
			element2.setAttribute("class", "combobox");
			
			element2.setAttribute("style", "display: none;");
			element2.setAttribute("onchange", "reload();");
			
			var selectOpt = document.createElement('option');	
			selectOpt.value = '';
			selectOpt.innerHTML = 'Select one...';					
			element2.appendChild(selectOpt);
					
			<% 	for( int i = 0 ; i < headPENetworkListofValues.size() ; i++ )
				{
					LabelValueBean headPENetworkObject = headPENetworkListofValues.get(i); %>
					var opt = document.createElement('option');	
					opt.value = '<%=headPENetworkObject.getValue() %>';
					opt.innerHTML = '<%=headPENetworkObject.getLabel() %>';					
					element2.appendChild(opt);
			<% } %>
			
			cell2.appendChild(element2);
			
			$(".combobox").combobox();
			cell2.setAttribute("width", "19%");
			
			var cell3 = row.insertCell(2);
			cell3.setAttribute("width", "19%");
			
			var cell4 = row.insertCell(3);
			cell4.setAttribute("width", "19%");
			
			var cell5 = row.insertCell(4);
			cell5.setAttribute("width", "19%");
			
			var cell6 = row.insertCell(5);
			cell6.setAttribute("width", "9%");
			
			var cell7 = row.insertCell(5);
			cell7.setAttribute("width", "9%");
			
			reload();
		}

		function deleteRow(tableID) {
			try {
			var table = document.getElementById(tableID);
			var rowCount = table.rows.length;

			for(var i=0; i<rowCount; i++) {
				var row = table.rows[i];
				var chkbox = row.cells[0].childNodes[0];
				if(null != chkbox && true == chkbox.checked) {
					table.deleteRow(i);
					rowCount--;
					i--;
				}


			}
			}catch(e) {
				alert(e);
			}
			
			reload();
		}
		
		function incrementValue()
		{
			var form = window.document.LSPForm;
			var rowcountvalue = parseInt(form.rowsuffix.value, 10);
			
			rowcountvalue = isNaN(rowcountvalue) ? 0 : rowcountvalue;
			rowcountvalue++;
			form.rowsuffix.value = rowcountvalue;
		}
		
		function resetRow(level, rowNum, current)
		{
			switch(level) 
			{
				case '1':
					
					var headnetworkid = document.getElementsByName("headnetworkid"+rowNum);
					var newheadnetworkid = headnetworkid[0].value;
					
					// if new head network is the same than the current head network there are no changes
					if (newheadnetworkid == current) break; 
					
					try
					{
						var headpebox = document.getElementsByName("headpebox"+rowNum);
						headpebox[0].value = '';
					}
					catch (err) { /* Ignore */ }
					
					try
					{
						var tailnetworkid = document.getElementsByName("tailnetworkid"+rowNum);
						tailnetworkid[0].value = '';
					}
					catch (err) { /* Ignore */ }
					
					try
					{
						var tailpebox = document.getElementsByName("tailpebox"+rowNum);
						tailpebox[0].value = '';
					}
					catch (err) { /* Ignore */ }
					
					break;
				
				case '2':
				
					var headpebox = document.getElementsByName("headpebox"+rowNum);
					var newheadpebox = headpebox[0].value;
					
					// if new head PE is the same than the current head PE there are no changes
					if (newheadpebox == current) break; 
					
					try
					{
						var tailnetworkid = document.getElementsByName("tailnetworkid"+rowNum);
						tailnetworkid[0].value = '';
					}
					catch (err) { /* Ignore */ }
					
					try
					{
						var tailpebox = document.getElementsByName("tailpebox"+rowNum);
						tailpebox[0].value = '';
					}
					catch (err) { /* Ignore */ }
					
					break;
					
				case '3':
				
					var tailnetworkid = document.getElementsByName("tailnetworkid"+rowNum);
					var newtailnetworkid = tailnetworkid[0].value;
					
					// if new tail network is the same than the current tail network there are no changes
					if (newtailnetworkid == current) break; 
					
					try
					{
						var tailpebox = document.getElementsByName("tailpebox"+rowNum);
						tailpebox[0].value = '';
					}
					catch (err) { /* Ignore */ }
					
					break;
			}
		}
		
		function checkComboboxes()
		{
			var comboboxes = document.getElementsByClassName("combobox");
			
			for(var i=0; i < comboboxes.length; i++) 
			{
				if (comboboxes[i].value == '') 
				{
					var alert = new HPSAAlert('<bean:message bundle="LSPApplicationResources" key="message.emptyfields"/>');
					alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
					alert.setBounds(500, 120);
					alert.show();
	
					return false;
				}
			}
			
			return true;
		}
		
		function disableButtons()
		{
			var inputs = document.getElementsByTagName("INPUT");
			for (var i = 0; i < inputs.length; i++) {
				if (inputs[i].type == 'button') {
					inputs[i].disabled = true;
				}
			}
		}
		
	</script>
  
  <center> 
<h2 style="width:100%; text-align:center;">
	<%if (!("empty".equals(isManual)))
	{%>
		<bean:message bundle="InventoryResources" key="title.createmanuallsp"/>
	<%}
	else 
	{%>
  <bean:message bundle="LSPApplicationResources" key="jsp.creation.title"/>
	<%}%>
</h2> 
</center>


<H1>
		<html:errors bundle="PERouterApplicationResources" property="NetworkElementID" /> 
		<html:errors bundle="PERouterApplicationResources" property="NetworkID" /> 
        <html:errors bundle="PERouterApplicationResources" property="Name"/>
        <html:errors bundle="PERouterApplicationResources" property="Description"/>
        <html:errors bundle="PERouterApplicationResources" property="Location"/>
        <html:errors bundle="PERouterApplicationResources" property="IP"/>
		<html:errors bundle="PERouterApplicationResources" property="management_IP" />
        <html:errors bundle="PERouterApplicationResources" property="ManagementInterface"/>
        <html:errors bundle="PERouterApplicationResources" property="UsernameEnabled"/>
        <html:errors bundle="PERouterApplicationResources" property="Username"/>
        <html:errors bundle="PERouterApplicationResources" property="Password"/>
        <html:errors bundle="PERouterApplicationResources" property="EnablePassword"/>
        <html:errors bundle="PERouterApplicationResources" property="Vendor"/>
		<html:errors bundle="PERouterApplicationResources" property="OSversion" />
        <html:errors bundle="PERouterApplicationResources" property="ElementType"/>
        <html:errors bundle="PERouterApplicationResources" property="SerialNumber"/>
        <html:errors bundle="PERouterApplicationResources" property="Role"/>
		<html:errors bundle="PERouterApplicationResources" property="State" />
        <html:errors bundle="PERouterApplicationResources" property="LifeCycleState"/>
        <html:errors bundle="PERouterApplicationResources" property="Backup"/>
        <html:errors bundle="PERouterApplicationResources" property="SchPolicyName"/>
        <html:errors bundle="PERouterApplicationResources" property="ROCommunity"/>
        <html:errors bundle="PERouterApplicationResources" property="RWCommunity"/>
		<html:errors bundle="PERouterApplicationResources" property="BGPDiscovery" />
        <html:errors bundle="PERouterApplicationResources" property="Tier"/>
      <html:errors bundle="LSPApplicationResources" property="LSPId"/>
        <html:errors bundle="LSPApplicationResources" property="TunnelId"/>
        <html:errors bundle="LSPApplicationResources" property="headPE"/>
        <html:errors bundle="LSPApplicationResources" property="headPEName"/>
        <html:errors bundle="LSPApplicationResources" property="tailPE"/>
        <html:errors bundle="LSPApplicationResources" property="tailPEName"/>
        <html:errors bundle="LSPApplicationResources" property="headIP"/>
        <html:errors bundle="LSPApplicationResources" property="tailIP"/>
        <html:errors bundle="LSPApplicationResources" property="headVPNIP"/>
        <html:errors bundle="LSPApplicationResources" property="tailVPNIP"/>
        <html:errors bundle="LSPApplicationResources" property="Bandwidth"/>
        <html:errors bundle="LSPApplicationResources" property="TerminationPointID"/>
        <html:errors bundle="LSPApplicationResources" property="ActivationState"/>
        <html:errors bundle="LSPApplicationResources" property="AdminState"/>
        <html:errors bundle="LSPApplicationResources" property="ActivationDate"/>
        <html:errors bundle="LSPApplicationResources" property="ModificationDate"/>
        <html:errors bundle="LSPApplicationResources" property="LSPProfileName"/>
        <html:errors bundle="LSPApplicationResources" property="UsageMode"/>
  </H1>
<script type="text/javascript">
var allEvents = "";
function addListener(element,eventName,functionName){
  if(element.addEventListener){
    element.addEventListener(eventName,functionName,false);
                        } else {
    element.attachEvent("on" + eventName,functionName);
  }
}
</script>
<script>
function doOnLoad()
{
  // hide field
                                                                                                                // check hiding rules
  eval(allEvents);
}
addListener(window, "load", doOnLoad);
</script>
	<% String formAction = "/CreationCommitLSPAction.do?datasource=" + datasource + "&rimid=" + rimid; %>
	<html:form action="<%= formAction %>" style="text-align:center;">
	
	<html:hidden property="rowsuffix" value="<%= rowsuffix %>"/>
	<html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
  
	<table id="dataTable" style="width:1000px">
					
		<tr>
        <th width="6%">
			<input type="image" src="/activator/images/inventory-gui/tree/collapsed.gif" onclick="incrementValue(); addRow('dataTable');"/> 
			<input type="image" src="/activator/images/inventory-gui/tree/expanded.gif" onclick="deleteRow('dataTable');"/>
        </th>
        <th width="19%">
			<bean:message bundle="InventoryResources" key="field.head_pe_network.label"/>
        </th>
		<th width="19%">
			<bean:message bundle="InventoryResources" key="field.head_pe.label"/>
        </th>
		<th width="19%">
			<bean:message bundle="InventoryResources" key="field.tail_pe_network.label"/>
        </th>
		<th width="19%">
			<bean:message bundle="InventoryResources" key="field.tail_pe.label"/>
        </th>
		<th width="9%">
			<bean:message bundle="InventoryResources" key="field.cos.label"/>
        </th>
		<th width="9%">
			<bean:message bundle="InventoryResources" key="field.bandwidth.label"/>
        </th>
		</tr>
	
		<% 
		
		int count = 0; 
		
		for (int i=1; i < suffix+1; i++)
		{
			String headnetworkidName = "headnetworkid"+String.valueOf(i);
							
			if (request.getParameter(headnetworkidName) != null)
			{
				String key = headnetworkidName;
				String value = request.getParameter(headnetworkidName);
				
				String entryNumber = key.replace("headnetworkid","");

				String selectedHeadNetwork = ""; 
				String selectedHeadPE = ""; 
				String selectedTailNetwork = ""; 
				String selectedTailPE = ""; 
				String selectedCOS = ""; 
				String selectedBW = ""; 
				
				%>
				<tr>
					<td width="6%"><input type="checkbox" name="chkbox"/></td>
					<td width="19%">
						<select name="<%=key%>" id="combobox" class="combobox" onchange="resetRow('1', '<%=entryNumber%>', '<%=value%>'); reload();">
							<option value=""><bean:message bundle="InventoryResources" key="combobox.select_one.label"/></option>
							<% for( int j = 0 ; j < headPENetworkListofValues.size() ; j++ )
							{
									LabelValueBean headPENetworkObject = headPENetworkListofValues.get(j);
									
									if ((headPENetworkObject.getValue()).equals(value)) { %>		 
										<option value="<%= headPENetworkObject.getValue() %>" selected><%= headPENetworkObject.getLabel() %></option>
										<% selectedHeadNetwork = value;%>
									<% } else { %>
										<option value="<%= headPENetworkObject.getValue() %>"><%= headPENetworkObject.getLabel() %></option>
									<% } %>
									
							<% } %>
						</select>
					</td>
					
					<td width="19%">
						<% if ("".equals(selectedHeadNetwork)) { %>
								<bean:message bundle="InventoryResources" key="field.select_head_pe_network_first.label"/>
						<% } else 
							{
								com.hp.ov.activator.vpn.inventory.PERouter[] headPEList = null;                                   
								ArrayList<LabelValueBean> headPEListofValues = new ArrayList<LabelValueBean>();
								
								try
								{
									DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
									if (ds != null)
									{
										con = ds.getConnection();
									}
									
									headPEList = com.hp.ov.activator.vpn.inventory.PERouter.findByNetworkid(con, selectedHeadNetwork);	

									headPEList = headPEList != null ? headPEList : new com.hp.ov.activator.vpn.inventory.PERouter[0];
	  
									for (int j = 0; j < headPEList.length; j++) 
									{
										com.hp.ov.activator.vpn.inventory.PERouter headPEListObject = headPEList[j];
									  
										LabelValueBean headPEObject = new LabelValueBean(headPEListObject.getName(),headPEListObject.getNetworkelementid());
									  
										headPEListofValues.add(headPEObject);
                        }    
								} 
								catch(Exception e)
								{
									System.out.println("Exception getting requested data from database: "+e);
								}
								finally
								{
									if (con != null)
									{
										try 
										{
											con.close();
										}
										catch (Exception rollbackex)
										{
											// Ignore
										}
									}
								}		

								String headpeboxName = "headpebox"+entryNumber;
								
								if (request.getParameter(headpeboxName) != null)
								{
									selectedHeadPE = request.getParameter(headpeboxName);
								}
																
                    %>
								<select name="<%=headpeboxName%>" id="combobox" class="combobox" onchange="reload();">
									<option value=""><bean:message bundle="InventoryResources" key="combobox.select_one.label"/></option>
									<% for( int j = 0 ; j < headPEListofValues.size() ; j++ )
									{
											LabelValueBean headPEObject = headPEListofValues.get(j);

											if ((headPEObject.getValue()).equals(selectedHeadPE)) { %>		
												<option value="<%= headPEObject.getValue() %>" selected><%= headPEObject.getLabel() %></option>
											<% } else { %>
												<option value="<%= headPEObject.getValue() %>"><%= headPEObject.getLabel() %></option>
											<% } %>
									<% } %>
								</select>
						<% } %>
					</td>
					<td width="19%">
						<% if ("".equals(selectedHeadPE)) { %>
							<bean:message bundle="InventoryResources" key="field.select_head_pe_first.label"/>
						<% } else {
                              
								com.hp.ov.activator.vpn.inventory.PERouter beanHeadPERouter = null;
										
								com.hp.ov.activator.cr.inventory.Network tailNetwork = null;
								
								com.hp.ov.activator.cr.inventory.Network[] tailNetworkList = null;
																	
								ArrayList<LabelValueBean> tailPENetworkListofValues = new ArrayList<LabelValueBean>();
								
								try
								{
									DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
									if (ds != null)
									{
										con = ds.getConnection();
									}

									beanHeadPERouter = (com.hp.ov.activator.vpn.inventory.PERouter) com.hp.ov.activator.vpn.inventory.PERouter.findByPrimaryKey(con, selectedHeadPE);
				
									headNetwork = com.hp.ov.activator.cr.inventory.Network.findByNetworkid(con,beanHeadPERouter.getNetworkid());
									
									if ( (headNetwork.getAsn() != null) && !("".equals(headNetwork.getAsn())) )
									{
										String whereClause = "CRModel#Network.Type='Network' and CRModel#Network.Asn = "+headNetwork.getAsn();
										tailNetworkList = com.hp.ov.activator.cr.inventory.Network.findAll(con,whereClause);
									}
									else
									{
										String whereClause = "CRModel#Network.Type='Network' and (CRModel#Network.Asn is null or CRModel#Network.Asn='')";
										tailNetworkList = com.hp.ov.activator.cr.inventory.Network.findAll(con,whereClause);
									}		

									if (tailNetwork != null) 
									{
										LabelValueBean tailNetworkObject = new LabelValueBean(tailNetwork.getName(),tailNetwork.getNetworkid());
									  
										tailPENetworkListofValues.add(tailNetworkObject);
									}
									else
									{
										tailNetworkList = tailNetworkList != null ? tailNetworkList : new com.hp.ov.activator.cr.inventory.Network[0];
									  
										for (int j = 0; j < tailNetworkList.length; j++) 
										{
											com.hp.ov.activator.cr.inventory.Network tailNetworkListObject = tailNetworkList[j];
									  
											LabelValueBean tailNetworkObject = new LabelValueBean(tailNetworkListObject.getName(),tailNetworkListObject.getNetworkid());
									  
											tailPENetworkListofValues.add(tailNetworkObject);
										}
									}	
								} 
								catch(Exception e)
								{
									System.out.println("Exception getting requested data from database: "+e);
								}
								finally
								{
									if (con != null)
									{
										try 
										{
											con.close();
										}
										catch (Exception rollbackex)
										{
											// Ignore
										}
									}
								}								

								String tailnetworkidName = "tailnetworkid"+entryNumber;
								
								if (request.getParameter(tailnetworkidName) != null)
								{
									selectedTailNetwork = request.getParameter(tailnetworkidName);
								}
								
							%>
							
							<select name="<%=tailnetworkidName%>" id="combobox" class="combobox" onchange="resetRow('3', '<%=entryNumber%>', '<%=selectedTailNetwork%>'); reload();">
								<option value=""><bean:message bundle="InventoryResources" key="combobox.select_one.label"/></option>
								<% for( int j = 0 ; j < tailPENetworkListofValues.size() ; j++ )
								{
										LabelValueBean tailPENetworkObject = tailPENetworkListofValues.get(j);
										
										if ((tailPENetworkObject.getValue()).equals(selectedTailNetwork)) { %>
											<option value="<%= tailPENetworkObject.getValue() %>" selected><%= tailPENetworkObject.getLabel() %></option>
										<% } else { %>
											<option value="<%= tailPENetworkObject.getValue() %>"><%= tailPENetworkObject.getLabel() %></option>
										<% } %>
								<% } %>
							</select>
							
						<% } %>
					</td>
					<td width="19%">
						<% if ("".equals(selectedTailNetwork)) { %>
							<bean:message bundle="InventoryResources" key="field.select_tail_pe_network_first.label"/>
						<% } else 
							{
								com.hp.ov.activator.vpn.inventory.PERouter[] tailPEList = null;                                   
								ArrayList<LabelValueBean> tailPEListofValues = new ArrayList<LabelValueBean>();
								
								try
								{
									DataSource ds = (DataSource) InventoryTreeServlet.getDatasource(datasource);
									if (ds != null)
									{
										con = ds.getConnection();
									}
									
									tailPEList = com.hp.ov.activator.vpn.inventory.PERouter.findByNetworkid(con, selectedTailNetwork);	

									tailPEList = tailPEList != null ? tailPEList : new com.hp.ov.activator.vpn.inventory.PERouter[0];
	  
									for (int j = 0; j < tailPEList.length; j++) 
									{
										com.hp.ov.activator.vpn.inventory.PERouter tailPEListObject = tailPEList[j];
									  
										LabelValueBean tailPEObject = new LabelValueBean(tailPEListObject.getName(),tailPEListObject.getNetworkelementid());
									  
										tailPEListofValues.add(tailPEObject);
									}
								} 
								catch(Exception e)
								{
									System.out.println("Exception getting requested data from database: "+e);
								}
								finally
								{
									if (con != null)
									{
										try 
										{
											con.close();
										}
										catch (Exception rollbackex)
										{
											// Ignore
										}
									}
								}		

								String tailpeboxName = "tailpebox"+entryNumber;
								
								if (request.getParameter(tailpeboxName) != null)
								{
									selectedTailPE = request.getParameter(tailpeboxName);
								}
																
								%>
								<select name="<%=tailpeboxName%>" id="combobox" class="combobox" onchange="reload();">
									<option value=""><bean:message bundle="InventoryResources" key="combobox.select_one.label"/></option>
									<% for( int j = 0 ; j < tailPEListofValues.size() ; j++ )
									{
											LabelValueBean tailPEObject = tailPEListofValues.get(j);
											
											if ((tailPEObject.getValue()).equals(selectedHeadPE)) continue;
											
											if ((tailPEObject.getValue()).equals(selectedTailPE)) { %>		
												<option value="<%= tailPEObject.getValue() %>" selected><%= tailPEObject.getLabel() %></option>
											<% } else { %>
												<option value="<%= tailPEObject.getValue() %>"><%= tailPEObject.getLabel() %></option>
											<% } %>
									<% } %>
								</select>
						<% } %>
					</td>
					<td width="9%">
						<% if (COSListOfValues.size() == 0)
						{
							disableCreation = true; 
							%> <bean:message bundle="InventoryResources" key="warning.no_lsp_profiles_available.label"/> <%
									}    
						else 
						{
							String cosboxname = "cosbox"+entryNumber;
								
							if (request.getParameter(cosboxname) != null)
							{
								selectedCOS = request.getParameter(cosboxname);
							} 
							%>
							<select name="<%=cosboxname%>">
								<% 				
								for( int j = 0 ; j < COSListOfValues.size() ; j++ )
								{
									String  COSValue = (COSListOfValues.get(j)).toString();

									if (COSValue.equals(selectedCOS))
									{
									%>
										<option selected="selected" value="<%= COSValue %>"><%= COSValue %></option>
									<% } else {
									%>
										<option value="<%= COSValue %>"><%= COSValue %></option>
									<% }} %>
							</select>
						<% } %>
					</td>
					<td width="9%">
						<% 
							String bandwidthboxname = "bandwidth"+entryNumber;
								
							if (request.getParameter(bandwidthboxname) != null)
							{
								selectedBW = request.getParameter(bandwidthboxname);
							} 
						%>
						<select name="<%=bandwidthboxname%>">
							<% for( int j = 0 ; j < RLListOfValues.size() ; j++ )
							{
							String rateLimit = RLListOfValues.get(j);
											  
							if (!("Unknown".equals(rateLimit)))
							{
								if (rateLimit.equals(selectedBW))
								{ %>
									<option selected="selected" value="<%=rateLimit%>"><%=rateLimit%></option>
							<%	} else
								{ %>
									<option value="<%=rateLimit%>"><%=rateLimit%></option>
							<%	}
							}			
							} %>
							</select>
					</td>
				</tr>	
				<%
				count++;
			}
		}
		
		if (count < 1)
		{
			if (suffix < 2) 
			{
				String selectedCOS = ""; 
				String selectedBW = ""; 
				
			%>
				<tr>
					<td width="6%"><input type="checkbox" name="chkbox"/></td>
					<td width="19%">
						<select name="headnetworkid1" id="combobox" class="combobox" onchange="reload();">
							<option value=""><bean:message bundle="InventoryResources" key="combobox.select_one.label"/></option>
							<% for( int i = 0 ; i < headPENetworkListofValues.size() ; i++ )
							{
									LabelValueBean headPENetworkObject = headPENetworkListofValues.get(i);%>
												 
									<option value="<%= headPENetworkObject.getValue() %>"><%= headPENetworkObject.getLabel() %></option>
									
							<% } %>
						</select>
					</td>
					<td width="19%">
						<bean:message bundle="InventoryResources" key="field.select_head_pe_network_first.label"/>
					</td>
					<td width="19%">
						<bean:message bundle="InventoryResources" key="field.select_head_pe_first.label"/>
					</td>
					<td width="19%">
						<bean:message bundle="InventoryResources" key="field.select_tail_pe_network_first.label"/>
					</td>
					<td width="9%">
						<% if (COSListOfValues.size() == 0)
						{
							disableCreation = true; 
							%> <bean:message bundle="InventoryResources" key="warning.no_lsp_profiles_available.label"/> <%
									}    
						else 
						{
								%>
						<select name="cosbox1">
							<% 				
							for( int i = 0 ; i < COSListOfValues.size() ; i++ )
							{
								String  COSValue = (COSListOfValues.get(i)).toString();

								if (COSValue.equals(selectedCOS))
								{
								%>
								<option selected="selected" value="<%= COSValue %>"><%= COSValue %></option>
								<% } else {
								%>
								<option value="<%= COSValue %>"><%= COSValue %></option>
								<% }} %>
						 </select>
						 <% } %>
					</td>
					<td width="9%">
						<select name="bandwidth1">
							<% for( int i = 0 ; i < RLListOfValues.size() ; i++ )
							{
							String rateLimit = RLListOfValues.get(i);
											  
							if (!("Unknown".equals(rateLimit)))
							{
								if (rateLimit.equals(selectedBW))
								{ %>
									<option selected="selected" value="<%=rateLimit%>"><%=rateLimit%></option>
							<%	} else
								{ %>
									<option value="<%=rateLimit%>"><%=rateLimit%></option>
							<%	}
							}			
							} %>
						</select>
					</td>
				</tr>	
			<% }
			else
			{
				disableCreation = true;
			%>
				<img src="/activator/images/warning.gif"> <bean:message bundle="LSPApplicationResources" key="message.nolspstocreate"/>
			<%}
		} %>
				
	</table>
      
        <br>
       
	<table:table width="1000px">
      <table:row>
			<table:cell align="center">
				<% if (!disableCreation) { %>
					<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.create_alsp_button.label"/>" name="enviando" class="ButtonSubmit" onclick="disableButtons(); performCommit();">&nbsp;
				<% } else { %>
					<input disabled="true" type="button" value="<bean:message bundle="InventoryResources" key="confirm.create_alsp_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
				<% } %>
        </table:cell>
      </table:row>
    </table:table>

	<html:hidden property="headpe" value="1"/>
	<html:hidden property="tailpe" value="1"/>
	<html:hidden property="headip" value="1"/>
	<html:hidden property="tailip" value="1"/>
	<html:hidden property="headvpnip" value="1"/>
	<html:hidden property="tailvpnip" value="1"/>

   </html:form>
  </body>
</html>

<%}%>