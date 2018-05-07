<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%@ page
    info="shows the pages available for the audit table." session="true"
    contentType="text/html; charset=UTF-8" language="java"%>
<%
      request.setCharacterEncoding("UTF-8");

      // don't cache the page
      response.setDateHeader("Expires", 0);
      response.setHeader("Pragma", "no-cache");
      //String tableName = (String)session.getAttribute("currentTab");
      String noOfPages = (String)session.getAttribute("NumberOfPagesInAudit");
      String currentPage = (String)session.getAttribute("CurrentPageNumberinAudit");
      final String AUDIT_TABLE = "audit_record";
      String auditPage = "saAuditMsgs.jsp?";
      

      //String pageNo = ((Integer)i).toString();
%>

<html>


<head>
<link rel="stylesheet" type="text/css" href="/activator/css/activator.css">
<link rel="stylesheet" type="text/css" href="/activator/css/saTabs.css">
<link rel="stylesheet" type="text/css" href="/activator/css/saContextMenu.css">
<script language="JavaScript" src="/activator/javascript/table.js"></script>
<script language="JavaScript" src="/activator/javascript/saUtilities.js"></script>
<script language="JavaScript" src="/activator/javascript/saContextMenu.js"></script>
<script LANGUAGE="JavaScript1.2">
function redirect(pageNo){
msg ="<%="][Retrieving audit data, please wait...."%>";
    opener.top.messageLine.location.href = encodeURI('saDisplayMsg.jsp?Msg=' + msg);
    opener.top.main.location.href = "<%=auditPage%>"+"&page="+pageNo ;
    
    window.close();
  }  
</script>
</head>
<body onmousemove="logoutTimerReset();" onkeydown="logoutTimerReset();">
<table>
    
        <%
                if (noOfPages != null && !("".equalsIgnoreCase(noOfPages))) {
                  int numberOfPages = Integer.parseInt(noOfPages);
                  for (int i = 0; i < numberOfPages; i++) {
                    int pageDesc = i+1;
        %>
              
              <tr>
                  <td nowrap class="activatorPageLinks" onclick="redirect('<%=i%>')"
                      title="<%="Page "+pageDesc%>" onMouseOver="mouseOver(this);"
                      onMouseOut="mouseOut(this);">&nbsp;&nbsp;<%="Page" + pageDesc%>&nbsp;&nbsp;</td>
        <%
                      }
                   } 
        %>
    </tr>
</table>
</body>
</html>

