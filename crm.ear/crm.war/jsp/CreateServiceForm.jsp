<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%-- -*- html -*- --%>

<%-- ************************************************************** --%>
<%--                                                                --%>
<%-- CreateServiceForm.jsp                                          --%>
<%--                                                                --%>
<%-- Parameters:                                                    --%>
<%--  - None -                                                      --%>
<%--                                                                --%>
<%-- Description:                                                   --%>
<%--  It collects the information to store a new service            --%>
<%--  This information is sent to CommitServiceForm.jsp             --%>
<%--                                                                --%>
<%-- ************************************************************** --%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>


<%@page info="Create a service"
        contentType="text/html; charset=UTF-8"
        import="com.hp.ov.activator.crmportal.bean.*,com.hp.ov.activator.crmportal.action.*, java.util.HashMap,java.io.*,
		java.text.*, java.net.*,java.util.HashSet, com.hp.ov.activator.crmportal.utils.*,com.hp.ov.activator.crmportal.helpers.*,
		com.hp.ov.activator.crmportal.common.*, org.apache.log4j.Logger, com.hp.ov.activator.vpn.inventory.*,
		com.hp.ov.activator.inventory.SAVPN.*, javax.sql.DataSource, java.sql.Connection"
 %>

<%
  response.setDateHeader("Expires",0);
  response.setHeader("Pragma","no-cache");
  //load param parameters got here
   ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
   HashMap serviceParameters = new HashMap ();
   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
   HashMap parentServiceParameters = new HashMap ();
   parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");
   String serviceid = serviceForm.getServiceid();
   String parentserviceid = serviceForm.getParentserviceid();
   String serviceType = serviceForm.getType();
   String messageid   = serviceForm.getMessageid();
   Logger logger = Logger.getLogger("CRMPortalLOG");
   String servicemv  = (String)request.getAttribute("mv");
   String currPageNo = (String)request.getAttribute("currentPageNo");
   String viewPgNo   = (String)request.getAttribute("viewPageNo");
   if(currPageNo == null || "null".equals(currPageNo))
	   currPageNo="1";
	if(viewPgNo == null || "null".equals(viewPgNo))
	   viewPgNo="1";
   String strMessage = (String)request.getAttribute("Message");
   SimpleDateFormat df = (SimpleDateFormat)DateFormat.getDateInstance(DateFormat.SHORT);
   SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);
  
	String searchSite = (String)request.getAttribute("searchSite");	
	request.setAttribute("searchSite", searchSite);
	String siteidSearch = (String)request.getAttribute("siteidSearch");	
	request.setAttribute("siteidSearch", siteidSearch);
	String action_create="/CommitAddService";
		if(searchSite!=null && !searchSite.equals("") && !searchSite.equals("null")){
			action_create="/CommitAddServiceSearch";
		}	

System.out.println("Inside the CreateSErviceForm ::");
	
%>

<html:html locale="true">
  <head>
    <link rel="stylesheet" type="text/css" href="css/activator.css">
    <link rel="stylesheet" type="text/css" href="css/awfweb2.css">
    <META Http-Equiv="Cache-Control" Content="no-cache">
    <META Http-Equiv="Pragma" Content="no-cache">
    <META Http-Equiv="Expires" Content="0">
<script type="text/javascript">
function ismaxlength(obj){
var mlength=obj.getAttribute? parseInt(obj.getAttribute("maxlength")) : ""
if (obj.getAttribute && obj.value.length>mlength){
obj.value=obj.value.substring(0,mlength)
alert('<bean:message key="js.maxlength.comment" />');
}
}

</script>

<% if(serviceType.compareTo("layer2-VPN") != 0 && serviceType.compareTo("layer3-VPN") != 0)
	{
%>
<!-- calendar stylesheet -->
  <link rel="stylesheet" type="text/css" href="css/calendar-win2k-1.css" title="win2k-cold-1" />

  <!-- main calendar program -->
  <script type="text/javascript" src="javascript/calendar.js"></script>

  <!-- language for the calendar -->
  <script type="text/javascript" src="javascript/calendar-en.js"></script>

  <!-- the following script defines the Calendar.setup helper function, which makes
       adding a calendar a matter of 1 or 2 lines of code. -->
  <script type="text/javascript" src="javascript/calendar-setup.js"></script>
  <%
  }
     com.hp.ov.activator.crmportal.bean.Customer customer = serviceForm.getCustomer();

     HashSet roles = (HashSet) session.getAttribute(Constants.ROLES_KEY);
	 boolean isOperator = false;
      if(roles.contains(Constants.ROLE_OPERATOR)) {isOperator = true;}
 
     if(isOperator == false)
     throw new IllegalStateException("Wrong role to perform the operation");

	   String message = (String)request.getAttribute("errormessage");
    if (customer == null || (message != null && strMessage ==null)) 
		{
			
   %>
		<%= message%>
       <!-- <bean:message key="error.no.customer" /> -->
   <%
        } 
     else 
	   {	 
      String customerid  = customer.getCustomerid();
      String company     = customer.getCompanyname();
      String contactPersonName      = customer.getContactpersonname();
      String contactPersonSurName   = customer.getContactpersonsurname();
      String contactPersonphonenumber = customer.getContactpersonphonenumber();
	  String customerEmail = customer.getContactpersonemail();
      String date_string = Constants.DEFAULT_DATE_FORMAT.format(new java.util.Date()); 
	  int rowCounter = 0;

  %>


<%
	String action = "";
	if ("Trunk".equals(serviceType)) {
		action = "/CreateService";
		String reqtype = (String) request.getAttribute("reqtype");
	  	if (reqtype == null || "deleteTrunk".equals(reqtype) || "createTrunk".equals(reqtype)) {
	  		// Clean IGW session
	  	   	session.setAttribute("sub_interface_list", null);
%>
		<body bgcolor="white" onmousemove="parent.reload.setYPos();" onUnLoad="tmp=parent.reload.bDoUpdate; parent.reload.stopReload('true'); parent.reload.bDoUpdate=tmp; window.status = '';" onLoad="parent.reload.doScroll(),callValidate(),initCombo();init('<%=customerid%>','<%= currPageNo %>','<%=viewPgNo%>','<%=servicemv%>');" onResize="initCombo();">
			<table width="100%" border="0">
		      <tr>
		        
				<td class="white">	  
				  <html:img page="/images/Services.gif" border="0" align="left" title="Services"/>     
				</td>
				<td class="white">
					<h2 class="mainSubHeading"><center><bean:message key="title.create.service" /></center></h2>
				</td>
		        <td class="white">
					<a href="javascript:switchAutoRefresh();"><img id="refreshIcon" src="images/autoRefreshOn.gif" border="0" align="right" title="Auto-refresh is on"></a>
					<a href="/crm/CreateService.do?customerid=<%= customerid %>&type=Trunk&currentPageNo=<%= currPageNo %>&viewPageNo=<%= viewPgNo %>&mv=<%=servicemv%>" target="main"><img src="images/refresh.gif" border="0" align="right" title="Refresh"></a>
				</td>
		      </tr>
		  	</table>
<%
		} else {
%>
		<body bgcolor="white" onmousemove="parent.reload.setYPos();" onLoad="parent.reload.doScroll(),callValidate(),initCombo();" onResize="initCombo();">
			<td class="white">
				<h2 class="mainSubHeading"><center><bean:message key="title.create.service" /></center></h2>
			</td>
<%
		}
	} else {
	 	action = "/CommitAddService";
%>
	<body bgcolor="white" onmousemove="parent.reload.setYPos();" onLoad="parent.reload.doScroll(),callValidate(),initCombo();" onResize="initCombo();">
		<h2 class="mainSubHeading"><center><bean:message key="title.create.service" /> </center></h2>
<%
	}
%>
	   <html:form  action="<%=action_create%>">

        
        <table border="0" width="100%" cellpadding="2" cellspacing="1">
        <tr>
          <td class="title" colspan="6" align="left"><%= serviceType %> for customer</td>
        </tr>

        <tr>
          <th class="center"><bean:message key="label.customer.id" /></th>
          <th class="center"><bean:message key="label.company.name" /></th>
          <th class="center"><bean:message key="label.contact.person" /></th>
          <th class="center"><bean:message key="label.phone.number" /></th>
          <th class="center"><bean:message key="label.email" /></th>
          <th class="center"><bean:message key="label.Services" /></th>
        </tr>

        <tr>
          <td class="list<%= (rowCounter % 2) %>" align="center">
		  <a href="/crm/UpdateCustomerSubmit.do?customerid=<%= customerid %>"><%= customerid %></a></td>
          <td class="list<%= (rowCounter % 2) %>" align="center">
		  <%= customer.getCompanyname() == null ? "&nbsp;" : Utils.escapeXml(customer.getCompanyname())%></td>
          <td class="list<%= (rowCounter % 2) %>" align="center">
		  <%= customer.getContactpersonname() == null ? "&nbsp;" : Utils.escapeXml(customer.getContactpersonname()) %>
		  <%= customer.getContactpersonsurname() == null ? "&nbsp;" : Utils.escapeXml(customer.getContactpersonsurname()) %>
		  </td>
          <td class="list<%= (rowCounter % 2) %>" align="center">
		  <%= customer.getContactpersonphonenumber() == null ? "&nbsp;" : Utils.escapeXml(customer.getContactpersonphonenumber()) %>
		  </td>
          <td class="list<%= (rowCounter % 2) %>" align="center">
		  <%= customer.getContactpersonemail() == null ? "&nbsp;" : Utils.escapeXml(customer.getContactpersonemail()) %>
		  </td>
		    <% 
			    String strMV = null;
            	 HashMap  params = new HashMap();
                 params.put("customerid",customerid);
                 params.put("mv",strMV);
				 params.put("doResetReload","true");
		         pageContext.setAttribute("paramsMap", params);


			%>
          <td class="list<%= (rowCounter % 2) %>" align="center" >&nbsp;&nbsp;
                <html:link page="/ListAllServices.do" name="paramsMap" scope="page" >
	            <html:img page="/images/Services.gif" border="0" title="Show service" align="center"/>
	           </html:link>
          </td>
        </tr>
        <tr>
          <td class="list<%= (rowCounter % 2) %>" colspan=6 align="center">&nbsp;</td>
        </tr>

      </table>

      <% rowCounter++; %>
	  <br>
	  <center>
<%
	if (!"Trunk".equals(serviceType)) {
%>
      <table border=0 width=80% cellpadding=2 cellspacing=1>

          <tr>
            <td class="title" align="left" colspan=4><bean:message key="title.service.info" /></td>
			 <html:hidden  property="customerid" name="customerid" value="<%= serviceForm.getCustomerid() %>"/>
			  <html:hidden  property="type" name="type" value="<%= serviceForm.getType() %>"/>
		
		      <html:hidden  property="mv" name="mv" value="<%= servicemv %>"/>
  	          <html:hidden  property="currentPageNo" name="currentPageNo" value="<%= currPageNo %>"/>
  	          <html:hidden  property="viewPageNo" name="viewPageNo" value="<%= viewPgNo %>"/>
			  <input type=hidden name="searchSite" value="<%=searchSite%>">
		   <input type=hidden name="siteidSearch" value="<%=siteidSearch%>">
				<input type=hidden name="actionType" value="CommitAddService">
        
          </tr>

<%      if (parentserviceid != null && !parentserviceid.trim().equals (""))
	    {
               String parentServiceType = (String) parentServiceParameters.get ("type");
                String parentServiceName = (String) parentServiceParameters.get ("presname");
%>
            <tr valign="center" height = "30">
              <html:hidden  property="parentserviceid" name="parentserviceid" value="<%= parentserviceid %>"/>
              <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
              <td class="list<%= (rowCounter % 2) %>" align="left" width="40%">
			  
<%//if(serviceType.equals("layer3-Attachment")) {%>
			<logic:equal name="ServiceForm" property="type" value="layer3-Attachment">
				<b><bean:message key="label.siteid" /></b></td>
			 </logic:equal>    
		  
		<!--	<logic:notEqual name="ServiceForm" property="type" value="layer3-Attachment">
				<b><bean:message key="label.vpnid" /></b></td>
			</logic:notEqual>    -->
	<%//}%>		
			<logic:equal name="ServiceForm" property="type" value="layer2-Attachment">
				<b><bean:message key="label.siteid" /></b></td>
			 </logic:equal>    
		  
			<!--<logic:notEqual name="ServiceForm" property="type" value="layer2-Attachment">-->
				
				<%if(!serviceType.equals("layer3-Attachment") && !serviceType.equals("layer2-Attachment")&& !serviceType.equals("GIS-Attachment")) {%>
				<b><bean:message key="label.vpnid" /></b></td>
				<%}%>
			<!--</logic:notEqual> -->  
			
			  
			  <td class="list<%= (rowCounter % 2) %>">
			  <a href="/crm/ShowServiceParameters.do?serviceid=<%= parentserviceid %>">
			  <%=parentServiceName%> (<%= parentserviceid %>)</a>
			  </td>
              <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>			  
            </tr>
            <% rowCounter++;  %>
<%       
	  } //end of if parentserviceid  not null


%>
          <tr valign="center" height = "30">
            <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
            <td class="list<%= (rowCounter % 2) %>" align="left" width="40%"><b><%= serviceType %> id</b></td>
			
            <td class="list<%= (rowCounter % 2) %>" align="left">
			 <!--html:hidden  property="serviceid" name="serviceid" value="<%= serviceid %>"/-->
			 <input type="hidden" name="serviceid" id="serviceid" maxlength="32" size="32" value="<%= serviceid %>"><div id="TD_serviceId"><%= serviceid %></div></td>
			 
			 <html:hidden  property="messageid" name="messageid" value="<%= messageid %>"/>
            <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>          
		  </tr>
		  
          <% rowCounter++;%>

<%
	} else {
%>
		<input type="hidden" id="customerid" name="customerid" value="<%=customerid %>">
		<input type="hidden" id="type" name="type" value="Trunk">
		<table border=0 width=100% cellpadding=2 cellspacing=1>
<%
	}
          String tempserviceid = serviceid == null ? "" : serviceid;
          String tempparentserviceid = parentserviceid == null ? "" : parentserviceid;
          String serviceFormFileName = "../forms/" + serviceType + ".jsp";

		   if(serviceType.equals("layer3-Site") || serviceType.equals("layer3-Protection"))	{
	    serviceFormFileName = "../forms/" + "layer3-Attachment" + ".jsp";
	   }
	   
		   //Added for GIS - by Anu
		  if(serviceType.equals("GIS-Site") || serviceType.equals("GIS-Protection"))	{
	    serviceFormFileName = "../forms/" + "GIS-Attachment" + ".jsp";
	   }

	   		   if(serviceType.equals("layer2-Site"))	{
	    serviceFormFileName = "../forms/" + "layer2-Attachment" + ".jsp";
	   }
		  logger.debug("___________________________&&&&&&&&&&&&&&&&&&&&&&&&");
		  logger.debug("serviceFormFileName ===="+serviceFormFileName);
		  logger.debug("messageid >>>>>>>>>>>>>>"+messageid);
          logger.debug("___________________________&&&&&&&&&&&&&&&&&&&&&&&&");
%>




          <jsp:include page="<%= serviceFormFileName %>" flush="true">
            <jsp:param name="serviceid" value="<%= tempserviceid %>" />
            <jsp:param name="parentserviceid" value="<%= tempparentserviceid %>" />
            <jsp:param name="type" value="<%= serviceType %>" />
            <jsp:param name="customerid" value="<%= customerid %>" />
			<jsp:param name="mv" value="<%= servicemv %>" />
			<jsp:param name="currentPageNo" value="<%= currPageNo %>" />
            <jsp:param name="viewPageNo" value="<%= viewPgNo %>" />
			<jsp:param name="messageid" value="<%= messageid %>" />
            <jsp:param name="rowCounter" value="<%= rowCounter %>" />
          </jsp:include>
	
<% 
     //code for Trunk added in condition   05/04/2017
if(serviceType.compareTo("layer2-Site") == 0 || serviceType.compareTo("layer2-VPWS") == 0 || serviceType.compareTo("layer3-Site") == 0 || serviceType.compareTo("Trunk") == 0)
{

	// Aggregated LSPs ER
	Connection con = null;
	DataSourceLocator dsl = new DataSourceLocator(); 
	boolean showLSPOptions = false;
	boolean showLSPService = false;
	boolean showLSPAggregated = false;
	
	try
	{
		DataSource ds = dsl.getDataSource();
		if (ds != null)
		{
			con = ds.getConnection();
			
			com.hp.ov.activator.vpn.inventory.ISP[] ispData = com.hp.ov.activator.vpn.inventory.ISP.findAll(con);
			
			String idName = ispData[0].getIdname();
		
			com.hp.ov.activator.vpn.inventory.LSPParameters lspParam = com.hp.ov.activator.vpn.inventory.LSPParameters.findByIdname(con,idName);
			
			if (lspParam.getLspenabled())
			{
				showLSPOptions = true;
				showLSPService = true;
				
				if (lspParam.getAggregatelspenabled())
				{
					showLSPAggregated = true;
				}
			}			
		}             
	}
	catch(Exception e)
	{
		System.out.println("Exception getting LSP Parameters: "+e);
	}
	finally
	{
		if (con != null)
		{
			try 
			{
				con.close();
			}
			catch (Exception rollbackex)
			{
				// Ignore
			}
		}
	}

	
	if (showLSPOptions) {
%>  
	    <tr>
			<td class="title" colspan="4" align="left"><bean:message key="label.lspoptions.title" /></td>
		</tr>
		
		<tr>
			<td class="list1">&nbsp;</td>
			<td class="list1"><bean:message key="label.lspoptions.message" /></td>
			<td class="list1">
				<% if (showLSPService) 
					{
					if (showLSPAggregated)
					{ %>
				<input type="radio" name="lspoptions" value="Service"><bean:message key="label.lspoptions.service" /></input>
				<% } else {%> 
				<input type="radio" name="lspoptions" value="Service" checked="checked"><bean:message key="label.lspoptions.service" /></input>
				<%}} else { %>
				<input type="radio" name="lspoptions" value="Service" disabled><bean:message key="label.lspoptions.service" /></input>
				<% } %>
				
				<% if (showLSPAggregated) { %>
				<input type="radio" name="lspoptions" value="Aggregated" checked="checked"><bean:message key="label.lspoptions.aggregated" /></input>
				<% } else { %>
				<input type="radio" name="lspoptions" value="Aggregated" disabled><bean:message key="label.lspoptions.aggregated" /></input>
				<% } %>
			</td>
			<td class="list1">&nbsp;</td>
		</tr>
<% 	}
	else
	{%>
			<!-- By default LSP Usage Mode will be Service -->
			<html:hidden property="lspoptions" name="lspoptions" value="Service"/>
	<%}
}
	// Aggregated LSPs ER 
%>

<%  
if(!serviceType.equalsIgnoreCase("Trunk"))
	{
if(serviceType.compareTo("layer2-VPN") != 0 && serviceType.compareTo("layer3-VPN") != 0 && serviceType.compareTo("GIS-VPN") != 0)
{
	    rowCounter++;
%>
  	<tr>
	      <td class="title" colspan="4" align="left"><bean:message key="label.sched.info" /></td>
	</tr>
          <% rowCounter++; %>

<%        String start = (String) serviceParameters.get ("StartTime");
          if (start == null) {
            start = request.getParameter ("SP_StartTime"); //to be changed
            if (start == null) {
              start = "";
                              }
                          }
 %>
             <tr height="30">
    		<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    		<td align="left" class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.start.time" /></b></td>
    		<td align="left" class="list<%= (rowCounter % 2) %>">
      		<input name="SP_StartTime" id="starttime" value="<%= start == null ? "" : start %>" title="yyyy.MM.dd HH:mm:ss NOW: Leave the field empty" readOnly> 
			<img src="images/date_select.gif" id="buttonStartDate" />&nbsp;&nbsp;
    		<font face="Verdana"><small><B><a href="#" onclick= "clearCalendar('starttime','SP_StartTime');"> <bean:message key="calendar.reset.field"/> </a></B></small>
			</font></td>
    		<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
  		</tr>
  		<% rowCounter++; %>

   <%        String end = (String) serviceParameters.get ("EndTime");
          if (end == null) {
            end = request.getParameter ("SP_EndTime");  //to be changed
            if (end == null) {
              end = "";
                         }
                      } 
 %>

		<tr height="30">
    		<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    		<td align="left" class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.end.time" /></b></td>
    		<td align="left" class="list<%= (rowCounter % 2) %>">
      		<input name="SP_EndTime" id="endtime" value="<%= end == null ? "" : end %>" title="yyyy.MM.dd HH:mm:ss IGNORE: Leave the field empty" readOnly>
    		<img src="images/date_select.gif" id="buttonEndDate"/>&nbsp;&nbsp;
			<font face="Verdana"><small><B><a href="#" onclick= "clearCalendar('endtime','SP_EndTime');" style=Color:blue > <bean:message key="calendar.reset.field"/> </a>
			</td></B></small></font>
    		<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
  		</tr>
  		<% rowCounter++; %>
  
<%
	} //end of service type
%>
		
		<tr>
	      <td class="title" colspan="4" align="left"><bean:message key="label.comments" /></td>
	    </tr>
          <% rowCounter++; %>

<%        String comment = (String) serviceParameters.get ("Comment");
          if (comment == null) {
            comment = request.getParameter ("SP_Comment");  //to be changed
            if (comment == null) {
              comment = "";
                            }
                      } 
		%>

          <tr>
            <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
            <td colspan="2" class="list<%= (rowCounter % 2) %>" align="center">
			<textarea name="SP_Comment" cols="55%" rows="6"  maxlength="200" onkeyup="return ismaxlength(this);" ><%= comment == null ? "" : comment %></textarea></td>
            <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
          </tr>
          <% rowCounter++; %>

          <tr>
            <td class="list<%= (rowCounter % 2) %>" colspan="4">&nbsp;</td>
          </tr>
          <% rowCounter++; } %>
          
          <% if(!serviceType.equalsIgnoreCase("Trunk"))
			{%>
          <tr>          
            <td align="right" class="list<%= (rowCounter % 2) %>" colspan="4">
         
		     <html:link href="javascript:checkAll();">
	          <html:img imageName="submitObject" onclick="this.style.visibility='hidden'" page="/images/arrow_submit.gif" border="0" align="right"/>
	         </html:link>
           </td>
          </tr>
          <% }%>
          
        </table>
</center>
         <html:hidden  property="type" name="type" value="<%= serviceType %>"/>
         <html:hidden  property="customerid" name="customerid" value="<%= customerid %>"/>
		
   <!-- Default state value used for creation of bean object, typically changed in CommitServiceForm.jsp -->
         <html:hidden  property="state" name="state" value="Request_Sent"/>
         <html:hidden  property="modifydate" name="modifydate" value="<%= date_string %>"/>
         <html:hidden   property="submitdate" name="submitdate" value="<%= date_string %>"/>
          <html:hidden   property="messageid" name="messageid" value="<%= messageid %>"/>
     <%

		  String strRequestSynch = (String) session.getAttribute(Constants.REQUEST_SYNCHRONISATION);
          if( strRequestSynch == null)
		   { strRequestSynch = "true"; }
		  else
		   {  strRequestSynch = (String) session.getAttribute(Constants.REQUEST_SYNCHRONISATION); }
		 %>

         <html:hidden  property="SP_request_synchronisation" name="SP_request_synchronisation"
		 value="<%=strRequestSynch%>"/>

         <html:hidden  property="SP_Customer_name" name="SP_Customer_name" value="<%= company == null ? \"\" : company %>"/>

<%      String contactPersonConcatenated = (contactPersonName == null ? "" : contactPersonName) +
                                           (contactPersonSurName == null ? "" : (contactPersonName == null ? contactPersonSurName : " " + contactPersonSurName)) +
                                           (contactPersonphonenumber == null ? "" : (contactPersonName == null ? (contactPersonSurName == null ? contactPersonphonenumber : ": " + contactPersonphonenumber) : ": " + contactPersonphonenumber));
%>

         <html:hidden  property="SP_Contact_person" name="SP_Contact_person" 
		 value="<%= contactPersonConcatenated == null ? \"\" : contactPersonConcatenated %>"/>
		 <html:hidden  property="SP_Customer_email" name="SP_Customer_email" 
		 value="<%= customerEmail == null ? \"\" : customerEmail %>"/>

	</head>
<% 

if(serviceType.compareTo("layer2-VPN") != 0 && serviceType.compareTo("layer3-VPN") != 0 && !serviceType.equalsIgnoreCase("layer3-Site") && !serviceType.equalsIgnoreCase("Trunk") && serviceType.compareTo("GIS-VPN") != 0)
	{
%>
<script LANGUAGE="JavaScript" TYPE="text/javascript">
Calendar.setup({
    inputField     :    "endtime",
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
    inputField     :    "starttime",
    ifFormat       :    "yyyy.MM.dd HH:mm:ss", 
    daFormat       :    "<%=df.toPattern()%>",
    firstDay       :    1,
    showsTime      :    true,
    timeFormat     :    "24",
    button         :    "buttonStartDate",
    align          :    "Bl",
    singleClick    :    true
  });

</script>
<%}%>

	<script LANGUAGE="JavaScript" TYPE="text/javascript">

 function isSpecialCharFound(field)
  {	
    
     strValue = field.value;
    if(strValue.length != 0)
    {
        var Chars = "~`!@#$%^&*()+=.{}[]:;'<>?,./ ";

    	for (var i = 0; i < strValue.length; i++) {
    		if (!(Chars.indexOf(strValue.charAt(i)) == -1)){
		alert('<bean:message key="js.unavailable.char" />');
		field.focus();
		//field.select();
		return false;
		}
	}
        	
    }
    return true;
}



function clearCalendar(Id,fieldname)
		   {
				var timeObj;
				
				timeObj = getObjectById(Id);

				if(timeObj!=null)
			   {
					if(isIE_browser()){
					   timeObj.value = "";
					} else {
					   document.ServiceForm.elements[Id].value = "";

					}
					//timeObj.value = "";
				//	alert(document.ServiceForm.SP_StartTime);
				//document.ServiceForm.field.SP_StartTime.focus();
					//document.forms[0].field.focus();
			   }

		   }
function callValidate()
	{
	var msg = '<%=strMessage%>';
	if(msg!=null && msg!='null' && msg!="")
	{
		
		alert(msg);
	}
	}

</script>

<script LANGUAGE="JavaScript" TYPE="text/javascript">
function comboBox(oSelect, oText) {
  if (oSelect != null)
  {
  var iLeft= oSelect.offsetLeft;
　var iTop = oSelect.offsetTop;

var iWidth=oSelect.clientWidth;

var iHeight=oSelect.clientHeight;
oSelect.style.clip='rect(0,'+(iWidth)+','+(iHeight)+','+(iWidth-18)+')';
//alert("====iHeight====="+iHeight+"===iWidth==="+iWidth);

if(isIE_browser()){
	oText.style.width=iWidth;
　oText.style.height=iHeight;
  oText.style.top =iTop;
　oText.style.left=iLeft;
} else if(navigator.userAgent.indexOf("Firefox") != -1){
	oSelect.style.clip='rect(0,'+(iWidth+3)+','+(iHeight+10)+','+(iWidth-15)+')';
	oText.style.clip='rect(0,'+(iWidth-14)+','+(iHeight+10)+','+(0)+')';
	oSelect.style.height=20 + 'px';
	oSelect.style.width=iWidth+3;
　oText.style.width=iWidth-13 + 'px';
  oText.style.height=20 + 'px';
  oText.style.top =iTop + 'px';
　oText.style.left=iLeft + 'px';
}else if(navigator.userAgent.indexOf("MSIE 8.0") != -1||navigator.userAgent.indexOf("MSIE 7.0") != -1){
	oSelect.style.clip='rect(1,'+(iWidth+23)+','+(iHeight+6)+','+(iWidth+5)+')';
	oText.style.clip='rect(0,'+(iWidth+5)+','+(iHeight+6)+','+(0)+')';
	oSelect.style.height=22 + 'px';	
　oText.style.width=iWidth+8 +'px';
  oText.style.height=21 + 'px';
  oText.style.top =iTop + 'px';
　oText.style.left=iLeft + 'px';	
	
	}
　
  }
}
function Combo_Select(oSelect,oText)
{
　oText.value=oSelect.options[oSelect.selectedIndex].text;
}
function Text_ChkKey(oSelect,oText)
{
　if(event.keyCode==13)
  {
　　 var nIndex=HasTheValue(oText.value,oSelect);
　　 if(nIndex !=-1 && nIndex !=oSelect.selectedIndex)
　　 {
　　 oSelect.selectedIndex=nIndex;
　　 }
　}
}
function HasTheValue(name,oSelect)
{
　if(oSelect.options.length<1)
　　 return -1;
　var i=0;
　for(i=0;i<oSelect.options.length;i++)
　{
　　 if(oSelect.options[i].text==name)
　　 return i;
　}
　return -1;
}

function initCombo() {
      if (getObjectById('presnamelist') !== null)       
        comboBox(getObjectById('presnamelist'), getObjectById('presname'));
      if (getObjectById('SP_PW_aEndlist') !== null && getObjectById('SP_PW_zEndlist') != null) {
      	//alert("condition="+getObjectById('SP_PW_aEndlist').clientWidth+"====text withd==="+getObjectById('SP_PW_aEnd').clientWidth);
        comboBox(getObjectById('SP_PW_aEndlist'), getObjectById('SP_PW_aEnd'));
        comboBox(getObjectById('SP_PW_zEndlist'), getObjectById('SP_PW_zEnd'));
      }
}

function handleHintWhenOnFocus(presname, prompt) {
    if (presname.value == prompt) {
	presname.value = "";
    }
}
function handleHintWhenOnBlur(presname, prompt) {
    if (presname.value == "") {
	presname.value = prompt;
    }
}

function isIE_browser() {
// only indicate IE6 	
    if (window.XMLHttpRequest) {
        return false;
  }	else {
        return true;
  }
}


function getObjectById(objID) {
  if (document.getElementById  &&  document.getElementById(objID)) {
    return document.getElementById(objID);
  } else {
    if (document.all  &&  document.all(objID)) {
      return document.all(objID);
    } else {
      if (document.layers  &&  document.layers[objID]) {
        return document.layers[objID];
      } else {
        return document.ServiceForm.elements[objID];
      }
    }
  }
}

function switchAutoRefresh(autorefreshflag)
{
	var icon = document.getElementById("refreshIcon");
	if (parent.reload.bDoUpdate == true) {
		icon.src="images/autoRefreshOff.gif";
		icon.title="Auto-refresh is off";
		parent.reload.stopReload("true");
	} else {
		parent.reload.bDoUpdate = true;
		parent.reload.startReload("false");
		icon.src="images/autoRefreshOn.gif";
		icon.title="Auto-refresh is on";
	}
}


function init(custid,currPageNo,viewPgNo,servicemv)
{	
	if ('Netcape' == navigator.appName) document.forms[0].reset();	
	parent.reload.unlockScroll();
	parent.reload.doScroll();			
	parent.reload.findInstance();
	parent.reload.setURL('/crm/CreateService.do?customerid='+custid+'&type=Trunk&currentPageNo='+currPageNo+'&viewPageNo='+viewPgNo+'&mv='+servicemv);
	parent.reload.setCustomerId(custid);
	parent.reload.setServiceOperation('false');

	var icon = document.getElementById("refreshIcon");
	if(parent.reload.bDoUpdate == true){
		icon.src="images/autoRefreshOn.gif";
		icon.title="Auto-refresh is on";
		parent.reload.startReload("true");
	}else{
		icon.src="images/autoRefreshOff.gif";
		icon.title="Auto-refresh is off";
	}
} 

</script>
	
</body>
  </html:form>

<%
	// end of cust not null
  }  
  
  %>
</html:html>
