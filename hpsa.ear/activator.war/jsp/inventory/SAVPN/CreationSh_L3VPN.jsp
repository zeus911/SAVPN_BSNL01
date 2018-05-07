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
String datasource = (String) request.getParameter(Sh_L3VPNConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitSh_L3VPNAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "serviceid";
                                                                                                                        }
%>

<html>
  <head>
    <title><bean:message bundle="Sh_L3VPNApplicationResources" key="<%= Sh_L3VPNConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.Sh_L3VPNForm.action = '/activator<%=moduleConfig%>/CreationFormSh_L3VPNAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.Sh_L3VPNForm.submit();
    }
    function performCommit()
    {
      window.document.Sh_L3VPNForm.action = '/activator<%=moduleConfig%>/CreationCommitSh_L3VPNAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_L3VPNForm.submit();
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

com.hp.ov.activator.vpn.inventory.Sh_L3VPN beanSh_L3VPN = (com.hp.ov.activator.vpn.inventory.Sh_L3VPN) request.getAttribute(Sh_L3VPNConstants.SH_L3VPN_BEAN);

      String ServiceId = beanSh_L3VPN.getServiceid();
                String CustomerId = beanSh_L3VPN.getCustomerid();
                String ServiceName = beanSh_L3VPN.getServicename();
                String InitiationDate = beanSh_L3VPN.getInitiationdate();
                String ActivationDate = beanSh_L3VPN.getActivationdate();
                String ModificationDate = beanSh_L3VPN.getModificationdate();
                String State = beanSh_L3VPN.getState();
                String Type = beanSh_L3VPN.getType();
                String ContactPerson = beanSh_L3VPN.getContactperson();
                String Comments = beanSh_L3VPN.getComments();
                String Marker = beanSh_L3VPN.getMarker();
                String UploadStatus = beanSh_L3VPN.getUploadstatus();
                String DBPrimaryKey = beanSh_L3VPN.getDbprimarykey();
                  String VPNTopologyType = beanSh_L3VPN.getVpntopologytype();
                String QoSProfile_PE = beanSh_L3VPN.getQosprofile_pe();
                String QoSProfile_CE = beanSh_L3VPN.getQosprofile_ce();
                String ParentId = beanSh_L3VPN.getParentid();
                String Multicast = beanSh_L3VPN.getMulticast();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_L3VPNApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="Sh_L3VPNApplicationResources" property="ServiceId"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="CustomerId"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="ServiceName"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="InitiationDate"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="ActivationDate"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="ModificationDate"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="State"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="Type"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="ContactPerson"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="Comments"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="DBPrimaryKey"/>
          <html:errors bundle="Sh_L3VPNApplicationResources" property="VPNTopologyType"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="QoSProfile_PE"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="QoSProfile_CE"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="ParentId"/>
        <html:errors bundle="Sh_L3VPNApplicationResources" property="Multicast"/>
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
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.serviceid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="serviceid" size="24" value="<%= ServiceId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.serviceid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.customerid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="customerid" size="24" value="<%= CustomerId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.customerid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.servicename.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="servicename" size="24" value="<%= ServiceName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.servicename.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.initiationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="initiationdate" size="24" value="<%= InitiationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.initiationdate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.activationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="activationdate" size="24" value="<%= ActivationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.activationdate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.modificationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="modificationdate" size="24" value="<%= ModificationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.modificationdate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="state" size="24" value="<%= State %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.state.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="type" size="24" value="<%= Type %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.type.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.contactperson.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="contactperson" size="24" value="<%= ContactPerson %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.contactperson.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.comments.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="comments" size="24" value="<%= Comments %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.comments.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.marker.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="marker" size="24" value="<%= Marker %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.marker.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.uploadstatus.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="uploadstatus" size="24" value="<%= UploadStatus %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.uploadstatus.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.dbprimarykey.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dbprimarykey" size="24" value="<%= DBPrimaryKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.dbprimarykey.description"/>
                              </table:cell>
            </table:row>
                                                                    <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.vpntopologytype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vpntopologytype" size="24" value="<%= VPNTopologyType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.vpntopologytype.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.qosprofile_pe.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="qosprofile_pe" size="24" value="<%= QoSProfile_PE %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.qosprofile_pe.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.qosprofile_ce.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="qosprofile_ce" size="24" value="<%= QoSProfile_CE %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.qosprofile_ce.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.parentid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="parentid" size="24" value="<%= ParentId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.parentid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.multicast.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(Multicast==null||Multicast.trim().equals("")) {
                          selValue="unsupported";
                        } else {
                          selValue=Multicast.toString();
                        }    
                    %>

                    <html:select  property="multicast" value="<%= selValue %>" >
                                            <html:option value="unsupported" >unsupported</html:option>
                                            <html:option value="disabled" >disabled</html:option>
                                            <html:option value="enabled" >enabled</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3VPNApplicationResources" key="field.multicast.description"/>
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
