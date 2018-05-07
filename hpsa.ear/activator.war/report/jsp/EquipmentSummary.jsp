<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/report/jsp/bandwidthAccountingReportParams.jsp,v $--%>
<%-- $Revision: 1.11 $                                                                 --%>
<%-- $Date: 2011-02-18 05:35:50 $                                                     --%>
<%-- $Author: Anu D $                                                                   --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%@page import="com.hp.ov.activator.vpn.report.EquipmentSummaryReport"%>
<%@page contentType="text/html;charset=UTF-8"
	import="com.hp.ov.activator.mwfm.*,
                com.hp.ov.activator.mwfm.servlet.*,
                com.hp.ov.activator.vpn.inventory.*,
				java.sql.*,
                javax.sql.DataSource,
                java.util.*"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table"%>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn"%>
<%
    if (session == null || session.getAttribute(Constants.USER) == null) {
        response.sendRedirect(".../../jsp/sessionError.jsp");
        return;
    }

    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");

%>
<html>
<head>
<title>HP Service Activator</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link rel="stylesheet" type="text/css" href="/activator/css/saAudit.css">
<link rel="stylesheet" type="text/css"
	href="/activator/css/inventory.css">
<link rel="stylesheet" type="text/css"
	href="/activator/css/activator.css">
<link rel="stylesheet" type="text/css"
	href="/activator/css/saContextMenu.css">

<style test>
A:hover {font-weight;
	TEXT-DECORATION: underline;
}

.trigger {
	CURSOR: pointer;
	font-family: Verdana, Helvetica, Arial, Sans-serif;
	font-size: 8pt;
	color: black;
	padding: 1px, 3px;
}

.fcwidth {
	width: 150px;
	height: 20px;
}

.formCell {
	font-family: Verdana, Helvetica, Arial;
	font-size: 15px;
	font-weight: bold;
	color: blue;
	padding: 5px, 5px;
	width: 58%;
	height: 25;
}

.triggerB {
	CURSOR: pointer;
	font-family: Verdana, Helvetica, Arial, Sans-serif;
	font-size: 8pt;
	color: #336699;
	font-weight: bold;
	padding: 1px, 3px;
}

A:hover {
	color: blue;
}

.mainHeading1 {
	background: #336699;
	font-family: Verdana, Helvetica, Arial, Sans-serif;
	font-size: 9pt;
	line-height: 1.5;
	color: white;
	align: center;
	valign: middle;
	padding: 1px, 3px;
}
</style>
</head>
<body>
	<center>
		<br /> <br />
		<h2 class="mainSubHeading">
			<center>Provisioning Management System</center>
		</h2>
	</center>
	<%
	String row_class="tableEvenRow";
	Connection      con = null;
	DataSource      dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
	 try {con = (Connection) dataSource.getConnection();
	 
	 EquipmentSummaryReport rs_intance= new EquipmentSummaryReport(con);
	 
	  HashMap<String, String>  equipmentDetails = rs_intance.getEquipmentDetails();
	  
	%>
	
	<%
        String exportToExcel = request.getParameter("exportToExcel");
        if (exportToExcel != null
                && exportToExcel.toString().equalsIgnoreCase("YES")) {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "inline; filename="
                    + "EquipmentSummary.xls");
 
        }
     %>
	<table align="center" width="85%" cellpadding='0' border='1'
		style="overflow-y: scroll" cellspacing='0'>
		<tr align="center">
			<td colspan="16" class="mainHeading1" align="center"><b>Equipment Summary Report</b></td>
		</tr>
		<tr>
			<td align="center" class="mainHeading1">TYPE</td>
			<td align="center" class="mainHeading1">NO OF EQUIPMENTS</td>
		</tr>

		<%
		 Iterator it = equipmentDetails.entrySet().iterator();
	       while (it.hasNext()) {
	        Map.Entry entry_set = (Map.Entry)it.next();
	        String key = (String) entry_set.getKey();
	        String value = (String) entry_set.getValue();
     	 %>
		<tr class="<%=row_class%>">
			<td align="center" class="tablecell"><%=key%></td>
			<td align="center" class="tablecell"><%=value%></td>
		</tr>
		<%} %>
	</table>

	<table align="right" cellpadding='1' cellspacing='10' border='0'>
		<tr>
			<td class="mainHeading" align="left">
			<!--   <td width="50%"  class="mainHeading" align = "left">
						  <a  href="saveReport.jsp?reportType=BandwidthAccountingReport">
						  <center>Save</center></a>
					  </td> -->
					     <a href="EquipmentSummary.jsp?exportToExcel=YES" style="font-size: 10pt; font-family: Verdana, Helvetica, Arial, Sans-serif;"><b>Export to Excel</b></a>
				</td>
		</tr>
	</table>

	<%}catch (Exception e) {
        e.printStackTrace();
    } finally {
        con.close();
    } %>
</body>
</html>