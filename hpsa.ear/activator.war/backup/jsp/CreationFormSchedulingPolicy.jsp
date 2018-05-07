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
         info="Creation Equipment Configuration" 
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
    if (session == null || session.getAttribute(com.hp.ov.activator.mwfm.servlet.Constants.USER) == null) {
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
	/* JPM New */
    	// dont cache the page
	response.setDateHeader("Expires", 0);
    	response.setHeader("Pragma", "no-cache");
%>

<body>
	<h2 class="mainSubHeading"><center><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.title" /></center></h2>
<center>

<table align="center" width=80% border=0 cellpadding=0>
  <form id="form" name="form" method="POST" action="CreationCommitSchedulingPolicy.jsp" onSubmit="return checkFields(this)">

  <tr>
	<td class="mainHeading" align="center" colspan=4><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.NEW" /></td>
  </tr>

   <tr>
    	<td class="mainHeading">&nbsp;</td>
    	<td class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.Field" /></td>
    	<td class="mainHeading"><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.Value" /></td>
    	<td class="mainHeading">&nbsp;</td>
   </tr>

<script>
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
            var retSch = false;
            var ret = false;
            var strSch = form.schname.value;            
            if(window.RegExp){
            	var regstr = "^[a-zA-Z0-9._-]*$" ;
            	var reg = new RegExp(regstr);

            	if (strSch.length > 0){
	        		if(reg.test(strSch)) {
                		retSch = true;
            		}  else{
                		alert("Wrong symbols in the scheduling policy name.\nAllowed characters:\n- The uppercase letters 'A' through 'Z';\n- The lowercase letters 'a' through 'z';\n- The digits '0' through '9';\n- The characters '._-'.");
                		retSch = false;
            		}
            	
             
            	} else{
                	alert('<bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.alert.policyname" />');
                	retSch=false;
            	}
			}
           
			if (form.periodicity_select.selectedIndex != 0){
	         	ret = true;   
	        }
	        else{			
            	var str = form.periodicity.value;
            	var newStr = "";
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
        	
        	
            var newStrB = "";
            var retB = false;
            var bNr = form.backupsnumber.value;
            if (bNr.length == 1){
                if (bNr.charAt(0) == 0){
                    alert('<bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.alert.Nrgreaterthan" />');
                    retB = false;
                } else if(bNr.charAt(0) > '0' && bNr.charAt(0) <= '9'){
                       retB=true;
                  }else{
                    alert('<bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.alert.Nrfield" />');                    
                    retB=false;	              	    
	              }
            }else if(bNr.length > 1){
                for(i = 0; i < bNr.length; i++){
                    if(bNr.charAt(i) >= '0' && bNr.charAt(i) <= '9'){
                        newStrB = newStrB + bNr.charAt(i);
                    }
                }
                if(bNr != newStrB) {
                    alert('<bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.alert.Nrfield" />');
                    bNr.value = newStrB;
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
            if (retSch == true && ret == true && retB == true) {
                result = true;
            }
        return result;
    }
</script>

  <tr class="tableEvenRow">
    <td width="10%" class="tableCell">&nbsp;</td>
    <td width="50%" class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.PolicyName" /></b></td>
    <td width="30%" class="tableCell"><input id="schname"  type="text" name="schedulingpolicyname" size="20"></td>
    <td width="10%" class="tableCell">&nbsp;</td>
  </tr>


  <tr class="tableOddRow">
    <td class="tableCell">&nbsp;</td>
    <td class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.StartingTime" /> (yyyy/mm/dd hh:mm)</b></td>
    <td class="tableCell"><input  type="text"  name="startingtime" id='starttime' readOnly>
	<img src="../../images/date_select.gif" id="buttonEndDate" class="dateInputTriger"/>
	</td>
    <td class="tableCell">&nbsp;</td>
  </tr>

  	<tr class="tableEvenRow">
    		<td width="10%" class="tableCell">&nbsp;</td>
    		<td width="30%" class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.Periodicity" /></b></td>
    		<td width="50%" class="tableCell">
            <select class="tableCell" name="periodicity_select" onChange="changePeriodicityChoice(this)">
    		    <option selected>Custom</option>
                <option>Daily</option>
                <option>Weekly</option>
                <option>Monthly</option>
            </select>
            </td>
    		<td width="10%" class="tableCell">&nbsp;</td>
  	</tr>
<tr class="tableOddRow" id="periodicityInMinutes">
    <td class="tableCell">&nbsp;</td>
    <td class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.Periodicity" /> (minutes)</b></td>
    <td class="tableCell"><input  type="text" id="periodicity" name="periodicity" height="1" size="20"></td>
    <td class="tableCell">&nbsp;</td>
  </tr>
<tr  class="tableEvenRow" id="backupNumber">
    <td class="tableCell">&nbsp;</td>
    <td class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.BackupNumber" /></b></td>
    <td class="tableCell"><input  type="text"  id="backupsnumber" name="backupsnumber" value="5" size="20"></td>
    <td class="tableCell">&nbsp;</td>
  </tr>
  <tr class="tableEvenRow">
  	<td class="tableCell" colspan="4">&nbsp;</td>
  </tr>

  <tr>
    <td height="10" colspan="3" align="right">
  </tr>

</table>
	<input type="submit" name="create" value="<bean:message bundle="InventoryResources" key="Backup.CreateFormRetrievalPolicy.Create" />" >


</form>
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
