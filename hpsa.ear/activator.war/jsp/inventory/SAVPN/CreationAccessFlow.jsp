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
String datasource = (String) request.getParameter(AccessFlowConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitAccessFlowAction.do?datasource=" + datasource + "&rimid=" + rimid;
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
    <title><bean:message bundle="AccessFlowApplicationResources" key="<%= AccessFlowConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.AccessFlowForm.action = '/activator<%=moduleConfig%>/CreationFormAccessFlowAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.AccessFlowForm.submit();
    }
    function performCommit()
    {
      window.document.AccessFlowForm.action = '/activator<%=moduleConfig%>/CreationCommitAccessFlowAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.AccessFlowForm.submit();
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

com.hp.ov.activator.vpn.inventory.AccessFlow beanAccessFlow = (com.hp.ov.activator.vpn.inventory.AccessFlow) request.getAttribute(AccessFlowConstants.ACCESSFLOW_BEAN);

      String ServiceId = beanAccessFlow.getServiceid();
                String CustomerId = beanAccessFlow.getCustomerid();
                String Customer = beanAccessFlow.getCustomer();
                String ContactPerson = beanAccessFlow.getContactperson();
                String ServiceName = beanAccessFlow.getServicename();
                String InitiationDate = beanAccessFlow.getInitiationdate();
                String ActivationDate = beanAccessFlow.getActivationdate();
                String ModificationDate = beanAccessFlow.getModificationdate();
                String State = beanAccessFlow.getState();
                String Type = beanAccessFlow.getType();
                String Comments = beanAccessFlow.getComments();
                  String Name = beanAccessFlow.getName();
                String VPNName = beanAccessFlow.getVpnname();
                String SiteId = beanAccessFlow.getSiteid();
                String VlanId = beanAccessFlow.getVlanid();
                String PE_Status = beanAccessFlow.getPe_status();
                String CE_Status = beanAccessFlow.getCe_status();
                String AccessNW_Status = beanAccessFlow.getAccessnw_status();
                String ASBR_Status = beanAccessFlow.getAsbr_status();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="AccessFlowApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="AccessFlowApplicationResources" property="ServiceId"/>
        <html:errors bundle="AccessFlowApplicationResources" property="CustomerId"/>
        <html:errors bundle="AccessFlowApplicationResources" property="Customer"/>
        <html:errors bundle="AccessFlowApplicationResources" property="ContactPerson"/>
        <html:errors bundle="AccessFlowApplicationResources" property="ServiceName"/>
        <html:errors bundle="AccessFlowApplicationResources" property="InitiationDate"/>
        <html:errors bundle="AccessFlowApplicationResources" property="ActivationDate"/>
        <html:errors bundle="AccessFlowApplicationResources" property="ModificationDate"/>
        <html:errors bundle="AccessFlowApplicationResources" property="State"/>
        <html:errors bundle="AccessFlowApplicationResources" property="Type"/>
        <html:errors bundle="AccessFlowApplicationResources" property="Comments"/>
          <html:errors bundle="AccessFlowApplicationResources" property="Name"/>
        <html:errors bundle="AccessFlowApplicationResources" property="VPNName"/>
        <html:errors bundle="AccessFlowApplicationResources" property="SiteId"/>
        <html:errors bundle="AccessFlowApplicationResources" property="VlanId"/>
        <html:errors bundle="AccessFlowApplicationResources" property="PE_Status"/>
        <html:errors bundle="AccessFlowApplicationResources" property="CE_Status"/>
        <html:errors bundle="AccessFlowApplicationResources" property="AccessNW_Status"/>
        <html:errors bundle="AccessFlowApplicationResources" property="ASBR_Status"/>
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
                <bean:message bundle="AccessFlowApplicationResources" key="field.serviceid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="serviceid" size="24" value="<%= ServiceId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessFlowApplicationResources" key="field.serviceid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessFlowApplicationResources" key="field.customerid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="customerid" size="24" value="<%= CustomerId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessFlowApplicationResources" key="field.customerid.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="customer" value="<%= Customer %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="AccessFlowApplicationResources" key="field.contactperson.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="contactperson" size="24" value="<%= ContactPerson %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessFlowApplicationResources" key="field.contactperson.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessFlowApplicationResources" key="field.servicename.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="servicename" size="24" value="<%= ServiceName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessFlowApplicationResources" key="field.servicename.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessFlowApplicationResources" key="field.initiationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="initiationdate" size="24" value="<%= InitiationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessFlowApplicationResources" key="field.initiationdate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessFlowApplicationResources" key="field.activationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="activationdate" size="24" value="<%= ActivationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessFlowApplicationResources" key="field.activationdate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessFlowApplicationResources" key="field.modificationdate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="modificationdate" size="24" value="<%= ModificationDate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessFlowApplicationResources" key="field.modificationdate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessFlowApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="state" size="24" value="<%= State %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessFlowApplicationResources" key="field.state.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessFlowApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="type" size="24" value="<%= Type %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessFlowApplicationResources" key="field.type.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessFlowApplicationResources" key="field.comments.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="comments" size="24" value="<%= Comments %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessFlowApplicationResources" key="field.comments.description"/>
                              </table:cell>
            </table:row>
                                                                                  <html:hidden property="name" value="<%= Name %>"/>            
                                                                                <html:hidden property="vpnname" value="<%= VPNName %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="AccessFlowApplicationResources" key="field.siteid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="siteid" size="24" value="<%= SiteId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessFlowApplicationResources" key="field.siteid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessFlowApplicationResources" key="field.vlanid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vlanid" size="24" value="<%= VlanId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessFlowApplicationResources" key="field.vlanid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessFlowApplicationResources" key="field.pe_status.alias"/>
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
                <bean:message bundle="AccessFlowApplicationResources" key="field.pe_status.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessFlowApplicationResources" key="field.ce_status.alias"/>
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
                                            <html:option value="Failure" >Failure</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessFlowApplicationResources" key="field.ce_status.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessFlowApplicationResources" key="field.accessnw_status.alias"/>
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
                <bean:message bundle="AccessFlowApplicationResources" key="field.accessnw_status.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessFlowApplicationResources" key="field.asbr_status.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(ASBR_Status==null||ASBR_Status.trim().equals("")) {
                          selValue="In Progress";
                        } else {
                          selValue=ASBR_Status.toString();
                        }    
                    %>

                    <html:select  property="asbr_status" value="<%= selValue %>" >
                                            <html:option value="In Progress" >In Progress</html:option>
                                            <html:option value="Partial" >Partial</html:option>
                                            <html:option value="OK" >OK</html:option>
                                            <html:option value="Ignore" >Ignore</html:option>
                                            <html:option value="Failure" >Failure</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessFlowApplicationResources" key="field.asbr_status.description"/>
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
