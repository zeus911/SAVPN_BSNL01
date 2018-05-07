<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>


<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>


<%@page info="Leave VPN"%>
<%@ page import="java.util.Enumeration,java.util.HashMap,
                 com.hp.ov.activator.crmportal.action.*,
				 com.hp.ov.activator.crmportal.bean.*"%>

<%
    //load param parameters got here
   ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
   HashMap serviceParameters = new HashMap ();
   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
   HashMap parentServiceParameters = new HashMap ();
   parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");
   String serviceid = serviceForm.getServiceid();
   String parentserviceid = serviceForm.getParentserviceid();

    //String customerId = (String) serviceParameters.get("customerid");
	String customerId =serviceForm.getCustomerid();
    customerId = customerId == null ? "" : customerId;
	String siteServiceId = (String)request.getParameter("siteServiceId");
	request.setAttribute("siteServiceId", siteServiceId); 
	String searchSite = (String)request.getParameter("searchSite");	
	request.setAttribute("searchSite", searchSite);
	

    String failureLink = "/crm/ListAllServices.do?customerid="+customerId+"&doResetReload=true&mv=null";
	if(searchSite != null && !searchSite.equals(""))
			failureLink="SearchSiteSubmit.do?serviceid="+siteServiceId+"&doResetReload=true&mv=null";
    String link_part1 = "'/crm/ModifyService.do?type=layer3-Attachment&serviceid=" + serviceid +
                          "&customerid=" + customerId+
                          "&parentserviceid=' + form.parentserviceid.value" +
                          "+'&attachmentid=' + form.attachmentid.value" +
                          "+'&action=" + request.getParameter("action");

    String selectedVPNid = (String)request.getAttribute("vpnId");
	  //System.out.println("selectedVPNid ======"+selectedVPNid);
    selectedVPNid = selectedVPNid != null? selectedVPNid : serviceForm.getParentserviceid();
  //System.out.println("selectedVPNid ======"+selectedVPNid);

    // checking if the site is member of the multicast group in this VPN
    boolean restrictLeave = false;

    if(selectedVPNid != null)
		{
      boolean multicastEnabledBoth = "enabled".equals(serviceParameters.get("MulticastStatus")) && "enabled".equals(parentServiceParameters.get("MulticastStatus"));
      if(multicastEnabledBoth && String.valueOf(serviceParameters.get("MulticastVPNId")).equals(String.valueOf(parentServiceParameters.get("MulticastVPNId"))))
        restrictLeave = true;
    }

     //System.out.println("restrictLeave ======"+restrictLeave);

    int rowCounter;
  try {
      rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
  } catch (Exception e) {
        rowCounter = 0;
  }

    
    Service[] services = serviceForm.getServices();
	 //System.out.println("services ======"+services);
    Customer customer = serviceForm.getCustomer();
	 //System.out.println("customer ======"+customer);
    

	//jacqie - PR 15284
	String customerName = "";
	if (selectedVPNid != null && !selectedVPNid.equals("")) {
		
		customerName = (String)request.getAttribute("owner");

	}else {
		customerName = customer == null? "":customer.getCompanyname();
	 //System.out.println("customerName ======"+customerName);
		
	}
	

%>
<tr height="30">
        <td class="list<%= (rowCounter % 2) %>"></td>
        <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.owner" /></b></td>
        <td class="list<%= (rowCounter % 2) %>"><%=customerName%></td>
        <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>
<%rowCounter++;%>
<%
    if(services == null){
      session.setAttribute("NO_COMMIT", "TRUE");
%>
      <tr height="30">
        <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
        <td valign="middel" align="center" colspan="2" class="list<%= (rowCounter % 2) %>">
		<b><bean:message key="err.novpn" />&nbsp;&nbsp;&nbsp;</b>
          <a href="<%=failureLink%>">
            <img src="images/back.gif" border="0" alt="return"></a>
          </td>
        <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      </tr>
      <% rowCounter++; %>
      <tr height="15">
        <td class="list<%= (rowCounter % 2) %> " colspan=4 >&nbsp;</td>
      </tr>
<%
    }
else if(restrictLeave)
	{
        session.setAttribute("NO_COMMIT", "TRUE");
%>
      <tr height="30">
        <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
        <td valign="middel" align="center" colspan="2" class="list<%= (rowCounter % 2) %>">
		<b><bean:message key="err.nonmember.multicast" />&nbsp;&nbsp;&nbsp;</b>
          <a href="<%=failureLink%>">
            <img src="images/back.gif" border="0" alt="return"></a>
          </td>
        <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      </tr>
      <% rowCounter++; %>
      <tr height="15">
        <td class="list<%= (rowCounter % 2) %> " colspan=4 >&nbsp;</td>
      </tr>
      <% rowCounter++; %>
<%
    }
else if(services.length == 1)
	{
        session.setAttribute("NO_COMMIT", "TRUE");
%>
      <tr height="30">
        <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
        <td valign="middel" align="center" colspan="2" class="list<%= (rowCounter % 2) %>">
		<b><bean:message key="err.no.owner.vpn" />&nbsp;&nbsp;&nbsp;</b>
          <a href="<%=failureLink%>">
            <img src="images/back.gif" border="0" alt="return"></a>
          </td>
        <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      </tr>
      <% rowCounter++; %>
      <tr height="15">
        <td class="list<%= (rowCounter % 2) %> " colspan=4 >&nbsp;</td>
      </tr>
      <% rowCounter++; %>
<%
    }
   else
	{
		//System.out.println("else part ======");
%>
      <tr height="30">
        <td class="list<%= (rowCounter % 2) %>"></td>
        <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.leave" /></b></td>
        <td class="list<%= (rowCounter % 2) %>">
       <select name="vpnId" onchange="location.href=<%= link_part1 %>&vpnId='+document.ServiceForm.vpnId.value">
<%
     //System.out.println("services.length ======"+services.length);
      Service selectedService = null;
      boolean select;
      for (int i = 0; i < services.length; i++)
		  {
            Service service = services[i];
           if(service.getServiceid().equals(selectedVPNid)){
          selectedService = service;
          select = true;
        }else
          select = false;
        
%>
         <option value="<%=service.getServiceid()%>" <%=select ? "selected" : ""%>><%=service.getPresname()%> (id:<%=service.getServiceid()%>)</option>
<%
      }
%>
              </select>
          </td>
          <td class="list<%= (rowCounter % 2) %>"></td>
      </tr>
<%
      
        VPNMembership[] memberships =(VPNMembership[])request.getAttribute("memberships");
		//System.out.println("memberships ======"+memberships);
		if(memberships!=null){
			//System.out.println("memberships length ======"+memberships.length);
        if(memberships.length <= 1)
			{
          session.setAttribute("NO_COMMIT", "!");
%>
<tr height="30">
        <td class="list<%= (rowCounter % 2) %>"></td>
        <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
        <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
        <td class="list<%= (rowCounter % 2) %>"><a href="<%=failureLink%>"><img src="images/back.gif" border="0" title="return"></a></td>

</tr>
<%
        }
		}

    }
%>


