<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>


<%-- ************************************************************** --%>
<%--                                                                --%>
<%-- UpdateCustomerForm.jsp                                         --%>
<%--                                                                --%>
<%-- Parameters:                                                    --%>
<%--  id:   customer identifier                                     --%>
<%--                                                                --%>
<%-- Description:                                                   --%>
<%--  It shows the data of a customer and let it to be modified.    --%>
<%--  The modified data is sent to CommitUpdateCustomerForm.jsp in  --%>
<%--  order to be stored.                                           --%>
<%--                                                                --%>
<%-- ************************************************************** --%>


<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>

<%@page info="Update form for Customer"
        contentType="text/html;charset=UTF-8" language="java" 
        session="true"
        import="java.io.*, java.util.*, com.hp.ov.activator.crmportal.helpers.*,
		com.hp.ov.activator.crmportal.utils.*,
		com.hp.ov.activator.crmportal.action.CustomerForm" %>



<!--<%@ include file="../jsp/CheckSession.jsp" %>-->

<%
  response.setDateHeader("Expires",0);
  response.setHeader("Pragma","no-cache");
%>

<html:html locale="true">
  <head>
    <link rel="stylesheet" type="text/css" href="css/activator.css">
    <link rel="stylesheet" type="text/css" href="css/awfweb2.css">
  </head>

  <body>
    <center>
	  <html:form  action="/UpdateCustomerSubmit" focus="companyname">
      <html:hidden  property="actionflag" value="update" name="flag"/>

<%
     HashSet roles = (HashSet) session.getAttribute(Constants.ROLES_KEY);
    boolean isOperator = false;
    //System.out.println("roles :::::::"+roles);
    if(roles.contains(Constants.ROLE_OPERATOR)) {isOperator = true;}
     CustomerForm customerForm =  (CustomerForm)request.getAttribute("EditCustomerSubmit");
	
       if (customerForm == null)
	{
%>
        <bean:message key="error.no.customer" />
<%
    } else {
%>
<h2 class="mainSubHeading"><center><bean:message key="title.update.customer" /></center></h2>
      <table align="center" width="80%" border=0 cellpadding=0 cellspacing=0>
        <script>

            function checkAll() 
			{
              

				if(document.UpdateCustomerSubmit.companyname.value=="")
					{
                    alert('<bean:message key="js.company.name" />');
					document.UpdateCustomerSubmit.companyname.focus();
                  
                   }
				   else
				   {
					  
					   document.UpdateCustomerSubmit.submit();
				   }
            }

       
        </script>

        <tr>
          <th class="center" colspan=3>&nbsp;</th>
        </tr>

        <tr>
          <td class="list0"><div class="list0" id="req"><bean:message key="label.customer.id" /></div></td>
          <td class="list0">
		   <input type="hidden" name="creationtime"  value="<%= customerForm.getCreationtime() %>" size="20">
		   <input type="hidden" name="customerid"  value="<%= customerForm.getCustomerid() %>" size="20">		 
		  <%= customerForm.getCustomerid() %></td>
          <td class="list0"><bean:message key="desc.cust.identifier" /></td>
        </tr>

        <tr>
          <td class="list1"><div class="list1" id="opc"><bean:message key="label.company.name" /></div></td>
          <td class="list1"><input type=text  id="companyname" name="companyname"  value="<%= customerForm.getCompanyname() == null ? "" : customerForm.getCompanyname() %>" size="20"></td>
          <td class="list1"><bean:message key="desc.company.name" /></td>
        </tr>

        <tr>
          <td class="list0"><div class="list0" id="opc"><bean:message key="label.companyaddress" /></div></td>
          <td class="list0"><textarea name="companyaddress" rows="3" cols="17"><%= customerForm.getCompanyaddress() == null ? "" : customerForm.getCompanyaddress() %></textarea></td>
          <td class="list0"><bean:message key="desc.company.addr" /></td>
        </tr>

        <tr>
          <td class="list1"><div class="list1" id="opc"><bean:message key="label.city" /></div></td>
          <td class="list1"><input type=text  name="companycity"  value="<%= customerForm.getCompanycity() == null ? "" : customerForm.getCompanycity() %>" size="20"></td>
          <td class="list1"><bean:message key="desc.company.city" /></td>
        </tr>

        <tr>
          <td class="list0"><div class="list0" id="opc"><bean:message key="label.zipcode" /></div></td>
          <td class="list0"><input type=text  name="companyzipcode"  value="<%= customerForm.getCompanyzipcode() == null ? "" : customerForm.getCompanyzipcode() %>" size="20"></td>
          <td class="list0"><bean:message key="desc.company.post" /></td>
        </tr>

        <tr>
          <td class="list1"><div class="list1" id="opc"><bean:message key="label.first.name" /></div></td>
          <td class="list1"><input type=text  name="contactpersonname"  value="<%= customerForm.getContactpersonname() == null ? "" : customerForm.getContactpersonname() %>" size="20"></td>
          <td class="list1"><bean:message key="desc.contactname" /></td>
        </tr>

        <tr>
          <td class="list0"><div class="list0" id="opc"><bean:message key="label.surname" /></div></td>
          <td class="list0"><input type=text  name="contactpersonsurname"  value="<%= customerForm.getContactpersonsurname() == null ? "" : customerForm.getContactpersonsurname() %>" size="20"></td>
          <td class="list0"><bean:message key="desc.contactsurname" /></td>
        </tr>

        <tr>
          <td class="list1"><div class="list1" id="opc"><bean:message key="label.phone.number" /></div></td>
          <td class="list1"><input type=text  name="contactpersonphonenumber"  value="<%= customerForm.getContactpersonphonenumber() == null ? "" : customerForm.getContactpersonphonenumber() %>" size="20"></td>
          <td class="list1"><bean:message key="desc.contactphone" /></td>
        </tr>

        <tr>
          <td class="list0"><div class="list0" id="opc"><bean:message key="label.email" /></div></td>
          <td class="list0"><input type=text  name="contactpersonemail"  value="<%= customerForm.getContactpersonemail() == null ? "" : customerForm.getContactpersonemail() %>" size="20"></td>
          <td class="list0"><bean:message key="desc.contactmailid" /></td>
        </tr>
        <%if (customerForm.getActionflag()!= null && customerForm.getActionflag().equalsIgnoreCase("fromsearch") && customerForm.getStatus().equalsIgnoreCase("deleted")){%>
        <tr >
            <td class="list1"><div class="field" id="opc"><bean:message key="label.status" /> </div></td>
            <td class="list1" align="center">
               <input type="radio" name="status" value="Active" <%= customerForm.getStatus().equalsIgnoreCase("active")== true ? " CHECKED":" " %>><bean:message key="label.Active" />
               <input type="radio" name="status" value="Deleted" <%= customerForm.getStatus().equalsIgnoreCase("deleted")== true ? " CHECKED":" " %>><bean:message key="label.Deleted" /></td>
            <td class="list1"><bean:message key="desc.company.status" /></td>
        </tr>
        <%} else {%>
            <input type="hidden" name="status" value="<%= customerForm.getStatus()%>"/>
         <%} %>
        <tr>
          <td class="list1" colspan=3>&nbsp;</td>
        </tr>

        <tr>
            <td class="list0" colspan=3 align="right">
<%
      if(isOperator) {
%>
         <html:link href="javascript:checkAll();">
	     <html:img page="/images/arrow_submit.gif" border="0" title="submit data" align="right"/>
	     </html:link>

<%
         }
%>
            </td>
        </tr>
     </table>
<%
      }
%>
        </html:form>
    </center>

<%
%>
    <!--<center>
      <h2>Error</h2>
      <b>Error</b>:
      <p><a href="javascript:window.history.back();"><img src="../images/back.gif" border="0" title="return"></a>
    </center> -->
<%
 
%>
  </body>
</html:html>
