<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
 <%@ page import = "com.hp.ov.activator.inventory.facilities.StringFacility" %>
 <%@ page import = "com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.ConstantsFTStruts" %>

<%

String errorAction = (String) request.getAttribute(ConstantsFTStruts.ERROR_ACTION);
String errorMessage = (String) request.getAttribute(ConstantsFTStruts.ERROR_MESSAGE);
String exceptionMessage = (String) request.getAttribute(ConstantsFTStruts.EXCEPTION_MESSAGE);

String url=  "/activator/jsp/inventory-gui/inventory/inventorytree/inventoryTreeError.jsp?" +   ConstantsFTStruts.ERROR_ACTION + "=" + errorAction   + "&"  +   ConstantsFTStruts.ERROR_MESSAGE  + "=" + errorMessage +   "&"  +  ConstantsFTStruts.EXCEPTION_MESSAGE  + "=" + exceptionMessage ;

url=StringFacility.replaceAllByHTMLCharacter(url);

%>

<script>
parent.location.href = "<%=url%>";
</script>
