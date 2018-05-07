<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- -*- html -*- --%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>

<%@page info="add static routes" contentType="text/html;charset=UTF-8" language="java" 
  import="com.hp.ov.activator.crmportal.action.*, java.sql.*, com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*, java.text.*, java.net.*" %>


<%

  //load param parameters got here
   ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
   HashMap serviceParameters = new HashMap ();
   serviceParameters = (HashMap)request.getAttribute("serviceParameters");
   HashMap parentServiceParameters = new HashMap ();
   parentServiceParameters = (HashMap)request.getAttribute("parentServiceParameters");
   String serviceid = serviceForm.getServiceid();
   String parentserviceid = serviceForm.getParentserviceid();
   String customerid = serviceForm.getCustomerid();

  int rowCounter;
 
  
  // String including all static routes both existing and new routes.
  String allRoutes = (String)request.getAttribute("allRoutes");
  String removeflag = (String)request.getAttribute("removeflag");
  String addressFamily = (String)request.getAttribute("AddressFamily");
  if(removeflag==null) 
	removeflag ="N";
 
 String SelfLoad =  (String)request.getAttribute("SelfLoad");  //richa - 12083

  int staticCounter = 1;
  
  StaticRoute aroutes[] = (StaticRoute[])request.getAttribute("routes");

  if(request.getAttribute("staticCounter") == null)
   { 
	%>
       <input type="hidden" name="staticCounter" value="1">
<%  
      
	}
   else
    {
        staticCounter = Integer.parseInt((String)request.getAttribute("staticCounter"));
	
%>
       <input type="hidden" name="staticCounter" value="<%= staticCounter %>">
<%   
	}

 //System.out.println("JSP --- staticCounter >>>>>>>>>>>>>>>>>>>>>"+staticCounter);
  try 
  {
    rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
  } catch (Exception e)
  {
    rowCounter = 0;
  } 
  
%>
  <input type="hidden" name="empty" value="">

<%  

  

  String link_part1 = "'/crm/ModifyService.do?type=layer3-Attachment&action=AddStaticRoutes&serviceid="+serviceid+"&customerid="+
                        customerid +"&parentserviceid="+
                        parentserviceid;
  String link_part2 = "&empty='+ServiceForm.empty.value";

  //System.out.println("JSP --- existingStaticRoutes >>>>>>>>>>>>>>>>>>>>>"+existingStaticRoutes);



 if (aroutes != null) 
	 {
%>
    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.static.routes" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.route" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.mask" /></b></td>
    </tr>
    <% rowCounter++; %>

<%  
	
   } %>
   
   <% 
				  if (aroutes != null) 
				   {
					
					for (int i = 0; i < aroutes.length; i++) 	{
						String address=aroutes[i].getStaticrouteaddress();
						StringTokenizer routeElements = new StringTokenizer(address, "/");
						String route = routeElements.nextToken();
						String mask = routeElements.nextToken();
						%>
						<tr height="30">
						 <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
						 <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
						 <td align=left class="list<%= (rowCounter % 2) %>"><%= route %> </td>
						 <td align=left class="list<%= (rowCounter % 2) %>"><%= mask %> </td>
					   </tr>
					<% rowCounter++; %>
					<%
					}
				   }
				   %>
   


     <tr valign="bottom" height="30">
       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
       <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.add.staticroutes" /></b></td>
       <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.route.prefix" /></b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>/<bean:message key="label.mask" /> </b> </td>
       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
     </tr>
     <% rowCounter++; %>


<%   int i = 0; %>
<%   for (; i < staticCounter; i++) 
{

	%>
       <tr valign="center" height="30">
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
<%
%>
         <td valign="middle" class="list<%= (rowCounter % 2) %>">
    <%//if (SelfLoad!= null && SelfLoad.equalsIgnoreCase("true")){%>
<%

%>
		   <input type="text" name="routes<%= i %>" size="40" value="<%= (String)request.getAttribute("routes"+i) != null ? (String)request.getAttribute("routes"+i) : "" %>"> 
	<%//} else {%>
   <!--input type="text" name="route<%= i %>" size="40" value=""--> 
	<%//}%>

         <input type="text" name="masks<%= i %>" size="3" value="<%= (String)request.getAttribute("masks"+i) != null ? (String)request.getAttribute("masks"+i) : "" %>">
       </td>
       <td class="list<%= (rowCounter % 2) %>">
       </tr>
       <% rowCounter++; %>
<%   }%>
       <tr height="30">
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
         <td class="list<%= (rowCounter % 2) %>">

<%
        String removeEntryLink = link_part2;
        for(int k = 0; k < staticCounter; k++){
            link_part2 += "+'&routes" + k + "=' + ServiceForm.routes" + k + ".value";
            link_part2 += "+'&masks" + k + "=' + ServiceForm.masks" + k + ".value";
		   if(k < staticCounter - 1)
			   removeEntryLink = link_part2;
		}
		link_part2 += "+'&staticCounter=" + staticCounter+'\'';
		removeEntryLink +="+'&remove=Y'";
        removeEntryLink += "+'&staticCounter=" + (staticCounter - 1)+'\'';

%>
           <a href="#" class="list<%= (rowCounter % 2) %>" onClick="javascript:checkAll();">
		   <bean:message key="label.incl.entry" /></a>
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
            if(staticCounter > 1){
%>
           <a href="#" class="list<%= (rowCounter % 2) %>" onClick="location.href = <%= link_part1+removeEntryLink%>+'&allRoutes=<%= allRoutes %>'+'&SelfLoad=true'"><bean:message key="label.rem.last" /></a>
<%
            }
%>
         </td>
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
       </tr>
       <% rowCounter++;%>
       <input type="hidden" name="SP_STATIC_Routes" value="<%= allRoutes %>">

		<script LANGUAGE="JavaScript" TYPE="text/javascript">
           function checkAll(){
			var submitted = true;
         	 if(submitted)
			 {
        		var check =checkStaticRoutes();
				if(!check){
				  submitted = false;
				}              
            }
		      if(submitted){
        	location.href = <%=link_part1+link_part2%>+'&allRoutes=<%= allRoutes %>'+ "&SelfLoad=true"
			}
	     }
		 function checkStaticRoutes(){
			
			var staticcount ='<%=staticCounter%>';
         	for(ii=0;ii<staticcount;ii++)
            {
				if(getObjectById('routes'+ii).value.length==0 || getObjectById('masks'+ii).value.length==0) 
				{
					alert('<bean:message key="js.static.route" />'+' '+'<bean:message key="js.Row.number" />'+(ii+1)+' '+'<bean:message key="js.static.null" />');
					var subButton = document.getElementById('submitButtonId');
					subButton.style.visibility="visible";
					return false;
				}
			}
		    return true;
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
        return document.getElementById(Id);
	} else {
		return document.ServiceForm.elements[Id];
        //if(document.getElementById(Id)!==null){
		//	return document.getElementById(Id);
		//} else {
         //   return document.getElementsByName(Id);
		//}
	}
}

</script>

