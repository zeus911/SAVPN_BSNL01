<%-- *- html -*- --%>
<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->

<%
    // Make the page expire
    response.setHeader ("Expires", "Mon, 01 Jan 1990 00:00:00 GMT");

    // Check if there is a valid session available.
    if (session == null || session.getValue (Constants.USER) == null) {
       response.sendRedirect ("../../login_error.html");
       return;
    }
%>