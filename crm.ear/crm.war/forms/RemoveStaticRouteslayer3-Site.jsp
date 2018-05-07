<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>

<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- -*- html -*- --%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>

<%@page info="remove static routes"
  import="com.hp.ov.activator.crmportal.action.*, java.sql.*, com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*, java.text.*, java.net.*" %>


<%
     //load param parameters got here
   ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
   HashMap serviceParameters = new HashMap ();
   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
  
  int rowCounter;
  String existingStaticRoutes;
  
  try {
    rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
  } catch (Exception e) {
    rowCounter = 0;
  } %>

<%try {
   
    existingStaticRoutes = (String)serviceParameters.get("STATIC_Routes");
  } catch (Exception e) { %>
    <B><bean:message key="err.staticroutes" /></B>: <%= e.getMessage () %>.
<%  return;
  } 
  if (existingStaticRoutes != null && !existingStaticRoutes.equals(""))
	      { %>
    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.del.route" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.route" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.mask" /></b></td>
    </tr>
    <% rowCounter++; %>

<%  StringTokenizer routes = new StringTokenizer(existingStaticRoutes, ",");
    StringTokenizer routeElements = null;
    
    String routeAndMask = null;
    String route = null;
    String mask = null;
    int index = 0;
    String addressFamily = (String)request.getAttribute("AddressFamily");
	
     while (routes.hasMoreTokens()) {
       routeAndMask = routes.nextToken();
       routeElements = new StringTokenizer(routeAndMask, "/");
       route = routeElements.nextToken();
       mask = routeElements.nextToken();
		String tempMask = null;
		tempMask = mask;
		%>
       <tr height="30">
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
         <td align=left class="list<%= (rowCounter % 2) %>">
           <input type=checkbox name="deleteCheckBox<%= index %>">
           <input type="hidden" name="route<%= index %>" value="<%= route %>/<%= mask %>">
         <td align=left class="list<%= (rowCounter % 2) %>"><%= route %> </td>
         <td align=left class="list<%= (rowCounter % 2) %>"><%= tempMask %> </td>
       </tr>
<%     rowCounter++; 
       index++;
     }
   } else {
      // hide commit button
        session.setAttribute("NO_COMMIT", "true");

%>
     <tr height="30">
       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
       <td valign="middel" align="center" colspan="2" class="list<%= (rowCounter % 2) %>">
	   <b><bean:message key="err.no.routes.exist" />&nbsp;&nbsp;&nbsp;</b>
         <a href="javascript:window.history.go(-2);">
         <img src="images/back.gif" border="0" alt="return"></a>
       </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	   
     </tr>
     <% rowCounter++; %>
     <tr height="15">
       <td class="list<%= (rowCounter % 2) %> " colspan=4 >&nbsp;</td>
     </tr>
<%   return;
   } 

   if (rowCounter % 2 == 0) { %>
     <tr height="30">
       <td class="list<%= (rowCounter % 2) %> " colspan=4 >&nbsp;</td>
     </tr>
<% } %>

   <input type="hidden" name="Remove_Static_Routes" value="true">
       
