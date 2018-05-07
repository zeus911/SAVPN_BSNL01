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
                java.text.*,
                 java.util.StringTokenizer"
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
       response.sendRedirect (".../../jsp/sessionError.jsp");
       return;
    } 
	response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<html>
<head>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
	<script language="JavaScript" src="../../javascript/saNavigation.js"></script>
 	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
</head>

<body>
	<h2 class="mainSubHeading"><center>Create Equipment Back-up</center></h2>
<%

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
    java.util.Date TimeStamp = new java.util.Date();
    java.util.Date LastAccessTime = new java.util.Date();
    java.util.Date configTime = new java.util.Date();
    String Data= "";
    if(request.getParameter("timestamp") !=  null){
        TimeStamp = sdf.parse(request.getParameter("timestamp"));
    }
    if(request.getParameter("lastAccessTime") != null){
        LastAccessTime = sdf.parse(request.getParameter("lastAccessTime"));
    }
    if(request.getParameter("configTime") != null){
        configTime = sdf.parse(request.getParameter("configTime"));
    }
    if(request.getParameter("data") != null){
        Data = (new String(request.getParameter("data")));
    }
    String modified = "";
    if (request.getParameter("modifiedBy") != null)
        modified = new String(request.getParameter("modifiedBy"));


    // If only_conf = true, only the equipment configuration will be update
    String only_conf = request.getParameter("only_conf");
    if (only_conf == null) only_conf = "false";

%>

<jsp:useBean id="configLine" scope="request" class="com.hp.ov.activator.vpn.backup.ConfigLine" />
<jsp:setProperty name="configLine" property="equipmentName"/>
<jsp:setProperty name="configLine" property="equipmentID"/>
<jsp:setProperty name="configLine" property="timestamp" value="<%= TimeStamp %>"/>
<jsp:setProperty name="configLine" property="data" value="<%= Data %>"/>
<jsp:setProperty name="configLine" property="lastAccessTime" value="<%=  LastAccessTime %>"/>
<jsp:setProperty name="configLine" property="configTime" value="<%=  configTime %>"/>
<jsp:setProperty name="configLine" property="retrievalName"/>
<jsp:setProperty name="configLine" property="memoryType"/>
<jsp:setProperty name="configLine" property="createdBy"/>
<jsp:setProperty name="configLine" property="modifiedBy" value="<%=(String) modified %>"/>
<jsp:setProperty name="configLine" property="version"/>
<jsp:setProperty name="configLine" property="comment"/>

<%

   DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);
   Connection connection = null;
  PreparedStatement ps = null;
   int majorVersion,minorVersion;
   try {
     connection = (Connection) dataSource.getConnection(); 
	 com.hp.ov.activator.cr.inventory.NetworkElement ane = com.hp.ov.activator.cr.inventory.NetworkElement.findByNetworkelementid(connection, configLine.getEquipmentID());
	 BackupRef[] ref = BackupRef.findAll(connection, "configtime=to_date('"+sdf.format(configLine.getConfigTime()) + "','yyyy.mm.dd hh24:mi:ss') and eqid='"+configLine.getEquipmentID()+"'");
       
         if (only_conf != null && only_conf.equals("true")) {

      if (ref != null && ref.length == 1){
       
          EquipmentConfigurationWrapper ec = EquipmentConfigurationWrapper.findByPrimaryKeys(connection, configLine.getEquipmentID(), configLine.getConfigTime());
            if(Data == null) {
                ec.setData("");
            }else{
                ec.setData(configLine.getData());
            }
          ec.setLastaccesstime(sdf.format(configLine.getLastAccessTime()));
          ec.setModifiedby(configLine.getModifiedBy());
		      ec.setVersion(configLine.getVersion());
		      StringTokenizer st = new StringTokenizer(configLine.getVersion(), ".");
		      majorVersion = (new Integer(st.nextToken())).intValue();
		      minorVersion = (new Integer(st.nextToken())).intValue();
		      if (minorVersion == 9)
		      {
	       		majorVersion += 1;
		       	minorVersion = 0;
		       }else
              minorVersion += 1;
		      ec.setVersion(majorVersion + "." + minorVersion);
          ec.update(connection);
          ps = connection.prepareStatement("update v_backupref set  comments='"+configLine.getComment()+"',retrievalname='EDIT' where createdby='"+configLine.getCreatedBy()+"' and creationtime=to_date('"+sdf.format(configLine.getTimestamp())+"','yyyy.mm.dd hh24:mi:ss') and eqid='"+configLine.getEquipmentID()+"'");
          ps.executeUpdate();
          ps.close();
      }   else if (ref!=null && ref.length > 1){
          EquipmentConfigurationWrapper ec = EquipmentConfigurationWrapper.findByPrimaryKeys(connection, configLine.getEquipmentID(), configLine.getConfigTime());
           if (ec == null)
                ec = new EquipmentConfigurationWrapper();
            if(Data == null) {
                ec.setData("");
            }else{
                ec.setData(configLine.getData());
            }
            
          ec.setLastaccesstime(sdf.format(configLine.getLastAccessTime()));
          ec.setModifiedby(configLine.getModifiedBy());
	      StringTokenizer st = new StringTokenizer(configLine.getVersion(), ".");
		  majorVersion = (new Integer(st.nextToken())).intValue();
		  minorVersion = (new Integer(st.nextToken())).intValue();
		  
		  if (minorVersion == 9)
		  {
			majorVersion += 1;
			minorVersion = 0;
		  }
		  else
              minorVersion += 1;
		      ec.setVersion(majorVersion + "." + minorVersion);
          ec.setTimestamp(sdf.format(configLine.getLastAccessTime()));
          ec.setDirtyflag("");
          ec.setLastaccesstime(sdf.format(new java.util.Date()));
          ec.store(connection);
          ps = connection.prepareStatement("update v_backupref set  comments='"+configLine.getComment()+"',retrievalname='EDIT', configtime=to_date('"+sdf.format(configLine.getLastAccessTime())+"','yyyy.mm.dd hh24:mi:ss') where createdby='"+configLine.getCreatedBy()+"' and creationtime=to_date('"+sdf.format(configLine.getTimestamp())+"','yyyy.mm.dd hh24:mi:ss') and eqid='"+configLine.getEquipmentID()+"'");
          ps.executeUpdate();
          ps.close();
      }
         } else if (only_conf != null && only_conf.equalsIgnoreCase("false")){
            EquipmentConfigurationWrapper ec  = new EquipmentConfigurationWrapper();
            if(Data == null) {
                ec.setData("");
            }else{
                ec.setData(configLine.getData());
            }
            ec.setEquipmentid(configLine.getEquipmentID());
            ec.setCreatedby((String) session.getAttribute(Constants.USER));
            ec.setMemorytype(configLine.getMemoryType());
            ec.setTimestamp(sdf.format(configLine.getLastAccessTime()));
            ec.setLastaccesstime(sdf.format(new java.util.Date()));
            ec.store(connection);            
            String getComment = configLine.getComment();
            String eqnameSource = "";
             if (request.getParameter("equipmentNameSource") != null)
                eqnameSource = request.getParameter("equipmentNameSource");
            if (getComment == null && configLine.getRetrievalName().equalsIgnoreCase("CLONE")) {
                configLine.setComment("Cloned from the following config: \nTime Stamp: " + request.getParameter("timeDisplayed") + " \nSource: " + eqnameSource);
            }
             else if (getComment != null && configLine.getRetrievalName().equalsIgnoreCase("CLONE")){
                configLine.setComment(getComment +"\nCloned from the following config: \nTime Stamp: " + request.getParameter("timeDisplayed")+ " \nSource: " + eqnameSource);
            }

            ps = connection.prepareStatement("insert into v_backupref (ISPARENT__, configtime,createdby,creationtime,eqid,retrievalname,comments) values(0, to_date('"+sdf.format(configLine.getLastAccessTime())+"','yyyy.mm.dd hh24:mi:ss'), '"+configLine.getCreatedBy()+"' , to_date('"+sdf.format(new java.util.Date())+"','yyyy.mm.dd hh24:mi:ss'), '"+configLine.getEquipmentID()+"', '"+configLine.getRetrievalName()+"','"+configLine.getComment()+"')");
            ps.execute();

         }

	if (ane != null)
	  session.setAttribute("firstVendorTab",""+(String)ane.getVendor());

 %>
<!--EquipmentConfiguration stored successfully.-->
<hr>

<SCRIPT LANGUAGE="JavaScript">
   <%if (only_conf!=null && only_conf.equals("false") && configLine.getRetrievalName().equalsIgnoreCase("CLONE")) {%>
   	if (top.selectedMenu == top.leftFrame.document.getElementById("listTab")){
        var fPtr = top.messageLine.document;
        fPtr.open();
        fPtr.write("<bean:message bundle="InventoryResources" key="Backup.CreateCommitConfig.Error.cloned" />");
        fPtr.close();
	    top.main.location='../../jsp/saConfigFrame.jsp';
	    menuSelect(top.leftFrame.document.getElementById("listTab"));
    } else if (top.selectedMenu == top.leftFrame.document.getElementById("findTab")){
        var fPtr = top.messageLine.document;
        fPtr.open();
        fPtr.write("<bean:message bundle="InventoryResources" key="Backup.CreateCommitConfig.Error.cloned" />");
        fPtr.close();
        top.main.location='FindEquipmentConfiguration.jsp'	;
    }
   <%}else{%>
  if (top.selectedMenu == top.leftFrame.document.getElementById("listTab")){
	var fPtr = top.messageLine.document;
    fPtr.open();
    fPtr.write("<bean:message bundle="InventoryResources" key="Backup.CreateCommitConfig.Error.modified" />");
    fPtr.close();
	top.main.location='../../jsp/saConfigFrame.jsp';
  }
  else if (top.selectedMenu == top.leftFrame.document.getElementById("findTab")){
	var fPtr = top.messageLine.document;
    fPtr.open();
    fPtr.write("<bean:message bundle="InventoryResources" key="Backup.CreateCommitConfig.Error.modified" />");
    fPtr.close();
	top.main.location='FindEquipmentConfiguration.jsp'	;
  }
  else if (top.selectedMenu == top.leftFrame.document.getElementById("insertTab")){
	var fPtr = top.messageLine.document;
    fPtr.open();
    fPtr.write("<bean:message bundle="InventoryResources" key="Backup.CreateCommitConfig.Error.inserted" />");
    fPtr.close();
	top.main.location='../../jsp/saConfigFrame.jsp';
	menuSelect(top.leftFrame.document.getElementById("listTab"));
  }
  else {
	var fPtr = top.messageLine.document;
    fPtr.open();
    fPtr.write("<bean:message bundle="InventoryResources" key="Backup.CreateCommitConfig.Error.inserted" />");
    fPtr.close();
	top.main.location='../../jsp/saConfigFrame.jsp';
	menuSelect(top.leftFrame.document.getElementById("listTab"));
  }
  <%}%>
</SCRIPT>

<%  } catch (Exception e) {
		e.printStackTrace();
		%>
       <b><bean:message bundle="InventoryResources" key="Backup.CreateCommitConfig.Error.Stored" /></b>
<% } finally {
       if (ps != null)
        ps.close();

       if (connection != null)
        connection.close();
   }

%>
</body>
</html>
