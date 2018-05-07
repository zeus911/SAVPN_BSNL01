<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,
                java.sql.*, 
				javax.sql.DataSource,
                java.net.*, 
                java.text.*" 
         info="Commig JSP for bean EquipmentConfiguration" 
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
<%
    //JPM New
    // Check if there is a valid session available.
    if (session == null || session.getValue (com.hp.ov.activator.mwfm.servlet.Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    } 
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<html>
<head>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
 	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
</head>

<body>
	<h2 class="mainSubHeading"><center><bean:message bundle="InventoryResources" key="Backup.CreateCommitRetrievalPolicy.title" /></center></h2>

<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.backup.RetrievalPolicy" />
<jsp:setProperty name="bean" property="*"/>

<% DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);   
   Connection con = null;
   try {
      con = (Connection)dataSource.getConnection();  
      bean.store (con);
 %>
RetrievalPolicy stored successfully.
<hr>

<SCRIPT LANGUAGE="JavaScript">
	var fPtr = parent.frames['messageLine'].document;
       fPtr.open();
       fPtr.write("<bean:message bundle="InventoryResources" key="Backup.CreateCommitRetrievalPolicy.storedsuccess" />");
       fPtr.close();
</SCRIPT>

<%  } catch (Exception e) { %>
       <b><bean:message bundle="InventoryResources" key="Backup.CreateCommitRetrievalPolicy.storedError" /></b> <%= e.getMessage() %>
<% } finally {
       con.close();
   } %>
</body>
</html>