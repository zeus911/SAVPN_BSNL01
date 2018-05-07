
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;

import java.sql.Connection;

import org.apache.log4j.Logger;

import com.hp.ov.activator.crmportal.bean.Service;
import com.hp.ov.activator.crmportal.bean.ServiceParameter;
import com.hp.ov.activator.crmportal.bean.VPNMembership;
import com.hp.ov.activator.crmportal.utils.Constants;

public class LeaveVPNStateListener implements StateListener
{
    Logger logger = Logger.getLogger("CRMPortalLOG");

  public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception {
        logger.debug("connection = " + connection);
        logger.debug("serviceId = " + serviceId);
        logger.debug("state = " + state);
        logger.debug("data = " + data);

    if (state == null)
      return StateListener.REMOVE_AND_CONTINUE;

    if (serviceId == null)
      return StateListener.REMOVE_AND_CONTINUE;

    if (connection == null)
      return StateListener.REMOVE_AND_CONTINUE;

    logger.debug("LeaveVPNStateListener.proccedState");
    // if service failed or in some transitional state then everything ok and let's wait for our state
    if (state.indexOf("Ok") == -1)
      return StateListener.STAY_AND_CONTINUE;

    ServiceParameter parameter = null;
    ServiceParameter siteIdParameter = null;

    parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, "hidden_LastModifyAction");
    siteIdParameter = ServiceParameter.findByServiceidattribute(connection, serviceId, "Site_Service_id");

    logger.debug("parameter = " + parameter);
    if (parameter == null || siteIdParameter == null)
      return StateListener.REMOVE_AND_CONTINUE;// no parameter - no problem
    logger.debug("parameter.getValue() = " + parameter.getValue());
    if (!Constants.ACTION_LEAVE_VPN.equals(parameter.getValue()))
      return StateListener.REMOVE_AND_CONTINUE;// it yet another action
    // so if action was ACTION_LEAVE VPN AND ACTION HAVE BEEN SUCCEDED REMOVE VPN MEMBERSHIP
    parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, "hidden_vpnId");
    logger.debug("parameter = " + parameter);
    String siteServiceId = (String) siteIdParameter.getValue();
    logger.debug("site service id = " + siteServiceId);
    //  modified by tanye
    //String attachmentid = ServiceUtils.getServiceParam(connection, serviceId, "hidden_attachmentid");
    //logger.debug("LeaveVPNStateListenser: attachmentid: " + attachmentid);
    Service[] attachs = Service.findByParentserviceid(connection, siteServiceId);
    for (Service attach : attachs) {
      VPNMembership membership = VPNMembership.findByVpnidsiteattachmentid(connection, parameter.getValue(), attach.getServiceid());
      if (membership != null) {
        logger.debug("membership = " + membership);
        membership.delete(connection);
      }
    }
    
    /*VPNMembership membership = new VPNMembership(parameter.getValue(), attachmentid, "");
    logger.debug("membership = " + membership);
    membership.delete(connection);*/
    return StateListener.REMOVE_AND_CONTINUE;

  }
}
