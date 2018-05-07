﻿
<!------------------------------------------------------------------------
   hp OpenView service activator
   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
------------------------------------------------------------------------->
<%@page info="Creation form for bean IPNet/IPHost"
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
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

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

<%
    if (session == null || session.getAttribute(IPAddrPoolConstants.USER) == null) {
        response.sendRedirect("/activator/jsp/sessionError.jsp");
        return;
    }
%>

<jsp:useBean id="bean"
    class="com.hp.ov.activator.vpn.inventory.IPAddrPool" />

<%
    if(request.getParameter("name") != null) {
        bean.setPrimaryKey(URLDecoder.decode(request.getParameter("name"), "UTF-8"));
    }

    String displayKey = bean.getPrimaryKey();


    DataSource dbp = (DataSource) InventoryTreeServlet.getDatasource(request.getParameter(IPAddrPoolConstants.DATASOURCE));
    Connection con = null;
    try {
        con = (Connection)dbp.getConnection();
        bean = (com.hp.ov.activator.vpn.inventory.IPAddrPool)com.hp.ov.activator.vpn.inventory.IPAddrPool.findByPrimaryKey( con, bean.getPrimaryKey() );
    if ( bean == null || con == null)
    {
%>
<script>
    alert("Unable to display for creation: Address pool <%=StringFacility.replaceAllByHTMLCharacter(displayKey)%>" + "\n" +
    "Potential reasons for failure are: "
     + "\n\n" + "   - The name of the object in the inventoryTree.xml file is incorrect."
     + "\n" + " - A parameter name in the inventoryTree.xml file is incorrect."
     + "\n" + " - The requested data may have previously been deleted.");
</script>
<%
    } else {

    final String beanType = bean.getType().trim();
    String title = "";



    if(beanType.equalsIgnoreCase("IPHost") || beanType.equalsIgnoreCase("MDT Default") ||beanType.equalsIgnoreCase("LSP")
        || beanType.equalsIgnoreCase("NAT") || beanType.equalsIgnoreCase("Multicast loopback") ) {
	%>

<html>
<head>
<title><%=title%></title>
<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet"
    href="/activator/css/inventory-gui/subestilos.css">
<script src="/activator/javascript/hputils/alerts.js"></script>
<style type="text/css">
    A.nodec { text-decoration: none; }
    H1 { color: red; font-size: 13px }
</style>
</head>
<body background="/activator/images/inventory-gui/fondo.gif"
    style="overflow:auto;">
<center>
  <h2>
    <bean:message bundle="IPAddrPoolApplicationResources" key="jsp.creation.title1"/> <%=beanType%>  <bean:message bundle="IPAddrPoolApplicationResources" key="jsp.creation.title2"/>
  </h2>
</center>

<form name="form" method="POST" target="showMessage"
    action="../jsp<%=moduleConfig%>/CreationCommitCE_LoopbackInPool.jsp">
<center><table:table>
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
            <bean:message bundle="IPAddrPoolApplicationResources"
                key="field.pipnetaddr.alias" />
        </table:cell>
        <table:cell>
            <%= bean.getIpnet() == null ? "" : bean.getIpnet() %>/<%= bean.getMask() == null ? "" : bean.getMask() %>
        </table:cell>
        <table:cell>
            <bean:message bundle="IPAddrPoolApplicationResources"
                key="field.pipnetaddr.description" />
        </table:cell>
    </table:row>
    <input type="hidden" name="parentnetaddr"
        value="<%= bean.getIpnet() == null ? "" : bean.getIpnet() %>/<%= bean.getMask() == null ? "" : bean.getMask() %>">
    <input type="hidden" name="poolname"
        value="<%= bean.getName() == null ? "" : bean.getName() %>">
    <table:row>
        <table:cell>
            <bean:message bundle="IPAddrPoolApplicationResources"
                key="field.firstipaddr.alias" />
        </table:cell>
        <table:cell>
            <input type=text name="startaddr" value="" size="20">
        </table:cell>
        <table:cell>
            <bean:message bundle="IPAddrPoolApplicationResources"
                key="field.firstipaddr.description" />
        </table:cell>
    </table:row>
    <table:row>
        <table:cell>
            <bean:message bundle="IPAddrPoolApplicationResources"
                key="field.number.alias" />
        </table:cell>
        <table:cell>
            <input type=text name="number" value="" size="20">
        </table:cell>
        <table:cell>
            <bean:message bundle="IPAddrPoolApplicationResources"
                key="field.number.description" />
        </table:cell>
    </table:row>

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
</form>
</body>
</html>

<%      }else

        if(beanType.equalsIgnoreCase("IPNet") || beanType.equalsIgnoreCase("MDT Data")) {
%>

<html>
<head>
<title><%=title%></title>
<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet"
    href="/activator/css/inventory-gui/subestilos.css">
<script src="/activator/javascript/hputils/alerts.js"></script>
<style type="text/css">
    A.nodec { text-decoration: none; }
    H1 { color: red; font-size: 13px }
</style>
</head>
<body>

<center>
  <h2>
    <bean:message bundle="IPAddrPoolApplicationResources" key="jsp.creation.title1"/> <%=beanType%>  <bean:message bundle="IPAddrPoolApplicationResources" key="jsp.creation.title2"/>
  </h2>
</center>

<center>
<table>
    <form name="form" method="POST" target="showMessage" action="../jsp<%=moduleConfig%>/CreationCommitIPInPool.jsp">
    <center><table:table>
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
                <bean:message bundle="IPAddrPoolApplicationResources"
                    key="field.pipnetaddr.alias" />
            </table:cell>
            <table:cell>
                <%= bean.getIpnet() == null ? "" : bean.getIpnet() %>/<%= bean.getMask() == null ? "" : bean.getMask() %>
            </table:cell>
            <table:cell>
                <bean:message bundle="IPAddrPoolApplicationResources"
                    key="field.pipnetaddr.description" />
            </table:cell>
        </table:row>
        <input type="hidden" name="parentnetaddr"
            value="<%= bean.getIpnet() == null ? "" : bean.getIpnet() %>/<%= bean.getMask() == null ? "" : bean.getMask() %>">
        <input type="hidden" name="poolname"
            value="<%= bean.getName() == null ? "" : bean.getName() %>">
        <table:row>
            <table:cell>
                <bean:message bundle="IPAddrPoolApplicationResources"
                    key="field.firstipnetwork.alias" />
            </table:cell>
            <table:cell>
                <input type=text name="ipnetaddr" value="" size="20">
            </table:cell>
            <table:cell>
                <bean:message bundle="IPAddrPoolApplicationResources"
                    key="field.firstipnetwork.description" />
            </table:cell>
        </table:row>
        <table:row>
            <table:cell>
                <bean:message bundle="IPAddrPoolApplicationResources"
                    key="field.netnumber.alias" />
            </table:cell>
            <table:cell>
                <input type=text name="number" value="" size="20">
            </table:cell>
            <table:cell>
                <bean:message bundle="IPAddrPoolApplicationResources"
                    key="field.netnumber.description" />
            </table:cell>
        </table:row>

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
    </form>
</body>
</html>
<%     }
    }
    } catch (Exception e) { %>
<script>
    alert("Error retrieving information for: Address pool" + "\n" +"<%= e.getMessage().replace('\n',' ') %>" );
    </script>
<% } finally {
        try{
            con.close();
        }catch(Throwable th){
            // don't metter
        }
   }
 %>
<center><iframe src="../blank.html" name="showMessage" frameBorder="false" WIDTH="400" HEIGHT="150"></iframe></center>
