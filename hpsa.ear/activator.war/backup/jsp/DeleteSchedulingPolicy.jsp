<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,com.hp.ov.activator.cr.inventory.*,
		         com.hp.ov.activator.vpn.backup.servlet.*,
                 java.sql.*,
                 javax.sql.DataSource,
                 java.util.*,
          java.text.*,
          java.lang.*,
                 java.net.URLDecoder"
         info="View Equipment List" 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table"%>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn"%>
<% /* JPM New */ %>
<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(com.hp.ov.activator.mwfm.servlet.Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    }

    request.setCharacterEncoding("UTF-8");
%>

<html>
<head>
<% /* JPM New */ %>
	<script language="JavaScript" src="../../javascript/table.js"></script>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
</head>
<body>

<% DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);
   String SchedulingPolicy = URLDecoder.decode(request.getParameter("schedulingpolicyname"), "UTF-8");

   Connection con = null;
   try {
     con = (Connection)dataSource.getConnection();
     //NetworkElement[] ne = NetworkElement.findBySchpolicyname(con, SchedulingPolicy.trim());
     	com.hp.ov.activator.vpn.inventory.Switch[] switchBean = com.hp.ov.activator.vpn.inventory.Switch.findAll(con, "schpolicyname='"+SchedulingPolicy.trim() + "'");
	 	  com.hp.ov.activator.vpn.inventory.CERouter[] ceRouterBean = com.hp.ov.activator.vpn.inventory.CERouter.findAll(con, "schpolicyname='"+SchedulingPolicy.trim() + "'");
	 	  com.hp.ov.activator.vpn.inventory.PERouter[] peRouterBean = com.hp.ov.activator.vpn.inventory.PERouter.findAll(con, "schpolicyname='"+SchedulingPolicy.trim() + "'");
	 	
	 	if(switchBean == null &&  ceRouterBean == null && peRouterBean == null){
   
     //if (ne == null){
        com.hp.ov.activator.vpn.backup.SchedulingPolicy.delete (con, SchedulingPolicy.trim());
 %>
        <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
            var fPtr = parent.frames['messageLine'].document;
            fPtr.open();
            fPtr.write("<bean:message bundle="InventoryResources" key="Backup.DeleteSchedulingPolicy.name" /> <%= SchedulingPolicy%> <bean:message bundle="InventoryResources" key="Backup.DeleteSchedulingPolicy.remove" />");
            fPtr.close();
	        parent.frames['main'].location='FindSchedulingPolicy.jsp'
	    </script>

<%    }else {%>
         <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
            var fPtr = parent.frames['messageLine'].document;
            fPtr.open();
            fPtr.write("<bean:message bundle="InventoryResources" key="Backup.DeleteSchedulingPolicy.alert.used" />");
            fPtr.close();
		    parent.frames['main'].location='FindSchedulingPolicy.jsp' ;
        </script>
   <%}
    } catch (Exception e) {
		if ((e.getMessage()).startsWith("ORA-02292")){
		%>
		    <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
                     var fPtr = parent.frames['messageLine'].document;
                     fPtr.open();
                     fPtr.write("<bean:message bundle="InventoryResources" key="Backup.DeleteSchedulingPolicy.alert.used" />");
                     fPtr.close();           
					 parent.frames['main'].location='FindSchedulingPolicy.jsp'				
		    </script>
		<%
		}			
		else{e.printStackTrace();%>
            <b>Error occurred while deleting SchedulingPolicy information.</b>
<%      }
  } finally {
	   if (con != null)
        con.close();
   } %>
</table>
</body>
</html>