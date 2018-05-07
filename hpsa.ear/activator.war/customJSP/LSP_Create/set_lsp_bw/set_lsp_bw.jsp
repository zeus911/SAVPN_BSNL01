<!-- ============================================================== -->
<!-- HP Service Activator V51-1A                                    -->

<!-- Customized JSP.                                                -->
<!--                                                                -->
<!-- Copyright 2000-2003 Hewlett-Packard Development Company, L.P.  -->
<!-- All Rights Reserved                                            -->
<!--                                                                -->
<!-- ============================================================== -->
<!-- Queue: 'set_lsp_bw' -->
<%@ page contentType="text/html; charset=UTF-8"
         import="com.hp.ov.activator.mwfm.*, com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.inventory.facilities.StringFacility, com.hp.ov.activator.cr.inventory.*, com.hp.ov.activator.vpn.inventory.*, java.sql.*, javax.sql.DataSource, java.util.*, java.io.*" %>

<%
     DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);
     Connection dataBaseConnection = dataSource.getConnection();;
     LSP lSP1=null;
     LSP lSP2=null;
     
     JobRequestDescriptor jobRequestDescriptor=(JobRequestDescriptor) session.getAttribute(Constants.MWFM_JOB_DESCRIPTOR);
     AttributeDescriptor lSP1ID = jobRequestDescriptor.attributes[0];
     
     lSP1 = LSP.findByLspid(dataBaseConnection, lSP1ID.value); 
     
     AttributeDescriptor lSP2ID = jobRequestDescriptor.attributes[1];
     lSP2 = LSP.findByLspid(dataBaseConnection, lSP2ID.value); 

     AttributeDescriptor lSP1BandWidthAttr = jobRequestDescriptor.attributes[2];
     AttributeDescriptor lSP2BandWidthAttr = jobRequestDescriptor.attributes[3];
     String lSP1BandWidth = null;
     String lSP2BandWidth = null;
     if ( lSP1BandWidthAttr != null ) { 
        lSP1BandWidth = lSP1BandWidthAttr.value;
     }
     if ( lSP2BandWidthAttr != null ) { 
        lSP1BandWidth = lSP2BandWidthAttr.value;
     }
     
     String lSP1Headpe=null;
     String lSP1Tailpe=null;
     String lSP2Headpe=null;
     String lSP2Tailpe=null;
     if ( lSP1 != null ) {
         lSP1Headpe=com.hp.ov.activator.vpn.inventory.NetworkElement.findByNetworkelementid(dataBaseConnection,lSP1.getHeadpe()).getName();
         lSP1Tailpe=com.hp.ov.activator.vpn.inventory.NetworkElement.findByNetworkelementid(dataBaseConnection,lSP1.getTailpe()).getName();
     }
     if ( lSP2 != null ) {
         lSP2Headpe=com.hp.ov.activator.vpn.inventory.NetworkElement.findByNetworkelementid(dataBaseConnection,lSP2.getHeadpe()).getName();
         lSP2Tailpe=com.hp.ov.activator.vpn.inventory.NetworkElement.findByNetworkelementid(dataBaseConnection,lSP2.getTailpe()).getName();
     }
     
	 String whereForRate = "RateLimitName != 'Unknown'";
     RateLimit bandWidthRateLimits[]=RateLimit.findAll(dataBaseConnection, whereForRate);
     
     String lSP1AdminStateToolTip="Check this to activate LSP1";
     String lSP1BandWidthToolTip="Bandwidth between "+lSP1Headpe+" and "+lSP1Tailpe;
     String lSP2BandWidthToolTip="Bandwidth between "+lSP2Headpe+" and "+lSP2Tailpe;
     String lSP2AdminStateToolTip="Check this to activate LSP2";
     AttributeDescriptor vpnInfoAttr = jobRequestDescriptor.attributes[6];
     String vpnInfo = vpnInfoAttr.value;
	 dataBaseConnection.close();
%>
<html>
<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
  <script language="JavaScript" src='/activator/javascript/saUtilities.js'></script>
  <script language="JavaScript">
    function submitForm() {
        var form=document.form
        form.lsp1BandWidth.value=form.cmbLSP1BandWidth.value
        form.lsp2BandWidth.value=form.cmbLSP2BandWidth.value
        if ( form.chkLSP1AdminState.checked ) {
            form.lsp1AdminState.value="Up"
        } else {
            form.lsp1AdminState.value="Down"
        }
        if ( form.chkLSP2AdminState.checked ) {
            form.lsp2AdminState.value="Up"
        } else {
            form.lsp2AdminState.value="Down"
        }
        form.submit();
    }
  </script>
  <meta http-equiv="content-type" content="text/html; charset=utf-8">
</head>


<body onmousemove='logoutTimerReset();' onkeydown='logoutTimerReset();' onUnLoad="opener.window.top.interactWindow=null">
<h3><img src="/activator/images/HPlogo-black.gif" valign="top" align="right">Interact with job: LSP_Create</h3> 
<br>
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
   <td class="tableRow"> <%= jobRequestDescriptor.description == null ? "&nbsp;" : jobRequestDescriptor.description %> </td>
</tr>
</table>
<p>
<!-- Concrete job information: attributes -->
<form name="form" action="/activator/sendCasePacket" onsubmit="return validateDataTypes('count','askfor')" method="POST">
<table>
   <input type="hidden" name="id" value="<%= jobRequestDescriptor.jobId %>">
   <input type="hidden" name="workflow" value="<%= jobRequestDescriptor.name %>">
   <input type="hidden" name="queue" value="set_lsp_bw">

    <tr  class="tableRow" style="background: #FFFFFF">
       <td ><b title="<%=lSP1BandWidthToolTip%>" >LSP1 Bandwidth<br>(<%=lSP1Headpe%> -> <%=lSP1Tailpe%>)&nbsp;&nbsp;&nbsp;</b></td>
       <td>
        <select name="cmbLSP1BandWidth" style="width:130px" title="<%=lSP1BandWidthToolTip%>" >
                <%
                    String bandWidth=null;
                    for (int counter=0;counter<bandWidthRateLimits.length; counter++) {
                        bandWidth=bandWidthRateLimits[counter].getRatelimitname();
                       // if ( bandWidth.contains("_") ) continue;
                        if ( lSP1BandWidth != null && lSP1BandWidth.equals(bandWidth) ) {
                          %><option value="<%=bandWidth%>" selected><%=bandWidth%></option> <%
                        } else {
                          %><option value="<%=bandWidth%>" ><%=bandWidth%></option> <%
                        }
                   }
                %>
        </select>
       </td>
       <td></td>
    </tr>
    <tr  class="tableRow" style="background: #FFFFFF">
       <td></td>
       <td>
            <input type="checkbox" name="chkLSP1AdminState" Value="true" title="<%=lSP1AdminStateToolTip%>" checked > <font title="<%=lSP1AdminStateToolTip%>">Activate LSP</font>
       </td>
       <tr>
    </tr>

    <tr class="tableRow" style="background: #FFFFFF">
       <td ><b title="<%=lSP2BandWidthToolTip%>" >LSP2 Bandwidth<br>(<%=lSP2Headpe%> -> <%=lSP2Tailpe%>)&nbsp;&nbsp;&nbsp;</b></td>
       <td>
            <select name="cmbLSP2BandWidth" style="width:130px"  title="<%=lSP2BandWidthToolTip%>"  >
                <%
                    bandWidth=null;
                    for (int counter=0;counter<bandWidthRateLimits.length; counter++) {
                        bandWidth=bandWidthRateLimits[counter].getRatelimitname();
                       // if ( bandWidth.contains("_") ) continue;
                        if ( lSP2BandWidth != null && lSP2BandWidth.equals(bandWidth) ) {
                          %><option value="<%=bandWidth%>" selected><%=bandWidth%></option> <%
                        } else {
                          %><option value="<%=bandWidth%>" ><%=bandWidth%></option> <%
                        }
                   }
                %>
            </select>
       </td>
       <td></td>
    </tr>
    <tr  class="tableRow"  style="background: #FFFFFF" >
        <td></td>
        <td>
            <input type="checkbox" name="chkLSP2AdminState" Value="true" title="<%=lSP2AdminStateToolTip%>" checked> <font title="<%=lSP2AdminStateToolTip%>">Activate LSP</font>
       </td>
    </tr>
    <!-- Common trailer -->
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr>
        <td align="center" colspan="3">
           <input type="Button" value=" Submit" style="width:60px" OnClick="submitForm()"> &nbsp;&nbsp;
           <input type="reset"  value=" Clear " style="width:60px">
        </td>
    </tr>
</table>
<input type="hidden" name="lsp1id"  value="<%=lSP1ID.value%>">
<input type="hidden" name="lsp2id"  value="<%=lSP1ID.value%>">
<input type="hidden" name="lsp1BandWidth"  value="">
<input type="hidden" name="lsp2BandWidth"  value="">
<input type="hidden" name="lsp1AdminState"  value="">
<input type="hidden" name="lsp2AdminState"  value="">
</form>
</center>
</body>
</html>
