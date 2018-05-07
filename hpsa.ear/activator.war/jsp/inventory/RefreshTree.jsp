<!--------------------------------------------------------------------------
   HP OpenView Service Activator
   (c) Copyright 2010 Hewlett-Packard Development Company, L.P.
--------------------------------------------------------------------------->
<%@ page import="java.util.*,
				com.hp.ov.activator.inventorybuilder.spain.*,
				org.apache.struts.util.LabelValueBean,
				org.apache.struts.action.Action,
				org.apache.struts.action.ActionErrors " %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table" %>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn" %>

<%

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String rimid = (String) request.getParameter("rimid");
String refreshTreeRimid=(String) request.getParameter("refreshTreeRimid");

%>
<html>
  <head>

	<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
	<script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
  </head>

  <body background="/activator/images/inventory-gui/fondo.gif">

    <script>
 	parent.document.getElementById("ifr" + "<%=refreshTreeRimid%>").contentWindow.checkRefresh();
    </script>
  	
  </body>
</html>
