<%@ page import="java.io.Writer,
                 java.io.IOException,
                 com.hp.ov.activator.mwfm.servlet.Constants,
                 com.hp.ov.activator.mwfm.WFManager,
                 java.util.HashMap,java.util.Date,
                 com.hp.ov.activator.vpn.inventory.*,
                 javax.sql.DataSource,
                 java.net.InetAddress,
                 java.net.URLDecoder,
                 java.sql.Connection,
                 java.sql.SQLException,
                 java.sql.PreparedStatement,
                 java.sql.ResultSet,
                 java.util.regex.Pattern,
                 java.util.regex.Matcher,
                 com.hp.ov.activator.vpn.inventory.ISP"
         info="Backup Equipment Configuration" 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->
<% /* JPM New */ %>
<%
    request.setCharacterEncoding("UTF-8");
    // Check if there is a valid session available.
    if (session == null || session.getAttribute (Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    } 
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<%!
    public static final int SIZE=500, CELL_WIDTH=1, CELL_HEIGHT=10;
%>

<%! class Foo extends Thread {
	boolean b, bError;
	JspWriter out;
	String equipment;
    String equipmentName;
	String target_memory;
	HttpSession session;
	javax.sql.DataSource dataSource;
	String MWFM_WEB;
	String MWFM_VAR;
	String MWFM_ETC;
	boolean registeredDrivers;
    private String returnCode = null;
    String data="";
    String dirtyFlag = "";
    boolean checkTimestamp = true;
	  WFManager wfm = null;

	public Foo (JspWriter out, String equipment, String equipmentName, String target_memory, HttpSession session, javax.sql.DataSource dataSource,
				String var, String web, String etc, String registered, String dirtyFlag, boolean checkTimestamp, WFManager wfm) {
		this.out = out;
		this.equipment = equipment;
        this.equipmentName = equipmentName;
		this.target_memory = target_memory;
		System.out.println("Foo initialize target_memory="+target_memory);
		this.session = session;
		this.bError = false;
		this.dataSource = dataSource;
		this.MWFM_VAR = var;
		this.MWFM_WEB = web;
		this.MWFM_ETC = etc;
		this.registeredDrivers = new Boolean(registered).booleanValue();
        this.dirtyFlag =  dirtyFlag;
        this.checkTimestamp = checkTimestamp;
		//this.wfm = (WFManager)session.getAttribute(Constants.MWFM_SESSION);
     this.wfm = wfm;
        }

	public boolean isDone () {
	  return b;
	}

	public boolean isError() {
	  return bError;
	}

	public void setDone() {
	  b = true;
	}
    public void setReturnCode(String returnCode){
        this.returnCode = returnCode;
    }
    public String getReturnCode(){
        return returnCode;
    }

	public void setError() {
	  bError = true;
	}

	public void run() {
        try{
            if(wfm == null){
     
                setError();
                setReturnCode("Error trying to connect to MicroWorkflow Manager");
            }else{
     
                String jobName = "SaveRouterConfig";
                String sHPSAAddress = null;
                Connection connection = null;
                try{
                    connection = (Connection)dataSource.getConnection();
                    ISP isp = ISP.findByIdname(connection, "ISPID");
                    sHPSAAddress = isp.getIp();
                    if (sHPSAAddress == null || sHPSAAddress == ""){
                        InetAddress localNetIP= InetAddress.getLocalHost();
				        sHPSAAddress = localNetIP.getHostAddress();
                        
                    }
                    HashMap parameters = new HashMap();
                    parameters.put("hpip_hostname", sHPSAAddress);
                    parameters.put("neId", equipment);
                    parameters.put("retrieval_method", "MANUAL");
                    System.out.println("Pass to WF target_memory="+target_memory);
                    parameters.put("memory", target_memory);
                    parameters.put("created_by", session.getAttribute (Constants.USER));
                    parameters.put("dirtyflag", dirtyFlag);
                    parameters.put("checkTimestamp", new Boolean(checkTimestamp));
                    parameters.put("equipname", equipmentName);  
					HashMap results = wfm.startAndWaitForJob(jobName, parameters);
					if(results != null){
                      //System.out.println("The result got from the job : " + results.toString());
                    }
                    if("1".equals(String.valueOf(results.get("activation_major_code")))){
                        setError();
                        setReturnCode("Can' complete the job [" + jobName + "]. Reason ; " + results.get("activation_description"));
                    }else if("1".equals(String.valueOf(results.get("RET_VALUE")))){
                        setError();
                        setReturnCode("Can' complete the job [" + jobName + "]. Reason ; " + results.get("activation_description"));
                    }else if("1".equals(String.valueOf(results.get("ret_value")))){
					    setError();
                        setReturnCode("Can' complete the job [" + jobName + "]. Reason ; " + results.get("activation_description"));
                    }


                }catch(Exception e){
		                setError();
                    setReturnCode("Can' startup the job [" + jobName + "]. Reason ; " + e.getMessage());
                }    finally{
                       try{
                        connection.close();
                    }catch(Exception e){

                    }
                }
            }
        }finally{
		  setDone();
        }
	}
}
%>


<head>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
  	<link rel="stylesheet" type="text/css" href="../../css/spainTable.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
</head>

<%
String equipment =  URLDecoder.decode(String.valueOf(request.getParameter ("equipment")), "UTF-8");
String target_memory =  URLDecoder.decode(String.valueOf(request.getParameter ("memory")), "UTF-8");
String equipmentName = URLDecoder.decode(String.valueOf(request.getParameter ("equipmentName")), "UTF-8");
System.out.println("Get request parameter target_memory="+target_memory);
%>


<body>
<table border="0" cellpadding=0 cellspacing=0>
  <tr class="tableOddRow">
    <td class="searchHeading">&nbsp;Getting configuration from <%= equipmentName.length() > 10 ? equipmentName.substring(0,10) + "..." : equipmentName %>&nbsp;</td>
    <td class="tableCell">&nbsp;</td>
    <td class="tableCell">
      <table border="0" cellpadding=0 cellspacing=0>
        <tr>
<%
    for (int i = 0; i < SIZE; i++) {
%>
          <td><img src="../images/whitepixel.gif" name="img<%= i %>" width="<%= CELL_WIDTH %>" height="<%= CELL_HEIGHT %>"></td>
<%  } %>
        </tr>
      </table>
    <td class="tableCell">&nbsp;</td>
   </tr>
</table>
<%
	// JPM New
	/* Definir las rutas de acceso en funcion del tipo de sistema */
	String MWFM_WEB = getServletConfig().getInitParameter("ACTIVATOR_WEB");
	String MWFM_VAR = getServletConfig().getInitParameter("ACTIVATOR_VAR");
	String MWFM_ETC = getServletConfig().getInitParameter("ACTIVATOR_ETC");
  //EquipmentConfiguration ec = null;
	/* Comprobar si estan cargados los drivers */
	String registeredDrivers = "" + session.getAttribute("registered_drivers");
	if(!registeredDrivers.equals("true")) {
		registeredDrivers = "false";
		session.setAttribute((String)"registered_drivers", "true");
	}
	DataSource dataSource= (javax.sql.DataSource)session.getAttribute(Constants.DATASOURCE);
    String dirtyFlag = "";
    boolean checkTimestamp = true; 
     Connection connection = null;
    System.out.println("Initialize WFManager");
     WFManager wfm;
    try{
    	 wfm = (WFManager) session.getAttribute (Constants.MWFM_SESSION);  
    	 System.out.println("Get WFManager from session");  
     }catch(Exception e){
		 	System.out.println("Fail to get WFManager from session");
		 	wfm = null;
		 }  
     
    System.out.println("WFManager");  
     
    PreparedStatement ps = null;
    ResultSet rset = null;
 
     try {
 				System.out.println("Get DataSource connection");  
         connection = (Connection)dataSource.getConnection();
 				System.out.println("Prepare Statement");  
        ps = connection.prepareStatement ("select dirtyflag from v_equipmentconfiguration where timestamp = (select max(timestamp) from v_equipmentconfiguration where equipmentid='"+equipment+"')");
        System.out.println("Execute Query");     
        rset = ps.executeQuery();

	    if ( rset.next() ){
            do{
                dirtyFlag = rset.getString(1);
            }while (rset.next());
        }
     }catch(SQLException e){

         e.printStackTrace();
     }  finally{
         if(rset!=null)
            rset.close();
         if (ps != null)
            ps.close();
         if (connection!=null)
             connection.close();
     }
                 

    Foo foo = new Foo(out, equipment, equipmentName, target_memory, session, dataSource, MWFM_VAR, MWFM_WEB, MWFM_ETC, registeredDrivers, dirtyFlag, checkTimestamp,wfm);
    
	foo.start();

       for (int i=0;;i++) {
                int j = i % SIZE;
		Thread.sleep(300);
		out.println("<script> document.images['img" + j + "'].src = '../images/bluepixel.gif';" +
            		    "document.images['img" + j + "'].width = " + CELL_WIDTH + ";" +
            		    "document.images['img" + j + "'].height= " + CELL_HEIGHT + ";" +
	    		    "</script>");

		out.flush();

                if ( j == (SIZE - 1) ) {
                        for (int k=0; k < SIZE; k++) {
                	  out.println("<script> document.images['img" + k + "'].src = '../images/whitepixel.gif';" +
                         	      "document.images['img" + k + "'].width = " + CELL_WIDTH + ";" +
                            	      "document.images['img" + k + "'].height= " + CELL_HEIGHT + ";" +
                                      "</script>");
                        }
		 	out.flush();
                }

                if ( foo.isDone() )
                        break;
        }
%>
<%
if ( foo.getReturnCode() == null && !foo.isError() ) {

  for (int k=0; k < SIZE; k++) {
    out.println("<script> document.images['img" + k + "'].src = '../images/bluepixel.gif';" +
                "document.images['img" + k + "'].width = " + CELL_WIDTH + ";" +
                "document.images['img" + k + "'].height= " + CELL_HEIGHT + ";" +
                "</script>");
  }
  out.flush();
%>

&nbsp;&nbsp;Backup performed succesfully
<%
}
else {

  for (int k=0; k < SIZE; k++) {
    out.println("<script> document.images['img" + k + "'].src = '../images/redpixel.gif';" +
                "document.images['img" + k + "'].width = " + CELL_WIDTH + ";" +
                "document.images['img" + k + "'].height= " + CELL_HEIGHT + ";" +
                "</script>");
  }
  out.flush();
%>
  &nbsp;&nbsp;Error occurred performing backup (<%= foo.getReturnCode() %>).<br>
<%

} %>
</body>
</html>

