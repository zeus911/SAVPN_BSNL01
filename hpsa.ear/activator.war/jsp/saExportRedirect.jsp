<%@ page import="java.text.SimpleDateFormat,
                 java.text.DateFormat,
                 java.sql.*,
                 javax.sql.DataSource,
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
    final static String endDateIsLessThanBegin = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("603", "Begin date is bigger than end date.");
    final static String notAdmin        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("596", "You are not administrator.");
    final static String closeButton     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("436", "Close");
    final static String closeerror      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("608", "Error occurred. Probably you navigated out of main SA page.");
%>

<%
    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    session.removeAttribute("auditClnFilter");
%>

<jsp:useBean id="statExpFilter" scope="session" class="com.hp.ov.activator.mwfm.servlet.operatorFilterBean"/>
<jsp:setProperty name="statExpFilter" property="*" />

<%
    if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == false) {
%>
    <script>
        alert("<%=notAdmin%>");
    </script>
<%
       return;
    }
    String formType = request.getParameter("formType");


    //Validate form
    String errorMessage = "";
    SimpleDateFormat df = (SimpleDateFormat)DateFormat.getDateInstance(DateFormat.SHORT);
    SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);

    //is begin date corect?
    if(errorMessage.equals("")){
        errorMessage = (statExpFilter.getBeginDate().equals("")?badBeginDate:"");
    }
    if(errorMessage.equals("") ){
        try{
            errorMessage = (statExpFilter.parseBeginDate(df, tf)?"":badBeginDate);
			if(!(errorMessage.equals(""))){
			statExpFilter.setBeginDate("");
			statExpFilter.setBeginTime("");
			statExpFilter.setEndDate("");
			statExpFilter.setEndTime("");
			}
        }catch(Exception e){
            errorMessage = badBeginDate;
        }
    }

    //is end date corect?
    if(errorMessage.equals("")){
        errorMessage = (statExpFilter.getEndDate().equals("")?badEndDate:"");
    }
    if(errorMessage.equals("")){
        try{
            errorMessage = (statExpFilter.parseEndDate(df, tf)?"":badEndDate);
			if(!(errorMessage.equals(""))){
			statExpFilter.setBeginDate("");
			statExpFilter.setBeginTime("");
			statExpFilter.setEndDate("");
			statExpFilter.setEndTime("");
			}
        }catch(Exception e){
            errorMessage = badEndDate;
        }
    }

    // end date should be more than begin date
    if(errorMessage.equals("") && statExpFilter.getParsedBeginDate().compareTo(statExpFilter.getParsedEndDate())>0 ){
        errorMessage = endDateIsLessThanBegin;
			statExpFilter.setBeginDate("");
			statExpFilter.setBeginTime("");
			statExpFilter.setEndDate("");
			statExpFilter.setEndTime("");
	}


    if(errorMessage.equals("")){
%>
<script>
    window.onerror = handleError;

    function handleError(){
        document.write("<%=closeerror%><br>");
        document.write("<input type='button' onclick='window.close();' value='<%=closeButton%>'>");
        return true;
    }

    opener.top.location.href="/activator/statExport/<%=formType+"_export.csv"%>?formType=<%=formType%>";
    window.close();
</script>
<%
    }else{
        //forward back
%>
<script>
        location.href="saExportFilter.jsp?errorMsg=<%=errorMessage%>&formType=<%=formType%>";
</script>
<%
    }
%>
