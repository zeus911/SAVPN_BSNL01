<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->

<%@page info="Remove a service instance"
        import="com.hp.ov.activator.mwfm.servlet.*, 
                java.net.*, 
                java.sql.*, 
                javax.sql.DataSource" 
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

    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding ("UTF-8");
%>

<%!
    //I18N strings
    final static String successMsg  =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("113", "Service Instance successfully removed: ");
        final static String errorMsg    =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("114", "Unable to remove Service Instance: ");
        final static String error       =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1", "Error: ");
        final static String noServiceToDelete=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("115", "A valid service ID must be passed.");
%>

<html>
<head>
   <script language="JavaScript" src="/activator/javascript/utilities.js"></script>
   <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
   <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
</head>
<body>

<script language="JavaScript">
    clearMessageLine();
</script>

<% 
    if (request.getParameter("serviceID") == null) {
%>
    <script>alert("<%=noServiceToDelete%>");</script>
<%
    }
    else {
       String serviceID = URLDecoder.decode(request.getParameter("serviceID"));

       DataSource dataSource = (DataSource) session.getAttribute(Constants.DATASOURCE_INVENTORY);
       Connection connection = null;
       PreparedStatement pstmt = null;
       ResultSet rset = null;
       int numDelete=0;
       int numBinDelete=0;

       try { 
          connection = (Connection) dataSource.getConnection();
          pstmt = connection.prepareStatement("delete from service_instance_parameters where service_id = ?");
          pstmt.setString (1, serviceID);
          numDelete = pstmt.executeUpdate();

          pstmt = null;
          pstmt = connection.prepareStatement("delete from service_instance_binparams where service_id = ?");
          pstmt.setString (1, serviceID);
          numBinDelete = pstmt.executeUpdate();
       } 
       catch (Exception e) { 
          String err = "";
         
         if (e.getMessage() != null) {
           err = e.getMessage().replace('\n',' ');
           
         } else
                err = e.toString().replace('\n',' ');
%>
          <script>
              alert("HP Service Activator" + "\n\n" + "<%=errorMsg%>\n <%=error%> <%=err%> ");
          </script>
<% 
       } 
       finally { 
           try {
             if (pstmt != null) pstmt.close();
           } catch (Exception e) {}

           connection.close(); 

           //write either success or failure message
           if (numBinDelete == 0 && numDelete == 0) {
%>
               <script> alert("<%=errorMsg%> <%=serviceID%>"); </script>
<%         } 
           else {
%>
               <script> writeToMsgLine("<%=successMsg%> <%=serviceID%>"); </script>
<%         }

           // update the frames to include all new data
%>
           <script>
               top.servicetree.location = '/activator/servicetree?refresh=true&displayType=instance';
               parent.invSubmit.location = '/activator/jsp/inventory/invMsg.jsp?displayType=instance';
           </script>
<%
       }
    }  // end of outer check for valid serviceID
%>
</body>
</html>
