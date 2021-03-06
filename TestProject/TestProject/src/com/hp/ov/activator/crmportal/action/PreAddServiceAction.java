/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.action;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.Vector;

//import oracle.sql.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.hp.ov.activator.crmportal.bean.CAR;
import com.hp.ov.activator.crmportal.bean.Customer;
import com.hp.ov.activator.crmportal.bean.EXPMapping;
import com.hp.ov.activator.crmportal.bean.IPAddrPool;
import com.hp.ov.activator.crmportal.bean.IPNet;
import com.hp.ov.activator.crmportal.bean.Location;
import com.hp.ov.activator.crmportal.bean.PolicyMapping;
import com.hp.ov.activator.crmportal.bean.Profile;
import com.hp.ov.activator.crmportal.bean.Region;
import com.hp.ov.activator.crmportal.bean.Service;
import com.hp.ov.activator.crmportal.bean.ServiceParameter;
import com.hp.ov.activator.crmportal.bean.VlanRange;
import com.hp.ov.activator.crmportal.common.IdGenerator;
import com.hp.ov.activator.crmportal.helpers.ServiceUtils;
import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;
import com.hp.ov.activator.vpn.IPAddressHelper.IPAddressHelper;

public class PreAddServiceAction extends Action

{

	private static final Logger logger = Logger.getLogger("CRMPortalLOG");

	public PreAddServiceAction() {

	}

	@Override
  public ActionForward execute(ActionMapping mapping,

	ActionForm form,

	HttpServletRequest request,

	HttpServletResponse response) throws Exception {
		DatabasePool dbp = null;

		Connection con = null;
		

		// Added by pp for vlan range check start

		VlanRange vlanranges = null;

		int START_DIRECT_VLANID = 0;

		int END_DIRECT_VLANID = 0;

		int START_ACCESS_VLANID = 0;

		int END_ACCESS_VLANID = 0;

		String START_VLANIDS = "0";

		String END_VLANIDS = "0";
		
		int size = 0;
        int cpage = 1;
        int recPerPage = 1; // Just Initialization
        String strPageNo = "1";
        int totalPages = 1;
        int currentRs = 0;
        int lastRs = 0;

        int iPageNo = 1;
        int vPageNo = 1;
        String pt = request.getParameter("mv");
        

		// Added by pp for vlan range check end

		boolean error = false;

		String whereForRate = "RateLimitName != 'Unknown'";

		String customerid = request.getParameter("customerid");

		logger.debug("PreAddServiceAction ======customerid========" + customerid);

		String mv = request.getParameter("mv");

		String curVPNId = request.getParameter("SP_vpnserviceid");

		// logger.debug("PreAddServiceAction ======mv========"+mv);
		
		String searchSite=request.getParameter("searchSite");
	      request.setAttribute("searchSite", searchSite);
	      String siteidSearch = request.getParameter("siteidSearch");
	      request.setAttribute("siteidSearch", siteidSearch);

		if (mv == null) {

			mv = ((ServiceForm) form).getMv();
			pt = ((ServiceForm) form).getMv();
			// logger.debug("PreAddServiceAction ======mv========"+mv);
		}

		String currentPageNo = request.getParameter("currentPageNo");

		// logger.debug("PreAddServiceAction ======currentPageNo========"+currentPageNo);

		if (currentPageNo == null) {
			currentPageNo = ((ServiceForm) form).getCurrentPageNo();
			// logger.debug("PreAddServiceAction ======currentPageNo========"+currentPageNo);
		}

		String viewPageNo = request.getParameter("viewPageNo");

		// logger.debug("PreAddServiceAction ======viewPageNo========"+viewPageNo);

		if (viewPageNo == null) {
			viewPageNo = ((ServiceForm) form).getViewPageNo();
			// logger.debug("PreAddServiceAction ======viewPageNo========"+viewPageNo);
		}

		String type = request.getParameter("type");

		logger.debug("PreAddServiceAction ======type========" + type);

		String attachmentid = request.getParameter("attachmentid");

		logger.debug("PreAddServiceAction ======attachmentid========" + attachmentid);

		String subType = request.getParameter("subType");

		String resend = request.getParameter("resend");

		request.setAttribute("resend", resend);

		String reselect = request.getParameter("reselect");

		// if(type.equals("layer2-VPN")) mv="first";

		request.setAttribute("mv", mv);

		((ServiceForm) form).setMv(mv);

		request.setAttribute("currentPageNo", currentPageNo);

		((ServiceForm) form).setCurrentPageNo(currentPageNo);

		request.setAttribute("viewPageNo", viewPageNo);

		((ServiceForm) form).setViewPageNo(viewPageNo);

		HashMap serviceParameters = new HashMap();

		HashMap parentServiceParameters = new HashMap();

		String serviceid = request.getParameter("serviceid");

		logger.debug("PreAddServiceAction ======serviceid========" + serviceid);

		String parentserviceid = request.getParameter("parentserviceid");
		logger.debug("PreAddServiceAction ======parentserviceid========" + parentserviceid);

		String profile = request.getParameter("SP_QOS_PROFILE");

		// logger.debug("PreAddServiceAction ======SP_QOS_PROFILE========"+profile);

		Customer customer = null;

		Profile[] profiles = null;

		String messageid = null;

		String addressFamily = null;

		// Get database connection from session

		HttpSession session = request.getSession();

		dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);

		try {

			con = dbp.getConnection();

			// Added by pp for vlan range check start

			// The usage if START_DIRECT_VLANID , END_DIRECT_VLANID,
			// START_ACCESS_VLANID, END_ACCESS_VLANID is dummy now since we
			// cannot have a single start and end cos of multiple ranges defined
			// in a region.

			// Have retained it so as to not to affect any other file.May be
			// removed

			String pk = null;

			if (con != null) {

				if (vlanranges != null) {

					START_DIRECT_VLANID = 2001;

					END_DIRECT_VLANID = 3000;

				}

				if (vlanranges != null) {

					START_ACCESS_VLANID = 2001;

					END_ACCESS_VLANID = 3000;

				}

			}

			session.setAttribute("START_DIRECT_VLANID", START_DIRECT_VLANID);

			session.setAttribute("END_DIRECT_VLANID", END_DIRECT_VLANID);

			session.setAttribute("START_ACCESS_VLANID", START_ACCESS_VLANID);

			session.setAttribute("END_ACCESS_VLANID", END_ACCESS_VLANID);

			// System.out.println("START_DIRECT_VLANID= "+START_DIRECT_VLANID);

			// System.out.println(END_DIRECT_VLANID);

			// System.out.println(START_ACCESS_VLANID);

			// System.out.println(END_ACCESS_VLANID);

			// Added by pp for vlan range check end

			((ServiceForm) form).setCustomerid(customerid);

			((ServiceForm) form).setType(type);

			customer = Customer.findByPrimaryKey(con, customerid);

			((ServiceForm) form).setCustomer(customer);

			IdGenerator idGenerator = new IdGenerator(con);

			if (serviceid != null && !serviceid.equals("")) {

				Service service = Service.findByPrimaryKey(con, serviceid);

				// Comment following part. Need further modification!!!!!!

				if (service != null) {

					((ServiceForm) form).setServicename(service.getPresname());

					((ServiceForm) form).setPresname(service.getPresname());

					serviceParameters.put("serviceid", service.getServiceid());

					serviceParameters.put("state", service.getState());

					serviceParameters.put("presname", service.getPresname());

					serviceParameters.put("submitdate", service.getSubmitdate());

					serviceParameters.put("modifydate", service.getModifydate());

					serviceParameters.put("type", service.getType());

					serviceParameters.put("customerid", service.getCustomerid());

					// Following is commented by tanye. parentserviceid must be
					// passed in.

					// if parent service id was passed through request - then
					// use it,

					// else use from service params

					/*
					 * parentserviceid = parentserviceid != null ? parentserviceid : service.getParentserviceid();
					 * 
					 * 
					 * 
					 * // if it is Layer3 site - then there aren't any parent service id,
					 * 
					 * 
					 * 
					 * //it should be fetched from VPNMembership
					 * 
					 * 
					 * 
					 * if (parentserviceid == null && "layer3-Site".equals(service.getType())) {
					 * 
					 * 
					 * 
					 * parent service id is needed
					 * 
					 * 
					 * 
					 * when creating/deleting L3Site and after
					 * 
					 * 
					 * 
					 * failure retry is pressed
					 * 
					 * 
					 * 
					 * 
					 * 
					 * 
					 * 
					 * for other cases for Layer3 sites parent
					 * 
					 * 
					 * 
					 * service id is not used
					 * 
					 * 
					 * 
					 * 
					 * 
					 * 
					 * 
					 * final VPNMembership[] memberships = VPNMembership.findBySiteid(con, serviceid);
					 * 
					 * 
					 * 
					 * if (memberships != null && memberships.length > 0) {
					 * 
					 * 
					 * 
					 * parentserviceid = memberships[0].getVpnid();
					 * 
					 * 
					 * 
					 * }
					 * 
					 * 
					 * 
					 * }
					 */

				}

				serviceParameters.put("parentserviceid", parentserviceid);

				ServiceParameter[] serviceParamArray = ServiceParameter.findByServiceid(con, serviceid);

				// Map all array entries to a HashMap.

				if (!"true".equals(resend) || ("true".equals(resend) && !"true".equals(reselect))) {

					if (serviceParamArray != null) {

						for (int i = 0; i < serviceParamArray.length; i++) {

							serviceParameters.put(serviceParamArray[i].getAttribute(), serviceParamArray[i].getValue());

							request.setAttribute(serviceParamArray[i].getAttribute(), serviceParamArray[i].getValue());
						}

					}

				}

			}

			if (parentserviceid != null && !parentserviceid.equals("")) {

				Service parentService = Service.findByPrimaryKey(con, parentserviceid);

				if (parentService != null) {

					parentServiceParameters.put("serviceid", parentService.getServiceid());

					parentServiceParameters.put("state", parentService.getState());

					parentServiceParameters.put("presname", parentService.getPresname());

					parentServiceParameters.put("submitdate", parentService.getSubmitdate());

					parentServiceParameters.put("modifydate", parentService.getModifydate());

					parentServiceParameters.put("type", parentService.getType());

					parentServiceParameters.put("customerid", parentService.getCustomerid());

					parentServiceParameters.put("parentserviceid", parentService.getParentserviceid());

					ServiceParameter[] parentServiceParamArray = ServiceParameter.findByServiceid(con, parentserviceid);

					if (parentServiceParamArray != null) {

						for (int i = 0; i < parentServiceParamArray.length; i++) {

							parentServiceParameters.put(parentServiceParamArray[i].getAttribute(), parentServiceParamArray[i].getValue());

						}

					}

				}

			}

			if (customer != null) {

				if (serviceid == null) {

					serviceid = idGenerator.getServiceId();

				}

				messageid = idGenerator.getMessageId();

			}

			((ServiceForm) form).setServiceid(serviceid);

			((ServiceForm) form).setMessageid(messageid);

			((ServiceForm) form).setParentserviceid(parentserviceid);

			if (profile == null)

				profile = (String) serviceParameters.get("QOS_PROFILE");

			request.setAttribute("serviceParameters", serviceParameters);

			request.setAttribute("parentServiceParameters", parentServiceParameters);

			request.setAttribute("SP_QOS_PROFILE", profile);

			request.setAttribute("SP_vpnserviceid", serviceParameters.get("vpnserviceid"));
			String vpnserviceid = (String) serviceParameters.get("vpnserviceid");
			if (type.equals("layer2-VPN")) {

				profiles = Profile.findByLayer(con, "layer 2", "(customerid is null or customerid = '" + customerid + "')");

				String ethServiceType = null;
				String VLANId = null;
				String fixedVLAN = null;
				ethServiceType = (String) serviceParameters.get("EthServiceType");

				request.setAttribute("SP_EthServiceType", ethServiceType);

				VLANId = (String) serviceParameters.get("VLANId");

				request.setAttribute("SP_VLANId", VLANId);

				fixedVLAN = (String) serviceParameters.get("FixedVlan");

				request.setAttribute("SP_FixedVlan", fixedVLAN);

				// Find all the vlanid ranges belonging to that range

				VlanRange[] vlanRanges = VlanRange.findByUsageallocationregion(con, "Attachment", "External", "Provider");
				if (vlanRanges == null) {
					vlanRanges = VlanRange.findByUsageallocationregion(con, "Attachment", "External", "Provider");
				}

				if (vlanRanges != null) {
					START_VLANIDS = "";
					END_VLANIDS = "";
					for (int i = 0; i < vlanRanges.length; i++) {
						/*
						 * if(START_VLANIDS != "") START_VLANIDS += ","; if(END_VLANIDS != "") END_VLANIDS += ",";
						 */
						if (i == vlanRanges.length - 1) {
							START_VLANIDS += ",";
							END_VLANIDS += ",";
						}
						START_VLANIDS = START_VLANIDS + vlanRanges[i].getStartvalue();
						END_VLANIDS = END_VLANIDS + vlanRanges[i].getEndvalue();
					}
				}
				session.setAttribute("START_VLANIDS", START_VLANIDS);
				session.setAttribute("END_VLANIDS", END_VLANIDS);
			}

			if (type.equals("layer3-VPN")) {	
				
				try{
				String whereClause1 = null;
				String whereClause2 = null;
				addressFamily = (String) serviceParameters.get("AddressFamily");
				if (addressFamily == null)
					addressFamily = request.getParameter("SP_AddressFamily");
				if ("IPv6".equalsIgnoreCase(addressFamily)) {
					whereClause1 = "peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename like '%_v6'";
					whereClause2 = "customerid is null and peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename like '%_v6'";
				} else {
					whereClause1 = "peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename not like '%_v6'";
					whereClause2 = "customerid is null and peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename not like '%_v6'";
				}
				profiles = Profile.findByCustomeridlayer(con, customerid, "layer 3", whereClause1);

				Profile[] foreignprofiles = Profile.findByLayer(con, "layer 3", whereClause2);

				request.setAttribute("foreignprofiles", foreignprofiles);

				String vpnTopolology = null;

				String managedCE = null;

				String actScope = null;

				vpnTopolology = (String) serviceParameters.get("VPNTopology");
				if (vpnTopolology == null)
					vpnTopolology = request.getParameter("SP_VPNTopology");

				request.setAttribute("SP_VPNTopology", vpnTopolology);

				managedCE = (String) serviceParameters.get("CE_Routers_managed_per_default");
				if (managedCE == null)
					managedCE = request.getParameter("SP_CE_Routers_managed_per_default");

				request.setAttribute("SP_MANAGEDCE", managedCE);

				actScope = (String) serviceParameters.get("Default_Activation_Scope");
				if (actScope == null)
					actScope = request.getParameter("SP_Default_Activation_Scope");

				request.setAttribute("SP_ACTIVATIONSCOPE", actScope);

				request.setAttribute("SP_AddressFamily", addressFamily);

				}catch(Exception e){
					
					System.out.println("Exception is :::::::" +e);
				}
			}


				if (type.equals("GIS-VPN")) {
		
				String whereClause1 = null;
				String whereClause2 = null;
				addressFamily = (String) serviceParameters.get("AddressFamily");
				if (addressFamily == null)
					addressFamily = request.getParameter("SP_AddressFamily");
				if ("IPv6".equalsIgnoreCase(addressFamily)) {
					whereClause1 = "peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename like '%_v6'";
					whereClause2 = "customerid is null and peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename like '%_v6'";
				} else {
					whereClause1 = "peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename not like '%_v6'";
					whereClause2 = "customerid is null and peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename not like '%_v6'";
				}
				profiles = Profile.findByCustomeridlayer(con, customerid, "layer 3", whereClause1);

				Profile[] foreignprofiles = Profile.findByLayer(con, "layer 3", whereClause2);

				request.setAttribute("foreignprofiles", foreignprofiles);

				String vpnTopolology = null;

				String managedCE = null;

				String actScope = null;

				vpnTopolology = (String) serviceParameters.get("VPNTopology");
				if (vpnTopolology == null)
					vpnTopolology = request.getParameter("SP_VPNTopology");

				request.setAttribute("SP_VPNTopology", vpnTopolology);

				managedCE = (String) serviceParameters.get("CE_Routers_managed_per_default");
				if (managedCE == null)
					managedCE = request.getParameter("SP_CE_Routers_managed_per_default");

				request.setAttribute("SP_MANAGEDCE", managedCE);

				actScope = (String) serviceParameters.get("Default_Activation_Scope");
				if (actScope == null)
					actScope = request.getParameter("SP_Default_Activation_Scope");

				request.setAttribute("SP_ACTIVATIONSCOPE", actScope);

				request.setAttribute("SP_AddressFamily", addressFamily);

				}

			request.setAttribute("profiles", profiles);
			

			// LAYER 2 - VPWS

			if (type.equals("layer2-VPWS")) {

				String Site_Service_ID_aEnd = (String) serviceParameters.get("Site_Service_ID_aEnd");

				String Site_Attachment_ID_aEnd = (String) serviceParameters.get("Site_Attachment_ID_aEnd");

				if (Site_Service_ID_aEnd == null) {

					Site_Service_ID_aEnd = request.getParameter("SP_Site_Service_ID_aEnd");

					Site_Attachment_ID_aEnd = request.getParameter("SP_Site_Attachment_ID_aEnd");

					if (Site_Service_ID_aEnd == null)

						Site_Service_ID_aEnd = idGenerator.getServiceId();

					if (Site_Attachment_ID_aEnd == null)

						Site_Attachment_ID_aEnd = idGenerator.getServiceId();

				}

				String Site_Service_ID_zEnd = (String) serviceParameters.get("Site_Service_ID_zEnd");

				String Site_Attachment_ID_zEnd = (String) serviceParameters.get("Site_Attachment_ID_zEnd");

				if (Site_Service_ID_zEnd == null) {

					Site_Service_ID_zEnd = request.getParameter("SP_Site_Service_ID_zEnd");

					Site_Attachment_ID_zEnd = request.getParameter("SP_Site_Attachment_ID_zEnd");

					if (Site_Service_ID_zEnd == null)

						Site_Service_ID_zEnd = idGenerator.getServiceId();

					if (Site_Attachment_ID_zEnd == null)

						Site_Attachment_ID_zEnd = idGenerator.getServiceId();

				}

				request.setAttribute("SP_Site_Service_ID_aEnd", Site_Service_ID_aEnd);

				request.setAttribute("SP_Site_Attachment_ID_aEnd", Site_Attachment_ID_aEnd);

				request.setAttribute("SP_Site_Service_ID_zEnd", Site_Service_ID_zEnd);

				request.setAttribute("SP_Site_Attachment_ID_zEnd", Site_Attachment_ID_zEnd);

				Location[] locations_aEnd = null;

				Location[] locations_zEnd = null;

				Region[] regions = null;

				CAR[] rateLimits = null;

				String PW_aEnd_location = null;

				String PW_zEnd_location = null;

				String PW_aEnd_region = null;

				String PW_zEnd_region = null;

				// PW_Type states the type of service: FR, PPP, Ethernet

				String PW_Type_aEnd = null;

				String PW_Type_zEnd = null;

				// EthType states the type of service: port or port-vlan

				String EthType_aEnd = null;

				String EthType_zEnd = null;

				String UNIType_aEnd = null;

				String UNIType_zEnd = null;

				String ServiceMultiplexing_aEnd = (String) serviceParameters.get("ServiceMultiplexing_aEnd");

				request.setAttribute("ServiceMultiplexing_aEnd", ServiceMultiplexing_aEnd);

				String ServiceMultiplexing_zEnd = (String) serviceParameters.get("ServiceMultiplexing_zEnd");

				request.setAttribute("ServiceMultiplexing_zEnd", ServiceMultiplexing_zEnd);

				UNIType_aEnd = (String) serviceParameters.get("UNIType_aEnd");

				if (UNIType_aEnd == null) {

					UNIType_aEnd = request.getParameter("SP_UNIType_aEnd");

					if (UNIType_aEnd == null) {

						UNIType_aEnd = "Port";

					}

				}

				PW_Type_aEnd = (String) serviceParameters.get("PW_Type_aEnd");

				if (PW_Type_aEnd == null) {

					PW_Type_aEnd = request.getParameter("SP_PW_Type_aEnd");

					if (PW_Type_aEnd == null) {

						PW_Type_aEnd = "Ethernet";

					}

				}

				UNIType_zEnd = (String) serviceParameters.get("UNIType_zEnd");

				if (UNIType_zEnd == null) {

					UNIType_zEnd = request.getParameter("SP_UNIType_zEnd");

					if (UNIType_zEnd == null) {

						UNIType_zEnd = "Port";

					}

				}

				PW_Type_zEnd = (String) serviceParameters.get("PW_Type_zEnd");

				if (PW_Type_zEnd == null) {

					PW_Type_zEnd = request.getParameter("SP_PW_Type_zEnd");

					if (PW_Type_zEnd == null) {

						PW_Type_zEnd = "Ethernet";

					}

				}

				request.setAttribute("UNIType_aEnd", UNIType_aEnd);

				request.setAttribute("UNIType_zEnd", UNIType_zEnd);

				request.setAttribute("PW_Type_aEnd", PW_Type_aEnd);

				request.setAttribute("PW_Type_zEnd", PW_Type_zEnd);
				
				//Added for L2 VLAN
				
				String	SP_Vlan_Flag_aEnd = request.getParameter("SP_Vlan_Flag_aEnd");

				String	SP_Vlan_Flag_zEnd = request.getParameter("SP_Vlan_Flag_zEnd");

				request.setAttribute("SP_Vlan_Flag_aEnd", SP_Vlan_Flag_aEnd);
				request.setAttribute("SP_Vlan_Flag_zEnd", SP_Vlan_Flag_zEnd);
				

				if ("Ethernet".equals(PW_Type_aEnd)) {

					EthType_aEnd = (String) serviceParameters.get("EthType_aEnd");

					if (EthType_aEnd == null)

						EthType_aEnd = request.getParameter("SP_EthType_aEnd");

					if (EthType_aEnd == null)

						EthType_aEnd = "Port";

					if (!"Ethernet".equals(PW_Type_zEnd))

						EthType_aEnd = "VPWS-PortVlan";

				}

				if ("Ethernet".equals(PW_Type_zEnd)) {

					EthType_zEnd = (String) serviceParameters.get("EthType_zEnd");

					if (EthType_zEnd == null)

						EthType_zEnd = request.getParameter("SP_EthType_zEnd");

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

				request.setAttribute("EthType_aEnd", EthType_aEnd);

				request.setAttribute("EthType_zEnd", EthType_zEnd);

				String PW_aEnd = (String) serviceParameters.get("PW_aEnd");

				if (PW_aEnd == null) {

					PW_aEnd = request.getParameter("SP_PW_aEnd");

				}

				String PW_zEnd = (String) serviceParameters.get("PW_zEnd");

				if (PW_zEnd == null) {

					PW_zEnd = request.getParameter("SP_PW_zEnd");

				}

				request.setAttribute("PW_aEnd", PW_aEnd);

				request.setAttribute("PW_zEnd", PW_zEnd);

				String VLANIdaEnd = (String) serviceParameters.get("VLANIdaEnd");

				if (VLANIdaEnd == null) {

					VLANIdaEnd = request.getParameter("SP_VLANIdaEnd");

				}

				String VLANIdzEnd = (String) serviceParameters.get("VLANIdzEnd");

				if (VLANIdzEnd == null) {

					VLANIdzEnd = request.getParameter("SP_VLANIdzEnd");

				}

				request.setAttribute("VLANIdaEnd", VLANIdaEnd);

				request.setAttribute("VLANIdzEnd", VLANIdzEnd);

				String DLCIaEnd = (String) serviceParameters.get("DLCIaEnd");

				if (DLCIaEnd == null) {

					DLCIaEnd = request.getParameter("SP_DLCIaEnd");

				}

				String DLCIzEnd = (String) serviceParameters.get("DLCIzEnd");

				if (DLCIzEnd == null) {

					DLCIzEnd = request.getParameter("SP_DLCIzEnd");

				}

				request.setAttribute("DLCIaEnd", DLCIaEnd);

				request.setAttribute("DLCIzEnd", DLCIzEnd);

				String rateLimit = (String) serviceParameters.get("RL");

				if (rateLimit == null) {

					rateLimit = request.getParameter("SP_RL");

				}

				Profile qosprofile = null;
				String qosprofileName = (String) serviceParameters.get("QOS_PROFILE");

				if (qosprofileName == null) {

					qosprofileName = request.getParameter("SP_QOS_PROFILE");

				}

				request.setAttribute("SP_RL", rateLimit);
				request.setAttribute("SP_QOS_PROFILE", qosprofileName);

				// String baseProfile =
				// (String)serviceParameters.get("QOS_BASE_PROFILE");
				// if(baseProfile == null){
				// baseProfile = request.getParameter("SP_QOS_BASE_PROFILE");
				// }
				// request.setAttribute("SP_QOS_BASE_PROFILE", baseProfile);

				Profile[] qosprofiles = null;
				qosprofiles = Profile.findByLayer(con, "l2vpws");
				regions = Region.findAll(con, "name  IN (select region from CR_location)");
				request.setAttribute("qosprofiles", qosprofiles);

				// if (baseProfile == null || baseProfile.equals("")) {
				// baseProfile = qosprofileName;
				// }
				// if (baseProfile != null) {
				// qosprofile = Profile.findByQosprofilename(con, baseProfile);
				// }

				request.setAttribute("regions", regions);
				PW_aEnd_region = (String) serviceParameters.get("PW_aEnd_region");
				if (PW_aEnd_region == null) {
					PW_aEnd_region = request.getParameter("SP_PW_aEnd_region");
				}
				if (regions != null) {
					if (PW_aEnd_region == null) {
						PW_aEnd_region = regions[0].getPrimaryKey();
					}
				}

				PW_zEnd_region = (String) serviceParameters.get("PW_zEnd_region");
				if (PW_zEnd_region == null) {
					PW_zEnd_region = request.getParameter("SP_PW_zEnd_region");
				}
				if (regions != null) {

					if (PW_zEnd_region == null) {

						PW_zEnd_region = regions[0].getPrimaryKey();

					}

				}

				request.setAttribute("PW_aEnd_region", PW_aEnd_region);

				request.setAttribute("PW_zEnd_region", PW_zEnd_region);

				// LOCATIONS

				locations_aEnd = Location.findByRegion(con, PW_aEnd_region);

				locations_zEnd = Location.findByRegion(con, PW_zEnd_region);

				request.setAttribute("locations_aEnd", locations_aEnd);

				request.setAttribute("locations_zEnd", locations_zEnd);

				// RATELIMITS

				rateLimits = CAR.findAll(con, whereForRate);

				request.setAttribute("rateLimits", rateLimits);

				// David add
				EXPMapping[] expMappings = null;
				expMappings = EXPMapping.findAll(con);
				request.setAttribute("expMappings", expMappings);
				// System.out.println("VPWS expMappings the length is :" +
				// expMappings.length);
				// modify by tanye. Aquire the reuseable site

				Service[] available_sites = getAvailableSite(con, customerid, "");

				request.setAttribute("available_sites", available_sites);

				String[] available_siteid = null;

				try {
					available_siteid = new String[available_sites.length];
					for (int i = 0; i < available_sites.length; i++) {
						available_siteid[i] = available_sites[i].getServiceid();
					}
				} catch (Exception ex) {
					logger.debug("Exception thrown while iterating the availables sites for the customer = " + customerid + " (available_sites = "
							+ available_sites + ")");
					ex.printStackTrace();
					throw ex;
				}

				// PR 16399
				// ServiceParameter[] available_regions =
				// ServiceParameter.findByArrayServiceid(con, available_siteid,
				// "crm_serviceparam.Attribute = 'Region'", null, null, false);

				// ServiceParameter[] available_regions=null;
				// ServiceParameter[] available_locations=null;
				Vector<Object> RegionResultVector = new Vector<Object>();
				Vector<Object> LocationResultVector = new Vector<Object>();

				for (int i = 0; i < available_siteid.length; i++) {
					ServiceParameter[] available_regions_partial = ServiceParameter.findByServiceid(con, available_siteid[i],
							"crm_serviceparam.Attribute = 'Region'", null, false);
					ServiceParameter[] available_locations_partial = ServiceParameter.findByServiceid(con, available_siteid[i],
							"crm_serviceparam.Attribute = 'Location'", null, false);

					if (available_regions_partial != null) {
						for (int ii = 0; ii < available_regions_partial.length; ii++) {
							RegionResultVector.add(available_regions_partial[0]);
						}
					}
					if (available_locations_partial != null) {
						for (int jj = 0; jj < available_locations_partial.length; jj++) {
							LocationResultVector.add(available_locations_partial[0]);
						}
					}
					
					// in case of multiplexing VPWS sites BEGIN
					if (available_regions_partial == null) { 
						available_regions_partial = ServiceParameter.findAll(con,
							"(attribute='PW_aEnd_region' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_aEnd' and value="+available_siteid[i]+")) "+
							"OR (attribute='PW_zEnd_region' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_zEnd' and value="+available_siteid[i]+"))", "", false);
							
						if (available_regions_partial != null) {
							for (int ii = 0; ii < available_regions_partial.length; ii++) 
							{							
								ServiceParameter SP = new ServiceParameter();
								SP.setServiceid(available_siteid[i]);
								SP.setAttribute("Region");
								SP.setValue(available_regions_partial[0].getValue());
								RegionResultVector.add(SP);
							}
						}
					}
					
					if (available_locations_partial == null) {
						available_locations_partial = ServiceParameter.findAll(con,
							"(attribute='PW_aEnd_location' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_aEnd' and value="+available_siteid[i]+")) "+
							"OR (attribute='PW_zEnd_location' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_zEnd' and value="+available_siteid[i]+"))", "", false);
							
						if (available_locations_partial != null) {
							for (int ii = 0; ii < available_locations_partial.length; ii++) 
							{							
								ServiceParameter SP = new ServiceParameter();
								SP.setServiceid(available_siteid[i]);
								SP.setAttribute("Region");
								SP.setValue(available_locations_partial[0].getValue());
								LocationResultVector.add(SP);
							}
						}
					}
					// in case of multiplexing VPWS sites END
				}

				ServiceParameter[] available_regions = new ServiceParameter[RegionResultVector.size()];
				RegionResultVector.copyInto(available_regions);
				ServiceParameter[] available_locations = new ServiceParameter[LocationResultVector.size()];
				LocationResultVector.copyInto(available_locations);

				// PR 16399 Ends
				// ServiceParameter[] available_locations =
				// ServiceParameter.findByArrayServiceid(con, available_siteid,
				// "crm_serviceparam.Attribute = 'Location'", null, null,
				// false);
				// ServiceParameter[] available_locations;
				// ServiceParameter[] available_locations =
				// ServiceParameter.findByServiceidattribute(con,
				// available_siteid, "Location", null, null, false);
				request.setAttribute("available_regions", available_regions);

				request.setAttribute("available_locations", available_locations);
				
			}

      // TODO developing Trunk
			try{
      if (type.equals("Trunk")) {

    	  System.out.println("Trunk Code Started ");
        request.setAttribute("ServiceForm", request.getAttribute("ServiceForm"));
        
        String SP_link_type = "";
        String SP_link_types[] = {"1G", "10G", "100G"};
        request.setAttribute("SP_link_types", SP_link_types);

        SP_link_type = (String) serviceParameters.get("SP_link_type");

        if (SP_link_type == null) {

          SP_link_type = request.getParameter("SP_link_type");

        }
        if (SP_link_type != null) {

          request.setAttribute("SP_link_type", SP_link_type);
          serviceParameters.put("SP_link_type", SP_link_type);
        }
        
        String reqtype = request.getParameter("reqtype");
        request.setAttribute("reqtype", reqtype);

        String SP_trunk_id = request.getParameter("SP_trunk_id");
        request.setAttribute("SP_trunk_id", SP_trunk_id);
        
        String Site_Service_ID_aEnd = (String) serviceParameters.get("Site_Service_ID_aEnd");
        if (Site_Service_ID_aEnd == null) {
          Site_Service_ID_aEnd = request.getParameter("SP_Site_Service_ID_aEnd");
          if (Site_Service_ID_aEnd == null)
            Site_Service_ID_aEnd = idGenerator.getServiceId();
        }
        String Site_Service_ID_zEnd = (String) serviceParameters.get("Site_Service_ID_zEnd");
        if (Site_Service_ID_zEnd == null) {
          Site_Service_ID_zEnd = request.getParameter("SP_Site_Service_ID_zEnd");
          if (Site_Service_ID_zEnd == null)
            Site_Service_ID_zEnd = idGenerator.getServiceId();
        }
        request.setAttribute("SP_Site_Service_ID_aEnd", Site_Service_ID_aEnd);
        request.setAttribute("SP_Site_Service_ID_zEnd", Site_Service_ID_zEnd);

        // The following variable are declared outside the if because they are used in subinterface part
        String ipaddr_aEnd = null;
        String ipaddr_zEnd = null;
        String SP_Sub_ipaddress_aEnd = null;
        String SP_Sub_ipaddress_zEnd = null;
        List<String> iplist_aEnd = new ArrayList<String>();
        List<String> iplist_zEnd = new ArrayList<String>();
        List<String> Subiplist_aEnd = new ArrayList<String>();
        List<String> Subiplist_zEnd = new ArrayList<String>();
        String SP_IPv6_Address_aEnd = null;
        String SP_IPv6_Address_zEnd = null;
        String SP_Sub_IPv6_Address_aEnd = null;
        String SP_Sub_IPv6_Address_zEnd = null;
        List<String> Ipv6_iplist_aEnd = new ArrayList<String>();
        List<String> Ipv6_iplist_zEnd = new ArrayList<String>();
        List<String> SubIpv6_iplist_aEnd = new ArrayList<String>();
        List<String> SubIpv6_iplist_zEnd = new ArrayList<String>();
        
        if (reqtype == null) {
          error = setAllTrunks(con, customerid, error, request);
        } else if ("detailTrunk".equals(reqtype)) {
          String serviceId = request.getParameter("serviceId");
          List<HashMap<String,String>> allTrunksData = getTrunkDetails(con, serviceId);
          request.setAttribute("allTrunksData", allTrunksData);
        } else {
          
          if ("createTrunk".equals(reqtype) || "deleteTrunk".equals(reqtype)) {
            error = setAllTrunks(con, customerid, error, request);
          }
          
          String perouter_aEnd = null;
          String perouter_zEnd = null;
          String peinterface_aEnd = null;
          String peinterface_zEnd = null;
          String trunktype = null;
          String pool = null;
          String pool_aEnd = null;
          String pool_zEnd = null;
          String IPv6_family_aEnd = null;
          String IPv6_family_zEnd = null;
          String SP_Sub_IPv6_family_aEnd = null;
          String SP_Sub_IPv6_family_zEnd = null;
          String trunkname = "";
          String subinterface_name = null;
          String EndA_name = "";
          String EndB_name = "";
          String SP_ip_submask_aEnd = null;
          String SP_ip_submask_zEnd = null;
          String ip_networkIP_aEnd = null;
          String ip_networkIP_zEnd = null;
          String wildcard_aEnd = null;
          String wildcard_zEnd = null;
          List<String> Sub_ip_subnetmask_aEnd = null;
          List<String> Sub_ip_subnetmask_zEnd = null;
          String SP_Sub_ip_submask_aEnd = null;
          String SP_Sub_ip_submask_zEnd = null;
          String SP_Sub_ip_networkIP_aEnd = null;
          String SP_Sub_ip_networkIP_zEnd = null;
          String SP_Sub_wildcard_aEnd = null;
          String SP_Sub_wildcard_zEnd = null;
          String trunkdescription_a = null;
          String trunkdescription_b = null;
          String Interface_description_aEnd = null;
          String Interface_description_zEnd = null;
          Location[] locations_aEnd = null;
          Location[] locations_zEnd = null;
          Region[] regions = null;
          CAR[] rateLimits = null;
          String PW_aEnd_region = null;
          String PW_zEnd_region = null;
          String SP_trunk_negotiation_aside = null;
          String SP_trunk_negotiation_zside = null;

          String rateLimit = (String) serviceParameters.get("RL");
          if (rateLimit == null) {
            rateLimit = request.getParameter("SP_RL");
          }
          String qosprofileName = (String) serviceParameters.get("QOS_PROFILE");
          if (qosprofileName == null) {
            qosprofileName = request.getParameter("SP_QOS_PROFILE");
          }
          request.setAttribute("SP_RL", rateLimit);
          request.setAttribute("SP_QOS_PROFILE", qosprofileName);
          Profile[] qosprofiles = null;
          qosprofiles = Profile.findByLayer(con, "trunk");
          
          regions = Region.findAll(con, "name  IN (select region from CR_location)");
          request.setAttribute("qosprofiles", qosprofiles);
          request.setAttribute("regions", regions);
          // RATELIMITS
          rateLimits = CAR.findAll(con, whereForRate);
          request.setAttribute("rateLimits", rateLimits);
          EXPMapping[] expMappings = null;
          expMappings = EXPMapping.findAll(con);
          request.setAttribute("expMappings", expMappings);
          String SP_trunk_policy_aside = request.getParameter("SP_trunk_policy_aside");
          String SP_trunk_policy_zside = request.getParameter("SP_trunk_policy_zside");
          request.setAttribute("SP_trunk_policy_aside", SP_trunk_policy_aside);
          request.setAttribute("SP_trunk_policy_zside", SP_trunk_policy_zside);
          String Traffic_policy_io_aend = request.getParameter("SP_Traffic_policy_io_aend");
          String Traffic_policy_io_zend = request.getParameter("SP_Traffic_policy_io_zend");
          request.setAttribute("SP_Traffic_policy_io_aend", Traffic_policy_io_aend);
          request.setAttribute("SP_Traffic_policy_io_zend", Traffic_policy_io_zend);
          String SP_trunk_aside_ospf_cost = request.getParameter("SP_trunk_aside_ospf_cost");
          String SP_trunk_zside_ospf_cost = request.getParameter("SP_trunk_zside_ospf_cost");
          request.setAttribute("SP_trunk_aside_ospf_cost", SP_trunk_aside_ospf_cost);
          request.setAttribute("SP_trunk_zside_ospf_cost", SP_trunk_zside_ospf_cost);
          String SP_OSPF_aPassword = request.getParameter("SP_OSPF_aPassword");
          String SP_OSPF_zPassword = request.getParameter("SP_OSPF_zPassword");
          request.setAttribute("SP_OSPF_aPassword", SP_OSPF_aPassword);
          request.setAttribute("SP_OSPF_zPassword", SP_OSPF_zPassword);
          String SP_LDP_aPassword = request.getParameter("SP_LDP_aPassword");
          String SP_LDP_zPassword = request.getParameter("SP_LDP_zPassword");
          request.setAttribute("SP_LDP_aPassword", SP_LDP_aPassword);
          request.setAttribute("SP_LDP_zPassword", SP_LDP_zPassword);
          String SP_area_number_aEnd = request.getParameter("SP_area_number_aEnd");
          String SP_area_number_zEnd = request.getParameter("SP_area_number_zEnd");
          request.setAttribute("SP_area_number_aEnd", SP_area_number_aEnd);
          request.setAttribute("SP_area_number_zEnd", SP_area_number_zEnd);
          String SP_network_type_aside = request.getParameter("SP_network_type_aside");
          String SP_network_type_zside = request.getParameter("SP_network_type_zside");
          request.setAttribute("SP_network_type_aside", SP_network_type_aside);
          request.setAttribute("SP_network_type_zside", SP_network_type_zside);
          String SP_ospf_aside = request.getParameter("SP_ospf_aside");
          String SP_ospf_zside = request.getParameter("SP_ospf_zside");
          request.setAttribute("SP_ospf_aside", SP_ospf_aside);
          request.setAttribute("SP_ospf_zside", SP_ospf_zside);
          String SP_trunk_ldp_aside = request.getParameter("SP_trunk_ldp_aside");
          String SP_trunk_ldp_zside = request.getParameter("SP_trunk_ldp_zside");
          request.setAttribute("SP_trunk_ldp_aside", SP_trunk_ldp_aside);
          request.setAttribute("SP_trunk_ldp_zside", SP_trunk_ldp_zside);
          String SP_lnk_Protocol_aside = request.getParameter("SP_lnk_Protocol_aside");
          String SP_lnk_Protocol_zside = request.getParameter("SP_lnk_Protocol_zside");
          request.setAttribute("SP_lnk_Protocol_aside", SP_lnk_Protocol_aside);
          request.setAttribute("SP_lnk_Protocol_zside", SP_lnk_Protocol_zside);
          String SP_pim_name_aside = request.getParameter("SP_pim_name_aside");
          String SP_pim_name_zside = request.getParameter("SP_pim_name_zside");
          request.setAttribute("SP_pim_name_aside", SP_pim_name_aside);
          request.setAttribute("SP_pim_name_zside", SP_pim_name_zside);
          String SP_Trunk_bandwidth_aEnd = request.getParameter("SP_Trunk_bandwidth_aEnd");
          String SP_Trunk_bandwidth_zEnd = request.getParameter("SP_Trunk_bandwidth_zEnd");
          request.setAttribute("SP_Trunk_bandwidth_aEnd", SP_Trunk_bandwidth_aEnd);
          request.setAttribute("SP_Trunk_bandwidth_zEnd", SP_Trunk_bandwidth_zEnd);
          String SP_Trunk_rsvp_bandwidth_aEnd = request.getParameter("SP_Trunk_rsvp_bandwidth_aEnd");
          String SP_Trunk_rsvp_bandwidth_zEnd = request.getParameter("SP_Trunk_rsvp_bandwidth_zEnd");
          request.setAttribute("SP_Trunk_rsvp_bandwidth_aEnd", SP_Trunk_rsvp_bandwidth_aEnd);
          request.setAttribute("SP_Trunk_rsvp_bandwidth_zEnd", SP_Trunk_rsvp_bandwidth_zEnd);
          addressFamily = (String) serviceParameters.get("AddressFamily");
          String SP_trunk_aIPbinding = request.getParameter("SP_trunk_aIPbinding");
          String SP_trunk_zIPbinding = request.getParameter("SP_trunk_zIPbinding");
          request.setAttribute("SP_trunk_aIPbinding", SP_trunk_aIPbinding);
          request.setAttribute("SP_trunk_zIPbinding", SP_trunk_zIPbinding);
          String SP_trunk_aside_processid = request.getParameter("SP_trunk_aside_processid");
          String SP_trunk_zside_processid = request.getParameter("SP_trunk_zside_processid");
          request.setAttribute("SP_trunk_aside_processid", SP_trunk_aside_processid);
          request.setAttribute("SP_trunk_zside_processid", SP_trunk_zside_processid);
          String SP_trunk_aside_mtu = request.getParameter("SP_trunk_aside_mtu");
          String SP_trunk_zside_mtu = request.getParameter("SP_trunk_zside_mtu");
          request.setAttribute("SP_trunk_aside_mtu", SP_trunk_aside_mtu);
          request.setAttribute("SP_trunk_zside_mtu", SP_trunk_zside_mtu);
          String SP_Subtrunk_processid_aEnd = request.getParameter("SP_Subtrunk_processid_aEnd");
          String SP_Subtrunk_processid_zEnd = request.getParameter("SP_Subtrunk_processid_zEnd");
          request.setAttribute("SP_Subtrunk_processid_aEnd", SP_Subtrunk_processid_aEnd);
          request.setAttribute("SP_Subtrunk_processid_zEnd", SP_Subtrunk_processid_zEnd);
          if (addressFamily == null)
            addressFamily = request.getParameter("SP_AddressFamily");
          if (addressFamily == null) {
            addressFamily = "IPv4";
          }
          request.setAttribute("AddressFamily", addressFamily);
          IPAddrPool[] pools = IPAddrPool.findAll(con, "type='IPNet'");
          ArrayList<Object> availablePoolList = new ArrayList<Object>();
          if (pools != null) {
            for (int poolCount = 0; poolCount < pools.length; poolCount++) {
              String poolName = pools[poolCount].getName();
              if (IPNet.findByPoolnameCount(con, poolName, "count__ > '0'") > 0) {
                availablePoolList.add(pools[poolCount]);
              }
            }
          }
          if (availablePoolList.size() != 0) {
            pools = availablePoolList.toArray(new IPAddrPool[availablePoolList.size()]);
          } else {
            pools = null;
          }
          request.setAttribute("pools", pools);
          pool = (String) serviceParameters.get("AddressPool");
          if (pool == null) {
            pool_aEnd = request.getParameter("SP_AddressPool_aEnd");
            pool_zEnd = request.getParameter("SP_AddressPool_zEnd");
          }
          if (pool_aEnd == null || "".equals(pool_aEnd)) {
            if (pools != null) {
              // based on address family pick the first pool
              for (int i = 0; i < pools.length; i++) {
                if (pools[i].getAddressfamily().equals(addressFamily)) {
                  pool_aEnd = pools[i].getName();
                  break;
                }
              }
            }
          }
          if (pool_zEnd == null || "".equals(pool_zEnd)) {
            if (pools != null) {
              // based on address family pick the first pool
              for (int i = 0; i < pools.length; i++) {
                if (pools[i].getAddressfamily().equals(addressFamily)) {
                  pool_zEnd = pools[i].getName();
                  break;
                }
              }
            }
          }
          request.setAttribute("pool_aEnd", pool_aEnd);
          request.setAttribute("pool_zEnd", pool_zEnd);

          // IP Remove when it is selected
          SP_Sub_ipaddress_aEnd = request.getParameter("SP_Sub_ipaddress_aEnd");
          SP_Sub_ipaddress_zEnd = request.getParameter("SP_Sub_ipaddress_zEnd");

          if (pool_aEnd != null) {
            iplist_aEnd = getIPNETAddr(con, pool_aEnd);
          }
          
          if (pool_zEnd != null) {
            iplist_zEnd = getIPNETAddr(con, pool_zEnd);
          }
          
          ipaddr_aEnd = (String) serviceParameters.get("IPNETAddr");
          if (ipaddr_aEnd == null) {
            ipaddr_aEnd = request.getParameter("SP_trunk_ipaddress_aEnd");
          }
          
          ipaddr_zEnd = (String) serviceParameters.get("IPNETAddr");
          if (ipaddr_zEnd == null) {
            ipaddr_zEnd = request.getParameter("SP_trunk_ipaddress_zEnd");
          }
          
          // Get v4 netmask
          if (ipaddr_aEnd != null && !"".equals(ipaddr_aEnd)) {
            SP_ip_submask_aEnd = getSubnetmask(con, ipaddr_aEnd);
          }
          
          if (ipaddr_zEnd != null && !"".equals(ipaddr_zEnd)) {
            SP_ip_submask_zEnd = getSubnetmask(con, ipaddr_zEnd);
          }
          
          String Subpool_aEnd = null;
          String Subpool_zEnd = null;
          if (pool == null) {
            Subpool_aEnd = request.getParameter("SP_SubAddressPool_aEnd");
            Subpool_zEnd = request.getParameter("SP_SubAddressPool_zEnd");
          }
          if (Subpool_aEnd == null || "".equals(Subpool_aEnd)) {
            if (pools != null) {
              for (int i = 0; i < pools.length; i++) {
                if (pools[i].getAddressfamily().equals(addressFamily)) {
                  Subpool_aEnd = pools[i].getName();
                  break;
                }
              }
            }
          }
          if (Subpool_zEnd == null || "".equals(Subpool_zEnd)) {
            if (pools != null) {
              for (int i = 0; i < pools.length; i++) {
                if (pools[i].getAddressfamily().equals(addressFamily)) {
                  Subpool_zEnd = pools[i].getName();
                  break;
                }
              }
            }
          }
          
          if (Subpool_aEnd != null) {
            Subiplist_aEnd = getIPNETAddr(con, Subpool_aEnd);
          }
          if (Subpool_zEnd != null) {
            Subiplist_zEnd = getIPNETAddr(con, Subpool_zEnd);
          }
          
          if (Subiplist_aEnd != null && Subiplist_aEnd.size() != 0) {
            Sub_ip_subnetmask_aEnd = getIPSubnetMask(con, Subiplist_aEnd.get(0));
          }
          if (Subiplist_zEnd != null && Subiplist_zEnd.size() != 0) {
            Sub_ip_subnetmask_zEnd = getIPSubnetMask(con, Subiplist_zEnd.get(0));
          }

          request.setAttribute("ipaddrlist", ipaddr_aEnd);
          request.setAttribute("ipaddrlist_zEnd", ipaddr_zEnd);
          request.setAttribute("SP_Sub_ipaddress_aEnd", SP_Sub_ipaddress_aEnd);
          request.setAttribute("SP_Sub_ipaddress_zEnd", SP_Sub_ipaddress_zEnd);
          request.setAttribute("Subpool_aEnd", Subpool_aEnd);
          request.setAttribute("Subpool_zEnd", Subpool_zEnd);
          
          List<String> ip_subnetmask_aEnd = null;
          List<String> ip_subnetmask_zEnd = null;
          String ip_submask_aEnd = null;
          String ip_submask_zEnd = null;
          
          ip_subnetmask_aEnd = getIPSubnetMask(con, iplist_aEnd.get(0));
          ip_subnetmask_zEnd = getIPSubnetMask(con, iplist_zEnd.get(0));
          
          if (ip_subnetmask_aEnd != null) {
            ip_submask_aEnd = ip_subnetmask_aEnd.get(0);
            wildcard_aEnd = getWildCard(ip_submask_aEnd);
            ip_networkIP_aEnd = ip_subnetmask_aEnd.get(1);
          }         
          
          if (ip_subnetmask_zEnd != null) {
            ip_submask_zEnd = ip_subnetmask_zEnd.get(0);
            wildcard_zEnd = getWildCard(ip_submask_zEnd);
            ip_networkIP_zEnd = ip_subnetmask_zEnd.get(1);
          }
          
          request.setAttribute("ip_networkIP_aEnd", ipaddr_aEnd);
          request.setAttribute("wildcard_aEnd", wildcard_aEnd);
          request.setAttribute("ip_networkIP_zEnd", ipaddr_zEnd);
          request.setAttribute("wildcard_zEnd", wildcard_zEnd);
          
          
          
          // IPv6
          if (IPv6_family_aEnd == null) {
            IPv6_family_aEnd = request.getParameter("SP_IPv6_family_aEnd");
          }
          if (IPv6_family_zEnd == null) {
            IPv6_family_zEnd = request.getParameter("SP_IPv6_family_zEnd");
          }
          if (SP_Sub_IPv6_family_aEnd == null) {
            SP_Sub_IPv6_family_aEnd = request.getParameter("SP_Sub_IPv6_family_aEnd");
          }
          if (SP_Sub_IPv6_family_zEnd == null) {
            SP_Sub_IPv6_family_zEnd = request.getParameter("SP_Sub_IPv6_family_zEnd");
          }
          request.setAttribute("SP_IPv6_family_aEnd", IPv6_family_aEnd);
          request.setAttribute("SP_IPv6_family_zEnd", IPv6_family_zEnd);
          request.setAttribute("SP_Sub_IPv6_family_aEnd", SP_Sub_IPv6_family_aEnd);
          request.setAttribute("SP_Sub_IPv6_family_zEnd", SP_Sub_IPv6_family_zEnd);
          
          String SP_IPv6_Pool_aEnd = request.getParameter("SP_IPv6_Pool_aEnd");
          String SP_IPv6_Pool_zEnd = request.getParameter("SP_IPv6_Pool_zEnd");
          request.setAttribute("SP_IPv6_Pool_aEnd", SP_IPv6_Pool_aEnd);
          request.setAttribute("SP_IPv6_Pool_zEnd", SP_IPv6_Pool_zEnd);
          
          SP_IPv6_Address_aEnd = request.getParameter("SP_IPv6_Address_aEnd");
          SP_IPv6_Address_zEnd = request.getParameter("SP_IPv6_Address_zEnd");
          
          // Submask with IPv6
          if (SP_IPv6_Address_aEnd != null && !"".equals(SP_IPv6_Address_aEnd)) {
            SP_ip_submask_aEnd = getSubnetmask(con, SP_IPv6_Address_aEnd);  
          }
          
          if (SP_IPv6_Address_zEnd != null && !"".equals(SP_IPv6_Address_zEnd)) {
            SP_ip_submask_zEnd = getSubnetmask(con, SP_IPv6_Address_zEnd);
          }
          request.setAttribute("SP_ip_submask_aEnd", SP_ip_submask_aEnd);
          request.setAttribute("SP_ip_submask_zEnd", SP_ip_submask_zEnd);
          
          String SP_Sub_IPv6_Pool_aEnd = request.getParameter("SP_Sub_IPv6_Pool_aEnd");
          String SP_Sub_IPv6_Pool_zEnd = request.getParameter("SP_Sub_IPv6_Pool_zEnd");
          request.setAttribute("SP_Sub_IPv6_Pool_aEnd", SP_Sub_IPv6_Pool_aEnd);
          request.setAttribute("SP_Sub_IPv6_Pool_zEnd", SP_Sub_IPv6_Pool_zEnd);
          
          SP_Sub_IPv6_Address_aEnd = request.getParameter("SP_Sub_IPv6_Address_aEnd");
          SP_Sub_IPv6_Address_zEnd = request.getParameter("SP_Sub_IPv6_Address_zEnd");
          
          // Submask IPv6
          if (SP_Sub_IPv6_Address_aEnd != null && !"".equals(SP_Sub_IPv6_Address_aEnd)) {
            SP_Sub_ip_submask_aEnd = getSubnetmask(con, SP_Sub_IPv6_Address_aEnd);
          }
          
          if (SP_Sub_IPv6_Address_zEnd != null && !"".equals(SP_Sub_IPv6_Address_zEnd)) {
            SP_Sub_ip_submask_zEnd = getSubnetmask(con, SP_Sub_IPv6_Address_zEnd);
          }
          
          request.setAttribute("SP_Sub_IPv6_Address_aEnd", SP_Sub_IPv6_Address_aEnd);
          request.setAttribute("SP_Sub_IPv6_Address_zEnd", SP_Sub_IPv6_Address_zEnd);

          String SP_Sub_IPv6_encap_aEnd = request.getParameter("SP_Sub_IPv6_encap_aEnd");
          String SP_Sub_IPv6_encap_zEnd = request.getParameter("SP_Sub_IPv6_encap_zEnd");
          request.setAttribute("SP_Sub_IPv6_encap_aEnd", SP_Sub_IPv6_encap_aEnd);
          request.setAttribute("SP_Sub_IPv6_encap_zEnd", SP_Sub_IPv6_encap_zEnd);

          String SP_Sub_IPv6_binding_aEnd = request.getParameter("SP_Sub_IPv6_binding_aEnd");
          String SP_Sub_IPv6_binding_zEnd = request.getParameter("SP_Sub_IPv6_binding_zEnd");
          request.setAttribute("SP_Sub_IPv6_binding_aEnd", SP_Sub_IPv6_binding_aEnd);
          request.setAttribute("SP_Sub_IPv6_binding_zEnd", SP_Sub_IPv6_binding_zEnd);

          if (SP_IPv6_Pool_aEnd == null || "".equals(SP_IPv6_Pool_aEnd)) {
            if (IPv6_family_aEnd != null && IPv6_family_aEnd.equals("true")) {
              for (int i = 0; pools != null && i < pools.length; i++) {
                if (pools[i].getAddressfamily().equals("IPv6")) {
                  if (SP_IPv6_Pool_aEnd == null || "".equals(SP_IPv6_Pool_aEnd)) {
                    SP_IPv6_Pool_aEnd = pools[i].getPrimaryKey();
                    break;
                  }
                }
              }
            }
          }
          if (SP_IPv6_Pool_aEnd != null) {
            Ipv6_iplist_aEnd = getIPNETAddr(con, SP_IPv6_Pool_aEnd);
          }

          if (SP_IPv6_Pool_zEnd == null || "".equals(SP_IPv6_Pool_zEnd)) {
            if (IPv6_family_zEnd != null && IPv6_family_zEnd.equals("true")) {
              for (int i = 0; pools != null && i < pools.length; i++) {
                if (pools[i].getAddressfamily().equals("IPv6")) {
                  if (SP_IPv6_Pool_zEnd == null || "".equals(SP_IPv6_Pool_zEnd)) {
                    SP_IPv6_Pool_zEnd = pools[i].getPrimaryKey();
                    break;
                  }
                }
              }
            }
          }
          if (SP_IPv6_Pool_zEnd != null) {
            Ipv6_iplist_zEnd = getIPNETAddr(con, SP_IPv6_Pool_zEnd);
          }
          if (SP_IPv6_Address_aEnd == null && Ipv6_iplist_aEnd.size() > 0) {
            //SP_IPv6_Address_aEnd = Ipv6_iplist_aEnd.get(0);
          }
          if (SP_IPv6_Address_zEnd == null && Ipv6_iplist_zEnd.size() > 0) {
            //SP_IPv6_Address_zEnd = Ipv6_iplist_zEnd.get(0);
          }
          request.setAttribute("SP_IPv6_Address_aEnd", SP_IPv6_Address_aEnd);
          request.setAttribute("SP_IPv6_Address_zEnd", SP_IPv6_Address_zEnd);

          if (SP_Sub_IPv6_Pool_aEnd == null || "".equals(SP_Sub_IPv6_Pool_aEnd)) {
            if (SP_Sub_IPv6_family_aEnd != null && SP_Sub_IPv6_family_aEnd.equals("true")) {
              for (int i = 0; pools != null && i < pools.length; i++) {
                if (pools[i].getAddressfamily().equals("IPv6")) {
                  if (SP_Sub_IPv6_Pool_aEnd == null || "".equals(SP_Sub_IPv6_Pool_aEnd)) {
                    SP_Sub_IPv6_Pool_aEnd = pools[i].getPrimaryKey();
                    break;
                  }
                }
              }
            }
          }
          if (SP_Sub_IPv6_Pool_aEnd != null) {
            SubIpv6_iplist_aEnd = getIPNETAddr(con, SP_Sub_IPv6_Pool_aEnd);
          }

          if (SP_Sub_IPv6_Pool_zEnd == null || "".equals(SP_Sub_IPv6_Pool_zEnd)) {
            if (SP_Sub_IPv6_family_zEnd != null && SP_Sub_IPv6_family_zEnd.equals("true")) {
              for (int i = 0; pools != null && i < pools.length; i++) {
                if (pools[i].getAddressfamily().equals("IPv6")) {
                  if (SP_Sub_IPv6_Pool_zEnd == null || "".equals(SP_Sub_IPv6_Pool_zEnd)) {
                    SP_Sub_IPv6_Pool_zEnd = pools[i].getPrimaryKey();
                    break;
                  }
                }
              }
            }
          }
          if (SP_Sub_IPv6_Pool_zEnd != null) {
            SubIpv6_iplist_zEnd = getIPNETAddr(con, SP_Sub_IPv6_Pool_zEnd);
          }
          if (SubIpv6_iplist_aEnd != null && SP_Sub_IPv6_Address_aEnd == null && SubIpv6_iplist_aEnd.size() > 0) {
            //SP_Sub_IPv6_Address_aEnd = SubIpv6_iplist_aEnd.get(0);
          }
          if (SubIpv6_iplist_zEnd != null && SP_Sub_IPv6_Address_zEnd == null && SubIpv6_iplist_zEnd.size() > 0) {
            //SP_Sub_IPv6_Address_zEnd = SubIpv6_iplist_zEnd.get(0);
          }
          request.setAttribute("SP_Sub_IPv6_Address_aEnd", SP_Sub_IPv6_Address_aEnd);
          request.setAttribute("SP_Sub_IPv6_Address_zEnd", SP_Sub_IPv6_Address_zEnd);

          // address pool ends here.
          LinkedHashMap<String, String> trunkList = new LinkedHashMap<String, String>();
          if (trunktype == null) {
            trunktype = request.getParameter("SP_Trunk_Type");
            logger.debug("Trunk type First IF " + trunktype);
            trunkList = getTrunkType(con);
          }
          if (trunktype == null) {
            logger.debug("Trunk type 2nd IF is : " + trunktype);
            for (Map.Entry<String, String> entry : trunkList.entrySet()) {
              trunktype = entry.getKey();
              break;
            }
            logger.debug("Trunk type after 2nd IF for is : " + trunktype);
          }
          logger.debug("Trunk type Before setting varial  is : " + trunktype);
          request.setAttribute("trunktype", trunktype);
          request.setAttribute("trunkList", trunkList); // 2 copies you need
          logger.debug("Trunk type First IF " + trunktype);

          PW_aEnd_region = (String) serviceParameters.get("PW_aEnd_region");
          if (PW_aEnd_region == null) {
            PW_aEnd_region = request.getParameter("SP_PW_aEnd_region");
          }
          if (regions != null) {
            if (PW_aEnd_region == null) {
              PW_aEnd_region = regions[0].getPrimaryKey();
            }
          }
          PW_zEnd_region = (String) serviceParameters.get("PW_zEnd_region");
          if (PW_zEnd_region == null) {
            PW_zEnd_region = request.getParameter("SP_PW_zEnd_region");
          }
          if (regions != null) {
            if (PW_zEnd_region == null) {
              PW_zEnd_region = regions[0].getPrimaryKey();
            }
          }
          request.setAttribute("PW_aEnd_region", PW_aEnd_region);
          request.setAttribute("PW_zEnd_region", PW_zEnd_region);
          
          // Locations A
          locations_aEnd = Location.findByRegion(con, PW_aEnd_region);
          locations_zEnd = Location.findByRegion(con, PW_zEnd_region);
          request.setAttribute("locations_aEnd", locations_aEnd);
          request.setAttribute("locations_zEnd", locations_zEnd);

          String pe_location = (String) serviceParameters.get("Location");
          if (pe_location == null) {
            pe_location = request.getParameter("SP_PW_aEnd_location");
            request.setAttribute("SP_PW_aEnd_location", pe_location);
          }

          if (pe_location != null && !locationBelongsToRegion(con, pe_location, PW_aEnd_region))
            pe_location = null;
          if (pe_location == null) {
            pe_location = locations_aEnd[0].getPrimaryKey();
          }
          request.setAttribute("location", pe_location);
          
          // Routers A
          HashMap<String, String> peList_aEnd = new HashMap<String, String>();
          if (pe_location != null) {
            peList_aEnd = getPEList(con, pe_location, trunktype);
          }
          
          perouter_aEnd = request.getParameter("PERouter_aEnd");
          if (perouter_aEnd == null) {
            perouter_aEnd = request.getParameter("SP_PERouter_aEnd");
          }
          if (perouter_aEnd != null && !perouterBelongsToLocation(con, perouter_aEnd, pe_location))
            perouter_aEnd = null;
          
          // Locations Z
          String pe_location_zEnd = (String) serviceParameters.get("Location");
          
          if (pe_location_zEnd == null) {
            pe_location_zEnd = request.getParameter("SP_PW_zEnd_location");
            request.setAttribute("SP_PW_zEnd_location", pe_location_zEnd);
          }
          if (pe_location_zEnd != null && !locationBelongsToRegion(con, pe_location_zEnd, PW_zEnd_region))
            pe_location_zEnd = null;
          if (pe_location_zEnd == null) {
            pe_location_zEnd = locations_zEnd[0].getPrimaryKey();
          }
          request.setAttribute("location_zEnd", pe_location_zEnd);
          
          // Routers Z
          HashMap<String, String> peList_zEnd = new HashMap<String, String>();
          if (pe_location_zEnd != null) {
            peList_zEnd = getPEList(con, pe_location_zEnd, trunktype);
          }
          
          perouter_zEnd = request.getParameter("PERouter_zEnd");
          if (perouter_zEnd == null) {
            perouter_zEnd = request.getParameter("SP_PERouter_zEnd");
          }
          if (perouter_zEnd != null && !perouterBelongsToLocation(con, perouter_zEnd, pe_location_zEnd))
            perouter_zEnd = null;
          
          // Remove selected PE from list
          if (perouter_aEnd != null) {
            peList_zEnd.remove(perouter_aEnd);
          }
          if (perouter_zEnd != null) {
            peList_aEnd.remove(perouter_zEnd);
          }
          request.setAttribute("peList", peList_aEnd);
          request.setAttribute("peList_zEnd", peList_zEnd);
          
          // Set Routers
          request.setAttribute("PERouter_aEnd", perouter_aEnd);
          request.setAttribute("PERouter_zEnd", perouter_zEnd);
          
          // Name generation
          if ("".equals(trunkname) && perouter_aEnd != null && !"".equals(perouter_aEnd) && perouter_zEnd != null && !"".equals(perouter_zEnd)) {
            trunkname = getTrunkName(con, trunktype, perouter_aEnd, perouter_zEnd);
            request.setAttribute("trunkname", trunkname);
          }

          String presname = request.getParameter("presname");
          if (presname == null || "".equals(presname) || !trunkname.startsWith(presname)) {
            presname = trunkname;
          }
          request.setAttribute("presname", presname);
          ((ServiceForm) form).setPresname(presname);
          if ((EndA_name == null || "".equals(EndA_name)) && !"".equals(trunkname)) {
            EndA_name = trunkname + "-aEnd";
          }
          if ((EndB_name == null || "".equals(EndB_name)) && !"".equals(trunkname)) {
            EndB_name = trunkname + "-zEnd";
          }
          request.setAttribute("EndA_name", EndA_name);
          request.setAttribute("EndB_name", EndB_name);
          
          HashMap<String, String> ifList_aEnd = new HashMap<String, String>();
          if (perouter_aEnd != null) {
            ifList_aEnd = getIfList(con, perouter_aEnd);
          }

          peinterface_aEnd = request.getParameter("peinterface_aEnd");
          if (peinterface_aEnd == null) {
            peinterface_aEnd = request.getParameter("SP_PEInterface_aEnd");
          }
          
          HashMap<String, String> ifList_zEnd = new HashMap<String, String>();
          if (perouter_zEnd != null) {
            ifList_zEnd = getIfList(con, perouter_zEnd);
          }
          
          peinterface_zEnd = request.getParameter("peinterface_zEnd");
          if (peinterface_zEnd == null) {
            peinterface_zEnd = request.getParameter("SP_PEInterface_zEnd");
          }
          
          // Remove selected interfaces
          if (peinterface_aEnd != null && !"none".equals(peinterface_aEnd) && !"".equals(peinterface_aEnd)) {
            String[] peinterfaces_aEnd = peinterface_aEnd.split(";");
            for (String interfaceToRemove : peinterfaces_aEnd) {
              ifList_zEnd.remove(interfaceToRemove); 
            }
          }
          if (peinterface_zEnd != null && !"none".equals(peinterface_zEnd) && !"".equals(peinterface_aEnd)) {
            String[] peinterfaces_zEnd = peinterface_zEnd.split(";");
            for (String interfaceToRemove : peinterfaces_zEnd) {
              ifList_aEnd.remove(interfaceToRemove);
            }
          }
          
          request.setAttribute("ifList", ifList_aEnd);
          request.setAttribute("peinterface_aEnd", peinterface_aEnd);
          request.setAttribute("ifList_zEnd", ifList_zEnd);
          request.setAttribute("peinterface_zEnd", peinterface_zEnd);

          // Auto suggestion description
          String description_SP_link_type = request.getParameter("SP_link_type");
          if (description_SP_link_type == null) {
            if (((String) request.getAttribute("trunktype")).equals("1"))
              description_SP_link_type = "1G";
            else
              description_SP_link_type = "2.5G POS";
          } else {
            if (presname.startsWith("ST") && description_SP_link_type.startsWith("1"))
              description_SP_link_type = "2.5G POS";
            if (presname.startsWith("Eth") && description_SP_link_type.startsWith("2"))
              description_SP_link_type = "1G";
          }

          // Description TRUNK
          if (trunkdescription_a == null) {
            trunkdescription_a = request.getParameter("SP_trunk_description_aEnd");
          }
          if (trunkdescription_b == null) {
            trunkdescription_b = request.getParameter("SP_trunk_description_zEnd");
          }
          if (perouter_aEnd != null && perouter_zEnd != null && (trunkdescription_a == null || "".equals(trunkdescription_a)) && EndA_name != null && EndB_name != null) {
            trunkdescription_a = getDescription(con, peList_aEnd.get(perouter_aEnd).toUpperCase(), peList_zEnd.get(perouter_zEnd).toUpperCase(), description_SP_link_type, EndA_name, EndB_name);
            trunkdescription_a = trunkdescription_a.replace(Constants.MEMBER_REPLACE, Constants.TRUNK_REPLACE);
          }
          if (perouter_aEnd != null && perouter_zEnd != null && (trunkdescription_b == null || "".equals(trunkdescription_b)) && EndA_name != null && EndB_name != null) {
            trunkdescription_b = getDescription(con, peList_aEnd.get(perouter_aEnd).toUpperCase(), peList_zEnd.get(perouter_zEnd).toUpperCase(), description_SP_link_type, EndA_name, EndB_name);
            trunkdescription_b = trunkdescription_b.replace(Constants.MEMBER_REPLACE, Constants.TRUNK_REPLACE);
          }
          request.setAttribute("SP_trunk_description_aEnd", trunkdescription_a);
          request.setAttribute("SP_trunk_description_zEnd", trunkdescription_b);
          
          // Description LINK
          if (Interface_description_aEnd == null) {
            Interface_description_aEnd = request.getParameter("SP_Interface_description_aEnd");
          }
          if (Interface_description_zEnd == null) {
            Interface_description_zEnd = request.getParameter("SP_Interface_description_zEnd");
          }
          if (perouter_aEnd != null && perouter_zEnd != null && (Interface_description_aEnd == null || "".equals(Interface_description_zEnd)) && EndA_name != null && EndB_name != null) {
            Interface_description_aEnd = getDescription(con, peList_aEnd.get(perouter_aEnd).toUpperCase(), peList_zEnd.get(perouter_zEnd).toUpperCase(), description_SP_link_type, EndA_name, EndB_name);
            Interface_description_aEnd = Interface_description_aEnd.replace(Constants.MEMBER_REPLACE, Constants.LINK_REPLACE);
          }
          if (perouter_aEnd != null && perouter_zEnd != null && (Interface_description_zEnd == null || "".equals(Interface_description_zEnd)) && EndA_name != null && EndB_name != null) {
            Interface_description_zEnd = getDescription(con, peList_aEnd.get(perouter_aEnd).toUpperCase(), peList_zEnd.get(perouter_zEnd).toUpperCase(), description_SP_link_type, EndA_name, EndB_name);
            Interface_description_zEnd = Interface_description_zEnd.replace(Constants.MEMBER_REPLACE, Constants.LINK_REPLACE);
          }
          request.setAttribute("SP_Interface_description_aEnd", Interface_description_aEnd);
          request.setAttribute("SP_Interface_description_zEnd", Interface_description_zEnd);

          // Services
          Service[] available_sites = getAvailableSite(con, customerid, "");
          request.setAttribute("available_sites", available_sites);
          String[] available_siteid = null;
          try {
            available_siteid = new String[available_sites.length];
            for (int i = 0; i < available_sites.length; i++) {
              available_siteid[i] = available_sites[i].getServiceid();
            }
          } catch (Exception ex) {
            logger.debug("Exception thrown while iterating the availables sites for the customer = " + customerid
                + " (available_sites = " + available_sites + ")");
            ex.printStackTrace();
            throw ex;
          }
          // Negotiation
          if (SP_trunk_negotiation_aside == null) {
            SP_trunk_negotiation_aside = request.getParameter("SP_trunk_negotiation_aside");
          }
          if (SP_trunk_negotiation_zside == null) {
            SP_trunk_negotiation_zside = request.getParameter("SP_trunk_negotiation_zside");
          }
          request.setAttribute("SP_trunk_negotiation_aside", SP_trunk_negotiation_aside);
          request.setAttribute("SP_trunk_negotiation_zside", SP_trunk_negotiation_zside);
          Vector<Object> RegionResultVector = new Vector<Object>();
          Vector<Object> LocationResultVector = new Vector<Object>();
          for (int i = 0; i < available_siteid.length; i++) {
            ServiceParameter[] available_regions_partial = ServiceParameter.findByServiceid(con, available_siteid[i],
                "crm_serviceparam.Attribute = 'Region'", null, false);
            ServiceParameter[] available_locations_partial = ServiceParameter.findByServiceid(con, available_siteid[i],
                "crm_serviceparam.Attribute = 'Location'", null, false);
            if (available_regions_partial != null) {
              for (int ii = 0; ii < available_regions_partial.length; ii++) {
                RegionResultVector.add(available_regions_partial[0]);
              }
            }
            if (available_locations_partial != null) {
              for (int jj = 0; jj < available_locations_partial.length; jj++) {
                LocationResultVector.add(available_locations_partial[0]);
              }
            }
            // in case of multiplexing VPWS sites BEGIN
            if (available_regions_partial == null) {
              available_regions_partial = ServiceParameter.findAll(con,
                  "(attribute='PW_aEnd_region' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_aEnd' and value="
                      + available_siteid[i] + ")) "
                      + "OR (attribute='PW_zEnd_region' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_zEnd' and value="
                      + available_siteid[i] + "))",
                  "", false);
              if (available_regions_partial != null) {
                for (int ii = 0; ii < available_regions_partial.length; ii++) {
                  ServiceParameter SP = new ServiceParameter();
                  SP.setServiceid(available_siteid[i]);
                  SP.setAttribute("Region");
                  SP.setValue(available_regions_partial[0].getValue());
                  RegionResultVector.add(SP);
                }
              }
            }
            if (available_locations_partial == null) {
              available_locations_partial = ServiceParameter.findAll(con,
                  "(attribute='PW_aEnd_location' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_aEnd' and value="
                      + available_siteid[i] + ")) "
                      + "OR (attribute='PW_zEnd_location' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_zEnd' and value="
                      + available_siteid[i] + "))",
                  "", false);
              if (available_locations_partial != null) {
                for (int ii = 0; ii < available_locations_partial.length; ii++) {
                  ServiceParameter SP = new ServiceParameter();
                  SP.setServiceid(available_siteid[i]);
                  SP.setAttribute("Region");
                  SP.setValue(available_locations_partial[0].getValue());
                  LocationResultVector.add(SP);
                }
              }
            }
            // in case of multiplexing VPWS sites END
          }
          ServiceParameter[] available_regions = new ServiceParameter[RegionResultVector.size()];
          RegionResultVector.copyInto(available_regions);
          ServiceParameter[] available_locations = new ServiceParameter[LocationResultVector.size()];
          LocationResultVector.copyInto(available_locations);
          request.setAttribute("available_regions", available_regions);
          request.setAttribute("available_locations", available_locations);
          String SubEndA_name = null;
          String SubEndB_name = null;
          HashMap<String, HashMap<String, String>> sub_interfaces = new HashMap<String, HashMap<String, String>>();

          if (request.getAttribute("subinterface_name") == null) {
            subinterface_name = request.getParameter("SP_SubInterfaceName");
          }
          request.setAttribute("SP_SubInterfaceName", subinterface_name);
          
          String SubSite_Service_ID_aEnd = "";
          String SubSite_Service_ID_zEnd = "";
          request.setAttribute("SubEndA_name", SubEndA_name);
          request.setAttribute("SubEndB_name", SubEndB_name);
          
          // The service id of the subinterface is the same of the interface
          SubSite_Service_ID_aEnd = request.getParameter("SP_SubSite_Service_ID_aEnd");
          if (SubSite_Service_ID_aEnd == null) {
            SubSite_Service_ID_aEnd = Site_Service_ID_aEnd;
          }
          SubSite_Service_ID_zEnd = request.getParameter("SP_SubSite_Service_ID_zEnd");
          if (SubSite_Service_ID_zEnd == null) {
            SubSite_Service_ID_zEnd = Site_Service_ID_zEnd;
          }
          
          request.setAttribute("SP_SubSite_Service_ID_aEnd", SubSite_Service_ID_aEnd);
          request.setAttribute("SP_SubSite_Service_ID_zEnd", SubSite_Service_ID_zEnd);
          
          // Subinterface Description
          String SP_SubInt_description_aEnd = request.getParameter("SP_SubInt_description_aEnd");
          String SP_SubInt_description_zEnd = request.getParameter("SP_SubInt_description_zEnd");
          if (perouter_aEnd != null && perouter_zEnd != null && (SP_SubInt_description_aEnd == null || "".equals(SP_SubInt_description_aEnd)) && EndA_name != null && EndB_name != null) {
            SP_SubInt_description_aEnd = getDescription(con, peList_aEnd.get(perouter_aEnd).toUpperCase(), peList_zEnd.get(perouter_zEnd).toUpperCase(), description_SP_link_type, EndA_name, EndB_name);
            SP_SubInt_description_aEnd = SP_SubInt_description_aEnd.replace(Constants.MEMBER_REPLACE, Constants.TRUNK_REPLACE);
          }
          if (perouter_aEnd != null && perouter_zEnd != null && (SP_SubInt_description_zEnd == null || "".equals(SP_SubInt_description_zEnd)) && EndA_name != null && EndB_name != null) {
            SP_SubInt_description_zEnd = getDescription(con, peList_aEnd.get(perouter_aEnd).toUpperCase(), peList_zEnd.get(perouter_zEnd).toUpperCase(), description_SP_link_type, EndA_name, EndB_name);
            SP_SubInt_description_zEnd = SP_SubInt_description_zEnd.replace(Constants.MEMBER_REPLACE, Constants.TRUNK_REPLACE);
          }
          request.setAttribute("SP_SubInt_description_aEnd", SP_SubInt_description_aEnd);
          request.setAttribute("SP_SubInt_description_zEnd", SP_SubInt_description_zEnd);
          
          String Subtrunk_policy_aEnd = request.getParameter("Subtrunk_policy_aEnd");
          String Subtrunk_policy_zEnd = request.getParameter("Subtrunk_policy_zEnd");
          request.setAttribute("Subtrunk_policy_aEnd", Subtrunk_policy_aEnd);
          request.setAttribute("Subtrunk_policy_zEnd", Subtrunk_policy_zEnd);
          String SP_SubArea_number_aEnd = request.getParameter("SP_SubArea_number_aEnd");
          String SP_SubArea_number_zEnd = request.getParameter("SP_SubArea_number_zEnd");
          request.setAttribute("SP_SubArea_number_aEnd", SP_SubArea_number_aEnd);
          request.setAttribute("SP_SubArea_number_zEnd", SP_SubArea_number_zEnd);
          String SP_SubNegotiation_aend = request.getParameter("SP_SubNegotiation_aend");
          String SP_SubNegotiation_zend = request.getParameter("SP_SubNegotiation_zend");
          request.setAttribute("SP_SubNegotiation_aend", SP_SubNegotiation_aend);
          request.setAttribute("SP_SubNegotiation_zend", SP_SubNegotiation_zend);
          String SP_Sub_pim_name_aside = request.getParameter("SP_Sub_pim_name_aside");
          String SP_Sub_pim_name_zside = request.getParameter("SP_Sub_pim_name_zside");
          request.setAttribute("SP_Sub_pim_name_aside", SP_Sub_pim_name_aside);
          request.setAttribute("SP_Sub_pim_name_zside", SP_Sub_pim_name_zside);
          String SP_Sub_network_type_aside = request.getParameter("SP_Sub_network_type_aside");
          String SP_Sub_network_type_zside = request.getParameter("SP_Sub_network_type_zside");
          request.setAttribute("SP_Sub_network_type_aside", SP_Sub_network_type_aside);
          request.setAttribute("SP_Sub_network_type_zside", SP_Sub_network_type_zside);
          String SP_Sub_ospf_aside = request.getParameter("SP_Sub_ospf_aside");
          String SP_Sub_ospf_zside = request.getParameter("SP_Sub_ospf_zside");
          request.setAttribute("SP_Sub_ospf_aside", SP_Sub_ospf_aside);
          request.setAttribute("SP_Sub_ospf_zside", SP_Sub_ospf_zside);
          String SP_Subldp_aend = request.getParameter("SP_Subldp_aend");
          String SP_Subldp_zend = request.getParameter("SP_Subldp_zend");
          request.setAttribute("SP_Subldp_aend", SP_Subldp_aend);
          request.setAttribute("SP_Subldp_zend", SP_Subldp_zend);
          String SubQoSP_aend = request.getParameter("SubQoSP_aend");
          String SubQoSP_zend = request.getParameter("SubQoSP_zend");
          request.setAttribute("SubQoSP_aend", SubQoSP_aend);
          request.setAttribute("SubQoSP_zend", SubQoSP_zend);
          String SP_Subtrunk_mtu_aend = request.getParameter("SP_Subtrunk_mtu_aend");
          String SP_Subtrunk_mtu_zend = request.getParameter("SP_Subtrunk_mtu_zend");
          request.setAttribute("SP_Subtrunk_mtu_aend", SP_Subtrunk_mtu_aend);
          request.setAttribute("SP_Subtrunk_mtu_zend", SP_Subtrunk_mtu_zend);
          String SP_Subtrunk_ospf_cost_aend = request.getParameter("SP_Subtrunk_ospf_cost_aend");
          String SP_Subtrunk_ospf_cost_zend = request.getParameter("SP_Subtrunk_ospf_cost_zend");
          request.setAttribute("SP_Subtrunk_ospf_cost_aend", SP_Subtrunk_ospf_cost_aend);
          request.setAttribute("SP_Subtrunk_ospf_cost_zend", SP_Subtrunk_ospf_cost_zend);
          String SubSP_OSPF_aPassword = request.getParameter("SP_SubOSPF_aPassword");
          String SubSP_OSPF_zPassword = request.getParameter("SP_SubOSPF_zPassword");
          request.setAttribute("SP_SubOSPF_aPassword", SubSP_OSPF_aPassword);
          request.setAttribute("SP_SubOSPF_zPassword", SubSP_OSPF_zPassword);
          String SubSP_LDP_aPassword = request.getParameter("SP_SubLDP_aPassword");
          String SubSP_LDP_zPassword = request.getParameter("SP_SubLDP_zPassword");
          request.setAttribute("SP_SubLDP_aPassword", SubSP_LDP_aPassword);
          request.setAttribute("SP_SubLDP_zPassword", SubSP_LDP_zPassword);
          String SP_Subtrunk_policy_zside = request.getParameter("SP_Subtrunk_policy_zside");
          String SP_Subtrunk_policy_aside = request.getParameter("SP_Subtrunk_policy_aside");
          request.setAttribute("SP_Subtrunk_policy_zside", SP_Subtrunk_policy_zside);
          request.setAttribute("SP_Subtrunk_policy_aside", SP_Subtrunk_policy_aside);

          // QOS
          List<String> SP_QOS_PROFILE_list = getQosList(con);
          request.setAttribute("SP_QOS_PROFILE_list", SP_QOS_PROFILE_list);
          String SP_QOS_PROFILE = request.getParameter("SP_QOS_PROFILE");
          request.setAttribute("SP_QOS_PROFILE", SP_QOS_PROFILE);
          
          if (Sub_ip_subnetmask_aEnd != null && SP_ip_submask_aEnd != null) {
            SP_Sub_wildcard_aEnd = getWildCard(SP_ip_submask_aEnd);
            SP_Sub_ip_networkIP_aEnd = Sub_ip_subnetmask_aEnd.get(1);
          }

          if (Sub_ip_subnetmask_zEnd != null && SP_ip_submask_zEnd != null) {
            SP_Sub_wildcard_zEnd = getWildCard(SP_ip_submask_zEnd);
            SP_Sub_ip_networkIP_zEnd = Sub_ip_subnetmask_zEnd.get(1);
          }
          
          // Subinterface submask
          if (SP_Sub_ipaddress_aEnd != null && !"".equals(SP_Sub_ipaddress_aEnd)) {
            SP_Sub_ip_submask_aEnd = getSubnetmask(con, SP_Sub_ipaddress_aEnd); 
          }
          
          if (SP_Sub_ipaddress_zEnd != null && !"".equals(SP_Sub_ipaddress_zEnd)) {
            SP_Sub_ip_submask_zEnd = getSubnetmask(con, SP_Sub_ipaddress_zEnd);
          }

          request.setAttribute("SP_Sub_ip_submask_aEnd", SP_Sub_ip_submask_aEnd);
          request.setAttribute("SP_Sub_ip_submask_zEnd", SP_Sub_ip_submask_zEnd);

          //request.setAttribute("SP_Sub_ip_networkIP_aEnd", SP_Sub_ip_networkIP_aEnd);
          request.setAttribute("SP_Sub_ip_networkIP_aEnd", SP_Sub_ip_networkIP_aEnd);
          request.setAttribute("SP_Sub_wildcard_aEnd", SP_Sub_wildcard_aEnd);
          request.setAttribute("SP_Sub_ip_networkIP_zEnd", SP_Sub_ip_networkIP_zEnd);
          //request.setAttribute("SP_Sub_ip_networkIP_zEnd", SP_Sub_ip_networkIP_zEnd);
          request.setAttribute("SP_Sub_wildcard_zEnd", SP_Sub_wildcard_zEnd);

          if (session.getAttribute("sub_interface_list") != null) {
            sub_interfaces = (HashMap<String, HashMap<String, String>>) session.getAttribute("sub_interface_list");
            
            if (subinterface_name != null && ("modifysubinterface".equalsIgnoreCase(reqtype) || "creatingSub".equalsIgnoreCase(reqtype))) {

              HashMap<String, String> subinterface_sides = new HashMap<String, String>();

              if ("modifysubinterface".equalsIgnoreCase(reqtype)) {
                subinterface_sides = sub_interfaces.get(subinterface_name);
              }

              subinterface_sides.put(Constants.XSLPARAM_SUBINTERFACENAME, subinterface_name);
              subinterface_sides.put(Constants.XSLPARAM_PARENTINTERFACE_AEND, peinterface_aEnd);
              subinterface_sides.put(Constants.XSLPARAM_PARENTINTERFACE_ZEND, peinterface_zEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUBADDRESSPOOL_AEND, Subpool_aEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUBADDRESSPOOL_ZEND, Subpool_zEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IPADDRESS_AEND, SP_Sub_ipaddress_aEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IPADDRESS_ZEND, SP_Sub_ipaddress_zEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IP_NETWORKIP_AEND, SP_Sub_ip_networkIP_aEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IP_NETWORKIP_ZEND, SP_Sub_ip_networkIP_zEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUBINT_DESCRIPTION_AEND, SP_SubInt_description_aEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUBINT_DESCRIPTION_ZEND, SP_SubInt_description_zEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_TRUNK_NEGOTIATION_ASIDE, SP_SubNegotiation_aend);
              subinterface_sides.put(Constants.XSLPARAM_SUB_TRUNK_NEGOTIATION_ZSIDE, SP_SubNegotiation_zend);
              subinterface_sides.put(Constants.XSLPARAM_SUBTRUNK_MTU_AEND, SP_Subtrunk_mtu_aend);
              subinterface_sides.put(Constants.XSLPARAM_SUBTRUNK_MTU_ZEND, SP_Subtrunk_mtu_zend);
              subinterface_sides.put(Constants.XSLPARAM_SUB_PIM_NAME_ASIDE, SP_Sub_pim_name_aside);
              subinterface_sides.put(Constants.XSLPARAM_SUB_PIM_NAME_ZSIDE, SP_Sub_pim_name_zside);
              subinterface_sides.put(Constants.XSLPARAM_SUB_NETWORK_TYPE_ASIDE, SP_Sub_network_type_aside);
              subinterface_sides.put(Constants.XSLPARAM_SUB_NETWORK_TYPE_ZSIDE, SP_Sub_network_type_zside);
              subinterface_sides.put(Constants.XSLPARAM_SUB_OSPF_ASIDE, SP_Sub_ospf_aside);
              subinterface_sides.put(Constants.XSLPARAM_SUB_OSPF_ZSIDE, SP_Sub_ospf_zside);
              subinterface_sides.put(Constants.XSLPARAM_SUBTRUNK_OSPF_COST_AEND, SP_Subtrunk_ospf_cost_aend);
              subinterface_sides.put(Constants.XSLPARAM_SUBTRUNK_OSPF_COST_ZEND, SP_Subtrunk_ospf_cost_zend);
              subinterface_sides.put(Constants.XSLPARAM_SUBOSPF_APASSWORD, SubSP_OSPF_aPassword);
              subinterface_sides.put(Constants.XSLPARAM_SUBOSPF_ZPASSWORD, SubSP_OSPF_zPassword);
              subinterface_sides.put(Constants.XSLPARAM_SUBLDP_APASSWORD, SubSP_LDP_aPassword);
              subinterface_sides.put(Constants.XSLPARAM_SUBLDP_ZPASSWORD, SubSP_LDP_zPassword);
              subinterface_sides.put(Constants.XSLPARAM_SUBLDP_AEND, SP_Subldp_aend);
              subinterface_sides.put(Constants.XSLPARAM_SUBLDP_ZEND, SP_Subldp_zend);
              subinterface_sides.put(Constants.XSLPARAM_SUBTRUNK_POLICY_ASIDE, SP_Subtrunk_policy_aside);
              subinterface_sides.put(Constants.XSLPARAM_SUBTRUNK_POLICY_ZSIDE, SP_Subtrunk_policy_zside);
              subinterface_sides.put(Constants.XSLPARAM_SUBAREA_NUMBER_AEND, SP_SubArea_number_aEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUBAREA_NUMBER_ZEND, SP_SubArea_number_zEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IPADDRESS_AEND, SP_Sub_ipaddress_aEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IPADDRESS_ZEND, SP_Sub_ipaddress_zEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IPV6_FAMILY_AEND, SP_Sub_IPv6_family_aEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IPV6_FAMILY_ZEND, SP_Sub_IPv6_family_zEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IPV6_POOL_AEND, SP_Sub_IPv6_Pool_aEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IPV6_POOL_ZEND, SP_Sub_IPv6_Pool_zEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IPV6_ADDRESS_AEND, SP_Sub_IPv6_Address_aEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IPV6_ADDRESS_ZEND, SP_Sub_IPv6_Address_zEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IPV6_ENCAP_AEND, SP_Sub_IPv6_encap_aEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IPV6_ENCAP_ZEND, SP_Sub_IPv6_encap_zEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IPV6_BINDING_AEND, SP_Sub_IPv6_binding_aEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IPV6_BINDING_ZEND, SP_Sub_IPv6_binding_zEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUBTRUNK_PROCESSID_AEND, SP_Subtrunk_processid_aEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUBTRUNK_PROCESSID_ZEND, SP_Subtrunk_processid_zEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IP_SUBMASK_AEND, SP_Sub_ip_submask_aEnd);
              subinterface_sides.put(Constants.XSLPARAM_SUB_IP_SUBMASK_ZEND, SP_Sub_ip_submask_zEnd);

              sub_interfaces.put(subinterface_name, subinterface_sides);
            }
          }
          session.setAttribute("sub_interface_list", sub_interfaces);
          
          Iterator<Entry<String, HashMap<String, String>>> iterator = sub_interfaces.entrySet().iterator();
          while (iterator.hasNext()) {
            Entry<String, HashMap<String, String>> entry = iterator.next();
            
            String subIPAddressA = entry.getValue().get(Constants.XSLPARAM_SUB_IPADDRESS_AEND);
            if (subIPAddressA != null && !"".equals(subIPAddressA)) {
              if (subIPAddressA.equals(SP_Sub_ipaddress_aEnd)) {
                iplist_aEnd.remove(subIPAddressA);
                iplist_zEnd.remove(subIPAddressA);
                Subiplist_zEnd.remove(subIPAddressA);
              } else {
                iplist_aEnd.remove(subIPAddressA);
                iplist_zEnd.remove(subIPAddressA);
                Subiplist_aEnd.remove(subIPAddressA);
                Subiplist_zEnd.remove(subIPAddressA);  
              }
            }
            
            String subIPAddressZ = entry.getValue().get(Constants.XSLPARAM_SUB_IPADDRESS_ZEND);
            if (subIPAddressZ != null && !"".equals(subIPAddressZ)) {
              if (subIPAddressZ.equals(SP_Sub_ipaddress_zEnd)) {
                iplist_aEnd.remove(subIPAddressZ);
                iplist_zEnd.remove(subIPAddressA);
                Subiplist_aEnd.remove(subIPAddressZ);
              } else {
                iplist_aEnd.remove(subIPAddressZ);
                iplist_zEnd.remove(subIPAddressZ);
                Subiplist_aEnd.remove(subIPAddressZ);
                Subiplist_zEnd.remove(subIPAddressZ);  
              }
            }
            
            String subIPv6AddressA = entry.getValue().get(Constants.XSLPARAM_SUB_IPV6_ADDRESS_AEND);
            if (subIPv6AddressA != null && !"".equals(subIPv6AddressA)) {
              if (subIPv6AddressA.equals(SP_Sub_IPv6_Address_aEnd)) {
                Ipv6_iplist_aEnd.remove(subIPv6AddressA);
                Ipv6_iplist_zEnd.remove(subIPv6AddressA);
                SubIpv6_iplist_zEnd.remove(subIPv6AddressA);  
              } else {
                Ipv6_iplist_aEnd.remove(subIPv6AddressA);
                Ipv6_iplist_zEnd.remove(subIPv6AddressA);
                SubIpv6_iplist_aEnd.remove(subIPv6AddressA);
                SubIpv6_iplist_zEnd.remove(subIPv6AddressA);
              }
            }
            
            String subIPv6AddressZ = entry.getValue().get(Constants.XSLPARAM_SUB_IPV6_ADDRESS_ZEND);
            if (subIPv6AddressZ != null && !"".equals(subIPv6AddressZ)) {
              if (subIPv6AddressZ.equals(SP_Sub_IPv6_Address_zEnd)) {
                Ipv6_iplist_aEnd.remove(subIPv6AddressZ);
                Ipv6_iplist_zEnd.remove(subIPv6AddressZ);
                SubIpv6_iplist_aEnd.remove(subIPv6AddressZ);
              } else {
                Ipv6_iplist_aEnd.remove(subIPv6AddressZ);
                Ipv6_iplist_zEnd.remove(subIPv6AddressZ);
                SubIpv6_iplist_aEnd.remove(subIPv6AddressZ);
                SubIpv6_iplist_zEnd.remove(subIPv6AddressZ);  
              }
            }
          }
        }
        //PAGINATION LOGIC
        
        List<HashMap<String, String>> allTrunks = (List<HashMap<String, String>>)request.getAttribute("allTrunks");
        List<HashMap<String, String>> allTrunksPage = new ArrayList<HashMap<String, String>>();
        String strRecPerPage = (String) session
            .getAttribute("recordsPerPage"); // CONFIGURED VALUE
        if(allTrunks!=null)
          size = allTrunks.size();
        cpage = 1;        
        recPerPage = Integer.parseInt(strRecPerPage);
        
     // logger.debug("recPerPage VALUE CONFIGURED IN web.xml IS =="+recPerPage+"----"+newallServices);
        if (size % recPerPage == 0) {
            totalPages = size / recPerPage;
        } else {
            totalPages = size / recPerPage + 1;
        }

        if (totalPages == 0) {
            totalPages = 1;
        }

        if (request.getParameter("currentPageNo") != null) {

            strPageNo = request.getParameter("currentPageNo");
            iPageNo = Integer.parseInt(strPageNo);
        }

        if (request.getParameter("viewPageNo") != null) {
            vPageNo = Integer.parseInt(request
                    .getParameter("viewPageNo"));
        } else {
            vPageNo = 1;
        }

        if ((pt == null) || pt.length() < 1 || pt.equals("null")) {
            if (size > 0) {
                cpage = 1;
                currentRs = 1;
                if (recPerPage > size || cpage * recPerPage > size) {
                    lastRs = size;
                } else {
                    lastRs = cpage * recPerPage;
                }
            }
            if (size == 0) {
                cpage = 1;
                currentRs = 1;
                lastRs = 1;
                totalPages = 1;
            }

            vPageNo = 1;
        } else {
            if (request.getParameter("navigate") == null
                    && (request.getAttribute("DeleteAction") == null)) {
                if (pt.equals("next")) { /* next page navigation */

                    cpage = iPageNo + 1;
                    currentRs = (cpage * recPerPage) - recPerPage + 1;
                    lastRs = cpage * recPerPage;
                    vPageNo = cpage;
                    if (cpage == totalPages) {
                        lastRs = size;
                        
                    }
                    vPageNo = cpage;
                }
                if (pt.equals("prev")) { /* previous page navigation */

                    cpage = iPageNo - 1;
                    currentRs = (cpage * recPerPage) - recPerPage + 1;
                    lastRs = cpage * recPerPage;
                     vPageNo = cpage;
                }
                if (pt.equals("first")) { /* first page navigation */

                    cpage = 1;
                    currentRs = 1;
                    if (recPerPage > size || cpage * recPerPage > size) {
                        lastRs = size;
                    } else {
                        lastRs = cpage * recPerPage;
                    }
                    vPageNo = 1;
                }
                if (pt.equals("last")) { /* last page navigation */

                    cpage = totalPages;
                    currentRs = (cpage * recPerPage) - recPerPage + 1;
                    lastRs = size;
                    vPageNo = totalPages;
                }
                if (pt.equals("viewpageno")) { /*
                                                 * view a particular
                                                 * page
                                                 */

                    cpage = vPageNo;
                    currentRs = (cpage * recPerPage) - recPerPage + 1;
                    lastRs = cpage * recPerPage;

                    if (vPageNo == totalPages) {
                        lastRs = size;
                    } else {
                        lastRs = cpage * recPerPage;
                    }
                }

            } else { // when its a reload and not navigate
            
                
                if (totalPages < cpage) {
                    cpage = totalPages;
                } else {
                    cpage = Integer.parseInt(request.getParameter("currentPageNo"));
                }
                
                currentRs = (cpage * recPerPage) - recPerPage + 1;
                if (recPerPage > size || cpage * recPerPage > size) {
                    lastRs = size;
                } else {
                    lastRs = cpage * recPerPage;
                }
                
                vPageNo = cpage;
                
            }

        }
        LinkedHashSet parentsToDisplay = new LinkedHashSet();
        int ii = 0;
        int jj = 0;
        int kk = 0;
        int delrec = 0; // richa
        int prevloc = 0;
        int currLoc = 0;
        int prevcount = 0;
        int rem = 0;
        int maxallowable = 0;
        int count = 0;
        if(allTrunks!=null){
          for( int i=0; i<allTrunks.size();i++){
              
              
              
              prevloc = allTrunksPage.size();
              // logger.debug(" prevloc == "+prevloc+", cpage ="+cpage);
              maxallowable = recPerPage - prevloc;
              prevcount = count;
              //replace parentsubservice for 0
              count = 0 + 1 + prevcount;
              int diff = currentRs - count;
      
              kk = cpage - 1;
              if (kk == 0) {
                  // parentIndex = i;     
                  parentsToDisplay.add(allTrunks.get(i));
                  ii = 1;
                  maxallowable = maxallowable - 1;
                  // logger.debug(" maxallowable == "+maxallowable);
                  jj = maxallowable;    
                  
              } else {
  
                if (currentRs <= count) {
                    ii = (kk * recPerPage);
                    jj = ii + recPerPage - 1;
  
                    if (i > 0) {
                        ii = (kk * recPerPage) - prevcount;
                        jj = ii + recPerPage - 1;
                    }                  
                   
                } else {
                  ii = 0;
                  jj = 0;
  
                  // logger.debug("currentRs is > count ::for i"+i);
                  // logger.debug("currentRs is = "+currentRs);
                  // logger.debug("count is = "+count);
                  // logger.debug("prevloc is = "+prevloc);
                  if ((prevloc == 0) && (diff == 1)) {
                      parentsToDisplay.add(allTrunks.get(i));
  
                  }
              }
              if (((rem == 0) && (i > 0)) && (prevloc > 0)
                      && (maxallowable > 0)) {
                  // logger.debug(" enter (rem==0)&&(i>0))&&(prevloc>0 ");
                  diff = currentRs - prevcount;
                  if ((prevloc == 1) && (diff == 1)) {
                      parentsToDisplay.remove(allTrunks.get(i - 1));
                      allTrunksPage.remove(prevloc - 1);
                  }
                  parentsToDisplay.add(allTrunks.get(i));
                  ii = 1;
                  maxallowable = maxallowable - 1;
                  jj = maxallowable;                
  
              }           
          
              }
              if (parentsToDisplay.contains(allTrunks.get(i))) {
                allTrunksPage.add(allTrunks.get(i));                   
                currLoc = prevloc + 1;
            }
              currLoc = allTrunksPage.size();
              if (currLoc == recPerPage)
                  break;
          }//end for
        //END PAGINATION
        }
        request.setAttribute("allTrunksPage", allTrunksPage);
        
        
        // Remove used IPs
        if (ipaddr_aEnd != null && !"".equals(ipaddr_aEnd)) {
          iplist_zEnd.remove(ipaddr_aEnd);
          Subiplist_aEnd.remove(ipaddr_aEnd);
          Subiplist_zEnd.remove(ipaddr_aEnd);
        }
        if (ipaddr_zEnd != null && !"".equals(ipaddr_zEnd)) {
          iplist_aEnd.remove(ipaddr_zEnd);
          Subiplist_aEnd.remove(ipaddr_zEnd);
          Subiplist_zEnd.remove(ipaddr_zEnd);
        }
        if (SP_Sub_ipaddress_aEnd != null && !"".equals(SP_Sub_ipaddress_aEnd)) {
          iplist_aEnd.remove(SP_Sub_ipaddress_aEnd);
          iplist_zEnd.remove(SP_Sub_ipaddress_aEnd);
          Subiplist_zEnd.remove(SP_Sub_ipaddress_aEnd);
        }
        if (SP_Sub_ipaddress_zEnd != null && !"".equals(SP_Sub_ipaddress_zEnd)) {
          iplist_aEnd.remove(SP_Sub_ipaddress_zEnd);
          iplist_zEnd.remove(SP_Sub_ipaddress_zEnd);
          Subiplist_aEnd.remove(SP_Sub_ipaddress_zEnd);
        }
        
        // IPv6
        if (SP_IPv6_Address_aEnd != null && !"".equals(SP_IPv6_Address_aEnd)) {
          Ipv6_iplist_zEnd.remove(SP_IPv6_Address_aEnd);
          SubIpv6_iplist_aEnd.remove(SP_IPv6_Address_aEnd);
          SubIpv6_iplist_zEnd.remove(SP_IPv6_Address_aEnd);
        }
        if (SP_IPv6_Address_zEnd != null && !"".equals(SP_IPv6_Address_zEnd)) {
          Ipv6_iplist_aEnd.remove(SP_IPv6_Address_zEnd);
          SubIpv6_iplist_aEnd.remove(SP_IPv6_Address_zEnd);
          SubIpv6_iplist_zEnd.remove(SP_IPv6_Address_zEnd);
        }
        if (SP_Sub_IPv6_Address_aEnd != null && !"".equals(SP_Sub_IPv6_Address_aEnd)) {
          Ipv6_iplist_aEnd.remove(SP_Sub_IPv6_Address_aEnd);
          Ipv6_iplist_zEnd.remove(SP_Sub_IPv6_Address_aEnd);
          SubIpv6_iplist_zEnd.remove(SP_Sub_IPv6_Address_aEnd);
        }
        if (SP_Sub_IPv6_Address_zEnd != null && !"".equals(SP_Sub_IPv6_Address_zEnd)) {
          Ipv6_iplist_aEnd.remove(SP_Sub_IPv6_Address_zEnd);
          Ipv6_iplist_zEnd.remove(SP_Sub_IPv6_Address_zEnd);
          SubIpv6_iplist_aEnd.remove(SP_Sub_IPv6_Address_zEnd);
        }
        
        request.setAttribute("iplist", iplist_aEnd);
        request.setAttribute("iplist_zEnd", iplist_zEnd);
        request.setAttribute("Subiplist", Subiplist_aEnd);
        request.setAttribute("Subiplist_zEnd", Subiplist_zEnd);
        request.setAttribute("Ipv6_iplist_aEnd", Ipv6_iplist_aEnd);
        request.setAttribute("Ipv6_iplist_zEnd", Ipv6_iplist_zEnd);
        request.setAttribute("SubIpv6_iplist_aEnd", SubIpv6_iplist_aEnd);
        request.setAttribute("SubIpv6_iplist_zEnd", SubIpv6_iplist_zEnd);
        //pagination
        request.setAttribute("cpage", String.valueOf(cpage));
        request.setAttribute("currentRs", String.valueOf(currentRs));
        request.setAttribute("lastRs", String.valueOf(lastRs));
        request.setAttribute("totalPages", String.valueOf(totalPages));
        request.setAttribute("vPageNo", String.valueOf(vPageNo));
        System.out.println("Trunk Code Finished ");
      }
		}catch(Exception ex){
			System.out.println("Exception in trunk "+ex.getMessage());
			ex.printStackTrace();
		}
      // end of Trunk

      // LAYER 2 - SITE --add layer2-Attachment type

			if (type.equals("layer2-Site") || type.equals("layer2-Attachment")) {

				Region[] regions = null;

				Location[] locations = null;

				CAR[] rateLimits = null;

				regions = Region.findAll(con, "name  IN (select region from CR_location)");

				request.setAttribute("regions", regions);

				String region = (String) serviceParameters.get("Region");

				if (region == null) {

					region = request.getParameter("SP_Region");

				}

				if (region == null) {

					region = regions[0].getPrimaryKey();

				}

				request.setAttribute("region", region);

				// Find all the vlanid ranges belonging to that range

				VlanRange[] vlanRanges = VlanRange.findByUsageallocationregion(con, "Attachment", "External", region);

				if (vlanRanges == null) {

					vlanRanges = VlanRange.findByUsageallocationregion(con, "Attachment", "External", "Provider");

				}

				if (vlanRanges != null) {

					START_VLANIDS = "";

					END_VLANIDS = "";

					for (int i = 0; i < vlanRanges.length; i++) {

						/*
						 * if(START_VLANIDS != "")
						 * 
						 * 
						 * 
						 * START_VLANIDS += ",";
						 * 
						 * 
						 * 
						 * if(END_VLANIDS != "")
						 * 
						 * 
						 * 
						 * END_VLANIDS += ",";
						 */

						if (i == vlanRanges.length - 1) {

							START_VLANIDS += ",";

							END_VLANIDS += ",";

						}

						START_VLANIDS = START_VLANIDS + vlanRanges[i].getStartvalue();

						END_VLANIDS = END_VLANIDS + vlanRanges[i].getEndvalue();

					}

				}

				session.setAttribute("START_VLANIDS", START_VLANIDS);

				session.setAttribute("END_VLANIDS", END_VLANIDS);

				// LOCATIONS , RATELIMITS

				locations = Location.findByRegion(con, region);

				// locations = Location.findAll(con);

				rateLimits = CAR.findAll(con, whereForRate);

				request.setAttribute("locations", locations);

				request.setAttribute("rateLimits", rateLimits);

				// EXPMapping

				EXPMapping[] mappings = EXPMapping.findAll(con);

				request.setAttribute("mappings", mappings);

				String location = null;

				String ethServiceType = null;

				String mappg = null;

				String VLANId = null;

				String BPDUTag = null;

				String loopDetection = null;

				String connectivityType = null;

				String multiplexing = null;

				multiplexing = (String) serviceParameters.get("ServiceMultiplexing");

				request.setAttribute("ServiceMultiplexing", multiplexing);

				location = (String) serviceParameters.get("Location");

				if (location == null) {

					location = request.getParameter("SP_Location");

				}

				if (location == null) {

					location = locations[0].getPrimaryKey();

				}

				request.setAttribute("location", location);

				connectivityType = (String) serviceParameters.get("ConnectivityType");

				if (connectivityType == null) {

					connectivityType = request.getParameter("SP_ConnectivityType");

				}

				request.setAttribute("connectivityType", connectivityType);

				loopDetection = (String) serviceParameters.get("LoopDetection");

				if (loopDetection == null) {

					loopDetection = request.getParameter("SP_LoopDetection");

					if (loopDetection == null) {

						loopDetection = "true";

					}

				}

				request.setAttribute("loopDetection", loopDetection);

				BPDUTag = (String) serviceParameters.get("BPDUTag");

				if (BPDUTag == null) {

					BPDUTag = request.getParameter("SP_BPDUTag");

				}

				request.setAttribute("BPDUTag", BPDUTag);

				mappg = (String) serviceParameters.get("Mapping");

				if (mappg == null) {

					mappg = request.getParameter("SP_Mapping");

					if (mappg == null) {

						mappg = "false";

					}

				}

				request.setAttribute("mapping", mappg);

				VLANId = (String) serviceParameters.get("VLANId");

				if (VLANId == null) {

					VLANId = request.getParameter("SP_VLANId");

					if (VLANId == null || "0".equals(VLANId)) {

						if ("true".equals(mapping) && "true".equals(parentServiceParameters.get("FixedVlan"))) {

							if (parentServiceParameters.get("VLANId") != null && !"0".equals(parentServiceParameters.get("VLANId"))) {

								VLANId = (String) parentServiceParameters.get("VLANId");

							}

						}

					}

				}

				if (VLANId == null || "0".equals(VLANId)) {

					VLANId = "";

				}

				request.setAttribute("VLANId", VLANId);

				ethServiceType = (String) serviceParameters.get("EthServiceType");

				if (ethServiceType == null) {

					ethServiceType = request.getParameter("SP_EthServiceType");

					if (ethServiceType == null) {

						if ((parentServiceParameters.get("EthServiceType") != null)) {

							ethServiceType = (String) parentServiceParameters.get("EthServiceType");

						} else {

							ethServiceType = "";

						}

					}

				}

				request.setAttribute("ethServiceType", ethServiceType);

				String rateLimit = (String) serviceParameters.get("CAR");

				if (rateLimit == null)

					rateLimit = request.getParameter("SP_CAR");

				request.setAttribute("rateLimit", rateLimit);

				// QOS

				// logger.debug("PreAddServiceAction ======QOS========");

				Profile[] publicprofiles;

				EXPMapping[] expMappings = null;

				PolicyMapping[] policyMappings = null;

				String layer = "layer 2";

				Profile selectedProfile = null;

				String selectedProfileName = (String) serviceParameters.get("QOS_PROFILE");

				if (selectedProfileName == null)

					selectedProfileName = request.getParameter("SP_QOS_PROFILE");

				request.setAttribute("SP_QOS_PROFILE", selectedProfileName);

				// logger.debug("PreAddServiceAction ======selectedProfileName========"+selectedProfileName);

				String baseProfile = (String) serviceParameters.get("QOS_BASE_PROFILE");

				if (baseProfile == null)

					baseProfile = request.getParameter("SP_QOS_BASE_PROFILE");

				request.setAttribute("SP_QOS_BASE_PROFILE", baseProfile);

				// logger.debug("PreAddServiceAction ======baseProfile========"+baseProfile);

				expMappings = EXPMapping.findAll(con);

				request.setAttribute("expMappings", expMappings);

				// getting customer profiles

				profiles = Profile.findByCustomeridlayer(con, customerid, layer, "peqosprofilename is not null");

				request.setAttribute("profiles", profiles);

				// getting public profiles

				publicprofiles = Profile.findByLayer(con, layer, "customerid is null" + " and peqosprofilename is not null");

				request.setAttribute("publicprofiles", publicprofiles);

				if (baseProfile == null || baseProfile.equals("")) {

					baseProfile = selectedProfileName;

				}

				if (baseProfile != null) {

					selectedProfile = Profile.findByQosprofilename(con, baseProfile);

				}

				String parentProfileName = (String) parentServiceParameters.get("QOS_PROFILE");

				if (selectedProfile == null && parentProfileName != null) {

					selectedProfile = Profile.findByQosprofilename(con, parentProfileName);

					// to get the default parent profile

					if (selectedProfile != null)

						baseProfile = selectedProfile.getQosprofilename();

					selectedProfileName = baseProfile;

				}

				request.setAttribute("selectedProfile", selectedProfile);

				policyMappings = PolicyMapping.findByProfilename(con, baseProfile);

				request.setAttribute("policyMappings", policyMappings);

				try {

					for (int i = 0; i < policyMappings.length; i++) {
						String paramName = "QOS_CLASS_" + policyMappings[i].getPosition() + "_PERCENT";
						String percent = (String) serviceParameters.get(paramName);
						if (percent != null) {
							request.setAttribute("SP_" + paramName, percent);
						}
					}

				} catch (Exception ex) {
					logger.debug("Exception thrown while iterating the policyMappings (policyMappings = " + policyMappings + ")");
					ex.printStackTrace();
					throw ex;
				}

				// to get the default parent profile

				request.setAttribute("SP_QOS_PROFILE", selectedProfileName);

				request.setAttribute("SP_QOS_BASE_PROFILE", baseProfile);

				// modify by tanye. Aquire the reuseable site

				Service[] available_sites = getAvailableSite(con, customerid, parentserviceid);

				request.setAttribute("available_sites", available_sites);

				String[] available_siteid = null;

				try {
					available_siteid = new String[available_sites.length];

					for (int i = 0; i < available_sites.length; i++) {

						available_siteid[i] = available_sites[i].getServiceid();

					}
				} catch (Exception ex) {
					logger.debug("Exception thrown while iterating the availables sites for the customer = " + customerid + " and parentserviceid = "
							+ parentserviceid + " (available_sites = " + available_sites + ")");
					ex.printStackTrace();
					throw ex;
				}

				// PR 16399
				// ServiceParameter[] available_regions=null;
				// ServiceParameter[] available_locations=null;
				Vector<Object> RegionResultVector = new Vector<Object>();
				Vector<Object> LocationResultVector = new Vector<Object>();

				for (int i = 0; i < available_siteid.length; i++) {
					// System.out.println("Debug2: available_siteid is: "+available_siteid[i]);
					ServiceParameter[] available_regions_partial = ServiceParameter.findByServiceid(con, available_siteid[i],
							"crm_serviceparam.Attribute = 'Region'", "", false);
					ServiceParameter[] available_locations_partial = ServiceParameter.findByServiceid(con, available_siteid[i],
							"crm_serviceparam.Attribute = 'Location'", "", false);
					// System.out.println("Debug2: available_regions_partial= "+available_regions_partial[0].getValue()+" service id= "+available_regions_partial[0].getServiceid()+" available_locations_partial= "+available_locations_partial[0].getValue());
					if (available_regions_partial != null) {
						for (int ii = 0; ii < available_regions_partial.length; ii++) {
							RegionResultVector.add(available_regions_partial[0]);
						}
					}
					if (available_locations_partial != null) {
						for (int jj = 0; jj < available_locations_partial.length; jj++) {
							LocationResultVector.add(available_locations_partial[0]);
						}
					}
					
					// in case of multiplexing VPWS sites BEGIN
					if (available_regions_partial == null) { 
						available_regions_partial = ServiceParameter.findAll(con,
							"(attribute='PW_aEnd_region' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_aEnd' and value="+available_siteid[i]+")) "+
							"OR (attribute='PW_zEnd_region' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_zEnd' and value="+available_siteid[i]+"))", "", false);
							
						if (available_regions_partial != null) {
							for (int ii = 0; ii < available_regions_partial.length; ii++) 
							{							
								ServiceParameter SP = new ServiceParameter();
								SP.setServiceid(available_siteid[i]);
								SP.setAttribute("Region");
								SP.setValue(available_regions_partial[0].getValue());
								RegionResultVector.add(SP);
							}
						}
					}
					
					if (available_locations_partial == null) {
						available_locations_partial = ServiceParameter.findAll(con,
							"(attribute='PW_aEnd_location' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_aEnd' and value="+available_siteid[i]+")) "+
							"OR (attribute='PW_zEnd_location' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_zEnd' and value="+available_siteid[i]+"))", "", false);
							
						if (available_locations_partial != null) {
							for (int ii = 0; ii < available_locations_partial.length; ii++) 
							{							
								ServiceParameter SP = new ServiceParameter();
								SP.setServiceid(available_siteid[i]);
								SP.setAttribute("Region");
								SP.setValue(available_locations_partial[0].getValue());
								LocationResultVector.add(SP);
							}
						}
					}
					// in case of multiplexing VPWS sites END

				}

				ServiceParameter[] available_regions = new ServiceParameter[RegionResultVector.size()];
				RegionResultVector.copyInto(available_regions);
				ServiceParameter[] available_locations = new ServiceParameter[LocationResultVector.size()];
				LocationResultVector.copyInto(available_locations);

				// PR 16399 Ends
				request.setAttribute("available_regions", available_regions);

				request.setAttribute("available_locations", available_locations);

				// end of layer2

			}

			// LAYER 3 - SITE

			if (type.equals("layer3-Site") || type.equals("layer3-Attachment") || type.equals("layer3-Protection")) {

				String location = null;

				String region = null;

				String pool = null;
				
				String secondaryPool = null;

				String car = null;

				String connectivityType = null;

				String activation_Scope = null;

				String managed_CE_Router = null;

				String routing = null;

				String ospf_area = null;

				String customer_as = null;

				String ceBasedQoS;
				
				String SP_QoSChildEnabled = null;

				String presname = request.getParameter("presname");
				String reusedSite = request.getParameter("reusedSite");
				

				if (presname == null) {

					presname = "";

				}

				request.setAttribute("presname", presname);

				Region[] regions = Region.findAll(con, "name  IN (select region from CR_location)");

				region = (String) serviceParameters.get("Region");

				// logger.debug("PreAddServiceAction ======region========"+region);

				if (region == null) {

					region = request.getParameter("SP_Region");

				}

				// logger.debug("PreAddServiceAction ======SP_Region========"+region);

				if (region == null) {

					region = regions[0].getPrimaryKey();

				}

				request.setAttribute("regions", regions);

				request.setAttribute("region", region);

				Location[] locations = Location.findByRegion(con, region);

				// Location[] locations = Location.findAll(con);

				CAR[] cars = CAR.findAll(con, whereForRate);

				request.setAttribute("locations", locations);

				request.setAttribute("cars", cars);

				String multicastRLParam = (String) serviceParameters.get("MulticastRateLimit");

				CAR multicastRateLimit = null;

				if (multicastRLParam != null && "enabled".equals(serviceParameters.get("MulticastStatus")))

					multicastRateLimit = CAR.findByRatelimitname(con, multicastRLParam);

				// chnages for PR 11901

				// Now find the parents multicast ratelimit if it is null

				if (multicastRLParam == null) {

					multicastRLParam = (String) parentServiceParameters.get("MulticastRateLimit");

					if (multicastRLParam != null && "enabled".equals(parentServiceParameters.get("MulticastStatus")))

						multicastRateLimit = CAR.findByRatelimitname(con, multicastRLParam);

				}

				request.setAttribute("multicastRateLimit", multicastRateLimit);
				String whereclausure="type='IPNet' and name in (select ip.poolname from v_ipnet ip where IP.COUNT__>0)";
				IPAddrPool[] pools = IPAddrPool.findAll(con, whereclausure);	
			
				if(pools!=null)
				

				request.setAttribute("pools", pools);

				pool = (String) serviceParameters.get("AddressPool");

				if (pool == null) {

					pool = request.getParameter("SP_AddressPool");

				}

				request.setAttribute("pool", pool);
				
				secondaryPool = (String) serviceParameters.get("SecondaryAddressPool");

				if (secondaryPool == null) {

					secondaryPool = request.getParameter("SP_SecondaryAddressPool");

				}

				request.setAttribute("secondaryPool", secondaryPool);

				EXPMapping[] mappings = EXPMapping.findAll(con);

				request.setAttribute("mappings", mappings);

				location = (String) serviceParameters.get("Location");

				if (location == null) {

					location = request.getParameter("SP_Location");

				}

				if (location == null) {

					location = locations[0].getPrimaryKey();

				}

				request.setAttribute("location", location);

				car = (String) serviceParameters.get("CAR");

				if (car == null) {

					car = request.getParameter("SP_CAR");

				}

				request.setAttribute("car", car);

				connectivityType = (String) serviceParameters.get("ConnectivityType");

				if (connectivityType == null) {

					connectivityType = request.getParameter("SP_ConnectivityType");

				}

				request.setAttribute("connectivityType", connectivityType);

				managed_CE_Router = (String) serviceParameters.get("Managed_CE_Router");

				if (managed_CE_Router == null) {

					managed_CE_Router = request.getParameter("SP_Managed_CE_Router");

				}
				request.setAttribute("managed_CE_Router", managed_CE_Router);
				
				SP_QoSChildEnabled = (String) serviceParameters.get("SP_QoSChildEnabled");

                if (SP_QoSChildEnabled == null) {

                  SP_QoSChildEnabled = request.getParameter("SP_QoSChildEnabled");

                }
                if(SP_QoSChildEnabled != null){

                  request.setAttribute("SP_QoSChildEnabled", SP_QoSChildEnabled);
                  serviceParameters.put("SP_QoSChildEnabled", SP_QoSChildEnabled);
                }

				ceBasedQoS = (String) serviceParameters.get("CE_based_QoS");

				if (ceBasedQoS == null) {

					ceBasedQoS = request.getParameter("SP_CE_based_QoS");

				}

				request.setAttribute("ceBasedQoS", ceBasedQoS);

				// Added for IV6
				addressFamily = (String) serviceParameters.get("AddressFamily");

				if (addressFamily == null) {
					addressFamily = request.getParameter("SP_AddressFamily");
				}
				if (addressFamily == null) {
					if (("layer3-Protection").equals(subType) || "true".equals(resend)) {
						addressFamily = ServiceUtils.getServiceParam(con, curVPNId, "AddressFamily");
					} else {
						addressFamily = ServiceUtils.getServiceParam(con, parentserviceid, "AddressFamily");
					}
				}

				request.setAttribute("AddressFamily", addressFamily);

				activation_Scope = (String) serviceParameters.get("Activation_Scope");

				if ("true".equals(resend)) {

					String resend_activation_Scope = request.getParameter("resend_SP_Activation_Scope");
					request.setAttribute("resend_activation_Scope", resend_activation_Scope);
				}

				if (activation_Scope == null) {
					activation_Scope = request.getParameter("SP_Activation_Scope");
				}

				request.setAttribute("activation_Scope", activation_Scope);

				routing = (String) serviceParameters.get("RoutingProtocol");

				if (routing == null) {

					routing = request.getParameter("SP_RoutingProtocol");

				}

				request.setAttribute("SP_RoutingProtocol", routing);

				ospf_area = (String) serviceParameters.get("OSPF_Area");

				if (ospf_area == null || ospf_area.equals("")) {

					ospf_area = request.getParameter("SP_OSPF_Area");

				}

				request.setAttribute("ospf_area", ospf_area);

				customer_as = (String) serviceParameters.get("Customer_ASN");

				if (customer_as == null || customer_as.equals("")) {

					customer_as = request.getParameter("SP_Customer_ASN");

				}

				request.setAttribute("customer_as", customer_as);

				String strstaticCounter = request.getParameter("staticCounter");

				int staticCounter = 1;

				boolean inc_sc = true;

				// for loop for route,mask

				if (strstaticCounter != null) {

					staticCounter = Integer.parseInt(strstaticCounter);

				}

				// logger.debug("preadd action --- staticCounter >>>>>>>>>>>>>>>>>>>>>"+staticCounter);

				String static_routes = (String) serviceParameters.get("STATIC_Routes");

				if (static_routes != null && !static_routes.equals("")) {

					String[] routes = static_routes.split(",");

					strstaticCounter = String.valueOf(routes.length);

					for (int i = 0; i < routes.length; i++) {

						String[] r1 = routes[i].split("/");

						String s1 = Integer.toString(i);

						request.setAttribute("mask" + s1, r1[1]);

						request.setAttribute("route" + s1, r1[0]);

					}
					staticCounter = Integer.valueOf(strstaticCounter);

				} else {

					for (int i = 0; i < staticCounter; i++) {

						String s1 = Integer.toString(i);
						String route = request.getParameter("route" + s1);
						String mask = request.getParameter("mask" + s1);
						request.setAttribute("mask" + s1, mask);
						request.setAttribute("route" + s1, route);
						try {
							if (route != null && !"".equals(route) && "Static".equalsIgnoreCase(routing)) {
								IPAddressHelper.validateCIDRAddress(route + "/" + mask, addressFamily);
							}
						} catch (Exception e) {
							request.setAttribute("Message", e.getMessage());
							inc_sc = false;
						}

					}

				}

				if (strstaticCounter != null && inc_sc) {

					// staticCounter = Integer.parseInt(request.getParameter("staticCounter"));

					if (request.getParameter("include") != null && request.getParameter("include").equals("true")) {

						staticCounter++;
						strstaticCounter = Integer.toString(staticCounter);
					}
				}
				String include = request.getParameter("include");

				request.setAttribute("include", include);

				request.setAttribute("staticCounter", strstaticCounter);

				// QOS RELATED

				// logger.debug("PreAddServiceAction ======L3SITE----QOS========");

				Profile[] publicprofiles;

				EXPMapping[] expMappings = null;

				PolicyMapping[] policyMappings = null;

				String layer = "layer 3";

				Profile selectedProfile = null;

				String selectedProfileName = (String) serviceParameters.get("QOS_PROFILE");

				if (selectedProfileName == null)

					selectedProfileName = request.getParameter("SP_QOS_PROFILE");

				request.setAttribute("SP_QOS_PROFILE", selectedProfileName);

				// logger.debug("PreAddServiceAction ======selectedProfileName========"+selectedProfileName);

				String baseProfile = (String) serviceParameters.get("QOS_BASE_PROFILE");

				if (baseProfile == null)

					baseProfile = request.getParameter("SP_QOS_BASE_PROFILE");

				request.setAttribute("SP_QOS_BASE_PROFILE", baseProfile);

				// logger.debug("PreAddServiceAction ======baseProfile========"+baseProfile);

				expMappings = EXPMapping.findAll(con);

				request.setAttribute("expMappings", expMappings);

				// getting customer profiles
				String whereClause1 = null;
				String whereClause2 = null;
				if ("IPv6".equalsIgnoreCase(addressFamily)) {
					whereClause1 = "peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename like '%_v6'";
					whereClause2 = "customerid is null and peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename like '%_v6'";
				} else {
					whereClause1 = "peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename not like '%_v6'";
					whereClause2 = "customerid is null and peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename not like '%_v6'";
				}

				profiles = Profile.findByCustomeridlayer(con, customerid, layer, whereClause1);

				request.setAttribute("profiles", profiles);

				// getting public profiles

				publicprofiles = Profile.findByLayer(con, layer, whereClause2);

				request.setAttribute("publicprofiles", publicprofiles);

				if (baseProfile == null || baseProfile.equals("")) {

					baseProfile = selectedProfileName;

				}

				if (baseProfile != null) {

					selectedProfile = Profile.findByQosprofilename(con, baseProfile);

				}

				String parentProfileName = null;
				// Service service = Service.findByPrimaryKey(con, serviceid);
				//modified for GIS -Anu
				if (subType != null && (subType.equals(Constants.TYPE_LAYER3_PROTECTION)||subType.equals(Constants.TYPE_GIS_PROTECTION))) {
					// For protection attachment, the site service comes as parent service.
					// So take the base QOS profile from VPN Service.
					parentProfileName = ServiceUtils.getServiceParam(con, curVPNId, "QOS_PROFILE");
				} else {

					parentProfileName = (String) parentServiceParameters.get("QOS_PROFILE");
				}
				if (selectedProfile == null && parentProfileName != null) {

					selectedProfile = Profile.findByQosprofilename(con, parentProfileName);

					// to get the default parent profile

					baseProfile = selectedProfile.getQosprofilename();

					selectedProfileName = baseProfile;

				}

				request.setAttribute("selectedProfile", selectedProfile);

				policyMappings = PolicyMapping.findByProfilename(con, baseProfile);

				request.setAttribute("policyMappings", policyMappings);

				try {					
						for (int i = 0; i < policyMappings.length; i++) {
							String paramName = "QOS_CLASS_" + policyMappings[i].getPosition() + "_PERCENT";
							String percent = (String) serviceParameters.get(paramName);
							if (percent != null) {
								request.setAttribute("SP_" + paramName, percent);
							}
						}
					

				} catch (Exception ex) {
					logger.debug("Exception thrown while iterating policyMappings array (policyMappings = " + policyMappings + ")");
					ex.printStackTrace();
					throw ex;
				}

				// to get the default parent profile

				request.setAttribute("SP_QOS_PROFILE", selectedProfileName);

				request.setAttribute("SP_QOS_BASE_PROFILE", baseProfile);

				// modify by tanye. Aquire the reuseable site

				//Service[] available_sites = getAvailableSite(con, customerid, parentserviceid);
				String presnamelist = request.getParameter("presnamelist");				
				
				boolean reused=false;
				
				if(reusedSite==null){
					reused=isReused(con);
					reusedSite=Boolean.toString(reused);					
				}
				else
					reused=Boolean.valueOf(reusedSite);
				
				if( reused){
				
					ServiceExtBean[] available_sites = getAvailableSite(con, customerid, parentserviceid,managed_CE_Router,presnamelist);
	
					request.setAttribute("available_sites", available_sites);
					
					request.setAttribute("reusedSite", reusedSite);
				}


				request.setAttribute("subType", subType);

				request.setAttribute("attachmentid", attachmentid);
				

			} // end of layer 3 - site
			if (type.equals("GIS-Site") || type.equals("GIS-Attachment") || type.equals("GIS-Protection")) { 
				
				//System.out.print("Indide the GIS ::::");

				String location = null;

				String region = null;
				
				String perouter = null;
				
				String peinterface = null;

				String pool = null;
				
				String secondaryPool = null;

				String car = null;
				String ipaddrlist = null;

				String connectivityType = null;

				String activation_Scope = null;

				String managed_CE_Router = null;

				String routing = null;

				String ospf_area = null;

				String customer_as = null;

				String ceBasedQoS;

				String presname = request.getParameter("presname");

				if (presname == null) {

					presname = "";

				}

				request.setAttribute("presname", presname);

				Region[] regions = Region.findAll(con, "name  IN (select region from CR_location)");

				region = (String) serviceParameters.get("Region");

				// logger.debug("PreAddServiceAction ======region========"+region);

				if (region == null) {

					region = request.getParameter("SP_Region");

				}

				// logger.debug("PreAddServiceAction ======SP_Region========"+region);

				if (region == null) {

					region = regions[0].getPrimaryKey();

				}

				request.setAttribute("regions", regions);

				request.setAttribute("region", region);

				Location[] locations = Location.findByRegion(con, region);

				// Location[] locations = Location.findAll(con);

				CAR[] cars = CAR.findAll(con, whereForRate);

				request.setAttribute("locations", locations);

				request.setAttribute("cars", cars);

				String multicastRLParam = (String) serviceParameters.get("MulticastRateLimit");

				CAR multicastRateLimit = null;

				if (multicastRLParam != null && "enabled".equals(serviceParameters.get("MulticastStatus")))

					multicastRateLimit = CAR.findByRatelimitname(con, multicastRLParam);

				// chnages for PR 11901

				// Now find the parents multicast ratelimit if it is null

				if (multicastRLParam == null) {

					multicastRLParam = (String) parentServiceParameters.get("MulticastRateLimit");

					if (multicastRLParam != null && "enabled".equals(parentServiceParameters.get("MulticastStatus")))

						multicastRateLimit = CAR.findByRatelimitname(con, multicastRLParam);

				}

				request.setAttribute("multicastRateLimit", multicastRateLimit);
				
				// Added for IV6
				addressFamily = (String) serviceParameters.get("AddressFamily");

				if (addressFamily == null) {
					addressFamily = request.getParameter("SP_AddressFamily");
				}
				//  Doubts -Anu
				if (addressFamily == null) {
					if (("GIS-Protection").equals(subType) || "true".equals(resend)) {
						addressFamily = ServiceUtils.getServiceParam(con, curVPNId, "AddressFamily");
					} else {
						addressFamily = ServiceUtils.getServiceParam(con, parentserviceid, "AddressFamily");
					}
				}

				request.setAttribute("AddressFamily", addressFamily);

				IPAddrPool[] pools = IPAddrPool.findAll(con, "type='IPNet'");
				// code to show only available address pools
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

				request.setAttribute("pools", pools);

				pool = (String) serviceParameters.get("AddressPool");

				if (pool == null) {

					pool = request.getParameter("SP_AddressPool");

				}
				if (pool == null) {
					
					if(pools!=null)
					{
						// based on address family pick the first pool
						
						//System.out.println("addressFamily name is "+addressFamily);
						for(int i=0;i<pools.length;i++){
							if(pools[i].getAddressfamily().equals(addressFamily)){
								pool = pools[i].getName(); 
								break;
							}
						}
					}
					
				}
				request.setAttribute("pool", pool);
				
				/*********************** for Address pool ***********************************/
				
				 List<String> iplist = new ArrayList<String>();
				//System.out.println("pool name is "+pool);
				if (pool != null)
				{
					
					iplist = getIPNETAddr(con, pool);
				}
				
				request.setAttribute("iplist", iplist);
				
				ipaddrlist = (String) serviceParameters.get("IPNetAddr");
				
				if (ipaddrlist == null) {

					ipaddrlist = request.getParameter("SP_IPNetAddr");

				}
				
				if (ipaddrlist == null) {
					
					ipaddrlist=	iplist.get(0);   // first value by default
					/*for (Map.Entry<String, List<String>> entry: iplist.entrySet())
					{
						ipaddrlist = entry.getKey();
						break;
					}*/
				}
				
				request.setAttribute("ipaddrlist", ipaddrlist);
				
				secondaryPool = (String) serviceParameters.get("SecondaryAddressPool");

				if (secondaryPool == null) {

					secondaryPool = request.getParameter("SP_SecondaryAddressPool");

				}

				request.setAttribute("secondaryPool", secondaryPool);

				EXPMapping[] mappings = EXPMapping.findAll(con);

				request.setAttribute("mappings", mappings);

				location = (String) serviceParameters.get("Location");

				if (location == null) {

					location = request.getParameter("SP_Location");

				}
				
				if ( location != null && !locationBelongsToRegion(con, location, region)) location = null;

				if (location == null) {

					location = locations[0].getPrimaryKey();

				}
				
				HashMap<String, String> peList = new HashMap<String, String>();
				
				if (location != null)
				{
					peList = getPEList(con, location);
				}
				
				request.setAttribute("peList", peList);

				request.setAttribute("location", location);

				perouter = (String) serviceParameters.get("PERouter");
				
				if (perouter == null) {

					perouter = request.getParameter("SP_PERouter");

				}
				
				if ( perouter != null && !perouterBelongsToLocation(con, perouter, location)) perouter = null;
				
				if (perouter == null) {
					for (Map.Entry<String, String> entry: peList.entrySet())
					{
						perouter = entry.getKey();
						break;
					}
				}
				
				request.setAttribute("perouter", perouter);
				
				HashMap<String, String> ifList = new HashMap<String, String>();
				
				if (perouter != null)
				{
					ifList = getIfListForGIS(con, perouter);
				}
				
				request.setAttribute("ifList", ifList);
				
				peinterface = (String) serviceParameters.get("PEInterface");
				
				if (peinterface == null) {

					peinterface = request.getParameter("SP_PEInterface");

				}
				
				if (peinterface == null) {
					for (Map.Entry<String, String> entry: ifList.entrySet())
					{
						peinterface = entry.getKey();
						break;
					}
				}
				
				request.setAttribute("peinterface", peinterface);
				
				car = (String) serviceParameters.get("CAR");

				if (car == null) {

					car = request.getParameter("SP_CAR");

				}

				request.setAttribute("car", car);

				connectivityType = (String) serviceParameters.get("ConnectivityType");

				if (connectivityType == null) {

					connectivityType = request.getParameter("SP_ConnectivityType");

				}

				request.setAttribute("connectivityType", connectivityType);

				managed_CE_Router = (String) serviceParameters.get("Managed_CE_Router");

				if (managed_CE_Router == null) {

					managed_CE_Router = request.getParameter("SP_Managed_CE_Router");

				}

				request.setAttribute("managed_CE_Router", managed_CE_Router);

				ceBasedQoS = (String) serviceParameters.get("CE_based_QoS");

				if (ceBasedQoS == null) {

					ceBasedQoS = request.getParameter("SP_CE_based_QoS");

				}

				request.setAttribute("ceBasedQoS", ceBasedQoS);

			

				activation_Scope = (String) serviceParameters.get("Activation_Scope");

				if ("true".equals(resend)) {

					String resend_activation_Scope = request.getParameter("resend_SP_Activation_Scope");
					request.setAttribute("resend_activation_Scope", resend_activation_Scope);
				}

				if (activation_Scope == null) {
					activation_Scope = request.getParameter("SP_Activation_Scope");
				}

				request.setAttribute("activation_Scope", activation_Scope);

				routing = (String) serviceParameters.get("RoutingProtocol");

				if (routing == null) {

					routing = request.getParameter("SP_RoutingProtocol");

				}

				request.setAttribute("SP_RoutingProtocol", routing);

				ospf_area = (String) serviceParameters.get("OSPF_Area");

				if (ospf_area == null || ospf_area.equals("")) {

					ospf_area = request.getParameter("SP_OSPF_Area");

				}

				request.setAttribute("ospf_area", ospf_area);

				customer_as = (String) serviceParameters.get("Customer_ASN");

				if (customer_as == null || customer_as.equals("")) {

					customer_as = request.getParameter("SP_Customer_ASN");

				}

				request.setAttribute("customer_as", customer_as);

				String strstaticCounter = request.getParameter("staticCounter");

				int staticCounter = 1;

				boolean inc_sc = true;

				// for loop for route,mask

				if (strstaticCounter != null) {

					staticCounter = Integer.parseInt(strstaticCounter);

				}

				// logger.debug("preadd action --- staticCounter >>>>>>>>>>>>>>>>>>>>>"+staticCounter);

				String static_routes = (String) serviceParameters.get("STATIC_Routes");

				if (static_routes != null && !static_routes.equals("")) {

					String[] routes = static_routes.split(",");

					strstaticCounter = String.valueOf(routes.length);

					for (int i = 0; i < routes.length; i++) {

						String[] r1 = routes[i].split("/");

						String s1 = Integer.toString(i);

						request.setAttribute("mask" + s1, r1[1]);

						request.setAttribute("route" + s1, r1[0]);

					}
					staticCounter = Integer.valueOf(strstaticCounter);

				} else {

					for (int i = 0; i < staticCounter; i++) {

						String s1 = Integer.toString(i);
						String route = request.getParameter("route" + s1);
						String mask = request.getParameter("mask" + s1);
						request.setAttribute("mask" + s1, mask);
						request.setAttribute("route" + s1, route);
						try {
							if (route != null && !"".equals(route) && "Static".equalsIgnoreCase(routing)) {
								IPAddressHelper.validateCIDRAddress(route + "/" + mask, addressFamily);
							}
						} catch (Exception e) {
							request.setAttribute("Message", e.getMessage());
							inc_sc = false;
						}

					}

				}

				if (strstaticCounter != null && inc_sc) {

					// staticCounter = Integer.parseInt(request.getParameter("staticCounter"));

					if (request.getParameter("include") != null && request.getParameter("include").equals("true")) {

						staticCounter++;
						strstaticCounter = Integer.toString(staticCounter);
					}
				}
				String include = request.getParameter("include");

				request.setAttribute("include", include);

				request.setAttribute("staticCounter", strstaticCounter);
				
/* ********************* logic for PrefixList for BGP **************************************** */
				
				String strprefixCounter = request.getParameter("prefixCounter");
				
			
				int prefixCounter = 1;

				boolean inc1_sc = true;

				// for loop for route,mask

				if (strprefixCounter != null) {

					prefixCounter = Integer.parseInt(strprefixCounter);

				}
				
				String prefix_routes = (String) serviceParameters.get("PREFIX_Routes");
			//	System.out.println("PREFIX_Routes::::"+prefix_routes);


				if (prefix_routes != null && !prefix_routes.equals("")) {

					String[] routes = prefix_routes.split(",");

					strprefixCounter = String.valueOf(routes.length);

					for (int i = 0; i < routes.length; i++) {
						String s1 = Integer.toString(i);
						
                      if(routes[i].contains("le"))
                      {
                    	  String[] r1 = routes[i].split("/");	
                    	  
                    	 request.setAttribute("prefixroute" + s1, r1[0]);
                    	  
                         request.setAttribute("prefixmask" + s1, r1[1].split(" le ")[0]);
                         request.setAttribute("prefixmask" + s1, r1[1].split(" le ")[1]);
  						
                    	  
                      }else
                      {
						String[] r1 = routes[i].split("/");						

						request.setAttribute("prefixmask" + s1, r1[1]);

						request.setAttribute("prefixroute" + s1, r1[0]);
                      }						
						
					}
					prefixCounter = Integer.valueOf(strprefixCounter);

				} else {
						//System.out.println("Inside the PreAddServiceAction....loop1");
					for (int i = 0; i < prefixCounter; i++) {

						String s1 = Integer.toString(i);
						String route = request.getParameter("prefixroute" + s1);
						String mask = request.getParameter("prefixmask" + s1);
						String lemask=request.getParameter("lemask"+ s1);
						if(lemask==null){lemask="";}
						
						request.setAttribute("prefixmask" + s1, mask);
						request.setAttribute("prefixroute" + s1, route);
						request.setAttribute("lemask"+ s1 ,lemask);
						
						try {
							if (route != null && !"".equals(route) && "BGP".equalsIgnoreCase(routing)) {
								IPAddressHelper.validateCIDRAddress(route + "/" + mask, addressFamily);
							}
						} catch (Exception e) {
							request.setAttribute("Message", e.getMessage());
							inc1_sc = false;
						}

					}

				}

				if (strprefixCounter != null && inc1_sc) {

					// staticCounter = Integer.parseInt(request.getParameter("staticCounter"));

					if (request.getParameter("include") != null && request.getParameter("include").equals("true")) {

						prefixCounter++;
						strprefixCounter = Integer.toString(prefixCounter);
					}
				}
				String include1 = request.getParameter("include");

				request.setAttribute("include", include1);

				request.setAttribute("prefixCounter", strprefixCounter);
			

				// QOS RELATED

				// logger.debug("PreAddServiceAction ======L3SITE----QOS========");

				Profile[] publicprofiles;

				EXPMapping[] expMappings = null;

				PolicyMapping[] policyMappings = null;

				String layer = "layer 3";

				Profile selectedProfile = null;

				String selectedProfileName = (String) serviceParameters.get("QOS_PROFILE");

				if (selectedProfileName == null)

					selectedProfileName = request.getParameter("SP_QOS_PROFILE");

				request.setAttribute("SP_QOS_PROFILE", selectedProfileName);

				// logger.debug("PreAddServiceAction ======selectedProfileName========"+selectedProfileName);

				String baseProfile = (String) serviceParameters.get("QOS_BASE_PROFILE");

				if (baseProfile == null)

					baseProfile = request.getParameter("SP_QOS_BASE_PROFILE");

				request.setAttribute("SP_QOS_BASE_PROFILE", baseProfile);

				// logger.debug("PreAddServiceAction ======baseProfile========"+baseProfile);

				expMappings = EXPMapping.findAll(con);

				request.setAttribute("expMappings", expMappings);

				// getting customer profiles
				String whereClause1 = null;
				String whereClause2 = null;
				if ("IPv6".equalsIgnoreCase(addressFamily)) {
					whereClause1 = "peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename like '%_v6'";
					whereClause2 = "customerid is null and peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename like '%_v6'";
				} else {
					whereClause1 = "peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename not like '%_v6'";
					whereClause2 = "customerid is null and peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename not like '%_v6'";
				}

				profiles = Profile.findByCustomeridlayer(con, customerid, layer, whereClause1);

				request.setAttribute("profiles", profiles);

				// getting public profiles

				publicprofiles = Profile.findByLayer(con, layer, whereClause2);

				request.setAttribute("publicprofiles", publicprofiles);

				if (baseProfile == null || baseProfile.equals("")) {

					baseProfile = selectedProfileName;

				}

				if (baseProfile != null) {

					selectedProfile = Profile.findByQosprofilename(con, baseProfile);

				}

				String parentProfileName = null;
				// Service service = Service.findByPrimaryKey(con, serviceid);
				//modified for GIS -Anu
				if (subType != null && (subType.equals(Constants.TYPE_GIS_PROTECTION))) {
					// For protection attachment, the site service comes as parent service.
					// So take the base QOS profile from VPN Service.
					parentProfileName = ServiceUtils.getServiceParam(con, curVPNId, "QOS_PROFILE");
				} else {

					parentProfileName = (String) parentServiceParameters.get("QOS_PROFILE");
				}
				if (selectedProfile == null && parentProfileName != null) {

					selectedProfile = Profile.findByQosprofilename(con, parentProfileName);

					// to get the default parent profile

					baseProfile = selectedProfile.getQosprofilename();

					selectedProfileName = baseProfile;

				}

				request.setAttribute("selectedProfile", selectedProfile);

				policyMappings = PolicyMapping.findByProfilename(con, baseProfile);

				request.setAttribute("policyMappings", policyMappings);

				try {

					for (int i = 0; i < policyMappings.length; i++) {
						String paramName = "QOS_CLASS_" + policyMappings[i].getPosition() + "_PERCENT";
						String percent = (String) serviceParameters.get(paramName);
						if (percent != null) {
							request.setAttribute("SP_" + paramName, percent);
						}
					}

				} catch (Exception ex) {
					logger.debug("Exception thrown while iterating policyMappings array (policyMappings = " + policyMappings + ")");
					ex.printStackTrace();
					throw ex;
				}

				// to get the default parent profile

				request.setAttribute("SP_QOS_PROFILE", selectedProfileName);

				request.setAttribute("SP_QOS_BASE_PROFILE", baseProfile);

				// modify by tanye. Aquire the reuseable site

				Service[] available_sites = getAvailableSite(con, customerid, parentserviceid);

				request.setAttribute("available_sites", available_sites);

				String[] available_siteid = null;

				try {
					available_siteid = new String[available_sites.length];

					for (int i = 0; i < available_sites.length; i++) {

						available_siteid[i] = available_sites[i].getServiceid();

					}
				} catch (Exception ex) {
					logger.debug("Exception thrown while iterating the availables sites for the customer = " + customerid + " and parentserviceid = "
							+ parentserviceid + " (available_sites = " + available_sites + ")");
					ex.printStackTrace();
					throw ex;
				}

				// PR 16399
				// ServiceParameter[] available_regions=null;
				// ServiceParameter[] available_locations=null;
				Vector<Object> RegionResultVector = new Vector<Object>();
				Vector<Object> LocationResultVector = new Vector<Object>();

				for (int i = 0; i < available_siteid.length; i++) {
					// System.out.println("Debug2: available_siteid is: "+available_siteid[i]);
					ServiceParameter[] available_regions_partial = ServiceParameter.findByServiceid(con, available_siteid[i],
							"crm_serviceparam.Attribute = 'Region'", "", false);
					ServiceParameter[] available_locations_partial = ServiceParameter.findByServiceid(con, available_siteid[i],
							"crm_serviceparam.Attribute = 'Location'", "", false);
					// System.out.println("Debug2: available_regions_partial= "+available_regions_partial[0].getValue()+" service id= "+available_regions_partial[0].getServiceid()+" available_locations_partial= "+available_locations_partial[0].getValue());
					
					if (available_regions_partial != null) {
						for (int ii = 0; ii < available_regions_partial.length; ii++) {
							RegionResultVector.add(available_regions_partial[0]);
						}
					}
					if (available_locations_partial != null) {
						for (int jj = 0; jj < available_locations_partial.length; jj++) {
							LocationResultVector.add(available_locations_partial[0]);
						}
					}
					
					// in case of multiplexing VPWS sites BEGIN
					if (available_regions_partial == null) { 
						available_regions_partial = ServiceParameter.findAll(con,
							"(attribute='PW_aEnd_region' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_aEnd' and value="+available_siteid[i]+")) "+
							"OR (attribute='PW_zEnd_region' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_zEnd' and value="+available_siteid[i]+"))", "", false);
							
						if (available_regions_partial != null) {
							for (int ii = 0; ii < available_regions_partial.length; ii++) 
							{							
								ServiceParameter SP = new ServiceParameter();
								SP.setServiceid(available_siteid[i]);
								SP.setAttribute("Region");
								SP.setValue(available_regions_partial[0].getValue());
								RegionResultVector.add(SP);
							}
						}
					}
					
					if (available_locations_partial == null) {
						available_locations_partial = ServiceParameter.findAll(con,
							"(attribute='PW_aEnd_location' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_aEnd' and value="+available_siteid[i]+")) "+
							"OR (attribute='PW_zEnd_location' and serviceid IN (select serviceid from crm_serviceparam where attribute='Site_Service_ID_zEnd' and value="+available_siteid[i]+"))", "", false);
							
						if (available_locations_partial != null) {
							for (int ii = 0; ii < available_locations_partial.length; ii++) 
							{							
								ServiceParameter SP = new ServiceParameter();
								SP.setServiceid(available_siteid[i]);
								SP.setAttribute("Region");
								SP.setValue(available_locations_partial[0].getValue());
								LocationResultVector.add(SP);
							}
						}
					}
					// in case of multiplexing VPWS sites END

				}

				ServiceParameter[] available_regions = new ServiceParameter[RegionResultVector.size()];
				RegionResultVector.copyInto(available_regions);
				ServiceParameter[] available_locations = new ServiceParameter[LocationResultVector.size()];
				LocationResultVector.copyInto(available_locations);

				// PR 16399 Ends
				request.setAttribute("available_regions", available_regions);

				request.setAttribute("available_locations", available_locations);

				HashMap managedCERouters = new HashMap();

				String presnamelist = request.getParameter("presnamelist");
				for (Service s : available_sites) {

					ServiceParameter sp = ServiceParameter.findByServiceidattribute(con, s.getServiceid(), "Managed_CE_Router");
					String serviceidString = s.getServiceid();
					if (managed_CE_Router == null) {
						// if the option managed CE routers in form is not selected
						managedCERouters.put(serviceidString, (sp == null ? "" : sp.getValue()));
					} else {
						// if the option managed CE routers in form is selected, could be yes or no
						if (presnamelist == null) {
							managedCERouters.put(serviceidString, (sp == null ? "" : sp.getValue()));
						} else {
							// this will be set if another site has been chosen, ie during multiplexing
							if (presnamelist.equals(serviceidString)) {
								managedCERouters.put(presnamelist, (sp == null ? managed_CE_Router : sp.getValue()));
							} else {
								managedCERouters.put(serviceidString, (sp == null ? "" : sp.getValue()));
							}
						}
					}

				}
				request.setAttribute("subType", subType);

				request.setAttribute("attachmentid", attachmentid);
				
				request.setAttribute("managedCERouters", managedCERouters);
			}

		 }catch (Exception ex) {

			error = true;

			ex.printStackTrace();

			logger.error("PreAddServiceAction ======Excption thrown " + ex);

		} finally {

			// close the connection

			dbp.releaseConnection(con);			

			try { if (con != null) con.close(); } catch (Exception ex) { }
		}

		// Forward Action

		if (!(error)) {

			// set values to actionform obj && Transfer to the jsp

			return mapping.findForward(Constants.SUCCESS);

		} else {

			return mapping.findForward(Constants.FAILURE);

		}

	}


  //extra method for routers and interfaces.
  private String getVendorName(Connection con, String perouter)
  {
    PreparedStatement statePstmt = null;
    ResultSet resultSet = null;
    String query, vendor_name = null;
    logger.error("Router name is : " + perouter);
    query = "select vendor from cr_networkelement where NETWORKELEMENTID = ?";
    try
    {
      if (con != null)
      {
        statePstmt = con.prepareStatement(query);
        statePstmt.setString(1, perouter);
        resultSet = statePstmt.executeQuery();
        while (resultSet.next())
        {
          vendor_name = resultSet.getString(1);
        }
      }
    } catch (SQLException e)
    {
      e.printStackTrace();
    } finally
    {
      try {
        resultSet.close();
      } catch (Exception ignoreme) {
      }
      try {
        statePstmt.close();
      } catch (Exception ignoreme) {
      }
    }
    return vendor_name;
  }

  private String getDescription(Connection con,
      String location_aEnd,
      String location_zEnd,
      String description_SP_link_type,
      String nameA,
      String nameB)
  {
    PreparedStatement statePstmt = null;
    ResultSet resultSet = null;
    String query, description = null;
    int count = 0;
    query = "select count(*) from igw_trunk";
    try
    {
      if (con != null)
      {
        statePstmt = con.prepareStatement(query);
        resultSet = statePstmt.executeQuery();
        if (resultSet.next())
        {
          count = resultSet.getInt(1);
        }
        count = count + 1;
        String type_of_link = getTypeOfLink(description_SP_link_type);
        String name_finalA = "";
        String name_finalB = "";
        if (type_of_link.startsWith("STM")) {
          name_finalA = nameA;
          name_finalB = nameB;
        }
        else {
          int numA = nameA.indexOf('-');
          name_finalA = nameA.substring(numA + 1, nameA.length());
          int numB = nameB.indexOf('-');
          name_finalB = nameB.substring(numB + 1, nameB.length());
        }
        description = type_of_link + "_" + location_aEnd + "-" + name_finalA + "_to_" + location_zEnd + "-" + name_finalB + Constants.MEMBER_REPLACE + count;
      }
    } catch (SQLException e)
    {
      e.printStackTrace();
    } finally
    {
      try {
        resultSet.close();
      } catch (Exception ignoreme) {
      }
      try {
        statePstmt.close();
      } catch (Exception ignoreme) {
      }
    }
    return description;
  }
  
  private boolean setAllTrunks(Connection con, String customerid, boolean error, HttpServletRequest request) {
    List<HashMap<String, String>> allTrunks = new ArrayList<HashMap<String, String>>();
    PreparedStatement pstmtIGW = null;
    ResultSet rSetIGW = null;
    try {
      String query = "SELECT t.trunk_id, " +
                     "d1.SIDE_DESCRIPTION, " +
                     "t.link_type, " +
                     "t.status, " +
                     "t.submit_data, " +
                     "ne1.name, " +
                     "ne2.name " +
                     "FROM igw_trunk t " +
                     "INNER JOIN igw_trunktype tt " +
                     "ON t.trunktype_id = tt.trunktype_id " +
                     "INNER JOIN igw_trunkdata d1 " +
                     "ON t.trunk_id            = d1.trunk_id " +
                     "AND d1.parent_trunkdata IS NULL " +
                     "AND d1.side_sort_name    = 'A' " +
                     "INNER JOIN cr_networkElement ne1 " +
                     "ON d1.router_id = ne1.networkElementId " +
                     "INNER JOIN igw_trunkdata d2 " +
                     "ON t.trunk_id            = d2.trunk_id " +
                     "AND d2.parent_trunkdata IS NULL " +
                     "AND d2.side_sort_name    = 'Z' " +
                     "INNER JOIN cr_networkElement ne2 " +
                     "ON d2.router_id = ne2.networkElementId " +
                     "ORDER BY t.trunk_id ASC ";
      StringBuffer igwSQL = new StringBuffer(query);
      pstmtIGW = con.prepareStatement(igwSQL.toString());
      rSetIGW = pstmtIGW.executeQuery();
      while (rSetIGW.next()) {
        HashMap<String, String> trunkData = new HashMap<String, String>();
        trunkData.put("trunk_id", rSetIGW.getString(1));
        trunkData.put("name", rSetIGW.getString(2));
        trunkData.put("link_type", rSetIGW.getString(3));
        trunkData.put("status", rSetIGW.getString(4));
        trunkData.put("submit_data", rSetIGW.getString(5));
        trunkData.put("router_a", rSetIGW.getString(6));
        trunkData.put("router_z", rSetIGW.getString(7));
        allTrunks.add(trunkData);
      }
    } catch (Exception ex) {
      ex.printStackTrace();
      error = true;
    } finally {
      try {
      if (rSetIGW != null)
        rSetIGW.close();
      if (pstmtIGW != null)
        pstmtIGW.close();
      } catch (Exception e) {
        // ignore close error
      }
    }
    request.setAttribute("allTrunks", allTrunks);
    return error;
  }
  
  private List<HashMap<String,String>> getTrunkDetails(Connection con, String serviceId) {    
    String sql = "select TRUNKDATA_ID, PARENT_TRUNKDATA, TRUNK_ID, SIDE_SERVICE_ID, SIDE_NAME, SIDE_SORT_NAME, ROUTER_ID, INTERFACES_ID, " + 
        " IPNET_POOL, IPNET_ADDRESS, IPNET_SUBMASK, SIDE_DESCRIPTION, NEGO_FLAG, LINKPROTOCOL, MTU, PIM_FLAG, OSPFNET_TYPE_FLAG, " +  
        " OSPF_COST, OSPF_PASSWORD, LDP_FLAG, INTERFACE_DESCRIPTION, TRAFFIC_POLICYNAME, POLICY_TYPE, IPV6_POOL, IPV6_ADDRESS, " +  
        " ENCAPSULATION, IPBINDING_FLAG, OSPF_PROCESSID, AREA, LDP_PASSWORD, BANDWIDTH, RSVP_BANDWIDTH from IGW_TRUNKDATA where TRUNK_ID = ? ORDER BY SIDE_NAME ASC";
    HashMap<String, String> allTrunkData = null;
    PreparedStatement pstmtIGW = null;
    ResultSet rSetIGW = null;
    List<HashMap<String,String>> trunks = new ArrayList<HashMap<String,String>>();
    try {
      StringBuffer igwSQL = new StringBuffer(sql);
      pstmtIGW = con.prepareStatement(igwSQL.toString());
      pstmtIGW.setString(1, serviceId);
      rSetIGW = pstmtIGW.executeQuery();
      while (rSetIGW.next()) {
        allTrunkData = new HashMap<String, String>();
        allTrunkData.put("TRUNKDATA_ID", rSetIGW.getString(1));
        allTrunkData.put("PARENT_TRUNKDATA", rSetIGW.getString(2));
        allTrunkData.put("TRUNK_ID", rSetIGW.getString(3));
        allTrunkData.put("SIDE_SERVICE_ID", rSetIGW.getString(4));
        allTrunkData.put("SIDE_NAME", rSetIGW.getString(5));
        allTrunkData.put("SIDE_SORT_NAME", rSetIGW.getString(6));
        allTrunkData.put("ROUTER_ID", rSetIGW.getString(7));
        allTrunkData.put("INTERFACES_ID", rSetIGW.getString(8));
        allTrunkData.put("IPNET_POOL", rSetIGW.getString(9));
        allTrunkData.put("IPNET_ADDRESS", rSetIGW.getString(10));
        allTrunkData.put("IPNET_SUBMASK", rSetIGW.getString(11));
        allTrunkData.put("SIDE_DESCRIPTION", rSetIGW.getString(12));
        allTrunkData.put("NEGO_FLAG", rSetIGW.getString(13));
        allTrunkData.put("LINKPROTOCOL", rSetIGW.getString(14));
        allTrunkData.put("MTU", rSetIGW.getString(15));
        allTrunkData.put("PIM_FLAG", rSetIGW.getString(16));
        allTrunkData.put("OSPFNET_TYPE_FLAG", rSetIGW.getString(17));
        allTrunkData.put("OSPF_COST", rSetIGW.getString(18));
        allTrunkData.put("OSPF_PASSWORD", rSetIGW.getString(19));
        allTrunkData.put("LDP_FLAG", rSetIGW.getString(20));
        allTrunkData.put("INTERFACE_DESCRIPTION", rSetIGW.getString(21));
        allTrunkData.put("TRAFFIC_POLICYNAME", rSetIGW.getString(22));
        allTrunkData.put("POLICY_TYPE", rSetIGW.getString(23));
        allTrunkData.put("IPV6_POOL", rSetIGW.getString(24));
        allTrunkData.put("IPV6_ADDRESS", rSetIGW.getString(25));
        allTrunkData.put("ENCAPSULATION", rSetIGW.getString(26));
        allTrunkData.put("IPBINDING_FLAG", rSetIGW.getString(27));
        allTrunkData.put("OSPF_PROCESSID", rSetIGW.getString(28));
        allTrunkData.put("AREA", rSetIGW.getString(29));
        allTrunkData.put("LDP_PASSWORD", rSetIGW.getString(30));
        allTrunkData.put("BANDWIDTH", rSetIGW.getString(31));
        allTrunkData.put("RSVP_BANDWIDTH", rSetIGW.getString(32));
        trunks.add(allTrunkData);
      }
    } catch (Exception ex) {
      ex.printStackTrace();
      logger.error("Exception in IGW t  has occurred:  " + ex);
    } finally {
      try {
      if (rSetIGW != null)
        rSetIGW.close();
      if (pstmtIGW != null)
        pstmtIGW.close();
      } catch (Exception e) {
        // ignore close error
      }
    }
    return trunks;
  }

  private String getTypeOfLink(String description_SP_link_type)
  {
    String type_of_link = "";
    
    	if(description_SP_link_type!=null&&description_SP_link_type.equals("1G")) {
              type_of_link = "GIGE";
              
    	}else if(description_SP_link_type!=null&&description_SP_link_type.equals("10G")) {
    			type_of_link = "TENG";
        }else if(description_SP_link_type!=null&&description_SP_link_type.equals("100G")) {
        	type_of_link = "100G";
        }else{
              type_of_link = "STM16";
      
    }
    return type_of_link;
  }

  private String getTrunkName(Connection con, String trunktype_name, String perouter_aEnd, String perouter_zEnd)
  {
    String trunkname = null;
    if (con != null) {
      if ("1".equals(trunktype_name)) {
        trunkname = getEthTrunkName(con, perouter_aEnd, perouter_zEnd);
      } else {
        trunkname = getSTM16Name(con, trunktype_name, perouter_aEnd, perouter_zEnd);
      }

      if (trunkname != null && trunkname.contains(Constants.TRUNK_TYPE_IPTRUNK))
      {
        // TODO the part TRUNK_TYPE_IPTRUNK is not been used
        int trunksuffix = 0;
        String trunkparts = trunkname.substring(Constants.TRUNK_TYPE_IPTRUNK.length());
        trunksuffix = Integer.parseInt(trunkparts);
        trunksuffix++;
        trunkname = Constants.TRUNK_TYPE_IPTRUNK + trunksuffix;
      } else if ("1".equals(trunktype_name)) {
        if (trunkname == null) {
          trunkname = Constants.TRUNK_TYPE_ETHTRUNK + Constants.TRUNK_TYPE_ETHTRUNK_MIN;
        }
      } else if ("2".equals(trunktype_name)) {
        if (trunkname == null) {
          trunkname = Constants.TRUNK_TYPE_STM16 + Constants.TRUNK_TYPE_STM16_MIN;
        }
      }
    }
    return trunkname;
  }
  
  private String getSTM16Name(Connection con, String trunktype_name, String perouter_aEnd, String perouter_zEnd)
  {
    PreparedStatement statePstmt = null;
    ResultSet resultSet = null;
    int trunkNumber = 0;
    try {
      if (con != null) {
        String query = null;
        query = "SELECT TRIM(REPLACE(t.NAME, 'STM16', '')) " + 
                "FROM IGW_TRUNK t  " +
                "INNER JOIN IGW_TRUNKTYPE tt " + 
                "ON t.TRUNKTYPE_ID     = tt.TRUNKTYPE_ID " + 
                "inner join igw_trunkdata d  " +
                "on t.trunk_id = d.trunk_id  " +
                "and (d.router_id = ? or d.router_id = ?) " +
                "WHERE tt.TRUNKTYPE_ID = ? " +
                "group by t.name";
        statePstmt = con.prepareStatement(query);
        statePstmt.setString(1, perouter_aEnd);
        statePstmt.setString(2, perouter_zEnd);
        statePstmt.setString(3, trunktype_name);
        resultSet = statePstmt.executeQuery();
        List<Integer> numbersList = new ArrayList<Integer>();
        while (resultSet.next())
        {
          numbersList.add(Integer.parseInt(resultSet.getString(1)));
        }
        Collections.sort(numbersList);
        Iterator<Integer> iterator = numbersList.iterator();
        int i = Integer.valueOf(Constants.TRUNK_TYPE_STM16_MIN);
        boolean assigned = false;
        while (iterator.hasNext()) {          
          if (iterator.next() != i) {
            trunkNumber = i;
            assigned = true;
            break;
          }
          i++;
        }
        if (!assigned) {
          trunkNumber = i;
        }
      }
    } catch (SQLException e)
    {
      e.printStackTrace();
    } finally
    {
      try {
        resultSet.close();
      } catch (Exception ignoreme) {
      }
      try {
        statePstmt.close();
      } catch (Exception ignoreme) {
      }
    }
    return Constants.TRUNK_TYPE_STM16 + trunkNumber;
  }
  
  private String getEthTrunkName(Connection con, String perouter_aEnd, String perouter_zEnd)
  {
    PreparedStatement statePstmt = null;
    ResultSet resultSet = null;
    int trunkNumber = 0;
    try {
      if (con != null) {
        String query = null;
        // SQL query replaces the spaces to be able to manage "Eth-Trunk N" and "Eth-TrunkN"
        query = "SELECT * " +
                "FROM " +
                "(SELECT TRIM(REPLACE(NAME, 'Eth-Trunk', '')) name " +
                "FROM cr_interface i, " +
                "cr_terminationpoint t " +
                "WHERE t.terminationpointid = i.terminationpointid " +
                "AND (t.ne_id               = ? " +
                "OR t.ne_id                 = ?) " +
                "AND t.name LIKE 'Eth-Trunk%' " +
                "AND i.parentIf IS NULL " +
                ") " +
                "GROUP BY name";
        statePstmt = con.prepareStatement(query);
        statePstmt.setString(1, perouter_aEnd);
        statePstmt.setString(2, perouter_zEnd);
        resultSet = statePstmt.executeQuery();
        List<Integer> numbersList = new ArrayList<Integer>();
        while (resultSet.next())
        {
          numbersList.add(Integer.parseInt(resultSet.getString(1)));
        }
        Collections.sort(numbersList);
        Iterator<Integer> iterator = numbersList.iterator();
        int i = Integer.valueOf(Constants.TRUNK_TYPE_ETHTRUNK_MIN);
        boolean assigned = false;
        while (iterator.hasNext()) {
          int number = iterator.next();
          if (number == 0) {
            // ignore 0 because in aggregated Trunks the value "Eth 0" is possible but in IGW not.
            continue;
          }
          if (number != i) {
            trunkNumber = i;
            assigned = true;
            break;
          }
          i++;
        }
        if (!assigned) {
          trunkNumber = i;
        }
      }
    } catch (SQLException e)
    {
      e.printStackTrace();
    } finally
    {
      try {
        resultSet.close();
      } catch (Exception ignoreme) {
      }
      try {
        statePstmt.close();
      } catch (Exception ignoreme) {
      }
    }
    return Constants.TRUNK_TYPE_ETHTRUNK + trunkNumber;
  }
  
  private List<String> getQosList(Connection con)
  {
    List<String> resultQosList = new ArrayList<String>();
    PreparedStatement statePstmt = null;
    ResultSet resultSet = null;
    String query = "select NAME from IGW_QOS";
    try
    {
      if (con != null)
      {
        statePstmt = con.prepareStatement(query);
        resultSet = statePstmt.executeQuery();
        while (resultSet.next())
        {
          resultQosList.add(resultSet.getString(1));
        }
      }
    } catch (SQLException e)
    {
      e.printStackTrace();
    } finally
    {
      try {
        resultSet.close();
      } catch (Exception ignoreme) {
      }
      try {
        statePstmt.close();
      } catch (Exception ignoreme) {
      }
    }
    return resultQosList;
  }

  public String getWildCard(String subnetmask)
  {
    String wildcard = null;
    try
    {
      String[] bits = subnetmask.split("\\.");
      for (int i = 0; i < bits.length; i++) {
        int n = Integer.parseInt(bits[i]);
        int m = 255 - n;
        if (wildcard == null)
        {
          wildcard = Integer.toString(m);
        }
        else {
          wildcard = wildcard + "." + Integer.toString(m);
        }
        //System.out.println("Wildcard is :"+wildcard);
      }
    } catch (Exception e)
    {
      e.printStackTrace();
    }
    return wildcard;
  }

  private List<String> getIPSubnetMask(Connection con, String ip)
  {
    List<String> netDetails = null;
    if (ip != null && !"".equals(ip)) {
      ip = ip.split("@")[1];
      netDetails = new ArrayList<String>();
      try
      {
        logger.error("IP is : " + ip);
        String checkclass = ip.substring(0, ip.indexOf("."));
        int cc = Integer.parseInt(checkclass);
        String mask = null;
        if (cc > 0 && cc < 224)
        {
          if (cc < 128)
          {
            mask = "255.0.0.0";
          }
          if (cc > 127 && cc < 192)
          {
            mask = "255.255.0.0";
          }
          if (cc > 191)
          {
            mask = "255.255.255.0";
          }
        }
        //System.out.println("MASK:\n"+mask);
        netDetails.add(mask);
        String networkAddr = "";
        String[] ipAddrParts = ip.split("\\.");
        String[] maskParts = mask.split("\\.");
        for (int i = 0; i < 4; i++) {
          int x = Integer.parseInt(ipAddrParts[i]);
          int y = Integer.parseInt(maskParts[i]);
          int z = x & y;
          if (i == 3)
          {
            networkAddr += z;
          }
          else {
            networkAddr += z + ".";
          }
        }
        netDetails.add(networkAddr);
        //  System.out.println("ADDRESS:\n"+networkAddr);
      } catch (Exception e) {
        e.printStackTrace();
      }
    }
    return netDetails;
  }

  private List<String> getIPNETAddr(Connection con, String poolname)
  {
    List<String> ipnetadd = new ArrayList<String>();
    if (poolname == null || "".equals(poolname)) {
      return ipnetadd;
    }
    PreparedStatement statePstmt = null;
    ResultSet resultSet = null;
    String query;
    query = "select IPNETADDR from V_IPNET where POOLNAME = ? and count__ =1";
    try
    {
      if (con != null)
      {
        statePstmt = con.prepareStatement(query);
        statePstmt.setString(1, poolname);
        resultSet = statePstmt.executeQuery();
        while (resultSet.next())
        {
          ipnetadd.add(resultSet.getString(1));
        }
      }
    } catch (SQLException e)
    {
      System.out.print("Exception is PreAddServiceAction ::getIPNETAddr method " + e);
      e.printStackTrace();
    } finally
    {
      try {
        resultSet.close();
      } catch (Exception ignoreme) {
      }
      try {
        statePstmt.close();
      } catch (Exception ignoreme) {
      }
    }
    return ipnetadd;
  }
  
  private String getSubnetmask(Connection con, String ip)
  {
    if (ip == null || "".equals(ip)) {
      return null;
    }
    String subnetmask = null;
    PreparedStatement statePstmt = null;
    ResultSet resultSet = null;
    String query;
    query = "select NETMASK from V_IPNET where IPNETADDR = ? and count__ =1";
    try
    {
      if (con != null)
      {
        statePstmt = con.prepareStatement(query);
        statePstmt.setString(1, ip);
        resultSet = statePstmt.executeQuery();
        if (resultSet.next())
        {
          subnetmask = resultSet.getString(1);
        }
      }
    } catch (SQLException e)
    {
      System.out.print("Exception is PreAddServiceAction ::getSubnetmask method " + e);
      e.printStackTrace();
    } finally
    {
      try {
        resultSet.close();
      } catch (Exception ignoreme) {
      }
      try {
        statePstmt.close();
      } catch (Exception ignoreme) {
      }
    }
    return subnetmask;
  }

  private LinkedHashMap<String, String> getTrunkType(Connection con)
  {
    LinkedHashMap<String, String> trunkList = new LinkedHashMap<String, String>();
    Statement stmnt = null;
    ResultSet resultSet = null;
    String query;
    query = "select trunktype_id, name from igw_trunktype";
    try
    {
      if (con != null)
      {
        stmnt = con.createStatement();
        resultSet = stmnt.executeQuery(query);
        while (resultSet.next())
        {
          // Added an space at the end of the name because the value in Constants has also the space and it is necessary to send the appropriate command and to generate the correct interface "Eth-Trunk number"  
          trunkList.put(resultSet.getString(1), resultSet.getString(2) + " ");
        }
      }
    } catch (SQLException e)
    {
      e.printStackTrace();
    } finally
    {
      try {
        resultSet.close();
      } catch (Exception ignoreme) {
      }
      try {
        stmnt.close();
      } catch (Exception ignoreme) {
      }
    }
    return trunkList;
  }

  private boolean locationBelongsToRegion(Connection con, String location, String region)
  {
    boolean found = false;
    PreparedStatement statePstmt = null;
    ResultSet resultSet = null;
    String query;
    query = "select name from cr_location where region = ?";
    try
    {
      if (con != null)
      {
        statePstmt = con.prepareStatement(query);
        statePstmt.setString(1, region);
        resultSet = statePstmt.executeQuery();
        while (resultSet.next())
        {
          if (location.equals(resultSet.getString(1)))
          {
            found = true;
          }
        }
      }
    } catch (SQLException e)
    {
      e.printStackTrace();
    } finally
    {
      try {
        resultSet.close();
      } catch (Exception ignoreme) {
      }
      try {
        statePstmt.close();
      } catch (Exception ignoreme) {
      }
    }
    return found;
  }

  private boolean perouterBelongsToLocation(Connection con, String perouter, String location)
  {
    boolean found = false;
    PreparedStatement statePstmt = null;
    ResultSet resultSet = null;
    String query;
    query = "select networkelementid from cr_networkelement where location = ?";
    try
    {
      if (con != null)
      {
        statePstmt = con.prepareStatement(query);
        statePstmt.setString(1, location);
        resultSet = statePstmt.executeQuery();
        while (resultSet.next())
        {
          if (perouter.equals(resultSet.getString(1)))
          {
            found = true;
          }
        }
      }
    } catch (SQLException e)
    {
      e.printStackTrace();
    } finally
    {
      try {
        resultSet.close();
      } catch (Exception ignoreme) {
      }
      try {
        statePstmt.close();
      } catch (Exception ignoreme) {
      }
    }
    return found;
  }

  private HashMap<String, String> getPEList(Connection con, String locationName, String trunktype)
  {
    HashMap<String, String> peList = new HashMap<String, String>();
    PreparedStatement statePstmt = null;
    ResultSet resultSet = null;
    String query;
    if (trunktype.equals("1"))
      query = "select networkelementid, name from cr_networkelement where location = ? and (vendor = 'Huawei')";
    else
      query = "SELECT ne.networkelementid, " +
              "ne.name " +
              "FROM cr_networkelement ne " +
              "INNER JOIN cr_elementtype e " +
              "ON (e.elementtypegroupname = 'C7600' " +
              "OR e.elementtypegroupname  = 'C12000') " +
              "WHERE e.type               = ne.elementtype " +
              "AND ne.location            = ? " +
              "AND ne.vendor              = 'Cisco' " +
              "UNION " +
              "SELECT ne.networkelementid, " +
              "ne.name " +
              "FROM cr_networkelement ne " +
              "WHERE ne.vendor = 'Huawei'";
    try
    {
      if (con != null)
      {
        statePstmt = con.prepareStatement(query);
        statePstmt.setString(1, locationName);
        resultSet = statePstmt.executeQuery();
        while (resultSet.next())
        {
          peList.put(resultSet.getString(1), resultSet.getString(2));
        }
      }
    } catch (SQLException e)
    {
      e.printStackTrace();
    } finally
    {
      try {
        resultSet.close();
      } catch (Exception ignoreme) {
      }
      try {
        statePstmt.close();
      } catch (Exception ignoreme) {
      }
    }
    return peList;
  }

  private HashMap<String, String> getIfList(Connection con, String perouter)
  {
    HashMap<String, String> ifList = new HashMap<String, String>();
    PreparedStatement statePstmt = null;
    ResultSet resultSet = null;
    String query;
    logger.debug("Perouter id is " + perouter);
    //query = "select tp.terminationpointid, tp.name from cr_terminationpoint tp, cr_interface itf where tp.terminationpointid = itf.terminationpointid and tp.ne_id=? and itf.usagestate = ? and itf.activationstate = ? and itf.type='Ethernet'";
    query = "select tp.terminationpointid, tp.name from cr_terminationpoint tp, cr_interface itf where tp.terminationpointid = itf.terminationpointid and tp.ne_id=? and itf.usagestate = ? and itf.activationstate = ? ";
    try
    {
      if (con != null)
      {
        statePstmt = con.prepareStatement(query);
        statePstmt.setString(1, perouter);
        statePstmt.setString(2, "Available");
        statePstmt.setString(3, "Ready");
        resultSet = statePstmt.executeQuery();
        while (resultSet.next())
        {
          ifList.put(resultSet.getString(1), resultSet.getString(2));
          logger.debug("has interfaces..!" + resultSet.getString(2));
        }
        logger.debug("Exiting..!");
      }
    } catch (SQLException e)
    {
      e.printStackTrace();
    } finally
    {
      try {
        resultSet.close();
      } catch (Exception ignoreme) {
      }
      try {
        statePstmt.close();
      } catch (Exception ignoreme) {
      }
    }
    return ifList;
  }
  // END TRUNK

  private HashMap<String, String> getIfListForGIS(Connection con, String perouter)
  {
    HashMap<String, String> ifList = new HashMap<String, String>();
    PreparedStatement statePstmt = null;
    ResultSet resultSet = null;
    String query;
    logger.debug("Perouter id is " + perouter);
    query = "select tp.terminationpointid, tp.name from cr_terminationpoint tp, cr_interface itf where tp.terminationpointid = itf.terminationpointid and tp.ne_id=? and itf.usagestate = ? and itf.activationstate = ?";
    try
    {
      if (con != null)
      {
        statePstmt = con.prepareStatement(query);
        statePstmt.setString(1, perouter);
        statePstmt.setString(2, "Available");
        statePstmt.setString(3, "Ready");
        resultSet = statePstmt.executeQuery();
        while (resultSet.next())
        {
          ifList.put(resultSet.getString(1), resultSet.getString(2));
          logger.debug("has interfaces..!" + resultSet.getString(2));
        }
        logger.debug("Exiting..!");
      }
    } catch (SQLException e)
    {
      e.printStackTrace();
    } finally
    {
      try {
        resultSet.close();
      } catch (Exception ignoreme) {
      }
      try {
        statePstmt.close();
      } catch (Exception ignoreme) {
      }
    }
    return ifList;
  }

  private ServiceExtBean[] getAvailableSite(Connection con, String customerid, String vpnid,String managed_CE_Router, String presnamelist) throws Exception

  {
      ArrayList<ServiceExtBean> availableSites = new ArrayList<ServiceExtBean>();
      List<ServiceExtBean> sites=getSites(con,customerid,managed_CE_Router,presnamelist);
      
      if (sites != null) {

          for (ServiceExtBean site : sites) {
              

              Set<String> vpnids = new HashSet<String>();
              vpnids=getVPNids(con, site.getService().getServiceid());
              
              

              if (vpnids.contains(vpnid)) {

                  logger.debug("Site:" + site.getService().getServiceid() + " has been in VPN:" + vpnid + ". It could not be reused!");

                  continue;

              }

              if (vpnids.size() < 1) {

                  logger.error("Site:" + site.getService().getServiceid() + " doesn't belong to any VPN. It could not be reused!");

                  continue;

              }

              if (vpnids.size() > 1) {

                  availableSites.add(site);

                  continue;

              }

              // A none-reused site:

              Service vpn = Service.findByPrimaryKey(con, (String) vpnids.toArray()[0]);

              if ("layer3-VPN".equals(vpn.getType())) {

                  availableSites.add(site);

              }

              if ("layer2-VPN".equals(vpn.getType())) {

                  ServiceParameter param = ServiceParameter.findByServiceidattribute(con, vpn.getServiceid(), "EthServiceType");

                  if (param != null && "VPLS-PortVlan".equals(param.getValue())) {

                      availableSites.add(site);

                  }

              }

              if ("layer2-VPWS".equals(vpn.getType())) {

                  ServiceParameter[] params = ServiceParameter.findByServiceid(con, vpn.getServiceid(),

                  "crm_serviceparam.value='" + site.getService().getServiceid() + "'");

                  if (params != null && params.length == 1) {

                      ServiceParameter param = null;

                      if ("Site_Service_ID_aEnd".equals(params[0].getAttribute())) {

                          param = ServiceParameter.findByServiceidattribute(con, vpn.getServiceid(), "UNIType_aEnd");

                      } else if ("Site_Service_ID_zEnd".equals(params[0].getAttribute())) {
                          param = ServiceParameter.findByServiceidattribute(con, vpn.getServiceid(), "UNIType_zEnd");
                      }

                      if (param != null && "PortVlan".equals(param.getValue())) {
                          availableSites.add(site);
                      }
                  } else if (params != null && params.length == 2) {
                      ServiceParameter param = null;
                      if ("Site_Service_ID_aEnd".equals(params[1].getAttribute())) {
                          param = ServiceParameter.findByServiceidattribute(con, vpn.getServiceid(), "UNIType_aEnd");
                      } else if ("Site_Service_ID_zEnd".equals(params[1].getAttribute())) {
                          param = ServiceParameter.findByServiceidattribute(con, vpn.getServiceid(), "UNIType_zEnd");
                      }
                      if (param != null && "PortVlan".equals(param.getValue())) {
                          availableSites.add(site);
                      }
                  }
              }
          }
      }
      
      
      ServiceExtBean[] reArray = {};      

      return availableSites.toArray(reArray);

  }
  
  private Service[] getAvailableSite(Connection con, String customerid, String vpnid) throws Exception

	{

		ArrayList<Service> availableSites = new ArrayList<Service>();
		Service[] sites = Service.findByType(con, "Site", "CRM_SERVICE.CUSTOMERID='" + customerid + "'");
		
		if (sites != null) {

			for (Service site : sites) {
				

				Set<String> vpnids = new HashSet<String>();
				vpnids=getVPNids(con, site.getServiceid());
				
				

				if (vpnids.contains(vpnid)) {

					logger.debug("Site:" + site.getServiceid() + " has been in VPN:" + vpnid + ". It could not be reused!");

					continue;

				}

				if (vpnids.size() < 1) {

					logger.error("Site:" + site.getServiceid() + " doesn't belong to any VPN. It could not be reused!");

					continue;

				}

				if (vpnids.size() > 1) {

					availableSites.add(site);

					continue;

				}

				// A none-reused site:

				Service vpn = Service.findByPrimaryKey(con, (String) vpnids.toArray()[0]);

				if ("layer3-VPN".equals(vpn.getType())) {

					availableSites.add(site);

				}

				if ("layer2-VPN".equals(vpn.getType())) {

					ServiceParameter param = ServiceParameter.findByServiceidattribute(con, vpn.getServiceid(), "EthServiceType");

					if (param != null && "VPLS-PortVlan".equals(param.getValue())) {

						availableSites.add(site);

					}

				}

				if ("layer2-VPWS".equals(vpn.getType())) {

					ServiceParameter[] params = ServiceParameter.findByServiceid(con, vpn.getServiceid(),

					"crm_serviceparam.value='" + site.getServiceid() + "'");

					if (params != null && params.length == 1) {

						ServiceParameter param = null;

						if ("Site_Service_ID_aEnd".equals(params[0].getAttribute())) {

							param = ServiceParameter.findByServiceidattribute(con, vpn.getServiceid(), "UNIType_aEnd");

						} else if ("Site_Service_ID_zEnd".equals(params[0].getAttribute())) {
							param = ServiceParameter.findByServiceidattribute(con, vpn.getServiceid(), "UNIType_zEnd");
						}

						if (param != null && "PortVlan".equals(param.getValue())) {
							availableSites.add(site);
						}
					} else if (params != null && params.length == 2) {
						ServiceParameter param = null;
						if ("Site_Service_ID_aEnd".equals(params[1].getAttribute())) {
							param = ServiceParameter.findByServiceidattribute(con, vpn.getServiceid(), "UNIType_aEnd");
						} else if ("Site_Service_ID_zEnd".equals(params[1].getAttribute())) {
							param = ServiceParameter.findByServiceidattribute(con, vpn.getServiceid(), "UNIType_zEnd");
						}
						if (param != null && "PortVlan".equals(param.getValue())) {
							availableSites.add(site);
						}
					}
				}
			}
		}

		Service[] reArray = {};
		System.out.println("AVAILABLE SITES: "+availableSites.size());

		return availableSites.toArray(reArray);

	}

	private boolean checkAttachmentState(Service[] attachs) {

		boolean unableReused = true;

		if (attachs == null || attachs.length == 0) {

			return unableReused;

		}

		for (Service attach : attachs) {

			if ("PE_Ok".equals(attach.getState()) || "Ok".equals(attach.getState()) || "PE_CE_Ok".equals(attach.getState())) {

				unableReused = false;

				break;

			}

		}

		return unableReused;

	}
	
	 
	  private Set<String> getVPNids(Connection con, String serviceid)
	  {
		
		PreparedStatement ps = null;
	    ResultSet resultSet = null;  
	    Set<String> vpnids = new HashSet<String>();
		try
		{
			
			
			String query = "SELECT  distinct   crm_vpn_membership.vpnId  FROM  crm_service   crm_service,  crm_vpn_membership   crm_vpn_membership WHERE  crm_service.parentserviceid = ? AND crm_service.state IN ('PE_Ok','Ok', 'PE_CE_Ok')  and crm_service.serviceid = crm_vpn_membership.siteattachmentid";			
			ps = con.prepareStatement(query);
	        ps.setString(1, serviceid);
			
			resultSet = ps.executeQuery();                
	         
			while(resultSet.next()) 
			{
				vpnids.add(resultSet.getString(1));
			}  			           
	         
			
		}
		catch (Exception e) 
		{
			System.out.println("Exception inside getVPNids(): "+e);
		}
		finally
		{
			try { resultSet.close(); } catch (Exception ex) { } 
			try { ps.close(); } catch (Exception ex) { } 
		}   
		
		return vpnids;
	  }
	  
	  private List<ServiceExtBean> getSites(Connection con, String customerid, String managed_CE_Router,String presnamelist)
	  {
		
		PreparedStatement ps = null;
	    ResultSet resultSet = null;  
	    List<ServiceExtBean> servicesExt=new ArrayList();	    
		try
		{
			
			
			String query = "SELECT CRM_SERVICE.SERVICEID, CRM_SERVICE.PRESNAME, CRM_SERVICE.STATE, CRM_SERVICE.SUBMITDATE, CRM_SERVICE.MODIFYDATE, CRM_SERVICE.TYPE, CRM_SERVICE.CUSTOMERID, CRM_SERVICE.PARENTSERVICEID, CRM_SERVICE.ENDTIME,"+
						" CRM_SERVICE.NEXTOPERATIONTIME, CRM_SERVICE.LASTUPDATETIME, CRM_SERVICEPARAM1.VALUE as region, CRM_SERVICEPARAM2.VALUE as location, CRM_SERVICEPARAM3.VALUE as Managed_CE_Router"+
						" FROM CRM_SERVICE CRM_SERVICE, CRM_SERVICEPARAM CRM_SERVICEPARAM1, CRM_SERVICEPARAM CRM_SERVICEPARAM2, CRM_SERVICEPARAM CRM_SERVICEPARAM3"+
						" WHERE CRM_SERVICE.CUSTOMERID= ? AND CRM_SERVICE.TYPE='Site' AND"+
						" CRM_SERVICE.SERVICEID=CRM_SERVICEPARAM1.SERVICEID AND CRM_SERVICEPARAM1.ATTRIBUTE='Region' AND"+
						" CRM_SERVICE.SERVICEID=CRM_SERVICEPARAM2.SERVICEID and CRM_SERVICEPARAM2.ATTRIBUTE='Location' AND"+
						" CRM_SERVICE.SERVICEID=CRM_SERVICEPARAM3.SERVICEID and CRM_SERVICEPARAM3.ATTRIBUTE='Managed_CE_Router'";
			ps = con.prepareStatement(query);
	        ps.setString(1, customerid);
			
			resultSet = ps.executeQuery();  
			
	         
			while(resultSet.next()) 
			{				
				Service service=new Service();
				service.setServiceid(resultSet.getString(1));
				service.setPresname(resultSet.getString(2));
				service.setState(resultSet.getString(3));
				service.setSubmitdate(resultSet.getString(4));
				service.setModifydate(resultSet.getString(5));
				service.setType(resultSet.getString(6));
				service.setCustomerid(resultSet.getString(7));
				service.setParentserviceid(resultSet.getString(8));
				service.setEndtime(resultSet.getString(9));
				service.setNextoperationtime(resultSet.getLong(10));
				service.setLastupdatetime(resultSet.getLong(11));				
				ServiceExtBean serviceExt=new ServiceExtBean();
				serviceExt.setService(service);
				serviceExt.setRegion(resultSet.getString(12));
				serviceExt.setLocation(resultSet.getString(13));
				if(managed_CE_Router!=null){
					if(presnamelist!=null && presnamelist.equals(resultSet.getString(1))){
						if(resultSet.getString(14)==null)
							serviceExt.setManaged_CE_Router(managed_CE_Router);
						else
							serviceExt.setManaged_CE_Router(resultSet.getString(14));
					}
					else
						serviceExt.setManaged_CE_Router(resultSet.getString(14));
				}
				else 
				{
					serviceExt.setManaged_CE_Router(resultSet.getString(14));
				}
				servicesExt.add(serviceExt);
				
			}  	
	         
			
		}
		catch (Exception e) 
		{
			System.out.println("Exception inside getSites(): "+e);
		}
		finally
		{
			try { resultSet.close(); } catch (Exception ex) { } 
			try { ps.close(); } catch (Exception ex) { } 
		}   
		
		return servicesExt;
	  }
	  
	  
	  private boolean isReused(Connection con)
	  {
		
		PreparedStatement ps = null;
	    ResultSet resultSet = null;  
	    boolean isReused=false;
		try
		{
			
			
			String query = "select V_CRMPortalParam.REUSESITESDEFAULT from V_CRMPortalParam where V_CRMPortalParam.idname='ISPID'";			
			ps = con.prepareStatement(query);
			
			resultSet = ps.executeQuery();                
	         
			while(resultSet.next()) 
			{
				isReused=resultSet.getBoolean(1);
			}  			           
	         
			
		}
		catch (Exception e) 
		{
			System.out.println("Exception inside getVPNids(): "+e);
		}
		finally
		{
			try { resultSet.close(); } catch (Exception ex) { } 
			try { ps.close(); } catch (Exception ex) { } 
		}   
		
		return isReused;
	  }
	  
	
	public HashMap<String, String> getPEList(Connection con, String locationName)
	{
		HashMap<String, String> peList = new HashMap<String, String>();

		PreparedStatement statePstmt = null;
		ResultSet resultSet = null;
		String query;
		
		query = "select networkelementid, name from cr_networkelement where location = ?";
		
		try 
		{
			if (con != null) 
			{
				statePstmt = con.prepareStatement(query);
				statePstmt.setString(1, locationName);
				
				resultSet = statePstmt.executeQuery();
				
				while(resultSet.next())
				{
					peList.put(resultSet.getString(1), resultSet.getString(2));
				}
			} 
		}
		catch (SQLException e) 
		{
			// Do nothing
		}
		finally
		{
			try{ resultSet.close(); }catch(Exception ignoreme){}
			try{ statePstmt.close(); }catch(Exception ignoreme){}
		}
		
		return peList;
	}
	  	  
	  

}