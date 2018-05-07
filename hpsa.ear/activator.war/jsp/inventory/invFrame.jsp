<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->


<%@ page  import="com.hp.ov.activator.mwfm.servlet.*,    java.net.*"
         info="Shows the main heading, putting only the options available to the user"
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
	String displayType = (String) request.getParameter("displayType");
        String displayHeader;

        String invoke;
        String inventoryInvoke = "/activator/servicetree?displayType=inventory";
	String instanceInvoke = "/activator/servicetree?displayType=instance&name=Service Instances&type=Service Instances";

	if(displayType.length() > 0) {
	    displayHeader = (displayType.equals("inventory"))  ? "0" : "1";
	    invoke = (displayType.equals("inventory"))  ? inventoryInvoke : instanceInvoke;
	}
	else {
	    // no parameter is passed - the default is inventory 
	    displayHeader = "0";
	    invoke = inventoryInvoke;
        }
%>
<%! 
        final static String instanceTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("546", "HP Service Activator Service Instances");
        final static String inventoryTitle= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("547", "HP Service Activator Inventory");
%>

<html>
<head>
  <title><%= displayType.equals("inventory") ? inventoryTitle  : instanceTitle %></title>
  <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
</head>
   
   <frameset border="0" rows="10%,3%,*" frameborder="no" border="0">
      <frameset border="0" cols="90%,*" frameborder="no"> 
          <frame src="/activator/jsp/inventory/header.jsp?value=<%= displayHeader %>" name="invHeader" 
                    marginheight="0" marginwidth="10" noresize scrolling="no"></frame>
          <frame src="/activator/images/HPlogo-black.gif" marginheight="5" marginwidth="10" 
                    noresize scrolling="no"></frame>
      </frameset>

      <frame src="/activator/jsp/inventory/invHeader.jsp" scrolling="no" noresize marginheight="0" marginwidth="10"></frame>

      <frameset cols="35%,*" >
          <frame src="<%=invoke%>" name="servicetree" scrolling="yes" ></frame>
          <frame src="/activator/jsp/inventory/invData.jsp?displayType=<%=displayType%>" name="invMain"></frame>
      </frameset>

   </frameset>

</html>
