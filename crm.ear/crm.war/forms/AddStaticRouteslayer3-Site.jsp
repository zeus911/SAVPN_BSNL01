<%--##############################################################################--%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
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
  String existingStaticRoutes = (String)serviceParameters.get("STATIC_Routes");
  
  // String including all static routes both existing and new routes.
  String allRoutes = (String)request.getAttribute("allRoutes");
  Mask[] masks;
  int staticCounter = 1;

  if(request.getAttribute("staticCounter") == null)
   { 
	%>
       <input type="hidden" name="staticCounter" value="1">
<%  
}
else
{
       staticCounter = Integer.parseInt((String)request.getAttribute("staticCounter"));
       staticCounter++;
%>
       <input type="hidden" name="staticCounter" value="<%= staticCounter %>">
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
    try
	{
		masks = (Mask[])request.getAttribute("masks");
     } 
	 catch (Exception e)
 { 
%>
    <B><bean:message key="err.staticroutes" /></B>: <%= e.getMessage () %>.
<%  return;
 }

  // If no existing services then "".
  if (existingStaticRoutes == null)
  {
    existingStaticRoutes = "";
  }

  String link_part1 = "'/crm/ModifyService.do?type=layer3-Site&action=AddStaticRoutes&serviceid="+serviceid+"&customerid="+
                        customerid +"&parentserviceid="+
                        parentserviceid;
  String link_part2 = "&empty='+ServiceForm.empty.value";

  //System.out.println("JSP --- existingStaticRoutes >>>>>>>>>>>>>>>>>>>>>"+existingStaticRoutes);

  // Start allRoutes with the existing routes, but only the first time!
 if (allRoutes == null || allRoutes.equals("") || allRoutes.equals("null")) 
  {
    allRoutes = existingStaticRoutes;
  }

  //System.out.println("JSP --- allRoutes >>>>>>>>>>>>>>>>>>>>>"+allRoutes);

 if (!allRoutes.equals(""))
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
       mask = routeElements.nextToken(); %>
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
       <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.add.staticroutes" /></b></td>
       <td class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.route.prefix" /></b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>/<bean:message key="label.mask" /> </b> </td>
       <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
     </tr>
     <% rowCounter++; %>


<%   int i = 0; %>
<%   for (; i < staticCounter; i++) { %>
       <tr valign="center" height="30">
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>

         <td valign="middle" class="list<%= (rowCounter % 2) %>">
           <input type="text" name="route<%= i %>" size="15" value="<%= (String)request.getAttribute("route"+i) != null ? (String)request.getAttribute("route"+i) : "" %>"> /

         <select name="mask<%=i%>">
<%         if (masks != null) {
             for (int j = 0; j < masks.length; j++) 
				 {
                 if((String)request.getAttribute("mask"+i) != null ) 
					 {%>
                   <option <%= request.getAttribute("mask"+i) != null && request.getAttribute("mask"+i).equals(masks[j].getSlashnotation()) ? " selected" : "" %> value="<%= masks[j].getSlashnotation() %>"><%= masks[j].getSlashnotation() %></option>
<%               } else { %>
                   <option <%= request.getAttribute("mask"+(i-1)) != null && request.getAttribute("mask"+(i-1)).equals(masks[j].getSlashnotation()) ? " selected" : "" %> value="<%= masks[j].getSlashnotation() %>"><%= masks[j].getSlashnotation() %></option>
<%               } %>
<%             }
             } %>
         </select>
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
            link_part2 += "+'&route" + k + "=' + ServiceForm.route" + k + ".value";
            link_part2 += "+'&mask" + k + "=' + ServiceForm.mask" + k + ".options[ServiceForm.mask" + k + ".selectedIndex].value";
               if(k < staticCounter - 1)
                   removeEntryLink = link_part2;
           }
        link_part2 += "+'&staticCounter=" + staticCounter+'\'';
        removeEntryLink += "+'&staticCounter=" + (staticCounter - 2)+'\'';

%>
           <a href="#" class="list<%= (rowCounter % 2) %>" onClick="location.href = <%=link_part1+link_part2%>+'&allRoutes=<%= allRoutes %>'">
		   <bean:message key="label.incl.entry" /></a>
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<%
            if(staticCounter > 1){
%>
           <a href="#" class="list<%= (rowCounter % 2) %>" onClick="location.href = <%= link_part1+removeEntryLink%>+'&allRoutes=<%= allRoutes %>'"><bean:message key="label.rem.last" /></a>
<%
            }
%>
         </td>
         <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
       </tr>
       <% rowCounter++;%>
       <input type="hidden" name="SP_STATIC_Routes" value="<%= allRoutes %>">
