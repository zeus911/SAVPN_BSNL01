<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page autoFlush="true" 
         import="java.sql.*,
                 javax.sql.*,
                 java.util.*,
                 java.text.*,
                 com.hp.ov.activator.stats.AdministratorDataProducer,
                 com.hp.ov.activator.stats.AdministratorTableDataProducer,
                 com.hp.ov.activator.mwfm.servlet.*"
         info="Display audit filter." 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%!
    //I18N strings
    final static String header           = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("360", "Administrator Statistics");
    final static String headerFor        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("876", "for");

    final static String statsChart       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("877", "Statistical Chart");
    final static String statsTable       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("878", "Statistical Table");   
    final static String nothingToDisplay = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("879", "Nothing to display.");
    final static String notAdmin         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("596", "You are not administrator.");
%>
<jsp:useBean id="administratorFilter" scope="session" class="com.hp.ov.activator.mwfm.servlet.administratorFilterBean"/>
<html>
<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
  <link rel="stylesheet" type="text/css" href="/activator/css/saTabs.css">
  <link rel="stylesheet" type="text/css" href="/activator/css/saContextMenu.css">
  <script language="JavaScript" src="/activator/javascript/table.js"></script>
  <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
  <script language="JavaScript" src="/activator/javascript/saContextMenu.js"></script>
</head>
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<%
    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    // Check if there is a valid session available.
    if (session == null || session.getAttribute(Constants.USER) == null) {
%>
    <script>
        window.top.topFrame.location = window.top.topFrame.location;
    </script>
<%
       return;
    }
    if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == false) {
%>
    <script>
        alert("<%=notAdmin%>");
    </script>
<%
       return;
    }

    String hostName=administratorFilter.getHostName();
%>
<table cellpadding="0" cellspacing="0" width="100%">
  <tr align=left>
    <td nowrap class="frameHead"><%=header%>
<%
  if (!hostName.equals("")) {
%>&nbsp;<%=headerFor%>&nbsp;<%=hostName%><%
  }
%>
    </td>
  </tr>
</table>

<%
    HashMap availTbHeaders = AdministratorTableDataProducer.getTableHeaders();
    String[] selectedTableHeaders = administratorFilter.getSelectedTableHeader();
    Connection connection = null;
    if(selectedTableHeaders.length > 0){
        try { 
            DataSource dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
            connection = (Connection) dataSource.getConnection();
        } 
        catch (Exception e){
    %>
          <SCRIPT LANGUAGE="JavaScript"> alert("<%= ExceptionHandler.handle(e) %>"); </SCRIPT>
    <%
        }
    }
%>
    <table class="statsTable">
<%
    if(administratorFilter.isDisplayChartChecked() && session.getAttribute("administratorFilter_JFreeChartDataset")!=null){
        out.println("\t<tr id=\"header\"><td class=\"statsNote\" align=\"center\" colspan=\"7\">"+statsChart+"</td></tr>");
%>
    <tr id="header">
    <td colspan="7" align="center">
    <img src='/activator/chart?width=650&height=400&bean=administratorFilter&<%=(new java.util.Date()).getTime()%>' width="650" height="400" usemap="#chart" border="0">
    </td>
    </tr>
<%
        out.println("\t<tr><td colspan=\"7\">&nbsp;</td></tr>");
        out.println("\t<tr><td colspan=\"7\">&nbsp;</td></tr>");
    }

    //Print out data table
    if(selectedTableHeaders.length > 0){
        AdministratorTableDataProducer atdp = new AdministratorTableDataProducer();
        atdp.setFilterBean(administratorFilter);
        DateFormat df = DateFormat.getInstance();
        SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);
        SimpleDateFormat ftf = (SimpleDateFormat)session.getAttribute(Constants.FULL_TIME_FORMAT);
        atdp.setFormaters(ftf, NumberFormat.getInstance());
        
        out.println("\t<tr id=\"header\"><td class=\"statsNote\" align=\"center\" colspan=\"7\">"+statsTable+" <br/>("+
                df.format(administratorFilter.getParsedBeginDate())+" - "+df.format(administratorFilter.getParsedEndDate())+
                ")</td></tr>");
        try{
            Statement stmt = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet rset = atdp.produceResultSet(stmt);
            int splits = selectedTableHeaders.length/7+(selectedTableHeaders.length%7>0?1:0);
            for(int sp=0;sp<splits; sp++ ){

                //print header
                int totalHeaders = (selectedTableHeaders.length - ((sp+1)*7)>0?(sp+1)*7:selectedTableHeaders.length);
                out.println("\t<tr id=\"header\">");
                for (int i = sp*7; i < totalHeaders; i++) {
                    Integer index = new Integer(selectedTableHeaders[i]);
                    out.println("\t\t<td class=\"mainHeading\">"+availTbHeaders.get(index)+"</td>");
                }
                out.println("\t</tr>");

                //print units
                //out.println("\t<tr id=\"header\">");
                //for (int i = sp*7; i < totalHeaders; i++) {
                //    String val = atdp.getPreparedUnit(selectedTableHeaders[i]);
                //    out.println("\t\t<td class=\"mainHeading\">"+val+"</td>");
                //}
                //out.println("\t</tr>");

                //Print data
                int numRows = 1;
                if(rset != null && rset.next()){
                    String rowClass = (numRows%2 == 0) ? "tableEvenRowNoPointer" : "tableOddRowNoPointer";
                    out.println("\t<tr class="+rowClass+" >");
                    for (int i = sp*7; i < totalHeaders; i++) {
                        String val= atdp.getPreparedData(rset,selectedTableHeaders[i]);
                        out.println("\t\t<td class=\"tableCellNoPointer\" >"+val+"</td>");
                    }
                    out.println("\t</tr>");
                    numRows++;
                }

                //separator
                out.println("\t<tr><td colspan=\"7\">&nbsp;</td></tr>");
                rset.beforeFirst();
            }
            rset.close();
            stmt.close();
        }catch(Exception e){
             e.printStackTrace();
        }
    }
%>
    </table>
<%
    if(connection!=null){
        connection.close();
    }
    if(administratorFilter.isDisplayChartChecked() && session.getAttribute("administratorFilter_tooltips")!=null){
        out.println(session.getAttribute("administratorFilter_tooltips"));
    }
    if(!administratorFilter.isDisplayChartChecked() && selectedTableHeaders.length == 0){
        out.println(nothingToDisplay);
    }
%>
</body>
</html>

