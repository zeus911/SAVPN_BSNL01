<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->

<%@page info="Queries available service instances"
        import="com.hp.ov.activator.mwfm.servlet.*, 
        javax.sql.DataSource,
                java.sql.*" 
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
%>

<%!
    //I18N strings
    final static String summaryTitle    =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("101", "Service Instance Summary");
    final static String serviceInstanceId   =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("102", "Service Instance ID ");
    final static String name        =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("95", "Name");
    final static String value       =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("96", "Value");
        final static String errorMsg        =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("93", "Unable to retrieve Service Instance data: ");
        final static String error           =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1", "Error: ");
    final static String mayBeBinaryParam    =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("103", "Values stored in the service_instance_binparams table are not printable.");
    final static String binaryParam     =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("104", "binary parameter");
    final static String noData      =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("105", "No Service Instance data is available to display.");
%>

<html>
<head>
 <script language="JavaScript" src="/activator/javascript/utilities.js"></script>
 <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
 <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
</head>

<script language="JavaScript">
    clearMessageLine();
</script>

<body>
<center>
<h2><%=summaryTitle%></h2>

<table width="100% border="0" cellpadding="0">
   <td width="40%" class="invTitle" nowrap><%=serviceInstanceId%></td>
   <td width="30%" class="invTitle" nowrap><%=name%></td>
   <td width="30%" class="invTitle" nowrap><%=value%></td>

<%
   DataSource dataSource = (DataSource) session.getAttribute(Constants.DATASOURCE_INVENTORY);
   Connection connection = null;
   PreparedStatement pstmt = null;
   ResultSet rset = null;

   try {
     connection = (Connection) dataSource.getConnection();
     String select1 = "select service_id, name, value from service_instance_parameters"; 
     String select2 = "select service_id, name, 'binary_parameter' from service_instance_binparams"; 
     String union = " union "; 
     String orderBy = " order by service_id, name"; 
     String strQuery = select1 + union + select2 + orderBy;
     pstmt = connection.prepareStatement (strQuery.toString());
     rset = pstmt.executeQuery();

     if (rset.next()) {
           int numRows=0;
           String priorID="";

           do {
              String serviceID = rset.getString(1);
          String fieldValue = rset.getString(3);
%>
              <tr class= <%= (numRows%2 == 0) ? "tableOddRow" : "tableEvenRow" %> >
                <td class="invCell"><%= serviceID.equals(priorID) ? "&nbsp" : serviceID %></td>
                <td class="invCell"><%= rset.getString(2) %></td>
<%
          if (fieldValue != null && fieldValue.equals("binary_parameter")) {
%>
                    <td class="invCell"><i><%=binaryParam%></td>
<%
              }
          else {
%>
                    <td class="invCell"><%= rset.getString(3)==null ? "&nbsp" : rset.getString(3) %></td>
<%       }
%>
              </tr>

<%
             numRows++;
             priorID=serviceID;
           } while (rset.next());

       // print message that empty value may be a binary object
%>
       <script> 
        writeToMsgLine("<%=mayBeBinaryParam%>");
       </script> 
<%      }
     else {
%>
           <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
              var fPtr = parent.frames['messageLine'].document;
              fPtr.open();
              fPtr.write("<%=noData%>");
              fPtr.close();
           </script>
<% 
     }
   } catch (Exception e) {
        String err = "";
         
         if (e.getMessage() != null) {
           err = e.getMessage().replace('\n',' ');
           
         }
          else
                err = e.toString().replace('\n',' ');
%>
        <SCRIPT LANGUAGE="JavaScript">
           alert("HP Service Activator" + "\n\n" + "<%=errorMsg%>\n <%=error%> <%=err%>");
        </SCRIPT>

<% } finally {
       try {
         if (rset  != null) rset.close();
         if (pstmt != null) pstmt.close();
       } catch (Exception e) {}
       connection.close();
   }
%>

</table>
</center>
</body>
</html>
