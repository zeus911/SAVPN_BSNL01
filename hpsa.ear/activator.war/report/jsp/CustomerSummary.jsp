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
<%! int numPages = 0; %>
<%
int count=0;
int startIndex=0;
int increment=0;
    DataSource      dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
    Connection      con = null;
  

    String link1 = "'CustomerSummary.jsp?";
    String link2 = "&regionSelected=' + form.region.value ";
    String link3 = "'&locationSelected=' + form.location.value ";
  

    try {
        con = (Connection) dataSource.getConnection();
    
        CustomerSummaryReport cs_instance= new CustomerSummaryReport(con);
         HashMap<String,ArrayList>  customer_details =cs_instance.getCustomer_Details();
      //for pagination
      
    /*   ArrayList<String> customer_ids= new ArrayList<String>();
	  for(String customer_id: customer_details.keySet())
	  {
		  customer_ids.add(customer_id);
		  
	  } */
	  
    /* 	int numRows = customer_details.size();
    	String startIndexString = request.getParameter("startIndex");
    	if((startIndexString == null)||(startIndexString.length()==0)) 
    	 { //for pagination if page is loaded first time
    	startIndexString = "0";
    	 }else{
    		 startIndex= Integer.parseInt(startIndexString);
    	 }
    	
    	//System.out.println("Router Summary startindex>>>>"+startIndexString);
    	//System.out.println("Router Summary no of records>>>>"+request.getParameter("txtnumrec"));
    	
    	int numRecordsPerPage =1;
    	if (request.getParameter("txtnumrec")==null)
    		numRecordsPerPage = 1;
    		else
    		numRecordsPerPage = Integer.parseInt(request.getParameter("txtnumrec"));
    	
    	numPages = numRows /numRecordsPerPage ; 
    	int remain = numRows % numRecordsPerPage ;
    	if(remain != 0) numPages = numPages +1 ;
      //  int NextIndexString =numRecordsPerPage+1;
        int startpoint =0;
        // 
        String temp="";
        for(int inum=1;inum<=numPages;inum++)
    {
     
    temp=temp+"<a href=\"CustomerSummary.jsp?startIndex="+startpoint+"&txtnumrec="+numRecordsPerPage+"\" >"+inum+"</a> ";																																							
    startpoint = startpoint + numRecordsPerPage;
    }
     
        
        if((startIndex + numRecordsPerPage) <= numRows) 
        {
          
        increment = startIndex + numRecordsPerPage ;
       
        }
        else
        {
         
        if (remain == 0)
        {
        	
        	//System.out.println("Router Summary increment 2>>>>"+increment);
        increment = startIndex + numRecordsPerPage ;
        }else{
        	
        	
        increment = startIndex + remain;
        }//end of inner if
        } */
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
</style>
</head>
<script>
function ShowVpndetail(customerid)
{
    var xmlHttp;
    try
    {
        xmlHttp=new XMLHttpRequest();
    }
    catch (e)
    {
        try
        {
            xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch (e)
        {
            try
            {
                xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
            }
            catch (e)
            {
                alert("Your browser does not support AJAX!" +e);
                return false;
            }
        }
    }
                     
    var url="VpnSiteSummary.jsp?customerid="+customerid;

    xmlHttp.onreadystatechange=function()
    {
        if(xmlHttp.readyState==4)
        {
            var str=xmlHttp.responseText;

            var respval=str.split("<body>")[1].split("</body>")[0];
            //alert(respval);
            document.getElementById("Vpndetail").innerHTML=respval;
            document.getElementById("Vpndetail").style.display="block";         
         
        }
    }
    xmlHttp.open("GET",url,true);
    xmlHttp.send(null);
}

function hidediv()
{
	//alert('hide');
	  document.getElementById("Vpndetail").style.display="none";
}


	
</script>
<body>
	<form name="form" action="" method="POST">
		<center>
			<br />
			<br />
			<h2 class="mainSubHeading">
				<center>Provisioning Management System</center>
			</h2>
		</center>

		<% 
    String row_class="tableEvenRow";
    String operator =(String)session.getAttribute(Constants.USER); 
     
    Date date = new Date();
    DateFormat formatter = new SimpleDateFormat("yyyy MM dd HH:mm:ss");   
    
    %>

	<%-- 	<%
        String exportToExcel = request.getParameter("exportToExcel");
        if (exportToExcel != null
                && exportToExcel.toString().equalsIgnoreCase("YES")) {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "inline; filename="
                    + "CustomerSummary.xls");
 
        }
    %> --%>


		<table align="center" width=75% border=0 cellpadding=0>
			<tr>
				<td
					style="font-size: 8pt; font-family: Verdana, Helvetica, Arial, Sans-serif;"
					align="left"><b>Description</b>: Summary Report</td>
			</tr>
			<tr>
				<td
					style="font-size: 8pt; font-family: Verdana, Helvetica, Arial, Sans-serif;"
					align="left"><b>Operator </b> : <%=operator%></td>
			</tr>
			<tr>
				<td
					style="font-size: 8pt; font-family: Verdana, Helvetica, Arial, Sans-serif;"
					align="left"><b>Date </b> : <%=formatter.format( date ) %></td>
			</tr>
			<%-- <tr>  
 <td style=" font-size: 7pt;" align="left">Search By: &nbsp;</td>
  <td style=" font-size: 7pt;" align="left"><B>Customer id</B>       
                <select  
                        name="customer_id"
                        onChange="window.location = <%= link1 + link2 %>;">
               <%
                      for(int i=0;i<customer_list.size();i++)
                      {
                %>
        		 <option><%=customer_list.get(i) %></option>
         <% } %>
                </select>
         
        </td>
 </tr> --%>
		</table>
		<br /> <br />
		<div style="z-index: 1">
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
				<tr class="<%=row_class%>">
					<td align="center" class="tablecell"><a href="#"
						style="color: #336699; cursor: hand; text-decoration: none;"
					onclick="ShowVpndetail('<%=customer_id%>')"><%=customer_id%></a></td>
					<td align="left" class="tablecell"><%=Customer_name%></td>
					<td align="center" class="tablecell"><%=Count_l3VPN%></td>
					<td align="center" class="tablecell"><%=Count_l3Site%></td>
					<td align="center" class="tablecell"><%=Count_l2VPN%></td>
					<td align="center" class="tablecell"><%=Count_l2site%></td>
					<td align="center" class="tablecell"><%=Count_l2VPWS%></td>										
					<td align="center" class="tablecell"><%=Count_VPWSSite%></td>
					<td align="center" class="tablecell"><%=total_vpns%></td>
					<td align="center" class="tablecell"><%=total_sites%></td>

				</tr>
				<%} %>
			</table>


			<%-- <table width="16%" align ="right" border="0">
     
   <tr>
      <td align="left" width="50%"  style=" font-family: Verdana, Helvetica, Arial, Sans-serif;
                   font-size: 9pt;">
        <%if(startIndex != 0) {%> 
      <a href="CustomerSummary.jsp?startIndex=<%=startIndex-numRecordsPerPage%>&txtnumrec=<%=numRecordsPerPage%>"><b>Previous</b></a> 
      
       <%}%></td>
    <td width="40%" scope="col" >Page:<%=temp%></td>
    <td align="left" width="50%" style=" font-family: Verdana, Helvetica, Arial, Sans-serif;
                   font-size: 9pt;">  
        <%if(startIndex + numRecordsPerPage < numRows){%> 
        <a href="CustomerSummary.jsp?startIndex=<%=startIndex+numRecordsPerPage %>&txtnumrec=<%=numRecordsPerPage%>"><b>Next</b></a> 
      
        <%}%>
       
      </td>
      </tr>
    </table>
	<br/><br/> --%>
		</div>

		<div id="Vpndetail" align="center"
			style="left: 12%; top:20%; margin-left: 0px; margin-top: 0px; overflow: auto; z-index: 5; background-color: #D3D3D3; width: 80%; height: 80%; display: none; position: absolute;">

		</div>


		<br />
		<br />
		<table align="right" style="left: 10%" cellpadding='1'
			cellspacing='10' border='0'>
			<tr>
				<!--   <td style=" font-family: Verdana, Helvetica, Arial, Sans-serif;
                   font-size: 9pt;color:white;background: #336699;">
						  <a  href="#" onclick="javascript:window.print();" style="text-decoration:none;color:white" >Print</a>
					  </td> -->
				<td class="mainHeading" align="left">
				
      
   <a href="ToExcelCustomerSummary.jsp?" style="font-size: 10pt; font-family: Verdana, Helvetica, Arial, Sans-serif;"><b>Export to
						Excel</b></a> 
				</td>
			</tr>
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

	</form>
</body>
</html>
