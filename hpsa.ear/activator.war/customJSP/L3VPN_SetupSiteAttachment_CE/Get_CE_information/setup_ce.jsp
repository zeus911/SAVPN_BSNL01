		<%--##############################################################################--%>
		<%--                                                                              --%>
		<%--   ****  COPYRIGHT NOTICE ****                                                --%>
		<%--                                                                              --%>
		<%--   (c) Copyright 2003-2008 Hewlett-Packard Development Company, L.P.          --%>
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
		<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/L3VPN_SetupSiteAttachment_CE/Get_CE_information/setup_ce.jsp,v $                                                                   --%>
		<%-- $Revision: 1.27 $                                                                 --%>
		<%-- $Date: 2010-11-15 07:43:30 $                                                                     --%>
		<%-- $Author: tanye $                                                                   --%>
		<%--                                                                              --%>
		<%--##############################################################################--%>
		<%--#                                                                             --%>
		<%--#  Description                                                                --%>
		<%--#                                                                             --%>
		<%--##############################################################################--%>

		<%-- Queue: 'setup_ce' --%>

		<%@ page contentType="text/html; charset=UTF-8"
				 import="com.hp.ov.activator.mwfm.JobRequestDescriptor,
						 com.hp.ov.activator.mwfm.servlet.Constants,
						 javax.sql.DataSource,
						 java.sql.Connection,
						 com.hp.ov.activator.mwfm.AttributeDescriptor,
						 java.util.*,
						 com.hp.ov.activator.vpn.inventory.*,
						 com.hp.ov.activator.cr.inventory.Interface,
						 com.hp.ov.activator.cr.inventory.ElementTypeGroup,
						 com.hp.ov.activator.cr.inventory.ElementType,
						 com.hp.ov.activator.cr.inventory.Vendor, 
						 com.hp.ov.activator.cr.inventory.InterfaceType,
						 com.hp.ov.activator.cr.inventory.OSVersionGroup,
						 com.hp.ov.activator.cr.inventory.TerminationPoint , 
						 com.hp.ov.activator.vpn.backup.DeviceInformation" %>
		<%
			response.setDateHeader("Expires",0);
			response.setHeader("Pragma","no-cache");
			request.setCharacterEncoding("UTF-8");

		%>
		<html>
		<head>
		  <title>hp OpenView service activator Interact with job: L3VPN_SetupSite_CE</title>
		  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
		 <meta http-equiv="expires" content="Wed, 26 Feb 1997 08:21:57 GMT">
		 <script language="JavaScript"> 
			window.moveTo(50,0);
			window.resizeTo(900,740);
		 </script>
		</head>


		<body onUnLoad="opener.window.top.interactWindow=null" onLoad="this.location='#end'">
		<h3><img src="/activator/images/HPLogo.png" valign="top" align="right">Interact with job: L3VPN_SetupSite_CE</h3> 
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
												
		<%
			AttributeDescriptor ad16 = jd.attributes[16];
			AttributeDescriptor ad20 = jd.attributes[20];
			AttributeDescriptor ad21 = jd.attributes[21];
			AttributeDescriptor ad22 = jd.attributes[22];
		   AttributeDescriptor ad24 = jd.attributes[24];
			AttributeDescriptor ad27 = jd.attributes[27];
			AttributeDescriptor ad28 = jd.attributes[28];

			String tpList = ad24.value;

			String location = ad28.value;

			String addressFamily = ad27.value;
			//Set default address family
			if(addressFamily.equals("")) 
				addressFamily = "IPv4";
			
			String siteId = ad16.value == null ? "" : ad16.value;
			String attachmentId = ad21.value == null ? "" : ad21.value;
			String cerouterId = ad22.value == null ? "" : ad22.value;
			int  ce_count= new Integer(ad20.value).intValue();
			
		String readonly="";
			String disabled="";
			
			String ce_loopback_pool_name="Unknown";
			IPAddrPool ce_loopbackpool []=null;
			
		

			DataSource dataSource = (DataSource) session.getAttribute(Constants.DATASOURCE);
			Connection connection = null;


			try {
				if (dataSource == null)
					throw new IllegalStateException("Error getting database connection");
			connection = dataSource.getConnection();
			if (connection == null)
					throw new IllegalStateException("Error getting database connection");
				// check if the PE has set up
				String bundleKey=null;
				String timeSlot=null;
				String encapsulation=null;
				String vlanId=null;
				String type  = null;
				String dlci  = null;
				//System.out.println("terminationpoint id"+tpList);
				if((tpList!= null)&&(tpList.equals(" ")))
				{
					//bundle type/key, Time Slots, encapsulation, Vlan Id, DLCI
					String[] tpArray = tpList.split(";");
					Interface routerObj = Interface.findByTerminationpointid(connection,tpArray[0]);
					type = routerObj.getType();
					bundleKey=routerObj.getBundlekey();
					timeSlot=routerObj.getTimeslots();
					encapsulation=routerObj.getEncapsulation();
					vlanId=routerObj.getVlanid();
					dlci =routerObj.getDlci();
				   // System.out.println("type"+type+"bundleKey"+bundleKey+"timeSlot"+timeSlot+"encapsulation"+encapsulation+"vlanId"+vlanId);
					
				}
			 

			//get the default loopback pool name 
			ce_loopbackpool=IPAddrPool.findByTypeaddressfamily(connection,"IPHost", addressFamily);
			
			if(ce_loopbackpool != null && ce_loopbackpool.length > 0){
				ce_loopback_pool_name = ce_loopbackpool[0].getName();
			}

				String routername = request.getParameter("routername");
				if (routername == null && jd.attributes[0].value != null) routername = jd.attributes[0].value;

			String whereClause = "(location = '" + location + "' OR location = 'Unknown') AND V_CErouter.networkelementid not like 'Unknown%' and V_CErouter.managed = 'true' and lifecyclestate != 'Ready'";
		    CERouter[] ceRouter = CERouter.findAll(connection, whereClause); 

			ElementTypeGroup[] etg = ElementTypeGroup.findAll(connection, "v_actiontemplates.activationname='Add' and v_actiontemplates.role='CE' and CRModel#ElementTypeGroup.name = v_Actiontemplates.elementtype","v_actiontemplates");

			Vector v = new Vector();
			TreeMap hm = new TreeMap();
			Vector Elev = new Vector();
			TreeMap Elehm = new TreeMap();

			for ( int i=0; i< etg.length; i++)
			{
				String vendorName = etg[i].getVendor();
				if (!hm.containsKey(vendorName))
				{
					hm.put(vendorName,new Vendor(vendorName));
				}
			}
			Vendor[] vendors = new Vendor[hm.size()];
	//		ElementTypeGroup[] types = null;
			Set keys = hm.keySet();
			CERouter[] router = null;
				
			Iterator iterator = keys.iterator();
			int j=0;
			while (iterator.hasNext()) {
				String str =(String) iterator.next(); 
				Vendor ven = (Vendor) hm.get(str);
				vendors[j++]=ven;
			}
			//by KK Get the complete vendor list from CR_VENDOR table
			vendors=Vendor.findAll(connection);
			//by KK
			    String vendor = request.getParameter("vendor");
				String ceRouterName = request.getParameter("routername");
				String username_enabled = request.getParameter("username_enabled");
				String username = request.getParameter("username");
				String passwd_CE = request.getParameter("passwd_CE");
				String if_name_CE = request.getParameter("if_name_CE");
				String enable_passwd_CE = request.getParameter("enable_passwd_CE");
				String serial_number = request.getParameter("serial_number");
				String os_version = request.getParameter("os_version");
				String ro_community = request.getParameter("ro_community");
				String rw_community = request.getParameter("rw_community");
				String element_type = request.getParameter("element_type");

				if ( ceRouterName!= null && ! "".equals(ceRouterName) ) {
					router = CERouter.findByName(connection,ceRouterName);
					if(router !=null  && ! "".equals(router)) {
						CERouter selectedRouter = (CERouter)router[0];
						if ( username_enabled == null ) {
						username_enabled = selectedRouter.getUsernameenabledc();
						}
						username = selectedRouter.getUsername();
						passwd_CE = selectedRouter.getPassword();
						enable_passwd_CE = selectedRouter.getEnablepassword();
						serial_number = selectedRouter.getSerialnumber();
						if ( vendor == null ) {
							vendor = selectedRouter.getVendor();
						}
						if ( os_version == null ) {
							os_version = selectedRouter.getOsversion();
						}
						ro_community = selectedRouter.getRocommunity();
						rw_community = selectedRouter.getRwcommunity();
						if ( element_type == null ) {
							element_type = selectedRouter.getElementtype();
							ElementType elementType = ElementType.findByPrimaryKey(connection, element_type);
							element_type = elementType.getElementtypegroupname();
						}
					}

				} else {
							

						if (serial_number == null && jd.attributes[2].value != null && (jd.attributes[2].value.equals("null") == false)) serial_number = jd.attributes[2].value;

						if (username == null && jd.attributes[6].value != null  && (jd.attributes[6].value.equals("null") == false)) username = jd.attributes[6].value;

						//String username_enabled = request.getParameter("username_enabled");
						if (username_enabled == null && jd.attributes[7].value != null) username_enabled = jd.attributes[7].value;
						if (username_enabled == null) username_enabled = "No";
						if (passwd_CE == null && jd.attributes[4].value != null) passwd_CE = jd.attributes[4].value;
		  			    if (enable_passwd_CE == null && jd.attributes[5].value != null && (jd.attributes[5].value.equals("null") == false)) enable_passwd_CE = jd.attributes[5].value;
	

				}


				if (vendor == null &&  jd.attributes[12].value != null) vendor = jd.attributes[12].value;

				if (vendor == null || vendor.equals("")) vendor = vendors[0].getVendorname();
				if (element_type == null && jd.attributes[1].value != null) element_type = jd.attributes[1].value;
				
				ElementTypeGroup[] EleTypes = ElementTypeGroup.findByVendor(connection, vendor,"CRModel#ElementTypeGroup.Name=v_actiontemplates.elementtype and v_actiontemplates.activationname = 'Add' and v_actiontemplates.role = 'CE'","v_actiontemplates");
				
				//Added the logic to avoid duplicate ElementType Group
				if(EleTypes!=null){
					//KK added a null check since for certain vendors action templates would not have been created in V_ACTIONTEMPLATES table
					for ( int i=0; i< EleTypes.length; i++)
					{
						String vendorName = EleTypes[i].getName();
						if (!Elehm.containsKey(vendorName))
						{
							Elehm.put(vendorName,new ElementTypeGroup(vendorName, "", ""));
						}
					}
				}

				ElementTypeGroup[] types = new ElementTypeGroup[Elehm.size()];
				//ElementTypeGroup[] types = null;
				Set EleKeys = Elehm.keySet();
				Iterator EleIterator = EleKeys.iterator();
				j=0;
				//ElementTypeGroup[] vendors = new ElementTypeGroup[hm.size()];
				while (EleIterator.hasNext()) {
					String str =(String) EleIterator.next(); 
					ElementTypeGroup eleType = (ElementTypeGroup) Elehm.get(str);
					types[j++]=eleType;
				}
				//by KK Get the ElementTypes from CR_ELEMENTTYPEGROUP table for specific vendor, earlier getting a filtered list
				types = ElementTypeGroup.findByVendor(connection, vendor);
				//by KK

				String connection_protocol = request.getParameter("connection_protocol");
				if (connection_protocol == null && jd.attributes[3].value != null ) connection_protocol = jd.attributes[3].value;


				if (element_type == null && types != null) element_type = types[0].getVendor();


				if (if_name_CE == null && jd.attributes[8].value != null) if_name_CE = jd.attributes[8].value;

				String if_type_CE = request.getParameter("if_type_CE");
				if (if_type_CE == null && jd.attributes[9].value != null) if_type_CE = jd.attributes[9].value;

				InterfaceType[] if_types = InterfaceType.findAll(connection);
				if (os_version == null && jd.attributes[10].value != null) os_version = jd.attributes[10].value;

				OSVersionGroup[] versions = OSVersionGroup.findByVendor(connection, vendor);
				if (os_version == null && versions != null) os_version = versions[0].getOsversiongroupname();

				

				if (ro_community == null && jd.attributes[18].value != null && (jd.attributes[18].value.equals("null") == false)) ro_community = jd.attributes[18].value;
				if (ro_community == null) ro_community = "";

				if (rw_community == null && jd.attributes[19].value != null && (jd.attributes[19].value.equals("null") == false)) rw_community = jd.attributes[19].value;
				if (rw_community == null) rw_community = "";

		%>



		<p>
		<table>

		<% AttributeDescriptor ad13 = jd.attributes[13]; %>
		<tr>
		   <td><b><%=  ad13.description == null ? "&nbsp" : ad13.description %></b></td>
		   <td>
		   <%= ad13.value == null ? "" : ad13.value%>
		   </td>
		</tr>

		<% AttributeDescriptor ad14 = jd.attributes[14]; %>
		<tr>
		   <td><b><%=  ad14.description == null ? "&nbsp" : ad14.description %></b></td>
		   <td>
		   <%
			   String serviceId = ad14.value == null ? "" : ad14.value;

			   L3VPN vpn = (L3VPN)L3VPN.findByServiceid (connection, serviceId);
		   %>
		   <%= vpn == null?"not found in inventory": vpn.getServicename () %>
		   </td>
		</tr>
		<% AttributeDescriptor ad15 = jd.attributes[15]; %>
		<tr>
		   <td><b><%=  ad15.description == null ? "&nbsp" : ad15.description %></b></td>
		   <td>
		   <%= ad15.value == null ? "" : ad15.value%>
		   </td>
		</tr>

		<tr>
		   <td><b><%=  ad16.description == null ? "&nbsp" : ad16.description %></b></td>
		   <td>
		   <%= ad16.value == null ? "" : ad16.value%>
		   </td>
		</tr>

		<tr>
		   <td><b><%=  ad21.description == null ? "&nbsp" : ad21.description %></b></td>
		   <td>
		   <%= ad21.value == null ? "" : ad21.value%>
		   </td>
		</tr>

		<% if(type!=null)
				{%>
		<tr>
		   <td><b>PE InterfaceType</b></td>
		   <td>
		   <%= type%>
		   </td>
		</tr>
		<%
			}if(bundleKey!=null)
				{   
			%>
		<tr>
		   <td><b>PE BundleKey</b></td>
		   <td>
		   <%= bundleKey%>
		   </td>
		</tr>

		<%
			
			}if(timeSlot!=null)
				{   
			%>
		<tr>
		   <td><b>PE TimeSlot</b></td>
		   <td>
		   <%= timeSlot%>
		   </td>
		</tr><%
			
			}if(encapsulation!=null)
				{   
			%>
		<tr>
		   <td><b>PE Encapsulation</b></td>
		   <td>
		   <%= encapsulation%>
		   </td>
		</tr><%
			
			}if(vlanId!=null)
				{   
			%>
		<tr>
		   <td><b>PE VlanId</b></td>
		   <td>
		   <%= vlanId%>
		   </td>
		</tr>
		<%
				}if(dlci!=null)
				{   
			%>
		<tr>
		   <td><b>PE DLCI</b></td>
		   <td>
		   <%= dlci%>
		   </td>
		</tr>
		<%
				}%>



		<% AttributeDescriptor ad17 = jd.attributes[17]; 
		   if((ad17.value==null) || (ad17.value.equals("null")))  { ad17.value = "" ;}
		%>
		<tr>
		   <td><b><%=  ad17.description == null ? "&nbsp" : ad17.description %></b></td>
		   <td>
		   <%= ad17.value == null ? "" : ad17.value%>
		   </td>
		</tr>



		<form name="rsform" action="/activator/customJSP/L3VPN_SetupSiteAttachment_CE/Get_CE_information/setup_ce.jsp" method="POST">

		<!--<% AttributeDescriptor ad0 = jd.attributes[0]; %>
		<tr>
		   <td><b><%=  ad0.description == null ? "&nbsp" : ad0.description %></b></td>
		   <td>
		   <input type="text" <%=readonly%>  size="30" id="routername" name="routername" value="<%= routername == null ? "" : routername%>" >
		   </td>
		</tr> -->

		<!-- Added by Rama -->
		   <tr>
			<!--    <input type="text" id="create_router" name="create_router" value="false"> -->
			<td class="list0"><b><%=  ad0.description == null ? "&nbsp" : ad0.description %></b>&nbsp;&nbsp;</td><td class="list0">

			<% 
			String selected="";
				if (ce_count>=1)
			{
				 readonly="readonly";
				 disabled="disabled";
				 selected = "selected";
			
			}
			if(ceRouter != null && ce_count <1) {%>
			<select style="position:absolute;width:227px;" id="routernameList" name="routernameList" onchange="Combo_Select(this,routername);">
					 <option/>


					<%         
					  for (int i = 0 ; i < ceRouter.length; i++) {
						if ( ceRouter[i].getName().equals(ceRouterName) ) {
							selected="selected";
						} else {
						    selected="";
						}
					%>
					  <option value="<%=ceRouter[i].getName()%>" <%=selected%>><%=ceRouter[i].getName()%></option>
			     	 <%            
					 }
			
					 %>
					</select>
	<%} %>			

				<input style="position:absolute;width:210px;" type="text" id="routername" name="routername" maxlength="30" onFocus="handleHintWhenOnFocus(this,'Input or select site name')" onBlur="handleHintWhenOnBlur(this,'Input or select site name')"value="<%= routername == null || "".equals(routername) ? "Input or select site name" : routername%>"
				<%
					if (selected.equals("selected")) {
						%>readonly=true<%
					}
				%>
				><br></td>

				  </td>
				</tr>


		 <% AttributeDescriptor ad3 = jd.attributes[3]; %>

		<tr>
		   <td><b><%=  ad3.description == null ? "&nbsp" : ad3.description %></b></td>
		   <td>
			  <select <%=disabled%> name="connection_protocol">
				 
				 <option <%= connection_protocol.equals("telnet") ? " selected": " " %>>telnet</option>
				 <option <%= connection_protocol.equals("ssh") ? " selected": " " %>>ssh</option>
			  </select>
		   </td>
		</tr>


		<% AttributeDescriptor ad7 = jd.attributes[7]; %>

		<tr>
		   <td><b><%=  ad7.description == null ? "&nbsp" : ad7.description %></b></td>
		   <td>
			  <input type="radio" name="username_enabled" value="Yes" <%= username_enabled.equals("Yes") ? " checked" : " " %>  onClick="document.rsform.submit()" >Yes
			  <input type="radio" name="username_enabled" value="No"<%= username_enabled.equals("Yes") ? " " : " checked" %>  onClick="document.rsform.submit()" >No
		   </td>
		</tr>

		 <% AttributeDescriptor ad6 = jd.attributes[6]; 
			if (username_enabled.equals("Yes")) {%>
		<tr>
		   <td><b><%=  ad6.description == null ? "&nbsp" : ad6.description %></b></td>
		   <td>
		   <input type="text" size="30" name="username" value="<%= username == null ? "" : username%>" >
		   </td>
		</tr>
		<% } %>

		 <% AttributeDescriptor ad4 = jd.attributes[4]; %>

		<tr>
		   <td><b><%=  ad4.description == null ? "&nbsp" : ad4.description %></b></td>
		   <td>
		   <input type="password" size="30" id="passwd_CE" name="passwd_CE" value="<%= passwd_CE == null ? "" : passwd_CE%>" >
		  
		   </td>
		</tr>

		 <% AttributeDescriptor ad5 = jd.attributes[5]; %>

		<tr>
		   <td><b><%=  ad5.description == null ? "&nbsp" : ad5.description %></b></td>
		   <td>
		   <input type="password" size="30" name="enable_passwd_CE" value="<%= enable_passwd_CE == null ? "" : enable_passwd_CE%>" >
		   </td>
		</tr>

		<% AttributeDescriptor ad12 = jd.attributes[12]; %>
		<tr>
		   <td><b><%=  ad12.description == null ? "&nbsp" : ad12.description %></b></td>
		   <td>
		   <select <%=disabled%> name="vendor"  onchange="document.rsform.submit()" >
		<% if ( vendors != null) {
			 for (int i = 0 ; i < vendors.length; i++) {
		%>
				 <option <%= vendors[i].getVendorname().equals(vendor) ? " SELECTED" : " "%>><%= vendors[i].getVendorname() %></option>
		<%   }
		   }  %>
		   </select>
		   </td>
		</tr>

		 <% AttributeDescriptor ad10 = jd.attributes[10]; %>
		<tr>
		   <td><b><%=  ad10.description == null ? "&nbsp" : ad10.description %></b></td>
		   <td>
		   <select <%=disabled%>  name="os_version">
		<% if ( versions != null) {
			 for (int i = 0 ; i < versions.length; i++) {
		%>
			   <option value="<%= versions[i].getOsversiongroupname()%>" <%=disabled%>  <%= versions[i].getOsversiongroupname().equals(os_version) ? " SELECTED" : " " %>><%= versions[i].getOsversiongroupname()%></option>

		<%   }
		   }  %>
		   </select>
		   </td>
		</tr>

		<% AttributeDescriptor ad1 = jd.attributes[1]; %>
		<tr>
		   <td><b><%=  ad1.description == null ? "&nbsp" : ad1.description %></b></td>
		   <td>
		   <select  <%=disabled%> name="element_type"  onchange="document.rsform.submit()" >
		<% if ( types != null) {
			 for (int i = 0 ; i < types.length; i++) {
		%>
				 <option <%= types[i].getName().equals(element_type) ? " SELECTED" : " " %>><%= types[i].getName() %></option>
		<%   }
		   }  %>
		   </select>
		   </td>
		</tr>


		 <% AttributeDescriptor ad2 = jd.attributes[2]; %>

		<tr>
		   <td><b><%=  ad2.description == null ? "&nbsp" : ad2.description %></b></td>
		   <td>
		   <input <%=readonly%> type="text" size="30" name="serial_number" value="<%= serial_number == null ? "" : serial_number%>" >
		   </td>
		</tr>

		 <% AttributeDescriptor ad11 = jd.attributes[11]; %>

		
		 <% AttributeDescriptor ad8 = jd.attributes[8]; %>

		<%
		 
		TerminationPoint ceinterfaces[]=null;
		//change by lu yan for service multiplex
		String wherecluase ="(activationstate !='Activated'  and activationstate !='Ready')  and usagestate !='reserved' and type !='Unknown' and count__!=0";
		if(connection!=null)
			if(router != null) {

			cerouterId = router[0].getNetworkelementid();

		}
		 ceinterfaces=Interface.findByNe_id(connection,cerouterId,wherecluase);

	if (ceinterfaces==null || ceinterfaces != null )
		{
		%>
		 <% AttributeDescriptor ad9 = jd.attributes[9]; %>
		 <input type="hidden" id="create_if" name="create_if" value="true">
		<tr>
		   <td><b><%=  ad9.description == null ? "&nbsp" : ad9.description %></b></td>
		   <td>
		   <select name="if_type_CE">
		<% 
		/*For service multi-plexing, if PE use dot1q, then CE just allow ethernet type port to be selected.*/
			AttributeDescriptor ad26 = jd.attributes[26];
			String PE_encapsulation = ad26.value == null ? "" : ad26.value;
			/*If (PE !=dot1q || (PE==dot1q && if_types[i] include "thernet" substring))
				System.out.println("setup_ce.jsp: PE_encapsulation is "+PE_encapsulation);*/

			if ( if_types != null) {
				if (!PE_encapsulation.equals("MPLS-PortVlan")) {
					for (int i = 0 ; i < if_types.length; i++) {
		%>
						<option <%= if_types[i].getInterfacetypename().equals(if_type_CE) ? " SELECTED" : " " %>><%= if_types[i].getInterfacetypename() %></option>
		<%          }
			}else {
					for (int i = 0 ; i < if_types.length; i++) {
						if ((if_types[i].getGenerictype()).equals("Ethernet")){
		%>
							<option <%= if_types[i].getInterfacetypename().equals(if_type_CE) ? " SELECTED" : " " %>><%= if_types[i].getInterfacetypename() %></option>
		<%              }
				}
			} 
		   }  }
		   %>
		   </select>
		   </td>
		</tr>


	<%if (ceinterfaces==null)
		{
		%>


		<tr>
		   <td><b><%=  ad8.description == null ? "&nbsp" : ad8.description %></b></td>
		   <td>
		   <input type="text" size="30" id="if_name_CE" name="if_name_CE" value="<%= if_name_CE == null ? "" : if_name_CE%>" >

		   </td>
		</tr>

		<%
			}

			 else{
		%>

		   <tr>
				<input type="hidden" id="create_if" name="create_if" value="false">
				  
				  <td class="list0"><b><%=  ad8.description == null ? "&nbsp" : ad8.description %></b>&nbsp;&nbsp;</td><td class="list0">
					<select name="if_name_CE">
		<%        	  for (int i = 0 ; i < ceinterfaces.length; i++) {    %>
					  <option value="<%=ceinterfaces[i].getName()%>" SELECTED><%=ceinterfaces[i].getName()%></option>
		<%            }
			
				 %>
					</select>
				  </td>
				</tr>

		<%
				} 
				
		%>
		 <% AttributeDescriptor ad18 = jd.attributes[18]; %>

		<tr>
		   <td><b><%=  ad18.description == null ? "&nbsp" : ad18.description %></b></td>
		   <td>
		   <input <%=readonly%> type="text" size="30" name="ro_community" value="<%= ro_community == null ? "" : ro_community%>" >
		   </td>
		</tr>

		 <% AttributeDescriptor ad19 = jd.attributes[19];

		 %>

		<tr>
		   <td><b><%=  ad19.description == null ? "&nbsp" : ad19.description %></b></td>
		   <td>
		   <input  <%=readonly%> type="text" size="30" name="rw_community" value="<%= rw_community == null ? "" : rw_community%>" >
		   </td>
		</tr>



		</form>
		  

		  <%-- Concrete job information: attributes --%>


		<form id="form" name="form" action="/activator/sendCasePacket" method="POST">

		<%
			if(disabled.equalsIgnoreCase("disabled")) {
				%>
			<input type="hidden" id="routername" name="routername" value="<%= routername == null ? "" : routername%>">
			<input type="hidden" id="connection_protocol" name="connection_protocol" value="<%= connection_protocol == null ? "" : connection_protocol%>">
			<input type="hidden" id="vendor" name="vendor" value="<%=vendor == null ? "" : vendor%>">
			<!--<input type="hidden" id="os_version" name="os_version" value="<%=os_version == null ? "" : os_version%>">
			<input type="hidden" id="element_type" name="element_type" value="<%=element_type == null ? "" : element_type%>">-->
			<input type="hidden" id="ro_community" name="ro_community" value="<%=ro_community == null ? "" : ro_community%>">
			<input type="hidden" id="rw_community" name="rw_community" value="<%=rw_community == null ? "" : rw_community%>">
			<input type="hidden" id="create_if" name="create_if" value="false">
				<input type="hidden" id="passwd_CE" name="passwd_CE" value="<%= passwd_CE == null ? "" : passwd_CE%>" >
			  <input type="hidden"  name="enable_passwd_CE" value="<%= enable_passwd_CE == null ? "" : enable_passwd_CE%>" >

			 <%}%>

			<input  type="hidden" id="id" name="id" value="<%= jd.jobId %>">
			<input  type="hidden" id="workflow" name="workflow" value="<%= jd.name %>">
			<input type="hidden" id="queue" name="queue" value="setup_ce">
			<input type="hidden" id="routername" name="routername" value="">
			<input type="hidden" id="element_type" name="element_type" value="">
			<input type="hidden" id="serial_number" name="serial_number" value="">
			<input type="hidden" id="connection_protocol" name="connection_protocol" value="">
			<input type="hidden" id="passwd_CE" name="passwd_CE" value="">
			<input type="hidden" id="enable_passwd_CE" name="enable_passwd_CE" value="">
			<input type="hidden" id="username" name="username" value="">
			<input type="hidden" id="username_enabled" name="username_enabled" value="">
			<input type="hidden" id="if_name_CE" name="if_name_CE" value="">
			<input type="hidden" id="if_type_CE" name="if_type_CE" value="">
			<input type="hidden" id="os_version" name="os_version" value="">
			
			<input type="hidden" id="vendor" name="vendor" value="">
			<input type="hidden" id="ro_community" name="ro_community" value="">
			<input type="hidden" id="rw_community" name="rw_community" value="">
			<input type="hidden" id="create_if" name="create_if" value="">
			<input type="hidden" name="ce_loopback_pool_name" value="<%=ce_loopback_pool_name%>">

			<script>
	function handleList(routerList) {
				var cerouterList = getObjectById('routerList');
				var presname = getObjectById('routername');
				alert('ceRouterList' + presname );
							var selValue = routerList.options[routerList.selectedIndex].value;
			alert(selValue);
			
			if (routerList.selectedIndex > 0)
				{
					presname=routerList[routerList.selectedIndex].value;
					presname.readOnly="true";
					
				}
		
			}

function handleHintWhenOnFocus(presname, prompt) {
    if (presname.value == prompt) {
	presname.value = "";
    }
}
function handleHintWhenOnBlur(presname, prompt) {
    if (presname.value == "") {
	presname.value = prompt;
    }
}

function Combo_Select(oSelect,oText)
{
//	oText.value=oSelect.options[oSelect.selectedIndex].text;
//	if (oText.value == "" ) {
//		oText.readOnly="";
//		oText.value="Input or select site name"
//		alert('asdasd');
//	} else {
//		oText.readOnly="true";
//		rsform.submit();
//	}
	window.location.href=document.rsform.action+"?routername="+oSelect.options[oSelect.selectedIndex].text;
}
				function checkFields(){
			
					
					document.form.routername.value=document.rsform.routername.value;
					document.form.serial_number.value=document.rsform.serial_number.value;
					document.form.connection_protocol.value=document.rsform.connection_protocol.options[document.rsform.connection_protocol.selectedIndex].text;
					document.form.passwd_CE.value=document.rsform.passwd_CE.value;
					document.form.vendor.value=document.rsform.vendor.options[document.rsform.vendor.selectedIndex].text;
					document.form.element_type.value=document.rsform.element_type.options[document.rsform.element_type.selectedIndex].text;
					document.form.username_enabled.value=document.rsform.username_enabled[0].checked;
					document.form.enable_passwd_CE.value=document.rsform.enable_passwd_CE.value;
					if(document.rsform.os_version.selectedIndex!= -1)
						document.form.os_version.value=document.rsform.os_version.options[document.rsform.os_version.selectedIndex].value;
					document.form.ro_community.value=document.rsform.ro_community.value;
					document.form.rw_community.value=document.rsform.rw_community.value;
					 <% if (username_enabled.equals("Yes")) {%>
					  document.form.username.value=document.rsform.username.value;
					<% } %>
						
					
					document.form.create_if.value=document.rsform.create_if.value;
					<% if (ceinterfaces==null){
						
					%>
					document.form.if_name_CE.value=document.rsform.if_name_CE.value;
					document.form.if_type_CE.value=document.rsform.if_type_CE.options[document.rsform.if_type_CE.selectedIndex].text;
					
					<% }else{ %>
					  document.form.if_name_CE.value=document.rsform.if_name_CE.options[document.rsform.if_name_CE.selectedIndex].text;
					<%}%>

					
					var result = false;
					var str = document.getElementById('routername').value;
					var alertStr = '';
					var ret1 = true;
					var ret2 = true;
					var ret3 = true;

					if (str.length == 0){
						alertStr += ' Name of CE router \n ';
						ret1 = false;
					}
					str = document.getElementById('passwd_CE').value;
					if (str.length == 0){
						alertStr += ' Router password \n';
						ret2 = false;
					}
					str = document.getElementById('if_name_CE').value;
					if (str.length == 0){
						alertStr += ' Interface name \n';
					   ret3 = false;
					}


					if (ret1==true && ret2==true && ret3==true){
						result = true;
					} else{
						alert ('Provide:\n' + alertStr);
					
					}

					
				return result;
			}


				document.getElementById('form').onsubmit = checkFields;
			</script>
			<%-- Common trailer --%>
			<tr><td colspan="2">&nbsp;</td></tr>
			<tr>
				<td align="center" colspan="3">
				   <input type="submit" value="Submit" onClick="Submit">
				   <input type="reset"  value="Clear"  onclick="setOriginalValues()">
				</td>
			</tr>
		  </form>
		</table>
		</center>
		<a name="end"></a>
		<%
			} catch (Exception e) {
		%>
			<script>
				alert('<%=e.getMessage ()%>');
				top.window.close();
			</script>
		<%        e.printStackTrace ();
			} finally{
				try{
					connection.close();
				}catch(Exception ex){
					// doesn't metter
				}
			}
		%>
		<script language="JavaScript">
			function setOriginalValues() {
			  document.rsform.reset();
			}




		  </script>
		</body>
		</html>
