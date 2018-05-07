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
String datasource = (String) request.getParameter(L3AccessFlowConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitL3AccessFlowAction.do?datasource=" + datasource + "&rimid=" + rimid;
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
    <title><bean:message bundle="L3AccessFlowApplicationResources" key="<%= L3AccessFlowConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.L3AccessFlowForm.action = '/activator<%=moduleConfig%>/CreationFormL3AccessFlowAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.L3AccessFlowForm.submit();
    }
    function performCommit()
    {
      window.document.L3AccessFlowForm.action = '/activator<%=moduleConfig%>/CreationCommitL3AccessFlowAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.L3AccessFlowForm.submit();
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

com.hp.ov.activator.vpn.inventory.L3AccessFlow beanL3AccessFlow = (com.hp.ov.activator.vpn.inventory.L3AccessFlow) request.getAttribute(L3AccessFlowConstants.L3ACCESSFLOW_BEAN);

      String ServiceId = beanL3AccessFlow.getServiceid();
                String CustomerId = beanL3AccessFlow.getCustomerid();
                String Customer = beanL3AccessFlow.getCustomer();
                String ServiceName = beanL3AccessFlow.getServicename();
                String Name = beanL3AccessFlow.getName();
                String VPNName = beanL3AccessFlow.getVpnname();
                String InitiationDate = beanL3AccessFlow.getInitiationdate();
                String ActivationDate = beanL3AccessFlow.getActivationdate();
                String ModificationDate = beanL3AccessFlow.getModificationdate();
                String State = beanL3AccessFlow.getState();
                String Type = beanL3AccessFlow.getType();
                String AddressFamily = beanL3AccessFlow.getAddressfamily();
                String ContactPerson = beanL3AccessFlow.getContactperson();
                String Comments = beanL3AccessFlow.getComments();
                String SiteId = beanL3AccessFlow.getSiteid();
                String VlanId = beanL3AccessFlow.getVlanid();
                String PE_Status = beanL3AccessFlow.getPe_status();
                String CE_Status = beanL3AccessFlow.getCe_status();
                String AccessNW_Status = beanL3AccessFlow.getAccessnw_status();
                String ASBR_Status = beanL3AccessFlow.getAsbr_status();
                String IPNet = beanL3AccessFlow.getIpnet();
                String Netmask = beanL3AccessFlow.getNetmask();
                String SecondaryIPNet = beanL3AccessFlow.getSecondaryipnet();
                String SecondaryNetmask = beanL3AccessFlow.getSecondarynetmask();
                String Domain_id = beanL3AccessFlow.getDomain_id();
                String MDTData = beanL3AccessFlow.getMdtdata();
                String LoopAddr = beanL3AccessFlow.getLoopaddr();
                String RP = beanL3AccessFlow.getRp();
                boolean CE_based_QoS = new Boolean(beanL3AccessFlow.getCe_based_qos()).booleanValue();
            
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="L3AccessFlowApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="L3AccessFlowApplicationResources" property="ServiceId"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="CustomerId"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="Customer"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="ServiceName"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="Name"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="VPNName"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="InitiationDate"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="ActivationDate"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="ModificationDate"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="State"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="Type"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="AddressFamily"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="ContactPerson"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="Comments"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="SiteId"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="VlanId"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="PE_Status"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="CE_Status"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="AccessNW_Status"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="ASBR_Status"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="IPNet"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="Netmask"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="SecondaryIPNet"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="SecondaryNetmask"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="Domain_id"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="MDTData"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="LoopAddr"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="RP"/>
        <html:errors bundle="L3AccessFlowApplicationResources" property="CE_based_QoS"/>
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
    allEvents = allEvents + "checkShowRulesModificationDate();";//default invoked when loading HTML
    function checkShowRulesModificationDate(){
          var ModificationDatePass = false;
      
              if (/^[0-9]+.*$/.test(document.getElementsByName("modificationdate")[0].value)) {ModificationDatePass = true;}
                        
      

    var controlTr = document.getElementsByName("modificationdate")[0];
    
          if (true && ModificationDatePass ){
    
            
          
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
      }else{
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('modificationdate')[0],'keyup',checkShowRulesModificationDate);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesVlanId();";//default invoked when loading HTML
    function checkShowRulesVlanId(){
          var VlanIdPass = false;
      
              if (/^[1-9][0-9]*$/.test(document.getElementsByName("vlanid")[0].value)) {VlanIdPass = true;}
                        
      

    var controlTr = document.getElementsByName("vlanid")[0];
    
          if (true && VlanIdPass ){
    
            
          
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
      }else{
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('vlanid')[0],'keyup',checkShowRulesVlanId);";
   </script>   
    <script>
function doOnLoad()
{
  // hide field
                                                                    document.getElementsByName("modificationdate")[0].parentNode.parentNode.style.display="none";
                                                                  document.getElementsByName("vlanid")[0].parentNode.parentNode.style.display="none";
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
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.serviceid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="serviceid" size="24" value="<%= ServiceId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.serviceid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.customerid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="customerid" size="24" value="<%= CustomerId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.customerid.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="customer" value="<%= Customer %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.servicename.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="servicename" size="24" value="<%= ServiceName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.servicename.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="name" value="<%= Name %>"/>            
                                                                                <html:hidden property="vpnname" value="<%= VPNName %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.initiationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="initiationdate" size="24" value="<%= InitiationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.initiationdate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.activationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="activationdate" size="24" value="<%= ActivationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.activationdate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.modificationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="modificationdate" size="24" value="<%= ModificationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.modificationdate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="state" size="24" value="<%= State %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.state.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="type" size="24" value="<%= Type %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.type.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.addressfamily.alias"/>
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
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.addressfamily.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.contactperson.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="contactperson" value="<%= ContactPerson %>"/>
                                                        <html:text disabled="true" property="contactperson" size="24" value="<%= ContactPerson %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.contactperson.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.comments.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="comments" size="24" value="<%= Comments %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.comments.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.siteid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="siteid" value="<%= SiteId %>"/>
                                                        <html:text disabled="true" property="siteid" size="24" value="<%= SiteId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.siteid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.vlanid.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="vlanid" value="<%= VlanId %>"/>
                                                        <html:text disabled="true" property="vlanid" size="24" value="<%= VlanId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.vlanid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.pe_status.alias"/>
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
                                            <html:option value="Failure" >Failure</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.pe_status.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.ce_status.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="ce_status" value="<%= CE_Status %>"/>
                                                        <%                        
                        String selValue=null;                                    
                        if(CE_Status==null||CE_Status.trim().equals("")) {
                          selValue="In Progress";
                        } else {
                          selValue=CE_Status.toString();
                        }    
                    %>

                    <html:select disabled="true" property="ce_status" value="<%= selValue %>" >
                                            <html:option value="In Progress" >In Progress</html:option>
                                            <html:option value="Partial" >Partial</html:option>
                                            <html:option value="OK" >OK</html:option>
                                            <html:option value="Ignore" >Ignore</html:option>
                                            <html:option value="Failure" >Failure</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.ce_status.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.accessnw_status.alias"/>
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
                                            <html:option value="Failure" >Failure</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.accessnw_status.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.asbr_status.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="asbr_status" value="<%= ASBR_Status %>"/>
                                                        <%                        
                        String selValue=null;                                    
                        if(ASBR_Status==null||ASBR_Status.trim().equals("")) {
                          selValue="In Progress";
                        } else {
                          selValue=ASBR_Status.toString();
                        }    
                    %>

                    <html:select disabled="true" property="asbr_status" value="<%= selValue %>" >
                                            <html:option value="In Progress" >In Progress</html:option>
                                            <html:option value="Partial" >Partial</html:option>
                                            <html:option value="OK" >OK</html:option>
                                            <html:option value="Ignore" >Ignore</html:option>
                                            <html:option value="Failure" >Failure</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.asbr_status.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.ipnet.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ipnet" size="24" value="<%= IPNet %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.ipnet.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.netmask.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="netmask" size="24" value="<%= Netmask %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.netmask.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.secondaryipnet.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="secondaryipnet" size="24" value="<%= SecondaryIPNet %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.secondaryipnet.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.secondarynetmask.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="secondarynetmask" size="24" value="<%= SecondaryNetmask %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.secondarynetmask.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.domain_id.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="domain_id" size="24" value="<%= Domain_id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.domain_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.mdtdata.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="mdtdata" size="24" value="<%= MDTData %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.mdtdata.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.loopaddr.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="loopaddr" size="24" value="<%= LoopAddr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.loopaddr.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.rp.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(RP==null||RP.trim().equals("")) {
                          selValue="no";
                        } else {
                          selValue=RP.toString();
                        }    
                    %>

                    <html:select  property="rp" value="<%= selValue %>" >
                                            <html:option value="no" >no</html:option>
                                            <html:option value="yes" >yes</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.rp.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.ce_based_qos.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="ce_based_qos" value="true"/>
                  <html:hidden  property="ce_based_qos" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="L3AccessFlowApplicationResources" key="field.ce_based_qos.description"/>
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
