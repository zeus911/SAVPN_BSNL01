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
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/Modify_ifAddr/SelectRouterAndIf/modify_if_addr.jsp,v $                                                                   --%>
<%-- $Revision: 1.8 $                                                                 --%>
<%-- $Date: 2010-11-15 07:43:44 $                                                                     --%>
<%-- $Author: tanye $                                                                   --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- Queue: 'modify_if_addr' --%>

<%@ page contentType="text/html; charset=UTF-8"
         import="com.hp.ov.activator.mwfm.JobRequestDescriptor,
                 com.hp.ov.activator.mwfm.servlet.Constants,
                 com.hp.ov.activator.mwfm.AttributeDescriptor,
                 com.hp.ov.activator.vpn.inventory.TerminationPoint,
                 javax.sql.DataSource,
                 java.sql.Connection,
                 com.hp.ov.activator.vpn.inventory.NetworkElement,
                 com.hp.ov.activator.vpn.inventory.RouterInterface,
                 com.hp.ov.activator.vpn.inventory.PERouter" %>
<%
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");

%>
<html>
<head>
  <title>hp OpenView service activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">
  <script language="JavaScript">    
    window.moveTo(50,50);
    window.resizeTo(800,600);
  </script>
</head>

<body onUnLoad="opener.window.top.interactWindow=null">
<h3><img src="/activator/images/HPLogo.png" valign="top" align="right">Interact with job: ModifyIfAddr</h3>
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

<%  
//    AttributeDescriptor ad0 = jd.attributes[0];
//    AttributeDescriptor ad1 = jd.attributes[1];
//    AttributeDescriptor ad2 = jd.attributes[2];
//    AttributeDescriptor ad3 = jd.attributes[3];

    String ALL_PRESENT  = "0";
    String NO_EQUIPMENT = "1";
    String NO_INTERFACE = "2";
    String NO_DB = "3";

    com.hp.ov.activator.vpn.inventory.NetworkElement[] routers = null;
    TerminationPoint[] interfaces = null;

    String selected_router_id = request.getParameter("selected_router_id");
    String selected_interface_id = request.getParameter("selected_interface_id");
    
    String ret_value = ALL_PRESENT;
    int selected = 0;

    DataSource ds = (DataSource)session.getAttribute(Constants.DATASOURCE);
    Connection con = null;
    try {
        if (ds != null)  {
          con = ds.getConnection();
          if (con != null) {
            String whereClause = "NetworkElement.NETWORKELEMENTID not like 'Unknown_%%'  and state in ('Up', 'Reserved') and NetworkElement.Lifecyclestate != 'Planned'";              
              routers = NetworkElement.findAll(con, whereClause);

          // Select the first router in the list, or the one selected using the selected_router_id parameter.
              String ne_id = "";
              if (routers != null && routers.length > 0) {
                if (selected_router_id != null) {
                      for (int i = 0 ; i < routers.length; i++) {
                            if (routers[i].getNetworkelementid().equals(selected_router_id)) {
                                ne_id = routers[i].getNetworkelementid();
                            }
                      }
                } else {
                      ne_id = routers[0].getNetworkelementid();
                }
                
                // Find all interfaces on the selected router, which are free.
                    String whereClause2 = "count__ > 0";
                interfaces = RouterInterface.findByNe_id(con, ne_id, whereClause2);
                
                if (interfaces == null) {
                      ret_value = NO_INTERFACE;
                      interfaces = null;
                }
          } else {
             interfaces = null;
               ret_value = NO_EQUIPMENT;
            }
          } else {
             interfaces = null;
             ret_value = NO_DB;
          }
        } else {
          interfaces = null;
          ret_value = NO_DB;
        }
 %>
    
      <p>
      <table>

<%    if (!ret_value.equals(NO_EQUIPMENT) && !ret_value.equals(NO_DB)) { %>
        <form name="rsform" action="/activator/customJSP/Modify_ifAddr/SelectRouterAndIf/modify_if_addr.jsp" method="POST">
          <tr>
            <td class="list0"><b>Select Router</b>&nbsp;&nbsp;</td><td class="list0">
              <select name="selected_router_id" onchange="document.rsform.submit()">
<%              if ( routers != null) {
                  for (int i = 0 ; i < routers.length; i++) {
                    if (routers[i].getNetworkelementid().equals(selected_router_id)) {
                      selected = i;  %>
                      <option SELECTED value=<%= routers[i].getNetworkelementid() %> ><%= routers[i].getName() %></option>
<%                  } else { %>
                      <option value=<%= routers[i].getNetworkelementid() %> ><%= routers[i].getName() %></option>
<%                  }
                  }
                }  %>
              </select>
            </td>
          </tr>

          <tr>
            <td><b>Router Id</b></td>
            <td><i><%= routers[selected].getNetworkelementid() %></i></td>
          </tr>
        </form>

        <form name="ifform" action="/activator/customJSP/Modify_ifAddr/SelectRouterAndIf/modify_if_addr.jsp" method="POST">
          <input type="hidden" name="selected_router_id" value="<%= routers[selected].getNetworkelementid() %>">
          <tr>
            <td class="list0"><b>Select Interface</b>&nbsp;&nbsp;</td><td class="list0">
              <select name="selected_interface_id" onchange="document.ifform.submit()">
<%              if ( interfaces != null) {
                  if (selected_interface_id == null || selected_interface_id.equals("SelectInterface") || selected_interface_id.equals("null")) { %>
                    <option selected value="SelectInterface">Select interface</option>
<%                } %>
<%                for (int i = 0 ; i < interfaces.length; i++) { 
                    if (interfaces[i].getTerminationpointid().equals(selected_interface_id)) { %>
                      <option selected value=<%= interfaces[i].getTerminationpointid() %> ><%= interfaces[i].getName() %></option>
<%                  } else { %>
                      <option value=<%= interfaces[i].getTerminationpointid() %> ><%= interfaces[i].getName() %></option>
<%                  } 
                  }
                } else { %>
                  <option selected value="NoInterfaces" >No interfaces</option>
<%              } %>
              </select>
            </td>
          </tr>
        </form>
<%    } %>


<%    if (ret_value.equals(ALL_PRESENT) && selected_router_id != null && selected_interface_id != null &&
          !selected_interface_id.equals("NoInterfaces") && !selected_interface_id.equals("SelectInterface")) { %>
          
        <!-- Concrete job information: attributes --%>
        <form name="form" action="/activator/sendCasePacket" method="POST">
          <input type="hidden" name="id" value="<%= jd.jobId %>">
          <input type="hidden" name="workflow" value="<%= jd.name %>">
          <input type="hidden" name="queue" value="modify_if_addr">
          <input type="hidden" name="selected_router_id" value="<%= selected_router_id %>">
          <input type="hidden" name="selected_interface_id" value="<%= selected_interface_id %>">
          <input type="hidden" name="RET_VALUE" value="<%= ret_value %>">

          <tr>
            <td><b>Interface Id</b></td>
            <td><i><%= selected_interface_id %></i></td>
          </tr>

          <tr heigth=60>
            </td colspan=3>
          </tr>

          <tr>
            <td><b>New IP address</b></td>
            <td><input name="new_ip_address"></td>
          </tr>

          <tr>  
            <td><b>New mask</b></td>
            <td><input name="new_mask"></td>              
            <td>Netmask eg. 255.255.255.0</td>              
          </tr>

          <!-- Common trailer --%>
          <tr>
            <td colspan="3">&nbsp;</td>
          </tr>
          <tr>
            <td align="center" colspan="3">
              <input type="submit" value="Submit" >
              <input type="reset"  value="Clear">
            </td>
          </tr>
        </form>
        
<%    } else { %>

        <form name="form" action="/activator/sendCasePacket" method="POST">
          <input type="hidden" name="id" value="<%= jd.jobId %>">
          <input type="hidden" name="workflow" value="<%= jd.name %>">
          <input type="hidden" name="queue" value="modify_if_addr">
          <input type="hidden" name="selected_router_id" value="-">
          <input type="hidden" name="selected_interface_id" value="-">
          <input type="hidden" name="new_mask" value="-">
          <input type="hidden" name="new_ip_address" value="-">
          <input type="hidden" name="RET_VALUE" value="<%= NO_EQUIPMENT %>">

<%        if (ret_value.equals(NO_EQUIPMENT)) { %>
            <tr>
              <td><b>No routers available.</b></td>
            </tr>              
<%        } %>

<%        if (ret_value.equals(NO_DB)) { %>
            <tr>
              <td><b>No Database Connection avaiable.</b></td>
            </tr>
<%        } %>
          
          <tr>
            <td colspan="2">&nbsp;</td>
          </tr>
          
          <tr>
            <td align="center" colspan="3">
              <input type="submit" value="Cancel" >
            </td>
          </tr>
        </form>
<%    } 
    } catch (Exception e) {
      System.out.println("Exception in Router selection: " + e.getMessage());
    } finally{
         try{
            con.close();
         }catch(Exception ex){
           System.out.println("Exception during the closing connection in modify_if_addr.jsp : " + ex.getMessage());
         }
    }
%>
    </table>
  </center>
</body>
</html>
