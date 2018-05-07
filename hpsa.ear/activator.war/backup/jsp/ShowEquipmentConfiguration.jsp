<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,com.hp.ov.activator.cr.inventory.*,
                java.sql.*, 
                javax.sql.DataSource,
                java.util.*, 
                java.text.*,
                java.net.*" 
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
<center>
	<h2 class="mainSubHeading"><center><bean:message bundle="InventoryResources" key="Backup.Show.restore" /></h2>
</center>
	<jsp:useBean id="menuBackupBean" scope="session" class="com.hp.ov.activator.vpn.backup.servlet.menuBackupBean" />
<%
   String equipmentID = menuBackupBean.getEquipmentID();
     String equipmentName = menuBackupBean.getEquipmentName();
   String timestamp = menuBackupBean.getTimestamp();
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");       
   String sUrl=request.getParameter("url2");
   String networkElementID = request.getParameter("networkElementId");
%>

<table align="center" width="80%" border=0 cellpadding=0>
	<tr>
		<td class="mainHeading" align="center" colspan=4><bean:message bundle="InventoryResources" key="Backup.Show.from" /> (<%= equipmentName %>)</td>
  	</tr>
	<tr class="tableOddRow">
		<td width="10%" class="tableCell">&nbsp;</td>
  		<td width="30%" class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.Show.EquipmentName" /></b></td>
		<td width="50%" class="tableCell"><%= equipmentName %>
    		<td width="10%" class="tableCell">&nbsp;</td>
	</tr>
	<tr class="tableEvenRow">
		<td class="tableCell">&nbsp;</td>
  		<td class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.List.TimeStamp" /></b></td>
  		<%
  		if(timestamp != null && timestamp.length() > 3) {
  		%>
			<td class="tableCell"><%=timestamp%>
		<% } else { %>
    			<td class="tableCell">&nbsp;</td>
    		<% } %>
    		<td class="tableCell">&nbsp;</td>
	</tr>
  	<tr class="tableEvenRow">
    		<td class="tableCell">&nbsp;</td>
    		<td class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.Show.Save" /></b></td>
    		<td class="tableCell">&nbsp;<a href="DownloadEquipmentConfiguration.jsp?equipmentID=<%=equipmentID%>&equipmentName=<%= equipmentName %>&timestamp=<%= timestamp %>"><img border=0 src="../images/save.gif" ></a></td>
    		<td class="tableCell">&nbsp;</td>
  	</tr>
	  <tr class="tableOddRow">
	  	<td width="90%" colspan="4" class="mainHeading"  align="center"><bean:message bundle="InventoryResources" key="Backup.Show.Data" /></td>
	  </tr>
<%
   DataSource dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
   Connection connection = null;
   PreparedStatement ps = null;
   ResultSet rs = null;
   WFManager wfm = (WFManager) session.getAttribute (Constants.MWFM_SESSION);
   try {
     connection = (Connection) dataSource.getConnection();
	 EquipmentConfigurationWrapper ec = null;
   	if(timestamp != null && timestamp.length() > 0) {
            java.sql.Timestamp TimeStamp=null;
            java.util.Date formattedTime = null;
            ps = connection.prepareStatement("select configtime from v_backupref where creationtime=to_date('"+timestamp+"','yyyy.mm.dd hh24:mi:ss') and eqid='"+equipmentID+"'") ;
            rs = ps.executeQuery();
            while (rs.next()){
                TimeStamp = rs.getTimestamp(1);
            }
            if (TimeStamp != null){
                formattedTime = sdf.parse(TimeStamp.toString());
            }
     		ec = EquipmentConfigurationWrapper.findByPrimaryKeys (connection, equipmentID, formattedTime);
     	} else {
     		ec = EquipmentConfigurationWrapper.findByPrimaryKey (connection, equipmentID);
     	}
     	
%>
<%
String data = "";
if (ec!=null && ec.getData() != null) data = new String(ec.getData());
%>

  <tr class="tableOddRow">
    <td colspan="4" align="center" class="tableCell">
    	<textarea readonly wrap=off rows=20 cols="80%"  name="data" ><%=data%></textarea>
    </td>
  </tr>

  <tr class="tableEvenRow">
    <td align="right" colspan="4">&nbsp;</td>
  </tr>
</table>

<form name="form" target="messageLine"  method="POST" action="SendEquipmentConfiguration.jsp">
<table align="center" width="80%" border=0 cellpadding=0>
	<tr>
		<td class="mainHeading" align="center" colspan=4><bean:message bundle="InventoryResources" key="Backup.Show.Send" /></td>
  	</tr>
	<tr class="tableOddRow">		
		<input type="hidden" name="equipment" value="<%= java.net.URLEncoder.encode(equipmentName, "UTF-8") %>">
        <input type="hidden" name="equipmentID" value="<%= java.net.URLEncoder.encode(equipmentID, "UTF-8") %>">
		<%
   		if(ec!=null && timestamp != null && timestamp.length() > 0) { %>
			<input type="hidden" name="rowid" value="<%= java.net.URLEncoder.encode(ec.getUniqueIdentifier(),"UTF-8") %>">
		<%
		}
		%>
  	</tr>
  	<tr class="tableEvenRow">
		<td width="10%" class="tableCell">&nbsp;</td>
		<td width="30%" class="tableCell" ><b><bean:message bundle="InventoryResources" key="Backup.Show.TargetEquipment" /></b></td>
		<td width="50%" class="tableCell" >
		<select class="tableCell" name="networkElementId" onchange="document.location='ShowEquipmentConfiguration.jsp?networkElementId='+this.value">
		<%

			com.hp.ov.activator.cr.inventory.NetworkElement equipo = com.hp.ov.activator.cr.inventory.NetworkElement.findByNetworkelementid(connection, equipmentID);
			
			//change for VPN5.1
			//NetworkElement[] aBeans = NetworkElement.findByElementtype(connection, equipo.getElementtype(), " backup='1' ");
			com.hp.ov.activator.cr.inventory.NetworkElement[] aBeans = com.hp.ov.activator.cr.inventory.NetworkElement.findByElementtype(connection, equipo.getElementtype());
			for (int ii=0; ii < aBeans.length; ii++) {
           boolean backup=false;
           
           String role = aBeans[ii].getRole();
    			 if (role!= null && role.equalsIgnoreCase("PE"))
    				{
    				PERouter peBean = PERouter.findByPrimaryKey(connection, aBeans[ii].getNetworkelementid());
    				if ( peBean != null  && peBean.getBackup())
    		  		backup = true;
          	}	
          	
          
    			if ((role!= null && role.equalsIgnoreCase("CE")))
    			{	
    			CERouter ceBean = CERouter.findByPrimaryKey(connection, aBeans[ii].getNetworkelementid());
    			if (ceBean != null  && ceBean.getBackup())
          			backup = true;
          }
          		
    			if ((role!= null && (role.equalsIgnoreCase("AggregationSwitch") || role.equalsIgnoreCase("AccessSwitch")) ))
    			{	
    					Switch sBean = Switch.findByPrimaryKey(connection, aBeans[ii].getNetworkelementid());
    			   if (sBean != null  && sBean.getBackup())
          			backup = true;
          }
           
           
            if(com.hp.ov.activator.cr.inventory.Network.findByNetworkid(connection, aBeans[ii].getNetworkid())!=null && wfm.isInRole(com.hp.ov.activator.cr.inventory.Network.findByNetworkid(connection, aBeans[ii].getNetworkid()).getRegion()) && backup){
	  			    String sId = aBeans[ii].getNetworkelementid();
                    String sName = aBeans[ii].getName();
                    if(networkElementID == null) networkElementID = sId;
		%>
	  			        <option value="<%=sId %>"<%= sId.equals(networkElementID)? " selected" : "" %>><%= sName %></option>
		<%
                }
            }
		%>
		</select>
        </td>
		<td width="10%" class="tableCell">&nbsp;</td>
  	</tr>
  	<tr class="tableOddRow">
		<td class="tableCell" align="left">&nbsp;</td>
		<td class="tableCell" align="left"><b><bean:message bundle="InventoryResources" key="Backup.Show.TargetMemory" /></b></td>
		<td class="tableCell" align="left">
         <% request.setAttribute("restore","true");%>
         <%@ include file="GetMemoryTypes.jsp" %>


        </td>
    	<td class="list0" align="left">&nbsp;</td>
  	</tr>
  	<tr class="tableEvenRow">
  		<td class="tableCell" align="left" colspan="4">&nbsp;</td>
  	</tr>

</table>
	<p align="center"><input type="submit" name="send" value="<bean:message bundle="InventoryResources" key="Backup.Show.SendConfig" />"></p>
</form>
<%

   }
   catch (Exception e)
   {
	   	e.printStackTrace();
		%>
<SCRIPT LANGUAGE="JavaScript">
	var fPtr = top.messageLine.document;
	fPtr.open();
    fPtr.write("<bean:message bundle="InventoryResources" key="Backup.Show.Error.query" />");
	fPtr.close();
</SCRIPT> 
		<%
   }
   finally
   {
       if (rs != null)
        rs.close();
       if (ps != null)
        ps.close();
       if (connection != null)
     	connection.close();
   }
%>

</body>
</html>

