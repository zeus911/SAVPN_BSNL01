<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page import="java.sql.Connection,java.sql.ResultSet,java.sql.SQLException,java.sql.Statement,com.hp.ov.activator.db.DBUtils,com.hp.ov.activator.util.EncryptDecrypt" %>
<%
// Get all information from input
String userName = request.getParameter("user");
String password = request.getParameter("password");
String newPassword = request.getParameter("newpassword");

if (userName==null||userName.equals("")||newPassword==null||newPassword.equals("")){
response.sendRedirect("loginError.jsp?errorType=password_validation");

}else{


// Check if user is valid
Connection conn = null;
Statement stat = null;
ResultSet rs = null;

try {
      conn = DBUtils.getSystemDBConnection(false);
      
      com.hp.ov.activator.mwfm.engine.module.umm.beans.UserInfo userInfo = com.hp.ov.activator.mwfm.engine.module.umm.beans.UserInfo.findByName(conn, userName);
      
      if(userInfo!=null){
      String storedPassword = userInfo.getPassword();

	 String passwordEncripted = EncryptDecrypt.encrypt(password == null ? "" : password);
         boolean checkResult = false;
         if (!passwordEncripted.equals(storedPassword)) {
	   System.out.println("password wrong!");
           response.sendRedirect("loginError.jsp?errorType=password_validation");
         }	 

	 }else{
	   System.out.println("user is null!");
           response.sendRedirect("loginError.jsp?errorType=password_validation");
	 }
      
// Update signal for first time login and Change Password in database
      
      String enctypedNewPassword = EncryptDecrypt.encrypt(newPassword);
      userInfo.setPassword(enctypedNewPassword);
      userInfo.setFirstTimeLogin(false);
      userInfo.update(conn);
      stat = conn.createStatement();
      stat.executeUpdate("Insert into passwordcount values(passworddict_passwordid_seq.nextval,"+userInfo.getUserid()+",'"+newPassword+"',sysdate)");
      conn.commit();
      boolean postData = false;
%>
<html>
    <head>
        <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
    </head>
    <body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
		<form action="/activator/login" method="post" id="login">
			<input name="user" value="<%=userName%>"><input name="password" value="<%=newPassword%>">
		</form>
		<script>
			document.getElementById("login").submit();
		</script>
	</body>
</html>

<%

      }catch(Exception e){
      e.printStackTrace();

      }finally{
      stat.close();
      if(rs!=null)  rs.close();
      conn.close();
      }
}

%>

      

