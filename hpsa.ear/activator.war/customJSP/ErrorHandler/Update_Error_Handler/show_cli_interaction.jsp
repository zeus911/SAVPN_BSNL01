<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/ErrorHandler/Update_Error_Handler/show_cli_interaction.jsp,v $                                                                   --%>
<%-- $Revision: 1.9 $                                                             --%>
<%-- $Date: 2010-10-05 15:17:47 $                                                 --%>
<%-- $Author: shiva $                                                               --%>
<%--                                                                              --%>
<%--##############################################################################--%>   
<%--##############################################################################--%>
<%--#                                                                             --%>
<%--#  Description                                                                --%>
<%--#                                                                             --%>
<%--##############################################################################--%>


<%@ page contentType="text/html; charset=UTF-8"
         import="javax.sql.DataSource,java.sql.Connection,
         com.hp.ov.activator.mwfm.servlet.Constants,
                 java.util.ArrayList,
                 com.hp.ov.activator.vpn.inventory.*,
                 java.text.*,
                 java.util.*,
                 com.hp.ov.activator.vpn.errorhandler.*,
                  com.hp.ov.activator.vpn.utils.*,
                 java.io.*" %>
<%
    response.setDateHeader("Expires",0);
    //response.setHeader("Pragma","no-cache");
    response.setHeader("Cache-Control", "max-age=0");
    response.setHeader("Cache-Control", "public");
    request.setCharacterEncoding("UTF-8");
  
String action  = request.getParameter("action");
String message_id  = request.getParameter("message_id");
String service_type  = request.getParameter("service_type");
String service_name  = "test";
if(action==null)
   action="view";

   if (action.equalsIgnoreCase("view")) {
       String  filename= "inline; filename= "+message_id+".html";
        
       response.setContentType("application/x-download");
       response.setHeader("Content-Disposition", filename); 
       }
  else{
       String  filename= "attachment; filename=" +service_type+"_message_"+message_id+ ".cli.html";
        response.setContentType("application/x-download");
        response.setHeader("Content-Disposition",filename); 
    }


    DataSource ds= (DataSource)session.getAttribute(Constants.DATASOURCE);
    Connection con = null;

 
  try{

   if (ds != null)  {
       con = ds.getConnection();
        if (con != null) {

           ErrorHandler erHandler = new ErrorHandler(); 
           ActivationInformation act= erHandler.getActivationInfo(con,message_id);
           StringWriter writer =new StringWriter();
           writer.write(act.getErrorDialog());
           HashMap h=new HashMap();
           StringReader reader =new StringReader(writer.toString());
		   if (action.equalsIgnoreCase("view")) {
			   XSLTransformHelper.transformXML(reader,out,"../xsl/ActivationErrorDialog.xsl",h,pageContext);
		   }
		   else
			   {
			   XSLTransformHelper.transformXML(reader,out,"../xsl/ActivationErrorDialog.xsl",h,pageContext);
		   }
    }
   }
  }
  catch(Exception e)
  {
      if (e.getMessage()!=null)
          out.println(e.getMessage());
      else 
         out.println("Some Unexpected Error has happened.");
  }finally{
        try{
          con.close();
        }catch(Exception ex){
           out.println("Exception during the closing DB connection : " + ex.getMessage());
        }
  }
 %>


     

