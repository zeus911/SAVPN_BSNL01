<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
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


<%@page info="Create a service" contentType="text/html;charset=UTF-8" language="java" 
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
   String customerId = serviceForm.getCustomerid();
   String type = serviceForm.getType();

 String mv = (String)request.getAttribute("mv");
   String currentPageNo = (String)request.getAttribute("currentPageNo");
   String viewPageNo = (String)request.getAttribute("viewPageNo");


   
  Location[] locations = (Location[])request.getAttribute("locations");
  Region[] regions = (Region[])request.getAttribute("regions");
  IPAddrPool[] pools = (IPAddrPool[])request.getAttribute("pools");
  CAR[] cars = (CAR[])request.getAttribute("cars");
  Mask[] masks = (Mask[])request.getAttribute("masks");
  String layer = "GIS";

//  String presname = (String)request.getAttribute("presname");
  String presname = serviceForm.getPresname();
  String location = (String)request.getAttribute("location");
  String region   = (String)request.getAttribute("region");
  String pool = (String)request.getAttribute("pool");
  String secondaryPool = (String)request.getAttribute("secondaryPool");
  String car  = (String)request.getAttribute("car");
  String connectivityType  = (String)request.getAttribute("connectivityType");
  String activation_Scope  = (String)request.getAttribute("activation_Scope");
  String managed_CE_Router = (String)request.getAttribute("managed_CE_Router");
  String routing   = (String)request.getAttribute("routing");
  String ospf_area = (String)request.getAttribute("ospf_area");
  String customer_as = (String)request.getAttribute("customer_as");
  String ceBasedQoS  = (String)request.getAttribute("ceBasedQoS");
  if (presname == null) { presname = ""; }
 

String link_part0 = "&mv=" + mv +
                       "&currentPageNo=" + currentPageNo +
                       "&viewPageNo=" + viewPageNo;
 
  String link_part1 = "'/crm/CreateService.do?serviceid=" + serviceid +
                      "&customerid=" + customerId +
                      "&parentserviceid=" + parentserviceid +
                      "&type=" + type +link_part0;

  String link_part2 = "&presname=' + ServiceForm.presname.value + " +
                      "'&SP_Location=' + ServiceForm.SP_Location.options[SP_Location.selectedIndex].value + " +
                      "'&SP_AddressPool=' + ServiceForm.SP_AddressPool.options[SP_AddressPool.selectedIndex].value + " +
					  "'&SP_SecondaryAddressPool=' + ServiceForm.SP_SecondaryAddressPool.options[SP_SecondaryAddressPool.selectedIndex].value + " +
                      "'&SP_CAR=' + ServiceForm.SP_CAR.options[SP_CAR.selectedIndex].value + " +
                      "'&SP_Activation_Scope=' + ServiceForm.SP_Activation_Scope.options[SP_Activation_Scope.selectedIndex].value + " +
                     "'&SP_Managed_CE_Router='+ ServiceForm.SP_Managed_CE_Router.options[SP_Managed_CE_Router.selectedIndex].value + " +
                      "'&SP_RoutingProtocol=' + ServiceForm.SP_RoutingProtocol.options[SP_RoutingProtocol.selectedIndex].value + " +
                      "'&SP_Comment=' + ServiceForm.SP_Comment.value + "  +
                      "'&SP_StartTime=' + ServiceForm.SP_StartTime.value + "+
                      "'&SP_EndTime=' + ServiceForm.SP_EndTime.value +"+
                      "'&SP_Region=' + ServiceForm.SP_Region.options[SP_Region.selectedIndex].value +" +
                      "'&SP_QOS_PROFILE=' + ServiceForm.SP_QOS_PROFILE.options[SP_QOS_PROFILE.selectedIndex].value +" +
                      "'&SP_CE_based_QoS=' + ServiceForm.SP_CE_based_QoS.value +" +					 
                      "'&SP_QOS_BASE_PROFILE=' + ServiceForm.SP_QOS_BASE_PROFILE.value" ;


  int rowCounter;

  try {
    rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
  } catch (Exception e) {
    rowCounter = 0;
  }


      if (regions != null)
        if (region == null) {
          region = regions[0].getPrimaryKey();
        }
   
      if (pools != null)
	{
	  if (pool == null) 
	  {
		 pool = pools[0].getPrimaryKey();
	  }
	  if (secondaryPool == null) 
	  {
		 secondaryPool = "-none-";
	  }
	}

	EXPMapping[] mappings =  (EXPMapping[])request.getAttribute("mappings");

      int mappingsLength = mappings == null ? 0 : mappings.length;
      for(int i = 0; i < mappingsLength; i++)
		  {
        EXPMapping expMapping = mappings[i];
          link_part2 += "+'&SP_QOS_CLASS_"+expMapping.getPosition()+"_PERCENT=' " +
              "+ ServiceForm.SP_QOS_CLASS_"+expMapping.getPosition()+"_PERCENT.value";

          } //for

 
    //presname = serviceForm.getPresname();

    if (routing == null) 
	{
      routing = "STATIC";
    }
    if (routing.equals("BGP"))
	{
        link_part2 +=   "+'&SP_Customer_ASN=' + ServiceForm.SP_Customer_ASN.value";
    }   
	else if (routing.equals("OSPF"))
	{
         link_part2 +=    "+'&SP_OSPF_Area=' + ServiceForm.SP_OSPF_Area.value";
    }

   
%>

<% //staticcounter,include,mask etc -- 

    String strstaticCounter = (String)request.getAttribute("staticCounter");
	//String strstaticCounter = serviceForm.getStaticCounter();

    int staticCounter = 1;
    String removeEntryLink = link_part2;

    if (routing.equals ("STATIC"))
		{
		 //System.out.println("STATIC ROUTING");
         
      %>

<%   if(strstaticCounter == null)
	  {
	    staticCounter = 1;
	%>
       <input type="hidden" name="staticCounter" value="1">
<%      } 
	else
		{
        staticCounter = Integer.parseInt(strstaticCounter);
	    String strInclude = (String)request.getAttribute("include");
        %>
       <input type="hidden" name="staticCounter" value="<%= staticCounter %>">
<%   } 
		


         for (int k = 0; k < staticCounter; k++) 
		 {
             link_part2 += " + '&route" + k + "=' + ServiceForm.route" + k + ".value";
             link_part2 += " + '&mask" + k + "=' + ServiceForm.mask" + k + ".options[mask" + k + ".selectedIndex].value";
               if(k < staticCounter - 1)
                   removeEntryLink = link_part2;
           }
            link_part2 += "+'&staticCounter=" + staticCounter+'\'';
            removeEntryLink += "+'&staticCounter=" + (staticCounter - 1)+'\'';

      }
 
 %>


    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.l3sitename" /></b></td>
      <td class="list<%= (rowCounter % 2) %>" align=left>
	  <input type="text" id="presname" name="presname" maxlength="32" size="32" value=<%=presname%>></td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    </tr>

    <% rowCounter++; %>

<!--------------------------------------------------------------->
    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b>
	  <bean:message key="label.l2site.region" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
      <select name="SP_Region" onchange="location.href = <%= link_part1 + link_part2 %>;">
	  
<%    if (regions != null) {
        if (region == null) {
          region = regions[0].getPrimaryKey();
        }

        for (int i=0; regions != null && i < regions.length; i++) { %>
          <option<%= regions[i].getName().equals (region) ? " selected": "" %> value="<%=  regions[i].getName() %>"><%= regions[i].getName() %></option>
<%
         }
      }
%>
      </select>
	  </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    </tr>

    <% rowCounter++; %>
<!------------------------------------------------------------>
     <tr height="30">
          <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
          <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.l2site.loc" /></b></td>
          <td align=left class="list<%= (rowCounter % 2) %>">
          <select name="SP_Location">
		  
    <%    if (locations != null) {
            if (location == null) {
              location = locations[0].getPrimaryKey();
            }

            for (int i=0; locations != null && i < locations.length; i++) { %>
              <option<%= locations[i].getName().equals (location) ? " selected": "" %> value="<%=  locations[i].getName() %>"><%= locations[i].getName() %></option>
    <%      }
          }
    %>
          </select>
    	  </td>
          <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
        </tr>

        <% rowCounter++; %>
    <!------------------------------------------------------------>

    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.l2site.rlimit" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
      <select name="SP_CAR">

<%    if (cars != null) {
        String aux = car;
        if (car == null) {
          aux = cars[0].getPrimaryKey();
        }

        for (int i = 0; i < cars.length; i++) {
			
			%>
          <option<%= cars[i].getPrimaryKey().equals (aux) ? " selected" : "" %> value="<%= cars[i].getPrimaryKey() %>"><%= cars[i].getPrimaryKey() %>bps</option>
<%      }
     } %>
      </select>
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
  </tr>

  <% rowCounter++; %>
<%@include file="qos.jsp"  %>
   <!--------------------------CONNECTIVITY---------------------------------->

<%
  // If the VPN topology was set to Hub and spoke or composite then make it possible to select connectivity type for this site.
  if ((parentServiceParameters.get("VPNTopology") != null) && 
          parentServiceParameters.get("VPNTopology").toString().equals("Hub-and-Spoke")
      ) {

    link_part2 += " + '&SP_ConnectivityType=' + ServiceForm.SP_ConnectivityType.options[SP_ConnectivityType.selectedIndex].value"; %>

    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.site.conn.type" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
        <select name="SP_ConnectivityType">
<%        // Hub and Spoke
          if ((parentServiceParameters.get("VPNTopology") != null) && parentServiceParameters.get("VPNTopology").toString().equals("Hub-and-Spoke")) { %>
            <option <%= connectivityType != null && connectivityType.equals("hub") ? " selected": "" %> value="hub">Hub</option>
            <option <%= connectivityType != null && connectivityType.equals("spoke") ? " selected": "" %> value="spoke">Spoke</option>
<%        } %>

        </select>
      </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	  
    </tr>
  <% rowCounter++; %>
<%} else { 
    // Always set connectivity type to mesh if nothing is done! %>
    <input type="hidden" name="SP_ConnectivityType" value="mesh">
<%} %>

  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.mgd.cerouter" /></b></td>
    <td class="list<%= (rowCounter % 2) %>" align=left>
      <select name="SP_Managed_CE_Router" onChange="location.href = <%= link_part1 + link_part2 %>;">
        <% if (managed_CE_Router != null) { %>
          <option <%= managed_CE_Router.equals("true") ? " selected": "" %> value="true">Yes</option>
          <option <%= managed_CE_Router.equals("false") ? " selected": "" %> value="false">No</option>
        <% } else {
          if ((parentServiceParameters.get("CE_Routers_managed_per_default") != null)) { %>
            <option <%= parentServiceParameters.get("CE_Routers_managed_per_default").toString().equals("true") ? " selected": "" %> value="true">Yes</option>
            <option <%= parentServiceParameters.get("CE_Routers_managed_per_default").toString().equals("false") ? " selected": "" %> value="false">No</option>
          <% } else { %>
            <option selected value="true">Yes</option>
            <option value="false">No</option>
          <% } %>
        <% } %>
      </select>
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
  </tr>

  <% rowCounter++; %>
<%
  if("true".equalsIgnoreCase(managed_CE_Router)){
%>
<tr>
  <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.cebasedQos" /></b></td>
  <td class="list<%= (rowCounter % 2) %>" align=left>
    <select name="SP_CE_based_QoS" onChange="location.href = <%= link_part1 + link_part2 %>;">
      <option <%= "false".equals(ceBasedQoS) ? " selected": "" %> value="false">Disabled</option>
      <option <%= "true".equals(ceBasedQoS) ? " selected": "" %> value="true">Enabled</option>
    </select>
  </td>
  <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

  <% rowCounter++;
  }else{
  %>
  <input type="hidden" name="SP_CE_based_QoS" value="false"/>
  <%
  }
  %>


  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.activ.scope" /></b></td>
    <td class="list<%= (rowCounter % 2) %>" align=left>
      <select name="SP_Activation_Scope">
        <% if (activation_Scope != null) { %>
          <option <%= activation_Scope.equals("BOTH") ? " selected": "" %> value="BOTH">Both</option>
          <option <%= activation_Scope.equals("PE_ONLY") ? " selected": "" %> value="PE_ONLY">PE only</option>
          <option <%= activation_Scope.equals("CE_ONLY") ? " selected": "" %> value="CE_ONLY">CE only</option>
        <% } else {
          if ((parentServiceParameters.get("Default_Activation_Scope") != null)) { %>
            <option <%= parentServiceParameters.get("Default_Activation_Scope").toString().equals("BOTH") ? " selected": "" %> value="BOTH">Both</option>
            <option <%= parentServiceParameters.get("Default_Activation_Scope").toString().equals("PE_ONLY") ? " selected": "" %> value="PE_ONLY">PE only</option>
            <option <%= parentServiceParameters.get("Default_Activation_Scope").toString().equals("CE_ONLY") ? " selected": "" %> value="CE_ONLY">CE only</option>
          <% } else { %>
            <option selected value="BOTH">Both</option>
            <option value="PE_ONLY">PE only</option>
            <option value="CE_ONLY">CE only</option>
          <% } %>
        <% } %>
      </select>
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
   </tr>

  <% rowCounter++; %>

    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.pe.ce.addr.pool" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
      <select name="SP_AddressPool" onChange="location.href = <%= link_part1 + link_part2 %>;">
  <%    if (pools != null) {
          if (pool == null) {
            pool = pools[0].getPrimaryKey();
          }

          for (int i=0; pools != null && i < pools.length; i++) { %>
            <option<%= pools[i].getName().equals (pool) ? " selected": "" %> value="<%=  pools[i].getName() %>"><%= pools[i].getName() %></option>
  <%
           }
        }
  %>
        </select>
      </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    </tr>
    <% rowCounter++; %>
	
	<tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.pe.ce.secondary.addr.pool" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
      <select name="SP_SecondaryAddressPool" onChange="location.href = <%= link_part1 + link_part2 %>;">
  <%    if (pools != null) 
		{		  		  
          if (secondaryPool == null) 
		  {
			%> <option value="-none-" selected >-none-</option> <%
			secondaryPool = "-none-";
		  }
		  else
		  {
			%> <option value="-none-" >-none-</option> <%
		  }
          		  
          IPAddrPool tempPool =null ;
		  
          for (int i=0; pools != null && i < pools.length; i++) 
		  {
         	if(pools[i].getAddressfamily().equals(addressFamily))
			{
         		tempPool=pools[i];%>
         		<option<%= tempPool.getName().equals (secondaryPool) ? " selected": "" %> value="<%=  tempPool.getName() %>"><%= tempPool.getName() %></option>
         <%}

           }
        }
  %>
        </select>

      </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    </tr>
    <% rowCounter++; %>


  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.pe.ce.routing" /></b></td>
    <td align=left class="list<%= (rowCounter % 2) %>">
      <select id="SP_RoutingProtocol" name="SP_RoutingProtocol" onChange="location.href = <%= link_part1 + link_part2 %>;">
        <option<%= routing != null && routing.equals ("RIP") ? " selected" : "" %> value="RIP">RIP</option>
        <option<%= routing != null && routing.equals ("OSPF") ? " selected" : "" %> value="OSPF">OSPF</option>
        <option<%= routing != null && routing.equals ("BGP") ? " selected" : "" %> value="BGP">BGP</option>
        <option<%= routing != null && routing.equals ("STATIC") ? " selected" : "" %> value="STATIC">Static</option>
      </select>
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
  </tr>
  <% rowCounter++; %>



<% if (routing.equals ("BGP")) {%>
     <tr height="30">
       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
       <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.cust.asn" /></b></td>
       <td class="list<%= (rowCounter % 2) %>"><input type="text" id="SP_Customer_ASN" name="SP_Customer_ASN" size="10" <%= customer_as == null ? "" : "value=\"" + customer_as + "\"" %> onchange="checkNumValue(this, '<bean:message key="js.asn.range" />')"></td>
       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
     </tr>
     <% rowCounter++; %>
<% } %>

<% if (routing.equals ("OSPF")) {%>
     <tr height="30">
       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
       <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.ospfarea" /></b></td>
       <td class="list<%= (rowCounter % 2) %>"><input type="text" id="SP_OSPF_Area" name="SP_OSPF_Area" size="10" <%= ospf_area == null ? "" : "value=\"" + ospf_area + "\"" %>></td>
       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
     </tr>
     <% rowCounter++; %>
<% } %>

<% if (routing.equals ("STATIC")) {
    %>



<%   int i = 0; %>

     <tr valign="bottom" height="30">
       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
       <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.static.routes" /></b>
       <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.routepref" /></b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>/<bean:message key="label.l3sitemask" /> </b></td>
       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
     </tr>
     <% rowCounter++; %>
<!-- http://127.0.0.1:8080/portal/jsp/CreateServiceForm.jsp?serviceid=1005&customerid=1&parentserviceid=1003&type=layer3-Site&staticCounter=1&presname=&SP_Location=Copenhagen&SP_CAR=128K&SP_Activation_Scope=PE_ONLY&SP_Managed_CE_Router=false&SP_RoutingProtocol=STATIC&SP_Comment=&route0=10.10.1.1&mask0=30#-->

<%
    for (; i < staticCounter; i++) { %>
       <tr valign="center" height="30">
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

         <td valign="middle" class="list<%= (rowCounter % 2) %>">
           <input type="text" name="route<%= i %>" size="15" value="<%= (String)request.getAttribute("route"+i) != null ? (String)request.getAttribute("route"+i) : "" %>"> /

           <select name="mask<%= i %>">
<%           if (masks != null) 
			 {
               for (int j = 0; j < masks.length; j++)
			   {
                 if(request.getAttribute("mask"+i) != null ) 
					 {
%>
                   <option <%=((String)request.getAttribute("mask"+i)).equals(masks[j].getSlashnotation()) ? " selected" : "" %> value="<%= masks[j].getSlashnotation() %>"><%= masks[j].getSlashnotation() %></option>
<%               } else { %>
                   <option  value="<%= masks[j].getSlashnotation() %>"><%= masks[j].getSlashnotation() %></option>
<%               } %>
<%             }
             } %>
           </select>
         </td>
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
       </tr>
       <% rowCounter++; %>

<%   }%>
       <tr height="30">
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
         <td class="list<%= (rowCounter % 2) %>">


           <a href="#" class="list<%= (rowCounter % 2) %>" onClick="location.href = <%= link_part1 + link_part2 %>+ '&include=true';"><bean:message key="label.incl.entry" /></a>
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

		 

<%
            if(staticCounter > 1){
%>
           <a href="#" class="list<%= (rowCounter % 2) %>" onClick="location.href = <%= link_part1 + removeEntryLink %>;">
		   <bean:message key="label.rem.last" /></a>
<%
            }
%>
         </td>
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
       </tr>

<% }%>
	<script LANGUAGE="JavaScript" TYPE="text/javascript">
      function checkNumValue(input, prompt){
          var str = input.value;
          var newStr = "";
          for(i = 0; i < str.length; i++){
              if(str.charAt(i) >= '0' && str.charAt(i) <= '9'){
                  newStr = newStr + str.charAt(i);
              }
          }
          if(str != newStr || newStr.length == 0 ||  str < 1 || str > 65535) {
              alert(prompt);
              input.value = newStr;
              return false;
          }
          return true;
        }
        function checkAll() {
			var submitted = true;
            if(getObjectById('presname').value.length==0)
			{
               alert('<bean:message key="js.site.name" />');
               //getObjectById('submitObject').style.visibility ='visible';
               submitted = false;
            }
			var presname = getObjectById('presname');
			 if(!isSpecialCharFound(presname)) 
				 {
                   submitted = false;
            }
            var list = getObjectById('SP_RoutingProtocol')
            protocol = list.options[list.selectedIndex].value
            if(protocol == 'OSPF')
				{
                if(getObjectById('SP_OSPF_Area').value.length==0) 
					{
                    alert('<bean:message key="js.ospf.name" />');
                   // getObjectById('submitObject').style.visibility ='visible';
                    submitted = false;
                    }
				 var ospf_area = getObjectById('SP_OSPF_Area');
			     if(!isSpecialCharFound(ospf_area)) {
                   submitted = false;
                }
            } else
            if(protocol == 'BGP'){
              var customerASN = getObjectById('SP_Customer_ASN');              
              if(!checkNumValue(customerASN, '<bean:message key="js.asn.range" />')) {
                    //getObjectById('submitObject').style.visibility ='visible';
                    submitted = false;
                }
				 
            }

            if(submitted){
               document.ServiceForm.submit();
			}
			
        }

    function isIE_browser() {
    if (window.XMLHttpRequest) {
        return false;
  }	else {
        return true;
  }
}


function getObjectById(Id) {
	if(isIE_browser()) {
        return document.getElementById(Id);
	} else {
        return document.ServiceForm.elements[Id];
	}
}



</script>





