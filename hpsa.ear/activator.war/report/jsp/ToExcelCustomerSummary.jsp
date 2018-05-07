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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%
if (session == null || session.getAttribute(Constants.USER) == null) {
    response.sendRedirect(".../../jsp/sessionError.jsp");
    return;
}
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
        + "CustomerSummary.xls");

%>
</head>
<body>

<%

DataSource      dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
Connection      con = null;





try {
    con = (Connection) dataSource.getConnection();

    CustomerSummaryReport cs_instance= new CustomerSummaryReport(con);
     HashMap<String,ArrayList>  customer_details =cs_instance.getCustomer_Details();
  


%>
	<table align="center" width=70% cellpadding='0' border='1'>
				<tr>
					<td align="center" rowspan="2" class="mainHeading1">CustomerId</td>
					<td align="center" rowspan="2" class="mainHeading1">CompanyName</td>
					<td align="center" rowspan="1" colspan="6" class="mainHeading1">No
						Of VPNs/Sites</td>
					<td align="center" rowspan="2" class="mainHeading1">Total VPNs</td>
					<td align="center" rowspan="2" class="mainHeading1">Total
						Sites</td>
				</tr>
				<tr>
					<td align="center" class="mainHeading1">L3 VPN</td>
					<td align="center" class="mainHeading1">L3 VPN Site</td>
					<td align="center" class="mainHeading1">L2 VPN</td>
					<td align="center" class="mainHeading1">L2 VPN Site</td>
					<td align="center" class="mainHeading1">L2 VPWS</td>
					<td align="center" class="mainHeading1">L2 VPWS Site</td>
				</tr>
				<%
 	Iterator it = customer_details.entrySet().iterator();
	 while(it.hasNext()){ 
		 /*   for(count = startIndex; count < increment; count++) 
			  { */
			    
	 Map.Entry entry_set = (Map.Entry)it.next();	 
	 
	 ArrayList details = (ArrayList) entry_set.getValue();
	 
	// ArrayList  details= customer_details.get(customer_ids.get(count));
 
	 String customer_id =(String)entry_set.getKey();
	
	//String customer_id=customer_ids.get(count);
	 
	 String Customer_name=(String) details.get(0);
	 int  Count_l3Site = (Integer) details.get(1);
	 int  Count_l2site = (Integer)details.get(2);
	 int  Count_VPWSSite = (Integer)details.get(3);	 
	 int  Count_l3VPN =(Integer) details.get(4);
	 int  Count_l2VPN = (Integer)details.get(5);
	 int  Count_l2VPWS = (Integer)details.get(6);
	 
     int total_vpns=Count_l3VPN+Count_l2VPN+Count_l2VPWS;
     int total_sites=Count_l3Site+Count_l2site+Count_VPWSSite;
 
 %>
				<tr>
					<td align="center" ><a href="#"
						style="color: #336699; cursor: hand; text-decoration: none;"
						onclick="ShowVpndetail('<%=customer_id%>')"><%=customer_id%></a></td>
					<td align="left" ><%=Customer_name%></td>
					<td align="center" ><%=Count_l3VPN%></td>
					<td align="center" class="tablecell"><%=Count_l3Site%></td>
					<td align="center"><%=Count_l2VPN%></td>
					<td align="center" class="tablecell"><%=Count_l2site%></td>
					<td align="center" ><%=Count_l2VPWS%></td>					
					<td align="center" class="tablecell"><%=Count_VPWSSite%></td>
					<td align="center" class="tablecell"><%=total_vpns%></td>
					<td align="center" class="tablecell"><%=total_sites%></td>

				</tr>
				<%} %>
			</table>
			
		<%     }catch (Exception e) {
      //  e.printStackTrace();
%>
		<B>Error qyerying: <%= e.getMessage () %></B>
		<%
    } finally {
        con.close();
    }
%>
</body>
</html>