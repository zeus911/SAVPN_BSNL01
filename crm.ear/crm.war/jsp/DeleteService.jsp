<%--##############################################################################--%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--   (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.          --%>
<%--                                                                              --%>
<%--                                                                              --%>
<%--##############################################################################--%>



<%-- ************************************************************** --%>
<%--                                                                --%>
<%-- DeleteService.jsp                                              --%>
<%--                                                                --%>
<%-- Parameters:                                                    --%>
<%--  - serviceid                                                   --%>
<%--                                                                --%>
<%-- Description:                                                   --%>
<%--  Deletes the service and all its subservices                   --%>
<%--                                                                --%>
<%-- ************************************************************** --%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>





<%@page info="deletes a service"
        contentType="text/html;charset=UTF-8" language="java" 
        import="com.hp.ov.activator.crmportal.action.*,com.hp.ov.activator.crmportal.utils.*,
				java.sql.ResultSet, java.sql.SQLException, java.sql.PreparedStatement, java.sql.DriverManager,
               java.util.*, java.io.*, java.text.*, java.net.*, com.hp.ov.activator.crmportal.common.*,
			   com.hp.ov.activator.crmportal.bean.*, javax.sql.DataSource, java.sql.Connection" %>





<html:html locale="true">
  <head>
    <link rel="stylesheet" type="text/css" href="css/activator.css">
    <link rel="stylesheet" type="text/css" href="css/awfweb2.css">
  </head>
 
  <body>
<%
//include file="../jsp/CheckSession.jsp" 
     ServiceForm serviceForm = (ServiceForm)request.getAttribute("ServiceForm");
	 String StartTime  = ((ServiceForm)serviceForm).getEndTime();
	 String serviceid  = ((ServiceForm)serviceForm).getServiceid();
	 String customerid = ((ServiceForm)serviceForm).getCustomerid();
	 Service service       = (Service)request.getAttribute("service");
     Service[] subServices = (Service[])request.getAttribute("subServices");
     VPNMembership[] serviceMembership = (VPNMembership[])request.getAttribute("serviceMembership");
     VPNMembership[] relatedServices   = (VPNMembership[])request.getAttribute("relatedServices");

      HashSet roles = (HashSet) session.getAttribute(Constants.ROLES_KEY);
      boolean isOperator = false;
      //System.out.println("roles :::::::"+roles);
      if(roles.contains(Constants.ROLE_OPERATOR)) {isOperator = true;}
  
      if(isOperator == false)
      throw new IllegalStateException("Wrong role to perform the operation");

// Richa 11687
int cpage = 1;
	String strPageNo = "1";
	int vPageNo = 1;
	int totalPages= 1;
	String pt=(String)request.getParameter("mv"); 

    String strcpage = (String)request.getAttribute("currentPageNo");
	if(strcpage!=null)
	  cpage  = Integer.parseInt(strcpage);

	String strvPageNo	 =  (String)request.getAttribute("viewPageNo");
	if(strvPageNo!=null)
	  vPageNo = Integer.parseInt(strvPageNo);
	
	String strtotalPages	 =  (String)request.getAttribute("totalPages");
	if(strtotalPages!=null)
		totalPages = Integer.parseInt(strtotalPages);

    String currentRs	 =  (String)request.getAttribute("currentRs");
    String lastRs	 =  (String)request.getAttribute("lastRs");



	// Richa 11687	
	//	String mv=null; // Commented Richa 11687
HashMap params = null;

	// Manual LSPs ER
	Connection con = null;
	DataSourceLocator dsl = new DataSourceLocator(); 
	
	PreparedStatement pstmt = null;
	ResultSet rset = null;
	String count_str = "";
	int lspcount = 0;
	
	try
	{
		DataSource ds = dsl.getDataSource();
		if (ds != null)
		{
			con = ds.getConnection();
			
			String query =  "select count(*) from V_LSP lsp, V_LSPVPNMEMBERSHIP mem where lsp.lspid = mem.lspid and lsp.usagemode='Manual' and mem.vpnid=?";
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, serviceid);
			rset = pstmt.executeQuery();
			while(rset.next())
			{
				count_str = rset.getString(1);
			}
			
			lspcount = Integer.parseInt(count_str);
		}             
	}
	catch(Exception e)
	{
		System.out.println("Exception getting LSP information: "+e);
	}
	finally
	{
		try{ rset.close(); }catch(Exception ignoreme){}
		try{ pstmt.close(); }catch(Exception ignoreme){}
		try{ con.close(); }catch(Exception ignoreme){}
	}
	
     if(serviceid != null)
		 {

       if (service != null) 
		   {
      
          if(serviceMembership != null && serviceMembership.length > 1)
			 {
			
			 params = new HashMap();
			 params.put("customerid",customerid);
			 params.put("doResetReload","true");
	// Richa 11687
			 params.put("mv",pt);
			 params.put("currentPageNo",strcpage);
			 params.put("viewPageNo",strvPageNo);
			 params.put("currentRs",currentRs);
			 params.put("lastRs",lastRs);
			 params.put("totalPages",totalPages);
			 pageContext.setAttribute("paramsMap", params);
	// Richa 11687

%>
          <center>
             &nbsp;<br>
             &nbsp;<br>
             <h3><bean:message key="msg.delete.service.one"/></h3>
                      
			 <html:link page="/ListAllServices.do" name="paramsMap" scope="page" >
	         <html:img page="/images/back.gif" border="0" title="Back" align="center"/>
	         </html:link>
           </center>
    <%
                 }
    
		if(!(service.getType().equals("layer2-VPWS")) && (subServices != null || relatedServices != null))
		{
			 params = new HashMap();
			 params.put("customerid",customerid);
			 params.put("doResetReload","true");
	// Richa 11687
			 params.put("mv","viewpageno");
			 params.put("currentPageNo",strcpage);
			 params.put("viewPageNo",strvPageNo);
			 params.put("currentRs",currentRs);
			 params.put("lastRs",lastRs);
			 params.put("totalPages",totalPages);
			 pageContext.setAttribute("paramsMap", params);

	%>
           <center>
             &nbsp;<br>
             &nbsp;<br>
             <h3><bean:message key="msg.delete.service.two"/></h3>

              <html:link page="/ListAllServices.do" name="paramsMap" scope="page" >
	         <html:img page="/images/back.gif" border="0" title="Back" align="center"/>
	         </html:link>
           </center>
<%    
		}			 
		// In case there are Manual LSPs configured for that VPN
		else if (lspcount > 0) 
		{
							 params = new HashMap();
			 params.put("customerid",customerid);
			 params.put("doResetReload","true");
	// Richa 11687
			 params.put("mv","viewpageno");
			 params.put("currentPageNo",strcpage);
			 params.put("viewPageNo",strvPageNo);
			 params.put("currentRs",currentRs);
			 params.put("lastRs",lastRs);
			 params.put("totalPages",totalPages);
			 pageContext.setAttribute("paramsMap", params);

	%>
           <center>
             &nbsp;<br>
             &nbsp;<br>
             <h3><bean:message key="msg.delete.service.three"/></h3>

              <html:link page="/ListAllServices.do" name="paramsMap" scope="page" >
	         <html:img page="/images/back.gif" border="0" title="Back" align="center"/>
	         </html:link>
           </center>
<%    
			 }
       } //service
     }//service id
   %>
  
    </table>
  </body>
</html:html>





