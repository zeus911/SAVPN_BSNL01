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

<html>
<% /* JPM New */ %>
<head>
	<script language="JavaScript" src="../../javascript/table.js"></script>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
	<link rel="stylesheet" type="text/css" href="../../css/spainTable.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
</head>
<body>
<center>
	<h2 class="mainSubHeading"><bean:message bundle="InventoryResources" key="Backup.UpdateCommitRetrievalPolicy.title" /></h2>

<%! Object obj; %>

<%
	String NONE_METHOD = "NONE";
%>


<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.backup.RetrievalPolicy" />
<jsp:setProperty name="bean" property="retrievalpolicyname"/>

<% /* JPM New */ %>
<jsp:useBean id="menuBackupBean" scope="session" class="com.hp.ov.activator.vpn.backup.servlet.menuBackupBean" />
<% String retrievalName = menuBackupBean.getRetrievalPolicy();
   DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);    
   Connection con = null;
   com.hp.ov.activator.vpn.backup.RetrievalMethod[] retrieval = null;
   try {
	 con = (Connection)dataSource.getConnection();  
	 //bean = (com.hp.ov.activator.vpn.backup.RetrievalPolicy) com.hp.ov.activator.vpn.backup.RetrievalPolicy.findByPrimaryKey (con, bean.getRetrievalpolicyname());
	 bean = (com.hp.ov.activator.vpn.backup.RetrievalPolicy) com.hp.ov.activator.vpn.backup.RetrievalPolicy.findByPrimaryKey (con, retrievalName);
	 retrieval = com.hp.ov.activator.vpn.backup.RetrievalMethod.findAll(con);
	 if (bean == null) { %>No such RetrievalPolicy. <%} else { %>

<form name="form" method="POST" action="UpdateCommitRetrievalPolicy.jsp">
<table align="center" width=70% border=0 cellpadding=0 cellspacing=0>
	<tr>
		<td class="mainHeading" align="center" colspan=3><bean:message bundle="InventoryResources" key="Backup.UpdateCommitRetrievalPolicy.title" /></td>
	</tr>
	<tr class="tableOddRow">
		<td colspan="3" class="tableCell">&nbsp;</td>
	</tr>
  	<tr class="tableEvenRow">
    		<td class="tableCell">&nbsp;</td>
    		<td class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.Insert.RetrievalName" /></b></td>
 		<td class="tableCell"><%= bean.getRetrievalpolicyname() %>
			<input type="hidden" name="retrievalpolicyname" value="<%= bean.getRetrievalpolicyname() %>"></td>
  	</tr>
  	<tr class="tableOddRow">
    		<td class="tableCell">&nbsp;</td>
	    	<td class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.FirstRetrieval" /></b></td>
		<td class="tableCell">
    			<select name="firstmethod">
			<%
  			for (int i=0; retrieval != null && i < retrieval.length; i++) {
				// The method that was in the data base is shown as "selected"
				if (retrieval[i].getRetrievalname().equals(bean.getFirstmethod())) {
			%>
    		    			<option selected value="<%= retrieval[i].getRetrievalname() %>"><%= retrieval[i].getRetrievalname().toLowerCase() %></option>
			<%
				}
				// The rest is shown except for the NONE method that is prohibited in the first method
				else if (!retrieval[i].getRetrievalname().equals(NONE_METHOD)) {
			%>
    		    			<option value="<%= retrieval[i].getRetrievalname() %>"><%= retrieval[i].getRetrievalname().toLowerCase() %></option>
			<%
				}
	    		}
			%>
    			</select>
  	</tr>
  	<tr class="tableEvenRow">
    		<td class="tableCell">&nbsp;</td>
    		<td class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.SecondRetrieval" /></b></td>
    		<td class="tableCell">
    		<select name="secondmethod">
		<%
  		for (int i=0; retrieval != null && i < retrieval.length; i++) {
			if ( retrieval[i].getRetrievalname().equals(bean.getSecondmethod()) )	{
		%>
    		    		<option selected value="<%= retrieval[i].getRetrievalname() %>"><%= retrieval[i].getRetrievalname().toLowerCase() %></option>
		<%
			} else {
		%>
    		    		<option value="<%= retrieval[i].getRetrievalname() %>"><%= retrieval[i].getRetrievalname().toLowerCase() %></option>
		<%
			}
	    }
	%>
    		</select>
  	</tr>
	<tr class="tableOddRow">
    		<td class="tableCell">&nbsp;</td>
		<td class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.ThirdRetrieval" /></b></td>
    		<td class="tableCell">
    		<select name="thirdmethod">
	<%
  		for (int i=0; retrieval != null && i < retrieval.length; i++)	{
			if ( retrieval[i].getRetrievalname().equals(bean.getThirdmethod()) )	{
	%>
    		    		<option selected value="<%= retrieval[i].getRetrievalname() %>"><%= retrieval[i].getRetrievalname().toLowerCase() %></option>
	<%
			} else {
	%>
    		    		<option value="<%= retrieval[i].getRetrievalname() %>"><%= retrieval[i].getRetrievalname().toLowerCase() %></option>
	<%
			}
	    	}
	%>
    		</select>
  	</tr>
	<tr class="tableEvenRow">
		<td colspan="3" class="tableCell">&nbsp;</td>
	</tr>
</table>
	<p>
	<input type="submit" name="update" value="<bean:message bundle="InventoryResources" key="update.submit.button" />">
	</p>
</form>
<%
 } //else
	} catch (Exception e) { %>
	   <b><bean:message bundle="InventoryResources" key="Backup.UpdateRetrievalPolicy.Error" /></b> <%= e.getMessage() %>
<% } finally {
     if (con != null)
	  con.close();
   }
 %>

</center>
</body>
</html>