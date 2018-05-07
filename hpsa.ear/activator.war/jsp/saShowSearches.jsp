<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants"%>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%!
    //I18N strings
    final static String searchname  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1313", "Search Name");
    final static String nosearchavailable  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1314", "No Searches available");
    final static String updatesearchinfo  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1315", "Update search associations");
    final static String deleteSearches  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1316", "Delete Search");
    
%>
<script language="JavaScript" src="/activator/javascript/sort.js"></script>

<script language="JavaScript">
    window.onload = function () {
       window.menuName = "searchInfoMenu";
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
    
    function deleteSearches() {
      var searchid =  getCookie(window.menuName);
      if (searchid == null)  {
         writeToMsgLine("Please select a search.");
         return false;
      }
      var myArray = searchid.split("~");
      
	  var solname = myArray[0];
	  var viewname = myArray[1];
	  var searchname= myArray[2];
	        
      hideContextMenu(window.menuName);
      if (confirm("Do you want to delete search " + document.getElementById(searchid).getElementsByTagName("TD")[2].firstChild.nodeValue  + "?")) {
          top.main.location.href = '/activator/umm/DeleteCommitSearchInventoryAction.do?page_solname='+escape(solname)+'&page_viewname='+escape(viewname)+'&page_searchname='+escape(searchname);
          return true;
      }
      else {
          writeToMsgLine("Search deleting is canceled.");
      }
      return true;
    }    
    
    function openUpdateSearchAssociation() {
      var win;
      var searchid =  getCookie(window.menuName);
      if (searchid == null)  {
         writeToMsgLine("Please select a Search.");
         return false;
      }
      var myArray = searchid.split("~");
      
	  var solname = myArray[0];
	  var viewname = myArray[1];
	  var searchname= myArray[2];	
      hideContextMenu(window.menuName);
//      var returnValue=window.showModalDialog('/activator/umm/CreationFormSearchInventoryAction.do?firstOpen=yes&page_solname='+solname+'&page_viewname='+viewname+'&page_searchname='+escape(searchname),window,"dialogHeight:600px;dialogWidth:700px");
//      if (returnValue==1)
//	    {
//	        window.location.href="/activator/umm/SearchCommitSearchInventoryAction.do";
//	    }
	  win = window.open('/activator/umm/CreationFormSearchInventoryAction.do?firstOpen=yes&page_solname='+escape(solname)+'&page_viewname='+escape(viewname)+'&page_searchname='+escape(searchname) +'&firstOpen=yes','','resizable=yes,toolbar=no,scrollbars=no,menubar=no,directories=no,width=700,height=600');
//      win = window.open('/activator/umm/CreationFormSearchInventoryAction.do?firstOpen=yes&page_solname='+solname+'&page_viewname='+viewname+'&page_searchname='+escape(searchname),window,"dialogHeight:600px;dialogWidth:700px");
      win.focus();

    }
    
</script>


<table class="activatorTable" id="userInfo">
	<THEAD>
		<tr id="header">
			<td width="10%" class="mainHeading" onclick="sortAble('userInfo',0)" onmouseover="mOver(this)"><%=solutionname %></td>
			<td width="20%" class="mainHeading" onclick="sortAble('userInfo',1)" onmouseover="mOver(this)"><%=treename %></td>
			<td width="30%" class="mainHeading" onclick="sortAble('userInfo',2)" onmouseover="mOver(this)"><%=searchname %></td>
			<td width="40%" class="mainHeading"><%=description %></td>
		</tr>
	</THEAD>

	<%
	ArrayList srList = (ArrayList)session.getAttribute("srhTreeArray");
      if (srList != null) {
        int listCount = srList.size();
        int numRows = 1;
        if (listCount > 0) {
          for (int i = 0; i < listCount; i++) {
            String rowClass= (numRows%2 == 0) ? "tableEvenRow" : "tableOddRow";
            String srv = (String)srList.get(i);
		      StringTokenizer st = new StringTokenizer(srv, "||");
		      String[] strArray = new String[st.countTokens()];
		      int ii = 0;
		      while (st.hasMoreTokens()) {
		        strArray[ii++] = st.nextToken();
		      }
		      String solName = strArray[0];
		      String viewName = strArray[1];
		      String srhName = strArray[2];
		      String srhNameDesc = strArray[3];     
		      String id =   solName+"~"+viewName+"~"+srhName;         
%>
	<tr id="<%=id%>" class="<%=rowClass %>"
		onClick="hideContextMenu('searchInfoMenu');"
		onMouseOver="mouseOver(this);" onMouseOut="mouseOut(this);">
		<td width="10%" class="tableCell" nowrap align="left"><%if (solName != null && ! "null".equals(solName)){%>
		<%=solName%> <%} else {


            %> &nbsp; <%}
%></td>
		<td width="20%" class="tableCell" nowrap align="left"><%=viewName%></td>
		<td width="30%" class="tableCell" nowrap align="left"><%=srhName==null?"":srhName%></td>
		<td width="40%" class="tableCell" nowrap align="left"><%=srhNameDesc==null?"":srhNameDesc%>
		</td>
	</tr>
	<%
	++numRows;
          }
          }else{
            %>
        	<tr class="tableRowInfo">
        		<td class="tableRowInfo" colspan="4"><%=nosearchavailable %></td>
        	</tr>
        	<%
          }

          }else{
        %>
     	<tr class="tableRowInfo">
     		<td class="tableRowInfo" colspan="4"><%=nosearchavailable %></td>
     	</tr>
     	<%
          }


    %>

	</TBODY>
</table>
<TBODY>


	<!-- This table is hidden until selected for viewing with a right click -->
	<div id="searchInfoMenu"
		style="position: absolute;top: 0px;background-color: #e6e6e6;border-style: solid;border-width: 1px;border-color: #efefef #505050 #505050 #efefef;visibility: hidden; border-left: 1px solid black;border-top: 1px solid black;border-bottom: 3px solid black;border-right: 3px solid black;padding: 3px;z-index: 101;width: 200;"
		onclick="hideContextMenu(window.menuName);"><a href="#"
		class="menuItem" target="displayFrame"
		onclick="return openUpdateSearchAssociation();"
		onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=updatesearchinfo %></a>
	<hr>		
		<a href="#" class="menuItem" target="displayFrame"
		onclick="return deleteSearches();" onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=deleteSearches %></a>
