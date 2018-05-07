<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>

<%-- ************************************************************** --%>
<%--                                                                --%>
<%-- Searcsite.jsp                                             --%>
<%--                                                                --%>
<%-- Parameters: 												    --%>
<%-- 	- None -                       							    --%>
<%--                                  							    --%>
<%-- Description: 													--%>
<%--	It collects the information to find a new site  			--%>
<%-- 	This information is sent to FindCustomer.jsp 				--%>
<%--                                  								--%>
<%-- ************************************************************** --%>

<%@page info="Search site"
        contentType="text/html;charset=UTF-8" language="java" 
        import="java.util.*, java.io.*,com.hp.ov.activator.crmportal.action.ServiceForm" %>

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
<h2 class="mainSubHeading"><center><bean:message key="title.search.site" /></center></h2>
<center>
<html:form  action="/SearchSiteSubmit" focus="customername">
<html:hidden  property="actionflag" value="search" name="flag"/>


<table align="center" width="80%" border=0 cellpadding=5 cellspacing=2>
  <tr>
    <td class="mainHeading" colspan="4">&nbsp;</td>
  </tr>

  <tr class="tableEvenRow">
    <td class="tableCell"><div class="field" id="opc"><bean:message key="label.customer.name" /></div></td>
    <td class="tableCell" align="center"><input type="text" size="32" name="customername"></td>
  </tr>

  <tr class="tableOddRow">
    <td class="tableCell"><div class="field" id="opc"><bean:message key="label.site.name" /></div></td>
    <td class="tableCell" align="center"><input type="text" size="32" name="presname"></td>
  </tr>

  <tr class="tableEvenRow">
    <td class="tableCell"><div class="field" id="opc"><bean:message key="label.site.id" /></div></td>
    <td class="tableCell" align="center"><input type="text" size="32" name="serviceid"></td>
  </tr>

    <tr class="tableOddRow">
	<td class="tableCell" colspan="2" align="right">
	<html:link href="javascript:document.SearchSiteSubmit.submit();">
	<html:img page="/images/arrow_submit.gif" border="0" title="Search" align="center"/>
    </html:link>
	</td>
  </tr>
</table>
  </html:form>
</center>
</body>
</html:html>

