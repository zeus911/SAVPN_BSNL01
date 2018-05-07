<%@page info="Update JSP for bean SchSettings"
      import="com.hp.ov.activator.mwfm.servlet.*,
              com.hp.ov.activator.mwfm.*,
              java.sql.*,
              javax.sql.DataSource,
              java.net.*,com.hp.ov.activator.vpn.inventory.SchSettings"
      session="true"
      contentType="text/html;charset=utf-8"
%>

<!---------------------------------------------------------------------
-- Automatically generated code.
-- hp OpenView Service Activator InventoryBuilder 4.0
--
-- (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
----------------------------------------------------------------------->

<%
    if (session == null || session.getAttribute(Constants.USER) == null) {
        response.sendRedirect("/activator/jsp/sessionError.jsp");
        return;
    }

    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.SchSettings" />
<jsp:setProperty name="bean" property="*"/>

<% DataSource dataSource = (DataSource) session.getAttribute(Constants.DATASOURCE);
   Connection connection = null;
   try { 
     connection = (Connection) dataSource.getConnection();
	 String temp = (String)session.getAttribute("toggle_status");
	 String value="";
   if((temp==null)||(temp.equalsIgnoreCase("")))
   {
    SchSettings schObj = SchSettings.findByPrimaryKey(connection,"stop");
	if((schObj.getValue()==null)||(schObj.getValue().equalsIgnoreCase(""))||(schObj.getValue().equalsIgnoreCase("true")))
		value = "OFF";
	else
	  	value = "ON";
  }
  else
  {
    if(temp.equalsIgnoreCase("OFF"))
	{
		value = "ON";
	    bean.setKey("stop");
	    bean.setValue("false");
	 }
	else
	 {
		value = "OFF";
		bean.setKey("stop");
		bean.setValue("true");
	}
	bean.update( connection );

  }
session.setAttribute("toggle_status",value);
 String mode = (String)request.getParameter("mode");
  if (mode == null || !mode.equals("init")) 
  {
%>
 <%=value%>
<%
  }//end of if
 } // end of try
 catch (Exception e) 
 { 
	System.out.println(e);
 } finally { 
       connection.close(); 
   } 
%>
