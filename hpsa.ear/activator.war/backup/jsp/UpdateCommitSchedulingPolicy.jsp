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

<html>
<% /* JPM New */ %>
<head>
	<script language="JavaScript" src="../../javascript/table.js"></script>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
</head>

<body>
	<center><h2 class="mainSubHeading"><bean:message bundle="InventoryResources" key="Backup.UpdateCommitSchedulingPolicy.title" /></h2></center>

<%
java.util.Date StartingTime = null;
//Date StartingTime;
try
{
	long currTime = System.currentTimeMillis();
    Date currentDate = new Date(currTime);
    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy.MM.dd HH:mm");
    SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy.MM.dd");
    SimpleDateFormat sdf3 = new SimpleDateFormat("HH:mm");
    SimpleDateFormat sdf4 = new SimpleDateFormat("dd HH");
    SimpleDateFormat sdf5 = new SimpleDateFormat("yyyy.MM");

	String date = (String)request.getParameter("startingtime");
    if (date != null && !date.equals("")){
    StartingTime = sdf1.parse(date,new java.text.ParsePosition(0));

    if(StartingTime == null){
        StartingTime = sdf2.parse(date,new java.text.ParsePosition(0));
        if (StartingTime != null){
            date = date.trim().concat(" 00:00");
            StartingTime = sdf1.parse(date,new java.text.ParsePosition(0));
        } else {
           StartingTime = sdf3.parse(date,new java.text.ParsePosition(0));
            if(StartingTime != null){
                date = sdf2.format(currentDate).concat(" "+date.trim());
                StartingTime = sdf1.parse(date,new java.text.ParsePosition(0));
            }
            else{
                StartingTime = sdf4.parse(date,new java.text.ParsePosition(0));
                if(StartingTime != null){
                     date = sdf5.format(currentDate).concat("."+date.trim()).concat(":00");
                     StartingTime = sdf1.parse(date,new java.text.ParsePosition(0));
                }
            }
        }
    }
    }else{
       date = sdf1.format(currentDate);
       StartingTime = sdf1.parse(date,new java.text.ParsePosition(0));
    }

}
catch (Exception e) {e.printStackTrace();%>
    <center><bean:message bundle="InventoryResources" key="Backup.UpdateCommitSchedulingPolicy.Error.modify" /></center> 
    <%}
%>

<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.backup.SchedulingPolicy" />
<jsp:setProperty name="bean" property="schedulingpolicyname"/>
<jsp:setProperty name="bean" property="startingtime" value="<%=StartingTime %>"/>
<jsp:setProperty name="bean" property="refreshinterval"/>
<jsp:setProperty name="bean" property="backupsnumber"/>

<%


   DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);
   Connection con = null;
   try {
      String periodicity_select = (String)request.getParameter("periodicity_select");
      if(periodicity_select != null){
        	if (periodicity_select.trim().equalsIgnoreCase("daily"))
            	bean.setPeriodicity(1440);
        	if (periodicity_select.trim().equalsIgnoreCase("weekly"))
            	bean.setPeriodicity(1440*7);
        	if (periodicity_select.trim().equalsIgnoreCase("monthly"))
            	bean.setPeriodicity(1440*30);
        	if (periodicity_select.trim().equalsIgnoreCase("custom"))
        	 	bean.setPeriodicity((new Integer(((String)request.getParameter("periodicity")).trim()).intValue()));
   		}
     	con = (Connection)dataSource.getConnection();  		
     	bean.update (con);
	 	//com.hp.ov.activator.cr.inventory.NetworkElement[] ne = com.hp.ov.activator.cr.inventory.NetworkElement.findAll(con, "schpolicyname='"+bean.getSchedulingpolicyname()+"'");
	 	com.hp.ov.activator.vpn.inventory.Switch[] switchBean = com.hp.ov.activator.vpn.inventory.Switch.findAll(con, "schpolicyname='"+bean.getSchedulingpolicyname()+"'");
	 	com.hp.ov.activator.vpn.inventory.CERouter[] ceRouterBean = com.hp.ov.activator.vpn.inventory.CERouter.findAll(con, "schpolicyname='"+bean.getSchedulingpolicyname()+"'");
	 	com.hp.ov.activator.vpn.inventory.PERouter[] peRouterBean = com.hp.ov.activator.vpn.inventory.PERouter.findAll(con, "schpolicyname='"+bean.getSchedulingpolicyname()+"'");
	 	
	 	if(switchBean != null || ceRouterBean != null || peRouterBean != null){
         	SchSettings param = SchSettings.findByKey(con,"reload");
         	param.setValue("true");        
         	param.update(con); 			
  		}%>
  		
 <script language="JavaScript">	 
 	var fPtr = top.frames['messageLine'].document;					  
    fPtr.open();
    fPtr.write("<bean:message bundle="InventoryResources" key="Backup.UpdateCommitSchedulingPolicy.modifysuccess" />");
    fPtr.close();
	location.href ="FindSchedulingPolicy.jsp";
 </script>
<hr>
<%    
	} catch (Exception e) { 
		e.printStackTrace();%>
       <center><bean:message bundle="InventoryResources" key="Backup.UpdateCommitSchedulingPolicy.Error.modify" /></center>
<% } finally {
      if (con != null)
       con.close();
   } %>

</table>
</body>
</html>