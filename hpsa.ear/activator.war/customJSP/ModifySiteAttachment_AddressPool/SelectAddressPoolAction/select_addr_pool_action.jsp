<!-- ============================================================== -->
<!-- HP Service Activator V70-3A                                    -->
<!-- Customized JSP.                                                -->
<!--                                                                -->
<!-- Copyright 2000-2015 Hewlett-Packard Development Company, L.P.  -->
<!-- All Rights Reserved                                            -->
<!--                                                                -->
<!-- ============================================================== -->
<!-- Queue: 'select_addr_pool_action' -->
<%@ page contentType="text/html; charset=UTF-8"
         import="com.hp.ov.activator.mwfm.*, com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.inventory.facilities.StringFacility, com.hp.ov.activator.cr.inventory.*, com.hp.ov.activator.vpn.inventory.*, java.sql.*, javax.sql.DataSource, java.util.*, java.io.*" %>

<%
     JobRequestDescriptor jobRequestDescriptor = (JobRequestDescriptor) session.getAttribute(Constants.MWFM_JOB_DESCRIPTOR);
	 
	 String selected_option = null;
	 
	 String vpnInfo = null;
	 String pe_if_addr = null;
	 String ce_if_addr = null;
	 
	 AttributeDescriptor vpnInfoAttr = jobRequestDescriptor.attributes[0];
	 AttributeDescriptor peIfAddrAttr = jobRequestDescriptor.attributes[1];
	 AttributeDescriptor ceIfAddrAttr = jobRequestDescriptor.attributes[2];
	 
	 vpnInfo = vpnInfoAttr.value;
	 pe_if_addr = peIfAddrAttr.value;
	 ce_if_addr = ceIfAddrAttr.value;
	 
	 String peIPString = "PE Interface IP: ";
	 String ceIPString = "CE Interface IP: ";
	 String textString = "CE Activation has failed. Please choose one of the next three options: ";

%>
<html>
<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
  <script language="JavaScript" src='/activator/javascript/saUtilities.js'></script>
  <script language="JavaScript">       
		window.resizeTo(800,450);
	  </script>
  <script language="JavaScript">
    
	function submitFormManualFix() 
	{
        var form = document.form;
        
		form.selected_option.value = "ManualFix";
		
        form.submit();
    }
	
	function submitFormRetryCE() 
	{
        var form = document.form;
        
		form.selected_option.value = "RetryCE";
		
        form.submit();
    }
	
	function submitFormRollbackPE() 
	{
        var form = document.form;
        
		form.selected_option.value = "RollbackPE";
		
        form.submit();
    }
	
  </script>
  <meta http-equiv="content-type" content="text/html; charset=utf-8">
</head>
<body onmousemove='logoutTimerReset();' onkeydown='logoutTimerReset();' onUnLoad="opener.window.top.interactWindow=null">
<h3><img src="/activator/images/HPlogo-black.gif" valign="top" align="right">Interact with job: ModifySiteAttachment_AddressPool</h3> 
<center>
<table width="100%" border=0 cellpadding=0>
<tr>
   <td class="tableHeading">VPN Info</td>
   <td class="tableHeading">Service Id</td>
   <td class="tableHeading">Workflow</td>
   <td class="tableHeading">Status</td>
   <td class="tableHeading">Start Time</td>
   <td class="tableHeading">Post Time</td>
   <td class="tableHeading">Step</td>
   <td class="tableHeading">Description</td>
</tr>
<tr>
   <td class="tableRow"> <%= vpnInfo %> </td>
   <td class="tableRow"> <%= jobRequestDescriptor.serviceId %> </td>
   <td class="tableRow"> <%= jobRequestDescriptor.name %> </td>
   <td class="tableRow"> <%= jobRequestDescriptor.status == null ? "&nbsp;" : jobRequestDescriptor.status %> </td>
   <td class="tableRow"> <%= jobRequestDescriptor.startTime %> </td>
   <td class="tableRow"> <%= jobRequestDescriptor.postDate %> </td>
   <td class="tableRow"> <%= jobRequestDescriptor.stepName == null ? "&nbsp;" : jobRequestDescriptor.stepName %> </td>
   <td class="tableRow"> Select failover option </td>
</tr>
</table>
<p>
<form name="form" action="/activator/sendCasePacket" method="POST">
<table>
   <input type="hidden" name="id" value="<%= jobRequestDescriptor.jobId %>">
   <input type="hidden" name="workflow" value="<%= jobRequestDescriptor.name %>">
   <input type="hidden" name="queue" value="select_addr_pool_action">
	 
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr class="tableRow" style="background: #FFFFFF">
		<td><b><%=peIPString%></b></td>
		<td><%=pe_if_addr%></td>
		<td></td>
	 </tr>
	 <tr class="tableRow" style="background: #FFFFFF">
		<td><b><%=ceIPString%></b></td>
		<td><%=ce_if_addr%></td>
		<td></td>
	 </tr>
	 
	 <tr><td colspan="2">&nbsp;</td></tr>
	 
	 <tr class="tableRow" style="background: #FFFFFF">
		<td colspan="3"><b><%=textString%></b></td>
	 </tr>
   
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr>
        <td align="center" colspan="3">
		   <input type="Button" value="Configure CE Manually" OnClick="submitFormManualFix()"> &nbsp;&nbsp;
		   <input type="Button" value="Retry CE Activation" OnClick="submitFormRetryCE()"> &nbsp;&nbsp;
           <input type="Button" value="Rollback PE Activation" OnClick="submitFormRollbackPE()"> &nbsp;&nbsp;
        </td>
    </tr>
</table>
<input type="hidden" name="selected_option"  value="">
</form>
</center>
</body>
</html>
