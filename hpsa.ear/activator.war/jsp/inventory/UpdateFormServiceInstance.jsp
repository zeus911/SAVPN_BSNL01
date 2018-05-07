<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->
<%@page info="Update form for Service Instances"
      import="com.hp.ov.activator.mwfm.servlet.*, java.net.*"
      session="true"
      contentType="text/html;charset=utf-8"
%>
<%
    if (session == null || session.getAttribute(Constants.USER) == null) {
        response.sendRedirect("/activator/jsp/sessionError.jsp");
        return;
    }

    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<%!
    // I18N  Strings 
    final static String title      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("122", "Update Service Instance Field Data");
    final static String columnName = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("123", "Column Name");
    final static String columnValue= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("96", "Value");
    final static String submit  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("124", "Update");
    final static String reset       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("125", "Reset");
%>

    
<%
String serviceID  = (request.getParameter("ID")==null)? "" : URLDecoder.decode(request.getParameter("ID"),"UTF-8");
String fieldName  = (request.getParameter("name")==null)? "" : URLDecoder.decode(request.getParameter("name"),"UTF-8");
String fieldValue = (request.getParameter("value")==null)?"" : URLDecoder.decode(request.getParameter("value"),"UTF-8");
%>

<script>
    var fPtr=parent.messageLine.document; 
    fPtr.open();
    fPtr.write("");
    fPtr.close();
</script>

<html>
<head>
  <title>Update Service Instance</title>
  <script language="JavaScript" src="/activator/javascript/checks.js"></script>
  <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
</head>
<body>
<center>
<h2><%= title%><br><i><%=serviceID%></h2>

<form name="updateForm" method="POST" target="messageLine" action="/activator/jsp/inventory/updateServiceInstance.jsp">
<table border=0>
   <tr>
      <td class="invBField" id="name"><%= fieldName%></td>
      <td class="invField" id="value"><input type=text size=35 name="value" value="<%= fieldValue %>"></td>
   </tr>
   <input type="hidden" name="ID" value="<%= serviceID %>">
   <input type="hidden" name="name" value="<%= fieldName%>">

   <tr><td>&nbsp;</td></tr>
   <tr><td>&nbsp;</td></tr>
   <tr>
     <td colspan="2" align="center">
    <input type="submit" name="submit" value="<%=submit%>">&nbsp;
    <input type="reset" name="reset" value="<%=reset%>"> &nbsp;
      </td>
   </tr>
</table>
</center>
</body>
</html>
