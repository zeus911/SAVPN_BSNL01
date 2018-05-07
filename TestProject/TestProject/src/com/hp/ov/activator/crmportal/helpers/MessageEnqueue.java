
package com.hp.ov.activator.crmportal.helpers;


import com.hp.ov.activator.crmportal.bean.Message;
import org.apache.log4j.Logger;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;


import com.hp.ov.activator.crmportal.utils.*;
import com.hp.ov.activator.crmportal.dataaccess.*;
import java.sql.Connection;
import java.sql.SQLException;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

import java.util.*;
import java.io.*;

public class  MessageEnqueue
{

	
	private BufferedReader in;
	private StringBuffer saResponse = new StringBuffer();
	String messageId,serviceId,status, data, minorCode, responseData;
	
	private static final String MSGID_START_TAG = Constants.MSGID_START_TAG;
	private static final String MSGID_END_TAG = Constants.MSGID_END_TAG;
	private static final String PK_START_TAG = Constants.PK_START_TAG;
	private static final String PK_END_TAG = Constants.PK_END_TAG;
	private static final String STATUS_START_TAG = Constants.STATUS_START_TAG ;
	private static final String STATUS_END_TAG = Constants.STATUS_END_TAG ;
	private static final String DATA_START_TAG = Constants.DATA_START_TAG;
	private static final String DATA_END_TAG = Constants.DATA_END_TAG;
	private static final String DATA_EMPTY_TAG = Constants.DATA_EMPTY_TAG;
	
	
	Logger logger = Logger.getLogger("CRMPortalLOG");
	Connection connection = null;


	public MessageEnqueue()
	{
		try {
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/*
	 * This method reads response from Socket and stores
	 * it in saResponse(StringBuffer)
	 */
	public boolean getResponse(Socket syncSocket)
	{
		try
		{
			logger.debug("Inside getResponse");
			in = new BufferedReader(new InputStreamReader(syncSocket.getInputStream(), "UTF-8"));
			String line = null;
	
			// Reads from the socket as long as there is anything to read.
			while((line = in.readLine()) != null) 
			{
				saResponse.append(line);
			}
		}
		catch (Exception e)
		{
			logger.error("MessageEnqueue ERROR: While Reading Socket, socket closing");
			e.printStackTrace();
			return false;
		}
		finally 
		{
			if (in != null)
			{
				try 
				{
					in.close();
				} 
				catch(Exception e) 
				{
					logger.error("MessageEnqueue ERROR:Could not close inputstream in MessageEnqueue, ignoring error");
				}
			}
	
			if (syncSocket != null)
			{
				try 
				{
					syncSocket.close();
				} 
				catch(Exception e) 
				{
					logger.error("MessageEnqueue ERROR: Could not close client socket in MessageReciever, ignoring error");
				}
			}
		}
	

		return true;
	}
  
	/*
	 * This method extracts MessageId,ServiceId,Status,Data from saResponse
	 * 
	 */
	 public void handleMessage() 
	 {
			   // Find the two areas of interest in the response
		 try
		 {
			
			 if(PortalSyncListener.DEBUG)
			 {
				 logger.debug("Handle message started.");
			 }
			 //System.out.println("===saResponse==="+saResponse.toString());
               StringReader xmlReader = new StringReader(saResponse.toString());
               InputSource inputSource = new InputSource(xmlReader);
               DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
               DocumentBuilder db = dbf.newDocumentBuilder();
               Document doc = db.parse(inputSource);

               XPathFactory xpathFactory = XPathFactory.newInstance();
               XPath xPath = xpathFactory.newXPath(); 
               
               XPathExpression xPathExpression = xPath.compile(Constants.MESSAGE_ID_PATH);
               messageId = (String)xPathExpression.evaluate(doc, XPathConstants.STRING);
               if(messageId.length()==0){
                 logger.error("MessageEnqueue ERROR:The response from SA did not contain the expected syntax, sync cancelled.");
                 return ;
               }
               
               xPathExpression = xPath.compile(Constants.SERVICE_ID_PATH);
               serviceId = (String)xPathExpression.evaluate(doc, XPathConstants.STRING);
               if(serviceId.length()==0){
                 logger.error("MessageEnqueue ERROR:The response from SA did not contain the expected syntax, sync cancelled.");
                 return ;
               }
                
               xPathExpression = xPath.compile(Constants.STATUS_PATH);
               status = (String)xPathExpression.evaluate(doc, XPathConstants.STRING);
               if(status.length()==0){
                 logger.error("MessageEnqueue ERROR:The response from SA did not contain the expected syntax, sync cancelled.");
                 return ;
               }
               
               xPathExpression = xPath.compile(Constants.DATA_PATH);
               data = (String)xPathExpression.evaluate(doc, XPathConstants.STRING);
               if(data.length()==0){
                 //logger.error("MessageEnqueue ERROR:The response from SA did not contain the expected syntax, sync cancelled.");
                 return ;
               }
			   
			   xPathExpression = xPath.compile(Constants.RESPONSE_DATA);
               responseData = (String)xPathExpression.evaluate(doc, XPathConstants.STRING);
			   
               xPathExpression = xPath.compile(Constants.MINOR_CODE_PATH);
               minorCode = (String)xPathExpression.evaluate(doc, XPathConstants.STRING);		

			   logger.info(">>> handleMessage() >>> minorCode: "+minorCode);
			   
			   logger.info("Handle message for: messageId: "+messageId+", serviceId: "+serviceId+", status: "+status+", data: "+data+", comment: "+responseData);
			 
		 }
		 catch(Exception e)
		 {
			 logger.error("MessageEnqueue ERROR: The response from SA did not contain the expected syntax, sync cancelled 5.");
			 e.printStackTrace();
		 }
	}

	 /*
	  * This method enqueues Message to DB.
	  * It also puts the messageId to Memory queue(queueMap) and starts Dequeue thread.
	  * 
	  */

	public void enqueueMessage(long sequenceId,Connection connection) throws Exception
	{
		
		 try
		 {
			 if(PortalSyncListener.DEBUG)
			 {
				 logger.debug("Enqueue Message started.");
			 }
			
			final Message message = new Message(sequenceId,Long.parseLong(messageId), serviceId, status, data, responseData);
			message.store(connection);
			logger.debug("(" + messageId + ")Message stored. serviceId = "+ serviceId);
			MessageHelper msghelper = MessageHelper.MessageHelperSingletongetInstance();
			HashMap queueMap =  msghelper.getQueuemap();
			boolean dequeueFlag = queueMap.containsKey(messageId);
			 logger.debug("Memory Queue Flag"+dequeueFlag);
			synchronized(msghelper)
			{ 
				if(!dequeueFlag)
				{
					logger.debug("Adding messageId to memory queue"+messageId);
					queueMap.put(messageId,messageId);
					msghelper.setQueuemap(queueMap);
					
				}
			}
			if(!dequeueFlag)
			{
				logger.debug("Starting Dequeue Thread for messageId:"+messageId);
				MessageDequeue dequeueObj = new MessageDequeue(connection,Long.parseLong(messageId));
				dequeueObj.start();
			}
			
	

		 }
		 catch(SQLException sq)
		 {
			 logger.error("MessageEnqueue ERROR: During enqueue message to DB and starting Dequeue thread");
				// e.printStackTrace();
				 throw sq;
		 }
		 catch (Exception e)
		 {
			 logger.error("MessageEnqueue ERROR: During enqueue message to DB and starting Dequeue thread");
			// e.printStackTrace();
			 throw e;
		 }
	}


	
}
