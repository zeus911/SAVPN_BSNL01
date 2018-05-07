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
String datasource = (String) request.getParameter(Sh_L3AccessFlowConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitSh_L3AccessFlowAction.do?datasource=" + datasource + "&rimid=" + rimid;
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
    <title><bean:message bundle="Sh_L3AccessFlowApplicationResources" key="<%= Sh_L3AccessFlowConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.Sh_L3AccessFlowForm.action = '/activator<%=moduleConfig%>/CreationFormSh_L3AccessFlowAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.Sh_L3AccessFlowForm.submit();
    }
    function performCommit()
    {
      window.document.Sh_L3AccessFlowForm.action = '/activator<%=moduleConfig%>/CreationCommitSh_L3AccessFlowAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.Sh_L3AccessFlowForm.submit();
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

com.hp.ov.activator.vpn.inventory.Sh_L3AccessFlow beanSh_L3AccessFlow = (com.hp.ov.activator.vpn.inventory.Sh_L3AccessFlow) request.getAttribute(Sh_L3AccessFlowConstants.SH_L3ACCESSFLOW_BEAN);

      String ServiceId = beanSh_L3AccessFlow.getServiceid();
                String CustomerId = beanSh_L3AccessFlow.getCustomerid();
                String ServiceName = beanSh_L3AccessFlow.getServicename();
                String InitiationDate = beanSh_L3AccessFlow.getInitiationdate();
                String ActivationDate = beanSh_L3AccessFlow.getActivationdate();
                String ModificationDate = beanSh_L3AccessFlow.getModificationdate();
                String State = beanSh_L3AccessFlow.getState();
                String Type = beanSh_L3AccessFlow.getType();
                String ContactPerson = beanSh_L3AccessFlow.getContactperson();
                String Comments = beanSh_L3AccessFlow.getComments();
                String Marker = beanSh_L3AccessFlow.getMarker();
                String UploadStatus = beanSh_L3AccessFlow.getUploadstatus();
                String DBPrimaryKey = beanSh_L3AccessFlow.getDbprimarykey();
                  String SiteId = beanSh_L3AccessFlow.getSiteid();
                String VlanId = beanSh_L3AccessFlow.getVlanid();
                String PE_Status = beanSh_L3AccessFlow.getPe_status();
                String CE_Status = beanSh_L3AccessFlow.getCe_status();
                String AccessNW_Status = beanSh_L3AccessFlow.getAccessnw_status();
                String IPNet = beanSh_L3AccessFlow.getIpnet();
                String Netmask = beanSh_L3AccessFlow.getNetmask();
                String Domain_id = beanSh_L3AccessFlow.getDomain_id();
                String MDTData = beanSh_L3AccessFlow.getMdtdata();
                String LoopAddr = beanSh_L3AccessFlow.getLoopaddr();
                String RP = beanSh_L3AccessFlow.getRp();
                boolean CE_based_QoS = new Boolean(beanSh_L3AccessFlow.getCe_based_qos()).booleanValue();
                String AddressFamily = beanSh_L3AccessFlow.getAddressfamily();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="ServiceId"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="CustomerId"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="ServiceName"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="InitiationDate"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="ActivationDate"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="ModificationDate"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="State"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="Type"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="ContactPerson"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="Comments"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="Marker"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="UploadStatus"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="DBPrimaryKey"/>
          <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="SiteId"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="VlanId"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="PE_Status"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="CE_Status"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="AccessNW_Status"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="IPNet"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="Netmask"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="Domain_id"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="MDTData"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="LoopAddr"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="RP"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="CE_based_QoS"/>
        <html:errors bundle="Sh_L3AccessFlowApplicationResources" property="AddressFamily"/>
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
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.serviceid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="serviceid" size="24" value="<%= ServiceId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.serviceid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.customerid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="customerid" size="24" value="<%= CustomerId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.customerid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.servicename.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="servicename" size="24" value="<%= ServiceName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.servicename.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.initiationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="initiationdate" size="24" value="<%= InitiationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.initiationdate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.activationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="activationdate" size="24" value="<%= ActivationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.activationdate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.modificationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="modificationdate" size="24" value="<%= ModificationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.modificationdate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="state" size="24" value="<%= State %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.state.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="type" size="24" value="<%= Type %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.type.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.contactperson.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="contactperson" size="24" value="<%= ContactPerson %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.contactperson.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.comments.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="comments" size="24" value="<%= Comments %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.comments.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.marker.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="marker" size="24" value="<%= Marker %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.marker.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.uploadstatus.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="uploadstatus" size="24" value="<%= UploadStatus %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.uploadstatus.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.dbprimarykey.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dbprimarykey" size="24" value="<%= DBPrimaryKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.dbprimarykey.description"/>
                              </table:cell>
            </table:row>
                                                                    <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.siteid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="siteid" size="24" value="<%= SiteId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.siteid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.vlanid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vlanid" size="24" value="<%= VlanId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.vlanid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.pe_status.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(PE_Status==null||PE_Status.trim().equals("")) {
                          selValue="In Progress";
                        } else {
                          selValue=PE_Status.toString();
                        }    
                    %>

                    <html:select  property="pe_status" value="<%= selValue %>" >
                                            <html:option value="In Progress" >In Progress</html:option>
                                            <html:option value="Partial" >Partial</html:option>
                                            <html:option value="OK" >OK</html:option>
                                            <html:option value="Ignore" >Ignore</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.pe_status.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.ce_status.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(CE_Status==null||CE_Status.trim().equals("")) {
                          selValue="In Progress";
                        } else {
                          selValue=CE_Status.toString();
                        }    
                    %>

                    <html:select  property="ce_status" value="<%= selValue %>" >
                                            <html:option value="In Progress" >In Progress</html:option>
                                            <html:option value="Partial" >Partial</html:option>
                                            <html:option value="OK" >OK</html:option>
                                            <html:option value="Ignore" >Ignore</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.ce_status.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.accessnw_status.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(AccessNW_Status==null||AccessNW_Status.trim().equals("")) {
                          selValue="In Progress";
                        } else {
                          selValue=AccessNW_Status.toString();
                        }    
                    %>

                    <html:select  property="accessnw_status" value="<%= selValue %>" >
                                            <html:option value="In Progress" >In Progress</html:option>
                                            <html:option value="Partial" >Partial</html:option>
                                            <html:option value="OK" >OK</html:option>
                                            <html:option value="Ignore" >Ignore</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.accessnw_status.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.ipnet.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ipnet" size="24" value="<%= IPNet %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.ipnet.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.netmask.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="netmask" size="24" value="<%= Netmask %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.netmask.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.domain_id.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="domain_id" size="24" value="<%= Domain_id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.domain_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.mdtdata.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="mdtdata" size="24" value="<%= MDTData %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.mdtdata.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.loopaddr.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="loopaddr" size="24" value="<%= LoopAddr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.loopaddr.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.rp.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(RP==null||RP.trim().equals("")) {
                          selValue="yes";
                        } else {
                          selValue=RP.toString();
                        }    
                    %>

                    <html:select  property="rp" value="<%= selValue %>" >
                                            <html:option value="yes" >yes</html:option>
                                            <html:option value="no" >no</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.rp.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.ce_based_qos.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="ce_based_qos" value="true"/>
                  <html:hidden  property="ce_based_qos" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.ce_based_qos.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.addressfamily.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(AddressFamily==null||AddressFamily.trim().equals("")) {
                          selValue="IPv4";
                        } else {
                          selValue=AddressFamily.toString();
                        }    
                    %>

                    <html:select  property="addressfamily" value="<%= selValue %>" >
                                            <html:option value="IPv4" >IPv4</html:option>
                                            <html:option value="IPv6" >IPv6</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="Sh_L3AccessFlowApplicationResources" key="field.addressfamily.description"/>
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
