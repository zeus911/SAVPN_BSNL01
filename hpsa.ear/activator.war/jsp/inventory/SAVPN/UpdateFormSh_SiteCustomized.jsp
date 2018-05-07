
<%@page info="Update form for bean Sh_Site"
      import="com.hp.ov.activator.mwfm.servlet.*,
              com.hp.ov.activator.mwfm.*,
              com.hp.ov.activator.util.*,
              java.sql.*,
              com.hp.ov.activator.mwfm.WFManager,
              javax.sql.DataSource,
              java.net.*,
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

    String requestObject = request.getParameter("action");
    String message = " ";
    boolean action = false;
    if(requestObject.equalsIgnoreCase("update"))
    {
        message = "Update Service Name";
        action = true;
    }
    else
        message = "Resolve Site";

%>

<script>
    var fPtr=parent.messageLine.document;
    fPtr.open();
    fPtr.write("");
    fPtr.close();
</script>

<html>
<head>
  <title><%= message%></title>
  <script language="JavaScript" src="/activator/javascript/checks.js"></script>
  <!-- <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">-->
  <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
</head>
<body>

<%! Object obj; %>

<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.Sh_Site" />
<%
    // Set the properties on the bean - these values have been encoded and must be decoded prior to use
    if(request.getParameter("primaryKey") != null) {
        bean.setPrimaryKey(URLDecoder.decode(request.getParameter("primaryKey"), "UTF-8"));
    }
    else {
        bean.setServiceid(request.getParameter("serviceid") == null ? "" : URLDecoder.decode(request.getParameter("serviceid"),"UTF-8" ));
    }

    String displayKey = bean.getPrimaryKey();
%>

<%

    String refreshTreeRimid=(String) request.getParameter("refreshTreeRimid");
    session.setAttribute("refreshTreeRimid",refreshTreeRimid);

    DataSource dataSource = (DataSource)session.getAttribute(Constants.DATASOURCE);
    Connection connection = null;
    try {
        connection = (Connection)dataSource.getConnection();
        bean = (com.hp.ov.activator.vpn.inventory.Sh_Site)com.hp.ov.activator.vpn.inventory.Sh_Site.findByPrimaryKey( connection, bean.getPrimaryKey() );
    if ( bean == null )
    {
%>
    <script>
    alert("Unable to display update for: Sh_Site<%=displayKey%>" + "\n" +
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
</tr><tr><td class="tableHeading" height=3 colspan=3></td></tr>
<form name="form" method="POST"  action="/activator/jsp/inventory/SAVPN/UpdateCommitSh_SiteCustomized.jsp">

<!- WARNING: This field is of great importance and MUST be included in all customized UpdateForm JSP pages! -->
<input type="hidden" name="__hashcode" value="<%= ActivatorUtils.calculateHashValue(bean) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="req">ServiceId</div></td>
   <td class="tableCell"><%= bean.getServiceid() == null ? "" : TextFormater.HTMlize(bean.getServiceid()) %></td>
    <td class="tableCell"></td>
</tr>
<input type="hidden" name="serviceid" value="<%= bean.getServiceid() == null ? "" : TextFormater.HTMlizeInventory(bean.getServiceid()) %>">

<!--
<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">CustomerId</div> </td>
   <td class="tableCell"><input type=text  name="customerid" value="<%= bean.getCustomerid() == null ? "" : TextFormater.HTMlizeInventory(bean.getCustomerid()) %>" size="20"></td>
   <td class="tableCell">Customer identifier</td>
</tr>
-->

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


<%
    String customer = bean.getCustomerid();
    String customerId[] = customer.split(";");

    if(action)
    {
%>
<tr class="tableOddRow">
   <td><div class="tableCell" id="req">Customer</div></td>
   <td class="tableCell"><%= customerId[0] == null ? "" : TextFormater.HTMlize(customerId[0]) %></td> <td class="tableCell"></td>
</tr>
<input type="hidden" name="customerid" value="<%= customerId[0] == null ? "" : TextFormater.HTMlizeInventory(customerId[0]) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">Name</div> </td>
   <td class="tableCell"><input type=text  name="servicename" value="<%=  bean.getServicename() == null ? "" : TextFormater.HTMlizeInventory( bean.getServicename()) %>" size="20"></td>
   <td class="tableCell"></td>
</tr>

<%
    }
    else
        {
%>


<tr class="tableOddRow">
   <td><div class="tableCell" id="req">Customer</div> </td>

    <td class="tableCell">
    <select name = "customerid" onChange="changeEvent();document.form.submit();">
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
        <option <%= selectedId.equals(disp_value) ? "selected" : ""%> value="<%= customerId[i]%>"> <%= disp_value%></option>
    <%

        }

    %>
  </select> <td class="tableCell"></td>
</tr>

<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">CustomerName</div></td>
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
   </td> <td class="tableCell"></td>
</tr>
<input type="hidden" name="customername" value="<%= custName == null ? "" : TextFormater.HTMlizeInventory(custName) %>">



<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">Name</div></td>
   <td class="tableCell"><%= bean.getServicename() == null ? "" : TextFormater.HTMlize(bean.getServicename()) %></td>
 <td class="tableCell"></td></tr>
<input type="hidden" name="servicename" value="<%= bean.getServicename() == null ? "" : TextFormater.HTMlizeInventory(bean.getServicename()) %>">



<%
    }
%>






<input type="hidden" name="old_customerId" value="<%= bean.getCustomerid() == null ? "" : TextFormater.HTMlizeInventory(bean.getCustomerid()) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">Initiation Date</div></td>
   <td class="tableCell"><%= bean.getInitiationdate() == null ? "" : TextFormater.HTMlize(bean.getInitiationdate()) %></td> <td class="tableCell"></td>
</tr>
<input type="hidden" name="InitiationDate" value="<%= bean.getInitiationdate() == null ? "" : TextFormater.HTMlizeInventory(bean.getInitiationdate()) %>">


<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">Activation Date</div></td>
   <td class="tableCell"><%= bean.getActivationdate() == null ? "" : TextFormater.HTMlize(bean.getActivationdate()) %></td> <td class="tableCell"></td>
</tr>
<input type="hidden" name="ActivationDate" value="<%= bean.getActivationdate() == null ? "" : TextFormater.HTMlizeInventory(bean.getActivationdate()) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">ModificationDate</div></td>
   <td class="tableCell"><%= bean.getModificationdate() == null ? "" : TextFormater.HTMlize(bean.getModificationdate()) %></td> <td class="tableCell"></td>
</tr>
<input type="hidden" name="ModificationDate" value="<%= bean.getModificationdate() == null ? "" : TextFormater.HTMlizeInventory(bean.getModificationdate()) %>">

<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">State</div></td>
   <td class="tableCell"><%= bean.getState() == null ? "" : TextFormater.HTMlize(bean.getState()) %></td>
 <td class="tableCell"></td></tr>
<input type="hidden" name="State" value="<%= bean.getState() == null ? "" : TextFormater.HTMlizeInventory(bean.getState()) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">Type</div></td>
   <td class="tableCell"><%= bean.getType() == null ? "" : TextFormater.HTMlize(bean.getType()) %></td>
 <td class="tableCell"></td></tr>
<input type="hidden" name="Type" value="<%= bean.getType() == null ? "" : TextFormater.HTMlizeInventory(bean.getType()) %>">

<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">Contact Person</div></td>
   <td class="tableCell"><%= bean.getContactperson() == null ? "" : TextFormater.HTMlize(bean.getContactperson()) %></td> <td class="tableCell"></td>
</tr>
<input type="hidden" name="ContactPerson" value="<%= bean.getContactperson() == null ? "" : TextFormater.HTMlizeInventory(bean.getContactperson()) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">Comments</div></td>
   <td class="tableCell"><%= bean.getComments() == null ? "" : TextFormater.HTMlize(bean.getComments()) %></td>
 <td class="tableCell"></td></tr>
<input type="hidden" name="Comments" value="<%= bean.getComments() == null ? "" : TextFormater.HTMlizeInventory(bean.getComments()) %>">

<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">Marker</div></td>
   <td class="tableCell"><%= bean.getMarker() == null ? "" : TextFormater.HTMlize(bean.getMarker()) %></td>
 <td class="tableCell"></td></tr>
<input type="hidden" name="Marker" value="<%= bean.getMarker() == null ? "" : TextFormater.HTMlizeInventory(bean.getMarker()) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">UploadStatus</div></td>
   <td class="tableCell"><%= bean.getUploadstatus() == null ? "" : TextFormater.HTMlize(bean.getUploadstatus()) %></td>
 <td class="tableCell"></td></tr>
<input type="hidden" name="UploadStatus" value="<%= bean.getUploadstatus() == null ? "" : TextFormater.HTMlizeInventory(bean.getUploadstatus()) %>">

<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">DBPrimaryKey</div></td>
   <td class="tableCell"><%= bean.getDbprimarykey() == null ? "" : TextFormater.HTMlize(bean.getDbprimarykey()) %></td>
 <td class="tableCell"></td></tr>
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
     </td> <td class="tableCell"></td>
</tr>


<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">RemoteASN</div></td>
   <td class="tableCell"><%= bean.getRemoteasn() == null ? "" : TextFormater.HTMlize(bean.getRemoteasn()) %></td>
 <td class="tableCell"></td></tr>
<input type="hidden" name="RemoteASN" value="<%= bean.getRemoteasn() == null ? "" : TextFormater.HTMlizeInventory(bean.getRemoteasn()) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">OSPF_Area</div></td>
   <td class="tableCell"><%= bean.getOspf_area() == null ? "" : TextFormater.HTMlize(bean.getOspf_area()) %></td>
 <td class="tableCell"></td></tr>
<input type="hidden" name="OSPF_Area" value="<%= bean.getOspf_area() == null ? "" : TextFormater.HTMlizeInventory(bean.getOspf_area()) %>">

<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">SiteOfOrigin</div></td>
   <td class="tableCell"><%= bean.getSiteoforigin() == null ? "" : TextFormater.HTMlize(bean.getSiteoforigin()) %></td>
 <td class="tableCell"></td></tr>
<input type="hidden" name="SiteOfOrigin" value="<%= bean.getSiteoforigin() == null ? "" : TextFormater.HTMlizeInventory(bean.getSiteoforigin()) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="req">Managed</div></td>
   <td class="tableCell"><%= bean.getManaged() %></td>
 <td class="tableCell"></td></tr>
<input type="hidden" name="managed" value="<%= bean.getManaged() %>">

<tr class="tableOddRow">
   <td><div class="tableCell" id="req">Multicast</div></td>
   <td class="tableCell"><%= bean.getMulticast() == null ? "" : TextFormater.HTMlize(bean.getMulticast()) %></td>
 <td class="tableCell"></td></tr>
<input type="hidden" name="multicast" value="<%= bean.getMulticast() == null ? "" : TextFormater.HTMlizeInventory(bean.getMulticast()) %>">


<tr class="tableEvenRow">
   <td><div class="tableCell" id="opc">PostalAddress</div></td>
   <td class="tableCell"><%= bean.getPostaladdress() == null ? "" : TextFormater.HTMlize(bean.getPostaladdress()) %></td> <td class="tableCell"></td>
</tr>
<input type="hidden" name="PostalAddress" value="<%= bean.getPostaladdress() == null ? "" : TextFormater.HTMlizeInventory(bean.getPostaladdress()) %>">

<tr> <td>&nbsp;</td> </tr>
<tr> <td>&nbsp;</td> </tr>
<tr>
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
    alert("Error retrieving information for: Sh_Site" + "\n" +"<%= e.getMessage() == null ? "No Info available" : e.getMessage().replace('\n',' ') %>" );
    </script>
<% } finally {
       connection.close();
   }
 %>


</table></center>
</body>
</html>
