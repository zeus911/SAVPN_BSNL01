/*
 * **************************************************************************
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
 * ***********************************************************************
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
import com.hp.ov.activator.crmportal.helpers.ServiceUtils;

public class SiteSearchAction extends Action
{

  public SiteSearchAction()
  {

  }

  public ActionForward execute(ActionMapping mapping, ActionForm form,
      HttpServletRequest request, HttpServletResponse response)
      throws Exception
  {
    Logger logger = Logger.getLogger("CRMPortalLOG");
    DatabasePool dbp = null;
    Connection connection = null;
    ArrayList customersList = null;
    Customer[] customers = null;
    Customer customer = null;
    Service service = null;
    Service parentService = null;
    Service[] services = {};
    ServiceType[] serviceTypes = null;
    ArrayList<Service> list_services = new ArrayList<Service>();
    //ServiceType[] subServiceTypes = null;
    ArrayList subservTypes = new ArrayList();
    HashMap ServiceBeanMap = new HashMap();
    ArrayList pServiceIdList = new ArrayList();
    ArrayList lastModifyActionList = new ArrayList();
    ServiceParameter lastModifyAction = null;
    final String modify_partial = "Modify_Partial";

    /* *************************** */
    String curVPNId = null;
    String curVPNtype = null;
    int cnt = 0;
    HashMap<String, Object> mySites = new HashMap<String, Object>();
    ArrayList multipleMembershipslist = new ArrayList();
    int[] sitecount = new int[0];
    ServiceBean serBean = null;


    boolean treeStateChanged = false;
    String parentstate = null;
    ServiceParameter[] parameters = null;


    boolean error = false;
    boolean b = false;

    PreparedStatement pstmt = null;
    ResultSet rset = null;
    int existingServiceCount = 0;

    // Get database connection from session
    HttpSession session = request.getSession();
    dbp = (DatabasePool)session.getAttribute(Constants.DATABASE_POOL);

    HashMap service_treeStates = (HashMap)session
        .getAttribute("service_tree_states");
    if (service_treeStates == null) {
      service_treeStates = new HashMap();
    }

    if ("true".equals((String)request.getParameter("navigation"))) {
      form = (ServiceForm)session.getAttribute("SearchSiteSubmit");
    }


    // Richa

    int size = 0;
    int cpage = 1;
    int recPerPage = Constants.REC_PER_PAGE; // Just Initialization
    String strPageNo = "1";
    int totalPages = 1;
    int currentRs = 0;
    int lastRs = 0;
    int iPageNo = 1;
    int vPageNo = 1;
    String pt = (String)request.getParameter("mv");
    String strSort = request.getParameter("sort");
    if (strSort == null)
      strSort = "desc";


    String str = (String)request.getParameter("navigation");

    try {

      connection = (Connection)dbp.getConnection();
      Service sites[] = null;
      Service attachs[] = null;
      VPNMembership[] vpn = null;
      ArrayList foreignCustNameList = new ArrayList();
      Service site = null;

      // Search customer+sitename
      if (((ServiceForm)form).getCustomername() != null
          && !((ServiceForm)form).getCustomername().equals("")
          && !((ServiceForm)form).getCustomername().equals("null")) {
        if (((ServiceForm)form).getPresname() != null
            && !((ServiceForm)form).getPresname().equals("")
            && !((ServiceForm)form).getPresname().equals("null")) {
          StringBuffer addlnWhereClause = new StringBuffer();
          addlnWhereClause.append("crm_customer.companyname ='"
              + ((ServiceForm)form).getCustomername() + "'");
          customers = Customer.findAll(connection,
              addlnWhereClause.toString());

          if (customers != null) {
            customer = customers[0];
            String addlnWhere = "crm_service.presname='"
                + ((ServiceForm)form).getPresname() + "'";
            sites = Service.findByCustomerid(connection,
                customers[0].getCustomerid(), addlnWhere);
            site = sites[0];
            foreignCustNameList.add(customer.getCompanyname());
          }


        } else {
          logger.debug("SiteSearchAction >>" + "Site name is null");
          System.out.println("SiteSearchAction >>"
              + "Site name is null");
          error = true;
        }


      }

   // Search SiteID
        if (((ServiceForm)form).getServiceid() != null
            && !((ServiceForm)form).getServiceid().equals("")) {
          String parentwhereclause = "parentserviceid is null and type='Site'";
          site = Service.findByServiceid(connection,
              ((ServiceForm)form).getServiceid(),
              parentwhereclause);
          if (site != null) {
            customer = Customer.findByCustomerid(connection,
                site.getCustomerid());
            foreignCustNameList.add(customer.getCompanyname());
          }

        } else {
          logger.debug("SiteSearchAction >>"
              + "Customer name is null" + "Site name is null");
          logger.debug("SiteSearchAction >>" + "Site ID is null");
        }
        
       // List 
     
      if (site != null) {
        service = site;
        attachs = Service.findByParentserviceid(connection, site.getServiceid());
        /* test */
        if (attachs != null) {
          vpn = VPNMembership.findBySiteattachmentid(connection, attachs[0].getServiceid());
          Service serviceVpn = Service.findByServiceid(connection, vpn[0].getVpnid());

          list_services.add(serviceVpn);
          list_services.add(service);

          /*for(int j=0;j<attachs.length;j++)
              list_services.add(attachs[j]);*/

          services = new Service[list_services.size()];
          list_services.toArray(services);

          serBean = new ServiceBean(service);
          serBean.setActionsflag(new Boolean(true));
          String routingprotocol = ServiceUtils
              .getServiceParam(
                  connection,
                  service.getServiceid(),
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
              + service.getServiceid() + "_"
              + attachs[0].getServiceid();
          String treeState = (String)service_treeStates
              .get(treeStateParam);
          if (treeState == null)
            treeState = "expanded";
          if (selected_serviceid != null
              && selected_att != null) {
            if (selected_serviceid.equals(service.getServiceid())
                && selected_att
                    .equals(attachs[0].getServiceid())) {
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
          if (null != attachs[0].getState()) {
            if (!(attachs[0].equals("PE_Ok"))
                && !(attachs[0].equals("Ok"))) {
              serBean.setActionsflag(new Boolean(
                  false));
            }
          }

          parentstate = service.getState();
          
          //Child
          for(int i=0;i<attachs.length;i++){
        	  ServiceBean childBean = new ServiceBean(
                      attachs[i]);
                  childBean.setActionsflag(new Boolean(true));
                  routingprotocol = ServiceUtils.getServiceParam(
                      connection, attachs[0].getServiceid(),
                      Constants.PARAMETER_PE_CE_PROTOCOL);
                  childBean
                      .setPe_ce_routingprotocol(routingprotocol);
                  if (parentstate.indexOf("Ok") == -1) {
                    childBean
                        .setActionsflag(new Boolean(false));
                  }
                  parameters = ServiceParameter.findByServiceid(
                      connection, attachs[i].getServiceid()); // richa-
                                                              // 14548

                  serBean.addChildService(childBean);          
                  serBean.setServiceparameters(parameters);
        	  
          }
          
          

          StringBuffer VPNSite = new StringBuffer(
              serviceVpn.getServiceid() + "_" + service.getServiceid());

          String vpnSiteKey = VPNSite.toString() + "_"
              + cnt;
          ServiceBeanMap.put(vpnSiteKey, serBean);

          curVPNId = serviceVpn.getServiceid();
          curVPNtype = serviceVpn.getType();
          if (vpn.length == attachs.length) {
            ServiceBeanMap.put(curVPNId + "_AllnotinProgress",
                "Yes");
          } else {
            ServiceBeanMap.put(curVPNId + "_AllnotinProgress",
                "No");
          }

          /* Fin test*/
          //pServiceid = sites[0].getParentserviceid();//parent		

          ServiceBeanMap.put("_FirstVPNinPage",
              curVPNId);
          ServiceBeanMap.put(
              "_FirstVPNinPageType",
              curVPNtype);

        }


        //curVPNId = (String) ServiceBeanMap.get("_FirstVPNinPage");
        //curVPNtype = (String) ServiceBeanMap.get("_FirstVPNinPageType");

        for (int k = 0; k < services.length; k++)
        {
          sitecount = new int[services.length];
          String isParent = "N";
          String pServiceid = null;
          int siteCount = 0;
          String type = services[k].getType();
          ServiceType[] subServiceTypes = null;
          // PR 15068
          if ((services[k].getParentserviceid() == null)
              && ((type.equals("layer3-VPN"))
                  || (type.equals("layer2-VPWS")) || (type
                    .equals("layer2-VPN")))) {
            curVPNId = services[k].getServiceid();
            curVPNtype = services[k].getType();
            cnt = 0;
            mySites.clear();
          }
          if (type.equalsIgnoreCase("Site")
              && curVPNtype.equalsIgnoreCase("layer3-VPN")) {
            StringBuffer tmpVPNSite = new StringBuffer(curVPNId
                + "_" + services[k].getServiceid());
            String vpnSiteKey = tmpVPNSite.toString() + "_" + cnt;
            if (mySites.containsKey(vpnSiteKey)) {
              cnt++;
              vpnSiteKey = tmpVPNSite.toString() + "_" + cnt;
            }

            mySites.put(vpnSiteKey, null);

            ServiceBean tmpsiteService = (ServiceBean)ServiceBeanMap
                .get(vpnSiteKey);
            ServiceBean[] attachments = tmpsiteService
                .getChildServicesArray();

            subServiceTypes = new ServiceType[1];
            if (attachments == null)
              subServiceTypes[0] = ServiceType.findByName(connection,
                  "layer3-Attachment");
            else if (attachments.length == 1)
              subServiceTypes[0] = ServiceType.findByName(connection,
                  "layer3-Protection");
            else if (attachments.length > 1)
              subServiceTypes = null;

          } else {

            subServiceTypes = ServiceType.findByParentservtype(connection,
                services[k].getType());
          }
          subservTypes.add(subServiceTypes);
          // Find all multi VPNSites

          String whereClause2 = " crm_service.SERVICEID in (select SITEATTACHMENTID from"
              + " CRM_VPN_MEMBERSHIP A where VPNID = '"
              + services[k].getServiceid()
              + "' and 1 < "
              + "(select count(VPNID) from CRM_VPN_MEMBERSHIP where"
              + " SITEATTACHMENTID = A.SITEATTACHMENTID))";
          Service[] multipleMemberships = Service.findAll(connection,
              whereClause2);
          multipleMembershipslist.add(multipleMemberships);

          try {
            pstmt = connection
                .prepareStatement("select count(*) SiteCount from "
                    + "CRM_VPN_MEMBERSHIP where CRM_VPN_MEMBERSHIP.VPNID=?");
            pstmt.setString(1, services[k].getServiceid());
            rset = pstmt.executeQuery();

            if (rset.next()) {
              sitecount[k] = rset.getInt(1);
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

          if (services[k].getParentserviceid() != null) {
            pServiceid = services[k].getParentserviceid();
          }

          if (((services[k].getParentserviceid() != null) || (siteCount == 0))
              && !(type.equals("layer2-VPN"))) {
            // its a child rec
            isParent = "N";

            if (services[k].getParentserviceid() != null) {
              pServiceid = services[k].getParentserviceid();
            }
            if (siteCount == 0) {
              try {
                pstmt = connection
                    .prepareStatement("select VPNID from CRM_VPN_MEMBERSHIP where CRM_VPN_MEMBERSHIP.SITEATTACHMENTID=? order by VPNID "
                        + strSort);
                pstmt.setString(1, services[k].getServiceid());
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

          if (((services[k].getParentserviceid() == null) || (siteCount == 0))
              && (type.equals("layer3-VPN"))) {
            // its a l3 parent vpn without any site
            isParent = "Y";
            pServiceid = null;
          }
          if (((services[k].getParentserviceid() == null) && (siteCount == 0))
              && ((type.equals("layer2-VPWS")) || (type
                  .equals("layer2-VPN")))) {
            // its a parent vpn type other than l3vpn
            isParent = "Y";
            pServiceid = null;
          }

          // System.out.println("---------2nd----pServiceIdList now add the following id into list: "+pServiceid+"-----------------");
          pServiceIdList.add(pServiceid);

          // SERVICE STATE
          String serviceState = services[k].getState();
          lastModifyAction = ServiceParameter.findByPrimaryKey(connection,
              services[k].getServiceid()
                  + "||hidden_LastModifyAction");

          if (lastModifyAction == null) {
            if (serviceState.equals(modify_partial)) {
              lastModifyAction = ServiceParameter
                  .findByPrimaryKey(
                      connection,
                      services[k].getServiceid()
                          + "||hidden_LastModifyAction");
            }

          }

          // when its a SUBSERVICE
          if (isParent.equals("N")) {
            lastModifyAction = ServiceParameter
                .findByServiceidattribute(connection,
                    services[k].getServiceid(),
                    "hidden_LastModifyAction");
          }

          lastModifyActionList.add(lastModifyAction);

        }//END FOR SERVICES


        //service=Service.findByServiceid(connection, vpn[0].getVpnid());
        ((ServiceForm)form).setService(site);


        request.setAttribute("service_bean_map", ServiceBeanMap);
        //pServiceIdList.add(pServiceid);
        request.setAttribute("pServiceIdList", pServiceIdList);


        //??

        String serviceState = site.getState();
        lastModifyAction = ServiceParameter.findByPrimaryKey(connection,
            site.getServiceid()
                + "||hidden_LastModifyAction");

        if (lastModifyAction == null) {
          if (serviceState.equals(modify_partial)) {
            lastModifyAction = ServiceParameter
                .findByPrimaryKey(
                    connection,
                    site.getServiceid()
                        + "||hidden_LastModifyAction");
          }

        }


        lastModifyActionList.add(lastModifyAction);
        request.setAttribute("lastModifyActionList", lastModifyActionList);


        // Get the service Types
        serviceTypes = ServiceType.findAll(connection,
            "ParentServType is NULL and name not IN ('Hidden')");
        ((ServiceForm)form).setServiceTypes(serviceTypes);

      /*  String q3 = "select count(*) Count from crm_service  where crm_service.customerid='"
            + customer.getCustomerid() + "' ";

        pstmt = connection.prepareStatement(q3);

        rset = pstmt.executeQuery();

        if (rset.next()) {
          existingServiceCount = rset.getInt(1);
        }
        request.setAttribute("existingServiceCount",
            String.valueOf(existingServiceCount));*/
        //set with a unique service
        request.setAttribute("existingServiceCount","1");


        // Set the retrieved list of required Customers

        if (list_services != null) {
          int allServices = list_services.size();
          request.setAttribute("allServices", String.valueOf(allServices));

          String strRecPerPage = (String)session
              .getAttribute("recordsPerPage"); // CONFIGURED VALUE
          size = list_services.size();
          cpage = 1;
          recPerPage = Integer.parseInt(strRecPerPage);
          strPageNo = "1";
          totalPages = 1;
          currentRs = 0;
          lastRs = 0;

          iPageNo = 1;
          vPageNo = 1;

          if (size % recPerPage == 0) {
            totalPages = size / recPerPage;
          } else {
            totalPages = size / recPerPage + 1;
          }

          if (totalPages == 0) {
            totalPages = 1;
          }

          if (request.getParameter("currentPageNo") != null) {

            strPageNo = (String)request.getParameter("currentPageNo");
            iPageNo = Integer.parseInt(strPageNo);
          }

          if (request.getParameter("viewPageNo") != null) {
            vPageNo = Integer.parseInt((String)request
                .getParameter("viewPageNo"));
          } else {
            vPageNo = 1;
          }

          if ((pt == null) || (pt.equals("null"))) {
            if (size > 0) {
              cpage = 1;
              currentRs = 1;
              if (recPerPage > size) {
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

            if (request.getParameter("navigate") == null) {
              if (pt.equals("next")) { /* next page navigation */

                cpage = iPageNo + 1;
                currentRs = (cpage * recPerPage) - recPerPage + 1;
                lastRs = cpage * recPerPage;
                vPageNo = cpage;
                if (cpage == totalPages) {
                  lastRs = size;
                  vPageNo = totalPages;
                }
              }
              if (pt.equals("prev")) { /* previous page navigation */

                cpage = iPageNo - 1;
                currentRs = (cpage * recPerPage) - recPerPage + 1;
                lastRs = cpage * recPerPage;
              }
              if (pt.equals("first")) { /* first page navigation */

                cpage = 1;
                currentRs = 1;
                if (recPerPage > size) {
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

            } // end if(request.getParameter("navigate")==null)
            else { // when its a reload and not navigate

              cpage = Integer.parseInt((String)request
                  .getParameter("currentPageNo"));
              currentRs = Integer.parseInt((String)request
                  .getParameter("currentRs"));
              lastRs = Integer.parseInt((String)request
                  .getParameter("lastRs"));
              totalPages = Integer.parseInt((String)request
                  .getParameter("totalPages"));
              vPageNo = cpage;
            }
          }


          /* FORM ************************************* */
          session.setAttribute("service_tree_states", service_treeStates);
          ((ServiceForm)form).setServices(services);
          ((ServiceForm)form).setServiceid(site.getServiceid());
          ((ServiceForm)form).setCustomer(customer);
          ((ServiceForm)form).setCustomerid(customer.getCustomerid());
          ((ServiceForm)form).setSubServiceTypes(subservTypes);
          ((ServiceForm)form).setMultipleMemberships(multipleMembershipslist);
          ((ServiceForm)form).setSitecount(sitecount);
          // lastModifyActionList set here
          request.setAttribute("lastModifyActionList", lastModifyActionList);
          request.setAttribute("foreignCustNameList", foreignCustNameList);

          // SET PARENTSERVICEID'S
          request.setAttribute("pServiceIdList", pServiceIdList);


        }

        // meter esto dentro de listservice!=null puesto aqui temporal
        ((ServiceForm)form).setCustomer(customer);
      }//end site != null
      request.setAttribute("cpage", String.valueOf(cpage));
      request.setAttribute("currentRs", String.valueOf(currentRs));
      request.setAttribute("lastRs", String.valueOf(lastRs));
      request.setAttribute("totalPages", String.valueOf(totalPages));
      request.setAttribute("vPageNo", String.valueOf(vPageNo));
      request.setAttribute("recPerPage", String.valueOf(recPerPage));
      request.setAttribute("Option", "Search");
      request.setAttribute("navigation", "str");

    } catch (Exception ex) {
      error = true;
      logger.error("CustomerSearchAction class errors: ", ex);
    } finally {
      // close the connection
      dbp.releaseConnection(connection);
    }
    // Forward Action
    if (!(error)) {

      session.setAttribute("SearchSiteSubmit", (ServiceForm)form);
      //session.setAttribute("ServiceForm", (ServiceForm) form);     
      return mapping.findForward(Constants.SUCCESS);

    } else {
      session.setAttribute("SearchSiteSubmit", (ServiceForm)form);
      return mapping.findForward(Constants.FAILURE);
    }
  }// method

}
