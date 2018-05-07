<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>


<%@page info="Join VPN" contentType="text/html;charset=UTF-8" language="java" %>	
<%@ page import="java.util.Enumeration,java.util.*,
                 com.hp.ov.activator.crmportal.action.*,
				 com.hp.ov.activator.crmportal.bean.*,
				 com.hp.ov.activator.crmportal.utils.DatabasePool,
				 java.sql.*,
				 com.hp.ov.activator.crmportal.utils.*,
				 com.hp.ov.activator.crmportal.helpers.*,
				 java.net.*,
				 org.apache.log4j.Logger"%>
<%!
    public static final String HUB_AND_SPOKE = "HubAndSpoke";
    public static final String FULL_MESH = "FullMesh";
    public static final String HUB = "hub";
    public static final String SPOKE = "spoke";
    public static final String EXTERNAL = "EXTERNAL";
    public static final String INTERNAL = "INTERNAL";
    public static final String OK = "Ok";
    public static final String PARAMETER_MULTICAST_STATUS = "MulticastStatus";

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
	Logger logger = Logger.getLogger("CRMPortalLOG");
    String customerId = serviceForm.getCustomerid();
    customerId = customerId == null ? "" : customerId;
	
	String siteServiceIdSearch = (String)request.getParameter("siteServiceId");
	request.setAttribute("siteServiceId", siteServiceIdSearch); 
	String searchSite = (String)request.getParameter("searchSite");	
	request.setAttribute("searchSite", searchSite);
	
	String siteServiceId;
	siteServiceId = (String)serviceParameters.get("Site_Service_id");
	
	boolean enableSelected = false;
	String multicastVpnId = "";
	
	DatabasePool dbp = null;
   	Connection con = null;
	
	PreparedStatement statePstmt = null;
	ResultSet resultSet = null;
	
	dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
	
	try
	{
		con = (Connection) dbp.getConnection();
		
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
	catch(Exception ex)
	{
		logger.debug("Exception retrieving Multicast Status: "+ex.getMessage());
	}
	finally
	{
		if (con != null)
		{
			try{ resultSet.close(); }catch(Exception ignoreme){}
			try{ statePstmt.close(); }catch(Exception ignoreme){}
			
			try 
			{
				dbp.releaseConnection(con);
			}
			catch (Exception rollbackex)
			{
				// Ignore
			}
		}
	}
   
    String failureLink = "/crm/ListAllServices.do?customerid="+customerId+"&doResetReload=true&mv=null";
	if(searchSite != null && !searchSite.equals(""))
			failureLink="SearchSiteSubmit.do?serviceid="+siteServiceIdSearch+"&doResetReload=true&mv=null";
    String link_part1 = "'/crm/ModifyService.do?type=layer3-Attachment&serviceid=" + serviceid +
                        "&customerid=" + customerId+
                        "&parentserviceid=' + form.parentserviceid.value" +
                        "+'&attachmentid=' + form.attachmentid.value" +
                        "+'&action=" + (String)request.getAttribute("modifySelection");

    int rowCounter;
    boolean isExternal = Boolean.valueOf((String)request.getAttribute("isExternal")).booleanValue();
    boolean skipNext = false;

    String newServiceId  = (String)request.getAttribute("newServiceId");
    String extranetName  = (String)request.getAttribute("extranetName");
    String otherCustomer = (String)request.getAttribute("otherCustomer"); 
    String selectedVPNid = (String)request.getAttribute("selectedVPNid");
    
    String siteMulticastStatus  = (String)request.getAttribute("siteMulticastStatus");
   // System.out.println("siteMulticastStatus     ------>"+siteMulticastStatus);
    //System.out.println("newServiceId     ------>"+newServiceId);
   // System.out.println("selectedVPNid     ------>"+selectedVPNid);
    //System.out.println("otherCustomer     ------>"+otherCustomer);
    //System.out.println("extranetName     ------>"+otherCustomer);
   // siteMulticastStatus = (String)serviceParameters.get(PARAMETER_MULTICAST_STATUS);
    //siteMulticastStatus = siteMulticastStatus == null ? "disabled" : siteMulticastStatus;


    try {
        rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
    } catch (Exception e) {
        rowCounter = 0;
    }

 
        
    if(!enableSelected){
        
     
        if(newServiceId != null)
            link_part1 += ("&newServiceId="+newServiceId);

        // if we need to pass parameter to SA
        if(newServiceId != null && isExternal){
%>
<input type="hidden" name="newServiceId" value="<%=newServiceId%>">
<%
        }
%>

<tr height="30">
    <td class="list<%= (rowCounter % 2) %>"></td>
    <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.action" /></b></td>
    <td class="list<%= (rowCounter % 2) %>">
        <select name="operation_type" onchange="location.href=<%= link_part1 %>&operation_type='+document.ServiceForm.operation_type.value">
            <option <%= isExternal ? "" : "selected" %> value="<%=INTERNAL%>">join own</option>
            <option <%= !isExternal ? "" : "selected" %> value="<%=EXTERNAL%>">join extranet</option>
        </select>
    </td>
    <td class="list<%= (rowCounter % 2) %>"></td>
</tr>
<% rowCounter++; %>
<%
    if(isExternal) {
       
        Customer[] customers = (Customer[])request.getAttribute("customers");
        final int customersLength = customers != null ? customers.length : 0;
        if(customersLength == 0)
          skipNext = true;



%>
<tr height="30">
    <td class="list<%= (rowCounter % 2) %>"></td>
    <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.joinvpnl3" /></b></td>
    <td class="list<%= (rowCounter % 2) %>">
<%
      if(!skipNext){
%>
        <select name="otherCustomer" onchange="location.href=<%= link_part1 %>&operation_type='+document.ServiceForm.operation_type.value+'&otherCustomer='+document.ServiceForm.otherCustomer.value" >
<%
        String selectedCustomerId = null;
        boolean selected = false;

        for(int customerIndex = 0; customerIndex < customersLength; customerIndex++){
            Customer customer = customers[customerIndex];            

            if(otherCustomer.equals(customer.getCustomerid())){
                selected = true;
                selectedCustomerId = otherCustomer;
            }else
                selected = false;
%>
            <option <%= selected ? "selected" : ""%> value="<%=customer.getCustomerid()%>"><%=customer.getCompanyname()%></option>
<%
        }
        // if there wasn't any selected customers then lets select the first in the list
        if(selectedCustomerId == null && customersLength > 0){
            otherCustomer = customers[0].getCustomerid();        
        }
%>
        </select>
<%
      }// if(skipNext)
      else{
%>
        <bean:message key="msg.no.cust.found" />
<%
      }
%>
    </td>
    <td class="list<%= (rowCounter % 2) %>"></td>
</tr>
<% rowCounter++;

    }// if(isExternal)
    else{
%>
    <input type="hidden" name="otherCustomer" value="">
<%
    }
        String id = isExternal ? otherCustomer : customerId;
//        System.out.println("id = " + id);
        String tempServiceid = null;
        String addressFamily = null;
        Service[] vpns  = serviceForm.getServices();
        String selectedId = null;
        final int vpnsLength = vpns != null ? vpns.length : 0;
        int tempVPNsLength =0;
        ArrayList<Service> tempVPNs = new ArrayList<Service>();
        if(vpnsLength == 0){
          	skipNext = true;
        }
        else{
        	tempServiceid = vpns[0].getServiceid();
        
	        try{
	        	con = (Connection) dbp.getConnection();
	        	addressFamily = ServiceUtils.getServiceParam(con, serviceid,"AddressFamily");
	    	    for(int index = 0; index < vpnsLength ; index++){
	    	    	String tempAddressFamily = ServiceUtils.getServiceParam(con, vpns[index].getServiceid(),"AddressFamily");
	    	    	if(addressFamily.equals(tempAddressFamily)){
	    	    		tempVPNs.add(vpns[index]);
	       	    	}
	    	    }
	    	    tempVPNsLength = tempVPNs != null ? tempVPNs.size() : 0;
	    	}
	    	catch (Exception e)
	    	 {
	    		logger.debug("Exception retrieving  Address Family"+e.getMessage());
	    	 }
	    	finally
	    	 {
	    		if(con != null)
	    			 dbp.releaseConnection(con);
	    	 }
	  }

%>

<tr height="30">
    <td class="list<%= (rowCounter % 2) %>"></td>
    <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.joinTo" /></b></td>
    <td class="list<%= (rowCounter % 2) %>">
    
    <%
      if(tempVPNsLength == 0){
    	  
    	  skipNext = true;
      }
%>
    
<%
      if(!skipNext){
%>
        <select name="vpnId" onchange="location.href=<%= link_part1 %>&operation_type='+document.ServiceForm.operation_type.value+'&otherCustomer='+document.ServiceForm.otherCustomer.value + '&vpnId='+document.ServiceForm.vpnId.value" >
<%
        boolean selected = false;

        for(int vpnIndex = 0; vpnIndex < tempVPNsLength; vpnIndex++){
            Service vpn = tempVPNs.get(vpnIndex);
            if(selectedVPNid.equals(vpn.getServiceid())){
                selected = true;
                selectedId = selectedVPNid; // saving id to get VPNTopology attribute
            }else
                selected = false;
%>			
            <option <%= selected ? "selected" : ""%> value="<%=vpn.getServiceid()%>"><%=vpn.getPresname()%></option>
<%
        }
        if(selectedId == null && tempVPNsLength > 0)
            selectedId = tempVPNs.get(0).getServiceid();
%>
        </select>
<%
      }// if(!skipNext)
      else{
%>
       <bean:message key="err.no.vpns" /> 
<%
      }

%>
    </td>
    <td class="list<%= (rowCounter % 2) %>"></td>
</tr>
<%      rowCounter++;
        boolean isFullMesh = true;

        if(selectedId != null){
            ServiceParameter parameter = (ServiceParameter)request.getAttribute("parameter");
            isFullMesh = !"Hub-and-Spoke".equals(parameter.getValue());

%>

<tr height="30">
    <td class="list<%= (rowCounter % 2) %>"></td>
    <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.topology" /></b></td>
    <td class="list<%= (rowCounter % 2) %>">
        <%
            if(isFullMesh){
        %>
            <bean:message key="label.mesh" /><input type="hidden" name="connectivity" value="mesh">
        <%
            }else{
        %>
            <bean:message key="label.hubandspoke" />
        <%
            }
        %>
    </td>
    <td class="list<%= (rowCounter % 2) %>"></td>
</tr>
<%

            rowCounter++;
        }
%>

<%
    // if any vpn was selected and if it is hub and spoke
        if(!isFullMesh){
%>
<tr height="30">
    <td class="list<%= (rowCounter % 2) %>"></td>
    <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.l3siteconnec" /></b></td>
    <td class="list<%= (rowCounter % 2) %>">
        <select name="connectivity">
            <option value="<%=SPOKE%>">spoke</option>
            <option value="<%=HUB%>">hub</option>
        </select>
    </td>
    <td class="list<%= (rowCounter % 2) %>"></td>
</tr>
<% rowCounter++; %>
<%
        }
      if(skipNext){
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
    }// if(siteMulticastStatus.equals("disabled"))
    else{
        session.setAttribute("NO_COMMIT", "!");
%>        
<tr height="30">
        <td class="list<%= (rowCounter % 2) %>"></td>
        <td class="list<%= (rowCounter % 2) %>" colspan="2" align="center"><b><bean:message key="err.muticast.join.vpn" />&nbsp;</b></td>
        <td class="list<%= (rowCounter % 2) %>"><a href="<%=failureLink%>"><img src="images/back.gif" border="0" title="return"></a></td>
</tr>
<%        
    }
   // }
%>
