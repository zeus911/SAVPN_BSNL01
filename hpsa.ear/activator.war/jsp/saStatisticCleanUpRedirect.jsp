<%@ page import="java.text.SimpleDateFormat,
                 java.sql.*,
                 java.text.DateFormat,
                 javax.sql.DataSource,
                 com.hp.ov.activator.stats.AdministratorDataProducer,
                 com.hp.ov.activator.stats.OperatorDataProducer,
                 com.hp.ov.activator.mwfm.servlet.*"
         info="Checks for valid submit data."
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%!
    //I18N strings
    final static String badBeginDate    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("690", "Wrong begin date or time.");
    final static String badEndDate      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("601", "Wrong end date or time.");
    final static String success         = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("615", "Database updated successfuly.");
    final static String errMsg          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("889", "Unable to clean statistical information.");
    final static String endDateIsLessThanBegin = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("603", "Begin date is bigger than end date.");
%>

<%
    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    session.removeAttribute("auditClnFilter");
%>

<jsp:useBean id="statClnFilter" scope="session" class="com.hp.ov.activator.mwfm.servlet.operatorFilterBean"/>
<jsp:setProperty name="statClnFilter" property="*" />

<%  //Validate form
    String errorMessage = "";
    SimpleDateFormat df = (SimpleDateFormat)DateFormat.getDateInstance(DateFormat.SHORT);
    SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);

    //is begin date corect?
    //if(errorMessage.equals("")){
    //    errorMessage = (statClnFilter.getBeginDate().equals("")?badBeginDate:"");
    //}
	 //is begin date corect?
    if(errorMessage.equals("") && !statClnFilter.getBeginDate().trim().equals("")){
        try{
            errorMessage = (statClnFilter.parseBeginDate(df, tf)?"":badBeginDate);
			if(!(errorMessage.equals(""))){
			statClnFilter.setBeginDate("");
			statClnFilter.setBeginTime("");
			statClnFilter.setEndDate("");
			statClnFilter.setEndTime("");
			}
        }catch(Exception e){
            errorMessage = badBeginDate;
        }
    } else {

    }

    //is end date corect?
    if(errorMessage.equals("")){
        errorMessage = (statClnFilter.getEndDate().equals("")?badEndDate:"");
    }
    if(errorMessage.equals("")){
        try{
            errorMessage = (statClnFilter.parseEndDate(df, tf)?"":badEndDate);
			if(!(errorMessage.equals(""))){
			statClnFilter.setBeginDate("");
			statClnFilter.setBeginTime("");
			statClnFilter.setEndDate("");
			statClnFilter.setEndTime("");
			}
        }catch(Exception e){
            errorMessage = badEndDate;
        }
    }

    // end date should be more than begin date
    if(statClnFilter.getParsedBeginDate() != null) {
        if(errorMessage.equals("") && statClnFilter.getParsedBeginDate().compareTo(statClnFilter.getParsedEndDate())>0 ){
            errorMessage = endDateIsLessThanBegin;
			statClnFilter.setBeginDate("");
			statClnFilter.setBeginTime("");
			statClnFilter.setEndDate("");
			statClnFilter.setEndTime("");
        }
    }

    //perform delete
    if(errorMessage.equals("")){
        DataSource dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
        Connection connection = null;
        Statement stmt = null;
        try {
            connection = (Connection) dataSource.getConnection();
            stmt = connection.createStatement();
            int adminRecDel = AdministratorDataProducer.cleanUp(stmt,
                    statClnFilter.getParsedBeginDate(), statClnFilter.getParsedEndDate(), statClnFilter.getHostName());
            int operRecDel  = OperatorDataProducer.cleanUp(stmt,
                    statClnFilter.getParsedBeginDate(), statClnFilter.getParsedEndDate(), statClnFilter.getHostName());
        }catch(Exception e){
        String err = null;
            if (e.getMessage() != null) {
                String tmp = e.getMessage().replace('\n',' ');
                err = tmp.replace('"',' ');
            }
            else
                err = e.toString().replace('\n',' ');
%>
      <SCRIPT LANGUAGE="JavaScript"> alert("HP Service Activator" + "\n\n" + "<%=errMsg%> :  <%=err%>"); </SCRIPT>
<%
        } finally {
            try {
                if (stmt != null) stmt.close();
            } catch (Exception e) {;}
              if (connection != null)
               connection.close();
        }
%>
<script>
        window.close();
</script>
<%
    }else{
        //forward back
%>
<script>
        location.href="saStatisticCleanUp.jsp?errorMsg=<%=errorMessage%>";
</script>
<%
    }
%>
