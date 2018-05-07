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
                java.util.*, 
                java.text.*,
                java.net.*,
                java.io.*,
                 com.hp.ov.activator.vpn.backup.servlet.menuBackupBean"
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
    if (session == null || session.getAttribute(com.hp.ov.activator.mwfm.servlet.Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    } 
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

 <% /* JPM New. Activate Bean */%>
<jsp:useBean id="menuBackupBean" scope="session" class="com.hp.ov.activator.vpn.backup.servlet.menuBackupBean" />

<html>
<head>
<% /* JPM New */ %>
	<script language="JavaScript" src="../../javascript/table.js"></script>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
</head>

<body>
<%
	// Recoger el nombre del equipo seleccionado
	String equipmentID = menuBackupBean.getEquipmentID();
	
	if(equipmentID == null || equipmentID.length() <= 0) {
	%>
       	<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
           	alert("<bean:message bundle="InventoryResources" key="Backup.AuditLastEquipmentConfiguration.select" />");
       	</script>
	<%
	} else {
  		DataSource dataSource = (DataSource) session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.DATASOURCE);
  		Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Timestamp maxTime = null;

  		try {
			con = (Connection) dataSource.getConnection();		

    			//EquipmentConfiguration[] aeqc = EquipmentConfiguration.findByAttributes(con, equipmentID,n,n,n,n,n,n,n,n,b, "TimeStamp", "true");

              ps = con.prepareStatement("select max(creationtime) from v_backupref where eqid=?");
              ps.setString(1,equipmentID);
              rs = ps.executeQuery();
              if(rs.next()){
                do{
                    maxTime = rs.getTimestamp(1);
                }while(rs.next());
              }

			if(maxTime == null) {
			%>
				<SCRIPT LANGUAGE="JavaScript">
					var fPtr = top.frames['messageLine'].document;
				    fPtr.open();
       				fPtr.write("<bean:message bundle="InventoryResources" key="Backup.AuditLastEquipmentConfiguration.NotFound" /> <%= menuBackupBean.getEquipmentName()%>");
			       	fPtr.close();
				</SCRIPT>
			<%
			} else {
  				SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
				String lastTime = sdf.format(maxTime);
				
				menuBackupBean.setTimestamp(lastTime);
				// invocar a la ventana de Audit				
				%>
				<script>
					parent.frames['displayFrame'].location='ShowMemoryTypesForAudit.jsp'				
				</script>
			<%
			} // end if aeqc
  		} catch (Exception e) { %>
  			<b><bean:message bundle="InventoryResources" key="Backup.AuditLastEquipmentConfiguration.Error.retrieveinfo" /> </b> <%= e.getMessage() %>
		<% 
  		} finally {
              if(ps != null)
                ps.close();
              if(rs!=null)
                rs.close();
  			  con.close();
  		}
	} // end if equipmentName
%>
</body>
</html>