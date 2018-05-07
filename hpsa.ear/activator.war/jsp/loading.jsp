<%!
    //I18N strings
    final static String loading  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("548", "Loading data ...");       
%>
<%  String redirect = request.getParameter("redirect");
%>
<html>
<!--
    (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
-->
<head>
  <title>HP Service Activator</title>
</head>
<body>
    <%=loading%>
<%
    if(redirect!=null && !redirect.equals("")){
%>
<script>
    document.location.href = '<%=redirect%>';
</script>
<%
    }
%>
</body>
</html>
