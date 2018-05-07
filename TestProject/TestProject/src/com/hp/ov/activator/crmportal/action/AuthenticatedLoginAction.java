package com.hp.ov.activator.crmportal.action;

import java.rmi.Naming;
import java.util.HashSet;
import java.util.Set;

import javax.naming.InitialContext;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.apache.struts.Globals;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionServlet;

import com.hp.ov.activator.crmportal.helpers.PortalSyncListener;
import com.hp.ov.activator.crmportal.utils.Constants;
import com.hp.ov.activator.crmportal.utils.DatabasePool;
import com.hp.ov.activator.mwfm.WFAuthenticator;
import com.hp.ov.activator.mwfm.WFManager;

public class AuthenticatedLoginAction extends Action
{

  private static final String INIT_PARAM_DB_FAILURE_TEST = "DB_Failure_test";
  private static final String INIT_PARAM_MWFM_AUTHENTICATOR = "mwfm_authenticator";
  private static final String INIT_PARAM_RECORDS_PER_PAGE = "recordsPerPage";
  private static final String INIT_PARAM_SYNC_LISTENER_PORT = "Sync_Listener_port";

  private static final String KEY_ERROR_INVALID_LOGIN = "error.invalid.login";

  private static final String LOGGER_NAME = "CRMPortalLOG";

  private static final String PREFIX_SAVPN_ROLE = "SAVPN_CRM_";

  private Logger logger = Logger.getLogger(LOGGER_NAME);

  public AuthenticatedLoginAction()
  {
  }

  public ActionForward execute(ActionMapping mapping, ActionForm form,
      HttpServletRequest request, HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException
  {

    HttpSession session;
    ActionErrors actionerrors = new ActionErrors();
    ActionServlet actionServ = this.getServlet();
    ServletConfig sc = actionServ.getServletConfig();
    PortalSyncListener syncListener = null;
    DatabasePool dbp = null;

    // Invalidate session if it exists
    session = request.getSession(false);
    if (session != null) {
      session.invalidate();
    }
    session = request.getSession(true);

    actionerrors = ((LoginForm)form).validate(mapping, request);

    if (actionerrors.size() == 0)
    {
      //Init Param values for the actionservlet     
      if (getInitialParameters(actionServ, session)) {
        throw new ServletException("Login Action:: failed to load init parameters");
      }

      //Initialize DataSource
      try {
        final InitialContext context = new InitialContext();
        final DataSource datasource = (DataSource)context.lookup(Constants.DATASOURCE_NAME);
        dbp = new DatabasePool(datasource);
      } catch (Exception e) {
        String errorText = "Error getting db pool: <br><br>" + e;
        logger.error("LoginAction:: Login problem: " + errorText, e);
        throw new ServletException("Login Action:: failed to initialize datasource: " + e.getMessage());
      }

      // Save the dbpool in the session
      session.setAttribute(Constants.DATABASE_POOL, dbp);

      // Start the synchronization listener thread.
      try {
        // Ensures that only ONE instance of the listener is created.
        if (syncListener == null)
        {
          logger.debug("LoginAction:: Start synchronisation listener ...");
          int listenerPort = Integer.parseInt(servlet.getInitParameter(INIT_PARAM_SYNC_LISTENER_PORT));
          boolean dbFailureTest = Boolean.parseBoolean(servlet.getInitParameter(INIT_PARAM_DB_FAILURE_TEST));
          syncListener = new PortalSyncListener(sc, listenerPort, dbp, dbFailureTest);
          syncListener.start();
        }
      } catch (Exception e) {
        syncListener = null;
        String errorText = "Synchronisation listener failed startup. <br><br>" + e;
        logger
            .error("LoginAction:: Synchronisation listener port (Sync_Listener_port) is not specified in configuration");
        logger.error("LoginAction:: CRM synchronisation listener thread problem: " + errorText, e);
        logger.info("Login Action:: Unable to establish a connection to the DB");
        throw new ServletException("Login Action:: Unable to establish a DB connection: " + e.getMessage());
      }

      // Obtain username and password from web tier
      LoginForm loginForm = (LoginForm)form;
      
	  //String userId = java.net.URLDecoder.decode(loginForm.getUserId(), "UTF-8");
      //String password = java.net.URLDecoder.decode(loginForm.getPassWord(), "UTF-8");
	  
	  String userId = loginForm.getUserId();
      String password = loginForm.getPassWord();
      
	  logger.debug("LoginAction:: Login request for username: " + userId);

      // Verify user credentials
      try {
        Set<String> roles = authorizeUser(userId, password);
        logger.info("LoginAction:: Login request accepted: " + userId);
        session.setAttribute(Constants.USER, userId);
        session.setAttribute(Constants.ROLES_KEY, roles);
        return mapping.findForward(Constants.SUCCESS);
      } catch (LoginException e) {
        logger.info(String.format("LoginAction:: Login request failed for user '%s': %s", userId, e.getMessage()));
        if (e.isInvalidCredentials()) {
          ActionErrors ae = new ActionErrors();
          ae.add("userId", new ActionMessage(KEY_ERROR_INVALID_LOGIN));
          request.setAttribute(Globals.ERROR_KEY, ae);
        }
      }
    }

    session.invalidate();
    return mapping.findForward(Constants.FAILURE);
  }


  private Set<String> authorizeUser(String user, String password) throws LoginException
  {
    WFAuthenticator wfauthenticator = null;
    try {
      wfauthenticator = (WFAuthenticator)Naming.lookup(servlet.getInitParameter(INIT_PARAM_MWFM_AUTHENTICATOR));
    } catch (Exception e) {
      logger.error("LoginAction:: Connection to MWFM authenticator failed: " + e.getMessage());
      throw new LoginException("Failed to connect to MWFM authenticator", null, false);
    }

    WFManager wfmanager = null;
    try {
      wfmanager = wfauthenticator.login(user, password);
    } catch (Exception e) {
      throw new LoginException("Failed to authenticate user", e, true);
    }

    if (wfmanager == null) {
      throw new LoginException("Failed to authenticate user", null, true);
    }

    HashSet<String> roleSet = new HashSet<String>();
    try {
      String[] roles = wfmanager.getUMM().getUserRolesExt(user);
      for (String role : roles) {
        String vpnRole = vpnRoleForHPSARole(role);
        if (vpnRole != null) {
          roleSet.add(vpnRole);
        }
      }
    } catch (Exception e) {
      logger.error("LoginAction:: Failed to retrieve user roles: " + e.getMessage());
      throw new LoginException("Failed to retrieve user roles", e, false);
    }
    return roleSet;

  }

  private String vpnRoleForHPSARole(String role)
  {
    if (role.startsWith(PREFIX_SAVPN_ROLE) && role.length() > PREFIX_SAVPN_ROLE.length()) {
      return role.substring(PREFIX_SAVPN_ROLE.length());
    } else {
      return null;
    }
  }

  /*
   * Fetch Initial Params
   */
  private boolean getInitialParameters(ActionServlet actionServ, HttpSession session)
  {
    //	 Initial Parameters
    String errorURL, successURL, logDir, templateDir, recordsPerPage;
    String socketListener_port, socketListener_host, request_synchronisation;
    String rolesFilePath = Constants.rolesFilePath;
    String errorText = null;
    boolean error = false;

    successURL = actionServ.getInitParameter(Constants.LOGIN_SUCCESS);
    errorURL = actionServ.getInitParameter(Constants.LOGIN_FAILURE);
    logDir = actionServ.getInitParameter(Constants.LOGS_DIRECTORY);
    templateDir = actionServ.getInitParameter(Constants.TEMPLATE_DIR);
    if (actionServ.getInitParameter(Constants.PATH_TO_ROLES) != null)
      rolesFilePath = actionServ.getInitParameter(Constants.PATH_TO_ROLES);

    socketListener_port = servlet.getInitParameter(Constants.SOCKET_LIS_PORT);
    socketListener_host = servlet.getInitParameter(Constants.SOCKET_LIS_HOST);
    request_synchronisation = servlet.getInitParameter(Constants.REQUEST_SYNCHRONISATION);
    recordsPerPage = servlet.getInitParameter(INIT_PARAM_RECORDS_PER_PAGE);

    logger.debug("LoginAction:: logDir: " + logDir);
    logger.debug("LoginAction:: templateDir: " + templateDir);
    logger.debug("LoginAction:: SocketListener port: " + socketListener_port);
    logger.debug("LoginAction:: SocketListener_host: " + socketListener_host);

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
      session.setAttribute(Constants.LOG_DIRECTORY, logDir);
      session.setAttribute(Constants.LOGIN_SUCCESS, successURL);
      session.setAttribute(Constants.LOGIN_FAILURE, errorURL);
      session.setAttribute(Constants.TEMPLATE_DIR, templateDir);
      session.setAttribute(Constants.SOCKET_LIS_PORT, socketListener_port);
      session.setAttribute(Constants.SOCKET_LIS_HOST, socketListener_host);
      session.setAttribute(Constants.REQUEST_SYNCHRONISATION, request_synchronisation);
      session.setAttribute(INIT_PARAM_RECORDS_PER_PAGE, recordsPerPage);
    }
    return error;
  }


}

@SuppressWarnings("serial")
class LoginException extends Exception
{
  boolean invalidCredentials = false;

  public LoginException(String message, Throwable cause, boolean invalidCredentials)
  {
    super(message, cause);
    this.invalidCredentials = invalidCredentials;
  }

  public boolean isInvalidCredentials()
  {
    return invalidCredentials;
  }

}
