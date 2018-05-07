
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.plugin;

import org.apache.struts.action.*;
import org.apache.struts.config.*;

import javax.servlet.ServletException;
import javax.servlet.ServletContext;
import javax.servlet.ServletConfig;
import javax.servlet.http.HttpSession;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.hp.ov.activator.crmportal.helpers.PortalSyncListener;
import com.hp.ov.activator.crmportal.utils.*;

import org.apache.log4j.Logger;

public class StartPortalListenerPlugin implements PlugIn 
{
	public StartPortalListenerPlugin(){}


	public void init (ActionServlet servlet,ModuleConfig mc) throws ServletException
	  {
		    DatabasePool dbp = null;
		   String PLUGIN_NAME_KEY = StartPortalListenerPlugin.class.getName();
		   ServletContext context = null;	   
		   ServletConfig sc =null;
		   StartPortalListenerPlugin objPlugin = new StartPortalListenerPlugin();	   
		   PortalSyncListener syncListener = null;
		   Logger logger = Logger.getLogger("CRMPortalLOG");
		   String  logDir, socketListener_port, socketListener_host,
			                    template_dir, request_synchronisation;
		   boolean error = false;
		   String errorText = null;
		 
		 context = servlet.getServletContext();
		 sc      = servlet.getServletConfig();
		 context.setAttribute(PLUGIN_NAME_KEY, objPlugin);
		 
		 //System.out.println("Inside StartPortalListenerPlugin ...init ...");
		 logDir     = servlet.getInitParameter (Constants.LOG_DIRECTORY);
		// logger.debug("StartPortalListenerPlugin >>"+"logDir >>"+logDir);
		 socketListener_port = servlet.getInitParameter (Constants.SOCKET_LIS_PORT);
		// logger.debug("StartPortalListenerPlugin >>"+"socketListener_port >>"+socketListener_port);
	     socketListener_host = servlet.getInitParameter (Constants.SOCKET_LIS_HOST);
	    // logger.debug("StartPortalListenerPlugin >>"+"socketListener_host >>"+socketListener_host);
		 template_dir        = servlet.getInitParameter (Constants.TEMPLATE_DIR);
		// logger.debug("StartPortalListenerPlugin >>"+"template_dir >>"+template_dir);
		 request_synchronisation = servlet.getInitParameter (Constants.REQUEST_SYNCHRONISATION);
		// logger.debug("StartPortalListenerPlugin >>"+"request_synchronisation >>"+request_synchronisation);
			

		    if (logDir == null || socketListener_port == null ||
		        socketListener_host == null || template_dir == null || 
		        request_synchronisation == null)
		    {
		      error = true;
		      errorText = "One or more of the following parameters <br>" +
		                  "are missing or unreadable in the web.xml file: <br><br>" +
		                  "<br> <br> - log_dir<br> - socketListener_host<br>" +
		                  "- socketListener_port<br> - template_dir<br> - request_synchronisation'";
		      logger.error("CRM portal initial parameter missing : " + errorText);
		    }
		
			
             //		  initialize datasource
		    try {
		      final InitialContext initialcontext = new InitialContext();
		      //final DataSource datasource = (DataSource) initialcontext.lookup("java:/crmportal/jdbc/ServicesDB");
			  final DataSource datasource = (DataSource) initialcontext.lookup(Constants.DATASOURCE_NAME);
		       dbp = new DatabasePool(datasource);
		    } catch (Exception e) {
		      e.printStackTrace();
		      error = true;
		      errorText = "Error starting database pool: <br><br>" + e;
		      logger.error("CRM portal login problem: " + errorText, e);
		    }
			

//		  Start the synchronisation listener thread.
		    try {
		    	
			  logger.debug("PLUG IN CLASS -------------------------------------------start----------- ");
		      if (error == false && syncListener == null) {
		        logger.debug("Starting crm portal synchronisation listener.......");
		        int listenerPort = Integer.parseInt(servlet.getInitParameter("Sync_Listener_port"));
		        syncListener = new PortalSyncListener(sc,listenerPort,dbp);
		        syncListener.start();
		      }
		    } catch (Exception e) {
		      e.printStackTrace();
		      syncListener = null;
		      error = true;
		      errorText = "Could not start the synchronisation listener in startup. <br><br>" + e;
		      logger.error("CRM synchronisation listener thread problem: " + errorText, e);
			  logger.debug("PLUG IN CLASS -----------------------------------------end------------- ");
		    }
         
		   


		
	  }
	
	  public void destroy() 
	    {
	      //System.out.println("Destroying StartPortalListenerPlugin");
	    }

	

}
