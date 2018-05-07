<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->

<%@page info="Refresh the inventory tree"
        import="com.hp.ov.activator.mwfm.servlet.*"
        contentType="text/html; charset=UTF-8"
        language="java"
%>

<%
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
%>


<html>
<body>

     <script>
	// update the inventory tree 
        top.tree.location = '/activator/tree?refresh=true';
        parent.invSubmit.location = '/activator/jsp/inventory/invMsg.jsp';
     </script>

</body>
</html>
