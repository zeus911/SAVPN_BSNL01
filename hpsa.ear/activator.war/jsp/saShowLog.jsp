<%@ page import="com.hp.ov.activator.mwfm.*, 
                 com.hp.ov.activator.mwfm.servlet.*, 
                 java.net.*,
                 com.hp.ov.activator.mwfm.component.*, 
                 java.io.*" 
         info="Display a log" 
         contentType="text/html; charset=UTF-8"
         session="true" 
%><%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(Constants.USER) == null) {
%>
    <script>
        window.top.topFrame.location = window.top.topFrame.location;
    </script>
<%
       return;
    }  
    request.setCharacterEncoding ("UTF-8");
    String log = (String)request.getParameter ("name");
        
    String tabName = (String)request.getParameter ("tab");
    String SESSION_LOG_FILE = "tab_in_saLogFiles.jsp_";
    
   
   
    String nodeName = (String)session.getAttribute("NODE_NAME");
    String filterName = (String)session.getAttribute("FILTER_NAME");
    SESSION_LOG_FILE = SESSION_LOG_FILE + nodeName +"_";
    
    if (!"".equalsIgnoreCase(tabName) && tabName != null){
      session.setAttribute("SYSTEM_FILE_NAME",log);
      SESSION_LOG_FILE = SESSION_LOG_FILE  + tabName.toUpperCase();
      session.setAttribute(SESSION_LOG_FILE,log);
    }
    WFManager wfm = (WFManager)session.getAttribute(Constants.MWFM_SESSION);
    String deleteMessage = "" ;
    
    if(session.getAttribute("DELETE_LOGS")!=null){ 
      deleteMessage = (String)session.getAttribute("DELETE_LOGS");
      deleteMessage = deleteMessage.replaceAll("BB", "<br/>");
     } 
     
%><%!
    //I18N strings
    String errMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("169", " Unable to display the requested log file");
    String reason = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("170", " Either the file has been removed or is corrupt.");
    String defaultMesasage = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("788", " Please select a file from the below list of Log files");
    
%>
<html>
<head>
  <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
</head>
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<%
   boolean rmiCall = true ;
   if(log.equalsIgnoreCase("blank")){
     log ="";
     rmiCall = false ;
  %>
    <BR><BR><P align="left" ><%=defaultMesasage%></P>
  <%  
      
    if(!"".equals(deleteMessage) ){
      session.removeAttribute("DELETE_LOGS");
  %>    
    <BR><P align="left" ><%=deleteMessage%></P>
  <%
     }
    
     
    } 
    
    BufferedReader br = null;
    String str = "";
    long startTime = 0;
   if(rmiCall){
      try { 
          startTime = System.currentTimeMillis();
          if(filterName == null || "".equals(filterName)) {
          	str = wfm.getLogFile(nodeName,log);
          }
          else {
          	str = wfm.getLogFile(nodeName,log,filterName);
          }
      }catch(WFLogException WFLoge){
          response.setContentType("text/html");
          out.println("<BR><BR><P align='left' >"+WFLoge.getMessage()+"</P>" );
       }catch(Exception e){
          response.setContentType("text/html");
          out.println("<BR><BR><P align='left' >"+e.getMessage()+"</P>" );
          out.println("<P align='left' >"+reason+"</P>");
      }  
   } 
     
    out.println (str);
    long endTime = System.currentTimeMillis();
    
%>
</body>
</html>
<!-- (c) Copyright 2010 Hewlett-Packard Development Company, L.P.  -->
