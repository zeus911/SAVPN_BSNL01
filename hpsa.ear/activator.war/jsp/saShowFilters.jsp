<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants"%>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%!
    //I18N strings
    final static String filtername  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1306", "Filter Name");
    final static String nofilteravailable  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1347", "No Filters available");
    final static String updatefilterinfo  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1308", "Update filter associations");
    final static String deleteFilter  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1309", "Delete Filter");
%>
<script language="JavaScript" src="/activator/javascript/sort.js"></script>

<script language="JavaScript">
    window.onload = function () {
       window.menuName = "filterInfoMenu";
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
    
    function deleteFilter() {
      var filterid =  getCookie(window.menuName);
      if (filterid == null)  {
         writeToMsgLine("Please select a filter.");
         return false;
      }
      var myArray = filterid.split("~");
      
	  var solname = myArray[0];
	  var viewname = myArray[1];
	  var filtername= myArray[2];
	        
      hideContextMenu(window.menuName);
      if (confirm("Do you want to delete filter " + document.getElementById(filterid).getElementsByTagName("TD")[2].firstChild.nodeValue  + "?")) {
          top.main.location.href = '/activator/umm/DeleteCommitFilterInventoryAction.do?page_solname='+escape(solname)+'&page_viewname='+escape(viewname)+'&page_filtername='+escape(filtername);
          return true;
      }
      else {
          writeToMsgLine("Filter deleting is canceled.");
      }
      return true;
    }     
    
    function openUpdateFilterAssociation() {
      var win;
      var filterid =  getCookie(window.menuName);
      if (filterid == null)  {
         writeToMsgLine("Please select a Filter.");
         return false;
      }
      var myArray = filterid.split("~");
      
	  var solname = myArray[0];
	  var viewname = myArray[1];
	  var filtername= myArray[2];	
      hideContextMenu(window.menuName);
	  win = window.open('/activator/umm/CreationFormFilterInventoryAction.do?firstOpen=yes&page_solname='+escape(solname)+'&page_viewname='+escape(viewname)+'&page_filtername='+escape(filtername) +'&firstOpen=yes','','resizable=yes,toolbar=no,scrollbars=no,menubar=no,directories=no,width=1100,height=600');
      win.focus();

    }
    
</script>

<table class="activatorTable" id="userInfo">
	<THEAD>
		<tr id="header">
			<td width="10%" class="mainHeading" onclick="sortAble('userInfo',0)" onmouseover="mOver(this)"><%=solutionname %></td>
			<td width="20%" class="mainHeading" onclick="sortAble('userInfo',1)" onmouseover="mOver(this)"><%=treename %></td>
			<td width="30%" class="mainHeading" onclick="sortAble('userInfo',2)" onmouseover="mOver(this)"><%=filtername %></td>
			<td width="40%" class="mainHeading"><%=description %></td>
		</tr>
	</THEAD>

	<%
	ArrayList flList = (ArrayList)session.getAttribute("filTreeArray");
      if (flList != null) {
        int listCount = flList.size();
        int numRows = 1;
        if (listCount > 0) {
          for (int i = 0; i < listCount; i++) {
            String rowClass= (numRows%2 == 0) ? "tableEvenRow" : "tableOddRow";
            String flv = (String)flList.get(i);
		      StringTokenizer st = new StringTokenizer(flv, "||");
		      String[] strArray = new String[st.countTokens()];
		      int ii = 0;
		      while (st.hasMoreTokens()) {
		        strArray[ii++] = st.nextToken();
		      }
		      String solName = strArray[0];
		      String viewName = strArray[1];
		      String filName = strArray[2];
		      String filNameDesc = strArray[3];       
		      String id =   solName+"~"+viewName+"~"+filName;         
%>
	<tr id="<%=id%>" class="<%=rowClass %>"
		onMouseOver="mouseOver(this);" onMouseOut="mouseOut(this);">
		<td width="10%" class="tableCell" nowrap align="left"><%if (solName != null && ! "null".equals(solName)){%>
		<%=solName%> <%} else {


            %> &nbsp; <%}
%></td>
		<td width="20%" class="tableCell" nowrap align="left"><%=viewName%></td>
		<td width="30%" class="tableCell" nowrap align="left"><%=filName==null?"":filName%></td>
		<td width="40%" class="tableCell" nowrap align="left"><%=filNameDesc==null?"":filNameDesc%>
		</td>
	</tr>
	<%
	++numRows;
          }
          }else{
            %>
        	<tr class="tableRowInfo">
        		<td class="tableRowInfo" colspan="4"><%=nofilteravailable %></td>
        	</tr>
        	<%
          }

          }else{
        %>
     	<tr class="tableRowInfo">
     		<td class="tableRowInfo" colspan="4"><%=nofilteravailable %></td>
     	</tr>
     	<%
          }


    %>

	</TBODY>
</table>
<TBODY>


	<!-- This table is hidden until selected for viewing with a right click -->
	<div id="filterInfoMenu"
		style="position: absolute;top: 0px;background-color: #e6e6e6;border-style: solid;border-width: 1px;border-color: #efefef #505050 #505050 #efefef;visibility: hidden; border-left: 1px solid black;border-top: 1px solid black;border-bottom: 3px solid black;border-right: 3px solid black;padding: 3px;z-index: 101;width: 200;"
		onclick="hideContextMenu(window.menuName);"><a href="#"
		class="menuItem" target="displayFrame"
		onclick="return openUpdateFilterAssociation();"
		onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=updatefilterinfo %></a>
	<hr>		
		<a href="#" class="menuItem" target="displayFrame"
		onclick="return deleteFilter();" onmouseover="toggleHighlight(event)"
		onmouseout="toggleHighlight(event)"> <%=deleteFilter %></a>		
