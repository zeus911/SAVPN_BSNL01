<!------------------------------------------------------------------------

###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->

<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants,
                 javax.sql.DataSource,
                 java.sql.Connection,
                 com.hp.ov.activator.cr.inventory.*,
                 com.hp.ov.activator.vpn.inventory.MemoryTypes"
         info="Backup Equipment Configuration"
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
    if (session == null || session.getAttribute (Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    }
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<head>
	<script language="JavaScript" src="../../javascript/table.js"></script>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
  	<link rel="stylesheet" type="text/css" href="../../css/spainTable.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
</head>

<body>
<center><h2 class="mainSubHeading"><bean:message bundle="InventoryResources" key="Backup.ShowMemoryTypes.title" /></h2></center>
<%
  String networkElementID = null;
  DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);
  Connection connection = null;
  try {
    connection = (Connection)dataSource.getConnection();
%>
<center>
<form name="form" method="GET" target="displayFrame" action="AuditEquipmentConfiguration.jsp">
<table align="center" width="80%" border=0 cellpadding=0>
  	<tr>
		<td class="mainHeading" align="center" colspan=4><bean:message bundle="InventoryResources" key="Backup.ShowMemoryTypes.title" /></td>
	</tr>
  	<tr class="tableEvenRow">
    		<td width="10%" class="tableCell">&nbsp;</td>
    		<td width="30%" class="tableCell"><bean:message bundle="InventoryResources" key="Backup.ShowMemoryTypes.EquipmentName" /></td>
    		<td width="50%" class="tableCell">
<jsp:useBean id="menuBackupBean" scope="session" class="com.hp.ov.activator.vpn.backup.servlet.menuBackupBean" />
		<%
            String equipmentName = menuBackupBean.getEquipmentName();           
            networkElementID = menuBackupBean.getEquipmentID();
		%>
        <%=equipmentName %>
            </td>
    		<td width="10%" class="tableCell">&nbsp;</td>
  	</tr>
  	<tr class="tableOddRow">
		<td class="tableCell">&nbsp;</td>
		<td class="tableCell"><bean:message bundle="InventoryResources" key="Backup.ShowMemoryTypes.TargetMemory" /></td>
		<td class="tableCell">
<%--        GetMemoryTypes.jsp needs selectedNetworkElementID variable and returns boolean memoryTypesFound as result of finding--%>
        <%@ include file="GetMemoryTypes.jsp" %>

        </td>
		<td class="tableCell">&nbsp;</td>

  	</tr>
	<tr class="tableEvenRow">
		<td class="tableCell" colspan=4>&nbsp;</td>
  	</tr>
</table>
    <% if(memoryTypesFound){ %>
        <p>
	        <input type="submit" name="create" value="<bean:message bundle="InventoryResources" key="Backup.ShowMemoryTypes.Audit" />">
        </p>
    <% } %>

</form>
</center>
<%
  } catch (Exception sqle) {
%>
 <SCRIPT LANGUAGE="JavaScript">
	var fPtr = top.messageLine.document;
	fPtr.open();
    fPtr.write("<bean:message bundle="InventoryResources" key="Backup.ShowMemoryTypes.Error.query" />");
	fPtr.close();
</SCRIPT> 
<%
  } finally {
    if ( connection != null )
      connection.close();
  }
%>
</body>
</html>

