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
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/report/jsp/bandwidthAccountingReportParams.jsp,v $--%>
<%-- $Revision: 1.11 $                                                                 --%>
<%-- $Date: 2011-02-18 05:35:50 $                                                     --%>
<%-- $Author: tanye $                                                                   --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%@page contentType="text/html;charset=UTF-8" import="com.hp.ov.activator.mwfm.*,
                com.hp.ov.activator.mwfm.servlet.*,
                com.hp.ov.activator.vpn.inventory.*,
				com.hp.ov.activator.cr.inventory.NetworkElement,
				com.hp.ov.activator.cr.inventory.Region,com.hp.ov.activator.cr.inventory.Location,
                java.sql.*, com.hp.ov.activator.inventory.SAVPN.SwitchConstants,
                javax.sql.DataSource,
                java.util.*" 
%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table"%>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn"%>
<%
    if (session == null || session.getAttribute(Constants.USER) == null) {
        response.sendRedirect(".../../jsp/sessionError.jsp");
        return;
    }

    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");

%>
<%
    String        regionSelected = null;
    String      locationSelected = null;
    String                region = null;
    String              location = null;
    String                router = null;
    boolean               enable = true;

    LinkedList      regions = new LinkedList();
    LinkedList    locations = new LinkedList();
    Iterator             it = null;
    
    DataSource      dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
    Connection      connection = null;
    NetworkElement        pe[] = null;

    regionSelected = (String) request.getParameter("regionSelected");
    locationSelected = (String) request.getParameter("locationSelected");

    String link1 = "'bandwidthAccountingReportParams.jsp?";
    String link2 = "&regionSelected=' + form.region.value ";
    String link3 = "'&locationSelected=' + form.location.value ";

    try {
        connection = (Connection) dataSource.getConnection();
        Region reg[] = Region.findAll(connection, "NAME NOT IN ('Unknown','Provider')" );
        if(reg != null){
            for(int i =0; i<reg.length; i++){
                regions.addLast(reg[i].getName());
            }

            if(regionSelected == null)
                regionSelected = regions.getFirst().toString();
            Location loc[] = Location.findByRegion(connection, regionSelected);
            if(loc != null){
                for(int i =0; i<loc.length; i++){
                    locations.addLast(loc[i].getName());
                }

                if(locationSelected == null)
                locationSelected = locations.getFirst().toString();
                //pe = PERouter.findByLocation(connection, locationSelected);
                String addlnWhereClause= "(role ='"+SwitchConstants.PE+"' or role='"+SwitchConstants.AGGREGATIONSWITCH+"' or role= '"+ SwitchConstants.ACCESSSWITCH+"')";
                pe= NetworkElement.findByLocation(connection,locationSelected,addlnWhereClause);
            }
        }
    }catch (Exception e) {
        e.printStackTrace();
%>
      <B>Error qyerying:  <%= e.getMessage () %></B>
<%
    } finally {
        connection.close();
    }
%>

 <html>
   <head>
     <title>HP Service Activator</title>
     <meta http-equiv="pragma" content="no-cache">
     <meta http-equiv="cache-control" content="no-cache">
     <meta http-equiv="expires" content="0">
     <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
     <meta http-equiv="description" content="This is my page">

     <link rel="stylesheet" type="text/css" href="/activator/css/saAudit.css">
     <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
     <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
     <link rel="stylesheet" type="text/css" href="/activator/css/saContextMenu.css">

     <style test>
       A:hover{
         font-weight;
         TEXT-DECORATION: underline;
       }

       .trigger{
         CURSOR: pointer;
         font-family: Verdana, Helvetica, Arial, Sans-serif;
         font-size: 8pt;
         color: black;
         padding: 1px, 3px;
       }

       .fcwidth{
         width: 150px;
         height: 20px;
       }

       .formCell{ 
         font-family: Verdana, Helvetica, Arial;
         font-size: 15px;
         font-weight: bold;
         color: blue;
         padding: 5px,5px;
         width: 58%;
         height: 25;
       }

       .triggerB{
         CURSOR: pointer;
         font-family: Verdana, Helvetica, Arial, Sans-serif;
         font-size: 8pt;
         color: #336699 ;
         font-weight: bold;
         padding: 1px, 3px;
       }

       A:hover{
           color: blue;
       }
     </style>
  </head>
<body>
<form name="form" action="getReport.jsp" method="POST">
<center>
    <br/><br/>
    <h2 class="mainSubHeading">
        <center><bean:message bundle="InventoryResources" key="Report.Bandwidth.title" /></center>
    </h2>
    <input type="hidden" name="reportType" value="bandwidthAccountingReport"/>
    <table align="center" width=70% border=0 cellpadding=0>
        <tr>
            <td class="mainHeading" width=30% colspan='3'><bean:message bundle="InventoryResources" key="Report.Bandwidth.select" /></td>
        </tr>
        <tr id="rpRow1" class="tableOddRow">
            <td class="tableCell">&nbsp;</td>
            <td class="tableCell" width=30%><B><bean:message bundle="InventoryResources" key="Report.Bandwidth.Region" /></B></td>
            <td class="tableCell">
            <%if(regions == null || regions.isEmpty()){
                enable = false;%>
                No region configured!
            <%}else{%>
                <select size="1" 
                        name="region"
                        onChange="window.location = <%= link1 + link2 %>;">
                    <%  
                        it = regions.iterator();
                        while (it.hasNext()) {
                            region = it.next().toString();
                            %><option <%= region.compareTo(regionSelected)==0 ? "selected": "" %> value="<%=region%>"><%=region%></option><% 
                        } 
                    %>              
                </select>
            <%}%>
        </td>
        </tr>
            <tr id="rpRow2" class="tableEvenRow">
            <td class="tableCell">&nbsp;</td>
            <td class="tableCell" width=30%><B><bean:message bundle="InventoryResources" key="Report.Bandwidth.Location" /></B></td>
            <td class="tableCell">
            <%if(locations == null || locations.isEmpty()){
                enable=false;%>
                No location configured!         
            <%}else{%>
                <select size="1" 
                        name="location"
                        onChange="window.location = <%= link1 + link2%> + <%=link3 %>;">
                    <%  
                        it = locations.iterator();
                        while (it.hasNext()) {
                            location = it.next().toString();/////
                            %>
							<option  <%= location.compareTo(locationSelected)==0 ? "selected": "" %> value="<%=location%>"><%=location%></option>
							<% 
                        } 
                    %>          
                </select>
            <%}%>
        </td>
        </tr>
        </tr>
            <tr id="rpRow2" class="tableOddRow">
            <td class="tableCell">&nbsp;</td>
            <td class="tableCell" width=30%><B><bean:message bundle="InventoryResources" key="Report.Bandwidth.Routers" /></B></td>
            <td class="tableCell">
            <%if(pe == null || pe.length==0){
                enable=false;%>
                No PE router configured!                        
            <%}else{%>
                <select size="1" 
                        name="pe">
                    <%
                        for(int i =0; i<pe.length; i++){
                            %><option value="<%=pe[i].getNetworkelementid()%>"><%=pe[i].getName()%></option><% 
                        }
                    %>              
                </select>
            <%}%>
        </td>
        </tr>
        <tr id="rpRow3" class="tableEvenRow">
            <td class="tableCell" colspan='3' align="right">
                <%if(enable==true){%>
                    <input type="submit" value="<bean:message bundle="InventoryResources" key="Report.Bandwidth.Submit" />" name="B1">
                <%}else{%>
                    <input type="submit" value="<bean:message bundle="InventoryResources" key="Report.Bandwidth.Submit" />" name="B1" disabled = "true">
                <%}%>
            </td>
        </tr> 
    </div>
    </table>
</center>
</form>
</body>
</html>
