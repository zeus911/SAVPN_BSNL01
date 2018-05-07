<%--##################################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>

<%-- FindAllServices.jsp                                            --%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>


<%@page info="Find all services belonging to a specific customer"
 contentType="text/html; charset=UTF-8"
  import="java.sql.*, com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*,java.text.*,
          com.hp.ov.activator.crmportal.action.*,
          com.hp.ov.activator.crmportal.bean.*,       
          com.hp.ov.activator.crmportal.common.*,
          com.hp.ov.activator.crmportal.helpers.*,
		      com.hp.ov.activator.crmportal.utils.*,
		      java.sql.*, 
		      javax.sql.*,
		      java.util.*, 
		      java.io.*, 
		      java.text.*, 
		      java.net.*,
		      com.hp.ov.activator.crmportal.utils.DatabasePool,
		      org.apache.log4j.Logger,
          java.util.Date" %>  

<%
  response.setDateHeader("Expires",0);
  response.setHeader("Pragma","no-cache");

   ServiceForm ListServiceForm = (ServiceForm)request.getAttribute("ServiceForm");
   
   
   ServiceBean servicebean=null;
   String pt=(String)request.getParameter("mv"); 
   if(pt==null)
    pt = "viewpageno";
   String customerid = ListServiceForm.getCustomerid();
   String presNameSearch = null;
	Boolean allowModifyControlsForProtectionAttachment = true;
   boolean doResetReload = Boolean.valueOf(request.getParameter("doResetReload")).booleanValue();
   String  selected_serviceid = request.getParameter("selected_serviceid");
   //PR 15068: for expandation feature
   String  selected_att = request.getParameter("selected_att");
   //Custom for SearchSite
   String searchSite=null;
   String serviceid=null;

   HashSet roles = (HashSet) session.getAttribute(Constants.ROLES_KEY);
   boolean isOperator = false;
   boolean isAdministrator = false;
   //System.out.println("roles :::::::"+roles);
   if(roles.contains(Constants.ROLE_ADMIN)) {isAdministrator = true;}
   if(roles.contains(Constants.ROLE_OPERATOR)) {isOperator = true;}

   ArrayList pServiceIdList = new ArrayList();
   pServiceIdList=(ArrayList)request.getAttribute("pServiceIdList");
   String nextstate="";
   String deleteIconChild = "";
  // System.out.println(" doResetReload >>>>>>>" +doResetReload);


			int cpage = 1;
			int totalPages = 1 ;
			int currentRs=0;
			int lastRs=0;	
			int vPageNo = 1;


	String strcpage = (String)request.getAttribute("cpage");
	if(strcpage!=null)
	  cpage  = Integer.parseInt(strcpage);
    String strcurrentRs  =  (String)request.getAttribute("currentRs");
	if(strcurrentRs!=null)
	  currentRs  = Integer.parseInt(strcurrentRs);
	String strlastRs	 =  (String)request.getAttribute("lastRs");
	if(strlastRs!=null)
	  lastRs = Integer.parseInt(strlastRs);
	String strtotalPages =  (String)request.getAttribute("totalPages");
	if(strtotalPages!=null&&!strtotalPages.equalsIgnoreCase(""))
	  totalPages = Integer.parseInt(strtotalPages);
	String strvPageNo	 =  (String)request.getAttribute("vPageNo");
	if(strvPageNo!=null)
	  vPageNo = Integer.parseInt(strvPageNo);

	String strSort	 =  (String)request.getAttribute("sort");
	if(strSort==null)
	  strSort = "desc";

String currentSort = "desc";
	if(strSort.equalsIgnoreCase("asc"))
		currentSort = "desc";
	else if (strSort.equalsIgnoreCase("desc"))
     	currentSort = "asc";


//PR15763 begin
String strselValue = (String)request.getParameter("selValue");
String strselId = (String)request.getParameter("selId");
if(strselValue!=null && strselId !=null){
  session.setAttribute(strselId, strselValue);
  //System.out.println("#############################" + strselId + " " + strselValue);
}
//PR15763 end

		//this hash map will hold the expnsion /colapsed states of the services : now only layer 3 services 
		//These states are set in the session in the service_tree_states variable
		 HashMap treeStatesOfServices = (HashMap)session.getAttribute("service_tree_states");

		// Now form the link appender here

%>


<html:html locale="true">
  <head>
    <META Http-Equiv="Cache-Control" Content="no-cache">
    <META Http-Equiv="Pragma" Content="no-cache">
    <META Http-Equiv="Expires" Content="-1">
    <link rel="stylesheet" type="text/css" href="css/activator.css">
    <link rel="stylesheet" type="text/css" href="css/awfweb2.css">   
   	<script LANGUAGE="JavaScript" TYPE="text/javascript">



    <!-- //hide me
      var serviceid;
      var customerid;
      var sendSaDeleteRequest;
      var action;
      var currentState;
      var servicesInProcess = new Array(0);

      function isBusy(serviceid){
        for(i=0; i < servicesInProcess.length; i++){
          if(serviceid == servicesInProcess[i]){
            return true;
          }
        }
        return false;
      }

      function serviceInProgress(serviceid){
         if(isBusy(serviceid)){
          alert(' <bean:message key="js.service.process" /> ');
          return true;
        }
        servicesInProcess[servicesInProcess.length] = serviceid;
        return false;
      }

      function disableService(serviceid, customerid, action){
        if(serviceInProgress(serviceid)){
          return;
        }
        //var page = 'CommitDisableService.jsp?serviceid='+serviceid+'&customerid='+customerid+'&action='+action;
      //  self.location.href = page;
      }

      function stopPeriodic(serviceid, customerid){
        if(serviceInProgress(serviceid)){
          return;
        }
       // var page = 'StopPeriodicService.jsp?serviceid='+serviceid+'&customerid='+customerid;
       // self.location.href = page;
      }

      function deleteService(serviceid)
      {
		 // parent.reload.setServiceOperation('true');

    	//var page = '/crm/DeleteService.do?serviceid='+serviceid+'&customerid='+customerid+'&sendSaDeleteRequest='+sendSaDeleteRequest;
        var conf = confirm('Do you wish to proceed and delete this service ?');

        if (conf == true) {
         // self.location.href = page;
		 return true;
        }else{
			var deleteId =   "deleteIcon"+serviceid
			var deleteParent = 	document.getElementById(deleteId);
			deleteParent.style.visibility = "visible";
		  return false;
        }
      }

      function resendServiceRequest(serviceid, customerid)
      {
        if(serviceInProgress(serviceid)){
          return;
        }

       // var page = 'CommitModifyService.jsp?serviceid='+serviceid+'&customerid='+customerid;
        //self.location.href = page;
      }

      function resendModifyRequest(serviceid, customerid, action, currentState)
      {

        if(serviceInProgress(serviceid)){
          return;
        }

        var nextState = '';
        var page = '';

        if (currentState == 'Modify_Failure') {
          nextState = 'Modify_Request_Sent';
        }

        if (currentState == 'Modify_PE_Failure') {
          //nextState = 'Modify_PE_Request_Sent';
		  nextState = 'PE_Modify_Request_Sent';
        }

        if (currentState == 'Modify_Partial') {
          nextState = 'Undo_Modify_Sent';
        }

        if (currentState == 'Modify_PE_Partial') {
          //nextState = 'Undo_Modify_PE_Sent';
		  nextState = 'PE_Undo_Modify_Sent';
        }

      /*  if (nextState != '') {
          page = 'CommitModifyService.jsp?serviceid='+serviceid+'&customerid='+customerid+'&action='+action+'&state='+nextState;
        } else {
          page = 'CommitModifyService.jsp?serviceid='+serviceid+'&customerid='+customerid+'&action='+action;
        }
        self.location.href = page;*/
      }

      function doModify(serviceid, customerid, parentServiceId)
      {
        /*var page = 'ModifyServiceForm.jsp?serviceid='+serviceid+'&customerid='+customerid;
        if(parentServiceId)
          page += '&parentserviceid='+parentServiceId;
        self.location.href = page;*/
      }

      function undoModify(serviceid, customerid)
      {
        if(serviceInProgress(serviceid)){
          return;
        }

       // var page = 'UndoModifyService.jsp?serviceid='+serviceid+'&customerid='+customerid;
       // self.location.href = page;
      }

	  var bakStatus = "";
	  function setStatus(action, name)
		  {
		bakStatus = window.status;
		window.status = action + " " + name;
		return true;
	  }

	  function unsetStatus(){
		window.status = bakStatus;
		return true;
	  }

	 function switchAutoRefresh(autorefreshflag)
		  {

         var icon = document.getElementById("refreshIcon");
		 
		if(parent.reload.bDoUpdate == true){
			icon.src="images/autoRefreshOff.gif";
			icon.title="Auto-refresh is off";
			parent.reload.stopReload("true");
		}else{
			parent.reload.bDoUpdate = true;
			parent.reload.startReload("false");
			icon.src="images/autoRefreshOn.gif";
			icon.title="Auto-refresh is on";

		}
	  } 

 

	 function init(custid,pt,currpage,isnavigate,currentRs,lastRs,totalPages,strSort,search)
			 {
                
	    if ('Netcape' == navigator.appName) document.forms[0].reset();
				
					
		parent.reload.unlockScroll();				
		parent.reload.doScroll();			
		parent.reload.findInstance();
	    parent.reload.setURL('/crm/ListAllServices.do?sort='+strSort+'&customerid='+custid+'&mv='+pt+'&currentPageNo='+currpage+'&navigate='+isnavigate+ '&currentRs='+currentRs+'&lastRs='+lastRs+'&totalPages='+totalPages);
	    parent.reload.setCustomerId(custid);
		parent.reload.setServiceOperation('false');

		var icon = document.getElementById("refreshIcon");
		if(parent.reload.bDoUpdate == true){
			icon.src="images/autoRefreshOn.gif";
			icon.title="Auto-refresh is on";
			//parent.reload.startReload("<%=doResetReload%>");
			parent.reload.startReload("true");
		}else{
			icon.src="images/autoRefreshOff.gif";
			icon.title="Auto-refresh is off";
		}
               
	        } 

	    // end hide -->
    </script>
  </head>


  <%!
  
  final private Logger logger = Logger.getLogger("CRMPortalLOG");
//PR 15068
  final private static String reuse_failure  = "REUSE_FAILURE";
//PR 15068  
  final private static String delete_failure  = "Delete_Failure";
  final private static String modify          = "Modify";
  final private static String failure         = "Failure";
  final private static String partial         = "Partial";
  final private static String temporary       = "Temporary";
  final private static String ok              = "Ok";
  final private static String pe_ok           = "PE_Ok";
  final private static String ce_ok           = "CE_Setup_Ok";
  final private static String sched           = "Wait";
  final private static String modify_partial  = "Modify_Partial";
  final private static String enable          = "Enable";
  final private static String disable         = "Disable";
  final private static String disabled        = "Disabled";
  final private static String periodic        = "Periodic";
  final private static String ce_failure      = "CE_Failure";
  final private static String ce_temp_failure = "CE_Temporary_Failure";
  final private static String ce_partial_temp_failure = "CE_Partial_Temporary_Failure";
//  final private static String enabled         = "Enabled";
  final private static HashSet STATES_TO_ENABLE = new HashSet(6);
  final private static HashSet STATES_TO_DISABLE = new HashSet(9);

 static{
    STATES_TO_ENABLE.add("Disable_Failure");
    STATES_TO_ENABLE.add("Enable_Failure");
    STATES_TO_ENABLE.add("PE_Disabled");
    STATES_TO_ENABLE.add("CE_Disabled");
	STATES_TO_ENABLE.add("PE_CE_Disabled");
    STATES_TO_ENABLE.add("Disabled");

    STATES_TO_DISABLE.add("PE_Ok");
	STATES_TO_DISABLE.add("PE_CE_Ok");
    STATES_TO_DISABLE.add("CE_Setup_Ok");
    STATES_TO_DISABLE.add("Ok");
    STATES_TO_DISABLE.add("Disable_Failure");
    STATES_TO_DISABLE.add("Enable_Failure");
    STATES_TO_DISABLE.add("End_Time_Failure");
    STATES_TO_DISABLE.add("PE_End_Time_Failure");
	STATES_TO_DISABLE.add("PE_CE_End_Time_Failure");
  }

 final static String _replace(String name)
  {
    return name.replace ('_', ' ');
  }
%>
    
<%
 
 //   String customerid = ListServiceForm.getCustomerid();
   HashMap nextStateMap = new HashMap();
   nextStateMap.put("Modify_Failure","Modify_Request_Sent");
   nextStateMap.put("PE_Modify_Failure","PE_Modify_Request_Sent");
   nextStateMap.put("PE_CE_Modify_Failure","PE_CE_Modify_Request_Sent");
   nextStateMap.put("Modify_Partial","Undo_Modify_Sent");
   nextStateMap.put("PE_Modify_Partial","PE_Undo_Modify_Sent");
   nextStateMap.put("PE_CE_Modify_Partial","PE_CE_Undo_Modify_Sent");


    int j =0;
    
	try {
    
	     Service[] services = null;
	     Service[] parentServices = null;  		 	      
         ArrayList v = new ArrayList();	    
	  
		 int allServices= 0;   
		int existingServiceCount =0;
    //String presName = (String)request.getAttribute("presNameSearch") ;
		 int sizeParent = 0;
         
         int[] parentsSubService=new int[sizeParent];
		
            // Find all top level service, that is  parent services.
            parentServices = ListServiceForm.getParentServices();

			 // Find all  services , to be listed
            services = ListServiceForm.getServices();
			//Debug
//			for(int i=0;i<services.length;i++){
//			System.out.println("David Debug======="+services[i].getServiceid());
//			}
			
           // Find TOTAL NO of services belonging to a specific customer.
		   String sallServices=(String)request.getAttribute("allServices");
		
			if(sallServices!=null){			
		    allServices = Integer.parseInt((String)request.getAttribute("allServices"));
			}
			String sexistingServiceCount=(String)request.getAttribute("existingServiceCount");	
			
			if(sexistingServiceCount!=null){			 
			  existingServiceCount = Integer.parseInt((String)request.getAttribute("existingServiceCount"));
			}
			   
		if( parentServices != null)
		{			
		  
		    sizeParent = parentServices.length;
		    parentsSubService=new int[sizeParent];
		   // parentsSubService = ListServiceForm.getParentsSubService();

		}//if

                  /* 
				  *   PAGINATION LOGIC
				  *   cpage = currentpage number 
				  *   currentRs = starting number of record pointer on the current page
				  *   lastRs = last number of record pointer on the current page
				  *   recPerPage = total no of records to be displayed per page
				  *   vPageNo = view this page number
				  */
		
				 cpage      = Integer.parseInt((String)request.getAttribute("cpage"));
				 currentRs  = Integer.parseInt((String)request.getAttribute("currentRs"));
				 lastRs     = Integer.parseInt((String)request.getAttribute("lastRs"));
				 totalPages = Integer.parseInt((String)request.getAttribute("totalPages"));
				 vPageNo    = cpage;

             HashMap refreshMap = new HashMap();
			
		     refreshMap.put("customerid",customerid);
			 refreshMap.put("doResetReload","true");
			 refreshMap.put("mv","viewpageno	");
			 refreshMap.put("currentPageNo",String.valueOf(cpage));
			 refreshMap.put("viewPageNo",String.valueOf(vPageNo));
             refreshMap.put("currentRs",String.valueOf(currentRs));
			 refreshMap.put("lastRs",String.valueOf(lastRs));
			 refreshMap.put("sort",strSort);
       refreshMap.put("presName",presNameSearch);
			 pageContext.setAttribute("refreshParamsMap", refreshMap);
	    
	%>

<body onmousemove="parent.reload.setYPos();" onUnLoad="tmp=parent.reload.bDoUpdate; parent.reload.stopReload('true'); parent.reload.bDoUpdate=tmp; window.status = '';" onLoad="init('<%=customerid%>','<%=pt%>','<%=cpage%>','<%="false"%>','<%=currentRs%>','<%=lastRs%>','<%=totalPages%>','<%=strSort%>','<%=presNameSearch%>');">

  <center>

  <table width="100%" border="0">
      <tr>
        
		<td class="white">	  
		  <html:img page="/images/Services.gif" border="0" align="left" title="Services"/>     
		</td>

		<td class="white"><h2 class="mainSubHeading"><center>
		<bean:message key="title.cust.service"/></center></h2></td>
        <td class="white">
		  
			<a href="javascript:switchAutoRefresh();"><img id="refreshIcon" src="images/autoRefreshOn.gif" border="0" align="right" title="Auto-refresh is on"></a>
			<a href="/crm/ListAllServices.do?customerid=<%= customerid %>&doResetReload=true&mv=<%="viewpageno"%>&currentPageNo=<%=cpage%>&viewPageNo=<%=vPageNo%>&sort=<%=strSort%>&presName=<%=presNameSearch%>" target="main"><img src="images/refresh.gif" border="0" align="right" title="Refresh"></a>
		</td>
      </tr>
  </table>
</center>

<!--  **********************************************************************************************  -->
<!--  **********************************************************************************************  -->
<!--  * Table specifying customer data                                                             *  -->
<!--  **********************************************************************************************  -->
<!--  **********************************************************************************************  -->

<%    // Get the customer .
      Customer customer = ListServiceForm.getCustomer();
%>


      <table align="center" width="100%" border="0" cellpadding="2" cellspacing="1">
        <tr>
          <td class="title" colspan="5" align="left"><bean:message key="title.customerdetails"/></td>
        </tr>
        <tr>
          <th class="center"><bean:message key="label.customer.id"/></th>
          <th class="center"><bean:message key="label.company.name"/></th>
          <th class="center"><bean:message key="label.contact.person"/></th>
          <th class="center"><bean:message key="label.phone.number"/></th>
          <th class="center"><bean:message key="label.email"/></th>
        </tr>

<%      if (customer != null)
	{

                 HashMap updatecustparams = new HashMap();
		        // String mv = null;
                 updatecustparams.put("customerid",customerid);
                 updatecustparams.put("mv",pt);
				 updatecustparams.put("doResetReload","true");
				 updatecustparams.put("sort",strSort);
		         pageContext.setAttribute("updatecustparamsMap", updatecustparams);
			
%>
          <tr>
            <td class="list0" align="center">
			<html:link page="/EditCustomerfromList.do" name="updatecustparamsMap" scope="page" >
			<%= customerid %></td>
			</html:link>

            <td class="list0" align="center"><%= customer.getCompanyname() == null ? "&nbsp;" : Utils.escapeXml(customer.getCompanyname())%></td>
            <td class="list0" align="center"><%= customer.getContactpersonname() == null ? "&nbsp;" : Utils.escapeXml(customer.getContactpersonname()) %> <%= customer.getContactpersonsurname() == null ? "&nbsp;" : Utils.escapeXml(customer.getContactpersonsurname()) %></td>
            <td class="list0" align="center"><%= customer.getContactpersonphonenumber() == null ? "&nbsp;" : Utils.escapeXml(customer.getContactpersonphonenumber()) %></td>
            <td class="list0" align="center"><%= customer.getContactpersonemail() == null ? "&nbsp;" : Utils.escapeXml(customer.getContactpersonemail()) %></td>
        </tr>

          <tr>
            <td class="list1" colspan="5">&nbsp;</td>
          </tr>

      </table>

<!--  **********************************************************************************************  -->
<!--  **********************************************************************************************  -->
<!--  * Table specifying all possible services to DISPLAY                                        *  -->
<!--  **********************************************************************************************  -->
<!--  **********************************************************************************************  -->
<%
     
      if(isOperator)
	{
          ServiceType[] serviceTypes = null; 
		  serviceTypes = ListServiceForm.getServiceTypes() ;
%>

          <p>
          <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0">
           <tr>
            <td class="title" align="left" colspan="<%= serviceTypes == null ? 1 : serviceTypes.length %>">
			<bean:message key="title.create.new.services"/></td>
           </tr>

              <tr>
<%              if (serviceTypes != null) 
				  {
						  for (int i=0; i < serviceTypes.length; i++)
				  {
							  if(serviceTypes[i].getName().equalsIgnoreCase("GIS-VPN")){
		%>
		<th class="center">GIS-Service&nbsp;</th>
		<%
			} else {
		%>
		<th class="center"><%=_replace (serviceTypes[i].getName())%>&nbsp;</th>
		<%
			}
				  }
						  }
		%>
	</tr>
	<tr align="center">
		<%
			if (serviceTypes != null)
				  {
				          HashMap createparam = new HashMap();
                          
                      for (int i=0; i<serviceTypes.length; i++)
					  {
                         
		                  createparam.put("customerid",customerid);
		                  createparam.put("type",serviceTypes[i].getName());
						  createparam.put("mv","viewpageno");
						  if(!serviceTypes[i].getName().equals("Trunk")){
						  createparam.put("currentPageNo",String.valueOf(cpage));
						  createparam.put("viewPageNo",String.valueOf(cpage));
						  }
						  createparam.put("sort",strSort);
						  pageContext.setAttribute("createparamsMap", createparam);
						  String strServTypeImg="/images/"+serviceTypes[i].getName()+".gif";
						  //System.out.println("strServTypeImg ==="+strServTypeImg);
	 %>
                  <td class="list0">	
                  <html:link page="/CreateService.do" name="createparamsMap" scope="page" onclick=" parent.reload.setServiceOperation('true');">
	              <html:img page="<%=strServTypeImg%>"  width="64" border="0" title="<%=serviceTypes[i].getDescription() %>" align="center"/>
	              </html:link>
				  </td> 
                     
				   
<%                   }
                }
	%>
              </tr>
              <tr align="center">
			  <td class="list0" colspan=<%= serviceTypes == null ? 1 : serviceTypes.length + 2%>>&nbsp;</td>
			  </tr>
            
			  <tr align="center">
<%              if (serviceTypes != null)
		        {
                  for (int i=0; i<serviceTypes.length; i++)
					  { %>
                    <td class="list0">
					<a href="#" onClick="window.open ('help/index.html#<%= serviceTypes[i].getName() %>', 'foo', 'menubar=no,toolbar=no,scrollbars=yes');"><img border=0 src="images/info.gif" align="center" valign="bottom" title="Help about <%= serviceTypes[i].getDescription() %>"></a></td>
<%                   }
                }%>
              </tr>

			 
              
			  <tr>
                <td class="list0" colspan=<%= serviceTypes == null ? 1 : serviceTypes.length %>>&nbsp;</td>
              </tr>


          </table>
<%
           
    }//operator if

%>
        <p>  
		<html:form action="/ListAllServices">
          <table align="center" width="100%" border="0" cellpadding="2" cellspacing="0">
           <tr>
              <td class="title" ><font color ="white" size="2pt"><bean:message key="label.existing.serv"/> (<%=existingServiceCount%>)</font>
			  </td>
			  
			   <td width="20%" class="title" align="Right"> 
				   <html:link  href="javascript:callviewBySiteName();" >
					<font color = "white" size="1pt"><bean:message key="label.search"/></font>
				   </html:link>				   
				   <input type="text" name="txtviewSearch" >
				   </td>
				   
			   <td width="10%"class="title" align="Right">
			   <font color ="white" size="1pt"><bean:message key="label.page.service"/> <%=cpage%>/<%=totalPages%></font>
			   </td>
               <td width="5%"class="title"></td>
          <%		
				String stsCurrPg = String.valueOf(cpage);
			    String strViewPgNo = String.valueOf(vPageNo);

				HashMap navigationparams = new HashMap();
			    navigationparams.put("customerid",customerid);
		        navigationparams.put("doResetReload","true");
			  	navigationparams.put("currentPageNo",stsCurrPg);	
				//navigationparams.put("hidautoRefreshOn",autoRefreshOn);
                navigationparams.put("currentRs",String.valueOf(currentRs));
			    navigationparams.put("lastRs",String.valueOf(lastRs));
				navigationparams.put("sort",strSort);
	      %>            
	                	             
				  <input type="hidden" name="customerid" value="<%=customerid%>">
				  <input type="hidden" name="doResetReload" value="true">
				  <input type="hidden" name="mv" value="viewpageno">
				  <input type="hidden" name="currentPageNo" value="<%=stsCurrPg%>">
                
				  <input type="hidden" name="viewPageNo" value="<%=strViewPgNo%>">				
                  <input type="hidden" name="hidviewPageNo" value="<%=vPageNo%>">
				  <input type="hidden" name="sort" value="<%=strSort%>">
		<%
                          if(  totalPages > 0)
				  { 
		               navigationparams.put("mv","viewpageno");
					   pageContext.setAttribute("paramsMap", navigationparams);

		%>
                  <td width="25%" class="title" align="Right"> 
				   <html:link  href="javascript:callviewByPageNo();" >
					<font color = "white" size="1pt"><bean:message key="label.gotopage"/></font>
				   </html:link>				   
				   <input type="text" size="3" name="txtviewPageNo" value="<%=String.valueOf(cpage)%>">
				   </td>
										
	   <%          } 
	
		
				if( cpage >1 )
				{
		               navigationparams.put("mv","first");
					   pageContext.setAttribute("paramsMap", navigationparams);

		         
	   %>			
	            <td width="5%" class="title" align="Left">                     
				    <html:link page="/ListAllServices.do" name="paramsMap" scope="page">
						 <font color = "white" size="1pt"><bean:message key="label.first"/> </font>
				    </html:link>
				</td>  

	<%          }   
				else
				{
	 %>            
	               <td width="5%" class="title" align="Left">   
					 <font color = "#C0C0C0" size="1pt"><bean:message key="label.first"/> </font>
				 </td>

	 <%         } 
	
				if( cpage > 1 )
				{
                       navigationparams.put("mv","prev");
					   pageContext.setAttribute("paramsMap", navigationparams);

	%>				<td  width="8%"class="title"  align="Left">                     
						  <html:link page="/ListAllServices.do" name="paramsMap" scope="page" >
						 <font color = "white" size="1pt"> <bean:message key="label.prev"/>  </font>
						 </html:link>
					</td>  
	<%          }   
				else
				{
	 %>             <td  width="8%"class="title"  align="Left">   
					    <font color = "#C0C0C0" size="1pt"> <bean:message key="label.prev"/> </font>
					</td>
	 <%         }                                      
				if( cpage < totalPages ) 
				{ 
                       navigationparams.put("mv","next");
					   pageContext.setAttribute("paramsMap", navigationparams);

					
	%>                <td  width="5%"class="title"  align="Right">                                      
     				  <html:link page="/ListAllServices.do" name="paramsMap" scope="page" >
						  <font color = "white" size="1pt"> <bean:message key="label.next"/> </font>
					   </html:link>
					  </td>
	<%                         
		        } 
				else
				{
	%>            <td width="5%" class="title"  align="Right">
					  <font color = "#C0C0C0" size="1pt"> <bean:message key="label.next"/> </font>
				  </td>
	<%          }

	
				if( cpage < totalPages )
				{
		               navigationparams.put("mv","last");
					   pageContext.setAttribute("paramsMap", navigationparams);
	   %>					
	            <td  width="5%" class="title"  align="Right">                     
				  <html:link page="/ListAllServices.do" name="paramsMap" scope="page" >
				 <font color = "white" size="1pt"> <bean:message key="label.last"/> </font>
				 </html:link>
				</td> 
	<%       
		          }   
				else
				{
	 %>             <td  width="5%" class="title"  align="Right">   
					 <font color = "#C0C0C0"size="1pt"> <bean:message key="label.last"/> </font>
					 </td> 
	 <%         } 
	
	 %>
	 </tr> 
  </table>
  </html:form>

<!--  ***********************************************************************************************  -->
<!--  **********************************************************************************************  -->
<!--  * Loop all Services and show these                                                     *  -->
<!--  **********************************************************************************************  -->
<!--  **********************************************************************************************  -->

 <%

String sortDes = "<img src='images/down.gif' align='absmiddle'  border='0'/>";
String sortAsc = "<img src='images/up.gif' align='absmiddle'  border='0'/>";
 %>
 <table align="center" width="100%" border="0" cellpadding="2" cellspacing="1">
            <tr>
			<th class="left" width="1%"> </th>
            <th class="center"> 
		    <font color = "#C0C0C0">
			<a href="/crm/ListAllServices.do?customerid=<%= customerid %>&doResetReload=true&sort=<%=currentSort%>&mv=<%="viewpageno"%>&currentPageNo=<%=cpage%>&viewPageNo=<%=vPageNo%>&presName=<%=presNameSearch%>" style= color:white>
			<bean:message  key="label.Id"/>	&nbsp;<%=(currentSort.equalsIgnoreCase("desc")?sortDes:"")%><%=(currentSort.equalsIgnoreCase("asc")?sortAsc:"")%>
			 </a></font></th>
              <th class="left">&nbsp;&nbsp;<bean:message key="label.Name"/>&nbsp;</th>
              <th class="center"><bean:message key="label.State"/>&nbsp;</th>
              <th class="center"><bean:message key="label.Type"/>&nbsp;</th>
              <th class="center"><bean:message key="label.Submitdate"/>&nbsp;</th>
              <th class="left">&nbsp;&nbsp;<bean:message key="label.Action"/>&nbsp;</th>
              <th class="center"><bean:message key="label.Subservices"/>&nbsp;</th>
              <th class="center">&nbsp;</th>
            </tr>
<!--</table>-->
<%       
	        
			 
             if ((services == null)||(services.length == 0) )
	{ %>
	 
              <tr>
                <td class="list0" colspan=9 align="center">&nbsp;<br></td>
              </tr>
              <tr>
                <td class="list0" colspan=9 align="center"><h3>
				<bean:message key="msg.no.services.customer"/></h3></td>
              </tr>
              <tr>
                <td class="list0" colspan=9>&nbsp;</td>
              </tr>
      <!--</table>-->
		  
<%         
	} else {
              int end = services.length;
			  HashMap disableServiceParams = new HashMap();
              HashMap modifyServiceParams  = new HashMap();
			  HashMap deleteServiceParams  = new HashMap();
			  HashMap undomodifyParams   = new HashMap();
			  HashMap resendModifyParams = new HashMap();
			  HashMap resendCreateParams = new HashMap();

			 // System.out.println("JSP  end ==="+end);

              /**
			  *		 
			  ** Looping on all  services belonging to the specific customer.
			  **
			  **/
             ArrayList subservTypes = ListServiceForm.getSubServiceTypes();
			 ArrayList foreignCustNameList =(ArrayList)request.getAttribute("foreignCustNameList");		
			 ArrayList multipleMembershipslist = ListServiceForm.getMultipleMemberships();
			 ArrayList lastModifyActionList =(ArrayList)request.getAttribute("lastModifyActionList");
			 HashMap service_bean_map = (HashMap)request.getAttribute("service_bean_map");
			 Boolean actionsflagval=null;
            int[] sitecount=new int[services.length];
			 sitecount = ListServiceForm.getSitecount();

			 %>


			  <%
//PR 15068
		String curVPNId = null;
		String curVPNtype = null;
	      	curVPNId = (String)service_bean_map.get("_FirstVPNinPage");
	      	curVPNtype = (String)service_bean_map.get("_FirstVPNinPageType");

//PR15454
int cnt = 0;
HashMap<String, Object> mySites = new HashMap<String, Object>();

//		logger.debug("_FirstVPNinPage is "+curVPNId);
//		logger.debug("_FirstVPNinPage is "+curVPNtype);	
//		logger.debug("-----------Entry of FindAllServices.jsp----------");				
//	      	  for (int iii=0;iii<services.length;iii++){
//	      	  	logger.debug("Services["+iii+"]: id_"+services[iii].getServiceid()+" type_"+services[iii].getType()+" name_"+services[iii].getPresname());	
//	      	  }		
//PR 15068
             for (int i = 0; i<end; i++)		
	      {		  
	      	
				//System.out.println("JSP SERVICES LOOP == I=="+i );
				ServiceBean currentService= new ServiceBean( services[i]);

				// only for layer3 services overwrite with one which is in the service bean map
					
				 ServiceBean tmp=(ServiceBean)service_bean_map.get(currentService.getServiceid());
				 if(tmp != null){
					 currentService=tmp;
					 }
 
				HashSet multiSiteSet = new HashSet();
				int siteCount =  sitecount[i];
				boolean allowEnableVPN = false, allowDisableVPN = false;
			    ServiceType[] subServiceTypes = (ServiceType[])subservTypes.get(i);
			    /* debug
			    	if (subServiceTypes != null) {
					for (int zz=0; zz<subServiceTypes.length; zz++) {
						logger.debug("FindAllServices.jsp: service["+services[i].getServiceid()+"]'s subservTypes["+zz+"] is "+subServiceTypes[zz].getName());
					} 
				}else {
					logger.debug("FindAllServices.jsp: 1st service["+services[i].getServiceid()+"]'s subservTypes is null");					
				}
			    End of debug*/
			    
				ServiceParameter lastModifyAction = (ServiceParameter)lastModifyActionList.get(i);
                String serviceState = services[i].getState();			 
				String type = services[i].getType();
                String pServiceid = (String)pServiceIdList.get(i);

				String isParent = "N";
				 final String foreignCustomerId = services[i].getCustomerid().equals(customerid) ?
                            null : services[i].getCustomerid() ;
				 final String foreignCustomerName = (String)foreignCustNameList.get(i);
				
                   // Find all multi VPNSites
				                  
                  final Service[] multipleMemberships = (Service[])multipleMembershipslist.get(i);
                  
				  if(multipleMemberships != null)
				  {
                   
					for (int jj = 0; jj < multipleMemberships.length; jj++)
						{
                      multiSiteSet.add(multipleMemberships[jj].getServiceid());
                        }
                  }

		                  
                 final boolean isServiceDisabled = serviceState.indexOf(disabled) != -1 ||
                (serviceState.indexOf(disable) != -1 && serviceState.indexOf(failure)!=-1) ||
                (serviceState.indexOf(enable) != -1 && serviceState.indexOf(failure)!=-1);

                 String serviceRowStyle = isServiceDisabled ? "list1disabled" : "list1";
				   
			
				   if(((services[i].getParentserviceid()!=null) ||(siteCount == 0)) && 
					   !(type.equals("layer2-VPN")))
				     { 
					   //its a child rec

				       if(serviceRowStyle.equals("list1")) serviceRowStyle = "list0";
					    if(serviceRowStyle.equals("list1disabled")) serviceRowStyle = "list0disabled";
						isParent="N";

		             }
					   if(((services[i].getParentserviceid()==null) ||(siteCount == 0)) && 
				   (type.equals("layer3-VPN")||type.equals("GIS-VPN")))
				     { 
					   //its a l3 parent vpn without any site

				       if(serviceRowStyle.equals("list0")) serviceRowStyle = "list1";
					    if(serviceRowStyle.equals("list0disabled")) serviceRowStyle = "list1disabled";
                        isParent="Y";

		             }
					 if(((services[i].getParentserviceid()==null) && (siteCount == 0)) && 
					   ((type.equals("layer2-VPWS"))||(type.equals("layer2-VPN"))||(type.equals("Trunk"))))
				     { 
					   //its a parent vpn type other than l3vpn

				       if(serviceRowStyle.equals("list0")) serviceRowStyle = "list1";
					    if(serviceRowStyle.equals("list0disabled")) serviceRowStyle = "list1disabled";
						isParent="Y";

		             }
					
//PR 15068 The 3 type of L3VPN, L
				if((services[i].getParentserviceid()==null) && ((type.equals("layer3-VPN"))||(type.equals("layer2-VPWS"))||(type.equals("layer2-VPN"))||(type.equals("Trunk")) ||(type.equals("GIS-VPN")))) {
					isParent="Y";
					curVPNId = services[i].getServiceid();
					curVPNtype = services[i].getType();
					//PR 15068					 
                    
					
					//PR15454
					mySites.clear();
					cnt=0;
				}		
//End of PR 15068						
                
                  // if service has state that is allowed to be enabled
                  if(STATES_TO_ENABLE.contains(services[i].getState()))
                    // if service is member of only one VPN
                    if(!multiSiteSet.contains(services[i].getServiceid()))
						{
                      allowEnableVPN = true;
                   
                    }
             
                  // if service has state that is allowed to be disabled
                  if(STATES_TO_DISABLE.contains(services[i].getState()))
                    // if service is member of only one VPN
                    if(!multiSiteSet.contains(services[i].getServiceid()))
						{
                      allowDisableVPN = true;
                  
                    }

              
                // if VPN has some enabled and disabled sites then it is Partially Enabled or Partially Disabled
                if(allowEnableVPN && allowDisableVPN && (serviceState.equals(disabled) || serviceState.equals(ok) && (serviceState.indexOf(sched) == -1)||((serviceState.indexOf("End_Time_Failure") != -1))))
					{
                  if(isServiceDisabled)
                    serviceState = "Partialy_Disabled";
                  else
                    serviceState = "Partialy_Enabled";
                  
                   } //if

                				  
				   if(isParent.equals("Y"))
				   {

                      if(i>0)
						 {
 %>				                    
           <tr>
                <td class="list0" colspan=9 >&nbsp;</td>
              </tr>
  <%
				         }
				
                     undomodifyParams.put("serviceid",services[i].getServiceid());
                     undomodifyParams.put("customerid",customerid);
// Richa 11687
		 undomodifyParams.put("mv","viewpageno");
		 undomodifyParams.put("currentPageNo",String.valueOf(cpage));
		 undomodifyParams.put("viewPageNo",String.valueOf(vPageNo));

		 undomodifyParams.put("currentRs",String.valueOf(currentRs));
		 undomodifyParams.put("lastRs",String.valueOf(lastRs));
 		 undomodifyParams.put("totalPages",String.valueOf(totalPages));
 		 undomodifyParams.put("sort",strSort);
// Richa 11687
	
					 pageContext.setAttribute("undomodifyParamsMap", undomodifyParams);
 %>
              
                <tr class="<%=serviceRowStyle%>" align="center" align="middle">

				<td valign="middle"></td>

                  <td class="<%=serviceRowStyle%>" valign="middle">
                    <html:link	page="/ShowServiceParameters.do" name="undomodifyParamsMap" scope="page">
					<%= services[i].getServiceid() %>&nbsp; </html:link>
                  </td>

                  <td class="<%=serviceRowStyle%>"  valign="middle" align="left">
				   <%
                            if(foreignCustomerId != null || (multiSiteSet.contains(services[i].getServiceid())))
					       {

                    %>
                            <html:link page="/ShowServiceParameters.do" name="undomodifyParamsMap" scope="page">
							<%= Utils.escapeXml(services[i].getPresname()) %>
							</html:link> 
                    <%
                            }else{
                    %>
				        
						  <%= Utils.escapeXml(services[i].getPresname()) %>&nbsp;
			    	<%
                            }
                        
						  if(foreignCustomerName != null)
						{
							 HashMap foreignCustParams = new HashMap();
							 foreignCustParams.put("customerid",foreignCustomerId);
                             foreignCustParams.put("mv",pt);
				             foreignCustParams.put("doResetReload","true");
							 foreignCustParams.put("currentPageNo",String.valueOf(cpage));
							 foreignCustParams.put("viewPageNo",String.valueOf(vPageNo));
							 foreignCustParams.put("sort",strSort);
		                     pageContext.setAttribute("foreignCustParamsMap", foreignCustParams);
                     %>
                            (<html:link page="/ListAllServices.do" name="foreignCustParamsMap" scope="page"><%=Utils.escapeXml(foreignCustomerName)%></html:link>)
                     <%
                        }

                     %>

					</td>
	                  <td class="<%=serviceRowStyle%>"  valign="middle"> <%= Utils.escapeXml(_replace (serviceState)) %>&nbsp;</td>
		 <%
				 if(services[i].getType().equalsIgnoreCase("GIS-VPN")){
				 
				 %>
				 <td class="<%=serviceRowStyle%>"  valign="middle">GIS-Service&nbsp;</td>
				
				<%}else { %>
		
		<td class="<%=serviceRowStyle%>" valign="middle"><%=Utils.escapeXml(_replace (services[i].getType()))%>&nbsp;</td>
		<%} %>
		<td class="<%=serviceRowStyle%>" valign="middle"><%=Utils.escapeXml(services[i].getSubmitdate())%>&nbsp;</td>
		<%@ include file="ParentServiceActions.jsp"%>
		<!--              add subServices types (drop down with subservice types and submit button) -->
		<%--                  <td></td><b><%=services[i].getState()%></b></td>--%>
		<%
			if (isOperator && (serviceState.equals(ok)) && 
					//jacqie - PR 15345 BEGIN
					!"layer2-VPWS".equals(type))  //jacqie - PR 15345 END
	           { 
	                    HashMap createpageParams = new HashMap();
		                 
		               
	%>
                   
                    
              <input type="hidden" name="parentserviceid" value="<%= services[i].getServiceid() %>">
					 
                        <td class="<%=serviceRowStyle%>">

<%                         String subServicename = null;
							if (subServiceTypes == null) 
	                      {
//	                      	logger.debug("FindAllServices.jsp: 2nd service["+services[i].getServiceid()+"]'s subservTypes is null");
%>
                            <i><bean:message key="msg.no.subservices"/></i>
                            <td class="<%=serviceRowStyle%>">&nbsp;</td>
<%                        } else {
	%>
                            <select name="type<%=i%>" id="subserv<%=services[i].getServiceid()%>" onchange="storevalue(this);">
<%                            if (subServiceTypes != null) {
                                for (int jj=0; jj<subServiceTypes.length; jj++) { %>
                                  <option value="<%= Utils.escapeXml(subServiceTypes[jj].getName()) %>"
								  <%/**PR 15763 Begin*/ 
									subServicename = (String)session.getAttribute("subserv"+services[i].getServiceid());
									if(subServicename != null && subServicename.equals(Utils.escapeXml(subServiceTypes[jj].getName()))){%>selected<%}/**PR 15763 End*/  %>>
								  <%= Utils.escapeXml(_replace (subServiceTypes[jj].getName())) %>
								  </option>
<%                             //PR 15763 Removed 
									//subServicename = Utils.escapeXml(subServiceTypes[jj].getName());
//				logger.debug("FindAllServices.jsp: VPN service["+i+"]'s subservTypes["+jj+"] is "+subServiceTypes[jj].getName()+", subServicename is "+subServicename);
									}
                              }
						
                        
 %>
                            </select>
							  <input type="hidden" name="type" value="<%= type %>">
							<td class="<%=serviceRowStyle%>">
					<%
	                      if(subServicename == null) {
	                         if(subServiceTypes != null && subServiceTypes.length > 0)
	                            subServicename = Utils.escapeXml(subServiceTypes[0].getName());
							 else
								 subServicename = type;}
						 createpageParams.put("customerid",customerid);
            			 createpageParams.put("parentserviceid",services[i].getServiceid()); 
                         createpageParams.put("type",subServicename);
						 createpageParams.put("mv","viewpageno");
						  createpageParams.put("currentPageNo",String.valueOf(cpage));
						  createpageParams.put("viewPageNo",String.valueOf(cpage));
						  createpageParams.put("sort",strSort);
			             pageContext.setAttribute("createpageParamsMap", createpageParams);
                   %>
							
<%                if(!(currentService.getType()).equals("layer2-VPWS")) { 
%>					  					  
			        <html:link  page="/CreateService.do" name="createpageParamsMap" scope="page" onclick=" parent.reload.setServiceOperation('true');">
			        <html:img page="/images/arrow_submit.gif" onclick="this.style.visibility='hidden'" border="0" title="Submit"/> <!--Richa added to hide submit button; 11978 -->
			        </html:link>
<%                }
%>
                            </td>
<%                        } %>
                        </td>
                  
<%                } else { %>
                   <td class="<%=serviceRowStyle%>">&nbsp;</td>
                   <td class="<%=serviceRowStyle%>">&nbsp;</td>
<%                } 
							  
							  
		  }
		    //when its NOT A subservice	AND ONLY a PARENTSERVICE			  
 %>
               </tr>



<%             //when its a SUBSERVICE               
			   if(isParent.equals("N"))
				   {
					//key for fiding the state for a service is treestate+serviceid , for example "treestate1056"
					 //PR 15068, for site maybe belong to multiple VPN, and also l3 site has join feature, we use siteID+firstSiteAttachtmentID to identify.
					 //String treeStateKey="treestate"+currentService.getServiceid();
					 
					 StringBuffer exp_VPNSite = new StringBuffer(curVPNId+"_"+currentService.getServiceid());					 
					 String vpnSiteKey = exp_VPNSite.toString() + "_" + cnt;
					 
					 //System.out.println(service_bean_map);
					 if(mySites.containsKey(vpnSiteKey)){
   						cnt++;
                        vpnSiteKey = exp_VPNSite.toString() + "_" + cnt;
					 }
                      //System.out.println(vpnSiteKey + "---" + i);

					  ServiceBean exp_siteService = (ServiceBean)service_bean_map.get(vpnSiteKey);
					  //System.out.println( "~~~~~~~~~~~~~~" + exp_siteService);
					  mySites.put(vpnSiteKey, null);
                     
					 String treeStateKey = null;
					 if (null!=exp_siteService) {
					 	ServiceBean[] exp_attachments=exp_siteService.getChildServicesArray();
					 	if (null!=exp_attachments) {
					 		treeStateKey="treestate_"+currentService.getServiceid()+"_"+exp_attachments[0].getServiceid();
					 		selected_att = exp_attachments[0].getServiceid();
					 	}
					 }
					 String treeState=(String)treeStatesOfServices.get(treeStateKey);
					  //if null set to the default state
					  if(treeState==null)
						treeState="expanded";
					 //logger.debug("FindAllServices.jsp: treeStateKey is "+treeStateKey+", treeState is "+treeState);

                     boolean isSubDisabled = serviceState.indexOf(disabled) != -1 ||
                            (serviceState.indexOf(disable) != -1 && serviceState.indexOf(failure)!=-1) ||
                              (serviceState.indexOf(enable) != -1 && serviceState.indexOf(failure)!=-1);
                      final String rowStyle = isSubDisabled ? "list0disabled" : "list0";
					
					
%>
                   
					<%
                     undomodifyParams.put("serviceid",services[i].getServiceid());
                     undomodifyParams.put("customerid",customerid);
// Richa 11687
		 undomodifyParams.put("mv","viewpageno");
		 undomodifyParams.put("currentPageNo",String.valueOf(cpage));
		 undomodifyParams.put("viewPageNo",String.valueOf(vPageNo));

		 undomodifyParams.put("currentRs",String.valueOf(currentRs));
		 undomodifyParams.put("lastRs",String.valueOf(lastRs));
 		 undomodifyParams.put("totalPages",String.valueOf(totalPages));
 		 undomodifyParams.put("sort",strSort);
// Richa 11687
					 pageContext.setAttribute("undomodifyParamsMap", undomodifyParams);
				  %>
					
					<tr align="center" align="middle">

					<% 

					//if(foreignCustomerName != null || (!((currentService.getType()).equals("Site") && curVPNtype.equals("layer3-VPN")) && //!((currentService.getType()).equals("Site") && curVPNtype.equals("layer2-VPN"))))
	//jacqie - PR 15324
	if(foreignCustomerName != null || 
		(
			!(
				(currentService.getType()).equals("Site") && curVPNtype.equals("layer3-VPN")
			) 
			&&
			!(
				(currentService.getType()).equals("Site") && curVPNtype.equals("GIS-VPN")
			) 			
			&& 
			!(
				(currentService.getType()).equals("Site") && curVPNtype.equals("layer2-VPN")
			)&&
			!(
				(currentService.getType()).equals("Site") && curVPNtype.equals("layer2-VPWS")
			)
		)
	)
//jacqie - PR 15324
							{
					%>

 <td class="<%=rowStyle%>" valign="middle"></td>
					  <%
                          }
                            else{
                        %>
				 
				<td class="<%=rowStyle%>" valign="middle">

				<a href="/crm/ListAllServices.do?sort=<%=strSort%>&customerid=<%= customerid %>&doResetReload=true&mv=<%="viewpageno"%>&currentPageNo=<%=cpage%>&viewPageNo=<%=vPageNo%>&presName=<%=presNameSearch%>&selected_serviceid=<%=currentService.getServiceid()%>&selected_att=<%=selected_att%>"><img src="/crm/images/<%=treeState%>.gif" border="0" ></a>

					</td>

				
				  <%
                            }
                        %>




                      <td class="<%=rowStyle%>" valign="middle">

			
                    <html:link page="/ShowServiceParameters.do" name="undomodifyParamsMap" scope="page">   
						<%= services[i].getServiceid() %>&nbsp; </html:link>
                      </td>

                      <td class="<%=rowStyle%>"  valign="middle" align="left">
                       <%
                            if(foreignCustomerId != null || (multiSiteSet.contains(services[i].getServiceid())))
					       {

                        %>
                            <html:link page="/ShowServiceParameters.do" name="undomodifyParamsMap" scope="page">
							<%= Utils.escapeXml(services[i].getPresname()) %> </html:link>
                        <%
                            }else{
                        %>
				  <%= Utils.escapeXml(services[i].getPresname()) %>&nbsp;
				  <%
                            }
                        %>

                        <% if(foreignCustomerName != null)
							{
                             HashMap foreignCustParams = new HashMap();
							 foreignCustParams.put("customerid",foreignCustomerId);
                             foreignCustParams.put("mv",pt);
				             foreignCustParams.put("doResetReload","true");
							 foreignCustParams.put("currentPageNo",String.valueOf(cpage));
							 foreignCustParams.put("viewPageNo",String.valueOf(vPageNo));
							 foreignCustParams.put("sort",strSort);
		                     pageContext.setAttribute("foreignCustParamsMap", foreignCustParams);
                        %>
                            (<html:link page="/ListAllServices.do" name="foreignCustParamsMap" scope="page"><%=Utils.escapeXml(foreignCustomerName)%></html:link>)
                        <%
                        }

                  %>

					</td>
					<%
						HashMap worst_state_map = (HashMap)request.getAttribute("worst_state_map");
						String worst_pe_state = "";
						if(worst_state_map!=null && worst_state_map.containsKey(services[i].getServiceid())){
							worst_pe_state = "(" + worst_state_map.get(services[i].getServiceid()) + ")";
						}

						%>
                      <td class="<%=rowStyle%>"  valign="middle"><%= _replace (serviceState) %>&nbsp;
					  <%//PR15502 - Jacqie
						  if(!treeState.equals("expanded")){
							  
							  %><%=_replace(worst_pe_state)%><%}%></td>
                      <td class="<%=rowStyle%>"  valign="middle"><%= _replace (services[i].getType()) %>&nbsp;</td>
                      <td class="<%=rowStyle%>"  valign="middle"><%= services[i].getSubmitdate() %>&nbsp;</td>
	  
<%                  if(!(currentService.getType()).equals("vpws-Site")){ %>					  					  
					  <%@ include file="ChildServiceActions.jsp" %>
<%                  } else {
%>
                      <td class="<%=rowStyle%>"  valign="middle"></td>
<%                  }
%>
					   
					 <%@ include file="SubServices.jsp" %>




                  </tr>

				
					<%@ include file="SiteAttachments.jsp" %>


<%	
	
	} //if of subservices
			 
			  
      	    
        } // for
	
	%>

<!--        End of service tableCell -->
         
          </table>
    
		  
<%      } // if parent services not null

%>
   
<%
      } // if customer is not null
      else 
	{ %>
        <tr>
          <td class="list0" align="center" colspan=8><h3><bean:message key="label.cust.not.found"/></h3></td>
        </tr>
        <tr>
          <td class="list1" colspan=8>&nbsp;</td>
        </tr>
    </table>
<%
     }
	 
  } catch (Exception e) {e.printStackTrace();
     logger.error("ERROR Occured", e);
  %>
      <center>
        <h2>Error</h2>
        <b>Error retrieving service information:</b>
         <html:link href="javascript:window.history.back();">
		  <html:img page="/images/back.gif" border="0" align="left" title="Return"/>
	     </html:link>

      </center>
	  
<%  } 
%>
         
		  
      </center>
    </font>
	    <script>
	    	function trim(str){      		
      		return str.replace(/^\s*(.*?)[\s\n]*$/g, '$1'); 
      		}    	
	    	
     function callviewByPageNo()
	{
		
	    var error = false;
		var customerid='<%=customerid%>';
		var currentPageNo='<%=cpage%>';	
		var totalNoOfPages='<%=totalPages%>';	
		var sort = '<%=strSort%>'
		document.forms[0].customerid.value = customerid;
		document.forms[0].currentPageNo.value = currentPageNo;

		var viewPageNo = trim(document.forms[0].txtviewPageNo.value);
		
		if(viewPageNo==null||viewPageNo=="")
		{
			alert(' <bean:message key="js.enter.number" /> ');
			error = true;
		}
		else
		{
		     if( parseInt(parseFloat(viewPageNo)) > parseInt(parseFloat(totalNoOfPages)))
		    {
			alert('<bean:message key="js.enter.number.hint" />'+viewPageNo+' <bean:message key="js.greater.number" />'+totalNoOfPages);
			error = true;
		     }
		    if(parseInt(parseFloat(viewPageNo))<=0)
		     {
			alert('<bean:message key="js.enter.number.hint" />'+viewPageNo+' <bean:message key="js.unavailable.number" />');
			error = true;
		     }
		}

		if(error==true)
		{
		
	      document.forms[0].txtviewPageNo.select();
         document.forms[0].txtviewPageNo.focus();
	   }
        else
		{
		 document.forms[0].txtviewPageNo.value = viewPageNo;
		var pns = '<%=presNameSearch%>';
		var page = "/crm/ListAllServices.do?mv=viewpageno&doResetReload=true&customerid="+customerid+"&currentPageNo="+currentPageNo+"&viewPageNo="+viewPageNo+"&sort="+sort+"&presName="+pns;
        self.location.href = page;
		}
	}
     
     function callviewBySiteName()
     {
    	 
    	 var error = false;
 		var customerid='<%=customerid%>';
 		var currentPageNo='<%=cpage%>';	
 		var totalNoOfPages='<%=totalPages%>';	
 		var sort = '<%=strSort%>'
 		document.forms[0].customerid.value = customerid;
 		document.forms[0].currentPageNo.value = currentPageNo;
    	 
    	 var viewPageSiteName = trim(document.forms[0].txtviewSearch.value);
       document.forms[0].txtviewSearch.value = viewPageSiteName;

      //var page = "/crm/ListAllServices.do?mv=&doResetReload=true&customerid="+customerid+"&presName="+pageSiteSearch__+"&actionflag=editfromlist";
 		var page = "/crm/ListAllServices.do?mv=&doResetReload=true&customerid="+customerid+"&presName="+viewPageSiteName+"&actionflag=editfromlist";
        
 		
 		self.location.href = page;
 		
    	 
    	 
     }

//PR 15763 Begin
	function storevalue(serviceList) {

		var selValue = serviceList.options[serviceList.selectedIndex].value;
		var selId = serviceList.id;
		//alert(selValue);
		//alert(selId);
       
	   var customerid='<%=customerid%>';
		var currentPageNo='<%=cpage%>';	
		var totalNoOfPages='<%=totalPages%>';	
		var sort = '<%=strSort%>'
		var pns = '<%=presNameSearch%>';
		var page = "/crm/ListAllServices.do?mv=viewpageno&doResetReload=true&customerid="+customerid+"&currentPageNo="+currentPageNo+"&viewPageNo="+document.forms[0].txtviewPageNo.value+"&sort="+sort+"&selValue="+selValue+"&selId="+selId+"&presName="+pns;
		//alert(page);
        self.location.href = page;

      
	}
//PR 15763 End
   </script>

  </body>
  <HEAD>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" CONTENT="-1">
</HEAD>
</html:html>
