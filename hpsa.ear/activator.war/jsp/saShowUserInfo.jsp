<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants"%>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%!
    //I18N strings
    final static String name  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("95", "Name");
    final static String realname      = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("865", "Real Name");
    final static String companyname  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("866", "Company Name");
    final static String restricted  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("867", "System User");
    final static String teamName  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1320", "Team Name");
    final static String nouseravailable  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("868", "No user available");
    final static String udpateuserinfo  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("869", "Update User Info");
    final static String copyUser  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1327", "Copy User");
    final static String assignroles  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("870", "Assign Roles");
    final static String deleteuser  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("871", "Delete User");
    final static String status  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("10", "Status");
    final static String enableUser  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1052", "Enable User");
    final static String disableUser  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1053", "Disable User");
%>
<script language="JavaScript">

  <%
    String operationMsgui = (String)session.getAttribute("operationMsg");
    if(operationMsgui!=null&&!operationMsgui.equals("")){
    
%>
    writeToMsgLine("<%=operationMsgui%>");
<%
    session.setAttribute("operationMsg","");
    }
  %>
    
    window.onload = function () {
       window.menuName = "userInfoMenu";
       document.getElementById('userInfo').oncontextmenu =addContextMenuItem;
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
    
    function addContextMenuItem(evt){
    var menuName = window.menuName;
    var menu = document.getElementById(menuName);
    var parentRow;

    // get the event regardles of IE or Netscape
    var jobEvent = evt || window.event;

    if (document.all) {
       parentRow = jobEvent.srcElement.parentElement;
       while (parentRow.tagName != "TR") { 
          parentRow = parentRow.parentElement;
       }
    } else {
       // walk the tree until we find a row
       parentRow = jobEvent.target.parentNode;
       while (parentRow.tagName != "TR") { 
          parentRow = parentRow.parentNode;
       }
    }

    var userStatus = parentRow.getAttribute("userStatus");
    var systemUser = parentRow.getAttribute("systemUser");
    var sameUser = parentRow.getAttribute("sameUser");
       // Create a new tag and its attributes
       var anchorTag = document.createElement("A");
       anchorTag.setAttribute("id","userMaintain");
       anchorTag.setAttribute("href","#");
       anchorTag.setAttribute("class","menuItem");
       anchorTag.setAttribute("target","displayFrame");
       anchorTag.onmouseover= new Function("toggleHighlight(event)");
       anchorTag.onmouseout= new Function("toggleHighlight(event)");

	       if (userStatus=="false") {
	        anchorTag.onclick = new Function("enableUser()");
	        //anchorTag.appendChild(document.createTextNode("<%=enableUser %>"));
	        anchorTag.innerHTML="<%=enableUser %>";
		}else if (userStatus=="true"){
		anchorTag.onclick = new Function("disableUser()");
	        anchorTag.innerHTML="<%=disableUser %>";
	       }

       // the menu item may be added before
       // so we should check if this item exists
       if (document.getElementById("userInfoMenu").lastChild.getAttribute("id")!="userMaintain"){
//         document.getElementById("userInfoMenu").appendChild(document.createElement("HR"));
         document.getElementById("userInfoMenu").appendChild(anchorTag);
	 }else{
	 document.getElementById("userInfoMenu").removeChild(document.getElementById("userInfoMenu").lastChild);
	 document.getElementById("userInfoMenu").appendChild(anchorTag);
	 }
	 
    if(menu.id == "userInfoMenu"){
		if (systemUser=="true" || sameUser=="true") {
            var menuItem = document.getElementById("userMaintain");
            if(menuItem){
                menuItem.style.display="none"
            }
            var menuItem1 = document.getElementById("disableuserhr");
            if(menuItem1){
                menuItem1.style.display="none"
            }            
            var menuItem2 = document.getElementById("deleteuser");
            if(menuItem2){
                menuItem2.style.display="none"
            }		      
            var menuItem3 = document.getElementById("deleteuserhr");
            if(menuItem3){
                menuItem3.style.display="none"
            }		                  				
		} else {
            var menuItem = document.getElementById("userMaintain");
            if(menuItem){
                menuItem.style.display="block"
            }
            var menuItem1 = document.getElementById("disableuserhr");
            if(menuItem1){
                menuItem1.style.display="block"
            }		            
            var menuItem2 = document.getElementById("deleteuser");
            if(menuItem2){
                menuItem2.style.display="block"
            }		      
            var menuItem3 = document.getElementById("deleteuserhr");
            if(menuItem3){
                menuItem3.style.display="block"
            }		                  		
		
		}
    
    }
	 

       showContextMenu(evt);
       return false;
    }

    function enableUser() {
      var userId =  getCookie(window.menuName);
      if (userId == null)  {
         writeToMsgLine("Please select a user.");
         return false;
      }
      hideContextMenu(window.menuName);
      if (confirm("Do you want to enable user " + document.getElementById(userId).getElementsByTagName("TD")[0].firstChild.nodeValue + "?")) {
          top.main.location.href = '/activator/umm/DoCommitUserInfoAction.do?_pk_=' + userId + '&userstatus=true';
          return true;
      }
      else {
          writeToMsgLine("User enabling is canceled.");
      }
      return true;
      }

     function disableUser() {
      var userId =  getCookie(window.menuName);
      if (userId == null)  {
         writeToMsgLine("Please select a user.");
         return false;
      }
      hideContextMenu(window.menuName);
      if (confirm("Do you want to disable user " + document.getElementById(userId).getElementsByTagName("TD")[0].firstChild.nodeValue + "?")) {
          top.main.location.href = '/activator/umm/DoCommitUserInfoAction.do?_pk_=' + userId + '&userstatus=false';
          return true;
      }
      else {
          writeToMsgLine("User disabling is canceled.");
      }
      return true;
    }
    
    function deleteUser() {
      var userId =  getCookie(window.menuName);
      if (userId == null)  {
         writeToMsgLine("Please select a user.");
         return false;
      }
      hideContextMenu(window.menuName);
      if (confirm("Do you want to delete user " + document.getElementById(userId).getElementsByTagName("TD")[0].firstChild.nodeValue + "?")) {
          top.main.location.href = '/activator/umm/DeleteCommitUserInfoAction.do?_pk_=' + userId;
          return true;
      }
      else {
          writeToMsgLine("User deleting is canceled.");
      }
      return true;
    }
    
    function openRoleGrant() {
      var win;
      var userid =  getCookie(window.menuName);

      if (userid == null)  {
         writeToMsgLine("Please select a user.");
         return false;
      }
      win = window.open('/activator/umm/CreationFormRolesGrantedAction.do?page_userid=' + userid + '&page_username='+ escape(document.getElementById(userid).getElementsByTagName("TD")[0].firstChild.nodeValue) +'&firstOpen=yes','','resizable=yes,toolbar=no,scrollbars=no,menubar=no,directories=no,width=660,height=600');
      win.focus();

    }
    
    function openUpdateUserInfo() {
      var win;
      var userId =  getCookie(window.menuName);
      if (userId == null)  {
         writeToMsgLine("Please select a user.");
         return false;
      }
      hideContextMenu(window.menuName);
      var returnValue=window.showModalDialog('/activator/umm/UpdateFormUserInfoAction.do?firstOpen=yes&_pk_='+userId,window,"dialogHeight:500px;dialogWidth:600px");
      if (returnValue==1)
    {
        window.location.href="/activator/umm/SearchCommitUserInfoAction.do";
    }
      //win.focus();
    }

    function openCopyUser() {
      var win;
      var userId =  getCookie(window.menuName);
      if (userId == null)  {
         writeToMsgLine("Please select a user.");
         return false;
      }
      hideContextMenu(window.menuName);
      var returnValue=window.showModalDialog('/activator/umm/CopyFormUserAction.do?firstOpen=yes&_pk_='+userId,window,"dialogHeight:500px;dialogWidth:600px");
      if (returnValue==1)
    {
        window.location.href="/activator/umm/SearchCommitUserInfoAction.do";
    }
      //win.focus();
    }

    
  </script>
<script language="JavaScript" src="/activator/javascript/sort.js"></script>
<table class="activatorTable" id="userInfo">
	<THEAD>
		<tr id="header">
			<td width="10%" class="mainHeading" onclick="sortAble('userInfo',0)" onmouseover="mOver(this)"><%=name %></td>
			<td width="20%" class="mainHeading" onclick="sortAble('userInfo',1)" onmouseover="mOver(this)"><%=realname %></td>
			<td width="20%" class="mainHeading" onclick="sortAble('userInfo',2)" onmouseover="mOver(this)"><%=companyname %></td>
			<td width="30%" class="mainHeading"><%=description %></td>
			<%
			 if (((Boolean)request.getSession().getAttribute(com.hp.ov.activator.mwfm.servlet.Constants.TEAM_ENABLED)).booleanValue() == true) {
			%>
			<td width="10%" class="mainHeading" onclick="sortAble('userInfo',4)" onmouseover="mOver(this)"><%=teamName %></td>
			<%
			} else {
			%>
			<td width="10%" class="mainHeading" onclick="sortAble('userInfo',4)" onmouseover="mOver(this)"><%=restricted %></td>
			<%
			}
			%>
			<td width="10%" class="mainHeading" onclick="sortAble('userInfo',5)" onmouseover="mOver(this)"><%=status %></td>
		</tr>
	</THEAD>


	<%
ArrayList userList = (ArrayList)session.getAttribute("userinfolist");
String user = (String) session.getAttribute(Constants.USER);
if( userList!=null){
  int listCount = userList.size();
  int numRows = 1;
if (listCount>0) {
     for(int i=0; i< listCount; i++){
     String rowClass= (numRows%2 == 0) ? "tableEvenRow" : "tableOddRow";
     com.hp.ov.activator.mwfm.engine.module.umm.beans.UserInfo ui = (com.hp.ov.activator.mwfm.engine.module.umm.beans.UserInfo)userList.get(i);
     String sameUser = "false";
     if (user.equals(ui.getName())) {
     	sameUser = "true";
     } else {
     	sameUser = "false";
     }
     
%>
	<tr id="<%=ui.getName()%>" class="<%=rowClass %>"
		onClick="hideContextMenu('userInfoMenu');"
		onMouseOver="mouseOver(this);" onMouseOut="mouseOut(this);"  sameUser="<%=sameUser%>" systemUser="<%=ui.getSystemuser()%>" userStatus="<%=ui.getEnable()%>">
		<td width="10%" class="tableCell" nowrap align="left"><%=ui.getName()%></td>
		<td width="20%" class="tableCell" nowrap align="left"><%=ui.getRealname()==null?"":ui.getRealname()%></td>
		<td width="20%" class="tableCell" nowrap align="left"><%=ui.getCompanyname()==null?"":ui.getCompanyname()%></td>
		<td width="30%" class="tableCell" nowrap align="left"><%=ui.getDescription()==null?"":ui.getDescription()%></td>
		<%
		 if (((Boolean)request.getSession().getAttribute(com.hp.ov.activator.mwfm.servlet.Constants.TEAM_ENABLED)).booleanValue() == true) {
		%>
		<td width="10%" class="tableCell" nowrap align="left"><%=ui.getTeamname()%></td>
		<%
		} else {
		%>		
		<td width="10%" class="tableCell" nowrap align="left"><%=ui.getSystemuser()%></td>
		<%
		}
		%>
		<td width="10%" class="tableCell" nowrap align="left"><%=ui.getEnable()?"Enabled":"Disabled"%></td>
	</tr>
	<%		++numRows;
     }
     }else{
       %>
   	<tr class="tableRowInfo">
   		<td class="tableRowInfo" colspan="5"><%=nouseravailable %></td>
   	</tr>
   	<%
     }
     }else{
   %>
	<tr class="tableRowInfo">
		<td class="tableRowInfo" colspan="5"><%=nouseravailable %></td>
	</tr>
	<%
     }

     
%>
	</TBODY>
</table>
<table>
  	<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
	<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
</table>
<TBODY>

	<!-- This table is hidden until selected for viewing with a right click -->
	<div id="userInfoMenu" class="contextMenu"
		onclick="hideContextMenu(window.menuName);"><a href="#"
		class="menuItem" target="displayFrame"
		onclick="return openUpdateUserInfo();"
		onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=udpateuserinfo %></a>
	<hr>
	<a href="#" class="menuItem" target="displayFrame"
		onclick="return openCopyUser();" onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=copyUser %></a>
	<hr>
	<a href="#" class="menuItem" target="displayFrame"
		onclick="return openRoleGrant();" onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=assignroles %></a>
	<hr id="deleteuserhr">
	<a id="deleteuser" href="#" class="menuItem" target="displayFrame"
		onclick="return deleteUser();" onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=deleteuser %></a><hr id="disableuserhr"></div>
