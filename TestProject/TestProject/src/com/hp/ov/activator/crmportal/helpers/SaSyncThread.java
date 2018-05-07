
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
 *
 ************************************************************************
 */
package com.hp.ov.activator.crmportal.helpers;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import org.apache.log4j.Logger;
import com.hp.ov.activator.crmportal.bean.Message;
import com.hp.ov.activator.crmportal.bean.Service;
import com.hp.ov.activator.crmportal.bean.ServiceParameter;
import com.hp.ov.activator.crmportal.bean.StateMapping;

import com.hp.ov.activator.crmportal.bean.VPNMembership;
import com.hp.ov.activator.crmportal.utils.Constants;

public class SaSyncThread implements Runnable {
	//  private String serviceId;
	private final ArrayList messages = new ArrayList();
	private boolean running = false;
	private Logger logger = Logger.getLogger("CRMPortalLOG");
	Connection connection = null;
	public SaSyncThread(Connection con)
	{
		this.connection =  con;
	}
	public void run() {
		Message message;
		while (running) {
			// if no more messages in queue then just stop the thread
			synchronized (messages) {
				if (messages.size() == 0) {
					running = false;
					return;
				}else{
					message = (Message) messages.remove(0);
				}
			}
			try {
				connection = PortalSyncListener.dbp.getConnection();
				if (PortalSyncListener.DEBUG) {
					logger.debug("SaSyncThread RUN ("+message.getMessageid()+")GOT connection = " + connection);
				}
				logger.debug(message.getServiceid() + "_" + message.getState());
				proceedMessage(connection, message.getServiceid(), message.getState(), message.getData(), message.getResponsedata());
				message.delete(connection);
			} catch (Exception e) {
				logger.error("SaSyncThread ERROR: Exception during database actions using the synchronisation table bean, sync cancelled.", e);
				e.printStackTrace();
			} finally {
				if(PortalSyncListener.DEBUG){
					logger.debug("("+message.getMessageid()+")CLOSING CONNECTION connection = " + connection);
				}
				PortalSyncListener.dbp.releaseConnection (connection);
			}
		}
	}
	public void proceedMessage(Connection dbConnection, String serviceId, String saResp, String data, String responseData) throws SQLException {
		if (dbConnection == null) {
			logger.error("SaSyncThread ERROR: IN PROCEED MESSAGE The database connection could not be established, sync cancelled.");
			return;
		}
		Service service = Service.findByPrimaryKey(dbConnection, serviceId);
		if (service == null) {
			logger.error("SaSyncThread ERROR: No service in db with primkey '" + serviceId + "', sync cancelled.");
			return;
		}

		String serviceType = service.getType();
		String nextState = null;
		String currentState = null;
		if (serviceType.equals(Constants.TYPE_LAYER3_VPN) ||serviceType.equals(Constants.TYPE_GIS_VPN)|| serviceType.equals(Constants.TYPE_LAYER2_VPN)
				|| serviceType.equals(Constants.TYPE_LAYER2_VPWS) || serviceType.equals(Constants.TYPE_SITE)
				|| serviceType.equals(Constants.TYPE_LAYER3_PROTECTION) || serviceType.equals(Constants.TYPE_LAYER3_ATTACHMENT) 
				|| serviceType.equals(Constants.TYPE_GIS_PROTECTION) || serviceType.equals(Constants.TYPE_GIS_ATTACHMENT) 
				|| serviceType.equals(Constants.TYPE_LAYER2_ATTACHMENT) || serviceType.equals(Constants.TYPE_LAYER2_VPWS_ATTACHMENT)) {
			currentState = service.getState();
			if (currentState == null) {
				logger.error("SaSyncThread ERROR: The service has no current state cannot map to next state, sync cancelled.");
				return;
			}
			if (currentState.startsWith(Constants.ACTIVATION_SCOPE_PE)
					|| currentState.startsWith(Constants.ACTIVATION_SCOPE_CE) || currentState.startsWith(Constants.ACTIVATION_SCOPE_PE_CE)) {
				if(currentState.contains("_Setup_")){
					currentState = currentState.substring(9); //strip of CE_SETUP_
				}
				else if(currentState.startsWith("PE_CE_")){
					currentState = currentState.substring(6); //strip of PE_CE_
				}
				else{
					currentState = currentState.substring(3); //strip of PE_ or CE_
				}

			}
			String mapPrimKey = currentState + "||" + saResp;
			StateMapping stateMap = StateMapping.findByPrimaryKey(dbConnection, mapPrimKey);
			if (stateMap == null) {
				logger.error("SaSyncThread ERROR: No nextState could be found using the primkey '" + mapPrimKey
						+ "', sync cancelled. The service id is "+serviceId+" The current state was "+currentState+" and SA response was "+saResp);
				return;
			}
			nextState = stateMap.getNextstate();
			if (nextState == null) {
				logger.error("SaSyncThread ERROR: The nextState returned was null, sync cancelled.");
				return;
			}
			if (!nextState.contains("Delete") && !nextState.contains("REUSE")) {
				String actScope = getActivationScope(dbConnection, service.getServiceid(), serviceType, nextState);
				nextState = ((actScope.length() == 0) ? nextState : actScope + "_" + nextState);
			}
		} else {
			currentState = service.getState();
			if (currentState == null) {
				logger.error("SaSyncThread ERROR: The service has no current state cannot map to next state, sync cancelled.");
				return;
			}
			// Look up the next state
			String mapPrimKey = currentState + "||" + saResp;
			//logger.debug("SaSyncThread david debug: mapPrimKey could be found as currentState+saResp'" + mapPrimKey+ "', sync by david");
			StateMapping stateMap = StateMapping.findByPrimaryKey(dbConnection, mapPrimKey);
			if (stateMap == null) {
				logger.error("SaSyncThread ERROR: No nextState could be found using the primkey '" + mapPrimKey + "', sync cancelled.");
				return;
			}
			nextState = stateMap.getNextstate();
			if (nextState == null) {
				logger.error("SaSyncThread ERROR: The nextState returned was null, sync cancelled.");
				return;
			}
		}
		ServiceParameter parameter = ServiceParameter.findByServiceidattribute(dbConnection, service.getServiceid(), "Failure_description");
		if (parameter != null)
			parameter.delete(dbConnection);
		// Look up for state listener
		boolean doBreak = false;
		boolean doDescription = true;
		ServiceParameter lastCommitAction = ServiceParameter.findByServiceidattribute(dbConnection, service.getServiceid(),
				Constants.PARAMETER_LAST_COMMIT);
		//Added  to fix PR 10998 --Divya
		ServiceParameter lastCommitPeriodicAction = ServiceParameter.findByServiceidattribute(dbConnection, service.getServiceid(),  Constants.PARAMETER_PERIODIC_ACTION);
		logger.info("SASYNCTHREAD :: :  before calling proccedState OF STATELISTENER>>>lastCommitPeriodicAction ="+lastCommitPeriodicAction);
		if(lastCommitPeriodicAction!=null)
		{
			try
			{
				Class clazz = Class.forName(lastCommitPeriodicAction.getValue());
				Object object = clazz.newInstance();
				StateListener listener = (StateListener) object;
				int result = listener.proccedState(dbConnection, service.getServiceid(), nextState, saResp);
			}
			catch (Exception ex)
			{
				logger.error("SaSyncThread INFO: ERROR during UndoPeriodicScheduleListener procceding"+ex);
				ex.printStackTrace();
			}
		}
		//ends here
		logger.info("SASYNCTHREAD :: :  before calling proccedState OF STATELISTENER>>>lastCommitAction ="+lastCommitAction);
		//logger.error("SASYNCTHREAD  before calling proccedState OF STATELISTENER>>>dbConnection == "+dbConnection);
		if (lastCommitAction != null) {
			try {
				Class clazz = Class.forName(lastCommitAction.getValue());
				Object object = clazz.newInstance();
				StateListener listener = (StateListener) object;
				int result = listener.proccedState(dbConnection, service.getServiceid(), nextState, data);
				switch (result) {
				case StateListener.REMOVE_AND_BREAK:
					doBreak = true;
				case StateListener.REMOVE_AND_CONTINUE:
					lastCommitAction.delete(dbConnection);
					doDescription = false;
					break;
				case StateListener.STAY_AND_BREAK:
					doBreak = true;
				case StateListener.STAY_AND_CONTINUE:
					break;
				}
			} catch (Exception ex) {
				logger.error("SaSyncThread INFO: ERROR during listener procceding"+ex);
				ex.printStackTrace();
			}
		}

		if (doDescription) {
			if (data != null) {
				
				ServiceParameter serviceParameter = new ServiceParameter(service.getServiceid(), "Failure_description", data);
				serviceParameter.store(dbConnection);
				
			}

			if (responseData != null) 
			{
				ServiceParameter commentParameterRead = ServiceParameter.findByServiceidattribute(connection, service.getServiceid(), "HPSA_failure_description");	
				ServiceParameter commentParameterInsert = new ServiceParameter(service.getServiceid(), "HPSA_failure_description", responseData);

				if ( commentParameterRead == null )
				{
					commentParameterInsert.store(connection);
				}
				else
				{
					commentParameterInsert.update(connection);
				}
			}
		}
		if (doBreak)
			return;
		// Ensure that Activation Scope is set correctly after a proceed action of either PE or CE.
		//if (nextState.equals("Ok") && (currentState.equals("Proceed_PE_In_Progress") || currentState.equals("Proceed_CE_In_Progress"))) {
		ServiceParameter parameternextState = ServiceParameter.findByServiceidattribute(dbConnection, serviceId,  Constants.PARAM_NEXT_STATE);
		if ((nextState.equals("CE_Setup_Ok") || nextState.equals("PE_CE_Ok")) 
				&& (currentState.equals("In_Progress") && parameternextState !=null)) {
			logger.debug("SaSyncThread INFO: Next state was Ok, changing Activation Scope to BOTH!.");
			ServiceParameter activation_Scope = ServiceParameter.findByPrimaryKey(dbConnection, service.getServiceid() + "||Activation_Scope");
			if (activation_Scope != null) {
				activation_Scope.setValue("BOTH");
				activation_Scope.update(dbConnection);
				logger.debug("SaSyncThread INFO: Activation Scope changed.");
			} else {
				logger.error("SaSyncThread ERROR: Activation Scope could not be changed, the service parameter does not exist!");
			}
		}
		if (nextState.equals("Delete")) {
			logger.debug("SaSyncThread INFO: Next state was Delete, deleting service  '" + serviceId + "' now!.");
			//PR 15068
			ServiceUtils.deleteService(dbConnection, service);
			logger.debug("SaSyncThread INFO: Service '" + serviceId + "' deleted.");
		}else if ((nextState.equals("PE_Disabled")||nextState.equals("Disabled")||nextState.equals("CE_Disabled")||nextState.equals("PE_CE_Disabled")
				) && ("layer2-Attachment".equals(service.getType()) || (nextState.equals("PE_Disabled")||nextState.equals("Disabled")||nextState.equals("CE_Disabled") ||nextState.equals("PE_CE_Disabled"))  
						&& ("layer3-Attachment".equals(service.getType())||"GIS-Attachment".equals(service.getType()))|| "layer3-Protection".equals(service.getType()))){
			//logger.debug("SaSyncThread INFO nextstate="+nextState+" service type is"+service.getType());
			//PR 15138
			//get site
			service.setState(nextState);
			logger.debug("SaSyncThread INFO: Changing attachment '" + service.getServiceid() + "' state to " + nextState);
			ServiceUtils.updateService(dbConnection, service);
			Service tSite = null;
			tSite = Service.findByServiceid(dbConnection, service.getParentserviceid());
			if (null!=tSite){
				//get sub attachments
				Service tSite_attachments[] = Service.findByParentserviceid(dbConnection, tSite.getServiceid());
				if (tSite_attachments.length > 0) {
					int tSite_disabled_attachments_num = 0;
					for(int indx = 0; indx < tSite_attachments.length; indx++) {
						if ((tSite_attachments[indx].getState()).equals("PE_Disabled")
								||(tSite_attachments[indx].getState()).equals("CE_Disabled")
								||(tSite_attachments[indx].getState()).equals("Disabled") || (tSite_attachments[indx].getState()).equals("PE_CE_Disabled")) {  //david PR16115
							tSite_disabled_attachments_num += 1;
						}
					}
					//If all attachments' state is "PE_Disabled", disable the site
					if (tSite_disabled_attachments_num==tSite_attachments.length) {
						//tSite.setState("Disabled"); //by KK
						String actScope = getActivationScope(dbConnection, tSite.getServiceid(), tSite.getType(), nextState);//by KK
						String state = ((actScope.length() == 0) ? "Disabled" : actScope + "_" + "Disabled");//by KK
						tSite.setState(state);//by KK
						ServiceUtils.updateService(dbConnection, tSite);
						logger.debug("SaSyncThread INFO: Site '" + tSite.getServiceid() + "' sub attachments all disabled, so the site will be disabled.");
					} else if(tSite_disabled_attachments_num < tSite_attachments.length && tSite_disabled_attachments_num != 0){
						tSite.setState("Partial_Disabled");
						ServiceUtils.updateService(dbConnection, tSite);
						logger.debug("SaSyncThread INFO: Site '" + tSite.getServiceid() + "' sub attachments partial disabled, so the site will be partial disabled.");
					}
				}
			}
			//End of PR 15138
		}else if ((((nextState.equals("PE_Ok")||nextState.equals("Ok")||nextState.equals("CE_Ok")) && (Constants.TYPE_LAYER2_ATTACHMENT.equals(service.getType())))) 
				|| (((nextState.equals("PE_Ok")||nextState.equals("Ok")||nextState.equals("CE_Ok") ||nextState.equals("CE_Setup_Ok") || nextState.equals("PE_CE_Ok")) 
						&& (Constants.TYPE_LAYER3_ATTACHMENT.equals(service.getType()) || Constants.TYPE_LAYER3_PROTECTION.equals(service.getType())
						||Constants.TYPE_GIS_ATTACHMENT.equals(service.getType()) || Constants.TYPE_GIS_PROTECTION.equals(service.getType())))
						)){
			//PR 15138
			//get site
			//by KK
			//String scope=getActivationScope(dbConnection, service.getServiceid());
			ServiceParameter activation_Scope = ServiceParameter.findByPrimaryKey(dbConnection, service.getServiceid() + "||Activation_Scope");
			if (activation_Scope != null) {
				String scope = activation_Scope.getValue();
				if (scope.equals(Constants.ACTIVATION_SCOPE_VALUE_BOTH) ) {
					if ((nextState.startsWith(Constants.ACTIVATION_SCOPE_PE) || nextState.startsWith(Constants.ACTIVATION_SCOPE_CE)) 
							&& Constants.TYPE_LAYER2_ATTACHMENT.equals(service.getType())) {
						nextState = nextState.substring(3); //strip of PE_ or CE_
					}
					else if(Constants.TYPE_LAYER3_ATTACHMENT.equals(service.getType()) || Constants.TYPE_LAYER3_PROTECTION.equals(service.getType()))
						nextState = getL3SuccessState(dbConnection,service.getServiceid(),scope);
					
					else if(Constants.TYPE_GIS_ATTACHMENT.equals(service.getType()) || Constants.TYPE_GIS_PROTECTION.equals(service.getType()))
						nextState = getL3SuccessState(dbConnection,service.getServiceid(),scope);
				}
			}
			//by kk
			service.setState(nextState);
			logger.debug("SaSyncThread INFO: Changing attachment '" + service.getServiceid() + "' state to " + nextState);
			ServiceUtils.updateService(dbConnection, service);
			ServiceParameter actionParameter =ServiceParameter.findByServiceidattribute(connection, service.getServiceid(), "hidden_LastModifyAction");
			if(actionParameter !=null){
				String action = actionParameter.getValue();
				if (Constants.ACTION_JOINVPN.equals(action) || Constants.ACTION_LEAVEVPN.equals(action) || Constants.ACTION_MODIFYMULTICAST.equals(action) || Constants.ACTION_MODIFYCONNECTIVITYTYPE.equals(action) ){
					ServiceParameter protectionAttachmentIdParam =ServiceParameter.findByServiceidattribute(connection, service.getServiceid(), "protectionAttachmentId");
					if(protectionAttachmentIdParam != null){
						String protectionAttachmentId = protectionAttachmentIdParam.getValue();
						Service protectionService = Service.findByPrimaryKey(dbConnection, protectionAttachmentId);
						if ( protectionService != null ) {
							ServiceParameter protection_activation_Scope = ServiceParameter.findByPrimaryKey(dbConnection, protectionAttachmentId + "||Activation_Scope");
							if (protection_activation_Scope != null) {
								String protection_scope = protection_activation_Scope.getValue();

								if (protection_scope.equals(Constants.ACTIVATION_SCOPE_VALUE_BOTH) ) {
									if ((nextState.startsWith(Constants.ACTIVATION_SCOPE_PE) || nextState.startsWith(Constants.ACTIVATION_SCOPE_CE)) 
											&& Constants.TYPE_LAYER2_ATTACHMENT.equals(service.getType())) {
										nextState = nextState.substring(3); //strip of PE_ or CE_
									}
									else if(Constants.TYPE_LAYER3_ATTACHMENT.equals(service.getType()) || Constants.TYPE_LAYER3_PROTECTION.equals(service.getType()))
										nextState = getL3SuccessState(dbConnection,service.getServiceid(),protection_scope);
									else if(Constants.TYPE_GIS_ATTACHMENT.equals(service.getType()) || Constants.TYPE_GIS_PROTECTION.equals(service.getType()))
										nextState = getL3SuccessState(dbConnection,service.getServiceid(),protection_scope);
								}
							}
							protectionService.setState(nextState);
							ServiceUtils.updateService(dbConnection, protectionService);
						}
					}
					ServiceParameter lastModifyAction = ServiceParameter.findByServiceidattribute(dbConnection, service.getServiceid(),Constants.SERVICE_PARAM_HIDDEN_LASTMODIFYACTION);
					lastModifyAction.delete(dbConnection);
				}
			}
			Service tSite = null;
			tSite = Service.findByServiceid(dbConnection, service.getParentserviceid());
			if (null!=tSite){
				//get sub attachments
				Service tSite_attachments[] = Service.findByParentserviceid(dbConnection, tSite.getServiceid());
				if (tSite_attachments.length > 0 ) {
					boolean anyDisable = false;
					for(int indx = 0; indx < tSite_attachments.length; indx++) {
						if((tSite_attachments[indx].getState()).equals("PE_Disabled")||(tSite_attachments[indx].getState()).equals("CE_Disabled")
								||(tSite_attachments[indx].getState()).equals("Disabled") ||(tSite_attachments[indx].getState()).equals("PE_CE_Disabled")){
							anyDisable = true;
						}
					}
					//If all attachments' state is "PE_Disabled", disable the site
					if (!anyDisable) {
						//tSite.setState("Ok");//by KK
						String actScope = getActivationScope(dbConnection, tSite.getServiceid(), tSite.getType(), nextState);//by KK
						String state = ((actScope.length() == 0) ? "Ok" : actScope + "_" + "Ok");//by KK
						tSite.setState(state); //by KK
						ServiceUtils.updateService(dbConnection, tSite);
						logger.debug("SaSyncThread INFO: Site '" + tSite.getServiceid() + "' sub attachments all ok, so the site will be ok.");
					} else {
						tSite.setState("Partial_Disabled");
						ServiceUtils.updateService(dbConnection, tSite);
						logger.debug("SaSyncThread INFO: Site '" + tSite.getServiceid() + "' sub attachments partial disabled, so the site will be partial disabled.");
					}
				}
			}
			//End of PR 15138
		} else {
			if ( (Constants.TYPE_LAYER2_VPWS_ATTACHMENT.equals(service.getType()))) {
				if(service.getState().indexOf("Modify") != -1){
					String vPWSVPNServiceId=null;
					VPNMembership[] vpwsVPNs = VPNMembership.findBySiteattachmentid(connection, service.getServiceid());
					if (vpwsVPNs != null && vpwsVPNs.length == 1 ) {
						vPWSVPNServiceId=vpwsVPNs[0].getVpnid();
					} else {
						//Invalid scenario
						//Attachement is not part of any VPN or attachement is part of more than one VPN.
						logger.warn("Should never reach here.Attachement("+service.getServiceid()+") is not part of any VPN or attachement("+service.getServiceid()+") is part of more than one VPN.");
						return;
					}

					String zServiceId = ServiceParameter.findByServiceidattribute(connection, vPWSVPNServiceId, "Site_Attachment_ID_zEnd").getValue();
					Service zService = Service.findByPrimaryKey(dbConnection, zServiceId);
					Service vpnService = Service.findByPrimaryKey(dbConnection, vPWSVPNServiceId);
					zService.setState(getPENextState(nextState));
					vpnService.setState(nextState);
					ServiceUtils.updateService(dbConnection, zService);
					ServiceUtils.updateService(dbConnection, vpnService);
					service.setState(getPENextState(nextState));
				}
				else{
					service.setState(getPENextState(nextState));
				}
			} else {
				service.setState(nextState);
				ServiceParameter actionParameter =ServiceParameter.findByServiceidattribute(connection, service.getServiceid(), "hidden_LastModifyAction");
				if(actionParameter !=null){
					String action = actionParameter.getValue();
					if (Constants.ACTION_JOINVPN.equals(action) || Constants.ACTION_LEAVEVPN.equals(action) || Constants.ACTION_MODIFYMULTICAST.equals(action) || Constants.ACTION_MODIFYCONNECTIVITYTYPE.equals(action)){
						ServiceParameter protectionAttachmentIdParam =ServiceParameter.findByServiceidattribute(connection, service.getServiceid(), "protectionAttachmentId");
						if(protectionAttachmentIdParam != null){
							String protectionAttachmentId = protectionAttachmentIdParam.getValue();
							Service protectionService = Service.findByPrimaryKey(dbConnection, protectionAttachmentId);
							if ( protectionService != null ) {
								protectionService.setState(nextState);
								ServiceUtils.updateService(dbConnection, protectionService);
							}
						}

					}
				}
			}
			logger.debug("SaSyncThread INFO: Changing row 'State' in table 'Service' to '" + nextState + "' using primkey '" + serviceId + "'. The current state was "+currentState+" and SA response was "+saResp);
			ServiceUtils.updateService(dbConnection, service);
			logger.debug("SaSyncThread INFO: Row 'State' changed correctly.");
		}
	}

	/**
	 * Retrieves the activation scope parameter from SERVICE_PARAM table. 
	 * If scope is PE_Only returns string PE
	 * If scope is CE_Only returns string CE_setup for l3 other wise CE
	 * If scope is BOTH returns empty string 
	 * @param dbConnection
	 * @param serviceId
	 * @param serviceType
	 * @return String
	 * @throws SQLException
	 */
	private String getActivationScope(Connection dbConnection, String serviceId, String serviceType,String nxtState) throws SQLException
	{
		ServiceParameter parameterActScope = ServiceParameter.findByServiceidattribute(dbConnection, serviceId,  Constants.ACTIVATION_SCOPE_PARAM);

		String actScope = "";
		if (parameterActScope != null) {
			String temp = parameterActScope.getValue();
			if (serviceType.equals(Constants.TYPE_LAYER3_ATTACHMENT) || serviceType.equals(Constants.TYPE_LAYER3_PROTECTION)||serviceType.equals(Constants.TYPE_GIS_ATTACHMENT) || serviceType.equals(Constants.TYPE_GIS_PROTECTION)) {
				ServiceParameter parameterActCE = ServiceParameter.findByServiceidattribute(dbConnection, serviceId,  Constants.PARAM_ACTIVATE_CE_FLAG);
				ServiceParameter parameternextState = ServiceParameter.findByServiceidattribute(dbConnection, serviceId,  Constants.PARAM_NEXT_STATE);
				ServiceParameter parameterManCE = ServiceParameter.findByServiceidattribute(dbConnection, serviceId,  Constants.PARAM_MANAGED_CE);
				boolean paramActCE = parameterActCE != null ? Boolean.parseBoolean(parameterActCE.getValue()):false;
				String paramNextState = parameternextState != null ? parameternextState.getValue():"";
				boolean paramManCE = parameterManCE != null ? Boolean.parseBoolean(parameterManCE.getValue()):false;

				if(nxtState.indexOf("Failure") != -1){
					if (temp.equals(Constants.ACTIVATION_SCOPE_VALUE_PE_ONLY)) {

						actScope = Constants.ACTIVATION_SCOPE_PE;
					}
					else if (temp.equals(Constants.ACTIVATION_SCOPE_VALUE_CE_ONLY) && !paramActCE) {
						actScope = Constants.ACTIVATION_SCOPE_CE_SETUP;
					} else if ((temp.equals(Constants.ACTIVATION_SCOPE_VALUE_BOTH)) && !paramActCE) {
						if(paramManCE)
							actScope = Constants.ACTIVATION_SCOPE_PE_CE;
					}
					else if(paramActCE){
						if((nxtState.indexOf("Modify") !=-1 || nxtState.indexOf("Disable") != -1 || nxtState.indexOf("Enable") != -1
								|| nxtState.indexOf("Wait") !=-1  || nxtState.indexOf("Sched") !=-1)){
							actScope = "";
						}
						else{
							actScope = Constants.ACTIVATION_SCOPE_CE;
						}
					}
				}
				else {
					if (temp.equals(Constants.ACTIVATION_SCOPE_VALUE_PE_ONLY) && !(Constants.ACTIVATION_SCOPE_PE_CE+"_").equals(paramNextState)) {

						actScope = Constants.ACTIVATION_SCOPE_PE;
					}
					else if (temp.equals(Constants.ACTIVATION_SCOPE_VALUE_CE_ONLY) && !(Constants.ACTIVATION_SCOPE_PE_CE+"_").equals(paramNextState)) {
						actScope = Constants.ACTIVATION_SCOPE_CE_SETUP;
					} else if ((temp.equals(Constants.ACTIVATION_SCOPE_VALUE_BOTH) || (Constants.ACTIVATION_SCOPE_PE_CE+"_").equals(paramNextState)) 
							&& !paramActCE) {
						if(paramManCE)
							actScope = Constants.ACTIVATION_SCOPE_PE_CE;
					}
					else if(paramActCE){
						if(nxtState.indexOf("Modify") !=-1 || nxtState.indexOf("Disable") != -1 || nxtState.indexOf("Enable") != -1
								|| nxtState.indexOf("Wait") !=-1  || nxtState.indexOf("Sched") !=-1 ){
							actScope = "";
						}
						else{
							actScope = Constants.ACTIVATION_SCOPE_CE;
						}
					}
				}
			}
			else if(serviceType.equals(Constants.TYPE_SITE)){
				actScope = "";
			}
			else{
				if (temp.equals(Constants.ACTIVATION_SCOPE_VALUE_PE_ONLY)) {
					actScope = Constants.ACTIVATION_SCOPE_PE;
				} else if (temp.equals(Constants.ACTIVATION_SCOPE_VALUE_CE_ONLY)) {
					actScope = Constants.ACTIVATION_SCOPE_CE;
				} else if (temp.equals(Constants.ACTIVATION_SCOPE_VALUE_BOTH)) {
					actScope = "";
				}
			}
		} else {
			if (serviceType.equals(Constants.TYPE_LAYER2_ATTACHMENT)) {
				actScope = Constants.ACTIVATION_SCOPE_PE;
			}
		}
		return actScope;
	}
	/**
	 * 
	 * @param dbConnection
	 * @param serviceId
	 * @param scope
	 * @return
	 * @throws SQLException
	 */
	private String getL3SuccessState(Connection dbConnection, String serviceId, String scope) throws SQLException
	{
		String nextState = null;
		ServiceParameter parameternextState = ServiceParameter.findByServiceidattribute(dbConnection, serviceId,  Constants.PARAM_NEXT_STATE);
		ServiceParameter parameterActCE = ServiceParameter.findByServiceidattribute(dbConnection, serviceId,  Constants.PARAM_ACTIVATE_CE_FLAG);
		ServiceParameter parameterManCE = ServiceParameter.findByServiceidattribute(dbConnection, serviceId,  Constants.PARAM_MANAGED_CE);
		String paramNextState = parameternextState != null ? parameternextState.getValue():null;
		boolean paramActCE = parameterActCE != null ? Boolean.parseBoolean(parameterActCE.getValue()):false;
		String paramManCE = parameterManCE != null ? parameterManCE.getValue():"false";

		if (((scope.equals(Constants.ACTIVATION_SCOPE_VALUE_PE_ONLY) || scope.equals(Constants.ACTIVATION_SCOPE_VALUE_CE_ONLY) || scope.equals(Constants.ACTIVATION_SCOPE_VALUE_BOTH)) 
				&& paramNextState != null) && !paramActCE) {
			if(paramManCE.equals("true")){
				nextState = paramNextState+Constants.SERVICE_STATE_OK;
			}
			else{
				nextState = Constants.SERVICE_STATE_OK;
			}
		}
		else if (scope.equals(Constants.ACTIVATION_SCOPE_VALUE_BOTH) && paramNextState == null && !paramActCE){
			if(paramManCE.equals("true")){
				nextState = Constants.ACTIVATION_SCOPE_PE_CE+"_"+Constants.SERVICE_STATE_OK;
			}
			else{
				nextState = Constants.SERVICE_STATE_OK;
			}
		}
		else{ //if (scope.equals(Constants.ACTIVATION_SCOPE_VALUE_BOTH) && paramManCE.equals("false")) {
			nextState = Constants.SERVICE_STATE_OK;
		}
		//	  else if(parameterActCE ! =null && "Activate_CE".equals(paramActCE){
		//		  nextState = Constants.SERVICE_STATE_OK;
		//	  }

		return nextState;
	}

	/**
	 * Adds message to the list for processing.<br>
	 * Action is synchronized
	 *
	 * @param message message object to proceed
	 */
	public void addMessage(Message message) {
		if (PortalSyncListener.DEBUG) {
			logger.debug("SaSyncThread.addMessage starting: msgid/serviceid "
					+ message.getMessageid() + '/' +message.getServiceid());
		}
		synchronized (messages) {
			final int size = messages.size();
			for (int i = 0; i < size; i++) {
				Message listMessage = (Message) messages.get(i);
				if (listMessage.getMessageid() > message.getMessageid()) {
					messages.add(i, message);
					return;
				}
			}
			messages.add(message);
		}
		if (PortalSyncListener.DEBUG) {
			logger.debug("SaSyncThread.addMessage done: msgid/serviceid "
					+ message.getMessageid() + '/' +message.getServiceid());
		}
	}
	/**
	 * Starts thread that process messages list
	 */
	public void processMessages() {
		synchronized (messages) {
			if (!running) {
				running = true;
				Thread thread = new Thread(this);
				thread.start();
				if (PortalSyncListener.DEBUG) {
					logger.debug("SaSyncThread.processMessages thread has started");
				}
			}
		}
	}
	public static String getPENextState(String SiteState){
		if (SiteState.indexOf("PE_") >= 0) {
			return SiteState;
		}
		if(SiteState.equalsIgnoreCase("Modify_In_Progress"))
			return "PE_Modify_In_Progress";
		else if(SiteState.equalsIgnoreCase("Undo_Modify_In_Progress"))
			return "PE_Undo_Modify_In_Progress";
		else if(SiteState.equalsIgnoreCase("Disable_In_Progress"))
			return "PE_Disable_In_Progress";
		else if(SiteState.equalsIgnoreCase("Enable_In_Progress"))
			return "PE_Enable_In_Progress";
		else if(SiteState.equalsIgnoreCase("Modify_Temporary_Failure"))
			return "PE_Modify_Temporary_Failure";
		else if(SiteState.equalsIgnoreCase("Modify_Failure"))
			return "PE_Modify_Failure";    

		else if(SiteState.equalsIgnoreCase("REUSE_FAILURE"))
			return "REUSE_FAILURE";
		else if(SiteState.startsWith("Periodic_Modify"))
			return ("PE_" + SiteState.substring(0, "Periodic_Modify".length()) +  SiteState.substring("Periodic_Modify".length(), SiteState.length()));
		else
			return "PE_" + SiteState;
	}
	public boolean isRunning() {
		synchronized (messages) {
			return running;
		}
	}
}
