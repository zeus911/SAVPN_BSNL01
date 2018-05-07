 <!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

 ------------------------------------------------------------------------->
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>               
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/L2VPN_ReserveResource/Select_router_and_port/add_l2_site.jsp,v $                                                                   --%>
<%-- $Revision: 1.35 $                                                                 --%>
<%-- $Date: 2010-11-15 07:40:13 $                                                                     --%>
  <%-- $Author: tanye $                                                                   --%>
<%--                                                                              --%>
 <%--##############################################################################--%>
 <%--#                                                                             --%>
 <%--# Description                                                                 --%>
 <%--#                                                                             --%>
 <%--##############################################################################--%>

 <%-- Queue: 'add_l2_site' --%>
 <%@ page contentType="text/html; charset=UTF-8"
 import="com.hp.ov.activator.mwfm.*, com.hp.ov.activator.cr.inventory.*, com.hp.ov.activator.vpn.inventory.*, com.hp.ov.activator.mwfm.servlet.*, java.sql.*, javax.sql.DataSource, java.util.*, java.io.*, com.hp.ov.activator.cr.struts.nnm.cl.NNMiAbstractCrossLaunchAction, com.hp.ov.activator.cr.struts.na.cl.NAAbstractCrossLaunchAction, com.hp.ov.activator.nnm.common.*" %>

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
     window.resizeTo(800,600);


	function checkMASN()
	{
						
		if((document.form.multiASNFlag.value == true)||(document.form.multiASNFlag.value == "true"))
		{
		var r=confirm("There is already existing site services in other ASNs. If you continue you will not obtain connectivity to these. Are you sure you want to continue?");
					if((r==false)||(r=="false"))
					{
								
						document.form.RET_VALUE.value="3";
						document.form.router_id.value="-";
						document.form.selected_pe_if.value="-";
						return r;
					}
					else
						return r;
			
			}
	}

   </script>
 </head>


 <body onUnLoad="opener.window.top.interactWindow=null">
 <h3><img src="/activator/images/HPLogo.png" valign="top" align="right">Interact with job: L2VPN_AddSite</h3>
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

	<%!
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

 <%  String ip = request.getRemoteAddr();
	 // For MultiASN Check
     boolean multiASNFlag = false;

	 // For sharing port checkings
	 boolean isSharedPortAllowed = true;
	
     AttributeDescriptor ad0 = jd.attributes[0];
     String ALL_PRESENT  = "0";
     String NO_EQUIPMENT = "1";
     String NO_INTERFACE = "2";
     String RATELIMIT_INTERFACE = "5";
     String NO_DB = "3";
     String NO_PEs = "4";
     
     com.hp.ov.activator.cr.inventory.NetworkElement[] networkElements = null;
	 ArrayList toBeDiabledElements =new ArrayList();
    //For NNM Cross Launch
	com.hp.ov.activator.nnm.common.NNMiConfiguration nnmconf = null;
     com.hp.ov.activator.vpn.inventory.VlanRange vlanR =null;
     
         //AccessNetwork-start
         Switch[] accessSwitches = null;
     Switch accessSwitch = null;
     AccessSwitchWrapper accessSwitchWrapper = null;
         String role = "";
         StringBuffer PEList = new StringBuffer();
         //AccessNetwork-end
         
     String selected_pe_router_val = request.getParameter("router_id");
	 String interface_name = "";

	 if (request.getParameter("selected_pe_if")!=null) {
		interface_name=request.getParameter("selected_pe_if");
		//System.out.println("selected_pe_if value: " + interface_name);
	 }

	 AttributeDescriptor ad17 = jd.attributes[17]; 
     String fixedL2VPN = ad17.value;

     AttributeDescriptor ad8 = jd.attributes[8]; 
     String interface_type = ad8.value;

     AttributeDescriptor ad9 = jd.attributes[9]; 
     String vlan_ids = ad9.value;

     AttributeDescriptor ad10 = jd.attributes[10];
     String qosProfile = ad10.value;

     AttributeDescriptor ad13 = jd.attributes[13];
     String vpn_id = ad13.value;

     AttributeDescriptor ad15 = jd.attributes[15];
     String retry_message = ad15.value;

     AttributeDescriptor ad4 = jd.attributes[4];
     String comment = request.getParameter ("comment");
     comment = comment != null ? comment : (ad4.value == null ? "" : ad4.value);

     // If this value >= 2Mbps then allow to use entire fast ethernet interface
     boolean allowUseEntireFastEth = true;

     String ret_value = ALL_PRESENT;
     String location = ad0.value;
     int selected = 0;
     
     ResultSet resultSet = null;
     PreparedStatement pstmt = null;

     
     DataSource ds= (DataSource)session.getAttribute(Constants.DATASOURCE);
     Connection con = null;
     Customer customer = null;
 //    ArrayList portNames = new ArrayList ();
     String [] interfaceNames = new String[0];
     String vendor = "";
     String ratelimitId = null;
 	 boolean nnmEnabled = false;

 //    for (int i = 0; i < jd.attributes.length; i++) {
 //        AttributeDescriptor attribute = jd.attributes[i];
 //        System.out.println ("attribute.value["+i+"] = " + attribute.value);
 //    }
     try {
     if (ds != null)  {
         con = ds.getConnection();
         if (con != null) {

                nnmconf = com.hp.ov.activator.nnm.common.NNMiConfiguration.findById(con, "1");
				 if((nnmconf != null) && (nnmconf.getEnable_cl()== true )){
					nnmEnabled=true;
				}

             String whereClause = "Location = '" + location + "' and adminstate = 'Up' and LifeCycleState = 'Ready'";
             //where clause for avoiding the same primary attachment rouetr to appear on the protection attachment selection list 
			networkElements = PERouter.findByRole(con, "PE", whereClause);

			String whereClause3 = " and (Role='AccessSwitch' or Role='AggregationSwitch')";
			//where cluase for avoiding access networks in planned state
             String whereClause2 =" and (networkid IN ( SELECT networkid FROM V_ACCESSNETWORK WHERE V_ACCESSNETWORK.STATE='Ready')  OR   networkid IN  (SELECT networkid FROM CR_NETWORK WHERE parentnetworkid in (SELECT networkid FROM V_ACCESSNETWORK WHERE state ='Ready')))";
      //where clause for avoiding access networks attachted to PE with all Trunk mode
      String whereClause4 = " and networkid NOT IN (SELECT DISTINCT a.networkid FROM cr_link t, v_accessnetwork a, cr_interface r, cr_networkelement ne WHERE ((t.ne1 = ne.networkelementid and ne.networkid = a.networkid) OR (t.ne2 = ne.networkelementid and ne.networkid = a.networkid)) AND ((t.tp1 = r.terminationpointid AND r.usagestate='Trunk') OR (t.tp2 = r.terminationpointid AND r.usagestate='Trunk')) AND a.networkid NOT IN ( SELECT DISTINCT a.networkid FROM cr_link t, v_accessnetwork a, cr_interface r , cr_networkelement ne WHERE ((t.ne1 = ne.networkelementid and ne.networkid = a.networkid) OR (t.ne2 = ne.networkelementid and ne.networkid = a.networkid)) AND ((t.tp1 = r.terminationpointid AND r.usagestate='SwitchPort') OR (t.tp2 = r.terminationpointid AND r.usagestate='SwitchPort'))))"; 
      // avoiding sub access networks attachted to the above access network
      String whereClause5 = " and networkid NOT IN ( SELECT networkid from CR_NETWORK WHERE CR_NETWORK.PARENTNETWORKID IN (SELECT DISTINCT a.networkid FROM cr_link t, v_accessnetwork a, cr_interface r , cr_networkelement ne WHERE ((t.ne1 = ne.networkelementid and ne.networkid = a.networkid) OR (t.ne2 = ne.networkelementid and ne.networkid = a.networkid)) AND ((t.tp1 = r.terminationpointid AND r.usagestate='Trunk') OR (t.tp2 = r.terminationpointid AND r.usagestate='Trunk')) AND a.networkid NOT IN ( SELECT DISTINCT a.networkid FROM cr_link t, v_accessnetwork a, cr_interface r, cr_networkelement ne WHERE ((t.ne1 = ne.networkelementid and ne.networkid = a.networkid) OR (t.ne2 = ne.networkelementid and ne.networkid = a.networkid)) AND ((t.tp1 = r.terminationpointid AND r.usagestate='SwitchPort') OR (t.tp2 = r.terminationpointid AND r.usagestate='SwitchPort')))))"; 
      accessSwitches =  Switch.findAll(con,whereClause+whereClause2+whereClause3+whereClause4+whereClause5);

								
      String ne_id = null,networkid = null;
      ratelimitId = jd.attributes[16].value;
      RateLimit ratelimit = RateLimit.findByPrimaryKey(con, ratelimitId);
           if(ratelimit != null)
             allowUseEntireFastEth = 2000000 <= ratelimit.getAveragebw();

          boolean switches = false;
        
        //Added by pp for vlan range check start
        //Commnented this because this is only used in a if condition to display either PE routers or Access switches.
             /*      VlanRange vlanranges = null;
        int START_DIRECT_VLANID = 0;
          int END_DIRECT_VLANID = 0;
        int START_ACCESS_VLANID =  0;
          int END_ACCESS_VLANID = 0; 
          //Added by pp for vlan range check end      
        String pk = null;     
      pk = "Direct||External";
      
          vlanranges = (VlanRange)VlanRange.findByPrimaryKey(con, pk);
      
      if (vlanranges != null)
      {
          START_DIRECT_VLANID = vlanranges.getStartvalue();
          END_DIRECT_VLANID = vlanranges.getEndvalue();
      }
         
      pk = "Access||External";
      vlanranges = (VlanRange)VlanRange.findByPrimaryKey(con, pk);
      if (vlanranges != null)
      {
          START_ACCESS_VLANID = vlanranges.getStartvalue();
          END_ACCESS_VLANID = vlanranges.getEndvalue();
      }
      */

         if (interface_type.equalsIgnoreCase("Port")||Integer.parseInt(vlan_ids) == 0)
         {
              if ((networkElements != null && networkElements.length > 0)|| (accessSwitches != null && accessSwitches.length > 0) ) {
              ActionTemplates templates;
              PERouter peRouter;
              ArrayList filteredElements;
  //ArrayList filteredElements = new ArrayList(networkElements.length);
  //AccessNetwork-start
  //To check if access switches are present 
                        if(accessSwitches != null && networkElements != null){
							filteredElements = new ArrayList(networkElements.length+accessSwitches.length);
							switches = true;
						}else if(networkElements != null){
							 filteredElements = new ArrayList(networkElements.length);
						}else{
							filteredElements = new ArrayList(accessSwitches.length);
							 switches = true;
						}              //AccessNetwork-end
                                                
                                                // exclude from network elements those that don't have action templates
                        for (int i = 0 ; networkElements != null && i < networkElements.length; i++) {
                                 com.hp.ov.activator.cr.inventory.NetworkElement networkElement = networkElements[i];
                                    if(networkElement instanceof PERouter){
                                        peRouter = (PERouter) networkElement;
                                        OSVersion OSversion=  OSVersion.findByPrimaryKey(con, peRouter.getOsversion());
										ElementType elementtype=  ElementType.findByPrimaryKey(con, peRouter.getElementtype());																							
                                        templates = ActionTemplates.findByElementtypeosversionroleactivationname(con, elementtype.getElementtypegroupname(), OSversion.getOsversiongroup(), "PE", "L2-Add");
                                        //templates = ActionTemplates.findByElementtypeosversionroleactivationname(con, peRouter.getElementtype(), peRouter.getOsversion(), "PE", "L2-Add");
                                        if(templates == null) {
                                            toBeDiabledElements.add(networkElement);
                                            //continue;
										}
                                        if (!peRouter.getAdminstate().equals("Up"))
                                            continue;
                                    }
                                    filteredElements.add(networkElement);
                                }
                                     //AccessNetwork-start add switches to filteredelements
                                      if(switches){
                                            for (int i = 0; i < accessSwitches.length; i++) {
                                                   filteredElements.add(accessSwitches[i]);                    
                                                }
                                             }
                                                //AccessNetwork-end
                                networkElements = new com.hp.ov.activator.cr.inventory.NetworkElement[filteredElements.size()];
                                filteredElements.toArray(networkElements);
                            }
                            
                        }
                          else
                          {
                        if (vlan_ids != null && vlan_ids != "")
                        {
                         ActionTemplates templates;
                         PERouter peRouter;
                         ArrayList filteredElements = null;
                         //Removed this condition because there is now only one range for both access network and global .
                   //     if (Integer.parseInt(vlan_ids)<= END_DIRECT_VLANID && Integer.parseInt(vlan_ids) >= START_DIRECT_VLANID)
                     //   {
                                if (networkElements != null && networkElements.length > 0) {
                                    if(accessSwitches != null && accessSwitches.length > 0){ 
                                        filteredElements = new ArrayList(networkElements.length+accessSwitches.length);
                                        switches = true;
                                    }else{
                                        filteredElements = new ArrayList(networkElements.length);
                                    }
                                    //ArrayList filteredElements = new ArrayList(networkElements.length);
                    
                                    //              filteredElements = new ArrayList(networkElements.length);
                    
                                    for (int i = 0 ; i < networkElements.length; i++) {
                                        com.hp.ov.activator.cr.inventory.NetworkElement networkElement = networkElements[i];
                                        if(networkElement instanceof PERouter){
                                            peRouter = (PERouter) networkElement;
                                            	OSVersion OSversion=  OSVersion.findByPrimaryKey(con, peRouter.getOsversion());
												ElementType elementtype=  ElementType.findByPrimaryKey(con, peRouter.getElementtype());																							
                                            //templates = ActionTemplates.findByElementtypeosversionroleactivationname(con, peRouter.getElementtype(), peRouter.getOsversion(), "PE", "L2-Add");
                                            templates = ActionTemplates.findByElementtypeosversionroleactivationname(con,elementtype.getElementtypegroupname(), OSversion.getOsversiongroup(), "PE", "L2-Add");
                                            if(templates == null) {
												toBeDiabledElements.add(networkElement);
                                                //continue;
											}
                                            if (!peRouter.getAdminstate().equals("Up"))
                                                continue;
                                        }
                                        filteredElements.add(networkElement);
                                    }
                    
                                    
                           
                         //     }else if(Integer.parseInt(vlan_ids) <= END_ACCESS_VLANID && Integer.parseInt(vlan_ids) >= START_ACCESS_VLANID)
                           //       {
                                        //  if(accessSwitches != null && accessSwitches.length > 0)
                                    //      {
                                //          //              filteredElements = new ArrayList(accessSwitches.length);
                                                    //      switches = true;
                                            //          }
                                                    //AccessNetwork-start add switches to filteredelements
                                                    if(switches){
                                                        for (int i = 0; i < accessSwitches.length; i++) {
                                                            filteredElements.add(accessSwitches[i]);
                                                        }
                                                    }
                              if (filteredElements != null)
                               {
                                    networkElements = new com.hp.ov.activator.cr.inventory.NetworkElement[filteredElements.size()];
                                    filteredElements.toArray(networkElements);
                                                    //AccessNetwork-end
                                }
                                else
                                {
                                    networkElements = new com.hp.ov.activator.cr.inventory.NetworkElement[0];
                                }
                                    //filteredElements.toArray(networkElements);
                               }
                             }
                        }
                            com.hp.ov.activator.cr.inventory.NetworkElement networkElement = null;
                            
                            if (networkElements != null && networkElements.length > 0) {
                                if ( selected_pe_router_val != null )
                                {
                                        for (int i = 0 ; i < networkElements.length; i++) {
                                            com.hp.ov.activator.cr.inventory.NetworkElement element = networkElements[i];
                                            if (element.getNetworkelementid().equals(selected_pe_router_val)) {
                                                networkElement = element;
                                                ne_id = networkElements[i].getNetworkelementid();
												networkid = networkElements[i].getNetworkid();
                                                role = networkElements[i].getRole();
                                                vendor = networkElements[i].getVendor();
                                            }
                                        }
                                     } else
                                        {
                                            //networkElement = networkElements[0];
											int index=getIndexOfNextEligibleNE(networkElements, toBeDiabledElements);
											networkElement = networkElements[index];
                                            ne_id = networkElement.getNetworkelementid();
											networkid = networkElement.getNetworkid();
                                          vendor = networkElement.getVendor();
                                            //AccessNetwork-start
                                            selected_pe_router_val = ne_id;
                                            role = networkElement.getRole();
                                        }
                                           
									
								//Changes for MultiASN				  
								String ASBRquery1="";
								PreparedStatement asbrpstmt = null;
								ResultSet asbrrset =null;
								boolean flag = false;
								if(networkid!=null)
								{

									
									try
									{	
										com.hp.ov.activator.cr.inventory.Network networkObj= com.hp.ov.activator.cr.inventory.Network.findByNetworkid(con,networkid);
										String asn = networkObj.getAsn();
										if(asn!=null)
										{
											flag = true;
											ASBRquery1 = "( CR_Network.asn is null or CR_Network.asn !=?)";
										}
										else
										{
											ASBRquery1 = "( CR_Network.asn is not null)";
										}
						 


										String ASBRquery = "select distinct(CR_NetworkElement.Networkid) from CR_TerminationPoint , V_VPNFPMEmbership,CR_NetworkElement,CR_Network,V_L2FlowPoint,V_FlowPoint where 				 CR_NetworkElement.NETWORKELEMENTID = CR_TerminationPoint.NE_ID and CR_TerminationPoint.TERMINATIONPOINTID = V_VPNFPMEmbership.FLOWPOINTID  and V_L2FlowPoint.TERMINATIONPOINTID = CR_TerminationPoint.TERMINATIONPOINTID and V_FlowPoint.TERMINATIONPOINTID= V_L2FlowPoint.TERMINATIONPOINTID and V_VPNFPMEmbership.VPNID = ?  and CR_Network.networkid  = CR_NetworkElement.NETWORKID	and CR_Network.networkid !=? and"+ASBRquery1;
										asbrpstmt = con.prepareStatement(ASBRquery);
										asbrpstmt.setString(1,vpn_id);
										asbrpstmt.setString(2,networkid);
										
										if(flag){
											asbrpstmt.setString(3,asn);
										
										}

										 asbrrset = asbrpstmt.executeQuery();
										while(asbrrset.next())
										{
											multiASNFlag=true;
											break;
										}
									}
									catch(Exception e)
									{
										System.out.println("Exception during MultiASN check"+e);
									}
									finally
									{
										try
										{
											if(asbrrset!=null)
												asbrrset.close();
											if(asbrpstmt!=null)
												asbrpstmt.close();

										}
										catch(Exception ignore)
										{
										
										}
										
									}

								
								
								}


							//MultiASN changes ends here

                                            if(role.equalsIgnoreCase("PE")){
                                            //AccessNetwork-end
                                PERouter peRout;
                                PERouterWrapper peRouterWrapper;
                                peRout = (PERouter)PERouter.findByPrimaryKey(con, ne_id);
                                peRouterWrapper = new PERouterWrapper(peRout);

                                interfaceNames = peRouterWrapper.getInterfaces(con, Integer.parseInt(vlan_ids), 
                                                 vpn_id, interface_type, ratelimitId, qosProfile,fixedL2VPN );
                                        
                                            }//AccessNetwork-start if the role is AccessSwitch
                                                else if (role.equalsIgnoreCase("AccessSwitch") || role.equalsIgnoreCase("AggregationSwitch"))
                                                    {                                       
                                                        accessSwitch = Switch.findByPrimaryKey(con, selected_pe_router_val);
                                                        accessSwitchWrapper = new AccessSwitchWrapper(accessSwitch);
                                                        
                                                        interfaceNames = accessSwitchWrapper.getInterfaces(con, "MPLS-PortVlan");
														
                                                        //for (int i=0; i < interfaceNames.length; i++)
                                                        ArrayList PEs =  accessSwitchWrapper.getConnectedPElist(con);
                                                        if(PEs != null)
                                                        {
                                                            for (int i = 0 ; i < PEs.size(); i++)
                                                            { 
                                                             PERouter Pe = (PERouter) PEs.get(i);            
                                                             PEList.append(Pe.getName());
															 boolean isinsameVpn = accessSwitchWrapper.IsInSameVPN(con,vpn_id,Pe.getNetworkelementid(),Integer.parseInt(vlan_ids),fixedL2VPN);
															 // For fixed vpn, only the service in the same vpn can share the same npe vlan interface
															if (fixedL2VPN.equals("true"))
															{
															 boolean isVlanExist = accessSwitchWrapper.vlanIdExistinPE(con,Pe.getNetworkelementid(),Integer.parseInt(vlan_ids),accessSwitch.getNetworkid());
															
															 
															 if (!isVlanExist && !isinsameVpn)
																{
																	interfaceNames = new String[0];
																}
															
															}
															//else 
															//	{
															//	if (!isinsameVpn)
															//	{
															//		interfaceNames = new String[0];
															//	}
															//}


                                                             if(i != PEs.size()-1)
                                                                 PEList.append(", ");
                                                            }
                                                        }   else    
                                                            {
                                                                ret_value = NO_PEs;
                                                                PEList.append("No PEs connected");
                                                            }
                                                    }
													
                                            //AccessNetwork-end
									
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

                            } else {// if no network elements found
                              ret_value = NO_EQUIPMENT;
                            }
                        } else {// if no connection
                                            ret_value = NO_DB;
                        }
                    } else { // if no datasource

                        ret_value = NO_DB;
                    }

					if (interface_name != null && !"".equals(interface_name)) {
						com.hp.ov.activator.cr.inventory.Interface[] interface_array = com.hp.ov.activator.cr.inventory.Interface.findByNe_idname(con, selected_pe_router_val, interface_name);
						if (interface_array != null) {
							com.hp.ov.activator.cr.inventory.Interface selectedIF = interface_array[0];
							isSharedPortAllowed = ServiceMultiplexExtension.isSharedPortAllowed(con, selectedIF.getTerminationpointid(), selected_pe_router_val, "L2VPN");		
						}
					}			
                 %>

                    <p>
                        <table>

                 <% AttributeDescriptor ad6 = jd.attributes[6]; %>

                <tr>
                   <td><b>Customer Name</b></td>
                   <td>
                <%
                        if (ad6.value != null)
                          customer = com.hp.ov.activator.vpn.inventory.Customer.findByPrimaryKey(con, ad6.value); 

                %>
                   
                <%= customer == null ? "" :  customer.getCustomername()%>
                   </td>
                </tr>

                <%
                    AttributeDescriptor ad11 = jd.attributes[11]; 
                %>
                <tr>
                   <td><b>VPN Name</b></td>
                   <td>
                <%=  ad11.value == null ? "" : ad11.value %>
                   </td>
                </tr>

                <%
                    AttributeDescriptor ad12 = jd.attributes[12]; 
                %>
                <tr>
                   <td><b>Site Name</b></td>
                   <td>
                <%=  ad12.value == null ? "" : ad12.value %>
                   </td>
                </tr>

                <tr>
                   <td><b>UNIType</b></td>
                   <td>
                <%=  interface_type == null ? "" : interface_type %>
                   </td>
                </tr>

                <tr>
                   <td><b>Requested Rate limit</b></td>
                   <td>
                <%=  ratelimitId == null ? "" : ratelimitId %>
                   </td>
                </tr>

                <tr>
                   <td><b>Router Location</b></td>
                   <td>
                <%=  ad0.value == null ? "" : ad0.value %>
                   </td>
                </tr>

                <%      if (!ret_value.equals(NO_EQUIPMENT) && !ret_value.equals(NO_DB)) { %>
                          <form name="rsform" action="/activator/customJSP/L2VPN_ReserveResource/Select_router_and_port/add_l2_site.jsp" method="POST"
                          onsubmit="comment.value=document.rsform.comment.value">

                          <tr>
                            <td class="list0"><b>Select Router</b>&nbsp;&nbsp;</td><td class="list0">
                            <select name="router_id" onchange="document.rsform.submit()">
                <%          if ( networkElements != null) {
                              for (int i = 0 ; i < networkElements.length; i++) {
                                if (networkElements[i].getNetworkelementid().equals(selected_pe_router_val)) {
                                   selected = i;
                %>
				<%                   if(toBeDiabledElements.contains(networkElements[i])){ %>
                                  <option SELECTED disabled value="<%= networkElements[i].getNetworkelementid() %>"><%= networkElements[i].getName() %>  ( <%= networkElements[i].getRole() %> )
                                  </option>
                <%                   } else { %>
                                  <option SELECTED value="<%= networkElements[i].getNetworkelementid() %>"><%= networkElements[i].getName() %>  ( <%= networkElements[i].getRole() %> )
                                  </option>
                <%                  } %>
                <%              } else { %>
				<%                   if(toBeDiabledElements.contains(networkElements[i])){ %>
                                  <option disabled value="<%= networkElements[i].getNetworkelementid() %>"><%= networkElements[i].getName() %>  ( <%= networkElements[i].getRole() %> )
                                  </option>
                <%              } else { %>
                                  <option value="<%= networkElements[i].getNetworkelementid() %>"><%= networkElements[i].getName() %>  ( <%= networkElements[i].getRole() %> )
                                  </option>
                <%                  } %>
                <%              }
                              }
                            }  %>
                          </select>
                        </td>

                <tr>
                   <td><b>Router Id</b></td>
                   <td><i><%=  networkElements[selected].getNetworkelementid() %></i></td>
                </tr>

                <%     
                     
                 if (ret_value.equals(ALL_PRESENT)) {

                          for (int i = 0; i < interfaceNames.length; i++) {
                            //ret_value = NO_INTERFACE;
                            ret_value = RATELIMIT_INTERFACE;
                            if(!allowUseEntireFastEth && !interfaceNames[i].startsWith("Ethernet") && "Cisco".equals(vendor) && "Port".equals(interface_type))
                             continue;                             
                            ret_value = ALL_PRESENT;
                            break;
                          }
                        }
               
                        
                      if (ret_value.equals(ALL_PRESENT)) {
                %>
                          </tr>
                          <tr>
                            <td class="list0"><b>Select Port</b>&nbsp;&nbsp;</td><td class="list0">
                            <select name="selected_pe_if" id="selected_pe_if" onchange="document.rsform.submit()">
                <%
					if ( interfaceNames.length != 0) {
						for (int i = 0; i < interfaceNames.length; i++) {
								//Allow only Ethernet interfaces for RateLimit <2Mbps
						  if(!allowUseEntireFastEth && !interface_name.startsWith("Ethernet") && "Cisco".equals(vendor) && "Port".equals(interface_type)) {
							continue;
						  }
				%>
									<option <%=interface_name.equals(interfaceNames[i])?"selected ":" "%>><%= interfaceNames[i] %></option>
				<%  	} 
					}
				%>
                            </select>
                            <% if ( "VPLS-PortVlan".equals(interface_type)) { %>
                            <b>VLAN:</b><i><%=(vlan_ids.equals("0")?"Provider Managed":vlan_ids)%></i>
                            <%}%>
                            </td>
                          </tr>
                <%      } %>
                 
				 
				 
		<!-- Start RSI -->


<% if (nnmEnabled) {
	 com.hp.ov.activator.cr.inventory.NetworkElement ne = com.hp.ov.activator.cr.inventory.NetworkElement.findByPrimaryKey(con, selected_pe_router_val);
	
	
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


<!-- end RSI --> 
				 
				 
				 
				 
				 
				 
<% AttributeDescriptor ad5 = jd.attributes[5]; %>

           <tr>
                   <td><b>Contact Person</b></td>
                   <td>
                <%= ad5.value == null ? "" : ad5.value %>
                   </td>
                </tr>
           <tr>
                           <td><b>Comment</b></td>
                           <td>
                            <textarea cols="30" rows="4" name="comment"><%= comment %></textarea>
                           </td>
                        </tr>

                <%
                        if ( retry_message != null && !retry_message.equals("") ) { %>

                        <tr>
                           <td colspan="2"><b><%=retry_message%></b></td>
                        </tr>

                <%      } %>

                        </form>
                <%    } %>


                <%   
                 
                			if (ret_value.equals(ALL_PRESENT) && isSharedPortAllowed==true) { %>
 
                      <%-- Concrete job information: attributes --%>

                        
                        <form name="form" action="/activator/sendCasePacket" method="POST"
                        onsubmit="router_id.value=<%=  networkElements[selected].getNetworkelementid() %>;
                         selected_pe_if.value=document.rsform.selected_pe_if.options[document.rsform.selected_pe_if.selectedIndex].text;return checkMASN();">
                        <input type="hidden" name="id" value="<%= jd.jobId %>">
                        <input type="hidden" name="workflow" value="<%= jd.name %>">
                        <input type="hidden" name="queue" value="add_l2_site">
                        <input type="hidden" name="router_id" value="">
                        <input type="hidden" name="selected_pe_if" value="">
                        <input type="hidden" name="RET_VALUE" value="<%= ret_value %>">
                        <input type="hidden" name="operator_name" value="<%= session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) %>">
                        <input type="hidden" name="comment" value="<%=comment%>">
                        <input type="hidden" name="clientip" value="<%=ip%>">
						   <input type="hidden" name="multiASNFlag" value="<%=multiASNFlag%>">



                        <%-- Common trailer --%>
                        <tr>
                          <td colspan="2">&nbsp;</td>
                        </tr>
                        <tr>
                          <td align="center" colspan="3">
                            <input type="submit" value="Submit">
                            <input type="reset"  value="Clear">
						</td>
                        </tr>
                      </form>
                <%    }
				
					else if (ret_value.equals(ALL_PRESENT) && isSharedPortAllowed!=true) { %>
					  <form name="form" action="/activator/sendCasePacket" method="POST"
                        onsubmit="router_id.value=<%=  networkElements[selected].getNetworkelementid() %>;
                         selected_pe_if.value=document.rsform.selected_pe_if.options[document.rsform.selected_pe_if.selectedIndex].text;return checkMASN();">
                        <input type="hidden" name="id" value="<%= jd.jobId %>">
                        <input type="hidden" name="workflow" value="<%= jd.name %>">
                        <input type="hidden" name="queue" value="add_l2_site">
                        <input type="hidden" name="router_id" value="">
                        <input type="hidden" name="selected_pe_if" value="">
                        <input type="hidden" name="RET_VALUE" value="<%= ret_value %>">
                        <input type="hidden" name="operator_name" value="<%= session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) %>">
                        <input type="hidden" name="comment" value="<%=comment%>">
                        <input type="hidden" name="clientip" value="<%=ip%>">
						   <input type="hidden" name="multiASNFlag" value="<%=multiASNFlag%>">

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
                          <input type="hidden" name="queue" value="add_l2_site">
                          <input type="hidden" name="router_id" value="-">
                          <input type="hidden" name="selected_pe_if" value="-">
                          <input type="hidden" name="RET_VALUE" value="<%= NO_EQUIPMENT %>">
                          <input type="hidden" name="operator_name" value="<%= session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) %>">
                          <input type="hidden" name="comment" value="<%=comment%>">
                          <input type="hidden" name="clientip" value="<%=ip%>">



                          <tr>
                            <% if (ret_value.equals(NO_EQUIPMENT)) { %>
                            <td colspan="2"><b>No routers available at the specified location: </b>
                              <%= ad0.value == null ? "" : ad0.value %></td>
                <%      }
                        
                        if (ret_value.equals(NO_INTERFACE)) { %>
                          <td colspan="2"><b>No ports available on the specified router: </b>
                            <%= networkElements[selected].getName() %> (<%= networkElements[selected].getNetworkelementid() %>)</td>
                <%      } 
                				if (ret_value.equals(RATELIMIT_INTERFACE)) { %>
                          <td colspan="2"><b>RateLimit should be minimum 2M to select Interfaces on: </b>
                            <%= networkElements[selected].getName() %> (<%= networkElements[selected].getNetworkelementid() %>)</td>
                <%      } %>
                <%    if (ret_value.equals(NO_PEs)) { %>
                        <td colspan="4"><b>No PEs connected to specified switch:</b></td>
                        <td>
                          <input type="hidden" name="selected_pe_if" id="selected_pe_if">
                          <input type="hidden" name="service_type" id="service_type">
                        </td>
                        <td><%= networkElements[selected].getName() %>(<%= networkElements[selected].getNetworkelementid() %>)</td>
                <%    } %>

                      </tr>
                      <tr>
                        <td colspan="2">&nbsp;</td>
                      </tr>
                      <tr>
                        <td align="center" colspan="3">
                          <input type="submit" value="Cancel" >
                        </td>
                      </tr>
                    </form>
                <% }

                   else if (ret_value.equals(NO_DB)) { %>
                     <tr>
                       <td><b>No Database Connection available, close window to cancel</b></td>
                     </tr>
                <% }
                    } catch (Exception e) {
                        
                        e.printStackTrace ();
                        %>
                     <tr>
                       <td><b>Exception in Router selection: <%=e.getMessage()%></b></td>
                     </tr>
                <% 
                    } finally{
                         try{
                            try{
                                resultSet.close();
                            }catch(Exception ex){}
                            try{
                                pstmt.close();
                            }catch(Exception ex){}
                            try{
                                con.close();
                            }catch(Exception ex){}
                         }catch(Exception ex){
                           out.println("Exception during the closing connection in add_l2_site.jsp : " + ex.getMessage());
                             ex.printStackTrace ();
                         }
                    }   
                %>

                </table>
                </center>

<script type="text/javascript" src="/activator/javascript/CRModel/utils.js"></script>
<script language="JavaScript">    
    
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
