<%@ page import="com.hp.ov.activator.mwfm.servlet.Constants"%>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%!
    //I18N strings
    final static String operationtypename  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("796", "Operation Type Name");
    final static String nooperationtypeavailable  = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("797", "No operation type available");
    
%>
<script language="JavaScript" src="/activator/javascript/sort.js"></script>
<table class="activatorTable" id="userInfo">
	<THEAD>
		<tr id="header">
			<td width="10%" class="mainHeading" onclick="sortAble('userInfo',0)" onmouseover="mOver(this)"><%=solutionname %></td>
			<td width="20%" class="mainHeading" onclick="sortAble('userInfo',1)" onmouseover="mOver(this)"><%=treename %></td>
			<td width="30%" class="mainHeading" onclick="sortAble('userInfo',2)" onmouseover="mOver(this)"><%=operationtypename %></td>
			<td width="40%" class="mainHeading"><%=description %></td>
		</tr>
	</THEAD>

	<%
	ArrayList otList = (ArrayList)session.getAttribute("optTreeArray");
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
		      String opTypeName = strArray[2];
		      String opTypeNameDesc = strArray[3];                
%>
	<tr id="<%=solName%>" class="<%=rowClass %>"
		onMouseOver="mouseOver(this);" onMouseOut="mouseOut(this);">
		<td width="10%" class="tableCell" nowrap align="left"><%if (solName != null && ! "null".equals(solName)){%>
		<%=solName%> <%} else {


            %> &nbsp; <%}
%></td>
		<td width="20%" class="tableCell" nowrap align="left"><%=viewName%></td>
		<td width="30%" class="tableCell" nowrap align="left"><%=opTypeName==null?"":opTypeName%></td>
		<td width="40%" class="tableCell" nowrap align="left"><%=opTypeNameDesc==null?"":opTypeNameDesc%>
		</td>
	</tr>
	<%
	++numRows;
          }
          }else{
            %>
        	<tr class="tableRowInfo">
        		<td class="tableRowInfo" colspan="4"><%=nooperationtypeavailable %></td>
        	</tr>
        	<%
          }

          }else{
        %>
     	<tr class="tableRowInfo">
     		<td class="tableRowInfo" colspan="4"><%=nooperationtypeavailable %></td>
     	</tr>
     	<%
          }


    %>

	</TBODY>
</table>
<TBODY>