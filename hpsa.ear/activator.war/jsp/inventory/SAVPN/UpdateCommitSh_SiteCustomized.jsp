<%@page info="Update JSP for bean Sh_Site"
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

<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.Sh_Site" />

<%

    String onchange= request.getParameter("onchange");

if(onchange != null && onchange.equalsIgnoreCase("onchange"))
    {
        String primaryKey = request.getParameter("primaryKey");
        String selectedId = request.getParameter("customerid");

    %>
<form name="form1" method="POST" action="UpdateFormSh_SiteCustomized.jsp">
<input type = "hidden" name = "primaryKey" value = "<%= primaryKey%>">
<input type = "hidden" name = "action" value = "resolve">
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

     bean.setServiceid(request.getParameter("serviceid"));

     bean.setCustomerid(request.getParameter("customerid"));

     bean.setServicename(request.getParameter("servicename"));

     bean.setInitiationdate(request.getParameter("initiationdate"));

     bean.setActivationdate(request.getParameter("activationdate"));

     bean.setModificationdate(request.getParameter("modificationdate"));

     bean.setState(request.getParameter("state"));

     bean.setType(request.getParameter("type"));

     bean.setContactperson(request.getParameter("contactperson"));

     bean.setComments(request.getParameter("comments"));

     bean.setMarker(request.getParameter("marker"));

     bean.setUploadstatus(request.getParameter("uploadstatus"));

     bean.setDbprimarykey(request.getParameter("dbprimarykey"));

     try {
       String value = request.getParameter("__count");
       Number number = NumberFormat.getInstance().parse(value);
       bean.set__count(number.intValue());
     } catch (Exception e) {
       String value = request.getParameter("__count");
       if (value == null || "".equals(value)) {
         throw new RuntimeException("Parameter [__count] is mandatory.");
       } else {
         throw new RuntimeException("Incorrect value for field '__count'");
       }
     }

     bean.setRemoteasn(request.getParameter("remoteasn"));

     bean.setOspf_area(request.getParameter("ospf_area"));

     bean.setSiteoforigin(request.getParameter("siteoforigin"));

     bean.setManaged(Boolean.valueOf(request.getParameter("managed")).booleanValue());

     bean.setMulticast(request.getParameter("multicast"));

     bean.setPostaladdress(request.getParameter("postaladdress"));

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
com.hp.ov.activator.vpn.inventory.Sh_Site dbBean = (com.hp.ov.activator.vpn.inventory.Sh_Site)com.hp.ov.activator.vpn.inventory.Sh_Site.findByPrimaryKey( connection, bean.getPrimaryKey() );

      if (hashcode != ActivatorUtils.calculateHashValue(dbBean)) {
        throw new RuntimeException("Current object has changed in the database since last load. You are not able to submit this update. Please load object again");
      }


        String serviceid = request.getParameter("serviceid");
        String customerid = request.getParameter("customerid");
        String old_customerid = request.getParameter("old_customerId");

        String statement = "update sh_service set customerid='" + customerid
            + "', servicename = '"+ bean.getServicename()+"' where serviceid in (select serviceid from sh_accessflow where siteid='"
            + serviceid + "') or serviceid='" + serviceid + "'" ;

        PreparedStatement pstmt = null;
        pstmt = connection.prepareStatement(statement);
        pstmt.executeUpdate();
        pstmt.close();

        ResultSet rs = null;
      int rowCount = -1;
        Statement stmt = null;

        stmt = connection.createStatement();
          statement = "select count(*) from SH_SERVICE where customerid='" + old_customerid + "'";
        rs = stmt.executeQuery(statement);

       // get the number of rows from the result set
       rs.next();
       rowCount = rs.getInt(1);

    if (rowCount <=0) {
        Statement pstmt1 = null;
        statement = "delete SH_CUSTOMER where customerid='" + old_customerid + "'";
        pstmt1 = connection.createStatement();
        pstmt1.executeUpdate(statement);
        pstmt1.close();
    }
        rs.close();
        stmt.close();


 %>
<b>Sh_Site '<%= bean.getServicename() %>' stored successfully.</b>


    <script>
        parent.document.getElementById("ifr" + "<%=refreshTreeRimid%>").contentWindow.checkRefresh();
    </script>

<%  } catch (Exception e) { %>
    <script>
    alert("Error storing information for: Sh_Site" + "\n" + "<%= e.getMessage() == null ? "No Info available" : e.getMessage().replace('\n',' ') %>" );
    </script>
<% } finally {
     if(connection != null) {
       connection.close();

     }
   } }%>

</body>
</html>
