

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
    final static String rolename  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("798", "Role Name");
    final static String noroleavailable  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("799", "No role available");
    final static String updateroleinfo  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("800", "Update Role Info");
    final static String deleterole  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("801", "Delete Role");
    final static String assignoperationtype  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("802", "Assign Operation Type");
    final static String assignbranchtype  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("803", "Assign Branch Type");
    final static String assigntree  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("804", "Assign Tree");
    
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
       window.menuName = "roleInfoMenu";
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
    
    function deleteRole() {
      var roleid =  getCookie(window.menuName);
      if (roleid == null)  {
         writeToMsgLine("Please select a role.");
         return false;
      }
      hideContextMenu(window.menuName);
      if (confirm("Do you want to delete role " + document.getElementById(roleid).getElementsByTagName("TD")[0].firstChild.nodeValue  + "?")) {
          top.main.location.href = '/activator/umm/DeleteCommitRoleInfoAction.do?_pk_=' + roleid;
          return true;
      }
      else {
          writeToMsgLine("Role deleting is canceled.");
      }
      return true;
    }
    
    function openUpdateRoleInfo() {
      var win;
      var roleid =  getCookie(window.menuName);
      if (roleid == null)  {
         writeToMsgLine("Please select a role.");
         return false;
      }
      hideContextMenu(window.menuName);
      var returnValue=window.showModalDialog('/activator/umm/UpdateFormRoleInfoAction.do?firstOpen=yes&page_roleid='+roleid +'&page_rolename='+ escape(document.getElementById(roleid).getElementsByTagName("TD")[0].firstChild.nodeValue),window,"dialogHeight:400px;dialogWidth:600px");
      if (returnValue==1)
    {
        window.location.href="/activator/umm/SearchCommitRoleInfoAction.do";
    }
      //win = window.open('/activator/umm/UpdateFormRoleInfoAction.do?page_roleid='+roleid +'&page_rolename='+ document.getElementById(roleid).childNodes[0].firstChild.nodeValue,'','resizable=yes,toolbar=no,scrollbars=no,menubar=no,directories=no,width=700,height=600');
      //win.focus();
    }
    
    function openRoleGrant() {
      var win;
      var roleid =  getCookie(window.menuName);
      if (roleid == null)  {
         writeToMsgLine("Please select a role.");
         return false;
      }
      win = window.open('/activator/umm/CreationFormRolesGrantedAction.do?page_roleid='+roleid +'&page_rolename='+ escape(document.getElementById(roleid).getElementsByTagName("TD")[0].firstChild.nodeValue) +'&firstOpen=yes','','resizable=yes,toolbar=no,scrollbars=no,menubar=no,directories=no,width=700,height=600');
      win.focus();

    }
    
    
    function openAssignTree() {
     var win;
      var roleid =  getCookie(window.menuName);
      if (roleid == null)  {
         writeToMsgLine("Please select a role.");
         return false;
      }
      win = window.open('/activator/umm/CreationFormRoleViewTreeAction.do?page_roleid='+roleid +'&page_rolename='+ escape(document.getElementById(roleid).getElementsByTagName("TD")[0].firstChild.nodeValue) +'&firstOpen=yes','','resizable=yes,toolbar=no,scrollbars=no,menubar=no,directories=no,width=860,height=600');
      win.focus();
    }
    
    function openBranchTree() {
     var win;
      var roleid =  getCookie(window.menuName);
      if (roleid == null)  {
         writeToMsgLine("Please select a role.");
         return false;
      }
      win = window.open('/activator/umm/CreationFormRoleBranchTreeAction.do?page_roleid='+roleid +'&page_rolename='+ escape(document.getElementById(roleid).getElementsByTagName("TD")[0].firstChild.nodeValue) +'&firstOpen=yes','','resizable=yes,toolbar=no,scrollbars=no,menubar=no,directories=no,width=860,height=600');
      win.focus();
    }

    function openAssignOperationTree() {
      var win;
      var roleid =  getCookie(window.menuName);
      if (roleid == null)  {
         writeToMsgLine("Please select a role.");
         return false;
      }
      
      win = window.open('/activator/umm/CreationFormRoleOperationTreeAction.do?page_roleid='+roleid +'&page_rolename='+ escape(document.getElementById(roleid).getElementsByTagName("TD")[0].firstChild.nodeValue)+'&firstOpen=yes','','resizable=yes,toolbar=no,scrollbars=no,menubar=no,directories=no,width=860,height=600');
      win.focus();
    }
    
  </script>
<script language="JavaScript" src="/activator/javascript/sort.js"></script>
<table class="activatorTable" id="userInfo">
	<THEAD>
		<tr id="header">
			<td width="10%" class="mainHeading" onclick="sortAble('userInfo',0)" onmouseover="mOver(this)"><%=rolename %></td>
			<td width="40%" class="mainHeading"><%=description %></td>
		</tr>
	</THEAD>

	<%ArrayList roleList = (ArrayList)session.getAttribute("roleinfolist");
      if (roleList != null) {
        int listCount = roleList.size();
        int numRows = 1;
        if (listCount > 0) {
          for (int i = 0; i < listCount; i++) {
            String rowClass = (numRows % 2 == 0) ? "tableEvenRow" : "tableOddRow";
            com.hp.ov.activator.mwfm.engine.module.umm.beans.RoleInfo ri = (com.hp.ov.activator.mwfm.engine.module.umm.beans.RoleInfo)roleList
                .get(i);
%>
	<tr id="<%=ri.getName()%>" class="<%=rowClass %>"
		onClick="hideContextMenu('roleInfoMenu');"
		onMouseOver="mouseOver(this);" onMouseOut="mouseOut(this);">
		<td width="10%" class="tableCell" nowrap align="left"><%=ri.getName()%></td>
		<td width="40%" class="tableCell" nowrap align="left"><%=ri.getDescription()==null?"":ri.getDescription()%></td>
	</tr>
	<%	++numRows;
          }
        }else{
          %>
      	<tr class="tableRowInfo">
      		<td class="tableRowInfo" colspan="2"><%=noroleavailable %></td>
      	</tr>
      	<%
        }
        }else{
      %>
   	<tr class="tableRowInfo">
   		<td class="tableRowInfo" colspan="2"><%=noroleavailable %></td>
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
	<div id="roleInfoMenu"
		style="position: absolute;top: 0px;background-color: #e6e6e6;border-style: solid;border-width: 1px;border-color: #efefef #505050 #505050 #efefef;visibility: hidden; border-left: 1px solid black;border-top: 1px solid black;border-bottom: 3px solid black;border-right: 3px solid black;padding: 3px;z-index: 101;width: 180;"
		onclick="hideContextMenu(window.menuName);"><a href="#"
		class="menuItem" target="displayFrame"
		onclick="return openUpdateRoleInfo();"
		onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=updateroleinfo %></a>
	<hr>
	<a href="#" class="menuItem" target="displayFrame"
		onclick="return deleteRole();" onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=deleterole %></a>
	<hr>
	<a href="#" class="menuItem" target="displayFrame"
		onclick="return openAssignOperationTree();"
		onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=assignoperationtype %></a>
	<hr>
	<a href="#" class="menuItem" target="displayFrame"
		onclick="return openBranchTree();"
		onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=assignbranchtype %></a>
	<hr>
	<a href="#" class="menuItem" target="displayFrame"
		onclick="return openAssignTree();"
		onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=assigntree %></a></div>
