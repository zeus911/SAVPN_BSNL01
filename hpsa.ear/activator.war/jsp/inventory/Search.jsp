<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->


<%@page info="Queries available installations"
        import="com.hp.ov.activator.mwfm.servlet.*, 
        java.net.*,
        java.util.*,
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

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader    ("Pragma",  "no-cache");
    request.setCharacterEncoding ("UTF-8");
%>

<%!
    //I18N strings
    final static String searchResults   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("106", "Search Results");
    final static String serviceID       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("107", "Service ID");
    final static String noServiceMatches    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("108", "No Service Instances match the select criteria. ");
    final static String errorMsg        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("109", "Unable to retrieve Service Instance data. ");
    final static String error           = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1", "Error: ");
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
<h2><%=searchResults%></h2>

<% 
   DataSource dataSource = (DataSource) session.getAttribute(Constants.DATASOURCE_INVENTORY);
   Connection connection = null;
   PreparedStatement pstmt = null;
   ResultSet rset = null;

   try { 
     connection = (Connection) dataSource.getConnection();  
     
     StringBuffer strQuery = new StringBuffer();
     if (request.getParameter ("attribute") != null) {
    // Search by attribute
    strQuery.append ("select distinct(service_id) from service_instance_parameters ");
    String attribute = request.getParameter ("name");
    if (attribute != null && attribute.trim().length() == 0)
       attribute = null;
    if (attribute != null)
       strQuery.append (" where name " + (request.getParameter ("nameb") != null && 
            request.getParameter ("nameb").equals ("yes") ? 
                    "like '%' || ? || '%' " : "= ?"));
    String value = request.getParameter ("value");
    if (value != null && value.trim().length() == 0)
       value = null;
    if (value != null) {
       if (attribute != null)
        strQuery.append (" and ");
           else 
            strQuery.append (" where ");
       strQuery.append (" value " + 
        (request.getParameter ("valueb") != null &&     
            request.getParameter ("valueb").equals ("yes") ? 
                    "like '%' || ? || '%' " : "= ?"));
    }

        pstmt = connection.prepareStatement (strQuery.toString());
    int j = 1;
    if (attribute != null) {
       pstmt.setString (1, attribute);
       j++;
    }
    if (value != null) {
       pstmt.setString (j, value);
    }

        rset = pstmt.executeQuery();
        if (rset.next()) {
%>

           <table width="75%" border="0" cellpadding="0">
              <td class="invTitle"><%=serviceID%>&nbsp;</td>
<%
           int numRows=0;
           do { 
              String serviceID = rset.getString (1);
%>
              <tr class= <%= (numRows%2 ==0) ? "tableOddRow" : "tableEvenRow" %> >
                <td class="invCell">
                  <a href="/activator/jsp/inventory/QueryInstallation.jsp?serviceID=<%= URLEncoder.encode (serviceID) %>">
                  <%= serviceID %></a>
                </td>
              </tr>
<%       
             numRows++;
           } while (rset.next()); 
%>
          </tr>
          </table>
<%
        }
        else {
%>
           <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
        writeToMsgLine("<%=noServiceMatches%>");
           </script>
<%      }
     }
     else { 
    strQuery.append ("select a0.service_id ");
    // Search by client information
    Enumeration en = request.getParameterNames();
    int tables = 0;
    StringBuffer strWhere = new StringBuffer();
    while (en.hasMoreElements()) {
        String foo = (String) en.nextElement();
        if (!foo.endsWith("b")) {
           String value = request.getParameter (foo);
           if (value == null || value.trim().length() == 0) continue;
           if (tables == 0)
             strWhere.append (" where ");
           else 
             strWhere.append (" and ");
           strWhere.append ("a0.service_id = a" + tables + ".service_id and " + 
                "a" + tables + ".name = ? and a" + tables + ".value " +
                            (request.getParameter (foo + "b") != null ? " like '%' || ? || '%' " : " = ? "));
           tables++;
        }
        }
    if (tables == 0) strQuery = new StringBuffer ("select distinct (a0.service_id) ");  
    // Tables

    int kk = 0; 
        en = request.getParameterNames();
    while (en.hasMoreElements()) {
        String foo = (String) en.nextElement();
        if (!foo.endsWith("b")) {
           String value = request.getParameter (foo);
           if (value == null || value.trim().length() == 0) continue;
           strQuery.append (", a" + (kk++) + ".value  " + foo + " ");   
        }
         }
    strQuery.append (" from service_instance_parameters a0 ");
    for (int i = 1; i < tables; i++) 
      strQuery.append (", service_instance_parameters a" + i + " ");

    strQuery.append (strWhere);
    
    pstmt = connection.prepareStatement (strQuery.toString());
        en = request.getParameterNames();
    int j = 1;
    while (en.hasMoreElements()) {
        String foo = (String) en.nextElement();
        if (!foo.endsWith("b")) {
           String value = request.getParameter (foo);
           if (value == null || value.trim().length() == 0) continue;
           pstmt.setString (j++, foo);
           pstmt.setString (j++, value);    
        }
         }

    
    rset = pstmt.executeQuery();
    if (rset.next()) {
       ResultSetMetaData rsmd = rset.getMetaData();
%>
           <table width="75% border="0" cellpadding="0">
<%
       for (int i = 0; i < rsmd.getColumnCount(); i++) {
%>
               <th class="invTitle"><%= rsmd.getColumnName (i + 1)%></th>
<%         } 

           int numRows=0;
           do { 
              String serviceID = rset.getString (1); 
%>
              <tr class= <%= (numRows%2 == 0) ? "tableOddRow" : "tableEvenRow" %> >
                 <td class="invCell">
                    <a href="/activator/jsp/inventory/QueryInstallation.jsp?serviceID=<%=URLEncoder.encode(serviceID)%>">
                             <%= serviceID %></a>
                  </td>
<%            for (int i = 1; i < rsmd.getColumnCount(); i++) {
%>
                  <td class="invCell"><%= rset.getString (i + 1) %></td>
<%
              }
%>
              </tr>
<%         
             numRows++;
           } while (rset.next()); 
%>

           </table>
<%      } 
        else {
%>
           <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
        writeToMsgLine("<%=noServiceMatches%>");
           </script>
<%      }
     }
   } catch (Exception e) { 
        String err = "";
         
         if (e.getMessage() != null) {
           err = e.getMessage().replace('\n',' ');
           
         } else
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
       connection.close() ; 
   } 
%>

</center>
</body>
</html>
