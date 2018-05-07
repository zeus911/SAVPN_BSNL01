<!---------------------------------------------------------------------------

###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

----------------------------------------------------------------------------->

<%@ page  import="com.hp.ov.activator.mwfm.servlet.*,    java.net.*"
	 info="Shows the main heading, putting only the options available to the user" 
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
    // Check if there is a valid session available.
    if (session == null || session.getValue (Constants.USER) == null) {
       response.sendRedirect ("sessionError.jsp");
       return;
    }

    // don't allow cacheing
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
	request.setCharacterEncoding("UTF-8");

    // get the parameter that indicates which sub-menu to build
    String req = (String)request.getParameter("menu");
    String wfName=null;
%>

<%@ include file="actionMenus.jsp" %>
<html>
<body background="../images/stripe.gif">

<%
    if (req.equals("workflow")) {
%>
        <%=buildWorkflowActions(session)%>
<%  }
    else if (req.equals("job")) {
%>
        <%=buildJobActions()%>
<%  } 
    else if (req.equals("message")) {
%>
        <%=buildMessageActions() %>
<%  } 
    else if (req.equals("logFiles")){
%>
        <%=buildLogFileMenu(session)%>
<%  }
    else if (req.equals("help")) {
%>
        <%= buildHelpActions()%>
<%  }
    else if (req.equals("test"))  {
%>
        <%= buildTestActions()%>
<%  }
    else if (req.equals("jobSpecific"))  {
%>
        <%= buildJobSpecificActions(request.getParameter("perm"))%>
<%  }
    else if (req.equals("config"))  {
%>
        <%= buildConfigActions(request.getServerName(),(String)session.getAttribute(Constants.DISPLAY_STATISTICS))%>
<%  }
    else if (req.equals("tools"))  {
%>
        <%= buildToolsActions(session)%>
<%  }
    else if (req.equals("backup"))  {
%>
        <%= buildBackupActions()%>
<%  }
    else if (req.equals("equipmentList"))  {
%>
        <%= buildEquipmentActions(request.getParameter("perm"), "true")%>
<%  }
    else if (req.equals("schedulingList"))  {
%>
        <%= buildSchedulingActions(request.getParameter("delete"), request.getParameter("active"))%>
<%  }
    else if (req.equals("retrievalList"))  {
%>
        <%= buildRetrievalActions(request.getParameter("delete"), request.getParameter("active"))%>
<%  }
    else if (req.equals("equipmentConfiguration"))  {
%>
        <%= buildEquipmentActions(request.getParameter("delete"), "true")%>
<%  }
    else if (req.equals("equipmentName"))  {
%>
        <%= buildEquipmentNameActions()%>
<%  }
%>

</body>
</html>


