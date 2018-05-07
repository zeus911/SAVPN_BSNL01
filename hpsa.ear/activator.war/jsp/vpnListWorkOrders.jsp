<!---------------------------------------------------------------------
   HP OpenView Service Activator
   @ Copyright 2003-2010 Hewlett-Packard Development Company. L.P.
---------------------------------------------------------------------->
<%@ page    import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.audit.*,com.hp.ov.activator.util.TextFormater,java.sql.*,java.text.DateFormat,javax.sql.*,com.hp.ov.activator.cr.inventory.Region,com.hp.ov.activator.vpn.inventory.SetupCE_Workorder"
    info="Display audit messages for specific filter." session="true"
    contentType="text/html; charset=UTF-8" language="java"%>
<%!//I18N strings
  final static String noAuditMessages = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("569", "No audit messages available.");

  //changed by divya
  final static String audit = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("570", "Work-orders");
  final static String errMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("571", "Unable to retrieve audit information");  
  final static String resetTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("858", "Reset the Audit UI ");
  //end here

  final static String invalidGoToEntry = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("572", "Please enter a record num between 1 and ");
  final static String error = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1", "Error: ");
  final static String filter = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("573", "Filter");
  final static String filterTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("849", "Filter Messages");
  final static String prevPageLink = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("575", "&lt; Prev");
  final static String nextPageLink = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("576", "Next &gt;");
  final static String firstPageLabel = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("577", "&lt;&lt;");
  final static String lastPageLabel = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("578", "&gt;&gt;");
  final static String gotoLabel = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("579", "Go");  
  final static String prevPageTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("850", "Show Previous Page");
   final static String deleteWorkorder = "Delete workorder";
   final static String confirmMsg = "The selected work-order will be deleted.";
   final static String confirmAllMsg = "ALL work-orders will be deleted.";
   final static String cancelMsg = "Delete work-order action cancelled.";
   final static String successMsg  = "Work-order file successfully deleted ";
  final static String nextPageTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("851", "Show Next Page");
  final static String firstPageTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("852", "Show First Page");
  final static String lastPageTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("853", "Show Last Page");
  final static String gotoTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("854", " Go To Any Record Number");
  final static String notAdmin = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("855", "You are not Administrator.");

  //final static String openInst = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("856", "Open Instance");
  //final static String openNewInst = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("857", "Open New Instance");
  final static String filterHeading = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("573", "Filter");
  final static String navigation = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("587", "Navigation");
  final static String reset = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("125", "Reset");
  final static String msg1 = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("589", "Your result list is too long.<br>Please enter more detailed filter information.");
  final static String msg2 = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("590", "Your result list is empty.");
  //Table haeder names
  //changed by divya
  final static String date = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("591", "Date");
  final static String woName = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("592", "WOName");
  final static String jobId = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("146", "Service Id");
  // change as part of gnat 13365

  //sorting
  
  final static int DATE_DES = 2;
  final static int DATE_ASC = 3;
  final static int JOB_ID_DES = 10;
  final static int JOB_ID_ASC = 11;
  final static int WONAME_DES = 14;
  final static int WONAME_ASC = 15;
%>
<%
  String SESSION_AUDIT_RECORD_NUM = "session_vpn_recNo";
  String SESSION_AUDIT_GOTO = "session_vpn_goto";
  String startRecordNumber = "";
  String gotoValue = "";
  
  

  
  if(session.getAttribute(SESSION_AUDIT_RECORD_NUM) != null) {
 
    startRecordNumber = (String)session.getAttribute(SESSION_AUDIT_RECORD_NUM);
  }
  
  if(request.getParameter("recStart") != null ) {
    startRecordNumber = (String)request.getParameter("recStart");
  }
  if(request.getParameter("goto") != null) {
    if("true".equalsIgnoreCase((String)request.getParameter("goto"))){
      session.setAttribute(SESSION_AUDIT_GOTO,startRecordNumber);
    }
  }
  
  int startRecNo = 1 ;
%>

<jsp:useBean id="test" scope="session"
    class="com.hp.ov.activator.vpn.inventory.SetupCE_Workorder" />
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

      // don't cache the page
      response.setDateHeader("Expires", 0);
      response.setHeader("Pragma", "no-cache");

      request.setCharacterEncoding("UTF-8");

      //sorting functionality
      final String SESSION_SORTING = "sorting_in_vpnListWorkOrders.jsp";
	  int currentSort = JOB_ID_DES; // change as part of gnat 13365

      try {
        currentSort = ((Integer)session.getAttribute(SESSION_SORTING)).intValue();
      } catch (Exception e) {
        ;
      }

      try {
        int newSorting = Integer.parseInt(request.getParameter("sort"));
        if ((newSorting == currentSort || newSorting == currentSort + 1) && (currentSort % 2 == 0)) {
          //switch between asc and des
          if (newSorting == currentSort)
            currentSort = newSorting + 1;
          else
            currentSort = newSorting - 1;
        } else {
          currentSort = newSorting;
        }
        session.setAttribute(SESSION_SORTING, new Integer(currentSort));
      } catch (Exception e) {
        ;
      }

      boolean backFromFilter = (request.getParameter("filter") != null && !request.getParameter("filter").toString()
          .equals(""));
      
      int maxRec = 150;
      int noOfPages = 0;
      int noOfRecords = 1;
      try {
        maxRec = Integer.parseInt((String)session.getAttribute(Constants.AUDIT_MESSAGES_MAX));
      } catch (Exception e) {
        ;
      }

      // reset functionality
      if (request.getParameter("resetFlag") != null) {
        session.removeAttribute("CurrentPageNumber");
        session.removeAttribute("NumberOfPages");
        session.removeAttribute("SESSION_AUDIT_GOTO"); 
        session.removeAttribute("SESSION_AUDIT_RECORD_NUM"); 
       // auditFilter.setHostName("");
      }
      
      

      //  next&previous page functionality 
      
      if (session.getAttribute(SESSION_AUDIT_GOTO) != null){
        gotoValue = (String)session.getAttribute(SESSION_AUDIT_GOTO);
      }
      int pageNm = 0;
      try {
        pageNm = Integer.parseInt((String)request.getParameter("page"));
      } catch (Exception e) {
        ;
      }
      int endCount = 0;
      int fromCount = (maxRec * pageNm)+1;
	  //to verify this
     // boolean filterData = backFromFilter && !auditFilter.isEmptyBean();


%>
<html>
<head>
<title>HP Service Activator</title>
<link rel="stylesheet" type="text/css" href="../css/activator.css">
<link rel="stylesheet" type="text/css" href="../css/saTabs.css">
<link rel="stylesheet" type="text/css" href="../css/saContextMenu.css">
<link rel="stylesheet" type="text/css" href="../css/saAudit.css">
<script language="JavaScript" src="../javascript/table.js"></script>
<script language="JavaScript" src="../javascript/saUtilities.js"></script>
<script language="JavaScript" src="../javascript/saContextMenu.js"></script>
<script language="JavaScript" src="../../javascript/backup.js"></script>
</head>
<STYLE type="text/css" media="screen">
    #container
   {
        width: 100%;
        height: 100%;
        overflow: visible;
    }
    #header
    {   
            top:expression(this.offsetParent.scrollTop-2);
    }
</STYLE>
<body onclick="rowUnSelect();hideContextMenu('auditMenu');">
<table width="100%" height="100%">
    <tr height="5%" id="heap">
        <td>
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr align=left>
                <td nowrap class="frameHead"><%=audit%></td>
            </tr>
            <tr>    
                <td align="right" class = "bottomTab">
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>&nbsp;&nbsp;</td>
                        <td nowrap class="bottomTabLink" onclick="reset()"
                            title="<%=resetTitle%>" >&nbsp;&nbsp;<%=reset%>&nbsp;&nbsp;</td>
                        
                       <!-- <td nowrap class="bottomTabLink" onclick="popupFilter()"
                            title="<%=filterTitle%>" >&nbsp;&nbsp;<%=filter%>&nbsp;&nbsp;</td>-->
                       
                        
                        <td>&nbsp;&nbsp;</td>
                        <td align="right" nowrap class="bottomTabLink" onclick="first()"   id="firstPageLink"
                            title="<%=firstPageTitle%>">&nbsp;&nbsp;<%=firstPageLabel%>
                        </td>

                        <td>&nbsp;&nbsp;</td>
                        <td align="right" nowrap class="bottomTabLink" onclick="prev()"      id="prevLink"
                            title="<%=prevPageTitle%>">&nbsp;&nbsp;<%=prevPageLink%>
                        </td>

                        <td>&nbsp;&nbsp;</td>
                        <td align="right" class="bottomTab" nowrap>&nbsp;<span id="resultCnt"></span>
                        </td>

                        <td>&nbsp;&nbsp;</td>
                        <td align="right" nowrap class="bottomTabLink" onclick="next()"  id="nextLink"
                            title="<%=nextPageTitle%>">&nbsp;&nbsp;<%=nextPageLink%>
                        </td>

                        <td>&nbsp;&nbsp;</td>
                        <td align="right" nowrap class="bottomTabLink" onclick="last()"  id="lastPageLink"
                            title="<%=lastPageTitle%>">&nbsp;&nbsp;<%=lastPageLabel%>
                        </td>
                        <td>&nbsp;&nbsp;</td>
                        <td align="right" nowrap> 
                     <%if("".equalsIgnoreCase(gotoValue)){ %> 
                        <Input type ="text" id="gotoTxtBox" size = "6" value = "" class = "bottomTabTxtBox"  title="<%=gotoTitle%>">
                     <% } else { %> 
                        <Input type ="text" id="gotoTxtBox" size = "6" value = "<%=gotoValue%>" class = "bottomTabTxtBox"  title="<%=gotoTitle%>"> 
                     <% } %>
                        </td>
                        <td>&nbsp;&nbsp;</td>
                        <td align="right" nowrap class="bottomTabLink" onclick="submitPage()"  id="gotoLink"
                             title="<%=gotoTitle%>">&nbsp;&nbsp;<%=gotoLabel%>
                        </td>
                        <td>&nbsp;&nbsp;</td>
                    </tr>
                </table>
                </td>
            </tr>
        </table>
        </td>
    </tr>
    <%
		  WFManager wfm = (WFManager) session.getAttribute (Constants.MWFM_SESSION);
          DataSource dataSource = (DataSource)session.getAttribute(Constants.DATASOURCE);
          Connection connection = null;
          Statement stmt = null;
          ResultSet rset = null;
          boolean resultSetEmpty = true;
		  SetupCE_Workorder deleteBean = new SetupCE_Workorder();
          int numRows = 0;
          try {
            connection = (Connection)dataSource.getConnection();
			  String deleteMsg = "";
			 if (request.getParameter("act") != null)
				// Set the properties on the bean - these values have been encoded and must be decoded prior to use
				if(request.getParameter("serviceid") != null) {
			  String serviceid = request.getParameter("serviceid");
			  try {
				deleteBean.setServiceid(serviceid);
				boolean deleted = deleteBean.delete(connection);
				if (deleted) {
				  deleteMsg = successMsg + ":&nbsp;" + serviceid + "<br>";
				}
			  } catch (Exception e) {
%>
        <SCRIPT LANGUAGE="JavaScript"> alert("<%= ExceptionHandler.handle(e) %>"); </SCRIPT>
<%
      }
	 } else {
       deleteMsg = "The work-order to delete is not selected.<br>";
	 }
            stmt = connection.createStatement();
            String sortingKey = "";
			String groupingKey = "";
            switch (currentSort)
			{
              case JOB_ID_DES: sortingKey = "order by ServiceId desc"; break;
              case JOB_ID_ASC: sortingKey = "order by ServiceId asc"; break;
              case DATE_DES: sortingKey = "order by creationtime desc"; break;
              case DATE_ASC: sortingKey = "order by creationtime asc"; break;
              case WONAME_DES: sortingKey = "order by WOName desc"; break;
              case WONAME_ASC: sortingKey = "order by WOName asc"; break;
            }
            
            if(!"".equalsIgnoreCase(startRecordNumber)){
              try {
                startRecNo = Integer.parseInt(startRecordNumber);
              } catch (Exception e) {
                startRecNo = maxRec * pageNm ;
              }
            }
            fromCount = startRecNo  ;
            // noOfRecords = AuditFilter.getNumberOfPages(stmt, auditFilter, maxRec);
			  Region[] regions = Region.findAll(connection);
			  String roleClauseStart = "", roleClauseStart1 = "", roleClauseStart2 = "", roleClauseEnd = "";
			  boolean roleFlag=false;
              if (regions != null)
			  {
				  roleClauseStart1 = " where serviceid in ";
				  roleClauseStart2 = " or serviceid in (select serviceid from v_accessflow where siteid in ";
                  roleClauseStart = "(select serviceid from v_site where region in (";
                  roleClauseEnd = ")) ";
				  for (int i = 0; i < regions.length; i++)
				  {
                      if( wfm.isInRole(regions[i].getName()))
					  {
						  roleFlag=true;
                          roleClauseStart +="'"+regions[i].getName()+"',";
                      }
                  }
				 if(roleFlag)
					 roleClauseStart = roleClauseStart.substring(0,roleClauseStart.length() - 1);
				 else
					 roleClauseStart +="''";

              }
			  String countSQL = "select count(1) from V_SetupCE_Workorder" +roleClauseStart1+roleClauseStart+roleClauseEnd+roleClauseStart2+roleClauseStart+roleClauseEnd+") ";
			  rset = stmt.executeQuery(countSQL);
			  while (rset.next()) 
			  {
			      resultSetEmpty = false;
				  noOfRecords = rset.getInt(1);
			  }
			  //noOfRecords = SetupCE_Workorder.findAllCount(connection);
              if (noOfRecords > maxRec) {
                noOfPages = noOfRecords / maxRec;
                if ((noOfRecords % maxRec) > 0) {
                  noOfPages = noOfPages + 1;
                }
              }

              //SetupCE_Workorder[] bean = SetupCE_Workorder.findAll(connection,sortingKey);
			  String sql = "select * from V_SetupCE_Workorder  "+roleClauseStart1+roleClauseStart+roleClauseEnd+roleClauseStart2+roleClauseStart+roleClauseEnd+") "+sortingKey;
			  
              out.println("<script>");
              out.println("\tclearMessageLine();");
              out.println("</script>");
     
            session.setAttribute("NumberOfPagesInAudit", noOfPages + "");
            session.setAttribute("CurrentPageNumberInAudit", pageNm + "");
            session.setAttribute(SESSION_AUDIT_RECORD_NUM,startRecNo+"");
            String sortDes = "<img src='../images/down.gif' align='absmiddle' border='0'/>";
            String sortAsc = "<img src='../images/up.gif' align='absmiddle' border='0'/>";
            String resortLink = "vpnListWorkOrders.jsp?" + (backFromFilter ? "filter=1&" : "") + "sort=";
    %>
    <tr height="96%">
        <td>
        <div id="container">
        <table class="activatorTable" id="auditTable">
            <THEAD>
                <tr id="header">
                    <td class="mainHeading" nowrap><a TARGET="_self"
                        href="<%= resortLink+JOB_ID_DES%>"><%=jobId%>&nbsp; <%=(currentSort == JOB_ID_DES ? sortDes : "")%><%=(currentSort == JOB_ID_ASC ? sortAsc : "")%></a></td>
                     <td class="mainHeading" nowrap><a TARGET="_self"
                        href="<%= resortLink+WONAME_DES%>"><%=woName%>&nbsp; <%=(currentSort == WONAME_DES ? sortDes : "")%><%=(currentSort == WONAME_ASC ? sortAsc : "")%></a></td>
                    <td width="18%" class="mainHeading"><a TARGET="_self"
                        href="<%= resortLink+DATE_DES%>"><%=date%>&nbsp; <%=(currentSort == DATE_DES ? sortDes : "")%><%=(currentSort == DATE_ASC ? sortAsc : "")%></a></td>
             </tr>
            </THEAD>
            <TBODY>

			
                <%
				
						//System.out.println("sql to execute is"+sql);
						rset = stmt.executeQuery(sql);
						//System.out.println("rset"+rset);
						

						while (rset.next()) 
						{
                          resultSetEmpty = false;
                          String rowClass = (numRows % 2 == 0) ? "tableEvenRow" : "tableOddRow";
                    	  String jobid = rset.getString(1);
						  String woName = rset.getString(2);
						String date =rset.getString(4);

						// fix for the gnat 12848
                        
                        
                %>
                <tr id="<%=jobid%>"
                    class="<%=rowClass%>" onClick="javascript:location='vpnViewWorkOrderContent.jsp?workorderfile=<%=woName%>&serviceid=<%=jobid%>';"    
                    onMouseOver="mouseOver(this);" onMouseOut="mouseOut(this);">
                    <td class="tableCell"><%=jobid%></td>
                    <td class="tableCell"><%=woName%></td>
                   <td class="tableCell" nowrap><%=date%></td>
                
                </tr>
                <%
                          numRows++;
                          
                        /*  if (backFromFilter && numRows - 1 > maxRec) {
                            //too many records selected
                            out.println("<tr><td colspan='5' class='tableCellInfo'>" + msg1 + "</td></tr>");
                            break;
                          }*/
					  }// end of while
					 } catch (Exception e) {
                            String err = null;
                            if (e.getMessage() != null) {
                             String tmp = e.getMessage().replace('\n',' ');
                             err = tmp.replace('"',' ');
                            }
                            else {
                             err = e.toString().replace('\n',' ');
                            }
                       %>
                           <SCRIPT LANGUAGE="JavaScript"> alert("HP Service Activator" + "\n\n" + "<%=errMsg%>" +  "<%=err%>"); </SCRIPT>
                       <%
                            } finally {
                           
                            if (connection != null)
                              connection.close();
                        }
                     /*   if (bean.length<=0) {
                          //resultSet is empty
                          out.println("<tr><td colspan='5' class='tableCellInfo'>" + msg2 + "</td></tr>");
                        }
                        */
                        endCount = numRows + fromCount - 1;
                    
                %>
            </TBODY>
        </table>
       </div>
        </td>
    </tr>
</table>
<%

%>
<script>
     var cnt ;
   // prepare the new result string
    if('<%=numRows%>'!=0)
    {
      cnt = '<%=fromCount%>' + ' - ' + '<%=endCount%>' + ' / ' + '<%=noOfRecords%>';
     }
    else {
      cnt ="0 - 0 / 0 ";  
     }
     
    document.getElementById("resultCnt").innerHTML=cnt;



    var nextLink = document.getElementById('nextLink');
    var prevLink = document.getElementById('prevLink');
    var firstPageLink = document.getElementById('firstPageLink');
    var lastPageLink = document.getElementById('lastPageLink');
    var gotoLink = document.getElementById('gotoLink');
    var gotoTxtBox = document.getElementById('gotoTxtBox');
<%
    String nextPage = "#";
    String prevPage = "#";
    String firstPage = "#";
    String lastPage = "#";
    String gotoPage = "#";
    out.println("prevLink.className = 'bottomTabLink';");
    out.println("nextLink.className = 'bottomTabLink';");
    out.println("gotoLink.className = 'bottomTabLink';");
    out.println("firstPageLink.className = 'bottomTabLink';");
    out.println("lastPageLink.className = 'bottomTabLink';");
    out.println("gotoTxtBox.className = 'bottomTabTxtBox';");
    out.println("gotoTxtBox.disabled = false;");
    
    if(noOfRecords > 0){
     gotoPage = "vpnListWorkOrders.jsp?"+(backFromFilter?"filter=1&":"");
    }
    else {
      out.println("gotoLink.className = 'bottomTabLinkDisabled';");
      out.println("gotoTxtBox.disabled=true;");
    } 
    int remainder = noOfRecords % maxRec ;
    if (remainder < 1){
      remainder = maxRec;
    }
    int lastPageStartRec = noOfRecords - remainder + 1;
    int nextPageStartRec = endCount + 1;
    if(!resultSetEmpty && numRows == maxRec){
        lastPage = "vpnListWorkOrders.jsp?"+(backFromFilter?"filter=1&":"")+"recStart="+lastPageStartRec ;
        if(nextPageStartRec < noOfRecords){
          nextPage = "vpnListWorkOrders.jsp?"+(backFromFilter?"filter=1&":"")+"recStart="+nextPageStartRec ;
        } 
        else {
          nextPage = lastPage;
        }
        
    }else{
        out.println("    nextLink.className = 'bottomTabLinkDisabled';");
        nextPage = "#";
        out.println("    lastPageLink.className = 'bottomTabLinkDisabled';");
        lastPage = "#";
        
    }
    
    
    int temp = fromCount - maxRec;
    
    
    if(fromCount > 1){
        firstPage = "vpnListWorkOrders.jsp?"+(backFromFilter?"filter=1&":"")+"recStart=1";
        if(temp > 0){
          prevPage = "vpnListWorkOrders.jsp?"+(backFromFilter?"filter=1&":"")+"recStart="+temp;
        }else{
          prevPage = firstPage;
        }
        
    }else{
        prevPage = "#";
        out.println("    prevLink.className = 'bottomTabLinkDisabled';");
        out.println("    firstPageLink.className = 'bottomTabLinkDisabled';");
        firstPage = "#";
    }
    
%>
    function next(){
        if ('<%=nextPage%>' == '#'){
          return false;
        }
        else {
          location.href='<%=nextPage%>';
          var tmp = <%=numRows%>;
        }
    }
    function prev(){
        if ('<%=prevPage%>' == '#'){
          return false;
        } 
        else {
        location.href='<%=prevPage%>';
        }
    }
    
    window.onload = function () {
        if(document.all){
           var tr_header = document.getElementById("header");
           tr_header.style.position = "fixed";
           var menuName = window.menuName;
           document.onclick = "hideContextMenu(menuName)";
           //var tr_heap = document.getElementById("heap");
           //tr_heap.style.position = "relative";
        }
        window.menuName = "auditMenu";
        document.getElementById('auditTable').oncontextmenu = showContextMenu;
        recalculateDiv();
  
    }

    window.onresize = function () {
        recalculateDiv();
    }
    
    function recalculateDiv(){
        document.body.style.overflow = "auto";
        //var container = document.getElementById("container");
       // var heap = document.getElementById("heap");
        //container.style.height = parseInt(document.body.clientHeight - heap.offsetHeight - 10)+ 'px';
        //container.style.width  = parseInt(document.body.clientWidth - 15)+ 'px';
        
    }

    function openNewAuditInstace() {
      var win;
      win=window.open('saShowAuditMsgInfo.jsp?id='+getSelectedId(),'','resizable=no,status=no,width=500,height=424,scrollbars=yes');
      win.focus();
      if(window.top.auditWindowsArray == null){
        window.top.auditWindowsArray = new Array();
      }
      window.top.auditWindowsArray.push(win);
    }

    function displayAuditInstances() {
      var win = null;
      if(window.top.auditWindowsArray == null){
        window.top.auditWindowsArray = new Array();
      }
      for(var i=0; i<window.top.auditWindowsArray.length; i++){
        if(!window.top.auditWindowsArray[i].closed){
            win = window.top.auditWindowsArray[i];
            break;
        }
      }
      if(win==null){
        win = window.open('saShowAuditMsgInfo.jsp?id='+getSelectedId(),'','resizable=no,status=no,width=500,height=424,scrollbars=yes');
        window.top.auditWindowsArray.push(win);
      }else{
        win.document.location = 'saShowAuditMsgInfo.jsp?id='+getSelectedId();
      }
      win.focus();
    }
    
    function auditMessageInfo( auditId ){
      var win = null;
      if(window.top.auditWindowsArray == null){
        window.top.auditWindowsArray = new Array();
      }
      for(var i=0; i<window.top.auditWindowsArray.length; i++){
        if(!window.top.auditWindowsArray[i].closed){
            win = window.top.auditWindowsArray[i];
            break;
        }
      }
      if(win==null){
        win = window.open('saShowAuditMsgInfo.jsp?id='+auditId,'','resizable=no,status=no,width=500,height=424,scrollbars=yes');
        window.top.auditWindowsArray.push(win);
      }else{
        win.document.location = 'saShowAuditMsgInfo.jsp?id='+auditId;
      }
      win.focus();
    }
    
    function getSelectedId(){
        var cookieName = window.menuName;
        return getCookie(cookieName);
    }

    function popupFilter(){
        var win;
        win = window.open('saAuditFilter.jsp','filterWindow','resizable=no,status=no,width=400,height=475,scrollbars=no');
        win.focus();
    }

    function showFilterValues(){
        top.messageLine.location = "saShowFilter.jsp";

    }
    
    function last()
    {
    
     if ('<%=lastPage%>' == "#"){
      return false;
      }
    writeToMsgLine("<%="][Retrieving Message data, please wait...."%>");
    
     location.href='<%=lastPage%>';
    }

   function first()
   {
    
    if ('<%=firstPage%>' == "#"){
       return false;
    }
    writeToMsgLine("<%="][Retrieving Message data, please wait...."%>");
    
    location.href='<%=firstPage%>';
    }
    function goto(recStartVar){

      if ('<%=gotoPage%>' == '#'){
        return false;
      } 
      recStartVar = recStartVar * 1;
      var gotoRedirect = '<%=gotoPage%>'+"recStart="+recStartVar+"&goto=true";
      
      if(recStartVar > '<%=noOfRecords%>' || recStartVar < 1 )
      {
        alert( '<%=invalidGoToEntry%>' + '<%=noOfRecords%>');
        return false;
      }else {
        location.href=gotoRedirect;
      } 
     }
    function submitPage(){
      var recStart = document.getElementById('gotoTxtBox').value;
      var isNumber = IsNumeric(recStart);
      
      if (isNumber == false){
       recStart = '0';
       }
      recStartValue = recStart *1;
      
      goto(recStartValue);
    }  


    function IsNumeric(sText)

    { 
     var ValidChars = "0123456789";
     var IsNumber=true;
     var Char;

 
     for (i = 0; i < sText.length && IsNumber == true; i++) 
       { 
       Char = sText.charAt(i); 
       if (ValidChars.indexOf(Char) == -1) 
          {
          IsNumber = false;
          }
        }
     return IsNumber;
   
    }
  
  function reset(){
   writeToMsgLine("<%="][Retrieving audit data, please wait...."%>");
   location.href = "vpnListWorkOrders.jsp?resetFlag=1&recStart=1";
   }
    

	  function confirmDeleteWorkorder(confirmMsg, cancelMsg) {
		if (confirm(confirmMsg)) {
      var cookieName = window.menuName;
      var wo = getCookie(cookieName);
      top.main.location = "vpnListWorkOrders.jsp?act=delete&serviceid=" + wo;
      return true;
              }
              writeToMsgLine(cancelMsg);
              return false;
            }
</script>

  <%
     

       if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == true) 
			   {
            %>

<div id="auditMenu" class="contextMenu"
    onclick="hideContextMenu('auditMenu')">
   
   <a onclick="return confirmDeleteWorkorder('<%=confirmMsg%>','<%=cancelMsg%>');" class="menuItem"
              onmouseover="toggleHighlight(event)"
              onmouseout="toggleHighlight(event)"><%=deleteWorkorder%></a>
          

</div>
    
               <%
                }
            %>
</body>
</html>
