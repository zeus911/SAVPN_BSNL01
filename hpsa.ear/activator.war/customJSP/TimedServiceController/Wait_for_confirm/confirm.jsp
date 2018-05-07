<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->

<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>               
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/TimedServiceController/Wait_for_confirm/confirm.jsp,v $                                                                   --%>
<%-- $Revision: 1.9 $                                                                 --%>
<%-- $Date: 2010-11-15 07:44:13 $                                                                     --%>
<%-- $Author: tanye $                                                                   --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- Queue: 'confirm' --%>

<%@ page contentType="text/html; charset=UTF-8"
         import="com.hp.ov.activator.mwfm.JobRequestDescriptor,
                 com.hp.ov.activator.mwfm.servlet.Constants,
                 javax.sql.DataSource,
                 java.sql.Connection,
                 com.hp.ov.activator.mwfm.AttributeDescriptor,
                 java.util.ArrayList,
                 com.hp.ov.activator.vpn.inventory.*,
                 com.hp.ov.activator.vpn.inventory.Service,
                 com.hp.ov.activator.vpn.inventory.Customer,
                 com.hp.ov.activator.vpn.backup.DeviceInformation" %>
<%
 response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");

%>
<html>
<head>
  <title>hp OpenView service activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
 <meta http-equiv="expires" content="Wed, 26 Feb 1997 08:21:57 GMT">
 <script language="JavaScript">
    window.moveTo(50,50);
    window.resizeTo(800,600);
 </script>
</head>


<body onUnLoad="opener.window.top.interactWindow=null" onLoad="this.location='#end'">
<h3><img src="/activator/images/HPLogo.png" valign="top" align="right">Interact with job: Controller</h3>
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
<% 
JobRequestDescriptor jd=(JobRequestDescriptor) session.getAttribute(Constants.MWFM_JOB_DESCRIPTOR); 
%>
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
    AttributeDescriptor ad1 = jd.attributes[1];
    String action = ad1.value;




    AttributeDescriptor ad2 = jd.attributes[2];
    String serviceId = ad2.value;


    AttributeDescriptor ad3 = jd.attributes[3];
     String serviceName = ad3.value;

   

    AttributeDescriptor ad4 = jd.attributes[4];
    String workflowName = ad4.value;
     

    String type = "";
    String customerName = "";
     DataSource dataSource = (DataSource) session.getAttribute(Constants.DATASOURCE);
    Connection connection = null;
    try 
    {
            if (dataSource !=null)
            {
                connection = dataSource.getConnection();
                if (connection != null)
                {
                    Service serviceObj = Service.findByPrimaryKey(connection,serviceId);
                    if(serviceObj!=null)
                    {
                        type = serviceObj.getType();
                        String customerId =serviceObj.getCustomerid();
                        Customer customerObj = Customer.findByPrimaryKey(connection,customerId);
                        customerName = customerObj.getCustomername();
                    }
                }
            }
    }
    catch (Exception e) 
    {

    }
    finally{
        try{
            connection.close();
        }catch(Exception ex){
            // doesn't metter
        }
    }





%>
<p>
<%-- Concrete job information: attributes --%>
<form name="form" action="/activator/sendCasePacket" method="POST">
    <table>
        <input type="hidden" name="id" value="<%= jd.jobId %>">
        <input type="hidden" name="workflow" value="<%= jd.name %>">
        <input type="hidden" name="queue" value="confirm">
        <input type="hidden" name="TS_deactivation_needed">
<%              
        if(workflowName.indexOf("Modify") != -1 && workflowName.indexOf("CAR") != -1){   %>
        <tr>
            <td align="center" colspan="3">
                &nbsp;&nbsp;&nbsp;&nbsp; Rate limit modification time for Service Id <%=serviceId%> has been expired.
            </td>
        </tr>
        <tr>
            <td align="center" colspan="3">
                &nbsp;&nbsp;&nbsp;Proceed with <%=action%> (restore CAR value)?
            </td>
        </tr>
 <%     }
        else{
%>
        <tr>
            <td align="center" colspan="3">
                &nbsp;&nbsp;&nbsp;&nbsp; The scheduled end time for Service Id: <%=serviceId%> &nbsp;&nbsp; Service Name: <%= serviceName%> &nbsp;&nbsp; Service Type: <%= type%> &nbsp;&nbsp; Customer Name:<%=customerName%> &nbsp;&nbsp; has been reached.
            </td>
        </tr>
        <tr>
            <td align="center" colspan="3">
                &nbsp;&nbsp;&nbsp;Proceed with <%=action%>?
            </td>
        </tr>
        <%}%>
        <br>
        <br>
        <tr>
            <td align="center" colspan="3">
                <input type="submit" value="Yes" onClick="form.TS_deactivation_needed.value='true';">
                <input type="button"  value=" No " onClick="top.window.close();">
            </td>
        </tr>
    </table>
</form>
</center>
<a name="end"></a>
</body>
</html>
