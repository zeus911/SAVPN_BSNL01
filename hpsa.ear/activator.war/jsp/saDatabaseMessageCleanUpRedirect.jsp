<%@ page import="java.text.SimpleDateFormat,
                 java.text.DateFormat,
                 com.hp.ov.activator.mwfm.*,
                 com.hp.ov.activator.mwfm.servlet.Constants,
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
    final static String errMsg          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1140", "Unable to clean database messages.");
    final static String endDateIsLessThanBegin = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("603", "Begin date is bigger than end date.");
%>

<%
    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    session.removeAttribute("auditClnFilter");
%>

<jsp:useBean id="dbMsgClnFilter" scope="session" class="com.hp.ov.activator.mwfm.servlet.operatorFilterBean"/>
<jsp:setProperty name="dbMsgClnFilter" property="*" />

<%  //Validate form
    String errorMessage = "";
    SimpleDateFormat df = (SimpleDateFormat)DateFormat.getDateInstance(DateFormat.SHORT);
    SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);

    //is begin date corect?
    //if(errorMessage.equals("")){
    //    errorMessage = (dbMsgClnFilter.getBeginDate().equals("")?badBeginDate:"");
    //}
	 //is begin date corect?
    if(errorMessage.equals("") && !dbMsgClnFilter.getBeginDate().trim().equals("")){
        try{
            errorMessage = (dbMsgClnFilter.parseBeginDate(df, tf)?"":badBeginDate);
			if(!(errorMessage.equals(""))){
			dbMsgClnFilter.setBeginDate("");
			dbMsgClnFilter.setBeginTime("");
			dbMsgClnFilter.setEndDate("");
			dbMsgClnFilter.setEndTime("");
			}
        }catch(Exception e){
            errorMessage = badBeginDate;
        }
    } else {

    }

    //is end date corect?
    if(errorMessage.equals("")){
        errorMessage = (dbMsgClnFilter.getEndDate().equals("")?badEndDate:"");
    }
    if(errorMessage.equals("")){
        try{
            errorMessage = (dbMsgClnFilter.parseEndDate(df, tf)?"":badEndDate);
			if(!(errorMessage.equals(""))){
			dbMsgClnFilter.setBeginDate("");
			dbMsgClnFilter.setBeginTime("");
			dbMsgClnFilter.setEndDate("");
			dbMsgClnFilter.setEndTime("");
			}
        }catch(Exception e){
            errorMessage = badEndDate;
        }
    }

    // end date should be more than begin date
    if(dbMsgClnFilter.getParsedBeginDate() != null) {
        if(errorMessage.equals("") && dbMsgClnFilter.getParsedBeginDate().compareTo(dbMsgClnFilter.getParsedEndDate())>0 ){
            errorMessage = endDateIsLessThanBegin;
			dbMsgClnFilter.setBeginDate("");
			dbMsgClnFilter.setBeginTime("");
			dbMsgClnFilter.setEndDate("");
			dbMsgClnFilter.setEndTime("");
        }
    }

    //perform delete
    if(errorMessage.equals("")){
        try {
            WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
            int adminRecDel = wfm.deleteDBMsgByHostNameAndTimestamp(dbMsgClnFilter.getParsedBeginDate(), dbMsgClnFilter.getParsedEndDate(), dbMsgClnFilter.getHostName());
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
        location.href="saDatabaseMessageCleanUp.jsp?errorMsg=<%=errorMessage%>";
</script>
<%
    }
%>
