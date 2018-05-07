<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>

<%-- ************************************************************** --%>
<%--                                                                --%>
<%-- ShowServiceUpdateTime.jsp                                      --%>
<%--                                                                --%>
<%-- Parameters:                                                    --%>
<%--  CustomerId: customer identifier                               --%>
<%--  ServiceId: service identifier                                 --%>
<%--  LastTime: timestamp to compare                                --%>
<%--                                                                --%>
<%-- Description:                                                   --%>
<%--  It compares LastTime with the lastUpdate time of the          --%>
<%--  customer or service and if it's required generates            --%>
<%--  javascript code to refresh services view in CRM Portal        --%>
<%--                                                                --%>
<%-- ************************************************************** --%>

<%@ page contentType="text/html; charset=UTF-8"
         language="java"
          import="com.hp.ov.activator.crmportal.bean.Service,com.hp.ov.activator.crmportal.utils.DatabasePool,
                 com.hp.ov.activator.crmportal.helpers.PortalSyncListener,
                 java.sql.*,
                 com.hp.ov.activator.crmportal.bean.Customer"%>
<%
  response.setDateHeader("Expires",0);
  response.setHeader("Pragma","no-cache");
%>
<html>
<head>
    <META Http-Equiv="Cache-Control" Content="no-cache">
    <META Http-Equiv="Pragma" Content="no-cache">
    <META Http-Equiv="Expires" Content="-1">
</head>

<%
// System.out.println("ShowServiceUpdateTime :::::::");
  // No update by default
  boolean doUpdate = false;
  // Fetching request parameters
  String customerId = request.getParameter("CustomerId");
  String serviceId = request.getParameter("ServiceId");
  long lastTime;
  try{
    lastTime = Long.parseLong(request.getParameter("LastTime"));
  }catch(Exception ex){
    lastTime = 0;
  }
  Connection connection = null;
  PreparedStatement statement = null;
  ResultSet resultSet = null;
  DatabasePool dbp =  (DatabasePool) session.getAttribute("database_pool");
  try{
    //connection = PortalSyncListener.dbp.getConnection();
	connection = (Connection) dbp.getConnection();
    final Service service = Service.findByPrimaryKey(connection, String.valueOf(serviceId));
    final Customer customer = Customer.findByPrimaryKey(connection, String.valueOf(customerId));

    // If service parameter was passed then check service's last time first
    if(service != null && service.getLastupdatetime() > lastTime){
      doUpdate = true;
      lastTime = service.getLastupdatetime();
    }else if(customer != null && customer.getLastupdatetime() > lastTime){
      // If customer parameter is passed then check last time of the customer
      doUpdate = true;
      lastTime = customer.getLastupdatetime();
    }else{
      // If the customer's last time is less then LastTime parameter then there could be customer's services
      // with the last time greater then LastTime
      String query = "select max(lastupdatetime) from crm_service where customerid = ? and lastupdatetime > ?";

      statement = connection.prepareStatement(query);
      statement.setString(1, customerId);
      statement.setLong(2, lastTime);

      resultSet = statement.executeQuery();
      if(resultSet.next()){
        lastTime = resultSet.getLong(1);
        doUpdate = lastTime > 0;
      }
    }

  }catch(Exception ex){
    // doesn't matter
  }finally{
   
      if(resultSet != null)
        resultSet.close();
      if(statement != null)
        statement.close();
    if(connection != null)
   // PortalSyncListener.dbp.releaseConnection(connection);
	 dbp.releaseConnection(connection);
  }
%>
<script>
  function test(){
    return true;
  }
  function doReload(){
	
       if(<%=doUpdate%>)
	  {
      parent.doUpdate(<%=lastTime%>);
    }
  }

</script>
<body onload="doReload();"></body>
</html>