<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->

<%@ page import=" com.hp.ov.activator.mwfm.servlet.*,
                  com.hp.ov.activator.mwfm.*,
                  com.hp.ov.activator.mwfm.component.*,
                  java.net.*,
                  java.rmi.RemoteException"
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java" %>

<%
  // Setup response parameters
  response.setDateHeader("Expires", 0);
  response.setHeader    ("Pragma",  "no-cache");

  request.setCharacterEncoding ("UTF-8"); %>

<%!
  // Setup strings that will be displayed
  final static String selectJobFirst = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("658", "You must first select a job to change roles on.");
  final static String noConnectionToMwfm = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("659", "Could not get connection to the Workflow Manager.");
  final static String genericException = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("660", "Exception in processing of the change role request:");
  final static String numberException = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("661", "Numberformat exception invalid jobId:");
  final static String noSuchJobExceptionText = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("662", "No such job exists:");
  final static String noSuchQueueExceptionText = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("663", "No such queue exists:");
  final static String noAuthenticationModule = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("664", "Change role is not possible, either no authentication module is configured or no roles are considered valid.");
  final static String lackOfPermission = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("665", "You are not authorized to perform role changes."); 
  final static String missingCallParameters = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("666", "The JSP site was called with an invalid set of parameters."); 
  final static String tooManyWindows =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("667", "You may only change roles in one job at a time.  ");
  final static String closeWindow    =com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("668", "Please either close or submit the open change roles window."); 
  final static String requestRoleTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("669", "Changing the request role will cause this particular request on this particular queue to change role, making it possible for users with this role to see and interact with this request.");
  final static String listRolesTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("670", "List of all valid roles that can be selected.");
  final static String setDefaultRoleAlso = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("671", "Changing the default role too, means that the default role for the job will be set to the same value as the request role. Depending on the workflow implementation, this will result in all subsequent requests coming from this job to have the selected role.");
  final static String defaultRoleTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("672", "Change the default role for the entire job.");
  final static String traceRoleTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("673", "Change the trace role for the entire job.");
  final static String killRoleTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("674", "Change the kill role for the entire job.");
  final static String requestRoletd = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("675", "Request role");
  final static String setDefaultRoleAlsotd = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("676", "Change default role too?");
  final static String defaultRoletd = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("677", "Default role");
  final static String traceRoletd = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("678", "Trace role");
  final static String killRoletd = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("679", "Kill role");
  final static String trueString = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("14", "Yes");
  final static String falseString = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("15", "No");
  final static String windowTitle = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("680", "Change role on job:");
  final static String submitButton = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("16", "Submit");
  final static String RoleNotSet = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("681", "Role not set");
  
  %>

<%
  // Variables
  String[] validRoles = null;
  String defaultRole = null;
  String traceRole = null;
  String killRole = null;
  String requestRole = null;
  String jobId = request.getParameter("jobId"); 
  String queueName  = URLDecoder.decode(request.getParameter("queueName"),"UTF-8");
  long jobIdLong; 
 
  %>

<html>
  <head>
    <title>HP Service Activator</title>
    <link rel="stylesheet" type="text/css" href="/activator/css/interact.css">

    <script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">

    <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
      function closeChangeRolesWindow() {
        window.close();        
        return true;
      }
    </script>

<!--
    ##################### 
    # Validation checks #
    ##################### -->

<% 
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(Constants.USER) == null) {
%>
    <script>
        window.top.topFrame.location = window.top.topFrame.location;
    </script>
<%
      return;
    }   %>

<%
    // Check that the jobId is supplied    
    if (jobId == null || jobId.equals("")) { %>
      <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
        alert("<%=selectJobFirst%>");
        closeChangeRolesWindow();
      </script>
<%    return;
    } %> 
  
<%
    // Check that the jobId is valid   
    try {
      jobIdLong = Long.parseLong(jobId);
    } catch (NumberFormatException e) { %>
      <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
        alert("<%=numberException%> <%=e.getMessage()%>");
        closeChangeRolesWindow();
      </script>
<%    return;
    } %>

<%
    // Check that the callState parameter is supplied.
    if (request.getParameter("callState") == null) { %>
      <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
        alert("<%=missingCallParameters%>");
        closeChangeRolesWindow();
      </script>
<%    return;
    } %> 

<!--
    ########################## 
    # Branching on callState #
    ########################## -->

<%  
    // If the state is initialize start the fetching of data.
    if (request.getParameter("callState").equals("initialize")) {

      // Check and get the reference to the MWFM
      WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);

      if (wfm == null) { %>
        <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
          alert("<%=noConnectionToMwfm%>");
        </script>
<%      return; 
      } 

      try {
        // Fetch the information needed for display, and save it in the session.
        validRoles = wfm.getValidRoles();
        // Only fetch the request role information if it is not a job in the RunningJobs queue.
        if (queueName != null && !queueName.equals("RunningJobs")) {
          requestRole = wfm.getJobRequestRole(jobIdLong, queueName);
        } else {
          traceRole = wfm.getJobTraceRole(jobIdLong);
          killRole = wfm.getJobKillRole(jobIdLong);
        }
        defaultRole = wfm.getJobDefaultRole(jobIdLong);

      } catch(WFNotAuthorizedException e) { %>
        <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
          alert("<%=lackOfPermission%>");
          closeChangeRolesWindow();
        </script>
<%      return;      
      } catch (WFNoSuchJobException e) { %>
        <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
          alert("<%=noSuchJobExceptionText%> <%=jobId%>");
          closeChangeRolesWindow();
        </script>
<%      return;
      } catch (WFNoSuchQueueException e) { %>
        <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
          alert("<%=noSuchQueueExceptionText%> <%=queueName%>");
          closeChangeRolesWindow();
        </script>
<%      return;
      } catch (Exception e) { %>
        <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
          alert("<%=genericException%> <%=e.getMessage()%>");
          closeChangeRolesWindow();
        </script>
<%      return;
      } %>
      
<%    if (validRoles == null) { %>
        <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
        alert("<%=noAuthenticationModule%>");
        closeChangeRolesWindow();
       </script>
<%      return; 
      } 
    } else { 
      // Check and get the reference to the MWFM
      WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);

      if (wfm == null) { %>
        <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
          alert("<%=noConnectionToMwfm%>");
          closeChangeRolesWindow();
        </script>
<%      return; 
      } 
   
      try {  
        if (queueName != null && !queueName.equals("RunningJobs")) {
          // If requestRole is not null and the value is different from the former one.
          if (request.getParameter("requestRole") != null && !request.getParameter("requestRole").equals("null") && !request.getParameter("requestRole").equals(requestRole)) {
            wfm.setJobRequestRole(jobIdLong, queueName, request.getParameter("requestRole"));
          }
          
          // If setDefaultRole was selected and the role is valid and different from the former one.
          if (request.getParameter("requestRole") != null && 
              !request.getParameter("requestRole").equals("null") && 
              request.getParameter("setDefaultRole") != null && 
              request.getParameter("setDefaultRole").equals("true") &&
              !request.getParameter("requestRole").equals(defaultRole)) {
              wfm.setJobDefaultRole(jobIdLong, request.getParameter("requestRole"));
          }
        } else {
          // If defaultRole is not null and the value is different from the former one.
          if (request.getParameter("defaultRole") != null && !request.getParameter("defaultRole").equals("null") && !request.getParameter("defaultRole").equals(defaultRole)) {
            wfm.setJobDefaultRole(jobIdLong, request.getParameter("defaultRole"));
          }
          // If killRole is not null and the value is different from the former one.
          if (request.getParameter("killRole") != null && !request.getParameter("killRole").equals("null") && !request.getParameter("killRole").equals(killRole)) {
            wfm.setJobKillRole(jobIdLong, request.getParameter("killRole")); 
          }
          // If traceRole is not null and the value is different from the former one.
          if (request.getParameter("traceRole") != null && !request.getParameter("traceRole").equals("null") && !request.getParameter("traceRole").equals(traceRole)) {
            wfm.setJobTraceRole(jobIdLong, request.getParameter("traceRole"));
          }
        }
      } catch(WFNotAuthorizedException e) { %>
        <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
          alert("<%=lackOfPermission%>");
        </script>
<%    } catch (WFNoSuchJobException e) { %>
        <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
          alert("<%=noSuchJobExceptionText%> <%=jobId%>");
        </script>
<%    } catch (WFNoSuchQueueException e) { %>
        <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
          alert("<%=noSuchQueueExceptionText%> <%=queueName%>");
        </script>
<%    } catch (Exception e) { %>
        <SCRIPT LANGUAGE="JavaScript"> 
            alert("<%= ExceptionHandler.handle(e) %>"); 
            top.location.href = "..";
        </SCRIPT>
<%    } %>

      <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
        closeChangeRolesWindow();
      </script>
<%    return;  
    } %> 

  </head>

  <!-- Ensure that it is not possible to do a reload using f5 and by that reopen the change role window -->
  <body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">

<%
    // get the name of the workflow to start
    try { %>
      <h3>
        <img src="/activator/images/HPlogo-black.gif" valign="top" align="right"><%=windowTitle%> <%=jobId%>
      </h3> 
      <br>
      <br>
      <center>
        <form name="form" action="/activator/jsp/saChangeRoles.jsp" method="POST">
          <input type="hidden" name="jobId" value="<%=jobId%>">
          <input type="hidden" name="queueName" value="<%=queueName%>">
          <input type="hidden" name="callState" value="commit">

          <table width="100%" border=0 cellpadding=0>
            <tr>
              <th class="tableHeading">Role</th>
              <th class="tableHeading">Value</th>
            </tr>
<%            if (queueName != null && !queueName.equals("RunningJobs")) { %>
                <tr>
                  <td class="tableRow" title="<%=requestRoleTitle%>"><%=requestRoletd%></td>
                  <td class="tableRow" title="<%=listRolesTitle%>">
                    <select name=requestRole>
<%                    if (requestRole == null) { %>     
                        <option value="null" selected><%=RoleNotSet%></option>
<%                    } else { %>
                        <option value="<%=requestRole%>" selected><%=requestRole%></option>
<%                    } %>

<%                    for (int i = 0; i < validRoles.length; i++) { 
                        if (validRoles[i] != null && !validRoles[i].equals(requestRole)) { %>
                          <option value="<%=validRoles[i]%>"><%=validRoles[i]%></option>
<%                      }    
                      } %>                
                    </select>
                  </td>
                </tr>
        
                <tr>
                  <td class="tableRow" title="<%=setDefaultRoleAlso%>"><%=setDefaultRoleAlsotd%></td>
                  <td class="tableRow">
                    <input type="radio" name="setDefaultRole" value="true"><%=trueString%>
                    <input type="radio" name="setDefaultRole" value="false" CHECKED><%=falseString%>
                  </td>
                </tr>
<%            } else { %>
                <tr>
                  <td class="tableRow" title="<%=defaultRoleTitle%>"><%=defaultRoletd%></td>
                  <td class="tableRow" title="<%=listRolesTitle%>">
                    <select name="defaultRole">
<%                    if (defaultRole == null) { %>     
                        <option value="null" selected><%=RoleNotSet%></option>
<%                    } else { %>
                        <option value="<%=defaultRole%>" selected><%=defaultRole%></option>
<%                    } %>
                    
<%                    for (int i = 0; i < validRoles.length; i++) { 
                        if (validRoles[i] != null && !validRoles[i].equals(defaultRole)) { %>
                          <option value="<%=validRoles[i]%>"><%=validRoles[i]%></option>
<%                      }    
                      } %>                
                    </select>
                  </td>
                </tr>
    
                <tr>
                  <td class="tableRow" title="<%=traceRoleTitle%>"><%=traceRoletd%></td>
                  <td class="tableRow" title="<%=listRolesTitle%>">
                    <select name=traceRole>
<%                    if (traceRole == null) { %>     
                        <option value="null" selected><%=RoleNotSet%></option>
<%                    } else { %>
                        <option value="<%=traceRole%>" selected><%=traceRole%></option>
<%                    } %>

<%                    for (int i = 0; i < validRoles.length; i++) { 
                        if (validRoles[i] != null && !validRoles[i].equals(traceRole)) { %>
                          <option value="<%=validRoles[i]%>"><%=validRoles[i]%></option>
<%                      }    
                      } %>                
                    </select>
                  </td>
                </tr>
    
                <tr>
                  <td class="tableRow" title="<%=killRoleTitle%>"><%=killRoletd%></td>
                  <td class="tableRow" title="<%=listRolesTitle%>">
                    <select name=killRole>
<%                    if (killRole == null) { %>     
                        <option value="null" selected><%=RoleNotSet%></option>
<%                    } else { %>
                        <option value="<%=killRole%>" selected><%=killRole%></option>
<%                    } %>
                    
<%                    for (int i = 0; i < validRoles.length; i++) { 
                        if (validRoles[i] != null && !validRoles[i].equals(killRole)) { %>
                          <option value="<%=validRoles[i]%>" ><%=validRoles[i]%></option>
<%                      }    
                      } %>                
                    </select>
                  </td>
                </tr>
<%            } %>

            <tr>
              <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
              <td align="center" colspan="2">
                <input type="submit" value="<%=submitButton%>" >
              </td>
            </tr>
          </table>
        </form>
      </center>
<%  } catch(Exception e) { %>
      <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
        alert("<%=genericException%> <%=e.getMessage()%>");
        closeChangeRolesWindow();
      </script>
<%  } %>
  </body>
</html>
