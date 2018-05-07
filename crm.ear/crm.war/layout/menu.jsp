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
    <title>Menu</title>
    <link href="<html:rewrite page="/css/crm_menu.css" />" rel="stylesheet" type="text/css"/>
  </head>

  <body>
    <html:img styleClass="logo" page="/images/HPLogo.png" title="HP Logo"/>
    <p>
      <bean:message key="crm.operator"/>
      <logic:notEmpty name="user">
        <bean:write name="user"/>
      </logic:notEmpty>
    </p>  

      <bean:parameter id="thisSkip" name="SKIP_ACTIVATION" value="default"/>
      <bean:define id="SKIP_ACTIVATION" name="thisSkip" toScope="session"/>

      <logic:equal name="thisSkip" value="default">
        <bean:define id="nextSkip" value="true"/>
      </logic:equal>
      <logic:equal name="thisSkip" value="true">
        <bean:define id="nextSkip" value="false"/>
      </logic:equal>
      <logic:equal name="thisSkip" value="false">
        <bean:define id="nextSkip" value="default"/>
      </logic:equal>

      <jsp:useBean id="nextSkip" class="java.lang.String"/>
      <bean:define id="skipTitle"><bean:message key="menu.skip.activation.title" arg0="<%=nextSkip%>"/></bean:define>

    <h1><bean:message key="title.list.customer"/></h1>
    <ul>
      <logic:notEmpty name="roles">
      <logic:match name="roles" value="operator">
        <li><html:link forward="createCustomer" target="main"><bean:message key="menu.new.customer"/></html:link></li>
      </logic:match>
      </logic:notEmpty>
      <li><html:link forward="listCustomer" target="main"><bean:message key="menu.list.customer"/></html:link></li>
      <li><html:link forward="searchCustomer" target="main"><bean:message key="menu.search.customer"/></html:link></li>
	  <li><html:link forward="searchSite" target="main"><bean:message key="menu.search.site"/></html:link></li>
    </ul>
    <logic:notEmpty name="roles">
    <logic:match name="roles" value="admin">
      <h1><bean:message key="menu.settings"/></h1>
      <ul class="admin">
        <li>
        <html:link page="/layout/menu.jsp" paramId="SKIP_ACTIVATION" paramName="nextSkip" title="<%=skipTitle%>" target="menu"><bean:message key="menu.skip.activation"/> <bean:write name="thisSkip"/></html:link>
        </li>
      </ul>
    </logic:match>
    </logic:notEmpty>
  </body>
</html:html>
<%--
vim:softtabstop=4:shiftwidth=4:expandtab
--%>
