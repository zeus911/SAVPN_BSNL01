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
String datasource = (String) request.getParameter(RouterRecoveryConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String refreshTreeRimid = (String) request.getParameter("refreshTreeRimid");
String location = (String) request.getParameter("_location_");
String formAction = "/CreationCommitRouterRecoveryAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");

if (exceptionMessage==null){
exceptionMessage="";
}
if ( location == null ) {
location = "sourceinterface";
}
%>

<html>
<head>
<title><bean:message bundle="RouterRecoveryApplicationResources" key="<%= RouterRecoveryConstants.JSP_CREATION_TITLE %>"/></title>
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

com.hp.ov.activator.inventory.SAVPN.RouterRecoveryBean beanRouterRecovery = (com.hp.ov.activator.inventory.SAVPN.RouterRecoveryBean) request.getAttribute(RouterRecoveryConstants.ROUTERRECOVERY_BEAN);
String SourceInterface = StringFacility.replaceAllByHTMLCharacter(beanRouterRecovery.getSourceinterface());
ArrayList Services = (ArrayList)beanRouterRecovery.getServices();
String TargetInterface = StringFacility.replaceAllByHTMLCharacter(beanRouterRecovery.getTargetInterface());
int total       = 0;
int success     =0;
int failed      = 0;
int attempts    = 0;
int blueLength  =0;
int count  =-1;
int SIZE= 40, CELL_WIDTH= 7, CELL_HEIGHT=10;
PreparedStatement ps = null;
ResultSet rset = null;
DataSource ds = (DataSource)session.getAttribute("datasource");
String TPID = beanRouterRecovery.getTerminationid();
Connection con = null;
String targetPEName = ""; 
try
{
    if (ds != null)
    {
      con = ds.getConnection();
    }
	
	com.hp.ov.activator.vpn.inventory.PERouter targetPEObject = com.hp.ov.activator.vpn.inventory.PERouter.findByNetworkelementid(con,beanRouterRecovery.getTargetPE());
	targetPEName = targetPEObject.getName();
}
catch(Exception e)
{}
%>
<center>
  <h2>
    <bean:message bundle="RouterRecoveryApplicationResources" key="jsp.creation.title"/>
  </h2>
</center>

<H1>
<html:errors bundle="RouterRecoveryApplicationResources" property="SourceInterface"/>
<html:errors bundle="RouterRecoveryApplicationResources" property="Services"/>
<html:errors bundle="RouterRecoveryApplicationResources" property="TargetInterface"/>
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
<bean:message bundle="RouterRecoveryApplicationResources" key="field.sourcepe.alias"/>
*
</table:cell>
<table:cell>
<%= beanRouterRecovery.getSourcene() %>
</table:cell>
<table:cell>
<bean:message bundle="RouterRecoveryApplicationResources" key="field.sourcepe.description"/>
</table:cell>
</table:row>
<table:row>
<table:cell>
<bean:message bundle="RouterRecoveryApplicationResources" key="field.services.alias"/>
</table:cell>
<table:cell>
<logic:iterate id="services" name="RouterRecoveryBean" property="services">
<bean:write name="services"/>
</logic:iterate>
</table:cell>


<table:cell>
<bean:message bundle="RouterRecoveryApplicationResources" key="field.services.description"/>
</table:cell>
</table:row>
<table:row>
<table:cell>
<bean:message bundle="RouterRecoveryApplicationResources" key="field.targetpe.alias"/>
</table:cell>
<table:cell>
<%= targetPEName %>
</table:cell>
<table:cell>
<bean:message bundle="RouterRecoveryApplicationResources" key="field.targetpe.description"/>
</table:cell>
</table:row>


<table:table>
<table:row>
<br>
<br>
Please wait while the process is completed... moved <span ID="s">0</span> out of <span ID="t">0</span> service(s)
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

Thread.sleep(2000);

ps = con.prepareStatement(
                    " SELECT    TOTAL, SUCCESS, FAILED              " +
                    " FROM      V_INTERFACERECOVERED                  " +
                    " WHERE     SOURCETPID IN ( SELECT TERMINATIONPOINTID FROM CR_TERMINATIONPOINT WHERE NE_ID = '" + beanRouterRecovery.getSourceneid() + "') " );

total = Services.size();					
					
do
{
rset = ps.executeQuery();

success = 0;
failed = 0;

while (rset.next()) {
    // total       = rset.getInt("TOTAL");
    success     = success + rset.getInt("SUCCESS");
    failed      = failed + rset.getInt("FAILED");
    attempts    = success + failed;
}

out.println("<script> document.getElementById('s').innerHTML = '"+ success +"'; " +
            "document.getElementById('t').innerHTML = '"+ total +"'; " +
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
Thread.sleep(2000);
}while(attempts==0 || attempts < total);
ps = con.prepareStatement(
                " DELETE FROM       V_INTERFACERECOVERED              " +
                " WHERE             SOURCETPID IN ( SELECT TERMINATIONPOINTID FROM CR_TERMINATIONPOINT WHERE NE_ID = '" + beanRouterRecovery.getSourceneid() + "') " +
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
            try
            {
                con.close();
            } catch (Exception rollbackex)
            {
                //we don't handle this exception because we think this should be
                //corrected manually. System cann't handle this problem by itself.
            }
     }

}
%>

<script>
if (document.getElementById('s').innerHTML == document.getElementById('t').innerHTML) {
       alert("Congratulations: " + document.getElementById('t').innerHTML + " service(s) successfully moved.");
} else {
       alert("Warning: only " + document.getElementById('s').innerHTML + " are correctly moved. Please check the logs to know the problems.");
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
