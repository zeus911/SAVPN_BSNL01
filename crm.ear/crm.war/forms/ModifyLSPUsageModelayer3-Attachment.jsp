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


<%@page info="Modify LSP Usage Mode"
        contentType="text/html; charset=UTF-8"
        import="com.hp.ov.activator.crmportal.bean.*,com.hp.ov.activator.crmportal.action.*, java.util.HashMap,java.io.*,
		java.text.*, java.net.*,java.util.HashSet, com.hp.ov.activator.crmportal.utils.*,com.hp.ov.activator.crmportal.helpers.*, 
		java.sql.ResultSet, java.sql.SQLException, java.sql.PreparedStatement, java.sql.DriverManager,
		com.hp.ov.activator.crmportal.common.*, org.apache.log4j.Logger, com.hp.ov.activator.vpn.inventory.*,
		com.hp.ov.activator.inventory.SAVPN.*, javax.sql.DataSource, java.sql.Connection"
 %>


<%
    //load param parameters got here
	ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
	HashMap serviceParameters = new HashMap ();
	serviceParameters = (HashMap)request.getAttribute("serviceParameters");
	HashMap parentServiceParameters = new HashMap ();
	parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");
	String attachmentid = (String)request.getAttribute("attachmentid");
	String siteServiceId = (String)request.getParameter("siteServiceId");
request.setAttribute("siteServiceId", siteServiceId); 
String searchSite = (String)request.getParameter("searchSite");	
request.setAttribute("searchSite", searchSite);
	
	String customerId = (String) serviceParameters.get("customerid");
	
   	Connection con = null;
	DataSourceLocator dsl = new DataSourceLocator(); 
	boolean showLSPOptions = false;
	boolean showLSPService = false;
	boolean showLSPAggregated = false;
	boolean serviceLSPsInAttachment = false;
	String currentMode = "";
	PreparedStatement statePstmt = null;
	ResultSet resultSet = null;
	
	try
	{
		DataSource ds = dsl.getDataSource();
		if (ds != null)
		{
			con = ds.getConnection();
			
			com.hp.ov.activator.vpn.inventory.ISP[] ispData = com.hp.ov.activator.vpn.inventory.ISP.findAll(con);
			
			String idName = ispData[0].getIdname();
		
			com.hp.ov.activator.vpn.inventory.LSPParameters lspParam = com.hp.ov.activator.vpn.inventory.LSPParameters.findByIdname(con,idName);
			
			if (lspParam.getLspenabled())
			{
				showLSPOptions = true;
				showLSPService = true;
				
				if (lspParam.getAggregatelspenabled())
				{
					showLSPAggregated = true;
				}
			}		
			
			com.hp.ov.activator.vpn.inventory.FlowPoint[] currentFP = com.hp.ov.activator.vpn.inventory.FlowPoint.findByAttachmentid(con, attachmentid);
			
			currentMode = (String) currentFP[0].getUsagemode();

			// Find out if there are Service LSPs created as a consequence of the creation of this attachment
			String query = "select lsp.lspid from v_flowpoint fp, v_vpnfpmembership vf, cr_terminationpoint tp, v_lsp lsp, v_lspvpnmembership lv "
						 + "where fp.terminationpointid=vf.flowpointid and tp.terminationpointid=fp.terminationpointid and vf.vpnid=lv.vpnid and lv.lspid=lsp.lspid " 
						 + "and tp.ne_id=(select tp.ne_id from cr_terminationpoint tp, v_lsp lsp2 where tp.terminationpointid=lsp2.terminationpointid and lsp2.lspid=lv.lspid) "
						 + "and fp.attachmentid=?";
						 
			statePstmt = con.prepareStatement(query);
			statePstmt.setString(1, attachmentid);
			resultSet = statePstmt.executeQuery();
			
			while(resultSet.next())
			{
				serviceLSPsInAttachment = true;
			}
			
		}             
	}
	catch (SQLException sqle)
	{ %>
		<B><bean:message key="err.lsp.inventory" /></B>: <%= sqle.getMessage () %>.
		<%  return;
	}
	catch (Exception e) 
	{ %>
		<B><bean:message key="err.lsp.inventory" /></B>: <%= e.getMessage () %>.
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
	
	if (!showLSPService || !showLSPAggregated)
	{
	
	session.setAttribute("NO_COMMIT", "TRUE");
	
	String failureLink = "/crm/ListAllServices.do?customerid="+customerId+"&doResetReload=true&mv=null";
	if(searchSite != null && !searchSite.equals(""))
			failureLink="SearchSiteSubmit.do?serviceid="+siteServiceId+"&doResetReload=true&mv=null";
	
	 %>
		<tr height="30">
        <td class="list1">&nbsp;</td>
        <td valign="middle" align="center" colspan="2" class="list1">
		<b><bean:message key="err.no.lsp.cfg" />&nbsp;&nbsp;&nbsp;</b>
          <a href="<%=failureLink%>">
            <img src="images/back.gif" border="0" alt="return"></a>
          </td>
        <td class="list1">&nbsp;</td>
		</tr>
	<%
	}
	else if (serviceLSPsInAttachment)
	{
	
	session.setAttribute("NO_COMMIT", "TRUE");
	
	String failureLink = "/crm/ListAllServices.do?customerid="+customerId+"&doResetReload=true&mv=null";
	if(searchSite != null && !searchSite.equals(""))
			failureLink="SearchSiteSubmit.do?serviceid="+siteServiceId+"&doResetReload=true&mv=null";
	%> 
		<tr height="30">
        <td class="list1">&nbsp;</td>
        <td valign="middle" align="center" colspan="2" class="list1">
		<b><bean:message key="err.service.lsp.present" />&nbsp;&nbsp;&nbsp;</b>
          <a href="<%=failureLink%>">
            <img src="images/back.gif" border="0" alt="return"></a>
          </td>
        <td class="list1">&nbsp;</td>
		</tr>
	<%}
	else
	{%>

	<tr>
		<td class="list0">&nbsp;</td>
		<td class="list0">Select LSP usage mode:</td>
		<td class="list0">
			<% if ("Service".equals(currentMode)) { %>
			<input type="radio" name="lspoptions" value="Service" checked="checked">Service</input>
			<% } else { %>
			<input type="radio" name="lspoptions" value="Service">Service</input>
			<% } %>
			
			<% if ("Aggregated".equals(currentMode)) { %>
			<input type="radio" name="lspoptions" value="Aggregated" checked="checked">Aggregated</input>
			<% } else { %>
			<input type="radio" name="lspoptions" value="Aggregated">Aggregated</input>
			<% } %>
		</td>
		<td class="list0">&nbsp;</td>
	</tr>

<%
}
%>	

