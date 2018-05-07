<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>

<%
//  int rowCounter=0;
//  boolean allowPeriodicity = false;
%>
<%@page import = "java.text.*" %>

   <link rel="stylesheet" type="text/css" href="css/calendar-win2k-1.css" title="win2k-cold-1" />

  <!-- main calendar program -->
  <script type="text/javascript" src="javascript/calendar.js"></script>

  <!-- language for the calendar -->
  <script type="text/javascript" src="javascript/calendar-en.js"></script>

  <!-- the following script defines the Calendar.setup helper function, which makes
       adding a calendar a matter of 1 or 2 lines of code. -->
  <script type="text/javascript" src="javascript/calendar-setup.js"></script>
	
	<script LANGUAGE="JavaScript" TYPE="text/javascript">
  function trim(s) {
    while (s.substring(0,1) == ' ') {
      s = s.substring(1,s.length);
    }
    while (s.substring(s.length-1,s.length) == ' ') {
      s = s.substring(0,s.length-1);
    }
    return s;
  }
  
  function checkPeriodicity(){
    var startTime = getObjectById("StartTime").value;
    var endTime = getObjectById("EndTime").value;
    var isPeriodic = getObjectById("isPeriodic");
    var duration = getObjectById("Duration").value;
    var period = getObjectById("Period");
    if(trim(startTime) != "" && trim(endTime) != ""){
      isPeriodic.disabled = false;
      
    }else{
      isPeriodic.selectedIndex = 0;
      isPeriodic.disabled = true;
      switchPeriodic("false");

    }

  }
  
  
  function switchPeriodic(on){
    var duration = getObjectById("Duration");
    var period = getObjectById("Period");
    if(on == "true"){
      duration.disabled = false;
      period.disabled = false;
    }else{
      duration.disabled = true;
      period.disabled = true;
    }
    
  }

  function isIE_browser() {
    if (window.XMLHttpRequest) {
        return false;
  }	else {
        return true;
  }
}


function getObjectById(Id) {
	if(isIE_browser()) {
        return document.getElementById(Id);
	} else {
        if(document.getElementById(Id)!==null){
			return document.getElementById(Id);
		} else {
            return document.getElementsByName(Id);
		}
	}
}


</script>
<%
   SimpleDateFormat df = (SimpleDateFormat)DateFormat.getDateInstance(DateFormat.SHORT);
   SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);
  %>
<tr>
    <th class="left" colspan=4><bean:message key="lbl.sched.Info" /></th>
</tr>
<tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="lbl.str.time" /></b></td>
    <td align=left class="list<%= (rowCounter % 2) %>">
	<%        
	          //String start = (String) serviceParameters.get ("StartTime");  ------ PR 16616
	          String start = request.getParameter ("SP_StartTime");
          if (start == null) {
           // start = request.getParameter ("SP_StartTime"); //to be changed
           // if (start == null) {
              start = "";
           //                   }
                          }
 %>
      <input id="StartTime" name="SP_StartTime"  value="<%= start == null ? "" : start %>" title="yyyy.MM.dd HH:mm:ss NOW: Leave the field empty" onChange="checkPeriodicity()" readOnly>
	  <img src="images/date_select.gif" id="buttonStartDate" />&nbsp;&nbsp;
	  <font face="Verdana"><small><B><a href="#" onclick= "clearCalendar('StartTime','SP_StartTime');" style=Color:blue > <bean:message key="calendar.reset.field"/> </a>
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  </tr>
  <% rowCounter++; %>

    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="lbl.end.time" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
	     <%        //String end = (String) serviceParameters.get ("EndTime");
	                 String end = request.getParameter ("SP_EndTime"); 
          if (end == null) {           
              end = "";                         
                      } 
 %>
        <input id="EndTime" name="SP_EndTime" value="<%= end == null ? "" : end %>"  title="yyyy.MM.dd HH:mm:ss IGNORE: Leave the field empty" onChange="checkPeriodicity()" readOnly>
		<img src="images/date_select.gif" id="buttonEndDate" />&nbsp;&nbsp;
		<font face="Verdana"><small><B><a href="#" onclick= "clearCalendar('EndTime','SP_EndTime');" style=Color:blue > <bean:message key="calendar.reset.field"/> </a>
      </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    </tr>

  <% rowCounter++;
    if(allowPeriodicity){
  %>

    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="lbl.periodic" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
        <select id="isPeriodic" name="SP_isPeriodic"  disabled onChange="switchPeriodic(this.value)">
          <option value="false">No</option>
          <option value="true">Yes</option>
        </select>
      </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    </tr>

  <% rowCounter++; %>

    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="lbl.repeat" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
        <select id="Period" name="SP_Period"  disabled>

		  <option value="daily">Daily</option>
          <option value="weekly">Weekly</option>
          <option value="monthly">Monthly</option>
        </select>
      </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    </tr>

  <% rowCounter++; %>

    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="lbl.until" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
        <input id="Duration" name="SP_Duration" disabled value=""  title="yyyy.MM.dd HH:mm:ss" readOnly>
		<img src="images/date_select.gif" id="buttonDuration" />&nbsp;&nbsp;
		<font face="Verdana"><small><B><a href="#" onclick= "clearCalendar('Duration','SP_Duration');" style=Color:blue > <bean:message key="calendar.reset.field"/> </a>
      </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    </tr>

  <% rowCounter++;
    }
  %>

<script>
Calendar.setup({
    inputField     :    "StartTime",
    ifFormat       :    "yyyy.MM.dd HH:mm:ss", 
    daFormat       :    "<%=df.toPattern()%>",
    firstDay       :    1,
    showsTime      :    true,
    timeFormat     :    "24",
    button         :    "buttonStartDate",
    align          :    "Bl",
    singleClick    :    true
  });

Calendar.setup({
    inputField     :    "EndTime",
    ifFormat       :    "yyyy.MM.dd HH:mm:ss", 
    daFormat       :    "<%=df.toPattern()%>",
    firstDay       :    1,
    showsTime      :    true,
    timeFormat     :    "24",
    button         :    "buttonEndDate",
    align          :    "Bl",
    singleClick    :    true
  });

	Calendar.setup({
    inputField     :    "Duration",
    ifFormat       :    "yyyy.MM.dd HH:mm:ss", 
    daFormat       :    "<%=df.toPattern()%>",
    firstDay       :    1,
    showsTime      :    true,
    timeFormat     :    "24",
    button         :    "buttonDuration",
    align          :    "Bl",
    singleClick    :    true
  });

function clearCalendar(Id,fieldname)
		   {
				var timeObj = getObjectById(Id);
				if(timeObj!=null)
			   {
					timeObj.value = "";
			   }

		   }


</script>
