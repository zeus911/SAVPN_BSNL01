
<%@page info="Update form for bean Sh_VPN"
      import="com.hp.ov.activator.mwfm.servlet.*,
              com.hp.ov.activator.mwfm.*,
              com.hp.ov.activator.util.*,
              java.sql.*,
              com.hp.ov.activator.mwfm.WFManager,
              javax.sql.DataSource,
              java.net.*,
              com.hp.ov.activator.vpn.inventory.Sh_L3VPNMembership,
              com.hp.ov.activator.vpn.inventory.Sh_Service,
              java.text.*"
      session="true"
      contentType="text/html;charset=utf-8"
%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<!---------------------------------------------------------------------
-- Automatically generated code.
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
%>

<script>
    var fPtr=parent.messageLine.document;
    fPtr.open();
    fPtr.write("");
    fPtr.close();
</script>

<html>
<head>
  <title>Resolve VPN</title>
  <script language="JavaScript" src="/activator/javascript/checks.js"></script>
  <!-- <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">-->
  <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
</head>
<body>
<%! Object obj; %>

<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.Sh_VPN" />
<%
    // Set the properties on the bean - these values have been encoded and must be decoded prior to use
    if(request.getParameter("primaryKey") != null) {
        bean.setPrimaryKey(URLDecoder.decode(request.getParameter("primaryKey"), "UTF-8"));
    }
    else {
        bean.setServiceid(request.getParameter("serviceid") == null ? "" : URLDecoder.decode(request.getParameter("serviceid"),"UTF-8" ));
    }
        String rimid = request.getParameter("rimid");
    if(rimid!=null)
    {
        session.setAttribute("rimid",rimid);
    }

    String displayKey = bean.getPrimaryKey();
    String customer_id = null;
    int distinct_customer_count =-1;
%>

<%

String refreshTreeRimid=(String) request.getParameter("refreshTreeRimid");
      session.setAttribute("refreshTreeRimid",refreshTreeRimid);

    DataSource dataSource = (DataSource)session.getAttribute(Constants.DATASOURCE);
    Connection connection = null;
    try {
        connection = (Connection)dataSource.getConnection();
        bean = (com.hp.ov.activator.vpn.inventory.Sh_VPN)com.hp.ov.activator.vpn.inventory.Sh_VPN.findByPrimaryKey( connection, bean.getPrimaryKey() );

    if ( bean == null )
    {
%>
    <script>
    alert("Unable to display update for: Sh_VPN<%=displayKey%>" + "\n" +
    "Potential reasons for failure are: "
     + "\n\n" + "   - The name of the object in the inventoryTree.xml file is incorrect."
     + "\n" + " - A parameter name in the inventoryTree.xml file is incorrect."
     + "\n" + " - The requested data may have previously been deleted.");
    </script>
<%
    } else {

/*find all the sites that are memeber of this vpn and check if the sites from more than one customers are part of this VPN . If there are only sites from single customer is present then only that customer should be suggested in the list of customers */

     Sh_L3VPNMembership [] memberhips = (Sh_L3VPNMembership[])Sh_L3VPNMembership.findByVpnid(connection,bean.getPrimaryKey());
         if (memberhips != null && memberhips.length > 0){
              String first_siteid = memberhips[0].getSiteid();
          Sh_Service service = Sh_Service.findByPrimaryKey(connection, first_siteid);
          if(service != null){
            customer_id = service.getCustomerid();
            String whereClause = "serviceid in (select siteid from sh_l3vpnmembership l3v where l3v.VPNID = '"+
            bean.getPrimaryKey()+"') and customerid != '"+customer_id+"'";
            distinct_customer_count = Sh_Service.findAllCount(connection, whereClause);
        }
     }

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
</tr><tr><td class="tableHeading" height=3 colspan=3></td></tr>
<form name="form" method="POST"  action="/activator/jsp/inventory/SAVPN/UpdateCommitSh_VPNCustomized.jsp">

<!- WARNING: This field is of great importance and MUST be included in all customized UpdateForm JSP pages! -->
<input type="hidden" name="__hashcode" value="<%= ActivatorUtils.calculateHashValue(bean) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="req">ServiceId</div></td>
   <td class="tableCell"><%= bean.getServiceid() == null ? "" : TextFormater.HTMlize(bean.getServiceid()) %></td>
</tr>
<input type="hidden" name="serviceid" value="<%= bean.getServiceid() == null ? "" : TextFormater.HTMlizeInventory(bean.getServiceid()) %>">


<input type="hidden" name="primaryKey" value="<%= displayKey%>">

<input type= "hidden" name = "onchange" value = "false">


<script>

function changeEvent()
{
    document.getElementById("onchange").value = "onchange";

}

function clickEvent()
{
    document.getElementById("onchange").value = "false";
}

</script>

<tr class="tableOddRow">
   <td><div class="tableCell" id="req">Customer</div> </td>

   <%
    String customer = bean.getCustomerid();

   if(distinct_customer_count == 0 && customer_id != null )
       customer = customer_id;


    String customerId[] = customer.split(";");

   %>

    <td class="tableCell">
    <select name = "customerid"  onChange="changeEvent();document.form.submit();">
    <%
        //boolean status = false;
        String selectedId = request.getParameter("selectedId");
        String custName = " ";
        for(int i=0;i<customerId.length;i++ )
        {
            String disp_value;
            com.hp.ov.activator.vpn.inventory.Sh_Customer cust =com.hp.ov.activator.vpn.inventory.Sh_Customer.findByPrimaryKey(connection,customerId[i]);

            disp_value = customerId[i];
            if((selectedId == null)&& (i == 0))
            {
                selectedId = disp_value;
                custName = cust.getCustomername();
            }
            else if(selectedId.equals(customerId[i]))
            {
                custName = cust.getCustomername();
            }


    %>
        <option  <%= selectedId.equals(customerId[i]) ? "selected" : ""%> value="<%= customerId[i]%>"> <%= disp_value%></option>
    <%

        }
  %>
  </select>
</tr>

<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">Customer Name</div></td>
   <td class="tableCell">
  <%
    if(custName.indexOf(";")>=1)
    {
        String []  customerArray = custName.split(";");
        for(int i =0; i<customerArray.length;i++)
        {

  %>
   <%= TextFormater.HTMlize(customerArray[i])%>
   <br>
  <%    }
      }
    else
    {
%>
    <%= TextFormater.HTMlize(custName)%>
<%
   }
%>
</td>
</tr>
<input type="hidden" name="customername" value="<%= custName == null ? "" : TextFormater.HTMlizeInventory(custName) %>">


<input type="hidden" name="old_customerId" value="<%= bean.getCustomerid() == null ? "" : TextFormater.HTMlizeInventory(bean.getCustomerid()) %>">

<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">Name</div></td>
   <td class="tableCell"><%= bean.getServicename() == null ? "" : TextFormater.HTMlize(bean.getServicename()) %></td>
</tr>
<input type="hidden" name="servicename" value="<%= bean.getServicename() == null ? "" : TextFormater.HTMlizeInventory(bean.getServicename()) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">Initiation Date</div></td>
   <td class="tableCell"><%= bean.getInitiationdate() == null ? "" : TextFormater.HTMlize(bean.getInitiationdate()) %></td>
</tr>
<input type="hidden" name="InitiationDate" value="<%= bean.getInitiationdate() == null ? "" : TextFormater.HTMlizeInventory(bean.getInitiationdate()) %>">


<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">Activation Date</div></td>
   <td class="tableCell"><%= bean.getActivationdate() == null ? "" : TextFormater.HTMlize(bean.getActivationdate()) %></td>
</tr>
<input type="hidden" name="ActivationDate" value="<%= bean.getActivationdate() == null ? "" : TextFormater.HTMlizeInventory(bean.getActivationdate()) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">ModificationDate</div></td>
   <td class="tableCell"><%= bean.getModificationdate() == null ? "" : TextFormater.HTMlize(bean.getModificationdate()) %></td>
</tr>
<input type="hidden" name="ModificationDate" value="<%= bean.getModificationdate() == null ? "" : TextFormater.HTMlizeInventory(bean.getModificationdate()) %>">

<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">State</div></td>
   <td class="tableCell"><%= bean.getState() == null ? "" : TextFormater.HTMlize(bean.getState()) %></td>
</tr>
<input type="hidden" name="State" value="<%= bean.getState() == null ? "" : TextFormater.HTMlizeInventory(bean.getState()) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">Type</div></td>
   <td class="tableCell"><%= bean.getType() == null ? "" : TextFormater.HTMlize(bean.getType()) %></td>
</tr>
<input type="hidden" name="Type" value="<%= bean.getType() == null ? "" : TextFormater.HTMlizeInventory(bean.getType()) %>">

<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">Contact Person</div></td>
   <td class="tableCell"><%= bean.getContactperson() == null ? "" : TextFormater.HTMlize(bean.getContactperson()) %></td>
</tr>
<input type="hidden" name="ContactPerson" value="<%= bean.getContactperson() == null ? "" : TextFormater.HTMlizeInventory(bean.getContactperson()) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">Comments</div></td>
   <td class="tableCell"><%= bean.getComments() == null ? "" : TextFormater.HTMlize(bean.getComments()) %></td>
</tr>
<input type="hidden" name="Comments" value="<%= bean.getComments() == null ? "" : TextFormater.HTMlizeInventory(bean.getComments()) %>">

<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">Marker</div></td>
   <td class="tableCell"><%= bean.getMarker() == null ? "" : TextFormater.HTMlize(bean.getMarker()) %></td>
</tr>
<input type="hidden" name="Marker" value="<%= bean.getMarker() == null ? "" : TextFormater.HTMlizeInventory(bean.getMarker()) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">UploadStatus</div></td>
   <td class="tableCell"><%= bean.getUploadstatus() == null ? "" : TextFormater.HTMlize(bean.getUploadstatus()) %></td>
</tr>
<input type="hidden" name="UploadStatus" value="<%= bean.getUploadstatus() == null ? "" : TextFormater.HTMlizeInventory(bean.getUploadstatus()) %>">

<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">DBPrimaryKey</div></td>
   <td class="tableCell"><%= bean.getDbprimarykey() == null ? "" : TextFormater.HTMlize(bean.getDbprimarykey()) %></td>
</tr>
<input type="hidden" name="DBPrimaryKey" value="<%= bean.getDbprimarykey() == null ? "" : TextFormater.HTMlizeInventory(bean.getDbprimarykey()) %>">


<% NumberFormat intNf = NumberFormat.getIntegerInstance(); %>

<tr class="tableEvenRow">
   <td><div class="tableCell" id="req">Reservation count</div></td>
   <td class="tableCell">
    <%
        if ((getServletContext().getAttribute(Constants.TEST_JSP)).equals("true")) {
    %>
           <jsp:setProperty name="bean" property="__count"/>

           <input type="text" name="__count" value="<%= bean.get__count() %>">
     <%
       } else {
     %>
           <%= bean.get__count() %>
           <input type="hidden" name="__count" value="<%= bean.get__count() %>">
    <% } %>
     </td>
</tr>

<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">VPNTopologyType</div></td>
   <td class="tableCell"><%= bean.getVpntopologytype() == null ? "" : TextFormater.HTMlize(bean.getVpntopologytype()) %></td>
</tr>
<input type="hidden" name="VPNTopologyType" value="<%= bean.getVpntopologytype() == null ? "" : TextFormater.HTMlizeInventory(bean.getVpntopologytype()) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">QoSProfile_PE</div></td>
   <td class="tableCell"><%= bean.getQosprofile_pe() == null ? "" : TextFormater.HTMlize(bean.getQosprofile_pe()) %></td>
</tr>
<input type="hidden" name="QoSProfile_PE" value="<%= bean.getQosprofile_pe() == null ? "" : TextFormater.HTMlizeInventory(bean.getQosprofile_pe()) %>">

<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">QoSProfile_CE</div></td>
   <td class="tableCell"><%= bean.getQosprofile_ce() == null ? "" : TextFormater.HTMlize(bean.getQosprofile_ce()) %></td>
</tr>
<input type="hidden" name="QoSProfile_CE" value="<%= bean.getQosprofile_ce() == null ? "" : TextFormater.HTMlizeInventory(bean.getQosprofile_ce()) %>">

<tr > <td>&nbsp;</td> </tr>
<tr > <td>&nbsp;</td> </tr>
<tr >
<td colspan="3" align="center">
   <input type="submit" name="submit1" value="OK" onclick= "clickEvent()">&nbsp;
   <input type="reset" name="reset" value="Reset"> &nbsp;
</td>
</tr>
</form>
<%
 }
    } catch (Exception e) { %>
    <script>
    alert("Error retrieving information for: Sh_VPN" + "\n" +"<%= e.getMessage() == null ? "No Info available" : e.getMessage().replace('\n',' ') %>" );
    </script>
<% } finally {
       connection.close();
   }
 %>


</table></center>
</body>
</html>
