package com.hp.ov.activator.crmportal.helpers;

import java.util.HashMap;

public class MessageHelper 
{

	private static HashMap queueMap = new HashMap();
	private static MessageHelper instance;
	
	private MessageHelper() {
	}

	public static MessageHelper MessageHelperSingletongetInstance() {
	         if (instance==null)
	                  instance = new MessageHelper();
	return instance;
	
	}

	public synchronized void setQueuemap(HashMap queueMap)
	{
		MessageHelper.queueMap = queueMap;
	}

	public synchronized HashMap getQueuemap()
	{
		return queueMap;
	}

	
}
