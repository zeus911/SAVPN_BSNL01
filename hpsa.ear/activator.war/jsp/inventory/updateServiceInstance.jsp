<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->
<%@page info="Updates a field for a given service instance"
        import="com.hp.ov.activator.mwfm.servlet.*, 
                java.sql.*, 
                javax.sql.DataSource,
                java.net.*" 
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(Constants.USER) == null) {
       response.sendRedirect ("/activator/jsp/sessionError.jsp");
       return;
    }   

    // Don't cache the page
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding ("UTF-8");
%>

<%!
    //I18N strings  
    final static String updateMsg   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("126", "Service Instance successfully updated: ");
    final static String errorMsg    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("93", "Unable to retrieve Service Instance data: ");
    final static String noUpdate    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("127", "Unable to update Service Instance data");
    final static String error   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1", "Error: ");
%>

<html>
<head>
   <script language="JavaScript" src="/activator/javascript/utilities.js"></script>
   <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
   <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
</head>

<body>
<% 
   String serviceID  = request.getParameter("ID"); 
   String fieldName  = request.getParameter("name");
   String fieldValue = request.getParameter("value");
  
   DataSource dataSource= (DataSource) session.getAttribute (Constants.DATASOURCE_INVENTORY);
   Connection connection = null;
   PreparedStatement pstmt = null;
   try { 
       connection = (Connection) dataSource.getConnection();
       pstmt = connection.prepareStatement ("update service_instance_parameters set value = ? where service_id = ? " + 
                   " and name = ?");

       pstmt.setString (1, fieldValue);
       pstmt.setString (2, serviceID);
       pstmt.setString (3, fieldName);

       int rows = pstmt.executeUpdate();
       if (rows != 1) {
%>
        <script>alert("<%=noUpdate%>:  <%= serviceID%>");</script>
<%
       } else {
%>
        <script>writeToMsgLine("<%=updateMsg%> <%= serviceID%>");</script>
<%
       }
%>
       <SCRIPT LANGUAGE="JavaScript">
            parent.invSubmit.location = '/activator/jsp/inventory/QueryInstallation.jsp?serviceID=<%= URLEncoder.encode(serviceID) %>';
       </SCRIPT>
<%
   } 
   catch (Exception e) {
         String err = "";
         
         if (e.getMessage() != null) {
           err = e.getMessage().replace('\n',' ');
           
         } else
                err = e.toString().replace('\n',' ');
%>
         <SCRIPT LANGUAGE="JavaScript">
             alert("HP Service Activator" + "\n\n" + "<%= errorMsg%>\n<%=error%> <%= err%> ");
         </SCRIPT>
<% 
   } 
   finally { 
       try {
           if (pstmt != null) pstmt.close();
       } 
       catch (Exception e) {}

       connection.close(); 
   } 
%>

</center>
</body>
</html>
