<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>


<%-- ************************************************************** --%>
<%--                                                                --%>
<%-- ShowServiceParameters.jsp                                      --%>
<%--                                                                --%>
<%-- Parameters:                                                    --%>
<%--  serviceid: service identifier                                 --%>
<%--                                                                --%>
<%-- Description:                                                   --%>
<%--  It displays the parameters related with a service.            --%>
<%--                                                                --%>
<%-- ************************************************************** --%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>

<%@page info="Shows all service parameters"
        contentType="text/html;charset=UTF-8" language="java" 
        import=" java.sql.*, com.hp.ov.activator.crmportal.action.*, java.util.*, java.io.*,
			java.sql.ResultSet, java.sql.SQLException, java.sql.PreparedStatement, java.sql.DriverManager,
          com.hp.ov.activator.crmportal.bean.*,
          com.hp.ov.activator.crmportal.utils.*,
		  com.hp.ov.activator.crmportal.common.*,
		  com.hp.ov.activator.crmportal.helpers.*,
          java.util.regex.Pattern,
          java.util.regex.Matcher,
          java.util.Date,java.util.HashSet,
          org.apache.log4j.Logger, javax.sql.DataSource, java.sql.Connection" %>
		  
		 

<%!

  String _replace (String name)
  {
    return name != null ? name.replace('_', ' ').replaceFirst("CAR", "Rate limit") : "";
  }

  final static Pattern scheduledPattern = Pattern.compile("(Sched_Modify_(PE_)?Request_Sent)|(Modify_(PE_)?Wait_Start_Time(_Failure)?)|((PE_)?Ok_Wait_Mod_End_Time)|(Modify_(PE_)?Wait_End_Time_Failure)");
  final static Pattern periodicPattern = Pattern.compile("(Periodic.*)");
  final static Pattern periodicParameterPattern = Pattern.compile("(^Period)|(Duration)|(StartTime)|(EndTime)");

  final static Pattern modifyUndoPattern = Pattern.compile("((PE_)?Ok_Wait_Mod_End_Time)|(Modify_(PE_)?Wait_End_Time_Failure)");

  Logger logger = Logger.getLogger("CRMPortalLOG");

   HashMap deleteServiceParams  = new HashMap();

  
%>

<%
  response.setDateHeader("Expires",0);
  response.setHeader("Pragma","no-cache"); 

   HashSet roles = (HashSet) session.getAttribute(Constants.ROLES_KEY);
   boolean isOperator = false;
   boolean isAdministrator = false;
   logger.debug("roles :::::::"+roles);
   if(roles.contains(Constants.ROLE_ADMIN)) {isAdministrator = true;}
   if(roles.contains(Constants.ROLE_OPERATOR)) {isOperator = true;}
%>

<html:html locale="true">
  <head>
    <link rel="stylesheet" type="text/css" href="css/activator.css">
    <link rel="stylesheet" type="text/css" href="css/awfweb2.css">
	<META Http-Equiv="Cache-Control" Content="no-cache">
    <META Http-Equiv="Pragma" Content="no-cache">
    <META Http-Equiv="Expires" Content="0">
   	<script LANGUAGE="JavaScript" TYPE="text/javascript">
      var serviceid;
      var customerid;
      var sendSaDeleteRequest;

      function deleteService(serviceid, customerid, sendSaDeleteRequest)
      {
        var page = 'DeleteService.jsp?serviceid='+serviceid+'&customerid='+customerid+'&sendSaDeleteRequest='+sendSaDeleteRequest;
        var conf = confirm('Do you wish to proceed and delete the service ' + serviceid + '?');

        if (conf == true) {
          self.location.href = page;
        }
      }
  </script>
</head>

<% 

ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
ServiceParameter[] parameters = serviceForm.getServiceparameters();
Service service = serviceForm.getService();
Service pservice = serviceForm.getParentService(); 
String serviceid = serviceForm.getServiceid(); 
int listCounter = 0;
if(service == null)
{
	logger.debug("service is null");
}

// Richa 11687
int cpage = 1;
	String strPageNo = "1";
	int vPageNo = 1;
	int currentRs = 0;
	int lastRs = 0;
	int totalPages = 0;

	
	String pt = serviceForm.getMv();
    String strcpage = serviceForm.getCurrentPageNo();
	String strvPageNo = serviceForm.getViewPageNo();
	String strcurrentRs = serviceForm.getCurrentRs();
    String strlastRs = serviceForm.getLastRs();
	String strtotalPages = serviceForm.getTotalPages();

	
	if(strcpage!=null)
	  cpage  = Integer.parseInt(strcpage);

	if(strvPageNo!=null)
	  vPageNo = Integer.parseInt(strvPageNo);

	if(strcurrentRs!=null)
	  currentRs  = Integer.parseInt(strcurrentRs);

	if(strlastRs!=null)
	  lastRs = Integer.parseInt(strlastRs);

	if(strtotalPages!=null)
	  totalPages  = Integer.parseInt(strtotalPages);

%>

<body>
<center>

<%
      Matcher modifyUndoMatcher = modifyUndoPattern.matcher(service.getState());
      boolean modifyUndoFind =  modifyUndoMatcher.find();
      final int length = parameters != null ? parameters.length : 0;
      final Hashtable paramsTable = new Hashtable(length);
      final Hashtable scheduledParams = new Hashtable();
      final Hashtable periodicParams = new Hashtable();
      boolean isPeriodic = false;
      boolean isScheduled = false;

      for (int i = 0; i < length; i++)
		  {
           ServiceParameter parameter = parameters[i]; 
        if(periodicParameterPattern.matcher(parameter.getAttribute()).find())
          periodicParams.put(parameter.getAttribute(), parameter);
        else
          paramsTable.put(parameter.getAttribute(), parameter);
      }

      // If it's scheduled case then replace parameter with one saved in undo because it hasn't been changed yet
      Matcher matcher = scheduledPattern.matcher(service.getState());
      isScheduled = matcher.find();
      isPeriodic = periodicPattern.matcher(service.getState()).find();

      if(isScheduled)
	{
        String attribute = "hidden_LastModifiedAttribute";
        String value = "hidden_LastModifiedAttributeValue";
        ServiceParameter scheduledParameter, attributeParameter, valueParameter;
        int index = 0;
        while( null != (attributeParameter = (ServiceParameter) paramsTable.get(attribute)) )
		{

          valueParameter = (ServiceParameter) paramsTable.get(value);
          scheduledParameter = (ServiceParameter) paramsTable.get(attributeParameter.getValue());

          // save parameter in scheduled parameters list.
          if(valueParameter != null && scheduledParameter != null)
	    {
                if( modifyUndoFind && (attributeParameter.getValue().equals("CAR") || attributeParameter.getValue().equals("RL")))
				{
                    scheduledParams.put(attributeParameter.getValue(),
                         new ServiceParameter(serviceid, attributeParameter.getValue(), ((ServiceParameter) paramsTable.get("hidden_LastModifiedAttributeValue")).getValue()));
                 } 
				 else{
                scheduledParams.put(attributeParameter.getValue(),
                    new ServiceParameter(serviceid, attributeParameter.getValue(), scheduledParameter.getValue()));
                 }
          }

          // replace parameter with one from undo
          if(valueParameter != null)
	      {
              if( modifyUndoFind && "CAR".equals(attributeParameter.getValue()))
				  {
                   } else{
                if(scheduledParameter != null){
                    scheduledParameter.setValue(valueParameter.getValue());
                }
              }
          }

          attribute = "hidden_LastModifiedAttribute" + index ;
          value = "hidden_LastModifiedAttributeValue" + index++ ;
        }
      }

      // Filter qos parameters
      final Hashtable qosParams = new Hashtable(7);
      final Set keySet = paramsTable.keySet();
      final Iterator iterator = keySet.iterator();

      while (iterator.hasNext())
	{
        final String key = (String) iterator.next();
        if(key.startsWith("QOS_") || key.equals("CAR") || key.equals("RL"))
			{
          qosParams.put(key, paramsTable.get(key));
          iterator.remove();
        }
      }
	  
	
	 
	  
	  
	 
	  

%>
<html:form  action="/DeleteServicefromServiceParams" >

<h2 class="mainSubHeading"><center><bean:message key="label.Service" /> <%= serviceid %></center></h2>
      <table align="center" width="80%" border=0 cellpadding=4 cellspacing=1>
        <tr>
          <th class="left"><bean:message key="label.parameter" /></th>
          <th class="left"><bean:message key="label.Value" /></th>
        </tr>

        <tr align="left">
          <td class="list1" valign="middle"><bean:message key="label.Serviceid" /></td>
          <td class="list1" valign="middle"> <%= service.getServiceid() %> </td>
        </tr>

        <tr align="left">
          <td class="list<%= listCounter % 2 %>" valign="middle"><bean:message key="label.ServName" /></td>
          <td class="list<%= listCounter % 2 %>" valign="middle"> <%= service.getPresname() %> </td>
        </tr>

<%      listCounter++; %>

        <tr align="left">
          <td class="list<%= listCounter % 2 %>" valign="middle"><bean:message key="label.servState" /></td>
          <td class="list<%= listCounter % 2 %>" valign="middle"> <%= service.getState() %> </td>
        </tr>

<%      listCounter++; %>

        <tr align="left">
          <td class="list<%= listCounter % 2 %>" valign="middle"><bean:message key="label.serv.Submitdate" /></td>
          <td class="list<%= listCounter % 2 %>" valign="middle"> <%= service.getSubmitdate() %> </td>
        </tr>

<%      listCounter++; %>

        <tr align="left">
          <td class="list<%= listCounter % 2 %>" valign="middle"><bean:message key="label.serv.Modifydate" /></td>
          <td class="list<%= listCounter % 2 %>" valign="middle"> <%= service.getModifydate() %> </td>
        </tr>

<%      listCounter++; %>

        <tr align="left">
          <td class="list<%= listCounter % 2 %>" valign="middle"><bean:message key="label.serv.Type" /></td>
          <td class="list<%= listCounter % 2 %>" valign="middle"> <%= service.getType() %> </td>
        </tr>

<%      listCounter++; %>

        <tr align="left">
          <td class="list<%= listCounter % 2 %>" valign="middle"><bean:message key="label.serv.customer.id" /></td>
          <td class="list<%= listCounter % 2 %>" valign="middle">
		  <a href="/crm//EditCustomerfromList.do?customerid=<%= service.getCustomerid () %>"><%= service.getCustomerid() %> 
		  </td>
        </tr>

<%      listCounter++; %>

<%      if(service.getParentserviceid() != null) { %>
          <tr align="left">
            <td class="list<%= listCounter % 2 %>" valign="middle"><bean:message key="label.parent.serv.id" /></td>
            <td class="list<%= listCounter % 2 %>" valign="middle"> <%= service.getParentserviceid() %> </td>
          </tr>

<%        listCounter++;

%>
          <tr align="left">
            <td class="list<%= listCounter % 2 %>" valign="middle"><bean:message key="label.parent.serv.name" /></td>
            <td class="list<%= listCounter % 2 %>" valign="middle"> <%= pservice.getPresname() %> </td>
          </tr>

<%        listCounter++; %>
<%      } %>

<%      if (paramsTable.size() == 0) { %>
          <tr align="center">
            <td class="list<%= listCounter % 2 %>" colspan = 2>&nbsp</td>
          </tr>
<%        listCounter++; %>

          <tr>
            <td class="list<%= listCounter % 2 %>" colspan = 2 valign="middle">
              <bean:message key="label.no.serv.params" /></td>
            </td>
          </tr>
<%        listCounter++; %>
<%      } else {

            List keys = Collections.list(paramsTable.keys());
            Collections.sort(keys);

          for (int i=0; i < keys.size(); i++) {
            ServiceParameter parameter = (ServiceParameter) paramsTable.get(keys.get(i));
            if (parameter.getValue() != null && !parameter.getAttribute().startsWith("hidden") && !(parameter.getValue().equals("null"))) { 
				if(parameter.getAttribute().equals("EthServiceType")) parameter.setAttribute("ServiceType");
					if(parameter.getAttribute().equalsIgnoreCase("STATIC_routes"))
						continue;
				
				%>
              <tr align="left">
                <td class="list<%= listCounter % 2 %>" valign="middle"> <%= _replace(parameter.getAttribute()) %> </td>
                <td class="list<%= listCounter % 2 %>" valign="middle"> <%= parameter.getValue() %> </td>
              </tr>
<%            listCounter++;
            }
          }
        }
		%>
		<% // StaticRoute
	Connection con = null;
	DataSourceLocator ds1 = new DataSourceLocator(); 
	
	StaticRoute aroutes[]=null;
	
	
	try
	{
		DataSource ds = ds1.getDataSource();
		if (ds != null)
		{
			con = ds.getConnection();
			
			aroutes= StaticRoute.findByAttachmentid(con, serviceid);
		}             
	}
	catch(Exception e)
	{
		e.printStackTrace();
	} finally {	
		con.close();
	}
	
	if (aroutes != null) 
				   {
	
	
	%>

		<tr align="left">
          <td class="list1" valign="middle"><bean:message key="label.static.routes" /></td>
          <td class="list1" valign="middle"> 
		  <%
		  
					String routes = "";
					int cont=0;
					for (int i = 0; i < aroutes.length; i++) 	{						
						String address=aroutes[i].getStaticrouteaddress();
						StringTokenizer routeElements = new StringTokenizer(address, "/");
						String route = routeElements.nextToken();
						String mask = routeElements.nextToken();
						cont++;
						if(cont == aroutes.length)
							routes += route + "/" + mask ;
						else
							routes += route + "/" + mask +", " ;
						
					}
				   
		  
		  
		  %> 
		  <%= routes%>
		  
		  </td>
        </tr>
				   <% } %>
		
		
		
<%		
        if(qosParams.size() > 0 && (!service.getType().equals("layer3-Site")&& !service.getType().equals("layer2-Site"))){
%>
        <tr>
          <th class="left" colspan="2" align="center" ><bean:message key="label.qos.params" /></th>
        </tr>
<%
          ServiceParameter rateLimit = (ServiceParameter) qosParams.get("CAR");
          rateLimit = rateLimit != null ? rateLimit : (ServiceParameter) qosParams.get("RL");
          if(rateLimit != null){
%>
              <tr align="left">
                <td class="list<%= listCounter % 2 %>" valign="middle"><bean:message key="label.params.ratelimit" /></td>
                <td class="list<%= listCounter % 2 %>" valign="middle"> <%= rateLimit.getValue()%> </td>
              </tr>
<%
          }

          ServiceParameter qosProfile = (ServiceParameter) qosParams.get("QOS_PROFILE");
          if(qosProfile != null){
%>
              <tr align="left">
                <td class="list<%= listCounter % 2 %>" valign="middle"> <bean:message key="label.params.profile" /></td>
                <td class="list<%= listCounter % 2 %>" valign="middle"> <%= qosProfile.getValue()%> </td>
              </tr>
<%
          }
        }
        if(isScheduled && scheduledParams.size() > 0){
%>
        <tr>
          <th class="left" colspan="2" align="center" ><bean:message key="label.sched.params" /></th>
        </tr>
<%
          if(service.getNextoperationtime() > 1){
            String nextActivation = Constants.SCHEDULED_DATE_FORMAT.format(new Date(service.getNextoperationtime()));
%>
            <tr align="left">
              <td class="list<%= listCounter % 2 %>" valign="middle"> <bean:message key="label.next.activ" /></td>
              <td class="list<%= listCounter % 2 %>" valign="middle"> <%= nextActivation%> </td>
            </tr>
<%
          }
          final Enumeration keys = scheduledParams.keys();
          while (keys.hasMoreElements()) {
            String key = (String) keys.nextElement();
            ServiceParameter parameter = (ServiceParameter) scheduledParams.get(key);
%>
              <tr align="left">
                <td class="list<%= listCounter % 2 %>" valign="middle"> <%= _replace(parameter.getAttribute()) %> </td>
                <td class="list<%= listCounter % 2 %>" valign="middle"> <%= parameter.getValue() %> </td>
              </tr>
<%

          }
        }

        if(isPeriodic && periodicParams.size() > 0){
%>
        <tr>
          <th class="left" colspan="2" align="center" ><bean:message key="label.periodic.params" /></th>
        </tr>
<%
          if(service.getNextoperationtime() > 1){
            String nextActivation = Constants.SCHEDULED_DATE_FORMAT.format(new Date(service.getNextoperationtime()));
%>
            <tr align="left">
              <td class="list<%= listCounter % 2 %>" valign="middle"> <bean:message key="label.next.activ" /></td>
              <td class="list<%= listCounter % 2 %>" valign="middle"> <%= nextActivation%> </td>
            </tr>
<%
            final Enumeration keys = periodicParams.keys();
            while (keys.hasMoreElements()) 
			{
              String key = (String) keys.nextElement();
              ServiceParameter parameter = (ServiceParameter) periodicParams.get(key);
%>
              <tr align="left">
                <td class="list<%= listCounter % 2 %>" valign="middle"> <%= _replace(parameter.getAttribute()) %> </td>
                <td class="list<%= listCounter % 2 %>" valign="middle"> <%= parameter.getValue() %> </td>
              </tr>
<%
            }
            String key = Constants.PARAMETER_LAST_MODIFIED;
            String value = Constants.PARAMETER_LAST_MODIFIED_VALUE;
            int index = 0;
            while(paramsTable.contains(key)){
              ServiceParameter parameterKey = (ServiceParameter) paramsTable.get(key);
              ServiceParameter parameterValue = (ServiceParameter) paramsTable.get(value);
%>
              <tr align="left">
                <td class="list<%= listCounter % 2 %>" valign="middle"> <%= _replace(parameterKey.getValue()) %> </td>
                <td class="list<%= listCounter % 2 %>" valign="middle"> <%= parameterValue != null ? parameterValue.getValue() : "" %> </td>
              </tr>
<%
              key = Constants.PARAMETER_LAST_MODIFIED+index;
              value = Constants.PARAMETER_LAST_MODIFIED_VALUE+(index++);
            }

          }else{
%>
              <tr align="left">
                <td class="list<%= listCounter % 2 %>" valign="middle"><bean:message key="label.periodic.status" /> </td>
                <td class="list<%= listCounter % 2 %>" valign="middle"><bean:message key="label.finishing" /></td>
              </tr>
<%
          }
        }
%>
        <tr>
          <th class="left" colspan="2" align="center" ><bean:message key="label.rel.services" /></th>
        </tr>
        <tr>
          <th class="left"><bean:message key="label.serv" /></th>
          <th class="left"><bean:message key="label.param.attrib" /></th>
        </tr>
<%
        // counting related services

		   ServiceParameterVO[] parameterVO = serviceForm.getServiceparameterVO(); 
        
		for(int l=0;l< parameterVO.length;l++)	
			{
				ServiceParameterVO servParamVO = new ServiceParameterVO();
				servParamVO = parameterVO[l];
%>

		<tr align="left">
            <td class="list<%= listCounter % 2 %>" valign="middle"> <%=servParamVO.getServicename()%>(<a href="/crm/ListAllServices.do?customerid=<%=servParamVO.getCustomerid()%>&doResetReload=true&mv=null">
			<%=servParamVO.getCustomername()%></a>) </td>
            <td class="list<%= listCounter % 2 %>" valign="middle"> <%=servParamVO.getAttribute()%></td>
        </tr>
<%
                listCounter++;
            
        }
%>
        <tr>
          <td class="list<%= listCounter % 2 %>" align="right" colspan="2">
<%
        if(isOperator)
	{


		                   deleteServiceParams.put("serviceid",service.getServiceid());
	                       deleteServiceParams.put("customerid",service.getCustomerid());        
                           deleteServiceParams.put("sendSaDeleteRequest","false");
				// Richa 11687
						 deleteServiceParams.put("mv",pt);
						 deleteServiceParams.put("currentPageNo",strcpage);
						 deleteServiceParams.put("viewPageNo",strvPageNo);
		 				 deleteServiceParams.put("currentRs",strcurrentRs);
						 deleteServiceParams.put("lastRs",strlastRs);
						 deleteServiceParams.put("totalPages",strtotalPages);
				// Richa 11687

		                   pageContext.setAttribute("deleteServiceParamsMap", deleteServiceParams); 

						   if(isAdministrator){
%>
		    <html:link onclick="return confirm('This will delete the service parameters in CRM portal without sending any requests to HPSA. Hence, do not select this option unless you are absolutely sure about what you are doing. \nDo you want to proceed and delete the local service parameters ?')" page="/DeleteServicefromServiceParams.do" name="deleteServiceParamsMap" scope="page">
			 <html:img page="/images/Delete.gif" border="0"  align="right" title="Drop service without request to SA"/>
			 </html:link>
<%
						   }//if(isAdministrator)
      }
%>
          </td>
        </tr>
<%      listCounter++; %>

 
      </table>

      <p><html:link href="javascript:window.history.back();">
		  <html:img page="/images/back.gif" border="0" align="left" title="Return"/>
	     </html:link>
    

</center>

</body>
</html:form>




</html:html>
