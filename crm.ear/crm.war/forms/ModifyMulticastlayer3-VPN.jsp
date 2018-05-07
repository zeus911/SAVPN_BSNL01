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
   HashMap parentServiceParameters = new HashMap ();
   parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");
   String serviceid = serviceForm.getServiceid();
   String parentserviceid = serviceForm.getParentserviceid();

  String customerId = (String) serviceParameters.get("customerid");
  customerId = customerId == null ? "" : customerId;
   String failureLink = "/crm/ListAllServices.do?customerid="+customerId+"&doResetReload=true&mv=null";
  int rowCounter;

  try {
    rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
  } catch (Exception e) {
    rowCounter = 0;
  }
  String multicastStatus;
  String multicastMode;
  String multicastModeParam;
  String topology;
  int sitesCount = 0;

  try {
    /*
      check if there are multicast members in that VPN
      If there are any do not allow to disable VPN multicast
      add list of the sites
    */
      String strSiteCount = (String)request.getAttribute("sitesCount");
      sitesCount = Integer.parseInt(strSiteCount) ;
    
      multicastStatus = (String)serviceParameters.get("MulticastStatus");
      multicastMode = (String)serviceParameters.get("MulticastMode");
    
      multicastStatus = multicastStatus == null ? "disabled" : multicastStatus;
      topology = (String)serviceParameters.get("VPNTopology");
    
    if(sitesCount > 1 && "enabled".equals(multicastStatus) ){
%>
  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.multi.vpn" /></b></td>
    <td class="list<%= (rowCounter % 2) %>" align=left><bean:message key="label.enbld" /></td>
    <td class="list<%= (rowCounter++ % 2) %>">&nbsp;</td>
  </tr>
  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td valign="middle" align="center" colspan="2" class="list<%= (rowCounter % 2) %>">
     <b><bean:message key="label.multi.has" /> <%=sitesCount-1%> <bean:message key="label.multi.disabling" /></b>
      <a href="<%=failureLink%>">
        <img src="images/back.gif" border="0" alt="return"></a>
      </td>
    <td class="list<%= (rowCounter++ % 2) %>">&nbsp;</td>
  </tr>
<%
    session.setAttribute("NO_COMMIT", "TRUE");

  }else if(!"Full-Mesh".equals(topology) && "disabled".equals(multicastStatus)){
    session.setAttribute("NO_COMMIT", "TRUE");


%>
  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td valign="middle" align="center" colspan="2" class="list<%= (rowCounter % 2) %>">
     <b><bean:message key="label.multicast.availabilty" /></b>
      <a href="<%=failureLink%>">
        <img src="images/back.gif" border="0" alt="return"></a>
      </td>
    <td class="list<%= (rowCounter++ % 2) %>">&nbsp;</td>
  </tr>
<%
    
  }
  else{
%>

  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.multi.vpn" /></b></td>
    <td class="list<%= (rowCounter % 2) %>" align=left>
     <!-- <select id="MulticastStatus" name="MulticastStatus" onChange="switchMode()">-->
	      <select id="MulticastStatus" name="MulticastStatus">
          <option <%= "disabled".equals(multicastStatus) ? " selected": "" %> value="disabled">disabled</option>
          <option <%= "enabled".equals(multicastStatus) ? " selected": "" %> value="enabled">enabled</option>
      </select>
    </td>
    <td class="list<%= (rowCounter++ % 2) %>">&nbsp;</td>	
   </tr>
    
  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td class="list<%= (rowCounter % 2) %>" align=left><b id="mode_title"><bean:message key="label.multi.vpn.mode" /></b></td>
    <td class="list<%= (rowCounter % 2) %>" align=left>
      <select id="MulticastMode" name="SP_MulticastMode" <%= !"enabled".equals(multicastStatus) ? "" : "disabled" %> >
          <option <%= "sparse".equals(multicastMode) ? " selected": "" %> value="sparse">sparse</option>
          <option <%= "sparse-dense".equals(multicastMode) ? " selected": "" %> value="sparse-dense">sparse-dense</option>
      </select>
    </td>
    <td class="list<%= (rowCounter++ % 2) %>">&nbsp;</td>	
  </tr>

  <% }
  
  } catch (Exception e) { %>
    <B><bean:message key="err.multicast.status.inventory" /></B>: <%= e.getMessage () %>.
<%  session.setAttribute("NO_COMMIT", "TRUE");
  } 
%>
   <tr height="15">
     <td class="list<%= (rowCounter % 2) %>" colspan=4 >&nbsp;</td>
   </tr>



