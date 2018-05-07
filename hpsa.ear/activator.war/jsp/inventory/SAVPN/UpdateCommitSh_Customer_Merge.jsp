<%@page info="Update JSP for bean Sh_Customer"
      import="com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.serviceupload.Compare,
              com.hp.ov.activator.mwfm.*,com.hp.ov.activator.vpn.inventory.Sh_CustomerMapping,
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

		String refreshTreeRimid=(String) session.getAttribute("refreshTreeRimid");
%>


<script>
    var fPtr=parent.messageLine.document;
    fPtr.open();
    fPtr.write("");
    fPtr.close();
</script>

<html>
<head>
  <script language="JavaScript" src="/activator/javascript/checks.js"></script>
  <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
</head>
<body>

<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.Sh_Customer" />

<%

String todo= request.getParameter("todo");
String rimid =(String)session.getAttribute("rimid");
if( todo != null && todo.equalsIgnoreCase("cancel")){
//removing the selection from session
 session.removeAttribute("firstCustomer");
%>
    <script>
        window.location.href = "/activator/jsp/inventory/RefreshTree.jsp?rimid ='<%= rimid%>'"
    </script>

<%
return;
}

String onchange= request.getParameter("onchange");

if(onchange != null && onchange.equalsIgnoreCase("onchange"))
    {
        String primaryKey = request.getParameter("primaryKey");

%>

<form name="form1" method="POST" action="/activator/jsp/inventory/SAVPN/UpdateFormSh_Customer_Merge.jsp">
<input type = "hidden" name = "selectedId" value = "<%= primaryKey%>">

<script>
    form1.submit();
</script>
</form>

<%  return;}


if(onchange != null && onchange.equalsIgnoreCase("onClick"))
    {
        String primaryKey = request.getParameter("primaryKey");

%>

<form name="form1" method="POST" action="/activator/jsp/inventory/SAVPN/UpdateFormSh_Customer_Merge.jsp">
<input type = "hidden" name = "primaryKey" value = "<%= primaryKey%>">

<script>
    form1.submit();
</script>
</form>

<%  return;}

    DataSource dataSource = (DataSource) session.getAttribute(Constants.DATASOURCE);
    Connection connection = null;
   try {
connection = (Connection)dataSource.getConnection();

String old_customerid = request.getParameter("old_customerId");
String new_customerid = request.getParameter("customerId");
String statement = "update SH_SERVICE set CUSTOMERID = '" + new_customerid + "'" + " where customerid = '" + old_customerid + "'";

if(new_customerid == null)
    throw new Exception ("Second customer id is null");


PreparedStatement pstmt = null;
pstmt = connection.prepareStatement(statement);
pstmt.executeUpdate();
pstmt.close();

Statement pstmt1 = null;
statement = "delete SH_CUSTOMER where customerid='" + old_customerid + "'";
pstmt1 = connection.createStatement();
pstmt1.executeUpdate(statement);
pstmt1.close();

//selecting all the dbprimarykey with old_customerid and updating the dbprimary key without oldcustomer id
PreparedStatement pstmt2 = null;
try
{
    String whereCondition = "DBPrimaryKey like '"+ old_customerid +";%' or DBPrimaryKey like '%;"+old_customerid +"' or DBPrimaryKey like '%;"+old_customerid+";%' ";
    System.out.println("Where condition: "+whereCondition);
    com.hp.ov.activator.vpn.inventory.Sh_Customer[] shObj =
            bean.findAll( connection,whereCondition);

    String sql ="update Sh_Customer set CustomerName=?, Marker=?, UploadStatus=?, DBPrimaryKey=? where CustomerId=? " ;
    pstmt2 = connection.prepareStatement(sql);
    System.out.println("Update length: "+shObj.length);
    for(int i=0;i<shObj.length;i++)
    {
         String dbKey = shObj[i].getDbprimarykey();
         String [] keyArray = dbKey.split(";");
         StringBuffer sb = new StringBuffer();
         for(int j=0; j<keyArray.length;j++)
        {
             System.out.println("Old customer ID: "+old_customerid + ". Object: " +keyArray[j]);
            if(!(old_customerid.equals(keyArray[j])))
            {
                sb.append(keyArray[j]);
                if(j != (keyArray.length)-1 )
                    sb.append(";");
            }
        }
        System.out.println("Final replaced string: "+sb.toString());
        if(sb.toString().endsWith(";"))
        {
            String finalDbPrimKey = sb.toString();
            int idx = finalDbPrimKey.lastIndexOf(";");
            //finalDbPrimKey = finalDbPrimKey.substring(0,idx);
            //shObj[i].setDbprimarykey(finalDbPrimKey);
            sb = new StringBuffer(finalDbPrimKey.substring(0,idx));
        }/*else{
            shObj[i].setDbprimarykey(sb.toString());
        }*/

        //checking if customerid is equal to dbprimary key then assingning dbprimary key to undefined
        if(sb.toString().equals(shObj[i].getCustomerid()))
        {

            sb = new StringBuffer("Undefined");

        }


        shObj[i].setDbprimarykey(sb.toString());

        if ( shObj[i].getCustomername() == null )
            pstmt2.setNull( 1, Types.VARCHAR );
        else
            pstmt2.setString( 1, shObj[i].getCustomername() );
        if ( shObj[i].getMarker() == null )
            pstmt2.setNull( 2, Types.VARCHAR );
        else
            pstmt2.setString( 2,shObj[i]. getMarker() );
        if ( shObj[i].getUploadstatus() == null )
            pstmt2.setNull( 3, Types.VARCHAR );
        else
            pstmt2.setString( 3, shObj[i].getUploadstatus() );
        if ( shObj[i].getDbprimarykey() == null )
            pstmt2.setNull( 4, Types.VARCHAR );
        else
            pstmt2.setString( 4, shObj[i].getDbprimarykey() );
            pstmt2.setString( 5,shObj[i].getCustomerid() );

           pstmt2.addBatch();
    }
    pstmt2.executeBatch();

}
catch(Exception e)
{
    System.out.println("Exception during batch update "+e);
}
finally
{
    if ( pstmt2 != null )
        pstmt2.close();
}


//Adding entry tyo the sh_customermapping table
Sh_CustomerMapping sh_customerObj = new Sh_CustomerMapping(old_customerid,new_customerid);
sh_customerObj.store(connection);
Compare.compareAmbiguousCustomers(connection);

// Delete the customer which does not have any services
    PreparedStatement pstmt4 = null;
    try {
         statement ="delete from SH_CUSTOMER where CUSTOMERID not in (select customerid from SH_SERVICE)";
         pstmt4 = connection.prepareStatement(statement);
        pstmt4.executeUpdate();
    }catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    } finally {
        if ( pstmt4 != null )
        try {
            pstmt4.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            System.out.println("Error closing Preparedstatement");
        }
    }


session.removeAttribute("firstCustomer");
%>

<!--<b>Customers merged  successfully.</b>-->
<script>
//window.location.href = "/activator/jsp/inventory/RefreshTree.jsp?rimid=<%=rimid%>";
 parent.document.getElementById("ifr" + "<%=refreshTreeRimid%>").contentWindow.checkRefresh();

</script>

<%

} catch (Exception e) {
    System.out.println(e);
 %>
    <script>
    alert("Error storing information for: Sh_Customer" + "\n" + "<%= e.getMessage() == null ? "No Info available" : e.getMessage().replace('\n',' ') %>" );
    </script>
<% } finally {
     if(connection != null) {
       connection.close();
     }
   } %>





  </body>
</html>

