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
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/report/jsp/CustomerSummary.jsp,v $--%>
<%-- $Revision: 1.11 $                                                                 --%>
<%-- $Date: 2011-02-18 05:35:50 $                                                     --%>
<%-- $Author: Anu D $                                                                   --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%@page contentType="text/html;charset=UTF-8"
	import="com.hp.ov.activator.mwfm.*,
                com.hp.ov.activator.mwfm.servlet.*,
               com.hp.ov.activator.vpn.inventory.*,             
               com.hp.ov.activator.vpn.report.CustomerSummaryReport,
				com.hp.ov.activator.cr.inventory.NetworkElement,
				com.hp.ov.activator.cr.inventory.Region,com.hp.ov.activator.cr.inventory.Location,
                java.sql.*, com.hp.ov.activator.inventory.SAVPN.SwitchConstants,
                javax.sql.DataSource,
                java.text.SimpleDateFormat,
                java.text.DateFormat,
                java.util.Date,
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

<%
    
    DataSource      dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
    Connection      con = null;
    String row_class="tableEvenRow";
  

    try {
        con = (Connection) dataSource.getConnection();
    
       
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
	font-size: 8pt;
	line-height: 1.5;
	color: white;
	align: center;
	valign: middle;
	padding: 1px, 3px;
}

.mainHeading1 {
	background: #336699;
	font-family: Verdana, Helvetica, Arial, Sans-serif;
	font-size: 8pt;
	line-height: 1.5;
	color: white;
	align: center;
	valign: middle;
	padding: 1px, 3px;
}
</style>
</head>
<body>
	<%
String customer_id = request.getParameter("customerid");

CustomerSummaryReport cs_instance= new CustomerSummaryReport(con);
ArrayList  vpn_details =cs_instance.getCustomer_VPNList(customer_id);

ArrayList  site_details =cs_instance.getCustomer_SiteList(customer_id);
%>
	<div align="right">
		<table width=100%>
			<tr>
				<td align="center" width="97%" class="mainHeading1">
					<center>VPN/Site Summary</center>
				</td>
				<td style="width: 3%" class="mainHeading1"><a
					href="javascript:hidediv();"><img id="closeIcon"
						src="/activator/images/delete.gif" border="0" align="right"
						title="Close"></a></td>
			</tr>
		</table>
	</div>
	<br />
	<table width=100%>
		<tr align="center">
			<td><b>CustomerId</b> : <%=customer_id %></td>
		</tr>
	</table>
	<br />
	<table align="center" width=75% cellpadding='0' border='1'>
		<tr>
			<td align="center" class="mainHeading1">Vpn-Id</td>
			<td align="center" class="mainHeading1">Vpn-Name</td>
			<td align="center" class="mainHeading1">Submission-Date</td>
			<td align="center" class="mainHeading1">Vpn-Topology</td>
			<td align="center" class="mainHeading1">NoOfSites</td>
		</tr>
		<%
          for(int i=0;i<vpn_details.size();i++){ 	   
    	   String vpnid=vpn_details.get(i).toString().split("~")[0];
    	   String vpnname=vpn_details.get(i).toString().split("~")[1];
    	   String initiationdate=vpn_details.get(i).toString().split("~")[2];
    	   String topology=vpn_details.get(i).toString().split("~")[3];
    	   String sitecount= vpn_details.get(i).toString().split("~")[4];
    	    
       %>
		<tr class="<%=row_class%>">
			<td align="center" class="tablecell"><%=vpnid%></td>
			<td align="center" class="tablecell"><%=vpnname%></td>
			<td align="center" class="tablecell"><%=initiationdate%></td>
			<td align="center" class="tablecell"><%=topology%></td>
			<td align="center" class="tablecell"><%=sitecount%></td>
		</tr>

		<% } %>
	</table>
	<br>
	<table align="center" width=75% cellpadding='0' border='1'>
		<tr>
			<td align="center" class="mainHeading1">Site-Id</td>
			<td align="center" class="mainHeading1">Site-Name</td>
			<td align="center" class="mainHeading1">Submission-Date</td>
			<td align="center" class="mainHeading1">Site-Connectivity</td>
			<td align="center" class="mainHeading1">Rate-Limit</td>
			<td align="center" class="mainHeading1">Region</td>
			<td align="center" class="mainHeading1">Location</td>
			<td align="center" class="mainHeading1">Protocol</td>
		</tr>
		<%
        //serviceid+"~"+name+"~"+initation_date+"~"+region+"~"+location+"~"+connectivity+"~"+protocol+"~"+CAR);
        
        
        for(int i=0;i<site_details.size();i++){ 
        	
        	
       	 String Siteid=site_details.get(i).toString().split("~")[0];
     	 String Sitename=site_details.get(i).toString().split("~")[1];
          String initiationdate=site_details.get(i).toString().split("~")[2];
      	  String region=site_details.get(i).toString().split("~")[3];
      	  String location= site_details.get(i).toString().split("~")[4];
      	 String connectivity= site_details.get(i).toString().split("~")[5];
      	 String protocol= site_details.get(i).toString().split("~")[6];
      	 String car= site_details.get(i).toString().split("~")[7];
        	
        %>

		<tr class="<%=row_class%>">
			<td align="center" class="tablecell"><%=Siteid%></td>
			<td align="center" class="tablecell"><%=Sitename%></td>
			<td align="center" class="tablecell"><%=initiationdate%></td>
			<td align="center" class="tablecell"><%=connectivity%></td>
			<td align="center" class="tablecell"><%=car%></td>
			<td align="center" class="tablecell"><%=region%></td>
			<td align="center" class="tablecell"><%=location%></td>
			<td align="center" class="tablecell"><%=protocol%></td>
		</tr>
		<%} %>
	</table>

	<%     }catch (Exception e) {
       // e.printStackTrace();
%>
	<B>Error qyerying: <%= e.getMessage () %></B>
	<%
    } finally {
        con.close();
    }
%>


</body>
</html>


</body>
</html>