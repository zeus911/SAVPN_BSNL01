<!---------------------------------------------------------------------------

###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

----------------------------------------------------------------------------->
<%@page info="View JSP for bean audit_record"
      import="com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.inventory.SetupCE_Workorder,
              com.hp.ov.activator.mwfm.*,java.io.*,javax.sql.*,java.sql.*,
              java.util.*"
      session="true"
      contentType="text/html;charset=utf-8"
%>
<%
    if (session == null || session.getValue(Constants.USER) == null) {
        response.sendRedirect("sessionError.jsp");
        return;
    }
	BufferedReader br = null;
    request.setCharacterEncoding("UTF-8");
	
    String workorderfile   = request.getParameter("workorderfile");
	String serviceid = request.getParameter("serviceid");
%>

<html>
<head>
  <title>HP Service Activator</title>
  <script language="JavaScript" src="/activator/javascript/checks.js"></script>
  <script language="JavaScript" src="/activator/javascript/table.js"></script>
  <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">
  <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
 <script LANGUAGE="JavaScript" TYPE="text/javascript">
function openPage(workorderfile)
{
var page= 'saveWorkOrder.jsp?WorkOrderFile= ' + workorderfile;
self.location.href = page;
}
</script>
</head>
<body>
<center><h2><%=workorderfile%></h2></center>
<%
   	Connection	connection = null;
    try {
			DataSource dataSource = (DataSource)session.getAttribute(Constants.DATASOURCE);
			connection = (Connection)dataSource.getConnection();
			SetupCE_Workorder bean = SetupCE_Workorder.findByPrimaryKey(connection,serviceid);
			String wo = bean.getWo_content();
			InputStream is  = new ByteArrayInputStream(wo.getBytes("UTF-8"));
			br = new BufferedReader(new InputStreamReader(is));
			session.setAttribute("WorkOrderFile", workorderfile); //richa
			session.setAttribute("WorkOrderContent", wo); //richa


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
				//		  System.out.println("asdasda" +  str.indexOf("="));

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
             // if (str.trim().length() > idx) {
                td2 = str.substring(idx+1).trim();
            //  }
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
		connection.close();
      }catch (Exception ignoreMe) {}
   }
%>
 </body>

<!--<td class="tableCell" align="right"><a  href="saveWorkOrder.jsp?&WorkOrderFile= " + workorderfile> <img src="../images/tools/save.gif" border="0" title="Return"></a></center></td>-->
<center><a href="javascript:history.go(-1);"><img src="../images/tools/back.gif" border="0" title="Return"></a></center>
 <table width="100%" border="2">
<tr> 
<td class="tableCell" width="70%" border="1" align="right"><input type=button value="Save" onclick= "openPage('<%=workorderfile%>');" ></td>
<td class="tableCell" width="30%" border="1" align="left"><input type=button value="Print" onclick= "javascript:window.print();" ></td>
</tr>
  </table>
 
</html>
