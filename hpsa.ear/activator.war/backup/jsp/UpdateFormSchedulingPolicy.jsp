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

	SimpleDateFormat df = (SimpleDateFormat)DateFormat.getDateInstance(DateFormat.SHORT);
    SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);
%>

<html>
<% /* JPM New */ %>
<head>
	<script language="JavaScript" src="../../javascript/table.js"></script>	
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
	<link rel="stylesheet" type="text/css" href="../../css/spainTable.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">

 <!-- calendar stylesheet -->
  <link rel="stylesheet" type="text/css" media="all" href="../../css/calendar-win2k-1.css" title="win2k-cold-1" />

  <!-- main calendar program -->
  <script type="text/javascript" src="../../javascript/calendar.js"></script>

  <!-- language for the calendar -->
  <script type="text/javascript" src="../../javascript/calendar-en.js"></script>

  <!-- the following script defines the Calendar.setup helper function, which makes
       adding a calendar a matter of 1 or 2 lines of code. -->
  <script type="text/javascript" src="../../javascript/calendar-setup.js"></script>

</head>
<% 
	String schedulingName = null;

	// Get name of scheduling policy
	schedulingName = URLDecoder.decode(request.getParameter("schedulingName"), "UTF-8");
%>

<script language="JavaScript">
   function changePeriodicityChoice(list){
        var menu = document.getElementById('periodicityInMinutes');
        var bNr = document.getElementById('backupNumber');
        var currSelected = list.selectedIndex
        var text = list.options[currSelected].text
        if (text == "Custom"){
            menu.style.display = ''
            menu.style.visibility = "visible"           
            bNr.className = "tableEvenRow"
        }
        else {
            menu.style.visibility = "hidden"
            menu.style.display = "none"
            document.getElementById('periodicity').value=""
            bNr.className = "tableOddRow"
        }
    }

        function checkFields(form){
	        var ret = false;
	        var retB = false;
            var str = form.periodicity.value;
            var bNr = form.backupsnumber.value;
            var newStr = "";
            if (form.periodicity_select.selectedIndex != 0){
	         	ret = true;   
	        }
	            else{
            if (str.length == 1){
                if (str.charAt(0) == 0){
                    alert('<bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.alert.Periodicity" />');
                    ret = false;
                } else if(str.charAt(0) > '0' && str.charAt(0) <= '9'){
                       ret=true;
                    }else{
                    alert('<bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.alert.Periodicityfield" />');                    
                    ret=false;	                    
	                    }
            }else if(str.length > 1){
                for(i = 0; i < str.length; i++){
                    if(str.charAt(i) >= '0' && str.charAt(i) <= '9'){
                        newStr = newStr + str.charAt(i);
                    }
                }
                if(str != newStr) {
                    alert('<bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.alert.Periodicityfield" />');
                    str.value = newStr;
                    ret=false;
                }else{
                     ret=true;
                }
            }
            else {
                alert('<bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.alert.Periodicityfield" />');
                ret=false;
            }
        }
            newStr = "";
            if (bNr.length == 1){
                if (bNr.charAt(0) == 0){
                    alert('<bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.alert.Nrgreaterthan" />');
                    retB = false;
                } else if(bNr.charAt(0) > '0' && bNr.charAt(0) <= '9'){
                       retB=true;
                  }
                  else{
                    alert('<bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.alert.Nrfield" />');                    
                    retB=false;	              	    
	              }
            }else if(bNr.length > 1){
                for(i = 0; i < bNr.length; i++){
                    if(bNr.charAt(i) >= '0' && bNr.charAt(i) <= '9'){
                        newStr = newStr + bNr.charAt(i);
                    }
                }
                if(bNr != newStr) {
                    alert('<bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.alert.Nrfield" />');
                    bNr.value = newStr;
                    retB=false;
                }else{
                     retB=true;
                }
            }
            else {
                alert('<bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.alert.Nrfield" />');
                retB=false;
            }            
            
            
            var result = false;
            if (ret == true && retB == true) {
                result = true;
            }
        return result;            
    }

</script>

<body>
<center>
	<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.backup.SchedulingPolicy" />
	<jsp:setProperty name="bean" property="schedulingpolicyname"/>

	<h2 class="mainSubHeading"><bean:message bundle="InventoryResources" key="Backup.UpdateCommitSchedulingPolicy.title" /></h2>

<% /* JPM New */ %>
<jsp:useBean id="menuBackupBean" scope="session" class="com.hp.ov.activator.vpn.backup.servlet.menuBackupBean" />
<% /* String schedulingName = menuBackupBean.getSchedulingPolicy(); */ %>

<%
   DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);    
   Connection con = null;
   try {
	con = (Connection)dataSource.getConnection();  
	 // JPM New
	 //bean = (com.hp.ov.activator.vpn.backup.SchedulingPolicy) com.hp.ov.activator.vpn.backup.SchedulingPolicy.findByPrimaryKey (con, bean.getSchedulingpolicyname());

     	if (schedulingName == null || schedulingName.equals(""))
   	{
%>
       	<SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
           	alert("You must first select a scheduling policy to modify.");
       	</script>
<%
	}  else  {
	 bean =  com.hp.ov.activator.vpn.backup.SchedulingPolicy.findByPrimaryKey (con, schedulingName.trim());
	 SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
	 if (bean == null) { %>No such Scheduling Policy. <%} else { %>

	<form name="form" method="POST" action="UpdateCommitSchedulingPolicy.jsp" onSubmit="return checkFields(this);">
	<table align="center" width=70% border=0 cellpadding=0 cellspacing=0>
  		<tr>
			<td class="mainHeading" align="center" colspan=3><bean:message bundle="InventoryResources" key="Backup.UpdateCommitSchedulingPolicy.title" /></td>
		</tr>
		<tr class="tableOddRow">
			<td colspan="3" class="tableCell">&nbsp;</th>
  		</tr>
		<tr class="tableEvenRow">
    			<td class="tableCell">&nbsp;</td>
			<td class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.PolicyName" /></b></td>
			<td class="tableCell"><%= bean.getSchedulingpolicyname() %>
				<input type="hidden" name="schedulingpolicyname" value="<%= bean.getSchedulingpolicyname() %>"></td>
		</tr>
		<tr class="tableOddRow">
			<td class="tableCell">&nbsp;</td>
			<td class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.StartingTime" /> (yyyy/mm/dd hh:mm)</b></td>
			<td class="tableCell">
				<input type="text"  name="startingtime" id = "starttime" value="<%= sdf.format(bean.getStartingtime()) == null ? "" : "" + sdf.format(bean.getStartingtime()) %>" size="20" readOnly>
				<img src="../../images/date_select.gif" id="buttonEndDate" class="dateInputTriger"/>
				</td>
		</tr>
        
        <%
        long periodicity = bean.getPeriodicity();
        boolean selectedC = true;
        boolean selectedD = false;
        boolean selectedW = false;
        boolean selectedM = false;

        if (periodicity == 1440){
            selectedD = true;
            selectedC = false;
        }
        if (periodicity == 1440*7){
            selectedW = true;
            selectedC = false;
        }
        if (periodicity == 1440*30){
            selectedM = true;
            selectedC = false;
        }
        %>
		<tr class="tableEvenRow">
    		<td width="10%" class="tableCell">&nbsp;</td>
    		<td width="30%" class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.Periodicity" /></b></td>
    		<td width="50%" class="tableCell">
            <select class="tableCell" name="periodicity_select" onChange="changePeriodicityChoice(this)">
    		    <option <%= selectedC ? "selected" : "" %>>Custom</option>
                <option <%= selectedD ? "selected" : "" %>>Daily</option>
                <option <%= selectedW ? "selected" : "" %>>Weekly</option>
                <option <%= selectedM ? "selected" : "" %>>Monthly</option>
            </select>
            </td>           		
  	    </tr>

        <tr class="tableOddRow" id="periodicityInMinutes">
			<td class="tableCell">&nbsp;</td>
			<td class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.Periodicity" /> (minutes)</b></td>
			<td class="tableCell">
				<input type="text" id="periodicity" name="periodicity" value="<%= bean.getPeriodicity()  %>" size="20"></td>
		</tr>

		<!--tr class="tableOddRow">
			<td class="tableCell">&nbsp;</td>
			<td class="tableCell"><b>Refresh Interval</b></td>
			<td class="tableCell">
				<input type="text"  name="refreshinterval" value="<%= bean.getRefreshinterval()  %>" size="20"></td>
		</tr-->
		<tr class="tableOddRow" id="backupNumber">
			<td class="tableCell">&nbsp;</td>
			<td class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.BackupNumber" /></b></td>
			<td class="tableCell">
				<input type="text"  name="backupsnumber" value="<%= bean.getBackupsnumber()  %>" size="20"></td>
		</tr>
		<tr class="tableEvenRow">
			<td colspan="3" class="tableCell">&nbsp;</td>
		</tr>

         <%
        if (selectedC == false){
        %>
           <script language="JavaScript">
                var menu = document.getElementById('periodicityInMinutes');
                var bNr = document.getElementById('backupNumber');
                menu.style.display = 'none'
                menu.style.visibility = "hidden"
                bNr.className = "tableOddRow"
           </script>
        <%}%>

</table>
	<p>
	<input type="submit" name="update" value="<bean:message bundle="InventoryResources" key="Backup.UpdateSchedulingPolicy.button" />">
	</p>
</form>

<%
   } //else
 } //else
	} catch (Exception e) { %>	   
 <script language="JavaScript">	 
 	var fPtr = top.frames['messageLine'].document;					  
    fPtr.open();
    fPtr.write("<bean:message bundle="InventoryResources" key="Backup.UpdateSchedulingPolicy.Error.retrievingscheduling" />");
    fPtr.close();	
 </script>	   
<% } finally {
	if (con != null)
	   con.close();
   }
 %>
</center>
<script>
Calendar.setup({
    inputField     :    "starttime",
    ifFormat       :    "yyyy.MM.dd HH:mm", 
    daFormat       :    "<%=df.toPattern()%>",
    firstDay       :    1,
    showsTime      :    true,
    timeFormat     :    "24",
    button         :    "buttonEndDate",
    align          :    "Bl",
    singleClick    :    true
  });
</script>
</body>
</html>
