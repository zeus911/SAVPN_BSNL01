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
String datasource = (String) request.getParameter(Sh_L3FlowPointConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitSh_L3FlowPointAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
              _location_ = "terminationpointid";
                                                                                                                                    }
%>

<html>
  <head>
    <title><bean:message bundle="Sh_L3FlowPointApplicationResources" key="<%= Sh_L3FlowPointConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.Sh_L3FlowPointForm.action = '/activator<%=moduleConfig%>/CreationFormSh_L3FlowPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.Sh_L3FlowPointForm.submit();
    }
    function performCommit()
    {
      window.document.Sh_L3FlowPointForm.action = '/activator<%=moduleConfig%>/CreationCommitSh_L3FlowPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_L3FlowPointForm.submit();
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

com.hp.ov.activator.vpn.inventory.Sh_L3FlowPoint beanSh_L3FlowPoint = (com.hp.ov.activator.vpn.inventory.Sh_L3FlowPoint) request.getAttribute(Sh_L3FlowPointConstants.SH_L3FLOWPOINT_BEAN);

      String TerminationPointID = beanSh_L3FlowPoint.getTerminationpointid();
                String AttachmentId = beanSh_L3FlowPoint.getAttachmentid();
                String QoSProfile_in = beanSh_L3FlowPoint.getQosprofile_in();
                String QoSProfile_out = beanSh_L3FlowPoint.getQosprofile_out();
                String RateLimit_in = beanSh_L3FlowPoint.getRatelimit_in();
                String RateLimit_out = beanSh_L3FlowPoint.getRatelimit_out();
                String Marker = beanSh_L3FlowPoint.getMarker();
                String UploadStatus = beanSh_L3FlowPoint.getUploadstatus();
                String DBPrimaryKey = beanSh_L3FlowPoint.getDbprimarykey();
                String Protocol = beanSh_L3FlowPoint.getProtocol();
                String Maximum_Prefix = "" + beanSh_L3FlowPoint.getMaximum_prefix();
      Maximum_Prefix = (Maximum_Prefix != null && !(Maximum_Prefix.trim().equals(""))) ? nfA.format(beanSh_L3FlowPoint.getMaximum_prefix()) : "";
                      String StaticRoutes = beanSh_L3FlowPoint.getStaticroutes();
                String OSPF_id = beanSh_L3FlowPoint.getOspf_id();
                String Rip_id = beanSh_L3FlowPoint.getRip_id();
                String VRFName = beanSh_L3FlowPoint.getVrfname();
                String PE_InterfaceIP = beanSh_L3FlowPoint.getPe_interfaceip();
                String CE_InterfaceIP = beanSh_L3FlowPoint.getCe_interfaceip();
                String mCAR = beanSh_L3FlowPoint.getMcar();
                String mCoS = beanSh_L3FlowPoint.getMcos();
                String LoopbackId = beanSh_L3FlowPoint.getLoopbackid();
                boolean SOO_Configured = new Boolean(beanSh_L3FlowPoint.getSoo_configured()).booleanValue();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_L3FlowPointApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="Sh_L3FlowPointApplicationResources" property="TerminationPointID"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="AttachmentId"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="QoSProfile_in"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="QoSProfile_out"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="RateLimit_in"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="RateLimit_out"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="DBPrimaryKey"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="Protocol"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="Maximum_Prefix"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="StaticRoutes"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="OSPF_id"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="Rip_id"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="VRFName"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="PE_InterfaceIP"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="CE_InterfaceIP"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="mCAR"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="mCoS"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="LoopbackId"/>
        <html:errors bundle="Sh_L3FlowPointApplicationResources" property="SOO_Configured"/>
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
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.terminationpointid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="terminationpointid" size="24" value="<%= TerminationPointID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.terminationpointid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.attachmentid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="attachmentid" size="24" value="<%= AttachmentId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.attachmentid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.qosprofile_in.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="qosprofile_in" size="24" value="<%= QoSProfile_in %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.qosprofile_in.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.qosprofile_out.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="qosprofile_out" size="24" value="<%= QoSProfile_out %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.qosprofile_out.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ratelimit_in.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ratelimit_in" size="24" value="<%= RateLimit_in %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ratelimit_in.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ratelimit_out.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ratelimit_out" size="24" value="<%= RateLimit_out %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ratelimit_out.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.marker.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="marker" size="24" value="<%= Marker %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.marker.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.uploadstatus.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="uploadstatus" size="24" value="<%= UploadStatus %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.uploadstatus.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.dbprimarykey.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dbprimarykey" size="24" value="<%= DBPrimaryKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.dbprimarykey.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.protocol.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="protocol" size="24" value="<%= Protocol %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.protocol.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.maximum_prefix.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="maximum_prefix" size="24" value="<%= Maximum_Prefix %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.maximum_prefix.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.staticroutes.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="staticroutes" size="24" value="<%= StaticRoutes %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.staticroutes.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ospf_id.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ospf_id" size="24" value="<%= OSPF_id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ospf_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.rip_id.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rip_id" size="24" value="<%= Rip_id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.rip_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.vrfname.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vrfname" size="24" value="<%= VRFName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.vrfname.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.pe_interfaceip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="pe_interfaceip" size="24" value="<%= PE_InterfaceIP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.pe_interfaceip.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ce_interfaceip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ce_interfaceip" size="24" value="<%= CE_InterfaceIP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.ce_interfaceip.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.mcar.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="mcar" size="24" value="<%= mCAR %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.mcar.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.mcos.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="mcos" size="24" value="<%= mCoS %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.mcos.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.loopbackid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="loopbackid" size="24" value="<%= LoopbackId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.loopbackid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.soo_configured.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="soo_configured" value="true"/>
                  <html:hidden  property="soo_configured" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3FlowPointApplicationResources" key="field.soo_configured.description"/>
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
