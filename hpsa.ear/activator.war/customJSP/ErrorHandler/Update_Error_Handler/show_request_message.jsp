<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/ErrorHandler/Update_Error_Handler/show_request_message.jsp,v $                                                                   --%>
<%-- $Revision: 1.9 $                                                             --%>
<%-- $Date: 2010-10-05 15:17:47 $                                                 --%>
<%-- $Author: shiva $                                                               --%>
<%--                                                                              --%>
<%--##############################################################################--%>                                                   

<%@ page contentType="text/html; charset=UTF-8"
         import="com.hp.ov.activator.mwfm.JobRequestDescriptor,
                 com.hp.ov.activator.mwfm.servlet.Constants,
                 com.hp.ov.activator.mwfm.AttributeDescriptor,
                 java.util.ArrayList,
                 java.util.*,
                 java.io.*" %>
<%
       response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");

%>
<head>
<title>Show request message</title>
</head>
<% JobRequestDescriptor jd= (JobRequestDescriptor) session.getAttribute(Constants.MWFM_JOB_DESCRIPTOR); %>


<%
    String ip = request.getRemoteAddr();
    AttributeDescriptor ad0 = jd.attributes[0]; // return_code
    AttributeDescriptor ad1 = jd.attributes[1]; // VPN_Info
    AttributeDescriptor ad2 = jd.attributes[2]; // messafe_file_data
    AttributeDescriptor ad6 = jd.attributes[6]; // message_file
    AttributeDescriptor ad7 = jd.attributes[7];//log filter timestamp
    AttributeDescriptor ad8 = jd.attributes[8]; //log search pattern
    String return_code = request.getParameter("return_code");
    if ( return_code == null ) {
      return_code = ad0.value == null ? "" : ad0.value;
    }

    String VPN_Info = request.getParameter("VPN_Info");
    if ( VPN_Info == null ) {
      VPN_Info = ad1.value == null ? "" : ad1.value;
    }

    String message_file_data = request.getParameter("message_file_data");
    if ( message_file_data == null ) {
      message_file_data = ad2.value == null ? "" : ad2.value;
    }
message_file_data=message_file_data.replaceAll("<","&lt;");
message_file_data=message_file_data.replaceAll(">","&gt;");
    String message_file = request.getParameter("message_file");
    if ( message_file == null ) {
      message_file = ad6.value == null ? "" : ad6.value;
    }

    String log_filter_time_stamp = request.getParameter("log_filter_time_stamp");
    if ( log_filter_time_stamp == null ) {
      log_filter_time_stamp = ad7.value == null ? "" : ad7.value;
    }

    String log_search_pattern = request.getParameter("log_search_pattern");
    if ( log_search_pattern == null ) {
      log_search_pattern = ad8.value == null ? "" : ad8.value;
    }
 %>

<body>
<script>
window.focus();

</script>

    <pre><%= message_file_data %></pre>
</body>


     

