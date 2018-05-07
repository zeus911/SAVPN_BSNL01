<%@ page import="java.util.Date,
                 java.text.DateFormat,
                 java.text.SimpleDateFormat,
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
    final static String badBeginDate    = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("600", "Wrong start date or time.");
    final static String badEndDate      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("601", "Wrong end date or time.");
    final static String badJobId        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("630", "JobId value should be number.");
    final static String endDateIsLessThanBegin = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("603", "Begin date is bigger than end date.");
    final static String notAdmin        = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("596", "You are not administrator.");
    final static String closeButton     = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("436", "Close");
    final static String closeerror      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("631", "Error occurred. Probably you navigated out of Audit messages page.");
%>

<% 
    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
    session.removeAttribute("auditFilter");
%>

<jsp:useBean id="auditFilter" scope="session" class="com.hp.ov.activator.mwfm.servlet.auditFilterBean"/>
<jsp:setProperty name="auditFilter" property="*" />

<%  
    //Validate form
    String errorMessage = "";
    
    SimpleDateFormat df = (SimpleDateFormat)DateFormat.getDateInstance(DateFormat.SHORT);
    SimpleDateFormat tf = (SimpleDateFormat)DateFormat.getTimeInstance(DateFormat.SHORT);

    //jobId corect?
    if(auditFilter.getJobId()!=null && !auditFilter.getJobId().equals("")){
        try{
            Long.parseLong(auditFilter.getJobId());
        }catch(NumberFormatException nfe){
            errorMessage = badJobId;
        }
    }
    
    //begin date and time corect?
    if(errorMessage.equals("") && !auditFilter.getBeginDate().equals("")){
        try{
            errorMessage = (auditFilter.parseBeginDate(df, tf)?"":badBeginDate);
        }catch(NullPointerException e){;}
    }
    
    //end date and time corect?
    if(errorMessage.equals("") && !auditFilter.getEndDate().equals("")){
        try{
            errorMessage = (auditFilter.parseEndDate(df, tf)?"":badEndDate);
        }catch(NullPointerException e){;}
    }
    
    // end date should be more than begin date
    if(errorMessage.equals("") && auditFilter.getParsedBeginDate() != null && 
        auditFilter.getParsedEndDate()!= null &&
        auditFilter.getParsedBeginDate().compareTo(auditFilter.getParsedEndDate())>0 ){
        errorMessage = endDateIsLessThanBegin;
    }
    
    if(errorMessage.equals("")){
%>
<script LANGUAGE="JavaScript1.2">
    window.onerror = handleError;
    function handleError(){
        document.write("<%=closeerror%><br>");
        document.write("<input type='button' onclick='window.close();' value='<%=closeButton%>'>");
        return true;
    }
    //rnd variable need to be sure netscape will reload the frame.
    opener.top.main.location.href = "saAuditMsgs.jsp?page=0&recStart=1&filter=1&rnd="+<%=(new Date()).getTime()%>;
    window.close();
</script>
<%
    }else{
        //forward back
%>
<script>
        location.href="saAuditFilter.jsp?errorMsg=<%=errorMessage%>";
</script>
<%
    }
%>