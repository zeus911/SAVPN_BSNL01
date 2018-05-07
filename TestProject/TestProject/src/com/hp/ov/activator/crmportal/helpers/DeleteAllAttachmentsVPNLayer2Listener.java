
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

public class DeleteAllAttachmentsVPNLayer2Listener implements StateListener
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

		if(!"DeleteAllAttachments".equals(parameter.getValue()))
		{
			return StateListener.REMOVE_AND_CONTINUE;// it yet another action
		}

		if(parameter == null)
		{
			return StateListener.REMOVE_AND_CONTINUE;// something wrong
		}
				
		try 
		{
			String socketListener_port = PortalSyncListener.servletConfig.getInitParameter(Constants.SOCKET_LIS_PORT);
			String socketListener_host = PortalSyncListener.servletConfig.getInitParameter(Constants.SOCKET_LIS_HOST);
			String request_synchronisation = PortalSyncListener.servletConfig.getInitParameter(Constants.REQUEST_SYNCHRONISATION);
			String templateDir = PortalSyncListener.servletConfig.getInitParameter(Constants.TEMPLATE_DIR);
			String logDir = PortalSyncListener.servletConfig.getInitParameter(Constants.LOGS_DIRECTORY);
			String lastState = null;
			
			int undoIndex = 0;
			
			String whereClause = "attribute = 'vpnserviceid' and value = '"+serviceId+"'"; 
						
			ServiceParameter[] attachments = ServiceParameter.findAll(connection,whereClause);
			
			attachments = attachments != null ? attachments : new ServiceParameter[0];
			
			Service attachment = null;	
			
			// Find the first attachment that still exists
			for (int i=0; i < attachments.length; i++) 
			{
				Service vpnAttachment = Service.findByServiceid(connection,attachments[i].getServiceid());
				attachment = vpnAttachment;
				break;
			}
			
			if (attachment != null)
			{			
				HashMap attachmentServiceParameters = new HashMap ();

				attachmentServiceParameters.put("serviceid", attachment.getServiceid());
				attachmentServiceParameters.put("parentserviceid", attachment.getParentserviceid());
				attachmentServiceParameters.put("state", "Delete_Requested");
				attachmentServiceParameters.put("presname", attachment.getPresname());
				attachmentServiceParameters.put("submitdate", attachment.getSubmitdate());
				attachmentServiceParameters.put("modifydate", attachment.getModifydate());
				attachmentServiceParameters.put("type", attachment.getType());
				attachmentServiceParameters.put("customerid", attachment.getCustomerid());
				attachmentServiceParameters.put("modifydate", Constants.DEFAULT_DATE_FORMAT.format(new java.util.Date()));
				attachmentServiceParameters.put("HOST", socketListener_host);
				attachmentServiceParameters.put("PORT", socketListener_port);
				attachmentServiceParameters.put("TEMPLATE_DIR", templateDir);
				attachmentServiceParameters.put("operator", ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_OPERATOR));
				attachmentServiceParameters.put("LOG_DIRECTORY", logDir);
				attachmentServiceParameters.put(Constants.XSLPARAM_REQUEST_SYNCHRONISATION, request_synchronisation);
				attachmentServiceParameters.put("ACTION", "DeleteAllAttachments");

				IdGenerator idGenerator = new IdGenerator(connection);
				String messageid = idGenerator.getMessageId();
				attachmentServiceParameters.put(Constants.XSLPARAM_MESSAGEID, messageid);
				
				ServiceParameter[] attachmentServiceParamArray = ServiceParameter.findByServiceid(connection, attachment.getServiceid());

				if (attachmentServiceParamArray != null)
				{
					for (int j = 0; j < attachmentServiceParamArray.length; j++)
					{
						attachmentServiceParameters.put(attachmentServiceParamArray[j].getAttribute(), attachmentServiceParamArray[j].getValue());
					}
				}
				
				// Save state for later undo
				lastState = attachment.getState();

				// State needs to be set before sending to SA to avoid race condition!
				if (attachmentServiceParameters.get("state")== null || attachmentServiceParameters.get("state") == "") 
				{ 
					attachment.setState(lastState);
				}
				else
				{
					attachment.setState((String) attachmentServiceParameters.get("state"));
				}
				
				ServiceUtils.updateService(connection, attachment);

				ServiceUtils.saveOrUpdateParameter(connection, attachment.getServiceid(), "hidden_LastModifyAction", (String)attachmentServiceParameters.get("ACTION"));
				
				// Save listener for Delete All Attachments Bulk operation
				ServiceUtils.saveOrUpdateParameter(connection, attachment.getServiceid(), Constants.PARAMETER_LAST_COMMIT, DeleteAllAttachmentsAttachmentLayer2Listener.class.getName());

				try 
				{
					SendXML sender = new SendXML(attachmentServiceParameters);
					sender.Init();
					sender.Send();
				} 
				catch (IOException e) 
				{
					try 
					{
						attachment.setState(Constants.SERVICE_STATE_FAILURE);
						ServiceUtils.updateService(connection, attachment);
						ServiceUtils.saveOrUpdateParameter(connection, attachment.getServiceid(), Constants.SERVICE_PARAM_FAILURE_DESCRIPTION, e.getMessage());
					} 
					catch (Exception ex) 
					{
						logger.error("Exception in DeleteAllAttachmentsVPNLayer2Listener listener" + ex);
					}
				}
			} // if attachment is not null
			else
			{
				if (state.indexOf("Ok") > -1)
				{
					return StateListener.REMOVE_AND_CONTINUE;
				}
				else if (state.indexOf("Failure") > -1)
				{
					return StateListener.REMOVE_AND_CONTINUE;
				}
				else
				{
					Service vpnService = Service.findByServiceid(connection, serviceId);
				
					// Save listener for bulk delete operation
					ServiceUtils.saveOrUpdateParameter(connection, vpnService.getServiceid(), Constants.PARAMETER_LAST_COMMIT, DeleteAllAttachmentsVPNLayer2Listener.class.getName());
					
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
					serviceParameters.put("ACTION", "DeleteAllAttachments");
					serviceParameters.put("activation_name", "delete_All_Attachments_Finish");
										
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
					
					ServiceUtils.saveOrUpdateParameter(connection, serviceId, "hidden_LastModifyAction", "DeleteAllAttachments");
					
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
							logger.error("Exception in DeleteAllAttachmentsVPNLayer2Listener listener" + ex);
						}
					}
				}
			}
		} 
		catch (Exception ex) 
		{
			logger.error("Exception in DeleteAllAttachmentsVPNLayer2Listener listener" + ex);
		}

		return StateListener.REMOVE_AND_CONTINUE;
	}
}