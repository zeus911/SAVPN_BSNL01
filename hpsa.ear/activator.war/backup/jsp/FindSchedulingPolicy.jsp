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
                java.util.*, 
                java.net.*, 
                java.text.*,
                java.lang.*,
                 com.hp.ov.activator.util.TextFormater,
                 com.hp.ov.activator.vpn.inventory.servlet.Utils.*"
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
<jsp:useBean id="menuDataBean" scope="session" class="com.hp.ov.activator.mwfm.servlet.menuDataBean"/>

<% /* JPM New. Activate Bean */%>
<jsp:useBean id="menuBackupBean" scope="session" class="com.hp.ov.activator.vpn.backup.servlet.menuBackupBean" />
<% menuBackupBean.resetSchedulingPolicy(); %>

<head>
	<script language="JavaScript" src="../../javascript/table.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
	
	<link rel="stylesheet" type="text/css" href="../../css/spainTable.css">
	
	<link rel="stylesheet" type="text/css" href="../../css/saContextMenu.css">	
	<script language="JavaScript" src="../../javascript/saUtilities.js"></script>
	<script language="JavaScript" src="../../javascript/saContextMenu.js"></script>
	<script language="JavaScript" src="../../javascript/backup.js"></script>
</head>
<body onload="loadMenus()" onclick="hideContextMenu(lastMenuName);">
<center>
	<h2 class="mainSubHeading"><center><bean:message bundle="InventoryResources" key="Backup.FindSchedulingPolicy.title" /></center></h2>

<%
   String DEFAULT = "Default"; // Name of the default policy

   DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);    
   com.hp.ov.activator.vpn.backup.SchedulingPolicy[] acl = null; 
   //if (dataSource == null)
       //System.out.println("dbp returned NULL");
   Connection con = null;
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
   int length = 0;

   try {
	 con = (Connection)dataSource.getConnection();  
     acl = com.hp.ov.activator.vpn.backup.SchedulingPolicy.findAll(con);
     //ActivePolicies[]   ap  = ActivePolicies.findAll(con);

	%>


        		<%
     			if (acl == null) {
			%>
			<SCRIPT LANGUAGE="JavaScript">
				var fPtr = parent.frames['main'].document;
		       	fPtr.open();
		       	fPtr.write("<center>"+"<bean:message bundle="InventoryResources" key="Backup.FindSchedulingPolicy.Notfound" />"+"</center>");
		       	fPtr.close();
			</SCRIPT>
		<%
     		} else {%>
        	<table align="center" width=100% border=0 cellpadding=0>
  			<tr>
				<td class="mainHeading" align="center" colspan=5><bean:message bundle="InventoryResources" key="Backup.FindSchedulingPolicy.found" /> (<%= acl == null ? 0 : (acl.length-1) %>)</td>
  			</tr>
        		<tr>
				<td class="mainHeading">&nbsp;</td>
				<td class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.FindSchedulingPolicy.Name" /></td>
				<td class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.FindSchedulingPolicy.StartingTime" /></td>
				<td class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.FindSchedulingPolicy.Periodicity" /></td>
				<!--td class="mainHeading">Refresh Interval</td-->
				<td class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.FindSchedulingPolicy.BackupNumber" /></td>
        		</tr>     		
     		<%
     			int numRows = 1; int tmp = 0;
			String rowClass= (numRows%2 == 0) ? "tableEvenRow" : "tableOddRow";
        		for (int i=0; i<acl.length; i++)  {
        			//check periodicity: daily?/weekly?/monthly?/in minutes?
                      long periodicity = acl[i].getPeriodicity();
                      String periodicity_selected = (new Long(periodicity)).toString();

                      if (periodicity == 1440){
                        periodicity_selected = "Daily";
                      }
                      if (periodicity == 1440*7){
                        periodicity_selected = "Weekly";
                      }
                      if (periodicity == 1440*30){
                        periodicity_selected = "Monthly";
                      }

                    // Activar la opcion de delete
        			String delete="false";
        			String active="Deactivate";
        			
				if (!(acl[i].getSchedulingpolicyname()).equals(DEFAULT))  {
					delete="true";
				}
				/*if(!ap[0].getSchedulingpolicyname().equals(acl[i].getSchedulingpolicyname())) {
					active="Activate";
				} else {
					delete="false";
				}  */
        		
			%>
			<%
			//<SCRIPT LANGUAGE="JavaScript">
				//var fPtr = parent.frames['messageLine'].document;
		       	//fPtr.open();
		       	//fPtr.write("Configurations found." + < %= acl == null ? 0 : acl.length % >);
		       	//fPtr.close();
			//</SCRIPT>
			if ((acl[i].getSchedulingpolicyname()).compareToIgnoreCase("-none-") != 0){
				length++;
                String schName = acl[i].getSchedulingpolicyname();
			%>
				<tr id="rpRow<%=tmp%>" class="<%=rowClass%>"
						onclick="rowSelect(this);" 
						onMouseDown="setMenuName('rpMenu<%=tmp%>');  hideContextMenu(lastMenuName); setLastMenuName('rpMenu<%=tmp%>');
               		  		parent.frames['messageLine'].location.href='msgLine.jsp?menuType=2&schedulingName=<%=URLEncoder.encode(schName,"UTF-8") %>';"
				  		onMouseOver="mouseOver(this);" onMouseOut="mouseOut(this);">
					<td class="tableCell">
					<%
					//if (ap[0].getSchedulingpolicyname().equals(acl[i].getSchedulingpolicyname())) {
					%>
						<!--img border=0 src="../../images/ckmark.gif" alt="Active policy"-->
					<%
					//} else {
					%>
					&nbsp;
					<%
					//}
					%>
					</td>
					<td class="tableCell"><%= schName %></td>
					<td class="tableCell"><%= sdf.format(acl[i].getStartingtime()) %></td>
					<td class="tableCell"><%= periodicity_selected %></td>
					<!--td class="tableCell"><= acl[i].getRefreshinterval() %></td-->
					<td class="tableCell"><%= acl[i].getBackupsnumber() %></td>
				</tr>
<div id="rpMenu<%=tmp%>" class="contextMenu" onclick="hideContextMenu('rpMenu<%=tmp%>')">
            <a href='UpdateFormSchedulingPolicy.jsp?schedulingName=<%=URLEncoder.encode(schName,"UTF-8") %>' target="main"
               class="menuItem"
               onmouseover="toggleHighlight(event)"
               onmouseout="toggleHighlight(event)"><bean:message bundle="InventoryResources" key="Backup.FindSchedulingPolicy.ModifyPolicy" /></a>		   
			   
	<%
	/*String _active = "true";
	    	if(!active.equalsIgnoreCase("ACTIVATE")) {
    		_active = "false";
    	}*/
	%>
               
             <!--hr>
	      <a href='ActivePolicy.jsp?activeClass=scheduling&active=<=_active%>'  target="main"
	         class="menuItem"                     
	         onmouseover="toggleHighlight(event)"
             onmouseout="toggleHighlight(event)"><=active%> Policy</a-->
                 
	<%
	if(delete.equals("true")) {
	%>
             <hr>
	     <a href='DeleteObjectConfirm.jsp?schedulingName=<%=URLEncoder.encode(schName,"UTF-8") %>all=false&deleteClass=scheduling' target="main"
	     	class="menuItem"                     
	     	onmouseover="toggleHighlight(event)"
            onmouseout="toggleHighlight(event)"><bean:message bundle="InventoryResources" key="Backup.FindSchedulingPolicy.DeletePolicy" /></a>             
     <%
	 }//if delete 
	 %>           
                
    </div>

			<%
				tmp++;
				numRows ++;
        		}// for
     		}// else
		%>
        </table>

<% }
   }
   catch (Exception e)
   {
		%>
			<SCRIPT LANGUAGE="JavaScript">
				var fPtr = parent.frames['messageLine'].document;
		       	fPtr.open();
		       	fPtr.write("<bean:message bundle="InventoryResources" key="Backup.Find.Error.query" />");
		       	fPtr.close();
			</SCRIPT>		
		
		<%e.printStackTrace();
   }
   finally
   {
         if (con != null)                   
			con.close();
   }
%>

<script language="JavaScript">		
   function loadMenus(){	
<%
	if ( acl!=null) {
	 for(int index=0; index < length; index++) {
%>
	   document.getElementById('rpRow<%=index%>').oncontextmenu = showContextMenu;
<%
	  }
	}
%>
   }
		
   if (document.all) {
<% 
    for(int index=0; /*index < configurations_per_table &&*/ index < length; index++) {
%>
	  var menuName<%=index%> = "rpMenu<%=index%>";
	  document.onclick = "hideContextMenu(menuName<%=index%>)";
<%
     }
%>
   }  
</script>

</body>
</html>

