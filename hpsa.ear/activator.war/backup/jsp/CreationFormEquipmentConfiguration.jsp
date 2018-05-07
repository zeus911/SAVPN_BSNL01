<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->

<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,com.hp.ov.activator.cr.inventory.Region,com.hp.ov.activator.cr.inventory.*,
                java.sql.*, 
                javax.sql.DataSource,
                java.net.*, 
				java.util.Vector,
                java.text.*,
                 java.util.Hashtable,
                 java.util.Enumeration"
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
    if (session == null || session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) == null) {
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

<%
	/* JPM New */
    	// don't cache the page
	response.setDateHeader("Expires", 0);
    	response.setHeader("Pragma", "no-cache");
%>

<%
	String RETRIEVAL_METHOD = "MANUAL";
%>

<body>
	<h2 class="mainSubHeading"><center><bean:message bundle="InventoryResources" key="Backup.Insert.title" /></center></h2>
<%
   DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);
   WFManager wfm = (WFManager) session.getAttribute (Constants.MWFM_SESSION);
   Connection connection = null;
   PreparedStatement pstmt = null;
   ResultSet rset = null;
   String now = null;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
   String sUsername = (String) session.getAttribute(com.hp.ov.activator.mwfm.servlet.Constants.USER);
   Hashtable routers = new Hashtable();

   try
   {
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
/*pstmt = connection.prepareStatement("select networkelementid, name, schpolicyname from networkelement where backup='1' and vendor is not null "+roleClauseStart + roleClauseEnd+" order by name asc");
*/
         String sqlString = "select distinct n.networkelementid, name from cr_networkelement n, v_PERouter p, v_Cerouter c , v_switch s " +
         										"where ( (n.networkelementid= p.networkelementid and p.backup='1') or " +
         										"(n.networkelementid= c.networkelementid and c.backup='1') or (n.networkelementid= s.networkelementid and s.backup='1')) " +
         										"and vendor is not null " + roleClauseStart + roleClauseEnd+" order by name asc";

					pstmt = connection.prepareStatement(sqlString);		

        rset = pstmt.executeQuery();
        if(rset.next()){
            do{
                com.hp.ov.activator.cr.inventory.NetworkElement router = new com.hp.ov.activator.cr.inventory.NetworkElement();
                router.setNetworkelementid(rset.getString(1));
                router.setName(rset.getString(2));
                //router.setSchpolicyname(rset.getString(3));
                routers.put(router.getNetworkelementid(),router);                

            } while(rset.next());
        }
                   if (rset!=null){
                       rset.close();
                   }
                   if (pstmt != null){
                       pstmt.close();
                   }

       now = sdf.format(new java.util.Date());
	   
   if(routers ==null || routers.isEmpty() ){	 
	   
			sqlString = "select distinct n.networkelementid, n.name from cr_networkelement n " +
																							"where n.networkelementid IN (select networkelementid from v_perouter where backup = '1') or " +
																							"n.networkelementid IN (select networkelementid from v_switch where backup = '1') " +
         										"and n.vendor is not null " + roleClauseStart + roleClauseEnd+" order by name asc";
			pstmt = connection.prepareStatement(sqlString);
		rset = pstmt.executeQuery();
        if(rset.next()){
            do{
                com.hp.ov.activator.cr.inventory.NetworkElement router = new com.hp.ov.activator.cr.inventory.NetworkElement();
                router.setNetworkelementid(rset.getString(1));
                router.setName(rset.getString(2));
                //router.setSchpolicyname(rset.getString(3));
                routers.put(router.getNetworkelementid(),router);                

            } while(rset.next());
        }
                   if (rset!=null){
                       rset.close();
                   }
                   if (pstmt != null){
                       pstmt.close();
                   }

       now = sdf.format(new java.util.Date());
   }
if (routers != null && !routers.isEmpty()) {
try{
%>

<center>
<table align="center" width="80%" cellpadding=0>

<form  name="form" method="POST" action="CreationCommitEquipmentConfiguration.jsp">
  <tr>
	<td class="mainHeading" align="center" colspan="4"><bean:message bundle="InventoryResources" key="Backup.Insert.New" /></td>
  </tr>

  <tr class="tableEvenRow" >
  	<td width="10%" class="tableCell" >&nbsp;</td>
  	<td width="30%" class="tableCell" ><b><bean:message bundle="InventoryResources" key="Backup.Insert.EquipmentName" /></b></td>
    	<td width="50%" class="tableCell">
    	<select class="tableCell" name="equipmentID">
<%
    if (routers!= null) {
        Enumeration enum1 = routers.elements();

    while (enum1.hasMoreElements()){
        com.hp.ov.activator.cr.inventory.NetworkElement temp = (com.hp.ov.activator.cr.inventory.NetworkElement)enum1.nextElement();
%>
       <option value="<%=temp.getNetworkelementid()%>"><%= temp.getName() %></option>
	<%
    }

    }
	%>
    	</select>
    	</td>
  	<td width="10%" class="tableCell" align="center">&nbsp;</td>
  </tr>
  <tr class="tableOddRow">
  	<td class="tableCell" align="center">&nbsp;</td>
  	<td class="tableCell" ><b><bean:message bundle="InventoryResources" key="Backup.Insert.TimeStamp" /></b></td>
    	<td class="tableCell"><%= now %><input type="hidden" name="timestamp" value="<%= now %>"></td>
  	<td class="tableCell" align="center">&nbsp;</td>
  </tr>
  <tr class="tableEvenRow">
  	<td class="tableCell" align="center">&nbsp;</td>
  	<td class="tableCell" ><b><bean:message bundle="InventoryResources" key="Backup.Insert.CreatedBy" /></b></td>
    	<td class="tableCell"><%= sUsername %><input type="hidden" name="createdBy" value="<%= sUsername %>"></td>
  	<td class="tableCell" align="center">&nbsp;</td>
  </tr>
  <tr class="tableOddRow">
  	<td class="tableCell" align="center">&nbsp;</td>
  	<td class="tableCell" ><b><bean:message bundle="InventoryResources" key="Backup.Insert.RetrievalName" /></b></td>
    	<td class="tableCell"><%= RETRIEVAL_METHOD.toLowerCase() %><input type="hidden" name="retrievalName" value="<%= RETRIEVAL_METHOD %>"></td>
  	<td class="tableCell" align="center">&nbsp;</td>
  </tr>
  <tr class="tableEvenRow">
  	<td colspan="4" class="mainHeading"  align="center"><bean:message bundle="InventoryResources" key="Backup.Insert.Data" /></td>
  </tr>
  <tr class="tableOddRow">
    <td colspan="4" align="center" class="tableCell"><textarea wrap=off rows=30 cols="80%"  name="data" ></textarea></td>
  </tr>
  <tr class="tableOddRow">
  	<td colspan="4" class="tableCell"  align="center">&nbsp;</td>
  </tr>
  <tr>
    <td height="10" colspan="4" align="right"></td>
  </tr>
</table>


	<input type="submit" name="create" value="<bean:message bundle="InventoryResources" key="Backup.Insert.Create" />">
</form>
<%
}
catch (Exception e)
{
	e.printStackTrace();%>
			<SCRIPT LANGUAGE="JavaScript">
				var fPtr = parent.frames['messageLine'].document;
		       	fPtr.open();
		       	fPtr.write("<bean:message bundle="InventoryResources" key="Backup.Insert.Error.query" />");
		       	fPtr.close();
			</SCRIPT>	
	<%
} 
}
       else{%>
		<SCRIPT LANGUAGE="JavaScript">
			var fPtr = parent.frames['main'].document;
		       fPtr.open();
		       fPtr.write("<center>"+"<bean:message bundle="InventoryResources" key="Backup.Insert.Error.NoEquipFound" />"+"</center>");
		       fPtr.close();
		</SCRIPT>	       
	<%       }
}
   catch (Exception e)
   {
		%>
			<SCRIPT LANGUAGE="JavaScript">
				var fPtr = parent.frames['messageLine'].document;
		       	fPtr.open();
		       	fPtr.write("<bean:message bundle="InventoryResources" key="Backup.Insert.Error.query" />");
		       	fPtr.close();
			</SCRIPT>	
		<%
        return;
   }
   finally
   {
        connection.close();
   }
%>
</body>

</html>
