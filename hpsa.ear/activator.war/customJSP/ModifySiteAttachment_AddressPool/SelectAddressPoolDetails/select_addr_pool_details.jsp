<!-- ============================================================== -->
<!-- HP Service Activator V70-3A                                    -->
<!-- Customized JSP.                                                -->
<!--                                                                -->
<!-- Copyright 2000-2015 Hewlett-Packard Development Company, L.P.  -->
<!-- All Rights Reserved                                            -->
<!--                                                                -->
<!-- ============================================================== -->
<!-- Queue: 'select_addr_pool_details' -->
<%@ page contentType="text/html; charset=UTF-8"
         import="com.hp.ov.activator.mwfm.*, com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.inventory.facilities.StringFacility, com.hp.ov.activator.cr.inventory.*, com.hp.ov.activator.vpn.inventory.*, java.sql.*, javax.sql.DataSource, java.util.*, java.io.*" %>

<%
     JobRequestDescriptor jobRequestDescriptor = (JobRequestDescriptor) session.getAttribute(Constants.MWFM_JOB_DESCRIPTOR);
	 
	 String pool_name 				= null;
	 String secondary_pool_name 	= null;
	 String current_ipnet 			= null;
	 String current_secondary_ipnet = null;
	 
	 String managed_ce = null;
	 
	 IPAddrPool newPool   = null;
	 IPAddrPool newPool2  = null;
	 
	 IPNet[] ipnets		  = null;
	 IPNet[] ipnets2	  = null;
	 
	 IPNet currIpnet  = null;
	 IPNet currIpnet2 = null;
	 
	 IPAddrPool currPool  = null;
	 IPAddrPool currPool2 = null;
	 
	 String selected_ip   		  = null;
	 String selected_secondary_op = null;
	 
	 String vpnInfo = null;
	 
	 boolean ipnetUnavailable = false;
	 boolean secondaryIpnetUnavailable = false;
	 
	 int minimum_length = 0;
	 
	 DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);
     Connection con = dataSource.getConnection();
	 
	 try
	 {		 		
		 AttributeDescriptor poolNameAttr				= jobRequestDescriptor.attributes[0];
		 AttributeDescriptor secondaryPoolNameAttr		= jobRequestDescriptor.attributes[1];
		 AttributeDescriptor currentIpNetAttr 			= jobRequestDescriptor.attributes[2];
		 AttributeDescriptor currentSecondaryIPNetAttr 	= jobRequestDescriptor.attributes[3];
		 AttributeDescriptor vpnInfoAttr				= jobRequestDescriptor.attributes[6];
		 AttributeDescriptor managedCE					= jobRequestDescriptor.attributes[7];
		 
		 pool_name 				 = poolNameAttr.value;
		 secondary_pool_name 	 = secondaryPoolNameAttr.value;
		 current_ipnet 			 = currentIpNetAttr.value;
		 current_secondary_ipnet = currentSecondaryIPNetAttr.value;
		 
		 managed_ce = managedCE.value;
	 
		 newPool = IPAddrPool.findByName(con, poolNameAttr.value); 
		 ipnets  = IPNet.findByPoolname(con, newPool.getName(), "v_ipnet.count__<>'0'");
		 
		 if (!("".equals(secondaryPoolNameAttr.value)))
		 {
			newPool2  = IPAddrPool.findByName(con, secondaryPoolNameAttr.value); 
			ipnets2 = IPNet.findByPoolname(con, newPool2.getName(), "v_ipnet.count__<>'0'");
			
			if ((newPool2.getName()).equals(newPool.getName()))
			{
				minimum_length = 1; 
			}
		 }
		 
		 currIpnet = IPNet.findByIpnetaddr(con, currentIpNetAttr.value);
		 currPool = IPAddrPool.findByName(con, currIpnet.getPoolname());
		 
		 currIpnet2 = IPNet.findByIpnetaddr(con, currentSecondaryIPNetAttr.value);
		 
		 if (currIpnet2 != null)
		 {
			currPool2 = IPAddrPool.findByName(con, currIpnet2.getPoolname());
		 }
		 
		 vpnInfo = vpnInfoAttr.value;
		 
		 con.close();
	 }
	 catch (Exception e) 
	 {
		System.out.println("Exception in Address Pool details selection: " + e.getMessage());
		e.printStackTrace();
	 }
	 finally
	 {
		if (con != null) 
		{
			con.close();
		}
	 }
	 
	 String selectIpTooltip = "Select IP Net manually or leave it in Auto for automatic pick up from the pool";
	 String selectSecondaryIpTooltip = "Select IP Net manually or leave it in Auto for automatic pick up from the pool";
	 
	 String updateCEManually = "Managed CE is set to false. If necessary, please update CE Router configuration manually";

	try
	{
%>
<html>
<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
  <script language="JavaScript" src='/activator/javascript/saUtilities.js'></script>
  <script language="JavaScript">       
		window.resizeTo(800,450);
	  </script>
  <script language="JavaScript">
    function submitForm() 
	{
        var form = document.form;
        
		form.selected_ip.value = form.cmbSelectIP.value;
        form.selected_secondary_ip.value = form.cmbSelectSecondaryIP.value;
		
        form.submit();
    }
	
	function submitFormCancel() 
	{
        var form = document.form;
        
		form.selected_ip.value = "cancel";
		
        form.submit();
    }
  </script>
  <meta http-equiv="content-type" content="text/html; charset=utf-8">
</head>
<body onmousemove='logoutTimerReset();' onkeydown='logoutTimerReset();' onUnLoad="opener.window.top.interactWindow=null">
<h3><img src="/activator/images/HPlogo-black.gif" valign="top" align="right">Interact with job: ModifySiteAttachment_AddressPool</h3> 
<center>
<table width="100%" border=0 cellpadding=0>
<tr>
   <td class="tableHeading">VPN Info</td>
   <td class="tableHeading">Service Id</td>
   <td class="tableHeading">Workflow</td>
   <td class="tableHeading">Status</td>
   <td class="tableHeading">Start Time</td>
   <td class="tableHeading">Post Time</td>
   <td class="tableHeading">Step</td>
   <td class="tableHeading">Description</td>
</tr>
<tr>
   <td class="tableRow"> <%= vpnInfo %> </td>
   <td class="tableRow"> <%= jobRequestDescriptor.serviceId %> </td>
   <td class="tableRow"> <%= jobRequestDescriptor.name %> </td>
   <td class="tableRow"> <%= jobRequestDescriptor.status == null ? "&nbsp;" : jobRequestDescriptor.status %> </td>
   <td class="tableRow"> <%= jobRequestDescriptor.startTime %> </td>
   <td class="tableRow"> <%= jobRequestDescriptor.postDate %> </td>
   <td class="tableRow"> <%= jobRequestDescriptor.stepName == null ? "&nbsp;" : jobRequestDescriptor.stepName %> </td>
   <td class="tableRow"> Select new IP Pools / IP Nets </td>
</tr>
</table>
<p>
<form name="form" action="/activator/sendCasePacket" method="POST">
<table>
   <input type="hidden" name="id" value="<%= jobRequestDescriptor.jobId %>">
   <input type="hidden" name="workflow" value="<%= jobRequestDescriptor.name %>">
   <input type="hidden" name="queue" value="select_addr_pool_details">
	<tr class="tableRow" style="background: #FFFFFF">
       <td><b>Current IP Pool / IP Net: </b></td>
       <td><%=currPool.getName()%> / <%=currIpnet.getIpnetaddr()%></td>
       <td></td>
    </tr>
	<tr class="tableRow" style="background: #FFFFFF">
       <td><b>New IP Pool: </b></td>
       <td><%=newPool.getName()%></td>
       <td></td>
    </tr>
	<tr class="tableRow" style="background: #FFFFFF">
       <td ><b title="<%=selectIpTooltip%>" >Select new IPNet: </b></td>
       <td>
		<% if (ipnets.length > minimum_length) { %>
			<select name="cmbSelectIP" style="width:130px" title="<%=selectIpTooltip%>" >
                    				
					<% if ((newPool.getName()).equals(currPool.getName())) {%>
						<option value="nochange" selected>No change</option> 
						<option value="auto">Auto</option> 
					<% } else { %>
						<option value="auto" selected>Auto</option> 
					<% } %>
					
					<% String ipnetStr = null;
                    
					for (int i=0; i < ipnets.length; i++) 
					{
                        ipnetStr = ipnets[i].getIpnetaddr();

                        %><option value="<%=ipnetStr%>" ><%=ipnetStr%></option> <%
                   }%>
			</select>
		<% } else { 
			ipnetUnavailable = true; %>
			Not enough free IPNets available in <%=newPool.getName()%>
			<input type="hidden" name="cmbSelectIP" value="nochange">
		<% } %>
       </td>
       <td></td>
    </tr>
	
	<tr class="tableRow" style="background: #FFFFFF">
		<td><b>Current Secondary IP Pool / IP Secondary Net: </b></td>
		 <% if(currPool2 != null) { %>
		<td><%=currPool2.getName()%> / <%=currIpnet2.getIpnetaddr()%></td>
		  <% } else { %>
		<td>No Secondary IP currently configured for this service</td>
		<% } %>
	   <td></td>
	</tr>
	<% if (newPool2 != null) { %>
		<tr class="tableRow" style="background: #FFFFFF">
		   <td><b>New Secondary IP Pool: </b></td>
		   <td><%=newPool2.getName()%></td>
		   <td></td>
		</tr>
		<tr class="tableRow" style="background: #FFFFFF">
		   <td ><b title="<%=selectSecondaryIpTooltip%>" >Select new Secondary IPNet: </b></td>
		   <td>
			<% if (ipnets2.length > minimum_length) { %>
				<select name="cmbSelectSecondaryIP" style="width:130px" title="<%=selectSecondaryIpTooltip%>" >
													
						<% if ((currPool2 != null) && ((newPool2.getName()).equals(currPool2.getName()))) {%>
							<option value="nochange" selected>No change</option> 
							<option value="auto">Auto</option> 
							<option value="none">None</option>
						<% } else if (currPool2 == null) { %>
							<option value="auto">Auto</option>
							<option value="none" selected>None</option> 
						<% } else { %>
							<option value="auto" selected>Auto</option>
							<option value="none">None</option> 
						<% } %>
						
						<% String ipnetStr = null;
						
						for (int i=0; i < ipnets2.length; i++) 
						{
							ipnetStr = ipnets2[i].getIpnetaddr();

							%><option value="<%=ipnetStr%>" ><%=ipnetStr%></option> <%
					   }%>
				</select>
			<% } else { 
				secondaryIpnetUnavailable = true; %>
				Not enough free IPNets available in <%=newPool2.getName()%>
				<input type="hidden" name="cmbSelectSecondaryIP" value="nochange">
			<% } %>
		   </td>
		   <td></td>
		</tr>
	 <% } else { %>
		   <tr class="tableRow" style="background: #FFFFFF">
		   <td><b>New Secondary IP Pool: </b></td>
		   <td>- none -</td>
		   <td></td>
		   </tr>
		<% if(currPool2 != null) { %>
			<input type="hidden" name="cmbSelectSecondaryIP" value="none">
		<% } else { %>
			<input type="hidden" name="cmbSelectSecondaryIP" value="nochange">
		<% } %>
	 <% }%>
	 
	 <% if ("false".equals(managed_ce)) { %>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr class="tableRow" style="background: #FFFFFF">
		<td colspan="3"><b><%=updateCEManually%></b></td>
	 </tr>
	 <% } %>
   
    <!-- Common trailer -->
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr>
        <td align="center" colspan="3">
		   <% if (ipnetUnavailable && secondaryIpnetUnavailable) { %>
			<input type="Button" value="Submit" OnClick="submitForm()" disabled> &nbsp;&nbsp;
		   <% } else { %>
			<input type="Button" value="Submit" OnClick="submitForm()"> &nbsp;&nbsp;
		   <% } %>
		   <input type="Button" value="Cancel Modify" OnClick="submitFormCancel()"> &nbsp;&nbsp;
           <input type="reset"  value="Clear">
        </td>
    </tr>
</table>
<input type="hidden" name="pool_name"  value="<%=pool_name%>">
<input type="hidden" name="secondary_pool_name"  value="<%=secondary_pool_name%>">
<input type="hidden" name="current_ipnet"  value="<%=current_ipnet%>">
<input type="hidden" name="current_secondary_ipnet"  value="<%=current_secondary_ipnet%>">
<input type="hidden" name="selected_ip"  value="">
<input type="hidden" name="selected_secondary_ip"  value="">
</form>
</center>
</body>
</html>

<% } 
	catch (Exception e) 
	{
		System.out.println("Exception in Address Pool details selection: " + e.getMessage());
		e.printStackTrace();
	}
%>
