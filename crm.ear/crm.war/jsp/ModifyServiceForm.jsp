<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>

<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--#################################################################################--%>

<%-- -*- html -*- --%>

<%-- ************************************************************** --%>
<%--                                                                --%>
<%-- ModifyServiceForm.jsp                                          --%>
<%--                                                                --%>
<%-- Parameters:                                                    --%>
<%--  - None -                                                      --%>
<%--                                                                --%>
<%-- Description:                                                   --%>
<%--  It collects the information to store a new service            --%>
<%--  This information is sent to CommitModifyServiceForm.jsp       --%>
<%--                                                                --%>
<%-- *************************************************************** --%>


<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>


<%@page info="Modify a service"
  contentType="text/html;charset=UTF-8" language="java"
  import=" java.sql.*, com.hp.ov.activator.crmportal.bean.*,
          com.hp.ov.activator.crmportal.action.*,
		  com.hp.ov.activator.crmportal.helpers.*,
		  com.hp.ov.activator.crmportal.utils.*,
		  java.util.*, java.io.*, java.text.*, java.net.*,
          java.util.Date,org.apache.log4j.Logger,com.hp.ov.activator.crmportal.utils.DatabasePool,
          com.hp.ov.activator.crmportal.utils.*" %>

<%
  response.setDateHeader("Expires",0);
  response.setHeader("Pragma","no-cache");
  String formAction ="ModifyService";
String alertMessage = (String)request.getAttribute("Message");
Logger logger = Logger.getLogger("CRMPortalLOG");
  if(request.getParameter("actionType")==null)
	  {
   formAction ="ModifyService";
      }
	  else
	  {
   formAction =(String)request.getParameter("actionType");
	  }
      //load param parameters got here
   ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
   
   HashMap serviceParameters = new HashMap ();
   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
   HashMap parentServiceParameters = new HashMap ();
   parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");
   String CEbasedQoS ="";
   CEbasedQoS=(String)serviceParameters.get("CE_based_QoS");
   String siteServiceId = (String )serviceParameters.get("Site_Service_id");
   String allAttachmentsOk = "true";

/*	String pt=(String)request.getParameter("mv");
    int cpage  = Integer.parseInt((String)request.getAttribute("cpage"));
	int totalPages = Integer.parseInt((String)request.getAttribute("totalPages"));
	int vPageNo    = Integer.parseInt((String)request.getAttribute("vPageNo"));
*/

	String searchSite = (String)request.getAttribute("searchSite");	
	request.setAttribute("searchSite", searchSite);
	String siteidSearch = (String)request.getAttribute("siteidSearch");	
	request.setAttribute("siteidSearch", siteidSearch);
	


// Richa 11687
	int cpage = 1;
	String strPageNo = "1";
	int vPageNo = 1;

	String pt=(String)request.getParameter("mv");
	if(pt==null)
		pt="viewpageno";

    String strcpage = (String)request.getAttribute("currentPageNo");
	if(strcpage!=null)
	  cpage  = Integer.parseInt(strcpage);
	else
		strcpage="1";

	String strvPageNo	 =  (String)request.getAttribute("viewPageNo");
	if(strvPageNo!=null)
	  vPageNo = Integer.parseInt(strvPageNo);
	 else
		strvPageNo= "1";
	// Richa 11687
		
%>

<html:html locale="true">
  <head>
     <link rel="stylesheet" type="text/css" href="css/activator.css">
    <link rel="stylesheet" type="text/css" href="css/awfweb2.css">
	<META Http-Equiv="Cache-Control" Content="no-cache">
    <META Http-Equiv="Pragma" Content="no-cache">
    <META Http-Equiv="Expires" Content="0">
  	<script LANGUAGE="JavaScript" TYPE="text/javascript">

    function callReload()
	{

	  var action = ServiceForm.action.value;
	  //alert("action = "+action )
	  ServiceForm.actionflag.value=action;
	  ServiceForm.actionType.value="ModifyService";
	  ServiceForm.submit();

	}

	function callValidate()
	{

	var msg = '<%=alertMessage%>';
	if(msg!=null && msg!='null' && msg!='')
	{

		alert(msg);
	}
	}
	
	
	function refreshPeriodicity(){
	var isPeriodic = getObjectById("isPeriodic");
	if (isPeriodic != null) {
			checkPeriodicity();
		}
    }
	
	function callSubmit()
	{


     var action = ServiceForm.action.value;

	  if(action=="ModifyCAR")
	  {
        var period = getObjectById("Period");

	      if(period.disabled==false)
		 {
            var duration = getObjectById("Duration");
            if(duration.value.length==0)
			{
			    alert('<bean:message key="js.periodic.scheduling" />');
				var subButton = getObjectById('submitButtonId');
				subButton.style.visibility="visible";
				document.ServiceForm.Duration.focus();

			}
            else
			{
				ServiceForm.actionType.value="CommitModifyService";
                     ServiceForm.submit();
			}
		}
		 else
			{
				ServiceForm.actionType.value="CommitModifyService";
                     ServiceForm.submit();
			}
	  }
	  else if(action=="AddStaticRoutes")
		  {
			var check =checkStaticRoutes();
				if(!check)
				{
				  //alert('Wrong static route entered');
				}
				else
			  {
					ServiceForm.actionType.value="CommitModifyService";
                    ServiceForm.submit();
			  }
		  }
		  
		  else if(action=="ModifyRateLimitInterface")
		  {
			  var check =checkInterface();
				if(!check)
				{
				  //alert('Wrong static route entered');
				}
				else
			  {
					ServiceForm.actionType.value="CommitModifyService";
                    ServiceForm.submit();
			  }
			
				
		  }
	  else
	  {
             ServiceForm.actionType.value="CommitModifyService";
                     ServiceForm.submit();
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
        return  document.getElementById(Id);
	} else {
        return document.ServiceForm.elements[Id];
	}
}
   </script>

   </head>


  <%
     session.removeAttribute("NO_COMMIT");
	 Service service = serviceForm.getService();
	 String serviceType = service.getType();
	 String serviceid = serviceForm.getServiceid();	 
	 String messageid   = serviceForm.getMessageid();
	 String parentserviceid = serviceForm.getParentserviceid();
	 
	 Customer customer = serviceForm.getCustomer();
	 DatabasePool dbp = null;
	 Connection con = null;
	 if(parentserviceid==null){
	     parentserviceid = request.getParameter("parentserviceid");
	 }
	 String addressFamily = null;

    String attachmentid = (String)request.getAttribute("attachmentid");
    String parentType = (String)request.getAttribute("parentType");
    logger.debug("JSP attachmentid" + attachmentid);
    logger.debug("JSP parentType" + parentType);
	logger.debug("JSP parentserviceid" + parentserviceid);
	
	
	
	
	String modifySelection = (String)request.getAttribute("modifySelection");
      logger.debug("JSP modifySelection: " + modifySelection);

	   // if no modify action selected then hide commit button
      if(modifySelection == null || modifySelection.equalsIgnoreCase("") )
	 {
        session.setAttribute("NO_COMMIT", "true");
      }
	  
  try
  {
	HashSet roles = (HashSet) session.getAttribute(Constants.ROLES_KEY);
	boolean isOperator = false;
	boolean isAdministrator = false;
	logger.debug("roles :::::::"+roles);
	if(roles.contains(Constants.ROLE_OPERATOR)) {isOperator = true;}
	if(roles.contains(Constants.ROLE_ADMIN)) {isAdministrator = true;}

	if(isOperator == false)
	throw new IllegalStateException("Wrong role to perform the operation");
	
	String message = (String)request.getAttribute("errormessage");
	try{
    	dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
    	con = (Connection) dbp.getConnection();
	    if(serviceType.equals("layer3-VPN")){
	 	   addressFamily = ServiceUtils.getServiceParam(con, serviceid,"AddressFamily");
	    }
	    else if(serviceType.equals("layer3-Attachment")){
	  	  	addressFamily = ServiceUtils.getServiceParam(con, parentserviceid,"AddressFamily");
	    }
		
		if ("ModifyQoSBulk".equals(modifySelection) || "DeleteAllAttachments".equals(modifySelection))
		{
			String whereClause = "attribute = 'vpnserviceid' and value = '"+serviceid+"'"; 
							
			com.hp.ov.activator.crmportal.bean.ServiceParameter[] attachments = com.hp.ov.activator.crmportal.bean.ServiceParameter.findAll(con,whereClause);
			
			attachments = attachments != null ? attachments : new com.hp.ov.activator.crmportal.bean.ServiceParameter[0];
			
			for (int i=0; i < attachments.length; i++) 
			{
				com.hp.ov.activator.crmportal.bean.Service attachment = com.hp.ov.activator.crmportal.bean.Service.findByServiceid(con, attachments[i].getServiceid());
				String state = attachment.getState();
				
				if (state.indexOf("Ok") == -1)
				{
					allAttachmentsOk = "false";
				}
			}
		}
	}
	catch (Exception e)
	 {
		logger.debug("Exception retrieving bean data: "+e.getMessage());
	 }
	finally
	 {
		if(con != null)
			 dbp.releaseConnection(con);
	 }



    if (customer == null)
		{
      %>

	 <bean:message key="error.no.customer"/>
 <%
        } else if(message != null)
		{
    %>

	<%= message%>
	  <%
         }
	   else

	   {


      if ("Site".equals(serviceType)) {
        if ("layer2-VPN".equals(parentType)) {
          serviceType="layer2-Site";
        }
   //     if ("layer3-VPN".equals(parentType)) {
   //       serviceType="layer3-Site";
   //     }
      }
	  String l3AttachmentType = null;
	  if("layer3-Protection".equals(serviceType)){
          serviceType="layer3-Attachment";
		  l3AttachmentType="protection";
	  }

      logger.debug("JSP serviceType: " + serviceType);
      String serviceName = service.getPresname();
      serviceName = serviceName == null? "" : serviceName;

      String customerid = customer.getCustomerid();
      int rowCounter = 0;

	   if(addressFamily == null){
	   	addressFamily = (String)request.getAttribute("AddressFamily");
	   }

	   %>

	   <script>
		function validateForm() {
			var x = '<%=allAttachmentsOk%>';
						
			if (x == 'false') {
				alert("One or more site attachments are not in Ok/PE_Ok state. Bulk modification cannot be performed.");
				return false;
			}
		}
		
		function validateConfirmForm() {
			var x = '<%=allAttachmentsOk%>';
						
			if (x == 'false') {
				alert("One or more site attachments are not in Ok/PE_Ok state. Bulk modification cannot be performed.");
				return false;
			}
			else
			{
				return confirm('Are you sure you want to continue?');
			}
		}
	   </script>
	   
      <body bgcolor="white" onLoad = "callValidate(),refreshPeriodicity(); ">


<h2 class="mainSubHeading"><center><bean:message key="title.modify.service"/> <%= serviceType %></center></h2>
        <table border="0" width="100%" cellpadding="2" cellspacing="1">
        <tr>
          <th class="center"><bean:message key="label.customer.id"/></th>
          <th class="center"><bean:message key="label.company.name"/></th>
          <th class="center"><bean:message key="label.contactperson"/> </th>
          <th class="center"><bean:message key="label.phone.number"/> </th>
          <th class="center"><bean:message key="label.email"/></th>
		 
          <th class="center"><bean:message key="label.services"/></th>
		
        </tr>
        <tr>
          <td class="list<%= (rowCounter % 2) %>" align="center"><a title="Modify customer" href="/crm/UpdateCustomerSubmit.do?customerid=<%= customerid %>"><%= Utils.escapeXml(customerid) %></a></td>
          <td class="list<%= (rowCounter % 2) %>" align="center"><%= customer.getCompanyname() == null ? "&nbsp;" : Utils.escapeXml(customer.getCompanyname())%></td>
          <td class="list<%= (rowCounter % 2) %>" align="center"><%= customer.getContactpersonname() == null ? "&nbsp;" : Utils.escapeXml(customer.getContactpersonname()) %> <%= customer.getContactpersonsurname() == null ? "&nbsp;" : Utils.escapeXml(customer.getContactpersonsurname()) %></td>
          <td class="list<%= (rowCounter % 2) %>" align="center"><%= customer.getContactpersonphonenumber() == null ? "&nbsp;" : Utils.escapeXml(customer.getContactpersonphonenumber()) %></td>
          <td class="list<%= (rowCounter % 2) %>" align="center"><%= customer.getContactpersonemail() == null ? "&nbsp;" : Utils.escapeXml(customer.getContactpersonemail()) %></td>
		  <%			  
		  if(searchSite == null || searchSite.equals("")){ %>
          <td class="list<%= (rowCounter % 2) %>" align="center" >&nbsp;&nbsp;
              <a href="/crm/ListAllServices.do?customerid=<%= customerid %>&doResetReload=true&mv=null">
              <img border=0 src="images/Services.gif" width="20" height="20" title="Show service"></a>
          </td>
		  <% } else{%>
		  <td class="list<%= (rowCounter % 2) %>" align="center" >&nbsp;&nbsp;
              <a href="/crm/SearchSiteSubmit.do?serviceid=<%= siteidSearch%>&doResetReload=true&mv=null">
              <img border=0 src="images/Services.gif" width="20" height="20" title="Show service"></a>
          </td>
		  
		<%  }%>
        </tr>
        <tr>
          <td class="list<%= (rowCounter % 2) %>" colspan=6 align="center">&nbsp;</td>
        </tr>
      </table>
<br>
      <% rowCounter++; %>
	  
<center>
      <table border=0 width="80%" cellpadding=2 cellspacing=1>
		
			<html:form  action="/ModifyService" >


		  <html:hidden  property="serviceid" value="<%=serviceid%>" name="serviceid"/>
          <html:hidden  property="customerid" value="<%=customerid%>" name="customerid"/>
		  <html:hidden  property="type" value="<%=serviceType%>" name="type"/>
		 

<!--Richa 11687-->
		   <html:hidden  property="mv" value="<%=pt%>" name="pt"/>
		   <html:hidden  property="currentPageNo" value="<%=strcpage%>" name="currentPageNo"/>
		   <html:hidden  property="viewPageNo" value="<%=strvPageNo%>" name="vPageNo"/>
		   
<!--Richa 11687-->
		   <input type=hidden name="actionflag" value="">
		   <input type=hidden name="actionType" value="">
		   <input type=hidden name="searchSite" value="<%=searchSite%>">
		   <input type=hidden name="siteidSearch" value="<%=siteidSearch%>">

          <tr>
            <th class="left" colspan=4><bean:message key="title.service.info"/></th>
          </tr>

          <tr valign="center" height = "30">
            <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
            <td class="list<%= (rowCounter % 2) %>" align="left" width="40%"><strong><%= serviceType %><bean:message key="label.Id"/> </strong></td>
            <td class="list<%= (rowCounter % 2) %>" align="left"><a href="/crm/ShowServiceParameters.do?serviceid=<%= serviceid %>"><%=Utils.escapeXml(serviceName)%> (<%= serviceid %>)</a></td>
            <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
          </tr>
          <% rowCounter++; %>

          <tr height="30">
            <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
            <td align=left class="list<%= (rowCounter % 2) %>"><strong><bean:message key="label.param.tomodify"/></strong></td>
            <td align=left class="list<%= (rowCounter % 2) %>">
              <select name="action"  onChange="javascript:callReload();">  <!-- to be changed to action here -->
<%              if(modifySelection == null || modifySelection.equalsIgnoreCase("")){
%>
                    <option value="" selected >Select modify...</option>
<%
                }

                /*else if (serviceType.equals("layer2-Site")) {
%>
                      <option value="ModifyQoS">Modify QoS</option>
<%
                }*/
                if (serviceType.equals("layer2-Attachment")) {
%>
                      <option value="ModifyQoS">Modify QoS</option>
					  <option <%= "ModifyLSPUsageMode".equals(modifySelection) ? " selected": "" %> value="ModifyLSPUsageMode">Modify LSP usage mode</option>
<%
                }
				else if(serviceType.equals("layer2-VPN")){
%>
					<option <%= "ModifyQoSBulk".equals(modifySelection) ? " selected": "" %> value="ModifyQoSBulk">Modify QoS (Bulk)</option>
					
					<% if (isAdministrator) { %>
						<option <%= "DeleteAllAttachments".equals(modifySelection) ? " selected": "" %> value="DeleteAllAttachments">Delete All Attachments</option>
					<% } %>
					
<%              }
				else if(serviceType.equals("layer3-VPN")){
%>
                    <option <%= "ModifyTopology".equals(modifySelection) ? " selected": "" %> value="ModifyTopology">Topology</option>
					
					<option <%= "ModifyQoSBulk".equals(modifySelection) ? " selected": "" %> value="ModifyQoSBulk">Modify QoS (Bulk)</option>
					
					<% if (isAdministrator) { %>
						<option <%= "DeleteAllAttachments".equals(modifySelection) ? " selected": "" %> value="DeleteAllAttachments">Delete All Attachments</option>
					<% } %>
					
<%              } else if(serviceType.equals("layer2-VPWS")){
%>
                    <option <%= "ModifyRateLimit".equals(modifySelection) ? " selected": "" %> value="ModifyRateLimit">Rate-limit</option>
					<option <%= "ModifyLSPUsageMode".equals(modifySelection) ? " selected": "" %> value="ModifyLSPUsageMode">Modify LSP usage mode</option>

<%              } else if(serviceType.equals("layer3-Attachment")){
						request.setAttribute("siteServiceId", siteServiceId);
						if(!"protection".equals(l3AttachmentType)){
%>
							 <option <%= Constants.ACTION_JOIN_VPN.equals(modifySelection) ? " selected": "" %> value="<%=Constants.ACTION_JOIN_VPN%>">Join VPN</option>
			                 <option <%= Constants.ACTION_LEAVE_VPN.equals(modifySelection) ? " selected": "" %> value="<%=Constants.ACTION_LEAVE_VPN%>">Leave VPN</option>
							 <option <%= "ModifyConnectivityType".equals(modifySelection) ? " selected": "" %> value="ModifyConnectivityType">Connectivity type</option>
							 <%if(!"IPv6".equals(addressFamily)){%>
							 	<option <%= "ModifyMulticast".equals(modifySelection) ? " selected": "" %> value="ModifyMulticast">Multicast</option>
							 <%}%>
<%						}
%>
                <option <%= "ModifyCAR".equals(modifySelection) ? " selected": "" %> value="ModifyCAR">Rate limit</option>
				<option <%= "ModifyQoSProfile".equals(modifySelection) ? " selected": "" %> value="ModifyQoSProfile">Modify QoS</option>
                <option <%= "AddStaticRoutes".equals(modifySelection) ? " selected": "" %> value="AddStaticRoutes">Add static routes</option>
                <option <%= "RemoveStaticRoutes".equals(modifySelection) ? " selected": "" %> value="RemoveStaticRoutes">Remove static routes</option>
				<option <%= "ModifyLSPUsageMode".equals(modifySelection) ? " selected": "" %> value="ModifyLSPUsageMode">Modify LSP usage mode</option>
				<option <%= "ModifyAddressPool".equals(modifySelection) ? " selected": "" %> value="ModifyAddressPool">Modify Address Pool</option>
				<option <%= "ModifyRateLimitInterface".equals(modifySelection) ? " selected": "" %> value="ModifyRateLimitInterface">Modify Rate Limit and interface</option>
<%
                } else if(serviceType.equals("GIS-Attachment")){
                	request.setAttribute("siteServiceId", siteServiceId);
%>
       			<option <%= "ModifyCAR".equals(modifySelection) ? " selected": "" %> value="ModifyCAR">Rate limit</option>
				<option <%= "ModifyQoSProfile".equals(modifySelection) ? " selected": "" %> value="ModifyQoSProfile">Modify QoS</option>
                <option <%= "AddPrefixList".equals(modifySelection) ? " selected": "" %> value="AddPrefixList">Add Prefix List</option>
                <option <%= "RemovePrefixList".equals(modifySelection) ? " selected": "" %> value="RemovePrefixList">Remove Prefix List</option>   
<%} %>

			  </select>
              </td>
              <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
            </tr>
            <% rowCounter++; %>
            <tr height="15">
              <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
              <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
              <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
              <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
            </tr>
            <% rowCounter++; %>


<%
if (modifySelection != null && !modifySelection.equalsIgnoreCase("")) {
            String tempserviceid = serviceid == null ? "" : serviceid;
            String tempparentserviceid = parentserviceid == null ? "" : parentserviceid;
			String serviceFormFileName = "../forms/" + modifySelection + serviceType + ".jsp";
			if(modifySelection.equals("ModifyRateLimitInterface")){
				serviceFormFileName = "../forms/" + modifySelection + ".jsp";
			}
            else {
				serviceFormFileName = "../forms/" + modifySelection + serviceType + ".jsp";
			}			

%>

            <jsp:include page="<%= serviceFormFileName %>" flush="true">
              <jsp:param name="serviceid" value="<%= tempserviceid %>" />
              <jsp:param name="parentserviceid" value="<%= tempparentserviceid %>" />
              <jsp:param name="customerid" value="<%= customerid %>" />
              <jsp:param name="rowCounter" value="<%= rowCounter %>" />
              <jsp:param name="attachmentid" value="<%= attachmentid %>" />
			  <jsp:param name="siteServiceId" value="<%=siteidSearch %>" />
            </jsp:include>
<%        }
%>
        <html:hidden  property="customerid" name="customerid" value="<%= customerid %>"/>
        <html:hidden  property="serviceid" name="serviceid" value="<%= serviceid %>"/>
        <html:hidden  property="parentserviceid" name="parentserviceid" value="<%= parentserviceid %>"/>
        <input type=hidden  name="attachmentid" value="<%= attachmentid %>">
		<input type=hidden  name="VPNid" value="<%= parentserviceid %>">

		<%      if (service.getState().equals("Ok") || service.getState().equals("PE_CE_Ok") ||(service.getState().indexOf("Wait_End_Time_Failure") != -1 && service.getState().indexOf("PE") == -1)) { %>
		           <html:hidden  property="state" name="state" value="Modify_Request_Sent"/>
		<%      } else {
		          if (service.getState().equals("PE_Ok") || (service.getState().indexOf("Wait_End_Time_Failure") != -1 && service.getState().indexOf("PE") != -1)) { %>
		            <!--<input type="hidden" name="state" value="Modify_PE_Request_Sent"/>-->
					<input type="hidden" name="state" value="Modify_Request_Sent"/>
		<%        } else {
		            throw new Exception("The service is not in the correct state for modification!!");
		          }
		        }
		%>
        <%
              String no_commit = (String) session.getAttribute("NO_COMMIT");
              session.removeAttribute("NO_COMMIT");

              if (no_commit == null) { %>

          <tr>
            <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
            <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
            <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
            <td class="list<%= (rowCounter % 2) %>" align="right">

				   <html:link href="javascript:callSubmit();">
				   <% if ("DeleteAllAttachments".equals(modifySelection)) { %>
					<img  src="images/arrow_submit.gif" id="submitButtonId" onclick="return validateConfirmForm()" border="0" align="right"/>
				   <% } else if ("ModifyQoSBulk".equals(modifySelection)){ %>
					<img  src="images/arrow_submit.gif" id="submitButtonId" onclick="return validateForm()" border="0" align="right"/>
				   <% } else { %>
					<img  src="images/arrow_submit.gif" id="submitButtonId" onclick="this.style.visibility='hidden'" border="0" align="right"/>
				   <% } %>
	              </html:link>
            </td> 
          </tr>
		<%
              } %>
			  

        </form>
		</html:form>
        </table>
		
</center>
<%  }//else
  }//~try...

  catch (Exception e) {
      e.printStackTrace();
    %>
    <center>
    <h2>Error</h2>
    <b>Error modifying service: </b> <%= e.getMessage() %>
    <p><a href="javascript:window.history.back();"><img src="images/back.gif" border="0" title="return"></a>
    </center>
<%
	}
  %>



  </body>
</html:html>
