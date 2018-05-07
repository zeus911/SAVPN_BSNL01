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
java.util.Set,
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

String instance = (String) request.getParameter("instance");
String opname = (String)request.getParameter("opname");
String refreshTreeRimid = (String)request.getParameter("refreshTreeRimid");
String tab_name = (String)request.getParameter("tab_name");
String terminationpointid = (String)request.getParameter("terminationpointid");
String vi = (String)request.getParameter("vi");
String view = (String)request.getParameter("view");

String rimid = (String) request.getParameter("rimid");
String location = (String) request.getParameter("_location_");
String formAction = "/CreationCommitRouterRecoveryAction.do?datasource=" + datasource + "&rimid=" + rimid;

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


com.hp.ov.activator.inventory.SAVPN.RouterRecoveryBean beanRouterRecovery = (com.hp.ov.activator.inventory.SAVPN.RouterRecoveryBean) request.getAttribute(RouterRecoveryConstants.ROUTERRECOVERY_BEAN);

ArrayList Services = (ArrayList)beanRouterRecovery.getServices();

String region = beanRouterRecovery.getTargetRegion();
String network = beanRouterRecovery.getTargetNetwork();
Boolean noInterfaces = (Boolean)request.getAttribute(RouterRecoveryConstants.NO_INTERFACES);
if (noInterfaces != null && noInterfaces)
{
       errorMessage = "search.results.empty";
       exceptionMessage = "There are no interfaces availables for the selected router, please select other.";
}

String TerminationId = StringFacility.replaceAllByHTMLCharacter(beanRouterRecovery.getTerminationid());
String SourceNe = StringFacility.replaceAllByHTMLCharacter(beanRouterRecovery.getSourcene());
String SourceNeId = StringFacility.replaceAllByHTMLCharacter(beanRouterRecovery.getSourceneid());
String SourceRegion = StringFacility.replaceAllByHTMLCharacter(beanRouterRecovery.getSourceregion());
String SourceNetwork = StringFacility.replaceAllByHTMLCharacter(beanRouterRecovery.getSourcenetwork());
session.setAttribute("Services", Services);
%>

<script>
function performCommit() {
       if (document.getElementsByName("prevExecFail")[0].value == '1') {
               if (!confirm('<bean:message bundle="RouterRecoveryApplicationResources" key="previous.execution.failed"/>')) {
                       return;
               }
       }

       var interfacesOK = true;
       for (i = 0; i < document.getElementsByName("interfacesContainer").length; i++) {
               var sourceInterfaceName = "sourceinterface" + i;
               var targetInterfaceName = "targetinterface" + i;
               if (document.getElementsByName(sourceInterfaceName)[0].selectedIndex == 0 ||
                       document.getElementsByName(targetInterfaceName)[0].selectedIndex == 0 ||
                       document.getElementsByName(sourceInterfaceName)[0].selectedIndex == -1 ||
                       document.getElementsByName(targetInterfaceName)[0].selectedIndex == -1) {
                       interfacesOK = false;
               }
       }

       var action = '/activator<%=moduleConfig%>/CreationCommitRouterRecoveryAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
       for (i = 0; i < document.getElementsByName("interfacesContainer").length; i++) {
               var sourceInterfaceName = "sourceinterface" + i;
               var targetInterfaceName = "targetinterface" + i;
               action += '&sourceInterface' + i + '=' + document.getElementsByName(sourceInterfaceName)[0].value;
               action += '&targetInterface' + i + '=' + document.getElementsByName(targetInterfaceName)[0].value;
       }
       action += '&interfacesnum=' + i;

       if (window.document.RouterRecoveryForm.targetNetwork.selectedIndex != 0 &&
               window.document.RouterRecoveryForm.targetNetwork.selectedIndex != -1 &&
               interfacesOK) {

               window.document.RouterRecoveryForm.enviando.disabled='true';
               window.document.RouterRecoveryForm.action = action;
               window.document.RouterRecoveryForm.submit();
       } else {
               alert('<bean:message bundle="RouterRecoveryApplicationResources" key="selects.not.empty.router.interface.error"/>');
       }
}

function clearCombobox(select) {
       var clearLength = select.options.length;
       if (clearLength != 0) {
               for (clearCount = 0; clearCount < clearLength; clearCount++) {
                       select.remove(0);
               }
       }
}

function performResetInterfaces() {
       var containerLenght = document.getElementsByName("interfacesContainer").length;
       for (containerCount = 0; containerCount < containerLenght; containerCount++) {
          var sourceInterfaceName = "sourceinterface" + containerCount;
          var targetInterfaceName = "targetinterface" + containerCount;
          clearCombobox(document.getElementsByName(sourceInterfaceName)[0]);
          clearCombobox(document.getElementsByName(targetInterfaceName)[0]);
       }
}

function performReset() {
          window.document.RouterRecoveryForm.targetRegion.selectedIndex = -1;
          clearCombobox(window.document.RouterRecoveryForm.targetNetwork);
       clearCombobox(window.document.RouterRecoveryForm.targetPE);
          performResetInterfaces();
}

function changeSelect(event) {
       var selectObj = null;
       if (event.target != null) {
               selectObj = event.target.name;
       } else if (event.srcElement != null) {
               selectObj = event.srcElement.name;
       }
       var action = '/activator<%=moduleConfig%>/CreationFormRouterRecoveryAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&instance=<%=instance %>&opname=<%=opname %>&refreshTreeRimid=<%=refreshTreeRimid %>&tab_name=<%=tab_name %>&terminationpointid=<%=terminationpointid %>&vi=<%=vi %>&view=<%=view %>';
       if (selectObj == "targetRegion") {
               document.getElementsByName("targetNetwork")[0].value = "";
               document.getElementsByName("targetPE")[0].value = "";
       } else if (selectObj == "targetNetwork") {
               document.getElementsByName("targetPE")[0].value = "";
       } else if (selectObj.indexOf("sourceinterface") > -1 || selectObj.indexOf("targetinterface") > -1) {
               for (i = 0; i < document.getElementsByName("interfacesContainer").length; i++) {
                       var sourceInterfaceName = "sourceinterface" + i;
                       var targetInterfaceName = "targetinterface" + i;
                       action += '&sourceInterface' + i + '=' + document.getElementsByName(sourceInterfaceName)[0].value;
                       action += '&targetInterface' + i + '=' + document.getElementsByName(targetInterfaceName)[0].value;
               }
               action += '&interfacesnum=' + i;
       }
       window.document.RouterRecoveryForm.action = action;
       window.document.RouterRecoveryForm.submit();
}

function addInterfaceRow() {
       <% if (beanRouterRecovery.getTargetPE() != null) { %>
               var action = '/activator<%=moduleConfig%>/CreationFormRouterRecoveryAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&instance=<%=instance %>&opname=<%=opname %>&refreshTreeRimid=<%=refreshTreeRimid %>&tab_name=<%=tab_name %>&terminationpointid=<%=terminationpointid %>&vi=<%=vi %>&view=<%=view %>';
               for (i = 0; i < document.getElementsByName("interfacesContainer").length; i++) {
                       var sourceInterfaceName = "sourceinterface" + i;
                       var targetInterfaceName = "targetinterface" + i;
                       action += '&sourceInterface' + i + '=' + document.getElementsByName(sourceInterfaceName)[0].value;
                       action += '&targetInterface' + i + '=' + document.getElementsByName(targetInterfaceName)[0].value;
               }
               action += '&interfacesnum=' + (i + 1);
               window.document.RouterRecoveryForm.action = action;
               window.document.RouterRecoveryForm.submit();
       <% } else { %>
               alert('<bean:message bundle="RouterRecoveryApplicationResources" key="select.target.router.interface.error"/>');
       <% } %>
}

function delInterfaceRow() {
       if (document.getElementsByName("interfacesContainer").length > 1) {
               var index = (document.getElementsByName("interfacesContainer").length - 1);
               var element = document.getElementsByName("interfacesContainer"), index;
               element[index].parentNode.removeChild(element[index]);
               <% if (beanRouterRecovery.getTargetPE() != null) { %>
                       var action = '/activator<%=moduleConfig%>/CreationFormRouterRecoveryAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&instance=<%=instance %>&opname=<%=opname %>&refreshTreeRimid=<%=refreshTreeRimid %>&tab_name=<%=tab_name %>&terminationpointid=<%=terminationpointid %>&vi=<%=vi %>&view=<%=view %>';
                       for (i = 0; i < document.getElementsByName("interfacesContainer").length; i++) {
                               var sourceInterfaceName = "sourceinterface" + i;
                               var targetInterfaceName = "targetinterface" + i;
                               action += '&sourceInterface' + i + '=' + document.getElementsByName(sourceInterfaceName)[0].value;
                               action += '&targetInterface' + i + '=' + document.getElementsByName(targetInterfaceName)[0].value;
                       }
                       action += '&interfacesnum=' + i;
                       window.document.RouterRecoveryForm.action = action;
                       window.document.RouterRecoveryForm.submit();
               <% } %>
       } else {
               alert('<bean:message bundle="RouterRecoveryApplicationResources" key="all.source.router.interface.error"/>');
       }
}
</script>

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
               <bean:message bundle="InventoryResources" key="sources.heading"/>
       </table:cell>
       <table:cell>
               <bean:message bundle="InventoryResources" key="targets.heading"/>
       </table:cell>
</table:header>

<html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
<html:hidden property="terminationId" value="<%= TerminationId %>"/>
<html:hidden property="prevExecFail" value="<%= count %>"/>
<!-- Regions -->
<table:row>
       <table:cell>
               <bean:message bundle="RouterRecoveryApplicationResources" key="field.regions.alias"/>*
       </table:cell>
       <table:cell>
               <%= SourceRegion %>
       </table:cell>
       <table:cell>
               <logic:notEmpty name="RouterRecoveryBean" property="targetRegionOptions">
                       <html:select property="targetRegion" onchange="changeSelect(event)">
                               <html:optionsCollection name="RouterRecoveryBean" property="targetRegionOptions" />
                       </html:select>
               </logic:notEmpty>
               <logic:empty name="RouterRecoveryBean" property="targetRegionOptions">
                       <html:select property="targetRegion"></html:select>
               </logic:empty>
       </table:cell>
</table:row>
<!-- Networks -->
<table:row>
       <table:cell>
               <bean:message bundle="RouterRecoveryApplicationResources" key="field.networks.alias"/>*
       </table:cell>
       <table:cell>
               <%= SourceNetwork %>
       </table:cell>
       <table:cell>
               <logic:notEmpty name="RouterRecoveryBean" property="targetNetworkOptions">
                       <html:select property="targetNetwork" onchange="changeSelect(event)">
                               <html:optionsCollection name="RouterRecoveryBean" property="targetNetworkOptions" />
                       </html:select>
               </logic:notEmpty>
               <logic:empty name="RouterRecoveryBean" property="targetNetworkOptions">
                       <html:select property="targetNetwork"></html:select>
               </logic:empty>
       </table:cell>
</table:row>
<!-- Routers -->
<table:row>
       <table:cell>
               <bean:message bundle="RouterRecoveryApplicationResources" key="field.routers.alias"/>*
       </table:cell>
       <table:cell>
               <%= SourceNe %>
               <html:hidden property="sourceneid" value="<%= SourceNeId%>"/>
       </table:cell>
       <table:cell>
               <logic:notEmpty name="RouterRecoveryBean" property="targetPEOptions">
                       <html:select property="targetPE" onchange="changeSelect(event)">
                               <html:optionsCollection name="RouterRecoveryBean" property="targetPEOptions" />
                       </html:select>
               </logic:notEmpty>
               <logic:empty name="RouterRecoveryBean" property="targetPEOptions">
                       <html:select property="targetPE"></html:select>
               </logic:empty>
       </table:cell>
</table:row>
<%
       for (int i = 0; i < beanRouterRecovery.getSourceInterfaceOptions().size(); i++) {
%>
<!-- Interfaces and services -->
<div name="interfacesContainer">
<table:row>
       <table:cell>
               <bean:message bundle="RouterRecoveryApplicationResources" key="field.interfaces.alias"/>*
       </table:cell>
       <table:cell>
               <select onchange="changeSelect(event)" id="sourceinterface<%= i%>" name="sourceinterface<%= i%>" >
                       <option/>
                       <%
                       if (beanRouterRecovery.getTargetPE() != null && beanRouterRecovery.getSourceInterfaceOptions().get(i) != null) {
                               Set<String> set = beanRouterRecovery.getSourceInterfaceOptions().get(i).keySet();
                               for (String terminationPointId: set) {
                                       if (!(beanRouterRecovery.getSourceInterfaceOptions().get(i) == null || beanRouterRecovery.getSourceInterfaceOptions().get(i).get(terminationPointId) == null)) {
                                               String selected = (beanRouterRecovery.getSourceInterfaceOptions().get(i).get(terminationPointId).isSelected() == true) ? " selected": "";
                       %>
                                               <option <%=selected %> value="<%=terminationPointId %>"><%= beanRouterRecovery.getSourceInterfaceOptions().get(i).get(terminationPointId).getName() %></option>
                       <%
                                       }
                               }
                       }
                       %>
               </select>
               </div>
       </table:cell>
       <table:cell>
               <select onchange="changeSelect(event)" id="targetinterface<%= i%>" name="targetinterface<%= i%>" >
                       <option/>
                       <%
                       if (beanRouterRecovery.getTargetPE() != null && beanRouterRecovery.getTargetInterfaceOptions().get(i) != null) {
                               Set<String> set = beanRouterRecovery.getTargetInterfaceOptions().get(i).keySet();
                               for (String terminationPointId: set) {
                                       if (!(beanRouterRecovery.getTargetInterfaceOptions().get(i) == null || beanRouterRecovery.getTargetInterfaceOptions().get(i).get(terminationPointId) == null)) {
                                               String selected = (beanRouterRecovery.getTargetInterfaceOptions().get(i).get(terminationPointId).isSelected() == true) ? " selected": "";
                       %>
                                               <option <%=selected %> value="<%=terminationPointId %>"><%= beanRouterRecovery.getTargetInterfaceOptions().get(i).get(terminationPointId).getName() %></option>
                       <%
                                       }
                               }
                       }
                       %>
               </select>
       </table:cell>
</table:row>
</div>
<%
       }
%>
<!-- buttons -->
<table:row>
       <table:cell>
       </table:cell>
       <table:cell>
         <input type="button" value="<bean:message bundle="InventoryResources" key="confirm.add_button.label"/>" onclick="addInterfaceRow();">&nbsp;
         <input type="button" value="<bean:message bundle="InventoryResources" key="confirm.del_button.label"/>" onclick="delInterfaceRow();">
       </table:cell>
       <table:cell>
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
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
<script>
var alertMsg = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
alertMsg.setBounds(400, 120);
alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
alertMsg.show();
performResetInterfaces();
</script>
<%
}
%>

</html>
