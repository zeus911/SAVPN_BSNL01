<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->

<%@page info="Query requested installation"
        import="com.hp.ov.activator.mwfm.servlet.*, 
                java.sql.*, 
                java.net.*, 
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

    // Don't cache the page
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding ("UTF-8");
%>

<%!
        //I18N strings
        final static String title   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("92", "Service Instance ");
        final static String errorMsg    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("93", "Unable to retrieve Service Instance data: ");
        final static String noData      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("94", "No Service Instance data is available. ");
        final static String error       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1", "Error: ");
        final static String name        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("95", "Name");
        final static String value       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("96", "Value");
        final static String action      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("97", "Action");
        final static String edit    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("98", "Edit");
        final static String binaryParam = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("99", "binary parameter - cannot be edited");
%>

<html>
<head>
   <script language="JavaScript" src="/activator/javascript/utilities.js"></script>
   <script language="JavaScript" src="/activator/javascript/menu.js"></script>
   <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
   <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
</head>

<script language="JavaScript">
    clearMessageLine();
</script>

<%
    String serviceID = "";
    if (request.getParameter("serviceID") != null) {
        serviceID = URLDecoder.decode(request.getParameter("serviceID")); 
    }
    else {
%>
         <script> alert(com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("100", "You must pass a valid service instance id to this JSP."));</script>
<%
    }
%>

<body>
<center>
<h2><%= title %> <i><%= serviceID %></i></h2>

<% 
   DataSource dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE_INVENTORY);
   Connection connection = null;
   PreparedStatement pstmt = null;
   ResultSet rset = null;

   String select1 = "select name, value from service_instance_parameters where service_id = ?";
   String select2 = "select name, 'binary_parameter' from service_instance_binparams where service_id = ?";
   String union = " union ";
   String orderBy = " order by name";
   String strQuery = select1 + union + select2 + orderBy;

   try { 
     connection = (Connection) dataSource.getConnection();
     pstmt = connection.prepareStatement(strQuery);
     pstmt.setString (1, serviceID);
     pstmt.setString (2, serviceID);
     rset = pstmt.executeQuery();
     String fieldName, fieldValue;
     if (rset.next()) {
%>
     <table width = "100%" border="0" cellpadding="0">
     <tr>
        <td class="invTitle" nowrap><%=name%></td>
        <td class="invTitle"><%=value%></td>
     </tr>
<%  

     String formatTag = (((Boolean)session.getAttribute(Constants.FORMAT_TEXT)).booleanValue() == true ? "<pre>" : "");
     int numRows=0;

     do { 
        fieldName = rset.getString(1);
    fieldValue = rset.getString(2);
        if (fieldValue == null) fieldValue = "&nbsp;";
%>
<%
     if (fieldValue.equals("binary_parameter")) {
%>
             <tr class= <%= (numRows%2) == 0 ? "tableOddRow" : "tableEvenRow" %> >
             <td class="invCell"><%= fieldName%></td>
             <td class="invCell"><i><%=binaryParam%></i></td>
             </tr>
<%
         } 
         else {
%>
             <tr class= <%= (numRows%2) == 0 ? "tableOddRow" : "tableEvenRow" %>
                 OnClick="location.href='/activator/jsp/inventory/UpdateFormServiceInstance.jsp?ID=<%=URLEncoder.encode(serviceID)%>&name=<%=URLEncoder.encode(fieldName)%>&value=<%=URLEncoder.encode(fieldValue)%>';"
                  onMouseOver="mouseOver(this);"
                  onMouseOut ="mouseOut(this);" >
             <td class="invCell"><%= fieldName%></td>
             <td class="invCell"> <%=formatTag%><%= fieldValue==null ? "&nbsp;" : fieldValue  %></td>
             </tr>
<%
         }
%>
        </tr>
<%  
        numRows++;
     } while (rset.next()); 
%>
     </table>

<%   }
     else {
%>
         <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
         writeToMsgLine("<%=noData%>");
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
<% 
    } finally { 
       try {
     if (rset  != null) rset.close();
         if (pstmt != null) pstmt.close();
       } catch (Exception e) {}
         connection.close(); 
   } %>

<%-- Some useful functions --%>
<%! public String quote (String str) 
    {
       if (str == null) return "";
       StringBuffer strBuffer = new StringBuffer();
       for (int i = 0; i < str.length(); i++) {
          switch (str.charAt (i)) {
        case '\\':
           strBuffer.append ("\\\\");
           break;
        case '\"':
          // strBuffer.append ("");
           break;
            case '\'':
           strBuffer.append ("\\'");
               break;
        default:
           strBuffer.append (str.charAt (i));
      }
       }
       return strBuffer.toString();
    }
%>
</center>
</body>
</html>
