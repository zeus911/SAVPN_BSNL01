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
                 com.hp.ov.activator.stats.OperatorDataProducer,
                 com.hp.ov.activator.stats.OperatorTableDataProducer,
                 com.hp.ov.activator.mwfm.servlet.*"
         info="Display audit filter." 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%!
    //I18N strings
    final static String header           = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("359", "Operator Statistics");
    final static String headerFor        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("876", "for");

    final static String statsChart       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("877", "Statistical Chart");
    final static String statsTable       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("878", "Statistical Table");
    final static String nothingToDisplay = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("879", "Nothing to display.");
    final static String notAdmin        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("596", "You are not administrator.");

    //Static table headers
    final static String wfName           = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("6", "Workflow");
    
    final static String allHosts         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("613", "All Hosts");
%>

<%
    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
%>

<html>
<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
  <link rel="stylesheet" type="text/css" href="/activator/css/saContextMenu.css">
  <script language="JavaScript" src="/activator/javascript/table.js"></script>
  <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
  <script language="JavaScript" src="/activator/javascript/saContextMenu.js"></script>
</head>
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<%
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
%>
<jsp:useBean id="operatorFilter" scope="session" class="com.hp.ov.activator.mwfm.servlet.operatorFilterBean"/>
<%
  String hostName=operatorFilter.getHostName();

  if (hostName.equals("")) {
    hostName=allHosts;
  }
%>
<table cellpadding="0" cellspacing="0" width="100%">
  <tr align=left>
    <td nowrap class="frameHead"><%=header%>&nbsp;<%=headerFor%>&nbsp;<%=hostName%></td>
  </tr>
</table>

<%
    HashMap availTbHeaders = OperatorTableDataProducer.getTableHeaders();
    String[] selectedTableHeaders = operatorFilter.getSelectedTableHeader();
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
    if(operatorFilter.isDisplayChartChecked() && session.getAttribute("operatorFilter_JFreeChartDataset")!=null){
        out.println("\t<tr id=\"header\"><td class=\"statsNote\" align=\"center\" colspan=\"7\">"+statsChart+"</td></tr>");
%>
    <tr id="header">
    <td colspan="7" align="center">
    <img src='/activator/chart?width=650&height=400&bean=operatorFilter&dummy=<%=(new java.util.Date()).getTime()%>' width="650" height="400" usemap="#chart" border="0">
    </td>
    </tr>
<%
        out.println("\t<tr><td colspan=\"7\">&nbsp;</td></tr>");
        out.println("\t<tr><td colspan=\"7\">&nbsp;</td></tr>");
    }

    //Print out data table
    if(selectedTableHeaders.length > 0){
        OperatorTableDataProducer otdp = new OperatorTableDataProducer();
        otdp.setFilterBean(operatorFilter);
        DateFormat df = DateFormat.getInstance();
        SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);
        SimpleDateFormat ftf = (SimpleDateFormat)session.getAttribute(Constants.FULL_TIME_FORMAT);
        otdp.setFormaters(ftf, NumberFormat.getInstance());
        HashSet selWF = new HashSet();
        for(int i=0; i<operatorFilter.getSelectedWorkflows().length;i++){
            selWF.add(operatorFilter.getSelectedWorkflows()[i]);
        }

        out.println("\t<tr id=\"header\"><td class=\"statsNote\" align=\"center\" colspan=\"7\">"+statsTable+" <br/>("+df.format(operatorFilter.getParsedBeginDate())+" - "+df.format(operatorFilter.getParsedEndDate())+")</td></tr>");
        try{
            Statement stmt = connection.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet rset = otdp.produceResultSet(stmt);
            int splits = selectedTableHeaders.length/6+(selectedTableHeaders.length%6>0?1:0);
            for(int sp=0;sp<splits; sp++ ){

                //print header
                int totalHeaders = (selectedTableHeaders.length - ((sp+1)*6)>0?(sp+1)*6:selectedTableHeaders.length);
                out.println("\t<tr id=\"header\">");
                out.println("\t\t<td class=\"mainHeading\">"+wfName+"</td>");
                for (int i = sp*6; i < totalHeaders; i++) {
                    Integer index = new Integer(selectedTableHeaders[i]);
                    out.println("\t\t<td class=\"mainHeading\">"+availTbHeaders.get(index)+"</td>");
                }
                out.println("\t</tr>");

                //print units
                out.println("\t<tr id=\"header\">");
                out.println("\t\t<td class=\"mainHeading\">&nbsp;</td>");
                for (int i = sp*6; i < totalHeaders; i++) {
                    String val = otdp.getPreparedUnit(selectedTableHeaders[i]);
                    out.println("\t\t<td class=\"mainHeading\">"+val+"</td>");
                }
                out.println("\t</tr>");

                //Print data
                int numRows = 1;
                while(rset != null && rset.next()){
                    String rowClass = (numRows%2 == 0) ? "tableEvenRowNoPointer" : "tableOddRowNoPointer";
                    String wfName = rset.getString(OperatorTableDataProducer.WORKFLOWNAME_SQL);
                    selWF.remove(wfName);
    %>
        <tr class="<%=rowClass%>" >
            <td class="tableCellNoPointer" nowrap align="center"><%=wfName%></td>
    <%
                    for (int i = sp*6; i < totalHeaders; i++) {
                        String val= otdp.getPreparedData(rset,selectedTableHeaders[i]);
                        out.println("\t\t<td class=\"tableCellNoPointer\" >"+val+"</td>");
                    }
                    out.println("\t</tr>");
                    numRows++;
                }

                //if workFlow is sellected, but it doesn't contain any data we are going to dysplay '-'
                Iterator set = selWF.iterator();
                while(set.hasNext()){
                    String rowClass = (numRows%2 == 0) ? "tableEvenRowNoPointer" : "tableOddRowNoPointer";
                    String wfName = (String)set.next();
    %>
        <tr class="<%=rowClass%>">
            <td class="tableCellNoPointer" nowrap align="center"><%=wfName%></td>
    <%
                    for (int i = sp*6; i < totalHeaders; i++) {
                        out.println("\t\t<td class=\"tableCellNoPointer\" >-</td>");
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
    if(connection!= null){
        connection.close();
    }
    if(operatorFilter.isDisplayChartChecked() && session.getAttribute("operatorFilter_tooltips")!=null){
        out.println(session.getAttribute("operatorFilter_tooltips"));
    }
    if(!operatorFilter.isDisplayChartChecked() && selectedTableHeaders.length == 0){
        out.println(nothingToDisplay);
    }
%>
</body>
</html>

