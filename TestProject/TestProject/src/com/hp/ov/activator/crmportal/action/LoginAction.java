/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */


package com.hp.ov.activator.crmportal.action;

import java.io.File;
import java.io.FileNotFoundException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import org.apache.struts.action.*;
import org.apache.struts.config.ModuleConfig;
import org.apache.struts.*;
import org.apache.log4j.Logger;
import com.hp.ov.activator.crmportal.utils.*;
import com.hp.ov.activator.crmportal.plugin.*;
import com.hp.ov.activator.crmportal.helpers.BasicAuthenticator;
import com.hp.ov.activator.crmportal.helpers.PortalSyncListener;




/**
* Implementation of <strong>LoginAction</strong> 
* that validates a user logon.
*
*/
public class LoginAction extends Action 
{
	
	public LoginAction() 
	{
		//System.out.println("LoginAction constructor invoked");
	}
   
   /**
    * 
    * The event is logged if the debug level is >= Constants.DEBUG.
    *
    */
   
   public ActionForward execute(ActionMapping mapping, ActionForm form,
                HttpServletRequest request, HttpServletResponse response)
                throws java.io.IOException, javax.servlet.ServletException
   {  
        boolean error = false;
		boolean dbConnError = false;
        HttpSession session; 
        ActionErrors actionerrors = new ActionErrors();
        ActionServlet actionServ = this.getServlet();
        ServletContext servletContext = actionServ.getServletContext();
        ServletConfig sc = actionServ.getServletConfig();
        PortalSyncListener syncListener = null;
        File file = new File( servletContext.getRealPath(Constants.WEB_INF));	  
        DatabasePool dbp = null;
        String userId = null;
        String passWord = null;
        BasicAuthenticator basicAuthenticator = null; 
        Logger logger = Logger.getLogger("CRMPortalLOG");
	   
        // Invalidate session if it exists
        session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        session = request.getSession(true);
	   
        actionerrors = ((LoginForm) form).validate(mapping,request);
        // System.out.println("ACTION>>ERRORS"+actionerrors+"size::"+actionerrors.size());
	        
        LoginValidateBean lb = new LoginValidateBean();
        request.setAttribute("LoginValidateBean", lb);
        lb.setParameters(request);
        ActionErrors ae = lb.validate();
        request.setAttribute(Globals.ERROR_KEY, ae);
	        
        if(actionerrors.size()== 0)   
        {
            //Init Param values for the actionservlet     
            error = getInitialParameters(actionServ,session);

            // InitialiZe BasicAuthenticator
            basicAuthenticator = initBasicAuthenticator(file);
	           
            //Initialize DataSource
            try {
                final InitialContext context = new InitialContext();
                final DataSource datasource = (DataSource) context.lookup(Constants.DATASOURCE_NAME);
                dbp = new DatabasePool(datasource);
            } catch (Exception e) {
                e.printStackTrace();
                error = true;
                String errorText = "Error getting db pool: <br><br>" + e;
                logger.error("LoginAction:: Login problem: " + errorText, e);
            }

            // Save the dbpool in the session
            if(dbp!=null) {
                session.setAttribute(Constants.DATABASE_POOL, dbp); 
            } else {
                logger.error("LoginAction:: Login problem: db pool is null");
                error = true;
            }
                
            // Start the synchronisation listener thread.
            try {
                // Ensures that only ONE instance of the listener is created.
                if (error == false && syncListener == null)
                {
                    logger.debug("LoginAction:: Start synchronisation listener ...");
                    int listenerPort = Integer.parseInt( servlet.getInitParameter ("Sync_Listener_port"));
					boolean dbFailureTest = Boolean.parseBoolean( servlet.getInitParameter ("DB_Failure_test"));
                    syncListener = new PortalSyncListener(sc,listenerPort,dbp,dbFailureTest);
                    syncListener.start();
                }
            } catch (Exception e) {
                e.printStackTrace();
                syncListener = null;
                error = true;
				dbConnError = true;
                String errorText = "Synchronisation listener failed startup. <br><br>" + e;
                logger.error("LoginAction:: Synchronisation listener port (Sync_Listener_port) is not specified in configuration");
                logger.error("LoginAction:: CRM synchronisation listener thread problem: " + errorText, e);
            }
                
            // Obtain username and password from web tier
            userId = ((LoginForm) form).getUserId();
            passWord = ((LoginForm) form).getPassWord();
            logger.debug("LoginAction:: Login request for username: " +userId);
        
            // Verify'S the user's credentials
            if (basicAuthenticator != null && (userId != null && passWord != null)) {
                error = authorizeUser(basicAuthenticator,session,userId,passWord);
            }
        }

        if ((!error)&&(!dbConnError))
        {
            //login success
            // Save our logged-in user in the session
            logger.info("LoginAction:: Login request accepted: " + userId);
            session.setAttribute(Constants.USER, userId);
        
            // Return success
            return (mapping.findForward(Constants.SUCCESS));
        } else {    
			if (dbConnError)
			{
				// credentials don't match
				logger.info("Login Action:: Unable to establish a connection to the DB");
				throw new ServletException("Login Action:: Unable to establish a connection to the DB");
			}
			else
			{
				// credentials don't match
				logger.info("LoginAction:: Login request invalid: " + userId);

				// return to input page
				return (new ActionForward(mapping.getInput()));
			}
        }
    }
   
   
   /*
    * Fetch Initial Params
    */
   private boolean getInitialParameters(ActionServlet actionServ,HttpSession session)
   {
        //	 Initial Parameters
	    //System.out.println("INSIDE LOGIN ACTION CLASS ");
	    String errorURL, successURL, logDir, templateDir,recordsPerPage;
	    String socketListener_port, socketListener_host,request_synchronisation;
	    String rolesFilePath = Constants.rolesFilePath;
            String errorText = null;
	   // HashMap initParamsMap = new HashMap();
	    boolean error = false;
	    Logger logger = Logger.getLogger("CRMPortalLOG");
	    
	    successURL = actionServ.getInitParameter(Constants.LOGIN_SUCCESS); 
	    errorURL = actionServ.getInitParameter (Constants.LOGIN_FAILURE);    
	    logDir = actionServ.getInitParameter (Constants.LOGS_DIRECTORY);    
	    templateDir = actionServ.getInitParameter (Constants.TEMPLATE_DIR);   
	    if(actionServ.getInitParameter(Constants.PATH_TO_ROLES) != null)
		rolesFilePath = actionServ.getInitParameter(Constants.PATH_TO_ROLES);

            socketListener_port = servlet.getInitParameter (Constants.SOCKET_LIS_PORT);
            socketListener_host = servlet.getInitParameter (Constants.SOCKET_LIS_HOST);
            request_synchronisation = servlet.getInitParameter (Constants.REQUEST_SYNCHRONISATION);
            recordsPerPage = servlet.getInitParameter ("recordsPerPage");
	    
	    logger.debug("LoginAction:: logDir: "+logDir);
	    logger.debug("LoginAction:: templateDir: "+templateDir); 
            logger.debug("LoginAction:: SocketListener port: "+socketListener_port);
	    logger.debug("LoginAction:: SocketListener_host: "+socketListener_host);
            /*logger.debug("loginaction >>"+"request_synchronisation >>"+request_synchronisation);
            logger.debug("loginaction >>"+"recordsPerPage >>"+recordsPerPage);*/
		  
	    //CHK IF ANY  INIT PARAM VALUES ARE NULL !!
	    
        if (errorURL == null || successURL == null || logDir == null || rolesFilePath == null)
        {
            error = true;
            errorText = "One or more of the following parameters <br>" +
            "are missing or unreadable in the web.xml file: <br><br>" +
            "- login_success<br> - login_failure<br> - log_dir<br> - roles_file'";
            logger.error("LoginAction:: CRM portal login problem: " + errorText);
        }
        else
        {  
            // when no error
            error = false;
        	
            // Set session information
            session.setAttribute (Constants.LOG_DIRECTORY, logDir);
            session.setAttribute (Constants.LOGIN_SUCCESS, successURL);
            session.setAttribute (Constants.LOGIN_FAILURE, errorURL);
            session.setAttribute (Constants.TEMPLATE_DIR, templateDir);
            session.setAttribute (Constants.SOCKET_LIS_PORT, socketListener_port);
            session.setAttribute (Constants.SOCKET_LIS_HOST, socketListener_host);
            session.setAttribute (Constants.REQUEST_SYNCHRONISATION, request_synchronisation);
            session.setAttribute ("recordsPerPage", recordsPerPage);
        }
        return error;
   }
   
  /*
   * Initialize basic authenticator
   */
   private BasicAuthenticator initBasicAuthenticator(File file)
   {
	   BasicAuthenticator basicAuthenticator = null;
	   String rolesFilePath = Constants.rolesFilePath;
	   Logger logger = Logger.getLogger("CRMPortalLOG");  
		try {
			 file = new File(file, rolesFilePath);
			 basicAuthenticator = new BasicAuthenticator(file.getAbsolutePath());
			} 
		catch (FileNotFoundException e)
			{
		  e.printStackTrace();
	     // error = true;
	      String errorText = "Error starting authenticator: <br><br>" + e;
		  logger.error("LoginAction:: CRM portal login problem: " + errorText, e);
			}
		return  basicAuthenticator;
   }
   
   



    /*
     * Validate credentials with business tier.      
    */
    private boolean authorizeUser(BasicAuthenticator basicAuthenticator,HttpSession session,
    		                      String user,String password)
    {
    	boolean error = false;
   	    if(basicAuthenticator.authorize(session,user,password))
   	       {	   
				// Set user attribute data
				session.setAttribute (Constants.USER, user);
               error = false; 
			
			}
   	      else
			{
				session.invalidate();
				error = true;
           
           }	
   	    return error;
    }

} // End LoginAction
// vim:softtabstop=4:shiftwidth=4:expandtab
