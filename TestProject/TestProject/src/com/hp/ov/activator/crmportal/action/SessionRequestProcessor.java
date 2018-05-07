/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */

package com.hp.ov.activator.crmportal.action;

import java.io.UnsupportedEncodingException;
import java.util.Enumeration;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import org.apache.struts.action.RequestProcessor;
import com.hp.ov.activator.crmportal.utils.Constants;

public class SessionRequestProcessor extends RequestProcessor {
    protected boolean processPreprocess (
    HttpServletRequest request,
    HttpServletResponse response)
    {
        Logger logger = Logger.getLogger("CRMPortalLOG"); 
        ServletContext context	= getServletContext();
        String encoding = context.getInitParameter("Encoding");
        HttpSession session = null;
        String Path = request.getServletPath();

        try {
            if(encoding == null)
            {
                encoding = "UTF-8";
                //logger.debug("SessionRequestProcessor:: Encoding set to: " +encoding );	
                request.setCharacterEncoding(encoding); 
            }
        } catch (UnsupportedEncodingException e) {
            logger.error("SessionRequestProcessor:: Could not set the encoding to" +encoding );
        }

        // These lines are  to get a print in portal.log of all parameters transferred between pages.
        /* Enumeration myenum = request.getParameterNames();
        String param = null;
        String value = null;

        while (myenum.hasMoreElements()) {
            param = myenum.nextElement().toString();
            value = request.getParameter(param);
            logger.debug(param + " = " + value);
        }
        */

        logger.debug("SessionRequestProcessor:: Path: " +Path);

        // If login/logout process, session allowed to be invalid 
        if( (Path.indexOf("Login") >= 0) || (Path.indexOf("Logout") >= 0))
        {
            logger.debug("SessionRequestProcessor:: Login/Logout in Path: " +Path);
            return true;
        }

        // Check session is valid
        if(request.isRequestedSessionIdValid()) {
            session = request.getSession();

            //Check if userName attribute is in session. If so, it means user has already logged in
            if( session.getAttribute(Constants.USER) != null)
            {
                logger.debug("SessionRequestProcessor:: Valid Session for user: "+session.getAttribute(Constants.USER));  
                return true;
            }
            else {
                logger.debug("SessionRequestProcessor:: No user in session. Redirecting to login page");  
            }
        }
        else { //session expired
            logger.debug("SessionRequestProcessor:: Session expired. Redirecting to login page");  
        }
        
        // We must redirect to login page
        try {
            // sendRedirect to "redirect" will fail (aparently forwards can not be used).
            // Hence, the web.xml defined error page (loginError.jsp) will be instantiated.
            // This may be preferred instead of providing e.g. a proper URI like /Login.do !
            response.sendRedirect("redirect");
        } catch(Exception ex) {
            logger.error("SessionRequestProcessor:: Exception redirecting"+ex);
        }
        return false;
    }
}

// vim:softtabstop=4:shiftwidth=4:expandtab
