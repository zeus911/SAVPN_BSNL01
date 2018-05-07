<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>

<%-- ************************************************************** --%>
<%--                                                                --%>
<%-- SearchCustomer.jsp                                             --%>
<%--                                                                --%>
<%-- Parameters: 												    --%>
<%-- 	- None -                       							    --%>
<%--                                  							    --%>
<%-- Description: 													--%>
<%--	It collects the information to find a new customer  			--%>
<%-- 	This information is sent to FindCustomer.jsp 				--%>
<%--                                  								--%>
<%-- ************************************************************** --%>

<%@page info="Search customer"
        contentType="text/html;charset=UTF-8" language="java" 
        import="java.util.*, java.io.*,com.hp.ov.activator.crmportal.action.CustomerForm" %>

<!--<%@ include file="../jsp/CheckSession.jsp" %>-->
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>



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
   
  </head>

<body>
<h2 class="mainSubHeading"><center><bean:message key="title.search.customer" /></center></h2>
<center>
<html:form  action="/SearchCustomerSubmit" focus="customerid">
<html:hidden  property="actionflag" value="search" name="flag"/>


<table align="center" width="80%" border=0 cellpadding=5 cellspacing=2>
  <tr>
    <td class="mainHeading" colspan="4">&nbsp;</td>
  </tr>

  <tr class="tableEvenRow">
    <td class="tableCell"><div class="field" id="opc"><bean:message key="label.customer.id" /></div></td>
    <td class="tableCell" align="center"><input type="text" size="32" name="customerid"></td>
  </tr>

  <tr class="tableOddRow">
    <td class="tableCell"><div class="field" id="opc"><bean:message key="label.company.name" /></div></td>
    <td class="tableCell" align="center"><input type="text" size="32" name="companyname"></td>
  </tr>

  <tr class="tableEvenRow">
    <td class="tableCell"><div class="field" id="opc"><bean:message key="label.companyaddress" /></div></td>
    <td class="tableCell" align="center"><input type="text" size="32" name="companyaddress"></td>
  </tr>

  <tr class="tableOddRow">
    <td class="tableCell"><div class="field" id="opc"><bean:message key="label.city" /></div></td>
    <td class="tableCell" align="center"><input type="text" size="32" name="companycity"></td>
  </tr>

  <tr class="tableEvenRow">
    <td class="tableCell"><div class="field" id="opc"><bean:message key="label.zipcode" /></div></td>
    <td class="tableCell" align="center"><input type="text" size="32" name="companyzipcode"></td>
  </tr>

  <tr class="tableOddRow">
    <td class="tableCell"><div class="field" id="opc"><bean:message key="label.first.name" /></div></td>
    <td class="tableCell" align="center"><input type="text" size="32" name="contactpersonname"></td>
  </tr>

  <tr class="tableEvenRow">
    <td class="tableCell"><div class="field" id="opc"><bean:message key="label.surname" /></div></td>
    <td class="tableCell" align="center"><input type="text" size="32" name="contactpersonsurname"></td>
  </tr>

  <tr class="tableOddRow">
    <td class="tableCell"><div class="field" id="opc"><bean:message key="label.phone.number" /></div></td>
    <td class="tableCell" align="center"><input type="text" size="32" name="contactpersonphonenumber"></td>
  </tr>
  <tr class="tableEvenRow">
    <td class="tableCell"><div class="field" id="opc"><bean:message key="label.email" /></div></td>
    <td class="tableCell" align="center"><input type="text" size="32" name="contactpersonemail"></td>
  </tr>

  <tr class="tableOddRow">
    <td class="tableCell" colspan="2">&nbsp;</td>
  </tr>

  <tr class="tableEvenRow">
    <td class="tableCell"><div class="field" id="opc"><bean:message key="label.status" /></div></td>
    <td class="tableCell" align="center">
	  <input type="radio" name="status" value="Active" checked><bean:message key="label.Active" />
    <input type="radio" name="status" value="Deleted" ><bean:message key="label.Deleted" />
	</td>
  </tr>

  <tr class="tableOddRow">
    <td class="tableCell"><div class="field" id="opc"><bean:message key="label.haspendingjobs" /></div></td>
    <td class="tableCell" align="center">    
    <input type="radio" name="haspendingjobs" value="yes" ><bean:message key="label.yes" />
    <input type="radio" name="haspendingjobs" value="no" checked><bean:message key="label.no" />	    
  </tr>

  <tr class="tableEvenRow">
    <td class="tableCell"><div class="field" id="opc"><bean:message key="label.matchcase" /></div></td>
    <td class="tableCell" align="center">
	<input type="radio" name="matchcase" value="yes"><bean:message key="label.yes" />
    <input type="radio" name="matchcase" value="no" checked><bean:message key="label.no" />
	</td>
  </tr>

  <tr class="tableOddRow">
	<td class="tableCell" colspan="2" align="right">
	<html:link href="javascript:document.SearchCustomerSubmit.submit();">
	<html:img page="/images/arrow_submit.gif" border="0" title="Search" align="center"/>
    </html:link>
	</td>
  </tr>
</table>
  </html:form>
</center>
</body>
</html:html>

