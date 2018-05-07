<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,
		  com.hp.ov.activator.vpn.backup.servlet.*,
                java.sql.*,
                javax.sql.DataSource,
                java.util.*,
                java.text.*,
                java.net.*,
                 java.io.*,
				 java.lang.*,
				 java.io.Writer,
                 java.io.IOException,
                 java.io.File"
         info="View Equipment List"
         session="true"
         contentType="text/html; charset=UTF-8"
         language="java"
%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table"%>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn"%>
<% /* JPM New */ %>
<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute(Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    }
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<html>
<%! public static final int SIZE=500, CELL_WIDTH=1, CELL_HEIGHT=10;
%>
<%! class FooWriter extends Writer {

	JspWriter out;

	public FooWriter (JspWriter out) {
	  this.out = out;
	}

	public void flush() {
	  try {
	    out.flush();
	  } catch (IOException ioe) {}
	}

	public void close() {
	}

	public void write(char[] cbuf, int off, int len) {
	  try {
	    out.println("<tt>");
	    out.println(new String(cbuf, off, len));
	    out.println("</tt><br>");
	  } catch (IOException ioe) {}
	}
} %>

<%! class Foo extends Thread {
	boolean b, bError;
	JspWriter out;
	String equipment;
	String target_memory;
	String sFilename;
	HttpSession session;
	DataSource dataSource;
	String MWFM_WEB;
	String MWFM_VAR;
	String MWFM_ETC;
    String jobName = "Audit router config";
    String current_config_var = "xml";
	String filename_var = "activation_txt";
	boolean registeredDrivers;
    private String returnCode="";
    private String wf_output = "";

	public Foo (JspWriter out, String equipment, String target_memory, String sFilename, HttpSession session,
				DataSource dataSource, String var, String web, String etc, String registered) {
		this.out = out;
		this.equipment = equipment;
		this.target_memory = target_memory;
		this.session = session;
		this.bError = false;
		this.sFilename = sFilename;
		this.dataSource = dataSource;
		this.MWFM_VAR = var;
		this.MWFM_WEB = web;
		this.MWFM_ETC = etc;
		this.registeredDrivers = new Boolean(registered).booleanValue();
    }

    public String getReturnCode(){
        return this.returnCode;
    }
	
	public String getFilename(){
        return this.sFilename;
    }

    public void setReturnCode(String returnCode){
        this.returnCode = returnCode;
    }

    public String getWFOutput(){
        return this.wf_output;
    }

    public void setWFOutput(String output){
        this.wf_output = output;
    }

	public boolean isDone () {
	  return b;
	}

	public Vector stringToVector(String sString) {
		Vector v = new Vector();
		java.util.StringTokenizer st = new java.util.StringTokenizer(sString, "\n");

		while ( st.hasMoreTokens() ) {
			String sLine = st.nextToken();
			v.addElement(sLine);
		}
		return v;
	}

	public String vectorToString(Vector v) {
		StringBuffer sb = new StringBuffer("");
		int iSize = v.size();

		for (int ii=0; ii < iSize; ii++) {
			if ( ii != 0 )
				sb.append("\n");
			sb.append((String) v.get(ii));
		}

		return sb.toString();
	}

	public boolean isError() {
	  return bError;
	}

	public void setDone() {
	  b = true;
	}

	public void setError() {
	  bError = true;
	}

	public void run() {
        try{
            WFManager wfm = (WFManager)session.getAttribute(Constants.MWFM_SESSION);
            if(wfm == null){
                setError();
                returnCode = "Can't connect to MicroWorkflow Manager";
            }else{
                HashMap parameters = new HashMap();
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
                    System.out.println("view: IP " + sHPSAAddress);
                    parameters.put("memory", target_memory);
                    parameters.put("hpip_hostname", sHPSAAddress);
                    parameters.put("neId", equipment);

                    HashMap results = null;
                    results = (HashMap)wfm.startAndWaitForJob(jobName, parameters);
                    if(results != null){
                        if("1".equals(String.valueOf(results.get("RET_VALUE")))){
                            throw new Exception("Error during the workflow execution");
                        }
                        if("1".equals(String.valueOf(results.get("activation_major_code")))){
                            throw new Exception("Error during the activation [" + results.get("activation_description") + "]");
                        }
                        wf_output = String.valueOf(results.get(this.current_config_var));
						sFilename = String.valueOf(results.get(this.filename_var));
						
                    }
                }catch(UnknownHostException uhs){
                    setError();
                    returnCode = "Can't state the SA host IP address. Reason : " + uhs.getMessage();
                }catch(Exception e){
                    setError();
                    returnCode = "Can't start the job [" + jobName + "]. Reason : " + e.getMessage();
                } finally{
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
<% /* JPM New */ %>
	<script language="JavaScript" src="../../javascript/table.js"></script>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
    <link rel="stylesheet" type="text/css" href="../../css/spainTable.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">

    <SCRIPT LANGUAGE="JavaScript">
        function closeView(){
	       top.main.location='FetchEquipmentConfiguration.jsp';
        }
    </script>
</head>

<body>
<%
   String equipmentName = (String)request.getParameter("equipmentName");
    String equipmentID = (String)request.getParameter("equipmentID");
   String target_memory = (String)request.getParameter("memory");
   String jsp_returnCode = "";
   if(target_memory == null){
    jsp_returnCode = "The target memory is not indicated!";
   }


     String operationText = "Close";

   if (equipmentID == null || equipmentID.equals(""))
   {
%>
       <SCRIPT LANGUAGE="JavaScript" type="text/JavaScript">
           alert("<bean:message bundle="InventoryResources" key="Backup.View.alert.Notselected" />");
       </script>
<%
   }
   else
   {
%>

<center>
	<h2 class="mainSubHeading"><center><bean:message bundle="InventoryResources" key="Backup.View.EquipmentConfiguration" /></center></h2>

  <table align="center" border="0" cellpadding=0 cellspacing=0>
  <tr class="tableOddRow">
    <td colspan="3" align="center" class="searchHeading">&nbsp;Getting <%=target_memory %> configuration from <%= equipmentName.length() > 10 ? equipmentName.substring(0,10) + "..." : equipmentName %>&nbsp;</td>
  </tr>
  <tr class="tableOddRow">
    <td align="center" class="tableCell" height="15">&nbsp;</td>
    <td align="center" class="tableCell" height="15">
      <table border="0" cellpadding=0 cellspacing=0>
        <tr>
<%
    for (int i = 0; i < SIZE; i++) {
%>
          <td><img src="../images/whitepixel.gif" name="img<%= i %>" width="<%= CELL_WIDTH %>" height="<%= CELL_HEIGHT %>"></td>
<%  } %>
        </tr>
      </table>
    </td>
    <td align="center" class="tableCell" height="15">&nbsp;</td>
   </tr>
</table>
<%

	String MWFM_WEB = getServletConfig().getInitParameter("ACTIVATOR_WEB");
	String MWFM_VAR = getServletConfig().getInitParameter("ACTIVATOR_VAR");
	String MWFM_ETC = getServletConfig().getInitParameter("ACTIVATOR_ETC");


	String registeredDrivers = "" + session.getAttribute("registered_drivers");
	if(!registeredDrivers.equals("true")) {
		registeredDrivers = "false";
		session.setAttribute((String)"registered_drivers", "true");
	}

	String sFilename = MWFM_VAR + File.separator + "plugins" + File.separator + "audit__" + equipmentName + "." + System.currentTimeMillis();

	DataSource dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
    Foo foo = new Foo(out, equipmentID, target_memory, sFilename, session, dataSource, MWFM_VAR, MWFM_WEB, MWFM_ETC, registeredDrivers);
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
                if ( foo.isDone() ) break;
        }
%>
<p>
<%
if ("".equals(foo.getReturnCode()) && !foo.isError() ) {
  for (int k=0; k < SIZE; k++) {
    out.println("<script> document.images['img" + k + "'].src = '../images/bluepixel.gif';" +
                "document.images['img" + k + "'].width = " + CELL_WIDTH + ";" +
                "document.images['img" + k + "'].height= " + CELL_HEIGHT + ";" +
                "</script>");
  }
  out.flush();
%>
<p align="center">&nbsp;&nbsp;<bean:message bundle="InventoryResources" key="Backup.View.success.retrieved" /></p>


<%
   	String vCurrentConfig = (foo.getWFOutput()).replaceAll("\r","");
   	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
%>



<%

   	String now = null;

   	String sUsername = (String) session.getAttribute(Constants.USER);
   	try {
     		now = sdf.format(new java.util.Date());
		%>
			<form name="form" method="POST">
			<table width="80%" border="0" cellpadding="0">
  				<tr>
					<td class="mainHeading" align="center" colspan=4><bean:message bundle="InventoryResources" key="Backup.View.EquipmentConfiguration" /></td>
  				</tr>
  				<%
  				int row = 1;
				String rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
  				%>
  				<tr class="<%=rowClass%>">
    					<td width="10%" class="tableCell">&nbsp;</td>
       				<td width="30%" class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.View.EquipmentName" /></b></td>
					<td width="50%" class="tableCell"><%= equipmentName %>
    					<td width="10%" class="tableCell">&nbsp;</td>
  				</tr>

				<%
				row ++;
				rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
				%>
  				<tr class="<%=rowClass%>">
    					<td class="tableCell">&nbsp;</td>
  					<td align=left class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.View.Timestamp" />&nbsp;</b></td>

    						<td align=left class="tableCell"><%= now %>
    						<input type="hidden" name="timestamp" value="<%= now %>"></td>

    					<td class="tableCell">&nbsp;</td>
				</tr>

				<%

				rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
				%>
  				</tr>

				<%
				row ++;
				rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
				%>
                <tr class="<%=(row%2 == 0) ? "tableEvenRow" : "tableOddRow"%>">
                    <td class="tableCell">&nbsp;</td>
                    <td align=left class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.View.MemoryType" />&nbsp;</b></td>
                    <td align=left class="tableCell"><%=  target_memory == null ? "": target_memory%>
                        <% if(target_memory != null){ %>
						    <input type="hidden" name="memoryType" value="<%= target_memory %>"></td>
                        <%}%>
                    <td class="tableCell">&nbsp;</td>
                </tr>
					<%
					row ++;
					rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
					%>
				<tr class="<%=rowClass%>">
    					<td class="tableCell">&nbsp;</td>
    					<td align=left class="tableCell"><b><bean:message bundle="InventoryResources" key="Backup.View.CreatedBy" />&nbsp;</b></td>
    					<td align=left class="tableCell"><%= sUsername %></td>
    					<td class="tableCell">&nbsp;</td>
  				</tr>

					<%
					row ++;
					rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
					%>
 					 <tr class="<%=rowClass%>">
					  	<td width="90%" colspan="4" class="mainHeading"  align="center"><bean:message bundle="InventoryResources" key="Backup.View.Data" /></td>
				  </tr>
				<%
				row ++;
				rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
				%>
				<tr class="<%=rowClass%>">
                    <td colspan="4" align="center" class="tableCell">
    						<textarea readonly wrap=off rows=40 cols="80%"  name="data" ><%=vCurrentConfig%></textarea>
    				</td>
  				</tr>
				<%
				row ++;
				rowClass= (row%2 == 0) ? "tableEvenRow" : "tableOddRow";
				%>
				<tr class="<%=rowClass%>">
				 	<td colspan="4" class="tableCell"  align="center">&nbsp;</td>
  				</tr>
  			</table>
			
				<table>
				<tr>
					<td><b><bean:message bundle="InventoryResources" key="Backup.Show.Save" /></b></td>
					<td>&nbsp;<a href="DownloadEquipmentConfiguration.jsp?equipmentID=<%=equipmentID%>&equipmentName=<%= equipmentName %>&timestamp=<%= now %>&filename=<%= foo.getFilename() %>"><img border=0 src="../images/save.gif" ></a></td>
				</tr>
				</table>
				
  				<p>
					<input type="button" name="close" value="<bean:message bundle="InventoryResources" key="Backup.View.button.Close" />" onClick='closeView()'>
				</p>

  			</form>
	<%
	} catch (Exception e) {
        e.printStackTrace();
       	%><b>Error.</b>
<% }
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
    <p align="center">Error ocurred while requesting configuration (<%= foo.getReturnCode() %>).</p>
    <%
}
if(!"".equals(jsp_returnCode)){
    %>
    <p align="center">Error ocurred during the output of configuration (<%= jsp_returnCode %>).</p>
    <%
}
   }
%>
</center>
</body>
</html>