<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>
                                                                        
<%-- ************************************************************** --%>
<%--                                                                --%>
<%-- ShowCustomerSearchResult.jsp                                   --%>
<%--                                                                --%>
<%-- Parameters:                                                    --%>
<%--  (The parameters are sent by SearchCustomer.jsp)               --%>
<%--                                                                --%>
<%-- Description:                                                   --%>
<%--  It displays the customers who match with the data sent by     --%>
<%--  SearchCustomer.jsp, if no parameters are present all the      --%>
<%--  customers will be displayed.                                  --%>
<%--                                                                --%>
<%-- ************************************************************** --%>

 
<%@page contentType="text/html;charset=UTF-8" language="java"
		info="Show the customers founds during search"
        import=" java.util.*, java.io.*,com.hp.ov.activator.crmportal.action.CustomerForm,com.hp.ov.activator.crmportal.utils.*,
		com.hp.ov.activator.crmportal.helpers.*" %>

  <%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
  <%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>



<!--<%@ include file="../jsp/CheckSession.jsp" %>-->

<%
  response.setDateHeader("Expires",0);
  response.setHeader("Pragma","no-cache");
%>

<html:html locale="true">
  <head>
   
    <link rel="stylesheet" type="text/css" href="css/activator.css">
    <link rel="stylesheet" type="text/css" href="css/awfweb2.css">
	<META Http-Equiv="Cache-Control" Content="no-cache">
    <META Http-Equiv="Pragma" Content="no-cache">
    <META Http-Equiv="Expires" Content="0">
   
	<script LANGUAGE="JavaScript" TYPE="text/javascript">

  

  <!--
    function deleteCustomer(id)
    {
      var conf1 = confirm('Do you wish to continue and delete the customer and all its associated services?');
      var page = "DeleteCustomer.jsp?customerid=" + id + "&soft=false";
      if (conf1 == true) {
        var conf2 = confirm('Do you wish to continue and remove all associated services?');
        if (conf2 == true) {
          self.location.href = page;
        }
      }
    }

	function softdeleteCustomer(customerid)
    {
      var conf1 = confirm('Do you wish to continue and deactivate the customer?');
      var page = "DeleteCustomer.jsp?customerid=" + customerid + "&soft=true";
        if (conf1 == true)
        {
          self.location.href = page;
        }
    }

	function deactivateCustomer(customerid)
    {
      var conf1 = confirm('Do you wish to continue and delete the customer?');
      var page = "DeleteCustomer.jsp?customerid=" + customerid + "&soft=true&deactivate=true";
        if (conf1 == true)
        {
          self.location.href = page;
        }
    }
  -->
    </script>
  </head>

<body>
     <%
 
	 ArrayList customers = ( ArrayList)request.getAttribute("CRM_customers_searchresult");
     CustomerForm customerForm =  null;
      HashSet roles = (HashSet) session.getAttribute(Constants.ROLES_KEY);
      boolean isOperator = false;
      //System.out.println("roles :::::::"+roles);
      if(roles.contains(Constants.ROLE_OPERATOR)) {isOperator = true;}
     %>

   <h2 class="mainSubHeading"><center><bean:message key="title.search.results" /></center></h2>
   <br><font color="red">
   <html:errors/>
   </font></br>

     <html:form  action="/EditCustomerfromSearch">
     <html:hidden  property="actionflag" value="fromsearch" name="flag"/>
	 <html:hidden  property="soft" value="true" name="soft"/>
	 <html:hidden  property="deactivate" value="" name="deactivate"/>

     <center>
       
	     <table align="center" width="100%" border=0 cellpadding=2 cellspacing=1>
         <tr>
<%         if (customers != null && customers.size() == 1) { %>
             <td class="title" colspan="6" align="left">
			 <bean:message key="msg.one.customer" /></td>
<%         } %>

<%         if (customers != null && customers.size() > 1) { %>
             <td class="title" colspan="6" align="left">(<%= customers.size() %>) <bean:message key="msg.cust.found" /></td>
<%         } %>

<%         if (customers == null || customers.size() == 0) { %>
            <td class="title" colspan="6" align="left">
			<bean:message key="msg.no.customer" /></td>
<%         } %>
         </tr>
         <tr>
           <th class="center"><bean:message key="label.customer.id" /></th>
           <th class="center"><bean:message key="label.company.name" /></th>
           <th class="center"><bean:message key="label.contactperson" /></th>
           <th class="center"><bean:message key="label.phone.number" /></th>
           <th class="center"><bean:message key="label.services" />&nbsp;</th>
           <th class="center">&nbsp;<bean:message key="label.actions" />&nbsp;</th>
         </tr>

<%   if (customers == null)
	{
		%>
        <tr>
            <td class="list0" colspan=6 align="center">
              &nbsp;<br>
              <h3><bean:message key="msg.no.cust.found" /><br></h3>
              &nbsp;<br>
            </td>
        </tr>
     </table>
<%   } 
     else
		 {
           HashMap params = new HashMap();
		   params.put("actionflag","fromsearch");
       for (int i=0; i<customers.size(); i++) 
        { 
		     customerForm = (CustomerForm) customers.get( i );
		      
 %>
           <tr  align="left" align="middle">
		    <html:hidden  property="customerid" value="<%= customerForm.getCustomerid()%>"/>

           <td class="list<%= i % 2 %>" valign="middle" align="center">
		        <%
                 params.put("customerid",customerForm.getCustomerid());
		         pageContext.setAttribute("paramsMap", params);

			   %>

			   <% 
			     String mv = null;
            	 HashMap  listparams = new HashMap();
                 listparams.put("customerid",customerForm.getCustomerid());
                 listparams.put("mv",mv);
				 listparams.put("doResetReload","true");
		         pageContext.setAttribute("listparamsMap", listparams);


			%>
			<html:link page="/EditCustomerfromSearch.do" name="paramsMap" scope="page" >
	          <%= customerForm.getCustomerid() %>
	        </html:link>
		   </td>
		
           <td class="list<%= i % 2 %>" valign="middle">
		   <%= customerForm.getCompanyname() != null ? Utils.escapeXml(customerForm.getCompanyname()) : "" %>
		   </td>
           <td class="list<%= i % 2 %>" valign="middle">
		   <%= customerForm.getContactpersonname() == null ? "" : Utils.escapeXml(customerForm.getContactpersonname()) %> 
		   <%= customerForm.getContactpersonsurname() == null ? "" : Utils.escapeXml(customerForm.getContactpersonsurname()) %>
		   </td>
           <td class="list<%= i % 2 %>" valign="middle">
		   <%= customerForm.getContactpersonphonenumber() != null ? Utils.escapeXml(customerForm.getContactpersonphonenumber()) : "" %></td>
           <td class="list<%= i % 2 %>" align="center" valign="middle">
        &nbsp;
        &nbsp;
       <%  if (!customerForm.getStatus().equalsIgnoreCase("deleted"))
	         {
		   %>
               <html:link page="/ListAllServices.do" name="listparamsMap" scope="page" >
	            <html:img page="/images/Services.gif" border="0" title="Show service" align="center"/>
	           </html:link>

       <%
	         }%>
           </td>
      <td class="list<%= i % 2 %>" align="center" valign="middle">
   <%

		   if(isOperator) {
   %>
       
			   <html:link page="/EditCustomerfromSearch.do" name="paramsMap" scope="page">
	           <html:img page="/images/Update.gif" border="0" title="Modify customer"/>
	           </html:link>
		
        <%  
		 	 HashMap deleteParams = new HashMap();
		     deleteParams.put("soft","true");
		     deleteParams.put("customerid",customerForm.getCustomerid());
		   

		if (!customerForm.getStatus().equalsIgnoreCase("deleted"))
	         {
                deleteParams.put("deactivate","true");
	            pageContext.setAttribute("deleteparamsMap", deleteParams);
	    %>
        &nbsp;
          
			<html:link page="/DeleteCustomerfromSearch.do" name="deleteparamsMap" scope="page" >
	        <html:img page="/images/DeleteCustomer.gif" border="0" title="Delete customer"/>
	        </html:link>
    

        <%
			}
		     else
			{
			  pageContext.setAttribute("deleteparamsMap", deleteParams);
		%>
        &nbsp;
           
			<html:link page="/DeleteCustomerfromSearch.do" name="deleteparamsMap" scope="page" >
	        <html:img page="/images/DeleteCustomer.gif" border="0" title="Delete customer"/>
	        </html:link>

         <%    } 
	
	    }
	
	%>
            </td>
          </tr>

    <%   }// for 
	
	%>
       
	</table>
    <% }// else

    %>
   </center>
  
 </html:form>
  </body>
</html:html>


