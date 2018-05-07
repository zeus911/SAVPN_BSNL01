<%@ page import="java.util.Date,
                 java.sql.Connection,
                 javax.sql.DataSource,
                 java.text.DateFormat,
                 java.text.SimpleDateFormat,
                 com.hp.ov.activator.mwfm.servlet.*,
                 com.hp.ov.activator.stats.Utils,
                 com.hp.ov.activator.stats.OperatorDataProducer,
                 com.hp.ov.activator.stats.DatasetProducer"
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
    final static String badBeginDate    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("600", "Wrong start date or time.");
    final static String badEndDate      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("601", "Wrong end date or time.");
    final static String wfShouldBeSelect       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("740", "At least one workflow should be selected.");
    final static String serieShouldBeSelect    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("602", "At least one data series should be selected.");
    final static String missingDate     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("741", "Missing start or end date.");
    final static String endDateIsLessThanBegin = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("603", "Begin date is bigger than end date.");
    final static String tooManyStepsError      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("604", "Time range is too wide, or time unit is too small.");
    final static String timeUnitIsTooBig       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("605", "Specified time unit is too big for this time range.");
    final static String tooManySteps    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("742", "WARNING:\\nTime range is too wide or time unit is too small.\\n Do you want to continue?");
    final static String noDataForOne    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("743", "No statistical data exist for this workflow.");
    final static String noDataForMore   = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("744", "No statistical data exist for these workflows.");
    final static String notAdmin        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("596", "You are not administrator.");
    final static String noData          = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("607", "There are no data for period: ");

    final static String closeButton     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("436", "Close");
    final static String closeerror      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("608", "Error occurred. Probably you navigated out of main SA page.");
%>
<% 
    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    session.removeAttribute("operatorFilter");
%>

<jsp:useBean id="operatorFilter" scope="session" class="com.hp.ov.activator.mwfm.servlet.operatorFilterBean"/>
<jsp:setProperty name="operatorFilter" property="*" />

<%  
    if (((Boolean) session.getAttribute(Constants.IS_ADMIN)).booleanValue() == false) {
%>
    <script>
        alert("<%=notAdmin%>");
    </script>
<%
       return;
    }
    //Validate form
    String errorMessage = "";
    boolean isTooManySteps = false;
    SimpleDateFormat df = (SimpleDateFormat)DateFormat.getDateInstance(DateFormat.SHORT);
    SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);

    //begin date corect?
    if(errorMessage.equals("") && !operatorFilter.getBeginDate().equals("")){
        try{
            errorMessage = (operatorFilter.parseBeginDate(df,tf)?"":badBeginDate);
        }catch(NullPointerException e){;}
    }

    //end date corect?
    if(errorMessage.equals("") && !operatorFilter.getEndDate().equals("")){
        try{
            errorMessage = (operatorFilter.parseEndDate(df,tf)?"":badEndDate);
        }catch(NullPointerException e){;}
    }
    
    //at least one workflow should be selected
    if(errorMessage.equals("") && operatorFilter.getSelectedWorkflows().length == 0){
        errorMessage = wfShouldBeSelect;
    }

    //Prepare dates for later usability
    if(errorMessage.equals("")){
        try { 
            DataSource dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
            Connection con = (Connection) dataSource.getConnection();
            operatorFilter.prepareParsedDates(con);
            con.close();
        }catch (Exception e){;}
    }
    
    //both dates should be not null
    if(errorMessage.equals("") && (operatorFilter.getParsedBeginDate() == null || operatorFilter.getParsedEndDate() == null) ){
        if(operatorFilter.getSelectedWorkflows().length == 1){
            errorMessage = noDataForOne;
        }else{
            errorMessage = noDataForMore;
        }
    }

    //Do we have data for this period
    if(errorMessage.equals("") && operatorFilter.getParsedBeginDate().getTime() == 0 ){
        errorMessage = noData + DateFormat.getDateTimeInstance().format(operatorFilter.getParsedBeginDate()) + 
                " - " + DateFormat.getDateTimeInstance().format(operatorFilter.getParsedEndDate());
    }

    //end date should be more than begin date
    if(errorMessage.equals("") && operatorFilter.getParsedBeginDate().compareTo(operatorFilter.getParsedEndDate())>0 ){
        errorMessage = endDateIsLessThanBegin;
    }

    //at least one time unit should be in time range
    if(errorMessage.equals("") && operatorFilter.isDisplayChartChecked() && Utils.isTimeUnitTooSmall(
            operatorFilter.getParsedBeginDate(),operatorFilter.getParsedEndDate(),operatorFilter.getTimeUnit()) ){
        errorMessage = timeUnitIsTooBig;
    }

    //if we need chart,at lease one series should be selectes
    if(errorMessage.equals("") && operatorFilter.isDisplayChartChecked() && 
            !operatorFilter.isWorkflowActivationsChecked() &&
            !operatorFilter.isProcessingTimeChecked() &&
            !operatorFilter.isWaitTimeChecked() &&
            !operatorFilter.isPersistenceTimeChecked() &&
            !operatorFilter.isActivationTimeChecked() &&
            !operatorFilter.isIdleTimeChecked() &&
            !operatorFilter.isDurationTimeChecked()){
        errorMessage = serieShouldBeSelect;
    }

    //if we need chart, check for step number
    if(errorMessage.equals("") && operatorFilter.isDisplayChartChecked() &&
            OperatorDataProducer.getTotalSteps(operatorFilter)>600 ){
        isTooManySteps = true;
    }

    //if we need chart, check for step max number
    if(errorMessage.equals("") && operatorFilter.isDisplayChartChecked() &&
            OperatorDataProducer.getTotalSteps(operatorFilter)>4000 ){
        errorMessage = tooManyStepsError ;
    }

    if(errorMessage.equals("")){
        //clean session
        session.removeAttribute("operatorFilter"+DatasetProducer.BEAN_EXTENSION);
        
        //Start dataProducer
        String threadName = "Stat_operator_thread_"+System.currentTimeMillis();
        OperatorDataProducer dp = new OperatorDataProducer(threadName);
        dp.setSession(session);
        dp.setBeanName("operatorFilter");
        dp.start();
%>
<script LANGUAGE="JavaScript1.2">
    window.onerror = handleError;
    
    function handleError(){
        document.write("<%=closeerror%><br>");
        document.write("<input type='button' onclick='window.close();' value='<%=closeButton%>'>");
        return true;
    }

    if(<%=isTooManySteps%>){
        if(confirm('<%=tooManySteps%>')){
            opener.top.main.location.href = "saStatLoading.jsp?thread=<%=threadName%>&redirect=saStatOperatorResult.jsp&bean=operatorFilter";
            window.close();
        }else{
            location.href="saOperatorFilter.jsp?errorMsg=<%=errorMessage%>";
        }
    }else{
        opener.top.main.location.href = "saStatLoading.jsp?thread=<%=threadName%>&redirect=saStatOperatorResult.jsp&bean=operatorFilter";
        window.close();
    }
</script>
<%
    }else{
        //forward back
%>
<script>
        location.href="saOperatorFilter.jsp?errorMsg=<%=errorMessage%>";
</script>
<%
    }
%>
