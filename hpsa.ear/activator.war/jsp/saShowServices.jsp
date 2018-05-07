<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="com.hp.ov.activator.mwfm.*, 
             com.hp.ov.activator.mwfm.servlet.*,
             java.util.*,
             java.net.*" 
         info="Show all services." 
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute (Constants.USER) == null) {
%>
    <script>
        window.top.topFrame.location = window.top.topFrame.location;
    </script>
<%
       return;
    }   
 
    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader    ("Pragma",  "no-cache");

    request.setCharacterEncoding ("UTF-8");
        
    String sortDes = "<img src='/activator/images/down.png' align='absmiddle' border='0'/>";
    String sortAsc = "<img src='/activator/images/up.png' align='absmiddle' border='0'/>";
    String resortLink = "saShowServices.jsp?sort=";

    final int SERVICE_ID_DES = 0;
    final int SERVICE_ID_ASC = 1;
    final String SESSION_SORTING = "sorting_in_saShowServices.jsp";
    int currentSort = SERVICE_ID_ASC; 
    String serviceRetrievalCondition = "";
    String jobMaxFromConf =null;
    String serviceMax =null;
    boolean retrieveAllServicesFromCluster = false;
    boolean specifiedNumberOfServicesFromCluster =false;
    int serviceMaxRec =0;
    String SESSION_SERVICECONDITION = "session_in_saShowJobs.jsp";
    
    try {
        currentSort = ((Integer)session.getAttribute(SESSION_SORTING)).intValue();
    }catch(Exception e){
    }

    try {
        int newSorting = Integer.parseInt(request.getParameter("sort"));
        if( (newSorting == currentSort || newSorting == currentSort+1) && (currentSort%2 == 0)){
            if(newSorting == currentSort) currentSort = newSorting + 1;
            else currentSort = newSorting - 1;
        } else{
            currentSort = newSorting;
        }
        session.setAttribute(SESSION_SORTING,new Integer(currentSort));

    }catch(Exception e){;}
    
    if(session.getAttribute("job_records_max_records")!=null){
        jobMaxFromConf =(String)session.getAttribute("services_max_records");
    }
    
    if (request.getParameter("serviceMaxCondition") != null) {
        serviceRetrievalCondition = (String)request.getParameter("serviceMaxCondition"); 
    } else{
        serviceRetrievalCondition = (String)session.getAttribute(SESSION_SERVICECONDITION); 
    }
    
    if ("retrieveAllServices".equalsIgnoreCase(serviceRetrievalCondition)) {
        session.removeAttribute("specifiedNumberOfServices");
        serviceMax = null;
    } else if("retrieveLimitedServices".equalsIgnoreCase(serviceRetrievalCondition)){
        session.removeAttribute("specifiedNumberOfServices");
        serviceMax = jobMaxFromConf;
    } else if("specifiedNumberOfServices".equalsIgnoreCase(serviceRetrievalCondition)){   
        if(request.getParameter("serviceMax")!= null) { 
            serviceMax = (String)request.getParameter("serviceMax");        
        } else {
            serviceMax = (String)session.getAttribute("specifiedNumberOfServices");       
        }
        session.setAttribute("specifiedNumberOfServices",serviceMax);     
        specifiedNumberOfServicesFromCluster = true;
    } else {
        session.removeAttribute("specifiedNumberOfServices");
        serviceMax = jobMaxFromConf;
    }
    
    // Dirty exception handling 
    try{
        serviceMaxRec = Integer.parseInt(serviceMax);
    } catch(Exception e){
        serviceMax =null;
    }
    
    if(serviceMax!=null){
        retrieveAllServicesFromCluster = true;
    }else{
        retrieveAllServicesFromCluster =false;
    }
    
    session.setAttribute(SESSION_SERVICECONDITION,serviceRetrievalCondition);
    
    String retrieveAllServices = "saShowServices.jsp?"+"serviceMaxCondition=retrieveAllServices"+"&sort="+currentSort;
    String retrieveLimitedServices ="saShowServices.jsp?"+"serviceMaxCondition=retrieveLimitedServices"+"&sort="+currentSort;
    String specifiedNumberOfServices = "saShowServices.jsp?"+"serviceMaxCondition=specifiedNumberOfServices"+"&sort="+currentSort;
    String noOfServices = "";
%>

<%!
    //I18N strings
    final static String runningJobs      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("166", "Running Jobs");
    final static String scheduledJobs    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("765", "Scheduled Jobs");
    final static String services         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("692", "Services");
    final static String serviceID        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("415", "Service Id");
    final static String noServices       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("810", "No Services");
    final static String results          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("288", "Results ");
    final static String retrieveAll      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("811", "Retrieve all Services");
    final static String retrieveLimited  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("812", "Retrieve limited Services");
    final static String retrieveSpecified = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("813", "Retrieve specified number of Services");
%>
<html>
    <head>
        <title>HP Service Activator</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8">
        <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
        <link rel="stylesheet" type="text/css" href="/activator/css/saContextMenu.css">
        <link rel="stylesheet" type="text/css" href="/activator/css/saTabs.css">
        <script language="JavaScript" src="/activator/javascript/table.js"></script>
        <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
        <script language="JavaScript" src="/activator/javascript/saContextMenu.js"></script>
        <script language="JavaScript" src="/activator/javascript/saNavigation.js"></script>
        <script language="JavaScript">
            if (window.top.refresh==null || window.top.refresh != "OFF") {
                document.write("<meta http-equiv='refresh' content='<%=session.getAttribute(Constants.JOB_REFRESH_RATE)%>'>");
            }

            window.onload = function () {
                window.menuName = "serviceMenu";
                document.getElementById('serviceTable').oncontextmenu = showContextMenu;
            }

            function getRunnningJobs() {
                var cookieName = window.menuName;
                var srvcId = getCookie(cookieName);

                if (srvcId == null)  {
                  writeToMsgLine("Please reselect service.");
                } else {
                  top.main.location.href = 'saCreateFrame.jsp?jsp=saShowJobsForService.jsp?serviceid=' + srvcId;                  
                }
            }

            function getScheduledJobs() {
                var cookieName = window.menuName;
                var srvcId = getCookie(cookieName);

                if (srvcId == null)  {
                  writeToMsgLine("Please reselect service.");
                }
                else {
                  top.main.location.href = 'saCreateFrame.jsp?jsp=saShowScheduledJobsForService.jsp?serviceid=' + srvcId;
                }
            }

            if (document.all) {
                var menuName = window.menuName;
                document.onclick = "hideContextMenu(menuName)";
            }
            
            var serviceNumber = null;
        var specifiedNumOfServices = 0;
        
        function setNumberOfServices(){
            serviceNumber = document.getElementById('noOfServices').value;
            if(specifiedNumOfServices == 1) {
                specifiedNumOfServices = 0;
                location.href='<%=specifiedNumberOfServices%>'+'&serviceMax='+serviceNumber;
            }
        }
        
        function specifiedNumberOfServices(){
            specifiedNumOfServices = 1;            
            setNumberOfServices();
        }
         
        function retrieveAllServices(){
            location.href='<%=retrieveAllServices%>';
        }
        
        function retrieveLimitedServices(){
            location.href='<%=retrieveLimitedServices%>';
        }
        
        function redirect(param) {
            if("Retrieve specified number of Services" == param || "specifiedNumberOfServices" == param){
                specifiedNumberOfServices();
            } else if ("Retrieve limited Services" == param || "retrieveLimitedServices" == param) {
                retrieveLimitedServices();
            } else if ("Retrieve all Services" == param || "retrieveAllServices" == param) {
                retrieveAllServices();
            }
        }
        
        if('<%=serviceRetrievalCondition%>' == 'specifiedNumberOfServices') {
            window.onload = redirect('<%=serviceRetrievalCondition%>') ;
            }
        </script>
    </head>
    <body onclick="rowUnSelect();hideContextMenu('serviceMenu')" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
        
   
       <table cellpadding="0" cellspacing="0" width="100%">
         <tr align=left>
          <td nowrap class="frameHead"><%=services%></td>
         </tr> 
       </table>        
            
        <table class="activatorTable" id="serviceTable">
            <tr height="5">
                <td>
                    <table border='0' cellpadding='0' cellspacing='0' width="100%" class="bottomTab">
                        <tr>
                            <td class='bottomTab' nowrap>
                                <table border='0' id="resultTable" cellpadding='0' cellspacing='0' width="100%">
                                    <tr>
                                        <td  class ="bottomTab" align ="right">
                        <select name = "NumberOfServices" onchange="redirect(this.value)">                    
                                        <%if("specifiedNumberOfServices".equalsIgnoreCase(serviceRetrievalCondition)) { %>
                                            <option value="<%=retrieveSpecified%>" selected = "selected" ><%=retrieveSpecified%></option>
                                            <option value="<%=retrieveLimited%>"  ><%=retrieveLimited%></option>
                                            <option value="<%=retrieveAll%>"  ><%=retrieveAll%></option>                              
                                        <%} else if ("retrieveLimitedServices".equalsIgnoreCase(serviceRetrievalCondition)) {%>                                  
                                            <option value="<%=retrieveSpecified%>"   ><%=retrieveSpecified%></option>
                                            <option value="<%=retrieveLimited%>" selected = "selected"  ><%=retrieveLimited%></option>
                                            <option value="<%=retrieveAll%>"  ><%=retrieveAll%></option>                              
                                        <%} else if ("retrieveAllServices".equalsIgnoreCase(serviceRetrievalCondition)) {%>
                                            <option value="<%=retrieveSpecified%>"   ><%=retrieveSpecified%></option>
                                            <option value="<%=retrieveLimited%>"  ><%=retrieveLimited%></option>
                                            <option value="<%=retrieveAll%>" selected = "selected" ><%=retrieveAll%></option>
                                        <%} else {%>
                                            <option value="<%=retrieveSpecified%>"  ><%=retrieveSpecified%></option>
                                            <option value="<%=retrieveLimited%>" selected = "selected" ><%=retrieveLimited%></option>
                                            <option value="<%=retrieveAll%>"   ><%=retrieveAll%></option>
                                        <%}%>
                                        </select>
                                    </td>
                                    <%if(session.getAttribute("specifiedNumberOfServices") != null){ %>
                                        <td align ="right"  class ="bottomTab"><input type="text" id="noOfServices" onchange="setNumberOfServices()" size = "3" value ="<%=(String)session.getAttribute("specifiedNumberOfServices")%>" ></td>
                                    <%}else{ %>
                                        <td align ="right" class ="bottomTab"><input type="text" id="noOfServices" onchange="setNumberOfServices()" size = "3" value="" ></td>
                                    <%} %>                            
                                    <td align="right" class='bottomTab' nowrap><%=results%>&nbsp;<span id="resultCnt"></span></td>
                                </tr>
                            </table>
                        </td>
                    </tr>              
                </table>
                </td>
            </tr>
            <tr id="header">
                <td width="20%" class="mainHeading"><a TARGET="_self" href="<%=resortLink+SERVICE_ID_DES%>"><%=serviceID%>&nbsp;<%=(currentSort==SERVICE_ID_DES?sortDes:"")%><%=(currentSort==SERVICE_ID_ASC?sortAsc:"")%></a></td> 
            </tr>

            <%                                
                WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
                switch(currentSort){
                    case SERVICE_ID_DES:    wfm.setComparator("SolutionDescriptor", "ServiceId", true); break;
                    case SERVICE_ID_ASC:    wfm.setComparator("SolutionDescriptor", "ServiceId", false); break;
                }
                Exception e = null;
                SolutionDescriptor solutionDescriptor=null;
                String[] serviceIds = null;
                HashMap responseMap =null;
        int columns = 0;
                try {                   
                    if(serviceMax!=null){
                solutionDescriptor = wfm.retrieveServices(serviceMaxRec);
            } else{
                solutionDescriptor = wfm.retrieveServices();
                    }
                    StringBuffer showJobsMessage = new StringBuffer();
                    if (solutionDescriptor == null) {
            %>
            <!--<SCRIPT LANGUAGE="JavaScript">
                writeToMsgLine("<%=noServices%>");
            </SCRIPT>-->
            <tr class="tableRowInfo">
                <td class="tableRowInfo" colspan="<%= columns+1%>"><%=noServices%></td>
            </tr>
            <%
                    } else {
                        if(solutionDescriptor.getStatus() != 0) {
                            responseMap = (HashMap) solutionDescriptor.getExceptionMap();        
                            for (Iterator it = responseMap.keySet().iterator(); it.hasNext();) {
                                String localHostName = (String)it.next();
                                e = (Exception) responseMap.get(localHostName);
                                if (e != null) {
                                    showJobsMessage.append("Services could not be obtained from ");
                                    showJobsMessage.append(localHostName);
                                    showJobsMessage.append(" - Exception Received - ");
                                    showJobsMessage.append(e);
                                    showJobsMessage.append("<br>");
                                }
                            }
                            if (showJobsMessage.length() != 0) {
            %>
            <script language="JavaScript">
                writeToMsgLine("<%=showJobsMessage%>");
            </script>
            <%
                            }
                        }
                        serviceIds=solutionDescriptor.getServiceIds();
                        if(serviceIds==null || serviceIds.length ==0){
            %>
            <!--<SCRIPT LANGUAGE="JavaScript">
                writeToMsgLine("<%=noServices%>");
            </SCRIPT>-->
            <tr class="tableRowInfo">
                <td class="tableRowInfo" colspan="<%= columns+1%>"><%=noServices%></td>
            </tr>            
            <%
                        } else {
                            int numRows=1;
                            int size=serviceIds.length;
                            for (int i = 0; i < size; i++) {
                                String srvcId=serviceIds[i];
                                String rowClass = (numRows%2 == 0) ? "tableEvenRow" : "tableOddRow";
                                String colClass = "tableCell";
            %>
            <tr id="<%=srvcId%>" class="<%=rowClass%>" onClick="hideContextMenu('serviceMenu');" onMouseOver="mouseOver(this);" onMouseOut="mouseOut(this);">
                <td class="<%=colClass%>"> <%= srvcId %></td>
            </tr>
            <%
                                ++numRows;
                            }
                        }
                    }            
                } catch (Exception e1) {
                    e1.printStackTrace();
            %>
            <SCRIPT LANGUAGE="JavaScript"> 
                alert("<%= ExceptionHandler.handle(e1) %>"); 
                top.location.href = "..";
            </SCRIPT>
            <%
                } 
            %>
        </table>
        <!-- Update the result count in the tab/header frame -->
    <script language="JavaScript">
        document.getElementById("resultCnt").innerHTML = <%=(serviceIds != null && serviceIds.length>0?"'1 - "+serviceIds.length+"'":"'0'")%>;
        </script>
        <!-- hidden until menu is selected -->
        <div id="serviceMenu" class="contextMenu" onclick="hideContextMenu('serviceMenu')">
            <a href="#" onclick="getRunnningJobs();" class="menuItem" onmouseover="toggleHighlight(event)" onmouseout="toggleHighlight(event)"> <%=runningJobs%></a>
            <a href="#" onclick="getScheduledJobs();" class="menuItem" onmouseover="toggleHighlight(event)" onmouseout="toggleHighlight(event)"> <%=scheduledJobs%></a>
        </div>
    </body>
</html>
