<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>

<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- -*- html -*- --%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>

<%@page info="Create a service" contentType="text/html;charset=UTF-8"
	language="java"
	import="com.hp.ov.activator.crmportal.action.*, java.sql.*, com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*, java.text.*, java.net.*"%>


<%
   ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
   HashMap serviceParameters = new HashMap ();
   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
   HashMap parentServiceParameters = new HashMap ();
   parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");
   String serviceid = serviceForm.getServiceid();
   String parentserviceid = serviceForm.getParentserviceid();

  java.util.ArrayList allProfiles = new java.util.ArrayList();
  //String presname = serviceForm.getServicename();
  String presname = serviceForm.getPresname();
  final String customerId = serviceForm.getCustomerid();

   String resendCreate = (String)request.getAttribute("resend");
   Boolean resend = resendCreate!=null && resendCreate.equals("true");
   String viewPageNo = (String)request.getAttribute("viewPageNo");
   String mv = (String)request.getAttribute("mv");
   String currentPageNo = (String)request.getAttribute("currentPageNo");
   String type = serviceForm.getType();
   String myprofile = (String)request.getAttribute("SP_QOS_PROFILE");


   String vpnTopolology = (String)request.getAttribute("SP_VPNTopology");
   String managedCE = (String)request.getAttribute("SP_MANAGEDCE");
   String actScope = (String)request.getAttribute("SP_ACTIVATIONSCOPE");
   String addressFamily = (String) request.getAttribute("SP_AddressFamily");
   
   if(addressFamily ==null)
		addressFamily="IPv4";

  int rowCounter;

  try {
    rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
  } catch (Exception e) {
    rowCounter = 0;
  }


  Profile[] profiles;

   // getting customer profiles

	 profiles = (Profile[])request.getAttribute("profiles");
      if(profiles != null){
        for (int i = 0; i < profiles.length; i++)
          allProfiles.add(profiles[i]);
      }

      // getting public profiles

        Profile[] foreignprofiles = (Profile[])request.getAttribute("foreignprofiles");

      if(foreignprofiles != null){
       for (int i = 0; i < foreignprofiles.length; i++)
          allProfiles.add(foreignprofiles[i]);
      }
	String link_part = "'/crm/CreateService.do?serviceid=" + serviceid +
				 "&customerid=" + request.getParameter("customerid") +
				 "&type=" + "GIS-VPN" + "&mv=" + mv +
				 "&currentPageNo=" + currentPageNo +
				 "&viewPageNo=" + viewPageNo +
				 "&resend=" + resendCreate +
				 "&presname=' + ServiceForm.presname.value + " +
				 "'&SP_AddressFamily=' + ServiceForm.SP_AddressFamily.options[SP_AddressFamily.selectedIndex].value + " +
				 "'&SP_QOS_PROFILE=' + ServiceForm.SP_QOS_PROFILE.options[SP_QOS_PROFILE.selectedIndex].value + " +
				 "'&SP_VPNTopology=' + ServiceForm.SP_VPNTopology.options[SP_VPNTopology.selectedIndex].value + " +
				 "'&SP_CE_Routers_managed_per_default=' + ServiceForm.SP_CE_Routers_managed_per_default.options[SP_CE_Routers_managed_per_default.selectedIndex].value + " +
				 "'&SP_Default_Activation_Scope=' + ServiceForm.SP_Default_Activation_Scope.options[SP_Default_Activation_Scope.selectedIndex].value";

 %>
<!--  <B>Error getting QoS profiles from the inventory</B> -->
</body>
</html>
<%

   //String domain = (String) serviceParameters.get("DomainName");
   //String cos_string = (String) serviceParameters.get("CoS");
%>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message
				key="label.l3vpn.name" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" align=left><input
		type="text" id="presname" name="presname" maxlength="32" size="32"
		<%= presname == null ? "" : "value=\"" + presname + "\"" %>></td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message
				key="label.vpntopo" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" align=left><select
		name="SP_VPNTopology">
			<option <%="Full-Mesh".equals(vpnTopolology)?"selected":""%>
				value="Full-Mesh">Full mesh</option>
			<option <%="Hub-and-Spoke".equals(vpnTopolology)?"selected":""%>
				value="Hub-and-Spoke">Hub and spoke</option>
	</select></td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>
<tr>
	<td class="title" colspan="4" align="left"><bean:message
			key="label.sitedef" /></td>
</tr>

<!--Start : Added for supporting IPV6-->
<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message
				key="label.addressfamily" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" align=left>
	<select	name="SP_AddressFamily" onChange="location.href = <%= link_part %>;">
			<option <%="IPv4".equals(addressFamily)?"selected":""%> value="IPv4">IPv4</option>
			<option <%="IPv6".equals(addressFamily)?"selected":""%> value="IPv6">IPv6</option>
	</select></td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>
<% rowCounter++; %>
<!--End : Added for supporting IPV6-->
<input type="hidden" name="SP_MulticastStatus" value="disabled">
<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message
				key="label.l3.qosprof" /></b></td> 	
	<td class="list<%= (rowCounter % 2) %>" align=left><select
		name="SP_QOS_PROFILE">
			<%
    if(allProfiles != null){
        for (int i=0; i < allProfiles.size(); i++) {
        Profile profile = (Profile)allProfiles.get(i);
%>
			<option
				<%= profile.getQosprofilename().equals(myprofile) ? "selected" : ""%>
				value="<%=  profile.getQosprofilename() %>"><%= profile.getQosprofilename() %></option>
			<%}
    }
  %>
	</select></td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++; %>

<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message
				key="label.mgd.cerouter" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" align=left><select
		name="SP_CE_Routers_managed_per_default">
			<option <%="false".equals(managedCE)?"selected":""%> value="false">No</option>
			<option <%="true".equals(managedCE)?"selected":""%> value="true">Yes</option>

	</select></td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>

<% rowCounter++;%>


<tr height="30">
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
	<td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message
				key="label.act.scope" /></b></td>
	<td class="list<%= (rowCounter % 2) %>" align=left><select
		name="SP_Default_Activation_Scope">
			<option <%="PE_ONLY".equals(actScope)?"selected":""%> value="PE_ONLY">PE
				only</option>
			<%-- <option <%="BOTH".equals(actScope)?"selected":""%> value="BOTH">Both</option>
			<option <%="CE_ONLY".equals(actScope)?"selected":""%> value="CE_ONLY">CE
				only</option> --%>

	</select></td>
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>
<% rowCounter++; %>
<input type="hidden" name="resend" value=<%= resendCreate %>>

<script LANGUAGE="JavaScript" TYPE="text/javascript">
	function checkAll() {

		var submitted = true;

		if (getObjectById('presname').value.length == 0) {
			alert('<bean:message key="js.vpn.name" />');
			submitted = false;
		}
		if (getObjectById('SP_QOS_PROFILE').value.length == 0) {
			alert('<bean:message key="js.vpn.profile" />');
			submitted = false;
		}

		var presname = getObjectById('presname');
		if (!isSpecialCharFound(presname)) {
			submitted = false;
		}

		if (submitted) {
			document.ServiceForm.submit();
		} else {
			getObjectById('presname').focus();
			setVisible("submitObject");
		}

	}

	function isIE_browser() {
		if (window.XMLHttpRequest) {
			return false;
		} else {
			return true;
		}
	}

	function getObjectById(Id) {
		if (isIE_browser()) {
			return document.getElementById(Id);
		} else {
			return document.ServiceForm.elements[Id];
		}
	}

	function setVisible(Id) {
		if (isIE_browser()) {
			document.getElementById(Id).style.visibility = 'visible';
		} else {
			document.getElementsByName(Id)[0].style.visibility = 'visible';
		}
	}
</script>
