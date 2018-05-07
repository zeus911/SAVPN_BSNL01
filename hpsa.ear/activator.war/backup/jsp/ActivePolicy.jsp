<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.inventory.*,
                java.sql.*, 
				javax.sql.DataSource,
                java.net.*, 
                java.text.*" 
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
    if (session == null || session.getValue (com.hp.ov.activator.mwfm.servlet.Constants.USER) == null) {
       response.sendRedirect ("./../jsp/sessionError.jsp");
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
	<link rel="shortcut icon"  href="../../images/servact.ico">
</head>

<% /* JPM New. Activate Bean */%>
<jsp:useBean id="menuBackupBean" scope="session" class="com.hp.ov.activator.vpn.backup.servlet.menuBackupBean" />
<%
	String SchedulingName = null;
	String RetrievalName  = null;
	
	// Recoger el tipo de activacion
	String type = (String)request.getParameter("activeClass");
	if(type != null && type.equals("scheduling")) {
		SchedulingName = menuBackupBean.getSchedulingPolicy();
	} 
	if(type != null && type.equals("retrieval")) {
		RetrievalName  = menuBackupBean.getRetrievalPolicy();
	} 
	
	//Recoger si es una activacion o desactivacion
	String active = (String)request.getParameter("active");
	if(active == null || active.equals("null")) {
		active = "true";
	}
	
	String DEFAULT = "Default";
%>
<body>

<%
   DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);   
   Connection con = null;
   try {
     //con = (Connection) dbp.getConnection();
	 con = (Connection)dataSource.getConnection();  
	 ActivePolicies[] aps = ActivePolicies.findAll(con);
	 

     ActivePolicies   ap  = aps[0];
	 
	 
	 String prevSchedulingName = ap.getSchedulingpolicyname();
	 NetworkElement[] equip = NetworkElement.findAll(con, "schpolicyname='"+prevSchedulingName + "'"/*+"' or schedulingpolicyname='Default'"*/);
     if (SchedulingName != null && equip != null) {
     		 if(active.equals("true")) {
		 	ap.setSchedulingpolicyname(SchedulingName);
	 	 	ap.update (con);			
			for (int k = 0; k < equip.length; k++){
				equip[k].setSchpolicyname(SchedulingName);
				equip[k].update(con); 				
			}
	 	 } else {
		 	ap.setSchedulingpolicyname(DEFAULT);
	 	 	ap.update (con);
			for (int k = 0; k < equip.length; k++){
				equip[k].setSchpolicyname(DEFAULT);
				equip[k].update(con);
			}
	 	 }
	 } else if (equip == null){
	 	NetworkElement[] equip_none = NetworkElement.findAll(con);
     	if(active.equals("true")) {
		 	ap.setSchedulingpolicyname(SchedulingName);
	 	 	ap.update (con);			

	 	 } else {
		 	ap.setSchedulingpolicyname(DEFAULT);
	 	 	ap.update (con);			
	 	 }	
		 if (equip_none != null){		
			for (int k = 0; k < equip_none.length; k++){
				equip_none[k].setSchpolicyname("-none-");
				equip_none[k].update(con);					
			}
		} 	
	 }
     if (RetrievalName  != null) {
     		 if(active.equals("true")) {
		 	ap.setRetrievalpolicyname(RetrievalName);
		 	ap.update (con);
		 } else {
		 	ap.setRetrievalpolicyname(DEFAULT);
		 	ap.update (con);
		 }
	 }

	 if (SchedulingName != null) {
%>		
		<form id="form" method="POST" action="FindSchedulingPolicy.jsp">
			<script>
			location.href  = "/activator/scheduler?reload=true";
			document.getElementById('form').submit();			
			</script>
		</form>
<%
	 } else if (RetrievalName  != null) {
%>
		<form id="form" method="POST" action="FindRetrievalPolicy.jsp">
			<script>
			document.getElementById('form').submit();
			</script>
		</form>
<%
	 }

  } catch (Exception e) {
	 %>
       <b><bean:message bundle="InventoryResources" key="Backup.ActivePolicy.Error.changepolicy" /></b> <% e.printStackTrace(); %>
	<%
  }
  finally
  {
     con.close();

   }
%>
</body>
</html>