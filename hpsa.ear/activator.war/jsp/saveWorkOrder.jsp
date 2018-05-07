<%@page import="com.hp.ov.activator.mwfm.servlet.*, com.hp.ov.activator.vpn.inventory.SetupCE_Workorder" contentType="text/html; charset=UTF-8"%><%if (session == null || session.getAttribute(Constants.USER) == null){
        response.sendRedirect("sessionError.jsp");
        return;
    }
	request.setCharacterEncoding("UTF-8");
%><%

   String strworkorderfile = (String)session.getAttribute("WorkOrderFile");
   String strWorkOrderContent = (String)session.getAttribute("WorkOrderContent");
   String  filename= "attachment; filename=" + strworkorderfile;
   response.setContentType("application/x-download");
   response.setHeader("Content-Disposition",filename);

%><%=strWorkOrderContent%>
