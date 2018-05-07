
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.helpers;

import org.apache.log4j.Logger;

import java.sql.Connection;
import java.sql.SQLException;
import java.net.Socket;
import java.io.BufferedReader;
import java.io.InputStreamReader;

public class MessageReciever extends Thread{
  private Socket syncSocket;
  private long messageId;
  private BufferedReader in;
  private StringBuffer saResponse = new StringBuffer();
  Logger logger = Logger.getLogger("CRMPortalLOG");

  public void run() {
    logger.debug("MessageReciever INFO: ("+ messageId +")MessageReciever started, handling request: Thread_id = " + toString());
    if (getResponse()) {
      handleResponse();
    }
    logger.debug("MessageReciever INFO: ("+ messageId +")MessageReciever stopping, request handled: Thread_id = " + toString());

  }

  private void handleResponse() 
  {
			  
           // PortalSyncListener.messageDispatcher.handleMessage(messageId, saResponse );
	    
  }

  public MessageReciever(Socket syncSocket, long id) {
    this.syncSocket = syncSocket;
    this.messageId = id;
  }

   private boolean getResponse()
  {
    try{
      in = new BufferedReader(new InputStreamReader(syncSocket.getInputStream(), "UTF-8"));

      String line = null;

      // Reads from the socket as long as there is anything to read.
      while((line = in.readLine()) != null) {
        saResponse.append(line);
      }
    } catch (Exception e) {
      logger.error("MessageReciever ERROR: ("+ messageId +")Synchronisation failed, socket closing");
      e.printStackTrace();
      return false;
    } finally {
      if (in != null) {
        try {
          in.close();
        } catch(Exception e) {
          logger.error("MessageReciever ERROR: ("+ messageId +")Could not close inputstream in MessageReciever, ignoring error");
        }
      }

      if (syncSocket != null) {
        try {
          syncSocket.close();
        } catch(Exception e) {
          logger.error("MessageReciever ERROR: ("+ messageId +")Could not close client socket in MessageReciever, ignoring error");
        }
      }
    }
    return true;
  }

}
