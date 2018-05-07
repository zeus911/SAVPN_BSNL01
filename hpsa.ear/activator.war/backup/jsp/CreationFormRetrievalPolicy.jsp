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
         info="Creation Equipment Configuration" 
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
    if (session == null || session.getValue (com.hp.ov.activator.mwfm.servlet.Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    } 
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<%
	String NONE_METHOD = "NONE";
%>

<html>
<% /* JPM New */ %>
<head>
	<script language="JavaScript" src="../../javascript/table.js"></script>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
	<link rel="stylesheet" type="text/css" href="../../css/spainTable.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
</head>

<%
	/* JPM New */
    	// don't cache the page
	response.setDateHeader("Expires", 0);
    	response.setHeader("Pragma", "no-cache");
%>

<body>
	<h2 class="mainSubHeading"><center><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.title" /></center></h2>
<%
    DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE); 
   Connection con = null;
   com.hp.ov.activator.vpn.backup.RetrievalMethod[] retrieval = null;
   try
   {
	con = (Connection)dataSource.getConnection();  
    retrieval = com.hp.ov.activator.vpn.backup.RetrievalMethod.findAll(con);
   }
   catch (Exception e)
   {
		%>
		<B><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.Error.query" /></B>: <%= e.getMessage () %>.
		<%
        return;
   }
   finally
   {
       if (con != null)
	    con.close();
   }
%>
<center>
<table border=0 width=75% cellpadding=0>

<form name="form" method="GET" action="CreationCommitRetrievalPolicy.jsp">
  <tr>
	<td class="mainHeading" align="center" colspan=4><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.CreateNew" /></td>
  </tr>

<%
  //JPM New
  //<tr>
	//<td class="title" valign="top" align="left"><img src="../../images/ctl.gif" border=0></td>
	//<td colspan="2" class="title">create new retrieval policy</td>
	//<td class="title" valign="top" align="right" ><img src="../../images/ctr.gif" border=0></td>
  //</tr>
%>

   <tr>
    	<td  class="mainHeading">&nbsp;</td>
    	<td  class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.Field" /></td>   	
    	<td  class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.Value" /></td>   	
    	<td  class="mainHeading">&nbsp;</td>
   </tr>

  <tr class="tableOddRow">
	<td width="10%" class="tableCell">&nbsp;</td>
    	<td width="50%" class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.PolicyName" /></b></td>
    	<td width="30%" class="tableCell"><input type="text" class="tableCell" name="retrievalpolicyname"  size="20"></td>
	<td width="10%" class="tableCell">&nbsp;</td>
  </tr>

  <tr class="tableEvenRow">
    <td class="tableCell">&nbsp;</td>
    <td class="tableCell"><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.FirstRetrieval" /></td>
    <td class="tableCell">
    <select class="tableCell" name="firstmethod">
	<%
  		for (int i=0; retrieval != null && i < retrieval.length; i++)
  		{
			if (!retrieval[i].getRetrievalname().equals(NONE_METHOD))
			{
				%>
    		    <option value="<%= retrieval[i].getRetrievalname() %>"><%= retrieval[i].getRetrievalname().toLowerCase() %></option>
				<%
			}
	    }
	%>
    </select>
    <td class="tableCell">&nbsp;</td>
  </tr>

  <tr class="tableOddRow">
    <td class="tableCell">&nbsp;</td>
    <td nowrap=""  class="tableCell"><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.SecondRetrieval" /></td>
    <td class="tableCell">
    <select class="tableCell"  name="secondmethod">
	<%
  		for (int i=0; retrieval != null && i < retrieval.length; i++)
  		{
	%>
        <option value="<%= retrieval[i].getRetrievalname() %>"><%= retrieval[i].getRetrievalname().toLowerCase() %></option>
	<%
	    }
	%>
    </select>
    <td class="tableCell">&nbsp;</td>
  </tr>

  <tr class="tableEvenRow">
    <td class="tableCell">&nbsp;</td>
    <td class="tableCell"><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.ThirdRetrieval" /></td>
    <td class="tableCell">
    <select class="tableCell" name="thirdmethod">
	<%
  		for (int i=0; retrieval != null && i < retrieval.length; i++)
  		{
	%>
        <option value="<%= retrieval[i].getRetrievalname() %>"><%= retrieval[i].getRetrievalname().toLowerCase() %></option>
	<%
	    }
	%>
    </select>
    <td class="tableCell">&nbsp;</td>
  </tr>

  <tr class="tableOddRow">
  	<td class="tableCell" colspan="4">&nbsp;</td>
  </tr>
</table>

<%
//JPM New
//<p align=right>
//<a href="javascript:form.submit();"><img src="../../images/arrow_submit.gif" border="0" align="center" alt="send"></a></p>
%>
<p>
	<input type="submit" name="create" value="<bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.Create" />">
</p>	
</form>
</body>

</html>