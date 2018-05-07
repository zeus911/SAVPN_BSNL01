		<%--##############################################################################--%>
		<%--                                                                              --%>
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

		<%-- -*- html -*- --%>
		<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
		<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>

		<%@page info="Create a service" contentType="text/html;charset=UTF-8" language="java" 
		  import="com.hp.ov.activator.crmportal.action.*, java.sql.*, javax.sql.*,com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*, java.text.*, java.net.*,com.hp.ov.activator.crmportal.utils.DatabasePool,com.hp.ov.activator.crmportal.utils.*,org.apache.log4j.Logger" %>
		<%
		String ua = request.getHeader( "User-Agent" );
		boolean isFirefox = ( ua != null && ua.indexOf( "Firefox/" ) != -1 );
		boolean isMSIE = ( ua != null && ua.indexOf( "MSIE" ) != -1 );
		response.setHeader( "Vary", "User-Agent" );
		%>


		<%!
			boolean isAToM( String siteA, String siteZ)
			{
				 if (siteA.equals(siteZ))
				return false;
			  else
				return true;
			}

			//actStartValue,actEndValue is for hetrogenous scenario

			//actStartValue1,actEndValue1 is for normal scenario

			String vlanTitle(String siteA, String siteZ,String actStartValue, String actEndValue,String actStartValue1, String actEndValue1)
			{

						StringTokenizer aTok = new StringTokenizer(actStartValue, ",");
						StringTokenizer zTok = new StringTokenizer(actEndValue, ",");
						String bgVlanRange = "";
						String vlanRange = "";
						while(aTok.hasMoreTokens()) {
							if(bgVlanRange != "")
								bgVlanRange += ",";
							bgVlanRange = bgVlanRange + aTok.nextToken() + " - " + zTok.nextToken();
						}
						
						 aTok = new StringTokenizer(actStartValue1, ",");
						 zTok = new StringTokenizer(actEndValue1, ",");

						while(aTok.hasMoreTokens()) {
							if(vlanRange != "")
								vlanRange += ",";
							vlanRange = vlanRange + aTok.nextToken() + " - " + zTok.nextToken();
						}
						

						String first = "Recommended Customer provided VLAN ID range" + bgVlanRange + ". Blank for Provider managed value.";
						String second = "Recommended Customer provided VLAN ID range" + vlanRange +". Blank for Provider managed value.";
				 return isAToM(siteA, siteZ)==true?first:second;
			}

			String vlanIdLow(String siteA, String siteZ,String actStartValue,String actStartValue1) {
			  return isAToM(siteA, siteZ)==true?actStartValue:actStartValue1;
			}

			String vlanIdHigh(String siteA, String siteZ,String actEndValue,String actEndValue1) {
			  return isAToM(siteA, siteZ)==true?actEndValue:actEndValue1;
			}


			String vlanIdLowHigh(String siteA, String siteZ,String actStartValue, String actEndValue,String actStartValue1,String actEndValue1) {
						StringTokenizer aTok = new StringTokenizer(actStartValue, ",");
						StringTokenizer zTok = new StringTokenizer(actEndValue, ",");
						String bgVlanRange = "";
						String vlanRange = "";
						while(aTok.hasMoreTokens()) {
							if(bgVlanRange != "")
								bgVlanRange += ",";
							bgVlanRange = bgVlanRange + aTok.nextToken() + " - " + zTok.nextToken();
						}
						
						 aTok = new StringTokenizer(actStartValue1, ",");
						 zTok = new StringTokenizer(actEndValue1, ",");

						while(aTok.hasMoreTokens()) {
							if(vlanRange != "")
								vlanRange += ",";
							vlanRange = vlanRange + aTok.nextToken() + " - " + zTok.nextToken();
						}
			  return isAToM(siteA, siteZ)==true?bgVlanRange:vlanRange;
			}


			/*String dlciLow() {
			  return "200";
			}

			String dlciHigh() {
			  return "999";
			}*/

		%>


		<%

		  //load param parameters got here
		  Logger logger = Logger.getLogger("CRMPortalLOG");

		   ServiceForm serviceform = (ServiceForm)request.getAttribute("ServiceForm");
		   HashMap serviceParameters = new HashMap ();
		   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
		   HashMap parentServiceParameters = new HashMap ();
		   parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");
		   String serviceid = serviceform.getServiceid();
		   String parentserviceid = serviceform.getParentserviceid();
		   String customerId = serviceform.getCustomerid();
		   String type = serviceform.getType();

			DatabasePool dbp = null;
			Connection con = null;
		
   String resendCreate = (String)request.getAttribute("resend");
   Boolean resend = resendCreate!=null && resendCreate.equals("true");
ServiceParameter[] available_regions = (ServiceParameter[])request.getAttribute("available_regions");
   ServiceParameter[] available_locations = (ServiceParameter[])request.getAttribute("available_locations");
		   
		  Location[] locations_aEnd = (Location[])request.getAttribute("locations_aEnd");
		  Location[] locations_zEnd = (Location[])request.getAttribute("locations_zEnd");
		  Region[] regions = (Region[])request.getAttribute("regions");
		  CAR[] rateLimits = (CAR[])request.getAttribute("rateLimits");
		  Profile[] qosprofiles = (Profile[])request.getAttribute("qosprofiles");

		//Changes made to fix PR 14304 -- Divya

		  String PW_aEnd_location = (String)request.getAttribute("PW_aEnd_location");
		 if(PW_aEnd_location == null )
		  PW_aEnd_location = (String)serviceform.getSP_PW_aEnd_location();

		  String PW_zEnd_location =  (String)request.getAttribute("PW_zEnd_location");
		  if(PW_zEnd_location == null)
		   PW_zEnd_location =  (String)serviceform.getSP_PW_zEnd_location();

		//ends here for PR 14304
		  String PW_aEnd_region =  (String)request.getAttribute("PW_aEnd_region");
		  String PW_zEnd_region =  (String)request.getAttribute("PW_zEnd_region");

		  String presname = serviceform.getPresname();

		  // PW_Type states the type of service: FR, PPP, Ethernet
		  String PW_Type_aEnd =  (String)request.getAttribute("PW_Type_aEnd");
		  String PW_Type_zEnd =  (String)request.getAttribute("PW_Type_zEnd");

		  // EthType states the type of service: port or port-vlan
		  String EthType_aEnd =  (String)request.getAttribute("EthType_aEnd");
		  String EthType_zEnd =  (String)request.getAttribute("EthType_zEnd");

		  String UNIType_aEnd =  (String)request.getAttribute("UNIType_aEnd");
		  String UNIType_zEnd =  (String)request.getAttribute("UNIType_zEnd");
      
		  String Vlan_Flag_aEnd =  (String)request.getAttribute("SP_Vlan_Flag_aEnd");
		  String Vlan_Flag_zEnd =  (String)request.getAttribute("SP_Vlan_Flag_zEnd");
		  if(Vlan_Flag_aEnd==null){Vlan_Flag_aEnd="false";}
		  if(Vlan_Flag_zEnd==null){Vlan_Flag_zEnd="false";}
		  
		  
		  String Site_Service_ID_aEnd = (String)request.getAttribute("SP_Site_Service_ID_aEnd");
		  String Site_Attachment_ID_aEnd = (String)request.getAttribute("SP_Site_Attachment_ID_aEnd");
		  String Site_Service_ID_zEnd = (String)request.getAttribute("SP_Site_Service_ID_zEnd");
		  String Site_Attachment_ID_zEnd = (String)request.getAttribute("SP_Site_Attachment_ID_zEnd");
		  Service[] sites = (Service[])request.getAttribute("available_sites");
		  
		  
		   String mv = (String)request.getAttribute("mv");
		   String currentPageNo = (String)request.getAttribute("currentPageNo");
		   String viewPageNo = (String)request.getAttribute("viewPageNo");
		   
		   // avoid combox lose selected value when refresh
		   String PW_aEndlist =  (String)request.getParameter("SP_PW_aEndlist");
		   String PW_zEndlist =  (String)request.getParameter("SP_PW_zEndlist");


		   String ServiceMultiplexing_aEnd = (String)request.getAttribute("ServiceMultiplexing_aEnd");
		   String ServiceMultiplexing_zEnd = (String)request.getAttribute("ServiceMultiplexing_zEnd");
		   

       
					String aEndBgStVlanRange = "";
					String aEndBgEndVlanRange = "";
					String zEndBgStVlanRange = "";
					String zEndBgEndVlanRange = "";
					String aEndStartVlanRange = "";
					String aEndEndVlanRange = "";
					String zEndStartVlanRange = "";
					String zEndEndVlanRange = "";
					String aEndStDlciRange = "";
					String aEndEndDlciRange = "";
					String zEndStDlciRange = "";
					String zEndEndDlciRange ="";
					String zEndDlciRange = "";
					String aEndDlciRange = "";

					VlanRange[] vlanRanges = null;
					DLCIRange[] dlciRanges = null;
					try
					{
						dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
						con = (Connection) dbp.getConnection();
						
						dlciRanges = DLCIRange.findByUsageallocationregion(con, "Attachment" , "External", PW_aEnd_region );
						if(dlciRanges == null) {
							dlciRanges = DLCIRange.findByUsageallocationregion(con, "Attachment" , "External", "Provider" );
						}
						
						//If No DLCI Ranges are defined
						
						if(dlciRanges == null) {
							aEndStDlciRange = aEndEndDlciRange = aEndDlciRange = "0";
						}
						
						else {
							for(int i=0;i<dlciRanges.length;i++) {
								if(aEndStDlciRange != "") {
									aEndStDlciRange += ",";
									aEndEndDlciRange += ",";
									aEndDlciRange += ",";
								}
								aEndStDlciRange = aEndStDlciRange + dlciRanges[i].getStartvalue();
								aEndEndDlciRange = aEndEndDlciRange + dlciRanges[i].getEndvalue();
								aEndDlciRange += dlciRanges[i].getStartvalue() + "-" + dlciRanges[i].getEndvalue();
							}
						}

						
						// DLCI For Z End
						dlciRanges = DLCIRange.findByUsageallocationregion(con, "Attachment" , "External", PW_zEnd_region );
						if(dlciRanges == null) {
							dlciRanges = DLCIRange.findByUsageallocationregion(con, "Attachment" , "External", "Provider" );
						}
						
						//If No DLCI Ranges are defined

						if(dlciRanges == null) {
							zEndStDlciRange = zEndEndDlciRange = zEndDlciRange = "0";
						}
						
						else {
							for(int i=0;i<dlciRanges.length;i++) {
								if(  zEndStDlciRange != "") {
									zEndStDlciRange += ",";
									zEndEndDlciRange += ",";
									zEndDlciRange += ",";
								}
								zEndStDlciRange = zEndStDlciRange + dlciRanges[i].getStartvalue();
								zEndEndDlciRange = zEndEndDlciRange + dlciRanges[i].getEndvalue();
								zEndDlciRange += dlciRanges[i].getStartvalue() + "-" + dlciRanges[i].getEndvalue();
							}
						}


						//For Bridge Group
						vlanRanges = VlanRange.findByUsageallocationregion(con,"BridgeGroup","Internal",PW_aEnd_region);
						if(vlanRanges == null) {
							vlanRanges = VlanRange.findByUsageallocationregion(con,"BridgeGroup","Internal","Provider");
						}
						
						//If no vlanRanges are defined
						if(vlanRanges == null) {
							aEndBgStVlanRange = aEndBgEndVlanRange = "0";
						}
						else {
							for(int i=0; i< vlanRanges.length;i++) {
					
								aEndBgStVlanRange = aEndBgStVlanRange + vlanRanges[i].getStartvalue()  + ",";
								aEndBgEndVlanRange =  aEndBgEndVlanRange + vlanRanges[i].getEndvalue()   + ",";;
							}
						}
						//For Bridge Group Z End
						vlanRanges = VlanRange.findByUsageallocationregion(con,"BridgeGroup","Internal",PW_zEnd_region);
						if(vlanRanges == null) {
							vlanRanges = VlanRange.findByUsageallocationregion(con,"BridgeGroup","Internal","Provider");
						}
						//If no vlanRanges are defined
						if(vlanRanges == null) {
							zEndBgStVlanRange = zEndBgEndVlanRange = "0";
						}
						else {
							for(int i=0; i< vlanRanges.length;i++) {
						
								zEndBgStVlanRange = zEndBgStVlanRange + vlanRanges[i].getStartvalue()  + ",";
								zEndBgEndVlanRange =  zEndBgEndVlanRange + vlanRanges[i].getEndvalue()  + ",";
							}
						}

						//For Vlan Ranges a End

						vlanRanges = VlanRange.findByUsageallocationregion(con,"Attachment","External",PW_aEnd_region);
						if(vlanRanges == null) {
							vlanRanges = VlanRange.findByUsageallocationregion(con,"Attachment","External","Provider");
						}

						//If no vlanRanges are defined
						if(vlanRanges == null) {
							aEndStartVlanRange = aEndEndVlanRange = "0";
						}
						else {
							for(int i=0; i< vlanRanges.length;i++) {
					
								aEndStartVlanRange = aEndStartVlanRange + vlanRanges[i].getStartvalue()  + ",";
								aEndEndVlanRange =  aEndEndVlanRange + vlanRanges[i].getEndvalue()  + ",";
							}
						}
						//For Vlan Ranges z End

						vlanRanges = VlanRange.findByUsageallocationregion(con,"Attachment","External",PW_zEnd_region);
						if(vlanRanges == null) {
							vlanRanges = VlanRange.findByUsageallocationregion(con,"Attachment","External","Provider");
						}
						//If no vlanRanges are defined
						if(vlanRanges == null) {
							zEndStartVlanRange = zEndEndVlanRange = "0";
						}
						else {
							for(int i=0; i< vlanRanges.length;i++) {
						
								zEndStartVlanRange = zEndStartVlanRange + vlanRanges[i].getStartvalue()  + ",";
								zEndEndVlanRange =  zEndEndVlanRange + vlanRanges[i].getEndvalue()  + ",";
							}
						}
						
						
					}
					catch(Exception e)
					{
						logger.debug("Exception retrieving start value and endvalue"+e.getMessage());
					}
					finally
					{
					
					if(con != null)
					 dbp.releaseConnection(con);
				  }
				   

		  String link_part = "'/crm/CreateService.do?serviceid=" + serviceid +
							 "&customerid=" + customerId +							 
							 "&SP_Site_Service_ID_aEnd=" + Site_Service_ID_aEnd +
							 "&SP_Site_Attachment_ID_aEnd=" + Site_Attachment_ID_aEnd +
							 "&SP_Site_Service_ID_zEnd=" + Site_Service_ID_zEnd +
							 "&SP_Site_Attachment_ID_zEnd=" + Site_Attachment_ID_zEnd +
							 //"&parentserviceid=" + parentserviceid +
							  "&mv=" + mv +
							 "&currentPageNo=" + currentPageNo +
							 "&viewPageNo=" + viewPageNo +
							 "&resend=" + resendCreate +
							 "&reselect=" + resend +
							 "&type=" + "layer2-VPWS" + 
							 "&presname=' + ServiceForm.presname.value + " +
							 "'&SP_PW_aEnd=' + ServiceForm.SP_PW_aEnd.value + " +
							 "'&SP_PW_zEnd=' + ServiceForm.SP_PW_zEnd.value + " +
							 "'&SP_PW_aEnd_location=' + ServiceForm.SP_PW_aEnd_location.options[SP_PW_aEnd_location.selectedIndex].value + " +
							 "'&SP_PW_zEnd_location=' + ServiceForm.SP_PW_zEnd_location.options[SP_PW_zEnd_location.selectedIndex].value + " +
							 "'&SP_Region=' + ServiceForm.SP_Region.value + " +
							 "'&SP_PW_aEnd_region=' + ServiceForm.SP_PW_aEnd_region.options[SP_PW_aEnd_region.selectedIndex].value + " +
							 "'&SP_PW_zEnd_region=' + ServiceForm.SP_PW_zEnd_region.options[SP_PW_zEnd_region.selectedIndex].value + " +
							 "'&SP_RL=' + ServiceForm.SP_RL.value + " +
							 "'&SP_QOS_PROFILE=' + ServiceForm.SP_QOS_PROFILE.value + " + 
							 "'&SP_UNIType_aEnd=' + ServiceForm.SP_UNIType_aEnd.value + " +
							 "'&SP_UNIType_zEnd=' + ServiceForm.SP_UNIType_zEnd.value + " +
							 "'&SP_Vlan_Flag_aEnd=' + ServiceForm.SP_Vlan_Flag_aEnd.value + " +
							 "'&SP_Vlan_Flag_zEnd=' + ServiceForm.SP_Vlan_Flag_zEnd.value + " +
							 "'&SP_PW_aEndlist=' + ServiceForm.SP_PW_aEndlist.options[SP_PW_aEndlist.selectedIndex].value + " +
							 "'&SP_PW_zEndlist=' + ServiceForm.SP_PW_zEndlist.options[SP_PW_zEndlist.selectedIndex].value + " +
							 "'&SP_Comment=' + ServiceForm.SP_Comment.value";

		  int rowCounter;

		  try {
			rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
		  } catch (Exception e) {
			rowCounter = 0;
		  }

		/** if ("Ethernet".equals(PW_Type_aEnd)) {
			EthType_aEnd   = (String) serviceParameters.get ("EthType_aEnd");
			if (EthType_aEnd == null) 
			  EthType_aEnd = request.getParameter ("SP_EthType_aEnd");
			if (EthType_aEnd == null)
			  EthType_aEnd = "Port";

			if (!"Ethernet".equals(PW_Type_zEnd))
			  EthType_aEnd = "VPWS-PortVlan";
		  }

		  if ("Ethernet".equals(PW_Type_zEnd)) {
			EthType_zEnd   = (String) serviceParameters.get ("EthType_zEnd");
			if (EthType_zEnd == null) 
			  EthType_zEnd = request.getParameter ("SP_EthType_zEnd");
			if (EthType_zEnd == null)
			  EthType_zEnd = "Port";

			if (!"Ethernet".equals(PW_Type_aEnd))
			  EthType_zEnd = "VPWS-PortVlan";
		  }

		  if ("Ethernet".equals(PW_Type_aEnd) && "Ethernet".equals(PW_Type_zEnd)) {
			if ("true".equals(request.getParameter("aEndSelected"))) {
			  EthType_zEnd = EthType_aEnd;
			}
			if ("true".equals(request.getParameter("zEndSelected"))) {
			  EthType_aEnd = EthType_zEnd;
			}
		  }

		  String PW_aEnd = (String) serviceParameters.get("PW_aEnd");
		  if (PW_aEnd == null) {
			PW_aEnd = request.getParameter("SP_PW_aEnd");
		  }

		  String PW_zEnd = (String) serviceParameters.get("PW_zEnd");
		  if (PW_zEnd == null) {
			PW_zEnd = request.getParameter("SP_PW_zEnd");
		  }


		  String VLANIdaEnd = (String) serviceParameters.get("VLANIdaEnd");
		  if (VLANIdaEnd == null) {
			VLANIdaEnd = request.getParameter("SP_VLANIdaEnd");
		  }

		  String VLANIdzEnd = (String) serviceParameters.get("VLANIdzEnd");
		  if (VLANIdzEnd == null) {
			VLANIdzEnd = request.getParameter("SP_VLANIdzEnd");
		  }

		  String DLCIaEnd = (String) serviceParameters.get("DLCIaEnd");
		  if (DLCIaEnd == null) {
			DLCIaEnd = request.getParameter("SP_DLCIaEnd");
		  }

		  String DLCIzEnd = (String) serviceParameters.get("DLCIzEnd");
		  if (DLCIzEnd == null) {
			DLCIzEnd = request.getParameter("SP_DLCIzEnd");
		  }

**/

		  
		  String rateLimit = (String)request.getAttribute("SP_RL");
		  String qosprofileName = (String)request.getAttribute("SP_QOS_PROFILE");

		  EthType_aEnd = (String)request.getAttribute ("EthType_aEnd");
		  EthType_zEnd = (String)request.getAttribute ("EthType_zEnd");
		  String PW_aEnd = (String)request.getAttribute ("PW_aEnd");
		  String PW_zEnd = (String)request.getAttribute ("PW_zEnd");
		  String VLANIdaEnd  = (String)request.getAttribute ("VLANIdaEnd");
		  String VLANIdzEnd  = (String)request.getAttribute ("VLANIdzEnd");
		  String DLCIaEnd   = (String)request.getAttribute ("DLCIaEnd");
		  String DLCIzEnd   = (String)request.getAttribute ("DLCIzEnd");


		   if ("layer2-VPWS".equals(serviceform.getType())&& ("true".equals(ServiceMultiplexing_aEnd) || "true".equals(ServiceMultiplexing_zEnd)))
        {
        
        EthType_aEnd= "VPWS-PortVlan";
        EthType_zEnd= "VPWS-PortVlan";
        }
		   //System.out.println(" UNIType_aEnd="+UNIType_aEnd+ " PW_Type_aEnd="+PW_Type_aEnd+ " EthType_aEnd="+EthType_aEnd);
		  
		  try {
			  if (regions != null)
				if (PW_zEnd_region == null) {
				  PW_zEnd_region = regions[0].getPrimaryKey();
				}
		   
			} catch (Exception e) { %>
			<B><bean:message key="err.l2vpws" /></B>: <%= e.getMessage () %>.
			</body>
			</html>
		<%
			  return;
			} 

		  if ("VPWS-PortVlan".equals(EthType_aEnd)) {
			   link_part += " + '&SP_VLANIdaEnd=' + ServiceForm.SP_VLANIdaEnd.value";
		  }

		  if ("VPWS-PortVlan".equals(EthType_zEnd)) {
			   link_part += " + '&SP_VLANIdzEnd=' + ServiceForm.SP_VLANIdzEnd.value";
		  }

		  if ("FrameRelay".equals(PW_Type_aEnd)) {
			   link_part += " + '&SP_DLCIaEnd=' + ServiceForm.SP_DLCIaEnd.value";
		  }

		  if ("FrameRelay".equals(PW_Type_zEnd)) {
			   link_part += " + '&SP_DLCIzEnd=' + ServiceForm.SP_DLCIzEnd.value";
		  }

		%>


		  <tr height="30">
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
			<td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.vpws.name" /></b></td>
			<td class="list<%= (rowCounter % 2) %>" align=left><input type="text" id="presname" name="presname" maxlength="32" size="32" <%= presname == null ? "" : "value=\"" + presname + "\"" %>></td>
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
		  </tr>

		  <% rowCounter++; %>
		  <tr height="30">
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
			<td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.vpws.ratelimit" /></b></td>
			<td align=left class="list<%= (rowCounter % 2) %>">
			<select name="SP_RL" onChange="setAbsolutRL();">
		<%  if (rateLimits != null) {
			  if (rateLimit == null) {
				rateLimit = rateLimits[0].getPrimaryKey();
			  }

			  for (int i=0; rateLimits != null && i < rateLimits.length; i++) { 
				 
				  
				  %>
				<option<%= rateLimits[i].getRatelimitname().equals (rateLimit) ? " selected": "" %> value="<%=  rateLimits[i].getRatelimitname() %>"><%= rateLimits[i].getRatelimitname() %></option>
		<%    }
			}
		%>
			</select>
			</td>
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	 	  
		  </tr>

		  <% rowCounter++; %>


<!-- ===================================David add started====================================   -->
<%
     Profile[] profiles;
	 Profile[] publicprofiles;
     EXPMapping[] expMappings = null;
     PolicyMapping[] policyMappings = null;
    java.util.Hashtable policyMap = new java.util.Hashtable();
	java.util.HashMap   complaintMapping = new java.util.HashMap();
    java.util.ArrayList allProfiles = new java.util.ArrayList();
    
    //request.setAttribute("SP_QOS_BASE_PROFILE", "vpws_20.20.20.20.20");
    //request.setAttribute("SP_QOS_PROFILE", "vpws_100.0.0.0.0");
    
    String selectedProfileName = null;
       selectedProfileName =    (String) request.getAttribute("SP_QOS_PROFILE");
    String  parentProfileName =  null;
        parentProfileName = (String)parentServiceParameters.get("QOS_PROFILE");

	
     if(request.getAttribute("QOS_PROFILE") == null)
        parentProfileName = null;
    
    if(request.getAttribute("SP_QOS_PROFILE") == null)
        selectedProfileName = null;

    String baseProfile = (String) request.getAttribute("SP_QOS_BASE_PROFILE");
   
    
    //System.out.println("VPWS inital params: selectedProfileName="+selectedProfileName+" parentProfileName="+parentProfileName+" baseProfile="+baseProfile);
	if(request.getAttribute("SP_QOS_BASE_PROFILE") == null)
        baseProfile = null;
 
    Profile selectedProfile = null;
    int maximumPosition = 0;
	boolean message = false;

    try {
       
        expMappings = ( EXPMapping[])request.getAttribute("expMappings");

//complaintMapping.put(profile.getQosprofilename(),profile.getCompliant());
		//if(profile.getCompliant().equalsIgnoreCase(Constants.COMPLAINT))

        // getting customer profiles

        profiles = (Profile[])request.getAttribute("profiles");
        if(profiles != null)
		{
            for (int i = 0; i < profiles.length; i++)
			{
				//allProfiles.add(profiles[i]);
              
				Profile profileObj = (Profile)profiles[i];
				
				if(profileObj.getCompliant().equalsIgnoreCase(Constants.COMPLAINT))
				{	
					allProfiles.add(profiles[i]);
				}
				else
				{
						message = true;
					if(selectedProfileName != null && profileObj.getQosprofilename().equalsIgnoreCase(selectedProfileName))
					{
						selectedProfileName = null;
						baseProfile = null;
					}
				
				}
				// ends here
			}
        }
        
        // getting public profiles
        publicprofiles = (Profile[])request.getAttribute("qosprofiles");
        
        if(publicprofiles != null)
		{
            for (int i = 0; i < publicprofiles.length; i++)
			{
				// allProfiles.add(publicprofiles[i]);
				 //Added by Divya
				 Profile publicProfileObj = (Profile)publicprofiles[i];
				if(publicProfileObj.getCompliant().equalsIgnoreCase(Constants.COMPLAINT))
				{	
					allProfiles.add(publicprofiles[i]);
					//System.out.println("77777777777 publicprofiles"+publicprofiles[i]);
				}
				else
				{
					message = true;
					if( selectedProfileName != null && publicProfileObj.getQosprofilename().equalsIgnoreCase(selectedProfileName))
					{
						selectedProfileName = null;
						baseProfile = null;
					}
				
				}
				// ends here
			}
        }


      // this is a hack done to handle "Uknown" Qos Profile 
	  // need to find a better way of handling if the current profile is non compliant one. 
	   if(selectedProfileName != null && selectedProfileName.equalsIgnoreCase("Unknown")){
		selectedProfileName =null;
		baseProfile = null;
	   
	   }


// PR 16702       
      if(allProfiles.size() == 0)
      {
      
       try {      
           throw new Exception("There are no profiles in inventory");
        }catch(Exception e){           
           System.err.println("Error: "+e);
        }
      } 

         //  if there wasn't ANY BASE profile then it's the selected profile
        if(baseProfile == null || baseProfile.equals(""))
		{
            if(selectedProfileName==null  || selectedProfileName.equals(""))
			{

			   selectedProfileName = ((Profile) allProfiles.get(0)).getQosprofilename();
			   selectedProfile = (Profile) allProfiles.get(0);
		     baseProfile = selectedProfileName;
		       
			}
            baseProfile = selectedProfileName;
			 
        }
     
	
		selectedProfile = (Profile)request.getAttribute("selectedProfile");
        if(selectedProfile == null && parentProfileName != null)
		{
		
         // selectedProfile = Profile.findByQosprofilename(dbConnection, parentProfileName);
		  baseProfile = selectedProfile.getQosprofilename();
          selectedProfileName = baseProfile;
        }
        
	//	if(selectedProfile == null)
	//	{
  //         selectedProfile = (Profile) allProfiles.get(0);
  //         baseProfile = selectedProfile.getQosprofilename();
  //         selectedProfileName = baseProfile;
		   
  //   }

        policyMappings = (PolicyMapping[])request.getAttribute("policyMappings");

		//Modified by Jimmi
		//following is hack added to fix the problem of of policy mapping not dispalyed
		// initially when the page get loaded 
		// All these Qos related logic may be moved to actions classes later 
		 DatabasePool dbpp = null;
   	     Connection conn = null;
		 
		 if(policyMappings == null){
			try{
		        dbpp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
     			conn = (Connection) dbpp.getConnection();
				policyMappings = PolicyMapping.findByProfilename(conn, baseProfile);
				selectedProfile =Profile.findByQosprofilename(conn,selectedProfileName);

			}catch(Exception e){
				throw new Exception("Could not fetch policy mappings from inventory");
			}finally{
			// close the connection
		        dbpp.releaseConnection(conn);
			}
		}
		// modification by Ends here 

        policyMappings = policyMappings == null ? new PolicyMapping[0]: policyMappings;

	   
        for (int i = 0; i < policyMappings.length; i++) {
            PolicyMapping policyMapping = policyMappings[i];
            policyMap.put(policyMapping.getPosition(), policyMapping);
	    final int position = Integer.parseInt(policyMapping.getPosition());
	    if(position > maximumPosition)
		    maximumPosition = position;
        }

      
    } catch (Throwable e) {
        e.printStackTrace();

%>
      <B><bean:message key="err.qos" /></B>: <%= e.getMessage () %>.
<%    return;
    } 

%>


 <!--------------------------PROFILE---------------------------------->
   	<script LANGUAGE="JavaScript" TYPE="text/javascript">

    var oldProfileName = "";
<%
     if(selectedProfileName != null)
	 {
        // that means that custom percents were selected and they must be selected again
         if(!(selectedProfileName.equals(baseProfile)))
		{
%>
            oldProfileName = "<%=selectedProfileName%>";
<%      }
    }
%>
       setAbsolutRL();


 function countPercents(id)
		{

      var sum = 0;
<%    for (int i = 0; i < expMappings.length; i++) {
        EXPMapping expMapping = expMappings[i];
%>
        box = this.document.getElementById('QOS_CLASS_<%=expMapping.getPosition()%>_PERCENT');
        sum = sum + parseInt(box.value);
<%   }%>
      var lastBox = document.getElementById('QOS_CLASS_<%=maximumPosition%>_PERCENT');
      var reminder = sum - parseInt(lastBox.value);

      if(sum <= 100 || reminder <=100){
        document.getElementById("optC<%=maximumPosition%>P"+(100 - reminder)).selected = true;
      }else{
         var editedBox = document.getElementById("QOS_CLASS_"+id + "_PERCENT");
         var editedValue = parseInt(editedBox.value);
         editedValue = editedValue - (reminder - 100);
		document.getElementById("optC" + id + "P" + editedValue).selected = true;
         document.getElementById("optC<%=maximumPosition%>P0").selected = true;
      }
    }
/**
    changes the name for the profile when the percents are adjusted
*/
    function changeName(){
        var newName = generateName();
        var profileCombo = document.getElementById("ProfileName");
        if(oldProfileName != ""){
            //remove old entry
            profileCombo.options[profileCombo.options.length-1] = null;
        }
        oldProfileName = newName;
        var newOption = new Option(newName, newName);
        newOption.selected="true";
        profileCombo.options[profileCombo.options.length] = newOption;
    }


/**
    display absoult ratelimit 
*/



    function setAbsolutRL(){




     var ratelimitStr = this.document.ServiceForm.SP_RL.value;   
     
      var len = 0;
      len = ratelimitStr.length;
			var rtValue = 0
      rtValue = parseInt(ratelimitStr);
      var rtunit = ratelimitStr.substr(len-1,1);
<%    for (int i = 0; i < expMappings.length; i++) {
        EXPMapping expMapping = expMappings[i];
%>
  			var percent = 0;
				var runit2 = rtunit; 
  			box = this.document.getElementById('QOS_CLASS_<%=expMapping.getPosition()%>_PERCENT');
        if (box != null){ 
        	percent = parseInt(box.value);
        }
        var absoultRL = 0;
        absoultRL = percent * rtValue/100;
        if(absoultRL <1 && rtunit == "M"){
       		 	absoultRL = absoultRL * 1024;	
       		 	rtunit2="K";  
       }else
       	{
       		rtunit2=rtunit; 
      }
       absoultRL= Math.round(absoultRL);
        var absoultRLStr= absoultRL.toString().concat(rtunit2,"bps")
        //alert("===absoultRLStr is:"+absoultRLStr+"===");
        var RT = this.document.getElementById('QOS_CLASS_<%=expMapping.getPosition()%>_RL');
        if(RT != null){
       			RT.setAttribute("value",absoultRLStr);
     		}
<% }%>
     
}  

function showMenu(val,id)
{
	alert("inside showmenu"+val+ "iddd"+id);
	//document.getElementById(id).disabled = val;

}

/**
  Name generation algorithm
  <Prefix>_<percent0>.<percent1>.<percent2>.<percent3>
*/
    function generateName(){
      //var name = "";
      var name = document.getElementById("prefix").value;
<%
  for (int i = 0; i < expMappings.length; i++) {
    EXPMapping expMapping = expMappings[i];
%>
        box = this.document.getElementById('QOS_CLASS_<%=expMapping.getPosition()%>_PERCENT');
<%     if(i != 0){
        %>name = name + ".";<%
       }else{
        %>name = name + "_";<%
       }%>
        name = name + parseInt(box.value);
<%
  }
%>
        return name;
    }

    function init()
		
		{
<%
        // this means that custom percents were selected and they must be selected again
          if( selectedProfileName != null)
	{
	     //String percent1 = request.getParameter("SP_QOS_CLASS_0_PERCENT");
	     //System.out.println("1111111 percent is: "+percent1);
         if(!(selectedProfileName.equals(baseProfile)))
			 {
            for(int i = 0; i < policyMappings.length; i++)
				{
              final String paramName = "SP_QOS_CLASS_"+policyMappings[i].getPosition()+"_PERCENT";
              String percent = request.getParameter(paramName);
                if(percent == null) percent = (String) request.getAttribute(paramName);
%>
            document.getElementById("optC<%=policyMappings[i].getPosition()%>P<%=percent%>").selected = true;
            
 <%             } //for
          } //inner if
    }//outer if
%>
      
    }


</script>
<!--   ======================================= Qos ================================================================       -->

<tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align="left" class="list<%= (rowCounter % 2) %>">
	  <b><bean:message key="label.qosprofile" /></b></td>
      <td align="left" class="list<%= (rowCounter % 2) %>">
      <select id="ProfileName" name="SP_QOS_PROFILE" width="50%"
 onChange="document.getElementById('BaseProfile').value='';location.href = <%= link_part %>;setAbsolutRL();">

<%  
	
	if (allProfiles != null) 
     {
        for (int i = 0; i < allProfiles.size(); i++)
			{
		    Profile profile = (Profile)allProfiles.get(i);
		  
			complaintMapping.put(profile.getQosprofilename(),profile.getCompliant());
			//if(profile.getCompliant().equalsIgnoreCase(Constants.COMPLAINT))
			//{
			
%>
          <option <%= profile.getQosprofilename().equals (baseProfile) ? " selected" : "" %>
		  value="<%= profile.getQosprofilename() %>"><%= profile.getQosprofilename() %>
		  </option>
<%      //}
	  }
     }
     if(selectedProfileName != null && baseProfile != null && !(selectedProfileName.equals(baseProfile)))
		 {
			
%>
     <option selected value="<%= selectedProfileName %>"><%= selectedProfileName %></option>
<%
    
}
%>
      </select>
	   </td>
     <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  </tr>
    <input type="hidden" id="prefix" name="SP_QOS_PREFIX" value="<%= selectedProfile != null ? selectedProfile.getPrefix(): "" %>">
    <input type="hidden" id="BaseProfile" name="SP_QOS_BASE_PROFILE" value="<%= baseProfile != null ? baseProfile : "" %>">    
 <% rowCounter++; %>





<!-- =================================new add======================================   -->


  <%
	  for(int classIndex = 0; classIndex < expMappings.length; classIndex++){
          EXPMapping expMapping = expMappings[classIndex];
          PolicyMapping policyMapping = (PolicyMapping) policyMap.get(expMapping.getPosition());

	 
	  if(policyMapping != null){
//		final boolean isDisabled = policyMapping.getPosition().equals(String.valueOf(maximumPosition));
		
  %>
    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align="left" class="list<%= (rowCounter % 2) %>">&nbsp;&nbsp;&nbsp;&nbsp;<b><%=expMapping.getClassname()%></b></td>
      <td align="left" class="list<%= (rowCounter % 2) %>">
      <table cellpadding="0" cellspacing="0" width="100%"> 
      <tr>
      <td align="left" width="50%" class="list<%= (rowCounter % 2) %>"><%=policyMapping != null ? policyMapping.getTclassname() : ""%>
    </td>
    <td class="list<%= (rowCounter % 2) %>" align="left">
<%
	String valTest =(String)complaintMapping.get(policyMapping.getProfilename());
		
			%>


		
	<select id="QOS_CLASS_<%=expMapping.getPosition()%>_PERCENT" name="SP_QOS_CLASS_<%=expMapping.getPosition()%>_PERCENT"
    onChange="countPercents('<%=expMapping.getPosition()%>');changeName();setAbsolutRL();">	
	
<%    
	
	for (int percentIndex = 0; percentIndex <= 100; percentIndex+=1) { %>
          <option id="optC<%=expMapping.getPosition()%>P<%=percentIndex%>" value="<%=percentIndex%>"
                <%=policyMapping.getPercentage().equals(String.valueOf(percentIndex)) ? "selected" : ""%>>
                <%=percentIndex%>
          </option>
<%    }%>
        </select>
    </td>
    
    <td   class="list<%= (rowCounter % 2)  %>" align=left width="54%">&nbsp;&nbsp;
     	<input type=text id="QOS_CLASS_<%=expMapping.getPosition()%>_RL" name="SP_QOS_CLASS_<%=expMapping.getPosition()%>_RL" readonly="readonly"  size="10">
    </td>
    
    </tr>
    </table>
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  </tr>
  <%    rowCounter++;
	  }else{
  %>
	<input type="hidden" id="QOS_CLASS_<%=expMapping.getPosition()%>_PERCENT" name="SP_QOS_CLASS_<%=expMapping.getPosition()%>_PERCENT" value="0">
  <input type="hidden" id="QOS_CLASS_<%=expMapping.getPosition()%>_RL" name="SP_QOS_CLASS_<%=expMapping.getPosition()%>_RL" value="0">
  
  <%
	  }
      }
	 %>


 <script>
    init();
    setAbsolutRL();
  </script>

<!-- ===================================David add ends====================================   -->


		  <tr>
			<td class="title" align="left" colspan="2" width="40%"><bean:message key="label.siteinfo" /></td>
			<td class="title" style="padding:0px">
			  <table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
				<tr>
				  <td class="title" align="left" width="50%"><bean:message key="label.aend" /></td>
				  <td class="title" align="left" width="50%"><bean:message key="label.zend" /></td>
				</tr>
			  </table>
			</td>
			<td class="title">&nbsp;</td>
		  </tr>
		  
		  <tr height="30">
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
			<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message key="label.vpwssite.name" /></b></td>
			<td class="list<%= (rowCounter % 2) %>" style="padding:0px">
			  <table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
				<tr>
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<select style="position:absolute;width:200px;" onchange="Combo_Select(this,SP_PW_aEnd);handleReuseAction(this, 'aEnd')" id="SP_PW_aEndlist" name="SP_PW_aEndlist" >
					<option/>
					<%if ( sites != null && "Ethernet".equals(PW_Type_aEnd) && "VPWS-PortVlan".equals(EthType_aEnd)) {    
						 for (int i=0; i<sites.length; i++) {
					%>       <option value="<%=sites[i].getServiceid()%>" <%= sites[i].getServiceid().equals(PW_aEndlist) ? " selected": ""%>><%= sites[i].getPresname()%></option>
					<%   }		       
					  }
					%> 
				　　   </select>
				<% if( isFirefox ){ %>
				　　   <input style="position:absolute;width:185;" type="text" id="SP_PW_aEnd" name="SP_PW_aEnd" maxlength="32" onKeyPress="Text_ChkKey(SP_PW_aEndlist,this)" onFocus="handleHintWhenOnFocus(this, 'Input or select AEnd site name')" onBlur="handleHintWhenOnBlur(this, 'Input or select AEnd site name')" value="<%= PW_aEnd == null || "".equals(PW_aEnd) ? "Input or select AEnd site name" : PW_aEnd%>">
				<% } else if( isMSIE ){ %>
				　　   <input style="position:absolute;width:185;margin-left:-25px;" type="text" id="SP_PW_aEnd" name="SP_PW_aEnd" maxlength="32" onKeyPress="Text_ChkKey(SP_PW_aEndlist,this)" onFocus="handleHintWhenOnFocus(this, 'Input or select AEnd site name')" onBlur="handleHintWhenOnBlur(this, 'Input or select AEnd site name')" value="<%= PW_aEnd == null || "".equals(PW_aEnd) ? "Input or select AEnd site name" : PW_aEnd%>">
				<% } else { %>
				<input style="position:absolute;width:185;margin-left:-25px;" type="text" id="SP_PW_aEnd" name="SP_PW_aEnd" maxlength="32" onKeyPress="Text_ChkKey(SP_PW_aEndlist,this)" onFocus="handleHintWhenOnFocus(this, 'Input or select AEnd site name')" onBlur="handleHintWhenOnBlur(this, 'Input or select AEnd site name')" value="<%= PW_aEnd == null || "".equals(PW_aEnd) ? "Input or select AEnd site name" : PW_aEnd%>">
				<% } %>
				　　   <!--<input style="position:absolute;width:185;margin-left:-25px;" type="text" id="SP_PW_aEnd" name="SP_PW_aEnd" maxlength="32" onKeyPress="Text_ChkKey(SP_PW_aEndlist,this)" onFocus="handleHintWhenOnFocus(this, 'Input or select AEnd site name')" onBlur="handleHintWhenOnBlur(this, 'Input or select AEnd site name')" value="<%= PW_aEnd == null || "".equals(PW_aEnd) ? "Input or select AEnd site name" : PW_aEnd%>"> -->

					<input type="hidden" name="ServiceMultiplexing_aEnd" id="ServiceMultiplexing_aEnd" value=<%=ServiceMultiplexing_aEnd==null? "false":ServiceMultiplexing_aEnd%>>
				  </td>
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<select style="position:absolute;width:200px;" onchange="Combo_Select(this,SP_PW_zEnd);handleReuseAction(this, 'zEnd')" id="SP_PW_zEndlist" name="SP_PW_zEndlist" >
					<option/>
					<%if ( sites != null && "Ethernet".equals(PW_Type_zEnd) && "VPWS-PortVlan".equals(EthType_zEnd)) {    
						 for (int i=0; i<sites.length; i++) {
					%>       <option value="<%=sites[i].getServiceid()%>" <%= sites[i].getServiceid().equals(PW_zEndlist) ? " selected": ""%>><%= sites[i].getPresname()%></option>
					<%   }		       
					  }
					%> 
				　　   </select>
				<% if( isFirefox ){ %>
				　　   <input style="position:absolute;width:185;" type="text" id="SP_PW_zEnd" name="SP_PW_zEnd" maxlength="32" onKeyPress="Text_ChkKey(SP_PW_zEndlist,this)" onFocus="handleHintWhenOnFocus(this,'Input or select ZEnd site name')" onBlur="handleHintWhenOnBlur(this,'Input or select ZEnd site name')" value="<%= PW_zEnd == null || "".equals(PW_zEnd) ? "Input or select ZEnd site name" : PW_zEnd%>">
				<% } else if( isMSIE ){ %>
				　　   <input style="position:absolute;width:185;margin-left:-25px;" type="text" id="SP_PW_zEnd" name="SP_PW_zEnd" maxlength="32" onKeyPress="Text_ChkKey(SP_PW_zEndlist,this)" onFocus="handleHintWhenOnFocus(this,'Input or select ZEnd site name')" onBlur="handleHintWhenOnBlur(this,'Input or select ZEnd site name')" value="<%= PW_zEnd == null || "".equals(PW_zEnd) ? "Input or select ZEnd site name" : PW_zEnd%>">
				<% } else { %>
				<input style="position:absolute;width:185;margin-left:-25px;" type="text" id="SP_PW_zEnd" name="SP_PW_zEnd" maxlength="32" onKeyPress="Text_ChkKey(SP_PW_zEndlist,this)" onFocus="handleHintWhenOnFocus(this,'Input or select ZEnd site name')" onBlur="handleHintWhenOnBlur(this,'Input or select ZEnd site name')" value="<%= PW_zEnd == null || "".equals(PW_zEnd) ? "Input or select ZEnd site name" : PW_zEnd%>">
				<% } %>
				　　  <!-- <input style="position:absolute;width:185;margin-left:-25px;" type="text" id="SP_PW_zEnd" name="SP_PW_zEnd" maxlength="32" onKeyPress="Text_ChkKey(SP_PW_zEndlist,this)" onFocus="handleHintWhenOnFocus(this,'Input or select ZEnd site name')" onBlur="handleHintWhenOnBlur(this,'Input or select ZEnd site name')" value="<%= PW_zEnd == null || "".equals(PW_zEnd) ? "Input or select ZEnd site name" : PW_zEnd%>"> -->

					<input type="hidden" name="ServiceMultiplexing_zEnd" id="ServiceMultiplexing_zEnd" value=<%=ServiceMultiplexing_zEnd==null? "false":ServiceMultiplexing_zEnd%>>
				  </td>
				</tr>
			  </table>
			</td>
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
		  </tr>
		  <% rowCounter++; %>


		  <tr height="30">
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
			<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message key="label.vpws.serviceid" /></b></td>
			<td class="list<%= (rowCounter % 2) %>" style="padding:0px">
			  <table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
				<tr>
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%" >
					<input type="hidden" name="SP_Site_Service_ID_aEnd" id="SP_Site_Service_ID_aEnd" maxlength="32" size="32" value="<%= Site_Service_ID_aEnd %>">
					<div id="TD_SP_Site_Service_ID_aEnd"><%= Site_Service_ID_aEnd %></div>
				  </td>
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="hidden" name="SP_Site_Service_ID_zEnd" id="SP_Site_Service_ID_zEnd" maxlength="32" size="32" value="<%= Site_Service_ID_zEnd %>">
					<div id="TD_SP_Site_Service_ID_zEnd"><%= Site_Service_ID_zEnd %></div>
				  </td>
				</tr>
			  </table>
			</td>
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
		  </tr>
		  <% rowCounter++; %>
		  
		  <tr height="30">
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
			<td class="list<%= (rowCounter % 2) %>" align=left width="40%"><b><bean:message key="label.vpws.attachmentid" /></b></td>
			<td class="list<%= (rowCounter % 2) %>" style="padding:0px">
			  <table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
				<tr>
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="hidden" name="SP_Site_Attachment_ID_aEnd" id="SP_Site_Attachment_ID_aEnd" maxlength="32" size="32" value="<%= Site_Attachment_ID_aEnd %>"><%= Site_Attachment_ID_aEnd %>
				  </td>
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%">
					<input type="hidden" name="SP_Site_Attachment_ID_zEnd" id="SP_Site_Attachment_ID_zEnd" maxlength="32" size="32" value="<%= Site_Attachment_ID_zEnd %>"><%= Site_Attachment_ID_zEnd %>
				  </td>
				</tr>
			  </table>
			</td>
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
		  </tr>
		  <% rowCounter++; %>

		  <tr height="30">
		  <%
			 link_part += " + '&SP_PW_Type_aEnd=' + ServiceForm.SP_PW_Type_aEnd.options[SP_PW_Type_aEnd.selectedIndex].value";
			 link_part += " + '&SP_PW_Type_zEnd=' + ServiceForm.SP_PW_Type_zEnd.options[SP_PW_Type_zEnd.selectedIndex].value";


			 if ("Ethernet".equals(PW_Type_aEnd)) 
			   link_part += " + '&SP_EthType_aEnd=' + ServiceForm.SP_EthType_aEnd.options[SP_EthType_aEnd.selectedIndex].value";
			 if ("Ethernet".equals(PW_Type_zEnd))
			   link_part += " + '&SP_EthType_zEnd=' + ServiceForm.SP_EthType_zEnd.options[SP_EthType_zEnd.selectedIndex].value";
		  %>
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
			<td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.interfacetype" /></b></td>
			<td class="list<%= (rowCounter % 2) %>" style="padding:0px">
			  <table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
				<tr>
				  <td class="list<%= (rowCounter % 2) %>" align=left>
					<select name="SP_PW_Type_aEnd" onChange="location.href = <%= link_part+" + '&aEndSelected=true'" %>;">
					  <option <%= PW_Type_aEnd.equals("Ethernet") ? " selected": "" %> value="Ethernet">Ethernet</option>
					  <option <%= PW_Type_aEnd.equals("FrameRelay") ? " selected": "" %> value="FrameRelay">FrameRelay</option>
					  <option <%= PW_Type_aEnd.equals("PPP") ? " selected": "" %> value="PPP">PPP</option>
					</select>
				  </td>
				  <td class="list<%= (rowCounter % 2) %>" align=left>
					<select name="SP_PW_Type_zEnd" onChange="location.href = <%= link_part+" + '&zEndSelected=true'" %>;">
					  <option <%= PW_Type_zEnd.equals("Ethernet") ? " selected": "" %> value="Ethernet">Ethernet</option>
					  <option <%= PW_Type_zEnd.equals("FrameRelay") ? " selected": "" %> value="FrameRelay">FrameRelay</option>
					  <option <%= PW_Type_zEnd.equals("PPP") ? " selected": "" %> value="PPP">PPP</option>
					</select>
				  </td>
				</tr>
			  </table>
			</td>
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
		   </tr>

		  <% rowCounter++; %>

		  <% if (PW_Type_aEnd.equals("Ethernet") || PW_Type_zEnd.equals("Ethernet")) {
		%>
			<tr height="30">
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
			<td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.serv.type" /></b></td>
			<td class="list<%= (rowCounter % 2) %>" style="padding:0px">
			  <table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
				<tr>
		  <% if (PW_Type_aEnd.equals("Ethernet")) { %>
				  <td class="list<%= (rowCounter % 2) %>" align=left>
					<select name="SP_EthType_aEnd" onChange="location.href=<%= link_part+" + '&aEndSelected=true'" %>;">
					  <option <%= "VPWS-PortVlan".equals(EthType_aEnd) ? " selected": "" %> value="VPWS-PortVlan">port-vlan</option>
					   <option  <%= "VPWS-Vlan".equals(EthType_aEnd) ? " selected": "" %> value="VPWS-Vlan">VLAN</option>
		  <% if (PW_Type_zEnd.equals("Ethernet")) { %>
					  <option <%= "Port".equals(EthType_aEnd) ? " selected": "" %> value="Port">port</option>
		  <% } %>		  			
					</select>
				  </td>
		<%   } else { %>
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%" maxlength="32" size="32"> </td>
		<%   } 
			 if (PW_Type_zEnd.equals("Ethernet")) { %>
				  <td class="list<%= (rowCounter % 2) %>" align=left>
					<select name="SP_EthType_zEnd" onChange="location.href=<%= link_part+" + '&zEndSelected=true'" %>;">
					  <option <%= "VPWS-PortVlan".equals(EthType_zEnd) ? " selected": "" %> value="VPWS-PortVlan">port-vlan</option>
					    <option  <%= "VPWS-Vlan".equals(EthType_zEnd) ? " selected": "" %> value="VPWS-Vlan">VLAN</option>
		  <% if (PW_Type_aEnd.equals("Ethernet")) { %>
					  <option <%= "Port".equals(EthType_zEnd) ? " selected": "" %> value="Port">port</option>
		  <% } %>
		  		
					</select>
				  </td>
		<%   } else { %>
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%" maxlength="32" size="32"> </td>
		<%   } %>
				</tr>
			  </table>
			</td>
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
		   </tr>

		  <% rowCounter++; %>
		  <% } %>



		  <%  // Set UNIType according to selected Interface type and Service Type
			 UNIType_aEnd = PW_Type_aEnd;
			  
			 if (PW_Type_aEnd.equals("Ethernet")){
			   if ("Port".equals(EthType_aEnd)) {
				 UNIType_aEnd = "Port";
			    Vlan_Flag_aEnd ="false";}
			   if ("VPWS-PortVlan".equals(EthType_aEnd))
				 UNIType_aEnd = "PortVlan";
			   Vlan_Flag_aEnd ="false";
			   if ("VPWS-Vlan".equals(EthType_aEnd)) {
					 UNIType_aEnd = "PortVlan";
			        Vlan_Flag_aEnd ="true";}
			        
			 }
		 
			 UNIType_zEnd = PW_Type_zEnd;
			 if (PW_Type_zEnd.equals("Ethernet")){
			   if ("Port".equals(EthType_zEnd))
				 UNIType_zEnd = "Port";
			   Vlan_Flag_zEnd ="false";
			   if ("VPWS-PortVlan".equals(EthType_zEnd))
				 UNIType_zEnd = "PortVlan";
			   Vlan_Flag_zEnd ="false";
			   if ("VPWS-Vlan".equals(EthType_zEnd))
					 UNIType_zEnd = "PortVlan";
			 	  Vlan_Flag_zEnd ="true";
			 }

		  %>

		  <input type="hidden" id="SP_UNIType_aEnd" name="SP_UNIType_aEnd" value="<%= UNIType_aEnd %>">
		  <input type="hidden" id="SP_UNIType_zEnd" name="SP_UNIType_zEnd" value="<%= UNIType_zEnd %>">
		  
		   <input type="hidden" id="SP_Vlan_Flag_aEnd" name="SP_Vlan_Flag_aEnd" value="<%= Vlan_Flag_aEnd %>">
		  <input type="hidden" id="SP_Vlan_Flag_zEnd" name="SP_Vlan_Flag_zEnd" value="<%= Vlan_Flag_zEnd %>">
		  
				  <input type="hidden" id="aEndBgStVlanRange" name="aEndBgStVlanRange" value="<%= aEndBgStVlanRange %>">
				  <input type="hidden" id="aEndBgEndVlanRange" name="aEndBgEndVlanRange" value="<%= aEndBgEndVlanRange %>">
				  <input type="hidden" id="zEndBgStVlanRange" name="zEndBgStVlanRange" value="<%= zEndBgStVlanRange %>">
				  <input type="hidden" id="zEndBgEndVlanRange" name="zEndBgEndVlanRange" value="<%= zEndBgEndVlanRange %>">
				  <input type="hidden" id="aEndStartVlanRange" name="aEndStartVlanRange" value="<%= aEndStartVlanRange %>">
				  <input type="hidden" id="aEndEndVlanRange" name="aEndEndVlanRange" value="<%= aEndEndVlanRange %>">
				  <input type="hidden" id="zEndStartVlanRange" name="zEndStartVlanRange" value="<%= zEndStartVlanRange %>">
				  <input type="hidden" id="zEndEndVlanRange" name="zEndEndVlanRange" value="<%= zEndEndVlanRange %>">
				  <input type="hidden" id="aEndStDlciRange" name="aEndStDlciRange" value="<%= aEndStDlciRange %>">
				  <input type="hidden" id="aEndEndDlciRange" name="aEndEndDlciRange" value="<%= aEndEndDlciRange %>">
				  <input type="hidden" id="zEndStDlciRange" name="zEndStDlciRange" value="<%= zEndStDlciRange %>">
				  <input type="hidden" id="zEndEndDlciRange" name="zEndEndDlciRange" value="<%= zEndEndDlciRange %>">
				  
	  <input type="hidden" id="SP_Region">

	  <input type="hidden" id="manualSet">

		  <tr height="30">
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
			<td align=left class="list<%= (rowCounter % 2) %>" width=40><b><bean:message key="label.vpws.region" /></b></td>
			<td style="padding:0px">
			  <table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
				<tr>
				  <td align=left class="list<%= (rowCounter % 2) %>" width="50%">
					<select name="SP_PW_aEnd_region" id="SP_PW_aEnd_region" onChange="location.href = <%= link_part %>;" <%= !"true".equals(resendCreate) ? "" : "disabled" %>>
		<%  if (regions != null) {
			  if (PW_aEnd_region == null) {
				PW_aEnd_region = regions[0].getPrimaryKey();
			  }
		   
			  for (int i=0; regions != null && i < regions.length; i++) { %>
					  <option<%= regions[i].getName().equals (PW_aEnd_region) ? " selected": "" %> value="<%=  regions[i].getName() %>"><%= regions[i].getName() %></option>
		<%    }
			}
		%>  
					</select>
				  </td>
				  <td align=left class="list<%= (rowCounter % 2) %>" width="50%">
					<select name="SP_PW_zEnd_region" onChange="location.href = <%= link_part%>;" <%= !"true".equals(resendCreate) ? "" : "disabled" %>>
		<%  if (regions != null) {
			  if (PW_zEnd_region == null) {
				PW_zEnd_region = regions[0].getPrimaryKey();
			  }
		   
			  for (int i=0; regions != null && i < regions.length; i++) { %>
					  <option<%= regions[i].getName().equals (PW_zEnd_region) ? " selected": "" %> value="<%=  regions[i].getName() %>"><%= regions[i].getName() %></option>
		<%    }
			}
		%>
					</select>
				  </td>
				</tr>
			  </table>
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
		  </tr>

		  <% rowCounter++; %>

		  <tr height="30">
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
			<td align=left class="list<%= (rowCounter % 2) %>" width=40><b><bean:message key="label.vpws.loc" /></b></td>
			<td style="padding:0px">
			  <table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
				<tr>
				  <td align=left class="list<%= (rowCounter % 2) %>" width="50%">
					<select name="SP_PW_aEnd_location" <%= !"true".equals(resendCreate) ? "" : "disabled" %>>
		<%  if (locations_aEnd != null) {
			  if (PW_aEnd_location == null) {
				PW_aEnd_location = locations_aEnd[0].getPrimaryKey();
			  }
		   
			  for (int i=0; locations_aEnd != null && i < locations_aEnd.length; i++) { %>
					  <option<%= locations_aEnd[i].getName().equals (PW_aEnd_location) ? " selected": "" %> value="<%=  locations_aEnd[i].getName() %>"><%= locations_aEnd[i].getName() %></option>
		<%    }
			}
		%>  
					</select>
				  </td>
				  <td align=left class="list<%= (rowCounter % 2) %>" width="50%">
					<select name="SP_PW_zEnd_location" <%= !"true".equals(resendCreate) ? "" : "disabled" %>>
		<%  if (locations_zEnd != null) {
			  if (PW_zEnd_location == null) {
				PW_zEnd_location = locations_zEnd[0].getPrimaryKey();
			  }
		  
			  for (int i=0; locations_zEnd != null && i < locations_zEnd.length; i++) { %>
					  <option<%= locations_zEnd[i].getName().equals (PW_zEnd_location) ? " selected": "" %> value="<%=  locations_zEnd[i].getName() %>"><%= locations_zEnd[i].getName() %></option>
		<%    }
			}
		%>
					</select>
				  </td>
				</tr>
			  </table>
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
		  </tr>
<input type="hidden" name="resend" value=<%= resendCreate %>>

		  <% rowCounter++; %>
			 <script>
				function checkNumValue(input, prompt){
				  var str = input.value;
				  var newStr = "";
				  for(i = 0; i < str.length; i++){
					  if(str.charAt(i) >= '0' && str.charAt(i) <= '9'){
						  newStr = newStr + str.charAt(i);
					  }
				  }
				  if(str != newStr || newStr.length == 0) {
					  alert(prompt);
					  input.value = newStr;
					  return false;
				  }
				  return true;
				}
				function checkNumValueOrSpace(input, prompt){
				  var str = input.value;
				  var newStr = "";
				  for(i = 0; i < str.length; i++){
					  if(str.charAt(i) >= '0' && str.charAt(i) <= '9'){
						  newStr = newStr + str.charAt(i);
					  }
				  }
				  if(str != newStr) {
					  alert(prompt);
					  input.value = newStr;
					  return false;
				  }
				  return true;
				}
				function checkVlanRange(input, prompt){
				  var str   = input.value;
				  var value = input.value;
				  var bgStVlan;
				  var bgEndVlan;
				  var stVlan;
				  var endVlan;
			  
				  //PR15189
				  if (value == 0) {
				    return true;
				  }
				  
				  var i=0;
				if(getObjectById('SP_VLANIdaEnd') != null) {
				 if(str == getObjectById('SP_VLANIdaEnd').value) {
				 bgStVlan = getObjectById('aEndBgStVlanRange').value;
				 bgEndVlan =  getObjectById('aEndBgEndVlanRange').value;
				 stVlan =  getObjectById('aEndStartVlanRange').value;
				 endVlan =  getObjectById('aEndEndVlanRange').value;
						  }
					}
				if(getObjectById('SP_VLANIdzEnd') != null) {
				 if(str == getObjectById('SP_VLANIdzEnd').value){
					bgStVlan = getObjectById('zEndBgStVlanRange').value;
					  bgEndVlan =  getObjectById('zEndBgEndVlanRange').value;
						  stVlan =  getObjectById('zEndStartVlanRange').value;
						 endVlan =  getObjectById('zEndEndVlanRange').value;
						 } 
				}
						var  vlanStValue = bgStVlan.split(",");
						var vlanEndValue = bgEndVlan.split(",");
						var vlanStValue1 = stVlan.split(",");
						var vlanEndValue1 = endVlan.split(",");
				  if ( str.length >0 ) {
					if((<%=!isAToM(PW_Type_aEnd,PW_Type_zEnd)%>)) {

						vlanStValue = stVlan.split(",");
						vlanEndValue = endVlan.split(",");
					} 
					else {
						vlanStValue = bgStVlan.split(",");		  
						vlanEndValue = bgEndVlan.split(",");
					}
		
					for(i=0;i<(vlanStValue.length -1) ; i++) {

						if((parseInt(value) < parseInt(vlanStValue[i])) || (parseInt(value) >  parseInt(vlanEndValue[i]))) {
							
							if( i == vlanStValue.length -2)  {
								alert(prompt);
								return false;
							}
							else 
								continue;

						}
						else {
							break;
						}
					  }
					}
				  return true;
				}
				function checkDLCIRange(input, prompt){
				  var str   = input.value;
				  var value = input.value;
				  var stlist;	
				  var endlist;
				  var aend;
				  var zend;
				  
				  //PR15189
				  if (value == 0) {
				    return true;
				  }
				  
				  if ( str.length >0 ) {
					  //alert("her");
					if(getObjectById('SP_DLCIaEnd') != null){
										
						stlist = getObjectById('aEndStDlciRange').value.split(",");
						endlist = getObjectById('aEndEndDlciRange').value.split(",");
					}
					else {
						stlist = getObjectById('zEndStDlciRange').value.split(",");
						endlist = getObjectById('zEndEndDlciRange').value.split(",");
					}
				

					for(var i=0 ; i< stlist.length ;i++) {
						if( value < stlist[i] || value > endlist[i]) {
							alert(prompt);
							return false;
						}
						else {
							return true;
						}
					}		
				  }
				}

                
function handleReusedLocation(siteid, side)
		{
          var SP_Region = getObjectById("SP_PW_" + side +"_region");
		  var SP_Location = getObjectById("SP_PW_" + side +"_location");
		  if (siteid != null && siteid != "") { 
		   SP_Region.disabled = "true";
		   SP_Location.disabled = "true";
			<%if(available_regions != null){
				for(ServiceParameter r : available_regions){ %>
                if(siteid == <%=r.getServiceid()%>){
				    for(j=0;j<SP_Region.length;j++) {  
                     if(SP_Region.options[j].value == "<%=r.getValue()%>"){
                        SP_Region.selectedIndex = j;
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




				function handleReuseAction(siteList, side) {
				  var PW_Type_aEnd = getObjectById('SP_PW_Type_aEnd');
				  var PW_Type_zEnd = getObjectById('SP_PW_Type_zEnd');
				  if (PW_Type_aEnd.value == "Ethernet" && PW_Type_zEnd.value == "Ethernet") {
				    handleEthernetReuseAction(siteList, side);
				  } else {
				    handleNoEthernetReuseAction(siteList, side);
				  }
				  handleReusedLocation(siteList[siteList.selectedIndex].value, side)
				}

				function handleNoEthernetReuseAction(siteList, side) {				 			
				  var end = getObjectById('SP_PW_' + side);
				  var td = document.getElementById('TD_SP_Site_Service_ID_' + side);
				  if (siteList.selectedIndex > 0) {
					td.innerHTML=siteList[siteList.selectedIndex].value;
					end.readOnly="true";										   	   	           	
				  } else {
					if (side=="aEnd") {
						td.innerHTML=<%= Site_Service_ID_aEnd %>; 
					} else {
						td.innerHTML=<%= Site_Service_ID_zEnd %>;
					}
					end.readOnly="";
					end.focus();
				  }											
				}
				function handleEthernetReuseAction(siteList, side) {
				var aEndList = getObjectById('SP_PW_aEndlist');
				var zEndList = getObjectById('SP_PW_zEndlist');
				var PW_Type_aEnd = getObjectById('SP_PW_Type_aEnd');
				var PW_Type_zEnd = getObjectById('SP_PW_Type_zEnd');
				var EthType_aEnd = getObjectById('SP_EthType_aEnd');
				var EthType_zEnd = getObjectById('SP_EthType_zEnd');
				var UNIType_aEnd = getObjectById('SP_UNIType_aEnd');
				var UNIType_zEnd = getObjectById('SP_UNIType_zEnd');
			  
				var end = getObjectById('SP_PW_' + side);
				if (side == "aEnd") {
					curEndList = aEndList;
					otherEndList = zEndList;
				} else {
					curEndList = zEndList;
					otherEndList = aEndList;
				}
							   
				var flag = getObjectById('manualSet');
				
				if (aEndList.selectedIndex == 0 && zEndList.selectedIndex == 0) {
					PW_Type_aEnd.disabled="";
					PW_Type_zEnd.disabled="";
					EthType_aEnd.disabled="";
					EthType_zEnd.disabled="";
					//EthType_aEnd.selectedIndex = 1;
					//EthType_zEnd.selectedIndex = 1;
					//UNIType_aEnd.value="Port";
					//UNIType_zEnd.value="Port";
					
					flag.setAttribute("value","false");
				}
				
				var otherSelValue = otherEndList.options[otherEndList.selectedIndex].value;
				var curSelValue = curEndList.options[curEndList.selectedIndex].value;
				var needDel;
				var td = document.getElementById('TD_SP_Site_Service_ID_' + side);
					if (siteList.selectedIndex > 0) {
						td.innerHTML=siteList[siteList.selectedIndex].value;
					end.readOnly="true";
					
					EthType_aEnd.selectedIndex = 0;
					EthType_zEnd.selectedIndex = 0;
					
					
					if (side == "aEnd") {
					PW_Type_aEnd.disabled="true";
					PW_Type_zEnd.disabled="";
					EthType_aEnd.disabled="true";
					EthType_zEnd.disabled="";
					} else{
						PW_Type_aEnd.disabled="";
						PW_Type_zEnd.disabled="true";
						EthType_aEnd.disabled="";
						EthType_zEnd.disabled="true";
					}
					
					
					UNIType_aEnd.value="PortVlan";
					UNIType_zEnd.value="PortVlan";
						
					flag.setAttribute("value","true");
					
					for (var x=1;x<otherEndList.length;x++) { 
						otherEndList.options[x] = null;					
					}
					<% for (int y=0; y<sites.length; y++) {%>				
						otherEndList.options[<%=y+1%>] = new Option('<%=sites[y].getPresname()%>', '<%=sites[y].getServiceid()%>');
						if (otherSelValue == <%=sites[y].getServiceid()%>) {
							otherEndList.selectedIndex=<%=y+1%>;
						}
						if (curSelValue == <%=sites[y].getServiceid()%>) {
							needDel = <%=y+1%>;
						}							
					<%}%>
					otherEndList.options[needDel] = null;         	   	           	
				} else {
					if (side=="aEnd") {
						td.innerHTML=<%= Site_Service_ID_aEnd %>; 
					} else {
						td.innerHTML=<%= Site_Service_ID_zEnd %>;
					}
					end.readOnly="";
					end.focus();
					for (var i=1;i<otherEndList.length;i++) { 
						otherEndList.options[i] = null;					
					}
					<% for (int j=0; j<sites.length; j++) {%>				
						otherEndList.options[<%=j+1%>] = new Option('<%=sites[j].getPresname()%>', '<%=sites[j].getServiceid()%>');	
						if (otherSelValue == <%=sites[j].getServiceid()%>) {
							otherEndList.selectedIndex=<%=j+1%>;
						}		
					<%}%>
					}
				}
				function checkSitename() {
					var aEndTB = getObjectById('SP_PW_aEnd');
					var zEndTB = getObjectById('SP_PW_zEnd');
					
					var aEnd = getObjectById('SP_PW_aEndlist');
					var zEnd = getObjectById('SP_PW_zEndlist');
					
					var ServiceMultiplexing_aEnd = getObjectById('ServiceMultiplexing_aEnd');
					var ServiceMultiplexing_zEnd = getObjectById('ServiceMultiplexing_zEnd');
					//alert("aEndTB="+aEndTB.value+" zEndTB="+zEndTB.value+" aEnd="+aEnd.value+" zEnd="+zEnd.value+" ServiceMultiplexing_aEnd="+ServiceMultiplexing_aEnd.value);			  
					if (aEnd.selectedIndex > 0 && aEnd[aEnd.selectedIndex].text == aEndTB.value) {
						             	           	
						ServiceMultiplexing_aEnd.setAttribute("value","true");
					} else {
						
						ServiceMultiplexing_aEnd.setAttribute("value","false");
					}
							 
					if (zEnd.selectedIndex > 0 && zEnd[zEnd.selectedIndex].text == zEndTB.value) {
						          	           	
						ServiceMultiplexing_zEnd.setAttribute("value","true");
					} else {
						
						ServiceMultiplexing_zEnd.setAttribute("value","false");
					}
					
					//alert(getObjectById('ServiceMultiplexing_aEnd').value);
					//alert(getObjectById('ServiceMultiplexing_zEnd').value);
					//if(!resend){
				}
				function checkAll() {
					//alert(getObjectById('ServiceMultiplexing_aEnd').value);
					//alert(getObjectById('ServiceMultiplexing_zEnd').value);
				
				<%if(!resend){%>
						//alert("If not resend, please check site Name");
					checkSitename(); // add by tommy at 2009.1.4
					<%}%>
					var submitted = true;

					var presname = getObjectById('presname');
					 if(!isSpecialCharFound(presname))
						 {
						   submitted = false;
						}
           if(getObjectById('SP_RL').value.length==0) 
            {
			       alert('<bean:message key="js.site.RL" />');
			    submitted = false;
		       }    


					var aEnd_site = getObjectById('SP_PW_aEnd');
					 if(!isSpecialCharFound(aEnd_site))
						 {
						   submitted = false;
						}

					var zEnd_site = getObjectById('SP_PW_zEnd');
					 if(!isSpecialCharFound(zEnd_site))
						 {
						   submitted = false;
						}

					if(getObjectById('presname').value.length==0) {
					   alert('<bean:message key="js.vpws.name" />');
					   submitted = false;
					} else
					  if(getObjectById('SP_PW_aEnd').value.length==0) {
						 alert('<bean:message key="js.aend.site.name" />');
						 submitted = false;
					  } else
						if(getObjectById('SP_PW_zEnd').value.length==0) {
						  alert('<bean:message key="js.zend.site.name" />');
						  submitted = false;
						} else {
		<%                if (PW_Type_aEnd.equals("FrameRelay")) { %>
							 if (checkNumValueOrSpace(getObjectById('SP_DLCIaEnd'), '<bean:message key="js.aend.dlci.value" />') == false ) submitted = false;
							 else
							   if (checkDLCIRange(getObjectById('SP_DLCIaEnd'), '<bean:message key="js.aend.dlcirange.name" /> <%=aEndDlciRange%>') == false ) submitted = false;
		<%                }
						  if (PW_Type_zEnd.equals("FrameRelay")) { %>                  
							 if (checkNumValueOrSpace(getObjectById('SP_DLCIzEnd'), '<bean:message key="js.zend.dlci.value" />') == false ) submitted = false;
							 else
							
							   if (checkDLCIRange(getObjectById('SP_DLCIzEnd'), '<bean:message key="js.zend.dlcirange.name" /> <%=zEndDlciRange%>') == false ) submitted = false;
		<%                }
						  if ("VPWS-PortVlan".equals(EthType_aEnd)) { %>
							 if (checkNumValueOrSpace(getObjectById('SP_VLANIdaEnd'), '<bean:message key="js.aend.vlanid.value" />') == false ) submitted = false;
							 else
							   if (checkVlanRange(getObjectById('SP_VLANIdaEnd'), '<bean:message key="js.aend.vlanrange.name" /> <%=vlanIdLowHigh(PW_Type_aEnd,PW_Type_zEnd,aEndBgStVlanRange,aEndBgEndVlanRange,aEndStartVlanRange,aEndEndVlanRange)%>') == false ) submitted = false;
		<%                }
						  if ("VPWS-PortVlan".equals(EthType_zEnd)) { %>
							 if (checkNumValueOrSpace(getObjectById('SP_VLANIdzEnd'), '<bean:message key="js.zend.vlanid.value" />') == false ) submitted = false;
							 else
							   if (checkVlanRange(getObjectById('SP_VLANIdzEnd'), '<bean:message key="js.zend.vlanrange.name" /> <%=vlanIdLowHigh(PW_Type_aEnd,PW_Type_zEnd,aEndBgStVlanRange,aEndBgEndVlanRange,aEndStartVlanRange,aEndEndVlanRange)%>') == false ) submitted = false;
		<%                } %>
					}
					   
					if(submitted)
					{
					 
					  getObjectById('SP_Region').value = getObjectById('SP_PW_aEnd_region').options[getObjectById('SP_PW_aEnd_region').selectedIndex].value;
					
	
		<% /**           if ("VPWS-PortVlan".equals(EthType_aEnd)) { %>
						if (getObjectById('SP_VLANIdaEnd').value=="")
						  getObjectById('SP_VLANIdaEnd').value = "0";
		<%            } 
					if("FrameRelay".equals(PW_Type_aEnd)) {%>
						  if (getObjectById('SP_DLCIaEnd').value=="")
						  getObjectById('SP_DLCIaEnd').value = "0";
		<%			} %>
		<%            if ("VPWS-PortVlan".equals(EthType_zEnd)) { %>
						if (getObjectById('SP_VLANIdzEnd').value=="")
						  getObjectById('SP_VLANIdzEnd').value = "0";
		<%            } 
					if("FrameRelay".equals(PW_Type_zEnd)) {%>
						  if (getObjectById('SP_DLCIzEnd').value=="")
						  getObjectById('SP_DLCIzEnd').value = "0";
		<%				}**/%>


			          getObjectById("SP_PW_aEnd_region").disabled = "";
		              getObjectById("SP_PW_zEnd_region").disabled = "";
					  getObjectById("SP_PW_aEnd_location").disabled = "";
					  getObjectById("SP_PW_zEnd_location").disabled = "";
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

<%if(!resend){%>
	if (getObjectById("SP_PW_zEndlist").selectedIndex > 0) {
         handleReuseAction(getObjectById("SP_PW_zEndlist"), "zEnd");
     }
	 if (getObjectById("SP_PW_aEndlist").selectedIndex > 0) {
         handleReuseAction(getObjectById("SP_PW_aEndlist"), "aEnd");
	 }
<%}%>



			   // onsubmit = checkAll;
			   //ServiceForm.onsubmit = checkAll; 
			 </script>

		<%   if (PW_Type_aEnd.equals("FrameRelay") || PW_Type_zEnd.equals("FrameRelay")) { %>
			<tr height="30">
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
			<td class="list<%= (rowCounter % 2) %>" align=left><b>DLCI</b></td>
			<td style="padding:0px">
			  <table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
				<tr>
		<%   if (PW_Type_aEnd.equals("FrameRelay")) { %>
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%"><input type="text"
					  onchange="checkNumValue(this, '<bean:message key="js.aend.dlci.num.value" />')" id="SP_DLCIaEnd" 
					  name="SP_DLCIaEnd" maxlength="32" size="32" 
					  title="Valid Customer provided DLCI range is from <%=aEndDlciRange%>. Blank for Provider managed value."
					  <%= DLCIaEnd == null ? "" : "value=\"" + DLCIaEnd + "\"" %>>
				  </td>
		<%   } else { %>
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%" maxlength="32" size="32"> </td>
		<%   } 
			 if (PW_Type_zEnd.equals("FrameRelay")) { %>
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%"><input type="text" 
					  onchange="checkNumValue(this, '<bean:message key="js.zend.dlci.num.value" />')" id="SP_DLCIzEnd" 
					  name="SP_DLCIzEnd" maxlength="32" size="32" 
					  title="Valid Customer provided DLCI range is from <%=zEndDlciRange%>. Blank for Provider managed value."
					  <%= DLCIzEnd == null ? "" : "value=\"" + DLCIzEnd + "\"" %>>
				  </td>
		<%   } else { %>
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%" maxlength="32" size="32"> </td>
		<%   } %>
				</tr>
			  </table>
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
		  <% rowCounter++; %>
		  <% } %>

		<%   if ("VPWS-PortVlan".equals(EthType_aEnd) || "VPWS-PortVlan".equals(EthType_zEnd)) { %>
			<tr height="30">
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
			<td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.vlanid" /></b></td>
			<td style="padding:0px">
			  <table border="0" cellpadding="2" cellspacing="0" width="100%" height="100%">
				<tr>
		<%   if ("VPWS-PortVlan".equals(EthType_aEnd)) { %>
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%"><input type="text"
					  onChange="checkNumValue(this, '<bean:message key="js.aend.vlanid.num.value" />')" 
					  id="SP_VLANIdaEnd" name="SP_VLANIdaEnd" maxlength="32" size="32" 
					  <%= VLANIdaEnd == null ? "" : "value=\"" + VLANIdaEnd + "\"" %>
							  title="<%=vlanTitle(PW_Type_aEnd,PW_Type_zEnd,aEndBgStVlanRange,aEndBgEndVlanRange,aEndStartVlanRange,aEndEndVlanRange)%>" >
				  </td>
		<%   } else { %>
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%" maxlength="32" size="32"> </td>
		<%   }
			 if ("VPWS-PortVlan".equals(EthType_zEnd)) { %> 
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%"><input type="text" 
					  onChange="checkNumValue(this, '<bean:message key="js.zend.vlanid.num.value" />')" 
					  id="SP_VLANIdzEnd" name="SP_VLANIdzEnd" maxlength="32" size="32" 
					  <%= VLANIdzEnd == null ? "" : "value=\"" + VLANIdzEnd + "\"" %>
					  title="<%=vlanTitle(PW_Type_aEnd,PW_Type_zEnd,zEndBgStVlanRange,zEndBgEndVlanRange,zEndStartVlanRange,zEndEndVlanRange)%> ">
				  </td>
		<%   } else { %>
				  <td class="list<%= (rowCounter % 2) %>" align=left width="50%" maxlength="32" size="32"> </td>
		<%   } %>
				</tr>
			  </table>
			</td>
			<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
		  </tr>
		  <% rowCounter++; %>
		  <% } %>
