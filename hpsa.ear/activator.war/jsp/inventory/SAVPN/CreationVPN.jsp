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
String datasource = (String) request.getParameter(VPNConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitVPNAction.do?datasource=" + datasource + "&rimid=" + rimid;
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
    <title><bean:message bundle="VPNApplicationResources" key="<%= VPNConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.VPNForm.action = '/activator<%=moduleConfig%>/CreationFormVPNAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.VPNForm.submit();
    }
    function performCommit()
    {
      window.document.VPNForm.action = '/activator<%=moduleConfig%>/CreationCommitVPNAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.VPNForm.submit();
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

com.hp.ov.activator.vpn.inventory.VPN beanVPN = (com.hp.ov.activator.vpn.inventory.VPN) request.getAttribute(VPNConstants.VPN_BEAN);

      String ServiceId = beanVPN.getServiceid();
                String CustomerId = beanVPN.getCustomerid();
                String Customer = beanVPN.getCustomer();
                String ContactPerson = beanVPN.getContactperson();
                String ServiceName = beanVPN.getServicename();
                String Name = beanVPN.getName();
                String InitiationDate = beanVPN.getInitiationdate();
                String ActivationDate = beanVPN.getActivationdate();
                String ModificationDate = beanVPN.getModificationdate();
                String State = beanVPN.getState();
                String Type = beanVPN.getType();
                String QoSProfile_PE = beanVPN.getQosprofile_pe();
                String QoSProfile_CE = beanVPN.getQosprofile_ce();
                String VPNTopologyType = beanVPN.getVpntopologytype();
                String Comments = beanVPN.getComments();
            
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="VPNApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="VPNApplicationResources" property="ServiceId"/>
        <html:errors bundle="VPNApplicationResources" property="CustomerId"/>
        <html:errors bundle="VPNApplicationResources" property="Customer"/>
        <html:errors bundle="VPNApplicationResources" property="ContactPerson"/>
        <html:errors bundle="VPNApplicationResources" property="ServiceName"/>
        <html:errors bundle="VPNApplicationResources" property="Name"/>
        <html:errors bundle="VPNApplicationResources" property="InitiationDate"/>
        <html:errors bundle="VPNApplicationResources" property="ActivationDate"/>
        <html:errors bundle="VPNApplicationResources" property="ModificationDate"/>
        <html:errors bundle="VPNApplicationResources" property="State"/>
        <html:errors bundle="VPNApplicationResources" property="Type"/>
        <html:errors bundle="VPNApplicationResources" property="QoSProfile_PE"/>
        <html:errors bundle="VPNApplicationResources" property="QoSProfile_CE"/>
        <html:errors bundle="VPNApplicationResources" property="VPNTopologyType"/>
        <html:errors bundle="VPNApplicationResources" property="Comments"/>
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
    allEvents = allEvents + "checkShowRulesVPNTopologyType();";//default invoked when loading HTML
    function checkShowRulesVPNTopologyType(){
          var TypePass = false;
      
              if (/^L3VPN$/.test(document.getElementsByName("type")[0].value)) {TypePass = true;}
                        
      

    var controlTr = document.getElementsByName("vpntopologytype")[0];
    
          if (true && TypePass ){
    
            
          
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
      }else{
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('type')[0],'keyup',checkShowRulesVPNTopologyType);";
   </script>   
    <script>
function doOnLoad()
{
  // hide field
                                                                    document.getElementsByName("modificationdate")[0].parentNode.parentNode.style.display="none";
                                                      document.getElementsByName("vpntopologytype")[0].parentNode.parentNode.style.display="none";
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
                <bean:message bundle="VPNApplicationResources" key="field.serviceid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="serviceid" size="24" value="<%= ServiceId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VPNApplicationResources" key="field.serviceid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="VPNApplicationResources" key="field.customerid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="customerid" size="24" value="<%= CustomerId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VPNApplicationResources" key="field.customerid.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="customer" value="<%= Customer %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="VPNApplicationResources" key="field.contactperson.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="contactperson" size="24" value="<%= ContactPerson %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VPNApplicationResources" key="field.contactperson.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="VPNApplicationResources" key="field.servicename.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="servicename" size="24" value="<%= ServiceName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VPNApplicationResources" key="field.servicename.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="name" value="<%= Name %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="VPNApplicationResources" key="field.initiationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="initiationdate" size="24" value="<%= InitiationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VPNApplicationResources" key="field.initiationdate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="VPNApplicationResources" key="field.activationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="activationdate" size="24" value="<%= ActivationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VPNApplicationResources" key="field.activationdate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="VPNApplicationResources" key="field.modificationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="modificationdate" size="24" value="<%= ModificationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VPNApplicationResources" key="field.modificationdate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="VPNApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="state" size="24" value="<%= State %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VPNApplicationResources" key="field.state.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="VPNApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="type" size="24" value="<%= Type %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VPNApplicationResources" key="field.type.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="VPNApplicationResources" key="field.qosprofile_pe.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="qosprofile_pe" size="24" value="<%= QoSProfile_PE %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VPNApplicationResources" key="field.qosprofile_pe.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="qosprofile_ce" value="<%= QoSProfile_CE %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="VPNApplicationResources" key="field.vpntopologytype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vpntopologytype" size="24" value="<%= VPNTopologyType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VPNApplicationResources" key="field.vpntopologytype.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="VPNApplicationResources" key="field.comments.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="comments" size="24" value="<%= Comments %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="VPNApplicationResources" key="field.comments.description"/>
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
