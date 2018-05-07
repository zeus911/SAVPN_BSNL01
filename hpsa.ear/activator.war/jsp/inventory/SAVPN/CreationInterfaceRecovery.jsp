<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
com.hp.ov.activator.vpn.inventory.*,
com.hp.ov.activator.inventory.SAVPN.*,
org.apache.struts.util.LabelValueBean,
org.apache.struts.action.Action,
java.sql.Connection,
java.sql.PreparedStatement,
javax.sql.DataSource,
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
String datasource = (String) request.getParameter(InterfaceRecoveryConstants.DATASOURCE);

String instance = (String) request.getParameter("instance");
String opname = (String)request.getParameter("opname");
String refreshTreeRimid = (String)request.getParameter("refreshTreeRimid");
String tab_name = (String)request.getParameter("tab_name");
String terminationpointid = (String)request.getParameter("terminationpointid");
String vi = (String)request.getParameter("vi");
String view = (String)request.getParameter("view");

String rimid = (String) request.getParameter("rimid");
String location = (String) request.getParameter("_location_");
String formAction = "/CreationCommitInterfaceRecoveryAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null) {
       exceptionMessage="";
}
if (location == null) {
       location = "sourceinterface";
}

String count = (String) String.valueOf(request.getAttribute("PREVIOUS_EXECUTION_FAILED"));
if ("1".equals(count)) {
       // remove old failed execution
       Connection con = null;
       try {
               DataSource ds = (DataSource)session.getAttribute("datasource");
               if (ds != null) {
                       con = ds.getConnection();
                       PreparedStatement ps = con.prepareStatement(
                               " DELETE FROM V_INTERFACERECOVERED " +
                               " WHERE SOURCETPID = '" + terminationpointid + "' ");
                       ps.executeUpdate();
               }
       }
       catch(Exception e) {}
       finally {
               if (con != null) {
                       try {
                               con.close();
                       } catch (Exception rollbackex) {}
               }
       }
}
%>

<script>
function performCommit() {
       if (document.getElementsByName("prevExecFail")[0].value == '1') {
               if (!confirm('<bean:message bundle="InterfaceRecoveryApplicationResources" key="previous.execution.failed"/>')) {
                       return;
               }
       }
       if (window.document.InterfaceRecoveryForm.targetNetwork.selectedIndex != 0 &&
               window.document.InterfaceRecoveryForm.targetNetwork.selectedIndex != -1 &&
               window.document.InterfaceRecoveryForm.targetInterface.selectedIndex != -1) {

               window.document.InterfaceRecoveryForm.enviando.disabled='true';
               window.document.InterfaceRecoveryForm.action = '/activator<%=moduleConfig%>/CreationCommitInterfaceRecoveryAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
               window.document.InterfaceRecoveryForm.submit();
       } else {
               alert('<bean:message bundle="InterfaceRecoveryApplicationResources" key="selects.not.empty.error"/>');
       }
}

function performReset() {
       window.document.InterfaceRecoveryForm.targetRegion.selectedIndex = -1;
       window.document.InterfaceRecoveryForm.targetNetwork.selectedIndex = -1;
       window.document.InterfaceRecoveryForm.targetPE.selectedIndex = -1;
       window.document.InterfaceRecoveryForm.targetInterface.selectedIndex = -1;
}

function changeSelect(event) {
       var selectObj = null;
       if (event.target != null) {
               selectObj = event.target.name;
       } else if (event.srcElement != null) {
               selectObj = event.srcElement.name;
       }
       if (selectObj == "targetRegion") {
               document.getElementsByName("targetNetwork")[0].value = "";
               document.getElementsByName("targetPE")[0].value = "";
       } else if (selectObj == "targetNetwork") {
               document.getElementsByName("targetPE")[0].value = "";
       }
       window.document.InterfaceRecoveryForm.action = '/activator<%=moduleConfig%>/CreationFormInterfaceRecoveryAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&instance=<%=instance %>&opname=<%=opname %>&refreshTreeRimid=<%=refreshTreeRimid %>&tab_name=<%=tab_name %>&terminationpointid=<%=terminationpointid %>&vi=<%=vi %>&view=<%=view %>';
       window.document.InterfaceRecoveryForm.submit();
}
</script>

<html>
<head>
<title><bean:message bundle="InterfaceRecoveryApplicationResources" key="<%= InterfaceRecoveryConstants.JSP_CREATION_TITLE %>"/></title>
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
com.hp.ov.activator.inventory.SAVPN.InterfaceRecoveryBean beanInterfaceRecovery = (com.hp.ov.activator.inventory.SAVPN.InterfaceRecoveryBean) request.getAttribute(InterfaceRecoveryConstants.INTERFACERECOVERY_BEAN);
String SourceInterface = StringFacility.replaceAllByHTMLCharacter(beanInterfaceRecovery.getSourceinterface());
ArrayList Services = (ArrayList)beanInterfaceRecovery.getServices();

String region = beanInterfaceRecovery.getTargetRegion();
String network = beanInterfaceRecovery.getTargetNetwork();
Boolean noInterfaces = (Boolean)request.getAttribute(InterfaceRecoveryConstants.NO_INTERFACES);
if (noInterfaces != null && noInterfaces)
{
       errorMessage = "search.results.empty";
       exceptionMessage = "There are no interfaces availables for the selected router, please select other.";
}

String TerminationId = StringFacility.replaceAllByHTMLCharacter(beanInterfaceRecovery.getTerminationid());
String NeId = StringFacility.replaceAllByHTMLCharacter(beanInterfaceRecovery.getNeid());
session.setAttribute("Services", Services);
%>
<center>
  <h2>
    <bean:message bundle="InterfaceRecoveryApplicationResources" key="jsp.creation.title"/>
  </h2>
</center>
<H1>
<html:errors bundle="InterfaceRecoveryApplicationResources" property="SourceInterface"/>
<html:errors bundle="InterfaceRecoveryApplicationResources" property="Services"/>
<html:errors bundle="InterfaceRecoveryApplicationResources" property="TargetInterface"/>
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

<html:hidden property="neId" value="<%= NeId%>"/>
<html:hidden property="terminationId" value="<%= TerminationId %>"/>
<html:hidden property="prevExecFail" value="<%= count %>"/>

<table:row>
       <table:cell>
       <bean:message bundle="InterfaceRecoveryApplicationResources" key="field.sourceinterface.alias"/>*
       </table:cell>
       <table:cell>
               <%= SourceInterface %>
               <html:hidden property="sourceinterface" value="<%= SourceInterface %>"/>
       </table:cell>
       <table:cell>
               <bean:message bundle="InterfaceRecoveryApplicationResources" key="field.sourceinterface.description"/>
       </table:cell>
</table:row>
<table:row>
       <table:cell>
               <bean:message bundle="InterfaceRecoveryApplicationResources" key="field.services.alias"/>
       </table:cell>
       <table:cell>
               <logic:iterate id="services" name="InterfaceRecoveryBean" property="services">
                       <bean:write name="services"/>
               </logic:iterate>
       </table:cell>
       <table:cell>
               <bean:message bundle="InterfaceRecoveryApplicationResources" key="field.services.description"/>
       </table:cell>
</table:row>

<table:row>
       <table:cell>
               <bean:message bundle="InterfaceRecoveryApplicationResources" key="field.targetregion.alias"/>
       </table:cell>
       <table:cell>
               <logic:notEmpty name="InterfaceRecoveryBean" property="targetRegionOptions">
                       <html:select property="targetRegion" onchange="changeSelect(event)">
                               <html:optionsCollection name="InterfaceRecoveryBean" property="targetRegionOptions" />
                       </html:select>
               </logic:notEmpty>
               <logic:empty name="InterfaceRecoveryBean" property="targetRegionOptions">
                       <html:select property="targetRegion"></html:select>
               </logic:empty>
       </table:cell>
       <table:cell>
               <bean:message bundle="InterfaceRecoveryApplicationResources" key="field.targetregion.description"/>
       </table:cell>
</table:row>

<table:row>
       <table:cell>
               <bean:message bundle="InterfaceRecoveryApplicationResources" key="field.targetnetwork.alias"/>
       </table:cell>
       <table:cell>
               <logic:notEmpty name="InterfaceRecoveryBean" property="targetNetworkOptions">
                       <html:select property="targetNetwork" onchange="changeSelect(event)">
                               <html:optionsCollection name="InterfaceRecoveryBean" property="targetNetworkOptions" />
                       </html:select>
               </logic:notEmpty>
               <logic:empty name="InterfaceRecoveryBean" property="targetNetworkOptions">
                       <html:select property="targetNetwork"></html:select>
               </logic:empty>
       </table:cell>
       <table:cell>
               <bean:message bundle="InterfaceRecoveryApplicationResources" key="field.targetnetwork.description"/>
       </table:cell>
</table:row>

<table:row>
       <table:cell>
               <bean:message bundle="InterfaceRecoveryApplicationResources" key="field.targetpe.alias"/>*
       </table:cell>
       <table:cell>
               <logic:notEmpty name="InterfaceRecoveryBean" property="targetPEOptions">
                       <html:select property="targetPE" onchange="changeSelect(event)">
                               <html:optionsCollection name="InterfaceRecoveryBean" property="targetPEOptions" />
                       </html:select>
               </logic:notEmpty>
               <logic:empty name="InterfaceRecoveryBean" property="targetPEOptions">
                       <html:select property="targetPE"></html:select>
               </logic:empty>
       </table:cell>
       <table:cell>
               <bean:message bundle="InterfaceRecoveryApplicationResources" key="field.targetpe.description"/>
       </table:cell>
</table:row>

<table:row>
       <table:cell>
               <bean:message bundle="InterfaceRecoveryApplicationResources" key="field.targetinterface.alias"/>*
       </table:cell>
       <table:cell>
               <logic:notEmpty name="InterfaceRecoveryBean" property="targetInterfaceOptions">
                       <html:select property="targetInterface">
                               <html:optionsCollection name="InterfaceRecoveryBean" property="targetInterfaceOptions" />
                       </html:select>
               </logic:notEmpty>
               <logic:empty name="InterfaceRecoveryBean" property="targetInterfaceOptions">
                       <html:select property="targetInterface"></html:select>
               </logic:empty>
       </table:cell>
       <table:cell>
               <bean:message bundle="InterfaceRecoveryApplicationResources" key="field.targetinterface.description"/>
       </table:cell>
</table:row>

<table:row>
       <table:cell colspan="3" align="center">
               <br>
       </table:cell>
</table:row>
<table:row>
       <table:cell colspan="3" align="center">
               <input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="performCommit();">&nbsp;
               <input type="button" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset" onclick="performReset();">
       </table:cell>
</table:row>
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
