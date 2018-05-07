<%--------------------------------------------------------------------------%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.  --%>
<%--------------------------------------------------------------------------%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN"
   "http://www.w3.org/TR/html4/frameset.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>

<html:html>
<head>
  <title><bean:message key="crm.main.title" /></title>
  
  <frameset cols="160,*">
    <frameset rows="0,91%,9%" border="0">
      <html:frame action="Reload" frameName="reload" scrolling="no" noresize="true" frameborder="0"/>
      <html:frame action="Menu" frameName="menu" scrolling="no" frameborder="0"/>
      <html:frame action="Footer" frameName="footer" scrolling="no" frameborder="0"/>
    </frameset>
    <html:frame action="Welcome" frameName="main" frameborder="0"/>
  </frameset>
</html:html>

<%--
vim:softtabstop=4:shiftwidth=4:expandtab
--%>
