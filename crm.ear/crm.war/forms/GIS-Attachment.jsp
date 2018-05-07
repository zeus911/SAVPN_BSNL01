<%--##############################################################################--%>

<%--                                                                              --%>

<%--   ****  COPYRIGHT NOTICE ****                                                --%>

<%--                                                                              --%>

<%--   (c) Copyright 2003-2006 Hewlett-Packard Development Company, L.P.          --%>

<%--                                                                              --%>

<%--   All Rights Reserved.                                                       --%>

<%--                                                                              --%>

<%--##############################################################################--%>



<%--                                                                              --%>

<%--##############################################################################--%>

<%--#                                                                             --%>

<%--#  Description                                                                --%>

<%--#                                                                             --%>

<%--##############################################################################--%>



<%-- -*- html -*- --%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>

<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>





<%@page info="Create a service"

  import="com.hp.ov.activator.crmportal.action.*, java.sql.*, com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*, java.text.*, java.net.*" %>







<%

 //load param parameters got here

   

 

	ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");

	HashMap serviceParameters = new HashMap ();

	serviceParameters = (HashMap)request.getAttribute("serviceParameters");



	//this is a hack for using the same jsp for protection and initila attachments

	String subType = request.getParameter("subType");



	 if(subType==null)

	subType=(String)request.getAttribute("subType");

	 if(subType==null)

	subType="GIS-Attachment";



	String readonlyflag="";

	String disabled = "";

	String attachment_type="initial";

	readonlyflag= subType.equalsIgnoreCase("GIS-Attachment")? "" : "readonly" ;

	attachment_type =subType.equalsIgnoreCase("GIS-Protection")? "protection" : "initial" ;



	HashMap parentServiceParameters = new HashMap ();

	parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");



	String serviceid = serviceForm.getServiceid();

	String parentserviceid = serviceForm.getParentserviceid();

	String parentServiceName = (String) parentServiceParameters.get ("presname");

	String customerId = serviceForm.getCustomerid();

	String type = serviceForm.getType();

	String mv = (String)request.getAttribute("mv");

	String currentPageNo = (String)request.getAttribute("currentPageNo");

	String viewPageNo = (String)request.getAttribute("viewPageNo");







	Location[] locations = (Location[])request.getAttribute("locations");

	Region[] regions = (Region[])request.getAttribute("regions");

	IPAddrPool[] pools = (IPAddrPool[])request.getAttribute("pools");

	CAR[] cars = (CAR[])request.getAttribute("cars");

	String layer = "GIS";





//  String presname = (String)request.getAttribute("presname");

	String presname = serviceForm.getPresname();

	String location = (String)request.getAttribute("location");

	String region   = (String)request.getAttribute("region");

	String pool = (String)request.getAttribute("pool");

	String secondaryPool = (String)request.getAttribute("secondaryPool");

	String car  = (String)request.getAttribute("car");

	String connectivityType  = (String)request.getAttribute("connectivityType");
 System.out.println("Connectivity type is "+connectivityType);

	String vpnserviceid  = (String)request.getAttribute("SP_vpnserviceid");

	if(vpnserviceid == null)

	 vpnserviceid = request.getParameter("SP_vpnserviceid");

	String activation_Scope  = (String)request.getAttribute("activation_Scope");

	String resend_activation_Scope  = (String)request.getAttribute("resend_activation_Scope");

	String managed_CE_Router = (String)request.getAttribute("managed_CE_Router");

	String routing   = (String)request.getAttribute("routing");

	String ospf_area = (String)request.getAttribute("ospf_area");

	String customer_as = (String)request.getAttribute("customer_as");

	String ceBasedQoS  = (String)request.getAttribute("ceBasedQoS");

	String addressFamily = (String)request.getAttribute("AddressFamily");

	String peRouter = (String)request.getAttribute("perouter");

	String peInterface = (String)request.getAttribute("peinterface");
	String ipaddrlist = (String)request.getAttribute("ipaddrlist");

	CAR multicastRateLimit = null;

	multicastRateLimit = (CAR)request.getAttribute("multicastRateLimit");

	Service[] sites = (Service[])request.getAttribute("available_sites");

	ServiceParameter[] available_regions = (ServiceParameter[])request.getAttribute("available_regions");

    ServiceParameter[] available_locations = (ServiceParameter[])request.getAttribute("available_locations");



	HashMap managedCERouters = new HashMap ();

	managedCERouters = (HashMap)request.getAttribute("managedCERouters");

	 List<String> iplist = new  ArrayList<String>();
	 iplist=(List<String>)request.getAttribute("iplist");

	HashMap<String, String> peList = new HashMap<String, String> ();

	peList = (HashMap<String, String>)request.getAttribute("peList");

	

	HashMap<String, String> ifList = new HashMap<String, String> ();

	ifList = (HashMap<String, String>)request.getAttribute("ifList");

	

    String attachmentid = (String)request.getAttribute("attachmentid");



	String resendCreate = (String)request.getAttribute("resend");

	Boolean resend = resendCreate!=null && resendCreate.equals("true");

	

	String ServiceMultiplexing = (String)request.getAttribute("ServiceMultiplexing");

	if(ServiceMultiplexing == null) ServiceMultiplexing = "false";

	

//	 avoid combox lose selected value when refresh

	String presnamelist =  (String)request.getParameter("presnamelist");

	String managed_ce_router_flag =  (String)request.getParameter("managed_ce_router_flag");

 	if (presname == null) { presname = ""; }



     String link_part0 = "&mv=" + mv +

                       "&currentPageNo=" + currentPageNo +

                       "&viewPageNo=" + viewPageNo +

					   "&resend=" + resendCreate;



	String link_part1 = "'/crm/CreateService.do?serviceid=" + serviceid +

                      "&customerid=" + customerId +

                      "&parentserviceid=" + parentserviceid +

                      "&type=" + type +link_part0;



	String link_part2="";



	if(subType.equals("GIS-Protection") || resend){

		

	



		 link_part2 = "&presname=' + ServiceForm.presname.value + " +

	                      "'&SP_Location=' + ServiceForm.SP_Location.value + " +

	            	   "'&SP_vpnserviceid=' + ServiceForm.SP_vpnserviceid.value + " +

	                      "'&SP_CAR=' + ServiceForm.SP_CAR.options[ServiceForm.SP_CAR.selectedIndex].value + " +

		                "'&SP_Activation_Scope=' + ServiceForm.SP_Activation_Scope.options[ServiceForm.SP_Activation_Scope.selectedIndex].value + '" +

	                     "&SP_Managed_CE_Router='+ ServiceForm.SP_Managed_CE_Router.value + " +

	                      "'&SP_RoutingProtocol=' + ServiceForm.SP_RoutingProtocol.value + " +

	                   //   "'&SP_Comment=' + ServiceForm.SP_Comment.value + "  +

	                      "'&SP_StartTime=' + ServiceForm.SP_StartTime.value + "+

	                      "'&SP_EndTime=' + ServiceForm.SP_EndTime.value +"+

	                      "'&SP_Region=' + ServiceForm.SP_Region.value +" +

	                      "'&SP_QOS_PROFILE=' + ServiceForm.SP_QOS_PROFILE.options[ServiceForm.SP_QOS_PROFILE.selectedIndex].value +" +

	                      "'&SP_CE_based_QoS=' + ServiceForm.SP_CE_based_QoS.value +" +

	                      "'&SP_QOS_BASE_PROFILE=' + ServiceForm.SP_QOS_BASE_PROFILE.value +" +

	                      "'&SP_PERouter=' + ServiceForm.SP_PERouter.options[ServiceForm.SP_PERouter.selectedIndex].value + " +

	    				  "'&SP_PEInterface=' + ServiceForm.SP_PEInterface.options[ServiceForm.SP_PEInterface.selectedIndex].value + " +

	                      //"'&presnamelist=' + ServiceForm.presnamelist.options[presnamelist.selectedIndex].value + " +

	                      //"'&managed_ce_router_flag=' + ServiceForm.managed_ce_router_flag.value + " +

	                      "'&attachmentid=' + ServiceForm.attachmentid.value + " +

						  "'&subType=' + ServiceForm.subType.value" ;

		if(pools != null)

		{

			link_part2 +=  "+'&SP_AddressPool=' + ServiceForm.SP_AddressPool.options[ServiceForm.SP_AddressPool.selectedIndex].value";


			link_part2 +=  "+'&SP_IPNetAddr=' + ServiceForm.SP_IPNetAddr.options[ServiceForm.SP_IPNetAddr.selectedIndex].value";
			
		}

		if(addressFamily != null)

			link_part2 +=  "+'&SP_AddressFamily=' + ServiceForm.SP_AddressFamily.options[ServiceForm.SP_AddressFamily.selectedIndex].value";



	    link_part2 += "+'&reselect=" + resend +"'";

		link_part2 += "+'&resend_SP_Activation_Scope=" + resend_activation_Scope +"'";



	}else{



		 link_part2 = "&presname=' + ServiceForm.presname.value + " +

	                      "'&SP_Location=' + ServiceForm.SP_Location.options[ServiceForm.SP_Location.selectedIndex].value + " +

	            	  "'&SP_vpnserviceid=' + ServiceForm.SP_vpnserviceid.value + " +

	                      "'&SP_CAR=' + ServiceForm.SP_CAR.options[ServiceForm.SP_CAR.selectedIndex].value + " +



	                      "'&SP_Activation_Scope=' + ServiceForm.SP_Activation_Scope.options[ServiceForm.SP_Activation_Scope.selectedIndex].value + " +

	                     "'&SP_Managed_CE_Router='+ ServiceForm.SP_Managed_CE_Router.options[ServiceForm.SP_Managed_CE_Router.selectedIndex].value + " +

	                      "'&SP_RoutingProtocol=' + ServiceForm.SP_RoutingProtocol.options[ServiceForm.SP_RoutingProtocol.selectedIndex].value + " +

	                    //  "'&SP_Comment=' + ServiceForm.SP_Comment.value + "  +

	                      "'&SP_StartTime=' + ServiceForm.SP_StartTime.value + "+

	                      "'&SP_EndTime=' + ServiceForm.SP_EndTime.value +"+

	                      "'&SP_Region=' + ServiceForm.SP_Region.options[ServiceForm.SP_Region.selectedIndex].value +" +

	                      "'&SP_QOS_PROFILE=' + ServiceForm.SP_QOS_PROFILE.options[ServiceForm.SP_QOS_PROFILE.selectedIndex].value +" +

	                      "'&SP_CE_based_QoS=' + ServiceForm.SP_CE_based_QoS.value +" +

	                      "'&SP_QOS_BASE_PROFILE=' + ServiceForm.SP_QOS_BASE_PROFILE.value +" +

	                      "'&SP_PERouter=' + ServiceForm.SP_PERouter.options[ServiceForm.SP_PERouter.selectedIndex].value + " +

	    	    		  "'&SP_PEInterface=' + ServiceForm.SP_PEInterface.options[ServiceForm.SP_PEInterface.selectedIndex].value + " +

	                      "'&presnamelist=' + ServiceForm.presnamelist.options[ServiceForm.presnamelist.selectedIndex].value + " +

	                      "'&managed_ce_router_flag=' + ServiceForm.managed_ce_router_flag.value + " +

	                      "'&attachmentid=' + ServiceForm.attachmentid.value + " +

						"'&subType=' + ServiceForm.subType.value" ;

	   if(pools != null && !resend)

	   {

			 link_part2 +=  "+'&SP_AddressPool=' + ServiceForm.SP_AddressPool.options[ServiceForm.SP_AddressPool.selectedIndex].value";

			

			 link_part2 +=   "+'&SP_IPNetAddr=' + ServiceForm.SP_IPNetAddr.options[ServiceForm.SP_IPNetAddr.selectedIndex].value";
	   }



	   if(addressFamily != null && !resend )

			link_part2 +=  "+'&SP_AddressFamily=' + ServiceForm.SP_AddressFamily.options[ServiceForm.SP_AddressFamily.selectedIndex].value";



	}





	int rowCounter;



	try {

	  rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));

	}

	catch (Exception e) {

	  rowCounter = 0;

	}





	if (regions != null)

	  if (region == null) {

	    region = regions[0].getPrimaryKey();

	  }



	if (pools != null)

	{

	  if (pool == null) 

	  {

		 pool = pools[0].getPrimaryKey();

	  }

	  if (secondaryPool == null) 

	  {

		 secondaryPool = "-none-";

	  }

	}



	EXPMapping[] mappings =  (EXPMapping[])request.getAttribute("mappings");



    int mappingsLength = mappings == null ? 0 : mappings.length;

	for(int i = 0; i < mappingsLength; i++)

	{

	    EXPMapping expMapping = mappings[i];

	      link_part2 += "+'&SP_QOS_CLASS_"+expMapping.getPosition()+"_PERCENT=' " +

	          "+ ServiceForm.SP_QOS_CLASS_"+expMapping.getPosition()+"_PERCENT.value";



	      } //for



	if(addressFamily == null)

			addressFamily = (String)request.getAttribute("SP_AddressFamily");



	car = request.getParameter("SP_CAR");

	 if (car == null) {

	  car = (String) parentServiceParameters.get ("CAR");

	  }





	ceBasedQoS = request.getParameter("SP_CE_based_QoS");



    if (ceBasedQoS == null) {

		ceBasedQoS = (String) parentServiceParameters.get ("CE_based_QoS");



    }

	

	if (activation_Scope == null){

		activation_Scope = request.getParameter("SP_Activation_Scope");

	}

	



	if (activation_Scope == null) {

    	activation_Scope = (String) parentServiceParameters.get ("Activation_Scope");

    }



  	managed_CE_Router = request.getParameter("SP_Managed_CE_Router");





	if (managed_CE_Router == null) {

	  managed_CE_Router = (String) parentServiceParameters.get ("CE_Routers_managed_per_default");

	}



	if (managed_CE_Router == null) {

	  managed_CE_Router = (String) parentServiceParameters.get ("Managed_CE_Router");

	  }



	connectivityType = request.getParameter("SP_ConnectivityType");

    if (connectivityType == null) {

  		 connectivityType = (String) parentServiceParameters.get ("ConnectivityType");



    }





    //presname = serviceForm.getPresname();

   routing = (String)request.getAttribute("SP_RoutingProtocol");

    if (routing == null) {

         routing   = (String) parentServiceParameters.get ("RoutingProtocol");

    }



	if (routing == null) {

      routing = "STATIC";

    }

    if (routing.equals("BGP")){

        link_part2 +=   "+'&SP_Customer_ASN=' + ServiceForm.SP_Customer_ASN.value";

    }   else

        if (routing.equals("OSPF")){

            link_part2 +=    "+'&SP_OSPF_Area=' + ServiceForm.SP_OSPF_Area.value";

    }



   if(ospf_area == null)

    ospf_area = request.getParameter("SP_OSPF_Area");

    if(ospf_area == null || ospf_area.equals("")){

       	 ospf_area = (String) parentServiceParameters.get ("OSPF_Area");

	   }



	if(customer_as == null)

	  customer_as = request.getParameter("SP_Customer_ASN");

	   if(customer_as == null || customer_as.equals("")){

	  				 customer_as = (String) parentServiceParameters.get ("Customer_ASN");

	   }

%>



<% //staticcounter,include,mask etc --



    String strstaticCounter = (String)request.getAttribute("staticCounter");

	//String strstaticCounter = serviceForm.getStaticCounter();

	String strprefixCounter =(String)request.getAttribute("prefixCounter");	

	int prefixCounter=1;

	

    int staticCounter = 1;

    

    String removeEntryLink = link_part2;

    String removeEntryLink1=link_part2;

    

  //  System.out.println("routing protocol"+routing);



    if (routing.equals("STATIC"))

		{



    	//  out.print("RELOADED STATIC"); 

      %>



<%   if(strstaticCounter == null)

	  {

	    staticCounter = 1;

	%>

       <input type="hidden" name="staticCounter" value="1">

<%      }

	else

		{

        staticCounter = Integer.parseInt(strstaticCounter);

	    String strInclude = (String)request.getAttribute("include");

        %>

       <input type="hidden" name="staticCounter" value="<%= staticCounter %>">

<%   }





         for (int k = 0; k < staticCounter; k++)

		 {

             link_part2 += " + '&route" + k + "=' + ServiceForm.route" + k + ".value";

             link_part2 += " + '&mask" + k + "=' + ServiceForm.mask" + k + ".value";

               if(k < staticCounter - 1)

                   removeEntryLink = link_part2;

          }

            link_part2 += "+'&staticCounter=" + staticCounter+'\'';

            removeEntryLink += "+'&staticCounter=" + (staticCounter - 1)+'\'';



      }

    

    if(routing.equals("BGP")) {

    	

    	 if(strprefixCounter == null)

   	  {

    		 prefixCounter = 1;

 %>

  <input type="hidden" name="prefixCounter" value="1">

 

 <%} else {

	 prefixCounter = Integer.parseInt(strprefixCounter);

	    String strInclude = (String)request.getAttribute("include");

 

 %>

	   <input type="hidden" name="prefixCounter" value="<%=prefixCounter%>">

	 

<% }



         for (int k = 0; k < prefixCounter; k++)

		 {

             link_part2 += " + '&prefixroute" + k + "=' + ServiceForm.prefixroute" + k + ".value";

             link_part2 += " + '&prefixmask" + k + "=' + ServiceForm.prefixmask" + k + ".value";
             
             
             link_part2 += " + '&lemask" + k + "=' + ServiceForm.lemask" + k + ".value";
             

               if(k < prefixCounter - 1)

            	   removeEntryLink1 = link_part2;

          }

            link_part2 += "+'&prefixCounter=" + prefixCounter+'\'';

            removeEntryLink1 += "+'&prefixCounter=" + (prefixCounter - 1)+'\''; 

    	 

    } %> 



 <html:hidden  property="SP_Attachmenttype" name="SP_Attachmenttype" value="<%=attachment_type%>"/>

<input type="hidden" id="manualSet">

 <input type="hidden" name="subType" value="<%= subType %>">

 <input type="hidden" name ="reuse_service_identity" value=<%= serviceid %>>



<%if(!type.equals("GIS-Attachment") && !type.equals("GIS-Protection")){%>



		<tr height="30">

		  <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

		  <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.l3sitename" /></b></td>

		  <td class="list<%= (rowCounter % 2) %>" align=left>

		  <select style="position:absolute;width:227px;" onchange="Combo_Select(this,presname);handleReuseAction(this)" id="presnamelist" name="presnamelist" >

            <option/>

            <%if ( sites != null ) {

                 for (int i=0; i<sites.length; i++) {

			%>       <option value="<%=sites[i].getServiceid()%>" <%= sites[i].getServiceid().equals(presnamelist) ? " selected": ""%>><%= sites[i].getPresname()%></option>

			<%   }

			  }

			%>

		  </select>

		  <input style="position:absolute;width:210px;" type="text" id="presname" name="presname" maxlength="200" onKeyPress="Text_ChkKey(presnamelist,this)" onFocus="handleHintWhenOnFocus(this,'Input or select site name')" onBlur="handleHintWhenOnBlur(this,'Input or select site name')" value="<%= presname == null || "".equals(presname) ? "Input or select site name" : presname%>"><br></td>

		  <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

		</tr>



<% rowCounter++; %>

<%}



if(type.equals("GIS-Attachment") || type.equals("GIS-Protection")){%>



	<html:hidden  property="presname" name="presname" value="<%= parentServiceName+\"-\"+type%>"/>

<%}%>



<input type="hidden" name="ServiceMultiplexing" id="ServiceMultiplexing" value=<%=ServiceMultiplexing==null? "false":ServiceMultiplexing %>>

<input type="hidden" name="SP_vpnserviceid" value="<%= vpnserviceid %>">

<input type="hidden" name="attachmentid" value="<%= attachmentid %>">

<input type="hidden" name="resend" value=<%= resendCreate %>>



<%







if(subType.equals("GIS-Attachment")){





%>



<!--------------------------------------------------------------->

    <tr height="30">

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

      <td align=left class="list<%= (rowCounter % 2) %>"><b>

	  <bean:message key="label.l2site.region" /></b></td>

      <td align=left class="list<%= (rowCounter % 2) %>">

      <select name="SP_Region" onchange="location.href = <%= link_part1 + link_part2 %>;" <%= !"true".equals(resendCreate) ? "" : "disabled" %> >



<%    if (regions != null) {

        if (region == null) {

          region = regions[0].getPrimaryKey();

        }



        for (int i=0; regions != null && i < regions.length; i++) { %>

          <option<%= regions[i].getName().equals (region) ? " selected": "" %> value="<%=  regions[i].getName() %>"><%= regions[i].getName() %></option>

<%

         }

      }

%>

      </select>

	  </td>

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

    </tr>





  <% rowCounter++; %>

<!------------------------------------------------------------>



<!------------------------------------------------------------>

     <tr height="30">

          <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

          <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.l2site.loc" /></b></td>

          <td align=left class="list<%= (rowCounter % 2) %>">

          <select name="SP_Location" onchange="location.href = <%= link_part1 + link_part2 %>;"  <%= !"true".equals(resendCreate) ? "" : "disabled" %>>



    <%    if (locations != null) {

            if (location == null) {

              location = locations[0].getPrimaryKey();

            }



            for (int i=0; locations != null && i < locations.length; i++) { %>

              <option<%= locations[i].getName().equals (location) ? " selected": "" %> value="<%=  locations[i].getName() %>"><%= locations[i].getName() %></option>

    <%      }

          }

    %>

          </select>



    	  </td>

          <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

        </tr>









<!---------------------------------------------------------------------->

  <% rowCounter++; %>





<%}else{%>







<!--------------------------------------------------------------->

    <tr height="30">

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

      <td align=left class="list<%= (rowCounter % 2) %>"><b>

	  <bean:message key="label.l2site.region" /></b></td>



	 <td align=left class="list<%= (rowCounter % 2) %>">

                <%=parentServiceParameters.get("Region")%>

	  </td>

	<input type="hidden" name="SP_Region" value="<%=parentServiceParameters.get("Region")%>">

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

    </tr>



        <% rowCounter++; %>

 <!------------------------------------------------------------>









  <tr height="30">

          <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

          <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.l2site.loc" /></b></td>

          <td align=left class="list<%= (rowCounter % 2) %>">

           <%= parentServiceParameters.get("Location")%>

       	  </td>

          <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

        </tr>

	<input type="hidden" name="SP_Location" value="<%= parentServiceParameters.get("Location")%>">

        <% rowCounter++; %>

    <!------------------------------------------------------------>









<%}%>






	<tr height="30">

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

      <td align=left class="list<%= (rowCounter % 2) %>"><b>PE Router</b></td>

      <td align=left class="list<%= (rowCounter % 2) %>">

      <select name="SP_PERouter" onchange="location.href = <%= link_part1 + link_part2 %>;">

  <%    if (peList != null) 

		{

			for (Map.Entry<String, String> entry: peList.entrySet())

			{	

				String attr = entry.getKey();

				String val = entry.getValue();

				

				if (peRouter != null && peRouter.equals(attr))

				{

				%>

					<option value="<%=attr%>" selected><%=val%></option>

				<%

				}

				else

				{

				%>

					<option value="<%=attr%>"><%=val%></option>

				<%

				}

			}

        }%>

        </select>



      </td>

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

    </tr>

    <% rowCounter++; %>

	<tr height="30">

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

      <td align=left class="list<%= (rowCounter % 2) %>"><b>PE Interface</b></td>

      <td align=left class="list<%= (rowCounter % 2) %>">

      <select name="SP_PEInterface">

  <%    if (ifList != null && !ifList.isEmpty()) 

		{

			for (Map.Entry<String, String> entry: ifList.entrySet())

			{	

				String attr = entry.getKey();

				String val = entry.getValue();

				

				if (peInterface != null && peInterface.equals(attr))
				{
				%>
					<option value="<%=attr%>" selected><%=val%></option>
				<%

				}

				else

				{			
				%>

					<option value="<%=attr%>"><%=val%></option>

				<%
				}
			}

        }else {%>

        <option value="none">-none-</option>

        <% } %>

        </select>



      </td>

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

    </tr>

     <% rowCounter++; %>




    <tr height="30">

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.l2site.rlimit" /></b></td>

      <td align=left class="list<%= (rowCounter % 2) %>">



      <select name="SP_CAR"   onChange="setAbsolutRL();">



<%    if (cars != null) {

        String aux = car;

        if (car == null) {

          aux = cars[0].getPrimaryKey();

        }



        for (int i = 0; i < cars.length; i++) {



            if(multicastRateLimit != null && cars[i].getAveragebw() < multicastRateLimit.getAveragebw())

            continue;

			%>

          <option<%= cars[i].getPrimaryKey().equals (aux) ? " selected" : "" %> value="<%= cars[i].getPrimaryKey() %>"><%= cars[i].getPrimaryKey() %>bps</option>

<%      }

     } %>

      </select>

    </td>

    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

  </tr>



  <% rowCounter++; %>

<%

if(subType.equals("GIS-Attachment")){

%>

<%

  // If the VPN topology was set to Hub and spoke or composite then make it possible to select connectivity type for this site.

  if ((parentServiceParameters.get("VPNTopology") != null) &&

          parentServiceParameters.get("VPNTopology").toString().equals("Hub-and-Spoke")

      ) {



    link_part2 += " + '&SP_ConnectivityType=' + ServiceForm.SP_ConnectivityType.options[ServiceForm.SP_ConnectivityType.selectedIndex].value";

  }

 }

%>



<%@include file="qos.jsp"  %>







<%

if(subType.equals("GIS-Attachment")){





%>





   <!--------------------------CONNECTIVITY---------------------------------->

<%

  if ((parentServiceParameters.get("VPNTopology") != null) &&

          parentServiceParameters.get("VPNTopology").toString().equals("Hub-and-Spoke")

      ) {

%>

    <tr height="30">

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.site.conn.type" /></b></td>

      <td align=left class="list<%= (rowCounter % 2) %>">

        <select name="SP_ConnectivityType" onChange="location.href = <%= link_part1 + link_part2 %>;">

<%        // Hub and Spoke

          if ((parentServiceParameters.get("VPNTopology") != null) && parentServiceParameters.get("VPNTopology").toString().equals("Hub-and-Spoke")) { %>

            <option <%= connectivityType != null && connectivityType.equals("hub") ? " selected": "" %> value="hub">Hub</option>

            <option <%= connectivityType != null && connectivityType.equals("spoke") ? " selected": "" %> value="spoke">Spoke</option>

<%        } %>



        </select>

      </td>

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

    </tr>

  <% rowCounter++; %>

<%} else {

    // Always set connectivity type to mesh if nothing is done! %>

    <input type="hidden" name="SP_ConnectivityType" value="mesh">

<%} %>



  <tr height="30">

    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

    <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.mgd.cerouter" /></b></td>

    <td class="list<%= (rowCounter % 2) %>" align=left>



      <select <%="true".equals(managed_ce_router_flag)? "disabled" : ""%> name="SP_Managed_CE_Router" onChange="location.href = <%= link_part1 + link_part2 %>;">

        <% if (managed_CE_Router != null) {%>

			<option <%= managed_CE_Router.equals("false") ? " selected": "" %> value="false">No</option>

		    <option <%= managed_CE_Router.equals("true") ? " selected": "" %> value="true">Yes</option>

        <% } else {

          if ((parentServiceParameters.get("CE_Routers_managed_per_default") != null)) { %>

		    <option <%= parentServiceParameters.get("CE_Routers_managed_per_default").toString().equals("false") ? " selected": "" %> value="false">No</option>

            <option <%= parentServiceParameters.get("CE_Routers_managed_per_default").toString().equals("true") ? " selected": "" %> value="true">Yes</option>



          <% } else { %>

	        <option selected value="true">Yes</option>

            <option value="false">No</option>

          <% } %>

        <% } %>

      </select>

      <input type="hidden" name="managed_ce_router_flag" value="<%=managed_ce_router_flag %>">

    </td>

    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

  </tr>

 <% rowCounter++; %>





<!---------------------------------------------------------------------->

<%}else{

%>





<!--------------------------------------------------------------->







   <!--------------------------CONNECTIVITY---------------------------------->



<tr height="30">

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.site.conn.type" /></b></td>

      <td align=left class="list<%= (rowCounter % 2) %>">

    	<%=parentServiceParameters.get("ConnectivityType")%>

      </td>

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

    </tr>

  <% rowCounter++; %>



<input type="hidden" name="SP_ConnectivityType" value="<%=parentServiceParameters.get("ConnectivityType")%>">







 <tr height="30">

    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

   <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.mgd.cerouter" /></b></td>

    <td class="list<%= (rowCounter % 2) %>" align=left> <%=parentServiceParameters.get("Managed_CE_Router")%>

  </td>

    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

  </tr>

  <input type="hidden" name="SP_Managed_CE_Router" value="<%=parentServiceParameters.get("Managed_CE_Router")%>">



  <% rowCounter++; %>





<%}%>



<%

  if("true".equalsIgnoreCase(managed_CE_Router) && !"IPv6".equals(addressFamily)){





%>



<tr>

  <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

  <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.cebasedQos" /></b></td>

  <td class="list<%= (rowCounter % 2) %>" align=left>

    <select name="SP_CE_based_QoS" onChange="location.href = <%= link_part1 + link_part2 %>;">

      <option <%= "false".equals(ceBasedQoS) ? " selected": "" %> value="false">Disabled</option>

      <option <%= "true".equals(ceBasedQoS) ? " selected": "" %> value="true">Enabled</option>

    </select>

  </td>

  <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

</tr>



   <% rowCounter++;

  }else{

  %>

  <input type="hidden" name="SP_CE_based_QoS" value="false"/>

  <%

  }

  %>







  <tr height="30">

    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

    <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.activ.scope" /></b></td>

    <td class="list<%= (rowCounter % 2) %>" align=left>

		<%

		if(resend && "BOTH".equals(resend_activation_Scope) && "BOTH".equals(activation_Scope)){

			{

				disabled = "disabled";

			}

			

		%>

			

	    <%}

		%>

      <select name="SP_Activation_Scope" <%=disabled%>>

        <%if (activation_Scope != null) { %>

			<option <%= activation_Scope.equals("PE_ONLY") ? " selected": "" %> value="PE_ONLY">PE only</option>

			<option <%= activation_Scope.equals("CE_ONLY") ? " selected": "" %> value="CE_ONLY">CE only</option>

			<option <%= activation_Scope.equals("BOTH") ? " selected": "" %> value="BOTH">Both</option>



			<% } else {

			  if ((parentServiceParameters.get("Default_Activation_Scope") != null)) { %>

				<option <%= parentServiceParameters.get("Default_Activation_Scope").toString().equals("BOTH") ? " selected": "" %> value="BOTH">Both</option>

				<option <%= parentServiceParameters.get("Default_Activation_Scope").toString().equals("PE_ONLY") ? " selected": "" %> value="PE_ONLY">PE only</option>

				<option <%= parentServiceParameters.get("Default_Activation_Scope").toString().equals("CE_ONLY") ? " selected": "" %> value="CE_ONLY">CE only</option>





			  <% } else { %>

				<option selected value="BOTH">Both</option>

				<option value="PE_ONLY">PE only</option>

				<option value="CE_ONLY">CE only</option>

			  <% } %>

        <% } %>

      </select>

    </td>

    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

   </tr>



  <% rowCounter++; %>

	<!--Start  Added for IPV6 -->

	<tr height="30">

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.addressfamily" /></b></td>

      <td align=left class="list<%= (rowCounter % 2) %>">

      <select name="SP_AddressFamily" onChange="location.href = <%= link_part1 + link_part2 %>;">

		<% 

if("IPv4".equals(addressFamily)){%>

			<option value="IPv4">IPv4</option>

		<%}

		else if("IPv6".equals(addressFamily)){%>

			<option value="IPv6">IPv6</option>

		<%}%>

	 </select>



      </td>

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

    </tr>

    <% rowCounter++; %>

	<!--End  Added for IPV6 -->

    <tr height="30">

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.pe.ce.addr.pool" /></b></td>

      <td align=left class="list<%= (rowCounter % 2) %>">

      <select name="SP_AddressPool" onChange="location.href = <%= link_part1 + link_part2 %>;">

  <%    if (pools != null) {

          if (pool == null) {

			pool = pools[0].getPrimaryKey();

          }


          IPAddrPool tempPool =null ;

          for (int i=0; pools != null && i < pools.length; i++) {

         	if(pools[i].getAddressfamily().equals(addressFamily)){

         		tempPool=pools[i];%>

         		<option<%= tempPool.getName().equals (pool) ? " selected": "" %> value="<%=  tempPool.getName() %>"><%= tempPool.getName() %></option>

         <%}



           }

        }

  %>

        </select>

    	&nbsp;&nbsp;&nbsp;&nbsp;<b><bean:message key="label.pe.ce.ipnetaddr" /></b>
     	  <select name="SP_IPNetAddr" id ="SP_IPNetAddr" onChange="location.href = <%= link_part1 + link_part2 %>;">
     	<%   
     	if(iplist!=null && !iplist.isEmpty()){
	      for(int i=0;i<iplist.size();i++)
	      {    	  
	    		if (ipaddrlist != null && ipaddrlist.equals(iplist.get(i)))
				{
				%>
					<option value="<%=iplist.get(i)%>" selected><%=iplist.get(i)%></option>
				<%
				}
				else {
		 %> 
			<option value="<%=iplist.get(i) %>"><%=iplist.get(i) %></option>		
		<%
	      }	}}	
        %>
     	  </select>
     	</td>
       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    </tr>
    <% rowCounter++; %>
	
<%-- 
	<tr height="30">

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.pe.ce.secondary.addr.pool" /></b></td>

      <td align=left class="list<%= (rowCounter % 2) %>">

      <select name="SP_SecondaryAddressPool" onChange="location.href = <%= link_part1 + link_part2 %>;">

  <%    if (pools != null) 

		{		  		  

          if (secondaryPool == null) 

		  {

			%> <option value="-none-" selected >-none-</option> <%

			secondaryPool = "-none-";

		  }

		  else

		  {

			%> <option value="-none-" >-none-</option> <%

		  }

          		  

          IPAddrPool tempPool =null ;

		  

          for (int i=0; pools != null && i < pools.length; i++) 

		  {

         	if(pools[i].getAddressfamily().equals(addressFamily))

			{

         		tempPool=pools[i];%>

         		<option<%= tempPool.getName().equals (secondaryPool) ? " selected": "" %> value="<%=  tempPool.getName() %>"><%= tempPool.getName() %></option>

         <%}



           }

        }

  %>

        </select>



      </td>

      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

    </tr>

    <% rowCounter++; %> --%>

     

<%if(subType.equals("GIS-Protection")){%>



 <input type="hidden" name="SP_RoutingProtocol" value="<%=routing== null ?"BGP":routing%>">

  <tr height="30">

    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

    <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.pe.ce.routing" /></b></td>

    <td align=left class="list<%= (rowCounter % 2) %>">

     <%= routing == null ? "BGP" : routing %>

    </td>

    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

  </tr>



<% rowCounter++; }else{



%>



  <tr height="30">

    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

    <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.pe.ce.routing" /></b></td>

    <td align=left class="list<%= (rowCounter % 2) %>">

      <select id="SP_RoutingProtocol" name="SP_RoutingProtocol" onChange="location.href = <%= link_part1 + link_part2 %>;">

	    <option<%= routing != null && routing.equals ("OSPF") ? " selected" : "" %> value="OSPF">OSPF</option>

	    <option<%= routing != null && routing.equals ("STATIC") ? " selected" : "" %> value="STATIC">Static</option>

        <option<%= routing != null && routing.equals ("BGP") ? " selected" : "" %> value="BGP">BGP</option>

      </select>



    </td>

    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

  </tr>



<% rowCounter++;

}

%>











<% 

System.out.println("Routing in GIS is ::"+routing);

if (routing.equals ("BGP")) {%>

     <tr height="30">

       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

       <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.cust.asn" /></b></td>

       <td class="list<%= (rowCounter % 2) %>"><input <%=readonlyflag%> type="text" id="SP_Customer_ASN" name="SP_Customer_ASN" size="10" <%= customer_as == null ? "" : "value=\"" + customer_as + "\"" %> onchange="checkNumValue(this, '<bean:message key="js.asn.range" />')"></td>

       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

     </tr>

     <% rowCounter++; %>

     



<%   int i = 0; %>



     <tr valign="bottom" height="30">

       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

       <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.prefixlist.routes" /></b>

       <td class="list<%= (rowCounter % 2) %>">&nbsp;<b><bean:message key="label.ipprefix" /></b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>/&nbsp;&nbsp;<bean:message key="label.l3sitemask"/></b></td>

       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

     </tr>

     <% rowCounter++; %>





<%

    for (; i < prefixCounter; i++) { %>

       <tr valign="center" height="30">

         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>



      <td valign="middle" class="list<%= (rowCounter % 2) %>">

      <input type="text" name="prefixroute<%= i %>" size="25" value="<%= (String)request.getAttribute("prefixroute"+i) != null ? (String)request.getAttribute("prefixroute"+i) : "" %>"> /

	  <input type="text" name="prefixmask<%= i %>" size="3" value="<%= (String)request.getAttribute("prefixmask"+i) != null ? (String)request.getAttribute("prefixmask"+i) : "" %>">
	    &nbsp;&nbsp;le&nbsp;&nbsp;
	  <input type="text" name="lemask<%=i%>" size="3"  value="<%= (String)request.getAttribute("lemask"+i) != null ? (String)request.getAttribute("lemask"+i) : "" %>">

         </td>

         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

       </tr>

       <% rowCounter++; %>



<%   
    } 

    

 

%>

       <tr height="30">

         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

         <td class="list<%= (rowCounter % 2) %>">





           <a href="#" class="list<%= (rowCounter % 2) %>" onClick="javascript:if(checkPrefixRoutes()) location.href = <%= link_part1 + link_part2 %>+ '&include=true';"><bean:message key="label.incl.entry" /></a>

           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<%

            if(prefixCounter > 1){

%>

           <a href="#" class="list<%= (rowCounter % 2) %>" onClick="location.href = <%=link_part1 + removeEntryLink1 %>;">

		   <bean:message key="label.rem.last" /></a>

<%

            }

%>

         </td>

         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

       </tr>

     

<% } %>



<% if (routing.equals ("OSPF")) {%>

     <tr height="30">

       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

       <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.ospfarea" /></b></td>

       <td class="list<%= (rowCounter % 2) %>"><input <%=readonlyflag%> type="text" id="SP_OSPF_Area" name="SP_OSPF_Area" size="10" <%= ospf_area == null ? "" : "value=\"" + ospf_area + "\"" %>></td>

       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

     </tr>

     <% rowCounter++; %>

<% } %>



<% if (routing.equals ("STATIC")) {

    %>







<%   int i = 0; %>



     <tr valign="bottom" height="30">

       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

       <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.static.routes" /></b>

       <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.routepref" /></b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>/&nbsp;&nbsp;&nbsp;<bean:message key="label.l3sitemask" /> </b></td>

       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

     </tr>

     <% rowCounter++; %>

<!-- http://127.0.0.1:8080/portal/jsp/CreateServiceForm.jsp?serviceid=1005&customerid=1&parentserviceid=1003&type=layer3-Site&staticCounter=1&presname=&SP_Location=Copenhagen&SP_CAR=128K&SP_Activation_Scope=PE_ONLY&SP_Managed_CE_Router=false&SP_RoutingProtocol=STATIC&SP_Comment=&route0=10.10.1.1&mask0=30#-->



<%

    for (; i < staticCounter; i++) { %>

       <tr valign="center" height="30">

         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>



         <td valign="middle" class="list<%= (rowCounter % 2) %>">

           <input type="text" name="route<%= i %>" size="40" value="<%= (String)request.getAttribute("route"+i) != null ? (String)request.getAttribute("route"+i) : "" %>"> /

		   <input type="text" name="mask<%= i %>" size="3" value="<%= (String)request.getAttribute("mask"+i) != null ? (String)request.getAttribute("mask"+i) : "" %>">

         </td>

         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

       </tr>

       <% rowCounter++; %>



<%   }%>

       <tr height="30">

         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

         <td class="list<%= (rowCounter % 2) %>">





           <a href="#" class="list<%= (rowCounter % 2) %>" onClick="javascript:if(checkStaticRoutes()) location.href = <%= link_part1 + link_part2 %>+ '&include=true';"><bean:message key="label.incl.entry" /></a>

           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;







<%

            if(staticCounter > 1){

%>

           <a href="#" class="list<%= (rowCounter % 2) %>" onClick="location.href = <%= link_part1 + removeEntryLink %>;">

		   <bean:message key="label.rem.last" /></a>

<%

            }

%>

         </td>

         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

       </tr>



<% }%>

	<script LANGUAGE="JavaScript" TYPE="text/javascript">

      function checkNumValue(input, prompt){

          var str = input.value;

          var newStr = "";

          for(i = 0; i < str.length; i++){

              if(str.charAt(i) >= '0' && str.charAt(i) <= '9'){

                  newStr = newStr + str.charAt(i);

              }

          }

          if(str != newStr || newStr.length == 0 ||  str < 1 || str > 65535) {

              alert(prompt);

              input.value = newStr;

              return false;

          }

          return true;

        }





	   function checkStaticRoutes(){



			var staticcount ='<%=staticCounter%>';

         			for(ii=0;ii<staticcount;ii++)

                  	{

					  if(getObjectById('route'+ii).value.length==0 || getObjectById('mask'+ii).value.length==0)

			           {

                       alert('<bean:message key="js.static.route" />'+' '+'<bean:message key="js.Row.number" />'+(ii+1)+' '+'<bean:message key="js.static.null" />');

						 return false;

                       }

				    }

              return true;

          }

	   

	   function checkPrefixRoutes(){



		  

			var staticcount ='<%=prefixCounter%>';

        			for(ii=0;ii<staticcount;ii++)

                 	{

					  if(getObjectById('prefixroute'+ii).value.length==0 || getObjectById('prefixmask'+ii).value.length==0)

			           {

                      alert('<bean:message key="js.prefix.route" />'+' '+'<bean:message key="js.Row.number" />'+(ii+1)+' '+'<bean:message key="js.prefix.null" />');

						 return false;

                      }

				    }

        			

             return true;

         }    



      function checkOSPFArea(){



            	var validOSPF = false;

            	var OSPF=getObjectById('SP_OSPF_Area').value;

            	if(OSPF != null && OSPF <= 42949672295 && OSPF>=0 )

            	 {

            	 	validOSPF = true;

            	 	}

            	 if (!validOSPF){

								 alert('<bean:message key="js.ospf.validarea" />');

    							 return false;

							}

            return true;

      }

		function checkSitename() {

			var site = getObjectById('presname');

            var sitelist = getObjectById('presnamelist');

            var ServiceMultiplexing = getObjectById('ServiceMultiplexing');

            if (sitelist != null) {

            if (sitelist.selectedIndex > 0 && sitelist[sitelist.selectedIndex].text == site.value) {

            	ServiceMultiplexing.setAttribute("value","true");

            } else {

            	ServiceMultiplexing.setAttribute("value","false");

            }

            }

        }

        function handleManagedCERouter(siteid)

        {

          var SP_Managed_CE_Router = getObjectById('SP_Managed_CE_Router');

          var managed_ce_router_flag = getObjectById('managed_ce_router_flag');

          if (siteid != null || siteid != "") {

        	var mamagedCERouter;

        	<% for (Object s : managedCERouters.keySet()) {%>

        		if (siteid == <%=(String)s%>) {

					mamagedCERouter = "<%=((String)managedCERouters.get(s))%>";

				}

			<%}%>

			if (mamagedCERouter == "true") {

				SP_Managed_CE_Router.selectedIndex = 1;

				//SP_Managed_CE_Router.disabled = "true";

				//managed_ce_router_flag.value="true";

			} else if (mamagedCERouter == "false") {

				SP_Managed_CE_Router.selectedIndex = 0;

				//SP_Managed_CE_Router.disabled = "true";

				//managed_ce_router_flag.value="true";

			} else {

				SP_Managed_CE_Router.disabled = "";

				SP_Managed_CE_Router.selectedIndex = 0;

				managed_ce_router_flag.value="";

			}

		  } else {

		  	SP_Managed_CE_Router.disabled = "";

			SP_Managed_CE_Router.selectedIndex = 0;

			managed_ce_router_flag.value=""	;

		  }

        }

		// Handle site resue function

		function handleReuseAction(siteList)

		{

			var serviceList = getObjectById('presnamelist');

            var presname = getObjectById('presname');

            var flag = getObjectById('manualSet');



            if (serviceList.selectedIndex == 0) {

            	flag.setAttribute("value","false");

			}



       		var selValue = serviceList.options[serviceList.selectedIndex].value;



       		var td = document.getElementById('TD_serviceId');

            if (siteList.selectedIndex > 0)

			{

				td.innerHTML=siteList[siteList.selectedIndex].value;

				presname.readOnly="true";

				flag.setAttribute("value","true");

			} else

			{

            	td.innerHTML = <%= serviceid %>;

				presname.readOnly="";

				presname.focus();

            }

            handleManagedCERouter(siteList[siteList.selectedIndex].value);

			handleReusedLocation(siteList[siteList.selectedIndex].value)

		}



		function handleReusedLocation(siteid)

		{

          var SP_Region = getObjectById("SP_Region");

		  var SP_Location = getObjectById("SP_Location");

		  if (siteid != null && siteid != "") {

		   SP_Region.disabled = "true";

		   SP_Location.disabled = "true";

			<%if(available_regions != null){

				for(ServiceParameter r : available_regions){ %>

                if(siteid == <%=r.getServiceid()%>){

				    for(j=0;j<SP_Region.length;j++) {

                     if(SP_Region.options[j].value == "<%=r.getValue()%>"){

                        SP_Region.selectedIndex = j;

						SP_Region.value = "<%=r.getValue()%>";

					 } // if

				  } //  for

				} //if

			<%} //for

			} //if

			%>



           <%if(available_locations != null){

			   for(ServiceParameter l : available_locations){ %>

                if(siteid == <%=l.getServiceid()%>){

				  SP_Location.options.length = 0;

				  SP_Location.options.add(new Option("<%=l.getValue()%>", "<%=l.getValue()%>"));

				  SP_Location.value = "<%=l.getValue()%>";

				} //if

			<%} //for

		   } //if

			%>



		  } else {

		   //SP_Region.selectedIndex = 0;

           SP_Region.disabled = "";

		   //SP_Location.selectedIndex = 0;

		   SP_Location.disabled = "";

		  } //if (siteid != null && siteid != "")



		}



		function checkAll()

		{



			<% if (!"GIS-Attachment".equals(type)) { %>

			checkSitename(); // add by tommy at 2009.1.4

			<%}%>

			var submitted = true;

			var staticcount ='<%=staticCounter%>';

			var field = getObjectById('presname');

            var strValue = getObjectById('presname').value;

			var attachType = '<%=subType%>';

		 	if(getObjectById('presname').value.length==0)

		    	 {

               alert('<bean:message key="js.site.name" />');

               submitted = false;

            } 	

		 	var interface_val =getObjectById("SP_PEInterface").value;

		 	//alert(interface_val);

		 	if(interface_val=="none")

		 		{

		 		 alert('Please select Interface');

		 		 submitted = false;

		 		}

     	 if(getObjectById('SP_CAR').value.length==0)

        {

			    alert('<bean:message key="js.site.RL" />');

			    submitted = false;

		    }

		  if(getObjectById('SP_AddressPool').value.length==0)

        {

			    alert('<bean:message key="js.site.IPNET" />');

			    submitted = false;

		    }



			if(submitted)

			{

				// PR 12883 - Do not validate site name for protection attachment creation

			  if(attachType != ("GIS-Protection"))

			  {

			    if(strValue.length != 0)

				{

					if(!isSpecialCharFound(field))

					{

	                   submitted = false;

	                }

				}

			  }

			}



		 // Validation on presentation name is removed : Jimmi

		 // Submission was not allowed when protection attachment is created on a

		 //uplaoded services



			 if(submitted)

			 {

              var list = getObjectById('SP_RoutingProtocol')

			  protocol = list.value





            if(protocol == 'OSPF')

			{

                if(getObjectById('SP_OSPF_Area').value.length==0)

				        {

                    alert('<bean:message key="js.ospf.name" />');

                    submitted = false;

                }

				 var ospf_area = getObjectById('SP_OSPF_Area');

			     if(!isSpecialCharFound(ospf_area)) {

                   submitted = false;

              }

          var   check =checkOSPFArea();

          if(!check){

				  submitted = false;

				  }



            } else

            if(protocol == 'BGP')

			{

              var customerASN = getObjectById('SP_Customer_ASN');

              if(!checkNumValue(customerASN, '<bean:message key="js.asn.range" />'))

				  {

                    submitted = false;

                }

            }

                 }



             if(submitted){

			   getObjectById("SP_Region").disabled = "";

		       getObjectById("SP_Location").disabled = "";

			   getObjectById("SP_Activation_Scope").disabled = "";

               document.ServiceForm.submit();

			}else{

			    setVisible("submitObject");

			}



        }





function isIE_browser() {

    if (window.XMLHttpRequest) {

        return false;

  }	else {

        return true;

  }

}







function getObjectById(objID) {

  if (document.getElementById  &&  document.getElementById(objID)) {

    return document.getElementById(objID);

  } else {

    if (document.all  &&  document.all(objID)) {

      return document.all(objID);

    } else {

      if (document.layers  &&  document.layers[objID]) {

        return document.layers[objID];

      } else {

        return document.ServiceForm.elements[objID];

      }

    }

  }

}





function setVisible(Id) {

   if(isIE_browser()) {

        document.getElementById(Id).style.visibility = 'visible';

	} else {

        document.getElementsByName(Id)[0].style.visibility = 'visible';

	}

}




<%if(!resend && !subType.equalsIgnoreCase("GIS-Protection")){%>

if (getObjectById("presnamelist").selectedIndex > 0) {

  handleReuseAction(getObjectById("presnamelist"));

}

<%}%>

</script>
