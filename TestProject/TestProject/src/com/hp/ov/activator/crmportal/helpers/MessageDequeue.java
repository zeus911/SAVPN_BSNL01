package com.hp.ov.activator.crmportal.helpers;


import com.hp.ov.activator.crmportal.bean.Message;
import org.apache.log4j.Logger;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;


import com.hp.ov.activator.crmportal.utils.*;
import com.hp.ov.activator.crmportal.dataaccess.*;
import java.sql.Connection;
import java.sql.SQLException;


import java.util.*;
import java.io.*;


public class MessageDequeue extends Thread
{

	Connection connection;
	long messageId;
	Logger logger = Logger.getLogger("CRMPortalLOG");

	public MessageDequeue(Connection connection,long messageId)
	{
		this.connection = connection;
		this.messageId = messageId;

	}

	
	/*
	 * Dequeues message from DB and calls SaSyncThread for state updation .
	 * It also removes the messageId from Memory queue(queueMap) after processing.
	 * 
	 */
	public void run()
	{
		
		try
		{
			logger.debug("Dequeue Thread started for messageId:"+messageId);
			boolean flag = true;
			
			while(flag)
			{
				
				long idd = messageId;
				String whereClause = " messageid = '"+idd+"'";
				try
				{
					Message message[] = Message.findAll(connection,whereClause);
					
					for(int i=0;i<message.length;i++)
					{
						SaSyncThread saSyncObj = new SaSyncThread(connection);
						saSyncObj.proceedMessage(connection, message[i].getServiceid(), message[i].getState(), message[i].getData(), message[i].getResponsedata());
						boolean status = message[i].delete(connection);
						logger.debug("Removing Message from DB" +messageId);
					 }
				}
				catch (SQLException se)
				{
					logger.error("MessageDequeue ERROR: Failed to remove Message from DB, MessageId:"+messageId);
					 throw se;
				}
				catch (Exception e)
				{
					logger.error("MessageDequeue ERROR: Failed to remove Message from DB, MessageId:"+messageId);
					 e.printStackTrace();
				}
				MessageHelper msghelper = MessageHelper.MessageHelperSingletongetInstance();
				HashMap queueMap =  msghelper.getQueuemap();
				synchronized(msghelper)
				 {
					try
					{
						int count = Message.findAllCount(connection,whereClause);
						if(count==0)
						 {
							logger.debug("Removing messageId from Memory queue" +messageId);
							queueMap.remove(Long.toString(messageId));
							msghelper.setQueuemap(queueMap);
							flag=false;
							break;
						  }		
					}
					catch (SQLException se)
					{
						logger.error("MessageDequeue ERROR: Failed to remove Message from Memory Queue, MessageId:"+messageId);
						 throw se;
					}
					catch (Exception e)
					{
						logger.error("MessageDequeue ERROR: Failed to remove Message from Memory Queue, MessageId:"+messageId);
						e.printStackTrace();
					}
				 }
	
			 }
		}
		catch(Exception e)
		{
			logger.error("MessageDequeue ERROR");
			e.printStackTrace();
			
		}
		
	
	}





}  
