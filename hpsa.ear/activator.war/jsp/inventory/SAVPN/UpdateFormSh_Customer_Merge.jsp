
<%@page info="View JSP for bean Sh_Customer"
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
  <title>Merge Customer</title>
  <script language="JavaScript" src="/activator/javascript/checks.js"></script>
 <!-- <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">-->
  <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
</head>
<body>

<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.Sh_Customer" />
<jsp:useBean id="bean1" class="com.hp.ov.activator.vpn.inventory.Sh_Customer" />
<jsp:useBean id="bean2" class="com.hp.ov.activator.vpn.inventory.Sh_Customer" />
<%



    // Set the properties on the bean - these values have been encoded and must be decoded prior to use
    if(request.getParameter("primaryKey") != null) {
        bean.setPrimaryKey(URLDecoder.decode(request.getParameter("primaryKey"), "UTF-8"));
    }
    else {
        bean.setCustomerid(request.getParameter("customerid") == null ? "" : URLDecoder.decode(request.getParameter("customerid"),"UTF-8" ));
    }

    String rimid = request.getParameter("rimid");
    if(rimid!=null)
    {
        session.setAttribute("rimid",rimid);
    }

String refreshTreeRimid=(String) request.getParameter("refreshTreeRimid");
    session.setAttribute("refreshTreeRimid",refreshTreeRimid);

    String displayKey = bean.getPrimaryKey();

%>

<%

String message1 ="<tr> <td colspan='3' align='center'>  <div class='tableCell'><br><i>Right click on another customer and select 'Merge' to continue ...</i></div></td></tr>";

String message2 ="<tr> <td colspan='3' align='center'>  <div class='tableCell'><br><i>Select a different customer to continue or Press cancel to undo the selection </i></br></div></td></tr>";


String message3 ="<tr> <td colspan='3' align='center'><div class='tableCell' align='center'><br><i>Services of the first customer will be moved to second customer  <br> and first customer  will be deleted from inventory . <br/>Press OK to continue with the merge or Cancel to undo the selections</i></td></tr>";

String customer1=null;
String customer2=null;
customer1 = (String)session.getAttribute("firstCustomer");
 if((customer1==null)||(customer1.equals("")))
    {

         session.setAttribute("firstCustomer",bean.getPrimaryKey());
        customer1= bean.getPrimaryKey();

      }else{

            customer2= bean.getPrimaryKey();
            // session.removeAttribute("firstCustomer");
        }


     // Added by jimmi

     String selectedId = request.getParameter("selectedId");
     if(selectedId != null)
        customer2 = null;


    DataSource dataSource = (DataSource)session.getAttribute(Constants.DATASOURCE);
    Connection connection = null;
    try {
        connection = (Connection)dataSource.getConnection();

        if(customer1 != null){
        bean1 = (com.hp.ov.activator.vpn.inventory.Sh_Customer)com.hp.ov.activator.vpn.inventory.Sh_Customer.findByPrimaryKey( connection, customer1 );
        if(bean1.getMarker().equalsIgnoreCase("exists"))
            {
            session.removeAttribute("firstCustomer");
        %>

        <script>

            alert("Customer already exists in the VPN SVP repository. It is only possible to merge new customers into this customer. ")
            window.location.href = "/activator/jsp/inventory/RefreshTree.jsp"

        </script>


        <%}

        }



    if(customer2 != null){
        bean2 = (com.hp.ov.activator.vpn.inventory.Sh_Customer)com.hp.ov.activator.vpn.inventory.Sh_Customer.findByPrimaryKey( connection, customer2);

    }
    if ( (customer1 !=null && bean1 == null) || (customer2 !=null && bean2 == null) ) //outer if 1
    {
         session.removeAttribute("firstCustomer");
%>
    <script>
    alert("Unable to display page  for: Merge Customer <%=displayKey%>" + "\n" +
    "Potential reasons for failure are: "
     + "\n\n" + "   - The name of the object in the inventoryTree.xml file is incorrect."
     + "\n" + " - A parameter name in the inventoryTree.xml file is incorrect."
     + "\n" + " - The requested data may have previously been deleted."
     + "\n" + " - Previos merge operation was not completed successfully."
     + "\n" + " Try Again.");
    </script>

    <script>
    window.location.href = "/activator/jsp/inventory/RefreshTree.jsp"
    </script>
<%
    } else { //outer if 1

%>

<center>
<form name="form" method="POST" action="/activator/jsp/inventory/SAVPN/UpdateCommitSh_Customer_Merge.jsp">


<table cellSpacing="2" cellPadding="2" border="0" width="90%">
<tr class="tableTitle">
<td>
Name
</td>
<td>
Value
</td>
<td>
Description
</td>
</tr><tr><td class="tableHeading" height=3 colspan=3></td></tr>
<tr class="tableEvenRow">

<input type= "hidden" name = "onchange" value = "false">

<tr class="tableOddRow">
   <td colspan="3"> <center> <h3>First Customer</h3> </center></td>
</tr>

<input type="hidden" name="old_customerId" value="<%= bean1.getCustomerid() == null ? "" : bean1.getCustomerid()%>">
<input type="hidden" name="todo" value="=">



<tr class="tableEvenRow">
   <td> <div class="tableCell">CustomerId</div></td>
   <td class="tableCell"><%= bean1.getCustomerid() == null ? "" : TextFormater.HTMlize(bean1.getCustomerid()) %></td>
   <td class="tableCell"></td>
</tr>

<tr class="tableOddRow">
   <td> <div class="tableCell">CustomerName</div></td>
   <td class="tableCell">
<%
    String custName1 = bean1.getCustomername();
    if(custName1.indexOf(";")>=1)
    {
        String []  customerArray1 = custName1.split(";");
        for(int i =0; i<customerArray1.length;i++)
        {

%>
   <%= customerArray1[i]%>
   <br>
<%      }
    }
   else
    {
%>
    <%= bean1.getCustomername()%>
<%
   }

%>
   </td>
   <td class="tableCell"></td>
</tr>


<%

boolean dropDown = false;
if ((customer2 ==null || bean2 == null) || customer1.equalsIgnoreCase(customer2) ){

com.hp.ov.activator.vpn.inventory.Sh_Customer selected_customer =null;
String whereCondition = "customerid = '"+ bean1.getCustomerid() +"'";
//System.out.println("Before executing query ... " +whereCondition);

    com.hp.ov.activator.vpn.inventory.Sh_Customer[] shObj =
        bean.findAll( connection,whereCondition);
    //System.out.println("After executing query ... "+shObj.length);


    if(shObj.length>0)
    {
        //System.out.println("DBPrimary Key: "+shObj[0].getDbprimarykey()+" End");
        //System.out.println("Customer ID: "+bean1.getCustomerid()+ " End");
        if((!shObj[0].getDbprimarykey().equals(bean1.getCustomerid())) && (!((shObj[0].getDbprimarykey().trim()).length()==0))&& (!shObj[0].getDbprimarykey().equalsIgnoreCase("undefined")) )
        {
            dropDown = true;

    %>



    <tr class="tableEvenRow">
   <td><div class="tableCell">Merge Customer Id</div> </td>
    <td class="tableCell">
    <select  name="primaryKey" onChange="changeEvent();document.form.submit();">
<%


    boolean status = false;
    for(int i=0;i<shObj.length;i++)
    {
            String dbKey = shObj[i].getDbprimarykey();

            if(dbKey.startsWith("Truncated"))
            {
                dbKey = dbKey.substring(11);
                status = true;
            }
            String [] keyArray = dbKey.split(";");
            for(int j=0;j <keyArray.length;j++)
            {
                if(!bean1.getCustomerid().equals(keyArray[j]) )
                {
                    if((status)&&(j==(keyArray.length-1)))
                    {
                    System.out.println("Note the last customer Id is not displayed in the list as it is truncated!!!");

                    }
                    else
                    {
                        if(selectedId ==null)
                            selectedId = keyArray[j];

                        if(keyArray[j].equals(selectedId)){
                            selected_customer =com.hp.ov.activator.vpn.inventory.Sh_Customer.findByPrimaryKey(connection,keyArray[j]);
                    }


        %>


        <option <%= keyArray[j].equals(selectedId) ? " selected": "" %> value="<%= keyArray[j]%>"><%= keyArray[j]%></option>


<%                  }
                }
            }
    }
%>
        </select>

         <%
    if(status)
    {
 %>
 <td class="tableCell"><%= "NOTE: This is not the entire customer Id list"%></td>
<%
    }
%>
     <td class="tableCell"></td>    </tr>
<%}
                }%>
<tr class="tableOddRow">


<%if(selected_customer != null){%>

<tr class="tableOddRow"> <td><div class="tableCell">Merge Customer Name</div> </td>
      <td class="tableCell">
       <%
    String selectedcustName = selected_customer.getCustomername();

    if(selectedcustName.indexOf(";")>=1)
    {
        String []  customerArray1 = selectedcustName.split(";");
        for(int i =0; i<customerArray1.length;i++)
        {
    %>  <%= TextFormater.HTMlize(customerArray1[i])%>
   <br>
<%      }
    }   else
    {%> <%= TextFormater.HTMlize(selected_customer.getCustomername())%>

<%
    }
%>
   </td>
     <td class="tableCell"></td>
</tr>

<%}%>

<tr> <td>&nbsp;</td> </tr>
<tr> <td>&nbsp;</td> </tr>

<script>

function changeEvent()
{

    document.getElementById("onchange").value = "onchange";

}

function ClickEvent()
{

    document.getElementById("onchange").value = "onClick";

}


</script>






<%
    if(dropDown)
    {
    %>
    <td colspan="3" align="center">
   <input type="Button" name="ok" value=" OK  " onClick="ClickEvent();form.submit()"> &nbsp;
   <input type="reset" name="Cancel" value="Cancel" onClick="form.todo.value='cancel'; form.submit();">
   </td>
    </tr>
   <%}else if ((customer2 ==null || bean2 == null)){%>

    <%= message1%>
    <td colspan="3" align="center">
   <input type="reset" name="Cancel" value="Cancel" onClick="form.todo.value='cancel'; form.submit();">
   </td>
    </tr>
   <%}

    }
    %>





<%

if(customer1.equalsIgnoreCase(customer2))
    {//outer if


    //out.println(message2);

%>
</select></tr>

     <%= message2%>

    <%if(!dropDown){%>
        <tr class="tableOddRow"><td colspan="3" align="center">
        <input type="reset" name="Cancel" value="Cancel" onClick="form.todo.value='cancel'; form.submit();">
        </td></tr>

<%}

}else{//outer if

    if (customer2 !=null && bean2 != null  )
    {%>

<tr> <td>&nbsp;</td> </tr>
<tr> <td>&nbsp;</td> </tr>

<input type="hidden" name="customerId" value="<%= bean2.getCustomerid() == null ? "" : bean2.getCustomerid()%>">
<tr>
   <td colspan="3"> <center> <h3>Second Customer</h3> </center></td>
</tr>

<tr class="tableEvenRow">
   <td> <div class="tableCell">CustomerId</div></td>
   <td class="tableCell"><%= bean2.getCustomerid() == null ? "" : TextFormater.HTMlize(bean2.getCustomerid()) %></td>
   <td class="tableCell"></td>
</tr>

<tr class="tableOddRow">
   <td> <div class="tableCell">CustomerName</div></td>
   <td class="tableCell">

<%
    String custName2 = bean2.getCustomername();
    if(custName2.indexOf(";")>=1)
    {
        String []  customerArray2 = custName2.split(";");
        for(int j =0; j<customerArray2.length;j++)
        {
%>
    <%= customerArray2[j]%>
    <br>
<%
        }
    }
   else
    {
%>
    <%= bean2.getCustomername()%>
<%
    }
%>
   </td>
   <td class="tableCell"></td>
</tr>



<tr>
<tr> <td>&nbsp;</td> </tr>
<tr> <td>&nbsp;</td> </tr>

<td colspan="3" align="center">
   <input type="Button" name="ok" value=" OK  " onClick="if (confirm ('Are you sure you want to merge the selected customers?')) form.submit();"> &nbsp;
    <input type="reset" name="Cancel" value="Cancel" onClick="form.todo.value='cancel'; form.submit();">
</td>
</tr>

<%}
%>

<%if(customer2 !=null && bean2 != null ){
%>
<tr> <td>&nbsp;</td> </tr>
<%=message3%>
<%}%>

</table> </center>
 </form>
<%

}//outer if 2

} //outer if 1
    } catch (Exception e) {

        System.out.println("exception"+e);
        %>
    <script>
    alert("Error retrieving information for: Sh_Customer" + "\n" +"<%= e.getMessage() == null ? "No Info available" : e.getMessage().replace('\n',' ') %>" );
    </script>
<% } finally {
        if(connection != null) {
       connection.close();
     }
   }
 %>


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
