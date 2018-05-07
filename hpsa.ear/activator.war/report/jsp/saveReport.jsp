<%@page import="com.hp.ov.activator.mwfm.servlet.*;" contentType="text/html; charset=UTF-8"%><%if (session == null || session.getAttribute(Constants.USER) == null){
        response.sendRedirect("../../jsp/sessionError.jsp");
        return;
    }
    request.setCharacterEncoding("UTF-8");
%><%
    String report = (String)session.getAttribute("report");
    String reportType = (String) request.getParameter("reportType");
    String  filename= "attachment; filename=" + reportType + ".xml";
    response.setContentType("application/x-download");
    response.setHeader("Content-Disposition",filename);
%><%=report%>
      
<%-- DONOT TRY TO FORMAT THIS JSP OTHERWISE THE XML GENERATED WILL NOT BE WELL FORMED --%>