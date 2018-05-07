<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
com.hp.ov.activator.vpn.inventory.*,
com.hp.ov.activator.cr.inventory.*,
com.hp.ov.activator.inventory.SAVPN.*,
org.apache.struts.util.LabelValueBean,   java.sql.Connection,
org.apache.struts.action.Action,javax.sql.DataSource,
java.sql.PreparedStatement,java.sql.ResultSet,
java.text.NumberFormat,
org.apache.struts.action.ActionErrors,
com.hp.ov.activator.inventory.facilities.StringFacility " %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri = "/WEB-INF/table-taglib.tld" prefix="table" %>
<%@ taglib uri = "/WEB-INF/button-taglib.tld" prefix="btn" %>

<%
// These lines below prevent catching at the browser and eventual proxy servers
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server

%>
<%
/** For Struts module concept **/
org.apache.struts.config.ModuleConfig strutsModuleConfig =
            org.apache.struts.util.ModuleUtils.getInstance().getModuleConfig(null,
                (HttpServletRequest) pageContext.getRequest(),
                pageContext.getServletContext());
// module name that can be used as solution name
String moduleConfig = strutsModuleConfig.getPrefix();
%>

<%
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);
nfB.setMaximumFractionDigits(6);

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(ControllerRecoveryConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String refreshTreeRimid = (String) request.getParameter("refreshTreeRimid");
String location = (String) request.getParameter("_location_");
String formAction = "/CreationCommitControllerRecoveryAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");

String SourcePEName = ""; 
String TargetPEName = ""; 
String SourceEcName = ""; 
String TargetEcName = ""; 

if (exceptionMessage==null){
exceptionMessage="";
}
if ( location == null ) {
location = "sourceinterface";
}
%>

<html>
<head>
<title><bean:message bundle="ControllerRecoveryApplicationResources" key="<%= ControllerRecoveryConstants.JSP_CREATION_TITLE %>"/></title>
<link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
<link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
<script src="/activator/javascript/hputils/alerts.js"></script>
<style type="text/css">
A.nodec { text-decoration: none; }
H1 { color: red; font-size: 13px }
</style>
</head>
<body background="/activator/images/inventory-gui/fondo.gif" style="overflow:auto;">
<%

com.hp.ov.activator.inventory.SAVPN.ControllerRecoveryBean beanControllerRecovery = (com.hp.ov.activator.inventory.SAVPN.ControllerRecoveryBean) request.getAttribute(ControllerRecoveryConstants.CONTROLLERRECOVERY_BEAN);
String SourceEcId = StringFacility.replaceAllByHTMLCharacter(beanControllerRecovery.getSourceecid());
ArrayList Services = (ArrayList)beanControllerRecovery.getServices();
int numberOfInterfaces = beanControllerRecovery.getNumberofinterfaces();
String TargetEcId = StringFacility.replaceAllByHTMLCharacter(beanControllerRecovery.getTargetecid());
int total       = 0;
int success     = 0;
int failed      = 0;
int attempts    = 0;
int totalCh     = 0;
int successCh   = 0;
int failedCh    = 0;
int attemptsCh  = 0;
int blueLength  = 0;
int count  =-1;
int SIZE= 40, CELL_WIDTH= 7, CELL_HEIGHT=10;
PreparedStatement ps = null;
PreparedStatement ps2 = null;
ResultSet rset = null;
ResultSet rset2 = null;
DataSource ds = (DataSource)session.getAttribute("datasource");
String TPID = beanControllerRecovery.getTerminationid();
Connection con = null;
try
{
    if (ds != null)
    {
      con = ds.getConnection();
    }
	
	com.hp.ov.activator.vpn.inventory.PERouter sourcePEObject = com.hp.ov.activator.vpn.inventory.PERouter.findByNetworkelementid(con,beanControllerRecovery.getSourceneid());
	SourcePEName = sourcePEObject.getName();
	
	com.hp.ov.activator.vpn.inventory.PERouter targetPEObject = com.hp.ov.activator.vpn.inventory.PERouter.findByNetworkelementid(con,beanControllerRecovery.getTargetPE());
	TargetPEName = targetPEObject.getName();
	
	com.hp.ov.activator.cr.inventory.ElementComponent sourceEcObject = com.hp.ov.activator.cr.inventory.ElementComponent.findByElementcomponentid(con, SourceEcId);
	SourceEcName = sourceEcObject.getName();
	
	com.hp.ov.activator.cr.inventory.ElementComponent targetEcObject = com.hp.ov.activator.cr.inventory.ElementComponent.findByElementcomponentid(con, TargetEcId);
	TargetEcName = targetEcObject.getName();
	
	com.hp.ov.activator.cr.inventory.Interface[] channelizedInterfaces = com.hp.ov.activator.cr.inventory.Interface.findByEc_id(con, SourceEcId);
	channelizedInterfaces = channelizedInterfaces != null ? channelizedInterfaces : new com.hp.ov.activator.cr.inventory.Interface[0];
	totalCh = channelizedInterfaces.length;
}
catch(Exception e)
{}
%>
<center>
  <h2>
    <bean:message bundle="ControllerRecoveryApplicationResources" key="jsp.creation.title"/>
  </h2>
</center>

<H1>
<html:errors bundle="ControllerRecoveryApplicationResources" property="SourceInterface"/>
<html:errors bundle="ControllerRecoveryApplicationResources" property="Services"/>
<html:errors bundle="ControllerRecoveryApplicationResources" property="TargetInterface"/>
</H1>

<html:form action="<%= formAction %>">
<center>
<table:table>
<table:header>
<table:cell>
<bean:message bundle="InventoryResources" key="name.heading"/>
</table:cell>
<table:cell>
<bean:message bundle="InventoryResources" key="value.heading"/>
</table:cell>
<table:cell>
<bean:message bundle="InventoryResources" key="description.heading"/>
</table:cell>
</table:header>

<table:row>
<table:cell>
<bean:message bundle="ControllerRecoveryApplicationResources" key="field.sourceec.alias"/>
*
</table:cell>
<table:cell>
<%= SourceEcName+" ("+SourcePEName+")" %>
</table:cell>
<table:cell>
<bean:message bundle="ControllerRecoveryApplicationResources" key="field.sourceec.description"/>
</table:cell>
</table:row>
<table:row>
<table:cell>
<bean:message bundle="ControllerRecoveryApplicationResources" key="field.numberofinterfaces.alias"/>
</table:cell>
<table:cell>
<%= String.valueOf(totalCh) %>
</table:cell>
<table:cell>
<bean:message bundle="ControllerRecoveryApplicationResources" key="field.numberofinterfaces.description"/>
</table:cell>
</table:row>
<table:row>
<table:cell>
<bean:message bundle="ControllerRecoveryApplicationResources" key="field.services.alias"/>
</table:cell>
<table:cell>
<logic:iterate id="services" name="ControllerRecoveryBean" property="services">
<bean:write name="services"/>
</logic:iterate>
</table:cell>


<table:cell>
<bean:message bundle="ControllerRecoveryApplicationResources" key="field.services.description"/>
</table:cell>
</table:row>
<table:row>
<table:cell>
<bean:message bundle="ControllerRecoveryApplicationResources" key="field.targetec.alias"/>
</table:cell>
<table:cell>
<%= TargetEcName+" ("+TargetPEName+")" %>
</table:cell>
<table:cell>
<bean:message bundle="ControllerRecoveryApplicationResources" key="field.targetec.description"/>
</table:cell>
</table:row>


<table:table>
<table:row>
<br>
<br>
Please wait while the process is completed... 
<br>
Moved <span ID="s1">0</span> out of <span ID="t1">0</span> channelized interface(s)
<br>
Moved <span ID="s">0</span> out of <span ID="t">0</span> service(s)
<br>
<br>
<%

for (int i = 0; i < SIZE; i++) {    %>
        <table:cell>
            <span ID="i">
                <img src="../../backup/images/whitepixel.gif" name="img<%= i %>" width="<%= CELL_WIDTH %>" height="<%= CELL_HEIGHT %>">
            </span>
    </table:cell>
<%  } %>
</table:row>
</table:table>
<%
try{

int timeoutCounter = 0; // Set to 720 x 5 seconds (1 hour)

String EC_ORIGIN = "EC"+SourceEcId;
String EC_TARGET = "EC"+TargetEcId;

Thread.sleep(2000);

ps = con.prepareStatement(
                    " SELECT    TOTAL, SUCCESS, FAILED              " +
                    " FROM      V_INTERFACERECOVERED                  " +
                    " WHERE     SOURCETPID IN ( SELECT TERMINATIONPOINTID FROM CR_TERMINATIONPOINT WHERE NE_ID = '" + beanControllerRecovery.getSourceneid() +"') " +
					" OR        TARGETTPID IN ( SELECT TERMINATIONPOINTID FROM CR_TERMINATIONPOINT WHERE NE_ID = '" + beanControllerRecovery.getTargetPE() + "') " );
					
boolean no_services=false;
if(Services.get(0).equals("NO SERVICES")){
	total=0;
	no_services=true;
}
else
{
	total = Services.size();
}

ps2 = con.prepareStatement(
                    " SELECT    TOTAL, SUCCESS, FAILED              " +
                    " FROM      V_INTERFACERECOVERED                  " +
                    " WHERE     SOURCETPID = '"+EC_ORIGIN+"' AND TARGETTPID = '"+EC_TARGET+"'");
					
do
{
rset = ps.executeQuery();
rset2 = ps2.executeQuery();

success = 0;
failed = 0;

successCh = 0;
failedCh = 0;

while (rset.next() && total > 0) {
    success     = success + rset.getInt("SUCCESS");
    failed      = failed + rset.getInt("FAILED");
    attempts    = success + failed;
}

while (rset2.next()) {
    successCh     = rset2.getInt("SUCCESS");
    failedCh      = rset2.getInt("FAILED");
    attemptsCh    = successCh + failedCh;
}


out.println("<script> document.getElementById('s').innerHTML = '"+ success +"'; " +
            "document.getElementById('t').innerHTML = '"+ total +"'; " +
			"document.getElementById('s1').innerHTML = '"+ successCh +"'; " +
			"document.getElementById('t1').innerHTML = '"+ totalCh +"'; " +
            "</script>");
out.flush();

if(total!=0){
    blueLength = (attempts * SIZE ) / total;
    for(int i=0; i< blueLength; i++){
            out.println("<script>document.images['img" + i + "'].src = 'C:/HP/jboss/server/default/deploy/hpovact.sar/activator.war/backup/images/bluepixel.gif'; " +
                        "document.images['img" + i + "'].width = " + CELL_WIDTH + "; " +
                        "document.images['img" + i + "'].height= " + CELL_HEIGHT + "; " +
                        "</script>");
            out.flush();
    }
}
out.flush();
Thread.sleep(5000);

timeoutCounter++;

}while((((attempts==0 || attempts < total)&& !no_services) || (attemptsCh < totalCh)) && (timeoutCounter < 720));
ps = con.prepareStatement(
                " DELETE FROM       V_INTERFACERECOVERED              " +
                " WHERE             SOURCETPID IN ( SELECT TERMINATIONPOINTID FROM CR_TERMINATIONPOINT WHERE NE_ID = '" + beanControllerRecovery.getSourceneid() + "') " +
                " AND               FAILED = '0'                    " +
                " AND               SUCCESS = TOTAL                 "
                );
            ps.executeUpdate();
            out.flush();
}
catch(Exception e)
{

}

finally
{
    if (con != null)
    {
		try { ps.close(); } catch (Exception rollbackex) {}
		try { ps2.close(); } catch (Exception rollbackex) {}
		try { rset.close(); } catch (Exception rollbackex) {}
		try { rset2.close(); } catch (Exception rollbackex) {}
		try { con.close(); } catch (Exception rollbackex) {}
	}
}
%>

<script>
if ((document.getElementById('s').innerHTML == document.getElementById('t').innerHTML) && (document.getElementById('s1').innerHTML == document.getElementById('t1').innerHTML)){
	if(document.getElementById('t').innerHTML == 0){
		alert(<%= String.valueOf(successCh) %>+"/"+<%= String.valueOf(totalCh) %> + " channelized interfaces migrated. No services to migrate. ");
	}else{
		alert(<%= String.valueOf(successCh) %>+"/"+<%= String.valueOf(totalCh) %> + " channelized interfaces have been migrated. " + <%= String.valueOf(success) %>+"/"+<%= String.valueOf(total) %> + " service(s) moved.");
	}	
} else {
	alert(<%= String.valueOf(successCh) %>+"/"+<%= String.valueOf(totalCh) %> + " channelized interfaces have been migrated. " + <%= String.valueOf(success) %>+"/"+<%= String.valueOf(total) %> + " service(s) moved. Please check the logs to know the problems.");
}
window.location.href = "/activator/jsp/inventory/RefreshTree.jsp?refreshTreeRimid=<%=refreshTreeRimid%>"
</script>
</table:table>
</center>

</html:form>

</body>
<%
if ( location != null ) {
%>

<script type="text/javascript">
document.all("<%=location%>").focus();
</script>
<%
}
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
<script>
var alertMsg = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
alertMsg.setBounds(400, 120);
alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
alertMsg.show();
</script>
<%
}
%>

</html>
