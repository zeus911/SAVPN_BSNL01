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


<%@page info="Modify Corporate VPN topology"
  import="com.hp.ov.activator.crmportal.action.*, java.sql.*, com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*, java.text.*, java.net.*" %>



<%
 //load param parameters got here
   ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
   HashMap serviceParameters = new HashMap ();
   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
 
  String customerId = (String) serviceParameters.get("customerid");
  customerId = customerId == null ? "" : customerId;
  String siteServiceId = (String)request.getParameter("siteServiceId");
	request.setAttribute("siteServiceId", siteServiceId); 
	String searchSite = (String)request.getParameter("searchSite");	
	request.setAttribute("searchSite", searchSite);
  String failureLink = "/crm/ListAllServices.do?customerid="+customerId+"&doResetReload=true&mv=true";
  if(searchSite != null && !searchSite.equals(""))
			failureLink="SearchSiteSubmit.do?serviceid="+siteServiceId+"&doResetReload=true&mv=null";
  int rowCounter;

  try {
    rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
  } catch (Exception e) {
    rowCounter = 0;
  }

  String currentTopology;

  currentTopology = (String)serviceParameters.get("VPNTopology");
  String multicastStatus = (String)serviceParameters.get("MulticastStatus");  
  if("enabled".equals(multicastStatus)){
    session.setAttribute("NO_COMMIT", "TRUE");    

%>    
  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td valign="middle" align="center" colspan="2" class="list<%= (rowCounter % 2) %>">
    <b><bean:message key="err.topologymodify.disabledvpn" /></b>
      <a href="<%=failureLink%>">
        <img src="images/back.gif" border="0" alt="return"></a>
      </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  </tr>
    
<% rowCounter++;   
  }
  else{
  %>
  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.modl3vpn.topology" /></b></td>
    <td class="list<%= (rowCounter % 2) %>" align=left>
      <select name="SP_VPNTopology">
<%      if (currentTopology != null) { %>
          <option <%= currentTopology.equals("Hub-and-Spoke") ? " selected": "" %> value="Hub-and-Spoke">Hub and spoke</option>
          <option <%= currentTopology.equals("Full-Mesh") ? " selected": "" %> value="Full-Mesh">Full mesh</option>
<%      } %>      
      </select>
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
   </tr>

  <% rowCounter++; 
  }
  %>

   <tr height="15">
     <td class="list<%= (rowCounter % 2) %>" colspan=4 >&nbsp;</td>
   </tr>



