<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>

<%-- -*- html -*- --%>

<%@page info="Modify RL"
  import="com.hp.ov.activator.crmportal.servlet.*, java.sql.*, com.hp.ov.activator.crmportal.bean.*, java.util.*, java.io.*, java.text.*, java.net.*" %>

<%@ include file="../forms/LoadParams.jsp" %>

<%

  DatabasePool dbp = (DatabasePool) session.getAttribute (Constants.DATABASE_POOL);
  Connection con = null;

  RL[] rateLimits = null;
  String QoS = null;
  String priority = null;
  String rateLimit = null;
  String goldRate = null;
  String silverRate = null;
  String bronzeRate = null;

  int rowCounter;

  try {
    rowCounter = request.getParameter ("rowCounter") == null ? 0 : Integer.parseInt(request.getParameter ("rowCounter"));
  } catch (Exception e) {
    rowCounter = 0;
  }

  try {
    con = (Connection) dbp.getConnection();
    QoS = (String) serviceParameters.get("QoS");
    rateLimit = (String) serviceParameters.get("RL");
    rateLimits = RL.findAll(con);
    goldRate = (String) serviceParameters.get("GoldRate");
    silverRate = (String) serviceParameters.get ("SilverRate");
    bronzeRate = (String) serviceParameters.get ("BronzeRate");
  } catch (Exception e) { %>
    <B><bean:message key="errs.RL.Qos.inventory" /></B>: <%= e.getMessage () %>.
<%  return;
  } finally {
    dbp.releaseConnection (con);
  }
%>

<% if (QoS.equals ("Fixed")) { %>
  <tr height="30">
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
    <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.multi.RL" /></b></td>
    <td align=left class="list<%= (rowCounter % 2) %>">
    <select name="SP_RL">
<%    if (rateLimits != null) {
        String aux = rateLimit;
        if (rateLimit == null) {
          aux = rateLimits[0].getPrimaryKey();
        }

        for (int i = 0; i < rateLimits.length; i++) { %>
          <option<%= rateLimits[i].getPrimaryKey().equals (aux) ? " selected" : "" %> value="<%= rateLimits[i].getPrimaryKey() %>"><%= rateLimits[i].getPrimaryKey() %><bean:message key="label.bps" /></option>
<%      }
      } %>
    </select>
    </td>
    <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
  </tr>

<% } else if (QoS.equals ("CoS-based")) { %>
    <tr>
      <td class="title" width=5%>&nbsp;</td>
      <td class="title" align="left"><bean:message key="label.params.cosbasedqos" /></td>
      <td class="title">&nbsp;</td>
	  <td class="title">&nbsp;</td>
    </tr>
 
    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.gold" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
      <select name="SP_GoldRate">
<%    if (rateLimits != null) {
        if (goldRate == null) {
          goldRate = rateLimits[0].getPrimaryKey();
        }

        for (int i=0; rateLimits != null && i < rateLimits.length; i++) { %>
          <option<%= rateLimits[i].getRatelimit().equals (goldRate) ? " selected": "" %> value="<%=  rateLimits[i].getRatelimit() %>"><%= rateLimits[i].getRatelimit() %></option>
<%      }
      }
%>
      </select>
	  </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	  
    </tr>

   <% rowCounter++; %>
 
    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.silver" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
      <select name="SP_SilverRate">
<%    if (rateLimits != null) {
        if (silverRate == null) {
          silverRate = rateLimits[0].getPrimaryKey();
        }

        for (int i=0; rateLimits != null && i < rateLimits.length; i++) { %>
          <option<%= rateLimits[i].getRatelimit().equals (silverRate) ? " selected": "" %> value="<%=  rateLimits[i].getRatelimit() %>"><%= rateLimits[i].getRatelimit() %></option>
<%      }
      }
%>
      </select>
	  </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	  
    </tr>
 
   <% rowCounter++; %>
 
    <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.bronze" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
      <select name="SP_BronzeRate">
<%    if (rateLimits != null) {
        if (bronzeRate == null) {
          bronzeRate = rateLimits[0].getPrimaryKey();
        }

        for (int i=0; rateLimits != null && i < rateLimits.length; i++) { %>
          <option<%= rateLimits[i].getRatelimit().equals (bronzeRate) ? " selected": "" %> value="<%=  rateLimits[i].getRatelimit() %>"><%= rateLimits[i].getRatelimit() %></option>
<%      }
      }
%>
      </select>
	  </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	  
    </tr>
<% } %>

  <% rowCounter++; %>

  <tr>
      <th class="left" colspan=4><bean:message key="label.rl.schedulingInfo" /></th>
  </tr>
  <tr height="30">
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>
      <td align=left class="list<%= (rowCounter % 2) %>"><b><bean:message key="label.str.time" /></b></td>
      <td align=left class="list<%= (rowCounter % 2) %>">
        <input name="SP_StartTime" value="" title="yyyy.MM.dd HH:mm NOW: Leave the field empty" >
          <!--a href="#" onClick="window.alert('Timeformat: yyyy.MM.dd HH:mm \n NOW: Leave the field empty');">
            <img src="../images/help.gif" border="0" alt="Help on format"></a-->
      </td>
      <td class="list<%= (rowCounter % 2) %>">&nbsp;</td>	
    </tr>
  <% rowCounter++; %>

