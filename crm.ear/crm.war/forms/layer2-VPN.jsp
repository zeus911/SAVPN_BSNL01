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
  import="com.hp.ov.activator.crmportal.action.*, java.sql.*, com.hp.ov.activator.crmportal.bean.*, 
            com.hp.ov.activator.crmportal.utils.*,com.hp.ov.activator.crmportal.helpers.*,java.util.*, java.io.*, java.text.*, java.net.*,com.hp.ov.activator.crmportal.utils.DatabasePool,com.hp.ov.activator.crmportal.utils.*,java.sql.*, javax.sql.*,org.apache.log4j.Logger" %>


<%
    //set the params from loadparams page when calling this page from createserviceform
   //load param parameters got here
   ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
   HashMap serviceParameters = new HashMap ();
   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
   HashMap parentServiceParameters = new HashMap ();
   parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters"); 
    DatabasePool dbp = null;
   Connection con = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   Logger logger = Logger.getLogger("CRMPortalLOG");
   String serviceid       = serviceForm.getServiceid();
   String parentserviceid = serviceForm.getParentserviceid();
   String presname   = serviceForm.getPresname();
   String customerId = serviceForm.getCustomerid();
   String ethServiceType = (String) serviceParameters.get("EthServiceType");
   String VLANId_string  = (String) serviceParameters.get("VLANId");
   String fixedVlan = (String) serviceParameters.get("FixedVlan");
   String profile   = (String)request.getAttribute("SP_QOS_PROFILE");
   Profile[] profiles =  (Profile[])request.getAttribute("profiles");
   
   // These contain all the start and end vlan ids of multiple ranged defined in a region.	
	 String START_VLANIDS = ((String)session.getAttribute("START_VLANIDS"));
   //System.out.println("START_VLANIDS ="+START_VLANIDS);
    String END_VLANIDS = ((String)session.getAttribute("END_VLANIDS"));
   //System.out.println("END_VLANIDS ="+END_VLANIDS);   
   

    int rowCounter = 0;

	  String mv = (String)request.getAttribute("mv");
   String currentPageNo = (String)request.getAttribute("currentPageNo");
   String viewPageNo = (String)request.getAttribute("viewPageNo");

    String resendCreate = (String)request.getAttribute("resend");
   Boolean resend = resendCreate!=null && resendCreate.equals("true");


 //action path has to be formed here
  String link_part = "'/crm/CreateService.do?serviceid=" + serviceid +
                     "&customerid=" + request.getParameter("customerid") +
                     "&type=" + "layer2-VPN" + "&mv=" + mv +
                     "&currentPageNo=" + currentPageNo +
                     "&viewPageNo=" + viewPageNo +
					 "&resend=" + resendCreate +
                     "&presname=' + ServiceForm.presname.value + " +
                     "'&SP_EthServiceType=' + ServiceForm.SP_EthServiceType.options[SP_EthServiceType.selectedIndex].value + " +
                     "'&SP_QOS_PROFILE=' + ServiceForm.SP_QOS_PROFILE.value + " +
                     "'&SP_Comment=' + ServiceForm.SP_Comment.value";



    rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
 	
 


  ethServiceType = request.getParameter ("SP_EthServiceType");
  if (ethServiceType == null) {
	   ethServiceType = (String)request.getAttribute ("SP_EthServiceType");
	   if (ethServiceType == null)
         ethServiceType = "Port";
  }

  VLANId_string = request.getParameter ("SP_VLANId");
  if (VLANId_string == null) {
	  VLANId_string = (String)request.getAttribute ("SP_VLANId");
	  if (VLANId_string == null || VLANId_string.equals("0"))
        VLANId_string = "";
  }

  fixedVlan = request.getParameter ("SP_FixedVlan");
  if ( fixedVlan== null) {
	   fixedVlan = (String)request.getAttribute ("SP_FixedVlan");
	   if ( fixedVlan== null) 
        fixedVlan = "false";
  }


%>

  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.vpn.name" /></b></td>
    <td class="list<%= (rowCounter % 2) %>" align=left>
	<input type="text" id="presname" name="presname" maxlength="32" size="32" 
	<%= presname == null ? "" : "value=\"" + presname + "\"" %>></td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
  </tr>

  <% rowCounter++; %>

  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.serv.type" /></b></td>
    <td class="list<%= (rowCounter % 2) %>" align=left>
      <select name="SP_EthServiceType" onChange="location.href = <%= link_part %>;">
        <option <%= ethServiceType.equals("VPLS-PortVlan") ? " selected": "" %> value="VPLS-PortVlan">port-vlan</option>
        <option <%= ethServiceType.equals("Port") ? " selected": "" %> value="Port">port</option>
      </select>
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
   </tr>

  <% rowCounter++; %>

  <% if (ethServiceType.equals ("VPLS-PortVlan")) {
    link_part += " + '&SP_FixedVlan=' + forms[0].SP_FixedVlan[0].checked";
  %>

   <tr height="30">
     <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
     <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.fixedvlan" /></b></td>
     <td class="list<%= (rowCounter % 2) %>" align=left>

       <input type="radio" name="SP_FixedVlan" value="true"
         onClick="location.href = <%= link_part %>;"
         <%= fixedVlan.equalsIgnoreCase("true") ? " CHECKED":" " %>> Enabled

       <input type="radio" name="SP_FixedVlan" value="false" 
         onClick="location.href = <%= link_part %>;"
         <%= fixedVlan.equalsIgnoreCase("false") ? " CHECKED":" " %>> Disabled

     </td>
     <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	  	 
    </tr>

  <% rowCounter++; %>

  <% if (fixedVlan.equals ("true"))
	 {
	  
	  String vlanRanges = "";
	  
	  try
	  {
		dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
		con = (Connection) dbp.getConnection();
		// Get all the ranges belonging to  a region
		pstmt = con.prepareStatement("select startvalue,endvalue from v_vlanrange where usage='Attachment' and allocation='External' and region = 'Provider'");
	
		rs = pstmt.executeQuery();
		while(rs.next())
		{
			//vlanStartValue = rs.getString(1);
			//vlanEndValue = rs.getString(2);
			//loop through each one and from a string containing all the ranges.
			if(vlanRanges != "")
				vlanRanges += "," ;
			vlanRanges = vlanRanges + rs.getString(1) + " - " + rs.getString(2);
		}
		
		if(vlanRanges.equals("")) {
			vlanRanges = "not defined";
		}
	  }
	  catch(Exception e)
	 {
		logger.debug("Exception retrieving vlanrange"+e.getMessage());
	 }
	  finally
		 {
			if(rs != null)
			  rs.close();
			if(pstmt != null)
			  pstmt.close();
			if(con != null)
  			 dbp.releaseConnection(con);
		 }

	  
	%>

  <% link_part += " + '&SP_VLANId=' + ServiceForm.SP_VLANId.value"; %>

  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.vlanid" /></b></td>
    <td class="list<%= (rowCounter % 2) %>" align=left>
    <input type="hidden" name="vlanRanges" value="<%= vlanRanges %>">
    <input type="hidden" name="START_VLANIDS" value="<%= START_VLANIDS %>">
    <input type="hidden" name="END_VLANIDS" value="<%= END_VLANIDS %>">    
      <input type="text" onChange="checkNumValueOrSpace(this, '<bean:message key="js.no.vlanid" />')" 
       id="SP_VLANId" name="SP_VLANId" maxlength="32" size="32" 
       <%= VLANId_string == null ? "" : "value=\"" + VLANId_string + "\"" %> 
       title="Recommended Customer provided VLAN ID ranges are   <%= vlanRanges%> ">
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>  
  </tr>

  <% rowCounter++; %>

<%   } else { %>
  <input type="hidden" id="SP_VLANId" name="SP_VLANId" value="0">
<%   } %>

  <% } else { %> 
    <input type="hidden" id="SP_VLANId" name="SP_VLANId" value="0">
  <% } %>
    <tr>
      <td class="title" colspan="4" align="left"><bean:message key="label.params.qos" /></td>
    </tr>
   <tr height="30">
     <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
     <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.qosprofile" /></b></td>
     <td class="list<%= (rowCounter % 2) %>" align=left>
       <select name="SP_QOS_PROFILE">
  <%
    if(profiles != null){
        for (int i=0; i < profiles.length; i++) { %>
          <option <%=profiles[i].getQosprofilename().equals(profile) ? "selected" : ""%> value="<%=  profiles[i].getQosprofilename() %>"><%= profiles[i].getQosprofilename() %></option>
<%      }
      }
%>
      </select>
	  </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	  
    </tr>

   <% rowCounter++; %>
 
    <!-- Always set connectivity type to mesh if nothing is done! OR layer 2 -->
    <input type="hidden" name="SP_ConnectivityType" value="mesh">
	<input type="hidden" name="resend" value=<%= resendCreate %>>

<script>
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
        function checkAll() {
            var submitted = true;

            if(getObjectById('presname').value.length==0) {
               alert('<bean:message key="js.vpn.name" />');
               submitted = false;
            }
            
            if(getObjectById('SP_QOS_PROFILE').value.length==0) {
               alert('<bean:message key="js.vpn.profile" />');
               submitted = false;
            }
             
			var presname = getObjectById('presname');
			 if(!isSpecialCharFound(presname)) {
                   submitted = false;
                }
<%          
            if (ethServiceType.equals ("VPLS-PortVlan") && fixedVlan.equals ("true")) { %>
            else
            if (checkNumValueOrSpace(getObjectById('SP_VLANId'), '<bean:message key="js.no.vlanid" />') == false ) 
	           submitted = false;
            else
            	var promp = '<bean:message key="js.vlanrange.hint" />' +getObjectById('vlanRanges').value;
              if (checkVlanRange(getObjectById('SP_VLANId'), promp, getObjectById('START_VLANIDS').value , getObjectById('END_VLANIDS').value) == false ) 
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
       // onsubmit = checkAll();
       // ServiceForm.onsubmit = checkAll();
</script>
