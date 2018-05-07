<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>               
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/report/jsp/executiveSummaryReportParams.jsp,v $--%>
<%-- $Revision: 1.8 $                                                                 --%>
<%-- $Date: 2011-02-18 05:35:50 $                                                     --%>
<%-- $Author: tanye $                                                                   --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%@page contentType="text/html;charset=UTF-8"  import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table"%>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn"%>

<%
    if (session == null || session.getAttribute(Constants.USER) == null) {
        response.sendRedirect("../../jsp/sessionError.jsp");
        return;
    }

    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");

%>



 <html>
   <head>
     <title><bean:message bundle="InventoryResources" key="Report.heading" /></title>
     <meta http-equiv="pragma" content="no-cache">
     <meta http-equiv="cache-control" content="no-cache">
     <meta http-equiv="expires" content="0">
     <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
     <meta http-equiv="description" content="This is my page">

     <script language="JavaScript" src="/activator/javascript/table.js"></script>
     <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
     <script language="JavaScript" src="/activator/javascript/saContextMenu.js"></script>
     <script language="JavaScript" src="../../javascript/backup.js"></script>
     
     <link rel="stylesheet" type="text/css" href="/activator/css/saAudit.css">
     <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
     <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
     <link rel="stylesheet" type="text/css" href="/activator/css/saContextMenu.css">

     <style test>
       A:hover {font-weight;
         TEXT-DECORATION:underline;
       }

       .trigger {
         CURSOR: pointer;
         font-family: Verdana, Helvetica, Arial, Sans-serif;
         font-size: 8pt;
         color: black;
         padding: 1px, 3px;
       }

       .fcwidth {
         width: 150px;height: 20px;
       }

       .formCell{ font-family: Verdana, Helvetica, Arial;
         font-size: 15px;
         font-weight: bold;
         color: blue;
         padding: 5px,5px;
         width:58%;
         height:25;
       }

       .triggerB {
         CURSOR: pointer;
         font-family: Verdana, Helvetica, Arial, Sans-serif;
         font-size: 8pt;
         color:#336699 ;
         font-weight: bold;
         padding: 1px, 3px;
       }

       A:hover {color:blue}
     </style>
  </head>
<body>
<form name="form" action="getReport.jsp" method="POST">
<center>
    <br/><br/>
    <h2 class="mainSubHeading">
        <center><bean:message bundle="InventoryResources" key="Report.SummaryReport.main" /></center>
    </h2>
    <input type="hidden" name="reportType" value="executiveSummaryReport"/>
    <table align="center" width=70% border=0 cellpadding=0>
        <tr>
            <td class="mainHeading" width=30% colspan='3'><bean:message bundle="InventoryResources" key="Report.SummaryReport.mainHeading" /></td>
        </tr>
        <tr id="rpRow1" class="tableOddRow">
            <td class="tableCell">&nbsp;</td>
            <td class="tableCell" width=30%><bean:message bundle="InventoryResources" key="Report.SummaryReport.tablecell" /></td>
            <td class="tableCell">
            <select size="1" name="timeFrame">
                <option value="1" selected><bean:message bundle="InventoryResources" key="Report.SummaryReport.1month" /></option>
                <option value="2"><bean:message bundle="InventoryResources" key="Report.SummaryReport.2month" /></option>
                <option value="3"><bean:message bundle="InventoryResources" key="Report.SummaryReport.3month" /></option>
                <option value="4"><bean:message bundle="InventoryResources" key="Report.SummaryReport.4month" /></option>
                <option value="5"><bean:message bundle="InventoryResources" key="Report.SummaryReport.5month" /></option>
                <option value="6"><bean:message bundle="InventoryResources" key="Report.SummaryReport.6month" /></option>
                <option value="12"><bean:message bundle="InventoryResources" key="Report.SummaryReport.1year" /></option>
                <option value="24"><bean:message bundle="InventoryResources" key="Report.SummaryReport.2year" /></option>
                <option value="36"><bean:message bundle="InventoryResources" key="Report.SummaryReport.3year" /></option>
                <option value="48"><bean:message bundle="InventoryResources" key="Report.SummaryReport.4year" /></option>
                <option value="60"><bean:message bundle="InventoryResources" key="Report.SummaryReport.5year" /></option>
                <option value="12000">  <bean:message bundle="InventoryResources" key="Report.SummaryReport.All" />  </option>
            </select>
        </td>
        </tr> 
        <tr id="rpRow2" class="tableEvenRow">
            <td class="tableCell" colspan='3' align="right">
                <input type="submit" value="<bean:message bundle="InventoryResources" key="Report.SummaryReport.Submit" />" name="B1">
            </td>
        </tr> 
    </div>
    </table>
</center>
</form>
</body>
</html>
