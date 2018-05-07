
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;


import com.hp.ov.activator.crmportal.bean.Message;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Hashtable;

import com.hp.ov.activator.crmportal.utils.*;
import org.apache.log4j.Logger;


public class MessageDispatcher
{
 private static final String PK_START_TAG = Constants.PK_START_TAG;
 private static final String PK_END_TAG = Constants.PK_END_TAG;

 private static final String STATUS_START_TAG = Constants.STATUS_START_TAG ;
 private static final String STATUS_END_TAG = Constants.STATUS_END_TAG ;

 private static final String DATA_START_TAG = Constants.DATA_START_TAG;
 private static final String DATA_END_TAG = Constants.DATA_END_TAG;
 private static final String DATA_EMPTY_TAG = Constants.DATA_EMPTY_TAG;

 // default timeout for Cleaner thread to sleep between activities
 private static final int SLEEP_TIMEOUT = Constants.SLEEP_TIMEOUT;
 private final Hashtable queues;
  DatabasePool dbp;
  Connection connection = null;
  Logger logger = Logger.getLogger("CRMPortalLOG");


 public MessageDispatcher(Connection con) throws SQLException 
	 {
   queues = new Hashtable();
   this.connection = con;
   try 
	   {
        //logger.info("CONNECTION IN MESSG DISPATCHER CLASS:  " + connection);

     // messages should be sorted by messageId
     final Message[] messages = Message.findAll(connection);

     final int length = (messages == null ? 0 : messages.length);
     if (PortalSyncListener.DEBUG)
     {
       logger.debug("FOUND SAVED MESSAGES: length = " + length);
     }

     SaSyncThread queue;
     if(length >0)
      {
         for (int i = 0; i < length; i++)
         {
       final Message message = messages[i];
       if (PortalSyncListener.DEBUG)
       {
         logger.debug(message.getMessageid() + "\tserviceid= " + message.getServiceid() + "\tstate= " + message.getState());
       }
    
	   queue = (SaSyncThread) queues.get(message.getServiceid());
       if (PortalSyncListener.DEBUG) 
       {
         logger.debug("Searching queue with id = "+message.getServiceid());
       }
       if (queue == null)
       {
         queue = new SaSyncThread(connection);
         queues.put(message.getServiceid(), queue);
         if (PortalSyncListener.DEBUG) {
           logger.debug("New queue created");
         }
       }
       queue.addMessage(message);
       if (PortalSyncListener.DEBUG)
         logger.debug("Message added to the queue");

       queue.processMessages();
         }//for
     }//if
     
   }//TRY
   catch (SQLException e)
   {
	 logger.error("MessageDispatcher::Error "+e); 
     e.printStackTrace();
     throw e;
   } 

   new Cleaner().start();
 }

 public void handleMessage(long messageId, StringBuffer saResponse) {

   logger.info("*******************************************************************"); 
   logger.info("Msg Dispatcher - handleMessage: ("+ messageId +") response from SA ="+saResponse);
   logger.info("*******************************************************************"); 


   // Find the two areas of interest in the response
   if(PortalSyncListener.DEBUG){
         logger.debug("("+ messageId +")Handle message started.");
       }
   int startTag = saResponse.indexOf(PK_START_TAG);
   int endTag = saResponse.indexOf(PK_END_TAG);

   String serviceId;
   if (startTag != -1 && endTag != -1) {
     serviceId = saResponse.substring(startTag + PK_START_TAG.length(), endTag);
   } else {
     logger.error("SaSyncThread ERROR: ("+ messageId +")The response from SA did not contain the expected syntax, sync cancelled.");
     return;
   }

   startTag = saResponse.indexOf(STATUS_START_TAG);
   endTag = saResponse.indexOf(STATUS_END_TAG);

   String status;
   if (startTag != -1 && endTag != -1) {
     status = saResponse.substring(startTag + STATUS_START_TAG.length(), endTag);
   } else {
     logger.error("SaSyncThread ERROR: ("+ messageId +")The response from SA did not contain the expected syntax, sync cancelled.");
     return;
   }

   startTag = saResponse.indexOf(DATA_START_TAG);
   endTag = saResponse.indexOf(DATA_END_TAG);

   int emptyTag = saResponse.indexOf(DATA_EMPTY_TAG);

   String data = null;
   if ( emptyTag == -1 ) {
     if (startTag != -1 && endTag != -1) {
       data = saResponse.substring(startTag + DATA_START_TAG.length(), endTag);
     } else {
       logger.error("SaSyncThread ERROR: The response from SA did not contain the expected syntax, sync cancelled.");
       return;
     }
   }

   // process messages
   final Message message = new Message(messageId,messageId, serviceId, status, data, "");
 
   try {
        	  
		 connection = PortalSyncListener.dbp.getConnection();

		 if(connection==null) 
		   { 
         logger.info("connection is null in message dispatcher handlemessage method " );
             }

     SaSyncThread queue;
     synchronized (queues) {
       if(PortalSyncListener.DEBUG){
         logger.debug("("+ messageId +")Searching for a queue. " +
         		"serviceId = "+serviceId);
       }
       queue = (SaSyncThread) queues.get(serviceId);
       if (queue == null) {
         if(PortalSyncListener.DEBUG){
           logger.debug("("+ messageId +")Queue not found, creating a new");
         }
         queue = new SaSyncThread(connection);
         queues.put(serviceId, queue);
       }
       
       if (PortalSyncListener.DEBUG) {
         logger.debug("(" + messageId + ")adding th" +
         		"e message:" + message.getMessageid() + 
         		"\t" + message.getServiceid() + "\t" + 
         		message.getState() + "\t" + message.getData());
       }
       queue.addMessage(message);
       if (PortalSyncListener.DEBUG) {
         logger.debug("("+ messageId +")message added to the queue");
         logger.debug("(" + messageId + ")Getting connection." +
         		" serviceId = " + serviceId);
       }

       //connection = dbp.getConnection();

       if (PortalSyncListener.DEBUG) {
         logger.debug("(" + messageId + ")Got connection. serviceId = " 
        		 + serviceId);
       }
       message.store(connection);

       if (PortalSyncListener.DEBUG) {
         logger.debug("(" + messageId + ")Message stored. serviceId = " 
        		 + serviceId);
       }
     }
     queue.processMessages();
   } catch (SQLException e) {
     logger.error("SaSyncThread ERROR: (" + messageId + ")Unable to " +
     		"save message, sync cancelled.");
     e.printStackTrace();
   } 
   finally {
	   
		   PortalSyncListener.dbp.releaseConnection (connection);
	 
   }
 }

 class Cleaner extends Thread {
   public void run() {
     while (true) {
       try {
         sleep(SLEEP_TIMEOUT);
         if(PortalSyncListener.DEBUG){
           logger.debug("Removing message queues that aren't in use");
         }
       } catch (InterruptedException e) {
         e.printStackTrace();
       }

       synchronized (queues) {
         final Enumeration enumeration = queues.keys();
         while (enumeration.hasMoreElements()) {
           String key = (String) enumeration.nextElement();
           SaSyncThread processor = (SaSyncThread) queues.get(key);
           if (!processor.isRunning()) {
             queues.remove(key);
             if (PortalSyncListener.DEBUG) {
               logger.debug("removed: " + key);
             }
           }
         }
       }
       if (PortalSyncListener.DEBUG) {
         logger.debug("done");
       }
     }

   }

 }


}

