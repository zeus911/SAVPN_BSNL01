<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>


<%@page info="Modify VPN QoS (Bulk)"
        contentType="text/html; charset=UTF-8"
        import="com.hp.ov.activator.crmportal.bean.*,com.hp.ov.activator.crmportal.action.*, java.util.HashMap,java.io.*,
		java.text.*, java.net.*,java.util.HashSet, com.hp.ov.activator.crmportal.utils.*,com.hp.ov.activator.crmportal.helpers.*, 
		java.sql.ResultSet, java.sql.SQLException, java.sql.PreparedStatement, java.sql.DriverManager,
		com.hp.ov.activator.crmportal.common.*, org.apache.log4j.Logger, com.hp.ov.activator.vpn.inventory.*,
		com.hp.ov.activator.inventory.SAVPN.*, javax.sql.DataSource, java.sql.Connection"
 %>

<%  
	//load param parameters got here
	ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
	HashMap serviceParameters = new HashMap ();
	serviceParameters = (HashMap)request.getAttribute("serviceParameters");
	
	String servType = serviceForm.getType();
	
	String selectedCAR = "";
	
	if (request.getAttribute("rateLimit") != null)
	{
		selectedCAR = (String) request.getAttribute("rateLimit");
	}
	
	String SP_QoSChildEnabled = (String) request.getAttribute("SP_QoSChildEnabled");
	
	if(SP_QoSChildEnabled==null){
		SP_QoSChildEnabled="false";
	}
	
	String serviceid = serviceForm.getServiceid();
    String layer = "layer 3";
    String customer_id = serviceForm.getCustomerid();
    customer_id = customer_id == null ? "" : customer_id;
	String whereForRate = "RateLimitName != 'Unknown'";
	
	// Get QoS related parameters
	String addFam = (String)request.getAttribute("AddressFamily");
	
	String selectedProfileName = "";
	
	if (request.getAttribute("SP_QOS_PROFILE") != null)
	{
		selectedProfileName = (String) request.getAttribute("SP_QOS_PROFILE");
	}
	
	String baseProfile = "";
	
	if (request.getAttribute("SP_QOS_BASE_PROFILE") != null)
	{
		baseProfile = (String) request.getAttribute("SP_QOS_BASE_PROFILE");
	}
	
	com.hp.ov.activator.crmportal.bean.Profile[] profiles;
	com.hp.ov.activator.crmportal.bean.Profile selectedProfile = null;
    
	com.hp.ov.activator.crmportal.bean.EXPMapping[] expMappings = null;
    com.hp.ov.activator.crmportal.bean.PolicyMapping[] policyMappings = null;
	
	com.hp.ov.activator.crmportal.bean.CAR[] rateLimits = null;
    
	java.util.Hashtable policyMap = new java.util.Hashtable();
	java.util.HashMap   compliantMapping = new java.util.HashMap();
    java.util.ArrayList allProfiles = new java.util.ArrayList();
	
	int maximumPosition = 0;
	boolean message = false;
	String siteServiceId = (String)request.getParameter("siteServiceId");
	request.setAttribute("siteServiceId", siteServiceId); 
	String searchSite = (String)request.getParameter("searchSite");	
	request.setAttribute("searchSite", searchSite);
	
	String link_part1 = "'/crm/ModifyService.do?type=layer3-VPN&serviceid=" + serviceid +
                        "&customerid=" +customer_id+
                        "&action=" + request.getParameter("action") +
              "&SP_QOS_PROFILE=' + form.SP_QOS_PROFILE.options[form.SP_QOS_PROFILE.selectedIndex].value" +
              "+'&SP_CAR=' + form.SP_CAR.value"+
			  "+'&parentserviceid=' + form.parentserviceid.value"+
			  "+'&SP_QoSChildEnabled=' + form.SP_QoSChildEnabled.value";

	String failureLink = "/crm/ListAllServices.do?customerid="+customer_id+"&doResetReload=true&mv=true";
	if(searchSite != null && !searchSite.equals(""))
			failureLink="SearchSiteSubmit.do?serviceid="+siteServiceId+"&doResetReload=true&mv=null";

	int rowCounter = 0;
    
	Connection con = null;
	DataSourceLocator dsl = new DataSourceLocator(); 
	
	// CAR
	try
	{
		DataSource ds = dsl.getDataSource();
		if (ds != null)
		{
			con = ds.getConnection();
		
			rateLimits = com.hp.ov.activator.crmportal.bean.CAR.findAll(con,whereForRate);		
			
			// Assign default value to selectedCAR if it hasn no value yet
			if ("".equals(selectedCAR))
			{
				if (rateLimits != null) 
				{
					rateLimits = rateLimits != null ? rateLimits : new com.hp.ov.activator.crmportal.bean.CAR[0];
					
					for (int i=0; i < rateLimits.length; i++) 
					{
						if (!("Unknown".equals(rateLimits[i].getRatelimitname())) && ("".equals(selectedCAR)))
						{
							selectedCAR=rateLimits[i].getRatelimitname();
						}
					}
				}
			}
			
			com.hp.ov.activator.crmportal.bean.EXPMapping[] mappings = com.hp.ov.activator.crmportal.bean.EXPMapping.findAll(con);

			int mappingsLength = mappings == null ? 0 : mappings.length;

			for(int i = 0; i < mappingsLength; i++)
				{
				com.hp.ov.activator.crmportal.bean.EXPMapping expMapping = mappings[i];
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
	}
	catch (Exception e) 
	{ 
		e.printStackTrace();
		%>
		<script>
		alert('<bean:message key="js.ratelimit.error" /><%= e.getMessage () %>.');
		location.href = '<%=failureLink%>';
		</script>
		<%
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

	// QoS
	try {
		
		DataSource ds = dsl.getDataSource();
		
		if (ds != null)
		{
			con = ds.getConnection();
			
			expMappings = com.hp.ov.activator.crmportal.bean.EXPMapping.findAll(con);
			
			String whereClause1 = "";
			String whereClause2 = "";

			if("IPv6".equalsIgnoreCase(addFam)){
				whereClause1 = "peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename like '%_v6'" ;
				whereClause2 = "customerid is null and peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename like '%_v6'";
			}
			else{
				whereClause1 = "peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename not like '%_v6'" ;
				whereClause2 = "customerid is null and peqosprofilename is not null and prefix != 'l3_asbr' and qosprofilename not like '%_v6'";
			}
		    
			// getting customer profiles
			profiles = com.hp.ov.activator.crmportal.bean.Profile.findByLayer(con, layer, whereClause1);
			
			if(profiles != null)
			{
				for (int i = 0; i < profiles.length; i++)
				{
					com.hp.ov.activator.crmportal.bean.Profile profileObj = profiles[i];
					if(profileObj.getCompliant().equalsIgnoreCase("compliant"))
					{	
						allProfiles.add(profiles[i]);
					}
					else
					{
						message = true;
						if( (!("".equals(selectedProfileName))) && profileObj.getQosprofilename().equalsIgnoreCase(selectedProfileName))
						{
							selectedProfileName = "";
							baseProfile = "";
						}
					
					}
					// ends here
				}
			}
			
		   if((!("".equals(selectedProfileName))) && selectedProfileName.equalsIgnoreCase("Unknown"))
		   {
			selectedProfileName = "";
			baseProfile = "";
		   }

			if(allProfiles.size() == 0)
				throw new Exception("There are no profiles in inventory");

			 //  if there was no base profile then it is the selected profile
			if("".equals(baseProfile))
			{
				if("".equals(selectedProfileName))
				{
				   selectedProfileName = ((com.hp.ov.activator.crmportal.bean.Profile) allProfiles.get(0)).getQosprofilename();
				   selectedProfile = (com.hp.ov.activator.crmportal.bean.Profile) allProfiles.get(0);
				   baseProfile = selectedProfileName;
				}
				baseProfile = selectedProfileName;
				 
			}
			
			selectedProfile = com.hp.ov.activator.crmportal.bean.Profile.findByQosprofilename(con, baseProfile);
			
			if(selectedProfile == null)
			{
				selectedProfile = (com.hp.ov.activator.crmportal.bean.Profile) allProfiles.get(0);
				baseProfile = selectedProfile.getQosprofilename();
				selectedProfileName = baseProfile;
			   
			}

			policyMappings = com.hp.ov.activator.crmportal.bean.PolicyMapping.findByProfilename(con, baseProfile);
					
			if(policyMappings == null)
			{
				policyMappings = com.hp.ov.activator.crmportal.bean.PolicyMapping.findByProfilename(con, baseProfile);
				selectedProfile = com.hp.ov.activator.crmportal.bean.Profile.findByQosprofilename(con,selectedProfileName);
			}
			
			policyMappings = policyMappings == null ? new com.hp.ov.activator.crmportal.bean.PolicyMapping[0]: policyMappings;

		   
			for (int i = 0; i < policyMappings.length; i++) 
			{
				com.hp.ov.activator.crmportal.bean.PolicyMapping policyMapping = policyMappings[i];
				policyMap.put(policyMapping.getPosition(), policyMapping);
			
				int position = Integer.parseInt(policyMapping.getPosition());
				
				if(position > maximumPosition)
					maximumPosition = position;
			}
		}
	}		
    catch (Exception e) 
	{ 
		e.printStackTrace();
		%>
		<script>
		alert('<bean:message key="err.qos" /><%= e.getMessage () %>.');
		location.href = '<%=failureLink%>';
		</script>
		<%
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
	
%>
 
<tr height="30">
  <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.multi.RL" /></b></td>
  <td align=left class="list<%= (rowCounter % 2) %>">
  <select name="SP_CAR" onChange="setAbsolutRL();">
<%  if (rateLimits != null) 
	{
		rateLimits = rateLimits != null ? rateLimits : new com.hp.ov.activator.crmportal.bean.CAR[0];
		
		for (int i=0; i < rateLimits.length; i++) 
		{
			%>
				<option <%= rateLimits[i].getRatelimitname().equals (selectedCAR) ? " selected": "" %> value="<%=  rateLimits[i].getRatelimitname() %>"><%= rateLimits[i].getRatelimitname() %></option>
		    <%
	   }
  }
%>
  </select>
</td>
 <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
</tr>
   <% rowCounter++; %>


  <!--------------------------PROFILE---------------------------------->
   	<script LANGUAGE="JavaScript" TYPE="text/javascript">

    var oldProfileName = "";
<%
     if (!("".equals(selectedProfileName)))
	 {
        // that means that custom percents were selected and they must be selected again
         if(!(selectedProfileName.equals(baseProfile)))
		{
%>
            oldProfileName = "<%=selectedProfileName%>";
<%      }
    }
%>
       setAbsolutRL();
/**
  Function counts percents the sum of all percents and reduces last combobox value for sum to be qual 100%
  If even with last combobox = 0 the sum is greater then 100 it reduces edited (id) combobox value for sum to be equal 100
*/
    function countPercents(id)
		{

      var sum = 0;
<%    for (int i = 0; i < expMappings.length; i++) {
        com.hp.ov.activator.crmportal.bean.EXPMapping expMapping = expMappings[i];
%>
        box = this.document.getElementById('QOS_CLASS_<%=expMapping.getPosition()%>_PERCENT');
        sum = sum + parseInt(box.value);
<%   }%>
      var lastBox = document.getElementById('QOS_CLASS_<%=maximumPosition%>_PERCENT');
      var reminder = sum - parseInt(lastBox.value);

      if(sum <= 100 || reminder <=100){
        document.getElementById("optC<%=maximumPosition%>P"+(100 - reminder)).selected = true;
      }else{
         var editedBox = document.getElementById("QOS_CLASS_"+id + "_PERCENT");
         var editedValue = parseInt(editedBox.value);
         editedValue = editedValue - (reminder - 100);
		document.getElementById("optC" + id + "P" + editedValue).selected = true;
         document.getElementById("optC<%=maximumPosition%>P0").selected = true;
      }
    }
/**
    changes the name for the profile when the percents are adjusted
*/
    function changeName(){
        var newName = generateName();
		
        var profileCombo = document.getElementById("ProfileName");
		
        if(oldProfileName != ""){
            //remove old entry
            profileCombo.options[profileCombo.options.length-1] = null;
        }
        oldProfileName = newName;
        var newOption = new Option(newName, newName);
        newOption.selected="true";
        profileCombo.options[profileCombo.options.length] = newOption;
    }

    //check for duplicate in qos profile combo box

    function checkduplicate(){
    	var profileCombo = document.getElementById("ProfileName");
		for(var i = 0; i < profileCombo.options.length; i++) {
	       for(var j = 0; j < profileCombo.options.length; j++) {
	            if( j != i && profileCombo.options[i].value == profileCombo.options[j].value) {
	                  profileCombo.options[i] = null;
	            }
	       }
	   	}
    }

/**
    display absoult ratelimit 
*/
    function setAbsolutRL(){

	 var ratelimitStr = this.document.ServiceForm.SP_CAR.value;   
     
      var len = 0;
      len = ratelimitStr.length;
			var rtValue = 0
      rtValue = parseInt(ratelimitStr);
      var rtunit = ratelimitStr.substr(len-1,1);
<%    for (int i = 0; i < expMappings.length; i++) {
        com.hp.ov.activator.crmportal.bean.EXPMapping expMapping = expMappings[i];
%>
  			var percent = 0;
				var runit2 = rtunit; 
  			box = this.document.getElementById('QOS_CLASS_<%=expMapping.getPosition()%>_PERCENT');
        if (box != null){ 
        	percent = parseInt(box.value);
        }
        var absoultRL = 0;
        absoultRL = percent * rtValue/100;
        if(absoultRL <1 && rtunit == "M"){
       		 	absoultRL = absoultRL * 1024;	
       		 	rtunit2="K";  
       }else
       	{
       		rtunit2=rtunit; 
      }
       absoultRL= Math.round(absoultRL);
        var absoultRLStr= absoultRL.toString().concat(rtunit2,"bps")
        //alert("===absoultRLStr is:"+absoultRLStr+"===");
        var RT = this.document.getElementById('QOS_CLASS_<%=expMapping.getPosition()%>_RL');
        if(RT != null){
       			RT.setAttribute("value",absoultRLStr);
     		}
<% }%>
     
}  

function showMenu(val,id)
{
	alert("inside showmenu"+val+ "iddd"+id);
	//document.getElementById(id).disabled = val;

}

/**
  Name generation algorithm
  <Prefix>_<percent0>.<percent1>.<percent2>.<percent3>
*/
    function generateName(){
      //var name = "";
      var name = document.getElementById("prefix").value;
	  var addFam = "";
	  var servType = '<%=servType%>';
	  if(servType.indexOf("layer3") > -1){
		addFam = '<%= addFam%>';
	  }
	  
<%
  for (int i = 0; i < expMappings.length; i++) {
    com.hp.ov.activator.crmportal.bean.EXPMapping expMapping = expMappings[i];
%>
        box = this.document.getElementById('QOS_CLASS_<%=expMapping.getPosition()%>_PERCENT');
<%     if(i != 0){
        %>name = name + ".";<%
       }else{
        %>name = name + "_";<%
       }%>
        name = name + parseInt(box.value);
<%
  }
%>	
	if (addFam == "IPv6"){
		return (name+"_v6");
	}else{
		return name;
	}
        
    }

    function init()
		
		{
<%
        // this means that custom percents were selected and they must be selected again
          if( !("".equals(selectedProfileName)))
		{
	    
         if(!(selectedProfileName.equals(baseProfile)))
			 {
            
				for(int i = 0; i < policyMappings.length; i++)
				{
					final String paramName = "SP_QOS_CLASS_"+policyMappings[i].getPosition()+"_PERCENT";
					String percent = request.getParameter(paramName);
					if(percent == null) percent = (String) request.getAttribute(paramName);
					%>
						document.getElementById("optC<%=policyMappings[i].getPosition()%>P<%=percent%>").selected = true;
			
				<%} //for
          } //inner if
    }//outer if
%>
      
    }

	
</script>
   
   
  <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align="left" class="list<%= (rowCounter % 2) %>">
	  <b><bean:message key="label.qosprofile" /></b></td>
      <td align="left" class="list<%= (rowCounter % 2) %>">
      <select id="ProfileName" name="SP_QOS_PROFILE" width="50%"
 onChange="document.getElementById('BaseProfile').value='';location.href = <%= link_part1 %>;setAbsolutRL();">

<%  
	
	if (allProfiles != null) 
     {
        for (int i = 0; i < allProfiles.size(); i++)
			{
		    com.hp.ov.activator.crmportal.bean.Profile profile = (com.hp.ov.activator.crmportal.bean.Profile)allProfiles.get(i);
		
			compliantMapping.put(profile.getQosprofilename(),profile.getCompliant());
			
%>
          <option <%= profile.getQosprofilename().equals (baseProfile) ? " selected" : "" %>
		  value="<%= profile.getQosprofilename() %>"><%= profile.getQosprofilename() %>
		  </option>
<%      
	  }
     }
	 
     if((!("".equals(selectedProfileName))) && (!("".equals(baseProfile))) && (!(selectedProfileName.equals(baseProfile))))
		 {
			
%>
     <option selected value="<%= selectedProfileName %>"><%= selectedProfileName %></option>
<%
    
}
%>
      </select>
	   </td>


	
	<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  </tr>
  <input type="hidden" id="prefix" name="SP_QOS_PREFIX" value="<%= selectedProfile != null ? selectedProfile.getPrefix(): "" %>">
  <input type="hidden" id="BaseProfile" name="SP_QOS_BASE_PROFILE" value="<%= baseProfile != null ? baseProfile : "" %>">



  <% rowCounter++; %>
  <%
	  for(int classIndex = 0; classIndex < expMappings.length; classIndex++){
          com.hp.ov.activator.crmportal.bean.EXPMapping expMapping = expMappings[classIndex];
          com.hp.ov.activator.crmportal.bean.PolicyMapping policyMapping = (com.hp.ov.activator.crmportal.bean.PolicyMapping) policyMap.get(expMapping.getPosition());

	 
	  if(policyMapping != null){
//		final boolean isDisabled = policyMapping.getPosition().equals(String.valueOf(maximumPosition));
		
  %>
    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align="left" class="list<%= (rowCounter % 2) %>">&nbsp;&nbsp;&nbsp;&nbsp;<b><%=expMapping.getClassname()%></b></td>
      <td align="left" class="list<%= (rowCounter % 2) %>">
      <table cellpadding="0" cellspacing="0" width="100%"> 
      <tr>
      <td align="left" width="50%" class="list<%= (rowCounter % 2) %>"><%=policyMapping != null ? policyMapping.getTclassname() : ""%>
    </td>
    <td class="list<%= (rowCounter % 2) %>" align="left">
<%
	String valTest =(String)compliantMapping.get(policyMapping.getProfilename());
		
			%>


		
	<select id="QOS_CLASS_<%=expMapping.getPosition()%>_PERCENT" name="SP_QOS_CLASS_<%=expMapping.getPosition()%>_PERCENT"
    onChange="countPercents('<%=expMapping.getPosition()%>');changeName();checkduplicate();setAbsolutRL();">	
	
<%    
	
	for (int percentIndex = 0; percentIndex <= 100; percentIndex+=1) { %>
          <option id="optC<%=expMapping.getPosition()%>P<%=percentIndex%>" value="<%=percentIndex%>"
                <%=policyMapping.getPercentage().equals(String.valueOf(percentIndex)) ? "selected" : ""%>>
                <%=percentIndex%>
          </option>
<%    }%>
        </select>
    </td>
    
    <td   class="list<%= (rowCounter % 2)  %>" align=left width="54%">&nbsp;&nbsp;
     	<input type=text id="QOS_CLASS_<%=expMapping.getPosition()%>_RL" name="SP_QOS_CLASS_<%=expMapping.getPosition()%>_RL" readonly="readonly"  size="10">
    </td>
    
    </tr>
    </table>
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  </tr>
  <%    rowCounter++;
	  }else{
  %>
	<input type="hidden" id="QOS_CLASS_<%=expMapping.getPosition()%>_PERCENT" name="SP_QOS_CLASS_<%=expMapping.getPosition()%>_PERCENT" value="0">
  <input type="hidden" id="QOS_CLASS_<%=expMapping.getPosition()%>_RL" name="SP_QOS_CLASS_<%=expMapping.getPosition()%>_RL" value="0">
  
  <%
	  }
      }
	 %>
	 <tr height="30">
		<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
		<td class="list<%= (rowCounter % 2) %>" align=left><b><bean:message key="label.qosprofilechild" /></b></td>
		<td class="list<%= (rowCounter % 2) %>" align=left>
		  <select  name="SP_QoSChildEnabled" onChange="location.href = <%= link_part1 %>;">
		   
				<option <%= SP_QoSChildEnabled.equals("false") ? " selected": "" %> value="false">No</option>
				<option <%= SP_QoSChildEnabled.equals("true") ? " selected": "" %> value="true">Yes</option>
		   
		  </select>
		
		</td>
		<td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
  </tr>
  <script>
    init();
    setAbsolutRL();
  </script>