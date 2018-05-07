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
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- -*- html -*- --%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>


<%@page info="Modify CAR"
  import="com.hp.ov.activator.crmportal.action.*, java.sql.*, com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*, java.text.*, java.net.*" %>


<%
    //load param parameters got here
   ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
   HashMap serviceParameters = new HashMap ();
   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
   HashMap parentServiceParameters = new HashMap ();
   parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");

  CAR[] cars = null;
  String car;
  CAR multicastRateLimit = null;


  int rowCounter;

  try {
    rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
  } catch (Exception e) {
    rowCounter = 0;
  }

  try {
    
    cars = (CAR[])request.getAttribute("cars");
    car = (String)serviceParameters.get("CAR");
    final String multicastRLParam = (String) serviceParameters.get("MulticastRateLimit");
    if(multicastRLParam != null && "enabled".equals(serviceParameters.get("MulticastStatus")))
     // multicastRateLimit = CAR.findByRatelimitname(con, multicastRLParam); 
	 multicastRateLimit = (CAR)request.getAttribute("multicastRateLimit");
  } catch (Exception e) 
{ %>
    <B><bean:message key="err.car.inventory" /></B>: <%= e.getMessage () %>.
<%  return;
  } 
  
  
  %>

  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.multi.RL" /></b></td>
    <td align=left class="list<%= (rowCounter % 2) %>">
    <select name="SP_CAR">
<%    
      if (cars != null) 
       {
        String aux = car;
        if (car == null) {
          aux = cars[0].getPrimaryKey();
        }

        for (int i = 0; i < cars.length; i++) 
			{
          if(multicastRateLimit != null && cars[i].getAveragebw() < multicastRateLimit.getAveragebw())
            continue;
%>
          <option<%= cars[i].getPrimaryKey().equals (aux) ? " selected" : "" %> value="<%= cars[i].getPrimaryKey() %>">    <%= cars[i].getPrimaryKey() %><bean:message key="label.bps" /></option>
<%      }
      } %>
    </select>
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
  </tr>
  <% rowCounter++;
    boolean allowPeriodicity = true;  
  %>
  <%@include file="SchedulingParams.jsp"%>