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
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/L3VPN_SetupSiteAttachment_CE/Confirm_CE_Setup/confirm_ce_setup.jsp,v $                                                                   --%>
<%-- $Revision: 1.8 $                                                                 --%>
<%-- $Date: 2010-11-15 07:43:15 $                                                                     --%>
<%-- $Author: tanye $                                                                   --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%><!-- Queue: 'confirm_ce_setup' -->

<%@ page contentType="text/html; charset=UTF-8"
         import="com.hp.ov.activator.mwfm.*, com.hp.ov.activator.mwfm.servlet.*" %>
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
        if(document.getElementById("ce_confirm").value == "close"){
            top.window.close();
        }else{
            document.getElementById("form").submit();
        }


    }
</script>

<body onload="window.resizeTo(650,450);" >
<h3><img src="/activator/images/HPLogo.png" valign="top" align="right">Interact with job: AddSiteVPN</h3>
<%--<h6>Using file: C:\HP\jboss\server\default\deploy\hpovact.sar\activator.war\customJSP\AddSiteVPN\Confirm_CE_Setup\confirm_ce_setup.jsp</h6>--%>
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
   <input type="hidden" name="queue" value="confirm_ce_setup">
   <input type="hidden" name="ce_confirm">
 <% AttributeDescriptor customerNameAttr = jd.attributes[5]; %>
 <% AttributeDescriptor customerIdAttr = jd.attributes[6]; %>

<tr>
   <td><b>Customer(id)</b></td>
   <td>
<%= customerNameAttr.value == null ? "" : com.hp.ov.activator.inventory.facilities.StringFacility.replaceAllByHTMLCharacter(customerNameAttr.value) %>
(<%= customerIdAttr.value == null ? "" : com.hp.ov.activator.inventory.facilities.StringFacility.replaceAllByHTMLCharacter(customerIdAttr.value) %>)
   </td>
   <td>&nbsp;</td>
</tr>

 <% AttributeDescriptor vpnNameAttr = jd.attributes[2]; %>
 <% AttributeDescriptor vpnIdAttr = jd.attributes[3]; %>

<tr>
   <td><b>VPN(id)</b></td>
   <td>
<%= vpnNameAttr.value == null ? "" : com.hp.ov.activator.inventory.facilities.StringFacility.replaceAllByHTMLCharacter(vpnNameAttr.value) %>
(<%= vpnIdAttr.value == null ? "" : com.hp.ov.activator.inventory.facilities.StringFacility.replaceAllByHTMLCharacter(vpnIdAttr.value) %>)
   </td>
   <td>&nbsp;</td>
</tr>

 <% AttributeDescriptor siteNameAttr = jd.attributes[4]; %>
 <% AttributeDescriptor siteIdAttr = jd.attributes[0]; %>

<tr>
   <td><b>Site(id)</b></td>
   <td>
<%= siteNameAttr.value == null ? "" : siteNameAttr.value %>
(<%= siteIdAttr.value == null ? "" : siteIdAttr.value %>)
   </td>
   <td>&nbsp;</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>
<tr>
   <td align="center" colspan="3"><b>Is CE setup done?</b></td>
   <td>
   <!--select name="ce_confirm" id="ce_confirm">
    <option value="close">Not yet</option>
    <option value="true">Yes</option>
   </select>
   </td>
   <td>&nbsp;</td-->
</tr>

<!-- Common trailer -->
<tr>
    <td align="center" colspan="3">
      <input  type="submit" value="Yes" onClick="form.ce_confirm.value='true';window.close()">
       <input type="button"  value=" No " onClick="top.window.close();">
    </td>
</tr>
<tr>
    <td colspan="2">
        <pre>
            <%=com.hp.ov.activator.inventory.facilities.StringFacility.replaceAllByHTMLCharacter(jd.attributes[7].value)%>
        </pre>
    </td>
</tr>
</table>
</form>
</center>
</body>
</html>
