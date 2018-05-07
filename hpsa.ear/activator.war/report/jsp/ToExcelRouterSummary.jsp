<%@page import="com.hp.ov.activator.vpn.report.RouterSummaryReport"%>
<%@page contentType="text/html;charset=UTF-8"
	import="com.hp.ov.activator.mwfm.*,
                com.hp.ov.activator.mwfm.servlet.*,
                com.hp.ov.activator.vpn.inventory.*,
				com.hp.ov.activator.cr.inventory.NetworkElement,
				com.hp.ov.activator.cr.inventory.Region,com.hp.ov.activator.cr.inventory.Location,
                java.sql.*, com.hp.ov.activator.inventory.SAVPN.SwitchConstants,
                javax.sql.DataSource,
                java.util.*"%>
<html>
<head>

<%
if (session == null || session.getAttribute(Constants.USER) == null) {
    response.sendRedirect(".../../jsp/sessionError.jsp");
    return;
}
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
        + "RouterSummary.xls");

%>
</head>
<body>

<%

DataSource      dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
Connection      con = null;





try {
    con = (Connection) dataSource.getConnection();

    RouterSummaryReport rs_intance= new RouterSummaryReport(con);
	 
	  LinkedHashMap<String,HashMap<String,String>>  nE_intdetails = rs_intance.getRouter_interfacedetails();
  


%>
	<table align="center" width="85%" cellpadding='0' border='1'
		style="overflow-y: scroll" cellspacing='0'>
		<tr align="center">
			<td colspan="14" class="mainHeading1" align="center"><b>Equipment
					level interface summary report for PE routers</b></td>
		</tr>
		<tr>
			<td align="center" rowspan="2" class="mainHeading1">PERouter
				Name</td>
			<td align="center" rowspan="2" class="mainHeading1">Location</td>
			<td align="center" rowspan="2" class="mainHeading1">Vendor</td>
			<td align="center" rowspan="2" class="mainHeading1">Model</td>

			<td align="center" colspan="2" class="mainHeading1">E1</td>
			<td align="center" colspan="2" class="mainHeading1">GigabitEthernet</td>
			<td align="center" colspan="2" class="mainHeading1">FastEthernet</td>
			<td align="center" colspan="2" class="mainHeading1">Pos</td>
			<td align="center" colspan="2" class="mainHeading1">TenGigabitEthernet</td>
			<!-- <td align="center" rowspan="1" colspan="6" class="mainHeading1">Available(Maximum)</td> -->
			<!-- <td align="center" rowspan="2" class="mainHeading1">Total Used</td>
			<td align="center" rowspan="2" class="mainHeading1">Total Available</td> -->
		</tr>
		<tr>

			<td align="center" class="mainHeading1">Used</td>
			<td align="center" class="mainHeading1">Free</td>
			<td align="center" class="mainHeading1">Used</td>
			<td align="center" class="mainHeading1">Free</td>
			<td align="center" class="mainHeading1">Used</td>
			<td align="center" class="mainHeading1">Free</td>
			<td align="center" class="mainHeading1">Used</td>
			<td align="center" class="mainHeading1">Free</td>
			<td align="center" class="mainHeading1">Used</td>
			<td align="center" class="mainHeading1">Free</td>
		</tr>

		<%
		 Iterator it = nE_intdetails.entrySet().iterator();
							
							
							
			 while (it.hasNext()) {	    	 
	        Map.Entry entry_set = (Map.Entry)it.next();	  
	        
	      //  System.out.print("Count.."+count);
	       
	      
	      HashMap<String,String> Pe_inter_detail= (HashMap)entry_set.getValue();
	        String router_name= Pe_inter_detail.get("Router_name");
	        String location=Pe_inter_detail.get("Location");
	        String vendor=Pe_inter_detail.get("Vendor");
	        String model=Pe_inter_detail.get("Model");
	        
	        String total_Used_Inter_count=Pe_inter_detail.get("total_Used_Inter_count");
	        String total_Free_Inter_count=Pe_inter_detail.get("total_Free_Inter_count");
	        
	        String free_Serial_Inter_count=Pe_inter_detail.get("free_Serial_Inter_count");
	        String free_Fast_Inter_count=Pe_inter_detail.get("free_Fast_Inter_count");	        
	        String free_Giga_inter_count=Pe_inter_detail.get("free_Giga_inter_count");
	        String free_Pos_Inter_count=Pe_inter_detail.get("free_Pos_Inter_count");
	        
	        String Used_Giga_inter_count=Pe_inter_detail.get("Used_Giga_inter_count");
	        String Used_Fast_Inter_count=Pe_inter_detail.get("Used_Fast_Inter_count");
	        String Used_Serial_Inter_count=Pe_inter_detail.get("Used_Serial_Inter_count");
	        String Used_Pos_Inter_count=Pe_inter_detail.get("Used_Pos_Inter_count");
	        
	        String free_TenGig_Inter_count=Pe_inter_detail.get("free_TenGig_Inter_count");
	        String Used_TenGig_Inter_count=Pe_inter_detail.get("Used_TenGig_Inter_count");
	        
	        // E1 count
	         String free_E1_Inter_count=Pe_inter_detail.get("free_E1_Inter_count");
	        String Used_E1_Inter_count=Pe_inter_detail.get("Used_E1_Inter_count");
	        
	        if(free_E1_Inter_count==null){
	        	free_E1_Inter_count="0";	        	
	        }
	        if(Used_E1_Inter_count==null){
	        	Used_E1_Inter_count="0";	        	
	        }
	        
	        
	        int Other_free_interfaces=0;
	        int Other_USed_interfaces=0;
	        
	        if(free_TenGig_Inter_count==null){
	        	free_TenGig_Inter_count="0";	        	
	        }
	        if(Used_TenGig_Inter_count==null){
	        	Used_TenGig_Inter_count="0";	        	
	        }
	        
	        if(total_Used_Inter_count==null){
	        	total_Used_Inter_count="0";
	        	
	        }
	        if(total_Free_Inter_count==null){
	        	total_Free_Inter_count="0";	        	
	        }
	        if(free_Serial_Inter_count==null){
	        	free_Serial_Inter_count="0";	        	
	        }
	        if(free_Fast_Inter_count==null ){
	        	free_Fast_Inter_count="0";	        	
	        }
	        if(free_Pos_Inter_count==null ){
	        	free_Pos_Inter_count="0";	        	
	        }
	        if(free_Giga_inter_count==null ){
	        	free_Giga_inter_count="0";	        	
	        }
	        if(Used_Serial_Inter_count==null){
	        	Used_Serial_Inter_count="0";	        	
	        }
	        if(Used_Fast_Inter_count==null ){
	        	Used_Fast_Inter_count="0";	        	
	        }
	        if(Used_Pos_Inter_count==null ){
	        	Used_Pos_Inter_count="0";	        	
	        }
	        if(Used_Giga_inter_count==null ){
	        	Used_Giga_inter_count="0";	        	
	        }
	        
	        try {
	       //  Other_free_interfaces=Integer.parseInt(total_Free_Inter_count) -(Integer.parseInt(free_Serial_Inter_count)+Integer.parseInt(free_Giga_inter_count)+Integer.parseInt(free_Fast_Inter_count)+Integer.parseInt(free_Pos_Inter_count));
	         //Other_USed_interfaces=Integer.parseInt(total_Used_Inter_count) -(Integer.parseInt(Used_Giga_inter_count)+Integer.parseInt(Used_Fast_Inter_count)+Integer.parseInt(Used_Serial_Inter_count)+Integer.parseInt(Used_Pos_Inter_count));
	        }catch(Exception e){
	        	
	        	//System.out.println("Exception in Router summary"+e);
	        	
	        }
	        
	        %>
		<tr>
			<td align="left" class="tablecell"><%=router_name%></td>
			<td align="left" class="tablecell"><%=location%></td>
			<td align="left" class="tablecell"><%=vendor %></td>
			<td align="left" class="tablecell"><%=model%></td>
			<td align="center" class="tablecell"><%=Used_E1_Inter_count %></td>
			<td align="center" class="tablecell"><%=free_E1_Inter_count %></td>
			<td align="center" class="tablecell"><%= Used_Giga_inter_count%></td>
			<td align="center" class="tablecell"><%= free_Giga_inter_count%></td>
			<td align="center" class="tablecell"><%=Used_Fast_Inter_count %></td>
			<td align="center" class="tablecell"><%=free_Fast_Inter_count %></td>
			<td align="center" class="tablecell"><%=Used_Pos_Inter_count %></td>
			<td align="center" class="tablecell"><%=free_Pos_Inter_count%></td>
			<td align="center" class="tablecell"><%=Used_TenGig_Inter_count %></td>
			<td align="center" class="tablecell"><%=free_TenGig_Inter_count %></td>


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