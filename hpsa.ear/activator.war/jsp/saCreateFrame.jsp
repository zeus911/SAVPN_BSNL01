<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%
//This dummy page is needed to work search functionality
String wrapedJsp = (String) request.getParameter("jsp");
if(wrapedJsp == null || wrapedJsp.equals("")){
  wrapedJsp = "/activator/jsf/jobs/jobs.jsf";
}
if(wrapedJsp.equalsIgnoreCase("saDBLogMessage.jsp") ){
  if(session.getAttribute("currentTab")!=null){
    wrapedJsp = wrapedJsp +"?tab="+(String)session.getAttribute("currentTab");
  }
}
if(wrapedJsp.equalsIgnoreCase("saNodeView.jsp") ){
  wrapedJsp = wrapedJsp +"?framewidth="+request.getParameter("framewidth")+"&frameheight="+request.getParameter("frameheight");
}
%>
<!doctype html>
<html>

<head>
  <title>HP Service Activator</title>
  <link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
</head>

<frameset rows="100%" frameborder="0" framespacing="0">
  <frame src="<%=wrapedJsp%>" name="displayFrame" topmargin="0" marginwidth="10" marginheight="0"  noresize scrolling="auto">
</frameset>

</html>
