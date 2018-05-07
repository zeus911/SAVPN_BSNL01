
<%@page info="Update form for bean Sh_Customer"
      import="com.hp.ov.activator.mwfm.servlet.*,
              com.hp.ov.activator.mwfm.*,com.hp.ov.activator.vpn.inventory.Sh_Customer,
              com.hp.ov.activator.vpn.inventory.Sh_CustomerMapping,
              com.hp.ov.activator.util.*,
              java.sql.*,java.util.*,
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
%>

<script>
    var fPtr=parent.messageLine.document;
    fPtr.open();
    fPtr.write("");
    fPtr.close();
</script>

<html>
<head>
  <title>Resolve Customer</title>
  <script language="JavaScript" src="/activator/javascript/checks.js"></script>
  <!-- <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">-->
  <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
</head>
<body>

<%! Object obj; %>

<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.Sh_Customer" />
<%
    // Set the properties on the bean - these values have been encoded and must be decoded prior to use
    if(request.getParameter("primaryKey") != null) {
        bean.setPrimaryKey(URLDecoder.decode(request.getParameter("primaryKey"), "UTF-8"));
    }
    else {
        bean.setCustomerid(request.getParameter("customerid") == null ? "" : URLDecoder.decode(request.getParameter("customerid"),"UTF-8" ));
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
        bean = (com.hp.ov.activator.vpn.inventory.Sh_Customer)com.hp.ov.activator.vpn.inventory.Sh_Customer.findByPrimaryKey( connection, bean.getPrimaryKey() );
    if ( bean == null )
    {
%>


    <script>
    alert("Unable to display update for: Sh_Customer<%=displayKey%>" + "\n" +
    "Potential reasons for failure are: "
     + "\n\n" + "   - The name of the object in the inventoryTree.xml file is incorrect."
     + "\n" + " - A parameter name in the inventoryTree.xml file is incorrect."
     + "\n" + " - The requested data may have previously been deleted.");





    </script>
<%
    } else {
%>


<center>

<!--<form name="form" method="POST" action="UpdateCommitSh_Customer_Merge.jsp">-->
<!--<form name="form" method="POST"  action="UpdateCommitSh_CustomerCustomized.jsp">-->

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
<form name = "form" method="POST" action="/activator/jsp/inventory/SAVPN/UpdateCommitSh_CustomerCustomized.jsp">


<!- WARNING: This field is of great importance and MUST be included in all customized UpdateForm JSP pages! -->
<input type="hidden" name="__hashcode" value="<%= ActivatorUtils.calculateHashValue(bean) %>">
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

<tr class="tableEvenRow">

   <td><div class="tableCell" id="req">Ambiguous Customer Id</div></td>
   <td class="tableCell"><%= bean.getCustomerid() == null ? "" : TextFormater.HTMlize(bean.getCustomerid()) %></td>
   <td class="tableCell"></td>
</tr>
<input type="hidden" name="old_customerId" value="<%= bean.getCustomerid() == null ? "" : TextFormater.HTMlizeInventory(bean.getCustomerid()) %>">


<tr class="tableOddRow">
   <td><div class="tableCell" id="req">CustomerId</div> </td>
    <td class="tableCell">

    <%
        String selectedId = request.getParameter("selectedId");

        //to check if dbprimary key startswith truncated and setting the status flag true
        String dbKey = bean.getDbprimarykey();
        boolean status = false;
        if(dbKey.startsWith("Truncated"))
        {
            dbKey = dbKey.substring(11);
            status = true;
        }



        String customer = bean.getCustomerid();
        String customerId[] = customer.split(";");
        ArrayList customer_id_list = new ArrayList();



        for(int i=0;i<customerId.length;i++ )
        {

             Sh_Customer cust = null;
              //Always use the customer in the mapping entry if it exists
              Sh_CustomerMapping mapping = Sh_CustomerMapping.findByPrimaryKey(connection,customerId[i]);
              if (mapping != null)
              {
                   cust =Sh_Customer.findByPrimaryKey(connection,mapping.getCustomerid());
              }
              else
              {
                   cust =Sh_Customer.findByPrimaryKey(connection,customerId[i]);
              }
              if(cust != null)
              {
                  customer_id_list.add(cust.getCustomerid());
              }
              if(customer_id_list.size()< 1)
              {
                  throw new Exception ("Error suggesting customer id  for resolution");
              }
    }
    Set set = new LinkedHashSet();
    set.addAll(customer_id_list);
    customer_id_list = new ArrayList(set);
    int custSize = customer_id_list.size();

    %>
   <select name = "customerid" onChange="changeEvent();document.form.submit();">
    <%
    for(int i=0;i<customer_id_list.size();i++)
    {
        String disp_value = (String)customer_id_list.get(i);
        if((selectedId == null)&& (i == 0))
        {
            selectedId = disp_value;
        }
        if((status)&&(i==(custSize-1)))
        {
            System.out.println("Note the last customer Id is not displayed in the list as it is truncated!!!");
        }
        else
        {
%>
        <option <%= selectedId.equals(disp_value) ? "selected" : ""%>  value="<%= disp_value%>"> <%= disp_value%></option>

<%
        }
    }
%>
  </select>
 <%
    if(status)
    {
 %>
 <%= "NOTE: This is not the entire customer Id list"%>
<%
    }
%>
  <td class="tableCell"></td>
</tr>


<!--
<tr class="tableEvenRow">
   <td><div class="invBField" id="req">CustomerName</div> </td>
   <td class="tableCell">
   <select name = "CustomerName">
   <%
     for(int i=0;i<customerId.length;i++    )
        {
   %>
    <option <%= customerId[i]%> value="<%= customerId[i]%>">Customer:<%= customerId[i]%></option>
   <%}
  %>
  </select>
</tr>
-->

<%

    com.hp.ov.activator.vpn.inventory.Sh_Customer selectedCust =com.hp.ov.activator.vpn.inventory.Sh_Customer.findByPrimaryKey(connection,selectedId);


%>

<tr class="tableOddRow">
   <td><div class="tableCell" id="opc">CustomerName</div> </td>
   <td class="tableCell">
   <%
    String custName = selectedCust.getCustomername();
    if(custName.indexOf(";")>=1)
    {
        String []  customerArray = custName.split(";");
        for(int i =0; i<customerArray.length;i++)
        {

%>
   <%= TextFormater.HTMlize(customerArray[i])%>
   <br>
<%      }
    }
    else
    {
%>
    <%= TextFormater.HTMlize(custName)%>
<%
   }

%>
 </td>  <td class="tableCell"></td>
</tr>
<input type="hidden" name="customername" value="<%= selectedCust.getCustomername() == null ? "" : TextFormater.HTMlizeInventory(selectedCust.getCustomername()) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="req">Marker</div></td>
   <td class="tableCell"><%= bean.getMarker() == null ? "" : TextFormater.HTMlize(bean.getMarker()) %></td>
   <td class="tableCell"></td>
</tr>
<input type="hidden" name="marker" value="<%= bean.getMarker() == null ? "" : TextFormater.HTMlizeInventory(bean.getMarker()) %>">


<tr class="tableOddRow">
   <td><div class="tableCell" id="req">UploadStatus</div></td>
   <td class="tableCell"><%= bean.getUploadstatus() == null ? "" : TextFormater.HTMlize(bean.getUploadstatus()) %></td>
   <td class="tableCell"></td>
</tr>
<input type="hidden" name="uploadstatus" value="<%= bean.getUploadstatus() == null ? "" : TextFormater.HTMlizeInventory(bean.getUploadstatus()) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="req">DBPrimaryKey</div></td>
    <td class="tableCell">
    <%= dbKey == null ? "" : TextFormater.HTMlize(dbKey) %>

    </td>
   <td class="tableCell"></td>
</tr>
<input type="hidden" name="dbprimarykey" value="<%= bean.getDbprimarykey() == null ? "" : TextFormater.HTMlizeInventory(bean.getDbprimarykey()) %>">

<tr> <td>&nbsp;</td> </tr>
<tr> <td>&nbsp;</td> </tr>
<tr>
<td colspan="3" align="center">
 <!--  <input type="submit" name="submit" value="Submit">&nbsp;
   <input type="reset" name="reset" value="Reset"> &nbsp;-->

   <input type="submit" value="OK" name="submit1" onclick= "clickEvent()">&nbsp;
   <input type="reset" value="Reset" name="reset">&nbsp;
</td>
</tr>

</form>
</table> </center>
 <!--</form>-->
<%
 }
    } catch (Exception e) {
        System.out.println(e);
        %>
    <script>
    alert("Error retrieving information for: Sh_Customer" + "\n" +"<%= e.getMessage() == null ? "No Info available" : e.getMessage().replace('\n',' ') %>" );
    </script>
<% } finally {
       connection.close();
   }
 %>



</body>
</html>
