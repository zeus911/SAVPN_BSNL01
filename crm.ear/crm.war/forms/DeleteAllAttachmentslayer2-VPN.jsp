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


<%@page info="Delete All Attachments L2VPN"
  import="com.hp.ov.activator.crmportal.action.*, com.hp.ov.activator.crmportal.utils.Constants,java.sql.*, com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*, java.text.*, java.net.*" %>


<%
    //load param parameters got here
   ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
   HashMap serviceParameters = new HashMap ();
   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
   HashMap parentServiceParameters = new HashMap ();
   parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");
   
   int rowCounter = 0;
  
   String customerId = (String) serviceParameters.get("customerid");
   String serviceid = serviceForm.getServiceid();
  
%>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td align=left colspan="2" class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.deleteallattachments.areyousure1" /></b></td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td align=left colspan="2" class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.deleteallattachments.areyousure2" /></b></td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td align=left colspan="2" class="list<%= (rowCounter % 2) %>"><b><font color="red"><img  src="images/warning.gif"/><bean:message key="label.deleteallattachments.areyousure3" /></font></b></td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>