<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->

<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,com.hp.ov.activator.cr.inventory.*,com.hp.ov.activator.cr.inventory.Region,
                java.sql.*, 
                javax.sql.DataSource,
                java.util.*, 
                java.text.*,
                java.net.*,
                org.apache.log4j.*,
                java.io.*"
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

<%!HashMap showAllHM = new HashMap();


Logger logger = Logger.getLogger("BackupTest");
%>
<% /* JPM New */ %>
<%  SimpleDateFormat sdf_test = new SimpleDateFormat("hh:mm:ss");
    logger.debug("-------------------------------");
    logger.debug(sdf_test.format(new java.util.Date()) + ": FindEquipmentList.jsp....load");
%>
<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute (Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    } 

   request.setCharacterEncoding ("UTF-8");
   String name = (String)request.getParameter ("name");
   session.setAttribute("firstVendorTab",""+name);

	int maxConfigs = 5;
	int maxConfigs2 = 5;
    Vector routersVisible = new Vector();
	ConfigLine[] configlines = null;


    String showAll = "";
    Vector routerConfigs = new Vector();
	boolean equipExpand = false;
    Vector expandVector = new Vector();

    Hashtable configListLength = new Hashtable();

%>

 <% /* JPM New. Activate Bean */%>
<jsp:useBean id="menuBackupBean" scope="session" class="com.hp.ov.activator.vpn.backup.servlet.menuBackupBean" />
<% menuBackupBean.resetEquipmentName(); %>
<% menuBackupBean.resetTimestamp(); %>
<% menuBackupBean.resetEquipmentID(); %>




<html>
<head>
<% /* JPM New */ %>
	
	<script language="JavaScript" src="../../javascript/menu.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
  	<link rel="stylesheet" type="text/css" href="../../css/spainTable.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
	
	<link rel="stylesheet" type="text/css" href="../../css/saContextMenu.css">
	<script language="JavaScript" src="../../javascript/saUtilities.js"></script>
    <script language="JavaScript" src="../../javascript/saContextMenu.js"></script>
	<script language="JavaScript" src="../../javascript/backup.js"></script>


</head>

<body onload="loadMenus();"  onClick="hideContextMenu('equipmentMenu'); hideContextMenu('routerMenu');hideContextMenu('routerMenuReduced');hideContextMenu('equipmentMenuReduced')">
<center>

<%
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
    //SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
    WFManager wfm = (WFManager) session.getAttribute (Constants.MWFM_SESSION);
    String equipexp = (String) request.getParameter("equipExpand");

    if (equipexp != null) {
	    Boolean bCurrent = (Boolean) session.getAttribute("Equip"+equipexp);
	    bCurrent = (bCurrent == null || bCurrent.equals(Boolean.FALSE) ? Boolean.TRUE : Boolean.FALSE);
	    session.setAttribute("Equip"+equipexp, bCurrent);
    }
    DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);
    Connection connection = null;
    ResultSet rset = null;
    PreparedStatement pstmt = null;
    String imageDir = getServletConfig().getInitParameter("ACTIVATOR_WEB") + "/backup/images/";

    try {
        connection = (Connection)dataSource.getConnection();

%>
 <p>
   <table align="center" width=100% border=0 cellpadding=0>	
     <tr class="tableOddRow">			
	   <td colspan="8" class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.List.RouterName" /></td>
	 </tr>     
<%
    logger.debug(sdf_test.format(new java.util.Date()) + ": FindEquipmentList.jsp....request for selecting equipment names by manufacturer was sent...");
    Region[] regions = Region.findAll(connection);
    String roleClauseStart = "", roleClauseEnd = "", routersString = "";
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


        //pstmt = connection.prepareStatement("select cr_networkelement.networkelementid, name, schpolicyname from cr_networkelement, v_networkelement where v_networkelement.networkelementid=cr_networkelement.networkelementid and backup='1' and vendor=? "+roleClauseStart + roleClauseEnd);
       
       
       
       						pstmt = connection.prepareStatement("select distinct n.networkelementid, name from cr_networkelement n, v_PERouter p, v_Cerouter c , v_switch s " +
																							"where ( (n.networkelementid= p.networkelementid and p.backup='1') or " +
																							"(n.networkelementid= c.networkelementid and c.backup='1') or " +
																							"(n.networkelementid= s.networkelementid and s.backup='1')) and vendor = ? " +
																						  roleClauseStart + roleClauseEnd);
      
      
     
        pstmt.setString(1, name);
        rset = pstmt.executeQuery();
        if(rset.next()){
            do{
                com.hp.ov.activator.cr.inventory.NetworkElement router = new com.hp.ov.activator.cr.inventory.NetworkElement();
                router.setNetworkelementid(rset.getString(1));
                router.setName(rset.getString(2));
                //router.setSchpolicyname(rset.getString(3));
                routersVisible.add(router);
                routersString += " "+router.getName()+" ";
            } while(rset.next());
        }
		
		if(routersVisible ==null || routersVisible.size()==0){
			pstmt = connection.prepareStatement("select distinct n.networkelementid, n.name from cr_networkelement n " +
																							"where n.networkelementid IN (select networkelementid from v_perouter where backup = '1' and n.vendor = ?) or " +
																							"n.networkelementid IN (select networkelementid from v_switch where backup = '1' and n.vendor = ?)" +
																						  roleClauseStart + roleClauseEnd);
      
      
     
			pstmt.setString(1, name);
			pstmt.setString(2, name);
			rset = pstmt.executeQuery();
			if(rset.next()){
				do{
					com.hp.ov.activator.cr.inventory.NetworkElement router = new com.hp.ov.activator.cr.inventory.NetworkElement();
					router.setNetworkelementid(rset.getString(1));
					router.setName(rset.getString(2));
					//router.setSchpolicyname(rset.getString(3));
					routersVisible.add(router);
					routersString += " "+router.getName()+" ";
				} while(rset.next());
			}
		}
		
                   if (rset!=null){
                       rset.close();
                   }
                   if (pstmt != null){
                       pstmt.close();
                   }
        logger.debug(sdf_test.format(new java.util.Date()) + ": FindEquipmentList.jsp....equipment names were selected from DB. Router names: " + routersString);

       if (routersVisible != null){
            logger.debug(sdf_test.format(new java.util.Date()) + ": FindEquipmentList.jsp....start displaying equipment list & equipment configs");
   	        for(int A=0; A<routersVisible.size(); A++) {
                //empty previous config lines
                 configlines = null;
                logger.debug(".........................");
                boolean reduced = false;

				
                if (com.hp.ov.activator.cr.inventory.NetworkElement.findByNetworkelementid(connection,"networkID='"+((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid()+"' vendor ='"+name + "' and state in ('Up', 'Reserved') and LifeCycleState != 'Planned'")!=null){
                    reduced = false;
                }
   	               Boolean expEquip = (Boolean) session.getAttribute("Equip"+((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid());
   		           String equipimg = "../images/collapsed.gif" ;
  		           equipExpand = expEquip != null && expEquip.equals(Boolean.TRUE);
		           expandVector.addElement(expEquip);
		          //String n = null;
		           maxConfigs = 5;
                   logger.debug(sdf_test.format(new java.util.Date()) + ": FindEquipmentList.jsp....select configs from DB.....for " + ((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getName());
                   ArrayList configList = new ArrayList();
                   String selectSt = "select a.timestamp, to_char(b.creationtime,'yyyy.mm.dd HH24:mi:ss'), a.createdby, b.createdby, b.eqid," +
                           " a.version, a.data, a.lastaccesstime, b.retrievalname, a.memorytype, a.modifiedby, b.comments " +
                           "from v_equipmentconfiguration a, v_backupref b where b.configtime=to_date(a.timestamp,'yyyy-mm-dd HH24:mi:ss')";
                   pstmt = connection.prepareStatement (selectSt + " and b.eqid='"+((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid()+"' order by b.creationtime desc");
                   rset = pstmt.executeQuery();
                   if ( rset.next() ){
                        do{
                          ConfigLine temp = new ConfigLine();
                          
                          temp.setConfigTime(sdf.parse(rset.getString(1)));
                          temp.setTimestamp(sdf.parse(rset.getString(2)));                          
                          temp.setCreatedBy(rset.getString(4));
                          temp.setEquipmentID(rset.getString(5));
                          temp.setVersion(rset.getString(6));
                          temp.setData(rset.getString(7));
                          temp.setLastAccessTime(sdf.parse(rset.getString(8)));
                          temp.setRetrievalName(rset.getString(9));
                          temp.setMemoryType(rset.getString(10));
                          temp.setModifiedBy(rset.getString(11));
                          temp.setComment(rset.getString(12));
                          temp.setEquipmentName(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getName());
                          configList.add(temp);
                          logger.debug(sdf_test.format(new java.util.Date()) + ": FindEquipmentList.jsp....config line for " + temp.getEquipmentName()  +" "+temp.getTimestamp());
                        }while (rset.next());
                      }

                   if (rset!=null){
                       rset.close();
                   }
                   if (pstmt != null){
                       pstmt.close();
                   }
                   if (configList.size() > 0){
                        configlines = new ConfigLine[configList.size()];
                   }
                   else {
                        configlines = null;
                   }
                   for(int i = 0; i < configList.size(); i++){
                        configlines[i] = (ConfigLine)configList.get(i);
                   }

                   logger.debug(sdf_test.format(new java.util.Date()) + ": FindEquipmentList.jsp....configs from DB selected. Number of lines " + configList.size());

                   configList.clear();

		        if (configlines == null)
                    equipExpand = true;

   		        if (equipExpand) {
   		            equipimg = "../images/expanded.gif";
   		        }
    	
		        routerConfigs.addElement(configlines);
                   if(reduced == false){
%>
       					
	 <tr class="tableOddRow" onClick="rowSelect(this);"> 						
	   <td width="5%" class="tableCell"  align="center"><a href="FindEquipmentList.jsp?equipExpand=<%= ((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid()%>&name=<%=name%>&anchor=<%= ((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid()%>" name="<%= ((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid()%>"  onClick='clearMessageLine();'><img src="<%=equipimg %>" border="0" ></a></td>
	   <td colspan="7" class="tableCell" id="routerCell<%=A%>"
						    onMouseDown="setMenuName('routerMenu');
                                         hideContextMenu('equipmentMenu');hideContextMenu('routerMenuReduced');hideContextMenu('equipmentMenuReduced');
										 top.frames['messageLine'].location.href='msgLine.jsp?menuType=4&equipmentID=<%= URLEncoder.encode(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid(), "UTF-8") %>&equipmentName=<%= URLEncoder.encode(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getName(), "UTF-8") %>';"
			&nbsp;&nbsp;&nbsp;<img border=0 src="<%=new File (imageDir + name + ".gif").exists()?"../images/" + name + ".gif":"../images/router.gif"%>" alt="Equipment">
			&nbsp;<%= ((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getName()%></td>  	

<%
                   }else{   %>

	 <tr class="tableOddRow" onClick="rowSelect(this);">
	   <td width="5%" class="tableCell"  align="center"><a href="FindEquipmentList.jsp?equipExpand=<%= ((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid()%>&name=<%=name%>&anchor=<%= ((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid()%>" name="<%= ((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid()%>"  onClick='clearMessageLine();'><img src="<%=equipimg %>" border="0" ></a></td>
	   <td colspan="7" class="tableCell" id="routerCell<%=A%>"
						    onMouseDown="setMenuName('routerMenuReduced');
                                            hideContextMenu('equipmentMenu'); hideContextMenu('routerMenu');hideContextMenu('equipmentMenuReduced');
										   top.frames['messageLine'].location.href='msgLine.jsp?menuType=4&equipmentID=<%= URLEncoder.encode(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid(), "UTF-8") %>&equipmentName=<%= URLEncoder.encode(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getName(), "UTF-8") %>';"
			&nbsp;&nbsp;&nbsp;<img border=0 src="<%=new File (imageDir + name + ".gif").exists()?"../images/" + name + ".gif":"../images/router.gif"%>" alt="Equipment">
			&nbsp;<%= ((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getName()%></td>

<%                 }
                showAll = (String)request.getParameter("showAll" + ((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid());
		        if (showAll != null){
			        if (showAllHM.containsKey(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid()) == false || showAll.equals("false")){
				        showAllHM.put(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid(),showAll);
			        }
		        }
		        if(showAll == null || showAll.equals("null"))
		            showAll = "false";

                /*The boolean variable which can make ShowAll/Show Last 5 configs button to become invisible.*/
                boolean visibleShowBt = true;

                /*We find out what is the sheduled backups Nr for the equipment with assigned scheduling policy*/
                int sch_backups_nr = 0;
                int sch_pol_backups_nr = 0;
                String schpol_name = "";
                logger.debug(sdf_test.format(new java.util.Date()) + ": FindEquipmentList.jsp....start defining if the scheduling policy is assigned to equipment.....");
                //NetworkElement ne = com.hp.ov.activator.cr.inventory.NetworkElement.findByName(connection,(String)routersVisible.elementAt(A))[0];
               String id=((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid();
                com.hp.ov.activator.cr.inventory.NetworkElement ne = (com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A);
                if (ne != null)
                {
                	 	String role = ne.getRole();
               			if ((role!= null && role.equalsIgnoreCase("PE")))
											{
    										PERouter peBean = PERouter.findByPrimaryKey(connection, ne.getNetworkelementid());
    										schpol_name = peBean.getSchpolicyname();
          						}
          						if ((role!= null && role.equalsIgnoreCase("CE")))
											{
    										CERouter ceBean = CERouter.findByPrimaryKey(connection, ne.getNetworkelementid());
    										schpol_name = ceBean.getSchpolicyname();
          						}
          						if ((role!= null && (role.equalsIgnoreCase("AggregationSwitch") || role.equalsIgnoreCase("AccessSwitch")) ))
											{
    										Switch sBean = Switch.findByPrimaryKey(connection, ne.getNetworkelementid());
    										schpol_name = sBean.getSchpolicyname();
          						}
          						
                    //schpol_name = ((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getSchpolicyname();
                }
                if (schpol_name != null && schpol_name.trim().length()>0)
                    sch_pol_backups_nr = com.hp.ov.activator.vpn.inventory.SchedulingPolicy.findBySchedulingpolicyname(connection,schpol_name).getBackupsnumber();
                logger.debug(sdf_test.format(new java.util.Date()) + ": FindEquipmentList.jsp....scheduling policy defined: " + schpol_name + " with backups Nr " + sch_pol_backups_nr);
                /*To solve the situation when scheduled backups Nr is 5 but actual Nr of scheduled backups in Db is plus 1, e.g. 6*/
                if (configlines != null && configlines.length == 6){
                    if (sch_pol_backups_nr == 5){
                        for (int i = 0; i < configlines.length; i++){
                            if (configlines[i].getRetrievalName().equalsIgnoreCase("SCHEDULED_BACKUP"))
                                sch_backups_nr++;
                        }
                        if (sch_backups_nr == configlines.length)
                            visibleShowBt = false;
                    }
                
                }
                /*for further use*/
		        sch_backups_nr = 0;

		        if(equipExpand && configlines != null && configlines.length > 5 && visibleShowBt) {
		            if(showAll.equals("true") || (showAllHM.get(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid()) != null && ((String)showAllHM.get(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid())).equals("true")) ) {
		 
%>

	   <td  colspan=1 width="10%" align="center" class="tableCell" onMouseOut='actUnhighlight(this);'  onMouseOver='actHighlight(this);'><a  href="FindEquipmentList.jsp?showAll<%=((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid()%>=false&name=<%=name%>&anchor=<%=((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid()%>">Show Last 5</a></td>
	   
<%
		            }
		            else {
%>
	   <td colspan=1 width="10%" align="center" class="tableCell" onMouseOut='actUnhighlight(this);'  onMouseOver='actHighlight(this);'><a  href="FindEquipmentList.jsp?showAll<%=((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid()%>=true&name=<%=name%>&anchor=<%=((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid()%>">Show All</a></td>
	 
<%
		            }
	            }
%>							
	 </tr>    					
<%
	            if(equipExpand) {
	                if(configlines != null && configlines.length > 0) {
		            /* Establish maximum of configurations */
			            if(configlines.length < maxConfigs) {
			                maxConfigs = configlines.length;
			            }
			            else
			                if (configlines.length > maxConfigs) {
			                    if(showAll.equals("true")){				                   
				                    maxConfigs = configlines.length;
				                    showAllHM.put(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid(),showAll);
				                }
				                else
                                    if(showAllHM.get(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid()) != null){
					                    if( ((String)showAllHM.get(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid())).equals("true")){
						                    maxConfigs = configlines.length;
					                    }
				                    }
			                }

%>
	 <% /* Headers of configurations */ %>
	 <tr class="tableOddRow">
	   <td class="tableRowEmpty">&nbsp;</td>
	   <td class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.List.TimeStamp" /></td>
	   <td  class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.List.Version" /></td>
	   <td  class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.List.RetrievalType" /></td>
	   <td  class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.List.MemoryType" /></td>
	   <td  class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.List.CreateBy" /></td>
        <td width="20%" class="mainHeading" ><bean:message bundle="InventoryResources" key="Backup.List.Comment" /></td>
	 </tr>
<%
                        int actualLength = -1;
                        logger.debug(sdf_test.format(new java.util.Date()) + ": FindEquipmentList.jsp....the lines of configs are being drawn......");
                         
	    	            for(int B=0; B<maxConfigs; B++) {
                            if (configlines[B].getRetrievalName()!=null && configlines[B].getRetrievalName().equalsIgnoreCase("SCHEDULED_BACKUP") /*&& configlines[B].getCreatedBy().equalsIgnoreCase(schpol_name)*/)
                                sch_backups_nr++;

                            if((schpol_name == null || schpol_name.equalsIgnoreCase("-none-")) || (configlines[B].getRetrievalName()!=null && (!configlines[B].getRetrievalName().equalsIgnoreCase("SCHEDULED_BACKUP"))) || sch_backups_nr<=sch_pol_backups_nr /*|| (!configlines[B].getCreatedBy().equalsIgnoreCase(schpol_name))*/){
                                actualLength++;
   if( reduced == false){

%>
	 <tr id="equipmentRow<%=A%>_<%=actualLength%>" class="tableOddRow"
		 onClick="rowSelect(this);
             <%menuBackupBean.setEquipmentID(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid());menuBackupBean.setEquipmentName(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getName());menuBackupBean.setTimestamp(sdf.format(configlines[B].getTimestamp()));%>"
		 onMouseDown="setMenuName('equipmentMenu');
                      hideContextMenu('routerMenu');hideContextMenu('routerMenuReduced');hideContextMenu('equipmentMenuReduced');
					  top.frames['messageLine'].location.href='msgLine.jsp?menuType=1&equipmentID=<%= URLEncoder.encode(configlines[B].getEquipmentID(), "UTF-8") %>&timestamp=<%= sdf.format(configlines[B].getTimestamp())%>&equipmentName=<%= URLEncoder.encode(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getName(), "UTF-8") %>';"
		 onMouseOver="mouseOver(this);"
		 onMouseOut="mouseOut(this);">


       <td class="tableRowEmpty">&nbsp;</td>
	   <td class="tableCell"><%= sdf.format(configlines[B].getTimestamp())%></td>
	   <td class="tableCell"><%= configlines[B].getVersion()%></td>
	   <td class="tableCell"><%= configlines[B].getRetrievalName()%></td>
<%            
			                String mType = configlines[B].getMemoryType();
			                if(mType == null || mType.equals("null"))
				                mType = "";
%>
		<td class="tableCell"><%= mType%></td>
		<td class="tableCell"><%= configlines[B].getCreatedBy()%></td>
<%
			                String comment = configlines[B].getComment();
                            StringBuffer sb = new StringBuffer("");
                            String reduced_comment = "";
			                if(comment == null || comment.equalsIgnoreCase("null")){
				                comment = "";
                            } else{
                                sb.append(comment);
                                int size = sb.length();
                                if (size > 25){
                                    reduced_comment = sb.substring(0,24) + "...";
                                } else{
                                    reduced_comment = comment;
                                }


                            }
%>
        <td width="20%" class="tableCell" title="<%= comment%>"><%= reduced_comment%></td>
	 </tr>
<%       } else {
%>
	 <tr id="equipmentRow<%=A%>_<%=actualLength%>" class="tableOddRow"
		 onClick="rowSelect(this);
				  <%menuBackupBean.setEquipmentID(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid());menuBackupBean.setEquipmentName(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getName());menuBackupBean.setTimestamp(sdf.format(configlines[B].getTimestamp()));%>"
		 onMouseDown="setMenuName('equipmentMenuReduced');
                      hideContextMenu('equipmentMenu'); hideContextMenu('routerMenu');hideContextMenu('routerMenuReduced');
					  top.frames['messageLine'].location.href='msgLine.jsp?menuType=1&equipmentID=<%= URLEncoder.encode(configlines[B].getEquipmentID(), "UTF-8") %>&timestamp=<%= sdf.format(configlines[B].getTimestamp())%>&equipmentName=<%= URLEncoder.encode(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getName(), "UTF-8") %>';"
		 onMouseOver="mouseOver(this);"
		 onMouseOut="mouseOut(this);">


       <td class="tableRowEmpty">&nbsp;</td>
	   <td class="tableCell"><%= sdf.format(configlines[B].getTimestamp())%></td>
	   <td class="tableCell"><%= configlines[B].getVersion()%></td>
	   <td class="tableCell"><%= configlines[B].getRetrievalName()%></td>
<%
			                String mType = configlines[B].getMemoryType();
			                if(mType == null || mType.equals("null"))
				                mType = "";
%>
		<td class="tableCell"><%= mType%></td>
		<td class="tableCell"><%= configlines[B].getCreatedBy()%></td>
<%
			                String comment = configlines[B].getComment();
                            StringBuffer sb = new StringBuffer("");
                            String reduced_comment = "";
			                if(comment == null || comment.equalsIgnoreCase("null")){
				                comment = "";
                            } else{
                                sb.append(comment);
                                int size = sb.length();
                                if (size > 25){
                                    reduced_comment = sb.substring(0,24) + "...";
                                } else{
                                    reduced_comment = comment;
                                }


                            }
%>
        <td width="20%" class="tableCell" title="<%= comment%>"><%= reduced_comment%></td>
	 </tr>

<%   }
   }  // end of if
                            else{
                                if(configlines.length > maxConfigs) {
                                    if(showAll.equals("false")){
                                        maxConfigs++;
                                    }

			                }

                            }
	    	        } // end for configlines
                    logger.debug(sdf_test.format(new java.util.Date()) + ": FindEquipmentList.jsp....the lines of configs were drawn.");
                    configListLength.put(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid(), new Integer(actualLength));


    	        }   else{configListLength.put(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid(), new Integer(-1)); }
   		        // Establecer la expansion del
		        request.setAttribute("con", connection);
		        request.setAttribute("Equip", ""+((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(A)).getNetworkelementid());
		        request.setAttribute("class", "0");
    	    }
		    else { // no equipExpand
		    %>
<%
		     }
         } // end for routersVisible
    	 logger.debug(sdf_test.format(new java.util.Date()) + ": FindEquipmentList.jsp....equipment list & equipment configs were displayed.");

      // Establecer la expansion del ROUTER TYPE en la session
	  request.setAttribute("con", connection);
	  request.setAttribute("Device", ""+(String)name);
	  request.setAttribute("class", "0");	    			
%>
   </table>
<%
	// JPM New
	} //end if routersVisible
	else {
%>
   <SCRIPT LANGUAGE="JavaScript">
	 var fPtr = parent.frames['main'].document;
	 fPtr.open();
     fPtr.write("<center>"+"<bean:message bundle="InventoryResources" key="Backup.List.Error.NoEquipFound" />"+"</center>");
	 fPtr.close();
   </SCRIPT>
<%
	}
 %>
 </center>
 <!-- hidden until menu is selected -->
     <div id="equipmentMenu" class="contextMenu" >
            <a href='UpdateFormEquipmentConfiguration.jsp' target="displayFrame"
               class="menuItem"
               onmouseover="toggleHighlight(event)"
               onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.Clone" /></a>

             <hr>
	      <a href='UpdateFormEquipmentConfiguration.jsp?only_conf=true&view=true' target="displayFrame"
	         class="menuItem"
	         onmouseover="toggleHighlight(event)"
                 onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.View" /></a>

             <hr>
	      <a href='UpdateFormEquipmentConfiguration.jsp?only_conf=true' target="displayFrame"
	         class="menuItem"
	         onmouseover="toggleHighlight(event)"
                 onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.Edit" /></a>

             <hr>
	     <a href='DeleteObjectConfirm.jsp?all=false&deleteClass=equipment&equipmentType=<%=name%>' target="displayFrame"
	     	class="menuItem"
	     	onmouseover="toggleHighlight(event)"
                onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.Delete" /></a>

             <hr>
	     <a href='ShowEquipmentConfiguration.jsp' target="displayFrame"
	     	class="menuItem"
	     	onmouseover="toggleHighlight(event)"
                onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.RestoreConfig" /></a>

             <hr>
	     <a href='ShowMemoryTypesForAudit.jsp' target="displayFrame"
	     	class="menuItem"
	     	onmouseover="toggleHighlight(event)"
                onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.Audit" /></a>
    </div>

     <div id="equipmentMenuReduced" class="contextMenu" >
            <a href='UpdateFormEquipmentConfiguration.jsp' target="displayFrame"
               class="menuItem"
               onmouseover="toggleHighlight(event)"
               onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.Clone" /></a>

             <hr>
	      <a href='UpdateFormEquipmentConfiguration.jsp?only_conf=true&view=true' target="displayFrame"
	         class="menuItem"
	         onmouseover="toggleHighlight(event)"
                 onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.View" /></a>

             <hr>
	      <a href='UpdateFormEquipmentConfiguration.jsp?only_conf=true' target="displayFrame"
	         class="menuItem"
	         onmouseover="toggleHighlight(event)"
                 onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.Edit" /></a>

             <hr>
	     <a href='DeleteObjectConfirm.jsp?all=false&deleteClass=equipment&equipmentType=<%=name%>' target="displayFrame"
	     	class="menuItem"
	     	onmouseover="toggleHighlight(event)"
                onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.Delete" /></a>
    </div>

	<div id="routerMenu" class="contextMenu">

	     <a href='DeleteObjectConfirm.jsp?all=true&deleteClass=equipmentName' target="displayFrame"
	     	class="menuItem"
	     	onmouseover="toggleHighlight(event)"
                onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.DeleteAll" /></a>

             <hr>
	     <a href='AuditLastEquipmentConfiguration.jsp' target="displayFrame"
	     	class="menuItem"
	     	onmouseover="toggleHighlight(event)"
                onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.AuditLast" /></a>
    </div>

	<div id="routerMenuReduced" class="contextMenu" onclick="hideContextMenu('routerMenuReduced')">

	     <a href='DeleteObjectConfirm.jsp?all=true&deleteClass=equipmentName' target="displayFrame"
	     	class="menuItem"
	     	onmouseover="toggleHighlight(event)"
                onmouseout="toggleHighlight(event)"> <bean:message bundle="InventoryResources" key="Backup.Find.button.DeleteAll" /></a>

    </div>

</body>

<script language="JavaScript">
function loadMenus() {
<%
    logger.debug(sdf_test.format(new java.util.Date()) + ": FindEquipmentList.jsp....invisible menu is constructed....");
    if(routersVisible != null){
     for (int i = 0; i < routersVisible.size(); i++) {
         maxConfigs2 = 5;
        if ((Boolean)expandVector.elementAt(i) == Boolean.TRUE){
	     configlines = (ConfigLine[])routerConfigs.elementAt(i);

         Integer temp = (Integer)configListLength.get(((com.hp.ov.activator.cr.inventory.NetworkElement)routersVisible.elementAt(i)).getNetworkelementid());
         if (temp != null) {
            maxConfigs2 = temp.intValue();
         }
		   for (int j=0; j <= maxConfigs2; j++){
%>
			  document.getElementById('equipmentRow<%=i%>_<%=j%>').oncontextmenu = showContextMenu;
<%

		   }
        }
%>
	   document.getElementById('routerCell<%=i%>').oncontextmenu = showContextMenu;
<%

     }
   }   %>


}
</script>
<%    
   logger.debug(sdf_test.format(new java.util.Date()) + ": FindEquipmentList.jsp....invisible menu was constructed....");

  }  catch (Exception e) { e.printStackTrace();%>
<SCRIPT LANGUAGE="JavaScript">
	var fPtr =  top.messageLine.document;
	fPtr.open();
    fPtr.write("<bean:message bundle="InventoryResources" key="Backup.List.Error.query" />");
	fPtr.close();
</SCRIPT>




<%
  } finally {
      if (rset  != null)
         rset.close();
      if (pstmt != null)
         pstmt.close();
      if (connection != null)
  	     connection.close();
  }
%>



</html>
