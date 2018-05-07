<%@ page import="com.hp.ov.activator.mwfm.*, com.hp.ov.activator.vpn.inventory.Queue, 											 com.hp.ov.activator.vpn.inventory.Queue_Message,
                 com.hp.ov.activator.mwfm.servlet.*, java.sql.*,javax.sql.*,
                 com.hp.ov.activator.mwfm.servlet.*, 
                 com.hp.ov.activator.mwfm.component.WFNoSuchQueueException,
                 java.text.DateFormat,
                 java.text.MessageFormat,
                 java.util.Date,
                 java.net.*"
         info="Display all messages." 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
 <jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.Queue_Message" />


<head>
    <title>HP Service Activator</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <link rel="stylesheet" type="text/css" href="../css/activator.css">
    <script language="JavaScript" src="../javascript/saUtilities.js"></script>
</head>

<body>
 <%
    if (session == null || session.getValue(Constants.USER) == null) {
        response.sendRedirect("sessionError.jsp");
        return;
    }
	String unableToDeleteMsg  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("313", "Unable to delete message: "); 

	 request.setCharacterEncoding("UTF-8");
	 String delMsgSuccess   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("312", "Message successfully deleted."); 
   // String workorderfile   = request.getParameter("workorderfile");
		 String messageId   = request.getParameter("msgId");
		 String queueName   = request.getParameter("queue");
		 String fromCount  = (String) request.getParameter("fromCount");
        String numberOfMessages  = (String) request.getParameter("numberOfMessages");
        String maxRec = (String) request.getParameter("maxRec");
        int fromCountInt = 1;
		   if(maxRec != null && fromCount != null && numberOfMessages != null ) {
          fromCountInt = Integer.parseInt(fromCount);
          int numberOfMessagesInt = Integer.parseInt(numberOfMessages);
          int maxRecInt = Integer.parseInt(maxRec);
          if (fromCountInt > (numberOfMessagesInt-1)) {
            fromCountInt = fromCountInt - maxRecInt;
           }
           session.removeAttribute("REC_START_NUM");
           session.setAttribute("REC_START_NUM",fromCountInt+"");
        }
	 DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);
   Connection connection = null;
	Queue_Message queue = null;

	try
	{
		connection = (Connection)dataSource.getConnection();
			queue = bean.findByPrimaryKey( connection,messageId );
			queue.delete(connection);
			%>

			  <script language="JavaScript">
                writeToMsgLine("<%=delMsgSuccess%>");
			   top.processFrame.location.href = '../blank.html';
			//  parent.main.location.href='saMsgFrame.jsp';
            </script>
			<%
	}
	catch(SQLException e)
	 {
		System.out.println("exception during database connection"+e);
		 String err = null;
            if (e.getMessage() != null) {
                String tmp = e.getMessage().replace('\n',' ');
                err = tmp.replace('"',' ');
            }
            else {
                err = e.toString().replace('\n',' ');
%>
                <script language="JavaScript">
                   alert("HP Service Activator" + "\n\n" + "<%=unableToDeleteMsg%>" +  "<%=err%>");
                </script>
<%
            } 
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
			System.out.println("exception in finally block"+fi);
		}
	}

   %>
</body>
</html>
