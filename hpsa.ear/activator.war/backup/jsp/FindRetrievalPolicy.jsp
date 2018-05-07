<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,
		  com.hp.ov.activator.vpn.backup.servlet.*,
                java.sql.*, 
				javax.sql.DataSource,
                java.util.*, 
                java.net.*, 
                java.text.*,
                java.lang.*" 
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
    if (session == null || session.getValue (com.hp.ov.activator.mwfm.servlet.Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    }
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");	
%>

<head>
<% /* JPM New */ %>
	<script language="JavaScript" src="../../javascript/table.js"></script>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
	
	<script language="JavaScript" src="../../javascript/menu.js"></script>	

	<link rel="stylesheet" type="text/css" href="../../css/spainTable.css">
	
	<link rel="stylesheet" type="text/css" href="../../css/saContextMenu.css">
	<script language="JavaScript" src="../../javascript/saUtilities.js"></script>
	<script language="JavaScript" src="../../javascript/saContextMenu.js"></script>
	<script language="JavaScript" src="../../javascript/backup.js"></script>

</head>

<script language="JavaScript">	

</script>

<body onload="loadMenus()" onclick=" hideContextMenu(lastMenuName);">
<center>
	<h2 class="mainSubHeading"><center><bean:message bundle="InventoryResources" key="Backup.FindRetrievalPolicy.title" /></center></h2>
<%
   String DEFAULT = "Default"; // Name of the default policy
   String globActive="Inactive";
   String globDelete="false";   

   DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);  
   com.hp.ov.activator.vpn.backup.RetrievalPolicy[] acl = null;  
   int length = 0;
   
   Connection con = null;
   try {
     	//con = (Connection) dbp.getConnection();
		con = (Connection)dataSource.getConnection();  
     	acl = com.hp.ov.activator.vpn.backup.RetrievalPolicy.findAll(con);
	    ActivePolicies ap = ActivePolicies.findByFirst(con);

 	 %>
        <table align="center" width=100% border=0 cellpadding=0 >
  		<tr>
			<td class="mainHeading" align="center" colspan=3><bean:message bundle="InventoryResources" key="Backup.FindRetrievalPolicy.found" /> (<%= acl == null ? 0 : acl.length %>)</td>
  		</tr>
        	<tr>
			<td class="mainHeading">&nbsp;</td>
			<td class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.FindRetrievalPolicy.name" />&nbsp;</td>
			<td class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.FindRetrievalPolicy.firstmethod" />&nbsp;</td>
			<td class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.FindRetrievalPolicy.secondmethod" />&nbsp;</td>
			<td class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.FindRetrievalPolicy.thirdmethod" />&nbsp;</td>
        	</tr>
        	<%
     		if (acl == null) {
		%>
			<SCRIPT LANGUAGE="JavaScript">
				var fPtr = parent.frames['messageLine'].document;
		       	fPtr.open();
		       	fPtr.write("<bean:message bundle="InventoryResources" key="Backup.FindRetrievalPolicy.Notfound" />");
		       	fPtr.close();
			</SCRIPT>
		<%
     		} else {
     			int numRows = 1; int tmp = 0;
			String rowClass= (numRows%2 == 0) ? "tableEvenRow" : "tableOddRow";
        		for (int i=0; i<acl.length; i++) {
				  String delete="false";
        		  String active="Inactive";
        			
				if (!(acl[i].getRetrievalpolicyname()).equals(DEFAULT)) { 
					delete="true";					
				}
				if ( !(ap.getRetrievalpolicyname().equals(acl[i].getRetrievalpolicyname()))) {
					active="Active";
				} else {
					delete="false";
				}
				length++;
			%>
				<tr id="rpRow<%=tmp%>" class="<%= rowClass%>"
						onclick="rowSelect(this);" 										  		
				  		onMouseOver="mouseOver(this);" onMouseOut="mouseOut(this);" 
						onMouseDown=" setMenuName('rpMenu<%=tmp%>');  hideContextMenu(lastMenuName); setLastMenuName('rpMenu<%=tmp%>');
						parent.frames['messageLine'].location.href='msgLine.jsp?menuType=3&retrievalName=<%= URLEncoder.encode(acl[i].getRetrievalpolicyname()) %>';
						">
						
										  							
					<td class="tableCell">
					<%
						
						if (ap.getRetrievalpolicyname().equals(acl[i].getRetrievalpolicyname())) {
					%>
							<img border=0 src="../../images/ckmark.gif" alt="Active policy">
						<%
					} else {
					%>
						&nbsp;
					<%
					}
					%>
					</td>
				<td class="tableCell"><%= acl[i].getRetrievalpolicyname() %></td>
				<td class="tableCell"><%= acl[i].getFirstmethod().toLowerCase() %></td>
				<td class="tableCell"><%= acl[i].getSecondmethod().toLowerCase() %></td>
				<td class="tableCell"><%= acl[i].getThirdmethod().toLowerCase() %></td>
			</tr>

			
		
	
<div id="rpMenu<%=tmp%>" class="contextMenu" onclick="hideContextMenu('rpMenu<%=tmp%>')">
            <a href='UpdateFormRetrievalPolicy.jsp' target="main"              
               class="menuItem"
               onmouseover="toggleHighlight(event)"
               onmouseout="toggleHighlight(event)"> Modify Policy</a>		   
			   
	<%
	String _active = "true";
	    	if(!active.equalsIgnoreCase("ACTIVE")) {
    		_active = "false";
    	}
	%>
               
             <hr>
	      <a href='ActivePolicy.jsp?activeClass=retrieval&active=<%=_active%>'  target="main"
	         class="menuItem"                     
	         onmouseover="toggleHighlight(event)"
             onmouseout="toggleHighlight(event)"><%=active%> Policy</a>
                 
	<%
	if(delete.equals("true")) {
	%>
             <hr>
	     <a href='DeleteObjectConfirm.jsp?all=false&deleteClass=retrieval' target="main"
	     	class="menuItem"                     
	     	onmouseover="toggleHighlight(event)"
            onmouseout="toggleHighlight(event)"> Delete Policy</a>             
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
<%
   }
   catch (Exception e)
   {
	   e.printStackTrace();
		%>
		Error while looking for: <%= e.toString () %>.
		<%
   }
   finally
   {
     if (con!=null)
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

