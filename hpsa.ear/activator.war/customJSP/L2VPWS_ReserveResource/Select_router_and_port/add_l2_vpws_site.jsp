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
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/L2VPWS_ReserveResource/Select_router_and_port/add_l2_vpws_site.jsp,v $                                                                   --%>
<%-- $Revision: 1.36 $                                                                 --%>
<%-- $Date: 2010-12-03 02:53:05 $                                                                     --%>
<%-- $Author: divya $                                                                   --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--# Description                                                                 --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- Queue: 'add_l2_vpws_site' --%>

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





	function checkMASN()
	{
		if((document.form.multiASNFlag.value == true)||(document.form.multiASNFlag.value == "true"))
		{

			var r=confirm("There is already existing site services in other ASNs. If you continue you will not obtain connectivity to these. Are you sure you want to continue?");
			if((r==false)||(r=="false"))
			{

				document.form.RET_VALUE.value="4";
				document.form.router_id.value="-";
				document.form.selected_pe_if.value="-";
				document.form.intf_type.value="-";
				document.form.lmi_type.value="-";
				document.form.intf_type.value="-";

				return r;

			}
			else{
				return r;
			}
		}

	}
	function close()
	{
		var test = navigator.appName;
		if(test == "Microsoft Internet Explorer")
			window.close();
	}
  </script>
</head>


<body onUnLoad="opener.window.top.interactWindow=null">
<h3><img src="/activator/images/HPLogo.png" valign="top" align="right">Interact with job: L2VPWS_ReserveResource</h3>
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
    final static String ALL_PRESENT  = "0";
    final static String NO_EQUIPMENT = "1";
    final static String NO_INTERFACE = "2";
    final static String NO_DB = "3";
    final static String NO_PEs = "4";
    final static String RATELIMIT_INTERFACE = "5";
%>

<%
    boolean hasController = false;


	// For MultiASN Check
    boolean multiASNFlag = false;

	// For sharing port checkings
	boolean isSharedPortAllowed = true;

	String interfaceName;

    com.hp.ov.activator.cr.inventory.NetworkElement[] networkElements = null;
	ArrayList toBeDiabledElements =null;
    String [] interfaceNames = new String[0];
    String ip = request.getRemoteAddr();

    String selected_pe_router_val = request.getParameter("router_id");
    String selected_pe_if = request.getParameter("selected_pe_if");

    if ("yes".equals(request.getParameter("reset_pe_if"))) {
      selected_pe_if=null;
    }

    AttributeDescriptor ad0  = jd.attributes[0];

    AttributeDescriptor ad8 = jd.attributes[8];
    String interface_type = ad8.value;

    AttributeDescriptor ad13 = jd.attributes[13];
    String vc_type = ad13.value;

    AttributeDescriptor ad9 = jd.attributes[9];
    String vlan_id = ad9.value;

    AttributeDescriptor ad14 = jd.attributes[14];
    String dlci = ad14.value;

    AttributeDescriptor ad15 = jd.attributes[15];
    String skip_router_id = ad15.value;

    AttributeDescriptor ad10 = jd.attributes[10];
    String rate_limit = ad10.value;

    AttributeDescriptor ad17 = jd.attributes[17];
    String AToM = ad17.value;

    AttributeDescriptor ad18 = jd.attributes[18];
    String retry_message = ad18.value;

    AttributeDescriptor ad22 = jd.attributes[22];
    String Region = ad22.value; 

   AttributeDescriptor ad24 = jd.attributes[24];
    String VPWS_Vlan = ad24.value; 

    AttributeDescriptor ad4 = jd.attributes[4];
    String comment = request.getParameter ("comment");
    comment = comment != null ? comment : (ad4.value == null ? "" : ad4.value);

    // If this value >= 2Mbps then allow to use entire fast ethernet interface
    boolean allowUseEntireFastEth = true;
	boolean nnmEnabled = false;
	//For NNM Cross Launch
	com.hp.ov.activator.nnm.common.NNMiConfiguration nnmconf = null;

    String ret_value = ALL_PRESENT;
    String location = ad0.value;
    int selected = 0;

    DataSource ds= (DataSource)session.getAttribute(Constants.DATASOURCE);
    Connection con = null;
    Customer customer = null;
    Service  vpws = null;
    NetworkResults results;

	String networkid ="";

    try {
    if (ds != null)  {
        con = ds.getConnection();
        if (con != null) {
			nnmconf = com.hp.ov.activator.nnm.common.NNMiConfiguration.findById(con, "1");
				 if((nnmconf != null) && (nnmconf.getEnable_cl()== true )){
					nnmEnabled=true;
				}

         results = ProcessNetworkElements( con,
                                                    location,
                                                    interface_type, vc_type, rate_limit,
                                                    selected_pe_router_val,
                                                    vlan_id,
                                                    dlci,
                                                    skip_router_id,
                                                    AToM);
        ret_value = results.selectionResult;
        networkElements = results.networkElements;
        interfaceNames = results.interfaceNames;
        hasController = results.hasController;
        toBeDiabledElements = results.toBeDiabledElements;
        if(selected_pe_router_val == null && networkElements != null && networkElements.length > 0)

	{
			int index=getIndexOfNextEligibleNE(networkElements, toBeDiabledElements);
			selected_pe_router_val = networkElements[index].getNetworkelementid();
			networkid = networkElements[index].getNetworkid();

	}

		  //Changes for MultiASN
								String ASBRquery1="";
								PreparedStatement asbrpstmt = null;
								Statement  aendstmt = null;
								ResultSet aendrset =null;
								ResultSet asbrrset =null;
								String networkelementid="";
								boolean flag = false;
								 AttributeDescriptor vpws_id = jd.attributes[11];
								  AttributeDescriptor aend_id = jd.attributes[23];


								if((aend_id.value!=null)&&(!(aend_id.value.equals(""))))
								{

									try
									{
										 aendstmt = con.createStatement() ;
										String query_aend =  "select value from service_instance_parameters where service_id='"+aend_id.value+"' and name='router_id'";
										 aendrset = aendstmt.executeQuery(query_aend);
										 while(aendrset.next())
										{

										  networkelementid= (String)aendrset.getString(1);


										 }
										if(networkelementid!=null)
										{
											com.hp.ov.activator.cr.inventory.NetworkElement networkelementObj= com.hp.ov.activator.cr.inventory.NetworkElement.findByNetworkelementid(con,networkelementid);
											if(networkelementObj!=null)
											{
												com.hp.ov.activator.cr.inventory.Network anetworkObj= com.hp.ov.activator.cr.inventory.Network.findByNetworkid(con,networkelementObj.getNetworkid());
												if(anetworkObj!=null)
												{
													String aendAsn = anetworkObj.getAsn();
													com.hp.ov.activator.cr.inventory.NetworkElement zendneObj= com.hp.ov.activator.cr.inventory.NetworkElement.findByNetworkelementid(con,selected_pe_router_val);
													if(zendneObj!=null)
													{
														com.hp.ov.activator.cr.inventory.Network znetworkObj= com.hp.ov.activator.cr.inventory.Network.findByNetworkid(con,zendneObj.getNetworkid());
														if(znetworkObj!=null)
														{
															String zendAsn = znetworkObj.getAsn();
															if((aendAsn==null)&&(zendAsn==null))
																multiASNFlag=false;

															else if(((aendAsn==null)&&(zendAsn!=null))||((aendAsn!=null)&&(zendAsn==null))||(!aendAsn.equals(zendAsn)))
																	multiASNFlag=true;
														}
													}
												}
											}
										}


									}
									catch(Exception ee)
									{
											System.out.println("Exception during MultiASN check"+ee);
									}
									finally
									{
										try
										{
											if(aendrset!=null)
												aendrset.close();
											if(aendstmt!=null)
												aendstmt.close();


										}
										catch(Exception ignore)
										{

										}

									}
							}

							//MultiASN changes ends here

					if (interfaceNames.length == 0)
						ret_value = NO_INTERFACE;
					else
					{
					  String newInterfaceName = interfaceNames[0];
					  for (int i = 0; i < interfaceNames.length; i++) {
						if (interfaceNames[i].equals(selected_pe_if)) {
						  newInterfaceName = selected_pe_if;
						}
					  }
					  selected_pe_if = newInterfaceName;
					}

        } else {// if no connection
              ret_value = NO_DB;
        }
    } else { // if no datasource
            ret_value = NO_DB;
    }

	if (selected_pe_if != null)
	{
		com.hp.ov.activator.cr.inventory.Interface selectedIF = com.hp.ov.activator.cr.inventory.Interface.findByNe_idname(con, selected_pe_router_val, selected_pe_if)[0];
		isSharedPortAllowed = ServiceMultiplexExtension.isSharedPortAllowed(con, selectedIF.getTerminationpointid(), selected_pe_router_val, "L2VPWS");
	}

 %>
<p>
  <table>

<%
    String lmi_type = null;
    lmi_type = request.getParameter ("lmi_type");
    if (lmi_type==null)
      lmi_type = "ansi";

    String intf_type = null;
    intf_type = request.getParameter ("intf_type");
    if (intf_type==null)
      intf_type = "dce"; %>


<%  if (!ret_value.equals(NO_DB)) {

  AttributeDescriptor ad6 = jd.attributes[6]; %>

    <tr>
      <td><b>Customer Name</b></td>
      <td colspan="3">
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
      <td><b>VPWS Name</b></td>
      <td colspan="3">
<%  if (ad11.value != null) {
        vpws = com.hp.ov.activator.vpn.inventory.Service.findByPrimaryKey(con, ad11.value);%>
        <%=vpws.getServicename() %>
        <b >Id:</b><i>
<%= vpws.getServiceid() %></i>
<%    } else%>
      <%="" %>
      </td>
    </tr>

<%
		 PERouter selectedRouter = (PERouter) PERouter.findByPrimaryKey(con, String.valueOf(selected_pe_router_val));

    Switch selectedSwitch = null;
    AccessSwitchWrapper accessSwitchWrapper = null;
    PERouterWrapper peRouterWrapper = null;
    String vendor = null;
    if (selected_pe_router_val != null){
    if ( selectedRouter == null){
    selectedSwitch = Switch.findByPrimaryKey(con, String.valueOf(selected_pe_router_val));
    accessSwitchWrapper = new AccessSwitchWrapper(selectedSwitch);
    vendor = selectedSwitch == null ? "" : selectedSwitch.getVendor();
    }
    else
       peRouterWrapper = new PERouterWrapper(selectedRouter);
    }
     if(vendor == null || vendor.trim().length()==0)
     	vendor = selectedRouter == null  ? "" : selectedRouter.getVendor();
    String ratelimitId = jd.attributes[19].value;
    if ( selectedRouter == null && selectedSwitch == null)
    {
            ret_value = "NO_EQUIPMENT";
        }
    RateLimit ratelimit = RateLimit.findByPrimaryKey(con, ratelimitId);
    if(ratelimit != null)
    {
        allowUseEntireFastEth = 2000000 <= ratelimit.getAveragebw();
    }

    AttributeDescriptor ad12 = jd.attributes[12];


%>

      <form name="rsform" action="/activator/customJSP/L2VPWS_ReserveResource/Select_router_and_port/add_l2_vpws_site.jsp" method="POST"
            onsubmit="comment.value=document.rsform.comment.value">
        <tr> <td/> </tr>
        <tr> <td/> </tr>

        <tr>
          <td><b>Site Name</b></td>
          <td colspan="3">
<%= ad12.value == null ? "" : ad12.value %>
          </td>
        </tr>

        <tr>
          <td><b>Requested Rate limit</b></td>
          <td colspan="3">
<%= ratelimitId == null ? "" : ratelimitId %>
          </td>
        </tr>

        <tr>
          <td><b>Router Location</b></td>
          <td colspan="3">
<%= ad0.value == null ? "" : ad0.value %>
          </td>
        </tr>

        <tr>
          <td><b>Region</b></td>
          <td colspan="3">
<%=Region %>
          </td>
        </tr>

        <tr>
<%    if ("NO_EQUIPMENT".equals(ret_value)) { %>
          <td colspan="4"><b><i>No routers available at the specified location: <i></b>
<%= ad0.value == null ? "" : ad0.value %></td>
<%      } else { %>
          <td class="list0"><b>Select Router</b>&nbsp;&nbsp;</td>
          <td class="list0" colspan="3">
            <select name="router_id" onchange="getElementById('reset_pe_if').value='yes'; document.rsform.submit()">
<%    if ( networkElements != null) {
        for (int i = 0; i < networkElements.length; i++) {
          if (networkElements[i].getNetworkelementid().equals(selected_pe_router_val)) {
            selected = i;
%>
<%            if(toBeDiabledElements.contains(networkElements[i])){ %>
              <option disabled SELECTED value="<%= networkElements[i].getNetworkelementid() %>">
                <%= networkElements[i].getName() %> ( <%= networkElements[i].getRole() %> )
              </option>
<%            } else { %>
              <option SELECTED value="<%= networkElements[i].getNetworkelementid() %>">
                <%= networkElements[i].getName() %> ( <%= networkElements[i].getRole() %> )
              </option>
<%            } %>
<%        } else { %>
<%            if(toBeDiabledElements.contains(networkElements[i])){ %>
              <option disabled value="<%= networkElements[i].getNetworkelementid() %>">
                <%= networkElements[i].getName() %> ( <%= networkElements[i].getRole() %> )
              </option>
<%        } else { %>
              <option value="<%= networkElements[i].getNetworkelementid() %>">
                <%= networkElements[i].getName() %> ( <%= networkElements[i].getRole() %> )
              </option>
<%            } %>
<%        }
        }
      }  %>
            </select>
<%          if (hasController && (vc_type.equals( "FrameRelay" ) || vc_type.equals( "PPP" ))) {
%>          &nbsp;&nbsp;
            <input type="button" value="Create Interface" onClick="var win;win=window.open('/activator/jsp/CreateChannelFrame.jsp?NE_ID='+form.router_id.options[form.router_id.selectedIndex].value+'&rateLimit='+<%=ratelimit.getAveragebw()%>+'&location=/activator/customJSP/L2VPWS_ReserveResource/Select_router_and_port/add_l2_vpws_site.jsp', 'createchannelVPWS', 'width=700,height=500,scrollbars=yes,resizable=yes');win.focus();">
<%        } %>
          </td>
        </tr>

<%    if (!"NO_EQUIPMENT".equals(ret_value)) { %>
        <tr>
          <td><b>Router Id</b></td>
          <td colspan="3"><%=  networkElements[selected].getNetworkelementid() %></td>
        </tr>

<% } %>

<%
if (ret_value.equals(ALL_PRESENT) ) {
          for (int i = 0; i < interfaceNames.length; i++) {
            //ret_value = NO_INTERFACE;
             ret_value = RATELIMIT_INTERFACE;
            if(!allowUseEntireFastEth && !interfaceNames[i].startsWith("Ethernet") && "Cisco".equals(vendor) && "Port".equals(interface_type))
               continue;

            ret_value = ALL_PRESENT;
            break;
          }
      }


      if (ret_value.equals(ALL_PRESENT) ) {
%>
        <tr>
          <td><b>UNIType</b></td>
          <td colspan="3">
<% 
		

	 if(VPWS_Vlan!=null && VPWS_Vlan.equals("true")){

	%>
		VLAN
<% } else
	{
	%>
            <%=interface_type%>
<%}%> 

          </td>
        </tr>

        <tr>
          <td class="list0"><b>Select interface</b>&nbsp;&nbsp;</td>
          <td class="list0" colspan="2">
            <select name="selected_pe_if" onchange="document.rsform.submit()">>
<%

        //String interfaceName;
        for (int i = 0; i < interfaceNames.length; i++) {
          interfaceName = interfaceNames[i];
          if(!allowUseEntireFastEth && !interfaceName.startsWith("Ethernet") && "Cisco".equals(vendor) && "Port".equals(interface_type))
            continue;

          if (selected_pe_if == null) selected_pe_if = interfaceNames[i];
%>
              <option <%= interfaceName.equals(selected_pe_if)?" selected":""%>><%=interfaceName %></option>
<%      }%>
            </select>
<%      if (vc_type.equals( "Ethernet" ) && interface_type.equals("PortVlan")) { %>
            <b>VLAN:</b><i><%=(vlan_id.equals("0")?"Provider Managed":vlan_id)%></i>
<%      } else
        if (vc_type.equals( "FrameRelay" )) {%>
            <b>DLCI:</b><i><%=(dlci.equals("0")||(dlci!=null && dlci.trim().length()==0)?"Provider Managed":dlci)%></i>
<%      } %>
          </td>
        </tr>

<%      com.hp.ov.activator.cr.inventory.Interface[] ri = (com.hp.ov.activator.cr.inventory.Interface[])com.hp.ov.activator.cr.inventory.Interface.findByName(con, selected_pe_if, "ne_id="+networkElements[selected].getNetworkelementid());
            if (vc_type.equals( "FrameRelay" ) && ri != null) { %>
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
<%    } %>


<%    }
if((!allowUseEntireFastEth)&&(ret_value.equals(RATELIMIT_INTERFACE))) { %>
        <tr> <td colspan="4"><b><i>RateLimit should be minimum 2M to select Interfaces on
        <%= networkElements[selected].getName() %>
         </i> </b></td> </tr>

    <% }
else {
        if (ret_value.equals(NO_INTERFACE)) { %>
        <tr> <td colspan="4"><b><i>No interfaces available </i> </b></td> </tr>
<%      }
      }
    }%>

        <input type="hidden" name="reset_pe_if" id="reset_pe_if" value="" >

        <tr> <td/> </tr>
        <tr> <td/> </tr>

<!-- Start RSI -->


<% if (nnmEnabled && networkElements != null) {

	 com.hp.ov.activator.cr.inventory.NetworkElement ne = com.hp.ov.activator.cr.inventory.NetworkElement.findByPrimaryKey(con, networkElements[selected].getNetworkelementid());
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
          <td colspan="3">
<%= ad5.value == null ? "" : ad5.value %>
          </td>
        </tr>

        <tr>
           <td><b>Comment</b></td>
           <td colspan="3">
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
<%}%>

<%if (ret_value.equals(ALL_PRESENT) && isSharedPortAllowed==true) { %>

      <%-- Concrete job information: attributes --%>

      <form name="form" action="/activator/sendCasePacket" method="POST"
        onsubmit="router_id.value=<%=  networkElements[selected].getNetworkelementid() %>;
            selected_pe_if.value=document.rsform.selected_pe_if.options[document.rsform.selected_pe_if.selectedIndex].text;
<%          if (vc_type.equals("FrameRelay")) { %>
              lmi_type.value=document.rsform.lmi_type.options[document.rsform.lmi_type.selectedIndex].text;
              intf_type.value=document.rsform.intf_type.options[document.rsform.intf_type.selectedIndex].text;
<% } %> comment.value=document.rsform.comment.value;return checkMASN();">
        <input type="hidden" name="id" value="<%= jd.jobId %>">
        <input type="hidden" name="workflow" value="<%= jd.name %>">
        <input type="hidden" name="queue" value="add_l2_vpws_site">
        <input type="hidden" name="router_id" value="">
        <input type="hidden" name="selected_pe_if" value="">
        <input type="hidden" name="RET_VALUE" value="<%= ALL_PRESENT %>">
        <input type="hidden" name="operator_name" value="<%= session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) %>">
        <input type="hidden" name="comment" value="<%=comment%>">
        <input type="hidden" name="clientip" value="<%=ip%>">
        <input type="hidden" name="lmi_type" value="<%= lmi_type %>">
        <input type="hidden" name="intf_type" value="<%= intf_type %>">

		   <input type="hidden" name="multiASNFlag" value="<%=multiASNFlag%>">

        <%-- Common trailer --%>
        <tr>
          <td colspan="5">&nbsp;</td>
        </tr>
        <tr>
          <td align="center" colspan="5">
            <input type="submit" value="Submit" id="Submit" onclick ="close();">
            <input type="reset"  value="Clear" onclick="document.rsform.comment.value='';">
          </td>
        </tr>
      </form>
<%}

  else if (ret_value.equals(ALL_PRESENT) && isSharedPortAllowed!=true) { %>
		  <form name="form" action="/activator/sendCasePacket" method="POST">
        <input type="hidden" name="id" value="<%= jd.jobId %>">
        <input type="hidden" name="workflow" value="<%= jd.name %>">
        <input type="hidden" name="queue" value="add_l2_vpws_site">
        <input type="hidden" name="router_id" value="-">
        <input type="hidden" name="selected_pe_if" value="-">
        <input type="hidden" name="RET_VALUE" value="<%= ALL_PRESENT %>">
        <input type="hidden" name="operator_name" value="<%= session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) %>">
        <input type="hidden" name="comment" value="<%=comment%>">
        <input type="hidden" name="clientip" value="<%=ip%>">
        <input type="hidden" name="lmi_type" value="<%= lmi_type %>">
        <input type="hidden" name="intf_type" value="<%= intf_type %>">

		   <input type="hidden" name="multiASNFlag" value="<%=multiASNFlag%>">

			  <tr>
				<% if (isSharedPortAllowed != true) { %>
				<td colspan="4"><b>The selected interface is already used by not compatible services.</b></td>
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
          <input type="hidden" name="queue" value="add_l2_vpws_site">
          <input type="hidden" name="router_id" value="-">
          <input type="hidden" name="selected_pe_if" value="-">
          <input type="hidden" name="RET_VALUE" value="<%= NO_EQUIPMENT %>">
          <input type="hidden" name="operator_name" value="<%= session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) %>">
          <input type="hidden" name="comment" value="<%=comment%>">
          <input type="hidden" name="clientip" value="<%=ip%>">
          <input type="hidden" name="lmi_type" value="-">
          <input type="hidden" name="intf_type" value="-">

          <tr>
            <td colspan="5">&nbsp;</td>
          </tr>
          <tr>
            <td align="center" colspan="5">
              <input type="submit" value="Cancel" >
            </td>
          </tr>
        </form>
<% }

   if (ret_value.equals(NO_DB)) { %>
        <tr>
           <td><b>No Database Connection avaiable, close window to cancel</b></td>
         </tr>
<% }
    } catch (Exception e) {
        out.println("Exception in Router selection: " + e.getMessage());
        e.printStackTrace ();
    } finally{
         try{
            con.close();
         }catch(Exception ex){
           out.println("Exception during the closing connection in add_l2_vpws_site.jsp : " + ex.getMessage());
             ex.printStackTrace ();
         }
    }
%>

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

  class NetworkResults{
    private com.hp.ov.activator.cr.inventory.NetworkElement[] networkElements;
    private String[] interfaceNames;
    private String selectionResult;
    private boolean hasController;
	private ArrayList toBeDiabledElements;
    public NetworkResults(com.hp.ov.activator.cr.inventory.NetworkElement[] networkElements, String[] interfaceNames, String selectionResult, boolean hasController, ArrayList toBeDiabledElements){
      this.networkElements = networkElements;
      this.interfaceNames = interfaceNames;
      this.selectionResult = selectionResult;
      this.hasController = hasController;
	  this.toBeDiabledElements = toBeDiabledElements;
    }
  }
  private NetworkResults  ProcessNetworkElements( Connection con,
                                  String location,
                                  String interface_type,
                                  String vc_type,
                                  String rate_limit,
                                  String selected_pe_router_val,
                                  String vlan_id,
                                  String dlci,
                                  String skip_router_id,
                                  String isAToM)
{
//    String ret_value = ALL_PRESENT;
    ResultSet resultSet = null;
    PreparedStatement pstmt = null;
    NetworkResults results = new NetworkResults(null, new String[0], ALL_PRESENT, false, new ArrayList());

    Switch[] accessSwitches = null;
    Switch accessSwitch = null;
    AccessSwitchWrapper accessSwitchWrapper = null;
        String role = "";
        StringBuffer PEList = new StringBuffer();

    try {
            String whereClause = "Location = '" + location + "' and adminstate = 'Up'  and LifeCycleState = 'Ready'";
            results.networkElements = PERouter.findByRole(con, "PE", whereClause);

                        if (vc_type.equals( "Ethernet" ))
                        {
                            String whereClause1 = " and (Role='AccessSwitch' or Role='AggregationSwitch')";

                        //where cluase for avoiding access networks in planned state
                        String whereClause2 =" and (networkid IN ( SELECT networkid FROM V_ACCESSNETWORK WHERE V_ACCESSNETWORK.STATE='Ready')  OR   networkid IN  (SELECT networkid FROM CR_NETWORK WHERE parentnetworkid in (SELECT networkid FROM V_ACCESSNETWORK WHERE state ='Ready')))";
                            //where clause for avoiding access networks attachted to PE with all SwitchPort mode
                            /*String whereClause3 =" and networkid IN ((SELECT DISTINCT a.networkid FROM tmnconnection t, accessnetwork a, routerinterface r , networkelement " +
                                                                    "   WHERE (t.networkid1 = a.networkid OR t.networkid2 = a.networkid) AND " +
                                                                    " ((t.tp1 = r.terminationpointid AND r.usagestate='Trunk' and t.ne1 = networkelement.networkelementid and networkelement.role='PE') OR " +
                                                                    " (t.tp2 = r.terminationpointid AND r.usagestate='Trunk' and " +
                                                                    " t.ne2 = networkelement.networkelementid and networkelement.role='PE' ))), " +
                                                                    " ( SELECT networkid from NETWORK WHERE NETWORK.PARENTNETWORKID IN " +
                                                                    " (SELECT DISTINCT a.networkid FROM tmnconnection t, accessnetwork a, routerinterface r , networkelement " +
                                                                    " WHERE (t.networkid1 = a.networkid OR t.networkid2 = a.networkid) AND " +
                                                                    " ((t.tp1 = r.terminationpointid AND r.usagestate='Trunk' and t.ne1 = networkelement.networkelementid and networkelement.role='PE') OR " +
                                                                    " (t.tp2 = r.terminationpointid AND r.usagestate='Trunk' and " +
                                                                    " t.ne2 = networkelement.networkelementid and networkelement.role='PE' )))))" ;

							*/
							       //where clause for avoiding access networks attachted to PE with all SwitchPort mode
                                    String whereClause3 = " and networkid NOT IN (SELECT DISTINCT a.networkid FROM cr_link t, v_accessnetwork a, cr_interface r , cr_networkelement ne WHERE ((t.ne1 = ne.networkelementid and ne.networkid = a.networkid) OR (t.ne2 = ne.networkelementid and ne.networkid = a.networkid)) AND ((t.tp1 = r.terminationpointid AND r.usagestate='SwitchPort') OR (t.tp2 = r.terminationpointid AND r.usagestate='SwitchPort')) AND a.networkid NOT IN ( SELECT DISTINCT a.networkid FROM cr_link t, v_accessnetwork a, cr_interface r, cr_networkelement ne WHERE ((t.ne1 = ne.networkelementid and ne.networkid = a.networkid) OR (t.ne2 = ne.networkelementid and ne.networkid = a.networkid)) AND ((t.tp1 = r.terminationpointid AND r.usagestate='Trunk') OR (t.tp2 = r.terminationpointid AND r.usagestate='Trunk'))))";
                                    // avoiding sub access networks attachted to the above access network
                                    String whereClause4 = " and networkid NOT IN ( SELECT networkid from CR_NETWORK WHERE CR_NETWORK.PARENTNETWORKID IN (SELECT DISTINCT a.networkid FROM cr_link t, v_accessnetwork a, cr_interface r , cr_networkelement ne WHERE ((t.ne1 = ne.networkelementid and ne.networkid = a.networkid) OR (t.ne2 = ne.networkelementid and ne.networkid = a.networkid)) AND ((t.tp1 = r.terminationpointid AND r.usagestate='SwitchPort') OR (t.tp2 = r.terminationpointid AND r.usagestate='SwitchPort')) AND a.networkid NOT IN ( SELECT DISTINCT a.networkid FROM cr_link t, v_accessnetwork a, cr_interface r, cr_networkelement ne WHERE ((t.ne1 = ne.networkelementid and ne.networkid = a.networkid) OR (t.ne2 = ne.networkelementid and ne.networkid = a.networkid)) AND ((t.tp1 = r.terminationpointid AND r.usagestate='Trunk') OR (t.tp2 = r.terminationpointid AND r.usagestate='Trunk')))))";


                            accessSwitches =  Switch.findAll(con,whereClause+whereClause1+whereClause2+whereClause3+whereClause4);

                        }
            String ne_id = null;
            String vendor = "";
            boolean switches = false;
            // exclude from network elements those that don't have action templates
            if ((results.networkElements != null && results.networkElements.length > 0) || (accessSwitches != null && accessSwitches.length > 0) ) {
                ActionTemplates templates;
                PERouter peRouter;
                ArrayList filteredElements;
                      //AN-start
                    if(accessSwitches != null && results.networkElements != null){

                        filteredElements = new ArrayList(results.networkElements.length+accessSwitches.length);
                        switches = true;
                    }else if(results.networkElements != null){
                        filteredElements = new ArrayList(results.networkElements.length);
                    }else{
					filteredElements = new ArrayList(accessSwitches.length);
                        switches = true;
					}
                                //AN-end

                for (int i = 0 ; results.networkElements != null && i < results.networkElements.length; i++) {
                    com.hp.ov.activator.cr.inventory.NetworkElement networkElement = results.networkElements[i];
                    if(networkElement instanceof PERouter){
                        peRouter = (PERouter) networkElement;
                        OSVersion OSversion=  OSVersion.findByPrimaryKey(con, peRouter.getOsversion());
												ElementType elementtype=  ElementType.findByPrimaryKey(con, peRouter.getElementtype());
                        templates = ActionTemplates.findByElementtypeosversionroleactivationname(con, elementtype.getElementtypegroupname(), OSversion.getOsversiongroup(), "PE", "L2-VPWS-Add");

                        //templates = ActionTemplates.findByElementtypeosversionroleactivationname(con, peRouter.getElementtype(), peRouter.getOsversion(), "PE", "L2-VPWS-Add");
                        if(templates == null || peRouter.getNetworkelementid().equals(skip_router_id) ) {
							results.toBeDiabledElements.add(networkElement);
                            //continue;
						}
                    }
                    filteredElements.add(networkElement);
                }
                      //AN-start add switches to filteredelements
                                if(switches){
                                    for (int i = 0; i < accessSwitches.length; i++) {
                                      if (!accessSwitches[i].getNetworkelementid().equals(skip_router_id))
                                      {
                                            filteredElements.add(accessSwitches[i]);
                                        }
                                    }
                                }
                                //AN-end
                results.networkElements = new com.hp.ov.activator.cr.inventory.NetworkElement[filteredElements.size()];
                filteredElements.toArray(results.networkElements);
            }
            com.hp.ov.activator.cr.inventory.NetworkElement networkElement = null;
            if (results.networkElements != null && results.networkElements.length > 0) {
                if (selected_pe_router_val != null)
                {
                    for (int i = 0 ; i < results.networkElements.length; i++) {
                        com.hp.ov.activator.cr.inventory.NetworkElement element = results.networkElements[i];
                        if (element.getNetworkelementid().equals(selected_pe_router_val)) {
                            networkElement = element;
                            role = results.networkElements[i].getRole();
                        }
                    }
                }
              else
                {
					int index=getIndexOfNextEligibleNE(results.networkElements, results.toBeDiabledElements);
					selected_pe_router_val = results.networkElements[index].getNetworkelementid();
					role = results.networkElements[index].getRole();
                }
                if(networkElement == null){
					int index=getIndexOfNextEligibleNE(results.networkElements, results.toBeDiabledElements);
					networkElement = results.networkElements[index];
				}
                ne_id = networkElement.getNetworkelementid();
                vendor = networkElement.getVendor();

                    if(role.equalsIgnoreCase("PE"))
                {
                    // Test if the router has any SONET/E1 controllers
                    pstmt =  con.prepareStatement ("select count(*) from cr_elementcomponent where ectype='Controller' and ne_id=?");
                    pstmt.setString(1, ne_id);
                    ResultSet rset = pstmt.executeQuery();
                    results.hasController = rset.next() && Integer.parseInt(new String(rset.getString(1)))>0;
                    pstmt.close();

                    PERouter peRout;
                    PERouterWrapper peRouterWrapper;
                    peRout = (PERouter)PERouter.findByPrimaryKey(con, ne_id);
                    peRouterWrapper = new PERouterWrapper(peRout);

                    if ( vc_type.equals( "Ethernet" )) {

                    if ("VPWS-PortVlan".equals(interface_type) && "true".equals(isAToM)) {
                       interface_type = "AToM-PortVlan";
                    }
                    else if ("0".equals(vlan_id) && "Port".equals(interface_type))
                            interface_type = "Port";
                            else
                            interface_type = "VPWS-PortVlan";

                    results.interfaceNames = peRouterWrapper.getInterfaces(con, Integer.parseInt(vlan_id), interface_type, !new String("None").equals(rate_limit));

                } else
                if ( vc_type.equals( "FrameRelay" )) {
                int dlci_value = 0;
                if ( dlci != null &&  dlci.length() > 0 )
                    dlci_value= Integer.parseInt(dlci);
                  results.interfaceNames = peRouterWrapper.getSerialInterfaces(con, dlci_value, "true".equals(isAToM)?"AToM":"VPWS","Attachment||External");

                } else
                if ( vc_type.equals( "PPP" )) {
                  results.interfaceNames = peRouterWrapper.getSerialInterfaces(con, "PPP" );
                 // System.out.println("FrameRelay interfaceNames =" +results.interfaceNames);
                } else
                {
                  results.selectionResult = NO_INTERFACE;
                }
              if (results.interfaceNames.length == 0)
                  results.selectionResult = NO_INTERFACE;
          }
                else if (role.equalsIgnoreCase("AccessSwitch") || role.equalsIgnoreCase("AggregationSwitch"))
                    {
                        accessSwitch = Switch.findByPrimaryKey(con, selected_pe_router_val);
                        accessSwitchWrapper = new AccessSwitchWrapper(accessSwitch);
                        results.interfaceNames = accessSwitchWrapper.getInterfaces(con, "MPLS-PortVlan");
                        ArrayList PEs =  accessSwitchWrapper.getConnectedPElist(con);
                                if(PEs != null){
                                    for (int i = 0 ; i < PEs.size(); i++) {
                                     PERouter Pe = (PERouter) PEs.get(i);
                                     PEList.append(Pe.getName());
                                     if(i != PEs.size()-1)
                                         PEList.append(", ");
                                    }
                                }else{
                                    results.selectionResult = NO_PEs;
                                    PEList.append("No PEs connected");
                                }
                    }
                    } else {
              results.selectionResult = NO_EQUIPMENT;
          }
    }
    catch (Exception ex){ }
    finally{
        try{
            if ( resultSet != null ) resultSet.close();
        }catch(Exception ex){}
        try{
            if ( pstmt != null ) pstmt.close();
        }catch(Exception ex){}
    }
    return results;
} %>


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

