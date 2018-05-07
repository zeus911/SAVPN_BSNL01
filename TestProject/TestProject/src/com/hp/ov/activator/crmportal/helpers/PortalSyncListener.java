/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */


package com.hp.ov.activator.crmportal.helpers;

import org.apache.log4j.Logger;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.sql.*;

import com.hp.ov.activator.crmportal.utils.*;
import com.hp.ov.activator.crmportal.dataaccess.*;
import com.hp.ov.activator.crmportal.bean.Message;


import java.util.*;
import java.io.*;

public class PortalSyncListener extends Thread 
{
  
  private int listenerPort = 0;
  private long idCounter;
  private ServerSocket listener = null;
  public static final boolean DEBUG = true;
  
  public static ServletConfig servletConfig;
  private PortalListenerDAO portalListenerDAO;
  Logger logger = Logger.getLogger("CRMPortalLOG");
  public static DatabasePool dbp = null;
  Connection connection = null;
 
	public PortalSyncListener(ServletConfig sc,int listenerPort,DatabasePool dbp) throws Exception 
  {
	       
    logger.debug("PortalSyncListener INFO: PortalSyncListener CONSTRUCTOR begins");

     this.listenerPort = listenerPort;
	 this.dbp = dbp;
	 servletConfig=sc;
	 boolean dbready = true;

    try 
	{
		connection = dbp.getConnection();
		this.connection = connection;
							
		logger.info(" connection is === "+connection); 
		if(connection!=null)
		{
			portalListenerDAO =  new PortalListenerDAO(connection); 
			idCounter = portalListenerDAO.getMaxCRMStates(connection);
		}
    }
    catch (Exception e) 
    {
      e.printStackTrace();
      logger.error("CRM portal Error starting database pool: " +  e);
	  dbready=false;
    }
    
	if (dbready)
	{
		logger.debug("***************************************************");
		boolean conflag = false;
		try {
		  logger.debug("PortalSyncListener INFO: Starts listener socket for portal synchronisation input on port " + listenerPort);
		  listener = new ServerSocket(listenerPort);
		  logger.debug("PortalSyncListener INFO: PortalSyncListener CREATED.............");
		} catch (IOException e) {
		  logger.debug("PortalSyncListener WARN: Could not start synchronisation listener on port " + listenerPort + ". Listener may be already running.");
			conflag = true;
		}
		finally
		{
			if(conflag)
			  {
				try
				{
					 if(connection!=null) 
					{
						 dbp.releaseConnection(connection);
					}
				}
				catch (Exception e)
				{
					logger.error("PortalSyncListener ERROR: Could not close Connection.");
				}
			
			}
		
		}
	}
	else
	{
		throw new Exception("CRM portal Error: Unable to connect to database. Stopping ...");
	}
  }
  
  public PortalSyncListener(ServletConfig sc,int listenerPort,DatabasePool dbp, boolean dbFailureTest) throws Exception 
  {
	       
    logger.debug("PortalSyncListener INFO: PortalSyncListener CONSTRUCTOR begins");

     this.listenerPort = listenerPort;
	 this.dbp = dbp;
	 servletConfig=sc;
	 boolean dbready = true;

    try {
	
		if (dbFailureTest)
		{
			throw new Exception("Exception triggered by DB FAILURE TEST.");
		}
		else
		{
			connection = dbp.getConnection();
		
			this.connection = connection;
		
			
			
			logger.info(" connection is === "+connection); 
			if(connection!=null)
			{
				portalListenerDAO =  new PortalListenerDAO(connection); 
				idCounter = portalListenerDAO.getMaxCRMStates(connection);
			}
		}
    }
    catch (Exception e) 
    {
      e.printStackTrace();
      logger.error("CRM portal Error starting database pool: " +  e);
	  dbready=false;
    }
    
	if (dbready)
	{
		logger.debug("***************************************************");
		boolean conflag = false;
		try {
		  logger.debug("PortalSyncListener INFO: Starts listener socket for portal synchronisation input on port " + listenerPort);
		  listener = new ServerSocket(listenerPort);
		  logger.debug("PortalSyncListener INFO: PortalSyncListener CREATED.............");
		} catch (IOException e) {
		  logger.debug("PortalSyncListener WARN: Could not start synchronisation listener on port " + listenerPort + ". Listener may be already running.");
			conflag = true;
		}
		finally
		{
			if(conflag)
			  {
				try
				{
					 if(connection!=null) 
					{
						 dbp.releaseConnection(connection);
					}
				}
				catch (Exception e)
				{
					logger.error("PortalSyncListener ERROR: Could not close Connection.");
				}
			
			}
		
		}
	}
	else
	{
		throw new Exception("CRM portal Error: Unable to connect to database. Stopping ...");
	}
  }

  // The listening job is run in its own thread.
  public void run() {
    try 
	{
		if(listener != null)
		{
		  onRestart();
	      logger.debug("PortalSyncListener INFO: Starts listening for portal synchronisation input on port " + listenerPort);
	      while (true)
	      {
		        // Direct incomming requests to its own thread and socket.
	    	 
	    	  final long id = nextId();
	    	  MessageEnqueue enqueueObj = new MessageEnqueue();
	    	  try
	    	  {
		    	final Socket syncSocket = listener.accept();
		        if(PortalSyncListener.DEBUG){
		          logger.debug("PortalSyncListener INFO: Got socket.");
		        }
		        
		  		if(PortalSyncListener.DEBUG)
		        {
		          logger.debug("PortalSyncListener INFO: Message Enqueue created.");
		        }
		        if (enqueueObj.getResponse(syncSocket))
		  		{
		  			enqueueObj.handleMessage();
		  		}
		  		 enqueueObj.enqueueMessage(id,connection);
		       // callEnqueue(connection,syncSocket,id);
		       
	    	  }
	    	  catch(SQLException sq)
	 		  {
	    		  logger.debug("PortalSyncListener WARN: SQLException caught in synchronisation listener during accept."+sq);
	    		  sq.printStackTrace();
	    		  if((sq.getErrorCode()==17002)||(sq.getErrorCode()==0)||(sq.getErrorCode()==17410))
	    			  reTryConnection(enqueueObj,id); 
	    		  
	 		  }
	    	  catch (Exception e)
	    	  {
	    	      logger.debug("PortalSyncListener WARN: Exception caught in synchronisation listener during accept."+e);
	    	      e.printStackTrace();
	    	      		    	   
	    	  }
		   }
		}
		
    }
    catch (Exception e)
    {
      logger.debug("PortalSyncListener WARN: Exception caught in synchronisation listener during accept. LISTENER STOPPED!!!!!"+e);
      e.printStackTrace();
          

    } 
    finally 
	{
		 
			try
			{
				 if(connection!=null) 
				 {
					 dbp.releaseConnection(connection);
				 }
			}
			catch (Exception e)
			{
				logger.error("PortalSyncListener ERROR: Could not close Connection.");
			}
			if (listener != null)
			{
				try {
				  listener.close();

				} catch (Exception e) {
				  logger.error("PortalSyncListener ERROR: Could not close listener.");
				}
			 }
	
	 }
  }
   
  	/*
	 * This method is Called when MessageEnqueue fails due to db not reachable or restarted. 
	 * This method tries to obtain a valid connection object when db is down or not reachable
	 * or their is no valid connection.
	 *
	 */

  public Connection reTryConnection(MessageEnqueue enqueueObj, long id)
  {
	  
	  try 
	   {
	    	
			while(true)
			{
				try
				{
					connection = dbp.getConnection();
					logger.debug("reTryConnection: Obtainging the new Connection object");
					if(!connection.isClosed())
					{
						enqueueObj.enqueueMessage(id,connection);
						logger.debug("reTryConnection: Got a valid connection object");
						break;
					}
					Thread.sleep(10000);
					
				}
				catch (Exception e)
				{
					logger.error("PortalSyncListener ERROR: While trying to reconnect to db"+e);	
					try
					{
						Thread.sleep(10000);
					}
					catch (Exception e1)
					{
					}
				}
				
			}
				
			
		} 
	    catch (Exception e1) 
		{
			logger.error("PortalSyncListener ERROR: While trying to reconnect to db"+e1);
	    	e1.printStackTrace();
		}
	  return connection;
  }

  	/*
	 * This method is Called on Server Startup. 
	 * This method enqueues Message to DB.It also puts the messageId to Memory queue(queueMap) and starts Dequeue thread.
	 */
  public void onRestart()
  {
	
	 try
	 {
	 	
	 	 logger.debug("onRestart started.");
		 //PR16939 check crm_message exist or not, avoid throw exception from bean
		 	Statement statement = connection.createStatement();
		  ResultSet  resultSet = statement.executeQuery(DAOConstants.getMaxOfCRMStates);
		  Message message[] = Message.findAll(connection);
		 if(message!=null)
		 {
			  Thread.sleep(10000);
			  for(int i=0;i<message.length;i++)
			  {
				 MessageHelper msghelper = MessageHelper.MessageHelperSingletongetInstance();
				 HashMap queueMap =  msghelper.getQueuemap();
				 String id = Long.toString(message[i].getMessageid());
				 boolean dequeueFlag = queueMap.containsKey(id);
				 logger.debug("Memory Queue Flag"+dequeueFlag);
				 synchronized(msghelper)
					{ 
						if(!dequeueFlag)
						{
							logger.debug("Adding messageId to memory queue"+id);
							queueMap.put(id,id);
							msghelper.setQueuemap(queueMap);
								
						}
				   }
				 if(!dequeueFlag)
				 {
					logger.debug("Starting Dequeue Thread for messageId:"+id);
					MessageDequeue dequeueObj = new MessageDequeue(connection,message[i].getMessageid());
					dequeueObj .start();
				 }
			  }
		 }
		  logger.debug("End of onRestart method.");
	 }
	  catch (SQLException e)
	 {
		 logger.error("PortalSyncListener SQL ERROR: Could not Access " + Constants.CRM_STATES_TABLE ,  e);
		}

	 catch (Exception e)
	 {
		 logger.error("PortalSyncListener ERROR: Could not Sync with the Existing DB Messages"+e);
		 e.printStackTrace();
	 }

  
  }
  
  /**
   * Returns next unique identifier for recieved messages
   *
   * @return identifier value
   */
  public synchronized long nextId()
  {
    idCounter++;
    return idCounter;
  }
}