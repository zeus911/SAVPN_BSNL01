<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,
		  com.hp.ov.activator.vpn.backup.servlet.*,
                 java.net.*" 
         info="Track a Job ID" 
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
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(Constants.USER) == null) {
       response.sendRedirect ("./../jsp/sessionError.jsp");
       return;
    }
	response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>


<% /* JPM New. Activate Bean */%>
<jsp:useBean id="menuBackupBean" scope="session" class="com.hp.ov.activator.vpn.backup.servlet.menuBackupBean" />

<%
// Obtener el tipo de registro que va a ser borrado
String deleteType = request.getParameter("deleteClass");
String schedulingName = null;
String retrievalName = null;
String equipmentType = null;
String equipmentID = null;
String equipmentName = null;
String timestamp = null;
String deleteAll = "false";
String deleteText = "";

if(deleteType.equalsIgnoreCase("SCHEDULING")) {
	schedulingName = menuBackupBean.getSchedulingPolicy();
	deleteText = "Scheduling";
} else if(deleteType.equalsIgnoreCase("RETRIEVAL")) {	
	retrievalName = menuBackupBean.getRetrievalPolicy();
	deleteText = "Retrieval";
} else if(deleteType.equalsIgnoreCase("EQUIPMENT")) {	
	equipmentID = menuBackupBean.getEquipmentID();
    equipmentName = menuBackupBean.getEquipmentName();
	timestamp = menuBackupBean.getTimestamp();
	System.out.println("TimeStamp get from menuBean"+timestamp);
	equipmentType = request.getParameter("equipmentType");
	if(timestamp == null || timestamp.length() <= 0)
		timestamp = "";
	deleteAll = request.getParameter("all");
	deleteText = "Equipment";
} else if(deleteType.equalsIgnoreCase("EQUIPMENTNAME")) {	
	equipmentID = menuBackupBean.getEquipmentID();
    equipmentName = menuBackupBean.getEquipmentName();
	deleteAll = request.getParameter("all");
	deleteText = "Equipment Configs";
}
%>

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
   if(deleteType.equalsIgnoreCase("SCHEDULING")) {
   	if (schedulingName == null || schedulingName.equals(""))
   	{
%>
       	<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
           	alert("<bean:message bundle="InventoryResources" key="Backup.DeleteObject.selectpolicy" />");
       	</script>
<%
   	}  else  {
%>
             <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
                 if (confirm("<bean:message bundle="InventoryResources" key="Backup.DeleteObject.confirm.scheduling" /> <%= schedulingName.replaceAll("&#37;", "%") %>" )) {
    			var page = "DeleteSchedulingPolicy.jsp?schedulingpolicyname=<%= URLEncoder.encode(schedulingName, "UTF-8")%>";
      			self.location.href = page;
                 }
                 else {
                     var fPtr = top.messageLine.document;
                     fPtr.open();
                     fPtr.write("<bean:message bundle="InventoryResources" key="Backup.DeleteObject.cancelled" />");
                     fPtr.close();
					// top.main.location='../../jsp/saConfigFrame.jsp';						 
					 top.main.location='../../backup/jsp/FindSchedulingPolicy.jsp';
                 }
                     
             </script>
<%
   	}
} else if(deleteType.equalsIgnoreCase("RETRIEVAL")) {
   	if (retrievalName == null || retrievalName.equals(""))
   	{
%>
       	<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
           	alert("<bean:message bundle="InventoryResources" key="Backup.DeleteObject.selectretrieval" />");
       	</script>
<%
   	}  else  {
%>
             <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
                 if (confirm("<bean:message bundle="InventoryResources" key="Backup.DeleteObject.confirm.retrieval" /> <%= retrievalName %>" )) {
    			var page = "DeleteRetrievalPolicy.jsp?retrievalpolicyname= + <%= retrievalName%>";
      			self.location.href = page;
                 }
                 else {
                     var fPtr = parent.parent.frames['messageLine'].document;
                     fPtr.open();
                     fPtr.write("<bean:message bundle="InventoryResources" key="Backup.DeleteObject.cancelled" />");
                     fPtr.close();
					 top.main.location='../../jsp/saConfigFrame.jsp';						  
                 }
                  
             </script>
<%
   	}
} else if(deleteType.equalsIgnoreCase("EQUIPMENT")) {
   	if ((equipmentName == null || equipmentName.equals("")) && deleteAll.equalsIgnoreCase("FALSE"))
   	{
%>
       	<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
           	alert("<bean:message bundle="InventoryResources" key="Backup.DeleteObject.selectequipment" />");
       	</script>
<%
   	}  else  {
%>
             <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
                 if (confirm("<bean:message bundle="InventoryResources" key="Backup.DeleteObject.confirm.equipment" /> <%= equipmentName %>, <%= timestamp%>" )) {
    			var page = "DeleteEquipmentConfiguration.jsp?equipmentid=<%= equipmentID%>&equipmentname=<%= equipmentName%>&equipmentType=<%= equipmentType%>&timestamp=<%= timestamp%>&all=<%=deleteAll%>";
      			self.location.href = page;
                 }
                 else {
                     var fPtr = parent.parent.frames['messageLine'].document;
                     fPtr.open();
                     fPtr.write("<bean:message bundle="InventoryResources" key="Backup.DeleteObject.cancelled" />");
                     fPtr.close();
					 top.main.location='../../jsp/saConfigFrame.jsp';	
                 }
                     
             </script>
<%
   	}
} else if(deleteType.equalsIgnoreCase("EQUIPMENTNAME")) {
%>
	<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
       	if (confirm("<bean:message bundle="InventoryResources" key="Backup.DeleteObject.confirm.removeequipmentfrom" /> <%= equipmentName %>" )) {
    			var page = "DeleteEquipmentConfiguration.jsp?equipmentid=<%= equipmentID%>&equipmentname=<%= equipmentName%>&all=<%=deleteAll%>";
      			self.location.href = page;
		}
		else {
			var fPtr = parent.parent.frames['messageLine'].document;
                    fPtr.open();
                    fPtr.write("<bean:message bundle="InventoryResources" key="Backup.DeleteObject.cancelled" />");
                    fPtr.close();
					top.main.location='../../jsp/saConfigFrame.jsp';	
		}                    
             </script>
<%
}
%>
</body>
</html>
