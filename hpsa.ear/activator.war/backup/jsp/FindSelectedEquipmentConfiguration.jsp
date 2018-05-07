<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->

<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,
                java.sql.*, 
                java.util.*, 
                java.text.*,
                java.io.*" 
         info="Find Equipment List" 
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
    if (session == null || session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    }
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<head>
</script>
<% /* JPM New */ %>
	<script language="JavaScript" src="../../javascript/table.js"></script>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
  	<link rel="stylesheet" type="text/css" href="../../css/spainTable.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
</head>

<body>
	<h2 class="mainSubHeading"><center><bean:message bundle="InventoryResources" key="Backup.Find.title" /></center></h2>
<center>
<form name="form" method="GET" action="FindEquipmentConfiguration.jsp">
<table align="center" width=80% border=0 >

<%
//JPM New
  //<tr>
	//<td class="title" valign="top" align="left"><img src="../../images/ctl.gif" border=0></td>
	//<td colspan="2" class="title">find an equipment configuration</td>
	//<td class="title" valign="top" align="right" ><img src="../../images/ctr.gif" border=0></td>
  //</tr>
%>
  <tr>
	<td class="mainHeading" align="center" colspan=4><bean:message bundle="InventoryResources" key="Backup.Find.config" /></td>
  </tr>
  <tr>
	<td width="10%" class="mainHeading">&nbsp;</td>
	<td width="30%" class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.Find.Field" /></td>
	<td width="50%" class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.Find.Value" /></td>
	<td width="10%" class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.Find.Optional" /></td>
  </tr>

  <tr class="tableEvenRow">
    <td class="tableCell">&nbsp;</td>
    <td class="tableCell">&nbsp;<bean:message bundle="InventoryResources" key="Backup.Find.EquipmentName" /></td>
    <td class="tableCell"><input type="text" size="34" name="EquipmentName"></td>
    <td class="tableCell" align="center"><bean:message bundle="InventoryResources" key="Backup.Find.YES" /></td>
  </tr>
  <tr class="tableOddRow">
    <td class="tableCell">&nbsp;</td>
    <%//<td class="tableRowSelectSp">&nbsp;Timestamp &nbsp;&nbsp;(dd/mm/yyyy)</td>%>
    <td class="tableCell">&nbsp;<bean:message bundle="InventoryResources" key="Backup.Find.Timestamp" /> &nbsp;&nbsp;(yyyy.mm.dd)</td>
    <td class="tableCell"><bean:message bundle="InventoryResources" key="Backup.Find.from" />&nbsp;<input type="text" size="10" maxlength="10" name="TimeStampLow">&nbsp;<bean:message bundle="InventoryResources" key="Backup.Find.to" />&nbsp;<input type="text" size="10" name="TimeStampHigh"></td>
    <td class="tableCell" align="center"><bean:message bundle="InventoryResources" key="Backup.Find.YES" /></td>
  </tr>
  <tr class="tableEvenRow">
    <td class="tableCell">&nbsp;</td>
    <td class="tableCell">&nbsp;<bean:message bundle="InventoryResources" key="Backup.Find.Version" /></td>
    <td class="tableCell"><input type="text" size="34" name="Version"></td>
    <td class="tableCell" align="center"><bean:message bundle="InventoryResources" key="Backup.Find.YES" /></td>
  </tr>
  <!--tr class="tableOddRow">
    <td class="tableCell">&nbsp;</td>
    <td nowrap="" class="tableCell">&nbsp;Last Access Time &nbsp;&nbsp;(yyyy.mm.dd)</td>
    <td class="tableCell">from&nbsp;<input type="text" size="10" maxlength="10" name="LastAccessTimeLow">&nbsp;to&nbsp;<input type="text" size="10" name="LastAccessTimeHigh"></td>
    <td class="tableCell" align="center">yes</td>
  </tr-->
  <tr class="tableOddRow">
    <td class="tableCell">&nbsp;</td>
    <td class="tableCell">&nbsp;<bean:message bundle="InventoryResources" key="Backup.Find.RetrievalType" /></td>
    <td class="tableCell"><input type="text" size="34" name="RetrievalName"></td>
    <td class="tableCell" align="center"><bean:message bundle="InventoryResources" key="Backup.Find.YES" /></td>
  </tr>

   <tr class="tableEvenRow">
    <td class="tableCell">&nbsp;</td>
    <td class="tableCell">&nbsp;<bean:message bundle="InventoryResources" key="Backup.Find.MemoryType" /></td>
    <td class="tableCell"><input type="text" size="34" name="MemoryType"></td>
    <td class="tableCell" align="center"><bean:message bundle="InventoryResources" key="Backup.Find.YES" /></td>
  </tr>

  <tr class="tableOddRow">
  	<td width="5%" class="tableCell">&nbsp;</td>
  	<td width="90%" colspan="2" class="mainHeading"  align="center"><bean:message bundle="InventoryResources" key="Backup.Find.Options" /></td>
  	<td width="5%" class="tableCell">&nbsp;</td>
  </tr>
  <tr class="tableEvenRow">
    <td class="tableCell">&nbsp;</td>
    <td class="tableCell">&nbsp;<bean:message bundle="InventoryResources" key="Backup.Find.ExactSearch" />?</td>
    <td class="tableCell">
    	<input type="radio" name="exact" value="yes"><bean:message bundle="InventoryResources" key="Backup.Find.YES" />
      <input type="radio" name="exact" value="no" checked><bean:message bundle="InventoryResources" key="Backup.Find.NO" />
    </td>
    <td class="tableCell">&nbsp;</td>
  </tr>
  <tr class="tableOddRow">
    <td class="tableCell">&nbsp;</td>
    <td class="tableCell">&nbsp;<bean:message bundle="InventoryResources" key="Backup.Find.DisplayedNumber" /></td>
    <td class="tableCell"><input type="text" size="10" name="configsNR" value="100"></td>
    <td class="tableCell">&nbsp;</td>
  </tr>
  <tr>
    <td colspan=3>&nbsp;</td>
  </tr>

<%
  // JPM New
  //<tr>
	//<td class="list0" valign="bottom" align="left"><img src="../../images/cbl.gif" border=0></td>
	//<td class="list0" colspan="2">&nbsp;</td>
	//<td class="list0" valign="bottom" align="right"><img src="../../images/cbr.gif" border=0></td>
  //</tr>
%>

</table>

<p>
<%
//JPM New
//<a href="javascript:form.submit();"><img src="../../images/arrow_submit.gif" border="0" align="center" alt="send"></a>
%>
	<input type="submit" name="search" value="<bean:message bundle="InventoryResources" key="Backup.Find.button.Search" />">
</p>
</center>
</form>
</body>
</html>

