<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants,
                 javax.sql.DataSource,
                 java.sql.Connection,
                 com.hp.ov.activator.cr.inventory.*,
                 com.hp.ov.activator.vpn.inventory.*,
                 java.net.URLEncoder,
                 com.hp.ov.activator.mwfm.WFManager"
         info="Fetch Equipment Configuration"
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
    if (session == null || session.getAttribute (Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    }
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<head>
	<script language="JavaScript" src="../../javascript/table.js"></script>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
  	<link rel="stylesheet" type="text/css" href="../../css/spainTable.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
</head>

<body>
<center><h2 class="mainSubHeading"><bean:message bundle="InventoryResources" key="Backup.Show.title" /></h2></center>
<%
  DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);
  Connection connection = null;
  WFManager wfm = (WFManager) session.getAttribute (Constants.MWFM_SESSION);

  try {
    connection = (Connection)dataSource.getConnection();


    com.hp.ov.activator.cr.inventory.NetworkElement[] aBean = com.hp.ov.activator.cr.inventory.NetworkElement.findAll(connection, "Adminstate in ('Up', 'Reserved') and LifeCycleState != 'Planned'");
    boolean empty = true;
    if(aBean != null){
        for ( int i = 0; i < aBean.length; i++) {
        	String role = aBean[i].getRole();
    			 if (role!= null && role.equalsIgnoreCase("PE"))
    				{
    				PERouter peBean = PERouter.findByPrimaryKey(connection, aBean[i].getNetworkelementid());
    				if ( peBean != null  && peBean.getBackup())
    		  		empty = false;
          	}	
          	
          
    			if ((role!= null && role.equalsIgnoreCase("CE")))
    			{	
    			CERouter ceBean = CERouter.findByPrimaryKey(connection, aBean[i].getNetworkelementid());
    			if (ceBean != null  && ceBean.getBackup())
          		empty = false;
          }
          		
    			if ((role!= null && (role.equalsIgnoreCase("AggregationSwitch") || role.equalsIgnoreCase("AccessSwitch")) ))
    			{	
    					Switch sBean = Switch.findByPrimaryKey(connection, aBean[i].getNetworkelementid());
    			   if (sBean != null  && sBean.getBackup())
          		empty = false;
          }
        }
    }

    if ( empty ) {
%>
		<SCRIPT LANGUAGE="JavaScript">
			var fPtr = this.document;
		       fPtr.open();
		       fPtr.write("<center>No equipment is available.</center>");
		       fPtr.close();
		</SCRIPT>

<%
    }
    else {
        com.hp.ov.activator.cr.inventory.NetworkElement selectedNetworkElement = null;
        String selectedId= request.getParameter("id");
        selectedId = selectedId == null ? "" : selectedId;
%>
<center>
<form name="form" method="GET" target="main" action=  "ViewEquipmentConfiguration.jsp">
<table align="center" width="80%" border=0 cellpadding=0>
  	<tr>
		<td class="mainHeading" align="center" colspan=4><bean:message bundle="InventoryResources" key="Backup.Show.showconfig" /></td>
	</tr>
  	<tr class="tableOddRow">
    		<td class="tableCell" colspan=4>&nbsp;</td>
  	</tr>
  	<tr class="tableEvenRow">
    		<td width="10%" class="tableCell">&nbsp;</td>
    		<td width="30%" class="tableCell"><bean:message bundle="InventoryResources" key="Backup.Show.EquipmentName" /></td>
    		<td width="50%" class="tableCell">
            <select class="tableCell" name="equipmentID"
                    onchange="document.location='FetchEquipmentConfiguration.jsp?id='+this.value+'&memory='+getElementById('memory').value" >
		<%
      			for ( int ii=0; ii < aBean.length; ii++ ) {
                      com.hp.ov.activator.cr.inventory.NetworkElement networkElement = aBean[ii];
                      boolean selected = false;
                      if(com.hp.ov.activator.cr.inventory.Network.findByNetworkid(connection, networkElement.getNetworkid())!=null && wfm.isInRole(com.hp.ov.activator.cr.inventory.Network.findByNetworkid(connection, networkElement.getNetworkid()).getRegion())){
											String role = networkElement.getRole();
											boolean backup=false;
											
											if ((role!= null && role.equalsIgnoreCase("PE")))
											{
    										PERouter peBean = PERouter.findByPrimaryKey(connection, networkElement.getNetworkelementid());
    										backup = peBean.getBackup();
          						}
          						
    									if ((role!= null && role.equalsIgnoreCase("CE")))
    									{	
    										CERouter ceBean = CERouter.findByPrimaryKey(connection, networkElement.getNetworkelementid());
    										backup = ceBean.getBackup();
          						}
          						
    									if ((role!= null && (role.equalsIgnoreCase("AggregationSwitch") || role.equalsIgnoreCase("AccessSwitch")) ))
    									{
    										Switch sBean = Switch.findByPrimaryKey(connection, networkElement.getNetworkelementid());
    			   						backup = sBean.getBackup();
          						}
                      if ( ((new String("Up")).equals(networkElement.getAdminstate())||(new String("Reserved")).equals(networkElement.getAdminstate())) && backup) {
                          selectedNetworkElement = selectedNetworkElement == null ? networkElement : selectedNetworkElement;
                          if(selectedId.equalsIgnoreCase(networkElement.getNetworkelementid())){
                              selectedNetworkElement = networkElement;
                              selected = true;
                          }

		%>
    					<option value="<%= networkElement.getNetworkelementid()%>" <%= selected ? "selected" : "" %> ><%= networkElement.getName() %></option>
		<%
				    }
                  }
		      }
            String networkElementID = selectedNetworkElement.getNetworkelementid();
		%>
            </select>
            </td>
    		<td width="10%" class="tableCell">&nbsp;</td>
  	</tr>
    <input type="hidden" name="equipmentName" value="<%=URLEncoder.encode(selectedNetworkElement.getName(), "UTF-8")%>"/>
    <input type="hidden" name="equipmentVendor" value="<%=URLEncoder.encode(selectedNetworkElement.getVendor(), "UTF-8")%>"/>
  	<tr class="tableOddRow">
		<td class="tableCell">&nbsp;</td>
		<td class="tableCell"><bean:message bundle="InventoryResources" key="Backup.Show.TargetMemory" /></td>
		<td class="tableCell">
<%--        GetMemoryTypes.jsp needs selectedNetworkElementID variable and returns boolean memoryTypesFound as result of finding--%>		
        <%@ include file="GetMemoryTypes.jsp" %>

        </td>
		<td class="tableCell">&nbsp;</td>

  	</tr>
	<tr class="tableEvenRow">
		<td class="tableCell" colspan=4>&nbsp;</td>
  	</tr>
</table>
    <% if(memoryTypesFound){ %>
        <p>
	        <input type="submit" name="create" value="<bean:message bundle="InventoryResources" key="Backup.Show.button.ShowConfig" />">
        </p>
    <% } %>

</form>
</center>
<%
    }
%>
<%
  } catch (Throwable sqle) { 
%>
<SCRIPT LANGUAGE="JavaScript">
	var fPtr = top.messageLine.document;
	fPtr.open();
    fPtr.write("<bean:message bundle="InventoryResources" key="Backup.Show.Error.query" />");
	fPtr.close();
</SCRIPT>  
<%
  } finally {
    if ( connection != null )
      connection.close();
  }
%>
</body>
</html>