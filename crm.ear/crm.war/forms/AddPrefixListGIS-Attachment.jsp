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

<%@page info="add prefix list" contentType="text/html;charset=UTF-8" language="java" 
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
  String existingPrefixList = (String)serviceParameters.get("PREFIX_Routes");
  
  // String including all static routes both existing and new routes.
  String allRoutes = (String)request.getAttribute("allRoutes");
  String removeflag = (String)request.getAttribute("removeflag");
  String addressFamily = (String)request.getAttribute("AddressFamily");
  if(removeflag==null) 
	removeflag ="N";
 
 String SelfLoad =  (String)request.getAttribute("SelfLoad");  //richa - 12083

  int prefixCounter = 1;

  if(request.getAttribute("prefixCounter") == null)
   { 
	%>
       <input type="hidden" name="prefixCounter" value="1">
<%  
      
	}
   else
    {
	   prefixCounter = Integer.parseInt((String)request.getAttribute("prefixCounter"));
	
%>
       <input type="hidden" name="prefixCounter" value="<%= prefixCounter %>">
<%   
	}
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

  // If no existing services then "".
  if (existingPrefixList == null)
  {
	  existingPrefixList = "";
  }

  String link_part1 = "'/crm/ModifyService.do?type=GIS-Attachment&action=AddPrefixList&serviceid="+serviceid+"&customerid="+
                        customerid +"&parentserviceid="+
                        parentserviceid;
  String link_part2 = "&empty='+ServiceForm.empty.value";


  // Start allRoutes with the existing routes, but only the first time!
 if (allRoutes == null || allRoutes.equals("") || allRoutes.equals("null")) 
  {
    allRoutes = existingPrefixList;
  }

  //System.out.println("JSP --- allRoutes >>>>>>>>>>>>>>>>>>>>>"+allRoutes);

 if (!allRoutes.equals(""))
	 {
%>
    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.prefixlist.routes" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.ipprefix" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.l3sitemask" /></b></td>
    </tr>
    <% rowCounter++; %>

<%  	
    StringTokenizer routes = new StringTokenizer(allRoutes, ",");
    StringTokenizer routeElements = null;   
    String routeAndMask = null;
    String route = null;
    String mask = null;    
     while (routes.hasMoreTokens()) 
		 {
       routeAndMask = routes.nextToken();
       routeElements = new StringTokenizer(routeAndMask, "/");
       route = routeElements.nextToken();
        mask = routeElements.nextToken();%>
       <tr height="30">
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
         <td align=left class="list<%= (rowCounter % 2) %>"><%= route %> </td>
         <td align=left class="list<%= (rowCounter % 2) %>"><%= mask %> </td>
       </tr>
       <% rowCounter++; 
     }
   } %>

     <tr valign="bottom" height="30">
       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
       <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.add.prefixlist" /></b></td>
       <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.ipprefix" /></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>/<bean:message key="label.mask" /> </b> </td>
       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
     </tr>
     <% rowCounter++; %>


<%   int i = 0; %>
<%   for (; i < prefixCounter; i++) 
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
		   <input type="text" name="routes<%= i %>" size="25" value="<%= (String)request.getAttribute("routes"+i) != null ? (String)request.getAttribute("routes"+i) : "" %>"> 
	<%//} else {%>
  
	<%//}%>

         <input type="text" name="masks<%= i %>" size="3" value="<%= (String)request.getAttribute("masks"+i) != null ? (String)request.getAttribute("masks"+i) : "" %>">
        
         &nbsp;le &nbsp;  <input type="text" name="lemask<%=i%>" size="3"  value="<%= (String)request.getAttribute("lemask"+i) != null ? (String)request.getAttribute("lemask"+i) : "" %>">
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
        for(int k = 0; k < prefixCounter; k++){
            link_part2 += "+'&routes" + k + "=' + ServiceForm.routes" + k + ".value";
            link_part2 += "+'&masks" + k + "=' + ServiceForm.masks" + k + ".value";
            link_part2 += " + '&lemask" + k + "=' + ServiceForm.lemask" + k + ".value";
		   if(k < prefixCounter - 1)
			   removeEntryLink = link_part2;
		}
		link_part2 += "+'&prefixCounter=" + prefixCounter+'\'';
		removeEntryLink +="+'&remove=Y'";
        removeEntryLink += "+'&prefixCounter=" + (prefixCounter - 1)+'\'';

%>
           <a href="#" class="list<%= (rowCounter % 2) %>" onClick="javascript:checkAll();">
		   <bean:message key="label.incl.entry" /></a>
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
            if(prefixCounter > 1){
%>
           <a href="#" class="list<%= (rowCounter % 2) %>" onClick="location.href = <%= link_part1+removeEntryLink%>+'&allRoutes=<%= allRoutes %>'+'&SelfLoad=true'"><bean:message key="label.rem.last" /></a>
<%
            }
%>
         </td>
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
       </tr>
       <% rowCounter++;%>
       <input type="hidden" name="SP_PREFIX_Routes" value="<%= allRoutes %>">

		<script LANGUAGE="JavaScript" TYPE="text/javascript">
           function checkAll(){
			var submitted = true;
         	 if(submitted)
			 {
        		var check =checkPrefixList();
				if(!check){
				  submitted = false;
				}              
            }
		      if(submitted){
        	location.href = <%=link_part1+link_part2%>+'&allRoutes=<%= allRoutes %>'+ "&SelfLoad=true"
			}
	     }
		 function checkPrefixList(){
			
			var prefixcount ='<%=prefixCounter%>';
         	for(ii=0;ii<prefixcount;ii++)
            {
				if(getObjectById('routes'+ii).value.length==0 || getObjectById('masks'+ii).value.length==0) 
				{
					alert('<bean:message key="js.prefix.route" />'+' '+'<bean:message key="js.Row.number" />'+(ii+1)+' '+'<bean:message key="js.static.null" />');
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

