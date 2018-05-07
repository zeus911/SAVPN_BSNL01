<!---------------------------------------------------------------------------

###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

----------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.servlet.*,
              com.hp.ov.activator.cr.inventory.*,
							com.hp.ov.activator.inventory.CRModel.*,
              com.hp.ov.activator.inventory.facilities.StringFacility,
              javax.sql.DataSource,
              java.sql.*,
              java.util.HashMap,
              java.util.Vector,
              java.util.regex.Matcher"
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<%
	String ne_id = (String) request.getParameter("NE_ID");
  String location = request.getParameter("location");
  String interfaceName = "";
  Connection con = null;
  com.hp.ov.activator.cr.inventory.ChannelizedInterface beanChannelizedInterface =
	(ChannelizedInterface)request.getSession().getAttribute(ChannelizedInterfaceConstants.CHANNELIZEDINTERFACE_BEAN);
   if(beanChannelizedInterface!=null)
   {
   	interfaceName = StringFacility.replaceAllByHTMLCharacter(beanChannelizedInterface.getName()); 
   
	
   try {
    DataSource dbp = (DataSource)session.getAttribute(Constants.DATASOURCE);
  
     con = dbp.getConnection();
     TerminationPoint []interfaces = (TerminationPoint[])Interface.findAll(con, " CRModel#TerminationPoint.ne_id = " + ne_id + " and CRModel#TerminationPoint.name= '" + interfaceName + "'");
     if (interfaces==null) 
 			{
				interfaceName= "";
			}
   
   } catch (SQLException e) { 
    e.printStackTrace();
  } finally { 
    try{
      con.close();
    }catch(Throwable th){
    }
  }
  }
%>

<html>
<head>
  <title>hp service activator</title>
  <link rel="stylesheet" type="text/css" href="../css/activator.css">
  <script>
  	if(top.window.opener.closed){
      alert("Plese close window as parent windows is closed");      
      }else{
      top.window.opener.location = '<%=location%>?router_id=<%=ne_id%>&selected_pe_if=<%=interfaceName%>';
      top.window.opener.focus()
      parent.window.close();    	
    	}
</script>
  
</head>




 <body>  


      
</body>
 
</html>
