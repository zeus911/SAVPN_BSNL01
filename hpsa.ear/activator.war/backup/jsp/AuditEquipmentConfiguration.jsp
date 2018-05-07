<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2011 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->

<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,
		  com.hp.ov.activator.vpn.backup.servlet.*, com.hp.ov.activator.mwfm.engine.*, com.hp.spain.telnet.*, com.hp.spain.cli.*, 
		  org.apache.commons.jrcs.diff.*, org.apache.commons.jrcs.rcs.*, com.hp.ov.activator.vpn.diffutils.VPNDeltaParser,
		  com.hp.ov.activator.vpn.diffutils.*, java.sql.*,javax.sql.DataSource, java.util.*, java.text.*, java.io.*, java.net.*, 
		  com.hp.ov.activator.mwfm.WFManager"
         info="Audit Equipment List" 
         session="true" 
         contentType="text/html; charset=UTF-8"
         language="java"
%>

<% /* JPM New */ %>
<%
    // Check if there is a valid session available.
    if (session == null || session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) == null) {
       response.sendRedirect ("../../login_error.html");
       return;
    }

	response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

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
    String equipmentID;
	String target_memory;
	String sFilename;
	HttpSession session;
	DataSource dataSource;
	String MWFM_WEB;
	String MWFM_VAR;
	String MWFM_ETC;
    String jobName = "Audit router config";
    String current_config_var = "xml";
	boolean registeredDrivers;
    private String returnCode="";
    private String wf_output = "";

	public Foo (JspWriter out, String equipmentID, String equipment, String target_memory, String sFilename, HttpSession session,
				DataSource dataSource, String var, String web, String etc, String registered) {
		this.out = out;
		this.equipment = equipment;
        this.equipmentID = equipmentID;
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
		String[] vs = sString.split("\n");
		Vector v = new Vector();

		for (int i=0; i < vs.length; i++) {
			v.addElement(vs[i]);
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
                returnCode = "Can't connect to the Micro Workflow Manager";
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
                        System.out.println("audit:IP was empty" + sHPSAAddress);
                    }
                    System.out.println("audit:IP " + sHPSAAddress);
                    parameters.put("equipment", equipment);
                    parameters.put("memory", target_memory);
                    parameters.put("hpip_hostname", sHPSAAddress);
                    parameters.put("neId", equipmentID);

                    HashMap results = null;
                    results = (HashMap)wfm.startAndWaitForJob(jobName, parameters);
                    if(results != null){
                        if("1".equals(String.valueOf(results.get("RET_VALUE")))){
                            throw new Exception("Error during the workflow execution");
                        }
						if("1".equals(String.valueOf(results.get("ret_value")))){
                            throw new Exception("Error during the workflow execution");
                        }
                        if("1".equals(String.valueOf(results.get("activation_major_code")))){
                            throw new Exception("Error during the activation [" + results.get("activation_description") + "]");
                        }
                        wf_output = String.valueOf(results.get(this.current_config_var));
                    }
                }catch(UnknownHostException uhs){
                    setError();
                    returnCode = "Can't state the SA host IP address. Reason : " + uhs.getMessage();
                }catch(Exception e){
                    setError();
                    returnCode = "Can't start the job [" + jobName + "]. Reason : " + e.getMessage();
                }finally{
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
	<script language="JavaScript" src="../../javascript/table.js"></script>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
 	<script language="JavaScript" src="../javascript/overlib.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
	<link rel="stylesheet" type="text/css" href="../../css/spainTable.css">
</head>

<jsp:useBean id="menuBackupBean" scope="session" class="com.hp.ov.activator.vpn.backup.servlet.menuBackupBean" />
<%
String equipment = menuBackupBean.getEquipmentName();
String equipmentID = menuBackupBean.getEquipmentID();
String timestamp = menuBackupBean.getTimestamp();
String target_memory = (String)request.getParameter("memory");
String jsp_returnCode = "";
if(target_memory == null){
    jsp_returnCode = "The target memory is not indicated!";
}
%>

<body>
	<center><h2 class="mainSubHeading">Audit Equipment Back-up</center></h2>
<table align="center" border="0" cellpadding=0 cellspacing=0>
  <tr class="tableOddRow">
    <td colspan="3" align="center" class="searchHeading">&nbsp;Getting <%=target_memory %> configuration from <%= equipment.length() > 10 ? equipment.substring(0,10) + "..." : equipment %>&nbsp;</td>
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
<center>
<%
	// JPM New
	/* Definir las rutas de acceso en funcion del tipo de sistema */
	String systemType = System.getProperty("os.name").toUpperCase();
	String MWFM_WEB = getServletConfig().getInitParameter("ACTIVATOR_WEB");
	String MWFM_VAR = getServletConfig().getInitParameter("ACTIVATOR_VAR");
	String MWFM_ETC = getServletConfig().getInitParameter("ACTIVATOR_ETC");
	
	/* Comprobar si estan cargados los drivers */
	String registeredDrivers = "" + session.getAttribute("registered_drivers");
	if(!registeredDrivers.equals("true")) {
		registeredDrivers = "false";
		session.setAttribute((String)"registered_drivers", "true");
	}
	
	String sFilename = MWFM_VAR + File.separator + "plugins" + File.separator + "audit__" + equipment + "." + System.currentTimeMillis();
	StringBuffer sb = new StringBuffer("");

	DataSource dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
    Foo foo = new Foo(out, equipmentID, equipment, target_memory, sFilename, session, dataSource, MWFM_VAR, MWFM_WEB, MWFM_ETC, registeredDrivers);
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
<p align="center">&nbsp;&nbsp;Configuration was retrieved successfully!</p>

<table width=100% border="0" cellpadding="0">
	<tr>
		<td colspan="8" class="mainHeading" align="center">Colors Definition</td>
	</tr>
	<tr class="tableOddRow">
		<td class="tableCell">&nbsp;</td>
		<td class="tableCell">No differences&nbsp;</td>
		<td class="diffChange">&nbsp;</td>
		<td class="tableCell">Changed in current configuration&nbsp;</td>
		<td class="diffDelete">&nbsp;</td>
		<td class="tableCell">Deleted in current configuration&nbsp;</td>
		<td class="diffInsert">&nbsp;</td>
		<td class="tableCell">Inserted in current configuration&nbsp;</td>
	</tr>
</table>

	<table class="activatorTable" align="center" width=100% border=0 cellpadding=0>
		<tr>
			<td class="mainHeading">&nbsp;</td>
			<td class="mainHeading">Audited Configuration</td>
			<td class="mainHeading">Current Configuration</td>
			<td class="mainHeading">&nbsp;</td>
		</tr>
<%
	    Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;    
   try {
		con = dataSource.getConnection();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
		EquipmentConfiguration ec;


		if ( timestamp != null ) {
            java.sql.Timestamp TimeStamp=null;
            java.util.Date formattedTime = null;
            ps = con.prepareStatement("select configtime from v_backupref where creationtime=to_date('"+timestamp+"','yyyy.mm.dd hh24:mi:ss') and eqid='"+equipmentID+"'") ;
            rs = ps.executeQuery();
            while (rs.next()){
                TimeStamp = rs.getTimestamp(1);
            }
            if (TimeStamp != null){
                formattedTime = sdf.parse(TimeStamp.toString());
            }
            ec = EquipmentConfigurationWrapper.findByPrimaryKeys (con, equipmentID, formattedTime);
		}
		else {
			ec = EquipmentConfigurationWrapper.findByLastConfiguration (con, equipmentID);
		}

        String commentSymbol = "!";


        String auditConfigBytes = ec.getData();
        if(auditConfigBytes == null){
            auditConfigBytes = "";
        }

        String aStr = new String(auditConfigBytes);
        aStr = aStr.replaceAll("\r", "") + "\n";
        Vector vAuditConfig = foo.stringToVector(aStr);

       Vector vCurrentConfig = foo.stringToVector((foo.getWFOutput()).replaceAll("\r",""));

       if(vCurrentConfig.size()>0){
           vCurrentConfig.remove(vCurrentConfig.size()-1);
       }

       boolean configEnded = false;
       int     commentIndex;
       String  configBegin = "version";
       String  showConfigBegin = "Running system configuration:";
       // Removing comments and line numbers (on Riverstone some configs come like "line_number : config line"
       String line;
       for (int i = vCurrentConfig.size()-1; i >= 0 ; i--) {
           line = (String) vCurrentConfig.elementAt (i);
           commentIndex = line.indexOf('#');
           if ((commentIndex != -1) && (commentIndex != 0)) line = line.substring(0,commentIndex-1);
           if(!configEnded) configEnded = line.startsWith(configBegin) || line.startsWith(showConfigBegin);
           if(configEnded || line.trim ().startsWith (commentSymbol) || line.trim().length() == 0 ){
               vCurrentConfig.remove (i);
               continue;
           }
           int index = line.indexOf (':');
           if(index != -1 && index < 5){
               line = line.substring (index+2);
           }
           String spacesLine = "";
           int st = 0, len = line.length();
           byte[] val = line.getBytes();
	       while ((st < len) && (val[st] == ' ')) {
               spacesLine = spacesLine + "&#160;";
           	   st++;
           }
           if (st != 0) line = spacesLine + line.substring(st);
           vCurrentConfig.set (i, line);
       }
       configEnded = false;
       for (int i = vAuditConfig.size()-1; i >=0 ; i--) {
           line = (String) vAuditConfig.elementAt (i);
           commentIndex = line.indexOf('#');
           if ((commentIndex != -1) && (commentIndex != 0)) line = line.substring(0,commentIndex-1);
           if(!configEnded) configEnded = line.startsWith(configBegin) || line.startsWith(showConfigBegin);
           if(configEnded || line.trim ().startsWith (commentSymbol) || line.trim().length() == 0 ){
               vAuditConfig.remove (i);
               continue;
           }
           int index = line.indexOf (':');
           if(index != -1 && index < 5){
               line = line.substring (index+2);
           }
           String spacesLine = "";
           int st = 0, len = line.length();
           byte[] val = line.getBytes();
	       while ((st < len) && (val[st] == ' ')) {
               spacesLine = spacesLine + "&#160;";
           	   st++;
           }
           if (st != 0) line = spacesLine + line.substring(st);
           vAuditConfig.set (i, line);
       }

		Object[] aoAuditConfig = Diff.stringToArray(foo.vectorToString(vAuditConfig));
		Object[] aoCurrentConfig = Diff.stringToArray(foo.vectorToString(vCurrentConfig));

		Revision revision = Diff.diff(aoAuditConfig, aoCurrentConfig);
		com.hp.ov.activator.vpn.diffutils.VPNDeltaParser udf = 
			new com.hp.ov.activator.vpn.diffutils.VPNDeltaParser (new StringReader(revision.toString()));

		com.hp.ov.activator.vpn.diffutils.Delta d;

		int iLineIndex = 1;
		int iLineFile1 = 0;
		int iLineFile2 = 0;
		String rowClass= "tableOddRow";
		while ( ( d = udf.getNextDelta()) != null ) {
			for (; iLineFile1 + 1 < d.getStartLineInOriginal(); iLineIndex++) {
				String sAuditLine = (String) vAuditConfig.get(iLineFile1++);
				String sCurrentLine = (String) vCurrentConfig.get(iLineFile2++);
%>
				<tr class="<%= rowClass%>">
					<td class="tableCell">&nbsp;</td>
					<td class="tableCell"><%= sAuditLine %></td>
					<td class="tableCell"><%= sCurrentLine %></td>
					<td class="tableCell">&nbsp;</td>
				</tr>
<%

			}
			if (d instanceof com.hp.ov.activator.vpn.diffutils.ChangeDelta) {
				int iLastLineFile1 = ((com.hp.ov.activator.vpn.diffutils.ChangeDelta) d).getEndLineInOriginal();
				int iLastLineFile2 = ((com.hp.ov.activator.vpn.diffutils.ChangeDelta) d).getEndLineInRevised();
				for (; iLineFile1 + 1 <= iLastLineFile1 || iLineFile2 + 1 <= iLastLineFile2;) {
					String sAuditLine = "";
					String sCurrentLine = "";

					if ( iLineFile1 + 1 <= iLastLineFile1 )
						sAuditLine = (String) vAuditConfig.get(iLineFile1++);
					if ( iLineFile2 + 1 <= iLastLineFile2 )
						sCurrentLine = (String) vCurrentConfig.get(iLineFile2++);
%>
					<tr class="<%= rowClass%>">
						<td class="diffChange" align=center>C</td>
						<td class="diffChange"><%= sAuditLine %></td>
						<td class="diffChange"><%= sCurrentLine %></td>
						<td class="diffChange">&nbsp</td>
					</tr>
<%
				}
			}
			else if (d instanceof com.hp.ov.activator.vpn.diffutils.DeleteDelta) {
				int iLastLineFile1 = ((com.hp.ov.activator.vpn.diffutils.DeleteDelta) d).getEndLineInOriginal();
				for (; iLineFile1 + 1 <= iLastLineFile1;) {
					String sAuditLine = "";
					String sCurrentLine = "";

					if ( iLineFile1 + 1 <= iLastLineFile1 ) {
						sAuditLine = (String) vAuditConfig.get(iLineFile1++);
					}
%>
					<tr class="<%= rowClass%>">
						<td class="diffDelete" align=center>D</td>
						<td class="diffDelete"><%= sAuditLine %></td>
						<td class="diffDelete"><%= sCurrentLine %></td>
						<td class="diffDelete">&nbsp</td>
					</tr>
<%
				}
			}
			else if (d instanceof com.hp.ov.activator.vpn.diffutils.AddDelta) {
				String sAuditLine = "";
				String sCurrentLine = "";
				if ( iLineFile1 > 0 && iLineFile2 > 0 ) {
					sAuditLine = (String) vAuditConfig.get(iLineFile1++);
					sCurrentLine = (String) vCurrentConfig.get(iLineFile2++);
%>
					<tr class="<%= rowClass%>">
						<td class="tableCell">&nbsp;</td>
						<td class="tableCell"><%= sAuditLine %></td>
						<td class="tableCell"><%= sCurrentLine %></td>
						<td class="tableCell">&nbsp;</td>
					</tr>
<%
				}
				int iLastLineFile2 = ((com.hp.ov.activator.vpn.diffutils.AddDelta) d).getEndLineInRevised();
				for (; iLineFile2 + 1 <= iLastLineFile2;) {
					sAuditLine = "";
					sCurrentLine = "";

					if ( iLineFile2 + 1 <= iLastLineFile2 ) {
						sCurrentLine = (String) vCurrentConfig.get(iLineFile2++);
					}
%>
					<tr class="<%= rowClass%>">
						<td class="diffInsert" align=center>I</td>
						<td class="diffInsert"><%= sAuditLine %></td>
						<td class="diffInsert"><%= sCurrentLine %></td>
						<td class="diffInsert">&nbsp</td>
					</tr>
<%
				}
			}
		}

		for (;iLineFile1 < vAuditConfig.size() || iLineFile2 < vCurrentConfig.size();) {
			String sAuditLine = "";
			String sCurrentLine = "";

			if ( iLineFile1 < vAuditConfig.size() )
				sAuditLine = (String) vAuditConfig.get(iLineFile1++);

			if ( iLineFile2 < vCurrentConfig.size() )
				sCurrentLine = (String) vCurrentConfig.get(iLineFile2++);
%>
			<tr class="<%= rowClass%>">
				<td class="tableCell">&nbsp;</td>
				<td class="tableCell"><%= sAuditLine %></td>
				<td class="tableCell"><%= sCurrentLine %></td>
				<td class="tableCell">&nbsp;</td>
			</tr>
<%
		}
%>
<% }catch(ArrayIndexOutOfBoundsException ae){
       //don't worry about it
   }catch(Exception e){
        jsp_returnCode =  e.toString();   e.printStackTrace();
	} finally {
       if (rs != null)
        rs.close();
       if (ps != null)
        ps.close();
		if (con != null)
			con.close();
		File f = new File(sFilename);
		f.delete();
	}
%>
	</table>

<p></p>
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
    <p align="center">Error ocurred while requesting configuration (<%= foo.getReturnCode() %>).</p>
    <%
}
if(!"".equals(jsp_returnCode)){
    %>
    <p align="center">Error ocurred during the output of configuration (<%= jsp_returnCode %>).</p>
    <%
}
%>
</body>
</html>
