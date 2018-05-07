<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--############################################################################--%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>


<%@ page import="java.util.*,
                 com.hp.ov.activator.crmportal.utils.*,
                 com.hp.ov.activator.crmportal.action.*,
                 com.hp.ov.activator.crmportal.bean.*"%>

<%  
   //load param parameters got here
   ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
   HashMap serviceParameters = new HashMap ();
   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
   HashMap parentServiceParameters = new HashMap ();
   parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");

    CAR multicastRateLimit = null;
	multicastRateLimit = (CAR)request.getAttribute("multicastRateLimit");
	String serviceid = serviceForm.getServiceid();
    String parentserviceid = serviceForm.getParentserviceid();
    String layer = "layer 3";
    String customer_id = serviceForm.getCustomerid();
    customer_id = customer_id == null ? "" : customer_id;
	String siteServiceId = (String)request.getParameter("siteServiceId");
request.setAttribute("siteServiceId", siteServiceId); 
String searchSite = (String)request.getParameter("searchSite");	
request.setAttribute("searchSite", searchSite);



	String failureLink = "/crm/ListAllServices.do?customerid="+customer_id+"&doResetReload=true&mv=true";
	if(searchSite != null && !searchSite.equals(""))
			failureLink="SearchSiteSubmit.do?serviceid="+siteServiceId+"&doResetReload=true&mv=null";
    CAR[] rateLimits = null;
	
	  String spCarOld = "";
	  Region[] regions =null;
	  String current_interface_name="";
	  String current_region="";
	  //Location[] networks= null;
	  TreeMap networks= new TreeMap ();
	  String current_network="";
	  TreeMap peRouters= new TreeMap ();
	  String current_perouter="";
	  String selected_region="";
	  String aux_region="";
	  String selected_network="";
	  String selected_perouter="";
	  String selected_interface="";
	  String aux_network="";
	  TreeMap interfaces= new TreeMap ();
	  String source_terminationpoint="";
	  
	  
    int rowCounter= Integer.parseInt(request.getParameter("rowCounter"));

    String rateLimit = (String)request.getAttribute("rateLimit");
    if (rateLimit == null)
      rateLimit = (String) serviceParameters.get("CAR");
	String SP_QoSChildEnabled = (String) request.getAttribute("SP_QoSChildEnabled");
	 
	
	if(SP_QoSChildEnabled==null){
		SP_QoSChildEnabled="false";
	}

    String link_part1 = "'/crm/ModifyService.do?type=layer3-Attachment&serviceid=" + serviceid +
                        "&customerid=" +customer_id+
                        "&action=" + request.getParameter("action") +
              "&SP_QOS_PROFILE=' + form.SP_QOS_PROFILE.options[form.SP_QOS_PROFILE.selectedIndex].value" +
              "+'&SP_CAR=' + form.SP_CAR.value" +
              "+'&parentserviceid=' + form.parentserviceid.value" +
              "+'&attachmentid=' + form.attachmentid.value" +
              "+'&SP_QOS_BASE_PROFILE=' + form.SP_QOS_BASE_PROFILE.value "+
			  "+'&SP_QoSChildEnabled=' + ServiceForm.SP_QoSChildEnabled.value "+
			  "+'&REGIONS=' + form.REGIONS.value " +
			  "+'&NETWORKS=' + form.NETWORKS.value " +
			  "+'&PEROUTERS=' + form.PEROUTERS.value " +
			  "+'&INTERFACES=' + form.INTERFACES.value ";
    String link_part2 = "";
    try
	{
       
        rateLimits = (CAR[])request.getAttribute("rateLimits");

		EXPMapping[] mappings = (EXPMapping[])request.getAttribute("mappings");

        int mappingsLength = mappings == null ? 0 : mappings.length;
		
		spCarOld = (String)request.getAttribute("SP_CAR_OLD");
		regions = (Region[])request.getAttribute("regions");
		current_region = (String)request.getAttribute("current_region");
		current_interface_name = (String)request.getAttribute("interface_name");
		//networks = (Location[])request.getAttribute("networks");
		networks = (TreeMap)request.getAttribute("networks");
		current_network = (String)request.getAttribute("current_network");
		peRouters=(TreeMap)request.getAttribute("peRouters");
		current_perouter=(String)request.getAttribute("current_perouter");
		selected_region = (String)request.getAttribute("selected_region");
		aux_region = (String)request.getAttribute("selected_region");
		selected_network = (String)request.getAttribute("selected_network");
		selected_perouter = (String)request.getAttribute("selected_perouter");
		aux_network = (String)request.getAttribute("selected_network");
		interfaces = (TreeMap)request.getAttribute("interfaces");
		selected_interface = (String)request.getAttribute("selected_interface");
		source_terminationpoint = (String)request.getAttribute("source_terminationpoint");

        for(int i = 0; i < mappingsLength; i++)
			{
            EXPMapping expMapping = mappings[i];
            final String spParamName = "SP_QOS_CLASS_"+expMapping.getPosition()+"_PERCENT";
            final String paramName = "QOS_CLASS_"+expMapping.getPosition()+"_PERCENT";
            link_part1 += "+'&"+spParamName+"=' + form."+spParamName+".value";
            if(request.getAttribute(spParamName) == null && 
				serviceParameters.get("QOS_CLASS_"+i+"_PERCENT") != null)
				{
                request.setAttribute(spParamName, serviceParameters.get(paramName));
                }
             }
        if(request.getAttribute("SP_QOS_PROFILE") == null && serviceParameters.get("QOS_PROFILE") != null) 
			{
            request.setAttribute("SP_QOS_PROFILE", serviceParameters.get("QOS_PROFILE"));
        }
    }
    catch(Exception ex){
        ex.printStackTrace();
%>


   <script>
    alert('<bean:message key="js.ratelimit.error" /><%= ex.getMessage () %>.');
    location.href = '<%=failureLink%>';
	
	
    </script>
<%

    }
  
%>
<tr height="30">
  <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.multi.RL" /></b></td>
  <td align=left class="list<%= (rowCounter % 2) %>">
  <input type="hidden" id="SP_CAR_OLD" name="SP_CAR_OLD" value="<%=spCarOld %>">
  <select name="SP_CAR"  onChange="setAbsolutRL();callReload();">
<%    if (rateLimits != null) {

	
    for (int i=0; i < rateLimits.length; i++) {

        
		if(multicastRateLimit != null && rateLimits[i].getAveragebw() < multicastRateLimit.getAveragebw())
            continue;
      %>

	  <option <%= rateLimits[i].getRatelimitname().equals (rateLimit) ? " selected": "" %> value="<%=  rateLimits[i].getRatelimitname() %>"><%= rateLimits[i].getRatelimitname() %></option>
<%      }
  }
%>
  </select>
</td>
 <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>
   <% rowCounter++; %>


<%@ include file="qos.jsp" %>
<tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.qosprofilechild" /></b></td>
    <td class="list<%= (rowCounter % 2) %>" align=left>
      <select  name="SP_QoSChildEnabled" onChange="location.href = <%= link_part1 + link_part2 %>;">
       
			<option <%= SP_QoSChildEnabled.equals("false") ? " selected": "" %> value="false">No</option>
		    <option <%= SP_QoSChildEnabled.equals("true") ? " selected": "" %> value="true">Yes</option>
       
      </select>
	
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  </tr>
   <% rowCounter++; %>
	<tr height="15">
              <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
              <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
              <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
              <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
            </tr>
            <% rowCounter++; %>
    <!-- INTERFACE -->
  <script LANGUAGE="JavaScript" TYPE="text/javascript">
          
		 function checkInterface(){
			var fields="";
			var region,network,perouter,iterfaces="";
			region="<%=request.getParameter("REGIONS")%>";
			network="<%=request.getParameter("NETWORKS")%>";
			perouter="<%=request.getParameter("PEROUTERS")%>";
			interfaces="<%=request.getParameter("INTERFACES")%>";
			if(region == "null")
				fields+=" Region";
			if(network == "null")
				fields+=" Network";
			if(perouter == "null")
				fields+=" PERouter";
			if(interfaces == "null")
				fields+=" Interface";
			if(fields!=""){
				alert("The fields: "+fields + ", must have a value");
				return false;
			}
			else{
				return true;
			}			
		}
		
		function checkNullInterface(){
			var perouters="<%=request.getParameter("PEROUTERS")%>";
			var size_interface=<%=request.getAttribute("size_interface")%>
			var errorInterface="<%=request.getAttribute("errorInterface")%>";
			if(perouters != "null"){
				if(size_interface == 1){
					if(errorInterface != "null" && errorInterface=="2M" ){											 
						alert('<bean:message key="recovery.error.2M" />');
					}
					else if(errorInterface != "null" && errorInterface=="bandwidth" ){
						alert('<bean:message key="recovery.error.no.enough.bandwidth" />');
					}
					else{
						alert('<bean:message key="recovery.error.no.interfaces.availables" />');
					}
				}
				
			}
		}
   </script>
  
  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.region" /></b></td>	
	<td align=left class="list<%= (rowCounter % 2) %>">	
		<table cellpadding="0" cellspacing="0" width="100%"> 
		  <tr>
			<td align="left" width="50%" class="list<%= (rowCounter % 2) %>"><%=current_region%>
			</td>
			<td class="list<%= (rowCounter % 2) %>" align="left">
		
				<select name="REGIONS" onChange="javascript:callReload();">
				<% 
				  if (regions != null) 
				   {
					
					for (int i = 0; i < regions.length; i++) 	{
						%>
					 <option <%= regions[i].getName().equals (selected_region) ? " selected" : "" %> value="<%= regions[i].getName() %>"> <%= regions[i].getName() %></option>
					<%
					}
				   }
				   %>
				   </select>
			</td>
		</tr>
		</table>
	</td>  
	
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
  </tr>
  <input type="hidden" id="aux_region" name="aux_region" value="<%= aux_region%>">
   <% rowCounter++; %>
  
  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.network" /></b></td>
	<td class="list<%= (rowCounter % 2) %>">
		<table cellpadding="0" cellspacing="0" width="100%"> 
		  <tr>
			<td align="left" width="50%" class="list<%= (rowCounter % 2) %>"><%=current_network%> 
			</td>
			<td class="list<%= (rowCounter % 2) %>" align="left">
				
					<select name="NETWORKS" onChange="javascript:callReload();">
					<% 
					if(networks  != null){
						Iterator it = networks .entrySet().iterator();
					 
						while (it.hasNext()) {
							Map.Entry e = (Map.Entry)it.next();
							%>
						 <option <%= e.getKey().toString().equals ((selected_network) ) ? " selected" : "" %> value="<%= e.getKey() %>"> <%= e.getValue() %></option>
						<%
						}
					}
				   
				   %>
					   </select>
				</td>  
			</tr>
		</table>
	</td>
	
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
  </tr>
  <input type="hidden" id="aux_network" name="aux_network" value="<%= aux_network%>">
   <% rowCounter++; %>
  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.perouter" /></b></td>	
	<td align=left class="list<%= (rowCounter % 2) %>">
		<table cellpadding="0" cellspacing="0" width="100%"> 
		  <tr>
			<td align="left" width="50%" class="list<%= (rowCounter % 2) %>"><%=current_perouter%>
			</td>
			<td class="list<%= (rowCounter % 2) %>" align="left">
				<select name="PEROUTERS" onChange="javascript:callReload();">
				<% 
				if(peRouters != null){
					Iterator it = peRouters.entrySet().iterator();
				 
					while (it.hasNext()) {
						Map.Entry e = (Map.Entry)it.next();
						%>
					 <option <%= e.getKey().toString().equals (selected_perouter) ? " selected" : "" %> value="<%= e.getKey() %>"> <%= e.getValue() %></option>
					<%
					}
				}
				   
				   %>
				   </select>
				  
				</td> 
			</tr>
			</table>
	</td>
	
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
  </tr>
  
  <% rowCounter++; %>
  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.interface" /></b></td>	
	<td align=left class="list<%= (rowCounter % 2) %>">
		<table cellpadding="0" cellspacing="0" width="100%"> 
		  <tr>
			<td align="left" width="50%" class="list<%= (rowCounter % 2) %>"><%=current_interface_name%>
			</td>
			<td class="list<%= (rowCounter % 2) %>" align="left">
				<select name="INTERFACES" onClick="javascript:checkNullInterface();" onChange="javascript:callReload();">
				<% 
				if(interfaces != null){
					Iterator it = interfaces.entrySet().iterator();
				 
					while (it.hasNext()) {
						Map.Entry e = (Map.Entry)it.next();
						%>
					 <option <%= e.getKey().toString().equals(selected_interface) ? " selected" : "" %> value="<%= e.getKey() %>"> <%= e.getValue() %></option>
					<%
					}
				}
				   
				   %>
				   </select>
				  
				</td> 
			</tr>
			</table>
	</td>
	 
	 <input type="hidden" id="source_terminationpoint" name="source_terminationpoint" value="<%= source_terminationpoint%>">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
  </tr>
  
 
  
  
  <% rowCounter++;
    boolean allowPeriodicity = true;  
  %>

  <tr height="15">
     <td class="list<%= (rowCounter % 2) %>" colspan=4 >&nbsp;</td>
   </tr>

