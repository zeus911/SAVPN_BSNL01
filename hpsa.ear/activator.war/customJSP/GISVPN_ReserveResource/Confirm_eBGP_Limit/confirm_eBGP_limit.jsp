<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
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

<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/L3VPN_ReserveResource/Confirm_eBGP_Limit/confirm_eBGP_limit.jsp,v $                                                                   --%>
<%-- $Revision: 1.8 $                                                                 --%>
<%-- $Date: 2010-11-15 07:41:44 $                                                                     --%>
<%-- $Author: tanye $                                                                   --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>
<!-- Queue: 'confirm_eBGP_limit' -->

<%@ page contentType="text/html; charset=UTF-8"
         import="com.hp.ov.activator.mwfm.*, 
                 com.hp.ov.activator.mwfm.servlet.*" %>
<%
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");

%>
<html>
<head>
  <title>hp OpenView service activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
  <meta http-equiv="content-type" content="text/html; charset=utf-8">
</head>
<script>
    function checkResult(){
       return checkNumValue( document.getElementById("maximum_prefix") );
    }

    function checkNumValue(input){
       var str = input.value;
       var numval = input.value;
       var newStr = "";
       for(i = 0; i < str.length; i++){
           if(str.charAt(i) >= '0' && str.charAt(i) <= '9'){
               newStr = newStr + str.charAt(i);
           }
       }
       if(str != newStr || newStr.length == 0) {
           alert('Maximum prefix must have a numeric value');
           input.value = newStr;
           return false;
       }
       if ( numval < 1 || numval > 4294967295 ) {
           alert( 'Maximum prefix value must be in range 1-4294967295' );
           return false;
       }
       return true;
    }
</script>

<body onload="window.resizeTo(800,450);" >
<h3><img src="/activator/images/HPLogo.png" valign="top" align="right">Interact with job: L3VPN_AddSite_PE</h3>
<%--<h6>Using file: C:\HP\jboss\server\default\deploy\hpovact.sar\activator.war\customJSP\L3VPN_AddSite_PE\Confirm_eBGP_Limit\confirm_eBGP_limit.jsp</h6>--%>
<br>
<center>
<table width="100%" border=0 cellpadding=0>
<tr>
   <th class="tableHeading">Job ID</th>
   <th class="tableHeading">Workflow</th>
   <th class="tableHeading">Start Date & Time</th>
   <th class="tableHeading">Post Date & Time</th>
   <th class="tableHeading">Step Name</th>
   <th class="tableHeading">Description</th>
   <th class="tableHeading">Status</th>
</tr>


<%-- Get the job descriptor to enable access to general job information --%>
<% JobRequestDescriptor jd=(JobRequestDescriptor) session.getAttribute(Constants.MWFM_JOB_DESCRIPTOR); %>

<tr>
    <td class="tableRow"> <%= jd.jobId %> </td>
    <td class="tableRow"> <%= jd.name %> </td>
    <td class="tableRow"> <%= jd.startTime %> </td>
    <td class="tableRow"> <%= jd.postDate %> </td>
    <td class="tableRow"> <%= jd.stepName == null ? "&nbsp;" : jd.stepName %> </td>
    <td class="tableRow"> <%= jd.description == null ? "&nbsp;" : jd.description %> </td>
    <td class="tableRow"> <%= jd.status == null ? "&nbsp;" : jd.status %> </td>
</tr>
</table>


<p>
<!-- Concrete job information: attributes -->
<form name="form" action="/activator/sendCasePacket" method="POST" id="form">
<table>
   <input type="hidden" name="id" value="<%= jd.jobId %>">
   <input type="hidden" name="workflow" value="<%= jd.name %>">
   <input type="hidden" name="queue" value="confirm_eBGP_limit">

<%  AttributeDescriptor ad6 = jd.attributes[6];
    AttributeDescriptor ad7 = jd.attributes[7]; %>

<tr>
   <td><b>Customer Name (Id) </b></td>
   <td>&nbsp;&nbsp;</td>
   <td colspan="2">
<%= ad6.value == null ? "" : ad6.value %> (<%= ad7.value == null ? "" : ad7.value %>)
   </td>
</tr>

<% AttributeDescriptor ad3 = jd.attributes[3];
   AttributeDescriptor ad4 = jd.attributes[4]; %>
<tr>
   <td><b>VPN Name (Id) </b></td>
   <td>&nbsp;&nbsp;</td>
   <td colspan="2">
<%= ad3.value == null ? "" : ad3.value %> (<%= ad4.value == null ? "" : ad4.value %>)
   </td>
</tr>

<% AttributeDescriptor ad1 = jd.attributes[1];
   AttributeDescriptor ad2 = jd.attributes[2];
%>
<tr>
   <td><b>Site Name (Id) </b></td>
   <td>&nbsp;&nbsp;</td>
   <td colspan="2">
<%= ad2.value == null ? "" : ad2.value %> (<%= ad1.value == null ? "" : ad1.value %>)
   </td>
</tr>


<%
    AttributeDescriptor ad0 = jd.attributes[0];
    String maximum_prefix = ad0.value;
%>

<tr>
   <td colspan="3">&nbsp;</td>
</tr>

<tr>
   <td><b>Maximum prefix:</b></td>
   <td>&nbsp;&nbsp;</td>
   <td colspan="2">
      <input type="text" name="maximum_prefix" id="maximum_prefix" value="<%= maximum_prefix %>" size="7">
   </td>
   <td>&nbsp;</td>
</tr>

<tr>
   <td colspan="3">&nbsp;</td>
</tr>

<!-- Common trailer -->
<tr>
    <td align="center" colspan="4">
      <input type="submit" value="Confirm" onClick="
         if (checkResult()==false) {
           maximum_prefix.focus();
           maximum_prefix.select();
           return false;
         }
         confirm_bgp.value='0';">
      <input type="submit" value="Refuse">

      <input type="hidden" name="confirm_bgp" value="1">
    </td>
</tr>
</table>
</form>
</center>
</body>
</html>
