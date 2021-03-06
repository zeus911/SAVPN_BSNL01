	<%--##############################################################################--%>
	<%--                                                                              --%>
	<%--   ****  COPYRIGHT NOTICE ****                                                --%>
	<%--                                                                              --%>
	<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
	<%--                                                                              --%>
	<%--                                                                              --%>
	<%--##############################################################################--%>
	<%--                                                                              --%>
	<%--##############################################################################--%>
	<%--#                                                                             --%>
	<%--#  Description                                                                --%>
	<%--#                                                                             --%>
	<%--##############################################################################--%>
	<%--##############################################################################--%>
	<%--                                                                              --%>               
	<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/GISVPN_ReserveResource/Select_PE_Router_And_If/add_gis_site_pe.jsp,v $                                                                   --%>
	<%-- $Revision: 1.53 $                                                                 --%>
	<%-- $Date: 2010-12-02 09:38:38 $                                                                     --%>
	<%-- $Author: uma $                                                                   --%>
	<%--                                                                              --%>
	<%--##############################################################################--%>
	<%--#                                                                             --%>
	<%--#  Description                                                                --%>
	<%--#                                                                             --%>
	<%--##############################################################################--%>
	<%-- Queue: 'add_gis_site_pe' --%>
	<%@ page contentType="text/html; charset=UTF-8"
			 import="javax.sql.DataSource,java.sql.Connection,
					 java.sql.*,com.hp.ov.activator.mwfm.JobRequestDescriptor,
					 com.hp.ov.activator.mwfm.servlet.Constants,
					 com.hp.ov.activator.mwfm.AttributeDescriptor,
					 java.util.ArrayList,com.hp.ov.activator.cr.inventory.*,
					 com.hp.ov.activator.cr.inventory.Interface,
					 com.hp.ov.activator.vpn.inventory.*,
					 com.hp.ov.activator.vpn.IPAddressHelper.IPAddressHelper,
					 com.hp.ov.activator.cr.struts.nnm.cl.NNMiAbstractCrossLaunchAction,
					 com.hp.ov.activator.nnm.common.*,
					 java.util.Arrays"
					 %>
	<%
		   response.setDateHeader("Expires",0);
		// response.setHeader("Pragma","no-cache");
		request.setCharacterEncoding("UTF-8");
	%>
	<html>
	<head>
	  <title>hp OpenView service activator</title>
	  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
	   <script language="JavaScript">       
		window.resizeTo(800,700);
	  </script>
	</head>
	<body onUnLoad="opener.window.top.interactWindow=null">
	<h3><img src="/activator/images/HPLogo.png" valign="top" align="right">Interact with job: GISVPN_ReserveResource</h3>
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
	<% JobRequestDescriptor jd= (JobRequestDescriptor) session.getAttribute(Constants.MWFM_JOB_DESCRIPTOR); %>
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
	<%!
	  //a method to retrieve count of number PE's connected to a given switch
	  //used to filter out access switches if mask chosen is /31 or /127.
	  //Done because there wont be suficient ip's for both the PE's
	  int getPECount(Connection con, String switchId) throws Exception{
		  int count=0;
		  Switch accessSwitch = Switch.findByPrimaryKey(con, switchId);
		  AccessSwitchWrapper accessSwitchWrapper = new AccessSwitchWrapper(accessSwitch);
		  ArrayList PEs =  accessSwitchWrapper.getConnectedPElist(con);
		  if(PEs!=null){
			count=PEs.size();
		  }
		  return count;
	  }
	  //a method to retrieve index of eligible NE that can be set as selected element when there are NE's that can be disabled due to lack of action templates
	  //or other reasons
	  int getIndexOfNextEligibleNE(com.hp.ov.activator.cr.inventory.NetworkElement[] networkElements, ArrayList toBeDiabledElements) throws Exception{
		  int index=0;
		  for (int i = 0; i < networkElements.length; i++) {
			 //set the index to first element in the NetworkElement[]
			 index=i;
			 boolean matchfound=false;
			 String fromArrayId=networkElements[i].getNetworkelementid();
			 //now iterate through the toBeDiabledElements and see if there exists a NE with same id. If yes, then stop
			 //start searching through the next element in NetworkElement[]
			 for (int j = 0; j < toBeDiabledElements.size(); j++) {
				com.hp.ov.activator.cr.inventory.NetworkElement ne=(com.hp.ov.activator.cr.inventory.NetworkElement)toBeDiabledElements.get(j);
				String fromArrayListId = ne.getNetworkelementid();
				if(fromArrayId.equals(fromArrayListId)){
					matchfound=true;
					break;
				}
			 }
			 if(!matchfound){
				 //If element in NetworkElement[] did not match any element in toBeDiabledElements
				 //then we can stop iterating through the NetworkElement[] and make this as selected element
				 break;
			 }
		  }
		  return index;
	  }
	%>
	<%
		String vlan_id = "0";
		String dlci_value = "0";
		boolean isSharedPortAllowed = true;
		String ip = request.getRemoteAddr();
		AttributeDescriptor ad0 = jd.attributes[0];
		AttributeDescriptor ad1 = jd.attributes[1];
		String reused_router = ad1.value;
		AttributeDescriptor ad2 = jd.attributes[2];
		String reused_if = ad2.value;
		AttributeDescriptor ad16 = jd.attributes[16];
		String retry_message = ad16.value;
		AttributeDescriptor ad18 = jd.attributes[18];
		String routingprotocol = ad18.value;
		AttributeDescriptor ad30 = jd.attributes[30];
		String region = ad30.value;
		String rateLimit = jd.attributes[19].value;
		RateLimit ratelimit = null;
		long rateLimitBW = 0;
		String siteid = jd.attributes[21].value;
	//PR 15150 for special protection issue, the PEs which original attachment attached to should be excluded from the PE_List for protection attachment.
		AttributeDescriptor ad27 = jd.attributes[27];
		String attachment_type = "";
		attachment_type = ad27.value;
		AttributeDescriptor ad28 = jd.attributes[28];
		String original_attachmentid = null;
		original_attachmentid = ad28.value;
	//End of 15150    
		AttributeDescriptor ad29 = jd.attributes[29];
		String address_family = ad29.value;
		//by KK PR 18023
		//retrieve the service being currently added
		AttributeDescriptor ad31 = jd.attributes[31];
		String serviceIdBeingAdded = ad31.value;
		
		// Routing protocol 
		AttributeDescriptor ad37 = jd.attributes[37];
		AttributeDescriptor ad38 = jd.attributes[38];
		AttributeDescriptor ad39 = jd.attributes[39];
		
		AttributeDescriptor ad40 = jd.attributes[40];
		String preSelectedPERouter = ad40.value;
		
		AttributeDescriptor ad41 = jd.attributes[41];
		String preSelectedPEInterface = ad41.value;
		
		String ospf_area =ad37.value;
		String Asn=ad38.value;
		String Static_routes= ad39.value;
		
		if(Static_routes!=null && !"".equals(Static_routes)){
		if(Static_routes.charAt(0)==','){
		Static_routes=Static_routes.replaceFirst("^,",""); }
		}			
		if(request.getParameter("routing_protocol")!=null)
		{
		 routingprotocol=request.getParameter("routing_protocol");
		}		
		AttributeDescriptor ad35 = jd.attributes[35];
		String preSelectedIPNetAddr = ad35.value;
		AttributeDescriptor ad36 = jd.attributes[36];
		String preSelectedpoolname = ad36.value;
		IPAddrPool[] pools=null;
 		IPNet[] ipnetAll =null;
		String ipnet_chosen=null;
		String netmask_chosen=null;
		String ipnetaddr=null;
		if(request.getParameter("IPNetAddr")!=null)
		{
		ipnetaddr=request.getParameter("IPNetAddr");
		}else{
		ipnetaddr=preSelectedIPNetAddr;
		}
		String poolname="";
		if(request.getParameter("pool_name")!=null)
		{
		poolname=request.getParameter("pool_name");
		}
		else{
		poolname=preSelectedpoolname;
		}
		
		//by KK
		String service_type = null;
		service_type = request.getParameter ("service_type");
		if (service_type==null)
		  service_type = "";
		if ( "yes".equals(request.getParameter("reset_service_type"))) {
		  service_type = "";
		}
		String vlan_id_type = null;
		vlan_id_type = request.getParameter ("vlan_id_type");
		if (vlan_id_type==null)
		  vlan_id_type = "provider_managed";
		String lmi_type = null;
		lmi_type = request.getParameter ("lmi_type");
		if (lmi_type==null)
		  lmi_type = "ansi";
		String intf_type = null;
		intf_type = request.getParameter ("intf_type");
		if (intf_type==null)
		  intf_type = "dce";
		AttributeDescriptor ad4 = jd.attributes[4];
		String comment = request.getParameter ("comment");  
		comment = comment != null ? comment : (ad4.value == null ? "" : ad4.value);
		String originalComment = request.getParameter ("OriginalComment");
		originalComment = originalComment == null ? comment : originalComment;
		String ALL_PRESENT  = "0";
		String NO_EQUIPMENT = "1";
		String NO_INTERFACE = "2";
		String NO_DB = "3";
		String NO_PEs = "4";
		String NO_PEIFs = "5";
		String NOT_SUPPORTED_NUMBER_PEIFs = "6";
		String NO_VLANS = "7";
		String NO_VRRPGROUPIDS = "0";
		boolean hasController = false;
		boolean nnmEnabled = false;
		com.hp.ov.activator.cr.inventory.NetworkElement[] networkElements = null;
		ArrayList toBeDiabledElements = new ArrayList();
		 //AN-start
		Switch[] accessSwitches = null;
		Switch accessSwitch = null;
		AccessSwitchWrapper accessSwitchWrapper = null;
		String role = "";
		StringBuffer PEList = new StringBuffer();
		String ipNet_Mask = "30";
		String upe_port_mode="None";
		ArrayList PEs = null;
		boolean vrrpEnabled = false;
		boolean disableVRRP=false;
		String vrrp_master_pe_id ="";
		ArrayList freeVRRPGroupIds = null;
		String vrrp_group_id = "";
		//For NNM Cross Launch
		com.hp.ov.activator.nnm.common.NNMiConfiguration nnmconf = null;
		if(request.getParameter("vrrp_master_pe_id") != null){
		  vrrp_master_pe_id=request.getParameter("vrrp_master_pe_id");
	//      System.out.println("selected interface: " + interface_name);
		}
		if(request.getParameter("vrrp_group_id") != null){
		  vrrp_group_id=request.getParameter("vrrp_group_id");
	//      System.out.println("selected interface: " + interface_name);
		}
	if(request.getParameter("vrrpEnabled") != null){
	if ( "false".equals(request.getParameter("vrrpEnabled"))) {
		  vrrpEnabled = false;
		}
		else{
		vrrpEnabled = true;
		}
	 }
		//AN-end
		com.hp.ov.activator.cr.inventory.NetworkElement reused_ne = null;
		com.hp.ov.activator.cr.inventory.Interface[] ri = null;
		PERouter peRout = null;
		PERouterWrapper peRouterWrapper = null;
		String[] interfaceNames = null;
		String router_id = request.getParameter("router_id");
		if ((router_id == null || "".equals(router_id)) && (preSelectedPERouter != null && !"".equals(preSelectedPERouter)))
		{
			router_id = preSelectedPERouter;
		}
		
		boolean exceptionFlag = false;
		String interface_name="";
		if (request.getParameter("selected_pe_if")!=null) {
		  interface_name=request.getParameter("selected_pe_if");
	//      System.out.println("selected interface: " + interface_name);
		}
		if ("yes".equals(request.getParameter("reset_pe_if"))) {
		  interface_name="";
		}
		String maximumPrefix = null;
		maximumPrefix = request.getParameter("maximum_prefix");
		if (maximumPrefix == null) {
			maximumPrefix = "50";
		}
		// Username & password for BGP
		String[] BGPCredentialsVendors = { "Huawei" };
		String BGPUsername = null;
		BGPUsername = request.getParameter("BGPUsername");
		if (BGPUsername == null) {
			BGPUsername = "";
		}
		String BGPPassword = null;
		BGPPassword = request.getParameter("BGPPassword");
		if (BGPPassword == null) {
			BGPPassword = "";
		}
		// BGP Multi-Hop
		String[] BGPMultiHopVendors = { "Huawei", "Cisco", "Juniper" };
		boolean BGPMultiHopCheck = false;
		if (request.getParameter("BGPMultiHopCheck") == null) {
			BGPMultiHopCheck = false;
		} else {
			BGPMultiHopCheck = true;
		}
		String BGPMultiHop = null;
		BGPMultiHop = request.getParameter("BGPMultiHop");
		if (BGPMultiHop == null) {
			BGPMultiHop = "";
		}
		//String IPNetAddr =null;
		String ret_value = ALL_PRESENT;
		String location = ad0.value;
		int selected = 0;
		int freeDLCIs[] = null;
		int freeVlanIds[] = null;
	    String vendor = "";
		DataSource ds= (DataSource)session.getAttribute(Constants.DATASOURCE);
		Connection con = null;
		try {
			if (ds != null)  {
				con = ds.getConnection();
				   if (con != null) {
				   
						if ((interface_name == null || "".equals(interface_name)) && (preSelectedPEInterface != null && !"".equals(preSelectedPEInterface)))
						{
							Interface selectedIfObj = Interface.findByTerminationpointid(con, preSelectedPEInterface);
							interface_name = selectedIfObj.getName();
						}
					   //by kk PR 18023
					   //using the serviceIdBeingAdded check if there is an entry in V_L3ACCESSFLOW table
						L3AccessFlow aceessFlow = (com.hp.ov.activator.vpn.inventory.L3AccessFlow)L3AccessFlow.findByPrimaryKey(con, serviceIdBeingAdded);
						if(aceessFlow!=null){
							ipnet_chosen=aceessFlow.getIpnet();
							netmask_chosen=aceessFlow.getNetmask();
						}
					   //by KK
					if (reused_router != null && reused_router.trim().length()>0) {
					  reused_ne = com.hp.ov.activator.cr.inventory.NetworkElement.findByPrimaryKey(con, reused_router);
					  router_id = reused_router;
					}
					ratelimit = RateLimit.findByPrimaryKey(con, rateLimit);
					if(ratelimit != null){
					  rateLimitBW = ratelimit.getAveragebw();
					}
					// Address pool 
					String whereClause_1= "V_IPAddrPool.AddressFamily ='"+address_family+"'";
					 pools =IPAddrPool.findAll(con,whereClause_1);
						ArrayList<Object> availablePoolList = new ArrayList<Object>();
				if (pools != null) {
					for (int poolCount = 0; poolCount < pools.length; poolCount++) {
						String poolName = pools[poolCount].getName();
						if (IPNet.findByPoolnameCount(con, poolName, "count__ > '0'") > 0) {
							availablePoolList.add(pools[poolCount]);
						}
					}
				}
				if (0 != availablePoolList.size()) {
					pools = (IPAddrPool[]) availablePoolList.toArray(new IPAddrPool[availablePoolList.size()]);
				} else {
					pools = null;
				}		
					if(pools!=null)
					{
					 String whereclause_2="poolname='"+poolname+"' and count__ =1";
					    ipnetAll= IPNet.findAll(con,whereclause_2);		
					}
					
				//  end of pools
					nnmconf = com.hp.ov.activator.nnm.common.NNMiConfiguration.findById(con, "1");
					  if((nnmconf != null) && (nnmconf.getEnable_cl()== true )){
						nnmEnabled=true;
					}
				String whereClause = "Location = '" + location + "' and adminstate = 'Up'  and LifeCycleState = 'Ready'";
		  //where clause for avoiding the same primary attachment rouetr to appear on the protection attachment selection list 
		  //PR 15150
		  String whereClause2=" and v_perouter.networkelementid not in (select cr_terminationpoint.ne_id from cr_terminationpoint ,v_flowpoint ,v_accessflow where v_flowpoint.attachmentid =v_accessflow.serviceid and cr_terminationpoint.TERMINATIONPOINTID = v_flowpoint.TERMINATIONPOINTID and  v_flowpoint.attachmentid='" + original_attachmentid + "')";
					String where_clause9 = " and v_perouter.networkelementid IN (select ne.networkelementid from cr_networkelement ne , cr_network net where net.networkid = ne.networkid and net.region = '" + region + "')";
					String where_clause11 = " and (select count(*) from cr_terminationpoint where cr_terminationpoint.ne_id = v_perouter.networkelementid) <> '0'";
		  if ("protection".equals(attachment_type) && null!=original_attachmentid){
				networkElements = PERouter.findByRole(con, "PE", whereClause+whereClause2+where_clause9+where_clause11);
			  }else {
			   networkElements = PERouter.findByRole(con, "PE", whereClause+where_clause9+where_clause11); // modified by tommy for multi service
			  }
			  //End of PR 15150
			   String whereClause3 = " and (Role='AccessSwitch' or Role='AggregationSwitch')";
			   //where cluase for avoiding access networks in planned state
			   //Updated the querry to avoid mutiple row returns error , PR 14973
				String whereClause4 =" and (networkid IN ( SELECT networkid FROM V_ACCESSNETWORK WHERE V_ACCESSNETWORK.STATE='Ready')  OR   networkid IN  (SELECT networkid FROM CR_NETWORK WHERE parentnetworkid in (SELECT networkid FROM V_ACCESSNETWORK WHERE state ='Ready')))";
			  //Same upe is avoided for protection attachment
				String wherecluse5=" and V_Switch.networkelementid not in (select ne1 from CR_Link ,V_accesslink,v_accessflow where v_accesslink.Linkid=cr_Link.LinkID and   v_accessflow.SERVICEID =v_accesslink.ATTACHMENTID and  v_accessflow.SERVICEID='" + original_attachmentid + "')";
			  // Switches that are  not part of any trunks are avoided 
				String where_clause6 = " and V_Switch.networkelementid in (select distinct V_Switch.networkelementid from V_Switch"+ ",cr_networkelement,CR_Link  where V_Switch.networkelementid=cr_networkelement.networkelementid  and "+ "(CR_Link.ne1=cr_networkelement.networkelementid or CR_link.ne2=cr_networkelement.networkelementid))" ;
					String where_clause10 = " and v_switch.networkelementid IN (select ne.networkelementid from cr_networkelement ne , cr_network net where net.networkid = ne.networkid and net.region = '" + region + "')";
				if ("protection".equals(attachment_type) && null!=original_attachmentid){
				  accessSwitches =  Switch.findAll(con,whereClause+whereClause3+whereClause4+wherecluse5+ where_clause6 + where_clause10);
				}else {
					accessSwitches =  Switch.findAll(con,whereClause+whereClause3+whereClause4 + where_clause6 + where_clause10);
				}
				   String ne_id = "";
					boolean switches = false;
					// exclude from network elements those that don't have action templates
					if ((networkElements != null && networkElements.length > 0) || (accessSwitches != null && accessSwitches.length > 0)) {
						ArrayList filteredElements ;
						//AN-start
						if(accessSwitches != null && networkElements != null){
							filteredElements = new ArrayList(networkElements.length+accessSwitches.length);
							switches = true;
						}else if(networkElements != null){
							filteredElements = new ArrayList(networkElements.length);
						}else{
						filteredElements = new ArrayList(accessSwitches.length);
							switches = true;
						}
						//AN-end
						PERouter peRouter;
						ActionTemplates templates;
						for (int i = 0; networkElements != null && i < networkElements.length; i++) {
							com.hp.ov.activator.cr.inventory.NetworkElement networkElement = networkElements[i];
							if(networkElement instanceof PERouter){
								peRouter = (PERouter) networkElement;
								OSVersion OSversion=  OSVersion.findByPrimaryKey(con, peRouter.getOsversion());
													ElementType elementtype=  ElementType.findByPrimaryKey(con, peRouter.getElementtype());																							
								templates = ActionTemplates.findByElementtypeosversionroleactivationname(con,elementtype.getElementtypegroupname(), OSversion.getOsversiongroup(), "PE", "Add");
								//templates = ActionTemplates.findByElementtypeosversionroleactivationname(con, peRouter.getElementtype(), peRouter.getOsversion(), "PE", "Add");
								if(templates == null) {
									toBeDiabledElements.add(networkElement);
									//continue;
								}
							}
							filteredElements.add(networkElement);
						}
						//AN-start add switches to filteredelements
						if(switches){
							for (int i = 0; i < accessSwitches.length; i++) {
									filteredElements.add(accessSwitches[i]);
									//kk PR 18023
									if(netmask_chosen!=null && (netmask_chosen.equals("127") || netmask_chosen.equals("31"))){
										//this means CE part of activation is done, now when choosing PE we cannot allow selection of access switches
										//whose PE count is more than or equal to 2
										//get the count of the PE's attached to this switch
										int peCount=getPECount(con, accessSwitches[i].getNetworkelementid());
										if(peCount >=2){
											//if PE count is greater than or equal to 2, do not show these switches
											toBeDiabledElements.add(accessSwitches[i]);
										}
									}
									//kk
							}
						}
						//AN-end
						networkElements = new com.hp.ov.activator.cr.inventory.NetworkElement[filteredElements.size()];
						filteredElements.toArray(networkElements);
					}
					if (networkElements != null && networkElements.length > 0) {
						if (router_id != null) {
							for (int i = 0 ; i < networkElements.length; i++) {
								if (networkElements[i].getNetworkelementid().equals(router_id)) {
									ne_id = networkElements[i].getNetworkelementid();
									role = networkElements[i].getRole();
	                                vendor = networkElements[i].getVendor();
								}
							}
						}
						else {
							int index=getIndexOfNextEligibleNE(networkElements, toBeDiabledElements);
							ne_id = networkElements[index].getNetworkelementid();
	                        vendor = networkElements[0].getVendor();
							router_id = ne_id;
							//AN-start
							role = networkElements[index].getRole();
						}   
						if(role.equalsIgnoreCase("PE")){
							//AN-end
							// Test if the router has any SONET/E1 controllers
							PreparedStatement pstmt =  con.prepareStatement ("select count(*) from CR_elementcomponent where ectype='Controller' and ne_id=?");
							pstmt.setString(1, router_id);
							ResultSet rset = pstmt.executeQuery();
							hasController = rset.next() && Integer.parseInt(new String(rset.getString(1)))>0;
							pstmt.close();
							peRout = (com.hp.ov.activator.vpn.inventory.PERouter)PERouter.findByPrimaryKey(con, router_id);
							peRouterWrapper = new PERouterWrapper(peRout);
							String []ethernetInterfaces = peRouterWrapper.getInterfaces(con, "MPLS-PortVlan");
							String []serialInterfaces = peRouterWrapper.getSerialInterfaces(con, "MPLS");
							int size = ethernetInterfaces.length + serialInterfaces.length;
							interfaceNames = new String[size];
							int ai=0, bi=0, ci=0;
							// while there are elements in ethernetInterfaces
							while( ai < ethernetInterfaces.length ) {
							  interfaceNames[ci++] = ethernetInterfaces[ai++];
							}
							// while there are elements in serialInterfaces
							while( bi < serialInterfaces.length ) {
							  interfaceNames[ci++] = serialInterfaces[bi++];
							}                       
						}//AN-start if the role is AccessSwitch
						else if (role.equalsIgnoreCase("AccessSwitch") || role.equalsIgnoreCase("AggregationSwitch")){                                      
							accessSwitch = Switch.findByPrimaryKey(con, router_id);
							accessSwitchWrapper = new AccessSwitchWrapper(accessSwitch);
							interfaceNames = accessSwitchWrapper.getInterfaces(con, "MPLS-PortVlan");                       
							PEs =  accessSwitchWrapper.getConnectedPElist(con);
							//IF connected PEs are more than two VRRP can be enabled
							if(PEs !=null){
							if(PEs.size() >=2){
							if(request.getParameter("vrrpEnabled") == null){
									L3VRRP l3vrrp[] = L3VRRP.findAll(con);
										if(l3vrrp != null){                             
											vrrpEnabled = new Boolean(l3vrrp[0].getVrrp()).booleanValue();
										}
								}
								freeVRRPGroupIds = accessSwitchWrapper.getFreeVRRPGroupIDs(con);
										//by KK
										//iterate through the PE's and see if VRRP can be supported
										//VRRP can be supported in following cases
										//IPv4 all cases ie irrespective of whether thwe two PE's are cisco or juniper
										//IPv6 not supported if any one of the PE's is a cisco 
										String vendorString="";
										for (int i = 0 ; i < PEs.size(); i++) {
											PERouter Pe = (PERouter) PEs.get(i);
											vendorString += Pe.getVendor();
										}
										if("IPv6".equals(address_family) && vendorString.contains("Cisco")){
											vrrpEnabled=false;
											disableVRRP=true;											
										}
										//by KK
									if(vrrpEnabled && freeVRRPGroupIds != null){
										if(request.getParameter("vrrp_group_id") == null)
										vrrp_group_id = freeVRRPGroupIds.get(0).toString();
									}else{
										NO_VRRPGROUPIDS = "1";
									}   
							}
							}
							if(PEs != null){
								for (int i = 0 ; i < PEs.size(); i++) { 
								 PERouter Pe = (PERouter) PEs.get(i);   
								if( i ==0 && PEs.size() >=2 && request.getParameter("vrrp_master_pe_id") == null)
									vrrp_master_pe_id = accessSwitchWrapper.getMasterPE(con);
								 PEList.append(Pe.getName());
								 if(i != PEs.size()-1)
									 PEList.append(", ");
								}
								// find the termination points in PE that are connected to the selected accessswitch/AN
									ArrayList PEInterfaces =  accessSwitchWrapper.getPEInterfaceList(con);
										if( PEInterfaces!= null){
											 if(PEInterfaces.size()>1){
												ipNet_Mask = "29";
												if("IPv6".equals(address_family))
													 ipNet_Mask = "125";
												}
											/*if(PEInterfaces.size()>2){
												ret_value = NOT_SUPPORTED_NUMBER_PEIFs; 
											}*/
										}else{
											ret_value = NO_PEIFs;
										}
							}else{
								ret_value = NO_PEs;
								PEList.append("No PEs connected");
							}
						}
						//AN-end
						if (interfaceNames.length == 0)
						   ret_value = NO_INTERFACE;
						else
						{
						  String newInterfaceName = interfaceNames[0];
						  for (int i = 0; i < interfaceNames.length; i++) {
							if (interfaceNames[i].equals(interface_name)) {
							  newInterfaceName = interface_name;
							}
						  }
						  interface_name = newInterfaceName;
						}
					  } else {
						ret_value = NO_EQUIPMENT;
					}
				} else {
					ret_value = NO_DB;
				}
			} else {
				ret_value = NO_DB;
			}
			com.hp.ov.activator.cr.inventory.Interface selectedIF = com.hp.ov.activator.cr.inventory.Interface.findByNe_idname(con, router_id, interface_name)[0];
			isSharedPortAllowed = ServiceMultiplexExtension.isSharedPortAllowed(con, selectedIF.getTerminationpointid(), router_id, "L3VPN");
isSharedPortAllowed=true;
	 %>
		<p>
			<table>
	 <% AttributeDescriptor ad6 = jd.attributes[6]; %>
	<tr>
	   <td><b>Customer Name</b></td>
	   <td colspan="3">
	<%
			com.hp.ov.activator.vpn.inventory.Customer customer = null;
			if (ad6.value != null)
			  customer = com.hp.ov.activator.vpn.inventory.Customer.findByPrimaryKey(con, ad6.value); 
	%>
	<%= customer == null ? "" : customer.getCustomername() %>
	   </td>
	</tr>
	<%
		AttributeDescriptor ad8 = jd.attributes[8]; 
	%>
	<tr>
	   <td><b>VPN Name</b></td>
	   <td colspan="3">
	<%=  ad8.value == null ? "" : ad8.value %>
	   </td>
	</tr>
	<%
		AttributeDescriptor ad9 = jd.attributes[9];
	%>
	<tr>
	   <td><b>Site Name</b></td>
	   <td colspan="3">
	<%=  ad9.value == null ? "" : ad9.value %>
	   </td>
	</tr>
	<tr>
	   <td><b>Requested Rate limit</b></td>
	   <td colspan="3">
	<%=  rateLimit == null ? "" : rateLimit %>
	   </td>
	</tr>
	<tr>
	   <td><b>Router Location</b></td>
	   <td colspan="3">
	<%=  ad0.value == null ? "" : ad0.value %>
	   </td>
	</tr>
	<%      if (!ret_value.equals(NO_EQUIPMENT) && !ret_value.equals(NO_DB)) { %>
			  <form name="rsform" action="/activator/customJSP/GISVPN_ReserveResource/Select_PE_Router_And_If/add_gis_site_pe.jsp" method="POST"
			  onsubmit="comment.value=document.rsform.comment.value">
			  <input type="hidden" name="OriginalComment" value="<%= originalComment %>" id="originalComment">          
			  <tr>
				<td class="list0"><b>Select Router</b>&nbsp;&nbsp;</td><td class="list0" colspan="3">
	<%          if ((reused_router != null && !"".equals(reused_router)) && reused_ne != null && (retry_message == null || retry_message.length()==0)) { %>
					<%= reused_ne.getName() %> ( <%= reused_ne.getRole() %> )
					<input type="hidden" name="router_id" id="router_id" value="<%= reused_ne.getNetworkelementid() %>">
	<%          } else { %>
					<select name="router_id" onchange="document.getElementById('reset_pe_if').value='yes'; document.getElementById('reset_service_type').value='yes'; document.rsform.submit()">
	<%              if ( networkElements != null) {
					  for (int i = 0 ; i < networkElements.length; i++) {
						if (networkElements[i].getNetworkelementid().equals(router_id)) {
						   selected = i;  %>
	<%                     if(toBeDiabledElements.contains(networkElements[i])){ %>
						  <option disabled SELECTED value="<%= networkElements[i].getNetworkelementid() %>">
							<%= networkElements[i].getName() %> ( <%= networkElements[i].getRole() %> )
						  </option>
	<%                     } else { %>
						  <option SELECTED value="<%= networkElements[i].getNetworkelementid() %>">
							<%= networkElements[i].getName() %> ( <%= networkElements[i].getRole() %> )
						  </option>
	<%                     } %>
	<%                  } else { %>
	<%                     if(toBeDiabledElements.contains(networkElements[i])){ %>
						  <option disabled value="<%= networkElements[i].getNetworkelementid() %>">
							<%= networkElements[i].getName() %> ( <%= networkElements[i].getRole() %> )
						  </option>
	<%                  } else { %>
						  <option value="<%= networkElements[i].getNetworkelementid() %>">
							<%= networkElements[i].getName() %> ( <%= networkElements[i].getRole() %> )
						  </option>
	<%                     } %>
	<%                  }
					  }
					}  %>
				  </select>
	<%       } %>
			</td>
	<%
			  if (hasController) {
						String ci_link = "/activator/jsp/CreateChannelFrame.jsp?";
						if ((reused_router != null && !"".equals(reused_router)) && reused_ne != null && (retry_message == null || retry_message.length()==0)) {
							ci_link += "NE_ID='+form.router_id.value+";
						} else {
							 ci_link += "NE_ID='+form.router_id.options[form.router_id.selectedIndex].value+";
						}
							ci_link += "'&rateLimit=" + rateLimitBW + 
							"&location=/activator/customJSP/GISVPN_ReserveResource/Select_PE_Router_And_If/add_gis_site_pe.jsp";
	%>
				<td align="center">
				  <input type="button" value="Create Interface" onClick="var win;win=window.open('<%=ci_link%>', 'createchannelL3', 'width=700,height=500,scrollbars=yes,resizable=yes');win.focus();">
				</td>
	<%        } else {
	%>
				<td></td>
	<%
			  }
	%>
	</tr>
	<tr>
	   <td><b>Router Id</b></td>
	   <td colspan="3"><%= ((reused_router != null && !"".equals(reused_router)) && reused_ne != null) ? reused_ne.getNetworkelementid() : networkElements[selected].getNetworkelementid() %></td>
	</tr>
	<%    if (ret_value.equals(ALL_PRESENT)) { 
			ri = (com.hp.ov.activator.cr.inventory.Interface[])com.hp.ov.activator.cr.inventory.Interface.findByName(con, interface_name, "ne_id="+router_id);
	%>
			<tr>
			  <td class="list0"><b>Select Interface</b>&nbsp;&nbsp;</td><td class="list0">
	<%        if ((reused_router != null && !"".equals(reused_router)) && (reused_if != null && !"".equals(reused_router)) && ( retry_message == null || retry_message.length()==0 ) ) { %>
				<%= reused_if %>
				<input type="hidden" name="selected_pe_if" id="selected_pe_if" value="<%= reused_if %>">
	<%        } else { %>
				<select name="selected_pe_if" id="selected_pe_if" onchange="document.getElementById('reset_service_type').value='yes'; document.rsform.submit()">
	<%          if ( interfaceNames.length != 0) {
				  for (int i = 0 ; i < interfaceNames.length; i++) {    %>
				  <option <%=interface_name.equals(interfaceNames[i])?"selected ":" "%> value="<%= interfaceNames[i] %>"><%= interfaceNames[i] %></option>
	<%            }
				}  %>
				</select>
	<%         } %>
			  </td>
			</tr>
	<!-- AN- start -->
		<% if(role.equalsIgnoreCase("AccessSwitch") || role.equalsIgnoreCase("AggregationSwitch")) { %>
			<tr>
				<td><b>PEs</b></td>
				<td colspan="3"><%= PEList.toString()%></td>
			</tr>
		<%}%>
			<!-- AN- start -->
		<% if(role.equalsIgnoreCase("AccessSwitch") || role.equalsIgnoreCase("AggregationSwitch")) {
				vlan_id_type = "customer_provided"; 
			}%>
			<!-- AN- End -->
			<tr>
			  <td class="list0"><b>Select Encapsulation</b>&nbsp;&nbsp;</td><td class="list0">
	<%      if (reused_router != null && !"".equals(reused_router)) { 
				service_type = "MPLS-PortVlan";
				if ("MPLS-PortVlan".equals(service_type) && vlan_id_type.equals("customer_provided")) {
				  try {  if(role.equalsIgnoreCase("AccessSwitch") || role.equalsIgnoreCase("AggregationSwitch")) {
							freeVlanIds = accessSwitchWrapper.getFreeVlanIds(con,"Attachment");
						}else{
							freeVlanIds = peRouterWrapper.getFreeVlanIds(con, interface_name, "Attachment");
						}				
						if(freeVlanIds.length ==0) {
							ret_value = NO_VLANS;
						}
				  } 
				  catch (Exception e) {
					System.out.println("Exception in Interface selection: " + e.getMessage());
					exceptionFlag = true;
					service_type ="Port";	 
				  }
				}
	%>
				Ethernet-dot1Q
				<input type="hidden" name="service_type" id="service_type" value="MPLS-PortVlan">
	<%      } else { %>
			  <select name="service_type" id="service_type" onchange="document.rsform.submit()">
	<%     
			if ("Ethernet".equals(ri[0].getType())) {
			  if ("Ready".equals(ri[0].getActivationstate()) && "Available".equals(ri[0].getUsagestate()) && (role.equalsIgnoreCase("AccessSwitch") || role.equalsIgnoreCase("AggregationSwitch"))) 
				  { %>        
				  <option <%=service_type.equals("Port")?" SELECTED":""%> value="Port">none</option>
	<%        } else if ("Ready".equals(ri[0].getActivationstate()) &&                                      "Available".equals(ri[0].getUsagestate()) &&                                    role.equalsIgnoreCase("PE")) { %>
					<option <%=service_type.equals("Port")?" SELECTED":""%> value="Port">none</option>        
		<%    }
				else {
				service_type = "MPLS-PortVlan";
			  }
			  if ("MPLS-PortVlan".equals(service_type) && vlan_id_type.equals("customer_provided")) {
				try {  if(role.equalsIgnoreCase("AccessSwitch") || role.equalsIgnoreCase("AggregationSwitch")) {
							freeVlanIds = accessSwitchWrapper.getFreeVlanIds(con,"Attachment");
						//  System.out.println("Free vlans" + freeVlanIds.length);
						}else{
							freeVlanIds = peRouterWrapper.getFreeVlanIds(con, interface_name, "Attachment");
						}
				} 
				catch (Exception e) {
				  System.out.println("Exception in Interface selection: " + e.getMessage()); 
				  exceptionFlag = true;
				  service_type ="Port";
				  if("Ready".equals(ri[0].getActivationstate()) && "SubIfPresent".equals(ri[0].getUsagestate())) {%>
					<option  value="Port">none</option>
			<%    }
				}
			  }
	%>
				  <option <%=service_type.equals("MPLS-PortVlan")?" SELECTED":""%> value="MPLS-PortVlan">Ethernet-dot1Q</option>
	<%      } else %>
	<%      if ("Serial".equals(ri[0].getType())) {
			  if ("Ready".equals(ri[0].getActivationstate()) && "Available".equals(ri[0].getUsagestate())) { %>
	<%          if ( !("FrameRelay".equals(ri[0].getSubtype()) || "PPP".equals(ri[0].getSubtype())) ) { %>
				  <option <%=service_type.equals("HDLC")?" SELECTED":""%> value="HDLC">HDLC</option>
	<%          } %>
	<%          if ( !("FrameRelay".equals(ri[0].getSubtype()) || "HDLC".equals(ri[0].getSubtype())) ) { %>
				  <option <%=service_type.equals("PPP")?" SELECTED":""%> value="PPP">PPP</option>
	<%          }
				if ( "FrameRelay".equals(ri[0].getSubtype())) {
				  service_type = "FrameRelay";
				}
			  } else
			  {
				service_type = "FrameRelay"; 
			  }
				if ( "FrameRelay".equals(service_type) && vlan_id_type.equals("customer_provided")) { 
				  try {
					freeDLCIs = peRouterWrapper.getFreeDLCIs(con, interface_name, "MPLS","Attachment");
				  } 
				  catch (Exception e) {
					System.out.println("Exception in Interface selection: " + e.getMessage());
					exceptionFlag = true;
					service_type ="Port";	  
				  }
				}
				if ( !("HDLC".equals(ri[0].getSubtype()) || "PPP".equals(ri[0].getSubtype())) ) { %>
	%>
				  <option <%=service_type.equals("FrameRelay")?" SELECTED":""%> value="FrameRelay">FrameRelay</option>
	<%          }
			  } %>
			  </select>
	<%      } %>
			  </td>
			</tr>
	<%    
	 if (service_type.equals("MPLS-PortVlan") || service_type.equals("FrameRelay")) { %>
			  <tr>
				<td class="list0"><b><%= service_type.equals("MPLS-PortVlan")?"VLAN ID selection":"DLCI selection"%></b>&nbsp;&nbsp;</td><td class="list0">
				<% if(role.equalsIgnoreCase("AccessSwitch") || role.equalsIgnoreCase("AggregationSwitch")) {    %>  
					<select name="vlan_id_type" id="vlan_id_type" onchange="document.rsform.submit()">          
						<option value="customer_provided" <%=vlan_id_type.equals("customer_provided")?" SELECTED":""%>>Customer Provided</option>
					</select>
				<% }else { %>
					<select name="vlan_id_type" id="vlan_id_type" onchange="document.rsform.submit()">          
						<option value="provider_managed" <%=vlan_id_type.equals("provider_managed")?" SELECTED":""%>>Provider Managed</option>
						<option value="customer_provided" <%=vlan_id_type.equals("customer_provided")?" SELECTED":""%>>Customer Provided</option>
					</select>
				<% }%>
				</td>
			  </tr>
			  <% if(freeVlanIds != null ) { %>
	<%        if (service_type.equals("MPLS-PortVlan") && vlan_id_type.equals("customer_provided") && freeVlanIds.length != 0 ) { %>
			  <tr>
				<td class="list0"><b>VLAN ID</b>&nbsp;&nbsp;</td><td class="list0">
				  <select name="vlan_id">
	<%              boolean wasSelected = false;
					String isSelected = "";              
					boolean freevlans = false;
					for (int i = 0; i < freeVlanIds.length; i++) {					
					  if ( freeVlanIds[i] == 0 ) continue;
					  freevlans = true;
					  if ( wasSelected == true && isSelected.equals(" selected") ) {
						isSelected = "";
					  }
					  if ( wasSelected == false && isSelected.equals("") && freeVlanIds[i] >= 3001 ) {
						isSelected = " selected"; 
						wasSelected = true;
					  }  %>
					<option <%= isSelected%> id="vlan_<%= freeVlanIds[i] %>" value="<%= freeVlanIds[i] %>"><%= freeVlanIds[i] %></option>
	<%              } 
					   if(!freevlans) {				
							ret_value = NO_VLANS;
						}
					  %>
		 </select>
				</td>
			  </tr>
	<%        }
			}   
	 }
			%>
	<%      if (service_type.equals("FrameRelay")) { 
			  if (vlan_id_type.equals("customer_provided")) { %>
			  <tr>
				<td class="list0"><b>DLCI</b>&nbsp;&nbsp;</td><td class="list0">
				  <select name="dlci_value">
	<%              for (int i = 0; i < freeDLCIs.length; i++) {
					  if ( freeDLCIs[i] == 0 ) continue; %>
					<option id="dlci_<%= freeDLCIs[i] %>" value="<%= freeDLCIs[i] %>"><%= freeDLCIs[i] %></option>
	<%              } %>
				  </select>
				</td>
			  </tr>
	<%        } %>
			  <tr>
				<td class="list0"><b>Select LMI type</b>&nbsp;&nbsp;</td><td class="list0">
				  <select name="lmi_type">
	<%        if ("Available".equals(ri[0].getUsagestate()) || ri[0].getLmitype()==null ) {
				if ( peRouterWrapper.isCisco(con)) { %>
					<option <%=lmi_type.equals("cisco")?" SELECTED":""%>>cisco</option>
	<%          } %>
					<option <%=lmi_type.equals("ansi")?" SELECTED":""%>>ansi</option>
					<option <%=lmi_type.equals("q933a")?" SELECTED":""%>>q933a</option>
	<%        } else { %>
					<option><%= ri[0].getLmitype() %></option>      
	<%        } %>
				  </select>
				</td>
			  </tr>
			  <tr>
				<td class="list0"><b>Select INTF type</b>&nbsp;&nbsp;</td><td class="list0">
				  <select name="intf_type">
	<%        if ("Available".equals(ri[0].getUsagestate()) || ri[0].getIntftype()==null ) { %>
					<option <%=intf_type.equals("dce")?" SELECTED":""%>>dce</option>
					<option <%=intf_type.equals("dte")?" SELECTED":""%>>dte</option>
	<%        } else { %>
					<option><%= ri[0].getIntftype() %></option>      
	<%        } %>
				  </select>
				</td>
			  </tr>
	<%      } %>
	<tr>
	<td><b>AddressPool</b></td>
	<td>
	 <select name="pool_name" onchange="document.rsform.submit()">
   <%    if (pools != null) {		  
          for (int i=0;i< pools.length; i++) {
		  if(poolname!=null && poolname.equals(pools[i].getName()))
		  {
         	%>
         	<option value ="<%=pools[i].getName()%>" selected><%=pools[i].getName()%></option>
         <%}else {%>
		 <option value ="<%=pools[i].getName()%>"><%=pools[i].getName()%></option>
         <%  }
		 }
        }
  %>
        </select>
		</td>
	</tr>
	<tr>
	   <td><b>WAN IP</b></td>
	   <td>
	   <select name="IPNetAddr" id ="IPNetAddr">
	   <%
		
	    for(int i=0;i<ipnetAll.length;i++)
		{ 
			if(ipnetaddr!=null && ipnetaddr.equals(ipnetAll[i].getIpnetaddr())) {
	    %>
		<option value="<%=ipnetAll[i].getIpnetaddr()%>" selected><%=ipnetAll[i].getIpnetaddr()%>	  
	    <%
		 }else{
		%>
		<option value="<%=ipnetAll[i].getIpnetaddr()%>"><%=ipnetAll[i].getIpnetaddr()%></option>
		<% }}%>		
		 </select>
	   </td>
	</tr>	
		<tr>
	   <td><b>Type of protocol</b></td>
	   <td><%=routingprotocol%>
	  </td>
	</tr>
	<%      if ("BGP".equals(routingprotocol) ) { %>
	
	<tr>
	   <td><b>Max number of prefix limit</b></td>
	   <td>
		 <input type="input" name="maximum_prefix" id="maximum_prefix" value="<%=maximumPrefix %>" size="7">
	   </td>
	</tr>
	<%      } %>
	<%      if ("BGP".equals(routingprotocol) && Arrays.asList(BGPCredentialsVendors).contains(vendor)) { %>
	<tr>
	   <td><b>Username</b></td>
	   <td>
		 <input type="input" name="BGPUsername" id="BGPUsername" value="<%=BGPUsername %>" size="30">
	   </td>
	</tr>
	<tr>  
	   <td><b>Password</b></td>
	   <td>
		 <input type="password" name="BGPPassword" id="BGPPassword" value="<%=BGPPassword %>" size="30">
	   </td>
	</tr>
	<%      } %>
	<%      if ("BGP".equals(routingprotocol) && Arrays.asList(BGPMultiHopVendors).contains(vendor)) { %>
	<tr>
		<td><b>Multi-Hop</b></td>
		<td>
			<input TYPE="checkbox" id="BGPMultiHopCheck" name="BGPMultiHopCheck" VALUE="true" <%= (BGPMultiHopCheck) ? " CHECKED":" " %> onClick="document.getElementById('BGPMultiHopCheck').value=form.BGPMultiHopCheck.checked;document.rsform.submit()">
			<%      if (BGPMultiHopCheck) { %>
				<input type="input" name="BGPMultiHop" id="BGPMultiHop" value="<%=BGPMultiHop %>" size="30">
			<%      } %>
		</td>
	</tr>
	<%      } %>
	<!-- start vrrp -->
		<% if(PEs != null && PEs.size()>=2){ %>
		<tr>
				<td><b>VRRP</b></td>
		<%		if(!disableVRRP){%>
				<td><input TYPE="checkbox" id="vrrpEnabled" name="vrrpEnabled" VALUE="true" <%= (vrrpEnabled) ? " CHECKED":" " %> onClick="document.getElementById('vrrpEnabled').value=form.vrrpEnabled.checked;document.rsform.submit()"></td>
        <%		} else {%>
				<td><input disabled TYPE="checkbox" id="vrrpEnabled" name="vrrpEnabled" VALUE="true" <%= (vrrpEnabled) ? " CHECKED":" " %> onClick="document.getElementById('vrrpEnabled').value=form.vrrpEnabled.checked;document.rsform.submit()"></td>
        <%		} %>
				<input type="hidden" name="vrrpEnabled" id="vrrpEnabled" value="false" >				
		</tr>
		<% if (vrrpEnabled && NO_VRRPGROUPIDS.equals("0")) { %>
		<tr>
				   <td class="list0"><b>Master</b>&nbsp;&nbsp;</td><td class="list0" colspan="3">
				<select name="vrrp_master_pe_id" id="vrrp_master_pe_id" onchange="document.rsform.submit()">
	<%          if ( PEs != null) {
				  for (int i = 0 ; i < PEs.size(); i++) {
					if(vrrp_master_pe_id.equals(((PERouter)PEs.get(i)).getNetworkelementid())){
					   selected = i;  %>
					 <option SELECTED value="<%= ((PERouter)PEs.get(i)).getNetworkelementid() %>">
						<%= ((PERouter)PEs.get(i)).getName() %> </option>
	<%              } else { %>
					  <option value="<%= ((PERouter)PEs.get(i)).getNetworkelementid() %>">
						<%= ((PERouter)PEs.get(i)).getName() %> </option>
	<%              }
				  }
				}  %>
			  </select>
			</td>
	</tr>
	<tr>
				   <td class="list0"><b>VRRP Group ID</b>&nbsp;&nbsp;</td><td class="list0" colspan="3">
				<select name="vrrp_group_id" id="vrrp_group_id" onchange="document.rsform.submit()">
	<%          if ( freeVRRPGroupIds != null) {
				  for (int i = 0 ; i < freeVRRPGroupIds.size(); i++) {
					if(vrrp_group_id.equals(freeVRRPGroupIds.get(i).toString())){
					   selected = i;  %>
					 <option SELECTED value="<%= freeVRRPGroupIds.get(i).toString() %>">
						<%= freeVRRPGroupIds.get(i).toString() %> </option>
	<%              } else { %>
					  <option value="<%= freeVRRPGroupIds.get(i).toString() %>">
						<%= freeVRRPGroupIds.get(i).toString() %> </option>
	<%              }
				  }
				}  %>
			  </select>
			</td>
	</tr>
		<% }%>
		<%}%>
	<!-- end vrrp -->
	<% if (nnmEnabled) {
		 com.hp.ov.activator.cr.inventory.NetworkElement ne = com.hp.ov.activator.cr.inventory.NetworkElement.findByPrimaryKey(con, router_id);
		%>
		<tr>
			   <td class="list0"><b>Topology view</b>&nbsp;&nbsp;</td><td class="list0" colspan="3">
			   <select name="rsi_id" id="rsi_id">
			  <% if (nnmEnabled) {
				session.setAttribute(NNMiAbstractCrossLaunchAction.DATASOURCE_NNMI_CL, ds);
				session.setAttribute(NNMiAbstractCrossLaunchAction.NNMI_IP, ne.getManagement_ip());
				session.setAttribute(NNMiAbstractCrossLaunchAction.NNMI_NAME, ne.getName());
			%>
				   <option SELECTED value="nnm_l3neighbor_view">NNM L3 Neighbor View</option>
				   <option value="nnm_l2neighbor_view">NNM L2 Neighbor View</option>
	<% } %>
			  </select>
			</td>
			<td>
			<INPUT TYPE="Button" value= " Launch Views" name="RSI_Operation" onClick="launchRsiView()";">
	</td>
	</tr>
	<%  } %>
	<!-- end -->
	<% AttributeDescriptor ad5 = jd.attributes[5]; %>
	<tr>
	   <td><b>Contact Person</b></td>
	   <td colspan="3">
	<%= ad5.value == null ? "" : ad5.value %>
	   </td>
	</tr>
	<%      } %>
	<tr>
	   <td><b>Comment</b></td>
	   <td colspan="4">
		<textarea cols="30" rows="4" name="comment" id="comment"><%=comment%></textarea>
	   </td>
	</tr>
		<%    } 
		if(exceptionFlag)
			{
		%>
		<tr>
		<td colspan="2"><b>External Vlan IDs/DLCIs for the router:<%= ((reused_router != null && !"".equals(reused_router)) && reused_ne != null) ? reused_ne.getName() : networkElements[selected].getName() %> are exhausted or not configured.</b></td>
		</tr>
		<%}%>
	<tr>
	<%    if (ret_value.equals(NO_INTERFACE)) { %>
			<td colspan="4"><b>No interfaces available on the specified router: </b></td>
			   <td><%= networkElements[selected].getName() %> (<%= networkElements[selected].getNetworkelementid() %>)</td>
	<%    } %>
	<%    if (ret_value.equals(NO_PEs)) { %>
			<td colspan="4"><b>No PEs connected to specified switch: </b></td>
			   <td><%= networkElements[selected].getName() %> (<%= networkElements[selected].getNetworkelementid() %>)</td>
	<%    } %>
	<%    if (ret_value.equals(NO_PEIFs)) { %>
			<td colspan="4"><b>Could not find the terminationpoints on PEs connected to specified switch: </b></td>
			   <td><%= networkElements[selected].getName() %> (<%= networkElements[selected].getNetworkelementid() %>)</td>
	<%    } %>
	<%    if (ret_value.equals(NOT_SUPPORTED_NUMBER_PEIFs)) { %>
		  <td colspan="4"><b>There are more than two Trunks connecting the Accessnetwork to the Provider Network.</b> </td>
	<%    } %>
	<%    if (ret_value.equals(NO_VLANS)) { %>
			<td colspan="4"><b>No vlans available on the specified router: </b></td>
			   <td><%= networkElements[selected].getName() %> (<%= networkElements[selected].getNetworkelementid() %>)</td>
	<%    } %>
	<%    if (vrrpEnabled && NO_VRRPGROUPIDS.equals("1")) { %>
		  <td colspan="4"><b>There are no VRRP group Ids available for VRRP functionality.</b> </td>
	<%   vrrpEnabled = false; } %>
	</tr>
		<input type="hidden" name="reset_pe_if" id="reset_pe_if" value="" >
		<input type="hidden" name="reset_service_type" id="reset_service_type" value="" >
	<%
			if ( retry_message != null && !retry_message.equals("") ) { %>
			<tr>
			   <td colspan="2"><b><%=retry_message%></b></td>
			</tr>
	<%      } %>
	  </form>
	<%      if (ret_value.equals(ALL_PRESENT) && isSharedPortAllowed==true) { %>
		  <%-- Concrete job information: attributes --%>
		  <form name="form" action="/activator/sendCasePacket" method="POST"
			onsubmit="router_id.value=document.rsform.router_id.value;
			selected_pe_if.value=document.rsform.selected_pe_if.value;
			service_type.value=document.rsform.service_type.value;      
			IPNetAddr.value=document.rsform.IPNetAddr.value;
			pool_name.value=document.rsform.pool_name.value;
			//routing_protocol.value=document.rsform.routing_protocol.value;
	<%      if (service_type.equals("MPLS-PortVlan")) { %> 			  vlan_id_type.value=document.rsform.vlan_id_type.options[document.rsform.vlan_id_type.selectedIndex].value;
	<%        if (vlan_id_type.equals("customer_provided")) { %>
				vlan_id.value=document.rsform.vlan_id.options[document.rsform.vlan_id.selectedIndex].text;
	<%        } else { %>
				vlan_id.value='0';
	<%        } %>
	<%      } %>
	<%      if (service_type.equals("FrameRelay")) { %>
			  vlan_id_type.value=document.rsform.vlan_id_type.options[document.rsform.vlan_id_type.selectedIndex].value;
	<%        if (vlan_id_type.equals("customer_provided")) { %>
				dlci_value.value=document.rsform.dlci_value.options[document.rsform.dlci_value.selectedIndex].text;
	<%        } else { %>
				dlci_value.value='0';
	<%        } %>
			  lmi_type.value=document.rsform.lmi_type.options[document.rsform.lmi_type.selectedIndex].text;
			  intf_type.value=document.rsform.intf_type.options[document.rsform.intf_type.selectedIndex].text;
	<%      } %>
	
	
	<%		if ("BGP".equals(routingprotocol)) { %>
	<%			if (Arrays.asList(BGPCredentialsVendors).contains(vendor)) { %>
					BGPUsername.value=document.rsform.BGPUsername.value;
					BGPPassword.value=document.rsform.BGPPassword.value;
	<%			} %>
	<%			if (Arrays.asList(BGPMultiHopVendors).contains(vendor)) { %>
					BGPMultiHopCheck.value=document.rsform.BGPMultiHopCheck.value;
	<%			} %>		
	<%      	if (BGPMultiHopCheck) { %>
					BGPMultiHop.value=document.rsform.BGPMultiHop.value;
					if (checkNumValue(BGPMultiHop) == false) {
						document.rsform.BGPMultiHop.focus();
						document.rsform.BGPMultiHop.select();
						return false;
					}
	<%      	} %>
	<%      } %>
	<%      if ("BGP".equals(routingprotocol)) { %>
				Asn.value=document.rsform.Asn.value;
				if(document.rsform.Asn.value=='')
				{
				  alert('Customer ASN must be a number from 1 to 65535');
				  return false;
				}
			  maximum_prefix.value=document.rsform.maximum_prefix.value;
			  if ( checkNumValue(maximum_prefix) == false ) {
				document.rsform.maximum_prefix.focus();
				document.rsform.maximum_prefix.select();
				return false;
			  }
			  if ( maximum_prefix.value > 1000 ) {
				alert('Maximum number of prefix limit is more then 1000. The value has to be approved by Admin/Manager.');
			  }
	<%      } else { %>
			  maximum_prefix.value = '0';
	<%      } 
	//Start -AN
			if(role.equalsIgnoreCase("AccessSwitch") || role.equalsIgnoreCase("AggregationSwitch")){
			%>
			service_type.value = 'MPLS-PortVlan';
			if ( document.rsform.service_type.value=='Port' )
				   upe_port_mode.value = 'Access';
			else
				   upe_port_mode.value = 'Trunk';
			<%} //End-AN  %>
			comment.value=document.rsform.comment.value">
			<input type="hidden" name="id" value="<%= jd.jobId %>">
			<input type="hidden" name="workflow" value="<%=jd.name %>">
			<input type="hidden" name="queue" value="add_gis_site_pe">
			<input type="hidden" name="router_id" value="">
			<input type="hidden" name="selected_pe_if" value="">
			<input type="hidden" name="pool_name" value="">
			<input type="hidden" name="IPNetAddr" value="">		
			<input type="hidden" name="maximum_prefix" value="<%= maximumPrefix %>">
			<input type="hidden" name="BGPUsername" value="<%= BGPUsername %>">
			<input type="hidden" name="BGPPassword" value="<%= BGPPassword %>">
			<input type="hidden" name="BGPMultiHop" value="<%= BGPMultiHop %>">
			<input type="hidden" name="BGPMultiHopCheck" value="<%= BGPMultiHopCheck %>">
			<input type="hidden" name="RET_VALUE" value="<%= ret_value %>">
			<input type="hidden" name="operator_name" value="<%= session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) %>">
			<input type="hidden" name="comment" value="<%= comment %>">
			<input type="hidden" name="clientip" value="<%= ip %>">     
			<input type="hidden" name="service_type" value="<%= service_type %>">   
			<input type="hidden" name="vlan_id_type" value="<%= vlan_id_type %>">
			<input type="hidden" name="vlan_id" value="<%= vlan_id %>">
			<input type="hidden" name="dlci_value" value="<%= dlci_value %>">
			<input type="hidden" name="lmi_type" value="<%= lmi_type %>">
			<input type="hidden" name="intf_type" value="<%= intf_type %>">
			<input type="hidden" name="ipnet_mask" value="<%= ipNet_Mask %>">
			<input type="hidden" name="upe_port_mode" value="<%=upe_port_mode%>">
			<input type="hidden" name="vrrp" value="<%=vrrpEnabled%>">
			<input type="hidden" name="vrrp_master_pe_id" value="<%=vrrp_master_pe_id%>">
			<input type="hidden" name="vrrp_group_id" value="<%=vrrp_group_id%>">
	<%--        <input type="hidden" name="OriginalComment" value="<%= originalComment %>" id="originalComment">--%>
			<%-- Common trailer --%>
			<tr>
			  <td colspan="2">&nbsp;</td>
			</tr>
			<tr>
			  <td align="center" colspan="3">
				<input type="submit" value="Submit" >
				<input type="reset"  value="Clear" onclick="setOriginalComment();document.getElementById('maximum_prefix').value=''">
			  </td>
			</tr>
		  </form>
	<%    }
		  else if (ret_value.equals(ALL_PRESENT) && isSharedPortAllowed!=true) { %>
		  <form name="form" action="/activator/sendCasePacket" method="POST">
			  <input type="hidden" name="id" value="<%= jd.jobId %>">
			  <input type="hidden" name="workflow" value="<%= jd.name %>">
			  <input type="hidden" name="queue" value="add_gis_site_pe">
			  <input type="hidden" name="router_id" value="-">
			  <input type="hidden" name="selected_pe_if" value="-">
			  <input type="hidden" name="pool_name" value="">
				<input type="hidden" name="IPNetAddr" value="">
				
			  <input type="hidden" name="maximum_prefix" value="<%= maximumPrefix %>">
			  <input type="hidden" name="BGPUsername" value="<%= BGPUsername %>">
			  <input type="hidden" name="BGPPassword" value="<%= BGPPassword %>">
			  <input type="hidden" name="BGPMultiHop" value="<%= BGPMultiHop %>">
			  <input type="hidden" name="BGPMultiHopCheck" value="<%= BGPMultiHopCheck %>">
			  <input type="hidden" name="RET_VALUE" value="<%= NO_EQUIPMENT %>">
			  <input type="hidden" name="operator_name" value="<%= session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) %>">
			  <input type="hidden" name="comment" value="<%= comment %>">
			  <input type="hidden" name="clientip" value="<%= ip %>">
			  <input type="hidden" name="service_type" value="-">
			  <input type="hidden" name="vlan_id_type" value="-">
			  <input type="hidden" name="vlan_id" value="0">
			  <input type="hidden" name="dlci_value" value="0">
			  <input type="hidden" name="lmi_type" value="-">
			  <input type="hidden" name="intf_type" value="-">
			  <input type="hidden" name="ipnet_mask" value="<%= ipNet_Mask %>">
			  <input type="hidden" name="upe_port_mode" value="<%=upe_port_mode%>">
			  <input type="hidden" name="vrrp" value="<%=vrrpEnabled%>">
			  <input type="hidden" name="vrrp_master_pe_id" value="<%=vrrp_master_pe_id%>">
			  <input type="hidden" name="vrrp_group_id" value="<%=vrrp_group_id%>">
			  <tr>
				<% if (isSharedPortAllowed != true) { %>
				<td colspan="4"><b>The selected interface is already in use with not compatible services.</b></td>
	<%      } %>
		  </tr>
		  <tr>
			<td colspan="2">&nbsp;</td>
		  </tr>
		  <tr>
			<td align="center" colspan="3">
			  <input type="submit" value="Cancel">
			</td>
		  </tr>
	<% }
		  else if (!ret_value.equals(ALL_PRESENT) && !ret_value.equals(NO_DB)) { %>
			<form name="form" action="/activator/sendCasePacket" method="POST">
			  <input type="hidden" name="id" value="<%= jd.jobId %>">
			  <input type="hidden" name="workflow" value="<%= jd.name %>">
			  <input type="hidden" name="queue" value="add_gis_site_pe">
			  <input type="hidden" name="router_id" value="-">
			  <input type="hidden" name="selected_pe_if" value="-">
			  <input type="hidden" name="pool_name" value="">
				<input type="hidden" name="IPNetAddr" value="">
							  
			  <input type="hidden" name="maximum_prefix" value="<%= maximumPrefix %>">
			  <input type="hidden" name="BGPUsername" value="<%= BGPUsername %>">
			  <input type="hidden" name="BGPPassword" value="<%= BGPPassword %>">
			  <input type="hidden" name="BGPMultiHop" value="<%= BGPMultiHop %>">
			  <input type="hidden" name="BGPMultiHopCheck" value="<%= BGPMultiHopCheck %>">
			  <input type="hidden" name="RET_VALUE" value="<%= NO_EQUIPMENT %>">
			  <input type="hidden" name="operator_name" value="<%= session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) %>">
			  <input type="hidden" name="comment" value="<%= comment %>">
			  <input type="hidden" name="clientip" value="<%= ip %>">
			  <input type="hidden" name="service_type" value="-">
			  <input type="hidden" name="vlan_id_type" value="-">
			  <input type="hidden" name="vlan_id" value="0">
			  <input type="hidden" name="dlci_value" value="0">
			  <input type="hidden" name="lmi_type" value="-">
			  <input type="hidden" name="intf_type" value="-">
			  <input type="hidden" name="ipnet_mask" value="<%= ipNet_Mask %>">
			  <input type="hidden" name="upe_port_mode" value="<%=upe_port_mode%>">
			  <input type="hidden" name="vrrp" value="<%=vrrpEnabled%>">
			  <input type="hidden" name="vrrp_master_pe_id" value="<%=vrrp_master_pe_id%>">
			  <input type="hidden" name="vrrp_group_id" value="<%=vrrp_group_id%>">
			  <tr>
				<% if (ret_value.equals(NO_EQUIPMENT)) { %>
				<td colspan="4"><b>No routers available at the specified location: </b></td>
				<td><%= ad0.value == null ? "" : ad0.value %></td>
	<%      } %>
		  </tr>
		  <tr>
			<td colspan="2">&nbsp;</td>
		  </tr>
		  <tr>
			<td align="center" colspan="3">
			  <input type="submit" value="Cancel">
			</td>
		  </tr>
	<% }
		   if (ret_value.equals(NO_DB)) { %>
			 <tr>
			   <td><b>No Database Connection avaiable, close window to cancel</b></td>
			 </tr>
		<% }
		} catch (Exception e) {
			System.out.println("Exception in Router selection: " + e.getMessage());
							e.printStackTrace ();
							%>
						 <tr>
						   <td><b>Exception in Router selection: <%=e.getMessage()%></b></td>
						 </tr>
	   <%   
		} finally{
			try{
			  con.close();
			}catch(Exception ex){
			   System.out.println("Exception during the closing connection in add_gis_site_pe.jsp : " + ex.getMessage());
			}
		}
	%>
	</table>
	  </form>
	</center>
	<script type="text/javascript" src="/activator/javascript/CRModel/utils.js"></script>
	<script language="JavaScript">    
		function setOriginalComment() {
		  document.getElementById('comment').value = document.getElementById('originalComment').value;
		}
	
		
		function checkNumValue(input){
		   var str = input.value;
		   var inputName = input.name;
		   var numval = input.value;
		   var newStr = "";
		   for(i = 0; i < str.length; i++){
			   if(str.charAt(i) >= '0' && str.charAt(i) <= '9'){
				   newStr = newStr + str.charAt(i);
			   }
		   }
		   if(str != newStr || newStr.length == 0) {
			   alert(inputName + ' must have a numeric value');
			   input.value = newStr;
			   return false;
		   }
		   if ( numval < 1 || numval > 4294967295 ) {
			   alert(inputName + ' value must be in range 1-4294967295');
			   return false;
		   }
		   return true;
		}
	function launchRsiView() {
		var rsi_link;
		var win;
		var uuid = "<%= session.getAttribute(NNMiAbstractCrossLaunchAction.NNMI_UUID) %>";
		var ip = "<%= session.getAttribute(NNMiAbstractCrossLaunchAction.NNMI_IP) %>";
		var name = "<%= session.getAttribute(NNMiAbstractCrossLaunchAction.NNMI_NAME) %>";
		var identification_method;
		if (uuid != "null" && uuid != "") identification_method = "nnmi_uuid="+uuid;
		else if (ip != "null" && ip != "") identification_method = "nnmi_ip="+ip;
		else identification_method = "nnmi_name="+name;
		if(document.rsform.rsi_id.value=='nnm_l2neighbor_view'){
			rsi_link='/activator/inventory/CRModel/NNMiShowL2ConnectionAction.do?' + identification_method;
		}
		if(document.rsform.rsi_id.value=='nnm_l3neighbor_view')
			rsi_link='/activator/inventory/CRModel/NNMiShowL3ConnectionAction.do?' + identification_method
		win=window.open(rsi_link);
		win.focus();
		if(isIE7())
		win.setTimeout("self.close()", 3000); 
	}
	  </script>
	</body>
	</html>
