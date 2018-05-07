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
  <html:base/>
  <title>Welcome</title>
  <link href="<html:rewrite page="/css/crm_main.css" />"  rel="stylesheet" type="text/css"/>
</head>
<body>
    <h1><bean:message key="welcome.crm.main.title"/>
      <html:img page="/images/HPLogo_main.png" border="0" alt="Logo"/>
    </h1>
</body>
</html:html>

<!-- vim:softtabstop=4:shiftwidth=4:expandtab
-->

