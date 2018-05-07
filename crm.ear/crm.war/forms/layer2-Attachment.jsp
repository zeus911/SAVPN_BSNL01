<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2006 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- -*- html -*- --%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>


<%@page info="Create a service" contentType="text/html;charset=UTF-8" language="java" 
  import="com.hp.ov.activator.crmportal.action.*, java.sql.*, com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*, java.text.*, java.net.*, org.apache.log4j.Logger,com.hp.ov.activator.crmportal.utils.Constants,com.hp.ov.activator.crmportal.utils.DatabasePool"
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
   Logger logger_l2site = Logger.getLogger("CRMPortalLOG");

   Region[] regions = (Region[])request.getAttribute("regions");
   Location[] locations = (Location[])request.getAttribute("locations");
   CAR[] rateLimits = (CAR[])request.getAttribute("rateLimits");

   String customerId = serviceForm.getCustomerid();
   String type = serviceForm.getType();
   String attachment_type="initial";
   String strVlanRanges = "";

   //Added by pp for vlan range check start
   //Now not used since we do not have a single vlan range. -- Rama R.
   int START_DIRECT_VLANID = ((Integer)session.getAttribute("START_DIRECT_VLANID")).intValue();
   //System.out.println("START_DIRECT_VLANID ="+START_DIRECT_VLANID);
	 int END_DIRECT_VLANID = ((Integer)session.getAttribute("END_DIRECT_VLANID")).intValue();
	 int START_ACCESS_VLANID = ((Integer)session.getAttribute("START_ACCESS_VLANID")).intValue();
	 int END_ACCESS_VLANID = ((Integer)session.getAttribute("END_ACCESS_VLANID")).intValue(); 
	//Added by pp for vlan range check end	

	// These contain all the start and end vlan ids of multiple ranged defined in a region.	
	 String START_VLANIDS = ((String)session.getAttribute("START_VLANIDS"));
  // System.out.println("START_VLANIDS ="+START_VLANIDS);
    String END_VLANIDS = ((String)session.getAttribute("END_VLANIDS"));
 //System.out.println("START_VLANIDS ="+END_VLANIDS);
	
  String presname = serviceForm.getPresname();
  String location = (String)request.getAttribute("location");
  String region = (String)request.getAttribute("region");
  String ethServiceType = (String)request.getAttribute("ethServiceType");
  String mapping = (String)request.getAttribute("mapping");
  String VLANId  = (String)request.getAttribute("VLANId");

  String BPDUTag = (String)request.getAttribute("BPDUTag");
  String loopDetection = (String)request.getAttribute("loopDetection");
  String layer= "layer 2";
  String connectivityType = (String)request.getAttribute("connectivityType");

   String mv = (String)request.getAttribute("mv");
   String currentPageNo = (String)request.getAttribute("currentPageNo");
   String viewPageNo = (String)request.getAttribute("viewPageNo");
   String vpnserviceid  = (String)request.getAttribute("SP_vpnserviceid");
   if(vpnserviceid == null)
   vpnserviceid = request.getParameter("SP_vpnserviceid");
   String parentServiceName = (String) parentServiceParameters.get ("presname");

   String resendCreate = (String)request.getAttribute("resend");
   Boolean resend = resendCreate!=null && resendCreate.equals("true");

   String ServiceMultiplexing = (String)request.getAttribute("ServiceMultiplexing");
   if(ServiceMultiplexing == null) ServiceMultiplexing = "false";

   ServiceParameter[] available_regions = (ServiceParameter[])request.getAttribute("available_regions");
   ServiceParameter[] available_locations = (ServiceParameter[])request.getAttribute("available_locations");
   
// avoid combox lose selected value when refresh
   String presnamelist =  (String)request.getParameter("presnamelist");

   String link_part1 = "'/crm/CreateService.do?serviceid=" + serviceid +
                     "&customerid=" + customerId +
                     "&parentserviceid=" + parentserviceid +
                     "&type=" + type + 
					 "&mv=" + mv +
                     "&currentPageNo=" + currentPageNo +
                     "&viewPageNo=" + viewPageNo +
					 "&resend=" + resendCreate +
					 "&reselect=" + resend +
					 "&SP_EthServiceType=" + ethServiceType +
                     "&presname=' + ServiceForm.presname.value + " +
                     "'&SP_VLANId=' + ServiceForm.SP_VLANId.value + " +
					 "'&SP_Location=' + ServiceForm.SP_Location.options[SP_Location.selectedIndex].value + " +
					 "'&SP_vpnserviceid=' + ServiceForm.SP_vpnserviceid.value + " +
					 "'&SP_LoopDetection=' + ServiceForm.SP_LoopDetection.value + " +
                     "'&SP_Comment=' + ServiceForm.SP_Comment.value +"+
                     "'&SP_StartTime=' + ServiceForm.SP_StartTime.value + "+
                     "'&SP_EndTime=' + ServiceForm.SP_EndTime.value +" +
                     "'&SP_Region=' + ServiceForm.SP_Region.options[ServiceForm.SP_Region.selectedIndex].value +'" +
					 "&SP_CAR=' + ServiceForm.SP_CAR.value +" +
                     "'&SP_QOS_PROFILE=' + ServiceForm.SP_QOS_PROFILE.options[ServiceForm.SP_QOS_PROFILE.selectedIndex].value +" +
                     "'&SP_QOS_BASE_PROFILE=' + ServiceForm.SP_QOS_BASE_PROFILE.value";
					 
		 if (ethServiceType.equals("VPLS-PortVlan") ) {

			 link_part1 += "+'&SP_Mapping=' + ServiceForm.SP_Mapping[0].checked";

		   if(!resend)
              link_part1 += "+'&presnamelist=' + ServiceForm.presnamelist.options[presnamelist.selectedIndex].value";
           }

  String link_part2="";
  int rowCounter;
  

    rowCounter = request.getAttribute ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));

	  region = (String) request.getAttribute("region");
     
      if (regions != null)
        if (region == null) 
		{
          region = regions[0].getPrimaryKey();
        }
       
	  EXPMapping[] mappings =  (EXPMapping[])request.getAttribute("mappings");

      int mappingsLength = mappings == null ? 0 : mappings.length;
      for(int i = 0; i < mappingsLength; i++)
		  {
        EXPMapping expMapping = mappings[i];
          link_part1 += "+'&SP_QOS_CLASS_"+expMapping.getPosition()+"_PERCENT=' " +
              "+ ServiceForm.SP_QOS_CLASS_"+expMapping.getPosition()+"_PERCENT.value";
      } //for

  
		
    if (ethServiceType.equals("VPLS-PortVlan") && !resend)
		{
      link_part1 += " + '&SP_Mapping=' + ServiceForm.SP_Mapping[0].checked";
    }


  String rateLimit = (String)request.getAttribute("rateLimit");
  Service[] sites = (Service[])request.getAttribute("available_sites");
%>

<input type="hidden" name="resend" value=<%= resendCreate %>>
<!--%@include file="CheckVlanRange.jsp"%-->
<% if (!"layer2-Attachment".equals(type)) { %>
	
	<tr height="30">
	<% rowCounter++; %>
	<input type="hidden" id="manualSet">
	<input type="hidden" name ="reuse_service_identity" value=<%= serviceid %>>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.l2site" /></b></td>
      <td class="list<%= (rowCounter % 2) %>" align=left>
    <% if (ethServiceType.equals("VPLS-PortVlan")) {%>
      <select style="position:absolute;width:227px;" onchange="Combo_Select(this,presname);handleReuseAction(this)" id="presnamelist" name="presnamelist" >
        <option/>
        <%if ( sites != null ) {    
             for (int i=0; i<sites.length; i++) {
		%>       <option value="<%=sites[i].getServiceid()%>" <%= sites[i].getServiceid().equals(presnamelist) ? " selected": ""%>><%= sites[i].getPresname()%></option>
		<%   }		       
		  }
		%>
          </select>
          <input style="position:absolute;width:210px" type="text" id="presname" name="presname" maxlength="32" onKeyPress="Text_ChkKey(presnamelist,this)" onFocus="handleHintWhenOnFocus(this,'Input or select site name')" onBlur="handleHintWhenOnBlur(this,'Input or select site name')" value="<%= presname == null || "".equals(presname) ? "Input or select site name" : presname%>">&nbsp;&nbsp;</td>
	 <%} else { %>
	   <input type="text" id="presname" name="presname" maxlength="32" size="32" <%= presname == null ? "" : "value=\"" + presname + "\"" %>></td>
	 <%} %>
	 <input type="hidden" name="ServiceMultiplexing" id="ServiceMultiplexing" value="false">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	  
    </tr>

    <% rowCounter++; %>
<% } else { %>
	<input type="hidden" name="ServiceMultiplexing" id="ServiceMultiplexing" value=<%=ServiceMultiplexing %>>
	<html:hidden  property="presname" name="presname" value="<%= parentServiceName+type%>"/>
	<html:hidden  property="serviceid" name="serviceid" value="<%= serviceid %>"/>
<%} %>
<input type="hidden" name="SP_vpnserviceid" value="<%= vpnserviceid %>">

<!--------------------------------------------------------------->
    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.l2site.region" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
<%    if (regions != null) {
        if (region == null) {
          region = regions[0].getPrimaryKey();
        }
%>
             
			   <select name="SP_Region" onChange="location.href = <%= link_part1 %>;" <%= !"true".equals(resendCreate) ? "" : "disabled" %>>
<%
        for (int i=0; regions != null && i < regions.length; i++)
			{ 
			
%>
        <option<%= regions[i].getName().equals (region) ? " selected": "" %> value="<%=  regions[i].getName() %>"><%= regions[i].getName() %></option>
<%
         }

%>
               </select>

   <%   }//regions 
    %>
	  </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    </tr>

    <% rowCounter++; %>
<!------------------------------------------------------------>
     <tr height="30">
          <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
          <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.l2site.loc" /></b></td>
          <td align=left class="list<%= (rowCounter % 2) %>">

          <select name="SP_Location" <%= !"true".equals(resendCreate) ? "" : "disabled" %>>
    <%    if (locations != null) {
            if (location == null) {
              location = locations[0].getPrimaryKey();
            }

            for (int i=0; locations != null && i < locations.length; i++) { 
				
				%>
            <option<%= locations[i].getName().equals (location) ? " selected": "" %> value="<%=  locations[i].getName() %>"><%= locations[i].getName() %></option>
    <%      }
          }//locations

    %>
          </select>

		 
    	  </td>
          <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
        </tr>

        <% rowCounter++; %>
    <!------------------------------------------------------------>
 <html:hidden  property="SP_Attachmenttype" name="SP_Attachmenttype" value="<%=attachment_type%>"/>

  <% if (ethServiceType.equals ("VPLS-PortVlan")) 
	  { %>

   <tr height="30">
     <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
     <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.l2site.vlan" /></b></td>
     <td class="list<%= (rowCounter % 2) %>" align=left>
       <input type="radio" name="SP_Mapping" value="true" onClick="location.href = <%= link_part1 %>;" <%= mapping.equals("true") ? " CHECKED":" " %>> Enabled
       <input type="radio" name="SP_Mapping" value="false" onClick="location.href = <%= link_part1 %>;" <%= mapping.equals("false") ? " CHECKED":" " %>> Disabled
     </td>
     <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	  	 
    </tr>

    <% rowCounter++; %>

    <% if (mapping.equals("true")) { %>
  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.l2site.vlanid" /></b></td>
    <td class="list<%= (rowCounter % 2) %>" align=left>
    <% 
			StringTokenizer stTok = new StringTokenizer(START_VLANIDS, ",");
			StringTokenizer endTok = new StringTokenizer(END_VLANIDS, ",");

			while(stTok.hasMoreTokens()) {
			
				if( strVlanRanges != "") 
					strVlanRanges += ",";
				strVlanRanges += stTok.nextToken() + " - " + endTok.nextToken();
			}
		//	System.out.println("strVlanRanges:" + strVlanRanges);
		%>
    <!--Added by pp for vlan range check start-->
    <input type="hidden" name="START_DIRECT_VLANID" value="<%= START_DIRECT_VLANID %>">
    <input type="hidden" name="END_DIRECT_VLANID" value="<%= END_DIRECT_VLANID %>">
    <input type="hidden" name="START_ACCESS_VLANID" value="<%= START_ACCESS_VLANID %>">
    <input type="hidden" name="END_ACCESS_VLANID" value="<%= END_ACCESS_VLANID %>">
	 <input type="hidden" name="START_VLANIDS" value="<%= START_VLANIDS %>">
    <input type="hidden" name="END_VLANIDS" value="<%= END_VLANIDS %>">
	    <input type="hidden" name="strVlanRanges" value="<%= strVlanRanges %>">

    <!--Added by pp for vlan range check end-->	
    
	  <input type="text" onChange="checkNumValueOrSpace(this, '<bean:message key="js.no.vlanid" />')" 
        id="SP_VLANId" name="SP_VLANId" maxlength="32" size="32"
        <%= VLANId == null ? "" : "value=\"" + VLANId + "\"" %>
		
        title="Recommended Customer provided VLAN ID Ranges: <%= strVlanRanges %>)">
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  </tr>

  <% rowCounter++; %>
<%   } else { %>
    <input type="hidden" name="SP_VLANId" value="0">

<%     }

   } //VPLS-PortVlan
   
   else
	   
	{
%>
    <input type="hidden" name="SP_VLANId" value="0">
<%
}%>

   <tr height="30">
     <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	 
     <!--VPN-->  <!--<td class="list<%= (rowCounter % 2) %>" align=left> <b><bean:message key="label.l2site.loopdetec" /></b> </td>-->
     <!--ME-->  <td class="list<%= (rowCounter % 2) %>" align=left></td>
     <td class="list<%= (rowCounter % 2) %>" align=left>
<%
 // loopDetection.equals("true") ? " selected": ""
 // loopDetection.equals("false") ? " selected": ""    
%>
      
	    <!--VPN-->  <!--<select name="SP_LoopDetection" property="selectedItem" type="hidden"> -->
       <!--ME-->    <select name="SP_LoopDetection" property="selectedItem" style="display:none">  
	   <!--VPN-->
        <!-- <option value="true">true</option>     
         <option value="false">false</option>-->
       </select>
     
     </td>

     <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	 
    </tr>

  <% rowCounter++; %>
    <tr>
      <td colspan="4" class="title" align="left"><bean:message key="label.params.qos" /></td>
    </tr>


    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.l2site.rlimit" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
      <select name="SP_CAR" property="selectedItem"  onChange="setAbsolutRL();">

    
<%    if (rateLimits != null) {
        for (int i=0; i < rateLimits.length; i++) { 

		//rateLimits[i].getRatelimitname().equals (rateLimit) ? " selected": ""	
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
 
<%@include file="qos.jsp"  %>
   <% rowCounter++; %>
 
    <!-- Always set connectivity type to mesh if nothing is done! OR layer 2 -->
    <input type="hidden" name="SP_ConnectivityType" value="mesh">

	<script LANGUAGE="JavaScript" TYPE="text/javascript">

        function checkNumValueOrSpace(input, prompt){
          var str = input.value;
          var newStr = "";
          for(i = 0; i < str.length; i++){
              if(str.charAt(i) >= '0' && str.charAt(i) <= '9'){
                  newStr = newStr + str.charAt(i);
              }
          }
          if(str != newStr) {
              alert(prompt);
              input.value = newStr;
              return false;
          }
          return true;
        }
       function checkVlanRange(input, prompt, startVlan , endVlan){

		if(input.value == "")
			return true;
		   
          var str   = input.value;
          var value = input.value;
		 // Split the start and end vlans to get individual block of ranges
		 var startRange = startVlan.split(",")
			var  endRange = endVlan.split(",")
			var i =0;
			var flag = 1;
		
	
	
		
       if ( str.length > 0 ) {
		  for(i=0;i<startRange.length ; i++) {
       
		
		 if(parseInt(value) >= parseInt(startRange[i]) && parseInt(value) <= parseInt(endRange[i]) )
            {		flag = 0;
					 break;
						
								 
            } 
          
		  }
          if(parseInt(value) == 0) 
	            {	   
	            	// alert('Zero'+value);        
			        }
			if(flag==1)
          	{
            		alert(prompt);
            		return false;
            	}
          }
          return true;
        }
	
		function checkSitename() {
			var site = getObjectById('presname');
            var sitelist = getObjectById('presnamelist');     
            var ServiceMultiplexing = getObjectById('ServiceMultiplexing');
                                   
            if (sitelist != null && sitelist.selectedIndex > 0 && sitelist[sitelist.selectedIndex].text == site.value) {            	           	
            	ServiceMultiplexing.setAttribute("value","true");
            } else {
            	ServiceMultiplexing.setAttribute("value","false");
            }                             
        }
        function checkAll() {
			<% if (!"layer2-Attachment".equals(type)) { %>
        	checkSitename(); // add by tommy at 2009.1.4
			<%}%>
            var submitted = true;
             if(getObjectById('SP_CAR').value.length==0) 
        {
			    alert('<bean:message key="js.site.RL" />');
			    submitted = false;
		    }           
            if(getObjectById('presname').value.length==0) 
			{
               alert('<bean:message key="js.site.name" />');
               submitted = false;
            }
			var presname = getObjectById('presname');
			 if(!isSpecialCharFound(presname))
				 {
                   submitted = false;
                }
<%          if (ethServiceType.equals ("VPLS-PortVlan") && mapping.equals("true")) { %>
	

            if (checkNumValueOrSpace(getObjectById('SP_VLANId'), '<bean:message key="js.no.vlanid" />') == false ) 
	           submitted = false;
            else
            	var promp = '<bean:message key="js.vlanrange.hint" />' +getObjectById('strVlanRanges').value +')';
               if (checkVlanRange(getObjectById('SP_VLANId'), promp , getObjectById('START_VLANIDS').value , getObjectById('END_VLANIDS').value) == false )
								submitted = false;
<%          } %>

            if (!submitted) {
              setVisible("submitObject");

			}
            else
            {
              //if (getObjectById('SP_VLANId').value=="")
               // getObjectById('SP_VLANId').value = "0";
			   getObjectById("SP_Region").disabled = "";
		       getObjectById("SP_Location").disabled = "";
               document.ServiceForm.submit();
			}

            //return submitted;

        }
       // onsubmit = checkAll;
        //ServiceForm.onsubmit = checkAll;
		function handleReuseAction(siteList)
		{
			var serviceList = getObjectById('presnamelist');          
            var presname = getObjectById('presname');                           
            var flag = getObjectById('manualSet');
            
            if (serviceList.selectedIndex == 0) {
            	flag.setAttribute("value","false");
				}
       		
       		var selValue = serviceList.options[serviceList.selectedIndex].value;

       		var td = document.getElementById('TD_serviceId');
            if (siteList.selectedIndex > 0) 
				{
					td.innerHTML=siteList[siteList.selectedIndex].value;      	
					presname.readOnly="true";
					flag.setAttribute("value","true");       	   	           	
				} else 
				{
            		td.innerHTML = <%= serviceid %>; 
					presname.readOnly="";
					presname.focus(); 
           }

		   handleReusedLocation(siteList[siteList.selectedIndex].value)
		}



function handleReusedLocation(siteid)
		{
          var SP_Region = getObjectById("SP_Region");
		  var SP_Location = getObjectById("SP_Location");
		  if (siteid != null && siteid != "") { 
		   SP_Region.disabled = "true";
		   SP_Location.disabled = "true";
			<%if(available_regions != null){
				for(ServiceParameter r : available_regions){ %>
                if(siteid == <%=r.getServiceid()%>){
				    for(j=0;j<SP_Region.length;j++) {  
                     if(SP_Region.options[j].value == "<%=r.getValue()%>"){
                        SP_Region.selectedIndex = j;
					 } // if
				  } //  for     
				} //if
			<%} //for
			} //if
			%>

           <%if(available_locations != null){
			   for(ServiceParameter l : available_locations){ %>
                if(siteid == <%=l.getServiceid()%>){
				  SP_Location.options.length = 0; 
				  SP_Location.options.add(new Option("<%=l.getValue()%>", "<%=l.getValue()%>"));
				} //if
			<%} //for
		   } //if
			%>
           
		  } else {
		   //SP_Region.selectedIndex = 0;
           SP_Region.disabled = "";
		   //SP_Location.selectedIndex = 0;
		   SP_Location.disabled = "";
		  } //if (siteid != null && siteid != "")

		}

function isIE_browser() {
    if (window.XMLHttpRequest) {
        return false;
  }	else {
        return true;
  }
}


function getObjectById(objID) {
  if (document.getElementById  &&  document.getElementById(objID)) {
    return document.getElementById(objID);
  } else {
	  if(document.getElementsByName && document.getElementsByName(objID)){
       return document.getElementsByName(objID)[0];
	  }else if (document.all  &&  document.all(objID)) {
      return document.all(objID);
    } else {
      if (document.layers  &&  document.layers[objID]) {
        return document.layers[objID];
      } else {
        return document.ServiceForm.elements[objID];
      }
    }
  }
}

function setVisible(Id) {
   if(isIE_browser()) {
        document.getElementById(Id).style.visibility = 'visible';
	} else {
        document.getElementsByName(Id)[0].style.visibility = 'visible';
	}
}

<%if(!resend){%>
var presname_obj = getObjectById("presnamelist");
if(presname_obj != null)
{
	if (presname_obj.selectedIndex > 0) {
  	handleReuseAction(getObjectById("presnamelist"));
	}
}
<%}%>
</script>