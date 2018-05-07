<!---------------------------------------------------------------------------

###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

----------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,com.hp.ov.activator.cr.inventory.*,com.hp.ov.activator.cr.inventory.Region,
                java.sql.*, 
                javax.sql.DataSource,
                java.util.*, 
                java.text.*,
                java.net.*,
                java.io.*,
                 org.apache.log4j.Logger,
                 org.apache.log4j.BasicConfigurator"
         info="Display all router types." 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%!Logger logger = Logger.getLogger("BackupTest");
%>

<% /* JPM New */ %>
<%  SimpleDateFormat sdf_test = new SimpleDateFormat("hh:mm:ss");
    logger.debug(sdf_test.format(new java.util.Date()) + ": saRouterTabs.jsp....load");
%>
<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) == null) {
       response.sendRedirect ("sessionError.jsp");
       return;
    } 
	request.setCharacterEncoding("UTF-8");
%>

<%!
     //I18N strings
     final static String noRouters = "No routers available.";		
     final static String routers   = "Routers";
%>


<html>
<head>
<% /* JPM New */ %>
<base target="_top">
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
    <link rel="stylesheet" type="text/css" href="/activator/css/saTabs.css">
    
    <script language="JavaScript" src="../javascript/saNavigation.js"></script>        
	<script language="JavaScript" src="../javascript/table.js"></script>	
	<script language="JavaScript" src="../javascript/menu.js"></script>
	<script language="JavaScript" src="../../javascript/backup.js"></script>
  	<link rel="stylesheet" type="text/css" href="../css/spainTable.css">
  	
	<script>
	  function clearMessageLine() {      
    	var fPtr = top.messageLine.document;
		fPtr.open();
		fPtr.write("");
		fPtr.close();     
	  }
	</script>
</head>

<body>
<%   
  DataSource dataSource = (DataSource)session.getAttribute(Constants.DATASOURCE);
  Vector list = new Vector();
  Connection connection = null;
  PreparedStatement ps = null;
  ResultSet rs = null;
  try {

    WFManager wfm = (WFManager) session.getAttribute (Constants.MWFM_SESSION);

    connection = (Connection)dataSource.getConnection();
    Region[] regions = Region.findAll(connection);
    String roleClauseStart = "", roleClauseEnd = "";
      if (regions != null){
          roleClauseStart = " and location in(select name from cr_location where region in(";
          roleClauseEnd = ")) ";
        for (int i = 0; i < regions.length; i++){
            if( wfm.isInRole(regions[i].getName())){
                roleClauseStart +="'"+regions[i].getName()+"',";
            }
        }
          roleClauseStart = roleClauseStart.substring(0,roleClauseStart.length() - 1);
      }




      /*for debug purpurses*/
      String vendorsValid = "";
      logger.debug(sdf_test.format(new java.util.Date()) + ": saRouterTabs.jsp....checking equipment to be valid for roles");
      //ps = connection.prepareStatement("select distinct vendor from networkelement where backup ='1' and vendor is not null and state='Up' "+ roleClauseStart + roleClauseEnd);
     
      ps = connection.prepareStatement("select distinct vendor from cr_networkelement n, v_PERouter p, v_Cerouter c , v_switch s " +
																							"where ( (n.networkelementid= p.networkelementid and p.backup='1') or " +
																							"(n.networkelementid= c.networkelementid and c.backup='1') or " +
																							"(n.networkelementid= s.networkelementid and s.backup='1')) and  vendor  is not null and adminstate='Up' " 
																						  +roleClauseStart + roleClauseEnd);

      rs = ps.executeQuery();
      if (rs.next()){
          do{
            list.add(rs.getString(1));
            vendorsValid+=" "+rs.getString(1)+" ";
          }while (rs.next());
      }
	  if(vendorsValid.equals("")){
		  
		  ps = connection.prepareStatement("select distinct vendor from cr_networkelement n " +
																							"where n.networkelementid IN (select networkelementid from v_perouter where backup = '1') or " +
																							"n.networkelementid IN (select networkelementid from v_switch where backup = '1') and  vendor  is not null and adminstate='Up' " 
																							+roleClauseStart + roleClauseEnd);

		  rs = ps.executeQuery();
		  if (rs.next()){
			  do{
				list.add(rs.getString(1));
				vendorsValid+=" "+rs.getString(1)+" ";
			  }while (rs.next());
		  }
	  }
	  
       if (rs!=null){
          rs.close();
                   }
       if (ps != null){
           ps.close();
       }      


    logger.debug(sdf_test.format(new java.util.Date()) + ": saRouterTabs.jsp....checking equipment to be valid for roles....Done. Vendors selected: " + vendorsValid);


     	// JPM New. Comprobar list obtenida
	if (list.size() > 0) {
%>
<p>
  <table  cellpadding="0" cellspacing="0">
    <div>
      <tr align=center>
	    <td nowrap align=center class="frameHead"><%=routers%></td>
	  </tr>
    </div>   		    
    <table border=0 cellpadding="1" cellspacing="0" >
      <tr id="toprow">
<%
	  int numLogs=0;
	  String firstVendorTab = (String)session.getAttribute("firstVendorTab");
	  for (int i = 0; i < list.size(); i++) {
	    // Display tabs for all queues with jobs waiting
		numLogs=i;
		String vendorName = (String)list.elementAt(i);
 		if (firstVendorTab == null) {
%>                  

	    <td  id="tab<%=i%>" class=<%=numLogs==0 ? "tabSelected" : "tabUnSelected"%> nowrap
		     onMouseOver="highlightTab(this);"
		     onMouseOut="unHighlightTab(this);"
		     onClick="selectTab(this);clearMessageLine();window.parent.displayFrame.location='../backup/jsp/FindEquipmentList.jsp?reload=true&name=<%=(String)list.elementAt(i)%>'"
	    ><%=vendorName%></td>
	    <td width=1 bgcolor=#ffffff><img width=1 height=1 alt=""></td> 
<%
           session.setAttribute("firstVendorTab",(String)list.elementAt(0));
           firstVendorTab = (String)list.elementAt(0);
        }
        else 
          if (firstVendorTab.compareTo(vendorName) == 0){
 %>
 
  <td id="tab<%=i%>" class= "tabSelected"  nowrap
		     onMouseOver="highlightTab(this);"
		     onMouseOut="unHighlightTab(this);"
		     onClick="selectTab(this);clearMessageLine();window.parent.displayFrame.location='../backup/jsp/FindEquipmentList.jsp?reload=true&name=<%=(String)list.elementAt(i)%>'"
	    ><%=vendorName%></td>
	    <td width=1 bgcolor=#ffffff><img width=1 height=1 alt=""></td> 
<script>tabSelected = document.getElementById("tab<%=i%>");</script>
<%
} else {
%>
<td  id="tab<%=i%>" class= "tabUnSelected" nowrap
		     onMouseOver="highlightTab(this);"
		     onMouseOut="unHighlightTab(this);"
		     onClick="selectTab(this);clearMessageLine();window.parent.displayFrame.location='../backup/jsp/FindEquipmentList.jsp?reload=true&name=<%=(String)list.elementAt(i)%>'"
	    ><%=vendorName%></td>
	    <td width=1 bgcolor=#ffffff><img width=1 height=1 alt=""></td> 
<% 
}
	  }// end for list
%>
	  </tr> 
    </table>
    <table border=0 cellpadding=1 cellspacing=2 width="100%" class=bottomTab>
	  <tr>
	    <td class=bottomTab nowrap></td>
	  </tr>
    </table>		
  </table>
  <script>
	
//top.main.displayFrame.location = "../backup/jsp/FindEquipmentList.jsp?name=<%=firstVendorTab%>";
window.parent.displayFrame.location = "../backup/jsp/FindEquipmentList.jsp?name=<%=firstVendorTab%>";

</script>
  
<%
	// JPM New
	} // end if list


	else {
%>
<SCRIPT LANGUAGE="JavaScript">
  	var fPtr = this.document;
	fPtr.open();
  	fPtr.write("<center>No equipment has been found.</center>");
	fPtr.close();
</SCRIPT>
<%
	} logger.debug(sdf_test.format(new java.util.Date()) + ": saRouterTabs.jsp....the tabs for equipment were drawn");
  } catch (Exception e) { %>
  	
	<b>Error retrieving information.</b>
	
<% 
  } finally {  
  	  try{
        if (rs  != null)
            rs.close();
        if (ps != null)
            ps.close();
        if(connection != null)
            connection.close();
      }catch(Exception e){}
  }
 %>
</body>
</html>
