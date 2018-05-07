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
  import="com.hp.ov.activator.crmportal.action.*, com.hp.ov.activator.crmportal.utils.Constants,java.sql.*, com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*, java.text.*, java.net.*" %>


<%
    //load param parameters got here
   ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
   HashMap serviceParameters = new HashMap ();
   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
   HashMap parentServiceParameters = new HashMap ();
   parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");
  
  String customerId = (String) serviceParameters.get("customerid");
  
  CAR[] cars = null;
  String car;
  CAR multicastRateLimit = null;
  String qosCompliant = null;


  int rowCounter;

  try {
    rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
  } catch (Exception e) {
    rowCounter = 0;
  }

  try {
    
    cars = (CAR[])request.getAttribute("rateLimits");

    car = (String)serviceParameters.get("CAR");
    multicastRateLimit = (CAR)request.getAttribute("multicastRateLimit");
	qosCompliant = (String)request.getAttribute("qos_compliance");

		
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


<%
    if(qosCompliant != null && !qosCompliant.equalsIgnoreCase(Constants.COMPLAINT)){

	 String errorMessage = "Modify Ratelimit operation  is supported only on services with VPN SVP compliant QoS profile.&nbsp;&nbsp;&nbsp;";
	    String failureLink = "/crm/ListAllServices.do?customerid="+customerId+"&doResetReload=true&mv=null";
%>
 <tr height="30">
        <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
        <td valign="middle" align="center" colspan="2" class="list<%= (rowCounter % 2) %>"><b><%=errorMessage%></b>
          <a href="<%=failureLink%>">
            <img src="images/back.gif" border="0" alt="return"></a>
          </td>
        <td class="list<%= (rowCounter++ % 2) %>">&nbsp;</td>
      </tr>
  
<%
 session.setAttribute("NO_COMMIT", "TRUE");
}
%>	
  <tr height="15">
     <td class="list<%= (rowCounter % 2) %>" colspan=4 >&nbsp;</td>
   </tr>

