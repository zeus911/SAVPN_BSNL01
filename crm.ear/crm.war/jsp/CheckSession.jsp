<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>               
<%-- $Source: /tmp/vpn/SA_VPN_SP/jboss/server/default/deploy/crmportal.sar/crm.war/jsp/CheckSession.jsp,v $                                                                   --%>
<%-- $Revision: 1.6 $                                                                 --%>
<%-- $Date: 2010-10-05 14:19:35 $                                                                     --%>
<%-- $Author: shiva $                                                                   --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>


<%@page import="java.util.*" %>

<%
  // Make the page expire
  response.setHeader ("Expires", "Mon, 01 Jan 1990 00:00:00 GMT");

  // Check if there is a valid session available.
 /* if (session == null || session.getValue (Constants.USER) == null) {
    response.sendRedirect ("/portal/index.html");
    return;
  }*/


  // Outcomment these lines to get a print on std out of all parameters transferred between pages.
/*
  Enumeration enum = request.getParameterNames();
  String param = null;
  String value = null;

  while (enum.hasMoreElements()) {
	  param = enum.nextElement().toString();
	  value = request.getParameter(param);
	  // System.out.println(param + " = " + value);
  }
*/
%> 
