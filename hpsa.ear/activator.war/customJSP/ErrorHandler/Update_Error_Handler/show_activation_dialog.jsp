<%--##############################################################################--%>
<%--                                                                              --%>
<%--   ****  COPYRIGHT NOTICE ****                                                --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--   All Rights Reserved.                                                       --%>
<%--                                                                              --%>
<%--##############################################################################--%>
<%-- $Source: /tmp/vpn/SA_VPN_SP/OpenView/ServiceActivator/solutions/SAVPN/UI/customJSP/ErrorHandler/Update_Error_Handler/show_activation_dialog.jsp,v $                                                                   --%>
<%-- $Revision: 1.10 $                                                             --%>
<%-- $Date: 2010-10-05 15:17:47 $                                                 --%>
<%-- $Author: shiva $                                                              --%>
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
                 java.sql.*,com.hp.ov.activator.mwfm.JobRequestDescriptor,
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
%>
<%

    DataSource ds= (DataSource)session.getAttribute(Constants.DATASOURCE);
    Connection con = null;
	String dialog="";
	String action  = request.getParameter("action");

	String activation_dialog = "";
	String service_type = request.getParameter("service_type");
	String equipment_name = request.getParameter("equipment_name");
	String element_type = request.getParameter("element_type");
	String vendor = request.getParameter("vendor");
	String message_id  = request.getParameter("message_id");

	if (action.equalsIgnoreCase("Save")) 
		{
			   String  filename= "attachment; filename=" +service_type+"_message_"+message_id+ ".cli.xml";
			   response.setContentType("application/x-download");
			   response.setHeader("Content-Disposition",filename); 
		}
	
 try{
  
   HashMap h=new HashMap();
   h.put("activation_name",service_type);
   h.put("equipment_name",equipment_name);
   h.put("element_type",element_type);
   h.put("vendor",vendor);
   h.put("action",action);
   h.put("dialog",dialog);

   
   if (ds != null)  {
       con = ds.getConnection();
        if (con != null) {
            
           ErrorHandler erHandler = new ErrorHandler(); 
           ActivationInformation act= erHandler.getActivationInfo(con,message_id);
           StringWriter writer =new StringWriter();
           BufferedReader bfReader = new BufferedReader(new StringReader(act.getActivation_dialog()));
           String a;
            while ( (a=bfReader.readLine())!= null)
             {
                    if(a.indexOf("<?xml version=")!=-1)
                        continue;       
                    if( a.indexOf("CLIv4.dtd")!=-1)
                        continue;       
                     writer.write(a+"\n");
            }
            
           StringReader reader =new StringReader(writer.toString());
		   		   		  
		   if (action.equalsIgnoreCase("Save")) {
			   dialog = act.getActivation_dialog();
			%>
			<%=dialog%>
			<%}
			else
			{
				XSLTransformHelper.transformXML(reader,out,"../xsl/ListCLICommands.xsl",h,pageContext);
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

     

