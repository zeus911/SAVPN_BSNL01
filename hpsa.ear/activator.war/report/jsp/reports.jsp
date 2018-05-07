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
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/report/jsp/reports.jsp,v $--%>
<%-- $Revision: 1.8 $                                                                 --%>
<%-- $Date: 2011-02-18 05:35:50 $                                                     --%>
<%-- $Author: tanye $                                                                   --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>





<%@page contentType="text/html;charset=UTF-8" import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*"%>

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
<center>
    <br/><br/>
    <h2 class="mainSubHeading"><center><bean:message bundle="InventoryResources" key="Report.type" /></center></h2>               
            <table align="center" width=85% border=0 cellpadding=0>
                <tr>
                    <td class="mainHeading" width=30%><bean:message bundle="InventoryResources" key="Report.name" /></td>
                    <td class="mainHeading"><bean:message bundle="InventoryResources" key="Report.Description" /></td>
                </tr>
                <tr id="rpRow0" class="tableOddRow"
                        onclick="rowSelect(this);
                                 window.location='executiveSummaryReportParams.jsp';"
                        onMouseOver="mouseOver(this);"
                        onMouseOut="mouseOut(this);">
                    <td class="tableCell"><bean:message bundle="InventoryResources" key="Report.SummaryReport" /></td>
                    <td class="tableCell"><bean:message bundle="InventoryResources" key="Report.SummaryReport.Description" /></td>    
                </tr>
                <tr id="rpRow1" class="tableEvenRow"
                        onclick="rowSelect(this);
                                 window.location='servicesPerPEReportParams.jsp';"
                        onMouseOver="mouseOver(this);"
                        onMouseOut="mouseOut(this);">
                    <td class="tableCell"><bean:message bundle="InventoryResources" key="Report.PerPEReport" /></td>   
                    <td class="tableCell"><bean:message bundle="InventoryResources" key="Report.PerPEReport.Description" /></td> 
                </tr>
                <tr id="rpRow2" class="tableOddRow"
                        onclick="rowSelect(this);
                                window.location='bandwidthAccountingReportParams.jsp';"
                        onMouseOver="mouseOver(this);"
                        onMouseOut="mouseOut(this);">
                    <td class="tableCell"><bean:message bundle="InventoryResources" key="Report.BandwidthReport" /></td>  
                    <td class="tableCell"><bean:message bundle="InventoryResources" key="Report.BandwidthReport.Description" /></td>    
                </tr>
		<tr id="rpRow3" class="tableOddRow"
                        onclick="rowSelect(this);
                                window.location='EquipmentSummary.jsp';"
                        onMouseOver="mouseOver(this);"
                        onMouseOut="mouseOut(this);">
                    <td class="tableCell"><bean:message bundle="InventoryResources" key="Report.EquipmentSummary" /></td>  
                    <td class="tableCell"><bean:message bundle="InventoryResources" key="Report.EquipmentSummary.Description" /></td>    
                </tr>
		<tr id="rpRow4" class="tableOddRow"
                        onclick="rowSelect(this);
                                window.location='RouterSummary.jsp';"
                        onMouseOver="mouseOver(this);"
                        onMouseOut="mouseOut(this);">
                    <td class="tableCell"><bean:message bundle="InventoryResources" key="Report.RouterSummary" /></td>  
                    <td class="tableCell"><bean:message bundle="InventoryResources" key="Report.RouterSummary.Description" /></td>    
                </tr>
		<tr id="rpRow5" class="tableOddRow"
                        onclick="rowSelect(this);
                                window.location='CustomerSummary.jsp';"
                        onMouseOver="mouseOver(this);"
                        onMouseOut="mouseOut(this);">
                    <td class="tableCell"><bean:message bundle="InventoryResources" key="Report.CustomerSummary" /></td>  
                    <td class="tableCell"><bean:message bundle="InventoryResources" key="Report.CustomerSummary.Description" /></td>    
                </tr>



            </div>
        </table>
</body>
</html>

