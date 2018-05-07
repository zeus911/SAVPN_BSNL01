
<!------------------------------------------------------------------------
   hp OpenView service activator
   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
------------------------------------------------------------------------->
<%@page info="Update form for bean IPNet/IPHost"
    import="java.sql.*,
              javax.sql.DataSource,
              java.net.*,
              com.hp.ov.activator.vpn.inventory.*,
          com.hp.ov.activator.inventory.SAVPN.*,
          org.apache.struts.util.LabelValueBean,
          com.hp.ov.activator.mwfm.servlet.inventory.inventorytree.InventoryTreeServlet,
          com.hp.ov.activator.inventory.facilities.StringFacility"
    session="true" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table"%>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn"%>

<%
     if (session == null || session.getAttribute(IPAddrPoolConstants.USER) == null) {
        response.sendRedirect("/activator/jsp/sessionError.jsp");
        return;
    }
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>



<%
/** For Struts module concept **/
org.apache.struts.config.ModuleConfig strutsModuleConfig =
            org.apache.struts.util.ModuleUtils.getInstance().getModuleConfig(null,
                (HttpServletRequest) pageContext.getRequest(),
                pageContext.getServletContext());
// module name that can be used as solution name
String moduleConfig = strutsModuleConfig.getPrefix();
%>

<script>
    var fPtr=parent.messageLine.document;
    fPtr.open();
    fPtr.write("");
    fPtr.close();
</script>


<html>
<head>
  <title>Update IPAddrPool</title>
  <script language="JavaScript" src="/activator/javascript/checks.js"></script>
<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet"
    href="/activator/css/inventory-gui/subestilos.css">
<script src="/activator/javascript/hputils/alerts.js"></script>
<style type="text/css">
    A.nodec { text-decoration: none; }
    H1 { color: red; font-size: 13px }
</style></head>
<body background="/activator/images/inventory-gui/fondo.gif"
    style="overflow:auto;">

<%! Object obj; %>

<jsp:useBean id="bean" class="com.hp.ov.activator.vpn.inventory.IPAddrPool" />
<%
    // Set the properties on the bean - these values have been encoded and must be decoded prior to use
    if(request.getParameter("primaryKey") != null) {
        bean.setPrimaryKey(URLDecoder.decode(request.getParameter("primaryKey"), "UTF-8"));
    }
    else {
        bean.setName(request.getParameter("name") == null ? "" : URLDecoder.decode(request.getParameter("name"),"UTF-8" ));
    }

    String displayKey = bean.getPrimaryKey();
%>

<%

    DataSource dataSource = (DataSource) InventoryTreeServlet.getDatasource(request.getParameter(IPAddrPoolConstants.DATASOURCE));
    Connection connection = null;
    try {
        connection = (Connection)dataSource.getConnection();
        bean = (com.hp.ov.activator.vpn.inventory.IPAddrPool)com.hp.ov.activator.vpn.inventory.IPAddrPool.findByPrimaryKey( connection, bean.getPrimaryKey() );
    if ( bean == null )
    {
%>
    <script>
    alert("Unable to display update for: IPAddrPool<%=displayKey%>" + "\n" +
    "Potential reasons for failure are: "
     + "\n\n" + "   - The name of the object in the inventoryTree.xml file is incorrect."
     + "\n" + " - A parameter name in the inventoryTree.xml file is incorrect."
     + "\n" + " - The requested data may have previously been deleted.");
    </script>
<%
    } else {
%>
<center>
  <h2>
    <bean:message bundle="IPAddrPoolApplicationResources" key="jsp.update.title"/>
  </h2>
</center>

<!--<form name="form" method="POST" target="messageLine" action="UpdateCommitIPAddrPoolCustomized.jsp">-->
<form name="form" method="POST" target="showMessage"
    action="../jsp<%=moduleConfig%>/UpdateCommitIPAddrPoolCustomized.jsp">

<center>
<table:table>
<table:header>
<table:cell>
    <bean:message bundle="InventoryResources" key="name.heading" />
</table:cell>
<table:cell>
    <bean:message bundle="InventoryResources" key="value.heading" />
</table:cell>
<table:cell>
    <bean:message bundle="InventoryResources" key="description.heading" />
</table:cell>
</table:header>


<table:row>
<table:cell>
<bean:message bundle="IPAddrPoolApplicationResources" key="field.name.alias"/>
*
</table:cell>
<table:cell>

<%= bean.getName() != null? bean.getName() : "" %>
</table:cell>
<table:cell>
<bean:message bundle="IPAddrPoolApplicationResources" key="field.name.description"/>
</table:cell>
</table:row>
<input type="hidden" name="name" value="<%= bean.getName() == null ? "" : bean.getName() %>">

<table:row>
<table:cell>
<bean:message bundle="IPAddrPoolApplicationResources" key="field.ipnet.alias"/>
*
</table:cell>
<table:cell>
<input type=text  name="ipnet" value="<%= bean.getIpnet() == null ? "" : bean.getIpnet() %>" size="20">
</table:cell>
<table:cell>
<bean:message bundle="IPAddrPoolApplicationResources" key="field.ipnet.description"/>
</table:cell>
</table:row>

<table:row>
<table:cell>
<bean:message bundle="IPAddrPoolApplicationResources" key="field.mask.alias"/>
*
</table:cell>
<table:cell>

<input type=text  name="mask" value="<%= bean.getMask() == null ? "" : bean.getMask() %>" size="20"></table:cell>
<table:cell>
<bean:message bundle="IPAddrPoolApplicationResources" key="field.mask.description"/>
</table:cell>
</table:row>

<table:row>
<table:cell>
<bean:message bundle="IPAddrPoolApplicationResources" key="field.type.alias"/>
*
</table:cell>
<table:cell>
   <%= bean.getType() == null ? "" : bean.getType() %>
</table:cell>
<table:cell>
<bean:message bundle="IPAddrPoolApplicationResources" key="field.type.description"/>
</table:cell>
</table:row>

<input type="hidden" name="type" value="<%= bean.getType() == null ? "" :bean.getType()%>">
<input type="hidden" name="old_ipnet" value="<%= bean.getIpnet() == null ? "" :bean.getIpnet()%>">
<input type="hidden" name="old_mask" value="<%=bean.getMask() == null ? "" :bean.getMask()%>">

<table:row>
<table:cell colspan="3" align="center">
<br>
</table:cell>
</table:row>

<table:row>
<table:cell colspan="3" align="center">
<input type="submit" name="submit"
    value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>">&nbsp
<input type="reset" name="reset"
    value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>"> &nbsp
</table:cell>
</table:row>
</table:table></center>

<%
 } }catch (Exception e) { %>
    <script>
    alert("Error retrieving information for: IPAddrPool" + "\n" +"<%= e.getMessage() == null ? "No Info available" : e.getMessage().replace('\n',' ') %>" );
    </script>
<% } finally {
       connection.close();
   }
 %>
</form>
</body>
</html>

<center><iframe src="../blank.html" name="showMessage" frameBorder="false" WIDTH="400" HEIGHT="150"></iframe></center>
