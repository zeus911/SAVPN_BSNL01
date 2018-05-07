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


<%@page info="Modify Attachment VPN connectivity type"
        contentType="text/html; charset=UTF-8"
        import="com.hp.ov.activator.crmportal.bean.*,com.hp.ov.activator.crmportal.action.*, java.util.* ,java.io.*,
		java.text.*, java.net.*,java.util.HashSet, com.hp.ov.activator.crmportal.utils.*,com.hp.ov.activator.crmportal.helpers.*, 
		java.sql.ResultSet, java.sql.SQLException, java.sql.PreparedStatement, java.sql.DriverManager, java.util.ArrayList,
		com.hp.ov.activator.crmportal.common.*, org.apache.log4j.Logger, javax.sql.DataSource, java.sql.Connection"
 %>


<%

	//load param parameters got here
	ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
	HashMap serviceParameters = new HashMap ();
	serviceParameters = (HashMap)request.getAttribute("serviceParameters");
	HashMap parentServiceParameters = new HashMap ();
	parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");
	String serviceid = serviceForm.getServiceid();
	String parentserviceid = request.getParameter("parentserviceid");
	String customerId = serviceForm.getCustomerid();
	customerId = customerId == null ? "" : customerId;

	String siteServiceId;
	siteServiceId = (String)serviceParameters.get("Site_Service_id");
	String siteServiceIdSearch = (String)request.getParameter("siteServiceId");
	request.setAttribute("siteServiceId", siteServiceIdSearch); 
	String searchSite = (String)request.getParameter("searchSite");	
	request.setAttribute("searchSite", searchSite);
	
  Connection con = null;
  DataSourceLocator dsl = new DataSourceLocator(); 
  
  PreparedStatement statePstmt = null;
  ResultSet resultSet = null;
  
  boolean isMCASTEnabled = false;
  
  try
	{
		DataSource ds = dsl.getDataSource();
		if (ds != null)
		{
			con = ds.getConnection();
			
			com.hp.ov.activator.vpn.inventory.Site siteObj = com.hp.ov.activator.vpn.inventory.Site.findByServiceid(con, siteServiceId);
			
			if (siteObj != null)
			{
				if ("enabled".equals(siteObj.getMulticast()))
				{
					isMCASTEnabled = true;
				}
			}
			else
			{
				com.hp.ov.activator.vpn.inventory.MulticastSite mcastSiteObj = com.hp.ov.activator.vpn.inventory.MulticastSite.findByAttachmentid(con, serviceid);
				
				if (mcastSiteObj != null)
				{
					isMCASTEnabled = true;
				}
			}
			
			String query = "select l3v.serviceid from v_l3vpn l3v where l3v.parentid = ? and l3v.multicast = 'unsupported'";
						 
			statePstmt = con.prepareStatement(query);
			statePstmt.setString(1, parentserviceid);
			resultSet = statePstmt.executeQuery();
		}             
	}
	catch (SQLException sqle)
	{ %>
		<%= sqle.getMessage () %>.
		<%  return;
	}
	catch (Exception e) 
	{ %>
		<%= e.getMessage () %>.
		<%  return;
	}
	finally
	{
		if (con != null)
		{
			try{ resultSet.close(); }catch(Exception ignoreme){}
			try{ statePstmt.close(); }catch(Exception ignoreme){}
			
			try 
			{
				con.close();
			}
			catch (Exception rollbackex)
			{
				// Ignore
			}
		}
	}
	
	int rowCounter;

	try {
		rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
	} catch (Exception e) {
		rowCounter = 0;
	}
	
	String failureLink = "/crm/ListAllServices.do?customerid="+customerId+"&doResetReload=true&mv=null";
	if(searchSite != null && !searchSite.equals(""))
			failureLink="SearchSiteSubmit.do?serviceid="+siteServiceIdSearch+"&doResetReload=true&mv=null";
	
	
	if (isMCASTEnabled)
	{
		session.setAttribute("NO_COMMIT", "!");
		%>        
		<tr height="30">
				<td class="list<%= (rowCounter % 2) %>"></td>
				<td class="list<%= (rowCounter % 2) %>" colspan="2" align="center"><b><bean:message key="err.conntype.multicast" />&nbsp;</b></td>
				<td class="list<%= (rowCounter % 2) %>"><a href="<%=failureLink%>"><img src="images/back.gif" border="0" title="return"></a></td>
		</tr>
	<%}
	else
	{

	String link_part1 = "'/crm/ModifyService.do?type=layer3-Attachment&serviceid=" + serviceid +
                      "&customerid=" + customerId+
                      "&parentserviceid=' + form.parentserviceid.value" +
                      "+'&attachmentid=' + form.attachmentid.value" +
                        "+'&action=" + request.getParameter("action");

	String link_part2 ="&connTypeVPNId=' + ServiceForm.connTypeVPNId.options[connTypeVPNId.selectedIndex].value";

  String currentConnectivityType;
  String selectedVPN = (String)request.getAttribute("selectedVPN");
  selectedVPN = selectedVPN == null ? parentserviceid : selectedVPN;
  try
	  {
    
    // get VPNs List
   
    Service[] services = (Service[])serviceForm.getServices();
    
    if(services == null || services.length == 0)
      throw new IllegalStateException("Attachment must have at least one membership");
%>
<tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.l3site.con.vpn" /></b></td>
    <td align=left class="list<%= (rowCounter % 2) %>">
  <select name="connTypeVPNId" onchange="location.href = <%= link_part1 + link_part2 %>;">
<%
    boolean wasSelected = false;
  //System.out.println("services.length = " + services.length);

    for (int i = 0; i < services.length; i++) 
	{
      Service serviceVPN = services[i];
//      System.out.println("serviceVPN = " + serviceVPN);
      String selected;
      if(serviceVPN.getServiceid().equals(selectedVPN))
	  {
        selected = " selected";
        wasSelected = true;
      }
	  else
	 { 
        selected = "";      
	  }
%>

      <option<%=selected%> value="<%=serviceVPN.getServiceid()%>">
	  <%=serviceVPN.getPresname()%><%=" ( id :"%><%=serviceVPN.getServiceid()%><%=" )"%></option>            

<%
    //System.out.println("selected = " + selected);
    }
%>
  </select>
  </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  </tr>
  <% rowCounter++; %>


<%
    //if nothing was selected and selectedVPN id wasn't in list thes select first element
    if(!wasSelected)
		  {
      selectedVPN = services[0].getServiceid();
	  }
     //System.out.println("selectedVPN here === " + selectedVPN);
    currentConnectivityType = (String)request.getAttribute("currentConnectivityType");
//    System.out.println("currentConnectivityType = " + currentConnectivityType);
    String siteTopology = (String)request.getAttribute("siteTopology");
//    System.out.println("siteTopology = " + siteTopology);
%>
  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.l3site.conn" /></b></td>
    <td align=left class="list<%= (rowCounter % 2) %>">
      <select name="SP_ConnectivityType">
<%
    if(siteTopology.equalsIgnoreCase("Hub-and-Spoke"))
	{
      if("mesh".equalsIgnoreCase(currentConnectivityType))
		  {
%>
        <option value="mesh">Mesh</option>
<%
         }
%>
          <option value="hub" <%="hub".equalsIgnoreCase(currentConnectivityType) ? "selected":"" %>>Hub</option>
          <option value="spoke"<%="spoke".equalsIgnoreCase(currentConnectivityType) ? "selected":"" %>>Spoke</option>
<%
       }else{
      if(!"mesh".equalsIgnoreCase(currentConnectivityType)){
%>

          <option value="<%=currentConnectivityType%>"><%=currentConnectivityType%></option>
<%
      }
%>
          <option value="mesh">Mesh</option>
<%
    }
%>
      </select>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  </tr>
  <% rowCounter++; %>

<%
  } catch (Exception e) {
    e.printStackTrace();
%>
    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td class="list<%= (rowCounter % 2) %> ">
      <td valign="middle" colspan="2" class="list<%= (rowCounter % 2) %>">
	  <b><bean:message key="err.conntype.inventory" />:<%= e.getMessage () %>.&nbsp;&nbsp;&nbsp;</b>
       
		<html:link href="javascript:window.history.go(-2);">
		  <html:img page="/images/back.gif" border="0" align="left" title="Return"/>
	     </html:link>
      </td>
    </tr>
    <% rowCounter++; %>
    <tr height="15">
      <td class="list<%= (rowCounter % 2) %> " colspan=4 >&nbsp;</td>
    </tr>
<%
  }
  }
%>

