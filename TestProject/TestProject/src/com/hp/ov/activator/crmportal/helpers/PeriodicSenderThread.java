
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;

import com.hp.ov.activator.crmportal.bean.Service;
import com.hp.ov.activator.crmportal.bean.ServiceParameter;
import com.hp.ov.activator.crmportal.common.*;
import com.hp.ov.activator.crmportal.utils.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;
import java.io.IOException;
import java.text.ParseException;
import java.text.ParsePosition;

import org.apache.log4j.Logger;

public class PeriodicSenderThread extends Thread {
	private String host;
	private String port;
	private String templateDir;
	private String logDirectory;
	private DatabasePool databasePool;
	/**
	 * Time in minutes for thread for sleeping
	 */
	private int periodicInterval;

	Logger logger = Logger.getLogger("CRMPortalLOG");
	private static final int MILLS_IN_MINUTE = 60000;
	private static final Date FUTURE_START_TIME = new Date(3460914000000L);
	private static final Date FUTURE_END_TIME = new Date(3531592800000L);
	private boolean isRunning = false;


	public PeriodicSenderThread(String host, String port, String templateDir, String logDirectory, DatabasePool pool, String periodicInterval) {
		this.host = host;
		this.port = port;
		this.templateDir = templateDir;
		this.logDirectory = logDirectory;
		databasePool = pool;
		this.periodicInterval = Integer.parseInt(periodicInterval) * MILLS_IN_MINUTE;
	}

	/**
	 * @return the timestamp before startTime or endTime when request should be send to OVSA
	 */
	private long getActiveInterval() {
		return periodicInterval * 2;
	}

	public void run() {
		isRunning = true;
		try {
			logger.debug("PERIODIC: STARTED");
			sleep(periodicInterval);
			logger.debug("PERIODIC: WAKING");
			while (true) {
				Connection connection = null;
				long currentTime = 0;
				long nextStartTime = 0;
				synchronized (this) {
					try {
						connection = databasePool.getConnection();
						logger.debug("GOT CONNECTION: "+connection);
						if (PortalSyncListener.DEBUG) {
							logger.debug("PERIODIC: Got connection");
						}

						// get the services to send
						currentTime = new Date().getTime();
						nextStartTime = currentTime + periodicInterval;
						final String whereClause = "NextOperationTime is not null and NextOperationTime > 0 and NextOperationTime < " + (currentTime + getActiveInterval());
						Service[] services = Service.findAll(connection, whereClause);
						services = services == null ? new Service[0] : services;

						if (PortalSyncListener.DEBUG) {
							logger.debug("PERIODIC: Services found:" + services.length);
						}
						for (int i = 0; i < services.length; i++) {
							proccedService(connection, services[i], currentTime);
						}
						currentTime = new Date().getTime();


					} catch (Exception e) {
						logger.error("Error while proceeding service", e);
					} finally {
						//logger.debug("RELEASED CONNECTION: "+connection);
						databasePool.releaseConnection(connection);
					}
				}
				final long timeToSleep = nextStartTime - currentTime;
				logger.debug("PERIODIC: READY TO SLEEP: " + timeToSleep);
				if (timeToSleep > 0)
					sleep(timeToSleep);
				logger.debug("PERIODIC: WOKE UP");
			}
		} catch (InterruptedException e) {
			logger.error("Periodic sender was interrupted", e);
		}

		isRunning = false;

	}

	private void proccedService(Connection connection, Service service, long currentTime) throws SQLException {
		final String oldState = service.getState();
		// If service has an "In progress" state then skip it
		if (!oldState.equals("Periodic_Modify_Ok") &&
						!oldState.equals("Periodic_Modify_PE_Ok") &&
						!oldState.equals("Periodic_Modify_Failure") &&
						!oldState.equals("Periodic_Modify_PE_Failure")) {
			return;
		}


		final String serviceType = service.getType();


		String newState = oldState.indexOf("PE") == -1 ? "Periodic_Modify_Request_Sent" : "PE_Periodic_Modify_Request_Sent";
		if (PortalSyncListener.DEBUG) {
			logger.debug("PERIODIC: Service type/oldState/newState:\t" + serviceType + "\t/" + oldState + "\t/" + newState);
		}
		// Fetching service parameters
		ServiceParameter[] parameters = ServiceParameter.findByServiceid(connection, service.getServiceid());
		parameters = parameters == null ? new ServiceParameter[0] : parameters;
		final HashMap serviceParameters = new HashMap(parameters.length);
		for (int i = 0; i < parameters.length; i++) {
			final ServiceParameter parameter = parameters[i];
			serviceParameters.put(parameter.getAttribute(), parameter.getValue());
		}

		// prepare default values
		serviceParameters.put("HOST", this.host);
		serviceParameters.put("PORT", this.port);
		serviceParameters.put("TEMPLATE_DIR", this.templateDir);
		serviceParameters.put("LOG_DIRECTORY", this.logDirectory);
		serviceParameters.put("type", serviceType);
		serviceParameters.put("serviceid", service.getServiceid());
		final IdGenerator idGenerator = new IdGenerator(connection);
		serviceParameters.put("messageid", idGenerator.getMessageId());

		String lastSchOperation = (String) serviceParameters.get("hidden_lastSchOperation");
		final String periodicity = (String) serviceParameters.get("Period");
		final Date duration = Constants.SCHEDULED_DATE_FORMAT.parse((String) serviceParameters.get("Duration"), new ParsePosition(0));
		boolean sendImmediatelly = false;
		long nextActivation;
		long thisActivation = -1;
		boolean continueWithoutActivation = false;

		try {
			// count next time
			long startTime = Constants.SCHEDULED_DATE_FORMAT.parse((String) serviceParameters.get("StartTime")).getTime();
			long endTime = Constants.SCHEDULED_DATE_FORMAT.parse((String) serviceParameters.get("EndTime")).getTime();
			if (PortalSyncListener.DEBUG) {
				logger.debug("PERIODIC: Service startTime/endTime/currentTime:\t" + new Date(startTime) + "\t/" + new Date(endTime) + "\t/" + new Date(currentTime));
			}


			startTime = getNextDate(startTime, currentTime, periodicity);
			endTime = getNextDate(endTime, currentTime, periodicity);
			// the next operation should be end time operation(undo)
			if ("StartTime".equals(lastSchOperation)) {
				// If end time is missed end time then request should be send immideatelly
				if (endTime > startTime && endTime < currentTime) {
					sendImmediatelly = true;
					nextActivation = getNextDate(startTime, periodicity);
					lastSchOperation = "EndTime";
					startTime = nextActivation;
					endTime = getNextDate(endTime, periodicity);
				} else {
					if (endTime < currentTime)
						endTime = getNextDate(endTime, periodicity);
					// If there are lots of time before end time then do not send anything just wait untill next wakeup period
					if (endTime - currentTime > getActiveInterval()) {
						nextActivation = endTime;
						continueWithoutActivation = true;
						newState = oldState;
					} else {
						// increase start and end time
						thisActivation = endTime;
						startTime = getNextDate(startTime, periodicity);
						endTime = getNextDate(endTime, periodicity);
						nextActivation = startTime;
						lastSchOperation = "EndTime";
					}
				}// if (endTime > startTime)
			} else {
				// the next operation should be start time operation
				if (startTime > endTime || (startTime < currentTime && currentTime < endTime)) {
					// If end time is missed end time then request should be send immideatelly
					sendImmediatelly = true;
					if (startTime > endTime)
						nextActivation = getNextDate(endTime, periodicity);
					else
						nextActivation = endTime;
					lastSchOperation = "StartTime";
					endTime = nextActivation;
				} else {
					if (startTime < currentTime)
						startTime = getNextDate(startTime, periodicity);
					if (endTime < startTime)
						endTime = getNextDate(endTime, periodicity);
					// If there are lot of time before end time then do not send anything just wait untill next wakeup period
					if (startTime - currentTime > getActiveInterval()) {
						nextActivation = startTime;
						continueWithoutActivation = true;
						newState = oldState;
					} else {
						// increase start and end time
						thisActivation = startTime;
//						endTime = getNextDate(endTime, periodicity);
						nextActivation = endTime;
						lastSchOperation = "StartTime";
					}
				}

			} // if ("StartTime".equals(lastSchOperation))
			serviceParameters.put("hidden_lastSchOperation", lastSchOperation);
//			System.out.println("nextActivation = " + nextActivation);
//			System.out.println("duration.getTime() = " + duration.getTime());
			// If the next activation is after duration time then stop periodic sends
			if (duration != null && nextActivation >= duration.getTime()) {
//				System.out.println("duration = " + duration);
				nextActivation = 0;
//				System.out.println("oldState = " + oldState);
				if (oldState.indexOf("Failure") != -1)
					newState = oldState.substring("Periodic_".length());
				else
					newState = oldState.substring("Periodic_Modify_".length());
//				System.out.println("newState = " + newState);
				if (thisActivation > duration.getTime() && lastSchOperation.equals("EndTime")) {
					continueWithoutActivation = true;
				}
			}


			if (PortalSyncListener.DEBUG) {
				logger.debug("PERIODIC: Service startTime/endTime/nextTime:\t" + new Date(startTime) + "\t/" + new Date(endTime) + "\t/" + newState);
			}

			serviceParameters.put("StartTime", Constants.SCHEDULED_DATE_FORMAT.format(new Date(startTime)));
			serviceParameters.put("EndTime", Constants.SCHEDULED_DATE_FORMAT.format(new Date(endTime)));

			service.setState(newState);
			service.setNextoperationtime(nextActivation);
			ServiceUtils.updateService(connection, service);

			if (!continueWithoutActivation) {
				//reordering parameters
				switchRealParamsWithUndoes(serviceParameters);
			}

			final ServiceParameter parameter = new ServiceParameter(service.getServiceid(), "", "");
			final Iterator iterator = serviceParameters.keySet().iterator();
			while (iterator.hasNext()) {
				final String key = (String) iterator.next();
				final String value = (String) serviceParameters.get(key);
				if (PortalSyncListener.DEBUG) {
					logger.debug("PERIODIC: key/value"+key+"\t"+value);
				}
				parameter.setAttribute(key);
				parameter.setValue(value);
				parameter.update(connection);
			}

			final String action = (String) serviceParameters.get("hidden_PeriodicAction");
			serviceParameters.put("ACTION", action);

			serviceParameters.remove("StartTime");
			serviceParameters.remove("EndTime");

			if (!continueWithoutActivation) {
				if (!sendImmediatelly)
					serviceParameters.put("StartTime", Constants.SCHEDULED_DATE_FORMAT.format(new Date(thisActivation)));

				final SendXML sender = new SendXML(serviceParameters);
				sender.Init();
				sender.Send();
			}

			if (PortalSyncListener.DEBUG) {
				logger.debug("PERIODIC: Service sent");
			}

		} catch (ParseException e) {
			logger.error("Error while parsing data", e);
			service.setState("Periodic_Modify_PE_Failure");
			ServiceUtils.updateService(connection, service);
		} catch (Exception e) {
			logger.error("Error while sending periodic message", e);
			service.setState("Periodic_Modify_PE_Failure");
			ServiceUtils.updateService(connection, service);
		}


	}

	public static void switchRealParamsWithUndoes(HashMap parametersMap) {
		String attributeNameKey = Constants.PARAMETER_LAST_MODIFIED;
		String attributeNameValue = (String) parametersMap.get(attributeNameKey);
		String attributeValueKey = Constants.PARAMETER_LAST_MODIFIED_VALUE;
		String attributeValueValue = (String) parametersMap.get(attributeValueKey);
//      ServiceParameter parameter = new ServiceParameter(service.getServiceid(), null, null);
		int index = 0;
		while (attributeNameValue != null) {
			parametersMap.put(attributeValueKey, parametersMap.get(attributeNameValue));
			parametersMap.put(attributeNameValue, attributeValueValue);
			attributeNameKey = Constants.PARAMETER_LAST_MODIFIED + index;
			attributeNameValue = (String) parametersMap.get(attributeNameKey);
			attributeValueKey = Constants.PARAMETER_LAST_MODIFIED_VALUE + index++;
			attributeValueValue = (String) parametersMap.get(attributeValueKey);
		}

	}

	public void addService(Connection connection, String serviceid, String startTime, String endTime, String period, String duration) throws ParseException, SQLException {
		if (!isRunning)
			throw new IllegalStateException("Periodic sender is not running. Please restart the JBoss");

		connection = databasePool.getConnection();
		final Service service = Service.findByPrimaryKey(connection, serviceid);

		ServiceParameter lastSchOperation = ServiceParameter.findByServiceidattribute(connection, serviceid, "hidden_lastSchOperation");
		if (lastSchOperation != null) {
			lastSchOperation.setValue("StartTime");
			lastSchOperation.update(connection);
		} else {
			lastSchOperation = new ServiceParameter(serviceid, "hidden_lastSchOperation", "StartTime");
			lastSchOperation.store(connection);
		}

		final long nextActivation = Constants.SCHEDULED_DATE_FORMAT.parse(endTime).getTime();
		service.setNextoperationtime(nextActivation);

		ServiceUtils.updateService(connection, service);

	}

	private static long getNextDate(long startDate, String periodicity) {
		final GregorianCalendar nextStartTime = new GregorianCalendar();
		nextStartTime.setTimeInMillis(startDate);

		if ("5min".equals(periodicity)) {
			nextStartTime.set(Calendar.MINUTE, nextStartTime.get(Calendar.MINUTE) + 5);
		} else if ("Daily".equals(periodicity)) {
			nextStartTime.set(Calendar.DATE, nextStartTime.get(Calendar.DATE) + 1);
		} else if ("Weekly".equals(periodicity)) {
			nextStartTime.set(Calendar.DATE, nextStartTime.get(Calendar.DATE) + 7);
		} else if ("Monthly".equals(periodicity)) {
			nextStartTime.set(Calendar.MONTH, nextStartTime.get(Calendar.MONTH) + 1);
		} else
			return -1;

		return nextStartTime.getTimeInMillis();

	}

	private static long getNextDate(long startDate, long maximumDate, String periodicity) {

		final GregorianCalendar nextStartTime = new GregorianCalendar();
		nextStartTime.setTimeInMillis(startDate);
		long result = startDate;
		while (nextStartTime.getTimeInMillis() < maximumDate) {
			result = nextStartTime.getTimeInMillis();
			if ("5min".equals(periodicity)) {
				nextStartTime.set(Calendar.MINUTE, nextStartTime.get(Calendar.MINUTE) + 5);
			} else if ("Daily".equals(periodicity)) {
				nextStartTime.set(Calendar.DATE, nextStartTime.get(Calendar.DATE) + 1);
			} else if ("Weekly".equals(periodicity)) {
				nextStartTime.set(Calendar.DATE, nextStartTime.get(Calendar.DATE) + 7);
			} else if ("Monthly".equals(periodicity)) {
				nextStartTime.set(Calendar.MONTH, nextStartTime.get(Calendar.MONTH) + 1);
			} else
				return -1;
		}

		return result;
	}

	public void removeService(Connection connection, String serviceid) throws SQLException {

		synchronized (this) {
			final Service service = Service.findByPrimaryKey(connection, serviceid);
			if (service == null)
				throw new IllegalStateException("Service not found. ServiceId is wrong.");
			final String oldState = service.getState() != null ? service.getState() : "";
			// If the service is not in progress
			if (oldState.equals("Periodic_Modify_PE_Failure") ||
							oldState.equals("Periodic_Modify_Failure") ||
							oldState.equals("Periodic_Modify_PE_Ok") ||
							oldState.equals("Periodic_Modify_Ok")) {

				final String newState;
				if (service.getState().indexOf("Failure") != -1)
					newState = oldState.substring("Periodic_".length());
				else
					newState = oldState.substring("Periodic_Modify_".length());

				service.setState(newState);
				service.setNextoperationtime(0);

			} else {
				final ServiceParameter parameter = new ServiceParameter(serviceid, "hidden_lastSchOperation", "EndTime");
				parameter.update(connection);
				// 1 is set to enlist this service to the next thread's wakeup.
				// The state of the service will beM set to Ok but no periodic activation will occur
				service.setNextoperationtime(1);
				// setting old dates to ensure that no more periodic activations will occur
				parameter.setAttribute("StartTime");
				parameter.setValue(Constants.SCHEDULED_DATE_FORMAT.format(FUTURE_START_TIME));
				parameter.update(connection);
				parameter.setAttribute("EndTime");
				parameter.setValue(Constants.SCHEDULED_DATE_FORMAT.format(FUTURE_END_TIME));
				parameter.update(connection);
			}

			ServiceUtils.updateService(connection, service);
		}
	}

}

