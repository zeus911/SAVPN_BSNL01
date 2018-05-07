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
String datasource = (String) request.getParameter(L3FlowPointConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitL3FlowPointAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("terminationpointid") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                    _location_ = "attachmentid";
                                                                                                                                                      }

%>

<html>
  <head>
    <title><bean:message bundle="L3FlowPointApplicationResources" key="<%= L3FlowPointConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.L3FlowPointForm.action = '/activator<%=moduleConfig%>/UpdateFormL3FlowPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.L3FlowPointForm.submit();
    }
    function performCommit()
    {
      window.document.L3FlowPointForm.action = '/activator<%=moduleConfig%>/UpdateCommitL3FlowPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.L3FlowPointForm.submit();
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
com.hp.ov.activator.vpn.inventory.L3FlowPoint beanL3FlowPoint = (com.hp.ov.activator.vpn.inventory.L3FlowPoint) request.getAttribute(L3FlowPointConstants.L3FLOWPOINT_BEAN);
if(beanL3FlowPoint==null)
   beanL3FlowPoint = (com.hp.ov.activator.vpn.inventory.L3FlowPoint) request.getSession().getAttribute(L3FlowPointConstants.L3FLOWPOINT_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
L3FlowPointForm form = (L3FlowPointForm) request.getAttribute("L3FlowPointForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String TerminationPointId = beanL3FlowPoint.getTerminationpointid();
        
            
                            
            
                
                String AttachmentId = beanL3FlowPoint.getAttachmentid();
        
            
                            
            
                
                String VRFName = beanL3FlowPoint.getVrfname();
        
            
                            
            
                
                String PE_InterfaceIP = beanL3FlowPoint.getPe_interfaceip();
        
            
                            
            
                
                String PE_InterfaceSecondaryIP = beanL3FlowPoint.getPe_interfacesecondaryip();
        
            
                            
            
                
                String CE_InterfaceIP = beanL3FlowPoint.getCe_interfaceip();
        
            
                            
            
                
                String CE_InterfaceSecondaryIP = beanL3FlowPoint.getCe_interfacesecondaryip();
        
            
                            
            
                
                String Protocol = beanL3FlowPoint.getProtocol();
        
            
                            
            
                
                String OSPF_id = beanL3FlowPoint.getOspf_id();
        
            
                            
            
                
                String Rip_id = beanL3FlowPoint.getRip_id();
        
            
                            
            
                
              String Maximum_Prefix = "" + beanL3FlowPoint.getMaximum_prefix();
              Maximum_Prefix = (Maximum_Prefix != null && !(Maximum_Prefix.trim().equals(""))) ? nfA.format(beanL3FlowPoint.getMaximum_prefix()) : "";
          
            
            if( beanL3FlowPoint.getMaximum_prefix()==Integer.MIN_VALUE)
         Maximum_Prefix = "";
                            
            
                
                String StaticRoutes = beanL3FlowPoint.getStaticroutes();
        
            
                            
            
                
              boolean SOO_Configured = new Boolean(beanL3FlowPoint.getSoo_configured()).booleanValue();
    
            
                            
            
                
                String RateLimit_in = beanL3FlowPoint.getRatelimit_in();
        
            
                            
            
                
                String QoSProfile_in = beanL3FlowPoint.getQosprofile_in();
        
            
                            
            
                
                String RateLimit_out = beanL3FlowPoint.getRatelimit_out();
        
            
                            
            
                
                String QoSProfile_out = beanL3FlowPoint.getQosprofile_out();
        
            
                            
            
                
              boolean QoSChildEnabled = new Boolean(beanL3FlowPoint.getQoschildenabled()).booleanValue();
    
            
                            
            
                
                String mCAR = beanL3FlowPoint.getMcar();
        
            
                            
            
                
                String mCoS = beanL3FlowPoint.getMcos();
        
            
                            
            
                
                String LoopbackId = beanL3FlowPoint.getLoopbackid();
        
            
                            
            
                
                String Master = beanL3FlowPoint.getMaster();
        
            
                            
            
                
              String Priority = "" + beanL3FlowPoint.getPriority();
              Priority = (Priority != null && !(Priority.trim().equals(""))) ? nfA.format(beanL3FlowPoint.getPriority()) : "";
          
            
            if( beanL3FlowPoint.getPriority()==Integer.MIN_VALUE)
         Priority = "";
                            
            
                
              String VRRP_Group_Id = "" + beanL3FlowPoint.getVrrp_group_id();
              VRRP_Group_Id = (VRRP_Group_Id != null && !(VRRP_Group_Id.trim().equals(""))) ? nfA.format(beanL3FlowPoint.getVrrp_group_id()) : "";
          
            
            if( beanL3FlowPoint.getVrrp_group_id()==Integer.MIN_VALUE)
         VRRP_Group_Id = "";
                            
            
                
                String UsageMode = beanL3FlowPoint.getUsagemode();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="L3FlowPointApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="L3FlowPointApplicationResources" property="TerminationPointId"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="AttachmentId"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="VRFName"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="PE_InterfaceIP"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="PE_InterfaceSecondaryIP"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="CE_InterfaceIP"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="CE_InterfaceSecondaryIP"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="Protocol"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="OSPF_id"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="Rip_id"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="Maximum_Prefix"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="StaticRoutes"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="SOO_Configured"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="RateLimit_in"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="QoSProfile_in"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="RateLimit_out"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="QoSProfile_out"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="QoSChildEnabled"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="mCAR"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="mCoS"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="LoopbackId"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="Master"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="Priority"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="VRRP_Group_Id"/>
        <html:errors bundle="L3FlowPointApplicationResources" property="UsageMode"/>
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
    allEvents = allEvents + "checkShowRulesTerminationPointId();";//default invoked when loading HTML
    function checkShowRulesTerminationPointId(){
          var TerminationPointIdPass = false ;
      if (/^\\S+$/.test(document.getElementsByName("terminationpointid")[0].value)) {TerminationPointIdPass = true;}
            
    var controlTr = document.getElementsByName("terminationpointid")[0];
          if (true && TerminationPointIdPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('terminationpointid')[0],'keyup',checkShowRulesTerminationPointId);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesAttachmentId();";//default invoked when loading HTML
    function checkShowRulesAttachmentId(){
          var AttachmentIdPass = false ;
      if (/^\\S+$/.test(document.getElementsByName("attachmentid")[0].value)) {AttachmentIdPass = true;}
            
    var controlTr = document.getElementsByName("attachmentid")[0];
          if (true && AttachmentIdPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('attachmentid')[0],'keyup',checkShowRulesAttachmentId);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesRateLimit_in();";//default invoked when loading HTML
    function checkShowRulesRateLimit_in(){
          var RateLimit_inPass = false ;
      if (/^\\S+$/.test(document.getElementsByName("ratelimit_in")[0].value)) {RateLimit_inPass = true;}
            
    var controlTr = document.getElementsByName("ratelimit_in")[0];
          if (true && RateLimit_inPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('ratelimit_in')[0],'keyup',checkShowRulesRateLimit_in);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesQoSProfile_in();";//default invoked when loading HTML
    function checkShowRulesQoSProfile_in(){
          var QoSProfile_inPass = false ;
      if (/^\\S+$/.test(document.getElementsByName("qosprofile_in")[0].value)) {QoSProfile_inPass = true;}
            
    var controlTr = document.getElementsByName("qosprofile_in")[0];
          if (true && QoSProfile_inPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('qosprofile_in')[0],'keyup',checkShowRulesQoSProfile_in);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesRateLimit_out();";//default invoked when loading HTML
    function checkShowRulesRateLimit_out(){
          var RateLimit_outPass = false ;
      if (/^\\S+$/.test(document.getElementsByName("ratelimit_out")[0].value)) {RateLimit_outPass = true;}
            
    var controlTr = document.getElementsByName("ratelimit_out")[0];
          if (true && RateLimit_outPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('ratelimit_out')[0],'keyup',checkShowRulesRateLimit_out);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesQoSProfile_out();";//default invoked when loading HTML
    function checkShowRulesQoSProfile_out(){
          var QoSProfile_outPass = false ;
      if (/^\\S+$/.test(document.getElementsByName("qosprofile_out")[0].value)) {QoSProfile_outPass = true;}
            
    var controlTr = document.getElementsByName("qosprofile_out")[0];
          if (true && QoSProfile_outPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('qosprofile_out')[0],'keyup',checkShowRulesQoSProfile_out);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesmCAR();";//default invoked when loading HTML
    function checkShowRulesmCAR(){
          var mCoSPass = false ;
      if (/^\\S+$/.test(document.getElementsByName("mcos")[0].value)) {mCoSPass = true;}
            
    var controlTr = document.getElementsByName("mcar")[0];
          if (true && mCoSPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('mcos')[0],'keyup',checkShowRulesmCAR);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesmCoS();";//default invoked when loading HTML
    function checkShowRulesmCoS(){
          var mCoSPass = false ;
      if (/^\\S+$/.test(document.getElementsByName("mcos")[0].value)) {mCoSPass = true;}
            
    var controlTr = document.getElementsByName("mcos")[0];
          if (true && mCoSPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('mcos')[0],'keyup',checkShowRulesmCoS);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesLoopbackId();";//default invoked when loading HTML
    function checkShowRulesLoopbackId(){
          var LoopbackIdPass = false ;
      if (/^\\S+$/.test(document.getElementsByName("loopbackid")[0].value)) {LoopbackIdPass = true;}
            
    var controlTr = document.getElementsByName("loopbackid")[0];
          if (true && LoopbackIdPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('loopbackid')[0],'keyup',checkShowRulesLoopbackId);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesMaster();";//default invoked when loading HTML
    function checkShowRulesMaster(){
          var MasterPass = false ;
      if (/^\\S+$/.test(document.getElementsByName("master")[0].value)) {MasterPass = true;}
            
    var controlTr = document.getElementsByName("master")[0];
          if (true && MasterPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('master')[0],'keyup',checkShowRulesMaster);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesPriority();";//default invoked when loading HTML
    function checkShowRulesPriority(){
          var MasterPass = false ;
      if (/^\\S+$/.test(document.getElementsByName("master")[0].value)) {MasterPass = true;}
            
    var controlTr = document.getElementsByName("priority")[0];
          if (true && MasterPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('master')[0],'keyup',checkShowRulesPriority);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesVRRP_Group_Id();";//default invoked when loading HTML
    function checkShowRulesVRRP_Group_Id(){
          var MasterPass = false ;
      if (/^\\S+$/.test(document.getElementsByName("master")[0].value)) {MasterPass = true;}
            
    var controlTr = document.getElementsByName("vrrp_group_id")[0];
          if (true && MasterPass ){
            
              
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
        
      } else {
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  }

      allEvents = allEvents + "addListener(document.getElementsByName('master')[0],'keyup',checkShowRulesVRRP_Group_Id);";
   </script>   
    <script>
function doOnLoad()
{
  // hide field
                    document.getElementsByName("terminationpointid")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("attachmentid")[0].parentNode.parentNode.style.display="none";
                                                                                                document.getElementsByName("ratelimit_in")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("qosprofile_in")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("ratelimit_out")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("qosprofile_out")[0].parentNode.parentNode.style.display="none";
                                    document.getElementsByName("mcar")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("mcos")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("loopbackid")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("master")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("priority")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("vrrp_group_id")[0].parentNode.parentNode.style.display="none";
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
      
                                    <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.terminationpointid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="terminationpointid" value="<%= TerminationPointId %>"/>
                                                        <html:text disabled="true" property="terminationpointid" size="24" value="<%= TerminationPointId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.terminationpointid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.attachmentid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="attachmentid" size="24" value="<%= AttachmentId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.attachmentid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.vrfname.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vrfname" size="24" value="<%= VRFName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.vrfname.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.pe_interfaceip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="pe_interfaceip" size="24" value="<%= PE_InterfaceIP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.pe_interfaceip.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.pe_interfacesecondaryip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="pe_interfacesecondaryip" size="24" value="<%= PE_InterfaceSecondaryIP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.pe_interfacesecondaryip.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.ce_interfaceip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ce_interfaceip" size="24" value="<%= CE_InterfaceIP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.ce_interfaceip.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.ce_interfacesecondaryip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ce_interfacesecondaryip" size="24" value="<%= CE_InterfaceSecondaryIP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.ce_interfacesecondaryip.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.protocol.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="protocol" size="24" value="<%= Protocol %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.protocol.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.ospf_id.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ospf_id" size="24" value="<%= OSPF_id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.ospf_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.rip_id.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rip_id" size="24" value="<%= Rip_id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.rip_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.maximum_prefix.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="maximum_prefix" size="24" value="<%= Maximum_Prefix %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.maximum_prefix.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.staticroutes.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="staticroutes" size="24" value="<%= StaticRoutes %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.staticroutes.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.soo_configured.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="soo_configured" value="true"/>
                  <html:hidden  property="soo_configured" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.soo_configured.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.ratelimit_in.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ratelimit_in" size="24" value="<%= RateLimit_in %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.ratelimit_in.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.qosprofile_in.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="qosprofile_in" size="24" value="<%= QoSProfile_in %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.qosprofile_in.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.ratelimit_out.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ratelimit_out" size="24" value="<%= RateLimit_out %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.ratelimit_out.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.qosprofile_out.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="qosprofile_out" size="24" value="<%= QoSProfile_out %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.qosprofile_out.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.qoschildenabled.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="qoschildenabled" value="true"/>
                  <html:hidden  property="qoschildenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.qoschildenabled.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.mcar.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="mcar" size="24" value="<%= mCAR %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.mcar.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.mcos.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="mcos" size="24" value="<%= mCoS %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.mcos.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.loopbackid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="loopbackid" size="24" value="<%= LoopbackId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.loopbackid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.master.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="master" size="24" value="<%= Master %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.master.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.priority.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="priority" size="24" value="<%= Priority %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.priority.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.vrrp_group_id.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vrrp_group_id" size="24" value="<%= VRRP_Group_Id %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.vrrp_group_id.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="L3FlowPointApplicationResources" key="field.usagemode.alias"/>
                              </table:cell>
              <table:cell>
                                                                          <%
                        String selValue=null;                                    
                        if(UsageMode==null||UsageMode.trim().equals(""))
                           selValue="Service";
                        else
                        selValue=UsageMode.toString();    
                          %>

                    <html:select  property="usagemode" value="<%= selValue %>" >
                                            <html:option value="Service" >Service</html:option>
                                            <html:option value="Aggregated" >Aggregated</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="L3FlowPointApplicationResources" key="field.usagemode.description"/>
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
