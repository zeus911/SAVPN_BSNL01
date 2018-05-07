
<%@page info="View JSP for bean Sh_L3SiteConnection"
      import="com.hp.ov.activator.mwfm.servlet.*,
              com.hp.ov.activator.mwfm.*,
              com.hp.ov.activator.util.*,
              java.sql.*,
              com.hp.ov.activator.mwfm.WFManager,
              javax.sql.DataSource,
              java.net.*,
              java.text.*,
              java.util.StringTokenizer"
      session="true"
      contentType="text/html;charset=utf-8"
%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>

<!---------------------------------------------------------------------
-- hp OpenView Service Activator InventoryBuilder 4.1
--
-- (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
----------------------------------------------------------------------->

<%
    if (session == null || session.getValue(Constants.USER) == null) {
        response.sendRedirect("/activator/jsp/sessionError.jsp");
        return;
    }

    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");

     String showAttachmentParams=null;
     showAttachmentParams=request.getParameter("showAttachmentParams");

%>

<%!   public int getSlashMask(String netMask){

        int count=0,mask=0;
        if(netMask != null){
            StringTokenizer tok = new StringTokenizer(netMask , "." );
            for (int i=0; i<4; i++) {
                String addr = tok.nextToken();
                mask = (mask << 8) + Integer.parseInt(addr);
            }

            for (int i=0; i<32; i++) {
            count += mask & 1;
                mask >>= 1;
            }
        }
        return count;
      }
%>

<script>
    var fPtr=parent.messageLine.document;
    fPtr.open();
    fPtr.write("");
    fPtr.close();
</script>

<html>
<head>
  <title>View Sh_L3SiteConnection</title>
  <script language="JavaScript" src="/activator/javascript/checks.js"></script>
  <!-- <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">-->
  <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
</head>
<body>


<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.Sh_L3SiteConnection" />
<%


    // Set the properties on the bean - these values have been encoded and must be decoded prior to use
    if(request.getParameter("primaryKey") != null) {
        bean.setPrimaryKey(URLDecoder.decode(request.getParameter("primaryKey"), "UTF-8"));
    }
    else {
        bean.setConnectionid(request.getParameter("connectionid") == null ? "" : URLDecoder.decode(request.getParameter("connectionid"),"UTF-8" ));
    }

    String displayKey = bean.getPrimaryKey();
%>

<%
    DataSource dataSource = (DataSource)session.getAttribute(Constants.DATASOURCE);
    Connection connection = null;
    try {
        connection = (Connection)dataSource.getConnection();
        bean = (com.hp.ov.activator.vpn.inventory.Sh_L3SiteConnection)com.hp.ov.activator.vpn.inventory.Sh_L3SiteConnection.findByPrimaryKey( connection, bean.getPrimaryKey() );
    if ( bean == null )
    {
%>
    <script>
    alert("Unable to display view for: Sh_L3SiteConnection <%=displayKey%>" + "\n" +
    "Potential reasons for failure are: "
     + "\n\n" + "   - The name of the object in the inventoryTree.xml file is incorrect."
     + "\n" + " - A parameter name in the inventoryTree.xml file is incorrect."
     + "\n" + " - The requested data may have previously been deleted.");
    </script>
<%
    } else {
%>

<center>
<table cellSpacing="2" cellPadding="2" border="0" width="90%">
<tr class="tableTitle">
<td>
<bean:message bundle="InventoryResources" key="name.heading"/>
</td>
<td>
<bean:message bundle="InventoryResources" key="value.heading"/>
</td>
<td>
<bean:message bundle="InventoryResources" key="description.heading"/>
</td>
</tr><tr><td class="tableHeading" height=3 colspan=3></td></tr><tr class="tableEvenRow">
   <td> <div class="tableCell">ConnectionID</div></td>
   <td class="tableCell"><%= bean.getConnectionid() == null ? "" : TextFormater.HTMlize(bean.getConnectionid()) %></td>
   <td class="tableCell">Connection identifier</td>
</tr>
<tr class="tableOddRow">
   <td> <div class="tableCell">Network</div></td>
   <td class="tableCell"><%= bean.getNetworkid1() == null ? "" : TextFormater.HTMlize(bean.getNetworkid1()) %></td>
   <td class="tableCell">Identifier of Network1 (PE)</td>
</tr>
<tr class="tableEvenRow">
   <td> <div class="tableCell">PE Router</div></td>
   <td class="tableCell"><%= bean.getNe1() == null ? "" : TextFormater.HTMlize(bean.getNe1()) %></td>
   <td class="tableCell">PE NE identifier</td>
</tr>
<tr class="tableOddRow">
   <td> <div class="tableCell">PE Interface</div></td>
   <td class="tableCell"><%= bean.getTp1() == null ? "" : TextFormater.HTMlize(bean.getTp1()) %></td>
   <td class="tableCell">PE Interface identifier</td>
</tr>
<tr class="tableEvenRow">
   <td> <div class="tableCell">CE Router</div></td>
   <td class="tableCell"><%= bean.getNe2() == null ? "" : TextFormater.HTMlize(bean.getNe2())  %></td>
   <td class="tableCell">CE NE identifier</td>
</tr>
<tr class="tableOddRow">
   <td> <div class="tableCell">CE Interface</div></td>
   <td class="tableCell"><%= bean.getTp2() == null ? "" : TextFormater.HTMlize(bean.getTp2()) %></td>
   <td class="tableCell">CE Interface identifier</td>
</tr>
<tr class="tableEvenRow">
   <td> <div class="tableCell">Protocol</div></td>
   <td class="tableCell"><%= bean.getProtocol() == null ? "" : TextFormater.HTMlize(bean.getProtocol()) %></td>
   <td class="tableCell">Routing protocol run on the link</td>
</tr>
<tr class="tableOddRow">
   <td> <div class="tableCell">IPNet</div></td>
   <td class="tableCell"><%= bean.getIpnet() == null ? "" : TextFormater.HTMlize(bean.getIpnet()) %></td>
   <td class="tableCell">IP address of The Net Link</td>
</tr>
<tr class="tableEvenRow">
   <td> <div class="tableCell">PE_InterfaceIP</div></td>
   <td class="tableCell"><%= bean.getPe_interfaceip() == null ? "" : TextFormater.HTMlize(bean.getPe_interfaceip()) %></td>
   <td class="tableCell">IP Address of the PE interface</td>
</tr>
<tr class="tableOddRow">
   <td> <div class="tableCell">CE_InterfaceIP</div></td>
   <td class="tableCell"><%= bean.getCe_interfaceip() == null ? "" : TextFormater.HTMlize(bean.getCe_interfaceip()) %></td>
   <td class="tableCell">IP Address of the CE interface</td>
</tr>
<tr class="tableEvenRow">
   <td> <div class="tableCell">SOO_Configured</div></td>
   <td class="tableCell"><%= bean.getSoo_configured() ? "Yes" : "No" %> </td>
   <td class="tableCell">Status of the Site of Origin Configuration</td>
</tr>


<%if(bean.getMdtdata() != null){%>

<tr class="tableOddRow">
   <td><div class="tableCell">MDTData</div></td>
   <td class="tableCell"><%= bean.getMdtdata()== null ? "" : TextFormater.HTMlize(bean.getMdtdata()) %></td>
   <td class="tableCell">Multicast data group</td>
</tr>

<%}%>


<%if(bean.getLoopaddr() != null){%>
<tr class="tableEvenRow">
   <td> <div class="tableCell">LoopAddr</div></td>
   <td class="tableCell"><%= bean.getLoopaddr() == null ? "" : TextFormater.HTMlize(bean.getLoopaddr()) %></td>
   <td class="tableCell">The address for multicast loopback interface</td>
</tr>

<%}%>

<%if(bean.getLoopid() != null){%>
<tr class="tableOddRow">
   <td> <div class="tableCell">LoopId</div></td>
   <td class="tableCell"><%= bean.getLoopid() == null ? "" : TextFormater.HTMlize(bean.getLoopid()) %></td>
   <td class="tableCell">The Loopback Id for multicast loopback interface</td>
</tr>

<%}%>

<%if(bean.getRp() != null){%>
<tr class="tableEvenRow">
   <td> <div class="tableCell">RP</div></td>
   <td class="tableCell"><%= bean.getRp() == null ? "" : TextFormater.HTMlize(bean.getRp()) %></td>
   <td class="tableCell">Randezvous point status if the multicast is enabled</td>
</tr>

<%}%>


<%if(bean.getQosprofile_pe() != null){%>
<tr class="tableOddRow">
   <td> <div class="tableCell">QoSProfile_PE</div></td>
   <td class="tableCell"><%= bean.getQosprofile_pe() == null ? "" : TextFormater.HTMlize(bean.getQosprofile_pe()) %></td>
   <td class="tableCell">The QoS profile on the PE</td>
</tr>

<%}%>

<%if(bean.getQosprofile_ce() != null){%>
<tr class="tableEvenRow">
   <td> <div class="tableCell">QoSProfile_CE</div></td>
   <td class="tableCell"><%= bean.getQosprofile_ce() == null ? "" : TextFormater.HTMlize(bean.getQosprofile_ce()) %></td>
   <td class="tableCell">The QoS profile on the CE</td>
</tr>

<%}%>




<%if(bean.getRatelimit_out() != null){%>
<tr class="tableOddRow">
   <td> <div class="tableCell">RateLimit_out</div></td>
   <td class="tableCell"><%= bean.getRatelimit_out() == null ? "" : TextFormater.HTMlize(bean.getRatelimit_out()) %></td>
   <td class="tableCell">RateLimit for outgoing traffic</td>
</tr>
<%}%>


<%if(bean.getRatelimit_in() != null){%>
<tr class="tableEvenRow">
   <td> <div class="tableCell">RateLimit_in</div></td>
   <td class="tableCell"><%= bean.getRatelimit_in() == null ? "" : TextFormater.HTMlize(bean.getRatelimit_in()) %></td>
   <td class="tableCell">RateLimit for incoming traffic</td>
</tr>
<%}%>

<%if(bean.getMcar() != null){%>
<tr class="tableOddRow">
   <td> <div class="tableCell">mCAR</div></td>
   <td class="tableCell"><%= bean.getMcar() == null ? "" : TextFormater.HTMlize(bean.getMcar()) %></td>
   <td class="tableCell">Bandwidth value for the multicast traffic</td>
</tr>
<%}%>

<%if(bean.getMcos() != null){%>
<tr class="tableEvenRow">
   <td> <div class="tableCell">mCoS</div></td>
   <td class="tableCell"><%= bean.getMcos() == null ? "" : TextFormater.HTMlize(bean.getMcos()) %></td>
   <td class="tableCell">Class of service(IPP) for the multicast traffic</td>
</tr>
<%}%>

<% NumberFormat intNf = NumberFormat.getIntegerInstance(); %>

<%if(bean.getMaximum_prefix() != 0){%>
<tr class="tableOddRow">
   <td> <div class="tableCell">Maximum_Prefix</div></td>
   <td class="tableCell"><%= intNf.format(bean.getMaximum_prefix()) %></td>
   <td class="tableCell">Maximum number of prefix limit</td>
</tr>
<%}%>

<%if(bean.getRl_ce_in() != null){%>
<tr class="tableEvenRow">
   <td> <div class="tableCell">RL_CE_in</div></td>
   <td class="tableCell"><%= bean.getRl_ce_in() == null ? "" : TextFormater.HTMlize(bean.getRl_ce_in()) %></td>
   <td class="tableCell">RateLimit for incoming traffic on the ce router</td>
</tr>
<%}%>


<%if(bean.getRl_ce_out() != null){%>
<tr class="tableOddRow">
   <td> <div class="tableCell">RL_CE_out</div></td>
   <td class="tableCell"><%= bean.getRl_ce_out() == null ? "" : TextFormater.HTMlize(bean.getRl_ce_out()) %></td>
   <td class="tableCell">RateLimit for outgoing traffic on the ce router</td>
</tr>
<%}%>


<%
    if ("STATIC".equals(bean.getProtocol())){
     String routes = "";
     StringTokenizer st = new StringTokenizer(bean.getStaticroutes(), ",");
     while (st.hasMoreTokens()) {
     String address = st.nextToken();
         StringTokenizer ipaddress = new StringTokenizer(address, "/");
     String ip = ipaddress.nextToken();
     String mask = ipaddress.nextToken();
         routes += ip + "/" + getSlashMask(mask) +"\n";
     }
%>
<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">StaticRoutes</div></td>
   <td class="tableCell"><textarea readonly rows="5"><%= routes == null ? "" : TextFormater.HTMlize(routes) %></textarea></td>
   <td class="tableCell">Static Routes for customer site</td>
</tr>
<% } %>



<tr class="tableEvenRow">
   <td> <div class="tableCell">Marker</div></td>
   <td class="tableCell"><%= bean.getMarker() == null ? "" : TextFormater.HTMlize(bean.getMarker()) %></td>
   <td class="tableCell">Marker for service upload</td>
</tr>

<%if(bean.getUploadstatus() != null){%>
<tr class="tableOddRow">
   <td> <div class="tableCell">UploadStatus</div></td>
   <td class="tableCell"><%= bean.getUploadstatus() == null ? "" : TextFormater.HTMlize(bean.getUploadstatus()) %></td>
   <td class="tableCell">Status: indicates compliance to VPN SVP and if the object cause conflict with existing db</td>
</tr>
<%}%>

<%if(bean.getDbprimarykey() != null){%>
<tr class="tableOddRow">
   <td> <div class="tableCell">DBPrimaryKey</div></td>
   <td class="tableCell"><%= bean.getDbprimarykey() == null ? "" : TextFormater.HTMlize(bean.getDbprimarykey()) %></td>
   <td class="tableCell">If marker='EXISTS', primary key of the existing object</td>
</tr>
<%}%>


<tr class="tableEvenRow">
   <td> <div class="tableCell">SiteId</div></td>
   <td class="tableCell"><%= bean.getSiteid() == null ? "" : TextFormater.HTMlize(bean.getSiteid()) %></td>
   <td class="tableCell">Service identifier of site</td>
</tr>
<tr> <td>&nbsp;</td> </tr>
<tr> <td>&nbsp;</td> </tr><%
 }
    } catch (Exception e) { %>
    <script>
    alert("Error retrieving information for: Sh_L3SiteConnection" + "\n" +"<%= e.getMessage() == null ? "No Info available" : e.getMessage().replace('\n',' ') %>" );
    </script>
<% } finally {
       connection.close();
   }
 %>

<%if(showAttachmentParams != null && showAttachmentParams.equalsIgnoreCase("yes")){%>


<tr>
<td colspan="3"><hr></td>
  </tr>
<tr>
<td colspan="3"><center><h2>Site Attachment Attributes</h2></center></td>
  </tr>
    <jsp:include page="ViewSh_SiteAttachmentCustomized.jsp" flush="true">
           <jsp:param name="primaryKey" value="<%= bean.getAttachmentid() == null ? "" : bean.getAttachmentid() %>" />
            <jsp:param name="caller" value="jsp" />
           </jsp:include>

<% } %>


</table> </center>

      <script>
         var fPtr=parent.messageLine.document;
         fPtr.open();
         fPtr.write("<html>");
         fPtr.write("<link rel='stylesheet' type='text/css' href='/activator/css/inventory.css'>");
         fPtr.write("<body class=invCell>");
         fPtr.write("JSP does not contain any editable fields.");
         fPtr.write("</body></html>");
         fPtr.close();
      </script>

</body>
</html>
