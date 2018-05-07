
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

public class ModifyQoSBulkVPNLayer3Listener implements StateListener
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
				
		try 
		{
			String socketListener_port = PortalSyncListener.servletConfig.getInitParameter(Constants.SOCKET_LIS_PORT);
			String socketListener_host = PortalSyncListener.servletConfig.getInitParameter(Constants.SOCKET_LIS_HOST);
			String request_synchronisation = PortalSyncListener.servletConfig.getInitParameter(Constants.REQUEST_SYNCHRONISATION);
			String templateDir = PortalSyncListener.servletConfig.getInitParameter(Constants.TEMPLATE_DIR);
			String logDir = PortalSyncListener.servletConfig.getInitParameter(Constants.LOGS_DIRECTORY);
			String lastState = null;
			
			int undoIndex = 0;
						
			// Get CAR and QOS from VPN parameters
			String selectedCAR = ""; 
			if (ServiceUtils.getServiceParam(connection, serviceId, "CAR") != null) 
			{
				selectedCAR = (String) ServiceUtils.getServiceParam(connection, serviceId, "CAR"); 
			}
			
			String selectedQoS = ""; 
			if (ServiceUtils.getServiceParam(connection, serviceId, "QOS_PROFILE") != null) 
			{						
				selectedQoS = (String) ServiceUtils.getServiceParam(connection, serviceId, "QOS_PROFILE");
			}
			
			String baseProfile = "";
			if (ServiceUtils.getServiceParam(connection, serviceId, "QOS_BASE_PROFILE") != null) 
			{						
				baseProfile = (String) ServiceUtils.getServiceParam(connection, serviceId, "QOS_BASE_PROFILE");
			}
			
			String selectedQoSChildEnabled = ""; 
			if (ServiceUtils.getServiceParam(connection, serviceId, "QoSChildEnabled") != null) 
			{						
				selectedQoSChildEnabled = (String) ServiceUtils.getServiceParam(connection, serviceId, "QoSChildEnabled");
			}
			
			String whereClause = "attribute = 'vpnserviceid' and value = '"+serviceId+"'"; 
						
			ServiceParameter[] attachments = ServiceParameter.findAll(connection,whereClause);
			
			attachments = attachments != null ? attachments : new ServiceParameter[0];
			
			Service attachment = null;	
			
			// Find the last attachment that does not match the CAR and QOS of the VPN
			for (int i=0; i < attachments.length; i++) 
			{
				try
				{
					Service vpnAttachment = Service.findByServiceid(connection,attachments[i].getServiceid());
					
					String attachmentCAR = ServiceUtils.getServiceParam(connection, vpnAttachment.getServiceid(), "CAR");
					String attachmentQoS = ServiceUtils.getServiceParam(connection, vpnAttachment.getServiceid(), "QOS_PROFILE");
					String attachmentQoSChildEnabled = ServiceUtils.getServiceParam(connection, vpnAttachment.getServiceid(), "QoSChildEnabled");
					
					if (!(selectedCAR.equals(attachmentCAR) && selectedQoS.equals(attachmentQoS) && selectedQoSChildEnabled.equals(attachmentQoSChildEnabled)))
					{
						attachment = vpnAttachment;
					}
				}
				catch (Exception ex)
				{
					// Do nothing
				}
			}
			
			if (attachment != null)
			{			
				HashMap attachmentServiceParameters = new HashMap ();

				attachmentServiceParameters.put("serviceid", attachment.getServiceid());
				attachmentServiceParameters.put("state", "Modify_Request_Sent");
				attachmentServiceParameters.put("presname", attachment.getPresname());
				attachmentServiceParameters.put("submitdate", attachment.getSubmitdate());
				attachmentServiceParameters.put("modifydate", attachment.getModifydate());
				
				if ("layer3-Protection".equals(attachment.getType()))
				{
					attachmentServiceParameters.put("type", "layer3-Attachment");
				}
				else 
				{
					attachmentServiceParameters.put("type", attachment.getType());
				}
				
				attachmentServiceParameters.put("customerid", attachment.getCustomerid());
				attachmentServiceParameters.put("modifydate", Constants.DEFAULT_DATE_FORMAT.format(new java.util.Date()));
				attachmentServiceParameters.put("HOST", socketListener_host);
				attachmentServiceParameters.put("PORT", socketListener_port);
				attachmentServiceParameters.put("TEMPLATE_DIR", templateDir);
				attachmentServiceParameters.put("operator", ServiceUtils.getServiceParam(connection, serviceId, Constants.SERVICE_PARAM_OPERATOR));
				attachmentServiceParameters.put("LOG_DIRECTORY", logDir);
				attachmentServiceParameters.put(Constants.XSLPARAM_REQUEST_SYNCHRONISATION, request_synchronisation);
				attachmentServiceParameters.put("ACTION", "ModifyQoSBulk");

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

				ServiceUtils.saveOrUpdateParameter(connection, attachment.getServiceid(), "hidden_LastModifyAction", (String)attachmentServiceParameters.get("ACTION"));
				
				if(!("".equals(selectedCAR)))
				{
					attachmentServiceParameters.put("CAR", selectedCAR);
					ServiceUtils.saveOrUpdateParameter(connection, attachment.getServiceid(), "CAR", selectedCAR);

					attachmentServiceParameters.put("hidden_LastModifyAction", (String)attachmentServiceParameters.get("ACTION"));
					saveAttributeForUndo(connection, attachment.getServiceid(), "CAR", attachmentServiceParameters);

					String region = ServiceParameter.findByServiceidattribute( connection, attachment.getServiceid(), "Region" ).getValue();
					attachmentServiceParameters.put("Region", region);	
				}

				if(!("".equals(selectedQoS)) && !("".equals(baseProfile)))
				{
					attachmentServiceParameters.put("QOS_BASE_PROFILE", baseProfile);
					ServiceUtils.saveOrUpdateParameter(connection, attachment.getServiceid(), "QOS_BASE_PROFILE", baseProfile);

					attachmentServiceParameters.put("QOS_PROFILE", selectedQoS);
					ServiceUtils.saveOrUpdateParameter(connection, attachment.getServiceid(), "QOS_PROFILE", selectedQoS);

					EXPMapping[] expMappings = EXPMapping.findAll(connection);

					int expMappingsCount = expMappings == null ? 0 : expMappings.length;

					extractParameter(connection, baseProfile, attachmentServiceParameters, attachment.getServiceid(), "QOS_BASE_PROFILE", "QoS Base Profile");

					for(int k = 0; k < expMappingsCount; k++)
					{
						// Get Percent
						String parameterNamePercent = "QOS_CLASS_"+expMappings[k].getPosition()+"_PERCENT";
						String parameterPercent = ServiceUtils.getServiceParam(connection, serviceId, parameterNamePercent);

						attachmentServiceParameters.put(parameterNamePercent, parameterPercent);
						ServiceUtils.saveOrUpdateParameter(connection, attachment.getServiceid(), parameterNamePercent, parameterPercent);

						// Get Rate Limit
						String parameterNameRL = "QOS_CLASS_"+expMappings[k].getPosition()+"_RL";
						String parameterRL = ServiceUtils.getServiceParam(connection, serviceId, parameterNameRL);

						attachmentServiceParameters.put(parameterNameRL, parameterRL);
						ServiceUtils.saveOrUpdateParameter(connection, attachment.getServiceid(), parameterNameRL, parameterRL);
					}

					 extractParameter(connection, selectedQoS, attachmentServiceParameters, attachment.getServiceid(), "QOS_PROFILE", "QoS Profile");	
					 extractParameter(connection, selectedCAR, attachmentServiceParameters, attachment.getServiceid(), "CAR", "Rate-limit", undoIndex++);
				}
				
				if(!("".equals(selectedQoSChildEnabled)))
				{
					attachmentServiceParameters.put("QoSChildEnabled", selectedQoSChildEnabled);
					ServiceUtils.saveOrUpdateParameter(connection, attachment.getServiceid(), "QoSChildEnabled", selectedQoSChildEnabled);
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

				String Old_serviceType = null;

				if (attachmentServiceParameters.get("type") != null) 
				{
					String serviceType = (String)attachmentServiceParameters.get("type");
					Old_serviceType = serviceType;
					attachmentServiceParameters.put("type", serviceType);
				}

				attachmentServiceParameters.put("vpnserviceid", serviceId);
				attachmentServiceParameters.put("parentserviceid", attachment.getParentserviceid()); 
				attachmentServiceParameters.put(Constants.XSLPARAM_ADDRESS_TYPE, Constants.IP_ADDR_V4);
				
				// Save listener for QoS Bulk operation
				ServiceUtils.saveOrUpdateParameter(connection, attachment.getServiceid(), Constants.PARAMETER_LAST_COMMIT, ModifyQoSBulkAttachmentLayer3Listener.class.getName());

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
						logger.error("Exception in ModifyQoSBulkVPNLayer3Listener listener" + ex);
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
				
					// Save listener for QoS Bulk operation
					ServiceUtils.saveOrUpdateParameter(connection, vpnService.getServiceid(), Constants.PARAMETER_LAST_COMMIT, ModifyQoSBulkVPNLayer3Listener.class.getName());
					
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
					serviceParameters.put("activation_name", "modify_QoS_Bulk_Finish");
										
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
							logger.error("Exception in ModifyQoSBulkVPNLayer3Listener listener" + ex);
						}
					}
				}
			}
		} 
		catch (Exception ex) 
		{
			logger.error("Exception in ModifyQoSBulkVPNLayer3Listener listener" + ex);
		}

		return StateListener.REMOVE_AND_CONTINUE;
	}
	
	void extractParameter(Connection connection, String parameter, HashMap serviceParameters, String serviceId, String parameterName, String parameterDescription) throws Exception
	{
		extractParameter(connection, parameter, serviceParameters, serviceId, parameterName, parameterDescription, -1);
	}

	void extractParameter(Connection connection, String parameter, HashMap serviceParameters, String serviceId, String parameterName, String parameterDescription, int index) throws Exception
	{
		if (parameter != null) 
		{
			if (serviceParameters.get(parameterName) != null) 
			{
				saveAttributeForUndo(connection, serviceId, parameterName, serviceParameters, index);
				serviceParameters.put(parameterName, parameter);
			} 
			else 
			{
				throw new Exception(parameterDescription +" not set for the selected service, cannot be modified.");
			}
		}
	}
	
	void saveAttributeForUndo(Connection con, String serviceid, String attribute, HashMap serviceParameters, int id) throws SQLException
	{
		final ServiceParameter modifiedServiceParameter = ServiceParameter.findByServiceidattribute(con, serviceid, attribute);
		final String index = id < 0 ? "" : String.valueOf(id);
		final String ATTRIBUTE_NAME = Constants.PARAMETER_LAST_MODIFIED  + index;
		final String ATTRIBUTE_VALUE = Constants.PARAMETER_LAST_MODIFIED_VALUE + index;

		id++;

		final String nextIndex = id < 0 ? "" : String.valueOf(id);
		final String NEXT_ATTRIBUTE_NAME = Constants.PARAMETER_LAST_MODIFIED + nextIndex;

		ServiceParameter nextAttribute = new ServiceParameter(serviceid, NEXT_ATTRIBUTE_NAME, "");

		try
		{
			nextAttribute.delete(con);
		}
		catch(SQLException ex)
		{
			// don't care if attribute have existed before deletion
		}

		String value = null;

		if (modifiedServiceParameter != null) 
		{
			value = modifiedServiceParameter.getValue();
		} 
		else 
		{
			// If the service parameter does not exists, then the undo action is to remove it again. This will be done in the undoModify jsp
			// if the ##REMOVE_IT## value is set in value!!!!
			value = "##REMOVE_IT##";
		}

		ServiceParameter lastModifiedAttribute = ServiceParameter.findByServiceidattribute(con, serviceid, ATTRIBUTE_NAME);

		if(lastModifiedAttribute == null) 
		{
			lastModifiedAttribute = new ServiceParameter();
			lastModifiedAttribute.setServiceid(serviceid);
			lastModifiedAttribute.setAttribute(ATTRIBUTE_NAME);
			lastModifiedAttribute.setValue(attribute);
			lastModifiedAttribute.store(con);
		} 
		else 
		{
			serviceParameters.put(ATTRIBUTE_NAME, attribute);
		}

		ServiceParameter lastModifiedAttributeValue = ServiceParameter.findByServiceidattribute(con, serviceid, ATTRIBUTE_VALUE);

		if(lastModifiedAttributeValue == null) 
		{
			lastModifiedAttributeValue = new ServiceParameter();
			lastModifiedAttributeValue.setServiceid(serviceid);
			lastModifiedAttributeValue.setAttribute(ATTRIBUTE_VALUE);
			lastModifiedAttributeValue.setValue(value);
			lastModifiedAttributeValue.store(con);
		} 
		else 
		{
			serviceParameters.put(ATTRIBUTE_VALUE, value);
		}
	}

	void saveAttributeForUndo(Connection con, String serviceid, String attribute, HashMap serviceParameters) throws SQLException
	{
		saveAttributeForUndo(con, serviceid, attribute, serviceParameters, -1);
	}
}
