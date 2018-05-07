<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>


<%-- ************************************************************** --%>
<%--                                                                --%>
<%-- Session.jsp                                                    --%>
<%--                                                                --%>
<%--                                                                --%>
<%-- Description:                                                   --%>
<%--  It displays the message for session timeout				    --%>
<%--                                                                --%>
<%-- ************************************************************** --%>


<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<html:html locale="true">
<head>
 <script language=javascript>
 </script>
</head>
<body onLoad = "alert('<bean:message key="session.time.out" />');top.location = '/crm/Login.do';">
</body>
</html:html>