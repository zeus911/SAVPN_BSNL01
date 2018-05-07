/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.hp.ov.activator.crmportal.bean.Service;
import com.hp.ov.activator.crmportal.bean.ServiceParameter;
import com.hp.ov.activator.crmportal.common.IdGenerator;
import com.hp.ov.activator.crmportal.utils.Constants;

public class CreateL2VPWSVPNStateListener implements StateListener {
	Logger logger = Logger.getLogger(Constants.CRMPORTALLOG);

	public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception {
		// if (PortalSyncListener.DEBUG) {
		logger.debug("Inside L2VPWSVPNStateListener");
		logger.debug("connection = " + connection);
		logger.debug("serviceId = " + serviceId);
		logger.debug("state = " + state);
		logger.debug("data = " + data);
		// }
		if (state == null)
			return StateListener.REMOVE_AND_CONTINUE;

		if (serviceId == null)
			return StateListener.REMOVE_AND_CONTINUE;

		if (connection == null)
			return StateListener.REMOVE_AND_CONTINUE;

		if (state.equals(Constants.SERVICE_STATE_FAILURE)) {
			ServiceUtils.saveOrUpdateParameter(connection, serviceId, Constants.SERVICE_PARAM_FAILURE_STATUS,
					Constants.SERVICE_PARAM_VALUE_VPWS_FAILURE);
		}

		if (state.indexOf(Constants.SERVICE_STATE_OK) == -1 && state.indexOf(Constants.SERVICE_STATE_MSG_FAILURE) == -1)
			return StateListener.STAY_AND_CONTINUE;

		try {

			HashMap allParameters = new HashMap();
			String socketListener_port = PortalSyncListener.servletConfig.getInitParameter(Constants.SOCKET_LIS_PORT);
			String socketListener_host = PortalSyncListener.servletConfig.getInitParameter(Constants.SOCKET_LIS_HOST);
			String request_synchronisation = PortalSyncListener.servletConfig.getInitParameter(Constants.REQUEST_SYNCHRONISATION);
			String templateDir = PortalSyncListener.servletConfig.getInitParameter(Constants.TEMPLATE_DIR);
			String logDir = PortalSyncListener.servletConfig.getInitParameter(Constants.LOGS_DIRECTORY);

			allParameters.put(Constants.XSLPARAM_HOST, socketListener_host);
			allParameters.put(Constants.XSLPARAM_PORT, socketListener_port);
			allParameters.put(Constants.XSLPARAM_TEMPLATE_DIR, templateDir);
			allParameters.put("operator", ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_OPERATOR));
			allParameters.put(Constants.XSLPARAM_LOG_DIRECTORY, logDir);
			allParameters.put(Constants.XSLPARAM_REQUEST_SYNCHRONISATION, request_synchronisation);
			IdGenerator idGenerator = new IdGenerator(connection);
			String messageid = idGenerator.getMessageId();
			allParameters.put(Constants.XSLPARAM_MESSAGEID, messageid);

			boolean aEndSiteReused = ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_SERVICEMULTIPLEXING_AEND)
					.equalsIgnoreCase("true");
			boolean zEndSiteReused = ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_SERVICEMULTIPLEXING_ZEND)
					.equalsIgnoreCase("true");
			Service siteService = null;
			String siteServiceId = null;
			String presname = null;
			String serviceIdOfToBeCreatedService = null;
			String serviceIdOfToBeCreatedServiceZend = null;
			if (aEndSiteReused && zEndSiteReused) {
				// Both end sites are reused. so no need to send the site creation request
				String aEndAttachmentServiceID = ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_SITE_ATTACHMENT_ID_AEND);
				serviceIdOfToBeCreatedService = aEndAttachmentServiceID;

				allParameters.put(Constants.XSLPARAM_SERVICEID, aEndAttachmentServiceID);
				allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_ADD);
				allParameters.put(Constants.SERVICE_PARAM_VPN_ID, serviceId);
				allParameters.put(Constants.XSLPARAM_XSLNAME, Constants.XSLNAME_L2VPWS_ATTACHMENT);

				ServiceUtils.saveOrUpdateParameter(connection, aEndAttachmentServiceID, Constants.PARAMETER_LAST_COMMIT,
						CreateL2VPWSStateListener.class.getName());
			} else if (aEndSiteReused || zEndSiteReused) {
				// One of the site is reused. Send site creation request for the other one.
				siteServiceId = aEndSiteReused ? ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_SITE_SERVICE_ID_ZEND)
						: ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_SITE_SERVICE_ID_AEND);
				siteService = Service.findByPrimaryKey(connection, siteServiceId);
				serviceIdOfToBeCreatedService = siteServiceId;

				// We need to the site name as Presname for Create Site
				if (siteService != null) {

					presname = siteService.getPresname();
					allParameters.put("presname", presname);
				}
				allParameters.put(Constants.XSLPARAM_XSLNAME, Constants.XSLNAME_SITE);
				allParameters.put(Constants.XSLPARAM_CUSTOMERID, siteService.getCustomerid());
			} else {
				// Both the sites are new. Send create request for sites.
				String aEndSiteServiceID = ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_SITE_SERVICE_ID_AEND);
				String zEndSiteServiceID = ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_SITE_SERVICE_ID_ZEND);
				Service aEndSite = Service.findByPrimaryKey(connection, aEndSiteServiceID);

				siteService = aEndSite;
				siteServiceId = aEndSiteServiceID;
				serviceIdOfToBeCreatedService = siteServiceId;
				serviceIdOfToBeCreatedServiceZend = zEndSiteServiceID;

				allParameters.put(Constants.XSLPARAM_XSLNAME, Constants.XSLNAME_SITES);
			}
			if (siteService != null) {
				// Site service(s) common code
				ServiceParameter vpnServiceId = new ServiceParameter();
				vpnServiceId.setServiceid(siteServiceId);
				vpnServiceId.setAttribute(Constants.SERVICE_PARAM_VPN_ID);
				vpnServiceId.setValue(serviceId);
				vpnServiceId.store(connection);

				allParameters.put(Constants.XSLPARAM_SERVICEID, siteServiceId);
				allParameters.put(Constants.XSLPARAM_ACTION, Constants.ACTION_CREATE);
				allParameters.put(Constants.XSLPARAM_CUSTOMERID, siteService.getCustomerid());
				ServiceUtils.saveOrUpdateParameter(connection, siteServiceId, Constants.PARAMETER_LAST_COMMIT,
						CreateL2VPWSSiteListener.class.getName());
			}
			if (serviceIdOfToBeCreatedService != null) {
				// Common code for site or attachment creation
				allParameters.put(Constants.SERVICE_PARAM_VPN_ID, serviceId);
				ServiceParameter VPWSServiceParams[] = ServiceParameter.findByServiceid(connection, serviceId);
				for (int i = 0; i < VPWSServiceParams.length; i++) {
					ServiceParameter serviceParameter = VPWSServiceParams[i];
					serviceParameter.setServiceid(serviceIdOfToBeCreatedService);
					allParameters.put(serviceParameter.getAttribute(), serviceParameter.getValue());
				}
				if (serviceIdOfToBeCreatedServiceZend != null) {
					for (int i = 0; i < VPWSServiceParams.length; i++) {
						ServiceParameter serviceParameter = VPWSServiceParams[i];
						serviceParameter.setServiceid(serviceIdOfToBeCreatedServiceZend);
						allParameters.put(serviceParameter.getAttribute(), serviceParameter.getValue());
					}
				}

				if (aEndSiteReused && zEndSiteReused) {
					ServiceParameter vpnServiceId = new ServiceParameter();
					vpnServiceId.setServiceid(serviceIdOfToBeCreatedService);
					vpnServiceId.setAttribute(Constants.SERVICE_PARAM_VPN_ID);
					vpnServiceId.setValue(serviceId);
					vpnServiceId.store(connection);
				}
				// by KK
				if ((aEndSiteReused || zEndSiteReused) || (!aEndSiteReused && !zEndSiteReused)) {
					allParameters.remove(Constants.START_TIME);
					allParameters.remove(Constants.END_TIME);
				}
				// by KK

				// In case of creating only zEnd site we overwrite Region value with zEnd's region.
				if (aEndSiteReused && !zEndSiteReused) {
					allParameters.put(Constants.REGION, allParameters.get(Constants.PW_ZEND_REGION));
				}
			}
			try {
				SendXML sender = new SendXML(allParameters);
				sender.Init();
				sender.Send();
			} catch (IOException e) {
				try {
					if (siteService != null) {
						siteService.setState("Failure");
						ServiceUtils.updateService(connection, siteService);
						ServiceUtils.saveOrUpdateParameter(connection, siteServiceId, Constants.SERVICE_PARAM_FAILURE_DESCRIPTION, e.getMessage());
					}

					if (!zEndSiteReused) {
						String zEndSiteServiceID = ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_SITE_SERVICE_ID_ZEND);
						Service zEndSite = Service.findByPrimaryKey(connection, zEndSiteServiceID);
						zEndSite.setState(Constants.SERVICE_STATE_FAILURE);
						ServiceUtils.updateService(connection, zEndSite);
						ServiceUtils
								.saveOrUpdateParameter(connection, zEndSiteServiceID, Constants.SERVICE_PARAM_FAILURE_DESCRIPTION, e.getMessage());
					}

					String aEndAttachmentServiceID = ServiceUtils.getServiceParam(connection, serviceId,
							Constants.SERVICE_PARAM_SITE_ATTACHMENT_ID_AEND);
					Service aEndAttachment = Service.findByPrimaryKey(connection, aEndAttachmentServiceID);
					aEndAttachment.setState(Constants.SERVICE_STATE_FAILURE);
					String zEndAttachmentServiceID = ServiceUtils.getServiceParam(connection, serviceId,
							Constants.SERVICE_PARAM_SITE_ATTACHMENT_ID_ZEND);
					Service zEndAttachment = Service.findByPrimaryKey(connection, zEndAttachmentServiceID);
					zEndAttachment.setState(Constants.SERVICE_STATE_FAILURE);

					ServiceUtils.updateService(connection, aEndAttachment);
					ServiceUtils.saveOrUpdateParameter(connection, aEndAttachmentServiceID, Constants.SERVICE_PARAM_FAILURE_DESCRIPTION,
							e.getMessage());
					ServiceUtils.updateService(connection, zEndAttachment);
					ServiceUtils.saveOrUpdateParameter(connection, zEndAttachmentServiceID, Constants.SERVICE_PARAM_FAILURE_DESCRIPTION,
							e.getMessage());
				} catch (Exception ex) {
					logger.error("Exception in L2VPWSVPNState listener" + ex);
				}
			}
		} catch (Exception ex) {
			logger.error("Exception in L2VPWSVPNState listener" + ex);
		}
		return StateListener.REMOVE_AND_CONTINUE;

	} // End public int proccedState(Connection connection, String serviceId, String state, String data)

} // End class CreateL2VPWSVPNStateListener implements StateListener

