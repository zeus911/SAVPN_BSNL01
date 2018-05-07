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


<%@page info="Modify Attachment Multicast"
        contentType="text/html; charset=UTF-8"
        import="com.hp.ov.activator.crmportal.bean.*,com.hp.ov.activator.crmportal.action.*, java.util.* ,java.io.*,
		java.text.*, java.net.*,java.util.HashSet, com.hp.ov.activator.crmportal.utils.*,com.hp.ov.activator.crmportal.helpers.*, 
		java.sql.ResultSet, java.sql.SQLException, java.sql.PreparedStatement, java.sql.DriverManager, java.util.ArrayList,
		com.hp.ov.activator.crmportal.common.*, org.apache.log4j.Logger, com.hp.ov.activator.vpn.inventory.*,
		com.hp.ov.activator.inventory.SAVPN.*, javax.sql.DataSource, java.sql.Connection"
 %>

<%!
  public static final String PARAMETER_MULTICAST_ID = "MulticastVPNId";
  public static final String PARAMETER_MULTICAST_STATUS = "MulticastStatus";
  public static final String PARAMETER_MULTICAST_RP = "MulticastRP";
  public static final String PARAMETER_MULTICAST_QOS_CLASS = "MulticastQoSClass";
  public static final String PARAMETER_MULTICAST_RATE_LIMIT = "MulticastRateLimit";
  private static String getParameter(HttpServletRequest request, Map parameters, String name){
    String result;
    result = request.getParameter(name);
    if(result != null)
      return result;
    result = (String)parameters.get(name);
    
    return result;
  }

%>
<%
   //load param parameters got here
   ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
   HashMap serviceParameters = new HashMap ();
   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
   HashMap parentServiceParameters = new HashMap ();
   parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");
   String serviceid = serviceForm.getServiceid();
   String parentserviceid = serviceForm.getParentserviceid();
   
   String siteServiceIdSearch = (String)request.getParameter("siteServiceId");
request.setAttribute("siteServiceId", siteServiceIdSearch); 
String searchSite = (String)request.getParameter("searchSite");	
request.setAttribute("searchSite", searchSite);
   
  String siteServiceId;
  siteServiceId = (String)serviceParameters.get("Site_Service_id");
  
  String customerId = (String) serviceParameters.get("customerid");
  customerId = customerId == null ? "" : customerId;
 

  int rowCounter;

  try {
    rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
  } catch (Exception e) {
    rowCounter = 0;
  }
  
  Connection con = null;
  DataSourceLocator dsl = new DataSourceLocator(); 
  
  PreparedStatement statePstmt = null;
  ResultSet resultSet = null;
  
  boolean enableSelected = false;
  String multicastVpnId = "";
  
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
					enableSelected = true;
				}
			}
			else
			{
				com.hp.ov.activator.vpn.inventory.MulticastSite mcastSiteObj = com.hp.ov.activator.vpn.inventory.MulticastSite.findByAttachmentid(con, serviceid);
				
				if (mcastSiteObj != null)
				{
					enableSelected = true;
				}
			}
			
			String query = "select l3v.serviceid from v_l3vpn l3v where l3v.parentid = ? and l3v.multicast = 'unsupported'";
						 
			statePstmt = con.prepareStatement(query);
			statePstmt.setString(1, parentserviceid);
			resultSet = statePstmt.executeQuery();
			
			while(resultSet.next())
			{
				multicastVpnId = resultSet.getString(1);
			}
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
  
  String siteMulticastStatus;
  siteMulticastStatus = (String)serviceParameters.get(PARAMETER_MULTICAST_STATUS);
  siteMulticastStatus = siteMulticastStatus == null ? "disabled" : siteMulticastStatus;

  String selectedVPNid = (String)request.getAttribute("vpnId");
  selectedVPNid = selectedVPNid != null ? selectedVPNid : request.getParameter("parentserviceid");
  
  final String VPNTopology = (String) parentServiceParameters.get("VPNTopology");
  final String mVPNMode = (String) parentServiceParameters.get("MulticastMode");  
  final String siteConnectivity = (String) serviceParameters.get("ConnectivityType");
  // Richa 11687
	int cpage = 1;
	String strPageNo = "1";
	int vPageNo = 1;

	String pt=(String)request.getParameter("mv"); 

    String strcpage = (String)request.getAttribute("currentPageNo");
	if(strcpage!=null)
	  cpage  = Integer.parseInt(strcpage);

	String strvPageNo	 =  (String)request.getAttribute("viewPageNo");
	if(strvPageNo!=null)
	  vPageNo = Integer.parseInt(strvPageNo);
	  //System.out.println("pt"+pt+"strcpage"+strcpage+"vPageNo"+vPageNo);
	// Richa 11687  

   String failureLink = "/crm/ListAllServices.do?customerid="+customerId+"&doResetReload=true&mv=null";  
   if(searchSite != null && !searchSite.equals(""))
			failureLink="SearchSiteSubmit.do?serviceid="+siteServiceIdSearch+"&doResetReload=true&mv=null";

  com.hp.ov.activator.crmportal.bean.VPNMembership[] memberships = null;

  String errorMessage = null;
	String qosCompliant = "";

  try 
  {
    memberships = (com.hp.ov.activator.crmportal.bean.VPNMembership[])request.getAttribute("memberships");
	qosCompliant = (String)request.getAttribute("qos_compliance");
  } 
  catch (Exception e)
  {
	e.printStackTrace();
    errorMessage = "Error getting Multicast Status from the inventory"+e.getMessage();
  } 

  // If the VPN supports multicast then allow to change site's status
    if(errorMessage != null){
      // do nothing. All the rest will be skipped and error message will be printed in the end.
    }else if(memberships != null && memberships.length > 1){
      errorMessage = "Attachment must be a member of only one VPN to enable multicast.";
    }else if(!"Full-Mesh".equals(VPNTopology)){
      errorMessage = "Multicast is available only for the Full-Mesh topologies.&nbsp;&nbsp;&nbsp;";
    }else if(!"mesh".equals(siteConnectivity)){
      errorMessage = "Multicast is available only for mesh sites.&nbsp;&nbsp;&nbsp;";
    }else{

%>

  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.multi.site" /></b></td>
    <td class="list<%= (rowCounter % 2) %>" align=left>

 <%
		if(qosCompliant != null && qosCompliant.equalsIgnoreCase(Constants.COMPLAINT))
		{
		  %>
	  <select name="<%=PARAMETER_MULTICAST_STATUS%>">
          <option <%= enableSelected ? "" : " selected" %> value="disabled">disabled</option>
          <option <%= enableSelected ? " selected" : "" %> value="enabled">enabled</option>
      </select>

<%
		}
		else
		{
		 errorMessage = "Multicast is supported only on services with VPN SVP compliant QoS profile.&nbsp;&nbsp;&nbsp;";
		}
        if(enableSelected)
	  {
%>
          VPN ID: <%=multicastVpnId%>
<%
        }
%>
    </td>
    <td class="list<%= (rowCounter++ % 2) %>">&nbsp;</td>
  </tr>
  <%
  }
    if(errorMessage != null){
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



