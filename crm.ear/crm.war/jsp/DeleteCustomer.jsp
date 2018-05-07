<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>

<%-- ************************************************************** --%>
<%--                                                                --%>
<%-- DeleteCustomer.jsp                                             --%>
<%--                                                                --%>
<%-- Parameters:                                                    --%>
<%--  id:   customer identifier                                     --%>
<%--  soft: soft delete (values: true|false)                        --%>
<%--                                                                --%>
<%-- Description:                                                   --%>
<%--  It deletes a customer. The parameter "id" gives the customer  --%>
<%--  identifier. If the parameter "soft" is "true" it will only    --%>
<%--  delete the customer if it has no services asociated.          --%>
<%--                                                                --%>
<%-- ************************************************************** --%>

<%@page contentType="text/html;charset=UTF-8" language="java" 
        info="Deletes the specified Customer"
        import="java.util.*,com.hp.ov.activator.crmportal.utils.*,
		com.hp.ov.activator.crmportal.helpers.*,com.hp.ov.activator.crmportal.action.CustomerForm" %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>


<!--<%@ include file="../jsp/CheckSession.jsp" %>-->

<html:html locale="true">
<head>
   <link rel="stylesheet" type="text/css" href="css/awfweb.css">
   <link rel="stylesheet" type="text/css" href="css/awfweb2.css">
</head>
<body>

<%
   String servicesExist = (String)request.getAttribute("Services_Found");
   String isSoft = (String)request.getAttribute("isSoft");
   String deactivate = (String)request.getAttribute("deactivate");
  
   //System.out.println("servicesExist >>>"+servicesExist);
   //System.out.println("isSoft >>>"+isSoft);
   //System.out.println("deactivate >>>"+deactivate);

      HashSet roles = (HashSet) session.getAttribute(Constants.ROLES_KEY);
      boolean isOperator = false;
      //System.out.println("roles :::::::"+roles);
      if(roles.contains(Constants.ROLE_OPERATOR)) {isOperator = true;}
  
      if(isOperator == false)
      throw new IllegalStateException("Wrong role to perform the operation");
      
    if (isSoft!=null && isSoft.equals("Y") && servicesExist!=null && (servicesExist.equals("Y")))
		{
 %>
      <center>
        <h2><bean:message key="err.any.screen" /></h2>
          <b><bean:message key="err.cannot.delete.customer" /></b>
		  <html:form  action="/ListCustomer">
		       <html:link href="javascript:window.history.back();">
	           <html:img page="/images/back.gif" border="0" title="Return" align="center"/>
	           </html:link>
          </html:form>
      </center>
<%
      }
	else if (deactivate!=null && deactivate.equals("Y"))
	   {
       
%>
      <center>
      &nbsp;<br>
      &nbsp;<br>
      <h3><bean:message key="msg.Delete.Customer.successful" /></h3>
       <html:form  action="/ListCustomer">
		<html:link page="/ListCustomer.do">
	    <html:img page="/images/back.gif" border="0" title="Return" align="center"/>
	    </html:link>
      </html:form>
      </center>
<%
    }else{
        
     
        %>
      <center>
      &nbsp;<br>
      &nbsp;<br>
      <h3><bean:message key="msg.Delete.Customer.successful" /></h3>
        <html:form  action="/ListCustomer">
		<html:link page="/ListCustomer.do">
	    <html:img page="/images/back.gif" border="0" title="Return" align="center"/>
	    </html:link>
      </html:form>
      </center>
        <%
    } // else
 %>
    
</body>
</html:html>
