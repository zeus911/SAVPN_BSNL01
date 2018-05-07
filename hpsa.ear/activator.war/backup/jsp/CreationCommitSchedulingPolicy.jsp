<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,
                java.sql.*, 
				javax.sql.DataSource,
                java.net.*, 
                java.text.*,
                 java.util.Calendar,
                 java.util.GregorianCalendar"        
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
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    }

    request.setCharacterEncoding("UTF-8");
%>

<html>
<head>
	<script language="JavaScript" src="../../javascript/checks.js"></script> 
    <script language="JavaScript" src="../../javascript/saNavigation.js"></script>
 	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
</head>

<body>
	<h2 class="mainSubHeading"><center><bean:message bundle="InventoryResources" key="Backup.CreateCommitScheduling.title" /></center></h2>

<%
java.util.Date StartingTime = null;
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
    } else {
        date = sdf1.format(currentDate);
        StartingTime = sdf1.parse(date,new java.text.ParsePosition(0));
    }

}
catch (Exception e) {e.printStackTrace();
%>
<center><bean:message bundle="InventoryResources" key="Backup.CreateCommitScheduling.Error.modify" /></center> 
<%}%>

<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.backup.SchedulingPolicy" />


<jsp:setProperty name="bean" property="schedulingpolicyname"/>
<jsp:setProperty name="bean" property="startingtime" value="<%= StartingTime %>"/>
<jsp:setProperty name="bean" property="refreshinterval"/>
<jsp:setProperty name="bean" property="backupsnumber"/>

<% 		DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);
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
     		bean.store (con);
 %>

<hr>

<SCRIPT LANGUAGE="JavaScript">
	var fPtr = top.messageLine.document;
       fPtr.open();
       fPtr.write("<bean:message bundle="InventoryResources" key="Backup.CreateCommitScheduling.storesuccess" />");
       fPtr.close();
       top.main.location='FindSchedulingPolicy.jsp';
	   menuSelect(top.leftFrame.document.getElementById("listSchTab"));
</SCRIPT>

<%  	} catch (Exception e) { e.printStackTrace();%>
       		<center><bean:message bundle="InventoryResources" key="Backup.CreateCommitScheduling.storedError" /></center> 
<% 		} finally {
			if(con!=null)
       			con.close();
   		} %>
</body>
</html>