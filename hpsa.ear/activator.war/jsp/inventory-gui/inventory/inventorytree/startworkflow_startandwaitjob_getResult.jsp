<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.ConstantsFTStruts,
        com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.action.WorkflowList,
        com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.struts.action.StringWorkflow,
        com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.ParameterExt,
        com.hp.ov.activator.treedeployer.inventory.inventorytree.definition.Result; " %> 

<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%
  String startingworkflowid=request.getParameter(ConstantsFTStruts.CURRENT_OPER_WORKFLOW_ID);
  String result_jsp="/activator/jsp/inventory-gui/inventory/inventorytree/startworkflow_startandwaitjob_getResult.jsp?"+ConstantsFTStruts.CURRENT_OPER_WORKFLOW_ID+"="+startingworkflowid;
  WorkflowList wfl = (WorkflowList)request.getSession().getAttribute(ConstantsFTStruts.WORKFLOW_INVENTORY_TREE);
  StringWorkflow swf=(StringWorkflow)wfl.workflowlist.get(new Integer(startingworkflowid));
  HashMap result=swf.jobResult;
  String jobstatus=swf.jobstatus;
%>


<script>
function init() {
  <%
      if  (jobstatus.equals("finished") || jobstatus.equals("exception") ) {
      }else{
  %>
        window.setTimeout("reload()" ,4300);
  <%
      }
  %>
}
function reload() {   
    location.href = "<%=result_jsp%>" ;
}
 init();
</script>

<html>
<head>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
      <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <script type="text/javascript" src="/activator/javascript/saUtilities.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
</head>
<body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;" onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">


  <%
    if  (jobstatus.equals("finished") ) {

  %>
         workflow status :    finished.   <br>
    <%
      Result r=null;
      if( swf.wkf.result!=null) {
  %>
        <br> Results:   <br>
  <%
            for (int i = 0; i < swf.wkf.result.length; i++) {
              r=swf.wkf.result[i];
              String rs = "";
              if (result.containsKey(r.name)) {
                if (result.get(r.name) == null) {
                  rs = "null";
                } else {
                  rs=((Object)result.get(r.name)).toString();
                }
              } else {
                rs = "Value not found";
              }


              
%>
 
 <%=r.displayName%>:      <%=rs%>    <br>

<%
            }
      }
  }else if  (jobstatus.equals("exception") ) {

%>
        workflow status :   got exception.    <br><br>
        exception :   <br> 
        <%=swf.jobexc%>  
 <%
  
  }else {

%>
       workflow status :    running......     <br>
       <img border=0 src="/activator/images/inventory-gui/inventory/ProgressBar.gif">
        
 <%
  }
%>

 </body>
</html>

  <%
  //clean up
  
      if  (jobstatus.equals("finished") || jobstatus.equals("exception") ) {
          wfl.remove(new Integer(startingworkflowid)); 
      }
  %>
