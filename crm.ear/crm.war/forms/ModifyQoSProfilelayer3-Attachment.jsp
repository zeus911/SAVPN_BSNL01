<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--############################################################################--%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>


<%@ page import="java.util.*,
                 com.hp.ov.activator.crmportal.utils.*,
                 com.hp.ov.activator.crmportal.action.*,
                 com.hp.ov.activator.crmportal.bean.*"%>

<%  
   //load param parameters got here
   ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
   HashMap serviceParameters = new HashMap ();
   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
   HashMap parentServiceParameters = new HashMap ();
   parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");

    CAR multicastRateLimit = null;
	multicastRateLimit = (CAR)request.getAttribute("multicastRateLimit");
	String serviceid = serviceForm.getServiceid();
    String parentserviceid = serviceForm.getParentserviceid();
    String layer = "layer 3";
    String customer_id = serviceForm.getCustomerid();
    customer_id = customer_id == null ? "" : customer_id;
	
	String siteServiceId = (String)request.getParameter("siteServiceId");
request.setAttribute("siteServiceId", siteServiceId); 
String searchSite = (String)request.getParameter("searchSite");	
request.setAttribute("searchSite", searchSite);

	String failureLink = "/crm/ListAllServices.do?customerid="+customer_id+"&doResetReload=true&mv=true";
	if(searchSite != null && !searchSite.equals(""))
			failureLink="SearchSiteSubmit.do?serviceid="+siteServiceId+"&doResetReload=true&mv=null";
    CAR[] rateLimits = null;
    int rowCounter= Integer.parseInt(request.getParameter("rowCounter"));

    String rateLimit = (String)request.getAttribute("rateLimit");
    if (rateLimit == null)
      rateLimit = (String) serviceParameters.get("CAR");
	String SP_QoSChildEnabled = (String) request.getAttribute("SP_QoSChildEnabled");
	 
	
	if(SP_QoSChildEnabled==null){
		SP_QoSChildEnabled="false";
	}

    String link_part1 = "'/crm/ModifyService.do?type=layer3-Attachment&serviceid=" + serviceid +
                        "&customerid=" +customer_id+
                        "&action=" + request.getParameter("action") +
              "&SP_QOS_PROFILE=' + form.SP_QOS_PROFILE.options[form.SP_QOS_PROFILE.selectedIndex].value" +
              "+'&SP_CAR=' + form.SP_CAR.value" +
              "+'&parentserviceid=' + form.parentserviceid.value" +
              "+'&attachmentid=' + form.attachmentid.value" +
              "+'&SP_QOS_BASE_PROFILE=' + form.SP_QOS_BASE_PROFILE.value +"+
			  "'&SP_QoSChildEnabled=' + ServiceForm.SP_QoSChildEnabled.value" ;
    String link_part2 = "";
    try
	{
       
        rateLimits = (CAR[])request.getAttribute("rateLimits");

		EXPMapping[] mappings = (EXPMapping[])request.getAttribute("mappings");

        int mappingsLength = mappings == null ? 0 : mappings.length;

        for(int i = 0; i < mappingsLength; i++)
			{
            EXPMapping expMapping = mappings[i];
            final String spParamName = "SP_QOS_CLASS_"+expMapping.getPosition()+"_PERCENT";
            final String paramName = "QOS_CLASS_"+expMapping.getPosition()+"_PERCENT";
            link_part1 += "+'&"+spParamName+"=' + form."+spParamName+".value";
            if(request.getAttribute(spParamName) == null && 
				serviceParameters.get("QOS_CLASS_"+i+"_PERCENT") != null)
				{
                request.setAttribute(spParamName, serviceParameters.get(paramName));
                }
             }
        if(request.getAttribute("SP_QOS_PROFILE") == null && serviceParameters.get("QOS_PROFILE") != null) 
			{
            request.setAttribute("SP_QOS_PROFILE", serviceParameters.get("QOS_PROFILE"));
        }
    }
    catch(Exception ex){
        ex.printStackTrace();
%>
    <script>
    alert('<bean:message key="js.ratelimit.error" /><%= ex.getMessage () %>.');
    location.href = '<%=failureLink%>';
    </script>
<%

    }
  
%>
<tr height="30">
  <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.multi.RL" /></b></td>
  <td align=left class="list<%= (rowCounter % 2) %>">
  <select name="SP_CAR"  onChange="setAbsolutRL();">
<%    if (rateLimits != null) {

	
    for (int i=0; i < rateLimits.length; i++) {

        
		if(multicastRateLimit != null && rateLimits[i].getAveragebw() < multicastRateLimit.getAveragebw())
            continue;
      %>

	  <option <%= rateLimits[i].getRatelimitname().equals (rateLimit) ? " selected": "" %> value="<%=  rateLimits[i].getRatelimitname() %>"><%= rateLimits[i].getRatelimitname() %></option>
<%      }
  }
%>
  </select>
</td>
 <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>
   <% rowCounter++; %>


<%@ include file="qos.jsp" %>
<tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.qosprofilechild" /></b></td>
    <td class="list<%= (rowCounter % 2) %>" align=left>
      <select  name="SP_QoSChildEnabled" onChange="location.href = <%= link_part1 + link_part2 %>;">
       
			<option <%= SP_QoSChildEnabled.equals("false") ? " selected": "" %> value="false">No</option>
		    <option <%= SP_QoSChildEnabled.equals("true") ? " selected": "" %> value="true">Yes</option>
       
      </select>
	
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  </tr>
 <% rowCounter++; %>
<%
  boolean allowPeriodicity = true;
%>
<%@ include file="SchedulingParams.jsp" %>
