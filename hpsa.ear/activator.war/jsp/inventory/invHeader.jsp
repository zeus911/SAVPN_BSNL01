<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->

<%@ page session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%!
    //I18N strings  
    final static String header  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("121", "Contents");
%>

<html>
<head>
  <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
</head>

<body >
<table width="100%" border="0" cellpadding="0">
  <tr>
    <td width="35%" class="invTitle" ><%= header %></td>
    <td width="65%" class="invTitle">&nbsp;</td>
  </tr>
</table>
</body>
</html>
