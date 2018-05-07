<!------------------------------------------------------------------------
   HP OpenView Service Activator
   @(c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
------------------------------------------------------------------------->

<%@ page import="com.hp.ov.activator.mwfm.*, com.hp.ov.activator.vpn.inventory.Queue, 											 com.hp.ov.activator.vpn.inventory.Queue_Message,
                 com.hp.ov.activator.mwfm.servlet.*, java.sql.*,javax.sql.*,
                 com.hp.ov.activator.mwfm.servlet.*, 
                 com.hp.ov.activator.mwfm.component.WFNoSuchQueueException,
				 com.hp.ov.activator.inventorybuilder.data.Bean,
                 java.text.DateFormat,
                 java.text.MessageFormat,
                 java.util.Date,
				 java.util.*,
                 java.net.*"
         info="Display all messages." 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
 <jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.Queue_Message" />
 <jsp:useBean id="bean1" class="com.hp.ov.activator.vpn.inventory.Queue" />

<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(Constants.USER) == null) {
%>
    <script>
        window.top.topFrame.location = window.top.topFrame.location;
    </script>
<%
       return;
    }


    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
%>

<%!
    //I18N strings
    final static String jobID       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("146", "Message Id");
    final static String workflow    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("6", "MessageState");
    final static String queue       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("147", "Url");
    final static String message     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("150", "Message");
    final static String noMsgs      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("151", "No messages available.");
    final static String errMsg      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("152", "Unable to retrieve data from queue");
    final static String errInfo     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("304", "To re-establish the micro-workflow engine connection please log back into tthe Operator UI.");

    final static String deleteMsg    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("305", "Delete Message");
   // final static String deleteAllMsgs= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("327", "Delete All Messages in Queue");
final static String deleteAllMsgs= "";
    final static String confirmMsg  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("310", "The selected message will be deleted.");
	final static String confirmAllMsg= "";
    //final static String confirmAllMsg= com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("328", "ALL messages in the displayed queue be deleted.");
    final static String cancelMsg   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("311", "Delete message action cancelled.");
	final static String noMsgsMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("151", "No messages available for Queue.");
    final static String outOfMemory = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("594", "The system is running low on memory and is only able to show {0} of {1} messages!");
    final static String outOfMemory2 = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("595", "The system is running low on memory and is only able to show {0} messages!");
	final static String reading_msgs_Msg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("864", "Reading messages, please wait...");
    
    //sorting
    final static int JOB_ID_DES = 0;
    final static int JOB_ID_ASC = 1;
    final static int WORKFLOW_DES = 2;
    final static int WORKFLOW_ASC = 3;
    final static int POST_TIME_DES = 4;
    final static int POST_TIME_ASC = 5;
    final static int STEP_DES = 6;
    final static int STEP_ASC = 7;
    final static int MSG_DES = 8;
    final static int MSG_ASC = 9;
	final static int MSGNAME_DES = 10;
    final static int MSGNAME_ASC = 11;
	String SESSION_TAB_PAGE = "session_tab_name_";
	String SESSION_TAB_RECORD_NUM = "session_tab_recNo_";
	String SESSION_TAB_GOTO = "session_tab_goto_";
    final static String SESSION_EXT_QUEUE = "msg_queue_externamlMessage.jsp";
%>
 
<% 
	String[] whereFilter = null;
    String queueName = (String)request.getParameter ("displayQueue"); 
	String encQueueName = URLEncoder.encode(queueName,"UTF-8");
	session.setAttribute(SESSION_EXT_QUEUE, encQueueName);
	SESSION_TAB_PAGE = "session_tab_name_";
	SESSION_TAB_RECORD_NUM = "session_tab_recNo_";
	SESSION_TAB_GOTO = "session_tab_goto_";

	SESSION_TAB_PAGE = SESSION_TAB_PAGE + encQueueName ;
	SESSION_TAB_RECORD_NUM = SESSION_TAB_RECORD_NUM + encQueueName ;
	SESSION_TAB_GOTO = "session_tab_goto_" + encQueueName ;
	int numberOfMessages = 0 ;
	int numberOfPages = 0;

	String startRecordNumber = "";
	if(session.getAttribute(SESSION_TAB_RECORD_NUM) != null) {
	  startRecordNumber = (String)session.getAttribute(SESSION_TAB_RECORD_NUM);
	  
	}
	if(request.getParameter("recStart") != null ) {
	  startRecordNumber = (String)request.getParameter("recStart");
	}
	if(request.getParameter("goto") != null) {
	  if("true".equalsIgnoreCase((String)request.getParameter("goto"))){
		session.setAttribute(SESSION_TAB_GOTO,startRecordNumber);
	  }
	}
	// part of the fix for gnat 12819
	if(session.getAttribute("REC_START_NUM") != null) {
		startRecordNumber = (String)session.getAttribute("REC_START_NUM");
		session.removeAttribute("REC_START_NUM");
		session.removeAttribute("SESSION_TAB_RECORD_NUM");
	}
	int startRecNo = 1 ;

%>

<html>
<head>
    <base target="_top">
    <meta http-equiv="content-type" content="text/html; charset=utf-8">

    <link rel="stylesheet" type="text/css" href="../css/activator.css">
	 <link rel="stylesheet" type="text/css" href="../css/VpnMessages.css">
    <link rel="stylesheet" type="text/css" href="../css/saContextMenu.css">
	<link rel="stylesheet" type="text/css" href="../css/saTabs.css">
<link rel="stylesheet" type="text/css" href="../css/saAudit.css">

    <script language="JavaScript" src="../javascript/table.js"></script>
    <script language="JavaScript" src="../javascript/saUtilities.js"></script>
    <script language="JavaScript" src="../javascript/saNavigation.js"></script>
    <script language="JavaScript" src="../javascript/saContextMenu.js"></script>
    <script language="JavaScript" src="../../javascript/backup.js"></script>
    <STYLE type="text/css" media="screen">
        #container
		{
		width: 98%;
		height: 100%;
		overflow: auto;
		}
		#header
		{
		top:expression(this.offsetParent.scrollTop-2);
		}
    </STYLE>
   <script language="JavaScript">

<%
    final String SESSION_SORTING = "sorting_in_externalMessages.jsp"+"_"+queueName;

    //default sorting criteria
    int currentSort = JOB_ID_ASC;
	

    try{
        currentSort = ((Integer)session.getAttribute(SESSION_SORTING)).intValue();
		

    }catch(Exception e){;}

    try{
        int newSorting = Integer.parseInt(request.getParameter("sort"));
	    if( (newSorting == currentSort || newSorting == currentSort+1) && (currentSort%2 == 0)){
            if(newSorting == currentSort) currentSort = newSorting + 1;
            else currentSort = newSorting - 1;
        }else{
            currentSort = newSorting;
        }
		session.setAttribute(SESSION_SORTING,new Integer(currentSort));
        out.println("    document.location.href='externalMessages.jsp?displayQueue="+encQueueName+"';");
    }catch(Exception e){;}
	int maxRec =1000;

	try {
maxRec = Integer.parseInt((String)session.getAttribute(Constants.MESSAGES_MAX));
} catch (Exception e) {
;
}

//  next&previous page functionality 
int pageNm = 0;
boolean inputProper = true;
if (request.getParameter("page") != null) {
try {
pageNm = Integer.parseInt((String)request.getParameter("page"));
} catch (Exception e) {
inputProper = false;
}
}
if(inputProper){
session.setAttribute(SESSION_TAB_PAGE, pageNm +"");
} else if (session.getAttribute(SESSION_TAB_PAGE)!=null){
try {
  pageNm = Integer.parseInt((String)session.getAttribute(SESSION_TAB_PAGE)); 
  } catch (Exception e) {
   ;
  }
}
int fromCount = (maxRec * pageNm)+1;
session.setAttribute("CurrentPageNumber", pageNm + "");


%>
	function confirmDeleteMessage(queue, confirmMsg, cancelMsg, fromCount, numberOfMessages, maxRec)
	{
		
	if (confirm(confirmMsg)) 
	{
	var msgId = getCookie('msgsMenu');
	top.processFrame.location.href = "deleteExternalMessage.jsp?action=delMsg" + "&msgId=" + msgId + "&queue=" + queue + "&fromCount=" + fromCount + "&numberOfMessages=" + numberOfMessages + "&maxRec=" + maxRec;

	// part of the fix for gnat 12819
	//var endCount = numberOfRows + fromCount -2;

	if (fromCount > (numberOfMessages-1)) {
		fromCount = fromCount - maxRec;
	}
	top.main.location.href = "ExternalQueue.jsp?displayQueue=<%=encQueueName%>";
	//parent.displayFrame.location="saMsgFrame.jsp?displayQueue=<%=encQueueName%>;

	return true;
	}
	writeToMsgLine(cancelMsg);
	return false;
	}
	window.onload = function ()
	{
		window.menuName = "msgsMenu";
		document.getElementById('msgsTable').oncontextmenu = showContextMenu;
		scrollTo(0,top.scrollY);
		if(document.all)
		{
		hideContextMenu('msgsMenu');
		var tr_header = document.getElementById("header");
		tr_header.style.position = "relative";
		}
		}

    </script>
</head>

<body  onClick="saveScrollPos();hideContextMenu('msgsMenu');rowUnSelect();" >
  <SCRIPT LANGUAGE="JavaScript">
    writeToMsgLine("<%="][Reading messages, please wait...."%>");
  </SCRIPT>


<%
    String sortDes = "<img src='../images/down.gif' align='absmiddle' border='0'/>";
    String sortAsc = "<img src='../images/up.gif' align='absmiddle' border='0'/>";
    String resortLink = "externalMessages.jsp?displayQueue="+encQueueName+"&sort=";
%>

<div id="container">
<table class="activatorTable" id="msgsTable">
 <THEAD>
  <tr id="header">
    <td width="10%"  class="mainHeading" nowrap><a TARGET="_self" href="<%= resortLink+JOB_ID_DES%>"><%=jobID%>&nbsp;<%=(currentSort==JOB_ID_DES?sortDes:"")%><%=(currentSort==JOB_ID_ASC?sortAsc:"")%></a></td>
    <td width="12%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+WORKFLOW_DES%>"><%=workflow%>&nbsp;<%=(currentSort==WORKFLOW_DES?sortDes:"")%><%=(currentSort==WORKFLOW_ASC?sortAsc:"")%></a></td>
    <td width="40%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+MSG_DES%>"><%= queue%>&nbsp;<%=(currentSort==MSG_DES?sortDes:"")%><%=(currentSort==MSG_ASC?sortAsc:"")%></a></td>
	 <td width="40%" class="mainHeading"><a TARGET="_self" href="<%= resortLink+MSGNAME_DES%>"><%= message%>&nbsp;<%=(currentSort==MSGNAME_DES?sortDes:"")%><%=(currentSort==MSGNAME_ASC?sortAsc:"")%></a></td>
  </tr>
 </THEAD>
  <TBODY>
<%
   int numRows=1;
   //MessageQueueDescriptor queue = null;
   try
{

    // get all messages for the displayed queue
   
    switch(currentSort){
       case JOB_ID_DES:    whereFilter = new String []{"messageId desc"}; break;
       case JOB_ID_ASC:    whereFilter = new String []{"messageId asc"}; break;
       case WORKFLOW_DES:  whereFilter = new String []{"messageState desc"}; break;
       case WORKFLOW_ASC:  whereFilter = new String []{"messageState asc"}; break;
       case MSG_DES:       whereFilter = new String []{"Destination desc"}; break;
       case MSG_ASC:       whereFilter = new String []{"Destination asc"}; break;
	   case MSGNAME_DES:    whereFilter = new String []{"messageName desc"}; break;
       case MSGNAME_ASC:    whereFilter = new String []{"messageName asc"}; break;
	}
   // queue = wfm.getMessageQueue(queueName);
	 DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);
   Connection connection = null;
	Queue_Message[] queue = null;
	Queue[] queueDB = null;
	String qName = null;
	String bgcolor = "";
	String whereCondition = "V_Queue_Message.queueName =";
	HashMap orderbyfilter = new HashMap();

	if(whereFilter != null){	
		orderbyfilter.put(Bean.PARAMETER_ORDER_BY_FIELDS,whereFilter);
	}
	int count =-1;
	try
	{
		connection = (Connection)dataSource.getConnection();
		count=bean.findByQueuenameCount(connection,encQueueName);
		numberOfMessages = count;
	}
	catch(SQLException e)
	 {
	
		System.out.println("exception during database connection"+e);
	}
	finally
	{
		try
			{
				if(connection != null)
					connection.close();
			}
			catch(Exception fi)
			{
			
				System.out.println("exception in finally block"+fi);

			}
	}
	


    // see if we have data to display
    if (numberOfMessages == 0) {
%>
          <tr class="tableRowInfo">
    <td class="tableRowInfo" colspan="9"><%=noMsgsMsg%></td>
  </tr>
  <SCRIPT LANGUAGE="JavaScript">
		writeToMsgLine("<%=noMsgs%>");
		</SCRIPT>
<%
	return;   
}
		
	numberOfPages = numberOfMessages / maxRec ;
	numberOfPages = numberOfMessages / maxRec ;
	//startRecNo = maxRec * pageNm ;
	if(!"".equalsIgnoreCase(startRecordNumber)){
	  try {

		startRecNo = Integer.parseInt(startRecordNumber);
	  } catch (Exception e) {
		startRecNo = maxRec * pageNm ;
	  }
	}

	fromCount = startRecNo  ;	
	
		try
		{	
			connection = (Connection)dataSource.getConnection();
			if(whereFilter!= null)
				whereCondition = whereCondition+"'"+encQueueName+"'";
			else 
				whereCondition = whereCondition+encQueueName;

			orderbyfilter.put(Bean.PARAMETER_EXTRA_WHERE_CLAUSE,whereCondition);
			
			queue = bean.findAll( connection, orderbyfilter);
			
		}
		catch(SQLException e)
		{
			queue = null;
			System.out.println("exception during database connection"+e);
		}
	
		finally
		{
			try
			{
				if(connection != null)
					connection.close();
			}
			catch(Exception fi)
			{
			
				System.out.println("exception in finally block"+fi);

			}
		}
		if (queue == null) 
		{
		%>
		<SCRIPT LANGUAGE="JavaScript">
		writeToMsgLine("<%=noMsgs%>");
		</SCRIPT>
		<%
		}
		

    // set initial values
    String formatTag = (((Boolean)session.getAttribute(Constants.FORMAT_TEXT)).booleanValue() == true ? "<pre>" : "");

	
		if (queue.length >0 ) {
        for (int j = 0; j < queue.length; j++) {
           String rowClass= (numRows%2 == 0) ? "tableEvenRow" : "tableOddRow";
           //String jobQueue=queue.name;
           if (Runtime.getRuntime().freeMemory() < 1000000) { 
%>
        <script language="JavaScript"> 
          clearMessageLine();         
          alert("<%=MessageFormat.format(outOfMemory, new Object[] {new Long(numRows-1), (queue == null?"0":String.valueOf(queue.length))})%>");
        </script>
<%
             break;
           }

		 
		   if(queue[j].getMessagestate().equalsIgnoreCase("failure"))
				bgcolor = "tableRowRed";
			else
				bgcolor = "tableCell";
			String filepath = queue[j].getMessagename();
			int index = filepath.lastIndexOf("/");
			String fileName = filepath.substring(index+1);
						

%>

<tr id="<%=queue[j].getMessageid()%>" class="<%=rowClass%>"         
onClick="hideContextMenu('msgsMenu');javascript:location='externalMessageDisplay.jsp?messageId=<%=queue[j].getMessageid()%>&fileName=<%= fileName%>';"    onMouseOver="mouseOver(this);"
               onMouseOut="mouseOut(this);" >
	
		  <td class="<%= bgcolor %>" align="middle"  ><%= queue[j].getMessageid() %></td>
			 
               <td class="<%= bgcolor %>" ><%= queue[j].getMessagestate() %></td>
               <td class="<%= bgcolor %>" ><%= queue[j].getDestination() %></td>
			   <td class="<%= bgcolor %>"><%= fileName%></td>

			  
           </tr>
<%     
            ++numRows;      
          } // end of message loop 
     }      // empty queue check
      
    // Set the results count
		int endCount = numRows + fromCount -2;
		String msgPageNum = pageNm + "";


		session.setAttribute(SESSION_TAB_PAGE,msgPageNum);
		session.setAttribute(SESSION_TAB_RECORD_NUM,startRecNo+"");

		// to solve the gnat 12775 and part of gnat 12819
		if (numberOfMessages < endCount) {
		  endCount = numberOfMessages;
		}
%>

     <script language="JavaScript"> 
         setResultCount('<%=endCount%>','<%=fromCount%>','<%=queueName%>','<%=pageNm%>','<%=maxRec%>','<%=numberOfMessages%>','<%=numberOfPages%>'); 
	clearMessageLine();   
     </script>
  
<%
}
   catch (OutOfMemoryError e) {
%>   
        <SCRIPT LANGUAGE="JavaScript"> 
            clearMessageLine();         
            alert("<%=MessageFormat.format(outOfMemory2, new Object[] {new Long(numRows-1)})%>");
        </SCRIPT>
<%
   }
   catch (Exception e) 
   { String err = null;

		System.out.println("exception"+e);
            if (e.getMessage() != null) {
                String tmp = e.getMessage().replace('\n',' ');
                err = tmp.replace('"',' ');
            }
            else
                err = e.toString().replace('\n',' ');
%>
<SCRIPT LANGUAGE="JavaScript"> 
alert("HP Service Activator" + "\n\n" + "<%=errMsg%> :  <%=err%>");
</SCRIPT>
<%
}
%>
</TBODY>
</table>
</div>

<!-- This table is hidden until selected for viewing with a right click -->
<!--  This menu is only available if the user has administrative rights -->

<%
  if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == true) {
%>
<div id="msgsMenu" class="contextMenu" onclick="javascript:hideContextMenu('msgsMenu');">
<a href="ExternalQueue.jsp?displayQueue=<%=encQueueName%>" class="menuItem" target="displayFrame"
onclick="return confirmDeleteMessage('<%=encQueueName%>','<%=confirmMsg%>','<%=cancelMsg%>','<%=fromCount%>','<%=numberOfMessages%>','<%=maxRec%>');"
onmouseover="toggleHighlight(event)"
onmouseout="toggleHighlight(event)"><%=deleteMsg%></a>
</div>
<% 
  } else {
%>
<div id="msgId" />
<% 
  }
%>

</body>
</html>
