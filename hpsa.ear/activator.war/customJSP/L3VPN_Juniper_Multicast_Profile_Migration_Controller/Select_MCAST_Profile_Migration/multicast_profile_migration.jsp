<%-- Queue: 'multicast_migration' --%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,
		com.hp.ov.activator.mwfm.*,
		com.hp.ov.activator.mwfm.servlet.*,
		com.hp.ov.activator.cr.inventory.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
		java.sql.*,
		java.sql.Connection,
		javax.sql.DataSource,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors,
        com.hp.ov.activator.inventory.facilities.StringFacility " %>

<%
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");

%>
<html>
<head>
  <title>hp OpenView service activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
  <link rel="stylesheet" href="/activator/css/inventory-gui/jquery-ui.css">
  <script src="/activator/javascript/jquery-1.10.2.js"></script>
  <script src="/activator/javascript/jquery-ui.js"></script>
  <script type="text/javascript">//<![CDATA[
	$(window).load(function(){
	$(".go").change(function(){
		var selVal=[];
		$(".go").each(function(){
			selVal.push(this.value);
		});
	   
		$(this).closest("tr").siblings("tr").find("option").removeAttr("disabled").filter(function(){
		   var a=$(this).parent("select").val();
		   return (($.inArray(this.value, selVal) > -1) && (this.value!=a))
		}).attr("disabled","disabled");
	});

	$(".go").eq(0).trigger('change');
	
	$(".go2").change(function(){
		var selVal=[];
		$(".go2").each(function(){
			selVal.push(this.value);
		});
	   
		$(this).closest("tr").siblings("tr").find("option").removeAttr("disabled").filter(function(){
		   var a=$(this).parent("select").val();
		   return (($.inArray(this.value, selVal) > -1) && (this.value!=a))
		}).attr("disabled","disabled");
	});

	$(".go2").eq(0).trigger('change');
	});//]]> 

	</script>
   <script language="JavaScript">
    window.resizeTo(800,640);
  </script>
</head>


<body onLoad="disableSelected()" onUnLoad="opener.window.top.interactWindow=null">
<h3><img src="/activator/images/HPLogo.png" valign="top" align="right">Interact with job: L3VPN_Juniper_Multicast_Profile_Migration_Controller</h3>
<center>
<table width="100%" border=0 cellpadding=0>
<tr>
   <th class="tableHeading">Job ID</th>
   <th class="tableHeading">Workflow</th>
   <th class="tableHeading">Start Date & Time</th>
   <th class="tableHeading">Post Date & Time</th>
   <th class="tableHeading">Step Name</th>
   <th class="tableHeading">Description</th>
   <th class="tableHeading">Status</th>
</tr>


<%-- Get the job descriptor to enable access to general job information --%>
<% JobRequestDescriptor jd=(JobRequestDescriptor) session.getAttribute(Constants.MWFM_JOB_DESCRIPTOR); %>
<tr>
    <td class="tableRow"> <%= jd.jobId %> </td>
    <td class="tableRow"> <%= jd.name %> </td>
    <td class="tableRow"> <%= jd.startTime %> </td>
    <td class="tableRow"> <%= jd.postDate %> </td>
    <td class="tableRow"> <%= jd.stepName == null ? "&nbsp;" : jd.stepName %> </td>
    <td class="tableRow"> <%= jd.description == null ? "&nbsp;" : jd.description %> </td>
    <td class="tableRow"> <%= jd.status == null ? "&nbsp;" : jd.status %> </td>
</tr>
</table>

<br/>

	  <form name="rsform" action="/activator/sendCasePacket" onsubmit="return validateDataTypes('count','askfor')" method="POST">
	  
	   <input type="hidden" name="id" value="<%= jd.jobId %>">
	   <input type="hidden" name="workflow" value="<%= jd.name %>">
	   <input type="hidden" name="queue" value="multicast_profile_migration">
			   
		<table width="100%" border=1 cellpadding=1>
			<tr>
				<td class="tableRow" colspan="7">
					<p><img src="/activator/images/warning.gif"> Only Profiles with both assigned Source IP and Group IP will be migrated</p>
				</td>
			</tr>
		</table>
		
		<br/>
		
		<table width="100%" border=0 cellpadding=0>
			<tr>
				<th class="tableHeading" width="8%">VPN id</th>
				<th class="tableHeading" width="8%">COS</th>
				<th class="tableHeading" width="8%">Bandwidth</th>
				<th class="tableHeading" width="17%">MCAST Source Pool</th>
				<th class="tableHeading" width="18%">MCAST Source IP</th>
				<th class="tableHeading" width="19%">MCAST Group Pool</th>
				<th class="tableHeading" width="20%">MCAST Group IP</th>
			</tr>
		</table>
			
		<div style="height: 200px; overflow-y: scroll;">
		
			<table width="100%" border=0 cellpadding=0>

				<% String mcast_profile_list_selected_string="";
								
				Connection con = null;
				
				PreparedStatement pstmt = null;
				ResultSet rset = null;
				
				ArrayList<String> attachmentIds = new ArrayList<String>(); 
					
				try 
				{
					DataSource ds= (DataSource)session.getAttribute(Constants.DATASOURCE);
									
					if (ds != null)  
					{
						con = ds.getConnection();
						
						if (con != null) 
						{
										
							String query = "SELECT DISTINCT vfmem.vpnid,"
											  +" l3fp.mcos,"
											  +" l3fp.mcar,"
											  +" fp.attachmentid,"
											  +" srv.servicename"
											+" FROM v_flowpoint fp,"
											  +" v_l3flowpoint l3fp,"
											  +" cr_terminationpoint tp,"
											  +" cr_networkelement ne,"
											  +" v_accessflow af,"
											  +" v_site s,"
											  +" v_vpnfpmembership vfmem,"
											  +" v_vpnmembership vmem,"
											  +" v_vpn v,"
											  +" v_service srv"
											+" WHERE fp.terminationpointid = l3fp.terminationpointid"
											+" AND fp.terminationpointid   = tp.terminationpointid"
											+" AND tp.ne_id                = ne.networkelementid"
											+" AND ne.vendor               = 'Juniper'"
											+" AND l3fp.mcar              IS NOT NULL"
											+" AND l3fp.mcos              IS NOT NULL"
											+" AND af.serviceid            = fp.attachmentid"
											+" AND s.serviceid             = af.siteid"
											+" AND s.multicast             = 'enabled'"
											+" AND vfmem.flowpointid       = fp.terminationpointid"
											+" AND vfmem.vpnid             = vmem.vpnid"
											+" AND vmem.siteid             = s.serviceid"
											+" AND vfmem.vpnid             = v.serviceid"
											+" AND srv.serviceid           = v.serviceid"
											+" AND vpntopologytype        <> 'multicast'"
											+" AND af.serviceid NOT       IN"
											  +" (SELECT attachmentid FROM v_multicastsite"
											  +" )"
											+" AND (select count (*)"
											  +" FROM v_multicastprofile"
											  +" WHERE vpnid   = v.serviceid"
											  +" AND bandwidth = l3fp.mcar"
											  +" AND cos       = l3fp.mcos"
											  +" ) < 1"
											+" ORDER BY vfmem.vpnid ASC";
								
							pstmt = con.prepareStatement(query);
						
							rset = pstmt.executeQuery();

							while(rset.next())
							{
								String attachmentId = rset.getString(4); 
								
								attachmentIds.add(attachmentId);
								
								String selected_source_ip_pool = "";
								if (request.getParameter("cmbSelectSourceIPPool"+attachmentId) != null) {
									selected_source_ip_pool = request.getParameter("cmbSelectSourceIPPool"+attachmentId);
								}

								String selected_source_ip = null;
								if ((request.getParameter("cmbSelectSourceIP"+attachmentId) != null) && !("none".equals(request.getParameter("cmbSelectSourceIP"+attachmentId)))) {
									selected_source_ip = request.getParameter("cmbSelectSourceIP"+attachmentId);
								}

								String selected_group_ip_pool = "";
								if (request.getParameter("cmbSelectGroupIPPool"+attachmentId) != null) {
									selected_group_ip_pool = request.getParameter("cmbSelectGroupIPPool"+attachmentId);
								}

								String selected_group_ip = null;
								if (request.getParameter("cmbSelectGroupIP"+attachmentId) != null) {
									selected_group_ip = request.getParameter("cmbSelectGroupIP"+attachmentId);
								}	

								int minimum_length = 0;
								
								EXPMapping[] expMappings = null;

								IPAddrPool[] multicastSourcesPools = null;
								IPHost[] multicastSources = null;

								IPAddrPool[] multicastGroupsPools = null;
								IPHost[] multicastGroups = null;
								
								boolean sourcePoolUnavailable = false;
								boolean groupPoolUnavailable = false;
								
								expMappings = com.hp.ov.activator.vpn.inventory.EXPMapping.findAll(con);
		 
								multicastSourcesPools 	= IPAddrPool.findAll(con, "type='Multicast Source' and addressfamily='IPv4'");
								multicastGroupsPools 	= IPAddrPool.findAll(con, "type='Multicast Group' and addressfamily='IPv4'");
								
								if (!("".equals(selected_source_ip_pool)))
								{
									multicastSources = IPHost.findByPoolname(con, selected_source_ip_pool, "v_iphost.count__<>'0'");
								}
								else if (multicastSourcesPools != null) 
								{
									selected_source_ip_pool = multicastSourcesPools[0].getName();
									multicastSources = IPHost.findByPoolname(con, selected_source_ip_pool, "v_iphost.count__<>'0'");
								}
								else 
								{
									sourcePoolUnavailable = true;
								}
								
								if (!("".equals(selected_group_ip_pool)))
								{
									multicastGroups = IPHost.findByPoolname(con, selected_group_ip_pool, "v_iphost.count__<>'0'");
								}
								else if (multicastGroupsPools != null) 
								{
									selected_group_ip_pool = multicastGroupsPools[0].getName();
									multicastGroups = IPHost.findByPoolname(con, selected_group_ip_pool, "v_iphost.count__<>'0'");
								}
								else 
								{
									groupPoolUnavailable = true;
								}
								
								%>
								<tr>
								
									<td class="tableRow" title="<%=rset.getString(5)%>" width="8%"><%=rset.getString(1)%></td>
									
									<% String vpnValue = "vpnValue"+attachmentId; %>
									<input type="hidden" name="<%=vpnValue%>" value="<%=rset.getString(1)%>">
									
									<td class="tableRow" width="8%">
										<% expMappings = expMappings != null ? expMappings : new EXPMapping[0];

										for (int i = 0; i < expMappings.length; i++) 
										{
											EXPMapping expMapping = expMappings[i];
											
											if ((expMapping.getExpvalue()).equals(rset.getString(2))) { %>
												<%=expMapping.getClassname()%>
											<%} %>
										<% } %>
									</td>
									
									<% String cosValue = "cosValue"+attachmentId; %>
									<input type="hidden" name="<%=cosValue%>" value="<%=rset.getString(2)%>">
									
									<td class="tableRow" width="8%"><%=rset.getString(3)%></td>
									
									<% String bwValue = "bwValue"+attachmentId; %>
									<input type="hidden" name="<%=bwValue%>" value="<%=rset.getString(3)%>">
									
									<td class="tableRow" width="19%">
										<% String cmbSelectSourceIPPoolName = "cmbSelectSourceIPPool"+attachmentId; %>
										<select name="<%=cmbSelectSourceIPPoolName%>" style="width:130px" onchange="reload(); disableSelected();">
											<% String sourceIPPoolStr = null;
													
											for (int i=0; i < multicastSourcesPools.length; i++) 
											{
												sourceIPPoolStr = multicastSourcesPools[i].getName();
												
												if (sourceIPPoolStr.equals(selected_source_ip_pool))
												{%>
													<option value="<%=sourceIPPoolStr%>" selected><%=sourceIPPoolStr%></option> 
												<% } else { %>
													<option value="<%=sourceIPPoolStr%>" ><%=sourceIPPoolStr%></option> 
												<% }
										   }%>
										</select>
									</td>
									
									<td class="tableRow" width="19%">
										<% String cmbSelectSourceIPName = "cmbSelectSourceIP"+attachmentId; %>
										
										<% if (multicastSources != null) {
										 if (multicastSources.length > minimum_length) { %>
											<select name="<%=cmbSelectSourceIPName%>" style="width:130px" onChange="disableSelected();">
													
													<option value="none">--</option>
													
													<% String iphostStr = null;
													
													for (int i=0; i < multicastSources.length; i++) 
													{
														iphostStr = multicastSources[i].getIp();

														if (iphostStr.equals(selected_source_ip))
														{%>
															<option value="<%=iphostStr%>" selected><%=iphostStr%></option> 
														<% } else { %>
															<option value="<%=iphostStr%>" ><%=iphostStr%></option> 
														<% }
												   }%>
											</select>
										<% } else { %>
											<img src="/activator/images/warning.gif">No free IP Addresses available
											<input type="hidden" name="<%=cmbSelectSourceIPName%>" value="none">
										<% }
										} else { %>
										  <img src="/activator/images/warning.gif">MCAST Source Pool unavailable
										  <input type="hidden" name="<%=cmbSelectSourceIPName%>" value="none">
										<% } %>
									</td>
									
									<td class="tableRow" width="19%">
										<% String cmbSelectGroupIPPoolName = "cmbSelectGroupIPPool"+attachmentId; %>
										
										<select name="<%=cmbSelectGroupIPPoolName%>" style="width:130px" onchange="reload(); disableSelected();">
											<% String groupIPPoolStr = null;
													
											for (int i=0; i < multicastGroupsPools.length; i++) 
											{
												groupIPPoolStr = multicastGroupsPools[i].getName();

												if (groupIPPoolStr.equals(selected_group_ip_pool))
												{%>
													<option value="<%=groupIPPoolStr%>" selected><%=groupIPPoolStr%></option> 
												<% } else { %>
													<option value="<%=groupIPPoolStr%>" ><%=groupIPPoolStr%></option> 
												<% }
										   }%>
										</select>
									</td>
									
									<td class="tableRow" width="19%">
										<% String cmbSelectGroupIPName = "cmbSelectGroupIP"+attachmentId; %>
										
										<% if (multicastGroups != null) {
											if (multicastGroups.length > minimum_length) { %>
											<select name="<%=cmbSelectGroupIPName%>" style="width:130px" onChange="disableSelected();">
													
												<option value="none">--</option>
													
													<% String iphostStr = null;
													
													for (int i=0; i < multicastGroups.length; i++) 
													{
														iphostStr = multicastGroups[i].getIp();
														
														if (iphostStr.equals(selected_group_ip))
														{%>
															<option value="<%=iphostStr%>" selected><%=iphostStr%></option> 
														<% } else { %>
															<option value="<%=iphostStr%>" ><%=iphostStr%></option> 
														<% }
													}%>
											</select>
										<% } else { %>
											<img src="/activator/images/warning.gif">No free IP Addresses available
											<input type="hidden" name="<%=cmbSelectGroupIPName%>" value="none">
										<% }
										} else { %>
										  <img src="/activator/images/warning.gif">MCAST Source Pool unavailable
										  <input type="hidden" name="<%=cmbSelectGroupIPName%>" value="none">
										<% } %>
									</td>
									
								</tr>
							<%}
						}
					}		
				}
				catch (Exception e) 
				{
					System.out.println("Exception in Service selection: " + e.getMessage());
					e.printStackTrace ();
				}
				finally
				{
					try{ rset.close(); }catch(Exception ignoreme){}
					try{ pstmt.close();}catch(Exception ignoreme){}
					
					try
					{
					  con.close();
					}
					catch(Exception ex)
					{
					   System.out.println("Exception during the closing connection in multicast_profile_migration.jsp : " + ex.getMessage());
					}
				} %>
		
			</table>
		</div>
	<table width="100%" border=0 cellpadding=0>
		<tr>
			<td align="center" colspan="4">
			   <input type="Button" value="Submit" style="width:60px" OnClick="submitForm()"> &nbsp;&nbsp;
			</td>
		</tr>
	</table>

	<input type="hidden" name="mcast_profile_list_selected_string"  value="">
 
 </form>

</center>
<p></p>
<script type="text/javascript" src="/activator/javascript/CRModel/utils.js"></script>
<script language="JavaScript">
	
	function disableSelected()
	{
		var form = document.rsform;
		var selects = form.getElementsByTagName("select");
		var options = form.getElementsByTagName("option");
		
		// First clear all the options
		for (var i = 0; i < options.length; i++) 
		{
			options[i].disabled = false; 
		}
			
		for (var i = 0; i < selects.length; i++) 
		{
			var selectName = selects[i].name; 
			var poolSubStr = "Pool";
			
			if (selectName.indexOf(poolSubStr) < 0)
			{
				for (var j = 0; j < options.length; j++) 
				{
					if ( options[j].value != "none" && options[j].value == selects[i].value)
					{
						options[j].disabled = true; 
					}
				}
				
				var currentSelect = document.getElementsByName(selectName)[0];
				
				for (var j = 0; j < currentSelect.length; j++)
				{
					if ( options[j].value != "none" && currentSelect.options[j].value == selects[i].value )
					{
						currentSelect.options[j].disabled = false; 
					}
				}
			}
		}
	}
	
	function reload()
	{
		var form = document.rsform;
		
		form.action = '/activator/customJSP/L3VPN_Juniper_Multicast_Profile_Migration_Controller/Select_MCAST_Profile_Migration/multicast_profile_migration.jsp'; 
		form.submit();
	}
	
	function submitForm()
	{	
		var form=document.rsform;	
		var profileList = ""; 
		
		<% for (int i=0; i < attachmentIds.size(); i++) 
		{%>			
			profileList = profileList + "#" + form.vpnValue<%=attachmentIds.get(i)%>.value + "%%" + form.cosValue<%=attachmentIds.get(i)%>.value + "%%" + form.bwValue<%=attachmentIds.get(i)%>.value + "%%" + form.cmbSelectSourceIP<%=attachmentIds.get(i)%>.value+ "%%" + form.cmbSelectGroupIP<%=attachmentIds.get(i)%>.value;
		<%}%>				
		
		form.mcast_profile_list_selected_string.value=profileList;
		form.submit();
	}

  </script>
</body>
</html>

