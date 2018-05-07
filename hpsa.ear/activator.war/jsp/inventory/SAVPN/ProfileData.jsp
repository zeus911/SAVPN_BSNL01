<!------------------------------------------------------------------------
   hp OpenView service activator
   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
------------------------------------------------------------------------->
<%--
    // uncomment this block to hide errors in IDE
    java.sql.Connection connection = null;
    String profileName = null;
    /**
     * two parameters to this jsp:
     * connection
     * profileName
     */
--%>
<%
    {
        DataSource dataSource = (DataSource) InventoryTreeServlet.getDatasource(request.getParameter(QoSProfileConstants.DATASOURCE));
    Connection con = null;
    try {
        con = dataSource.getConnection();

        com.hp.ov.activator.vpn.inventory.PolicyMapping[] policyMappings = com.hp.ov.activator.vpn.inventory.PolicyMapping.findByProfilename(con, profileName);
        policyMappings = policyMappings == null ? new com.hp.ov.activator.vpn.inventory.PolicyMapping[0] : policyMappings;
        java.util.Hashtable policyTable = new java.util.Hashtable(policyMappings.length);
        for (int i = 0; i < policyMappings.length; i++)
            policyTable.put(policyMappings[i].getPosition(), policyMappings[i]);

        com.hp.ov.activator.vpn.inventory.EXPMapping[] expMappings = com.hp.ov.activator.vpn.inventory.EXPMapping.findAll(con);
        expMappings = expMappings != null ? expMappings : new com.hp.ov.activator.vpn.inventory.EXPMapping[0];
        for (int i = 0; i < expMappings.length; i++) {
            com.hp.ov.activator.vpn.inventory.EXPMapping expMapping = expMappings[i];
            com.hp.ov.activator.vpn.inventory.PolicyMapping policyMapping = (com.hp.ov.activator.vpn.inventory.PolicyMapping) policyTable.get(expMapping.getPosition());
            if(policyMapping == null)
                continue;
%>
<table:row>
    <table:cell>
        &nbsp;&nbsp;&nbsp;&nbsp;<%=expMapping.getClassname()%>
    </table:cell>

    <table:cell>
        <%= policyMapping.getTclassname() == null ? "" : policyMapping.getTclassname() %>
    </table:cell>

    <table:cell>
        <%= policyMapping.getPercentage() == null ? "" : policyMapping.getPercentage() %> %
    </table:cell>
</table:row>
<%
        }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    try {
        con.close();
    } catch (Throwable th) {
        // don't matter
    }
}
    }
%>
