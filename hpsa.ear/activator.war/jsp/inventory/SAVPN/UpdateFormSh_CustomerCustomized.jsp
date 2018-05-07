
<%@page info="Update form for bean Sh_Customer"
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
  <title><bean:message bundle="Sh_CustomerApplicationResources" key="jsp.update.title"/></title>
  <script language="JavaScript" src="/activator/javascript/checks.js"></script>
 <!-- <link rel="stylesheet" type="text/css" href="/activator/css/inventory.css">-->
  <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
</head>
</head>
<body>

<%! Object obj; %>

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
    alert("Unable to display update for: Sh_Customer<%=displayKey%>" + "\n" +
    "Potential reasons for failure are: "
     + "\n\n" + "   - The name of the object in the inventoryTree.xml file is incorrect."
     + "\n" + " - A parameter name in the inventoryTree.xml file is incorrect."
     + "\n" + " - The requested data may have previously been deleted.");

    </script>
<%
    } else {
%>

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

<form name="form" method="POST" action="/activator/jsp/inventory/SAVPN/UpdateCommitSh_Customer.jsp">

<!- WARNING: This field is of great importance and MUST be included in all customized UpdateForm JSP pages! -->
<input type="hidden" name="__hashcode" value="<%= ActivatorUtils.calculateHashValue(bean) %>">

<tr class="tableEvenRow">
   <td><div class="tableCell" id="req"><bean:message bundle="Sh_CustomerApplicationResources" key="field.customerid.alias"/></div></td>
   <td class="tableCell"><%= bean.getCustomerid() == null ? "" : TextFormater.HTMlize(bean.getCustomerid()) %></td>
   <td class="tableCell"></td>
</tr>
<input type="hidden" name="customerid" value="<%= bean.getCustomerid() == null ? "" : TextFormater.HTMlizeInventory(bean.getCustomerid()) %>">
<%
    StringBuffer custName = new StringBuffer();
    int colLength = 4 ;
    custName.append(bean.getCustomername().trim());
    int rowLength = 3;
    if(custName.toString().indexOf(";")>=1)
    {
        String []  customerArray = custName.toString().split(";");
        custName = new StringBuffer();
        rowLength = customerArray.length+1;
        for(int i =0; i<customerArray.length;i++)
        {
            String temp = customerArray[i];
            if(temp.length() >colLength)
                colLength = temp.length()+4;
            custName.append(temp.trim());
            if(i<(customerArray.length-1))
                custName.append("\n");
        }

    }
    else
        colLength = bean.getCustomername().length()+colLength;


%>

<tr class="tableOddRow">
   <td><div class="tableCell" id="opc"><bean:message bundle="Sh_CustomerApplicationResources" key="field.customername.alias"/></div> </td>
   <td class="tableCell"><textarea  name="customername" rows="<%= rowLength%>" cols="<%= colLength%>" ><%= custName%></textarea></td>


   <!--<input type=text  name="customername" value="<%= bean.getCustomername() == null ? "" : TextFormater.HTMlizeInventory(bean.getCustomername()) %>" size="20">-->

   <td class="tableCell"></td>
</tr>
<tr class="tableEvenRow">
   <td><div class="tableCell" id="req"><bean:message bundle="Sh_CustomerApplicationResources" key="field.marker.alias"/></div></td>
   <td class="tableCell"><%= bean.getMarker() == null ? "" : TextFormater.HTMlize(bean.getMarker()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_CustomerApplicationResources" key="field.marker.description"/></td>
</tr>
<input type="hidden" name="marker" value="<%= bean.getMarker() == null ? "" : TextFormater.HTMlizeInventory(bean.getMarker()) %>">
<tr class="tableOddRow">
   <td><div class="tableCell" id="req"><bean:message bundle="Sh_CustomerApplicationResources" key="field.uploadstatus.alias"/></div></td>
   <td class="tableCell"><%= bean.getUploadstatus() == null ? "" : TextFormater.HTMlize(bean.getUploadstatus()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_CustomerApplicationResources" key="field.uploadstatus.description"/></td>
</tr>
<input type="hidden" name="uploadstatus" value="<%= bean.getUploadstatus() == null ? "" : TextFormater.HTMlizeInventory(bean.getUploadstatus()) %>">
<tr class="tableEvenRow">
   <td><div class="tableCell" id="req"><bean:message bundle="Sh_CustomerApplicationResources" key="field.dbprimarykey.alias"/></div></td>
   <td class="tableCell"><%= bean.getDbprimarykey() == null ? "" : TextFormater.HTMlize(bean.getDbprimarykey()) %></td>
   <td class="tableCell"><bean:message bundle="Sh_CustomerApplicationResources" key="field.dbprimarykey.description"/></td>
</tr>
<input type="hidden" name="dbprimarykey" value="<%= bean.getDbprimarykey() == null ? "" : TextFormater.HTMlizeInventory(bean.getDbprimarykey()) %>">

<tr> <td>&nbsp;</td> </tr>
<tr> <td>&nbsp;</td> </tr>
<tr>
<td colspan="3" align="center">
   <input type="submit" name="submit"  value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>">&nbsp;
   <input type="reset" name="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>"> &nbsp;
</td>
</tr><%
 }
    } catch (Exception e) { %>
    <script>
    alert("Error retrieving information for: Sh_Customer" + "\n" +"<%= e.getMessage() == null ? "No Info available" : e.getMessage().replace('\n',' ') %>" );
    </script>
<% } finally {
       connection.close();
   }
 %>


</table></center>
</body>
</html>
