/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */
package com.hp.ov.activator.crmportal.action;

import java.sql.*;
import java.util.*;

import javax.servlet.http.*;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;
import com.hp.ov.activator.crmportal.bean.*;
import com.hp.ov.activator.crmportal.helpers.*;

public class ListServicesAction extends Action {
	public ListServicesAction() {
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Logger logger = Logger.getLogger("CRMPortalLOG");
		DatabasePool dbp = null;
		Connection con = null;
		boolean error = false;

		String customerid = ((ServiceForm) form).getCustomerid();
		String pt = (String) request.getParameter("mv");

		ArrayList v = new ArrayList();
		ArrayList subservTypes = new ArrayList();
		ArrayList foreignCustNameList = new ArrayList();
		ArrayList multipleMembershipslist = new ArrayList();
		ArrayList lastModifyActionList = new ArrayList();
		ArrayList pServiceIdList = new ArrayList();
		HashMap ServiceBeanMap = new HashMap();
		;
		ServiceParameter[] parameters = null;
		Service[] services = null;
		Service[] parentServices = null;
		String curVPNId = null;
		String curVPNtype = null;

		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt_failure = null;
		ResultSet rset = null;
		ResultSet rset1 = null;
		ResultSet rset2 = null;
		ResultSet rset3 = null;
		ResultSet RsetSite1 = null;
		int allServices = 0;
		int existingServiceCount = 0;
		int sizeParent = 0;
		int subServicesSize = 0;
		int[] parentsSubService = new int[sizeParent];
		int[] sitecount = new int[0];
		final String modify_partial = "Modify_Partial";

		ServiceParameter lastModifyAction = null;
		Customer customer = null;

		boolean treeStateChanged = false;

		HashMap worst_pe_state = new HashMap();

		int size = allServices;
		int cpage = 1;
		int recPerPage = Constants.REC_PER_PAGE; // Just Initialization
		String strPageNo = "1";
		int totalPages = 1;
		int currentRs = 0;
		int lastRs = 0;

		int iPageNo = 1;
		int vPageNo = 1;

		String strSort = request.getParameter("sort");
		if (strSort == null)
			strSort = "desc";
		// Get database connection from session
		HttpSession session = request.getSession();
		dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);

		// logger.debug("******************action class***********************");
		// logger.debug("***************************************************");

		// this hash map will hold the expnsion /colapsed states of the services
		// : now only layer 3 services
		HashMap service_treeStates = (HashMap) session
				.getAttribute("service_tree_states");
		// Now form the link appender here
		if (service_treeStates == null) {
			service_treeStates = new HashMap();
		}
		//System.out.println("Pres Name in Service Form : "+ ((ServiceForm) form).getPresNameSearch());
		String presNameSearch = (String) request.getAttribute("presName");

		if (presNameSearch == null) {
			presNameSearch = request.getParameter("presName");
			if (presNameSearch == null) {
				presNameSearch = (String) session
						.getAttribute("special_search_value");
				System.out.println("Pres Name at session : " + presNameSearch);
			} else {
				System.out.println("Pres Name at setting session : " + presNameSearch);
				session.setAttribute("special_search_value", presNameSearch);
			}
			// ((ServiceForm) form).setPresNameSearch(presNameSearch);
		}
		System.out.println("Pres Name from request get Attribute : "
				+ presNameSearch);
		// Find all top level service, that is parent services.
		try {
			con = (Connection) dbp.getConnection();
			try {

				if (customerid == null) {
					customerid = request.getParameter("customerid");
				}
				// logger.debug("customerid is = "+customerid);
				System.out
						.println("-----------------------------Search----------------------------");
				System.out.println("Check for Serch var ::" + presNameSearch);
				// Get the customer details.
				customer = Customer.findByPrimaryKey(con, customerid);
				((ServiceForm) form).setCustomer(customer);

				// logger.debug(" customer == "+customer);
				// richa for sorting

				String orderbyClause = " order by parentserviceid " + strSort;
				// richa ends for sorting
				String parentwhereclause = " parentserviceid is null and type IN ('layer3-VPN' ,'layer2-VPN' , 'layer2-VPWS','GIS-VPN')";

				parentServices =
				// Service.findByCustomerid(con, customerid, parentwhereclause);
				findByCustomerid(con, customerid, parentwhereclause, strSort);
				((ServiceForm) form).setParentServices(parentServices);

			} catch (Exception e) {
				error = true;
				logger.error("ERROR AT : parentServices " + e);
			}

			if (null == parentServices) {
				logger.error("parentServices is null");
			}
			if (parentServices != null) {
				// logger.debug("No of parentServices  == "+parentServices.length);
				// set parentservices
				String q3 = "select count(*) Count from crm_service  where crm_service.customerid='"
						+ customerid + "' ";

				pstmt3 = con.prepareStatement(q3);

				rset3 = pstmt3.executeQuery();

				if (rset3.next()) {
					existingServiceCount = rset3.getInt(1);

				}

				sizeParent = parentServices.length;
				parentsSubService = new int[sizeParent];
				int directServicesCount = 0;
				int relatedServicesCount = 0;

				allServices = sizeParent;

				for (int i = 0; i < sizeParent; i++) {
					subServicesSize = 0;
					directServicesCount = 0;
					relatedServicesCount = 0;

					try {
						/*
						 * if(!(parentServices[i].getType().equals("layer3-VPN"))
						 * ) {
						 * 
						 * String q1 = "select count(*) Count from crm_service "
						 * +
						 * "where crm_service.customerid='"+customerid+"' and "
						 * +" crm_service.PARENTSERVICEID='"+parentServices[i].
						 * getServiceid()+"'";
						 * 
						 * pstmt1 = con.prepareStatement(q1); rset1 =
						 * pstmt1.executeQuery();
						 * 
						 * if ( rset1.next() ) { directServicesCount =
						 * rset1.getInt(1); }
						 * 
						 * } //parent is L3VPN
						 * if(parentServices[i].getType().equals("layer3-VPN"))
						 * {
						 */
						String q2 = "select count(*) count from ("
								+ "select s.parentserviceid from CRM_SERVICE s, CRM_VPN_MEMBERSHIP m where "
								+ "VPNID=?"
								// PR15154
								+ " and s.serviceid=m.siteattachmentid and s.type <> 'layer3-Protection') ";

						if (presNameSearch != null) {
							System.out
									.println("------------Search request sent with search param :"
											+ presNameSearch);
							q2 = " select count(*) count from ("
									+ " select s.parentserviceid from CRM_SERVICE s, CRM_VPN_MEMBERSHIP m where "
									+ " VPNID=?"
									// PR15154
									+ " and s.serviceid=m.siteattachmentid and s.type <> 'layer3-Protection'  and upper(presname) like upper('%"
									+ presNameSearch + "%') ) ";
							System.out.println("q2 query modified: " + q2);
						}

						pstmt2 = con.prepareStatement(q2);
						pstmt2.setString(1, parentServices[i].getServiceid());
						rset2 = pstmt2.executeQuery();

						if (rset2.next()) {
							relatedServicesCount = rset2.getInt(1);
						}

						// }
					} catch (Exception ex) {
						error = true;
						logger.error("Exception has occurred:  " + ex);
					} finally {
						if (rset1 != null)
							rset1.close();
						if (rset2 != null)
							rset2.close();
						if (pstmt1 != null)
							pstmt1.close();
						if (pstmt2 != null)
							pstmt2.close();
					}

					subServicesSize = directServicesCount
							+ relatedServicesCount;
					parentsSubService[i] = subServicesSize;
					allServices = allServices + subServicesSize;

					// System.out.println("VPN " +
					// parentServices[i].getServiceid() +
					// "'s subServicesSize is " + parentsSubService[i]);
				} // end of first for loop
				/*
				 * PAGINATION LOGIC cpage = currentpage number currentRs =
				 * starting number of record pointer on the current page lastRs
				 * = last number of record pointer on the current page
				 * recPerPage = total no of records to be displayed per page
				 * vPageNo = view this page number
				 */

				String strRecPerPage = (String) session
						.getAttribute("recordsPerPage"); // CONFIGURED VALUE
				size = allServices;
				cpage = 1;
				recPerPage = Integer.parseInt(strRecPerPage);
				// chling temp test:
				// recPerPage = 9;
				strPageNo = "1";
				totalPages = 1;
				currentRs = 0;
				lastRs = 0;

				iPageNo = 1;
				vPageNo = 1;

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

					strPageNo = (String) request.getParameter("currentPageNo");
					iPageNo = Integer.parseInt(strPageNo);
				}

				if (request.getParameter("viewPageNo") != null) {
					vPageNo = Integer.parseInt((String) request
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
							cpage = Integer.parseInt((String) request.getParameter("currentPageNo"));
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

				// Richa - 11687
				String DeleteAction = (String) request
						.getAttribute("DeleteAction"); // Richa - 11687
				if (DeleteAction != null
						&& DeleteAction.equalsIgnoreCase("Delete")) {
					if (lastRs == currentRs && totalPages == 1) {
						vPageNo = 1;
						cpage = 1;
					} else if (lastRs == currentRs) {
						totalPages = totalPages - 1;
						cpage = iPageNo - 1;
						vPageNo = cpage;
		  			    currentRs = (cpage*recPerPage)-recPerPage+1;
		                lastRs = cpage*recPerPage;
					}
					/*
					 * else { if(pt.equals("next")) { cpage = cpage-1; } else
					 * if(pt.equals("prev")) { cpage = cpage+1;}
					 * 
					 * 
					 * }
					 */

				}
				// System.out.println("In Action lastRs"+lastRs + " currentRs "
				// + currentRs + " totalPages " +totalPages + " cpage "+ cpage +
				// " vPageNo "+ vPageNo );
				/** end of pagination variable **/

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
				LinkedHashSet parentsToDisplay = new LinkedHashSet();
				for (int i = 0; i < parentServices.length; i++) {
					int cnt = 0;

					curVPNId = parentServices[i].getServiceid();
					curVPNtype = parentServices[i].getType();

					/*
					 * For only the VPN's all attachments' state isn't
					 * "PE_In_Progress", then we can do the disable/enable of
					 * the VPN
					 */
					VPNMembership[] relatedMembership = null;
					relatedMembership = VPNMembership
							.findByVpnid(con, curVPNId);
					int notInProgress_attachment_num = 0;
					if (null != relatedMembership) {
						for (int mm = 0; mm < relatedMembership.length; mm++) {
							Service attachment = null;
							attachment = Service
									.findByPrimaryKey(con,
											relatedMembership[mm]
													.getSiteattachmentid());
							if (null != attachment) {
								if (!((attachment.getState())
										.equals("PE_In_Progress"))) {
									notInProgress_attachment_num++;
									if (attachment.getState().equals(
											"PE_Failure")
											|| attachment.getState().equals(
													"PE_Disabled")
											&& worst_pe_state
													.containsKey(attachment
															.getParentserviceid())
											&& worst_pe_state.get(attachment
													.getParentserviceid()) != null
											&& !worst_pe_state
													.get(attachment
															.getParentserviceid())
													.equals("PE_Failure")) {
										worst_pe_state
												.put(attachment
														.getParentserviceid(),
														attachment.getState());
									}

								}
							}
						}

						/*
						 * Set a hash table as VPNId_AllnotinProgress to store
						 * the result, "Yes" or "No".
						 */
						if (notInProgress_attachment_num == relatedMembership.length) {
							ServiceBeanMap.put(curVPNId + "_AllnotinProgress",
									"Yes");
						} else {
							ServiceBeanMap.put(curVPNId + "_AllnotinProgress",
									"No");
						}
						// logger.debug(" ListServicesAction.java defect 49: curVPNId is "+curVPNId+", relatedMembership.length is"+relatedMembership.length+", notInProgress_attachment_num is"+notInProgress_attachment_num+", "+curVPNId+"_AllnotinProgress is"+ServiceBeanMap.get(curVPNId+"_AllnotinProgress"));
					} else {
						ServiceBeanMap.put(curVPNId + "_AllnotinProgress",
								"Yes");
					}
					/* End */

					// logger.debug("parentsSubService >>"+
					// i+" ==== "+parentsSubService[i]);
					prevloc = v.size();
					// logger.debug(" prevloc == "+prevloc+", cpage ="+cpage);
					maxallowable = recPerPage - prevloc;
					prevcount = count;
					count = parentsSubService[i] + 1 + prevcount;
					int diff = currentRs - count;

					kk = cpage - 1;
					if (kk == 0) {
						// parentIndex = i;
						parentsToDisplay.add(parentServices[i]);
						ii = 1;
						maxallowable = maxallowable - 1;
						// logger.debug(" maxallowable == "+maxallowable);
						jj = maxallowable;

						if (jj > parentsSubService[i]) {
							jj = parentsSubService[i];
						}
						// logger.debug("kk is 0, jj == "+jj);
					} else {

						if (currentRs <= count) {
							ii = (kk * recPerPage);
							jj = ii + recPerPage - 1;

							if (i > 0) {
								ii = (kk * recPerPage) - prevcount;
								jj = ii + recPerPage - 1;
							}

							if (jj > parentsSubService[i]) {
								jj = parentsSubService[i];
								rem = 0;
							}
							// logger.debug("currentRs is <=count ::for i"+i);
						} else {
							ii = 0;
							jj = 0;

							// logger.debug("currentRs is > count ::for i"+i);
							// logger.debug("currentRs is = "+currentRs);
							// logger.debug("count is = "+count);
							// logger.debug("prevloc is = "+prevloc);
							if ((prevloc == 0) && (diff == 1)) {
								parentsToDisplay.add(parentServices[i]);

							}
						}
						if (((rem == 0) && (i > 0)) && (prevloc > 0)
								&& (maxallowable > 0)) {
							// logger.debug(" enter (rem==0)&&(i>0))&&(prevloc>0 ");
							diff = currentRs - prevcount;
							if ((prevloc == 1) && (diff == 1)) {
								parentsToDisplay.remove(parentServices[i - 1]);
								v.remove(prevloc - 1);
							}
							parentsToDisplay.add(parentServices[i]);
							ii = 1;
							maxallowable = maxallowable - 1;
							jj = maxallowable;
							if (jj > parentsSubService[i]) {
								jj = parentsSubService[i];
								rem = 0;
							}

						}

					}

					if (parentsToDisplay.contains(parentServices[i])) {
						v.add(parentServices[i]);
						if (1 == v.size()) {
							ServiceBeanMap.put("_FirstVPNinPage", curVPNId);
							ServiceBeanMap.put("_FirstVPNinPageType",
									curVPNtype);
						}
						currLoc = prevloc + 1;
					}

					// GET required child services that belong to this specific
					// parent service.

					/*
					 * FETCH ONLY REQUIRED SERVICES BASED ON OFFSET
					 */

					try {
						StringBuffer sql = null;
						// PR 15068
						sql = new StringBuffer(
								"select s.serviceid, s.presname, s.state, s.submitdate, s.modifydate, s.type, s.customerid, s.parentserviceid, "
										+ "s.endtime, s.nextoperationtime, s.lastupdatetime from crm_vpn_membership m, crm_service s where m.vpnid=? "
										+ "and m.siteattachmentid=s.serviceid and s.parentserviceid IN (select parentserviceid from (select * from ("
										+ "select parentserviceid, rownum rn from (select distinct(s.parentserviceid) from CRM_SERVICE s, CRM_VPN_MEMBERSHIP m "
										+ "where m.vpnid=? and s.serviceid=m.siteattachmentid order by s.parentserviceid "
										+ strSort
										+ ")) "
										+ "where rn between ? and ?"
										+ "))"
										+
										// PR15154
										" and s.serviceid=m.siteattachmentid and s.type <> 'layer3-Protection'"
										+ " order by s.parentserviceid "
										+ strSort);
						if (presNameSearch != null) {
							System.out
									.println("------------Search request sent with search param :"
											+ presNameSearch);
							sql = null;
							// sql = new StringBuffer(
							// "select s.serviceid, s.presname, s.state, s.submitdate, s.modifydate, s.type, s.customerid, s.parentserviceid, "
							// +
							// "s.endtime, s.nextoperationtime, s.lastupdatetime from crm_vpn_membership m, crm_service s where m.vpnid=? "
							// +
							// "and m.siteattachmentid=s.serviceid and s.parentserviceid IN (select parentserviceid from (select * from ("
							// +
							// "select parentserviceid, rownum rn from (select distinct(s.parentserviceid) from CRM_SERVICE s, CRM_VPN_MEMBERSHIP m "
							// +
							// "where m.vpnid=? and s.serviceid=m.siteattachmentid order by s.parentserviceid "
							// + strSort
							// + ")) "
							// + "where rn between ? and ?"
							// + "))"
							// +
							// // PR15154
							// " and s.serviceid=m.siteattachmentid and s.type <> 'layer3-Protection' and upper(presname) like upper('%"
							// + presNameSearch
							// + "%') "
							// + " order by s.parentserviceid "
							// + strSort);
							sql = new StringBuffer(
									"select s.serviceid, s.presname, s.state, s.submitdate, s.modifydate, s.type, s.customerid, s.parentserviceid, "
											+ "s.endtime, s.nextoperationtime, s.lastupdatetime from crm_vpn_membership m, crm_service s where m.vpnid=? "
											+ "and m.siteattachmentid=s.serviceid and "
											+ "s.parentserviceid IN (select parentserviceid from (select * from ("
											+ "select parentserviceid, rownum rn from (select distinct(s.parentserviceid) from CRM_SERVICE s, CRM_VPN_MEMBERSHIP m "
											+ "where m.vpnid=? and s.serviceid=m.siteattachmentid and "
											+ " upper(presname) like upper('%"
											+ presNameSearch
											+ "%')  order by s.parentserviceid "
											+ strSort
											+ ")) "
											+ "where rn between ? and ?"
											+ "))"
											+
											// PR15154
											" and s.serviceid=m.siteattachmentid and s.type <> 'layer3-Protection' "
											+ " order by s.parentserviceid "
											+ strSort);
							System.out.println(" sql modified get Sites rn: "
									+ sql);
						}
						// System.out.println("sql is "+sql+"--------------ii is: "+ii+"---------jj is:"+jj);
						pstmt = con.prepareStatement(sql.toString());
						pstmt.setString(1, curVPNId);
						pstmt.setString(2, curVPNId);
						pstmt.setString(3, String.valueOf(ii));
						pstmt.setString(4, String.valueOf(jj));

						rset = pstmt.executeQuery();

						/* PR 15068 */
						String curSiteId = null;
						String curfailureSiteId = null;
						String curSiteAttachmentId = null;
						Service SiteAttachment = null;
						StringBuffer sqlSite = null;
						StringBuffer sqlForFailureSite = null;

						PreparedStatement pstmt_Site = null;
						ResultSet RsetSite = null;

						Service Site = null;
						Service FailureSite = null;
						ServiceBean serBean = null;
						String parentstate = null;

						/* End of PR 15068 */
						while (rset.next()) {

							// System.out.println("serviceid: "+
							// rset.getString(1)+", servicename: "+
							// rset.getString(2)+", pid: "+rset.getString(8));
							// System.out.println("Got record in VPN "+curVPNId);
							if (null != rset.getString(8)) {
								if ((rset.getString(8)).equals(curSiteId)) {
									cnt++;
								}
								/* New Site */
								curSiteId = rset.getString(8);

								try
								{
									sqlSite = new StringBuffer(
											"select serviceid, presname, state, submitdate, modifydate, type, customerid, "
													+ "parentserviceid, endtime, nextoperationtime, lastupdatetime from crm_service s where s.serviceid=? order by s.serviceid asc");
									// System.out.println("111111111sqlSite "+sqlSite.toString());
									pstmt_Site = con.prepareStatement(sqlSite
											.toString());
									pstmt_Site.setString(1, curSiteId);
									RsetSite = pstmt_Site.executeQuery();
									if (RsetSite.next()) {

									Site = new Service(RsetSite.getString(1),
											RsetSite.getString(2),
											RsetSite.getString(3),
											RsetSite.getString(4),
											RsetSite.getString(5),
											RsetSite.getString(6),
											RsetSite.getString(7),
											RsetSite.getString(8),
											RsetSite.getString(9),
											RsetSite.getLong(10),
											RsetSite.getLong(11));
									v.add(Site);
									// If it's the first service in a page, we
									// should record curVPNId and pass it to
									// jsp.
									if (1 == v.size()) {
										ServiceBeanMap.put("_FirstVPNinPage",
												curVPNId);
										ServiceBeanMap.put(
												"_FirstVPNinPageType",
												curVPNtype);
										}
									}
								}
								catch (SQLException sqlex)
								{
									error = true;
									logger.error("SQLException has occurred:  " + sqlex);
								}
								finally
								{
									if (pstmt_Site != null)
										pstmt_Site.close();	
									if (RsetSite != null)
										RsetSite.close();
								}
								
								/* New siteAttachment process */
								SiteAttachment = new Service(rset.getString(1),
										rset.getString(2), rset.getString(3),
										rset.getString(4), rset.getString(5),
										rset.getString(6), rset.getString(7),
										rset.getString(8), rset.getString(9),
										rset.getLong(10), rset.getLong(11));

								serBean = new ServiceBean(Site);
								serBean.setActionsflag(new Boolean(true));
								String routingprotocol = ServiceUtils
										.getServiceParam(
												con,
												curSiteId,
												Constants.PARAMETER_PE_CE_PROTOCOL);
								if (null != routingprotocol) {
									serBean.setPe_ce_routingprotocol(routingprotocol);
								}
								String selected_serviceid = request
										.getParameter("selected_serviceid");
								String selected_att = request
										.getParameter("selected_att");
								// String treeStateParam="treestate"+curSiteId;
								String treeStateParam = "treestate_"
										+ curSiteId + "_"
										+ SiteAttachment.getServiceid();
								String treeState = (String) service_treeStates
										.get(treeStateParam);
								if (treeState == null)
									treeState = "expanded";
								if (selected_serviceid != null
										&& selected_att != null) {
									if (selected_serviceid.equals(curSiteId)
											&& selected_att
													.equals(SiteAttachment
															.getServiceid())) {
										if (!treeStateChanged)
											treeState = treeState
													.equals("collapsed") ? "expanded"
													: "collapsed";
										treeStateChanged = true;
										// logger.debug("ListServicesAction.java: selected_serviceid is "+selected_serviceid+", selected_att is "+selected_att+", treeStateParam is "+treeStateParam+", treeState is "+treeState);
									}
								}
								serBean.setTreeState(treeState);
								service_treeStates.put(treeStateParam,
										treeState);
								// logger.debug("*******ListServicesAction*******Service type is "+Site.getType());
								// if any subchilds found add it to the Hash map
								// Set the the flag for each prent and child
								// services which determines if the actions and
								// sub services needs to be set
								// first find prent has any childs whose status
								// is not Ok .
								if (null != rset.getString(8)) {
									if (!(rset.getString(8).equals("PE_Ok"))
											&& !(rset.getString(8).equals("Ok"))) {
										serBean.setActionsflag(new Boolean(
												false));
									}
								}
								parentstate = Site.getState();
								ServiceBean childBean = new ServiceBean(
										SiteAttachment);
								childBean.setActionsflag(new Boolean(true));
								routingprotocol = ServiceUtils.getServiceParam(
										con, SiteAttachment.getServiceid(),
										Constants.PARAMETER_PE_CE_PROTOCOL);
								childBean
										.setPe_ce_routingprotocol(routingprotocol);
								if (parentstate.indexOf("Ok") == -1) {
									childBean
											.setActionsflag(new Boolean(false));
								}
								/*
								 * if (parentstate.indexOf("MSG_Failure") !=
								 * -1){ childBean. childBean.setActionsflag(new
								 * Boolean(true)); }
								 * System.out.println("=====JAVA====ID====="
								 * +SiteAttachment.getServiceid());
								 */
								parameters = ServiceParameter.findByServiceid(
										con, SiteAttachment.getServiceid()); // richa-
																				// 14548

								serBean.addChildService(childBean);
								serBean.setServiceparameters(parameters); // richa-
																			// 14548
								// logger.debug("*******ListServicesAction*******Found one Sub service for the service"+serBean.getServiceid()+
								// "Addin it to the hash map"+childBean);
								// adding the attachments as childs of Sites

								// }else if
								// ((rset.getString(8)).equals(curSiteId)) {

								String sql1 = "select s.serviceid, s.presname, s.state, s.submitdate, s.modifydate, s.type, s.customerid, s.parentserviceid, "
										+ "s.endtime, s.nextoperationtime, s.lastupdatetime from crm_vpn_membership m, crm_service s, crm_serviceparam p where m.vpnid=? "
										+ "and m.siteattachmentid=s.serviceid and s.parentserviceid IN (select parentserviceid from (select * from ("
										+ "select parentserviceid, rownum rn from (select s.parentserviceid from CRM_SERVICE s, CRM_VPN_MEMBERSHIP m "
										+ "where m.vpnid=? and s.serviceid=m.siteattachmentid order by s.parentserviceid desc))))"
										+ "and p.serviceid=s.serviceid and p.attribute='attachmentid' and p.value=?";

								PreparedStatement pstmt_protection = null;
								ResultSet RsetProtection = null;
								
								try
								{
									pstmt_protection = con.prepareStatement(sql1);
									pstmt_protection.setString(1, curVPNId);
									pstmt_protection.setString(2, curVPNId);
									pstmt_protection.setString(3,
											SiteAttachment.getServiceid());
									RsetProtection = pstmt_protection
											.executeQuery();
									if (RsetProtection.next()) {
										/* L3-Site Protection process */
										Service ProtectionAttachment = new Service(
												RsetProtection.getString(1),
												RsetProtection.getString(2),
												RsetProtection.getString(3),
												RsetProtection.getString(4),
												RsetProtection.getString(5),
												RsetProtection.getString(6),
												RsetProtection.getString(7),
												RsetProtection.getString(8),
												RsetProtection.getString(9),
												RsetProtection.getLong(10),
												RsetProtection.getLong(11));
										ServiceBean childBean1 = new ServiceBean(
												ProtectionAttachment);
										childBean1
												.setActionsflag(new Boolean(true));
										String routingprotocol1 = ServiceUtils
												.getServiceParam(
														con,
														ProtectionAttachment
																.getServiceid(),
														Constants.PARAMETER_PE_CE_PROTOCOL);
										childBean1
												.setPe_ce_routingprotocol(routingprotocol1);
										if (parentstate.indexOf("Ok") == -1) {
											childBean1.setActionsflag(new Boolean(
													false));
										}
										parameters = ServiceParameter
												.findByServiceid(con,
														ProtectionAttachment
																.getServiceid()); // richa-
																					// 14548
										serBean.addChildService(childBean1);
										serBean.setServiceparameters(parameters); // richa-
																					// 14548
									}
								}
								catch (SQLException sqlex)
								{
									error = true;
									logger.error("SQLException has occurred:  " + sqlex);
								}
								finally
								{
									if (pstmt_protection != null)
										pstmt_protection.close();		
									if (RsetProtection != null)
										RsetProtection.close();	
								}
								
								// ServiceBean[] tmp =
								// serBean.getChildServicesArray();
								// for(int ijk=0;ijk<tmp.length;ijk++){
								// logger.debug("VPN_"+curVPNId+" Site "+curSiteId+"'s serBean_child["+ijk+"]'s serviceid is:"+tmp[ijk].getServiceid()+", sername is:"+tmp[ijk].getPresname()+", protocol is "+tmp[ijk].getPe_ce_routingprotocol());
								// }
								StringBuffer VPNSite = new StringBuffer(
										curVPNId + "_" + curSiteId);

								String vpnSiteKey = VPNSite.toString() + "_"
										+ cnt;
								ServiceBeanMap.put(vpnSiteKey, serBean);

								// ServiceBeanMap.put(curSiteId, serBean);

							}
						}

						// start-PR 18384 - Failure site display logic,if the
						// sites doesn't have any attachment and it is in
						// failure state then we are fetching those sites and
						// displaying.

						String sql2 = "select a.serviceid, a.presname, a.state, a.submitdate, a.modifydate, a.type, a.customerid, "
								+ "a.parentserviceid, a.endtime, a.nextoperationtime, a.lastupdatetime from crm_service a, crm_serviceparam p"
								+ " where a.serviceid = p.serviceid and a.type='Site' and a.state ='Failure' and p.value = ? and a.serviceid not in (select parentserviceid from crm_service b where b.type like '%Attachment%')";

						pstmt_failure = con.prepareStatement(sql2);
						pstmt_failure.setString(1, curVPNId);
						RsetSite1 = pstmt_failure.executeQuery();

						while (RsetSite1.next()) {
							curfailureSiteId = RsetSite1.getString(1);

							FailureSite = new Service(RsetSite1.getString(1),
									RsetSite1.getString(2),
									RsetSite1.getString(3),
									RsetSite1.getString(4),
									RsetSite1.getString(5),
									RsetSite1.getString(6),
									RsetSite1.getString(7),
									RsetSite1.getString(8),
									RsetSite1.getString(9),
									RsetSite1.getLong(10),
									RsetSite1.getLong(11));
							v.add(FailureSite);
							//If it's the first service in a page, we should record curVPNId and pass it to jsp.
							if (1 == v.size()) {
								ServiceBeanMap.put("_FirstVPNinPage",curVPNId);
								ServiceBeanMap.put("_FirstVPNinPageType", curVPNtype);
							}

							if (FailureSite != null) {
								serBean = new ServiceBean(FailureSite);
							}
							serBean.setActionsflag(new Boolean(true));
							String routingprotocol = ServiceUtils
									.getServiceParam(con, curfailureSiteId,
											Constants.PARAMETER_PE_CE_PROTOCOL);
							if (null != routingprotocol) {
								serBean.setPe_ce_routingprotocol(routingprotocol);
							}

							parameters = ServiceParameter.findByServiceid(con,
									curfailureSiteId);
							serBean.setServiceparameters(parameters);

							StringBuffer VPNFailureSite = new StringBuffer(
									curVPNId + "_" + curfailureSiteId);
							String vpnFailSiteKey = VPNFailureSite.toString()
									+ "_" + cnt;
							ServiceBeanMap.put(vpnFailSiteKey, serBean);

						}

						// End

					} catch (Exception ex) {
						error = true;
						logger.error("Exception 20090203  has occurred:  " + ex);
					} finally {
						if (rset != null)
							rset.close();
						if (pstmt != null)
							pstmt.close();
						if (RsetSite1 != null)
							RsetSite1.close();
						if (pstmt_failure != null)
							pstmt_failure.close();
					}

					currLoc = v.size();
					if (currLoc == recPerPage)
						break;

				} // for
				request.setAttribute("worst_state_map", worst_pe_state);

				/*
				 * FORM SERVICES
				 */
				services = new Service[v.size()];
				v.toArray(services);
				// System.out.println("-----------ListSAction.java----------");
				// for (int iii=0;iii<services.length;iii++){
				// System.out.println("====Services["+iii+"]: id_"+services[iii].getServiceid()+" type_"+services[iii].getType()+" name_"+services[iii].getPresname());
				// }
			} // if
			/*
			 * logger.debug(" TOTAL services == "+services.length); for (int
			 * iii=0;iii<services.length;iii++){
			 * logger.debug("Services["+iii+"]: id_"
			 * +services[iii].getServiceid()
			 * +" type_"+services[iii].getType()+" name_"
			 * +services[iii].getPresname()); }
			 * logger.debug("ServiceBeanmap is "); logger.debug(ServiceBeanMap);
			 */
			// set services to be displayed
			((ServiceForm) form).setServices(services);

			// getting the childs of the subservices
			// layer-site has child attachments

			session.setAttribute("service_tree_states", service_treeStates);
			request.setAttribute("service_bean_map", ServiceBeanMap);
			request.setAttribute("allServices", String.valueOf(allServices));
			request.setAttribute("existingServiceCount",
					String.valueOf(existingServiceCount));
			request.setAttribute("cpage", String.valueOf(cpage));
			request.setAttribute("currentRs", String.valueOf(currentRs));
			request.setAttribute("lastRs", String.valueOf(lastRs));
			request.setAttribute("totalPages", String.valueOf(totalPages));
			request.setAttribute("vPageNo", String.valueOf(vPageNo));
			request.setAttribute("sort", strSort);
			request.setAttribute("sort", strSort);
			request.setAttribute("presName", presNameSearch);
			// Get the service Types
			ServiceType[] serviceTypes = null;
			serviceTypes = ServiceType.findAll(con,
					"ParentServType is NULL and name not IN ('Hidden')");
			((ServiceForm) form).setServiceTypes(serviceTypes);

			// loop services
			if ((services == null) || (services.length == 0)) {
				subservTypes = null;
			} else {
				sitecount = new int[services.length];
				int end = services.length - 1;

				curVPNId = (String) ServiceBeanMap.get("_FirstVPNinPage");
				curVPNtype = (String) ServiceBeanMap.get("_FirstVPNinPageType");

				HashMap<String, Object> mySites = new HashMap<String, Object>();
				int cnt = 0;
				for (int i = 0; i <= end; i++)

				{

					String isParent = "N";
					String pServiceid = null;
					int siteCount = 0;
					String type = services[i].getType();
					ServiceType[] subServiceTypes = null;
					// PR 15068
					if ((services[i].getParentserviceid() == null)
							&& ((type.equals("layer3-VPN"))||(type.equals("GIS-VPN"))
									|| (type.equals("layer2-VPWS")) || (type
										.equals("layer2-VPN")))) {
						curVPNId = services[i].getServiceid();
						curVPNtype = services[i].getType();
						cnt = 0;
						mySites.clear();
					}
					if (type.equalsIgnoreCase("Site")
							&& curVPNtype.equalsIgnoreCase("layer3-VPN")) {
						StringBuffer tmpVPNSite = new StringBuffer(curVPNId
								+ "_" + services[i].getServiceid());
						String vpnSiteKey = tmpVPNSite.toString() + "_" + cnt;
						if (mySites.containsKey(vpnSiteKey)) {
							cnt++;
							vpnSiteKey = tmpVPNSite.toString() + "_" + cnt;
						}

						mySites.put(vpnSiteKey, null);

						ServiceBean tmpsiteService = (ServiceBean) ServiceBeanMap
								.get(vpnSiteKey);
						ServiceBean[] attachments = tmpsiteService
								.getChildServicesArray();
						// logger.debug("List.java subservices: tmpVPNSite is "+tmpVPNSite.toString()+", attachments.length is "+attachments.length);
						// if(type.equalsIgnoreCase("layer3-Site")){
						// Service
						// attachments[]=Service.findByParentserviceid(con,services[i].getServiceid());
						// End of PR 15068

						subServiceTypes = new ServiceType[1];
						if (attachments == null)
							subServiceTypes[0] = ServiceType.findByName(con,
									"layer3-Attachment");
						else if (attachments.length == 1)
							subServiceTypes[0] = ServiceType.findByName(con,
									"layer3-Protection");
						else if (attachments.length > 1)
							subServiceTypes = null;

					} 
				// Added for GIS 
					
					else if (type.equalsIgnoreCase("Site")
							&& curVPNtype.equalsIgnoreCase("GIS-VPN")) {
						StringBuffer tmpVPNSite = new StringBuffer(curVPNId
								+ "_" + services[i].getServiceid());
						String vpnSiteKey = tmpVPNSite.toString() + "_" + cnt;
						if (mySites.containsKey(vpnSiteKey)) {
							cnt++;
							vpnSiteKey = tmpVPNSite.toString() + "_" + cnt;
						}

						mySites.put(vpnSiteKey, null);

						ServiceBean tmpsiteService = (ServiceBean) ServiceBeanMap
								.get(vpnSiteKey);
						ServiceBean[] attachments = tmpsiteService
								.getChildServicesArray();
						// logger.debug("List.java subservices: tmpVPNSite is "+tmpVPNSite.toString()+", attachments.length is "+attachments.length);
						// if(type.equalsIgnoreCase("layer3-Site")){
						// Service
						// attachments[]=Service.findByParentserviceid(con,services[i].getServiceid());
						// End of PR 15068

						subServiceTypes = new ServiceType[1];
						if (attachments == null)
							subServiceTypes[0] = ServiceType.findByName(con,
									"GIS-Attachment");
						else if (attachments.length == 1)
							subServiceTypes[0] = ServiceType.findByName(con,
									"GIS-Protection");
						else if (attachments.length > 1)
							subServiceTypes = null;

					} 			
					
					else {

						subServiceTypes = ServiceType.findByParentservtype(con,
								services[i].getType());
					}

					subservTypes.add(subServiceTypes);

					// get foreign cust name here
					String foreignCustomerId = services[i].getCustomerid()
							.equals(customerid) ? null : services[i]
							.getCustomerid();
					String foreignCustomerName = getCustomerName(con,
							foreignCustomerId);
					foreignCustNameList.add(foreignCustomerName);
					// Find all multi VPNSites

					String whereClause2 = " crm_service.SERVICEID in (select SITEATTACHMENTID from"
							+ " CRM_VPN_MEMBERSHIP A where VPNID = '"
							+ services[i].getServiceid()
							+ "' and 1 < "
							+ "(select count(VPNID) from CRM_VPN_MEMBERSHIP where"
							+ " SITEATTACHMENTID = A.SITEATTACHMENTID))";
					Service[] multipleMemberships = Service.findAll(con,
							whereClause2);
					multipleMembershipslist.add(multipleMemberships);

					try {
						pstmt = con
								.prepareStatement("select count(*) SiteCount from "
										+ "CRM_VPN_MEMBERSHIP where CRM_VPN_MEMBERSHIP.VPNID=?");
						pstmt.setString(1, services[i].getServiceid());
						rset = pstmt.executeQuery();

						if (rset.next()) {
							sitecount[i] = rset.getInt(1);
							siteCount = rset.getInt(1);
						}

					} catch (Exception ex) {
						error = true;
						logger.error("Exception has occurred:  " + ex);
					} finally {
						if (rset != null)
							rset.close();
						if (pstmt != null)
							pstmt.close();
					}

					if (services[i].getParentserviceid() != null) {
						pServiceid = services[i].getParentserviceid();
					}

					if (((services[i].getParentserviceid() != null) || (siteCount == 0))
							&& !(type.equals("layer2-VPN"))) {
						// its a child rec
						isParent = "N";

						if (services[i].getParentserviceid() != null) {
							pServiceid = services[i].getParentserviceid();
						}
						if (siteCount == 0) {
							try {
								pstmt = con
										.prepareStatement("select VPNID from CRM_VPN_MEMBERSHIP where CRM_VPN_MEMBERSHIP.SITEATTACHMENTID=? order by VPNID "
												+ strSort);
								pstmt.setString(1, services[i].getServiceid());
								rset = pstmt.executeQuery();

								if (rset.next()) {
									if (pServiceid == null) {
										pServiceid = rset.getString(1);
									}
									// System.out.println("-------------1st pServiceIdList now add the following id into list: "+pServiceid+"-----------------");
								}

							} catch (Exception ex) {
								ex.printStackTrace();
								logger.error("Exception has occurred:  " + ex);
							} finally {
								if (rset != null)
									rset.close();
								if (pstmt != null)
									pstmt.close();
							}
						}

					}

					if (((services[i].getParentserviceid() == null) || (siteCount == 0))
							&& (type.equals("layer3-VPN")||type.equals("GIS-VPN"))) {
						// its a l3 parent vpn without any site
						isParent = "Y";
						pServiceid = null;
					}
					if (((services[i].getParentserviceid() == null) && (siteCount == 0))
							&& ((type.equals("layer2-VPWS")) || (type
									.equals("layer2-VPN")))) {
						// its a parent vpn type other than l3vpn
						isParent = "Y";
						pServiceid = null;
					}

					// System.out.println("---------2nd----pServiceIdList now add the following id into list: "+pServiceid+"-----------------");
					pServiceIdList.add(pServiceid);

					// SERVICE STATE
					String serviceState = services[i].getState();
					lastModifyAction = ServiceParameter.findByPrimaryKey(con,
							services[i].getServiceid()
									+ "||hidden_LastModifyAction");

					if (lastModifyAction == null) {
						if (serviceState.equals(modify_partial)) {
							lastModifyAction = ServiceParameter
									.findByPrimaryKey(
											con,
											services[i].getServiceid()
													+ "||hidden_LastModifyAction");
						}

					}

					// when its a SUBSERVICE
					if (isParent.equals("N")) {
						lastModifyAction = ServiceParameter
								.findByServiceidattribute(con,
										services[i].getServiceid(),
										"hidden_LastModifyAction");
					}

					lastModifyActionList.add(lastModifyAction);

				}// FOR
			}// ELSE
			/*
			 * for (int z=0;z<subservTypes.size();z++) { ServiceType[]
			 * tsubServiceTypes = (ServiceType[])subservTypes.get(z); if
			 * (tsubServiceTypes != null) { for (int zz=0;
			 * zz<tsubServiceTypes.length; zz++) {
			 * logger.debug("ListServicesAction.java: service["
			 * +z+"]'s subservTypes["
			 * +zz+"] is "+tsubServiceTypes[zz].getName()); } } }
			 */

			// PR 18283
			// iterate through the services array set to
			// ((ServiceForm)form).setServices(services)
			// for services of type VPWS, check if the aEnd and zEnd attachment
			// is is OK state, only then set the
			// state for vpws to OK, else set to In Progress. This will ensure
			// that no actions are displayed till the aEnd and zEnd
			// reaches OK state
			if (services != null) {
				services = modifyStateForVPWSVPN(services, con);
			}
			((ServiceForm) form).setServices(services);

			// set all subservicetypes for the services
			((ServiceForm) form).setSubServiceTypes(subservTypes);
			// multipleMemberships set here
			((ServiceForm) form)
					.setMultipleMemberships(multipleMembershipslist);
			// set sitecounts here
			((ServiceForm) form).setSitecount(sitecount);
			// foreign cust name set here
			request.setAttribute("foreignCustNameList", foreignCustNameList);
			// lastModifyActionList set here
			request.setAttribute("lastModifyActionList", lastModifyActionList);

			// SET PARENTSERVICEID'S
			request.setAttribute("pServiceIdList", pServiceIdList);

		} catch (Exception excep) {
			excep.printStackTrace();
			logger.error("Exception in List Services Action" + excep);
			error = true;
		} finally {
			if (rset3 != null)
				rset3.close();
			if (pstmt3 != null)
				pstmt3.close();
			// close the connection
			dbp.releaseConnection(con);
		}

		// Forward Action
		if (!(error)) {
			// set values to actionform obj && Transfer to the jsp

			return mapping.findForward(Constants.SUCCESS);

		} else {

			return mapping.findForward(Constants.FAILURE);
		}

	}

	/**
	 * Method to modify the state of L2VPWS VPN to In_Progress, if the aEnd and
	 * zEnd attachments are still in the process of being created or modified or
	 * disabled. Invoked from execute()
	 * 
	 * @param services
	 * @param con
	 * @return modified Service[] where only the L2VPWS VPN service objects are
	 *         modified
	 * @throws Exception
	 */
	public Service[] modifyStateForVPWSVPN(Service[] services, Connection con)
			throws Exception {
		Service service = null;

		for (int i = 0; i < services.length; i++) {
			service = services[i];

			if (service != null) {

				if (service.getType().equals(Constants.TYPE_LAYER2_VPWS)
						&& (!service.getState().equals(
								Constants.SERVICE_STATE_FAILURE))) {

					String aEndSiteServiceID = ServiceUtils.getServiceParam(
							con, service.getServiceid(),
							Constants.SERVICE_PARAM_SITE_SERVICE_ID_AEND);
					String zEndSiteServiceID = ServiceUtils.getServiceParam(
							con, service.getServiceid(),
							Constants.SERVICE_PARAM_SITE_SERVICE_ID_ZEND);
					Service aEndSiteService = Service.findByServiceid(con,
							aEndSiteServiceID);
					Service zEndSiteService = Service.findByServiceid(con,
							zEndSiteServiceID);

					String aEndSiteServiceState = null;
					if (aEndSiteService != null) {
						aEndSiteServiceState = aEndSiteService.getState();
					}

					String zEndSiteServiceState = null;
					if (zEndSiteService != null) {
						zEndSiteServiceState = zEndSiteService.getState();
					}
					
					if (aEndSiteServiceState != null && zEndSiteServiceState != null){
						if ((!aEndSiteServiceState
								.equals(Constants.SERVICE_STATE_FAILURE))
								&& (!zEndSiteServiceState
										.equals(Constants.SERVICE_STATE_FAILURE))) {
							
							// get the service params Site_Attachment_ID_aEnd &
							// Site_Attachment_ID_zEnd for this service id
							String aEndServiceID = ServiceUtils
									.getServiceParam(
											con,
											service.getServiceid(),
											Constants.SERVICE_PARAM_SITE_ATTACHMENT_ID_AEND);
							String zEndServiceID = ServiceUtils
									.getServiceParam(
											con,
											service.getServiceid(),
											Constants.SERVICE_PARAM_SITE_ATTACHMENT_ID_ZEND);
							// get the state for aEnd and zEnd services
							Service aEndService = Service.findByServiceid(con,
									aEndServiceID);
							Service zEndService = Service.findByServiceid(con,
									zEndServiceID);
							if (aEndService != null && zEndService != null) {
								String aEndServiceState = aEndService.getState();
								String zEndServiceState = zEndService.getState();
								ArrayList states = new ArrayList();
								states.add("PE_" + Constants.STATE_REQUEST_SENT);
								states.add("PE_In_Progress");
								states.add("PE_Waiting_Operator");
								states.add("Sched_Request_Sent");
								states.add("PE_Wait_Start_Time");
								states.add("PE_Wait_End_Time");
								states.add("Sched_Delete_Confirm");
								states.add("Sched_Delete_Confirm");
								states.add("Delete_In_Progress");
								if (states.contains(aEndServiceState)
										&& states.contains(zEndServiceState)) {
									service.setState("In_Progress");
								}
							}
						} else {
							service.setState("Failure");
						}
					}
				}
			}

		}
		return services;
	}

	// get cust name
	final static String getCustomerName(Connection connection, String id) {
		if (id == null)
			return id;
		final Customer customer;
		try {
			customer = Customer.findByCustomerid(connection, id);
			if (customer == null)
				return null;
			return customer.getCompanyname();
		} catch (SQLException e) {

			return null;
		}
	}

	public static Service[] findByCustomerid(Connection con, String CustomerId,
			String addlnWhereClause, String sort) throws SQLException {
		PreparedStatement pstmt = null;
		Logger logger = Logger.getLogger("CRMPortalLOG");
		try {
			StringBuffer sql = new StringBuffer();
			// sql.append("select count(*) from  crm_service");
			sql.append("select  " + "crm_service" + ".ServiceId" + ", "
					+ "crm_service" + ".PresName" + ", " + "crm_service"
					+ ".State" + ", " + "crm_service" + ".SubmitDate" + ", "
					+ "crm_service" + ".ModifyDate" + ", " + "crm_service"
					+ ".Type" + ", " + "crm_service" + ".CustomerId" + ", "
					+ "crm_service" + ".ParentServiceId" + ", " + "crm_service"
					+ ".EndTime" + ", " + "crm_service" + ".NextOperationTime"
					+ ", " + "crm_service"
					+ ".LastUpdateTime  FROM crm_service");

			sql.append(" where ");
			sql.append("crm_service" + ".CustomerId=?");
			boolean bHasForUpdate = false;
			String strForUpdate = "";
			String newWhereClause;
			// if a where clause were passed in
			if (addlnWhereClause != null) {
				int iOuterFromIndex = sql.toString().toUpperCase()
						.indexOf("FROM");
				int iOuterWhereIndex = sql.toString().toUpperCase()
						.indexOf("WHERE");
				int iForUpdateIndex = addlnWhereClause.toString().toUpperCase()
						.indexOf("FOR UPDATE");
				if (iForUpdateIndex != -1) {
					bHasForUpdate = true;
					strForUpdate = addlnWhereClause.substring(iForUpdateIndex);
					String tableName = "crm_service";
					String innerSelect = " select " + tableName.trim()
							+ ".rowid row__id ";
					innerSelect += sql.substring(iOuterFromIndex,
							(iOuterWhereIndex == -1) ? sql.length()
									: iOuterWhereIndex);
					innerSelect += " where ";
					if (iOuterWhereIndex != -1) {
						innerSelect += sql.substring(iOuterWhereIndex + 5);
						innerSelect += " and ";
					}
					innerSelect += addlnWhereClause.substring(0,
							iForUpdateIndex);
					innerSelect = " select row__id from ( " + innerSelect
							+ ") where rownum = 1 ";
					newWhereClause = tableName.trim() + ".rowid in ("
							+ innerSelect + ") ";
				} else {
					newWhereClause = addlnWhereClause;
				}
				if (iOuterWhereIndex == -1) {
					sql.append(" where ");
				} else {
					if (!sql.substring(iOuterWhereIndex + 5, sql.length())
							.trim().equals("")) {
						sql.append(" and ");
					}
				}
				sql.append(" " + newWhereClause + " ");
			}
			if (bHasForUpdate) {
				sql.append(" " + strForUpdate + " ");
			}
			if (!bHasForUpdate) {
				sql.append(" " + " order by " + "crm_service" + ".serviceid "
						+ sort);
			}

			//
			pstmt = con.prepareStatement(sql.toString());
			if (CustomerId == null) {
				pstmt.setNull(1, Types.VARCHAR);
			} else {
				pstmt.setString(1, CustomerId);
			}
			if (bHasForUpdate) {
				if (CustomerId == null) {
					pstmt.setNull(2, Types.VARCHAR);
				} else {
					pstmt.setString(2, CustomerId);
				}
			}
			Service[] resultArray = execFindBy(pstmt);

			return resultArray;
		} finally {
			if (pstmt != null) {
				pstmt.close();
			}
		}
	}

	protected static Service[] execFindBy(PreparedStatement pstmt)
			throws SQLException {
		ResultSet rset = null;
		Logger logger = Logger.getLogger("CRMPortalLOG");

		try {
			rset = pstmt.executeQuery();

			LinkedHashMap l_hm = new LinkedHashMap();
			while (rset.next()) {
				// here we gather the result set
				// myVector v = new myVector();
				String var0 = rset.getString(1);
				String var1 = rset.getString(2);
				String var2 = rset.getString(3);
				String var3 = rset.getString(4);
				String var4 = rset.getString(5);
				String var5 = rset.getString(6);
				String var6 = rset.getString(7);
				String var7 = rset.getString(8);
				String var8 = rset.getString(9);
				long var9 = rset.getLong(10);
				// check if the field is null in oracle
				if (rset.wasNull()) {
					var9 = Long.MIN_VALUE;
				}
				long var10 = rset.getLong(11);
				// check if the field is null in oracle
				if (rset.wasNull()) {
					var10 = Long.MIN_VALUE;
				}
				Service bean = new Service(var0, var1, var2, var3, var4, var5,
						var6, var7, var8, var9, var10);
				l_hm.put(var0, bean);
			}
			Service[] resultArray = new Service[l_hm.size()];
			Collection col = (Collection) l_hm.values();
			col.toArray(resultArray);

			return resultArray;

		} catch (Exception e) {
			logger.debug("Exception here");
		} finally {
			if (rset != null) {
				rset.close();
			}
		}
		return null;
	}
}
