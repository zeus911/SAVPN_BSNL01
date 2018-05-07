<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
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
  import="com.hp.ov.activator.crmportal.action.*, java.sql.*, com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*, java.text.*, java.net.*, org.apache.log4j.Logger,com.hp.ov.activator.crmportal.utils.DatabasePool,com.hp.ov.activator.crmportal.utils.*,java.sql.*, javax.sql.*"
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

   DatabasePool dbp1 = null;
   Connection con1 = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
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


   String link_part1 = "'/crm/CreateService.do?serviceid=" + serviceid +
                     "&customerid=" + customerId +
                     "&parentserviceid=" + parentserviceid +
                     "&type=" + "layer2-Site" + 
					 "&mv=" + mv +
                     "&currentPageNo=" + currentPageNo +
                     "&viewPageNo=" + viewPageNo +
                     "&presname=' + ServiceForm.presname.value + " +
                     "'&SP_VLANId=' + ServiceForm.SP_VLANId.value + " +
                     "'&SP_Location=' + ServiceForm.SP_Location.options[SP_Location.selectedIndex].value + " +
                     "'&SP_LoopDetection=' + ServiceForm.SP_LoopDetection.value + " +
                     "'&SP_Comment=' + ServiceForm.SP_Comment.value +"+
                     "'&SP_StartTime=' + ServiceForm.SP_StartTime.value + "+
                     "'&SP_EndTime=' + ServiceForm.SP_EndTime.value +"+
                     "'&SP_Region=' + ServiceForm.SP_Region.options[ServiceForm.SP_Region.selectedIndex].value +" +
                     "'&SP_CAR=' + ServiceForm.SP_CAR.value +" +
                     "'&SP_QOS_PROFILE=' + ServiceForm.SP_QOS_PROFILE.options[ServiceForm.SP_QOS_PROFILE.selectedIndex].value +" +
                     "'&SP_QOS_BASE_PROFILE=' + ServiceForm.SP_QOS_BASE_PROFILE.value"; 

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

  
		
    if (ethServiceType.equals("VPLS-PortVlan"))
		{
      link_part1 += " + '&SP_Mapping=' + ServiceForm.SP_Mapping[0].checked";
    }


  String rateLimit = (String)request.getAttribute("rateLimit");
 
%>

    <tr height="30">
	<% rowCounter++; %>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.l2site" /></b></td>
      <td class="list<%= (rowCounter % 2) %>" align=left>
	  <input type="text" id="presname" name="presname" maxlength="32" size="32" 
	  <%= presname == null ? "" : "value=\"" + presname + "\"" %>></td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	  
    </tr>

    <% rowCounter++; %>

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
             
			   <select name="SP_Region" onChange="location.href = <%= link_part1 %>;">
<%
        for (int i=0; regions != null && i < regions.length; i++)
			{ 
			
%>
        <option<%= regions[i].getName().equals (region) ? " selected": "" %> value="<%=  regions[i].getName() %>"><%= regions[i].getName() %></option>
<%
         }

%>
               </select>

   <%   }//regions %>
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

    <% if (mapping.equals("true")) 
		{ 
		  String vlanStartValue= "3001";
		  String vlanEndValue= "4000";
		  try
		  {
			dbp1 = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
			con1 = (Connection) dbp1.getConnection();
			pstmt = con1.prepareStatement("select startvalue,endvalue from vlanrange where usage='Direct' and allocation='External'");
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				vlanStartValue = rs.getString(1);
				vlanEndValue = rs.getString(2);

			}
		  }
		  catch(Exception e)
		 {
			logger_l2site.debug("Exception retrieving vlanrange"+e.getMessage());
		 }
		 finally
		 {
			if(rs != null)
			  rs.close();
			if(pstmt != null)
			  pstmt.close();
			if(con1 != null)
  			 dbp1.releaseConnection(con1);
		 }

	%>
  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.l2site.vlanid" /></b></td>
    <td class="list<%= (rowCounter % 2) %>" align=left>
     
	  <input type="text" onChange="checkNumValueOrSpace(this, '<bean:message key="js.no.vlanid" />')" 
        id="SP_VLANId" name="SP_VLANId" maxlength="32" size="32"
        <%= VLANId == null ? "" : "value=\"" + VLANId + "\"" %>
        title="Recommended Customer provided VLAN ID range is from  <%= vlanStartValue%> to <%= vlanEndValue%>">
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
      <select name="SP_CAR" property="selectedItem">
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
        function checkVlanRange(input, prompt){
          var str   = input.value;
          var value = input.value;
  
          if ( str.length >0 ) {
            if( value < 1 || value > 4094) {
                alert(prompt);
                return false;
            }
          }
          return true;
        }
        function checkAll() {
            var submitted = true;

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
            else
            if (checkNumValueOrSpace(getObjectById('SP_VLANId'), '<bean:message key="js.no.vlanid" />') == false ) 
	           submitted = false;
            else
              if (checkVlanRange(getObjectById('SP_VLANId'), '<bean:message key="js.vlanrange.hint" /> 1 ~ 4094') == false )
				submitted = false;

<%          } %>

            if (!submitted) 
              setVisible("submitObject");
            else
            {
              if (getObjectById('SP_VLANId').value=="")
                getObjectById('SP_VLANId').value = "0";
               document.ServiceForm.submit();
			}

            //return submitted;

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

function setVisible(Id) {
   if(isIE_browser()) {
        document.getElementById(Id).style.visibility = 'visible';
	} else {
        document.getElementsByName(Id)[0].style.visibility = 'visible';
	}
}

       // onsubmit = checkAll;
        //ServiceForm.onsubmit = checkAll;
</script>