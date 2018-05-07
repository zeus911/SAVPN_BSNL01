<!------------------------------------------------------------------------
###############################################################################
#
#    (c) Copyright 2003-2010 Hewlett-Packard Development Company, L.P.
#
###############################################################################

------------------------------------------------------------------------->
<%@ page import="com.hp.ov.activator.mwfm.*,com.hp.ov.activator.mwfm.servlet.*,com.hp.ov.activator.vpn.backup.*,com.hp.ov.activator.vpn.inventory.*,com.hp.ov.activator.cr.inventory.*,
		  com.hp.ov.activator.vpn.backup.servlet.*, com.hp.ov.activator.mwfm.engine.*,
                java.sql.*,javax.sql.DataSource, java.util.*, java.text.*, java.io.*, java.net.*,
                 java.rmi.Naming,
                 com.hp.ov.activator.mwfm.WFManager"
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
    if (session == null || session.getAttribute (com.hp.ov.activator.mwfm.servlet.Constants.USER) == null) {
       response.sendRedirect ("../../jsp/sessionError.jsp");
       return;
    } 
    response.setDateHeader("Expires",0);
    response.setHeader("Pragma","no-cache");
    request.setCharacterEncoding("UTF-8");
%>

<%
String target = request.getParameter ("target");
String target_memory = request.getParameter ("memory");
String rowid = URLDecoder.decode(request.getParameter ("rowid"), "UTF-8");
String equipment = URLDecoder.decode(request.getParameter ("equipment"),"UTF-8");
String clientIP = request.getRemoteAddr();
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
	//FooWriter fooWriter;
	String equipment;
	String target;
	String target_memory;
	String rowid;
	String clientIP;
	HttpSession session;
	DataSource dataSource;
	String MWFM_WEB;
	String MWFM_VAR;
	String MWFM_ETC;
    String jobName = "Manually load router config";
    private String returnCode="";
	boolean registeredDrivers;

	public Foo (JspWriter out, String equipment, String rowid, String target, String target_memory, String clientIP, HttpSession session, DataSource dataSource,
				String var, String web, String etc, String registered) {
          	//this.fooWriter = new FooWriter(out);
		this.out = out;
		this.equipment = equipment;
		this.target = target;
		this.target_memory = target_memory;
		this.rowid = rowid;
		this.clientIP = clientIP;
		this.session = session;
		this.bError = false;
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

	public synchronized boolean isDone () {
	  return b;
	}

	public synchronized boolean isError() {
	  return bError;
	}

	public synchronized void setDone() {
	  b = true;
	}

	public synchronized void setError() {
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

                DataSource dataSource= (DataSource)session.getAttribute(Constants.DATASOURCE);
                Connection connection = null;
                try{
                    connection = (Connection)dataSource.getConnection();
                    ISP isp = ISP.findByIdname(connection, "ISPID");
                    sHPSAAddress = isp.getIp();
                    if (sHPSAAddress == null || sHPSAAddress == ""){
                        System.out.println("send:IP was empty" + sHPSAAddress);
                        InetAddress localNetIP= InetAddress.getLocalHost();
				        sHPSAAddress = localNetIP.getHostAddress();
                    }
                    System.out.println("send:IP " + sHPSAAddress);
  			        com.hp.ov.activator.cr.inventory.NetworkElement[] equipo = com.hp.ov.activator.cr.inventory.NetworkElement.findByName(connection, equipment);
                    String networkElementID = equipo[0].getNetworkelementid();

                    parameters.put("equipment", equipment);
                    parameters.put("target", target);
                    parameters.put("memory", target_memory);
                    parameters.put("row_id", rowid);
                    parameters.put("hpip_hostname",sHPSAAddress);
                    parameters.put("neId", networkElementID);
                    parameters.put("clientIP", clientIP);

                    HashMap results = null;
                    results = wfm.startAndWaitForJob(jobName, parameters);
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
/* 		Connection con = null;
    	try {

            con = (Connection) dataSource.getConnection();
			com.hp.ov.activator.cr.inventory.NetworkElement[] abean = com.hp.ov.activator.cr.inventory.NetworkElement.findByName(con, target);
			com.hp.ov.activator.cr.inventory.NetworkElement rTarget = abean[0];
			if ( rTarget == null ) {
				try {
					setError();
					out.println("Equipment not found in inventory");
				} catch (Exception ignoreIt) {}
			}
			else {

				// JPM New
				// HPSA_IP ha desaparecido de web.xml
				InetAddress localNetIP= InetAddress.getLocalHost();
				String sHPSAAddress = localNetIP.getHostAddress();

				//Manual_LOAD_Template ha desaparecido de web.xml
				String manual_load_template = "MANUAL_LOAD_CONFIG.vm";
				String sTemplate = manual_load_template;

				LoadDeviceInformation ldi = new LoadDeviceInformation (MWFM_WEB + File.separator + "backup" + File.separator + "config" + File.separator + "deviceRegister.xml");

				DeviceInformation dInfo = ldi.getDeviceInformation(con, target);
				if ( dInfo == null ) {
					returnCode = "Equipment type backup not supported";
					setError();
					return;
				}

				// JPM. New. Obtener el correcto nombre de plantilla
				BackupURL backupURL = dInfo.getBackupURL();
                //-->
                System.out.println("BackupURL : " + backupURL);
                //-->
				String manufacturer = backupURL.getManufacturer();
                                String template_path="";
				if(manufacturer.equalsIgnoreCase("CISCO") || manufacturer.equalsIgnoreCase("CATALYST")) {
					sTemplate = "CISCO_MANUAL_LOAD_CONFIG.vm";
                                        template_path = MWFM_ETC + File.separator + "template_files" + File.separator + "Cisco";
                                } else if(manufacturer.equalsIgnoreCase("RIVERSTONE")) {
					sTemplate = "RIVERSTONE_MANUAL_LOAD_CONFIG.vm";
                                        template_path = MWFM_ETC + File.separator + "template_files" + File.separator + "Riverstone";
                                }
				dInfo.setExtAccessProperty("TEMPLATE", sTemplate);
				dInfo.setExtAccessProperty("HPIA_HOSTNAME", sHPSAAddress);
				dInfo.setExtAccessProperty("ROUTER_NAME", equipment);
				dInfo.setExtAccessProperty("ROW_ID", rowid);

				dInfo.setExtAccessProperty("TEMPLATE_PATH", template_path);
				//JPM New
				String temp_path =  MWFM_VAR + File.separator + "plugins";
				dInfo.setExtAccessProperty("TEMP_PATH", temp_path);

				dInfo.setExtAccessProperty("ARGUMENT_SEPARATOR" , ";");
				dInfo.setExtAccessProperty("VALUE_SEPARATOR" , ":");
				dInfo.setExtAccessProperty("ARRAY_CHARACTER" , "[]");

				if ( sHPSAAddress == null || sTemplate == null || sHPSAAddress.equals("") || sTemplate.equals("") ) {
					try {
						//out.println("Variables " + Constants.HPSA_IP + " and " + Constants.MANUAL_LOAD_TEMPLATE + " are mandatory in web.xml");
						setError();
					} catch (Exception ignoreIt) {}
				}
				else {
					// JPM New. Register Riverstone backup driver
					//RiverStoneBackupDriver bd= new RiverStoneBackupDriver();
					//BackupManager.registerBackupDriver(bd);
					if(!registeredDrivers) {
						com.hp.ov.activator.vpn.backup.drivers.loadBackupDrivers(con);
					}

					BackupConnection backupConnection = BackupManager.getConnection(dInfo);
					if ( backupConnection == null ) {
						returnCode = "This type of equipment does not have a backup driver loaded";
						setError();
					}
					else {
						backupConnection.open();

						backupConnection.sendConfiguration("", new MemoryType((new Integer(target_memory)).intValue()));
					}
				}
			}
		} catch (Exception e) {

			try {
				setError();
				returnCode = "Error getting device information: " + e.getMessage();
			} catch (Exception ignoreIt) {}
			} finally {
				if ( con != null )
				  try {
				    con.close();
				  } catch (Exception ignoreIt) {}
				setDone();
			}
		}
*/
	}
%>


<head>
	<script language="JavaScript" src="../../javascript/table.js"></script>
	<script language="JavaScript" src="../../javascript/checks.js"></script>
  	<link rel="stylesheet" type="text/css" href="../../css/activator.css">
  	<link rel="stylesheet" type="text/css" href="../../css/spainTable.css">
	<link rel="shortcut icon"  href="../../images/servact.ico">
</head>

<body>
<table border="0" cellpadding=0 cellspacing=0>
  <tr class="tableOddRow">
    <td class="searchHeading">&nbsp;<bean:message bundle="InventoryResources" key="Backup.SendEquipmentConfiguration.restore" /> <%= equipment.length() > 10 ? equipment.substring(0,10) + "..." : equipment %>&nbsp;</td>
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
	// Define the path names
	String MWFM_WEB = getServletConfig().getInitParameter("ACTIVATOR_WEB");
	String MWFM_VAR = getServletConfig().getInitParameter("ACTIVATOR_VAR");
	String MWFM_ETC = getServletConfig().getInitParameter("ACTIVATOR_ETC");

	/* Comprobar si estan cargados los drivers */
	String registeredDrivers = "" + session.getAttribute("registered_drivers");
	if(!registeredDrivers.equals("true")) {
		registeredDrivers = "false";
		session.setAttribute((String)"registered_drivers", "true");
	}

	DataSource dataSource = (DataSource) session.getAttribute (Constants.DATASOURCE);
        Foo foo = new Foo(out, equipment, rowid, target, target_memory, clientIP, session, dataSource, MWFM_VAR, MWFM_WEB, MWFM_ETC, registeredDrivers);
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
if ( "".equals(foo.getReturnCode()) && !foo.isError() ) {

  for (int k=0; k < SIZE; k++) {
    out.println("<script> document.images['img" + k + "'].src = '../images/bluepixel.gif';" +
                "document.images['img" + k + "'].width = " + CELL_WIDTH + ";" +
                "document.images['img" + k + "'].height= " + CELL_HEIGHT + ";" +
                "</script>");
  }
  out.flush();
%>
&nbsp;&nbsp;Configuration sent <br>
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
&nbsp;&nbsp;Error ocurred sending configuration (<%= foo.getReturnCode() %>).<br>
<%

} %>
</center>
</body>
</html>

