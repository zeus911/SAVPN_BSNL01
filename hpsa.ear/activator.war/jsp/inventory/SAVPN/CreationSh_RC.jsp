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
String datasource = (String) request.getParameter(Sh_RCConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitSh_RCAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "rcname";
                                                      }
%>

<html>
  <head>
    <title><bean:message bundle="Sh_RCApplicationResources" key="<%= Sh_RCConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.Sh_RCForm.action = '/activator<%=moduleConfig%>/CreationFormSh_RCAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.Sh_RCForm.submit();
    }
    function performCommit()
    {
      window.document.Sh_RCForm.action = '/activator<%=moduleConfig%>/CreationCommitSh_RCAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_RCForm.submit();
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

com.hp.ov.activator.vpn.inventory.Sh_RC beanSh_RC = (com.hp.ov.activator.vpn.inventory.Sh_RC) request.getAttribute(Sh_RCConstants.SH_RC_BEAN);

      String RCName = beanSh_RC.getRcname();
                String L3VPNId = beanSh_RC.getL3vpnid();
                String RTExport = beanSh_RC.getRtexport();
                String RTImport = beanSh_RC.getRtimport();
                String Type = beanSh_RC.getType();
                String Marker = beanSh_RC.getMarker();
                String UploadStatus = beanSh_RC.getUploadstatus();
                String DBPrimaryKey = beanSh_RC.getDbprimarykey();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_RCApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="Sh_RCApplicationResources" property="RCName"/>
        <html:errors bundle="Sh_RCApplicationResources" property="L3VPNId"/>
        <html:errors bundle="Sh_RCApplicationResources" property="RTExport"/>
        <html:errors bundle="Sh_RCApplicationResources" property="RTImport"/>
        <html:errors bundle="Sh_RCApplicationResources" property="Type"/>
        <html:errors bundle="Sh_RCApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_RCApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_RCApplicationResources" property="DBPrimaryKey"/>
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
                <bean:message bundle="Sh_RCApplicationResources" key="field.rcname.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rcname" size="24" value="<%= RCName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_RCApplicationResources" key="field.rcname.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_RCApplicationResources" key="field.l3vpnid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="l3vpnid" size="24" value="<%= L3VPNId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_RCApplicationResources" key="field.l3vpnid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_RCApplicationResources" key="field.rtexport.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rtexport" size="24" value="<%= RTExport %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_RCApplicationResources" key="field.rtexport.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_RCApplicationResources" key="field.rtimport.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rtimport" size="24" value="<%= RTImport %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_RCApplicationResources" key="field.rtimport.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_RCApplicationResources" key="field.type.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(Type==null||Type.trim().equals("")) {
                          selValue="mesh";
                        } else {
                          selValue=Type.toString();
                        }    
                    %>

                    <html:select  property="type" value="<%= selValue %>" >
                                            <html:option value="mesh" >mesh</html:option>
                                            <html:option value="hub" >hub</html:option>
                                            <html:option value="spoke" >spoke</html:option>
                                            <html:option value="multicast" >multicast</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_RCApplicationResources" key="field.type.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_RCApplicationResources" key="field.marker.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="marker" size="24" value="<%= Marker %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_RCApplicationResources" key="field.marker.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_RCApplicationResources" key="field.uploadstatus.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="uploadstatus" size="24" value="<%= UploadStatus %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_RCApplicationResources" key="field.uploadstatus.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_RCApplicationResources" key="field.dbprimarykey.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dbprimarykey" size="24" value="<%= DBPrimaryKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_RCApplicationResources" key="field.dbprimarykey.description"/>
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
