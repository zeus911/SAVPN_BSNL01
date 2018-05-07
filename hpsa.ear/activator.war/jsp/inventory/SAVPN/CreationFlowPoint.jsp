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
String datasource = (String) request.getParameter(FlowPointConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitFlowPointAction.do?datasource=" + datasource + "&rimid=" + rimid;
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
    <title><bean:message bundle="FlowPointApplicationResources" key="<%= FlowPointConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.FlowPointForm.action = '/activator<%=moduleConfig%>/CreationFormFlowPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.FlowPointForm.submit();
    }
    function performCommit()
    {
      window.document.FlowPointForm.action = '/activator<%=moduleConfig%>/CreationCommitFlowPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.FlowPointForm.submit();
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

com.hp.ov.activator.vpn.inventory.FlowPoint beanFlowPoint = (com.hp.ov.activator.vpn.inventory.FlowPoint) request.getAttribute(FlowPointConstants.FLOWPOINT_BEAN);

      String TerminationPointId = beanFlowPoint.getTerminationpointid();
                String AttachmentId = beanFlowPoint.getAttachmentid();
                String QoSProfile_in = beanFlowPoint.getQosprofile_in();
                String QoSProfile_out = beanFlowPoint.getQosprofile_out();
                boolean QoSChildEnabled = new Boolean(beanFlowPoint.getQoschildenabled()).booleanValue();
                String RateLimit_in = beanFlowPoint.getRatelimit_in();
                String RateLimit_out = beanFlowPoint.getRatelimit_out();
                String UsageMode = beanFlowPoint.getUsagemode();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="FlowPointApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="FlowPointApplicationResources" property="TerminationPointId"/>
        <html:errors bundle="FlowPointApplicationResources" property="AttachmentId"/>
        <html:errors bundle="FlowPointApplicationResources" property="QoSProfile_in"/>
        <html:errors bundle="FlowPointApplicationResources" property="QoSProfile_out"/>
        <html:errors bundle="FlowPointApplicationResources" property="QoSChildEnabled"/>
        <html:errors bundle="FlowPointApplicationResources" property="RateLimit_in"/>
        <html:errors bundle="FlowPointApplicationResources" property="RateLimit_out"/>
        <html:errors bundle="FlowPointApplicationResources" property="UsageMode"/>
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
          var TerminationPointIdPass = false;
      
              if (/^\\S+$/.test(document.getElementsByName("terminationpointid")[0].value)) {TerminationPointIdPass = true;}
                        
      

    var controlTr = document.getElementsByName("terminationpointid")[0];
    
          if (true && TerminationPointIdPass ){
    
            
          
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
      }else{
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('terminationpointid')[0],'keyup',checkShowRulesTerminationPointId);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesAttachmentId();";//default invoked when loading HTML
    function checkShowRulesAttachmentId(){
          var AttachmentIdPass = false;
      
              if (/^\\S+$/.test(document.getElementsByName("attachmentid")[0].value)) {AttachmentIdPass = true;}
                        
      

    var controlTr = document.getElementsByName("attachmentid")[0];
    
          if (true && AttachmentIdPass ){
    
            
          
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
      }else{
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('attachmentid')[0],'keyup',checkShowRulesAttachmentId);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesQoSProfile_in();";//default invoked when loading HTML
    function checkShowRulesQoSProfile_in(){
          var QoSProfile_inPass = false;
      
              if (/^\\S+$/.test(document.getElementsByName("qosprofile_in")[0].value)) {QoSProfile_inPass = true;}
                        
      

    var controlTr = document.getElementsByName("qosprofile_in")[0];
    
          if (true && QoSProfile_inPass ){
    
            
          
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
      }else{
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('qosprofile_in')[0],'keyup',checkShowRulesQoSProfile_in);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesQoSProfile_out();";//default invoked when loading HTML
    function checkShowRulesQoSProfile_out(){
          var QoSProfile_outPass = false;
      
              if (/^\\S+$/.test(document.getElementsByName("qosprofile_out")[0].value)) {QoSProfile_outPass = true;}
                        
      

    var controlTr = document.getElementsByName("qosprofile_out")[0];
    
          if (true && QoSProfile_outPass ){
    
            
          
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
      }else{
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('qosprofile_out')[0],'keyup',checkShowRulesQoSProfile_out);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesRateLimit_in();";//default invoked when loading HTML
    function checkShowRulesRateLimit_in(){
          var RateLimit_inPass = false;
      
              if (/^\\S+$/.test(document.getElementsByName("ratelimit_in")[0].value)) {RateLimit_inPass = true;}
                        
      

    var controlTr = document.getElementsByName("ratelimit_in")[0];
    
          if (true && RateLimit_inPass ){
    
            
          
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
      }else{
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('ratelimit_in')[0],'keyup',checkShowRulesRateLimit_in);";
   </script>   
    <script>
    allEvents = allEvents + "checkShowRulesRateLimit_out();";//default invoked when loading HTML
    function checkShowRulesRateLimit_out(){
          var RateLimit_outPass = false;
      
              if (/^\\S+$/.test(document.getElementsByName("ratelimit_out")[0].value)) {RateLimit_outPass = true;}
                        
      

    var controlTr = document.getElementsByName("ratelimit_out")[0];
    
          if (true && RateLimit_outPass ){
    
            
          
        if(document.all){//IE
          controlTr.parentNode.parentNode.style.display="inline";
        }else{
          controlTr.parentNode.parentNode.style.display="table-row";
        }
  
                
      }else{
                  controlTr.parentNode.parentNode.style.display="none";   
              }
  
}

      allEvents = allEvents + "addListener(document.getElementsByName('ratelimit_out')[0],'keyup',checkShowRulesRateLimit_out);";
   </script>   
    <script>
function doOnLoad()
{
  // hide field
                    document.getElementsByName("terminationpointid")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("attachmentid")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("qosprofile_in")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("qosprofile_out")[0].parentNode.parentNode.style.display="none";
                                    document.getElementsByName("ratelimit_in")[0].parentNode.parentNode.style.display="none";
                              document.getElementsByName("ratelimit_out")[0].parentNode.parentNode.style.display="none";
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
                <bean:message bundle="FlowPointApplicationResources" key="field.terminationpointid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="terminationpointid" size="24" value="<%= TerminationPointId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="FlowPointApplicationResources" key="field.terminationpointid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="FlowPointApplicationResources" key="field.attachmentid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="attachmentid" size="24" value="<%= AttachmentId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="FlowPointApplicationResources" key="field.attachmentid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="FlowPointApplicationResources" key="field.qosprofile_in.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="qosprofile_in" size="24" value="<%= QoSProfile_in %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="FlowPointApplicationResources" key="field.qosprofile_in.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="FlowPointApplicationResources" key="field.qosprofile_out.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="qosprofile_out" size="24" value="<%= QoSProfile_out %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="FlowPointApplicationResources" key="field.qosprofile_out.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="FlowPointApplicationResources" key="field.qoschildenabled.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="qoschildenabled" value="true"/>
                  <html:hidden  property="qoschildenabled" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="FlowPointApplicationResources" key="field.qoschildenabled.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="FlowPointApplicationResources" key="field.ratelimit_in.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ratelimit_in" size="24" value="<%= RateLimit_in %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="FlowPointApplicationResources" key="field.ratelimit_in.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="FlowPointApplicationResources" key="field.ratelimit_out.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ratelimit_out" size="24" value="<%= RateLimit_out %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="FlowPointApplicationResources" key="field.ratelimit_out.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="FlowPointApplicationResources" key="field.usagemode.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(UsageMode==null||UsageMode.trim().equals("")) {
                          selValue="Service";
                        } else {
                          selValue=UsageMode.toString();
                        }    
                    %>

                    <html:select  property="usagemode" value="<%= selValue %>" >
                                            <html:option value="Service" >Service</html:option>
                                            <html:option value="Aggregated" >Aggregated</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="FlowPointApplicationResources" key="field.usagemode.description"/>
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
