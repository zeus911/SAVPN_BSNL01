<!-- ============================================================== -->
<!-- HP Service Activator V70-3A                                    -->
<!-- Customized JSP.                                                -->
<!--                                                                -->
<!-- Copyright 2000-2015 Hewlett-Packard Development Company, L.P.  -->
<!-- All Rights Reserved                                            -->
<!--                                                                -->
<!-- ============================================================== -->
<!-- Queue: 'select_multicast_options' -->
<%@ page contentType="text/html; charset=UTF-8"
         import="com.hp.ov.activator.mwfm.*, com.hp.ov.activator.mwfm.servlet.*, java.util.HashMap, com.hp.ov.activator.inventory.facilities.StringFacility, java.sql.PreparedStatement, java.sql.ResultSet, com.hp.ov.activator.cr.inventory.*, com.hp.ov.activator.vpn.inventory.*, java.sql.*, javax.sql.DataSource, org.apache.struts.util.LabelValueBean, java.util.*, java.io.*" %>

<%
     JobRequestDescriptor jobRequestDescriptor = (JobRequestDescriptor) session.getAttribute(Constants.MWFM_JOB_DESCRIPTOR);
	 
	 String vpn_id = null;
	 if ( request.getParameter("VPNId") != null ) {
		vpn_id = request.getParameter("VPNId");
	 } 	
	 
	 String attachment_id = null;
	 if ( request.getParameter("AttachmentId") != null ) {
		attachment_id = request.getParameter("AttachmentId");
	 } 
	 
	 String ne_name = null;
	 if ( request.getParameter("neName") != null ) {
		ne_name = request.getParameter("neName");
	 }
	 
	 String ne_id = null;
	 if ( request.getParameter("neId") != null ) {
		ne_id = request.getParameter("neId");
	 }
	 
	 String is_migration = null;
	 if ( request.getParameter("isMigration") != null ) {
		is_migration = request.getParameter("isMigration");
	 }
	 
	 String is_advanced = null;
	 if ( request.getParameter("isAdvanced") != null ) {
		is_advanced = request.getParameter("isAdvanced");
	 }
	 
	 
	 String multicast_vpn_id = null;
	 if ( request.getParameter("MulticastVPNId") != null ) {
		multicast_vpn_id = request.getParameter("MulticastVPNId");
	 } 	 
	 
	 String multicast_qos_class = null;
	 if ( request.getParameter("cmbSelectQoSClass") != null ) {
		multicast_qos_class = request.getParameter("cmbSelectQoSClass");
	 } 	 
	 
	 String multicast_rate_limit = null;
	 if ( request.getParameter("cmbSelectRateLimit") != null ) {
		multicast_rate_limit = request.getParameter("cmbSelectRateLimit");
	 } 	 
	 
	 String multicast_rp = null;
	 
	 String multicast_mode;
	 if ( request.getParameter("cmbSelectMulticastMode") != null ) {
		multicast_mode = request.getParameter("cmbSelectMulticastMode");
	 }
	 else
	 {
		multicast_mode = "sparse";
	 }
	 
	 String current_multicast_mode = "";
	 	 
	 boolean getMCASTMode = false;
	 boolean noVtInterfacesAvailable = false;
 
	 String vpnInfo = null;
	 if ( request.getParameter("VPN_Info") != null ) {
		vpnInfo = request.getParameter("VPN_Info");
	 }
	 
	 String vendor = null;
	 if ( request.getParameter("Vendor") != null ) {
		vendor = request.getParameter("Vendor");
	 }
	 		
	 String selected_vt_interface = "";
	 if (request.getParameter("vtInterfaceEntry") != null) {
		selected_vt_interface = request.getParameter("vtInterfaceEntry");
	 }
	 
	 String selected_rp_mode = "Disabled";
	 if ((request.getParameter("cmbRPMode") != null) && !("Disabled".equals(request.getParameter("cmbRPMode")))) {
		selected_rp_mode = request.getParameter("cmbRPMode");
	 }
 
	 String selected_rp_ip_local_manual = "";
	 if (request.getParameter("selectRPIPLocalManual") != null) {
		selected_rp_ip_local_manual = request.getParameter("selectRPIPLocalManual");
	 }
	 
	 String selected_rp_ip_local_pool = "";
	 if (request.getParameter("selectRPIPLocalPool") != null) {
		selected_rp_ip_local_pool = request.getParameter("selectRPIPLocalPool");
	 }
	 
	 String selected_rp_ip_remote = "";
	 if (request.getParameter("selectRPIPRemote") != null) {
		selected_rp_ip_remote = request.getParameter("selectRPIPRemote");
	 }
	 
	 String is_rp = "";
	 if (request.getParameter("cmbSelectRP") != null) {
		is_rp = request.getParameter("cmbSelectRP");
	 }
	 
	 String rp_mode = "Static";
	 if (request.getParameter("cmbSelectRPMode") != null) {
		rp_mode = request.getParameter("cmbSelectRPMode");
	 }
	 	 
	 String selected_rp = "";
	 if (request.getParameter("selectRPAddress") != null) {
		selected_rp = request.getParameter("selectRPAddress");
	 }
	 
	 HashMap<Integer, String> multipleRPs = new HashMap<Integer,String>();
	 
	 if (request.getParameter("selectRPMultiple1") != null) {
		multipleRPs.put(1, request.getParameter("selectRPMultiple1"));
	 }
	 else
	 {
		multipleRPs.put(1, "");
	 }
	 
	 if (request.getParameter("selectRPMultiple2") != null) {
		multipleRPs.put(2, request.getParameter("selectRPMultiple2"));
	 }
	 else
	 {
		multipleRPs.put(2, "");
	 }
	 
	 if (request.getParameter("selectRPMultiple3") != null) {
		multipleRPs.put(3, request.getParameter("selectRPMultiple3"));
	 }
	 else
	 {
		multipleRPs.put(3, "");
	 }
	 
	 if (request.getParameter("selectRPMultiple4") != null) {
		multipleRPs.put(4, request.getParameter("selectRPMultiple4"));
	 }
	 else
	 {
		multipleRPs.put(4, "");
	 }
	 
	 if (request.getParameter("selectRPMultiple5") != null) {
		multipleRPs.put(5, request.getParameter("selectRPMultiple5"));
	 }
	 else
	 {
		multipleRPs.put(5, "");
	 }
	 
	 HashMap<Integer, String> multipleGRs = new HashMap<Integer,String>();
	 
	 if (request.getParameter("selectGRMultiple1") != null) {
		multipleGRs.put(1, request.getParameter("selectGRMultiple1"));
	 }
	 else
	 {
		multipleGRs.put(1, "");
	 }
	 
	 if (request.getParameter("selectGRMultiple2") != null) {
		multipleGRs.put(2, request.getParameter("selectGRMultiple2"));
	 }
	 else
	 {
		multipleGRs.put(2, "");
	 }
	 
	 if (request.getParameter("selectGRMultiple3") != null) {
		multipleGRs.put(3, request.getParameter("selectGRMultiple3"));
	 }
	 else
	 {
		multipleGRs.put(3, "");
	 }
	 
	 if (request.getParameter("selectGRMultiple4") != null) {
		multipleGRs.put(4, request.getParameter("selectGRMultiple4"));
	 }
	 else
	 {
		multipleGRs.put(4, "");
	 }
	 
	 if (request.getParameter("selectGRMultiple5") != null) {
		multipleGRs.put(5, request.getParameter("selectGRMultiple5"));
	 }
	 else
	 {
		multipleGRs.put(5, "");
	 }
	 
	 String selected_anycast_rp_mode = "Anycast-non-RP";
	 if (request.getParameter("cmbAnycastRPMode") != null) {
		selected_anycast_rp_mode = request.getParameter("cmbAnycastRPMode");
	 }	 
	 
	 String selected_auto_rp_mode = "Auto-RP-Discovery";
	 if (request.getParameter("cmbAutoRPMode") != null) {
		selected_auto_rp_mode = request.getParameter("cmbAutoRPMode");
	 }

	 String selected_local_rp_pool = "manual";
	 
	 if ("Auto-RP-Mapping".equals(selected_auto_rp_mode))
	 {
		selected_local_rp_pool = "norp";
	 }
	 	 
	 if (request.getParameter("cmbLocalRPPool") != null) {
		selected_local_rp_pool = request.getParameter("cmbLocalRPPool");
	 }
	 
	 if ("Auto-RP-Announce".equals(selected_auto_rp_mode) && "norp".equals(selected_local_rp_pool))
	 {
		selected_local_rp_pool = "manual";
	 }
	 
	 if ("Local".equals(selected_rp_mode) && "norp".equals(selected_local_rp_pool))
	 {
		selected_local_rp_pool = "manual";
	 }
	 
	 boolean bcheckRP= false;
	 String scheckRP=request.getParameter("checkRP");
	 if(request.getParameter("checkRP") != null){
		if ( "false".equals(request.getParameter("checkRP"))) {		  
		  bcheckRP = false;
		}
		else{
		bcheckRP = true;
		}
	 }
	 
	 String selected_multiple_number = "2";
	 int multipleNumber = 2;
	 if (request.getParameter("cmbMultipleNum") != null) {
		selected_multiple_number = request.getParameter("cmbMultipleNum");
		
		try 
		{
			multipleNumber = Integer.parseInt(selected_multiple_number); 
		}
		catch (Exception e)
		{
			selected_multiple_number = "2"; 
			multipleNumber = 2; 
		}
	 }
	 
	 String selected_rp_msdp_check = "";
	 if (request.getParameter("checkRPMSDP") != null) {
		selected_rp_msdp_check = request.getParameter("checkRPMSDP");
	 }
	 
	 String selected_rp_msdp_local_pool = "manual";
	 if (request.getParameter("cmbRPMSDPLocalPool") != null) {
		selected_rp_msdp_local_pool = request.getParameter("cmbRPMSDPLocalPool");
	 }
	 
	 String selected_rp_msdp_local_manual = "";
	 if (request.getParameter("selectRPMSDPLocalManual") != null) {
		selected_rp_msdp_local_manual = request.getParameter("selectRPMSDPLocalManual");
	 }
	 
	 String selected_rp_msdp_local = "";
	 if (request.getParameter("selectRPMSDPLocal") != null) {
		selected_rp_msdp_local = request.getParameter("selectRPMSDPLocal");
	 }
	 
	 String selected_rp_msdp_peer = "";
	 if (request.getParameter("selectRPMSDPPeer") != null) {
		selected_rp_msdp_peer = request.getParameter("selectRPMSDPPeer");
	 }
	 String static_address = "";
	 if (request.getParameter("static_address") != null) {
		selected_rp_msdp_peer = request.getParameter("static_address");
	 }
	 
	 String selected_multiple_check = "";
	 if (request.getParameter("checkMultiple") != null) {
		selected_multiple_check = request.getParameter("checkMultiple");
	 }
	 
	 Map requestParams = request.getParameterMap();
	 Set requestParamsSet = requestParams.entrySet();
	 Iterator it = requestParamsSet.iterator();
	 
	 Vector mcast_profile_list = new Vector<String>();
	 
	 while (it.hasNext())
	 {
		 Map.Entry<String,String[]> entry = (Map.Entry<String,String[]>)it.next();
		 
		 String key = entry.getKey();
		
		 if (key.equals("mcastprofileid"))
		 {
			String[] values = entry.getValue();

			for (int i = 0; i < values.length; i++)
			{
				mcast_profile_list.addElement(values[i].toString());
			}
		 }
	 }
	 
	 String previousMCAR = null;
	 if ( request.getParameter("previousMCAR") != null ) {
		previousMCAR = request.getParameter("previousMCAR");
	 } 	
	 
	 String previousMCOSstr = null;
	 String previousMCOS = null;
	 if ( request.getParameter("previousMCOS") != null ) {
		previousMCOS = request.getParameter("previousMCOS");
	 } 
	 
	 EXPMapping[] expMappings = null;
	 RateLimit[] rlList = null;
	 
	 IPAddrPool[] multicastLocalRPPools = null;
	 IPHost[] multicastLocalRPs = null;
	 
	 IPAddrPool[] multicastLocalMSDPPools = null;
	 IPHost[] multicastLocalMSDPs = null;
	 
	 MulticastProfile[] multicastProfiles = null;
	 
	 int minimum_length = 0;
	 MulticastSite existingSite = null;
	 boolean siteExists = false;
	 
	 String osversion = "";
	 
	 String vpnName = "";
	 String siteName = ""; 
	 
	 DataSource dataSource = (DataSource)session.getAttribute(Constants.DATASOURCE);
     Connection con = dataSource.getConnection();
	 
	 try
	 {	
		 AttributeDescriptor multicastVpnIdAttr = null;
		 AttributeDescriptor multicastModeAttr  = null;
		 AttributeDescriptor vpnInfoAttr	   	= null;
		 AttributeDescriptor vendorAttr	   		= null;
		 AttributeDescriptor vpnIdAttr	   		= null;
		 AttributeDescriptor attachmentIdAttr	= null;
		 AttributeDescriptor neNameAttr			= null;
		 AttributeDescriptor neIdAttr			= null;
		 AttributeDescriptor isMigrationAttr	= null;
		 
		 if (multicast_vpn_id == null) 
		 {	
			multicastVpnIdAttr = jobRequestDescriptor.attributes[0];
			multicast_vpn_id = multicastVpnIdAttr.value;
		 }
		 
		 if (multicast_mode == null) 
		 {	
			multicastModeAttr = jobRequestDescriptor.attributes[4];
			multicast_mode = multicastModeAttr.value;
		 }
		 
		 if (vpnInfo == null) 
		 {	
			vpnInfoAttr	= jobRequestDescriptor.attributes[5];
			vpnInfo = vpnInfoAttr.value;
		 }		
		 
		 if (vendor == null) 
		 {	
			vendorAttr	= jobRequestDescriptor.attributes[6];
			vendor = vendorAttr.value;
		 }	
		 
		 if (vpn_id == null) 
		 {	
			vpnIdAttr	= jobRequestDescriptor.attributes[11];
			vpn_id = vpnIdAttr.value;
		 }	
		 
		 if (attachment_id == null) 
		 {	
			attachmentIdAttr = jobRequestDescriptor.attributes[12];
			attachment_id = attachmentIdAttr.value;
		 }	
		 
		 if (ne_name == null) 
		 {	
			neNameAttr = jobRequestDescriptor.attributes[13];
			ne_name = neNameAttr.value;
		 }
		 
		 if (ne_id == null) 
		 {	
			neIdAttr = jobRequestDescriptor.attributes[17];
			ne_id = neIdAttr.value;
		 }	
		 
		 if (is_migration == null) 
		 {	
			isMigrationAttr = jobRequestDescriptor.attributes[19];
			is_migration = isMigrationAttr.value;
		 }
		 
		 
		 if (previousMCOS == null)
		 {
			 previousMCOS = ((AttributeDescriptor)jobRequestDescriptor.attributes[21]).value;
		 }
		 
		 if (previousMCAR == null)
		 {
			 previousMCAR = ((AttributeDescriptor)jobRequestDescriptor.attributes[20]).value;
		 }
		  
		 if ("".equals(multicast_vpn_id))
		 {
			getMCASTMode = true; 
		 }
		 
		 expMappings = com.hp.ov.activator.vpn.inventory.EXPMapping.findAll(con);
		 rlList = com.hp.ov.activator.vpn.inventory.RateLimit.findAll(con);
		 
		 for (int i = 0; i < expMappings.length; i++){
			EXPMapping expMapping = expMappings[i];
			if ((expMapping.getExpvalue()).equals(previousMCOS)) {
				previousMCOSstr = expMapping.getClassname();
			}
		 }		

		expMappings = expMappings != null ? expMappings : new EXPMapping[0];		 
		 
		 if ("Cisco".equals(vendor))
		 {
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			
			try 
			{
				String query = "select osversion from cr_networkelement where networkelementid = ?";
								
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, ne_id);
				
				rset = pstmt.executeQuery();

				while(rset.next())
				{
					osversion = rset.getString(1);
				}
			}
			catch (Exception e)
			{
				System.out.println("Exception in Multicast options selection: " + e.getMessage());
				e.printStackTrace();
			}
			finally
			{
				try{ rset.close(); }catch(Exception ignoreme){}
				try{ pstmt.close();}catch(Exception ignoreme){}
			}
		 }
		 
		 if ("Juniper".equals(vendor))
		 {
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			
			try 
			{
				String query = "select ms.attachmentid from v_multicastsite ms, v_flowpoint fp, v_vpnfpmembership fpmem, cr_terminationpoint tp where ms.attachmentid = fp.attachmentid "+
							    "and fp.terminationpointid = tp.terminationpointid and fp.terminationpointid = fpmem.flowpointid and fpmem.vpnid = ? and tp.ne_id = ?";
								
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, vpn_id);
				pstmt.setString(2, ne_id);
				
				rset = pstmt.executeQuery();

				while(rset.next())
				{
					existingSite = MulticastSite.findByAttachmentid(con, rset.getString(1));
					siteExists = true;
				}
			}
			catch (Exception e)
			{
				System.out.println("Exception in Multicast options selection: " + e.getMessage());
				e.printStackTrace();
			}
			finally
			{
				try{ rset.close(); }catch(Exception ignoreme){}
				try{ pstmt.close();}catch(Exception ignoreme){}
			}			
			
			multicastLocalRPPools	= IPAddrPool.findAll(con, "type='Multicast RP' and addressfamily='IPv4'");
			multicastLocalMSDPPools = IPAddrPool.findAll(con, "type='Multicast MSDP' and addressfamily='IPv4'");
			
			if (!("".equals(selected_local_rp_pool)) && !("manual".equals(selected_local_rp_pool)))
			{
				multicastLocalRPs = IPHost.findByPoolname(con, selected_local_rp_pool, "v_iphost.count__<>'0'");
			}
			
			if (!("".equals(selected_rp_msdp_local_pool)) && !("manual".equals(selected_rp_msdp_local_pool)))
			{
				multicastLocalMSDPs = IPHost.findByPoolname(con, selected_rp_msdp_local_pool, "v_iphost.count__<>'0'");
			}
			
			multicastProfiles = MulticastProfile.findByVpnid(con, vpn_id);
		 }
		 	 
		 Service serviceObj = Service.findByServiceid(con, vpn_id);
		 AccessFlow afObj = AccessFlow.findByServiceid(con, jobRequestDescriptor.serviceId);
		 Service siteObj = Service.findByServiceid(con, afObj.getSiteid());
		 
		 
		 vpnName = serviceObj.getServicename()+" ("+vpn_id+")"; 
		 siteName = siteObj.getServicename()+" ("+jobRequestDescriptor.serviceId+")"; 
		 
		 
		 MulticastParameters multicastParam = MulticastParameters.findByIdname(con, "ISPID");
		 is_advanced = String.valueOf(multicastParam.getAdvancedjunipermulticast());
		 
		 PreparedStatement ps = null;
		 ResultSet rs = null;
		 
		 try 
		 {
		    String query = "SELECT rc.rtimport FROM v_rc rc, v_vpnfpmembership vfm, v_vpn v WHERE rc.l3vpnid = vfm.vpnid AND vfm.vpnid = v.serviceid AND v.vpntopologytype = ? AND vfm.flowpointid IN (SELECT flowpointid FROM v_vpnfpmembership where vpnid IN (SELECT vfm2.vpnid FROM v_vpnfpmembership vfm2, v_flowpoint fp2 WHERE vfm2.flowpointid = fp2.terminationpointid and fp2.attachmentid = ?))";
			
			ps = con.prepareStatement(query);
			ps.setString(1, "multicast");
			ps.setString(2, attachment_id);
			
			rs = ps.executeQuery();

			while(rs.next())
			{
				current_multicast_mode = rs.getString(1);
			}
		 }
		 catch (Exception e)
		 {
			System.out.println("Exception in Multicast options selection: " + e.getMessage());
			e.printStackTrace();
		 }
		 finally
		 {
			try{ rs.close(); }catch(Exception ignoreme){}
			try{ ps.close();}catch(Exception ignoreme){}
		 }
			
		 con.close();
	 }
	 catch (Exception e) 
	 {
		System.out.println("Exception in Multicast options selection: " + e.getMessage());
		e.printStackTrace();
	 }
	 finally
	 {
		if (con != null) 
		{
			con.close();
		}
	 }
	 
	 // Cisco
	 String selectMulticastModeTooltip = "Select the multicast mode for this multicast VPN (sparse/sparse-dense)";
	 String selectMulticastCoSTooltip = "Select the COS of the Multicast Profile";
	 String selectMulticastRateLimitTooltip = "Select the Rate Limit of the Multicast Profile";
	 String selectMulticastRPTooltip = "Select Rendezvous Point";
	 String selectMulticastRPTooltipMode = "Select Rendezvous Point Mode";
	 
	 // Juniper
	 String selectLocalRPIPPool = "Select the IP Pool to get the address from. Or leave it in Manual to enter a IP Address manually";
	 String selectLocalRPIP = "Select the IP Address of the Local RP";
	 String selectLocalMSDPIPPool = "Select the IP Pool to get the address from. Or leave it in Manual to enter a IP Address manually";
	 String selectLocalMSDPIP = "Select the IP Address of the Local MSDP";

	try
	{
%>
<html>
<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
  <script language="JavaScript" src='/activator/javascript/saUtilities.js'></script>
  <script language="JavaScript">       
		window.resizeTo(800,800);
	  </script>
  <script type="text/javascript">
	
	function submitFormGeneric() 
	{
        var form = document.form;
		var isValid = true;
		var doSubmit = true;
        
		form.MulticastQoSClass.value = form.cmbSelectQoSClass.value;
		form.MulticastRateLimit.value = form.cmbSelectRateLimit.value;
		form.MulticastRP.value = form.checkRP.value;
		if (form.checkRP.value == "true")
		{
			form.MulticastRPMode.value = form.cmbSelectRPMode.value;
			if( form.cmbSelectRPMode.value == "Static"){
				form.MulticastRPIP.value = form.selectRPAddress.value;
				isValid = ValidateIPaddress(form.selectRPAddress, "RP");
				if (isValid == false) doSubmit = false;
			}
		}
        if (doSubmit == true)
		{
			form.submit();
		}
    }
	
	function submitFormCancel() 
	{
        var form = document.form;
        
		form.MulticastMode.value = "cancel";
		
        form.submit();
    }
	
	function reload()
	{
		var form = document.form;
		
		form.action = '/activator/customJSP/L3VPN_ModifySiteAttachment_Multicast/SelectMulticastOptions/select_multicast_options.jsp'; 
		form.submit();
	}
	
	function submitFormJuniper() 
	{
        var form = document.form;
		var doSubmit = true;
		var isValid = true;
		var isMultiple = false;
		
		var mcastProfileListString = "";
		var checkboxes = document.getElementsByName('mcastprofileid');
				
		for (var i=0; i<checkboxes.length; i++) 
		{
			if (checkboxes[i].checked) 
			{
				mcastProfileListString = mcastProfileListString + "#" + checkboxes[i].value;
			}
		}
		
		form.MulticastProfileList.value = mcastProfileListString.substring(1);
		
		if (form.cmbRPMode.value == "Remote")
		{
			if (document.getElementsByName('checkMultiple')[0].checked)
			{
				isMultiple = true;
			}
		}
		
		if (form.cmbRPMode.value == "Anycast")
		{
			if (form.cmbAnycastRPMode.value == "Anycast-non-RP")
			{
				if (document.getElementsByName('checkMultiple')[0].checked)
				{
					isMultiple = true;
				}
			}
		}
		
		isValid = ValidateVtInterface(form.vtInterfaceEntry);
		if (isValid == false) doSubmit = false;
		
		form.VirtualTunnelInterface.value = "vt-"+form.vtInterfaceEntry.value;
		
		form.MulticastRPMode.value = form.cmbRPMode.value;
	
		
		if (form.cmbRPMode.value == "Local")
		{
			form.MulticastRPIPPool.value = form.cmbLocalRPPool.value;
			
			if (form.cmbLocalRPPool.value == "manual")
			{
				form.MulticastRPIP.value = form.selectRPIPLocalManual.value;
				isValid = ValidateIPaddress(form.selectRPIPLocalManual, "Local RP");
				if (isValid == false) doSubmit = false;
			}
			else
			{
				form.MulticastRPIP.value = form.selectRPIPLocalPool.value;
				isValid = ValidateIPaddress(form.selectRPIPLocalPool, "Local RP");
				if (isValid == false) doSubmit = false;
			}
		}
		
		if (form.cmbRPMode.value == "Remote")
		{
			if (isMultiple == true)
			{	
				var multipleRPString = "";
				
				<% for (int i=1; i <= multipleNumber; i++) 
				{ 
					String RPfieldName = "selectRPMultiple"+String.valueOf(i);%>
					
					isValid = ValidateIPaddress(form.<%=RPfieldName%>, "Remote RP");
					if (isValid == false) doSubmit = false;
					
					<% String GRfieldName = "selectGRMultiple"+String.valueOf(i);%>
					
					isValid = ValidateIPaddressGR(form.<%=GRfieldName%>, "Group Ranges IP");
					if (isValid == false) doSubmit = false;
					
					if (doSubmit == true) 
					{
						multipleRPString = multipleRPString + "#" + form.<%=RPfieldName%>.value + "|" + form.<%=GRfieldName%>.value;
					}
				<%}%>
				
				isValid = checkDuplicateEntries();
				if (isValid == false) doSubmit = false;
				
				form.MulticastRPIP.value = multipleRPString.substring(1);
			}
			else
			{
				form.MulticastRPIP.value = form.selectRPIPRemote.value;
				isValid = ValidateIPaddress(form.selectRPIPRemote, "Remote RP");
				if (isValid == false) doSubmit = false;
			}
		}
		
		if (form.cmbRPMode.value == "Anycast")
		{
			if (form.cmbAnycastRPMode.value == "Anycast-RP")
			{
				form.MulticastRPIP.value = form.selectRPIPLocalManual.value;
				isValid = ValidateIPaddress(form.selectRPIPLocalManual, "Local RP");
				if (isValid == false) doSubmit = false;
			}
			else
			{
				if (isMultiple == true)
				{	
					var multipleRPString = "";
					
					<% for (int i=1; i <= multipleNumber; i++) 
					{ 
						String RPfieldName = "selectRPMultiple"+String.valueOf(i);%>
						
						isValid = ValidateIPaddress(form.<%=RPfieldName%>, "Remote RP");
						if (isValid == false) doSubmit = false;
						
						<% String GRfieldName = "selectGRMultiple"+String.valueOf(i);%>
						
						isValid = ValidateIPaddressGR(form.<%=GRfieldName%>, "Group Ranges IP");
						if (isValid == false) doSubmit = false;
						
						if (doSubmit == true) 
						{
							multipleRPString = multipleRPString + "#" + form.<%=RPfieldName%>.value + "|" + form.<%=GRfieldName%>.value;
						}
					<%}%>
					
					isValid = checkDuplicateEntries();
					if (isValid == false) doSubmit = false;
					
					form.MulticastRPIP.value = multipleRPString.substring(1);
				}
				else
				{
					form.MulticastRPIP.value = form.selectRPIPRemote.value;
					isValid = ValidateIPaddress(form.selectRPIPRemote, "Remote RP");
					if (isValid == false) doSubmit = false;
				}
			}
			
			form.MulticastRPMode.value = form.cmbAnycastRPMode.value;	
		}
		
		if (form.cmbRPMode.value == "Auto")
		{
			if (form.cmbAutoRPMode.value != "Auto-RP-Discovery")
			{
				if (form.cmbLocalRPPool.value != "norp")
				{
					if (form.cmbLocalRPPool.value == "manual")
					{
						form.MulticastRPIP.value = form.selectRPIPLocalManual.value;
						isValid = ValidateIPaddress(form.selectRPIPLocalManual, "Local RP");
						if (isValid == false) doSubmit = false;
					}
					else
					{
						form.MulticastRPIP.value = form.selectRPIPLocalPool.value;
						isValid = ValidateIPaddress(form.selectRPIPLocalPool, "Local RP");
						if (isValid == false) doSubmit = false;
					}
				}
			}
			
			form.MulticastRPMode.value = form.cmbAutoRPMode.value;	
		}
		
		if (document.getElementsByName('checkRPMSDP')[0].checked)
		{
			form.MulticastMSDPLocalPool.value = form.cmbRPMSDPLocalPool.value;
			
			if (form.cmbRPMSDPLocalPool.value == "manual")
			{
				form.MulticastMSDPLocal.value = form.selectRPMSDPLocalManual.value;	
				isValid = ValidateIPaddress(form.selectRPMSDPLocalManual, "Local MSDP");
				if (isValid == false) doSubmit = false;
			}
			else
			{
				form.MulticastMSDPLocal.value = form.selectRPMSDPLocal.value;	
				isValid = ValidateIPaddress(form.selectRPMSDPLocal, "Local MSDP");
				if (isValid == false) doSubmit = false;
			}
			
			form.MulticastMSDPPeer.value = form.selectRPMSDPPeer.value;
			isValid = ValidateIPaddress(form.selectRPMSDPPeer, "Remote MSDP");
			if (isValid == false) doSubmit = false;
		}
		
		if (doSubmit == true)
		{
			form.submit();
		}
    }
	
	function ValidateIPaddress(inputText, addressType)  
	{  
		var ipformat = /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;  
		var inputSplit = inputText.value.split("@")[1];
		if (inputSplit == undefined) {
			inputSplit = inputText.value;
		}
		if(inputSplit.match(ipformat))  
		{  
			return true;  
		}  
		else  
		{  
			alert("You have entered an invalid "+addressType+" IP address: "+inputSplit); 
			return false;  
		}  
	}
	
	function ValidateIPaddressGR(inputText, addressType)  
	{  
		var ipformat = /^(22[4-9]|23[0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\/(3[0-2]|[0-2][0-9]|[1-9]?)$/;
		var inputSplit = inputText.value.split("@")[1];
		if (inputSplit == undefined) {
			inputSplit = inputText.value;
		}
		if(inputSplit.match(ipformat))  
		{  
			return true;  
		}  
		else  
		{  
			alert("You have entered an invalid Multicast Address for group ranges: "+inputSplit); 
			return false;  
		}
	}
	
	function ValidateVtInterface(inputText)
	{
		var ifformat = /^[0-9]+\/[0-9]+\/[0-9]+$/;
		
		if(inputText.value.match(ifformat))  
		{  
			return true;  
		}  
		else  
		{  
			alert("You have entered an invalid virtual tunnel interface. Expected format: vt-n/n/n (n=number)"); 
			return false;  
		}
	}
	
	function checkDuplicateEntries()
	{
		<% 
			for (int a=1; a <= multipleNumber; a++) 
			{
				String RPA = "selectRPMultiple"+String.valueOf(a);
				String GRA = "selectGRMultiple"+String.valueOf(a);
				
				for (int b=1; b <= multipleNumber; b++) 
				{
					if (a==b) continue;
					
					String RPB = "selectRPMultiple"+String.valueOf(b);
					String GRB = "selectGRMultiple"+String.valueOf(b);
					%>
						var rp_a = form.<%=RPA%>.value;
						var rp_b = form.<%=RPB%>.value;
						
						if (rp_a == rp_b)
						{
							alert("There are duplicate entries among the multiple RP list");
							return false;
						}
						
						var gr_a = form.<%=GRA%>.value;
						var gr_b = form.<%=GRB%>.value;
						
						if (gr_a == gr_b) 
						{
							alert("There are duplicate entries among the multiple group ranges list");
							return false;
						}
					<%
				}
			}
		%>
		
		return true;
	}

  </script>
  <meta http-equiv="content-type" content="text/html; charset=utf-8">
</head>
<body onmousemove='logoutTimerReset();' onkeydown='logoutTimerReset();' onUnLoad="opener.window.top.interactWindow=null">
<h3><img src="/activator/images/HPlogo-black.gif" valign="top" align="right">Interact with job: L3VPN_ModifySiteAttachment_Multicast</h3> 
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
   <td class="tableRow"> Select multicast options </td>
</tr>
</table>
<p>

<% if ("Cisco".equals(vendor)) { %>

	<table>
		<form name="form" action="/activator/sendCasePacket" method="POST">
		
			<% if (!"CiscoXR".equals(osversion)) {%>
				<% if ("".equals(current_multicast_mode)) {%>
				
					<tr class="tableRow" style="background: #FFFFFF">
					   <td ><b title="<%=selectMulticastModeTooltip%>" >Select Multicast mode: </b></td>
					   <td>
							<select name="cmbSelectMulticastMode" style="width:130px" title="<%=selectMulticastModeTooltip%>" onchange="reload();">
								<% if ("sparse-dense".equals(multicast_mode)) { %>
									<option value="sparse">sparse</option> 
									<option value="sparse-dense" selected>sparse-dense</option> 
								<% } else { %>
									<option value="sparse" selected>sparse</option> 
									<option value="sparse-dense">sparse-dense</option>
								<% } %>
							</select>
					   </td>
					   <td></td>
					</tr>
					<tr><td colspan="2">&nbsp;</td></tr>
				
				<% } else { %>
					
					<tr class="tableRow" style="background: #FFFFFF">
					   <td><b>Current Multicast mode: </b></td>
					   <td><%=current_multicast_mode%></td>
					   <td></td>
					</tr>
					<tr><td colspan="2">&nbsp;</td></tr>
					
					<input type="hidden" name="cmbSelectMulticastMode" value="<%=current_multicast_mode%>">
					
				<% } %>
			<% } 
			   else 
			   { %>
				<% if ("CiscoXR".equals(osversion)) { %>
					<% multicast_mode = "sparse"; %>
					<input type="hidden" name="cmbSelectMulticastMode" value="sparse">
				<% } else { %>
					<input type="hidden" name="cmbSelectMulticastMode" value="nomode">
				<% } %>
			<% } %>
	
			<input type="hidden" name="id" value="<%= jobRequestDescriptor.jobId %>">
			<input type="hidden" name="workflow" value="<%= jobRequestDescriptor.name %>">
			<input type="hidden" name="queue" value="select_multicast_options">
			
			<tr class="tableRow" style="background: #FFFFFF">
			   <td ><b title="<%=selectMulticastCoSTooltip%>" >Select COS: </b></td>
			   <td>
					<select name="cmbSelectQoSClass" style="width:130px" title="<%=selectMulticastCoSTooltip%>" >
						<% 	for (int i = 0; i < expMappings.length; i++) 
						{
							EXPMapping expMapping = expMappings[i];
							
							if ((expMapping.getExpvalue()).equals(multicast_qos_class)) { %>
								<option value="<%=expMapping.getExpvalue()%>" selected><%=expMapping.getClassname()%>
							<%} else { %>
								<option value="<%=expMapping.getExpvalue()%>"><%=expMapping.getClassname()%></option> 
							<% } %>
						<% } %>
					</select>
			   </td>
			   <td></td>
			</tr>
			
			<tr class="tableRow" style="background: #FFFFFF">
			   <td ><b title="<%=selectMulticastRateLimitTooltip%>" >Select Rate limit: </b></td>
			   <td>
					<select name="cmbSelectRateLimit" style="width:130px" title="<%=selectMulticastRateLimitTooltip%>" >
						<% rlList = rlList != null ? rlList : new RateLimit[0];

						for (int i = 0; i < rlList.length; i++) 
						{
							RateLimit rateLimit = rlList[i];
							
							if ("Unknown".equals(rateLimit.getRatelimitname())) continue;
							
							if ((rateLimit.getRatelimitname()).equals(multicast_rate_limit)) { %>
								<option value="<%=rateLimit.getRatelimitname()%>" selected><%=rateLimit.getRatelimitname()%></option> 
							<% } else { %>
								<option value="<%=rateLimit.getRatelimitname()%>"><%=rateLimit.getRatelimitname()%></option> 
							<% } %>
						<% } %>
					</select>
			   </td>
			   <td></td>
			</tr>
						
			
				<tr class="tableRow" style="background: #FFFFFF">				   
				  <td ><b title="<%=selectMulticastRPTooltip%>" >RP?: </b></td>
				   <td>
					<input TYPE="checkbox" id="checkRP" name="checkRP" VALUE=<%= (bcheckRP) ? "true": "false" %> <%= (bcheckRP) ? " CHECKED":" " %> onClick="document.getElementById('checkRP').value=form.checkRP.checked;reload();"></td>
							
				  </td>				   
				   <td></td>
				</tr>		
				
				
			<% if (bcheckRP) { %>
				<tr class="tableRow" style="background: #FFFFFF">
				   <td ><b title="<%=selectMulticastRPTooltipMode%>" >RP Mode: </b></td>
				   <td>
					<select name="cmbSelectRPMode" style="width:130px" title="<%=selectMulticastRPTooltipMode%>" onchange="reload();">
						<% if ("CiscoXR".equals(osversion)) { %>							
							<option value="Static" <%=("Static".equals(rp_mode))? " selected": " " %>>Static</option>
							<option value="Dynamic" <%=("Dynamic".equals(rp_mode))? " selected": " " %>>Dynamic</option>
						<% } else { %>
							<option value="Static" <%=("Static".equals(rp_mode))? " selected": " " %>>Static</option>
							<option value="Dynamic" <%=("Dynamic".equals(rp_mode))? " selected": " " %>>Dynamic</option>
							<% if (!("sparse-dense".equals(multicast_mode))) {%>
							<option value="Announce" <%=("Announce".equals(rp_mode))? " selected": " " %>>RP-Announce</option>
							<% } %>
						<% } %>
					</select>
				   </td>
				   <td></td>
				</tr>
				
			<%}%>
			
				<% if (bcheckRP && "Static".equals(rp_mode)) { %>
				<tr class="tableRow" style="background: #FFFFFF">
				   <td ><b title="<%=selectMulticastRPTooltipMode%>" >Static Address: </b></td>
				   <td>
					<% if (!("".equals(selected_rp))) { %>
								<input type="text" size="15" name="selectRPAddress" maxlength="15" value="<%=selected_rp%>" onFocus="this.select()">
							<% } else { %>
								<input type="text" size="15" name="selectRPAddress" maxlength="15" value="Enter Address" onFocus="this.select()">
							<% } %>
							
				   </td>
				   <td></td>
				</tr>
				<%} if(bcheckRP && !"Static".equals(rp_mode)) {%>				
				<input type="hidden" name="selectRPAddress" value="">
				<% } %>		
			
					
			<% if (("dense".equals(current_multicast_mode)) && !("CiscoXR".equals(osversion))) { %>
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td colspan="2"><b>Current Multicast mode is dense, which is not supported by Cisco GSR</b></td></tr>
				<tr>
					<td align="center" colspan="2">		
						<input type="Button" value="Cancel Modify" OnClick="submitFormCancel()"> &nbsp;&nbsp;
					</td>
				</tr>
			<% } else { %>
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr>
					<td align="center" colspan="3">		
						<input type="Button" value="Submit" OnClick="submitFormGeneric()"> &nbsp;&nbsp;					
						<input type="Button" value="Cancel Modify" OnClick="submitFormCancel()"> &nbsp;&nbsp;
					</td>
				</tr>
			<% } %>

			<input type="hidden" name="VPNId"  value="<%=vpn_id%>">
			<input type="hidden" name="AttachmentId"  value="<%=attachment_id%>">			
			<input type="hidden" name="neName"  value="<%=ne_name%>">
			<input type="hidden" name="neId"  value="<%=ne_id%>">
			<input type="hidden" name="isMigration"  value="<%=is_migration%>">
			<input type="hidden" name="MulticastVPNId"  value="<%=multicast_vpn_id%>">
			<input type="hidden" name="MulticastQoSClass"  value="">
			<input type="hidden" name="MulticastRateLimit"  value="">
			<input type="hidden" name="MulticastRP"  value="">
			<input type="hidden" name="MulticastMode"  value="<%=multicast_mode%>">
			<input type="hidden" name="VPN_Info"  value="<%=vpnInfo%>">
			<input type="hidden" name="Vendor"  value="<%=vendor%>">
			<input type="hidden" name="MulticastRPMode"  value="<%=selected_rp_mode%>">
			<input type="hidden" name="MulticastRPIPPool"  value="">
			<input type="hidden" name="MulticastRPIP"  value="">
			<input type="hidden" name="MulticastMSDPLocalPool"  value="">
			<input type="hidden" name="MulticastMSDPLocal"  value="">
			<input type="hidden" name="MulticastMSDPPeer"  value="">
			<input type="hidden" name="VirtualTunnelInterface"  value="">
			
		</form>	
	</table>

<% } else if ("Huawei".equals(vendor)) { %>

<table>
		<form name="form" action="/activator/sendCasePacket" method="POST">
			
			<% if ("".equals(current_multicast_mode)) {%>
			
				<tr class="tableRow" style="background: #FFFFFF">
				   <td ><b title="<%=selectMulticastModeTooltip%>" >Select Multicast mode: </b></td>
				   <td>
						<select name="cmbSelectMulticastMode" style="width:130px" title="<%=selectMulticastModeTooltip%>" onchange="reload();">
							<% if ("sparse-dense".equals(multicast_mode)) { %>
								<option value="sparse">sparse</option> 
								<option value="sparse-dense" selected>sparse-dense</option> 
							<% } else { %>
								<option value="sparse" selected>sparse</option> 
								<option value="sparse-dense">sparse-dense</option>
							<% } %>
						</select>
				   </td>
				   <td></td>
				</tr>
				<tr><td colspan="2">&nbsp;</td></tr>
			
			<% } else { %>
					
				<tr class="tableRow" style="background: #FFFFFF">
				   <td><b>Current Multicast mode: </b></td>
				   <td><%=current_multicast_mode%></td>
				   <td></td>
				</tr>
				<tr><td colspan="2">&nbsp;</td></tr>
				
				<input type="hidden" name="cmbSelectMulticastMode" value="<%=current_multicast_mode%>">
				
			<% } %>
			
	
			<input type="hidden" name="id" value="<%= jobRequestDescriptor.jobId %>">
			<input type="hidden" name="workflow" value="<%= jobRequestDescriptor.name %>">
			<input type="hidden" name="queue" value="select_multicast_options">
			
			<tr class="tableRow" style="background: #FFFFFF">
			   <td ><b title="<%=selectMulticastCoSTooltip%>" >Select COS: </b></td>
			   <td>
					<select name="cmbSelectQoSClass" style="width:130px" title="<%=selectMulticastCoSTooltip%>" >
						<% 	for (int i = 0; i < expMappings.length; i++) 
						{
							EXPMapping expMapping = expMappings[i];
							
							if ((expMapping.getExpvalue()).equals(multicast_qos_class)) { %>
								<option value="<%=expMapping.getExpvalue()%>" selected><%=expMapping.getClassname()%>
							<%} else { %>
								<option value="<%=expMapping.getExpvalue()%>"><%=expMapping.getClassname()%></option> 
							<% } %>
						<% } %>
					</select>
			   </td>
			   <td></td>
			</tr>
			
			<tr class="tableRow" style="background: #FFFFFF">
			   <td ><b title="<%=selectMulticastRateLimitTooltip%>" >Select Rate limit: </b></td>
			   <td>
					<select name="cmbSelectRateLimit" style="width:130px" title="<%=selectMulticastRateLimitTooltip%>" >
						<% rlList = rlList != null ? rlList : new RateLimit[0];

						for (int i = 0; i < rlList.length; i++) 
						{
							RateLimit rateLimit = rlList[i];
							
							if ("Unknown".equals(rateLimit.getRatelimitname())) continue;
							
							if ((rateLimit.getRatelimitname()).equals(multicast_rate_limit)) { %>
								<option value="<%=rateLimit.getRatelimitname()%>" selected><%=rateLimit.getRatelimitname()%></option> 
							<% } else { %>
								<option value="<%=rateLimit.getRatelimitname()%>"><%=rateLimit.getRatelimitname()%></option> 
							<% } %>
						<% } %>
					</select>
			   </td>
			   <td></td>
			</tr>
						
			<% if (!("sparse-dense".equals(multicast_mode)) ) { %>
				<tr class="tableRow" style="background: #FFFFFF">
				   <td ><b title="<%=selectMulticastRPTooltip%>" >RP?: </b></td>
				   <td>
					<input TYPE="checkbox" id="checkRP" name="checkRP" VALUE=<%= (bcheckRP) ? "true": "false" %> <%= (bcheckRP) ? " CHECKED":" " %> onClick="document.getElementById('checkRP').value=form.checkRP.checked;reload();"></td>
					</td>				   
				   <td></td>
				</tr>
				<% if (bcheckRP) { %>
				<tr class="tableRow" style="background: #FFFFFF">
				   <td ><b title="<%=selectMulticastRPTooltipMode%>" >RP Mode: </b></td>
				   <td>
					<select name="cmbSelectRPMode" style="width:130px" title="<%=selectMulticastRPTooltipMode%>" onchange="reload();">
							<option value="Static" <%=("Static".equals(rp_mode))? " selected": " " %>>Static</option>
							<option value="Dynamic" <%=("Dynamic".equals(rp_mode))? " selected": " " %>>Dynamic</option>
													
					</select>
				   </td>
				   <td></td>
				</tr>
				<%} %>
				<%if (bcheckRP && "Static".equals(rp_mode)) { %>
					 <tr class="tableRow" style="background: #FFFFFF">
					   <td><b title="<%=selectMulticastRPTooltipMode%>" >Static Address: </b></td>
							<% if (!("".equals(selected_rp))) { %>
								<td><input type="text" size="15" name="selectRPAddress" maxlength="15" value="<%=selected_rp%>" onFocus="this.select()"></td>
							<% } else { %>
								<td><input type="text" size="15" name="selectRPAddress" maxlength="15" value="Enter Address" onFocus="this.select()"></td>
							<% } %>
						<td></td>
					</tr>
						
				
			<% } else {%>
			<input type="hidden" name="selectRPAddress" value="">
			<%}
			
			}else {%>
			   
				<input type="hidden" name="checkRP" value="false">
				<input type="hidden" name="cmbSelectRPMode" value="">
				<input type="hidden" name="selectRPAddress" value="">
			<% } %>
			
			<% if ("dense".equals(current_multicast_mode)) { %>
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td colspan="2"><b>Current Multicast mode is dense, which is not supported by Huawei</b></td></tr>
				<tr>
					<td align="center" colspan="2">		
						<input type="Button" value="Cancel Modify" OnClick="submitFormCancel()"> &nbsp;&nbsp;
					</td>
				</tr>
			<% } else { %>
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr>
					<td align="center" colspan="3">					
						<input type="Button" value="Submit" OnClick="submitFormGeneric()"> &nbsp;&nbsp;					
						<input type="Button" value="Cancel Modify" OnClick="submitFormCancel()"> &nbsp;&nbsp;
					</td>
				</tr>
			<% } %>
			


			<input type="hidden" name="VPNId"  value="<%=vpn_id%>">
			<input type="hidden" name="AttachmentId"  value="<%=attachment_id%>">			
			<input type="hidden" name="neName"  value="<%=ne_name%>">
			<input type="hidden" name="neId"  value="<%=ne_id%>">
			<input type="hidden" name="isMigration"  value="<%=is_migration%>">
			<input type="hidden" name="isAdvanced"  value="<%=is_advanced%>">			
			<input type="hidden" name="MulticastVPNId"  value="<%=multicast_vpn_id%>">
			<input type="hidden" name="MulticastQoSClass"  value="">
			<input type="hidden" name="MulticastRateLimit"  value="">
			<input type="hidden" name="MulticastRP"  value="">
			<input type="hidden" name="MulticastMode"  value="<%=multicast_mode%>">
			<input type="hidden" name="VPN_Info"  value="<%=vpnInfo%>">
			<input type="hidden" name="Vendor"  value="<%=vendor%>">
			<input type="hidden" name="MulticastRPMode"  value="<%=selected_rp_mode%>">
			<input type="hidden" name="MulticastRPIPPool"  value="">
			<input type="hidden" name="MulticastRPIP"  value="">
			<input type="hidden" name="MulticastMSDPLocalPool"  value="">
			<input type="hidden" name="MulticastMSDPLocal"  value="">
			<input type="hidden" name="MulticastMSDPPeer"  value="">
			<input type="hidden" name="VirtualTunnelInterface"  value="">
			
		</form>	
	</table>


<% }else if ("Juniper".equals(vendor) && "true".equals(is_advanced)) { %> 
	
	<% if (siteExists) { %>
		<table>
			<form name="form" action="/activator/sendCasePacket" method="POST">
				<input type="hidden" name="id" value="<%= jobRequestDescriptor.jobId %>">
				<input type="hidden" name="workflow" value="<%= jobRequestDescriptor.name %>">
				<input type="hidden" name="queue" value="select_multicast_options">
				
				<tr class="tableRow" style="background: #FFFFFF">
				   <td><b>There is already one existing multicast site configured for this VPN Service (<%=vpnName%>) in <%=ne_name%>(<%=ne_id%>)</b></td>
				   <td></td>
				   <td></td>
				</tr>
				
				<% if (existingSite != null) 
				{				
					String RPAddr = "";
					String MsdpLocal = "";
					String MsdpPeer = "";
					
					if (existingSite.getRpaddress() != null) RPAddr = existingSite.getRpaddress();
					if (existingSite.getMsdplocaladdress() != null) MsdpLocal = existingSite.getMsdplocaladdress();
					if (existingSite.getMsdppeeraddress() != null) MsdpPeer = existingSite.getMsdppeeraddress();
					
					if (RPAddr.contains("|")) RPAddr = "Multiple RP configured";
				
				%>
					<tr>
						<td colspan="3">
							<table width="100%" border=0 cellpadding=0>
								<tr>
								   <td class="tableHeading">AttachmentId</td>
								   <td class="tableHeading">MulticastLoopbackAddress</td>
								   <td class="tableHeading">VirtualTunnelId</td>
								   <td class="tableHeading">RPMode</td>
								   <td class="tableHeading">RPAddress</td>
								   <td class="tableHeading">MSDPLocalAddress</td>
								   <td class="tableHeading">MSDPPeerAddress</td>								   
								</tr>
								<tr>
								   <td class="tableRow"> <%= existingSite.getAttachmentid() %> </td>
								   <td class="tableRow"> <%= existingSite.getMulticastloopbackaddress() %> </td>
								   <td class="tableRow"> <%= existingSite.getVirtualtunnelid() %> </td>
								   <td class="tableRow"> <%= existingSite.getRpmode() %> </td>
								   <td class="tableRow"> <%= RPAddr %> </td>
								   <td class="tableRow"> <%= MsdpLocal %> </td>
								   <td class="tableRow"> <%= MsdpPeer %> </td>
								</tr>
							</table>
						</td>
					</tr>
				<% } %>
				
				<input type="hidden" name="MulticastMode"  value="<%=multicast_mode%>">
				
				<!-- Common trailer -->
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr>
					<td align="center" colspan="3">
						<input type="Button" value="Cancel Modify" OnClick="submitFormCancel()"> &nbsp;&nbsp;
					</td>
				</tr>
			</form>
		</table>
	<% } else { %>
		<table>
			<form name="form" action="/activator/sendCasePacket" method="POST">
				<input type="hidden" name="id" value="<%= jobRequestDescriptor.jobId %>">
				<input type="hidden" name="workflow" value="<%= jobRequestDescriptor.name %>">
				<input type="hidden" name="queue" value="select_multicast_options">
				
				<tr class="tableRow" style="background: #FFFFFF">
				   <td><b>Existing Multicast Profiles for <%=vpnName%></b></td>
				   <td></td>
				   <td></td>
				</tr>
				
				<tr class="tableRow" style="background: #FFFFFF">
				   <td>Select the MCAST Profiles to configure for <%=siteName%>: </td>
				   <td></td>
				   <td></td>
				</tr>
			<% if ( previousMCAR != null && previousMCOSstr != null) { %>
				<tr class="tableRow" style="color: #110000">
				   <td><font color="red">Old Multicast parameters: <%=previousMCAR%> - <%=previousMCOSstr%></font></td>
				   <td></td>
				   <td></td>
				</tr>
			<% } %>
				<tr>
					<td colspan="3">
						<table width="100%" border=0 cellpadding=0>
							<tr>
							   <td class="tableHeading">Select</td>
							   <td class="tableHeading">Multicast Source</td>
							   <td class="tableHeading">Multicast Group</td>
							   <td class="tableHeading">COS</td>
							   <td class="tableHeading">Rate Limit</td>
							</tr>
							<% if (multicastProfiles != null) {%>
								<% for (int i=0; i < multicastProfiles.length; i++) {
									MulticastProfile mcastProfile = multicastProfiles[i]; %>
									
									<tr>
									   <% if((mcast_profile_list != null) && (mcast_profile_list.contains(mcastProfile.getMcastprofileid()))) { %>
										<td class="tableRow"> <input type="checkbox" name="mcastprofileid" value="<%=mcastProfile.getMcastprofileid()%>" checked /> </td>
									   <% } else { %>	
										<td class="tableRow"> <input type="checkbox" name="mcastprofileid" value="<%=mcastProfile.getMcastprofileid()%>"/> </td>
									   <% } %>
									   <td class="tableRow"> <%= mcastProfile.getMulticastsource() %> </td>
									   <td class="tableRow"> <%= mcastProfile.getMulticastgroup() %> </td>
									   <td class="tableRow"> 
										<%  for (int j = 0; j < expMappings.length; j++) 
											{
												EXPMapping expMapping = expMappings[j];
												
												if ((expMapping.getExpvalue()).equals(mcastProfile.getCos())) { %> 
													<%=expMapping.getClassname()%> 
												<% } %>
											<% } %>
									   </td>
									   <td class="tableRow"> <%= mcastProfile.getBandwidth() %> </td>
									</tr>
								<% } %>
							<% } else { %>
								<tr>
									<td colspan="4" class="tableRow">No Multicast Profiles for this VPN</td>
								</tr>
							<% } %>
						</table>
					</td>
				</tr>
				
				<tr class="tableRow" style="background: #FFFFFF">
				   <td>Multicast Profiles can be Added/Modified/Deleted from the SAVPN/Services Inventory Tree</td>
				   <td></td>
				   <td></td>
				</tr>
				
				<tr class="tableRow" style="background: #FFFFFF">
				   <td><input type="Button" value="Refresh" OnClick="reload();"></td>
				   <td></td>
				   <td></td>
				</tr>
					
				<tr><td colspan="2">&nbsp;</td></tr>
			</table>
				
			
			<table>
				<tr class="tableRow" style="background: #FFFFFF">
					<td><b>Specify Virtual Tunnel interface: </b></td>
					<% if (!("".equals(selected_vt_interface))) { %>
						<td>vt-<input type="text" size="9" name="vtInterfaceEntry" maxlength="9" value="<%=selected_vt_interface%>"></td>
					<% } else { %>
						<td>vt-<input type="text" size="9" name="vtInterfaceEntry" maxlength="9" value="n/n/n" onFocus="this.select()"><td>
					<% } %>
					<td></td>
				</tr>
				
				<tr><td colspan="2">&nbsp;</td></tr>
				
				<tr class="tableRow" style="background: #FFFFFF">
				   <td><b>RP settings: </b></td>
				   <td></td>
				   <td></td>
				</tr>
				
				<tr class="tableRow" style="background: #FFFFFF">
					<td>Select RP mode:</td>
					<td>
						<select name="cmbRPMode" style="width:130px" onchange="reload();">
							<% if ("Disabled".equals(selected_rp_mode)) { %>
								<option value="Disabled" selected>Disabled</option> 
							<% } else { %>
								<option value="Disabled">Disabled</option> 
							<% } %>
							<% if ("Remote".equals(selected_rp_mode)) { %>
								<option value="Remote" selected>Remote</option> 
							<% } else { %>
								<option value="Remote">Remote</option> 
							<% } %>
							<% if ("Local".equals(selected_rp_mode)) { %>
								<option value="Local" selected>Local</option> 
							<% } else { %>
								<option value="Local">Local</option> 
							<% } %>
							<% if ("Anycast".equals(selected_rp_mode)) { %>
								<option value="Anycast" selected>Anycast</option> 
							<% } else { %>
								<option value="Anycast">Anycast</option> 
							<% } %>
							<% if ("Auto".equals(selected_rp_mode)) { %>
								<option value="Auto" selected>Auto RP</option> 
							<% } else { %>
								<option value="Auto">Auto RP</option> 
							<% } %>
						</select>
					</td>
					<% if ("Remote".equals(selected_rp_mode) || ("Anycast".equals(selected_rp_mode) && "Anycast-non-RP".equals(selected_anycast_rp_mode))) { %>
						<td>
							<% if (!("".equals(selected_multiple_check))) { %>
								<input type="checkbox" name="checkMultiple" value="checkMultiple" onchange="reload();" checked /> Multiple
							<% } else { %>
								<input type="checkbox" name="checkMultiple" value="checkMultiple" onchange="reload();" /> Multiple
							<% } %>
						</td>
					<% } else { %>
						<td></td>
					<% } %>
				</tr>
				
				<% if ("Local".equals(selected_rp_mode)) { %>
					<tr class="tableRow" style="background: #FFFFFF">
					   <td>Select RP IP Address:</td>
						<% if (multicastLocalRPPools != null) { %>
							<% if (multicastLocalRPPools.length > minimum_length) { %>
								<td><select name="cmbLocalRPPool" style="width:130px" title="<%=selectLocalRPIPPool%>" onchange="reload();">
										
									<% if ("manual".equals(selected_local_rp_pool)) { %>
										<option value="manual" selected>Manual</option> 
									<% } else { %>
										<option value="manual">Manual</option> 
									<% } %>
										
										<% String ipPoolStr = null;
										
										for (int i=0; i < multicastLocalRPPools.length; i++) 
										{
											ipPoolStr = multicastLocalRPPools[i].getName();
											
											if (ipPoolStr.equals(selected_local_rp_pool))
											{%>
												<option value="<%=ipPoolStr%>" selected><%=ipPoolStr%></option> 
											<% } else { %>
												<option value="<%=ipPoolStr%>" ><%=ipPoolStr%></option> 
											<% }
										}%>
								</select></td>
							<% } else { %>
								<td><select name="cmbLocalRPPool" style="width:130px" title="<%=selectLocalRPIPPool%>" ><option value="manual" selected>Manual</option> </td>
							<% }
						} else { %>
							<td><select name="cmbLocalRPPool" style="width:130px" title="<%=selectLocalRPIPPool%>" ><option value="manual" selected>Manual</option> </td>
						<% } %>
						<% if ("manual".equals(selected_local_rp_pool)) { %>
							<% if (!("".equals(selected_rp_ip_local_manual))) { %>
								<td><input type="text" size="15" name="selectRPIPLocalManual" maxlength="15" value="<%=selected_rp_ip_local_manual%>"></td>
							<% } else { %>
								<td><input type="text" size="15" name="selectRPIPLocalManual" maxlength="15" value="Enter Address" onFocus="this.select()"></td>
							<% } %>
						<% } else { %>
							<% if (multicastLocalRPs != null) { %>
								<% if (multicastLocalRPs.length > minimum_length) { %>
									<td><select name="selectRPIPLocalPool" style="width:130px" title="<%=selectLocalRPIP%>" >
												
											<% String iphostStr = null;
											
											for (int i=0; i < multicastLocalRPs.length; i++) 
											{
												iphostStr = multicastLocalRPs[i].getIp();
												
												if (iphostStr.equals(selected_rp_ip_local_pool))
												{%>
													<option value="<%=iphostStr%>" selected><%=iphostStr%></option> 
												<% } else { %>
													<option value="<%=iphostStr%>" ><%=iphostStr%></option> 
												<% }
											}%>
									</select></td>
								<% } else { %>
									<td>No free IP Addresses available in current Multicast RP Pool</td>
								<% }
							} else { %>
								<td>Current IP Address Pool could not be found</td>
							<% } %>
						<% } %>
					</tr>
				<% } %>
				
				<% if ("Anycast".equals(selected_rp_mode)) { %>
					<tr class="tableRow" style="background: #FFFFFF">
						<td>Select Anycast mode:</td>
						<td>
							<select name="cmbAnycastRPMode" style="width:130px" onchange="reload();">
								<% if ("Anycast-non-RP".equals(selected_anycast_rp_mode)) { %>
									<option value="Anycast-non-RP" selected>Non-RP</option> 
								<% } else { %>
									<option value="Anycast-non-RP">Non-RP</option> 
								<% } %>
								<% if ("Anycast-RP".equals(selected_anycast_rp_mode)) { %>
									<option value="Anycast-RP" selected>RP</option> 
								<% } else { %>
									<option value="Anycast-RP">RP</option> 
								<% } %>
							</select>
						</td>
						<td></td>
					</tr>
					<% if ("Anycast-RP".equals(selected_anycast_rp_mode)) { %>
						<tr class="tableRow" style="background: #FFFFFF">
						   <td>Select RP IP Address:</td>
								<% if (!("".equals(selected_rp_ip_local_manual))) { %>
									<td><input type="text" size="15" name="selectRPIPLocalManual" maxlength="15" value="<%=selected_rp_ip_local_manual%>"></td>
								<% } else { %>
									<td><input type="text" size="15" name="selectRPIPLocalManual" maxlength="15" value="Enter Address" onFocus="this.select()"></td>
								<% } %>
							<td></td>
						</tr>
					<% } else { %>
						<% if ("".equals(selected_multiple_check)) { %>
							<tr class="tableRow" style="background: #FFFFFF">
							   <td>Specify Remote RP IP Address:</td>
									<% if (!("".equals(selected_rp_ip_remote))) { %>
										<td><input type="text" size="15" name="selectRPIPRemote" maxlength="15" value="<%=selected_rp_ip_remote%>" onFocus="this.select()"></td>
									<% } else { %>
										<td><input type="text" size="15" name="selectRPIPRemote" maxlength="15" value="Enter Address" onFocus="this.select()"></td>
									<% } %>
								<td></td>
							</tr>
						<% } else { %>
							<tr class="tableRow" style="background: #FFFFFF">
							   <td>Specify the number of Remote RPs:</td>
							   <td>
									<select name="cmbMultipleNum" style="width:40px" onchange="reload();">
										<% if ("2".equals(selected_multiple_number)) { %>
											<option value="2" selected>2</option> 
										<% } else { %>
											<option value="2">2</option> 
										<% } %>
										<% if ("3".equals(selected_multiple_number)) { %>
											<option value="3" selected>3</option> 
										<% } else { %>
											<option value="3">3</option> 
										<% } %>
										<% if ("4".equals(selected_multiple_number)) { %>
											<option value="4" selected>4</option> 
										<% } else { %>
											<option value="4">4</option> 
										<% } %>
										<% if ("5".equals(selected_multiple_number)) { %>
											<option value="5" selected>5</option> 
										<% } else { %>
											<option value="5">5</option> 
										<% } %>
									</select>
							   </td>
							   <td></td>
							</tr>
							<% for (int i=1; i <= multipleNumber; i++) { %>
								<tr class="tableRow" style="background: #FFFFFF">
									<% if (i == 1) { %>
										<td>Specify RP / group-ranges addresses:</td>
									<% } else { %>
										<td></td>
									<% } 
									String rpAddrEntryName = "selectRPMultiple"+String.valueOf(i);
									String grpRangesAddrEntryName = "selectGRMultiple"+String.valueOf(i);
									
									if (!("".equals(multipleRPs.get(i)))) { %>
										<td><input type="text" size="15" name="<%=rpAddrEntryName%>" maxlength="15" value="<%=multipleRPs.get(i)%>" onFocus="this.select()"></td>
									<% } else { %>
										<td><input type="text" size="15" name="<%=rpAddrEntryName%>" maxlength="15" value="Enter Address" onFocus="this.select()"></td>
									<% } 
														
									if (!("".equals(multipleGRs.get(i)))) { %>
										<td><input type="text" size="18" name="<%=grpRangesAddrEntryName%>" maxlength="18" value="<%=multipleGRs.get(i)%>" onFocus="this.select()"></td>
									<% } else { %>
										<td><input type="text" size="18" name="<%=grpRangesAddrEntryName%>" maxlength="18" value="Enter Address/mask" onFocus="this.select()"></td>
									<% } %>
								</tr>
							<% } %>
						<% } %>
					<% } %>
				<% } %>
				
				<% if ("Auto".equals(selected_rp_mode)) { %>
					<tr class="tableRow" style="background: #FFFFFF">
						<td>Select auto-RP mode:</td>
						<td>
							<select name="cmbAutoRPMode" style="width:130px" onchange="reload();">
								<% if ("Auto-RP-Discovery".equals(selected_auto_rp_mode)) { %>
									<option value="Auto-RP-Discovery" selected>Discovery</option> 
								<% } else { %>
									<option value="Auto-RP-Discovery">Discovery</option> 
								<% } %>
								<% if ("Auto-RP-Announce".equals(selected_auto_rp_mode)) { %>
									<option value="Auto-RP-Announce" selected>Announce</option> 
								<% } else { %>
									<option value="Auto-RP-Announce">Announce</option> 
								<% } %>
								<% if ("Auto-RP-Mapping".equals(selected_auto_rp_mode)) { %>
									<option value="Auto-RP-Mapping" selected>Mapping</option> 
								<% } else { %>
									<option value="Auto-RP-Mapping">Mapping</option> 
								<% } %>
							</select>
						</td>
						<td></td>
					</tr>
					<% if (!("Auto-RP-Discovery".equals(selected_auto_rp_mode))) { %>
						<tr class="tableRow" style="background: #FFFFFF">
						   <td>Select RP IP Address:</td>
							<% if (multicastLocalRPPools != null) { %>
								<% if (multicastLocalRPPools.length > minimum_length) { %>
									<td><select name="cmbLocalRPPool" style="width:130px" title="<%=selectLocalRPIPPool%>" onchange="reload();">
									
										<% if ("Auto-RP-Mapping".equals(selected_auto_rp_mode)) { %>
											<% if ("norp".equals(selected_local_rp_pool)) { %>
												<option value="norp" selected>No RP</option> 
											<% } else { %>
												<option value="norp">No RP</option> 
											<% } %>
										<% } %>
											
										<% if ("manual".equals(selected_local_rp_pool)) { %>
											<option value="manual" selected>Manual</option> 
										<% } else { %>
											<option value="manual">Manual</option> 
										<% } %>
											
											<% String ipPoolStr = null;
											
											for (int i=0; i < multicastLocalRPPools.length; i++) 
											{
												ipPoolStr = multicastLocalRPPools[i].getName();
												
												if (ipPoolStr.equals(selected_local_rp_pool))
												{%>
													<option value="<%=ipPoolStr%>" selected><%=ipPoolStr%></option> 
												<% } else { %>
													<option value="<%=ipPoolStr%>" ><%=ipPoolStr%></option> 
												<% }
											}%>
									</select></td>
								<% } else { %>
									<td><select name="cmbLocalRPPool" style="width:130px" title="<%=selectLocalRPIPPool%>" ><option value="manual" selected>Manual</option> </td>
								<% }
							} else { %>
								<td><select name="cmbLocalRPPool" style="width:130px" title="<%=selectLocalRPIPPool%>" ><option value="manual" selected>Manual</option> </td>
							<% } %>
							<% if ("manual".equals(selected_local_rp_pool)) { %>
								<% if (!("".equals(selected_rp_ip_local_manual))) { %>
									<td><input type="text" size="15" name="selectRPIPLocalManual" maxlength="15" value="<%=selected_rp_ip_local_manual%>"></td>
								<% } else { %>
									<td><input type="text" size="15" name="selectRPIPLocalManual" maxlength="15" value="Enter Address" onFocus="this.select()"></td>
								<% } %>
							<% } else if ("norp".equals(selected_local_rp_pool)) { %>
								<input type="hidden" name="selectRPIPLocalManual" value="">
							<% } else { %>
								<% if (multicastLocalRPs != null) { %>
									<% if (multicastLocalRPs.length > minimum_length) { %>
										<td><select name="selectRPIPLocalPool" style="width:130px" title="<%=selectLocalRPIP%>" >
													
												<% String iphostStr = null;
												
												for (int i=0; i < multicastLocalRPs.length; i++) 
												{
													iphostStr = multicastLocalRPs[i].getIp();
													
													if (iphostStr.equals(selected_rp_ip_local_pool))
													{%>
														<option value="<%=iphostStr%>" selected><%=iphostStr%></option> 
													<% } else { %>
														<option value="<%=iphostStr%>" ><%=iphostStr%></option> 
													<% }
												}%>
										</select></td>
									<% } else { %>
										<td>No free IP Addresses available in current Multicast RP Pool</td>
									<% }
								} else { %>
									<td>Current IP Address Pool could not be found</td>
								<% } %>
							<% } %>
						</tr>
					<% } %>
				<% } %>
		
				<% if ("Remote".equals(selected_rp_mode)) { %>
					<% if ("".equals(selected_multiple_check)) { %>
						<tr class="tableRow" style="background: #FFFFFF">
						   <td>Specify Remote RP IP Address:</td>
								<% if (!("".equals(selected_rp_ip_remote))) { %>
									<td><input type="text" size="15" name="selectRPIPRemote" maxlength="15" value="<%=selected_rp_ip_remote%>" onFocus="this.select()"></td>
								<% } else { %>
									<td><input type="text" size="15" name="selectRPIPRemote" maxlength="15" value="Enter Address" onFocus="this.select()"></td>
								<% } %>
							<td></td>
						</tr>
					<% } else { %>
						<tr class="tableRow" style="background: #FFFFFF">
						   <td>Specify the number of Remote RPs:</td>
						   <td>
								<select name="cmbMultipleNum" style="width:40px" onchange="reload();">
									<% if ("2".equals(selected_multiple_number)) { %>
										<option value="2" selected>2</option> 
									<% } else { %>
										<option value="2">2</option> 
									<% } %>
									<% if ("3".equals(selected_multiple_number)) { %>
										<option value="3" selected>3</option> 
									<% } else { %>
										<option value="3">3</option> 
									<% } %>
									<% if ("4".equals(selected_multiple_number)) { %>
										<option value="4" selected>4</option> 
									<% } else { %>
										<option value="4">4</option> 
									<% } %>
									<% if ("5".equals(selected_multiple_number)) { %>
										<option value="5" selected>5</option> 
									<% } else { %>
										<option value="5">5</option> 
									<% } %>
								</select>
						   </td>
						   <td></td>
						</tr>
						<% for (int i=1; i <= multipleNumber; i++) { %>
							<tr class="tableRow" style="background: #FFFFFF">
								<% if (i == 1) { %>
									<td>Specify RP / group-ranges addresses:</td>
								<% } else { %>
									<td></td>
								<% } 
								String rpAddrEntryName = "selectRPMultiple"+String.valueOf(i);
								String grpRangesAddrEntryName = "selectGRMultiple"+String.valueOf(i);
								
								if (!("".equals(multipleRPs.get(i)))) { %>
									<td><input type="text" size="15" name="<%=rpAddrEntryName%>" maxlength="15" value="<%=multipleRPs.get(i)%>" onFocus="this.select()"></td>
								<% } else { %>
									<td><input type="text" size="15" name="<%=rpAddrEntryName%>" maxlength="15" value="Enter Address" onFocus="this.select()"></td>
								<% } 
													
								if (!("".equals(multipleGRs.get(i)))) { %>
									<td><input type="text" size="18" name="<%=grpRangesAddrEntryName%>" maxlength="18" value="<%=multipleGRs.get(i)%>" onFocus="this.select()"></td>
								<% } else { %>
									<td><input type="text" size="18" name="<%=grpRangesAddrEntryName%>" maxlength="18" value="Enter Address/mask" onFocus="this.select()"></td>
								<% } %>
							</tr>
						<% } %>
					<% } %>
				<% } %>
				
				<tr><td colspan="2">&nbsp;</td></tr>
				
				<% if (!("Disabled".equals(selected_rp_mode))) { %>
					<tr class="tableRow" style="background: #FFFFFF">
						<td>
						<% if (!("".equals(selected_rp_msdp_check))) { %>
							<input type="checkbox" name="checkRPMSDP" value="checkRPMSDP" onchange="reload();" checked /> MSDP
						<% } else { %>
							<input type="checkbox" name="checkRPMSDP" value="checkRPMSDP" onchange="reload();" /> MSDP
						<% } %>
						</td>
						<td></td>
						<td></td>
					</tr>
					<% if (!("".equals(selected_rp_msdp_check))) { %>
						<tr class="tableRow" style="background: #FFFFFF">
							<td>Local Address:</td>
							<% if (multicastLocalMSDPPools != null) { %>
								<% if (multicastLocalMSDPPools.length > minimum_length) { %>
									<td><select name="cmbRPMSDPLocalPool" style="width:130px" title="<%=selectLocalMSDPIPPool%>" onchange="reload();">
											
										<% if ("manual".equals(selected_rp_msdp_local_pool)) { %>
											<option value="manual" selected>Manual</option> 
										<% } else { %>
											<option value="manual">Manual</option> 
										<% } %>
											
											<% String ipPoolStr = null;
											
											for (int i=0; i < multicastLocalMSDPPools.length; i++) 
											{
												ipPoolStr = multicastLocalMSDPPools[i].getName();
												
												if (ipPoolStr.equals(selected_rp_msdp_local_pool))
												{%>
													<option value="<%=ipPoolStr%>" selected><%=ipPoolStr%></option> 
												<% } else { %>
													<option value="<%=ipPoolStr%>" ><%=ipPoolStr%></option> 
												<% }
											}%>
									</select></td>
								<% } else { %>
									<td><select name="cmbRPMSDPLocalPool" style="width:130px" title="<%=selectLocalMSDPIPPool%>" ><option value="manual" selected>Manual</option> </td>
								<% }
							} else { %>
								<td><select name="cmbRPMSDPLocalPool" style="width:130px" title="<%=selectLocalMSDPIPPool%>" ><option value="manual" selected>Manual</option> </td>
							<% } %>
							<% if ("manual".equals(selected_rp_msdp_local_pool)) { %>
								<% if (!("".equals(selected_rp_msdp_local_manual))) { %>
									<td><input type="text" size="15" name="selectRPMSDPLocalManual" maxlength="15" value="<%=selected_rp_msdp_local_manual%>" onFocus="this.select()"></td>
								<% } else { %>
									<td><input type="text" size="15" name="selectRPMSDPLocalManual" maxlength="15" value="Enter Address" onFocus="this.select()"></td>
								<% } %>
							<% } else { %>
								<% if (multicastLocalMSDPs != null) { %>
									<% if (multicastLocalMSDPs.length > minimum_length) { %>
										<td><select name="selectRPMSDPLocal" style="width:130px" title="<%=selectLocalMSDPIP%>" >	
											<% String iphostStr = null;
											
											for (int i=0; i < multicastLocalMSDPs.length; i++) 
											{
												iphostStr = multicastLocalMSDPs[i].getIp();
												
												if (iphostStr.equals(selected_rp_msdp_local))
												{%>
													<option value="<%=iphostStr%>" selected><%=iphostStr%></option> 
												<% } else { %>
													<option value="<%=iphostStr%>" ><%=iphostStr%></option> 
												<% }
											}%>
										</select></td>
									<% } else { %>
										<td>No free IP Addresses available in current Multicast RP Pool</td>
									<% }
								} else { %>
									<td>Current IP Address Pool could not be found</td>
								<% } %>
							<% } %>
						</tr>
						<tr class="tableRow" style="background: #FFFFFF">
							<td>Peer Address:</td>
							<% if (!("".equals(selected_rp_msdp_peer))) { %>
								<td><input type="text" size="15" name="selectRPMSDPPeer" maxlength="15" value="<%=selected_rp_msdp_peer%>" onFocus="this.select()"></td>
							<% } else { %>
								<td><input type="text" size="15" name="selectRPMSDPPeer" maxlength="15" value="Enter Address" onFocus="this.select()"></td>
							<% } %>
							<td></td>
						</tr>
					<% } %>
				<% } else { %>
					<input type="hidden" name="checkRPMSDP" value="">
				<% } %>
			
				<input type="hidden" name="VPNId"  value="<%=vpn_id%>">
				<input type="hidden" name="AttachmentId"  value="<%=attachment_id%>">
				<input type="hidden" name="neName"  value="<%=ne_name%>">	
				<input type="hidden" name="neId"  value="<%=ne_id%>">			
				<input type="hidden" name="isMigration"  value="<%=is_migration%>">	
				<input type="hidden" name="isAdvanced"  value="<%=is_advanced%>">
				<input type="hidden" name="MulticastVPNId"  value="<%=multicast_vpn_id%>">
				<input type="hidden" name="MulticastQoSClass"  value="">
				<input type="hidden" name="MulticastRateLimit"  value="">
				<input type="hidden" name="MulticastRP"  value="">
				<input type="hidden" name="MulticastMode"  value="<%=multicast_mode%>">
				<input type="hidden" name="VPN_Info"  value="<%=vpnInfo%>">
				<input type="hidden" name="Vendor"  value="<%=vendor%>">
				<input type="hidden" name="MulticastRPMode"  value="<%=selected_rp_mode%>">
				<input type="hidden" name="MulticastRPIPPool"  value="">
				<input type="hidden" name="MulticastRPIP"  value="">
				<input type="hidden" name="MulticastMSDPLocalPool"  value="">
				<input type="hidden" name="MulticastMSDPLocal"  value="">
				<input type="hidden" name="MulticastMSDPPeer"  value="">
				<input type="hidden" name="MulticastProfileList"  value="">
				<input type="hidden" name="VirtualTunnelInterface"  value="">
				
				<!-- Common trailer -->
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr>
					<td align="center" colspan="3">
						<% if (noVtInterfacesAvailable) { %>
							<input type="Button" value="Submit" OnClick="submitFormJuniper()" disabled="true"> &nbsp;&nbsp;
						<% } else { %>
							<input type="Button" value="Submit" OnClick="submitFormJuniper()"> &nbsp;&nbsp;
						<% } %>
						
						<% if ("false".equals(is_migration)) { %>
							<input type="Button" value="Cancel Modify" OnClick="submitFormCancel()"> &nbsp;&nbsp;
						<% } %>
					</td>
				</tr>
			</form>
		</table>
	<% } %>


	<%}else if ("Juniper".equals(vendor) && !"true".equals(is_advanced)) { %>

<table>
		<form name="form" action="/activator/sendCasePacket" method="POST">
		
			<% if ("".equals(current_multicast_mode)) {%>
			
				<tr class="tableRow" style="background: #FFFFFF">
				   <td ><b title="<%=selectMulticastModeTooltip%>" >Select Multicast mode: </b></td>
				   <td>
						<select name="cmbSelectMulticastMode" style="width:130px" title="<%=selectMulticastModeTooltip%>" onchange="reload();">
							<% if ("sparse".equals(multicast_mode)) { %>
								<option value="sparse" selected>sparse</option> 
								<option value="sparse-dense">sparse-dense</option>
								<option value="dense">dense</option>
							<% } else if ("sparse-dense".equals(multicast_mode)) { %>
								<option value="sparse">sparse</option> 
								<option value="sparse-dense" selected>sparse-dense</option>
								<option value="dense">dense</option>
							<% } else { %>
								<option value="sparse">sparse</option> 
								<option value="sparse-dense">sparse-dense</option>
								<option value="dense" selected>dense</option>
							<% } %>
						</select>
				   </td>
				   <td></td>
				</tr>
				<tr><td colspan="2">&nbsp;</td></tr>
			
			<% } else { %>
			
				<% if ("dense".equals(current_multicast_mode)) { multicast_mode = "dense"; } %>
					
				<tr class="tableRow" style="background: #FFFFFF">
				   <td><b>Current Multicast mode: </b></td>
				   <td><%=current_multicast_mode%></td>
				   <td></td>
				</tr>
				<tr><td colspan="2">&nbsp;</td></tr>
				
				<input type="hidden" name="cmbSelectMulticastMode" value="<%=current_multicast_mode%>">
				
			<% } %>
			
	
			<input type="hidden" name="id" value="<%= jobRequestDescriptor.jobId %>">
			<input type="hidden" name="workflow" value="<%= jobRequestDescriptor.name %>">
			<input type="hidden" name="queue" value="select_multicast_options">
			
			<tr class="tableRow" style="background: #FFFFFF">
			   <td ><b title="<%=selectMulticastCoSTooltip%>" >Select COS: </b></td>
			   <td>
					<select name="cmbSelectQoSClass" style="width:130px" title="<%=selectMulticastCoSTooltip%>" >
						<% 	for (int i = 0; i < expMappings.length; i++) 
						{
							EXPMapping expMapping = expMappings[i];
							
							if ((expMapping.getExpvalue()).equals(multicast_qos_class)) { %>
								<option value="<%=expMapping.getExpvalue()%>" selected><%=expMapping.getClassname()%>
							<%} else { %>
								<option value="<%=expMapping.getExpvalue()%>"><%=expMapping.getClassname()%></option> 
							<% } %>
						<% } %>
					</select>
			   </td>
			   <td></td>
			</tr>
			
			<tr class="tableRow" style="background: #FFFFFF">
			   <td ><b title="<%=selectMulticastRateLimitTooltip%>" >Select Rate limit: </b></td>
			   <td>
					<select name="cmbSelectRateLimit" style="width:130px" title="<%=selectMulticastRateLimitTooltip%>" >
						<% rlList = rlList != null ? rlList : new RateLimit[0];

						for (int i = 0; i < rlList.length; i++) 
						{
							RateLimit rateLimit = rlList[i];
							
							if ("Unknown".equals(rateLimit.getRatelimitname())) continue;
							
							if ((rateLimit.getRatelimitname()).equals(multicast_rate_limit)) { %>
								<option value="<%=rateLimit.getRatelimitname()%>" selected><%=rateLimit.getRatelimitname()%></option> 
							<% } else { %>
								<option value="<%=rateLimit.getRatelimitname()%>"><%=rateLimit.getRatelimitname()%></option> 
							<% } %>
						<% } %>
					</select>
			   </td>
			   <td></td>
			</tr>						
			
			<% if (!"dense".equals(multicast_mode)) {%>
				
				<input type="hidden" name="checkRP" value="true">
				
				<tr class="tableRow" style="background: #FFFFFF">
				   <td ><b title="<%=selectMulticastRPTooltipMode%>" >RP Mode: </b></td>
				   <td>
					<select name="cmbSelectRPMode" style="width:130px" title="<%=selectMulticastRPTooltipMode%>" onchange="reload();">
							<option value="Static" <%=("Static".equals(rp_mode))? " selected": " " %>>Static</option>
							<option value="Dynamic" <%=("Dynamic".equals(rp_mode))? " selected": " " %>>Dynamic</option>
													
					</select>
				   </td>
				   <td></td>
				</tr>	
			
				<% if ("Static".equals(rp_mode)) { %>
					 <tr class="tableRow" style="background: #FFFFFF">
					   <td ><b title="<%=selectMulticastRPTooltipMode%>" >Static Address: </b></td>
							<% if (!("".equals(selected_rp))) { %>
								<td><input type="text" size="15" name="selectRPAddress" maxlength="15" value="<%=selected_rp%>" onFocus="this.select()"></td>
							<% } else { %>
								<td><input type="text" size="15" name="selectRPAddress" maxlength="15" value="Enter Address" onFocus="this.select()"></td>
							<% } %>
						<td></td>
					</tr>
				<%} else {%>
					<input type="hidden" name="selectRPAddress" value="">
				<% } %>
			<% } else { %>
				<input type="hidden" name="checkRP" value="false">
			<% } %>
				
			<!-- Common trailer -->
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr>
				<td align="center" colspan="3">					
					<input type="Button" value="Submit" OnClick="submitFormGeneric()"> &nbsp;&nbsp;					
					<input type="Button" value="Cancel Modify" OnClick="submitFormCancel()"> &nbsp;&nbsp;
				</td>
			</tr>

			<input type="hidden" name="VPNId"  value="<%=vpn_id%>">
			<input type="hidden" name="AttachmentId"  value="<%=attachment_id%>">			
			<input type="hidden" name="neName"  value="<%=ne_name%>">
			<input type="hidden" name="neId"  value="<%=ne_id%>">
			<input type="hidden" name="isMigration"  value="<%=is_migration%>">
			<input type="hidden" name="isAdvanced"  value="<%=is_advanced%>">			
			<input type="hidden" name="MulticastVPNId"  value="<%=multicast_vpn_id%>">
			<input type="hidden" name="MulticastQoSClass"  value="">
			<input type="hidden" name="MulticastRateLimit"  value="">
			<input type="hidden" name="MulticastRP"  value="">
			<input type="hidden" name="MulticastMode"  value="<%=multicast_mode%>">
			<input type="hidden" name="VPN_Info"  value="<%=vpnInfo%>">
			<input type="hidden" name="Vendor"  value="<%=vendor%>">
			<input type="hidden" name="MulticastRPMode"  value="<%=selected_rp_mode%>">
			<input type="hidden" name="MulticastRPIPPool"  value="">
			<input type="hidden" name="MulticastRPIP"  value="">
			<input type="hidden" name="MulticastMSDPLocalPool"  value="">
			<input type="hidden" name="MulticastMSDPLocal"  value="">
			<input type="hidden" name="MulticastMSDPPeer"  value="">
			<input type="hidden" name="VirtualTunnelInterface"  value="">
			
		</form>	
	</table>


<% }%>

</center>
</body>
</html>

<%  } 
	catch (Exception e) 
	{
		System.out.println("Exception in Multicast options selection: " + e.getMessage());
		e.printStackTrace();
	}
%>
