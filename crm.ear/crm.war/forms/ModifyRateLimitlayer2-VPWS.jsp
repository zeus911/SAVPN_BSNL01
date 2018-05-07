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


<%@page info="Modify Rate limit"
  import="com.hp.ov.activator.crmportal.action.*, java.sql.*, com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*, java.text.*, java.net.*" %>


<%

  //load param parameters got here
   ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
   HashMap serviceParameters = new HashMap ();
   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
   HashMap parentServiceParameters = new HashMap ();
   parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");
   String serviceid = serviceForm.getServiceid();
   String parentserviceid = serviceForm.getParentserviceid();

  CAR[] rateLimits = null;
  String rateLimit = "";
  boolean isError = false;


  int rowCounter;

  try {
    rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
  } catch (Exception e) {
    rowCounter = 0;
  }

  try {
  
    rateLimits = (CAR[])request.getAttribute("rateLimits");
    rateLimit = (String)serviceParameters.get("RL");
  } catch (Exception e) { %>
    <B><bean:message key="errs.RL.inven" /></B>: <%= e.getMessage () %>.
<%  
    isError = true;
  } %>

  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.multi.RL" /></b></td>
    <td align=left class="list<%= (rowCounter % 2) %>">
    <select name="SP_RL">
<%    
      for (int i = 0; i < rateLimits.length; i++) {
%>
        <option<%= rateLimits[i].getPrimaryKey().equals(rateLimit) ? " selected" : "" %> value="<%= rateLimits[i].getPrimaryKey() %>"><%= rateLimits[i].getPrimaryKey() %><bean:message key="label.bps" /></option>
<%    }
%>
    </select>
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
  </tr>
  <% rowCounter++; %>
<%
  boolean allowPeriodicity = true;
%>
<%@ include file="SchedulingParams.jsp" %>

    <% rowCounter++;
      if(isError){
        session.setAttribute("NO_COMMIT", "TRUE");
      }
    %>



