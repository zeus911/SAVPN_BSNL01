<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,
                java.sql.*, 
                javax.sql.DataSource,
                java.util.*, 
                java.text.*,
                java.net.*,
                 java.util.Date"
%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table"%>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn"%>
<%------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

-------------------------------------------------------------------------%>
<%
    response.setDateHeader("Expires",0);
     //response.setHeader("Pragma","no-cache");
    response.setHeader("Cache-Control", "max-age=0");
    response.setHeader("Cache-Control", "public");
    request.setCharacterEncoding("UTF-8");

  String en = request.getParameter ("equipmentID");
  String eqname = request.getParameter ("equipmentName");
  String ts = request.getParameter ("timestamp");  
  String filenameParameter = "";
  String mode = "Show";
  
  if (request.getParameter("filename") != null)
  {
	filenameParameter = request.getParameter ("filename");
	mode = "View";
  }
  
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");

    // for file name extension
    SimpleDateFormat  temp_format = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
    SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd_HHmm");
    Date temp = temp_format.parse(ts);
    String time_ext = format.format(temp);

    String filename = "attachment; filename=" + eqname+"_" + time_ext + ".txt";
    response.setContentType("application/unknown");
    response.setHeader("Content-Disposition",filename);

    // Check if there is a valid session available.
    if (session == null || session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    } 
%>
<%
  if ("View".equals(mode))
  {
	java.io.FileInputStream fileInputStream=new java.io.FileInputStream(filenameParameter);  
            
	int i;   
	while ((i=fileInputStream.read()) != -1) {  
		out.write(i);   
	}   
	fileInputStream.close(); 
  }
  else
  {
	  DataSource dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
	  Connection con = null;
	  PreparedStatement ps = null;
	  ResultSet rs = null;
	  try {
		if ( ts != null && en != null) {
		con = (Connection) dataSource.getConnection();
		String TimeStamp="";
		java.util.Date formattedTime = null;
		ps = con.prepareStatement("select to_char(configtime,'yyyy.mm.dd hh24:mi:ss') from v_backupref where creationtime=to_date('"+ts+"','yyyy.mm.dd hh24:mi:ss') and eqid='"+en+"'") ;
		//System.out.println("select to_char(configtime,'yyyy.mm.dd hh24:mi:ss') from backupref where creationtime=to_date('"+ts+"','yyyy.mm.dd hh24:mi:ss') and eqid='"+en+"'");
		rs = ps.executeQuery();
		while (rs.next()){
			 //TimeStamp = rs.getTimestamp(1);
			 TimeStamp = rs.getString(1);
		}
		if (TimeStamp != null){
			 formattedTime = sdf.parse(TimeStamp);
			 //System.out.println("FormatedTime is:"+formattedTime);
		}
		EquipmentConfiguration ec = EquipmentConfigurationWrapper.findByPrimaryKeys (con, en, formattedTime);
		out.print(new String(ec.getData()));
		//System.out.print("The result Data is:"+ec.getData());
		}
	  } catch (Exception e) {
		
	  } finally {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (con != null)
				con.close();
	  }
  }
%>
