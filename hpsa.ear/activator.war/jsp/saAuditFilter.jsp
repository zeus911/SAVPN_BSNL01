<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="java.net.*,
                 java.text.*,
                 java.util.*,
                 java.sql.*,
                 javax.sql.*,
                 com.hp.ov.activator.mwfm.servlet.*,
                 com.hp.ov.activator.mwfm.engine.module.*,
                 com.hp.ov.activator.mwfm.*"
         info="Display audit filter."
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%@page import="com.hp.ov.activator.audit.AuditValidationException"%>
<%@ taglib uri = "/WEB-INF/combotext-taglib.tld" prefix = "cmbtxt" %>
<%!

    //I18N strings
    
    final static String filterName        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1535", "Filter name");
    final static String filterSolution    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1536", "Filter solution");
    final static String filterRole        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1537", "Filter role");

    
    final static String header          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("618", "Audit Messages Filter");
    final static String identifier      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("415", "Service Id");
    final static String identifierTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("897", "Service Id to filter");
final static String orderId         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("919", "Order Id");
    final static String orderIdTitle    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1023", "Order Id to filter");
final static String workflowType    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("920", "Type");
    final static String workflowTypeTitle= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1025", "Workflow Type to filter");
final static String workflowState   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("921", "State");
    final static String workflowStateTitle= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1027", "Workflow State to filter");
    final static String eventType       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("621", "Event type");
    final static String eventTypeTitle  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("622", "Event type to filter");
    final static String beginDate       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("573", "From");
    final static String beginDateTitle  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("574", "From date, format: {0}");
    final static String endDate         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("575", "To");
    final static String endDateTitle    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("576", "To date, format: {0}");
    final static String className       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("623", "Class");
    final static String classNameTitle  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("624", "Class name to filter");
    final static String jobId           = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("146", "Job Id");
    final static String jobIdTitle      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("625", "Job Id to filter");
    final static String userName        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("88", "User");
    final static String userNameTitle   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("626", "User name to filter");
    final static String workflowName    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("6", "Workflow");
    final static String workflowNameTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("627", "Workflow to filter");
    final static String stepName        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("149", "Step");
    final static String stepNameTitle   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("628", "Step to filter");
    final static String message         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("150", "Message");
    final static String messageTitle    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("629", "Message to filter");
    final static String time            = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("577", "Time");
    final static String timeTitle       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("578", "Time format: {0}");
    final static String alert1          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("588", "Date must be specified when Time is used.");

    final static String loadForm      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1538", "Load");
    final static String deleteForm      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("190", "Delete");
    final static String saveForm      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1286", "Save");
    final static String submitForm      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("16", "Submit");
    final static String clearForm       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("595", "Clear form");

    final static String hostName        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("597", "Host");
    final static String allHosts        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("613", "All Hosts");
    final static String alert2          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("599", "Please select a host.");
    
    final static String errMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1539", "Unable to retrieve audit filters' data");
    final static String storeExecutedMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1540", "Filter stored in DB");
    final static String storeErrorMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1541", "Unable to store audit filter");
    final static String loadExecutedMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1542", "Filter loaded: ");
    final static String loadErrorMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1543", "Unable to load audit filter");
    final static String deleteExecutedMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1544", "Filter deleted");
    final static String deleteErrorMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1545", "Filter cannot be deleted");

    
    final static String REQUEST_OPERATION_SAVE = "save";
    final static String REQUEST_OPERATION_LOAD = "load";
    final static String REQUEST_OPERATION_DELETE = "delete";
    final static String REQUEST_LOADED_NAME = "loaded_filter_name";
    

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

    WFManager wfm=null;
    try {
      wfm=(WFManager)session.getAttribute(Constants.MWFM_SESSION);
    } catch (Exception e) {
%>
    <SCRIPT LANGUAGE="JavaScript">
      alert("<%= ExceptionHandler.handle(e) %>");
      top.location.href="..";
    </SCRIPT>
<%
      return;
    }

    // the jsp:setProperty is working wrong when overriding a vlue to ""
    // so we clean the object in session when name (mandatory field) is detected.
    if (request.getParameter("name") != null) {
      session.removeAttribute("auditFilter");
    }
    
%>
<jsp:useBean id="auditFilter" scope="session" class="com.hp.ov.activator.mwfm.servlet.auditFilterBean"/>
<jsp:setProperty name="auditFilter" property="*" />


<html>
<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
  <!-- calendar stylesheet -->
  <link rel="stylesheet" type="text/css" media="all" href="/activator/css/calendar-win2k-1.css" title="win2k-cold-1" />

  <!-- main calendar program -->
  <script type="text/javascript" src="/activator/javascript/calendar.js"></script>

  <!-- language for the calendar -->
  <script type="text/javascript" src="/activator/javascript/calendar-en.js"></script>

  <!-- the following script defines the Calendar.setup helper function, which makes
       adding a calendar a matter of 1 or 2 lines of code. -->
  <script type="text/javascript" src="/activator/javascript/calendar-setup.js"></script>
  <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
  <script type="text/javascript" src="/activator/javascript/hputils/hashMap.js"></script>
</head>
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();" onLoad="filter_changed()">

<%
 
  String user = (String) session.getAttribute(Constants.USER);
  UserManagementManager umm = wfm.getUMM();
  Vector vct=wfm.getAllClusterNodes();

%>
  
<script>
  function clearForm(){
    document.inputForm.identifier.value = "";
    document.inputForm.orderId.value = "";
    document.inputForm.workflowType.value = "";
    document.inputForm.workflowState.value = "";
    document.inputForm.eventType.value = "";
    document.inputForm.beginDate.value = "";
    document.inputForm.endDate.value = "";
    document.inputForm.beginTime.value = "";
    document.inputForm.endTime.value = "";
    document.inputForm.className.value = "";
    document.inputForm.jobId.value = "";
    document.inputForm.userName.value = "";
    document.inputForm.workflowName.value = "";
    document.inputForm.stepName.value = "";
    document.inputForm.message.value = "";
    document.inputForm.name.value = "";
    document.inputForm.solution.value = "";
    document.inputForm.role.options[0].selected = true;
  }

  function changeOperation (operation) {
	  document.getElementById('form_operation').value = operation;
    document.getElementById('inputForm').action = '/activator/jsp/saAuditFilter.jsp';
  }
  
  function filter_changed () {
    if (document.getElementById("name")) {
      _name = document.getElementById('name').value;
      _solution = document.getElementById('solution').value;
      id = (_solution == "" ? "" : _solution + "/") + _name
      if (filter_map.containsKey(id)) {
        document.getElementById('<%=loadForm%>').disabled = false;
        document.getElementById('<%=deleteForm%>').disabled = false;
<%
        // Creator check
        if (umm != null && !umm.isUserSuperUser(user)) {
%>
          if (filter_map.get(id) != '<%=user%>') {
        	  document.getElementById('<%=deleteForm%>').disabled = true;
          }
<%
        }
%>
      } else {
        document.getElementById('<%=loadForm%>').disabled = true;
        document.getElementById('<%=deleteForm%>').disabled = true;
      }

    } else {
      setTimeout("filter_changed()", 10)
    }



    
  }

  
</script>
<form name="inputForm" id="inputForm" action="/activator/jsp/saAuditFilterRedirect.jsp" method="POST" onsubmit="return checkForm();">
<%
 
  SimpleDateFormat df = (SimpleDateFormat)DateFormat.getDateInstance(DateFormat.SHORT);
  SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);
  String tmp = request.getParameter("errorMsg");
  String errorMsg = URLDecoder.decode((tmp!=null?tmp:""), "UTF-8");
  
  // Retrieving connection
  DataSource dataSource = (DataSource)session.getAttribute(Constants.DATASOURCE);
  Connection connection = null;
  try { 
  
    try { 
      connection = (Connection)dataSource.getConnection();
    } catch (Exception e) {}
    
    // input operation (load, delete, save or none)
    String operation = request.getParameter("operation");   
    boolean store_executed = false;
    String loaded_name = request.getParameter(REQUEST_LOADED_NAME);
    boolean load_executed = (loaded_name != null && !loaded_name.equals("")); 
    boolean delete_executed = false;
    
    if (REQUEST_OPERATION_SAVE.equals(operation)) {
      try {
        auditFilter.setCreator(user);
        auditFilter.store(connection, umm, load_executed, loaded_name);
        store_executed = true;
        load_executed = false;
%>        
        <script>
        window.opener.location.href = window.opener.location.href;
        </script>
<%              
      } catch (AuditValidationException sqla) {
%>        
        <script>
        location.href="saAuditFilter.jsp?errorMsg=<%=sqla.getMessage()%>";
        </script>
<%        
        return;
      } catch (SQLException sqle) {
%>        
        <script>
        location.href="saAuditFilter.jsp?errorMsg=<%=storeErrorMsg%>";
        </script>
<%        
        System.out.println("Database error: " + sqle.getMessage());
      }
    } else if (REQUEST_OPERATION_LOAD.equals(operation)) {
      
      try {
        auditFilter = auditFilterBean.load(connection, auditFilter.getIDString(), user, umm);
        load_executed = true;
        session.setAttribute("auditFilter", auditFilter);
       // Setting the loaded_filter_name value
      } catch (AuditValidationException sqla) {
%>        
        <script>
        location.href="saAuditFilter.jsp?errorMsg=<%=sqla.getMessage()%>";
        </script>
<%        
        return;
      } catch (SQLException sqle) {
%>        
        <script>
        location.href="saAuditFilter.jsp?errorMsg=<%=loadErrorMsg%>";
        </script>
<%        
        System.out.println("Database error: " + sqle.getMessage());
      }
      
    } else if (REQUEST_OPERATION_DELETE.equals(operation)) {
      
      try {
        boolean delete_result = auditFilterBean.delete(connection, auditFilter.getIDString(), user, umm);
        if (!delete_result) throw new AuditValidationException(deleteErrorMsg);
        delete_executed = true;
        load_executed = false;
        session.setAttribute("auditFilter", new auditFilterBean());
%>        
        <script>
        window.opener.location.href = window.opener.location.href;
        </script>
<%              
      } catch (AuditValidationException sqla) {
%>        
        <script>
        location.href="saAuditFilter.jsp?errorMsg=<%=sqla.getMessage()%>";
        </script>
<%        
        return;
      } catch (SQLException sqle) {
%>        
        <script>
        location.href="saAuditFilter.jsp?errorMsg=<%=deleteErrorMsg%>";
        </script>
<%        
        System.out.println("Database error: " + sqle.getMessage());
      }
      
   }
    
    
    


%>

<table cellpadding="0" cellspacing="0">
  <tr align=left>
    <td nowrap class="pageHead"><%=header%></td>
  </tr>
<%
    if (store_executed){
%>
  <tr align=left>
    <td nowrap class="simpleText"><%=storeExecutedMsg%></td>
  </tr>
<%
    } else if (load_executed) {
%>
<tr align=left>
<td nowrap class="simpleText"><%=loadExecutedMsg%> <%=auditFilter.getIDString()%></td>
</tr>
<%
    } else if (delete_executed) {
%>
    <tr align=left>
      <td nowrap class="simpleText"><%=deleteExecutedMsg%></td>
    </tr>
<%
    } else if(!errorMsg.equals("")){
%>
  <tr align=left>
    <td nowrap class="error"><%=errorMsg%></td>
  </tr>
<%
    }
%>
</table>
<%
  ClusterNodeBean cnb=null;

  if (vct.size()==1) {
    cnb=(ClusterNodeBean)vct.get(0);
%>
    <input type="hidden" name="hostName" value="<%=cnb.getHostName() %>">
<%
  }
  
  String[] existent_filter_names = new String[0];
  String[] existent_filter_solutions = new String[0];
  auditFilterBean[] existent_filters = new auditFilterBean[0];
 
  // Custom filters not accesible when no auth module
  if (umm != null) {
    existent_filter_names = auditFilterBean.findNamesByRoles(connection, umm.getUserRoles(user));
    existent_filter_solutions = auditFilterBean.findSolutionsByRoles(connection, umm.getUserRoles(user));
    existent_filters = auditFilterBean.findIDandCreatorByRoles(connection, umm.getUserRoles(user));
  }
%>

<script>

  var filter_map = new HashMap();

<%
  // Populating the id's array
  for(int x = 0; x < existent_filters.length; x++) {
%>
    filter_map.put('<%=existent_filters[x].getIDString()%>', '<%=existent_filters[x].getCreator()%>');
<%
  }
%>

</script>

<table class="filterTable">
<tr>

<%
// Custom filters not accesible when no auth module
if (umm != null) {
%>
  <td class="filterTextTd" title="<%=filterName%>" width="20%"><%=filterName%></td>
  <td colspan="3" title="<%=filterName%>">
		<cmbtxt:combotext name="name" value="<%=auditFilter.getName()%>" id="name" onchange="filter_changed()" position="relative" top="-10" width="250">
		<% 
		  for (int x = 0; x < existent_filter_names.length; x++) {
		%>
	    <cmbtxt:option value="<%=existent_filter_names[x]%>"/>    
		<%} %>
		</cmbtxt:combotext>  
	</td>     
</tr>
<tr>
  <td class="filterTextTd" title="<%=filterSolution%>" width="20%"><%=filterSolution%></td>
  <td colspan="3" title="<%=filterSolution%>">
    <cmbtxt:combotext name="solution" value="<%=auditFilter.getSolution()%>" id="solution" onchange="filter_changed()" position="relative" top="-10" width="250">
    <% 
      for (int x = 0; x < existent_filter_solutions.length; x++) {
    %>
      <cmbtxt:option value="<%=existent_filter_solutions[x]%>"/>    
    <%} %>
    </cmbtxt:combotext>  
  </td>     
</tr>
<tr>
  <td class="filterTextTd" title="<%=filterRole%>" width="20%"><%=filterRole%></td>
  <td colspan="3" title="<%=filterRole%>">
    <select name = "role">
        <option value=""></option>
    <%
      for (String user_roles : umm.getUserRoles(user)) {
    %>
        <option value="<%=user_roles%>" <%if(user_roles.equals(auditFilter.getRole())) out.print("selected"); %>><%=user_roles%></option>
    <%        
      }
    %>
    </select>
  </td>
</tr>
<tr>
<td colspan="4"><hr></hr></td>
</tr>
<%
// End of umm != null
}
%>

<tr>
  <td width="20%" class="filterTextTd" title="<%=hostName%>"><%=hostName%>:</td>
  <td class="operatorFilterText">
<%
  String selected=auditFilter.getHostName(), name;

  if (vct.size()==1) {
    cnb=(ClusterNodeBean)vct.get(0);
%>
<%= cnb.getHostName() %>
<%
  } else {
%>
    <select name="hostName" size="1">
<%
    if (selected=="") {
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
      if (name.compareToIgnoreCase(selected)==0) {
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
  <td width="20%" class="filterTextTd" title="<%=identifierTitle%>"><%=identifier%>:</td>
  <td colspan='3' title="<%=identifierTitle%>"><input type="text" size="30" name="identifier" value="<jsp:getProperty name="auditFilter" property="identifier" />"/></td>
</tr>
<tr>
  <td width="20%" class="filterTextTd" title="<%=orderIdTitle%>"><%=orderId%>:</td>
  <td colspan='3' title="<%=orderIdTitle%>"><input type="text" size="30" name="orderId" value="<jsp:getProperty name="auditFilter"
  property="orderId" />"/></td>
</tr>
<tr>
  <td width="20%" class="filterTextTd" title="<%=workflowTypeTitle%>"><%=workflowType%>:</td>
  <td colspan='3' title="<%=workflowTypeTitle%>"><input type="text" size="30" name="workflowType" value="<jsp:getProperty name="auditFilter"
  property="workflowType" />"/></td>
</tr>
<tr>
  <td width="20%" class="filterTextTd" title="<%=workflowStateTitle%>"><%=workflowState%>:</td>
  <td colspan='3' title="<%=workflowStateTitle%>"><input type="text" size="30" name="workflowState" value="<jsp:getProperty name="auditFilter"
  property="workflowState" />"/></td>
</tr>
<tr>
  <td class="filterTextTd" title="<%=eventTypeTitle%>"><%=eventType%>:</td>
  <td colspan='3' title="<%=eventTypeTitle%>"><input type="text" size="30" name="eventType" value="<jsp:getProperty name="auditFilter" property="eventType" />"/></td>
</tr>
<tr>
  <td class="filterTextTd" title="<%=MessageFormat.format(beginDateTitle,new Object[]{df.toPattern()})%>"><%=beginDate%>:</td>
  <td title="<%=MessageFormat.format(beginDateTitle,new Object[]{df.toPattern()})%>"><input type="text" size="8" name="beginDate" id='inputStartDate' title="<%=MessageFormat.format(beginDateTitle,new Object[]{df.toPattern()})%>" value="<jsp:getProperty name="auditFilter" property="beginDate" />"/>
    <img src="/activator/images/date_select.gif" id="buttonBeginDate" class="dateInputTriger"/></td>
  <td class="filterTextTd" title="<%=MessageFormat.format(endDateTitle,new Object[]{df.toPattern()})%>"><%=endDate%>:</td>
  <td title="<%=MessageFormat.format(endDateTitle,new Object[]{df.toPattern()})%>">
    <input type="text" size="8" name="endDate" id='inputEndDate' title="<%=MessageFormat.format(endDateTitle,new Object[]{df.toPattern()})%>" value="<jsp:getProperty name="auditFilter" property="endDate" />"/>
    <img src="/activator/images/date_select.gif" id="buttonEndDate" class="dateInputTriger"/></td>
  </td>
</tr>
<tr>
  <td class="filterTextTd" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>"><%=time%>:</td>
  <td title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>">
    <input type="text" size="8" name="beginTime" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>" value="<jsp:getProperty name="auditFilter" property="beginTime" />"/></td>
  <td class="filterTextTd" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>"></td>
  <td title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>">
    <input type="text" size="8" name="endTime" title="<%=MessageFormat.format(timeTitle,new Object[]{tf.toPattern()})%>" value="<jsp:getProperty name="auditFilter" property="endTime" />"/></td>
  </td>
</tr>
<tr>
  <td class="filterTextTd" title="<%=classNameTitle%>"><%=className%>:</td>
  <td colspan='3' title="<%=classNameTitle%>"><input type="text" size="30" name="className" value="<jsp:getProperty name="auditFilter" property="className" />"/></td>
</tr>
<tr>
  <td class="filterTextTd" title="<%=jobIdTitle%>"><%=jobId%>:</td>
  <td colspan='3' title="<%=jobIdTitle%>"><input type="text" size="30" name="jobId" value="<jsp:getProperty name="auditFilter" property="jobId" />"/></td>
</tr>
<tr>
  <td class="filterTextTd" title="<%=userNameTitle%>"><%=userName%>:</td>
  <td colspan='3' title="<%=userNameTitle%>"><input type="text" size="30" name="userName" value="<jsp:getProperty name="auditFilter" property="userName" />"/></td>
</tr>
<tr>
  <td class="filterTextTd" title="<%=workflowNameTitle%>"><%=workflowName%>:</td>
  <td colspan='3' title="<%=workflowNameTitle%>"><input type="text" size="30" name="workflowName" value="<jsp:getProperty name="auditFilter" property="workflowName" />"/></td>
</tr>
<tr>
  <td class="filterTextTd" title="<%=stepNameTitle%>"><%=stepName%>:</td>
  <td colspan='3' title="<%=stepNameTitle%>"><input type="text" size="30" name="stepName" value="<jsp:getProperty name="auditFilter" property="stepName" />"/></td>
</tr>
<tr>
  <td class="filterTextTd" title="<%=messageTitle %>"><%=message%>:</td>
  <td colspan='3' title="<%=messageTitle %>"><TEXTAREA COLS="23" ROWS="4" WRAP="VIRTUAL" name="message" value=""><jsp:getProperty name="auditFilter" property="message" /></TEXTAREA></td>
</tr>
<tr>
  <td align="left"><input type="button" value="<%=clearForm%>" onclick="clearForm()"></td>
  <td align="right" colspan='3'>
<%
// Custom filters not accesible when no auth module
if (umm != null) {
%>  
    <input type="submit" value="<%=loadForm%>" id="<%=loadForm%>" disabled="true" onClick="changeOperation('<%=REQUEST_OPERATION_LOAD%>');">
    <input type="submit" value="<%=deleteForm%>" id="<%=deleteForm%>" disabled="true" onClick="changeOperation('<%=REQUEST_OPERATION_DELETE%>');">
    <input type="submit" value="<%=saveForm%>" id="<%=saveForm%>" onClick="changeOperation('<%=REQUEST_OPERATION_SAVE%>');">
<%
// End of umm != null
}
%>   
    <input type="submit" value="<%=submitForm%>">
  </td>
</tr>
</table>


    <input type="hidden" name="operation" id="form_operation" value="">
<%
   if (load_executed) {
%>    
    <input type="hidden" name="<%=REQUEST_LOADED_NAME%>" id="<%=REQUEST_LOADED_NAME%>" value="<%=auditFilter.getIDString()%>">
   
<%
   } else {
%>    
    <input type="hidden" name="<%=REQUEST_LOADED_NAME%>" id="<%=REQUEST_LOADED_NAME%>" value="<%=loaded_name%>">
<%
   }

    // Cleaning session to not be showed up in the drop list.
    if (load_executed || store_executed) {
      session.removeAttribute("auditFilter");
    }

	} catch (Exception e) {
		String err = null;
		if (e.getMessage() != null) {
		 tmp = e.getMessage().replace('\n',' ');
		 err = tmp.replace('"',' ');
		}
		else {
		 err = e.toString().replace('\n',' ');
		}
	%>
	    <SCRIPT LANGUAGE="JavaScript"> alert("HP Service Activator" + "\n\n" + "<%=errMsg%> " +  "<%=err%>"); </SCRIPT>
	<%
	} finally {
		if (connection != null)
		  connection.close();
	}
	%>


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
  if (vct.size()!=1) {
%>
    if (document.inputForm.hostName.selectedIndex==-1) {
      alert('<%=alert2%>');
      return false;
    }
<%
  }
%>
    return true;
  }
</script>
</body>
</html>
