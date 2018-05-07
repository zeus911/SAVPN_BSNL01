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
                java.net.*,
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
    request.setCharacterEncoding("UTF-8");
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
<% menuBackupBean.resetEquipmentName(); %>
<% menuBackupBean.resetEquipmentID(); %>
<% menuBackupBean.resetTimestamp(); %>

<html>

<head>
<% /* JPM New */ %>
	<script language="JavaScript" src="../../javascript/menu.js"></script>	
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
	<link rel="stylesheet" type="text/css" href="../../css/spainTable.css">
	
	<link rel="stylesheet" type="text/css" href="../../css/saContextMenu.css">
	<script language="JavaScript" src="../../javascript/saUtilities.js"></script>
	<script language="JavaScript" src="../../javascript/saContextMenu.js"></script>	
	<script language="JavaScript" src="../../javascript/backup.js"></script>
</head>

<body onclick="hideContextMenu('equipmentMenu'); hideContextMenu('equipmentMenuReduced');">
<center>
	<h2 class="mainSubHeading"><center><bean:message bundle="InventoryResources" key="Backup.list.title" /></center></h2>
<%
   //We determine the order which should appear all the registries
   DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);
   Connection connection = null;
   PreparedStatement ps = null;
   ResultSet rs = null;
   WFManager wfm = (WFManager) session.getAttribute (Constants.MWFM_SESSION);
   int configurations_per_table = 100;
   int length = 0;
   boolean checkRowsExist = false;
   EquipmentConfiguration[] eqconfigs= null;
   ConfigLine[] acl = null;
   try {
        connection = (Connection) dataSource.getConnection();
        Vector list = new Vector();

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





       Vector equipmentNames = new Vector();
       Hashtable routers = new Hashtable();
       //ps = connection.prepareStatement("select networkelementid, name, schpolicyname from cr_networkelement where backup='1' "+roleClauseStart + roleClauseEnd);



				ps = connection.prepareStatement("select n.networkelementid, name  from cr_networkelement n, v_PERouter p, v_Cerouter c , v_switch s " +
																							"where ( (n.networkelementid= p.networkelementid and p.backup='1') or " +
																							"(n.networkelementid= c.networkelementid and c.backup='1') or " +
																							"(n.networkelementid= s.networkelementid and s.backup='1')) " +				
																					roleClauseStart + roleClauseEnd);

       rs = ps.executeQuery();
	  
       if(rs.next()){
                do{
                    com.hp.ov.activator.cr.inventory.NetworkElement router = new com.hp.ov.activator.cr.inventory.NetworkElement();
                    router.setNetworkelementid(rs.getString(1));
                    router.setName(rs.getString(2));
                    //router.setSchpolicyname(rs.getString(3));
                    equipmentNames.add(router.getName());
                    routers.put(router.getNetworkelementid(),router);
                } while(rs.next());
        }
		if(routers ==null || routers.isEmpty() ){
			ps = connection.prepareStatement("select distinct n.networkelementid, n.name from cr_networkelement n " +
																							"where n.networkelementid IN (select networkelementid from v_perouter where backup = '1') or " +
																							"n.networkelementid IN (select networkelementid from v_switch where backup = '1')" +				
																					roleClauseStart + roleClauseEnd);

																					
			   rs = ps.executeQuery();
			  
			   if(rs.next()){
						do{
							com.hp.ov.activator.cr.inventory.NetworkElement router = new com.hp.ov.activator.cr.inventory.NetworkElement();
							router.setNetworkelementid(rs.getString(1));
							router.setName(rs.getString(2));
							//router.setSchpolicyname(rs.getString(3));
							equipmentNames.add(router.getName());
							routers.put(router.getNetworkelementid(),router);
						} while(rs.next());
				}
		}



        String url=new String();
        String order = request.getParameter("order");
        String reverse = request.getParameter("reverse");
        String url2=new String();
        int currentPosition;

        //The variable navegar is used to navigate into all the registries. If the value is true, the system will not make the select to get the registries.
        String navegar =new String();
        navegar =request.getParameter ("navegar");
   

        // This will help the order by method when the FindEquipmentConfiguration is access from the FindSelectedEquipmentConfiguration.jsp
        url="FindEquipmentConfiguration.jsp?";
       if (request.getParameter ("EquipmentID")!=null) url=url.concat("EquipmentID="+request.getParameter ("EquipmentID")+"&");
        if (request.getParameter ("EquipmentName")!=null) url=url.concat("EquipmentName="+request.getParameter ("EquipmentName")+"&");
        if (request.getParameter ("TimeStampHigh")!=null) url=url.concat("TimeStampHigh="+request.getParameter ("TimeStampHigh")+"&");
        if (request.getParameter ("TimeStampLow")!=null) url=url.concat("TimeStampLow="+request.getParameter ("TimeStampLow")+"&");
        if (request.getParameter ("Version")!=null) url=url.concat("Version="+request.getParameter ("Version")+"&");
        if (request.getParameter ("LastAccessTimeHigh")!=null) url=url.concat("LastAccessTimeHigh="+request.getParameter ("LastAccessTimeHigh")+"&");
        if (request.getParameter ("LastAccessTimeLow")!=null) url=url.concat("LastAccessTimeLow="+request.getParameter ("LastAccessTimeLow")+"&");
        if (request.getParameter ("RetrievalName")!=null) url=url.concat("RetrievalName="+request.getParameter ("RetrievalName")+"&");
        if (request.getParameter ("MemoryType")!=null) url=url.concat("MemoryType="+request.getParameter ("MemoryType")+"&");
        if (request.getParameter ("CreatedBy")!=null) url=url.concat("CreatedBy="+request.getParameter ("CreatedBy")+"&");
        if (request.getParameter ("ModifiedBy")!=null) url=url.concat("ModifiedBy="+request.getParameter ("ModifiedBy")+"&");

        if (request.getParameter ("configsNR")!=null){
            try{
                Integer temp = Integer.valueOf((String)request.getParameter("configsNR"));
                configurations_per_table = temp.intValue();
            } catch (NumberFormatException  e){
                e.printStackTrace();
            }
        }

        //There is another url, this one will help us to return from the actions jsp
        Enumeration p=request.getParameterNames();

        url2="FindEquipmentConfiguration.jsp?";
        while (p.hasMoreElements()){
	        String s=p.nextElement().toString();
	        if (!s.equals("navegar")){
		        url2=url2.concat(s+"="+request.getParameter(s)+"&");
	        }
        }

        if (order == null)
	        order = (String)session.getAttribute("OrderCustomers");
        if (order == null)
	        session.setAttribute("OrderCustomers","EquipmentName"); //default order field
        else
	        session.setAttribute("OrderCustomers",order);

        if (request.getParameter("currentPosition")!=null)
  	        currentPosition=(Integer.valueOf(request.getParameter("currentPosition")).intValue());
        else
  	        currentPosition=0;
 
        if (session.getAttribute("currentPosition")==null) {
       	    if (currentPosition!=0) {
      		    session.setAttribute("currentPosition",(Integer.toString(currentPosition)));
        	}
        }

        if (session.getAttribute("ReverseCustomers")==null) {
  	        if (reverse==null) {
    		    session.setAttribute("ReverseCustomers","false"); //default order
    	    } else {
    		    session.setAttribute("ReverseCustomers",reverse);
    	    }
    } else {
	    if (reverse!=null) {
    		session.setAttribute("ReverseCustomers",reverse);
	    }
    }


    SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
     if (navegar!=null && navegar.equals("1")) {
      		eqconfigs=(EquipmentConfiguration[]) session.getAttribute("acl");
      } else {
      	    
            eqconfigs = EquipmentConfigurationWrapper.findByAttributesWithName (connection,             
            request.getParameter ("EquipmentName"),
                    null,
                    null,
            request.getParameter ("Version"),
            request.getParameter ("MemoryType"),
            request.getParameter ("CreatedBy"),
            request.getParameter ("ModifiedBy"),
            request.getParameter ("exact") != null && request.getParameter ("exact").equals ("yes"),
            (String)session.getAttribute("OrderCustomers"),
	        (String)session.getAttribute("ReverseCustomers"));
            if (eqconfigs!=null){
		     session.setAttribute("eqconfigs",eqconfigs);
            }
      }
      if (eqconfigs != null){
          //---------------------------------------------------
          ArrayList configList = new ArrayList();
          PreparedStatement  pstmt = null;
          ResultSet          rset = null;
          String  RetrievalName = request.getParameter("RetrievalName");
          String  TimeStampHigh = request.getParameter("TimeStampHigh");
          String  TimeStampLow = request.getParameter("TimeStampLow");
          String select_stmt ="select b.creationtime,b.createdby, b.eqid, b.retrievalname, b.comments from v_backupref b where ";
          String select_stmt_original = "";
          boolean bMatchExactly = (request.getParameter ("exact") != null && request.getParameter ("exact").equals ("yes"));
	      if ((TimeStampLow != null)&&(TimeStampHigh != null) && !(TimeStampHigh.equalsIgnoreCase("")) && !(TimeStampLow.equalsIgnoreCase("")))
				select_stmt+="TO_DATE(creationtime) BETWEEN TO_DATE('"+ TimeStampLow + "', 'yyyy.mm.dd') AND TO_DATE('"+ TimeStampHigh + "', 'yyyy.mm.dd') and ";
	      if (((TimeStampLow == null)|| (TimeStampLow.equalsIgnoreCase("")))&&(TimeStampHigh != null) && !(TimeStampHigh.equalsIgnoreCase("")))
				select_stmt+="TO_DATE(creationtime) <= TO_DATE('"+ TimeStampLow + "', 'yyyy.mm.dd') and ";
	      if ((TimeStampLow != null)&&((TimeStampHigh == null)||(TimeStampHigh.equalsIgnoreCase(""))) && !(TimeStampLow.equalsIgnoreCase("")))
				select_stmt+="TO_DATE(creationtime) >= TO_DATE('"+ TimeStampLow + "', 'yyyy.mm.dd')  and ";
          if (RetrievalName != null && !RetrievalName.equalsIgnoreCase(""))
				select_stmt+="RetrievalName " + (!bMatchExactly ? " like '%'||" : " = ") +"'"+ RetrievalName +"'"+ (!bMatchExactly ? "||'%' and " : " and ");
          select_stmt_original = select_stmt;
          for(int i = 0; i < eqconfigs.length; i++){
              select_stmt= select_stmt_original + " b.configtime=to_date('"+eqconfigs[i].getTimestamp()+"','yyyy.mm.dd HH24:mi:ss') order by b.creationtime desc";
              pstmt = connection.prepareStatement (select_stmt);
              rset = pstmt.executeQuery();
                      if ( rset.next() ){
                        do{
                          ConfigLine temp = new ConfigLine();
                          
                          temp.setTimestamp(rset.getTimestamp(1));
                          temp.setCreatedBy(rset.getString(2));
                          temp.setEquipmentID(rset.getString(3));
                          temp.setVersion(eqconfigs[i].getVersion());
                          temp.setData(eqconfigs[i].getData());
                          temp.setRetrievalName(rset.getString(4));
                          temp.setMemoryType(eqconfigs[i].getMemorytype());
                          temp.setModifiedBy(eqconfigs[i].getModifiedby());
                          temp.setComment(rset.getString(5));
                          if ((com.hp.ov.activator.cr.inventory.NetworkElement)routers.get(temp.getEquipmentID())!=null)
                            temp.setEquipmentName(((com.hp.ov.activator.cr.inventory.NetworkElement)routers.get(temp.getEquipmentID())).getName());
                          configList.add(temp);
                        }while (rset.next());
                      }
                      if (rset  != null)
                            rset.close();
                       if (pstmt != null)
                            pstmt.close();
          }

                   if (configList.size() > 0){
                        acl = new ConfigLine[configList.size()];
                   }
                   else {
                        acl = null;
                   }
                  for(int i = 0; i < configList.size(); i++){
                        acl[i] = (ConfigLine)configList.get(i);
                   }
                   configList.clear();

 //---------------------------------------------------
      }


     if (acl == null) {
		%>
		<SCRIPT LANGUAGE="JavaScript">
			var fPtr = top.main.document;
		       fPtr.open();
		       fPtr.write("<bean:message bundle="InventoryResources" key="Backup.Find.Error.NoConfigFound" />");
		       fPtr.close();
		</SCRIPT>
<%
     }  else  {
     		int j = 0; // Counter for configurations
     		
		int aclLength = acl.length;
       	if ((currentPosition*configurations_per_table)>=aclLength)
        		currentPosition--;
		j=(currentPosition*configurations_per_table);		
		for (int k=0; k<aclLength; k++) {
		  if (equipmentNames.contains(acl[k].getEquipmentName())) {
			length++;
		  }
		}
%>
		<table width="100%" border="0" cellpadding="0">
  			<tr>
				<td class="mainHeading" align="center" colspan=8> <bean:message bundle="InventoryResources" key="Backup.list.EquipmentConfigurations" /> (<%= j+1 %>/<%= length%>)</td>
  			</tr>
           	<tr>
				<td align="left" class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.List.Name" /></td>
				<td align="left" class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.List.TimeStamp" /></td>
				<td align="left" class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.List.RetrievalType" /></td>
				<td align="left" class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.List.MemoryType" /></td>
				<td align="left" class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.List.Version" /></td>
				<td align="left" class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.List.CreateBy" /></td>
				<td align="left" class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.List.ModifyBy" /></td>
        	</tr>
				<!--table id="equipmentTable" width="100%" border="0" cellpadding="0"-->
			<%
    			int numRows=1, tmp = 0;
				checkRowsExist = true;
                boolean reduced = false;

			    for (int counter=0; counter<configurations_per_table && j<acl.length; j++, counter++) {
				  String rowClass= (numRows%2 == 0) ? "tableEvenRow" : "tableOddRow";
			%>
				
				<%
                    com.hp.ov.activator.cr.inventory.NetworkElement nes = null;
                    if (equipmentNames.contains(acl[j].getEquipmentName())) {
                        nes = com.hp.ov.activator.cr.inventory.NetworkElement.findByNetworkelementid(connection,"networkID='"+acl[j].getEquipmentID()+ "' state in ('Up', 'Reserved') and LifeCycleState != 'Planned'");
                        if( nes!=null){

				%>
				<tr id="equipmentRow<%=tmp%>" class="<%=rowClass%>" align="center" align="middle"  
				     onclick="rowSelect(this);"				  
				     onMouseOver="mouseOver(this);" 
					 onMouseDown="setMenuName('equipmentMenu');top.messageLine.location.href='msgLine.jsp?menuType=1&equipmentID=<%= URLEncoder.encode(acl[j].getEquipmentID(), "UTF-8") %>&equipmentName=<%= URLEncoder.encode(acl[j].getEquipmentName(), "UTF-8") %>&timestamp=<%= sdf.format(acl[j].getTimestamp())%>';"
					 onMouseOut="mouseOut(this);">
					<td class="tableCell" align="left"><%=acl[j].getEquipmentName() %>&nbsp;</td>
					<td class="tableCell" align="left">&nbsp;<%= sdf.format(acl[j].getTimestamp()) %>&nbsp;</td>
					<td class="tableCell" align="left">&nbsp;<%=acl[j].getRetrievalName()%>&nbsp;</td>
					<td class="tableCell" align="left">&nbsp;<%= acl[j].getMemoryType() != null ? acl[j].getMemoryType().toLowerCase()  : "" %>&nbsp;</td>
					<td class="tableCell" align="left">&nbsp;<%= acl[j].getVersion() %>&nbsp;</td>
					<td class="tableCell" align="left">&nbsp;<%= acl[j].getCreatedBy() %>&nbsp;</td>
					<td class="tableCell" align="left">&nbsp;<%= acl[j].getModifiedBy() != null ? acl[j].getModifiedBy() : "" %></td>
					<% /* ACTIONS */%>
					<% /* END ACTIONS */%>
				</tr>
				
			<%
			            tmp++;

                        } else {
                            nes = com.hp.ov.activator.cr.inventory.NetworkElement.findByNetworkelementid(connection,acl[j].getEquipmentID());
                            if( nes!=null){


				%>
				<tr id="equipmentRow<%=tmp%>" class="<%=rowClass%>" align="center" align="middle"
				     onclick="rowSelect(this);"
				     onMouseOver="mouseOver(this);"
					 onMouseDown="setMenuName('equipmentMenuReduced');top.messageLine.location.href='msgLine.jsp?menuType=1&equipmentID=<%= URLEncoder.encode(acl[j].getEquipmentID(), "UTF-8") %>&equipmentName=<%= URLEncoder.encode(acl[j].getEquipmentName(), "UTF-8") %>&timestamp=<%= sdf.format(acl[j].getTimestamp())%>';"
					 onMouseOut="mouseOut(this);">
					<td class="tableCell" align="left"><%=acl[j].getEquipmentName() %>&nbsp;</td>
					<td class="tableCell" align="left">&nbsp;<%= sdf.format(acl[j].getTimestamp()) %>&nbsp;</td>
					<td class="tableCell" align="left">&nbsp;<%=acl[j].getRetrievalName()%>&nbsp;</td>
					<td class="tableCell" align="left">&nbsp;<%= acl[j].getMemoryType() != null ? acl[j].getMemoryType().toLowerCase()  : "" %>&nbsp;</td>
					<td class="tableCell" align="left">&nbsp;<%= acl[j].getVersion() %>&nbsp;</td>
					<td class="tableCell" align="left">&nbsp;<%= acl[j].getCreatedBy() %>&nbsp;</td>
					<td class="tableCell" align="left">&nbsp;<%= acl[j].getModifiedBy() != null ? acl[j].getModifiedBy() : "" %></td>
					<% /* ACTIONS */%>
					<% /* END ACTIONS */%>
				</tr>

			<%
			                    tmp++;
                            }
                    }
                    }


				numRows ++;
			}
			%>
			<!--/table-->	
		</table>	
        	<br>

<%
     }
  }
  catch (Exception e) {
	e.printStackTrace();%>
			<SCRIPT LANGUAGE="JavaScript">
				var fPtr = top.messageLine.document;
		       	fPtr.open();
		       	fPtr.write("<bean:message bundle="InventoryResources" key="Backup.Find.Error.query" />");
		       	fPtr.close();
			</SCRIPT>	
<%
  }
  finally {
       if (ps != null)
            ps.close();
       if(rs != null)
            rs.close();
       if(connection != null)
            connection.close();
  }
%>
</center>

<!-- hidden until menu is selected -->
     <div id="equipmentMenu" class="contextMenu"
          onclick="hideContextMenu('equipmentMenu')">
            <a href='UpdateFormEquipmentConfiguration.jsp' target="main"
               class="menuItem"
               onmouseover="toggleHighlight(event)"
               onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.Clone" /></a>

             <hr>
	      <a href='UpdateFormEquipmentConfiguration.jsp?only_conf=true&view=true' target="main"
	         class="menuItem"
	         onmouseover="toggleHighlight(event)"
                 onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Show.button.ShowConfig" /></a>

             <hr>
	      <a href='UpdateFormEquipmentConfiguration.jsp?only_conf=true' target="main"
	         class="menuItem"
	         onmouseover="toggleHighlight(event)"
                 onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.Edit" /></a>

             <hr>
	     <a href='DeleteObjectConfirm.jsp?all=false&deleteClass=equipment' target="main"
	     	class="menuItem"
	     	onmouseover="toggleHighlight(event)"
                onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.Delete" /></a>

             <hr>
	     <a href='ShowEquipmentConfiguration.jsp' target="main"
	     	class="menuItem"
	     	onmouseover="toggleHighlight(event)"
                onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.RestoreConfig" /></a>

             <hr>
	     <a href='ShowMemoryTypesForAudit.jsp' target="main"
	     	class="menuItem"
	     	onmouseover="toggleHighlight(event)"
                onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.Audit" /></a>

    </div>

    <div id="equipmentMenuReduced" class="contextMenu"
          onclick="hideContextMenu('equipmentMenu')">
            <a href='UpdateFormEquipmentConfiguration.jsp' target="main"
               class="menuItem"
               onmouseover="toggleHighlight(event)"
               onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.Clone" /></a>

             <hr>
	      <a href='UpdateFormEquipmentConfiguration.jsp?only_conf=true&view=true' target="main"
	         class="menuItem"
	         onmouseover="toggleHighlight(event)"
                 onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Show.button.ShowConfig" /></a>

             <hr>
	      <a href='UpdateFormEquipmentConfiguration.jsp?only_conf=true' target="main"
	         class="menuItem"
	         onmouseover="toggleHighlight(event)"
                 onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.Edit" /></a>

             <hr>
	     <a href='DeleteObjectConfirm.jsp?all=false&deleteClass=equipment' target="main"
	     	class="menuItem"
	     	onmouseover="toggleHighlight(event)"
                onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.Delete" /></a>
    </div>

	<script language="JavaScript">
      window.onload = function () {
	    window.menuName = "equipmentMenu";
	    <%
		if (checkRowsExist && acl!=null) {
		  for(int index=0; index < configurations_per_table && index < length; index++) {
		%>
	        document.getElementById('equipmentRow<%=index%>').oncontextmenu = showContextMenu;
		<%
		   }
		}
		%>
      }


  </script>
</body>
</html>

