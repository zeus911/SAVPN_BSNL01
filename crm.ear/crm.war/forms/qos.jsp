<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>

<%@ page import="com.hp.ov.activator.crmportal.utils.*,com.hp.ov.activator.crmportal.utils.DatabasePool,java.sql.Connection"%>

<%
	String servType = serviceForm.getType();
	
	String addFam = (String)request.getAttribute("AddressFamily");
     Profile[] profiles;
	 Profile[] publicprofiles;
     EXPMapping[] expMappings = null;
     PolicyMapping[] policyMappings = null;
    java.util.Hashtable policyMap = new java.util.Hashtable();
	java.util.HashMap   complaintMapping = new java.util.HashMap();
    java.util.ArrayList allProfiles = new java.util.ArrayList();
    String selectedProfileName = null;
       selectedProfileName =    (String) request.getAttribute("SP_QOS_PROFILE");
    String  parentProfileName =  null;
        parentProfileName = (String)parentServiceParameters.get("QOS_PROFILE");

	
     if(request.getAttribute("QOS_PROFILE") == null)
        parentProfileName = null;
    
    if(request.getAttribute("SP_QOS_PROFILE") == null)
        selectedProfileName = null;

    String baseProfile = (String) request.getAttribute("SP_QOS_BASE_PROFILE");
	if(request.getAttribute("SP_QOS_BASE_PROFILE") == null)
        baseProfile = null;
 
    Profile selectedProfile = null;
    int maximumPosition = 0;
	boolean message = false;

    try {
       
        expMappings = ( EXPMapping[])request.getAttribute("expMappings");

//complaintMapping.put(profile.getQosprofilename(),profile.getCompliant());
		//if(profile.getCompliant().equalsIgnoreCase(Constants.COMPLAINT))

        // getting customer profiles

        profiles = (Profile[])request.getAttribute("profiles");
        if(profiles != null)
		{
            for (int i = 0; i < profiles.length; i++)
			{
				//allProfiles.add(profiles[i]);
               //Added by Divya
				Profile profileObj = (Profile)profiles[i];
				if(profileObj.getCompliant().equalsIgnoreCase(Constants.COMPLAINT))
				{	
					allProfiles.add(profiles[i]);
				}
				else
				{
						message = true;
					if(selectedProfileName != null && profileObj.getQosprofilename().equalsIgnoreCase(selectedProfileName))
					{
						selectedProfileName = null;
						baseProfile = null;
					}
				
				}
				// ends here
			}
        }
        
        // getting public profiles
        publicprofiles = (Profile[])request.getAttribute("publicprofiles");
        if(publicprofiles != null)
		{
            for (int i = 0; i < publicprofiles.length; i++)
			{
				// allProfiles.add(publicprofiles[i]);
				 //Added by Divya
				 Profile publicProfileObj = (Profile)publicprofiles[i];
				if(publicProfileObj.getCompliant().equalsIgnoreCase(Constants.COMPLAINT))
				{	
					allProfiles.add(publicprofiles[i]);
				}
				else
				{
					message = true;
					if( selectedProfileName != null && publicProfileObj.getQosprofilename().equalsIgnoreCase(selectedProfileName))
					{
						selectedProfileName = null;
						baseProfile = null;
					}
				
				}
				// ends here
			}
        }


      // this is a hack done to handle "Uknown" Qos Profile 
	  // need to find a better way of handling if the current profile is non compliant one. 
	   if(selectedProfileName != null && selectedProfileName.equalsIgnoreCase("Unknown")){
		selectedProfileName =null;
		baseProfile = null;
	   
	   }


        if(allProfiles.size() == 0)
            throw new Exception("There are no profiles in inventory");

         //  if there wasn't ANY BASE profile then it's the selected profile
        if(baseProfile == null || baseProfile.equals(""))
		{
            if(selectedProfileName==null  || selectedProfileName.equals(""))
			{

			   selectedProfileName = ((Profile) allProfiles.get(0)).getQosprofilename();
			   selectedProfile = (Profile) allProfiles.get(0);
		       baseProfile = selectedProfileName;
			}
            baseProfile = selectedProfileName;
			 
        }

	
		selectedProfile = (Profile)request.getAttribute("selectedProfile");
        if(selectedProfile == null && parentProfileName != null)
		{
		
         // selectedProfile = Profile.findByQosprofilename(dbConnection, parentProfileName);
		  baseProfile = selectedProfile.getQosprofilename();
          selectedProfileName = baseProfile;
        }
        
		if(selectedProfile == null)
		{
            selectedProfile = (Profile) allProfiles.get(0);
            baseProfile = selectedProfile.getQosprofilename();
            selectedProfileName = baseProfile;
		   
        }

        policyMappings = (PolicyMapping[])request.getAttribute("policyMappings");

		//Modified by Jimmi
		//following is hack added to fix the problem of of policy mapping not dispalyed
		// initially when the page get loaded 
		// All these Qos related logic may be moved to actions classes later 
		 DatabasePool dbp = null;
   	     Connection con = null;
		 
		 if(policyMappings == null){
			try{
		        dbp = (DatabasePool) session.getAttribute(Constants.DATABASE_POOL);
     			con = (Connection) dbp.getConnection();
				policyMappings = PolicyMapping.findByProfilename(con, baseProfile);
				selectedProfile =Profile.findByQosprofilename(con,selectedProfileName);

			}catch(Exception e){
				throw new Exception("Could not fetch policy mappings from inventory");
			}finally{
			// close the connection
		        dbp.releaseConnection(con);
			}
		}
		// modification by Ends here 

        policyMappings = policyMappings == null ? new PolicyMapping[0]: policyMappings;

	   
        for (int i = 0; i < policyMappings.length; i++) {
            PolicyMapping policyMapping = policyMappings[i];
            policyMap.put(policyMapping.getPosition(), policyMapping);
	    final int position = Integer.parseInt(policyMapping.getPosition());
	    if(position > maximumPosition)
		    maximumPosition = position;
        }

      
    } catch (Throwable e) {
        e.printStackTrace();

%>
      <B><bean:message key="err.qos" /></B>: <%= e.getMessage () %>.
<%    return;
    } 

%>

   <!--------------------------PROFILE---------------------------------->
   	<script LANGUAGE="JavaScript" TYPE="text/javascript">

    var oldProfileName = "";
<%
     if(selectedProfileName != null)
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
        EXPMapping expMapping = expMappings[i];
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
        EXPMapping expMapping = expMappings[i];
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
    EXPMapping expMapping = expMappings[i];
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
          if( selectedProfileName != null)
	{
	     //String percent1 = request.getParameter("SP_QOS_CLASS_0_PERCENT");
	     //System.out.println("1111111 percent is: "+percent1);
         if(!(selectedProfileName.equals(baseProfile)))
			 {
            for(int i = 0; i < policyMappings.length; i++)
				{
              final String paramName = "SP_QOS_CLASS_"+policyMappings[i].getPosition()+"_PERCENT";
              String percent = request.getParameter(paramName);
                if(percent == null) percent = (String) request.getAttribute(paramName);
%>
            document.getElementById("optC<%=policyMappings[i].getPosition()%>P<%=percent%>").selected = true;
            
 <%             } //for
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
 onChange="document.getElementById('BaseProfile').value='';location.href = <%= link_part1 + link_part2 %>;setAbsolutRL();">

<%  
	
	if (allProfiles != null) 
     {
        for (int i = 0; i < allProfiles.size(); i++)
			{
		    Profile profile = (Profile)allProfiles.get(i);
		
			complaintMapping.put(profile.getQosprofilename(),profile.getCompliant());
		//commented ny Divya
		//if(profile.getCompliant().equalsIgnoreCase(Constants.COMPLAINT))
			//{
			
%>
          <option <%= profile.getQosprofilename().equals (baseProfile) ? " selected" : "" %>
		  value="<%= profile.getQosprofilename() %>"><%= profile.getQosprofilename() %>
		  </option>
<%      //}
	  }
     }
     if(selectedProfileName != null && baseProfile != null && (!(selectedProfileName.equals(baseProfile))))
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
          EXPMapping expMapping = expMappings[classIndex];
          PolicyMapping policyMapping = (PolicyMapping) policyMap.get(expMapping.getPosition());

	 
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
	String valTest =(String)complaintMapping.get(policyMapping.getProfilename());
		
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
  <script>
    init();
    setAbsolutRL();
  </script>

