<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors,
        com.hp.ov.activator.inventory.facilities.StringFacility " %>

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
String datasource = (String) request.getParameter(L3VPNMembershipConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitL3VPNMembershipAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "customername";
                                                            }
%>

<html>
  <head>
    <title><bean:message bundle="L3VPNMembershipApplicationResources" key="<%= L3VPNMembershipConstants.JSP_CREATION_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
      H1 { color: red; font-size: 13px }
    </style>
    <script>
    function sendthis(focusthis)
    {
      window.document.L3VPNMembershipForm.action = '/activator<%=moduleConfig%>/CreationFormL3VPNMembershipAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.L3VPNMembershipForm.submit();
    }
    function performCommit()
    {
      window.document.L3VPNMembershipForm.action = '/activator<%=moduleConfig%>/CreationCommitL3VPNMembershipAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.L3VPNMembershipForm.submit();
    }
    function init()
    {
<%
if ( _location_ != null ) {
%>
      var elems = document.getElementsByName("<%=_location_%>");
      var elem = elems == null || elems.length == 0 ? null : elems[0];
      if (elem != null) {
        elem.focus();
      }
<%
}
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
      var alertMsg = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
      alertMsg.setBounds(400, 120);
      alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
      alertMsg.show();
<%
}
%>
    }
    </script>
  </head>
  <body style="overflow:auto;" onload="init();">
<%

com.hp.ov.activator.vpn.inventory.L3VPNMembership beanL3VPNMembership = (com.hp.ov.activator.vpn.inventory.L3VPNMembership) request.getAttribute(L3VPNMembershipConstants.L3VPNMEMBERSHIP_BEAN);

      String CustomerName = beanL3VPNMembership.getCustomername();
                String SiteName = beanL3VPNMembership.getSitename();
                String VPNName = beanL3VPNMembership.getVpnname();
                String JoinDate = beanL3VPNMembership.getJoindate();
                String VPNNameId = beanL3VPNMembership.getVpnnameid();
                String VPNId = beanL3VPNMembership.getVpnid();
                String ConnectivityType = beanL3VPNMembership.getConnectivitytype();
                String SiteNameId = beanL3VPNMembership.getSitenameid();
                String SiteId = beanL3VPNMembership.getSiteid();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="L3VPNMembershipApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="L3VPNMembershipApplicationResources" property="CustomerName"/>
        <html:errors bundle="L3VPNMembershipApplicationResources" property="SiteName"/>
        <html:errors bundle="L3VPNMembershipApplicationResources" property="VPNName"/>
        <html:errors bundle="L3VPNMembershipApplicationResources" property="JoinDate"/>
        <html:errors bundle="L3VPNMembershipApplicationResources" property="VPNNameId"/>
        <html:errors bundle="L3VPNMembershipApplicationResources" property="VPNId"/>
        <html:errors bundle="L3VPNMembershipApplicationResources" property="ConnectivityType"/>
        <html:errors bundle="L3VPNMembershipApplicationResources" property="SiteNameId"/>
        <html:errors bundle="L3VPNMembershipApplicationResources" property="SiteId"/>
  </h1>
<script>
var allEvents = "";
function addListener(element,eventName,functionName){
  if(element.addEventListener){
    element.addEventListener(eventName,functionName,false);
  } else {
    element.attachEvent("on" + eventName,functionName);
  }
}
</script>
<script>
function doOnLoad()
{
  // hide field
                                                          // check hiding rules
  eval(allEvents);
}
addListener(window, "load", doOnLoad);
</script>
<html:form action="<%= formAction %>" style="text-align:center;">
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
      
      <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
      
                                    <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNMembershipApplicationResources" key="field.customername.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="customername" size="24" value="<%= CustomerName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNMembershipApplicationResources" key="field.customername.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNMembershipApplicationResources" key="field.sitename.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="sitename" size="24" value="<%= SiteName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNMembershipApplicationResources" key="field.sitename.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNMembershipApplicationResources" key="field.vpnname.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vpnname" size="24" value="<%= VPNName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNMembershipApplicationResources" key="field.vpnname.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNMembershipApplicationResources" key="field.joindate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="joindate" size="24" value="<%= JoinDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNMembershipApplicationResources" key="field.joindate.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="vpnnameid" value="<%= VPNNameId %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNMembershipApplicationResources" key="field.vpnid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vpnid" size="24" value="<%= VPNId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNMembershipApplicationResources" key="field.vpnid.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="connectivitytype" value="<%= ConnectivityType %>"/>            
                                                                                <html:hidden property="sitenameid" value="<%= SiteNameId %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="L3VPNMembershipApplicationResources" key="field.siteid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="siteid" size="24" value="<%= SiteId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3VPNMembershipApplicationResources" key="field.siteid.description"/>
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
  </html:form>

  </body>

</html>
