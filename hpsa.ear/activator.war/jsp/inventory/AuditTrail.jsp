<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.*,
                 com.hp.ov.activator.mwfm.servlet.*,
                 com.hp.ov.activator.mwfm.component.AuditEvent,
                 java.sql.*,
                 java.text.*,
                 javax.sql.DataSource,
                 java.net.*"
         info="Queries available service instances"
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
    // I18N strings
    final static String auditHeader = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("37", "Audit Trails");
    final static String invElement  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("82", "Inventory Element");
    final static String query       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("83", "Query");
    final static String clear   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("17", "Clear");
    final static String noAuditData = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("84", "No audit trail information is available for selected query.");
    final static String pleaseSelect = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("545", "Please select an inventory element to query against.");
    final static String id      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("85", "ID");
    final static String time    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("86", "Time of Operation");
    final static String dbOperation = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("87", "Database Operation"); 
    final static String user    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("88", "User"); 
    final static String errMsg  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("89", "Unable to retrieve audit trail information");
    final static String error   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1", "Error: ");
    final static String noAccessRights=com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("90", "Only system adminstrators are allowed access to this page.");
    final static String queryFor    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("91", "Query For:");
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
<% 
   String[] classes = request.getParameterValues ("element");

   int j=0;
   String operation="";
   if (request.getParameter("store") != null) {
      operation = "'STORE'";
      j++;
   }
   if (request.getParameter("update") != null) {
      operation += (operation.length() > 0 ? ", 'UPDATE'" : "'UPDATE'");
      j++;
   }
   if (request.getParameter("delete") != null) {
      operation += (operation.length() > 0 ? ", 'DELETE'" : "'DELETE'");
   }

%>

<h1><%=auditHeader%></h1>

<% 
   boolean bServices = ((Boolean) session.getAttribute(Constants.MWFM_SERVICES)).booleanValue(); 
if (bServices) {
    DataSource dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE_INVENTORY);
    Connection connection = null;
    PreparedStatement pstmt = null;
    ResultSet rset = null;
    try { 
        connection = (Connection) dataSource.getConnection();
        pstmt = connection.prepareStatement ("select distinct(class) from audit_record order by class");
        rset = pstmt.executeQuery();
        String fieldName, fieldValue;
        if (rset.next()) {
%>
<form action="/activator/jsp/inventory/AuditTrail.jsp" method="post">
<table>
  <tr>
    <td class="invBField" id="req"><%=invElement%></td>
    <td class="invField" id="req"><select name="element" size="3" multiple>
<%
            do {
                String className = rset.getString(1);
                if(className != null){
%>
       <option class="invCell"><%= className %></option>
<%          
                }
            } while (rset.next()); %>
       </select>
   </tr>
 
  <tr>
    <td class="invBField"><%=queryFor%></td>
    <td class="invCell" colspan="3" >
    Store<input type="checkbox" name="store" value="STORE" CHECKED>
    Update<input type="checkbox" name="update" value="UPDATE" CHECKED>
    Delete<input type="checkbox" name="delete" value="DELETE" CHECKED>
    </td>
  </tr>
   <tr>&nbsp;</tr>
   <tr>
     <td class="invField" colspan="3" align="center" >
       <input type="submit" value="<%=query%>">
       <input type="reset" value="<%=clear%>">
     </td>
   </tr>
</table>
</form>

<% 
        } else {
            out.println(noAuditData);
        }
        if (classes == null || classes.equals("") ) {
%>
        <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
        writeToMsgLine("<%=pleaseSelect%>");
        </script>
<%
        }

        if (classes != null ) { 
            if (rset != null) rset.close();
            if (pstmt != null) pstmt.close();

            // create the where clause
            String where="where event_type='"+AuditEvent.INVENTORY_EVENT+"' ";

            if (operation != null && !operation.equals("") ) {
                where += " and step_name in (";
                where += operation; 
                where += ") ";
            }

            where +=  " and class in (";
            for (int i = 0; i < classes.length; i++){
                if (i == 0) 
                    where += "'" + classes[i] + "'";
                else 
                    where += ", '" + classes[i] + "'";
            }
            where += ") ";

            pstmt = connection.prepareStatement
                    ("select * from audit_record " + where + " order by identifier, class, date_time");
            rset = pstmt.executeQuery();
            if (rset.next()) {
%>
<table>
   <tr>
     <td class="invTitle"><%=id%></td>
     <td class="invTitle"><%=invElement%></td>
     <td class="invTitle"><%=time%></td>
     <td class="invTitle"><%=dbOperation%></td>
     <td class="invTitle"><%=user%></td>
   </tr>
<%  
                int numRows=1;
                String rowClass="";

                do {
                    rowClass= (numRows%2 == 0) ? "tableEvenRowNoPointer" : "tableOddRowNoPointer";
                    DateFormat sf = DateFormat.getDateTimeInstance();
%>
         <tr class="<%=rowClass%>">
            <td class="invCell"><%= rset.getString ("identifier") %></td>
            <td class="invCell"><%= rset.getString ("class") %></td>  
            <td class="invCell"><%= sf.format(rset.getTimestamp("date_time")) %></td>
            <td class="invCell"><%= rset.getString ("step_name") %></td>
            <td class="invCell"><%= rset.getString ("user_name") %></td>
         </tr>
<% 
                    ++numRows;   
                } while (rset.next());
%>
</table>
<%
            } else {
%>
        <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
        writeToMsgLine("<%=noAuditData%>");
        </script>
<%      
            }
        }
    } catch (Exception e) { 
%>
      <SCRIPT LANGUAGE="JavaScript"> alert("<%= ExceptionHandler.handle(e) %>"); </SCRIPT>
<%
    } finally { 
        try {
            if (rset  != null) rset.close();
            if (pstmt != null) pstmt.close();
        } catch (Exception e) {}
        connection.close(); 
    } 
} else {
%>
   <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
    writeToMsgLine("<%=noAccessRights%>");
  </script>
<%
}
%>

</center>
</body>
</html>
