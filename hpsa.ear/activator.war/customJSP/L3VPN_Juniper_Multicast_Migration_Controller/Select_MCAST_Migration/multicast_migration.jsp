<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################
C:\SourceCode\SAVPN\UI\customJSP\L3VPN_Juniper_Multicast_Migration_Controller\Select_MCAST_Migration
------------------------------------------------------------------------->
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/L3VPN_Juniper_Multicast_Migration_Controller/Select_MCAST_Migration/multicast_migration.jsp,v $                                                                   --%>
<%-- $Revision: 1.36 $                                                                 --%>
<%-- $Date: 2010-12-03 02:53:05 $                                                                     --%>
<%-- $Author: divya $                                                                   --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--# Description                                                                 --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- Queue: 'multicast_migration' --%>

<%@ page contentType="text/html; charset=UTF-8"
         import="com.hp.ov.activator.mwfm.*, com.hp.ov.activator.cr.inventory.*, com.hp.ov.activator.vpn.inventory.*,  com.hp.ov.activator.mwfm.servlet.*, java.sql.*, javax.sql.DataSource, java.util.*, java.io.*, com.hp.ov.activator.cr.struts.nnm.cl.NNMiAbstractCrossLaunchAction, com.hp.ov.activator.nnm.common.*" %>

<%
       response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");

%>
<html>
<head>
  <title>hp OpenView service activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
   <script language="JavaScript">
    window.moveTo(50,50);
    window.resizeTo(800,640);


	function close()
	{
		var test = navigator.appName;
		if(test == "Microsoft Internet Explorer")
			window.close();
	}
  </script>
</head>


<body onUnLoad="opener.window.top.interactWindow=null">
<h3><img src="/activator/images/HPLogo.png" valign="top" align="right">Interact with job: L3VPN_Juniper_Multicast_Migration_Controller</h3>
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

<br />

			  <form name="rsform" action="/activator/sendCasePacket" onsubmit="return validateDataTypes('count','askfor')" method="POST">
			  
			   <input type="hidden" name="id" value="<%= jd.jobId %>">
			   <input type="hidden" name="workflow" value="<%= jd.name %>">
			   <input type="hidden" name="queue" value="multicast_migration">
			   
<%
		boolean hasController = false;
		String service="";
		String l3vpn_list_selected_string="[]";
			

		String interfaceName;

		com.hp.ov.activator.cr.inventory.NetworkElement[] networkElements = null;
		
		com.hp.ov.activator.vpn.inventory.L3VPN l3vpn= null;
		com.hp.ov.activator.vpn.inventory.AccessFlow accessFlow= null;
		ArrayList toBeDiabledElements =null;
		
		String services = "";
	   
		String ip = request.getRemoteAddr();   

		AttributeDescriptor ad1 = jd.attributes[1];
		String maxMigrationJobs = ad1.value;	
		
		String whereClause="v_l3vpn.multicast = 'enabled' AND (SELECT COUNT(*) FROM v_accessflow WHERE v_accessflow.siteid IN (SELECT vpnm.siteid FROM v_vpnmembership vpnm, v_l3vpn l3v, crm_service crms WHERE vpnm.vpnid = l3v.serviceid AND l3v.multicast = 'unsupported' AND l3v.parentid = v_l3vpn.serviceid AND crms.serviceid = vpnm.siteid AND crms.state = 'Ok' ) AND v_accessflow.serviceid IN (SELECT f.attachmentid FROM v_flowpoint f, cr_terminationpoint t, cr_networkelement n, crm_service crms WHERE f.terminationpointid = t.terminationpointid AND t.ne_id = n.networkelementid AND n.vendor = 'Juniper' AND crms.serviceid = f.attachmentid AND crms.state = 'PE_Ok' AND crms.type <> 'layer3-Protection') AND v_accessflow.serviceid NOT IN (SELECT f.attachmentid FROM v_vpnfpmembership m, v_multicastsite ms, v_flowpoint f WHERE ms.attachmentid = f.attachmentid AND f.terminationpointid = m.flowpointid ) AND v_accessflow.pe_status = 'OK') > 0 AND v_l3vpn.serviceid IN (SELECT DISTINCT m.vpnid FROM v_vpnfpmembership m, cr_terminationpoint t, cr_networkelement n, crm_service crms WHERE m.flowpointid = t.terminationpointid AND t.ne_id = n.networkelementid AND n.vendor = 'Juniper' AND m.vpnid = crms.serviceid AND crms.state = 'Ok' )";
		String whereClauseMember="V_Vpnmembership.siteid in (select distinct V_Site.serviceid from V_Site where V_Site.multicast='enabled')";
		L3VPN[] l3vpns = null;
		int numSites=0;
		
		Connection con = null;
		DataSource ds= (DataSource)session.getAttribute(Constants.DATASOURCE);
			try {
				if (ds != null)  {
					con = ds.getConnection();
					   if (con != null) {
						   l3vpns=L3VPN.findAll(con,whereClause);
						   if(l3vpns !=null){
							   if(l3vpns.length < 8 ){
								   %><div style="height: 200px; overflow-y: scroll;"><%
							   }
							   else{
								   %><div style="height: 400px; overflow-y: scroll;"><%
							   }
						   }
						   %>
						   

	<table width="100%" border=0 cellpadding=0>
		<tr>
			<th class="tableHeading">Select</th>
			<th class="tableHeading">Customer</th>
			<th class="tableHeading">Service</th>
			<th class="tableHeading">Sites to migrate</th>
		</tr>


	<%!
		final static String ALL_PRESENT  = "0";
		final static String NO_EQUIPMENT = "1";
		final static String NO_INTERFACE = "2";
		final static String NO_DB = "3";
		final static String NO_PEs = "4";
		final static String RATELIMIT_INTERFACE = "5";
		
	%>

	<%
						   if(l3vpns != null){							  
							   for (int i = 0; i < l3vpns.length; i++) {								   
								   l3vpn=l3vpns[i];
								   String whereClauseFlow="v_accessflow.siteid in (select vpnm.siteid from v_vpnmembership vpnm, v_l3vpn l3v, crm_service crms where vpnm.vpnid = l3v.serviceid and l3v.multicast = 'unsupported' and l3v.parentid = '"+l3vpn.getServiceid()+"' and crms.serviceid = vpnm.siteid and crms.state = 'Ok')"+  
															"and v_accessflow.serviceid in (select f.attachmentid from v_flowpoint f, cr_terminationpoint t, cr_networkelement n, crm_service crms where f.terminationpointid = t.terminationpointid and t.ne_id = n.networkelementid and n.vendor = 'Juniper' and crms.serviceid = f.attachmentid and crms.state = 'PE_Ok' and crms.type <> 'layer3-Protection')"+
															"and v_accessflow.serviceid not in (select f.attachmentid from v_vpnfpmembership m, v_multicastsite ms, v_flowpoint f where ms.attachmentid = f.attachmentid and f.terminationpointid = m.flowpointid ) and v_accessflow.pe_status = 'OK'";

								   numSites=AccessFlow.findAllCount(con,whereClauseFlow);
								   AccessFlow afs[] = AccessFlow.findAll(con,whereClauseFlow);
								   
								   for (AccessFlow af :  afs) {
									VPNMembership mem = VPNMembership.findByVpnidsiteid(con, l3vpn.getServiceid(), af.getSiteid());
									services += mem.getSitename() + " (" + af.getSiteid()+ "); ";
								   }
								   %>
								   <tr>
									   <td class="tableRow" style="text-align: center;"><INPUT TYPE="checkbox" NAME="service"   VALUE="<%= l3vpn.getServiceid()%>" id="<%= l3vpn.getServiceid()%>"   onClick="cont()"></INPUT>
									   </td>
									   <td class="tableRow"><%= l3vpn.getCustomer()%></td>
									   <td class="tableRow"><%= l3vpn.getServicename()%> (<%= l3vpn.getServiceid()%>)</td>
									   <%
										if (numSites == 1) { %>
									   <td class="tableRow" title="<%= services %>"><%= numSites %> service to migrate</td>
									   <% } else {%>
									   <td class="tableRow" title="<%= services %>"><%= numSites %> services to migrate</td>
									   <% }%>
									</tr>
							  <% }%>
								
								  
							  <%
						   }
					   }
				}
			}catch (Exception e) {
				System.out.println("Exception in Service selection: " + e.getMessage());
				  
								e.printStackTrace ();
			}finally{
				try{
				  con.close();
				}catch(Exception ex){
				   System.out.println("Exception during the closing connection in multicast_migration.jsp : " + ex.getMessage());
				}
			}
		
	   %>
	   
		
	 </table>
 </div>
	<table width="100%" border=0 cellpadding=0>
		<tr>
			<td align="center" colspan="4">
			   <input type="Button" value=" Submit" style="width:60px" OnClick="submitForm()"> &nbsp;&nbsp;
			   <input type="reset"  value=" Clear " style="width:60px">
			</td>
		</tr>
	</table>
<input type="hidden" name="l3vpn_list_selected_string"  value="">
 
 </form>

</center>
<p></p>
<script type="text/javascript" src="/activator/javascript/CRModel/utils.js"></script>
<script language="JavaScript">
	function submitForm(){		
		var form=document.rsform;
		var l3vpn_list_selected_string="";
		var checkboxes =document.getElementsByName("service");
		
		for (var i=0; i < checkboxes.length; i++) {			
			if(checkboxes[i].checked){	
				if(l3vpn_list_selected_string.localeCompare("")!=0)			
					l3vpn_list_selected_string+=","+checkboxes[i].value;
					else
						l3vpn_list_selected_string+=checkboxes[i].value;				
			}			
		}			
		form.l3vpn_list_selected_string.value=l3vpn_list_selected_string;
		form.submit();
				
		}
		

		function cont(){
			var contSelected=0;			
			var max=<%=maxMigrationJobs%>;		
			var l3vpn_list_selected_string="";
			var checkboxes =document.getElementsByName("service");
			
				
			for (var i=0; i < checkboxes.length; i++) {			
				if(checkboxes[i].checked){	
					if(l3vpn_list_selected_string.localeCompare("")!=0)			
						l3vpn_list_selected_string+=","+checkboxes[i].value;
						else
							l3vpn_list_selected_string+=checkboxes[i].value;
					contSelected++;
				}
			}
			if(contSelected < max){
				for (var i=0; i < checkboxes.length; i++) {			
					if(!checkboxes[i].checked){						
						document.getElementById(checkboxes[i].value).disabled = false;
					}
				}
			}
			
			if(contSelected == max || contSelected > max){
				for (var i=0; i < checkboxes.length; i++) {			
					if(!checkboxes[i].checked){						
						document.getElementById(checkboxes[i].value).disabled = true;
					}
				}
			}
			
		}
		
		
		
  </script>
</body>
</html>

