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


</head>
<body>

<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.Sh_Customer" />

<% DataSource dataSource = (DataSource) session.getAttribute(Constants.DATASOURCE);
   Connection connection = null;
   try {

     bean.setCustomerid(request.getParameter("customerid"));

     String cust = (String)request.getParameter("customername");
    String[] cust1 = cust.split("\n");
     StringBuffer sb = new StringBuffer();
     if(cust1.length>0)
     {
     for(int i=0;i<cust1.length;i++)
     {
        sb.append(cust1[i].trim());
        if(i+1<cust1.length)
            sb.append(";");

     }
      bean.setCustomername(sb.toString().trim());
     }
     else
         bean.setCustomername(cust);

     bean.setMarker(request.getParameter("marker"));

     bean.setUploadstatus(request.getParameter("uploadstatus"));

     bean.setDbprimarykey(request.getParameter("dbprimarykey"));

     connection = (Connection) dataSource.getConnection();

     String __hashcode = request.getParameter("__hashcode");
     int hashcode;
     try {
       hashcode = Integer.parseInt(__hashcode);
     } catch (Exception e) {
       if (__hashcode == null || "".equals(__hashcode)) {
         throw new RuntimeException("Parameter [__hashcode] is mandatory. This hidden field is used to make runtime check if another user/workflow has changed the object you are working on");       } else {
         throw new RuntimeException("Incorrect value for hidden field '__hashcode', must be an integer value");
       }
     }
com.hp.ov.activator.vpn.inventory.Sh_Customer dbBean = (com.hp.ov.activator.vpn.inventory.Sh_Customer)com.hp.ov.activator.vpn.inventory.Sh_Customer.findByPrimaryKey( connection, bean.getPrimaryKey() );

      if (hashcode != ActivatorUtils.calculateHashValue(dbBean)) {
        throw new RuntimeException("Current object has changed in the database since last load. You are not able to submit this update. Please load object again");
      }

     bean.update( connection );
 %>

<B>Sh_Customer '<%= bean.getPrimaryKey() %>' stored successfully.</B>


    <script>
        // window.location.href = "/activator/jsp/inventory/RefreshTree.jsp"
    </script>

<%  } catch (Exception e) { %>
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

