<%--------------------------------------------------------------------------%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.  --%>
<%--------------------------------------------------------------------------%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>

<html:html>
<head>
  <title>Footer</title>
  <link href="<html:rewrite page="/css/crm_menu.css" />" rel="stylesheet" type="text/css" />
</head>

<body>
  <ul class="button">
    <li>
      <html:form action="/Help" target="main">
        <html:submit><bean:message key="menu.button.help"/></html:submit>
      </html:form>
    </li>

    <logic:present name="user">
    <li>
      <html:form action="/Logout" target="_top">
        <html:submit><bean:message key="menu.button.exit"/></html:submit>
      </html:form>
    </li>
    </logic:present>
  </ul>
</body>

</html:html>

<%--
vim:softtabstop=4:shiftwidth=4:expandtab
--%>
