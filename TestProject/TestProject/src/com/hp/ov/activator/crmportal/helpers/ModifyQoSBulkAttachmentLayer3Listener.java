
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;

import com.hp.ov.activator.crmportal.bean.ServiceParameter;
import com.hp.ov.activator.crmportal.bean.VPNMembership;
import com.hp.ov.activator.crmportal.helpers.StateListener;
import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;

import com.hp.ov.activator.crmportal.common.*;
import com.hp.ov.activator.crmportal.bean.*;
import com.hp.ov.activator.crmportal.helpers.*;

import java.sql.*;
import java.text.*;
import java.util.*;
import java.util.Date;
import java.sql.Connection;
import java.io.IOException;

import javax.servlet.http.*;

import org.apache.log4j.Logger;

public class ModifyQoSBulkAttachmentLayer3Listener implements StateListener
{
	Logger logger = Logger.getLogger("CRMPortalLOG");

	public int proccedState(Connection connection, String serviceId, String state, String data) throws Exception 
	{
		logger.debug("connection = " + connection);
		logger.debug("serviceId = " + serviceId);
		logger.debug("state = " + state);
		logger.debug("data = " + data);
		
		//System.out.println("serviceId = " + serviceId + " || state = " + state);

		if(serviceId == null)
		{
			return StateListener.REMOVE_AND_CONTINUE;
		}
		
		if(state == null)
		{
			return StateListener.REMOVE_AND_CONTINUE;
		}

		if(connection == null)
		{
			return StateListener.REMOVE_AND_CONTINUE;
		}

		ServiceParameter parameter= null;
		parameter = ServiceParameter.findByServiceidattribute(connection, serviceId, "hidden_LastModifyAction");
		
		logger.debug("parameter = " + parameter);
		
		if(parameter == null)
		{
			return StateListener.REMOVE_AND_CONTINUE;// no parameter - no problem
		}

		if(!"ModifyQoSBulk".equals(parameter.getValue()))
		{
			return StateListener.REMOVE_AND_CONTINUE;// it yet another action
		}

		if(parameter == null)
		{
			return StateListener.REMOVE_AND_CONTINUE;// something wrong
		}
			
		String attachmentid = ServiceUtils.getServiceParam(connection, serviceId, "hidden_attachmentid");
		logger.debug("ModifyQoSBulkListener: attachmentid: " + attachmentid);
		
		// if service failed or in some transitional state then everything ok and let's wait for our state
		if (state.indexOf("Ok") > -1)
		{
			String vpnid = ServiceUtils.getServiceParam(connection, serviceId, "vpnserviceid");
			
			Service vpnService = Service.findByServiceid(connection, vpnid);
		
			// Save listener for QoS Bulk operation
			ServiceUtils.saveOrUpdateParameter(connection, vpnService.getServiceid(), Constants.PARAMETER_LAST_COMMIT, ModifyQoSBulkVPNLayer3Listener.class.getName());
			
			// Send ping message to HPSA in order to trigger the Listener
			String socketListener_port = PortalSyncListener.servletConfig.getInitParameter(Constants.SOCKET_LIS_PORT);
			String socketListener_host = PortalSyncListener.servletConfig.getInitParameter(Constants.SOCKET_LIS_HOST);
			String request_synchronisation = PortalSyncListener.servletConfig.getInitParameter(Constants.REQUEST_SYNCHRONISATION);
			String templateDir = PortalSyncListener.servletConfig.getInitParameter(Constants.TEMPLATE_DIR);
			String logDir = PortalSyncListener.servletConfig.getInitParameter(Constants.LOGS_DIRECTORY);
			
			HashMap serviceParameters = new HashMap();

			serviceParameters.put("serviceid", vpnService.getServiceid());
			serviceParameters.put("presname", vpnService.getPresname());
			serviceParameters.put("submitdate", vpnService.getSubmitdate());
			serviceParameters.put("modifydate", vpnService.getModifydate());
			serviceParameters.put("type", vpnService.getType());
			serviceParameters.put("customerid", vpnService.getCustomerid());
			serviceParameters.put("modifydate", Constants.DEFAULT_DATE_FORMAT.format(new java.util.Date()));
			serviceParameters.put("HOST", socketListener_host);
			serviceParameters.put("PORT", socketListener_port);
			serviceParameters.put("TEMPLATE_DIR", templateDir);
			serviceParameters.put("operator", ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_OPERATOR));
			serviceParameters.put("LOG_DIRECTORY", logDir);
			serviceParameters.put(Constants.XSLPARAM_REQUEST_SYNCHRONISATION, request_synchronisation);
			serviceParameters.put("ACTION", "ModifyQoSBulk");
			serviceParameters.put("activation_name", "modify_QoS_Bulk");
			
			IdGenerator idGenerator = new IdGenerator(connection);
			String messageid = idGenerator.getMessageId();
			serviceParameters.put(Constants.XSLPARAM_MESSAGEID, messageid);
			
			ServiceParameter[] serviceParamArray = ServiceParameter.findByServiceid(connection, vpnService.getServiceid());

			if (serviceParamArray != null)
			{
				for (int j = 0; j < serviceParamArray.length; j++)
				{
					serviceParameters.put(serviceParamArray[j].getAttribute(), serviceParamArray[j].getValue());
				}
			}
			
			if (!serviceParameters.containsKey("hidden_LastModifyAction")) 
			{
				ServiceParameter lastModifyAction = new ServiceParameter();
				lastModifyAction.setServiceid(vpnService.getServiceid());
				lastModifyAction.setAttribute("hidden_LastModifyAction");
				lastModifyAction.setValue((String)serviceParameters.get("ACTION"));
				lastModifyAction.store(connection);
			}
			
			try 
			{
				SendXML sender = new SendXML(serviceParameters);
				sender.Init();
				sender.Send();
			} 
			catch (IOException e) 
			{
				try 
				{
					vpnService.setState(Constants.SERVICE_STATE_FAILURE);
					ServiceUtils.updateService(connection, vpnService);
					ServiceUtils.saveOrUpdateParameter(connection, vpnService.getServiceid(), Constants.SERVICE_PARAM_FAILURE_DESCRIPTION, e.getMessage());
				} 
				catch (Exception ex) 
				{
					logger.error("Exception in ModifyQoSBulkAttachmentLayer3Listener listener" + ex);
				}
			}
		}
		else if (state.indexOf("Failure") > -1)
		{
			// Set VPN status to failed
			String vpnid = ServiceUtils.getServiceParam(connection, serviceId, "vpnserviceid");
			Service vpnservice = Service.findByServiceid(connection, vpnid);
			vpnservice.setState("Modify_Failure");
			ServiceUtils.updateService(connection, vpnservice);
			ServiceUtils.saveOrUpdateParameter(connection, vpnservice.getServiceid(), Constants.SERVICE_PARAM_FAILURE_DESCRIPTION, "Bulk QoS modification failed");
		}
		else
		{
			return StateListener.STAY_AND_CONTINUE;
		}

		return StateListener.REMOVE_AND_CONTINUE;
	}
}
