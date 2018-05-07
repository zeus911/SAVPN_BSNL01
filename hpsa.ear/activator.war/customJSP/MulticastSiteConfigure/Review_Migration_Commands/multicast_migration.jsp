<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2017 Hewlett-Packard Enterprise. 				          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>               
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- Queue: '' --%>

<%@ page contentType="text/html; charset=UTF-8"
         import="javax.sql.DataSource,java.sql.Connection,
                 java.sql.*,com.hp.ov.activator.mwfm.JobRequestDescriptor,
                 com.hp.ov.activator.mwfm.WFManager,
                 com.hp.ov.activator.mwfm.servlet.Constants,
                 com.hp.ov.activator.mwfm.AttributeDescriptor,
                 java.util.ArrayList,
                 com.hp.ov.activator.vpn.inventory.*,
                 java.text.*,com.hp.ov.activator.cr.inventory.NetworkElement,
                 java.util.*,
                 com.hp.ov.activator.vpn.errorhandler.*,
                 com.hp.ov.activator.vpn.utils.*,
                 com.hp.ov.activator.inventory.facilities.StringFacility,
                 java.io.*, com.hp.ov.activator.cr.struts.nnm.cl.NNMiAbstractCrossLaunchAction, com.hp.ov.activator.nnm.common.*" %>

<%
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");

%>

<html>
<head>
  <title>hp OpenView service activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
   

 <style>
.infoHead{
    font-family: Verdana, Helvetica, Arial, Sans-serif;
   font-size: 8pt;
   font-weight: bold;
    color: black;
    width: 20%;
    border-right: 1px solid #cccccc;
    border-bottom: 1px solid #cccccc;
}

.infoValue{
    font-family: Verdana, Helvetica, Arial, Sans-serif;
   font-size: 8pt;
    color: black;
    border-right: 1px solid #cccccc;
    border-bottom: 1px solid #cccccc;
}

   </style>
   <script language="JavaScript">       
    window.resizeTo(800,700);
   </script>
</head>


<body onUnLoad="opener.window.top.interactWindow=null">
<h3><img src="/activator/images/HPLogo.png" valign="top" align="right">Interact with job: ErrorHandler</h3>
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
<% JobRequestDescriptor jd= (JobRequestDescriptor) session.getAttribute(Constants.MWFM_JOB_DESCRIPTOR); %>

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

<%


    String ip = request.getRemoteAddr();
    AttributeDescriptor ad0 = jd.attributes[0]; // return_code
    AttributeDescriptor ad1 = jd.attributes[1]; // VPN_Info
    AttributeDescriptor ad2 = jd.attributes[2]; // message_data
	AttributeDescriptor ad3 = jd.attributes[3]; // operator_name
    AttributeDescriptor ad4 = jd.attributes[4]; // message_url
    AttributeDescriptor ad5 = jd.attributes[5]; //skipactivation
    AttributeDescriptor ad6 = jd.attributes[6]; //activation_identifier
	AttributeDescriptor ad7 = jd.attributes[7]; //SERVICE_ID
    AttributeDescriptor ad8 = jd.attributes[8]; //isp object
    AttributeDescriptor ad9 = jd.attributes[9]; //activation_dialog_html

    
    
    String return_code = request.getParameter("return_code");
    if ( return_code == null ) {
      return_code = ad0.value == null ? "" : ad0.value;
    }

    String VPN_Info = request.getParameter("VPN_Info");
    if ( VPN_Info == null ) {
      VPN_Info = ad1.value == null ? "" : ad1.value;
    }

    String message_data = request.getParameter("message_data");
    if ( message_data == null ) {
      message_data = ad2.value == null ? "" : ad2.value;
    }
	
	String operator_name = request.getParameter("operator_name");
    if ( operator_name == null ) {
      operator_name = ad3.value == null ? "" : ad3.value;
    }

    String message_url = request.getParameter("message_url");
    if ( message_url == null ) {
      message_url = ad4.value == null ? "" : ad4.value;
    }

    String reject_migration = request.getParameter("reject_migration");
    if ( reject_migration == null ) {
      reject_migration = ad5.value == null ? "" : ad5.value;
    }

    String activation_identifier = request.getParameter("activation_identifier");
    if ( activation_identifier == null ) {
      activation_identifier = ad6.value == null ? "" : ad6.value;
    }
     
    String service_id = request.getParameter("service_id");
    if ( service_id == null ) {
      service_id = ad7.value == null ? "" : ad7.value;
    }
	
	String activation_dialog_html = request.getParameter("activation_dialog_html");
    if ( activation_dialog_html == null ) {
      activation_dialog_html = ad9.value == null ? "" : ad9.value;
    }

%>
    <p>
    <table cellspacing="5">


<tr>
   <td><b>VPN Info</b></td>
   <td colspan="3"><%= VPN_Info %></td>
</tr>

       <tr>
      <td align="center" colspan="5">
       </tr>

<tr>
   <td><b>Multicast migration commands</b></b></td>
   <td><%= activation_dialog_html %></td>
</tr>


      <%-- Concrete job information: attributes --%>
      <form name="form" action="/activator/sendCasePacket" method="POST"
        onsubmit="reject_migration.value=document.rsform.reject_migration.value">


        
        <input type="hidden" name="id" value="<%= jd.jobId %>">
        <input type="hidden" name="workflow" value="<%= jd.name %>">
        <input type="hidden" name="queue" value="multicast_migration">
        <input type="hidden" name="return_code" value="<%= return_code%>">
        <input type="hidden" name="operator_name" value="<%= session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) %>">
        <input type="hidden" name="reject_migration" value=""> 
        
       <tr>
      <td align="center" colspan="5">
       </tr>
       <tr>
      <td align="center" colspan="5">
       </tr>

   <tr>
        <td align="center" colspan="5">
        
        <input type="submit" width="30" value="Accept" onclick="accept();">
        <input type="submit" width="30" value="Reject" onclick="reject(); ">
		<input type="submit" width="40" value="Rollback migration" onclick="rollback(); ">
        
          </td>
        </tr>
      </form>

</table>
</center>



<script type="text/javascript" src="/activator/javascript/CRModel/utils.js"></script>
 <script language="JavaScript">     

 
 function cancel(){
		 window.close();
 }
 
 function reject(){
	document.form.reject_migration.value='5';                    
 }


 
  function accept(){
    document.form.reject_migration.value='0';
 }

 
 function rollback(){
	document.form.reject_migration.value='6';                    
 }
 
  </script>
</body>
</html>
