<%@page contentType="text/xml;charset=UTF-8" language="java"%><?xml version="1.0" encoding="UTF-8"?>
<%@page import="com.hp.ov.activator.mwfm.*,
                com.hp.ov.activator.mwfm.servlet.*,
                com.hp.ov.activator.vpn.backup.*,
                com.hp.ov.activator.vpn.inventory.*,
				com.hp.ov.activator.cr.inventory.*,
                com.hp.ov.activator.vpn.report.*,
                java.sql.*, 
                javax.sql.DataSource,
                java.util.*, 
                java.text.*,
                java.net.*"%><%if (session == null || session.getAttribute(Constants.USER) == null) {
        response.sendRedirect("../../jsp/sessionError.jsp");
        return;
    }response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%><%DataSource      dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
    Connection      connection = null;
    String           timeFrame = null;
    String                neID = null;
    String              report = null;
    String          reportType = (String) request.getParameter("reportType");
    String              reportHeader = "<?xml-stylesheet type=\"text/xsl\" href= " ;
    try {connection = (Connection) dataSource.getConnection();
        if(reportType.compareTo("bandwidthAccountingReport")==0){
            neID = (String) request.getParameter("pe");         
            reportHeader+="\"../xsl/BandwidthAccounting.xsl\"?>\n";
            report=XMLCreator.execute(reportType,neID,connection);
        }else if (reportType.compareTo("servicePerPEReport")==0){
            neID = (String) request.getParameter("pe");
            reportHeader+="\"../xsl/ServicesPerPE.xsl\"?>\n";
            report=XMLCreator.execute(reportType,neID,connection);
        }else if(reportType.compareTo("executiveSummaryReport")==0){
                timeFrame = (String) request.getParameter("timeFrame");
                reportHeader+="\"../xsl/ExecutiveSummary.xsl\"?>\n";
                report=XMLCreator.execute(reportType,timeFrame,connection);
        }session.setAttribute("report",reportHeader+report);
    }catch (Exception e) {
        e.printStackTrace();
    } finally {
        connection.close();
    }
%><%=reportHeader%>
      
<%=report%>
<%-- DONOT TRY TO FORMAT THIS JSP OTHERWISE THE XML GENERATED WILL NOT BE WELL FORMED --%>