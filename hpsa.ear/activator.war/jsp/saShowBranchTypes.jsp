<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants"%>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%!
    //I18N strings
    final static String branchtreename  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("755", "Branch Tree Name");
    final static String nobranchtypeavailable  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("756", "No branch type available");
    
%>
<script language="JavaScript" src="/activator/javascript/sort.js"></script>
<table class="activatorTable" id="userInfo">
	<THEAD>
		<tr id="header">
			<td width="10%" class="mainHeading" onclick="sortAble('userInfo',0)" onmouseover="mOver(this)"><%=solutionname %></td>
			<td width="20%" class="mainHeading" onclick="sortAble('userInfo',1)" onmouseover="mOver(this)"><%=treename %></td>
			<td width="30%" class="mainHeading" onclick="sortAble('userInfo',2)" onmouseover="mOver(this)"><%=branchtreename %></td>
			<td width="40%" class="mainHeading"><%=description %></td>
		</tr>
	</THEAD>

	<%
	
	ArrayList otList = (ArrayList)session.getAttribute("branchTreeArray");
      if (otList != null) {
        int listCount = otList.size();
        int numRows = 1;
        if (listCount > 0) {
          for (int i = 0; i < listCount; i++) {
            String rowClass= (numRows%2 == 0) ? "tableEvenRow" : "tableOddRow";
            String otv = (String)otList.get(i);
		      StringTokenizer st = new StringTokenizer(otv, "||");
		      String[] strArray = new String[st.countTokens()];
		      int ii = 0;
		      while (st.hasMoreTokens()) {
		        strArray[ii++] = st.nextToken();
		      }
		      String solName = strArray[0];
		      String viewName = strArray[1];
		      String branchTypeName = strArray[2];
		      String branchTypeNameDesc = strArray[3];
%>
	<tr id="<%=solName%>" class="<%=rowClass %>"
		onMouseOver="mouseOver(this);" onMouseOut="mouseOut(this);">
		<td width="10%" class="tableCell" nowrap align="left"><%if (solName != null && ! "null".equals(solName)){%>
		<%=solName%> <%} else {


            %> &nbsp; <%}


            %></td>
		<td width="20%" class="tableCell" nowrap align="left"><%=viewName%></td>
		<td width="30%" class="tableCell" nowrap align="left"><%=branchTypeName==null?"":branchTypeName%></td>
		<td width="40%" class="tableCell" nowrap align="left"><%=branchTypeNameDesc==null?"":branchTypeNameDesc%>
		</td>
	</tr>
<%		++numRows;
     }
     }else{
       %>
   	<tr class="tableRowInfo">
   		<td class="tableRowInfo" colspan="4"><%=nobranchtypeavailable %></td>
   	</tr>
   	<%
     }

     }else{
   %>
	<tr class="tableRowInfo">
		<td class="tableRowInfo" colspan="4"><%=nobranchtypeavailable %></td>
	</tr>
	<%
     }


    %>

	</TBODY>
</table>
<TBODY>