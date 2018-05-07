<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->


<%@ page session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<html>
<head>
   <script language="JavaScript" src="/activator/javascript/utilities.js"></script>
   <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
</head>

<script language="JavaScript">
    clearMessageLine();
</script>

<%!
	//I18N strings
	final static String searchTitle	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("119", "Search");
	final static String name	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("95", "Name");
	final static String like	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("120", "Like");
	final static String value	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("96", "Value");
	final static String search	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("119", "Search");
	final static String clear	= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("17", "Clear");
%>

<body>
<h2><%=searchTitle%></h2>
<center>
<form name="attribute_form" action="/activator/jsp/inventory/Search.jsp" method="post">
<table>
  <input type="hidden" name="attribute" value="true">
  <tr>
    <td class="invField" id="opc"><%=name%></th>
    <td><input type="text" name="name" size="30"></td>
    <td class="invField" id="opc"><input type="checkbox" name="nameb" value="yes"><%=like%></td>
  </tr>
  </tr>
    <td class="invField" id="opc"><%=value%></th>
    <td><input type="text" name="value" size="30"></td>
    <td class="invField" id="opc"><input type="checkbox" name="valueb" value="yes"><%=like%></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3" align="center">
      <input type="submit" name="search" value="<%=search%>">
      <input type="reset" value="<%=clear%>">
  </tr>
</table>
</form>
</center>
</body>
</html>
