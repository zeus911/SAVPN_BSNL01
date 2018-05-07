<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants"%>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%!
    //I18N strings
    final static String notreeviewavailable  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("860", "No tree view available");
    
%>
<script language="JavaScript" src="/activator/javascript/sort.js"></script>
<table class="activatorTable" id="userInfo">
	<THEAD>
		<tr id="header">
			<td width="10%" class="mainHeading" onclick="sortAble('userInfo',0)" onmouseover="mOver(this)"><%=solutionname %></td>
			<td width="10%" class="mainHeading" onclick="sortAble('userInfo',1)" onmouseover="mOver(this)"><%=solutionlabel %></td>
			<td width="12%" class="mainHeading" onclick="sortAble('userInfo',2)" onmouseover="mOver(this)"><%=solutionsequence %></td>
			<td width="15%" class="mainHeading" onclick="sortAble('userInfo',3)" onmouseover="mOver(this)"><%=treename %></td>
			<td width="12%" class="mainHeading" onclick="sortAble('userInfo',4)" onmouseover="mOver(this)"><%=treesequence %></td>
			<td width="30%" class="mainHeading"><%=description %></td>
		</tr>
	</THEAD>

	<%ArrayList tdList = (ArrayList)session.getAttribute("treeDefinitionArray");
      if (tdList != null) {
        int listCount = tdList.size();
        int numRows = 1;
        if (listCount > 0) {
          for (int i = 0; i < listCount; i++) {
            com.hp.ov.activator.mwfm.engine.module.umm.beans.ViewTree otv = (com.hp.ov.activator.mwfm.engine.module.umm.beans.ViewTree)tdList
                .get(i);
            String rowClass = (numRows % 2 == 0) ? "tableEvenRow" : "tableOddRow";
%>
	<tr id="<%=otv.getName()%>" class="<%=rowClass %>"
		onMouseOver="mouseOver(this);" onMouseOut="mouseOut(this);">
		<td width="10%" class="tableCell" nowrap align="left"><%if (otv.getSolution() != null) {%>
		<%=otv.getSolution()%> <%} else {
            %> &nbsp; <%}
            %></td>
        <td width="10%" class="tableCell" nowrap align="left"><%if (otv.getSolutionlabel() != null) {%>
		<%=otv.getSolutionlabel()%> <%} else {
            %> &nbsp; <%}
            %></td>
        <td width="12%" class="tableCell" nowrap align="left"><%=otv.getSolutionsequencenumber()%></td>    
		<td width="15%" class="tableCell" nowrap align="left"><%=otv.getName()%></td>
		<td width="12%" class="tableCell" nowrap align="left"><%=otv.getTreesequencenumber()%></td>
		<td width="30%" class="tableCell" nowrap align="left"><%=otv.getDescription()==null?"":otv.getDescription()%>
		</td>
	</tr>
<%		++numRows;
     }
     }else{
       %>
   	<tr class="tableRowInfo">
   		<td class="tableRowInfo" colspan="6"><%=notreeviewavailable %></td>
   	</tr>
   	<%
     }

     }else{
   %>
	<tr class="tableRowInfo">
		<td class="tableRowInfo" colspan="6"><%=notreeviewavailable %></td>
	</tr>
	<%
     }


    %>
	</TBODY>
</table>
<TBODY>
