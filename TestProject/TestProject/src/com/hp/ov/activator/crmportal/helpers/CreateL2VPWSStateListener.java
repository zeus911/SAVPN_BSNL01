
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
import com.hp.ov.activator.crmportal.bean.Service;
import com.hp.ov.activator.crmportal.helpers.SaSyncThread;

import java.sql.Connection;

import org.apache.log4j.Logger;

public class CreateL2VPWSStateListener implements StateListener{
    Logger logger = Logger.getLogger("CRMPortalLOG");

  public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception {

    if (PortalSyncListener.DEBUG) {
      logger.debug("connection = " + connection);
      logger.debug("serviceId = " + serviceId);
      logger.debug("state = " + state);
      logger.debug("data = " + data);
    }

    if (state == null)
      return StateListener.REMOVE_AND_CONTINUE;

    if (serviceId == null)
      return StateListener.REMOVE_AND_CONTINUE;

    if (connection == null)
      return StateListener.REMOVE_AND_CONTINUE;

    if (PortalSyncListener.DEBUG) {
        logger.debug("CreateL2VPWSStateListener.proccedState: "+state);
    }
    String vpn_service_id=ServiceUtils.getServiceParam(connection, serviceId,Constants.SERVICE_PARAM_VPN_ID);
    if ( vpn_service_id == null ) {
    	throw new Exception("VPWS VPN Service ID is not found in service param table for Attachment Service ID: "+serviceId);
    }
    //For VPWS all the service parameter entries are stored against VPWS VPN service Id. 
    //So use vpn service id to fetch any service param table entry

    //Response has come for aEnd attachment, so set the same status for zEnd attachment
    String zEndAttachmentServiceID=ServiceUtils.getServiceParam(connection, vpn_service_id,Constants.SERVICE_PARAM_SITE_ATTACHMENT_ID_ZEND);
    Service zEndAttachment= Service.findByPrimaryKey(connection, zEndAttachmentServiceID);
    zEndAttachment.setState(SaSyncThread.getPENextState(state));
    ServiceUtils.updateService(connection, zEndAttachment);
    
    if(state.equals(Constants.STATE_FAILURE) ){
           
      
      //update the state of vpn id
      Service vpws=Service.findByPrimaryKey(connection, vpn_service_id);
      vpws.setState(state);
      ServiceUtils.updateService(connection, vpws);
    }
    
    if( state.equalsIgnoreCase(Constants.SERVICE_STATE_REUSE_FAILURE)){
        
        //update the state of vpn id
        Service vpws=Service.findByPrimaryKey(connection, vpn_service_id);
      //
        vpws.setState(state);
        ServiceUtils.updateService(connection, vpws);
      }
    if(state.equals(Constants.STATE_WAIT_END_TIME)){
      //set the lastcommit action to RemoveL2VPWSAttachmentListener
      ServiceUtils.saveOrUpdateParameter(connection, serviceId, Constants.PARAMETER_LAST_COMMIT, RemoveL2VPWSAttachmentListener.class.getName());
    }

    // if service failed or in some transitional state then everything ok and let's wait for our state
    if (state.indexOf("Ok") == -1 && state.indexOf("MSG_Failure") == -1)
      return StateListener.STAY_AND_CONTINUE;

    if (data == null)
      return StateListener.REMOVE_AND_CONTINUE;
 
    String values[] = data.split(",");

    String vlan_id_a = values[0];
    String vlan_id_z = values[1];

    String dlci_a = values[2];
    String dlci_z = values[3];

    ServiceParameter parameter_vlan_id_a = ServiceParameter.findByServiceidattribute(connection, vpn_service_id, "VLANIdaEnd");
    ServiceParameter parameter_vlan_id_z = ServiceParameter.findByServiceidattribute(connection, vpn_service_id, "VLANIdzEnd");

    ServiceParameter parameter_dlci_a = ServiceParameter.findByServiceidattribute(connection, vpn_service_id, "DLCIaEnd");
    ServiceParameter parameter_dlci_z = ServiceParameter.findByServiceidattribute(connection, vpn_service_id, "DLCIzEnd");
   
    if (PortalSyncListener.DEBUG) {
      logger.debug("parameters = " + parameter_vlan_id_a + "," + parameter_vlan_id_z + "," + parameter_dlci_a + "," + parameter_dlci_z);
    }

    if (parameter_vlan_id_a != null && parameter_vlan_id_a.getValue() != null && !parameter_vlan_id_a.getValue().equals("0")) {
      if (PortalSyncListener.DEBUG) {
        logger.debug("parameter_vlan_id_a.getValue() = " + parameter_vlan_id_a.getValue());
      }
      // If parameter exists, then do not update it
    } else {
      ServiceParameter serviceParameter = new ServiceParameter(vpn_service_id, "VLANIdaEnd", vlan_id_a);
      if ( parameter_vlan_id_a == null )
        serviceParameter.store(connection);
      else
        serviceParameter.update(connection);
    }

    if (parameter_vlan_id_z != null && parameter_vlan_id_z.getValue() != null && !parameter_vlan_id_z.getValue().equals("0")) {
      if (PortalSyncListener.DEBUG) {
        logger.debug("parameter_vlan_id_z.getValue() = " + parameter_vlan_id_z.getValue());
      }
      // If parameter exists, then do not update it
    } else {
      ServiceParameter serviceParameter = new ServiceParameter(vpn_service_id, "VLANIdzEnd", vlan_id_z);
      if ( parameter_vlan_id_z == null )
        serviceParameter.store(connection);
      else
        serviceParameter.update(connection);
    }

    if (parameter_dlci_a != null && parameter_dlci_a.getValue() != null && !parameter_dlci_a.getValue().equals("0")) {
      if (PortalSyncListener.DEBUG) {
        logger.debug("parameter_dlci_a.getValue() = " + parameter_dlci_a.getValue());
      }
      // If parameter exists, then do not update it
    } else {
      ServiceParameter serviceParameter = new ServiceParameter(vpn_service_id, "DLCIaEnd", dlci_a);
      if ( parameter_dlci_a == null )
        serviceParameter.store(connection);
      else
        serviceParameter.update(connection);
    }

    if (parameter_dlci_z != null && parameter_dlci_z.getValue() != null && !parameter_dlci_z.getValue().equals("0")) {
      if (PortalSyncListener.DEBUG) {
        logger.debug("parameter_dlci_z.getValue() = " + parameter_dlci_z.getValue());
      }
      // If parameter exists, then do not update it
    } else {
      ServiceParameter serviceParameter = new ServiceParameter(vpn_service_id, "DLCIzEnd", dlci_z);
      if ( parameter_dlci_z == null )
        serviceParameter.store(connection);
      else
        serviceParameter.update(connection);
    }

    return StateListener.REMOVE_AND_CONTINUE;

  }
}
