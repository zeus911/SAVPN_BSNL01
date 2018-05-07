
<%@page info="View JSP for bean Sh_L3VPN"
      import="com.hp.ov.activator.mwfm.servlet.*,
              com.hp.ov.activator.mwfm.*,
              com.hp.ov.activator.util.*,
              java.sql.*,
              com.hp.ov.activator.mwfm.WFManager,
              javax.sql.DataSource,
              java.net.*,
              java.text.*"
      session="true"
      contentType="text/html;charset=utf-8"
%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<!---------------------------------------------------------------------
-- Automatically generated code.
-- hp OpenView Service Activator InventoryBuilder 4.1
--
-- (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
----------------------------------------------------------------------->

<%
    if (session == null || session.getValue(Constants.USER) == null) {
        response.sendRedirect("/activator/jsp/sessionError.jsp");
        return;
    }

    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<script>

    var fPtr=parent.messageLine.document;
    fPtr.open();
    fPtr.write("");
    fPtr.close();
</script>

<html>
<head>
  <title><bean:message bundle="Sh_L3VPNApplicationResources" key="jsp.view.title"/> Sh_L3VPN</title>
  <script language="JavaScript" src="/activator/javascript/checks.js"></script>
  <!-- <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">-->
  <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
</head>
<body>


<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.Sh_L3VPN" />
<%

    // Set the properties on the bean - these values have been encoded and must be decoded prior to use
    if(request.getParameter("primaryKey") != null) {
        bean.setPrimaryKey(URLDecoder.decode(request.getParameter("primaryKey"), "UTF-8"));
    }
    else {
        bean.setServiceid(request.getParameter("serviceid") == null ? "" : URLDecoder.decode(request.getParameter("serviceid"),"UTF-8" ));
    }

    String displayKey = bean.getPrimaryKey();
%>

<%
    DataSource dataSource = (DataSource)session.getAttribute(Constants.DATASOURCE);
    Connection connection = null;
    try {
        connection = (Connection)dataSource.getConnection();
        bean = (com.hp.ov.activator.vpn.inventory.Sh_L3VPN)com.hp.ov.activator.vpn.inventory.Sh_L3VPN.findByPrimaryKey( connection, bean.getPrimaryKey() );
    if ( bean == null )
    {
%>
    <script>
    alert("Unable to display view for: Sh_L3VPN <%=displayKey%>" + "\n" +
    "Potential reasons for failure are: "
     + "\n\n" + "   - The name of the object in the inventoryTree.xml file is incorrect."
     + "\n" + " - A parameter name in the inventoryTree.xml file is incorrect."
     + "\n" + " - The requested data may have previously been deleted.");
    </script>
<%
    } else {
%>

<center>
<table cellSpacing="2" cellPadding="2" border="0" width="90%">
<tr class="tableTitle">
<td>
<bean:message bundle="InventoryResources" key="name.heading"/>
</td>
<td>
<bean:message bundle="InventoryResources" key="value.heading"/>
</td>
<td>
<bean:message bundle="InventoryResources" key="description.heading"/>
</td>
</tr><tr><td class="tableHeading" height=3 colspan=3></td></tr><tr class="tableEvenRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.serviceid.alias"/></div></td>
   <td class="tableCell"><%= bean.getServiceid() == null ? "" : TextFormater.HTMlize(bean.getServiceid()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.serviceid.description"/></td>
</tr>
<tr class="tableOddRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.customerid.alias"/></div></td>
   <td class="tableCell"><%= bean.getCustomerid() == null ? "" : TextFormater.HTMlize(bean.getCustomerid()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.customerid.description"/></td>
</tr>
<tr class="tableEvenRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.servicename.alias"/></div></td>
   <td class="tableCell"><%= bean.getServicename() == null ? "" : TextFormater.HTMlize(bean.getServicename()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.servicename.description"/></td>
</tr>
<tr class="tableOddRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.initiationdate.alias"/></div></td>
   <td class="tableCell"><%= bean.getInitiationdate() == null ? "" : TextFormater.HTMlize(bean.getInitiationdate()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.initiationdate.description"/></td>
</tr>
<tr class="tableEvenRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.activationdate.alias"/></div></td>
   <td class="tableCell"><%= bean.getActivationdate() == null ? "" : TextFormater.HTMlize(bean.getActivationdate()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.activationdate.description"/></td>
</tr>
<tr class="tableOddRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.modificationdate.alias"/></div></td>
   <td class="tableCell"><%= bean.getModificationdate() == null ? "" : TextFormater.HTMlize(bean.getModificationdate()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.modificationdate.description"/></td>
</tr>
<tr class="tableEvenRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.state.alias"/></div></td>
   <td class="tableCell"><%= bean.getState() == null ? "" : TextFormater.HTMlize(bean.getState()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.state.description"/></td>
</tr>
<tr class="tableOddRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.type.alias"/></div></td>
   <td class="tableCell"><%= bean.getType() == null ? "" : TextFormater.HTMlize(bean.getType()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.type.description"/></td>
</tr>
<tr class="tableEvenRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.contactperson.alias"/></div></td>
   <td class="tableCell"><%= bean.getContactperson() == null ? "" : TextFormater.HTMlize(bean.getContactperson()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.contactperson.description"/></td>
</tr>
<tr class="tableOddRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.marker.alias"/></div></td>
   <td class="tableCell"><%= bean.getMarker() == null ? "" : TextFormater.HTMlize(bean.getMarker()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.marker.description"/></td>
</tr>
<tr class="tableEvenRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.uploadstatus.alias"/></div></td>
   <td class="tableCell"><%= bean.getUploadstatus() == null ? "" : TextFormater.HTMlize(bean.getUploadstatus()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.uploadstatus.description"/></td>
</tr>
<tr class="tableOddRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.dbprimarykey.alias"/></div></td>
   <td class="tableCell"><%= bean.getDbprimarykey() == null ? "" : TextFormater.HTMlize(bean.getDbprimarykey()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.dbprimarykey.description"/></td>
</tr>

<% NumberFormat intNf = NumberFormat.getIntegerInstance(); %>

<tr class="tableEvenRow">
   <td><div class="tableCell" id="req">Reservation count</div></td>
   <td class="tableCell"><%= bean.get__count() %></td><td class="tableCell"> </td>
</tr>

<tr class="tableOddRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.vpntopologytype.alias"/></div></td>
   <td class="tableCell"><%= bean.getVpntopologytype() == null ? "" : TextFormater.HTMlize(bean.getVpntopologytype()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.vpntopologytype.description"/></td>
</tr>
<tr class="tableEvenRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.qosprofile_pe.alias"/></div></td>
   <td class="tableCell"><%= bean.getQosprofile_pe() == null ? "" : TextFormater.HTMlize(bean.getQosprofile_pe()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.qosprofile_pe.description"/></td>
</tr>
<tr class="tableOddRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.qosprofile_ce.alias"/></div></td>
   <td class="tableCell"><%= bean.getQosprofile_ce() == null ? "" : TextFormater.HTMlize(bean.getQosprofile_ce()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.qosprofile_ce.description"/></td>
</tr>
<tr class="tableEvenRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.parentid.alias"/></div></td>
   <td class="tableCell"><%= bean.getParentid() == null ? "" : TextFormater.HTMlize(bean.getParentid()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.parentid.description"/></td>
</tr>
<tr class="tableOddRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.multicast.alias"/></div></td>
   <td class="tableCell"><%= bean.getMulticast() == null ? "" : TextFormater.HTMlize(bean.getMulticast()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.multicast.description"/></td>
</tr>
<tr class="tableEvenRow">
   <td><div class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.comments.alias"/></div></td>
   <td class="tableCell"><textarea rows="5" cols="20"><%= bean.getComments()== null ? "" : bean.getComments() %></textarea></td>
   <td class="tableCell"><bean:message bundle="Sh_L3VPNApplicationResources" key="field.comments.description"/></td>
</tr>

<tr> <td>&nbsp;</td> </tr>
<tr> <td>&nbsp;</td> </tr><%
 }
    } catch (Exception e) { %>
    <script>
    alert("Error retrieving information for: Sh_L3VPN" + "\n" +"<%= e.getMessage() == null ? "No Info available" : e.getMessage().replace('\n',' ') %>" );
    </script>
<% } finally {
       connection.close();
   }
 %>


</table> </center>

      <script>
         var fPtr=parent.messageLine.document;
         fPtr.open();
         fPtr.write("<html>");
         fPtr.write("<link rel='stylesheet' type='text/css' href='/activator/css/inventory.css'>");
         fPtr.write("<body class=invCell>");
         fPtr.write("JSP does not contain any editable fields.");
         fPtr.write("</body></html>");
         fPtr.close();
      </script>

</body>
</html>
