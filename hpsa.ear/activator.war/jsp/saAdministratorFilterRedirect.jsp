<%@ page import="java.util.Date,
                 java.sql.Connection,
                 javax.sql.DataSource,
                 java.text.SimpleDateFormat,
                 java.text.DateFormat,
                 com.hp.ov.activator.mwfm.servlet.*,
                 com.hp.ov.activator.stats.Utils,
                 com.hp.ov.activator.stats.AdministratorDataProducer,
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
    final static String serieShouldBeSelect    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("602", "At least one data series should be selected.");
    final static String endDateIsLessThanBegin = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("603", "Begin date is bigger than end date.");
    final static String tooManyStepsError      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("604", "Time range is too wide, or time unit is too small.");
    final static String timeUnitIsTooBig       = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("605", "Specified time unit is too big for this time range.");
    final static String tooManySteps    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("606", "WARNING:\\nTime range is too wide or time units is too small.\\n Do you want to continue?");
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
    session.removeAttribute("administratorFilter");
%>

<jsp:useBean id="administratorFilter" scope="session" class="com.hp.ov.activator.mwfm.servlet.administratorFilterBean"/>
<jsp:setProperty name="administratorFilter" property="*" />

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
    if(errorMessage.equals("") && !administratorFilter.getBeginDate().equals("")){
        try{
            errorMessage = (administratorFilter.parseBeginDate(df, tf)?"":badBeginDate);
        }catch(NullPointerException e){;}
    }

    //end date corect?
    if(errorMessage.equals("") && !administratorFilter.getEndDate().equals("")){
        try{
            errorMessage = (administratorFilter.parseEndDate(df, tf)?"":badEndDate);
        }catch(NullPointerException e){;}
    }
    
    //Prepare dates for later usability
    try { 
        DataSource dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
        Connection con = (Connection) dataSource.getConnection();
        administratorFilter.prepareParsedDates(con);
        con.close();
    }catch (Exception e){
        e.printStackTrace();
%>
      <SCRIPT LANGUAGE="JavaScript"> alert("<%= ExceptionHandler.handle(e) %>"); </SCRIPT>
<%
    }
    
    //Do we have data for this period
    if(errorMessage.equals("") && administratorFilter.getParsedBeginDate().getTime() == 0 ){
        errorMessage = noData + DateFormat.getDateTimeInstance().format(administratorFilter.getParsedBeginDate()) + 
                " - " + DateFormat.getDateTimeInstance().format(administratorFilter.getParsedEndDate());
    }

    // end date should be more than begin date
    if(errorMessage.equals("") && administratorFilter.getParsedBeginDate().compareTo(administratorFilter.getParsedEndDate())>0 ){
        errorMessage = endDateIsLessThanBegin;
    }
    
    //at least one time unit should be in time range
    if(errorMessage.equals("") && administratorFilter.isDisplayChartChecked() && Utils.isTimeUnitTooSmall(
            administratorFilter.getParsedBeginDate(),administratorFilter.getParsedEndDate(),administratorFilter.getTimeUnit()) ){
        errorMessage = timeUnitIsTooBig;
    }

    //if we need chart,at lease one series should be selectes
    if(errorMessage.equals("") && administratorFilter.isDisplayChartChecked() && 
            !administratorFilter.isWorkerThreadsInUseChecked() &&
            !administratorFilter.isActivationThreadsInUseChecked() &&
            !administratorFilter.isRunningWFChecked() &&
            !administratorFilter.isActivationsChecked() &&
            !administratorFilter.isLogedInUsersChecked()){
        errorMessage = serieShouldBeSelect;
    }

    //if we need chart, check for step number
    if(errorMessage.equals("") && administratorFilter.isDisplayChartChecked() &&
            AdministratorDataProducer.getTotalSteps(administratorFilter)>600 ){
        isTooManySteps = true;
    }

    //if we need chart, check for step max number
    if(errorMessage.equals("") && administratorFilter.isDisplayChartChecked() &&
            AdministratorDataProducer.getTotalSteps(administratorFilter)>4000 ){
        errorMessage = tooManyStepsError ;
    }

    if(errorMessage.equals("")){
        //clean session
        session.removeAttribute("administratorFilter"+DatasetProducer.BEAN_EXTENSION);

        //Start dataProducer
        String threadName = "Stat_administrator_thread_"+System.currentTimeMillis();
        AdministratorDataProducer dp = new AdministratorDataProducer(threadName);
        dp.setSession(session);
        dp.setBeanName("administratorFilter");
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
            opener.top.main.location.href = "saStatLoading.jsp?thread=<%=threadName%>&redirect=saStatAdministratorResult.jsp&bean=administratorFilter";
            window.close();
        }else{
            location.href="saAdministratorFilter.jsp?errorMsg=<%=errorMessage%>";
        }
    }else{
        opener.top.main.location.href = "saStatLoading.jsp?thread=<%=threadName%>&redirect=saStatAdministratorResult.jsp&bean=administratorFilter";
        window.close();
    }
</script>
<%
    }else{
        //forward back
%>
<script>
        location.href="saAdministratorFilter.jsp?errorMsg=<%=errorMessage%>";
</script>
<%
    }
%>