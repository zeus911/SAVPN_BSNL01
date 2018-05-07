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
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(L2VPNConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitL2VPNAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("serviceid") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                                _location_ = "contactperson";
                                                                                                      }

%>

<html>
  <head>
    <title><bean:message bundle="L2VPNApplicationResources" key="<%= L2VPNConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.L2VPNForm.action = '/activator<%=moduleConfig%>/UpdateFormL2VPNAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.L2VPNForm.submit();
    }
    function performCommit()
    {
      window.document.L2VPNForm.action = '/activator<%=moduleConfig%>/UpdateCommitL2VPNAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.L2VPNForm.submit();
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
      var alert = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
      alert.setBounds(400, 120);
      alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
      alert.show();
<%
}
%>
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">

<%
com.hp.ov.activator.vpn.inventory.L2VPN beanL2VPN = (com.hp.ov.activator.vpn.inventory.L2VPN) request.getAttribute(L2VPNConstants.L2VPN_BEAN);
if(beanL2VPN==null)
   beanL2VPN = (com.hp.ov.activator.vpn.inventory.L2VPN) request.getSession().getAttribute(L2VPNConstants.L2VPN_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
L2VPNForm form = (L2VPNForm) request.getAttribute("L2VPNForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String ServiceId = beanL2VPN.getServiceid();
        
            
                            
            
                
                String CustomerId = beanL2VPN.getCustomerid();
        
            
                            
            
                
                String Customer = beanL2VPN.getCustomer();
        
            
                            
            
                
                String ContactPerson = beanL2VPN.getContactperson();
        
            
                            
            
                
                String ServiceName = beanL2VPN.getServicename();
        
            
                            
            
                
                String Name = beanL2VPN.getName();
        
            
                            
            
                
                String InitiationDate = beanL2VPN.getInitiationdate();
        
            
                            
            
                
                String ActivationDate = beanL2VPN.getActivationdate();
        
            
                            
            
                
                String ModificationDate = beanL2VPN.getModificationdate();
        
            
                            
            
                
                String State = beanL2VPN.getState();
        
            
                            
            
                
                String Type = beanL2VPN.getType();
        
            
                            
            
                
                String VPNTopologyType = beanL2VPN.getVpntopologytype();
        
            
                            
            
                
                String InterfaceType = beanL2VPN.getInterfacetype();
        
            
                            
            
                
                String VlanId = beanL2VPN.getVlanid();
        
            
                            
            
                
                String QoSProfile_PE = beanL2VPN.getQosprofile_pe();
        
            
                            
            
                
                String QoSProfile_CE = beanL2VPN.getQosprofile_ce();
        
            
                            
            
                
              boolean Fixed = new Boolean(beanL2VPN.getFixed()).booleanValue();
    
            
                            
            
                
                String Comments = beanL2VPN.getComments();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="L2VPNApplicationResources" key="jsp.update.title"/>
</h2> 

<H1>
      <html:errors bundle="L2VPNApplicationResources" property="ServiceId"/>
        <html:errors bundle="L2VPNApplicationResources" property="CustomerId"/>
        <html:errors bundle="L2VPNApplicationResources" property="Customer"/>
        <html:errors bundle="L2VPNApplicationResources" property="ContactPerson"/>
        <html:errors bundle="L2VPNApplicationResources" property="ServiceName"/>
        <html:errors bundle="L2VPNApplicationResources" property="Name"/>
        <html:errors bundle="L2VPNApplicationResources" property="InitiationDate"/>
        <html:errors bundle="L2VPNApplicationResources" property="ActivationDate"/>
        <html:errors bundle="L2VPNApplicationResources" property="ModificationDate"/>
        <html:errors bundle="L2VPNApplicationResources" property="State"/>
        <html:errors bundle="L2VPNApplicationResources" property="Type"/>
        <html:errors bundle="L2VPNApplicationResources" property="VPNTopologyType"/>
        <html:errors bundle="L2VPNApplicationResources" property="InterfaceType"/>
        <html:errors bundle="L2VPNApplicationResources" property="VlanId"/>
        <html:errors bundle="L2VPNApplicationResources" property="QoSProfile_PE"/>
        <html:errors bundle="L2VPNApplicationResources" property="QoSProfile_CE"/>
        <html:errors bundle="L2VPNApplicationResources" property="Fixed"/>
        <html:errors bundle="L2VPNApplicationResources" property="Comments"/>
    </H1>
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
          var ModificationDatePass = false ;
      if (/^[0-9]+.*$/.test(document.getElementsByName("modificationdate")[0].value)) {ModificationDatePass = true;}
            
    var controlTr = document.getElementsByName("modificationdate")[0];
          if (true && ModificationDatePass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('modificationdate')[0],'keyup',checkShowRulesModificationDate);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesVPNTopologyType();";//default invoked when loading HTML
    function checkShowRulesVPNTopologyType(){
          var TypePass = false ;
      if (/^L3VPN$/.test(document.getElementsByName("type")[0].value)) {TypePass = true;}
            
    var controlTr = document.getElementsByName("vpntopologytype")[0];
          if (true && TypePass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('type')[0],'keyup',checkShowRulesVPNTopologyType);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesVlanId();";//default invoked when loading HTML
    function checkShowRulesVlanId(){
          var VlanIdPass = false ;
      if (/^[1-9][0-9]*$/.test(document.getElementsByName("vlanid")[0].value)) {VlanIdPass = true;}
            
    var controlTr = document.getElementsByName("vlanid")[0];
          if (true && VlanIdPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('vlanid')[0],'keyup',checkShowRulesVlanId);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesFixed();";//default invoked when loading HTML
    function checkShowRulesFixed(){
          var InterfaceTypePass = false ;
      if (/^VPLS-PortVlan$/.test(document.getElementsByName("interfacetype")[0].value)) {InterfaceTypePass = true;}
            
    var controlTr = document.getElementsByName("fixed")[0];
          if (true && InterfaceTypePass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('interfacetype')[0],'keyup',checkShowRulesFixed);";
   </script>   
    <script>
function doOnLoad()
{
  // hide field
                                                                    document.getElementsByName("modificationdate")[0].parentNode.parentNode.style.display="none";
                                          document.getElementsByName("vpntopologytype")[0].parentNode.parentNode.style.display="none";
                                    document.getElementsByName("vlanid")[0].parentNode.parentNode.style.display="none";
                                          document.getElementsByName("fixed")[0].parentNode.parentNode.style.display="none";
                          // check hiding rules
  eval(allEvents);
}
addListener(window, "load", doOnLoad);
</script>
<html:form action="<%= formAction %>" style="text-align:center;">
<input type="hidden" name="_update_commit_" value="true"/> 
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
      
                                                  <html:hidden property="serviceid" value="<%= ServiceId %>"/>            
				                                            
                                                    <html:hidden property="customerid" value="<%= CustomerId %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VPNApplicationResources" key="field.customer.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="customer" value="<%= Customer %>"/>
                                                        <html:text disabled="true" property="customer" size="24" value="<%= Customer %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VPNApplicationResources" key="field.customer.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VPNApplicationResources" key="field.contactperson.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="contactperson" size="24" value="<%= ContactPerson %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VPNApplicationResources" key="field.contactperson.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="servicename" value="<%= ServiceName %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VPNApplicationResources" key="field.name.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="name" value="<%= Name %>"/>
                                                        <html:text disabled="true" property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VPNApplicationResources" key="field.name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VPNApplicationResources" key="field.initiationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="initiationdate" value="<%= InitiationDate %>"/>
                                                        <html:text disabled="true" property="initiationdate" size="24" value="<%= InitiationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VPNApplicationResources" key="field.initiationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VPNApplicationResources" key="field.activationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="activationdate" value="<%= ActivationDate %>"/>
                                                        <html:text disabled="true" property="activationdate" size="24" value="<%= ActivationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VPNApplicationResources" key="field.activationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VPNApplicationResources" key="field.modificationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="modificationdate" value="<%= ModificationDate %>"/>
                                                        <html:text disabled="true" property="modificationdate" size="24" value="<%= ModificationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VPNApplicationResources" key="field.modificationdate.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VPNApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="state" value="<%= State %>"/>
                                                        <html:text disabled="true" property="state" size="24" value="<%= State %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VPNApplicationResources" key="field.state.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VPNApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="type" value="<%= Type %>"/>
                                                        <html:text disabled="true" property="type" size="24" value="<%= Type %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VPNApplicationResources" key="field.type.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VPNApplicationResources" key="field.vpntopologytype.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="vpntopologytype" value="<%= VPNTopologyType %>"/>
                                                        <html:text disabled="true" property="vpntopologytype" size="24" value="<%= VPNTopologyType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VPNApplicationResources" key="field.vpntopologytype.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VPNApplicationResources" key="field.interfacetype.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="interfacetype" value="<%= InterfaceType %>"/>
                                                        <html:text disabled="true" property="interfacetype" size="24" value="<%= InterfaceType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VPNApplicationResources" key="field.interfacetype.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VPNApplicationResources" key="field.vlanid.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="vlanid" value="<%= VlanId %>"/>
                                                        <html:text disabled="true" property="vlanid" size="24" value="<%= VlanId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VPNApplicationResources" key="field.vlanid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VPNApplicationResources" key="field.qosprofile_pe.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="qosprofile_pe" value="<%= QoSProfile_PE %>"/>
                                                        <html:text disabled="true" property="qosprofile_pe" size="24" value="<%= QoSProfile_PE %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VPNApplicationResources" key="field.qosprofile_pe.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="qosprofile_ce" value="<%= QoSProfile_CE %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VPNApplicationResources" key="field.fixed.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                  <html:checkbox disabled="true" property="fixed" value="true"/>
                  <html:hidden disabled="true" property="fixed" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="L2VPNApplicationResources" key="field.fixed.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L2VPNApplicationResources" key="field.comments.alias"/>
                              </table:cell>
              <table:cell>
                <html:textarea property="comments" rows="5" cols="25" value="<%= Comments %>" />
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L2VPNApplicationResources" key="field.comments.description"/>
                                                                        </table:cell>
            </table:row>
                                
                        
                    
      <html:hidden property="__HASH_CODE" value="<%= __HASH_CODE %>"/>            
            
      
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
