<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,com.hp.ov.activator.cr.inventory.*,com.hp.ov.activator.cr.inventory.Region,
		  com.hp.ov.activator.vpn.backup.servlet.*,
                java.sql.*, 
                javax.sql.DataSource,
                java.util.*, 
                java.text.*,
                java.net.*" 
         info="View Equipment List" 
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
    if (session == null || session.getAttribute(Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    }
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="menuBackupBean" scope="session" class="com.hp.ov.activator.vpn.backup.servlet.menuBackupBean" />

<html>
<head>
<% /* JPM New */ %>
	<script language="JavaScript" src="../../javascript/table.js"></script>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
    <link rel="stylesheet" type="text/css" href="../../css/spainTable.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">

                <SCRIPT LANGUAGE="JavaScript">
                  function closeView(){
                    if (top.selectedMenu == top.leftFrame.document.getElementById("listTab")){
	                    top.main.location='../../jsp/saConfigFrame.jsp';
                    }
                    else if (top.selectedMenu == top.leftFrame.document.getElementById("findTab")){
	                    top.main.location='FindEquipmentConfiguration.jsp'	;
                    }
                  }
                </script>
</head>

<body>
<%
// Recoger el EquipmentName y el Timestamp
   String equipmentName = menuBackupBean.getEquipmentName();
    String equipmentID = menuBackupBean.getEquipmentID();
   String timestamp = menuBackupBean.getTimestamp();

// If only_conf = true, only the equipment configuration will be update
   String only_conf = request.getParameter("only_conf");
   if (only_conf == null) 
   	only_conf = "false";

   String view = request.getParameter("view");
   if (view == null)
   	view = "false";

   String operationText = "Clone";
   String headerText = "Clone";
   if( only_conf.equals("true") && view.equals("false")){
	    operationText = "Update";
       headerText = "Update";
   }
    if( only_conf.equals("true") && view.equals("true")){
        headerText = "View";
        operationText = "Close";
    }

   if (equipmentID == null || equipmentID.equals(""))
   {
%>
       <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
           alert("<bean:message bundle="InventoryResources" key="Backup.View.alert.Notselected" />");
       </script>
<%
   }
   else
   {
%>
<%! Object obj; %>
<%
   	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
   	java.util.Date timeStamp = sdf.parse(timestamp);
%>

<center>
	<h2 class="mainSubHeading"><center><%=headerText%> <bean:message bundle="InventoryResources" key="Backup.UpdateEquipmentConfiguration.title" /></center></h2>

	<jsp:useBean id="configLine" class="com.hp.ov.activator.vpn.backup.ConfigLine" />
	<jsp:setProperty name="configLine" property="equipmentName" value="<%= equipmentName %>"/>
	<jsp:setProperty name="configLine" property="timestamp" value="<%= timeStamp %>"/>
    <jsp:setProperty name="configLine" property="equipmentID" value="<%= equipmentID %>"/>
<%
   	DataSource dataSource = (DataSource) session.getAttribute(Constants.DATASOURCE);
   	Connection con = null;
    PreparedStatement  pstmt = null;
    ResultSet          rset = null;
   	String now = null;
   	String sUsername = (String) session.getAttribute(Constants.USER);
   	try {
     		con = (Connection) dataSource.getConnection();
                    pstmt = con.prepareStatement ("select a.timestamp, a.createdby, a.equipmentid, a.version, a.data, a.lastaccesstime, a.memorytype, a.modifiedby from V_equipmentconfiguration a where  a.equipmentid='"+configLine.getEquipmentID()+"' and to_date(a.timestamp,'yyyy.MM.dd HH24:mi:ss') in (select configtime from v_backupref where creationtime=to_date(?,'yyyy.MM.dd HH24:mi:ss') and eqid=?)");
                    //pstmt.setTimestamp (1, new java.sql.Timestamp (configLine.getTimestamp().getTime()));
                    pstmt.setString (1, sdf.format(configLine.getTimestamp()));             
                    pstmt.setString (2, configLine.getEquipmentID().trim());                    
                  
                    
                    rset = pstmt.executeQuery();                   
                      if ( rset.next() ){
                        do{
                          //configLine.setConfigTime(sdf.parse(rset.getString(1)));
                          configLine.setConfigTime(sdf.parse(rset.getString(1)));
                          configLine.setVersion(rset.getString(4));
                          configLine.setData(rset.getString(5));
                          configLine.setLastAccessTime(sdf.parse(rset.getString(6)));
                          configLine.setMemoryType(rset.getString(7));
                          configLine.setModifiedBy(rset.getString(8));
                        }while (rset.next());
                      }
                    if (rset!=null){
                        rset.close();
                    }
                    if (pstmt!=null){
                        pstmt.close();
                    }

                    pstmt = con.prepareStatement ("select retrievalname, comments, createdby from v_backupref where  eqid='"+configLine.getEquipmentID()+"' and creationtime=?");
                    pstmt.setTimestamp (1, new java.sql.Timestamp (configLine.getTimestamp().getTime()));
                    rset = pstmt.executeQuery();
                      if ( rset.next() ){
                        do{
                          configLine.setRetrievalName(rset.getString(1));
                          configLine.setComment(rset.getString(2));
                          configLine.setCreatedBy(rset.getString(3));
                        }while (rset.next());
                      }
                    if (rset!=null){
                        rset.close();
                    }
                    if (pstmt!=null){
                        pstmt.close();
                    }

     		now = sdf.format(new java.util.Date());
     		if (configLine == null) {
     		%>
			<SCRIPT LANGUAGE="JavaScript">
				var fPtr = top.messageLine.document;
		       	fPtr.open();
		       	fPtr.write("<bean:message bundle="InventoryResources" key="Backup.UpdateEquipmentConfiguration.Error.Notfound" />");
		       	fPtr.close();
			</SCRIPT>
		<%
		} else {
                 String retrieval_type = configLine.getRetrievalName();
                 if (only_conf.equalsIgnoreCase("false")){
                     configLine.setRetrievalName("CLONE");
                 }
		%>
			<form name="form" method="POST" action="CreationCommitEquipmentConfiguration.jsp?only_conf=<%= only_conf %>">
			<table width="80%" border="0" cellpadding="0">
  				<tr>
					<td class="mainHeading" align="center" colspan=4><bean:message bundle="InventoryResources" key="Backup.UpdateEquipmentConfiguration.Update" /></td>
  				</tr>		
  				<%
  				int row = 1;
				String rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
  				%>
  				<tr class="<%=rowClass%>">
    					<td width="10%" class="tableCell">&nbsp;</td>
       				<td width="30%" class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.View.EquipmentName" /></b></td>
					<td width="50%" class="tableCell"><%= configLine.getEquipmentName() %>
    					<td width="10%" class="tableCell">&nbsp;</td>
  				</tr>
				<% 
				if ( only_conf.equals("false") )
   				{  
					row ++;
					rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
   				%>
  					<tr class="<%=rowClass%>">
    						<td class="tableCell">&nbsp;</td>
						<td class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.UpdateEquipmentConfiguration.Destination" /></b></td>
						<td class="tableCell"><select  class="tableCell" name="equipmentID">
						<%
                        WFManager wfm = (WFManager) session.getAttribute (Constants.MWFM_SESSION);
                        Region[] regions = Region.findAll(con);
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
							com.hp.ov.activator.cr.inventory.NetworkElement[] aEquipos = com.hp.ov.activator.cr.inventory.NetworkElement.findAll(con, "vendor in (select vendor from cr_networkelement where networkelementid = '"+menuBackupBean.getEquipmentID()+"')" + roleClauseStart + roleClauseEnd);
							for (int ii=0; ii < aEquipos.length; ii++) {
	  							String sEquipo = aEquipos[ii].getName();
	  					%>
								<option value="<%=aEquipos[ii].getNetworkelementid()%>" <%= sEquipo.equals(configLine.getEquipmentName()) ? " selected" : "" %>> <%= sEquipo %></option>
						<%
						}
						%>
    						<td class="tableCell">&nbsp;</td>
					</tr>
                    <input type="hidden" name="equipmentNameSource" value="<%= configLine.getEquipmentName() %>"></td>
				<%
				} else {
				%>
					<input type="hidden" name="equipmentName" value="<%= configLine.getEquipmentName() %>"></td>
                    <input type="hidden" name="equipmentID" value="<%= configLine.getEquipmentID() %>"></td>
				<%
  				}
				%>
				<% 
				row ++;
				rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
				%>
  				<tr class="<%=rowClass%>">
    					<td class="tableCell">&nbsp;</td>
  					<td align=left class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.Find.Timestamp" />&nbsp;</b></td>
    					<% if (only_conf.equals("true")) { %>
    						<td align=left class="tableCell"><%= sdf.format(configLine.getTimestamp()) %>
    						<input type="hidden" name="timestamp" value="<%= sdf.format(configLine.getTimestamp()) %>"></td>
    					<% } else { %>
    						<td align=left class="tableCell"><%= now %>
    						<input type="hidden" name="timestamp" value="<%= now %>"></td>
    					<% } %>
    					<td class="tableCell">&nbsp;</td>
				</tr>
                <input type="hidden" name="configTime" value="<%= sdf.format(configLine.getConfigTime()) %>"></td>
                <input type="hidden" name="timeDisplayed" value="<%= sdf.format(configLine.getTimestamp()) %>"></td>
				<%
				row ++;
				rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
				%>
  				<tr class="<%=rowClass%>">
    					<td class="tableCell">&nbsp;</td>
    					<td align=left class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.Find.Version" />&nbsp;</b></td>
    					<td align=left class="tableCell"><%= configLine.getVersion() %>
					<input type="hidden" name="version" value="<%= configLine.getVersion() %>"></td>
    					<td class="tableCell">&nbsp;</td>
  				</tr>
				<% 
				row ++;
				rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow"; 			
				%>
  				</tr>
				<tr class="<%=rowClass%>">
    					<td class="tableCell">&nbsp;</td>
    					<td align=left class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.Find.RetrievalType" />&nbsp;</b></td>
    						<td align=left class="tableCell"><%=retrieval_type.toLowerCase() %>
							<input type="hidden" name="retrievalName" value="<%= configLine.getRetrievalName() %>"></td>
    					<td class="tableCell">&nbsp;</td>
  				</tr>
				<% 
				row ++;
				rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
                    String memoryType = configLine.getMemoryType();
				%>
                <tr class="<%=(row%2 == 0) ? "tableEvenRow" : "tableOddRow"%>">
                    <td class="tableCell">&nbsp;</td>
                    <td align=left class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.List.MemoryType" />&nbsp;</b></td>
                    <td align=left class="tableCell"><%=  memoryType == null ? "": memoryType%>
                        <% if(memoryType != null){ %>
						    <input type="hidden" name="memoryType" value="<%= configLine.getMemoryType() %>"></td>
                        <%}%>
                    <td class="tableCell">&nbsp;</td>
                </tr>
					<%
					row ++;
					rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
					%>
				<tr class="<%=rowClass%>">
    					<td class="tableCell">&nbsp;</td>
    					<td align=left class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.List.CreateBy" />&nbsp;</b></td>
    					<td align=left class="tableCell"><%= configLine.getCreatedBy() %>
						<input type="hidden" name="createdBy" value="<%= configLine.getCreatedBy() %>"></td>
    					<td class="tableCell">&nbsp;</td>
  				</tr>
				<% if (only_conf.equals("true") ) { %>
					<% 
					row ++;
					rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
					%>
					<tr class="<%=rowClass%>">
    						<td class="tableCell">&nbsp;</td>
    						<td align=left class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.List.ModifyBy" />&nbsp;</b></td>
                            <%String modifiedBy = "";
                                if (configLine.getModifiedBy() != null && !configLine.getModifiedBy().equalsIgnoreCase("null"))
                                    modifiedBy = configLine.getModifiedBy();
                            %>
    						<td align=left class="tableCell"><%= modifiedBy %>
							<input type="hidden" name="modifiedBy" value="<%= sUsername %>"></td>
    					<td class="tableCell">&nbsp;</td>
  					</tr>
  				<%}%>

					<%
					row ++;
					rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
                 String comment = "";
                 if (configLine.getComment() != null && !configLine.getComment().equalsIgnoreCase("null")) comment = configLine.getComment();
					%>
 					 <tr class="<%=rowClass%>">
                      <td class="tableCell">&nbsp;</td>
                      <td align=left class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.List.Comment" />&nbsp;</b></td>
                      <% if(view.equals("false")){%>
					  <td align=left class="tableCell"><textarea wrap=off rows=5 cols="50%"  name="comment" ><%=comment%></textarea></td>
                      <%} else{%>
                      <td align=left class="tableCell"><textarea readonly wrap=off rows=5 cols="50%"  name="comment" ><%=comment%></textarea></td>
                      <%}%>
                      <td class="tableCell">&nbsp;</td>
				  </tr>

					<%
					row ++;
					rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
					%>
 					 <tr class="<%=rowClass%>">
					  	<td width="90%" colspan="4" class="mainHeading"  align="center"><bean:message bundle="InventoryResources" key="Backup.View.Data" /></td>
				  </tr>
				<% 
				row ++;
				rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
				%>
				<tr class="<%=rowClass%>">
				             <% 
							  String data =configLine.getData();
							  String dataString = "";
							  if (data != null) dataString = new String(data); 
							  System.out.println("DATA"+data);
							  %>
                              <% if(view.equals("false")){%>
    					<td colspan="4" align="center" class="tableCell">
    						<textarea wrap=off rows=15 cols="80%"  name="data" ><%=dataString%></textarea>
    					</td>
                        <%} else{%>
    					<td colspan="4" align="center" class="tableCell">
    						<textarea readonly wrap=off rows=15 cols="80%"  name="data" ><%=dataString%></textarea>
    					</td>
                        <%}%>
  				</tr>
				<%
				row ++;
				rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
				%>
				<tr class="<%=rowClass%>">
				 	<td colspan="4" class="tableCell"  align="center">&nbsp;</td>
  				</tr>
  			</table>
              <%if (view.equals("true")){%>
  				<p>
					<input type="button" name="close" value="<bean:message bundle="InventoryResources" key="Backup.UpdateEquipmentConfiguration.button.closee" />" onClick='closeView()'>
				</p>

            <%} else if(operationText.equals("Update")){             	
            %>
  				<p>
					<input type="submit" name="clone" value="<bean:message bundle="InventoryResources" key="Backup.UpdateSchedulingPolicy.button" />">
				</p>
              <%}else{%>
         <p>
					<input type="submit" name="clone" value="<bean:message bundle="InventoryResources" key="Backup.Find.button.Clone" />">
				</p>
              	
              <% } %>	
  			</form>
		<%
		}
	} catch (Exception e) {
	e.printStackTrace();
       	%>
<SCRIPT LANGUAGE="JavaScript">
	var fPtr =  top.messageLine.document;
	fPtr.open();
    fPtr.write("<bean:message bundle="InventoryResources" key="Backup.List.Error.query" />");
	fPtr.close();
</SCRIPT>       	
<% } finally {
          if (rset  != null)
            rset.close();
          if (pstmt != null)
             pstmt.close();
          if (con != null)
       	    con.close();
   	}
   }
%>
</center>
</body>
</html>