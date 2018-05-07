

<%// These lines below prevent catching at the browser and eventual proxy servers

      response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1

      response.setHeader("Pragma", "no-cache"); //HTTP 1.0

      response.setDateHeader("Expires", 0); //prevents caching at the proxy server


      %>

<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants"%>
<%@ page import="java.util.ArrayList"%>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%!
    //I18N strings
    final static String teamname  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1320", "Team Name");
    final static String noteamavailable  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1321", "No team available");
    final static String updateteaminfo  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1322", "Update Team Info");
    final static String deleteteam  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1323", "Delete Team");
    final static String assignrole  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("870", "Assign Roles");
    
%>
<script language="JavaScript">
  
  <%
  
    String operationMsgri = (String)session.getAttribute("operationMsg");
    if(operationMsgri!=null&&!operationMsgri.equals("")){

%>
    writeToMsgLine("<%=operationMsgri%>");
<%
    session.setAttribute("operationMsg","");
    }
  %>
    window.onload = function () {
       window.menuName = "teamInfoMenu";
       document.getElementById('userInfo').oncontextmenu = showContextMenu;
       scrollTo(0,top.scrollY);
       recalculateDiv();
       scrollToTab();
       if(document.all){
          var tr_header = document.getElementById("header");
          tr_header.style.position = "relative";
       }
    }

    window.onresize = function () {
        recalculateDiv();
    }
    
    function deleteTeam() {
      var teamid =  getCookie(window.menuName);
      if (teamid == null)  {
         writeToMsgLine("Please select a team.");
         return false;
      }
      hideContextMenu(window.menuName);
      if (confirm("Do you want to delete team " + document.getElementById(teamid).getElementsByTagName("TD")[0].firstChild.nodeValue  + "?")) {
          top.main.location.href = '/activator/umm/DeleteCommitTeamInfoAction.do?_pk_=' + teamid;
          return true;
      }
      else {
          writeToMsgLine("Team deleting is canceled.");
      }
      return true;
    }
    
    function openUpdateTeamInfo() {
      var win;
      var teamid =  getCookie(window.menuName);
      if (teamid == null)  {
         writeToMsgLine("Please select a team.");
         return false;
      }
      hideContextMenu(window.menuName);
      var returnValue=window.showModalDialog('/activator/umm/UpdateFormTeamInfoAction.do?firstOpen=yes&page_teamid='+teamid +'&page_teamname='+ escape(document.getElementById(teamid).getElementsByTagName("TD")[0].firstChild.nodeValue),window,"dialogHeight:400px;dialogWidth:600px");
      if (returnValue==1)
    {
        window.location.href="/activator/umm/SearchCommitTeamInfoAction.do";
    }
      //win = window.open('/activator/umm/UpdateFormTeamInfoAction.do?page_teamid='+teamid +'&page_teamname='+ document.getElementById(teamid).childNodes[0].firstChild.nodeValue,'','resizable=yes,toolbar=no,scrollbars=no,menubar=no,directories=no,width=700,height=600');
      //win.focus();
    }
    
    
    function openAssignRoles() {
     var win;
      var teamid =  getCookie(window.menuName);
      if (teamid == null)  {
         writeToMsgLine("Please select a team.");
         return false;
      }
      win = window.open('/activator/umm/CreationFormTeamRolesGrantedAction.do?page_teamname='+ escape(document.getElementById(teamid).getElementsByTagName("TD")[0].firstChild.nodeValue) +'&firstOpen=yes','','resizable=yes,toolbar=no,scrollbars=no,menubar=no,directories=no,width=860,height=600');
      win.focus();
    }
    
  </script>
<script language="JavaScript" src="../javascript/sort.js"></script>
<table class="activatorTable" id="userInfo">
	<THEAD>
		<tr id="header">
			<td width="10%" class="mainHeading" onclick="sortAble('userInfo',0)" onmouseover="mOver(this)"><%=teamname %></td>
			<td width="40%" class="mainHeading"><%=description %></td>
		</tr>
	</THEAD>

	<%
	ArrayList teamList = (ArrayList)session.getAttribute("TeamInfoList");
      if (teamList != null) {
        int listCount = teamList.size();
        int numRows = 1;
        if (listCount > 0) {
          for (int i = 0; i < listCount; i++) {
            String rowClass = (numRows % 2 == 0) ? "tableEvenRow" : "tableOddRow";
            com.hp.ov.activator.mwfm.engine.module.umm.beans.Team ri = (com.hp.ov.activator.mwfm.engine.module.umm.beans.Team)teamList
                .get(i);
%>
	<tr id="<%=ri.getName()%>" class="<%=rowClass %>"
		onClick="hideContextMenu('teamInfoMenu');"
		onMouseOver="mouseOver(this);" onMouseOut="mouseOut(this);">
		<td width="10%" class="tableCell" nowrap align="left"><%=ri.getName()%></td>
		<td width="40%" class="tableCell" nowrap align="left"><%=ri.getDescription()==null?"":ri.getDescription()%></td>
	</tr>
	<%	++numRows;
          }
        }else{
          %>
      	<tr class="tableRowInfo">
      		<td class="tableRowInfo" colspan="2"><%=noteamavailable %></td>
      	</tr>
      	<%
        }
        }else{
      %>
   	<tr class="tableRowInfo">
   		<td class="tableRowInfo" colspan="2"><%=noteamavailable %></td>
   	</tr>
   	<%
        }


    %>
	</TBODY>
</table>
<table>
	<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
</table>
<TBODY>

	<!-- This table is hidden until selected for viewing with a right click -->
	<div id="teamInfoMenu"
		style="position: absolute;top: 0px;background-color: #e6e6e6;border-style: solid;border-width: 1px;border-color: #efefef #505050 #505050 #efefef;visibility: hidden; border-left: 1px solid black;border-top: 1px solid black;border-bottom: 3px solid black;border-right: 3px solid black;padding: 3px;z-index: 101;width: 180;"
		onclick="hideContextMenu(window.menuName);"><a href="#"
		class="menuItem" target="displayFrame"
		onclick="return openUpdateTeamInfo();"
		onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=updateteaminfo %></a>
	<hr>
	<a href="#" class="menuItem" target="displayFrame"
		onclick="return deleteTeam();" onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=deleteteam %></a>
	<hr>
	<a href="#" class="menuItem" target="displayFrame"
		onclick="return openAssignRoles();"
		onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=assignrole %></a></div>
