
<%@page info="View JSP for bean Sh_Customer"
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
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri = "/WEB-INF/table-taglib.tld" prefix="table" %>
<%@ taglib uri = "/WEB-INF/button-taglib.tld" prefix="btn" %>

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
  <title><bean:message bundle="Sh_CustomerApplicationResources" key="jsp.view.title"/></title>
  <script language="JavaScript" src="/activator/javascript/checks.js"></script>
  <!-- <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">-->
  <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
</head>
<body>


<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.Sh_Customer" />
<%
    // Set the properties on the bean - these values have been encoded and must be decoded prior to use
    if(request.getParameter("primaryKey") != null) {
        bean.setPrimaryKey(URLDecoder.decode(request.getParameter("primaryKey"), "UTF-8"));
    }
    else {
        bean.setCustomerid(request.getParameter("customerid") == null ? "" : URLDecoder.decode(request.getParameter("customerid"),"UTF-8" ));
    }

    String displayKey = bean.getPrimaryKey();
%>

<%
    DataSource dataSource = (DataSource)session.getAttribute(Constants.DATASOURCE);
    Connection connection = null;
    try {
        connection = (Connection)dataSource.getConnection();
        bean = (com.hp.ov.activator.vpn.inventory.Sh_Customer)com.hp.ov.activator.vpn.inventory.Sh_Customer.findByPrimaryKey( connection, bean.getPrimaryKey() );
    if ( bean == null )
    {
%>
    <script>
    alert("Unable to display view for: Sh_Customer <%=displayKey%>" + "\n" +
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
</tr><tr><td class="tableHeading" height=3 colspan=3></td></tr>
<tr class="tableEvenRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_CustomerApplicationResources" key="field.customerid.alias"/></div></td>
   <td class="tableCell"><%= bean.getCustomerid() == null ? "" : TextFormater.HTMlize(bean.getCustomerid()) %></td>
   <td class="tableCell"></td>
</tr>
<tr class="tableOddRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_CustomerApplicationResources" key="field.customername.alias"/></div></td>
   <td class="tableCell">

<%
    String custName = bean.getCustomername();
    if(custName.indexOf(";")>=1)
    {
        String []  customerArray = custName.split(";");
        for(int i =0; i<customerArray.length;i++)
        {

%>
   <%= TextFormater.HTMlize(customerArray[i])%>
   <br>
<%      }
    }
    else
    {
%>
    <%= TextFormater.HTMlize(custName)%>
<%
   }

%>

   </td>
   <td class="tableCell"></td>
</tr>
<tr class="tableEvenRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_CustomerApplicationResources" key="field.marker.alias"/></div></td>
   <td class="tableCell"><%= bean.getMarker() == null ? "" : TextFormater.HTMlize(bean.getMarker()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_CustomerApplicationResources" key="field.marker.description"/></td>
</tr>
<tr class="tableOddRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_CustomerApplicationResources" key="field.uploadstatus.alias"/></div></td>
   <td class="tableCell"><%= bean.getUploadstatus() == null ? "" : TextFormater.HTMlize(bean.getUploadstatus()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_CustomerApplicationResources" key="field.uploadstatus.description"/></td>
</tr>
<tr class="tableEvenRow">
   <td> <div class="tableCell"><bean:message bundle="Sh_CustomerApplicationResources" key="field.dbprimarykey.alias"/></div></td>
   <td class="tableCell"><%= bean.getDbprimarykey() == null ? "" : TextFormater.HTMlize(bean.getDbprimarykey()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_CustomerApplicationResources" key="field.dbprimarykey.description"/></td>
</tr>

<tr> <td>&nbsp;</td> </tr>
<tr> <td>&nbsp;</td> </tr><%
 }
    } catch (Exception e) { %>
    <script>
    alert("Error retrieving information for: Sh_Customer" + "\n" +"<%= e.getMessage() == null ? "No Info available" : e.getMessage().replace('\n',' ') %>" );
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
