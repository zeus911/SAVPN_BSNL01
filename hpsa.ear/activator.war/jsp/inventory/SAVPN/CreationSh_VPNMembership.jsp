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
String datasource = (String) request.getParameter(Sh_VPNMembershipConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitSh_VPNMembershipAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "vpnid";
                                                }
%>

<html>
  <head>
    <title><bean:message bundle="Sh_VPNMembershipApplicationResources" key="<%= Sh_VPNMembershipConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.Sh_VPNMembershipForm.action = '/activator<%=moduleConfig%>/CreationFormSh_VPNMembershipAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.Sh_VPNMembershipForm.submit();
    }
    function performCommit()
    {
      window.document.Sh_VPNMembershipForm.action = '/activator<%=moduleConfig%>/CreationCommitSh_VPNMembershipAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_VPNMembershipForm.submit();
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

com.hp.ov.activator.vpn.inventory.Sh_VPNMembership beanSh_VPNMembership = (com.hp.ov.activator.vpn.inventory.Sh_VPNMembership) request.getAttribute(Sh_VPNMembershipConstants.SH_VPNMEMBERSHIP_BEAN);

      String VPNId = beanSh_VPNMembership.getVpnid();
                String SiteId = beanSh_VPNMembership.getSiteid();
                String SiteName = beanSh_VPNMembership.getSitename();
                String VPNName = beanSh_VPNMembership.getVpnname();
                String Marker = beanSh_VPNMembership.getMarker();
                String UploadStatus = beanSh_VPNMembership.getUploadstatus();
                String DBPrimaryKey = beanSh_VPNMembership.getDbprimarykey();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_VPNMembershipApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="Sh_VPNMembershipApplicationResources" property="VPNId"/>
        <html:errors bundle="Sh_VPNMembershipApplicationResources" property="SiteId"/>
        <html:errors bundle="Sh_VPNMembershipApplicationResources" property="SiteName"/>
        <html:errors bundle="Sh_VPNMembershipApplicationResources" property="VPNName"/>
        <html:errors bundle="Sh_VPNMembershipApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_VPNMembershipApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_VPNMembershipApplicationResources" property="DBPrimaryKey"/>
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
                <bean:message bundle="Sh_VPNMembershipApplicationResources" key="field.vpnid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vpnid" size="24" value="<%= VPNId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_VPNMembershipApplicationResources" key="field.vpnid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_VPNMembershipApplicationResources" key="field.siteid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="siteid" size="24" value="<%= SiteId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_VPNMembershipApplicationResources" key="field.siteid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_VPNMembershipApplicationResources" key="field.sitename.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="sitename" size="24" value="<%= SiteName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_VPNMembershipApplicationResources" key="field.sitename.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_VPNMembershipApplicationResources" key="field.vpnname.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vpnname" size="24" value="<%= VPNName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_VPNMembershipApplicationResources" key="field.vpnname.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_VPNMembershipApplicationResources" key="field.marker.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="marker" size="24" value="<%= Marker %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_VPNMembershipApplicationResources" key="field.marker.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_VPNMembershipApplicationResources" key="field.uploadstatus.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="uploadstatus" size="24" value="<%= UploadStatus %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_VPNMembershipApplicationResources" key="field.uploadstatus.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_VPNMembershipApplicationResources" key="field.dbprimarykey.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dbprimarykey" size="24" value="<%= DBPrimaryKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_VPNMembershipApplicationResources" key="field.dbprimarykey.description"/>
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
