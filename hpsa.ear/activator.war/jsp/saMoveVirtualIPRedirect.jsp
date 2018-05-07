<%@ page import="com.hp.ov.activator.mwfm.*,
                 com.hp.ov.activator.mwfm.servlet.Constants,
                 com.hp.ov.activator.mwfm.servlet.*"
         info="Invokes method on WFManager to move selected virtual IP."
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<!--
******************************************************************
  HP OpenView Service Activator
  (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
*******************************************************************
-->
<%!
    //I18N strings       
    final static String errMsg = com.hp.ov.activator.activatorUiNLS.MsgHandler.getString("1305", "Unable to move Virtual IP");
    
%>
<%
    request.setCharacterEncoding ("UTF-8");

    // don't cache the page
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");
%>
<jsp:useBean id="moveVirtualIPFilter" scope="session" class="com.hp.ov.activator.mwfm.servlet.moveVirtualIPFilterBean"/>
<jsp:setProperty name="moveVirtualIPFilter" property="*" />
<%
    String nodeCurrentlyConfigured = moveVirtualIPFilter.getNodeCurrentlyConfigured();
    String virtualIPSelected = moveVirtualIPFilter.getVirtualIPMoved();
    String newRecepientNode= moveVirtualIPFilter.getRecipientHost();
    
    String[] a = virtualIPSelected.split("#");
    String interfaceCurrentlyConfigured = a[0];
    String virtualIP = a[1];    
    try {
        WFManager wfm = (WFManager) session.getAttribute(Constants.MWFM_SESSION);
        wfm.moveVirtualIP(nodeCurrentlyConfigured, newRecepientNode, virtualIP, interfaceCurrentlyConfigured);
    } catch(Exception e){
        String err = null;
        if (e.getMessage() != null) {
           String tmp = e.getMessage().replace('\n',' ');
           err = tmp.replace('"',' ');
        } else {
           err = e.toString().replace('\n',' ');
        }
%>
      <SCRIPT LANGUAGE="JavaScript"> alert("HP Service Activator" + "\n\n" + "<%=errMsg%> :  <%=err%>"); </SCRIPT>
<%
    }
%>
<script>
        window.close();
</script>    