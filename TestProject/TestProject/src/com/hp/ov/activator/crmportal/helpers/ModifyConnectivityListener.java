
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;

import com.hp.ov.activator.crmportal.helpers.StateListener;
import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.bean.ServiceParameter;
import com.hp.ov.activator.crmportal.bean.VPNMembership;

import java.sql.Connection;

import org.apache.log4j.Logger;

public class ModifyConnectivityListener implements StateListener{
    Logger logger = Logger.getLogger("CRMPortalLOG");

    public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception {
    logger.debug("connection = " + connection);
      logger.debug("serviceId = " + serviceId);
      logger.debug("state = " + state);
      logger.debug("data = " + data);

      if(state == null)
        return StateListener.REMOVE_AND_CONTINUE;

      if(serviceId == null)
        return StateListener.REMOVE_AND_CONTINUE;

      if(connection == null)
        return StateListener.REMOVE_AND_CONTINUE;

      ServiceParameter parameter= null;
      parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, "hidden_LastModifyAction");
      logger.debug("parameter = " + parameter);
      if(parameter == null)
        return StateListener.REMOVE_AND_CONTINUE;// no parameter - no problem

      if(!"ModifyConnectivityType".equals(parameter.getValue()))
        return StateListener.REMOVE_AND_CONTINUE;// it yet another action

      parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, Constants.PARAMETER_MODIFIED_VPN_ID);
      logger.debug("parameter = " + parameter);
      if(parameter == null)
        return StateListener.REMOVE_AND_CONTINUE;// something wrong
      String vpnId = parameter.getValue();
      parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, Constants.PARAMETER_OLD_CONNECTIVITY);
      logger.debug("parameter = " + parameter);

      if(parameter == null)
        return StateListener.REMOVE_AND_CONTINUE;// something wrong
      
      //modified by tanye
      String attachmentid = ServiceUtils.getServiceParam(connection, serviceId, "hidden_attachmentid");
      logger.debug("ModifyConnectivityListener: attachmentid: " + attachmentid);
      
      VPNMembership membership = VPNMembership.findByVpnidsiteattachmentid(connection, vpnId, attachmentid);
      logger.debug("membership = " + membership);
      if(membership == null)
        return StateListener.REMOVE_AND_CONTINUE;// something wrong

      membership.setConnectivitytype(parameter.getValue());
      membership.update(connection);

      return StateListener.REMOVE_AND_CONTINUE;
    }
  }
