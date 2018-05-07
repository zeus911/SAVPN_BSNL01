<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->

<%
MemoryTypes[] memoryTypes = null;
String memoryType = request.getParameter ("memory");
com.hp.ov.activator.cr.inventory.NetworkElement router = (com.hp.ov.activator.cr.inventory.NetworkElement) com.hp.ov.activator.cr.inventory.NetworkElement.findByNetworkelementid(connection, networkElementID);
String restore = (String)request.getAttribute("restore");
String backup = (String)request.getAttribute("backup");


if(router != null)
{
	String osversion = router.getOsversion();
	
	OSVersion OSversion=  OSVersion.findByPrimaryKey(connection, osversion);
	ElementType elementtype=  ElementType.findByPrimaryKey(connection, router.getElementtype());
	memoryTypes = MemoryTypes.findByOstype(connection,OSversion.getOsversiongroup(), elementtype.getElementtypegroupname());
	
}

boolean memoryTypesFound = (memoryTypes != null) && (memoryTypes.length != 0) ;

if(!memoryTypesFound){
%>  <div name="memory" id="memory">
No memory types found for this element type and OS version.
Please update in inventory Parameters -> Backup parameters
 </div>
<% }else { %>

    <select class="tableCell" name="memory" id="memory">
 
    <%
	
    if(restore != null && restore.equalsIgnoreCase("true")){
       for(int i = 0; i < memoryTypes.length; i++){
         if(!memoryTypes[i].getTargettype().equalsIgnoreCase("running")){

%>
            <option <%= (memoryType == null) ? "" : (memoryType.equals (memoryTypes[i].getMemorytype())?"selected" : "")%> value="<%= memoryTypes[i].getMemorytype() %>"><%= memoryTypes[i].getMemorytype().toLowerCase() %></option>
          <%}
      } %>

    </select>
<%	} else if(router.getOsversion().equalsIgnoreCase("CiscoXR")) {	 
		if(backup != null && backup.equalsIgnoreCase("true")){			
		%>backup<%
			for(int i = 0; i < memoryTypes.length; i++){		 
				 %>
                <option <%= (memoryType == null) ? "" : (memoryType.equals (memoryTypes[i].getMemorytype())?"selected" : "")%> value="<%= memoryTypes[i].getMemorytype() %>"><%= memoryTypes[i].getMemorytype().toLowerCase() %></option>
			<% 
		}
		}
		else{
				%>else<%
			for(int i = 0; i < memoryTypes.length; i++){			
				 if( !memoryTypes[i].getTargettype().equalsIgnoreCase("startup")){
					 %>
					<option <%= (memoryType == null) ? "" : (memoryType.equals (memoryTypes[i].getMemorytype())?"selected" : "")%> value="<%= memoryTypes[i].getMemorytype() %>"><%= memoryTypes[i].getMemorytype().toLowerCase() %></option>
				<% }
			}
		}%>

		</select>

	<%      

	} else{
            for(int i = 0; i < memoryTypes.length; i++){	

		%>
                <option <%= (memoryType == null) ? "" : (memoryType.equals (memoryTypes[i].getMemorytype())?"selected" : "")%> value="<%= memoryTypes[i].getMemorytype() %>"><%= memoryTypes[i].getMemorytype().toLowerCase() %></option>
        <% } %>

    </select>

<%      }
    } %>