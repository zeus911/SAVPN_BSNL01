
/*
 ***************************************************************************
 *
 * (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P. 
 *
 ************************************************************************
 */


package com.hp.ov.activator.crmportal.action;

import java.io.IOException;
import java.util.Hashtable;
import java.util.Locale;
import java.util.Vector;
import javax.servlet.*;
import javax.servlet.http.*;
import org.apache.struts.action.*;
import org.apache.struts.*;
import org.apache.log4j.Logger;
import com.hp.ov.activator.crmportal.utils.*;


/**
 * Implementation of <strong>LogoutAction</strong> that processes a
 * user logoff, which particulry includes invalidating the session.
 *
 * @author 
 * @author 
 * @version $Revision: 1.7 $ $Date: 2010-10-05 14:19:07 $
 */

public class LogoutAction extends Action
{
    /**
     * Logoff the user.
     * The event is logged if the debug level is >= Constants.DEBUG.
     *
     * @param mapping The ActionMapping used to select this instance
     * @param actionForm The ActionForm bean for this request (if any)
     * @param request The HTTP request we are processing
     * @param response The HTTP response we are creating
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet exception occurs
     */

    public LogoutAction() 
    {
        //System.out.println("LogoutAction constructor invoked");
    }

    
    public ActionForward execute(
         ActionMapping mapping,
         ActionForm form,
         HttpServletRequest request,
         HttpServletResponse response)
    throws java.io.IOException, javax.servlet.ServletException
    {
        Logger logger = Logger.getLogger("CRMPortalLOG");

        // Extract attributes we will need
        HttpSession session = request.getSession(false);

        if (session != null)
        {
            String user = (String) session.getAttribute(Constants.USER_KEY);

            if (user != null)
            {
                logger.debug("LogoutAction:: Remove user: " +user);
                // Remove login user
                session.removeAttribute(Constants.USER_KEY);
            }
            else
                logger.debug("LogoutAction:: No user");

            // Delete session
            logger.debug("LogoutAction:: Delete session");
            session.invalidate();
        }
        else
            logger.debug("LogoutAction:: No session");

        // Return success
        return (mapping.findForward(Constants.SUCCESS));
    }
} // end LogoutAction
// vim:softtabstop=4:shiftwidth=4:expandtab
