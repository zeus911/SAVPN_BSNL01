<%--------------------------------------------------------------------------%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.  --%>
<%--------------------------------------------------------------------------%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">

<%@ page session="true"
         contentType="text/html; charset=UTF-8"
         language="java"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>

<html:html>
  <head>
    <title><bean:message key="title.err.login" /></title>
    <link href="<html:rewrite page="/css/crm_main.css" />" rel="stylesheet" type="text/css"/>
    <meta http-equiv="refresh" content="8; url=/crm/Login.do">
  </head>

  <body>
    <center>
      <img src="/crm/images/HPLogo_main.png">

      <p><strong><bean:message key="err.unspecified.login" /></strong></p>
      <p><strong><bean:message key="err.redirecting.login" /></strong></p>
    </center>
  </body>
</html:html>

<!-- vim:softtabstop=4:shiftwidth=4:expandtab
-->
