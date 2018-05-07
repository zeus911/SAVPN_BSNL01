<%@page info="Update JSP for bean Sh_Customer"
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
    String refreshTreeRimid=(String) session.getAttribute("refreshTreeRimid");


    %>
<script>
      parent.refreshParentRimTree(4, <%= refreshTreeRimid %>);
    </script>
<html>
<head>
  <script language="JavaScript" src="/activator/javascript/checks.js"></script>
  <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
</head>
<body>

<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.Sh_Customer" />

<%
String onchange= request.getParameter("onchange");

if((onchange != null) &&( onchange.equalsIgnoreCase("onchange")))
    {
        String primaryKey = request.getParameter("primaryKey");
        String selectedId = request.getParameter("customerid");

%>

<form name="form1" method="POST" action="ResolveFormSh_CustomerCustomized.jsp">
<input type = "hidden" name = "primaryKey" value = "<%= primaryKey%>">
<input type = "hidden" name = "selectedId" value = "<%= selectedId%>">

<script>
    form1.submit();
</script>
</form>

<%
    }
else
{

DataSource dataSource = (DataSource) session.getAttribute(Constants.DATASOURCE);
   Connection connection = null;
   try {
connection = (Connection)dataSource.getConnection();
String old_customerid = request.getParameter("old_customerId");
String new_customerid = request.getParameter("customerid");

String statement = "update SH_SERVICE set CUSTOMERID = '" + new_customerid + "'" + " where customerid = '" + old_customerid + "'";

PreparedStatement pstmt = null;
pstmt = connection.prepareStatement(statement);
pstmt.executeUpdate();
pstmt.close();

    Statement pstmt1 = null;
    statement = "delete SH_CUSTOMER where customerid='" + old_customerid + "'";
    pstmt1 = connection.createStatement();
    pstmt1.executeUpdate(statement);
    pstmt1.close();

 %>
<b> Sh_Customer updated successfully.</b>

    <script>
   parent.document.frames["ifr" + "<%=refreshTreeRimid%>"].checkRefresh();
    </script>

<%  } catch (Exception e) {
 %>
    <script>
    alert("Error storing information for: Sh_Customer" + "\n" + "<%= e.getMessage() == null ? "No Info available" : e.getMessage().replace('\n',' ') %>" );
    </script>
<% } finally {
     if(connection != null) {
       connection.close();
     }
   }} %>

</body>
</html>

