<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="java.net.*,
                 java.text.*,
                 java.util.*,
                 com.hp.ov.activator.stats.OperatorTableDataProducer,
                 com.hp.ov.activator.mwfm.servlet.*,
                 com.hp.ov.activator.mwfm.engine.module.*,
                 com.hp.ov.activator.mwfm.* "
         info="Display operator filter." 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%!
    //I18N strings
    final static String header          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("730", "Operator Statistical Filter");
    final static String beginDate       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("573", "From");
    final static String beginDateTitle  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("574", "From date, format: {0}");
    final static String endDate         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("575", "To");
    final static String endDateTitle    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("576", "To date, format: {0}");
    final static String time            = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("577", "Time");
    final static String timeTitle       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("578", "Time format: {0}");
    final static String displayChart    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("731", "Display Chart");
    final static String wfSelection     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("732", "Workflow Selection");
    final static String available       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("584", "Available");
    final static String selected        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("585", "Selected");
    final static String servDisplay     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("580", "Chart Selection");
    final static String duration        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("733", "Workflow Duration Time");
    final static String serActivTime    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("734", "Activation Time");
    final static String nmWFActivation  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("735", "Number of Completed Jobs");
    final static String wfProcessingTime  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("736", "Workflow Processing Time");
    final static String wfPersistenceTime = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("737", "Workflow Persistence Time");
    final static String wfWaitTime      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("738", "Workflow Wait Time");
    final static String wfIdleTime      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("739", "Workflow Idle Time");
    final static String tableColumnSel  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("581", "Table Columns Selection");
    final static String timeUnit        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("593", "Time Unit");
    final static String minute          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("334", "Minute");
    final static String hour            = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("335", "Hour");
    final static String day             = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("336", "Day");
    final static String month           = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("338", "Month");
    final static String year            = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("594", "Year");
    final static String multiAxis       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("582", "Show multiple axes"); 
    final static String multiAxisTitle  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("583", "This will diplay chart with mutiple axis"); 
    final static String select          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("586", "Select"); 
    final static String remove          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("587", "Remove"); 
    final static String alert1          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("588", "Date must be specified when Time is used.");
    final static String notAdmin        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("596", "You are not administrator.");
    

    final static String submitForm      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("16", "Submit");
    final static String clearForm       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("595", "Clear form");

    final static String hostName        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("597", "Host");
    final static String allHosts        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("613", "All Hosts");
    final static String alert2          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("599", "Please select a host.");

%>
<%
    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(Constants.USER) == null) {
%>
    <script>
        opener.top.topFrame.location = opener.top.topFrame.location;
        window.close();
    </script>
<%
       return;
    }
    if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == false) {
%>
    <script>
        alert("<%=notAdmin%>");
        window.close();
    </script>
<%
       return;
    }

    WFManager wfm=null;
    try {
      wfm=(WFManager)session.getAttribute(Constants.MWFM_SESSION);
    } catch (Exception e) {
%>
    <SCRIPT LANGUAGE="JavaScript">
      alert("<%= ExceptionHandler.handle(e) %>");
      top.location.href = "..";
    </SCRIPT>
<%
      return;
    }

    Vector vct=wfm.getAllClusterNodes();
    SimpleDateFormat df = (SimpleDateFormat)DateFormat.getDateInstance(DateFormat.SHORT);
    SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);
    String tmp = request.getParameter("errorMsg");
    String errorMsg = URLDecoder.decode((tmp!=null?tmp:""), "UTF-8");

    Vector availWorkflows = (Vector) session.getAttribute(Constants.STAT_SERVLET_WORKFLOWS);
    if(availWorkflows == null){
        availWorkflows = new Vector();
        WorkflowDescriptor[] workflows = null;
        try {
            workflows = wfm.getWorkflows();
            if(workflows!=null){
                for(int i=0;i<workflows.length; i++){
                    availWorkflows.add(workflows[i]);
                }
            }
        }catch (Exception e) {
%>
    <SCRIPT LANGUAGE="JavaScript"> 
        alert("<%= ExceptionHandler.handle(e) %>"); 
        top.location.href = "..";
    </SCRIPT>
<%
        } 
    }else{
        //do we realy have defined workflows?
        availWorkflows = (Vector)availWorkflows.clone();
        WorkflowDescriptor[] workflows = null;
        try {
            workflows = wfm.getWorkflows();
            if(workflows!=null){
                //we are going to use only available workflows
                Vector col = new Vector();
                for(int i=0;i<workflows.length; i++){
                    col.add(workflows[i].name);
                }
                availWorkflows.retainAll(col);
             }else{
                //we have no workflows
                availWorkflows.clear();
            }
        }catch (Exception e) {
%>
    <SCRIPT LANGUAGE="JavaScript"> 
        alert("<%= ExceptionHandler.handle(e) %>"); 
        top.location.href = "..";
    </SCRIPT>
<%
        } 
    }
    
    HashMap availTbHeaders = OperatorTableDataProducer.getTableHeaders();
%>
<jsp:useBean id="operatorFilter" scope="session" class="com.hp.ov.activator.mwfm.servlet.operatorFilterBean"/>
<html>
<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
  <!-- calendar stylesheet -->
  <link rel="stylesheet" type="text/css" media="all" href="/activator/css/calendar-win2k-1.css" title="win2k-cold-1" />

  <script type="text/javascript" src="/activator/javascript/list.js"></script>

  <!-- main calendar program -->
  <script type="text/javascript" src="/activator/javascript/calendar.js"></script>

  <!-- language for the calendar -->
  <script type="text/javascript" src="/activator/javascript/calendar-en.js"></script>

  <!-- the following script defines the Calendar.setup helper function, which makes
       adding a calendar a matter of 1 or 2 lines of code. -->
  <script type="text/javascript" src="/activator/javascript/calendar-setup.js"></script>
  <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
</head>
<body onload="initTimeUnitDiv();init();" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<table cellpadding="0" cellspacing="0">
  <tr align=left>
    <td nowrap class="pageHead"><%=header%></td>
  </tr>
<%
    if(!errorMsg.equals("")){
%> 
  <Script LANGUAGE="JavaScript">
    window.resizeTo(429,763);
  </Script> 
  <tr align=left>
    <td nowrap class="error"><%=errorMsg%></td>
  </tr>
<%
    }
%>
   
</table>
<form name="inputForm" action="/activator/jsp/saOperatorFilterRedirect.jsp" method="POST" onsubmit="return checkForm()">
<%
  ClusterNodeBean cnb=null;

  if (vct.size()==1) {
    cnb=(ClusterNodeBean)vct.get(0);
%>
    <input type="hidden" name="hostName" value="<%=cnb.getHostName() %>">
<%
  }
%>
<table class="filterTable">
<tr>
  <td>
  <table>
  <tr>
    <td class="operatorFilterText" title="<%=hostName%>"><%=hostName%>:</td><td class="operatorFilterText">
<%
  String selHost=operatorFilter.getHostName(), name;

  if (vct.size()==1) {
    cnb=(ClusterNodeBean)vct.get(0);
%>
<%= cnb.getHostName() %>
<%
  } else {
%>
      <select name="hostName" size="1">
<%
    if (selHost=="") {
%>
      <option value="" selected><%=allHosts%></option>
<%
    } else {
%>
      <option value=""><%=allHosts%></option>
<%
    }

    Iterator it=vct.iterator();

    while (it.hasNext()) {
      cnb=(ClusterNodeBean)it.next();
      name=cnb.getHostName();
      if (name.compareToIgnoreCase(selHost)==0) {
%><option value="<%=name%>" selected><%=name%></option><%
      } else {
%><option value="<%=name%>"><%=name%></option><%
      }
    }
%>
    </select>
<%
  }
%>
    </td>
  </tr>
    
  <tr>
  <td class="operatorFilterText" title="<%=MessageFormat.format(beginDateTitle,new Object[]{df.toPattern()})%>"><%=beginDate%>:</td>
  <td title="<%=MessageFormat.format(beginDateTitle,new Object[]{df.toPattern()})%>"><input type="text" size="8" name="beginDate" title="<%=MessageFormat.format(beginDateTitle,new Object[]{df.toPattern()})%>" id='inputStartDate' value="<jsp:getProperty name="operatorFilter" property="beginDate" />"/>
    <img src="/activator/images/date_select.gif" id="buttonBeginDate" class="dateInputTriger"/></td>
  <td class="operatorFilterText" title="<%=MessageFormat.format(endDateTitle,new Object[]{df.toPattern()})%>"><%=endDate%>:</td>
  <td title="<%=MessageFormat.format(endDateTitle,new Object[]{df.toPattern()})%>">
    <input type="text" size="8" name="endDate" id='inputEndDate' title="<%=MessageFormat.format(endDateTitle,new Object[]{df.toPattern()})%>" value="<jsp:getProperty name="operatorFilter" property="endDate" />"/>
    <img src="/activator/images/date_select.gif" id="buttonEndDate" class="dateInputTriger"/></td>
  </td>
  </tr>
  <tr>
  <td class="operatorFilterText" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>"><%=time%>:</td>
  <td title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>">
    <input type="text" size="4" name="beginTime" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>" value="<jsp:getProperty name="operatorFilter" property="beginTime" />"/></td>
  <td class="operatorFilterText" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>"><%=time%>:</td>
  <td title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>">
    <input type="text" size="4" name="endTime" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>" value="<jsp:getProperty name="operatorFilter" property="endTime" />"/></td>
  </td>
  </tr>
  </table>
  </td>
</tr>
<tr height="35">
  <td><div class="operatorFilterHeader"><%=wfSelection%></div></td>
</tr>
<tr>
    <td nowrap class="operatorFilterText">
        <table>
        <tr><td class="operatorFilterText"><%=available%></td><td></td><td class="operatorFilterText"><%=selected%></td></tr>
        <tr>
        <td>
        <select name="wfName" size="4" style="width:175" multiple>
<%
        String[] selectedWorkflows = operatorFilter.getSelectedWorkflows();
        
        //we don't want to show all availabe workflows except selected
        for(int i=0;i<selectedWorkflows.length;i++){
            for (int j = 0; j < availWorkflows.size(); j++) {
                if(selectedWorkflows[i].equals(availWorkflows.get(j).toString())){
                    availWorkflows.remove(j);
                    break;
                }
            }
        }
        for (int i = 0; i < availWorkflows.size(); i++) {
%>
        <option id="wfname<%=i%>" value="<%=availWorkflows.get(i)%>" title="<%=availWorkflows.get(i)%>"><%=availWorkflows.get(i)%></option>
<%
        }
%>
        </select>
        </td>
        <td valign="center">
        <input type="button" title="<%=select%>" value=">" style="width:15px" onclick="moveDualList(this.form.wfName, this.form.selectedWorkflows, false)"><br>
        <input type="button" title="<%=remove%>" value="<" style="width:15px" onclick="moveDualList(this.form.selectedWorkflows, this.form.wfName, false)">
        </td>
        <td>
        <select name="selectedWorkflows" size="4" style="width:175" multiple>
<%
        for(int i=0;i<selectedWorkflows.length;i++){
%>
        <option value="<%=selectedWorkflows[i]%>"><%=selectedWorkflows[i]%></option>
<%      
        }
%>
        </select>
        </td>
        </tr>
        </table>
    </td>
</tr>
<tr height="35">
  <td><div class="operatorFilterHeader"><%=servDisplay%></div></td>
</tr>
<tr>
  <td>
    <table width="100%">
    <tr height="45">
        <td class="operatorFilterText" width="45%" title="<%=displayChart%>"><input type="checkBox" onclick="timeUnitDiv()" name="displayChart" value="checked" <%=operatorFilter.getDisplayChart()%>><%=displayChart%></td>
        <td>&nbsp;&nbsp;&nbsp;</td>
        <td class="operatorFilterText" title="<%=timeUnit%>">
          <div id="timeUnitDiv" >
          <%=timeUnit%>:&nbsp;&nbsp;<select name="timeUnit">
            <option value="<%=Calendar.MINUTE%>" <%=operatorFilter.getTimeUnit()==Calendar.MINUTE?"selected":""%>><%=minute %></option>
            <option value="<%=Calendar.HOUR_OF_DAY %>" <%=operatorFilter.getTimeUnit()==Calendar.HOUR_OF_DAY?"selected":""%>><%=hour %></option>
            <option value="<%=Calendar.DAY_OF_MONTH%>" <%=operatorFilter.getTimeUnit()==Calendar.DAY_OF_MONTH?"selected":""%>><%=day %></option>
            <option value="<%=Calendar.MONTH%>" <%=operatorFilter.getTimeUnit()==Calendar.MONTH?"selected":""%>><%=month %></option>
            <option value="<%=Calendar.YEAR%>" <%=operatorFilter.getTimeUnit()==Calendar.YEAR?"selected":""%>><%=year %></option>
          </select>
          <br height="10"/>
          <input type="checkBox" title="<%=multiAxisTitle%>" name="multiAxis" value="checked" <%=operatorFilter.getMultiAxis()%>><%= multiAxis%>
          </div>
        </td>
    </tr>
    </table>
  </td>
</tr>
<tr>
  <td class="operatorFilterText" title="<%=duration%>"><input type="checkBox" name="durationTime" value="checked" <%=operatorFilter.getDurationTime()%>><%= duration%></td>
</tr>
<tr>
  <td class="operatorFilterText" title="<%=serActivTime%>"><input type="checkBox" name="activationTime" value="checked" <%=operatorFilter.getActivationTime()%>><%=serActivTime%></td>
</tr>
<tr>
  <td class="operatorFilterText" title="<%=nmWFActivation%>"><input type="checkBox" name="workflowActivations" value="checked" <%=operatorFilter.getWorkflowActivations()%>><%=nmWFActivation%></td>
</tr>
<tr>
  <td class="operatorFilterText" title="<%=wfProcessingTime%>"><input type="checkBox" name="processingTime" value="checked" <%=operatorFilter.getProcessingTime()%>><%=wfProcessingTime%></td>
</tr>
<tr>
  <td class="operatorFilterText" title="<%=wfPersistenceTime%>"><input type="checkBox" name="persistenceTime" value="checked" <%=operatorFilter.getPersistenceTime()%>><%=wfPersistenceTime%></td>
</tr>
<tr>
  <td class="operatorFilterText" title="<%=wfWaitTime%>"><input type="checkBox" name="waitTime" value="checked" <%=operatorFilter.getWaitTime()%>><%=wfWaitTime%></td>
</tr>
<tr>
  <td class="operatorFilterText" title="<%=wfIdleTime%>"><input type="checkBox" name="idleTime" value="checked" <%=operatorFilter.getIdleTime()%>><%=wfIdleTime%></td>
</tr>
<tr height="35">
  <td title="<%=tableColumnSel%>"><div class="operatorFilterHeader"><%=tableColumnSel%></div></td>
</tr>
<tr>
    <td class="operatorFilterText" nowrap>
        <table>
        <tr><td class="operatorFilterText"><%=available%></td><td></td><td class="operatorFilterText"><%=selected%></td></tr>
        <tr>
        <td>
        <select name="tableHead" size="4" style="width:175" multiple>
<%
        String[] selectedTableHeaders = operatorFilter.getSelectedTableHeader();
        //here we don't want to display selected headers
        HashSet selectedTBHeads = new HashSet();
        for(int i=0;i<selectedTableHeaders.length;i++){
            selectedTBHeads.add(selectedTableHeaders[i]);
        }
        for (int i = 0; i < availTbHeaders.size(); i++) {
            if(!selectedTBHeads.contains(Integer.toString(i))){
%>
        <option value="<%=i%>"><%=availTbHeaders.get(new Integer(i))%></option>
<%
            }
        }
%>
        </select>
        </td>
        <td valign="center">
        <input type="button" title="<%=select%>" value=">" style="width:15px" onclick="moveDualList(this.form.tableHead, this.form.selectedTableHeader, true)"><br>
        <input type="button" title="<%=remove%>" value="<" style="width:15px" onclick="moveDualList(this.form.selectedTableHeader, this.form.tableHead, false)">
        </td>
        <td>
        <select name="selectedTableHeader" size="4" style="width:175" multiple>
<%
        for(int i=0;i<selectedTableHeaders.length;i++){
            int ind = Integer.parseInt(selectedTableHeaders[i]);
%>
        <option value="<%=selectedTableHeaders[i]%>"><%=availTbHeaders.get(new Integer(ind))%></option>
<%      
        }
%>
        </select>
        </td>
        <td valign="center">
        <BUTTON TYPE="button" style="height:20px;width:15px" onclick="moveVertList( this.form.selectedTableHeader, true)">
            <img src="/activator/images/up1.gif">
        </BUTTON>
        <br/>
        <BUTTON TYPE="button" style="height:20px;width:15px" onclick="moveVertList( this.form.selectedTableHeader, false)">
            <img src="/activator/images/down1.gif">
        </BUTTON>
        </td>
        </tr>
        </table>
    </td>
</tr>
<tr>
    <td>
        <table width="100%">
        <tr>
            <td align="left"><input type="button" value="<%=clearForm%>" onclick="clearForm()"></td>
            <td align="right"><input type="submit" value="<%=submitForm%>"></td>
        </tr>
        </table>
    </td>
</tr>
</table>
</form>
<script>
  Calendar.setup({
    inputField     :    "inputStartDate", 
    ifFormat       :    "<%=df.toPattern()%>",  
    daFormat       :    "<%=df.toPattern()%>",
    firstDay       :    1,
    showsTime      :    false,
    timeFormat     :    "24",
    button         :    "buttonBeginDate",
    align          :    "Bl",
    singleClick    :    true
  });

  Calendar.setup({
    inputField     :    "inputEndDate",
    ifFormat       :    "<%=df.toPattern()%>", 
    daFormat       :    "<%=df.toPattern()%>",
    firstDay       :    1,
    showsTime      :    false,
    timeFormat     :    "24",
    button         :    "buttonEndDate",
    align          :    "Bl",
    singleClick    :    true
  });

function prepareForm(){
  var list = document.inputForm.selectedTableHeader;
  for ( var j = 0; j < list.length; j++ ){
    if ( list[ j ] != null ){
      list.options[ j ].selected = true;
    }
  }
  var list = document.inputForm.selectedWorkflows;
  for ( var j = 0; j < list.length; j++ ){
    if ( list[ j ] != null ){
      list.options[ j ].selected = true;
    }
  }
}

function init(){
    initTimeUnitDiv();
    sortList(document.inputForm.tableHead);
    sortList(document.inputForm.selectedWorkflows);
    sortList(document.inputForm.wfName);
}

function initTimeUnitDiv(){
    var menu = document.getElementById('timeUnitDiv');
    if (<%=operatorFilter.getDisplayChart().equals("")%>) {
       // close menu
       menu.style.visibility = "hidden";
       menu.style.display = "none";
    } else {
       // open menu
       menu.style.display = 'block';
       menu.style.visibility = "visible";
    }
    var timeSelect = document.inputForm.timeUnit;
    if (( <%=operatorFilter.getTimeUnit()==-1%> )){
        timeSelect.options[ 2 ].selected = true;//we select hours by default
    }
}

function timeUnitDiv(){
    var menu = document.getElementById('timeUnitDiv');
    //determine if menu should be shownen
    if (!document.inputForm.displayChart.checked) {
       // close menu
       menu.style.visibility = "hidden";
       menu.style.display = "none";
    } else {
       // open menu
       menu.style.display = 'block';
       menu.style.visibility = "visible";
    }
}

  function checkForm(){
  
    if( document.inputForm.beginTime.value != "" &&
        document.inputForm.beginTime.value != " " &&
       (document.inputForm.beginDate.value == "" || 
        document.inputForm.beginDate.value == " ")){
      alert('<%=alert1%>');
      document.inputForm.beginDate.focus();
      return false;
    }
    if( document.inputForm.endTime.value != "" &&
        document.inputForm.endTime.value != " " &&
       (document.inputForm.endDate.value == "" || 
        document.inputForm.endDate.value == " ")){
      alert('<%=alert1%>');
      document.inputForm.endDate.focus();
      return false;
    }

<%
  if (vct.size()!=1) { %>
    if (document.inputForm.hostName.selectedIndex==-1) {
      alert('<%=alert2%>');
      return false;
    }
<%
  }
%>
    prepareForm();
    return true;
  }

function clearForm(){
<%
  if (vct.size()!=1) { %>
    document.inputForm.hostName.selectedIndex = 0;
<%
  }
%>
    document.inputForm.beginDate.value = " ";
    document.inputForm.endDate.value = " ";
    document.inputForm.beginTime.value = " ";
    document.inputForm.endTime.value = " ";
    document.inputForm.displayChart.checked = false;
    timeUnitDiv();
    document.inputForm.durationTime.checked = false;
    document.inputForm.activationTime.checked = false;
    document.inputForm.workflowActivations.checked = false;
    document.inputForm.processingTime.checked = false;
    document.inputForm.persistenceTime.checked = false;
    document.inputForm.waitTime.checked = false;
    document.inputForm.idleTime.checked = false;
    var list = document.inputForm.selectedTableHeader;
    prepareForm();
    moveDualList(document.inputForm.selectedTableHeader,document.inputForm.tableHead,false);
    moveDualList(document.inputForm.selectedWorkflows,document.inputForm.wfName,false);
}


</script>
</body>
</html>
