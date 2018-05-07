<!------------------------------------------------------------------------
   hp OpenView service activator
   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
------------------------------------------------------------------------->

<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
                com.hp.ov.activator.vpn.inventory.*,
                com.hp.ov.activator.inventory.SAVPN.*,
                org.apache.struts.util.LabelValueBean,
                org.apache.struts.action.Action,
                org.apache.struts.action.ActionErrors,
                java.text.NumberFormat,
                com.hp.ov.activator.inventory.facilities.StringFacility" %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri = "/WEB-INF/table-taglib.tld" prefix="table" %>
<%@ taglib uri = "/WEB-INF/button-taglib.tld" prefix="btn" %>


<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";

String refreshTreeRimid=(String) request.getSession().getAttribute("refreshTreeRimid");
//System.out.println("refreshTreeRimid:"+refreshTreeRimid );

    String refreshTree = (String) request.getAttribute(SuccessConstants.REFRESH_TREE);
	 String title = (String) request.getAttribute(SuccessConstants.JSP_VIEW_TITLE);
	  String message = (String) request.getAttribute(SuccessConstants.MESSAGE);
    if ( refreshTree != null && refreshTree.equalsIgnoreCase("true") ) {
        //System.out.println("refresh" );
%>
    <script>
    parent.document.frames["ifr" + "<%=refreshTreeRimid%>"].checkRefresh();
    </script>
<%
    }
%>

<html>
    <head>
        <title><%= title %></title>

    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
   <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
        <style type="text/css">
            A.nodec { text-decoration: none; }
        </style>
    </head>

    <body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;">

<center>
  <h2>
    <%= title %>
  </h2>
</center>

<center>
        <table:table>

    <table:header>
                <table:cell>
                    	<%= SuccessConstants.MESSAGE %>
                </table:cell>
    </table:header>
        </table:table>
        </center>
    </body>
</html>
