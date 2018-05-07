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

                                                                               java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm:ss");
            String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
    
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(InterfaceConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitInterfaceAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
                    _location_ = "name";
                                                                                                                                                                                                      }
%>

<html>
  <head>
    <title><bean:message bundle="InterfaceApplicationResources" key="<%= InterfaceConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.InterfaceForm.action = '/activator<%=moduleConfig%>/CreationFormInterfaceAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.InterfaceForm.submit();
    }
    function performCommit()
    {
      window.document.InterfaceForm.action = '/activator<%=moduleConfig%>/CreationCommitInterfaceAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.InterfaceForm.submit();
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

com.hp.ov.activator.vpn.inventory.Interface beanInterface = (com.hp.ov.activator.vpn.inventory.Interface) request.getAttribute(InterfaceConstants.INTERFACE_BEAN);

      String TerminationPointId = beanInterface.getTerminationpointid();
                String Name = beanInterface.getName();
                String NE_Id = beanInterface.getNe_id();
        String NE_IdLabel = (String) request.getAttribute(InterfaceConstants.NE_ID_LABEL);
ArrayList NE_IdListOfValues = (ArrayList) request.getAttribute(InterfaceConstants.NE_ID_LIST_OF_VALUES);
            String NE = beanInterface.getNe();
                String EC_Id = beanInterface.getEc_id();
        String EC_IdLabel = (String) request.getAttribute(InterfaceConstants.EC_ID_LABEL);
ArrayList EC_IdListOfValues = (ArrayList) request.getAttribute(InterfaceConstants.EC_ID_LIST_OF_VALUES);
            String EC = beanInterface.getEc();
                String State = beanInterface.getState();
                String Type = beanInterface.getType();
                String ParentIf = beanInterface.getParentif();
        String ParentIfLabel = (String) request.getAttribute(InterfaceConstants.PARENTIF_LABEL);
ArrayList ParentIfListOfValues = (ArrayList) request.getAttribute(InterfaceConstants.PARENTIF_LIST_OF_VALUES);
            String ParentIfC = beanInterface.getParentifc();
                String IPAddr = beanInterface.getIpaddr();
                String Subtype = beanInterface.getSubtype();
                String Encapsulation = beanInterface.getEncapsulation();
                String Description = beanInterface.getDescription();
                String IFIndex = beanInterface.getIfindex();
                String ActivationState = beanInterface.getActivationstate();
                String UsageState = beanInterface.getUsagestate();
                String VLANId = beanInterface.getVlanid();
                String VLANMode = beanInterface.getVlanmode();
                String DLCI = beanInterface.getDlci();
                String BundleKey = beanInterface.getBundlekey();
                String BundleId = beanInterface.getBundleid();
                String Timeslots = beanInterface.getTimeslots();
                String NumberOfSlots = beanInterface.getNumberofslots();
                String Bandwidth = beanInterface.getBandwidth();
                String LMIType = beanInterface.getLmitype();
                String IntfType = beanInterface.getIntftype();
                String States = beanInterface.getStates();
        String StatesLabel = (String) request.getAttribute(InterfaceConstants.STATES_LABEL);
ArrayList StatesListOfValues = (ArrayList) request.getAttribute(InterfaceConstants.STATES_LIST_OF_VALUES);
            String OriginalActivationState = beanInterface.getOriginalactivationstate();
                String NNMi_UUId = beanInterface.getNnmi_uuid();
                String NNMi_Id = beanInterface.getNnmi_id();
                String NNMi_LastUpdate = (beanInterface.getNnmi_lastupdate() == null) ? "" : beanInterface.getNnmi_lastupdate();
            
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="InterfaceApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="InterfaceApplicationResources" property="TerminationPointId"/>
        <html:errors bundle="InterfaceApplicationResources" property="Name"/>
        <html:errors bundle="InterfaceApplicationResources" property="NE_Id"/>
        <html:errors bundle="InterfaceApplicationResources" property="NE"/>
        <html:errors bundle="InterfaceApplicationResources" property="EC_Id"/>
        <html:errors bundle="InterfaceApplicationResources" property="EC"/>
        <html:errors bundle="InterfaceApplicationResources" property="State"/>
        <html:errors bundle="InterfaceApplicationResources" property="Type"/>
        <html:errors bundle="InterfaceApplicationResources" property="ParentIf"/>
        <html:errors bundle="InterfaceApplicationResources" property="ParentIfC"/>
        <html:errors bundle="InterfaceApplicationResources" property="IPAddr"/>
        <html:errors bundle="InterfaceApplicationResources" property="Subtype"/>
        <html:errors bundle="InterfaceApplicationResources" property="Encapsulation"/>
        <html:errors bundle="InterfaceApplicationResources" property="Description"/>
        <html:errors bundle="InterfaceApplicationResources" property="IFIndex"/>
        <html:errors bundle="InterfaceApplicationResources" property="ActivationState"/>
        <html:errors bundle="InterfaceApplicationResources" property="UsageState"/>
        <html:errors bundle="InterfaceApplicationResources" property="VLANId"/>
        <html:errors bundle="InterfaceApplicationResources" property="VLANMode"/>
        <html:errors bundle="InterfaceApplicationResources" property="DLCI"/>
        <html:errors bundle="InterfaceApplicationResources" property="BundleKey"/>
        <html:errors bundle="InterfaceApplicationResources" property="BundleId"/>
        <html:errors bundle="InterfaceApplicationResources" property="Timeslots"/>
        <html:errors bundle="InterfaceApplicationResources" property="NumberOfSlots"/>
        <html:errors bundle="InterfaceApplicationResources" property="Bandwidth"/>
        <html:errors bundle="InterfaceApplicationResources" property="LMIType"/>
        <html:errors bundle="InterfaceApplicationResources" property="IntfType"/>
        <html:errors bundle="InterfaceApplicationResources" property="States"/>
        <html:errors bundle="InterfaceApplicationResources" property="OriginalActivationState"/>
        <html:errors bundle="InterfaceApplicationResources" property="NNMi_UUId"/>
        <html:errors bundle="InterfaceApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="InterfaceApplicationResources" property="NNMi_LastUpdate"/>
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
    allEvents = allEvents + "checkShowRulesType();";//default invoked when loading HTML
    function checkShowRulesType(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        var StatesPass = false;
      
              if (/^(?:(?!(?:ReadyAvailable)).)*$/.test(document.getElementsByName("states")[0].value)) {StatesPass = true;}
                        
      

    var controlTr = document.getElementsByName("type")[0];
    
          if (true && OriginalActivationStatePass && StatesPass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesType);";
      allEvents = allEvents + "addListener(document.getElementsByName('states')[0],'change',checkShowRulesType);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesIPAddr();";//default invoked when loading HTML
    function checkShowRulesIPAddr(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        
      

    var controlTr = document.getElementsByName("ipaddr")[0];
    
          if (true && OriginalActivationStatePass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesIPAddr);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesSubtype();";//default invoked when loading HTML
    function checkShowRulesSubtype(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        
      

    var controlTr = document.getElementsByName("subtype")[0];
    
          if (true && OriginalActivationStatePass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesSubtype);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesEncapsulation();";//default invoked when loading HTML
    function checkShowRulesEncapsulation(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        var StatesPass = false;
      
              if (/^(?:(?!(?:ReadyAvailable)).)*$/.test(document.getElementsByName("states")[0].value)) {StatesPass = true;}
                        
      

    var controlTr = document.getElementsByName("encapsulation")[0];
    
          if (true && OriginalActivationStatePass && StatesPass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesEncapsulation);";
      allEvents = allEvents + "addListener(document.getElementsByName('states')[0],'change',checkShowRulesEncapsulation);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesDescription();";//default invoked when loading HTML
    function checkShowRulesDescription(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        
      

    var controlTr = document.getElementsByName("description")[0];
    
          if (true && OriginalActivationStatePass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesDescription);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesIFIndex();";//default invoked when loading HTML
    function checkShowRulesIFIndex(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        
      

    var controlTr = document.getElementsByName("ifindex")[0];
    
          if (true && OriginalActivationStatePass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesIFIndex);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesActivationState();";//default invoked when loading HTML
    function checkShowRulesActivationState(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        
      

    var controlTr = document.getElementsByName("activationstate")[0];
    
          if (true && OriginalActivationStatePass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesActivationState);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesUsageState();";//default invoked when loading HTML
    function checkShowRulesUsageState(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        var StatesPass = false;
      
              if (/^(?:(?!(?:ReadyTrunk|ReadyASBRLink|ReadySwitchPort)).)*$/.test(document.getElementsByName("states")[0].value)) {StatesPass = true;}
                        
      

    var controlTr = document.getElementsByName("usagestate")[0];
    
          if (true && OriginalActivationStatePass && StatesPass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesUsageState);";
      allEvents = allEvents + "addListener(document.getElementsByName('states')[0],'change',checkShowRulesUsageState);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesVLANId();";//default invoked when loading HTML
    function checkShowRulesVLANId(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        
      

    var controlTr = document.getElementsByName("vlanid")[0];
    
          if (true && OriginalActivationStatePass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesVLANId);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesVLANMode();";//default invoked when loading HTML
    function checkShowRulesVLANMode(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        
      

    var controlTr = document.getElementsByName("vlanmode")[0];
    
          if (true && OriginalActivationStatePass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesVLANMode);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesDLCI();";//default invoked when loading HTML
    function checkShowRulesDLCI(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        
      

    var controlTr = document.getElementsByName("dlci")[0];
    
          if (true && OriginalActivationStatePass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesDLCI);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesBundleKey();";//default invoked when loading HTML
    function checkShowRulesBundleKey(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        
      

    var controlTr = document.getElementsByName("bundlekey")[0];
    
          if (true && OriginalActivationStatePass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesBundleKey);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesBundleId();";//default invoked when loading HTML
    function checkShowRulesBundleId(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        
      

    var controlTr = document.getElementsByName("bundleid")[0];
    
          if (true && OriginalActivationStatePass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesBundleId);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesTimeslots();";//default invoked when loading HTML
    function checkShowRulesTimeslots(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        
      

    var controlTr = document.getElementsByName("timeslots")[0];
    
          if (true && OriginalActivationStatePass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesTimeslots);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesNumberOfSlots();";//default invoked when loading HTML
    function checkShowRulesNumberOfSlots(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        
      

    var controlTr = document.getElementsByName("numberofslots")[0];
    
          if (true && OriginalActivationStatePass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesNumberOfSlots);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesBandwidth();";//default invoked when loading HTML
    function checkShowRulesBandwidth(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        
      

    var controlTr = document.getElementsByName("bandwidth")[0];
    
          if (true && OriginalActivationStatePass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesBandwidth);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesLMIType();";//default invoked when loading HTML
    function checkShowRulesLMIType(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        
      

    var controlTr = document.getElementsByName("lmitype")[0];
    
          if (true && OriginalActivationStatePass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesLMIType);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesIntfType();";//default invoked when loading HTML
    function checkShowRulesIntfType(){
          var OriginalActivationStatePass = false;
      
              if (/^(?:(?!Activated).)*$/.test(document.getElementsByName("originalactivationstate")[0].value)) {OriginalActivationStatePass = true;}
                        
      

    var controlTr = document.getElementsByName("intftype")[0];
    
          if (true && OriginalActivationStatePass ){
    
            
            
        controlTr.disabled = false;
        
                
      }else{
                  controlTr.disabled = true;
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('originalactivationstate')[0],'keyup',checkShowRulesIntfType);";
   </script>   
    <script>
function doOnLoad()
{
  // hide field
                                                              document.getElementsByName("type")[0].disabled = true;
                                          document.getElementsByName("ipaddr")[0].disabled = true;
                              document.getElementsByName("subtype")[0].disabled = true;
                              document.getElementsByName("encapsulation")[0].disabled = true;
                              document.getElementsByName("description")[0].disabled = true;
                              document.getElementsByName("ifindex")[0].disabled = true;
                              document.getElementsByName("activationstate")[0].disabled = true;
                              document.getElementsByName("usagestate")[0].disabled = true;
                              document.getElementsByName("vlanid")[0].disabled = true;
                              document.getElementsByName("vlanmode")[0].disabled = true;
                              document.getElementsByName("dlci")[0].disabled = true;
                              document.getElementsByName("bundlekey")[0].disabled = true;
                              document.getElementsByName("bundleid")[0].disabled = true;
                              document.getElementsByName("timeslots")[0].disabled = true;
                              document.getElementsByName("numberofslots")[0].disabled = true;
                              document.getElementsByName("bandwidth")[0].disabled = true;
                              document.getElementsByName("lmitype")[0].disabled = true;
                              document.getElementsByName("intftype")[0].disabled = true;
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
      
                                                  <html:hidden property="terminationpointid" value="<%= TerminationPointId %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.name.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.ne_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="ne_id" value="<%= NE_Id %>" onchange="sendthis('ne_id');">
                      <html:options collection="NE_IdListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.ne_id.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="ne" value="<%= NE %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.ec_id.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="ec_id" value="<%= EC_Id %>" >
                      <html:options collection="EC_IdListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.ec_id.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="ec" value="<%= EC %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(State==null||State.trim().equals("")) {
                          selValue="Up";
                        } else {
                          selValue=State.toString();
                        }    
                    %>

                    <html:select  property="state" value="<%= selValue %>" >
                                            <html:option value="Up" >Up</html:option>
                                            <html:option value="Down" >Down</html:option>
                                            <html:option value="Unknown" >Unknown</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.state.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.type.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="type" size="24" value="<%= Type %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.type.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.parentif.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:select  property="parentif" value="<%= ParentIf %>" >
                      <html:options collection="ParentIfListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.parentif.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="parentifc" value="<%= ParentIfC %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.ipaddr.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ipaddr" size="24" value="<%= IPAddr %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.ipaddr.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.subtype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="subtype" size="24" value="<%= Subtype %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.subtype.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.encapsulation.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="encapsulation" size="24" value="<%= Encapsulation %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.encapsulation.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.description.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="description" size="24" value="<%= Description %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.description.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.ifindex.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ifindex" size="24" value="<%= IFIndex %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.ifindex.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.activationstate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(ActivationState==null||ActivationState.trim().equals("")) {
                          selValue="Activated";
                        } else {
                          selValue=ActivationState.toString();
                        }    
                    %>

                    <html:select  property="activationstate" value="<%= selValue %>" >
                                            <html:option value="Activated" >Activated</html:option>
                                            <html:option value="Failed" >Failed</html:option>
                                            <html:option value="Undefined" >Undefined</html:option>
                                            <html:option value="Ready" >Ready</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.activationstate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.usagestate.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(UsageState==null||UsageState.trim().equals("")) {
                          selValue="Available";
                        } else {
                          selValue=UsageState.toString();
                        }    
                    %>

                    <html:select  property="usagestate" value="<%= selValue %>" >
                                            <html:option value="Available" >Available</html:option>
                                            <html:option value="SubIfPresent" >SubIfPresent</html:option>
                                            <html:option value="Uplink" >Uplink</html:option>
                                            <html:option value="Reserved" >Reserved</html:option>
                                            <html:option value="InBundle" >InBundle</html:option>
                                            <html:option value="Trunk" >Trunk</html:option>
                                            <html:option value="ASBRLink" >ASBRLink</html:option>
                                            <html:option value="SwitchPort" >SwitchPort</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.usagestate.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.vlanid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vlanid" size="24" value="<%= VLANId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.vlanid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.vlanmode.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vlanmode" size="24" value="<%= VLANMode %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.vlanmode.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.dlci.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dlci" size="24" value="<%= DLCI %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.dlci.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.bundlekey.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="bundlekey" size="24" value="<%= BundleKey %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.bundlekey.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.bundleid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="bundleid" size="24" value="<%= BundleId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.bundleid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.timeslots.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="timeslots" size="24" value="<%= Timeslots %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.timeslots.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.numberofslots.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="numberofslots" size="24" value="<%= NumberOfSlots %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.numberofslots.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.bandwidth.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="bandwidth" size="24" value="<%= Bandwidth %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.bandwidth.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.lmitype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="lmitype" size="24" value="<%= LMIType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.lmitype.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.intftype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="intftype" size="24" value="<%= IntfType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.intftype.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="states" value="<%= States %>"/>            
                                                                                <html:hidden property="originalactivationstate" value="<%= OriginalActivationState %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_uuid.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_uuid" value="<%= NNMi_UUId %>"/>
                                                        <html:text disabled="true" property="nnmi_uuid" size="24" value="<%= NNMi_UUId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_uuid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_id.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_id" value="<%= NNMi_Id %>"/>
                                                        <html:text disabled="true" property="nnmi_id" size="24" value="<%= NNMi_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_lastupdate.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="nnmi_lastupdate" value="<%= NNMi_LastUpdate %>"/>
                                                        <html:text disabled="true" property="nnmi_lastupdate" size="24" value="<%= NNMi_LastUpdate %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceApplicationResources" key="field.nnmi_lastupdate.description"/>
                <%=sdfNNMi_LastUpdateDesc%>              </table:cell>
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
