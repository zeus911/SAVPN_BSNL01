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
                java.net.*, 
                java.text.*" 
         info="Commig JSP for bean EquipmentConfiguration" 
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
<%
    //JPM New
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(com.hp.ov.activator.mwfm.servlet.Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    } 
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<html>
<head>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
 	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
</head>

<body>
<%	
	//<jsp:useBean id="menuBackupBean" scope="session" class="com.hp.ov.activator.vpn.backup.servlet.menuBackupBean" />
%>

<%
if (request.getParameter("all").equals("true")) {
   	String equipmentName = request.getParameter("equipmentname");
    String equipmentID = request.getParameter("equipmentid");

   	if(equipmentID == null || equipmentName == null || equipmentName.equals("")) {
%>
       <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
           alert("<bean:message bundle="InventoryResources" key="Backup.DeleteEquipmentConfig.alert.select" />");
       </script>
   
<%
   	} else {
		DataSource dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
   		Connection con = null;
        PreparedStatement pstmt = null;
   		try {
     		con = (Connection) dataSource.getConnection();
            pstmt = con.prepareStatement( "delete from v_backupref where eqid='"+equipmentID.trim()+"'" );
            pstmt.execute();
            com.hp.ov.activator.vpn.inventory.EquipmentConfigurationWrapper.delete (con, equipmentID.trim());
			com.hp.ov.activator.cr.inventory.NetworkElement ane = com.hp.ov.activator.cr.inventory.NetworkElement.findByNetworkelementid(con, equipmentID);        
	
	if (ane != null)
	  session.setAttribute("firstVendorTab",""+(String)ane.getVendor());
%>
			
			<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
  if (top.selectedMenu == parent.parent.frames['leftFrame'].document.getElementById("listTab")){					
	var fPtr = parent.parent.frames['messageLine'].document;					  
    fPtr.open();
    fPtr.write("<bean:message bundle="InventoryResources" key="Backup.DeleteEquipmentConfig.success" />");
    fPtr.close();
	parent.parent.frames['main'].location='../../jsp/saConfigFrame.jsp'				
  }
  
</script>
<%
		} catch (Exception e) {
               e.printStackTrace();
%>
			<SCRIPT LANGUAGE="JavaScript">
				var fPtr = top.messageLine.document;
		       	fPtr.open();
		       	fPtr.write("<bean:message bundle="InventoryResources" key="Backup.DeleteEquipmentConfig.Error" />");
		       	fPtr.close();
			</SCRIPT>	
<%
		}
		finally {
			try{
                if (con != null)
                    con.close();
                if(pstmt != null)
                    pstmt.close();
            }catch (Exception e) {}
   		}
   	}
} else {
	// Recoger el EquipmentName y el Timestamp
	/* JPM New. Substituido pues ahora se llama desde un JSP anterior de confirmacion */
   	//String equipmentName = menuBackupBean.getEquipmentName();
   	//String timestamp = menuBackupBean.getTimestamp();
   	String equipmentName = request.getParameter("equipmentname");
    String equipmentID = request.getParameter("equipmentid");
   	String equipmentType = request.getParameter("equipmentType");
   	String timestamp = request.getParameter("timestamp");
   	if(equipmentID == null || equipmentName == null || equipmentName.equals("")) {
%>
       <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
           alert("<bean:message bundle="InventoryResources" key="Backup.DeleteEquipmentConfig.alert.select" />");
       </script>
   
<%
   	} else {
		DataSource dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
	   	Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rset = null;
        java.util.Date TimeStamp;
   		try {
     			con = (Connection) dataSource.getConnection();
	     		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
               if ( timestamp != null && timestamp.length() > 3) {
	                ConfigLine ref = new ConfigLine();//BackupRef.findAll(con, "creationtime=to_date('"+timestamp + "','yyyy.mm.dd hh24:mi:ss') and eqname='"+equipmentName.trim()+"'");
                    pstmt = con.prepareStatement("select creationtime,createdby,configtime,eqid from v_backupref where creationtime=to_date('"+timestamp + "','yyyy.mm.dd hh24:mi:ss') and eqid='"+equipmentID.trim()+"'");
                    rset = pstmt.executeQuery();
                    if ( rset.next() ){
                        do{
                          ref. setConfigTime(rset.getTimestamp(3));
                          ref.setTimestamp(rset.getTimestamp(1));
                          ref.setCreatedBy(rset.getString(2));
                          ref.setEquipmentID(rset.getString(4));
                        }while (rset.next());
                    }
                if (ref != null){
	                BackupRef[] refs = BackupRef.findAll(con, "configtime=to_date('"+sdf.format(ref.getConfigTime()) + "','yyyy.mm.dd hh24:mi:ss') and eqid='"+equipmentID.trim()+"'");
                    if (refs!=null && refs.length==1){
			            pstmt = con.prepareStatement( "delete from v_backupref where creationtime=to_date('"+timestamp + "','yyyy.mm.dd hh24:mi:ss') and eqid='"+equipmentID.trim()+"'" );
                        pstmt.execute();
                        TimeStamp = sdf.parse(timestamp);
				        com.hp.ov.activator.vpn.inventory.EquipmentConfigurationWrapper.delete (con, equipmentID.trim(), ref.getConfigTime());
                }   else
                        if (refs != null && refs.length > 1){
			                pstmt = con.prepareStatement( "delete from v_backupref where creationtime=to_date('"+timestamp + "','yyyy.mm.dd hh24:mi:ss') and eqid='"+equipmentID.trim()+"'" );
                            pstmt.execute();
                        }
                }
               } else{
                   pstmt = con.prepareStatement( "delete from v_backupref where eqid='"+equipmentID.trim()+"'" );
                   pstmt.execute();
                   com.hp.ov.activator.vpn.inventory.EquipmentConfigurationWrapper.delete (con, equipmentID.trim());                  
               }
%>


<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">

/*The below condition was never working(checked in 3A n later and there was always javascript error
	during delete triggered from list config.So these conditions are being commented.
*/
	//if (top.selectedMenu.id == "listTab"){
	var fPtr = top.messageLine.document;
    fPtr.open();
    fPtr.write("<bean:message bundle="InventoryResources" key="Backup.DeleteEquipmentConfig.success" />");
    fPtr.close();
	if(top.frames.main.frames.length==0)
		top.main.location='FindEquipmentConfiguration.jsp'
	else
		top.frames.main.frames['displayFrame'].location='FindEquipmentList.jsp?expand<%=equipmentType%>&name=<%=equipmentType%>&reload=true'
 
</script>
<%
		} catch (Exception e) {     e.printStackTrace();
%>
	
			<SCRIPT LANGUAGE="JavaScript">
				var fPtr = top.messageLine.document;
		       	fPtr.open();
		       	fPtr.write("<bean:message bundle="InventoryResources" key="Backup.DeleteEquipmentConfig.Error" />");
		       	fPtr.close();
			</SCRIPT>			
			<%
		}
		finally {
            if ( pstmt != null )
				pstmt.close();
            if ( rset != null )
				rset.close();
       		try{
                   con.close();
               }catch (Exception e) {}
		}
   	}
} //fin else
%>
</table>
</body>
</html>
