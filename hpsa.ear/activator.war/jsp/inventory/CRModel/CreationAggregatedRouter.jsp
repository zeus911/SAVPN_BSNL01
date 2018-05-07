<!------------------------------------------------------------------------
   hp OpenView service activator
   (c) Copyright 2003-2009 Hewlett-Packard Development Company, L.P.
------------------------------------------------------------------------->

<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
com.hp.ov.activator.cr.inventory.*,
com.hp.ov.activator.inventory.CRModel.*,
org.apache.struts.util.LabelValueBean,
org.apache.struts.action.Action,
org.apache.struts.action.ActionErrors,
java.text.NumberFormat,
com.hp.ov.activator.inventory.facilities.StringFacility" %>

<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@ taglib uri="/WEB-INF/table-taglib.tld" prefix="table" %>
<%@ taglib uri="/WEB-INF/button-taglib.tld" prefix="btn" %>


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
String datasource = (String) request.getParameter(AggregatedRouterConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String location = (String) request.getParameter("_location_");
String refreshTreeRimid = (String) request.getParameter("refreshTreeRimid");  //richa - 14525
String formAction = "/CreationCommitAggregatedRouterAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
exceptionMessage="";
}
if ( location == null ) {
location = "routerid";
}
%>



<html>
<head>
<title><bean:message bundle="AggregatedRouterResources" key="<%= AggregatedRouterConstants.JSP_CREATION_TITLE %>"/></title>
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

com.hp.ov.activator.inventory.CRModel.AggregatedRouterHelperBean beanAggregatedRouter = (com.hp.ov.activator.inventory.CRModel.AggregatedRouterHelperBean)request.getAttribute(AggregatedRouterConstants.AGGREGATEDROUTER_BEAN);
String RouterId = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getRouterid());
String ParentIf = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getParentif());
String RouterName = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getRoutername());
String InterfaceName = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getInterfacename());
String BundleType = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getBundletype());
String SubType = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getSubtype());
String KeyMask = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getKeymask());
String BundleMask = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getBundlemask());
String KEY_INDEX = "" + beanAggregatedRouter.getKey_index();
KEY_INDEX = (KEY_INDEX != null && !(KEY_INDEX.trim().equals(""))) ? nfA.format(beanAggregatedRouter.getKey_index()) : "";
String IfType = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getIftype());
String InterfaceMask = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getInterfacemask());
String BundleInterface = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getBundleinterface());
String BundleKey = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getBundlekey());
String BundleId = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getBundleid());
String InterfaceMaskPattern = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getInterfacemaskpattern());
List<String> SelectedInterface = beanAggregatedRouter.getSelectedinterface();
session.setAttribute(AggregatedRouterConstants.INTERFACE,SelectedInterface);
String Interfacelist  = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getInterfacelist());

String picMask = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getPicmask());
String picPattern = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getPicpattern());
String initialPic = StringFacility.replaceAllByHTMLCharacter(beanAggregatedRouter.getInitialpic());
%>

<script>


function performCommit() {
window.document.AggregatedRouterForm.action = '/activator<%=moduleConfig%>/CreationCommitAggregatedRouterAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
window.document.AggregatedRouterForm.submit();
}


function changeType()
{
    window.document.AggregatedRouterForm.action = '/activator<%=moduleConfig%>/CreationFormAggregatedRouterAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&refreshTreeRimid=<%=refreshTreeRimid%>&change=true';
    window.document.AggregatedRouterForm.submit();
    }

    function interfaceAdd()
{
    window.document.AggregatedRouterForm.action = '/activator<%=moduleConfig%>/CreationFormAggregatedRouterAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
    window.document.AggregatedRouterForm.submit();
}
</script>
<center> 
  <h2>
    <bean:message bundle="AggregatedRouterResources" key="jsp.creation.title"/>
  </h2> 
</center>


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


<html:hidden  property="routerid" value="<%= RouterId %>"/>
<html:hidden  property="parentif" value="<%= ParentIf %>"/>
<html:hidden  property="routername" value="<%= RouterName %>"/>
<html:hidden  property="subtype" value="<%= SubType %>"/>
<html:hidden  property="bundleid" value="<%= BundleId %>"/>
<html:hidden  property="bundlekey" value="<%= BundleKey %>"/>
<html:hidden  property="bundleinterface" value="<%= BundleInterface%>"/>
<html:hidden  property="iftype" value="<%= IfType%>"/>

<html:hidden  property="picmask" value="<%= picMask%>"/>
<html:hidden  property="picpattern" value="<%= picPattern%>"/>
<html:hidden  property="initialpic" value="<%= initialPic%>"/>



<table:row>
<table:cell>    
<bean:message bundle="AggregatedRouterResources" key="field.routername.alias"/></table:cell>
<table:cell>
<html:text disabled="true"  property="routername" size="24" value="<%= RouterName %>"/>
</table:cell>
<table:cell>
<bean:message bundle="AggregatedRouterResources" key="field.routername.description"/></table:cell>
</table:row>


<table:row>
<table:cell>    
<bean:message bundle="AggregatedRouterResources" key="field.bundletype.alias"/></table:cell>
<table:cell>
<html:select  property="bundletype" onchange="changeType()" >
<html:option value="<%= AggregatedRouterConstants.ETHERNET %>" ><%= AggregatedRouterConstants.ETHERNET %></html:option>
<html:option value="<%= AggregatedRouterConstants.PPP %>" ><%= AggregatedRouterConstants.PPP %></html:option>
<html:option value="<%= AggregatedRouterConstants.FRAMERELAY %>" ><%= AggregatedRouterConstants.FRAMERELAY %></html:option>
</html:select>
</table:cell>
<table:cell>
<bean:message bundle="AggregatedRouterResources" key="field.bundletype.description"/>

</table:cell>
</table:row>




<table:row>
<table:cell>    
    <bean:message bundle="AggregatedRouterResources" key="field.interfacename.alias"/>
</table:cell>

<logic:equal name="AggregatedRouterHelper" property="interfacesize" value="0">
<table:cell>
<bean:message bundle="AggregatedRouterResources" key="field.interfacemessage.alias"/>
</table:cell>
</logic:equal>

<logic:greaterThan name="AggregatedRouterHelper" property="interfacesize" value="0">
<table:cell>
<html:select  property="interfacelist" value="<%= Interfacelist%>">
<html:optionsCollection name="AggregatedRouterHelper" property="interfacearray"/>
</html:select>
<input type="button" value="<bean:message bundle="AggregatedRouterResources" key="confirm.add_button.label"/>" name="enviando" class="ButtonSubmit" onclick="javascript:interfaceAdd();">&nbsp;
</table:cell>
</logic:greaterThan>

<table:cell>
<bean:message bundle="AggregatedRouterResources" key="field.interfacename.description"/>
</table:cell>
</table:row>


<table:row>
<table:cell>    
<bean:message bundle="AggregatedRouterResources" key="field.selectedinterface.alias"/></table:cell>
<table:cell>
<logic:iterate id="selectedinterface" name="AggregatedRouterHelper" property="selectedinterface"> 
<bean:write name="selectedinterface"/>
</logic:iterate> 
</table:cell>
<table:cell>
<bean:message bundle="AggregatedRouterResources" key="field.selectedinterface.description"/></table:cell>
</table:row>




<table:row>
<table:cell>    
<bean:message bundle="AggregatedRouterResources" key="field.interface.alias"/>

</table:cell>
<table:cell>
<%= BundleInterface %>
</table:cell>
<table:cell>
<bean:message bundle="AggregatedRouterResources" key="field.interface.description"/>
</table:cell>
</table:row>




<table:row>
<table:cell colspan="3" align="center">
<br>
</table:cell>
</table:row>


<table:row>
<table:cell colspan="3" align="center">
<input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
<input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
</table:cell>
</table:row>

</table:table>
</center>
</html:form>

</body>
<%
if ( location != null ) {
%>


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
