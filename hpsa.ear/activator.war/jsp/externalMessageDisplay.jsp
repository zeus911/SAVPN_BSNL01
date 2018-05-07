
<!---------------------------------------------------------------------------

###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

----------------------------------------------------------------------------->
<%@page info="View JSP for bean audit_record"
      import="com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.inventory.Queue_Message,
                java.sql.*,javax.sql.*,
              com.hp.ov.activator.mwfm.*,java.io.*,
              java.util.*"
      session="true"
      contentType="text/html;charset=utf-8"
%>
<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.Queue_Message" />
<%
    if (session == null || session.getValue(Constants.USER) == null) {
        response.sendRedirect("sessionError.jsp");
        return;
    }

    request.setCharacterEncoding("UTF-8");
   // String workorderfile   = request.getParameter("workorderfile");
  String messageId   = request.getParameter("messageId");
  String fileName   = request.getParameter("fileName");
   DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);
   Connection connection = null;
	Queue_Message extMessage = null;
	String str1 = null;
	BufferedReader br = null;
	//StringBufferInputStream br = null;
	try
	{
		connection = (Connection)dataSource.getConnection();
		//str1 = bean.getClob(connection,messageId);
		extMessage = bean.findByMessageid(connection,messageId);
		if(extMessage!= null)
			str1 = extMessage.getMessage();
		
	InputStream is  = new ByteArrayInputStream(str1.getBytes("UTF-8"));
	br = new BufferedReader(new InputStreamReader(is));
		
		/*InputStream is  =  bean.getClob(connection,messageId);
		System.out.println("the inputstream isssssssss"+is);
	br = new BufferedReader(new InputStreamReader(is));*/
	
	}
	catch(Exception e)
	 {
	
		System.out.println("exception during database connection in externalMessageDisplay"+e);
	}
	finally
	{
		try
		{
			if(connection != null)
				connection.close();
		}
		catch(Exception fi)
		{
		
			System.out.println("exception in finally block in externalMessageDisplay"+fi);

		}
	}
%>

<html>
<head>
  <title>HP Service Activator</title>
  <script language="JavaScript" src="/activator/javascript/checks.js"></script>
  <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
  <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">

</head>
<body>
<center><h2><%= fileName%></h2></center>
<%
      
  try {
  
      String str = null;
%>
     <table align="center" width="50%" border="0">
	   <table align="center" width="50%" border="1">
        <!--tr>
          <td class="mainHeading" valign="top" align="left" colspan=5>&nbsp;</th>
        </tr-->
<%
          boolean textStarted = false;
          int idx = -1;
		  while ((str = br.readLine()) != null) {
		 if (str.length() == 0) {
                if (textStarted == true) {
%>
                  <tr class ="tableOddRow"><td colspan="2" class="tableCell">&nbsp;</td></tr>
<%
                }
                continue;
            }
			
			idx = str.indexOf("=");
			if(idx == -1) {
              str = str.trim();
              if (textStarted == false) {
%>
                  <tr class ="tableOddRow"><td colspan="2" class="tableCell" align="center"><b><%=str %></b></td></tr>
<%
              } else {
%>
                  <tr class ="tableOddRow"><td colspan="2" class="tableCell"><b><%=str %></b></td></tr>
<%
              }
            } else {
              String td1 = str.substring(0, idx).trim();
              String td2 = "&nbsp;";
              if (str.trim().length() > idx + 1) {
                td2 = str.substring(idx + 1).trim();
              }
%>
                  <tr class ="tableOddRow"><td class="tableCell"><%=td1 %></td><td class="tableCell"><%=td2 %></td></tr>

<%
            }

            textStarted = true;
         }
%>
       </table>
     </table>
<% }catch (Exception e) {
    //String err = e.getMessage().replace('\n',' ');
   }finally {
      try {
        br.close();
      }catch (Exception ignoreMe) {}
   }
%>
  </table></center>
    <p><center><a href="javascript:history.go(-1);"><img src="../images/tools/back.gif" border="0" title="Return"></a></center>


</body>
</html>
