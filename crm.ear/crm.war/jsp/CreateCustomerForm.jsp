<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>

<%-- ************************************************************** --%>
<%--                                                                --%>
<%-- CreateCustomerForm.jsp                                        --%>
<%--                                                                --%>
<%-- Parameters:                                                    --%>
<%--  - None -                                                      --%>
<%--                                                                --%>
<%-- Description:                                                   --%>
<%--  It collects the information to store a new client             --%>
<%--  This information is sent to CommitCustomerForm.jsp            --%>
<%--                                                                --%>
<%-- ************************************************************** --%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>


<%@page info="Create Page For a New Customer"
        contentType="text/html;charset=UTF-8" language="java" 
        import="java.io.*,com.hp.ov.activator.crmportal.action.CustomerForm
		,java.util.*, com.hp.ov.activator.crmportal.helpers.*,com.hp.ov.activator.crmportal.utils.* "
		%>
 
<!--<%@ include file="../jsp/CheckSession.jsp" %>-->

<%
  response.setDateHeader("Expires",0);
  response.setHeader("Pragma","no-cache");
//merging- richa
 CustomerForm customerForm = new CustomerForm();
 String strCreateOrUpdate = "";
 String strmainSubHeading = "";
 HashSet roles = null;
 boolean isOperator= false;
 String customer_id="";
 String strAction = "";
 String strValue = "";
 
 customerForm = (CustomerForm)request.getAttribute("EditCustomerSubmit");
 String stractionFlag = (String)request.getAttribute("actionflag");

if(customerForm!=null)
	{
	strCreateOrUpdate = "edit";
	strAction = "/UpdateCustomerSubmit";
	strValue = "update";
    roles = (HashSet) session.getAttribute(Constants.ROLES_KEY);
    if(roles.contains(Constants.ROLE_OPERATOR)) {isOperator = true;}
	}
 
else
{
customerForm = (CustomerForm)request.getAttribute("CreateCustomerForm");
if(customerForm!=null)
 {
	strCreateOrUpdate = "add";
	customer_id  = customerForm.getCustomerid();
	strAction = "/AddCustomerSubmit";
	strValue = "add";
 }
}
//merging- richa
%>
        <script>

            function checkAll() 
			{
               
               if(document.getElementById('companyname').value.length==0)
					{
                    alert('<bean:message key="js.no.customer.name" />');
					document.CreateCustomerForm.companyname.focus();
                  
                   }
				   else
				   {
					   document.CreateCustomerForm.submit();
				   }
             
				
            }

           

        </script>

<html:html locale="true">
<HEAD>
<%if(strCreateOrUpdate.equalsIgnoreCase("add")) {%>
	<TITLE><bean:message key="title.create.new.customer" /></TITLE>
<%} else if(strCreateOrUpdate.equalsIgnoreCase("edit")){
%>
<TITLE><bean:message key="title.update.customer" /></TITLE>
<%}%>

<link rel="stylesheet" type="text/css" href="css/activator.css">
<link rel="stylesheet" type="text/css" href="css/awfweb2.css">
<META Http-Equiv="Cache-Control" Content="no-cache">
<META Http-Equiv="Pragma"    Content="no-cache">
<META Http-Equiv="Expires"   Content="0">
</HEAD>
<BODY>
<%if(strCreateOrUpdate.equalsIgnoreCase("add")) {%>
  <h2 class="mainSubHeading"><center><bean:message key="title.create.new.customer" /></center></h2>
 <%} else if(strCreateOrUpdate.equalsIgnoreCase("edit")){%>
 <h2 class="mainSubHeading"><center><bean:message key="title.update.customer" /></center></h2>
 <%}%>
 <br><font color="red">
<html:errors/>
</font></br>
<html:form  action="<%=strAction%>" focus="companyname">
<html:hidden  property="actionflag" value="<%=strValue%>" name="flag"/>
    <center>
      <table align="center" width="80%" border=0 cellpadding=2 cellspacing=2>
          
        <tr>
          <td class="mainHeading" valign="top" align="left" colspan=5>&nbsp;</th>
        </tr>
<%if(strCreateOrUpdate.equalsIgnoreCase("add")) {%>
        <tr>
          <td class="list0"><div class="list0" id="req"><bean:message key="label.customer.id" /></div></td>
          <td class="list0"><input type="hidden" name="customerid"  value="<%= customer_id %>" size="30"><%= customer_id %></td>
          <td class="list0"><bean:message key="desc.cust.identifier" /></td><!--<html:text property="customerid"/>-->
        </tr>
<%} else if(strCreateOrUpdate.equalsIgnoreCase("edit")){%>

		<tr>
         <td class="list0"><div class="list0" id="req"><bean:message key="label.customer.id" /></div></td>
         <td class="list0">
		 <input type="hidden" name="creationtime"  value="<%= customerForm.getCreationtime() %>" size="20">
		 <input type="hidden" name="customerid"  value="<%= customerForm.getCustomerid() %>" size="20">		 
		 <%= customerForm.getCustomerid() %></td>
         <td class="list0"><bean:message key="desc.cust.identifier" /></td>
        </tr>
<%}%>
        <tr>
          <td class="list1"><div class="list1" id="opc"><bean:message key="label.company.name" /></div></td>
             <td class="list1"><input  class='inputField' type=text name="companyname"  id="companyname" value="<%= customerForm.getCompanyname() == null ? "" : customerForm.getCompanyname() %>" size="30"></td>
          <td class="list1"><bean:message key="desc.company.name" /></td>
        </tr>

        <tr>
          <td class="list0"><div class="list0" id="opc"><bean:message key="label.companyaddress" /></div></td>
           <td class="list0"><textarea  class='inputField' name="companyaddress" rows="3" cols="30"><%= customerForm.getCompanyaddress() == null ? "" : customerForm.getCompanyaddress() %></textarea></td>
          <td class="list0"><bean:message key="desc.company.addr" /></td>
        </tr>

        <tr>
          <td class="list1"><div class="list1" id="opc"><bean:message key="label.city" /></div></td>
          <td class="list1"><input class='inputField' type=text  name="companycity"  value="<%= customerForm.getCompanycity() == null ? "" : customerForm.getCompanycity() %>" size="30"></td>
          <td class="list1"><bean:message key="desc.company.city" /></td>
        </tr>

        <tr>
          <td class="list0"><div class="list0" id="opc"><bean:message key="label.zipcode" /></div></td>
          <td class="list0"><input class="inputField" type=text  name="companyzipcode"  value="<%= customerForm.getCompanyzipcode() == null ? "" : customerForm.getCompanyzipcode() %>" size="30"></td>
          <td class="list0"><bean:message key="desc.company.post" /></td>
        </tr>

        <tr>
          <td class="list1"><div class="list1" id="opc"><bean:message key="label.first.name" /></div></td>
            <td class="list1"><input class="inputField" type=text  name="contactpersonname"   value="<%= customerForm.getContactpersonname() == null ? "" : customerForm.getContactpersonname() %>" size="30"></td>
          <td class="list1"><bean:message key="desc.contactname" /></td>
        </tr>

        <tr>
          <td class="list0"><div class="list0" id="opc"><bean:message key="label.surname" /></div></td>
           <td class="list0"><input class="inputField" type=text  name="contactpersonsurname"  value="<%= customerForm.getContactpersonsurname() == null ? "" : customerForm.getContactpersonsurname() %>" size="30"></td>
          <td class="list0"><bean:message key="desc.contactsurname" /></td>
        </tr>

        <tr>
          <td class="list1"><div class="list1" id="opc"><bean:message key="label.phone.number" /></div></td>
         <td class="list1"><input class="inputField" type=text  name="contactpersonphonenumber"  value="<%= customerForm.getContactpersonphonenumber() == null ? "" : customerForm.getContactpersonphonenumber() %>" size="30"></td>
          <td class="list1"><bean:message key="desc.contactphone" /></td>
        </tr>
        <tr>
          <td class="list0"><div class="list0" id="opc"><bean:message key="label.email" /></div></td>
          <td class="list0"><input class="inputField" type=text  name="contactpersonemail"  value="<%= customerForm.getContactpersonemail() == null ? "" : customerForm.getContactpersonemail() %>" size="30"></td>
          <td class="list0"><bean:message key="desc.contactmailid" /></td>
        </tr>
		
		<tr>
          <td class="list1" colspan=3>&nbsp;</td>
        </tr>
<%if(strCreateOrUpdate.equalsIgnoreCase("add")) {%>
        
		<tr>
		  <td class="list0" align="right" colspan=3>
	     <html:link href="javascript:checkAll();">
	     <html:img page="/images/arrow_submit.gif" border="0" title="submit data" align="right"/>
	     </html:link>
	     </td>
        </tr>
<%} else if(strCreateOrUpdate.equalsIgnoreCase("edit")){%>

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

<%}%>
      </table>
  
    </center>

	 <!--
      <p><a href="javascript:window.history.back();"><img src="../images/back.gif" border="0" title="return"></a>
    </center> -->
  </html:form>
</BODY>
</html:html>