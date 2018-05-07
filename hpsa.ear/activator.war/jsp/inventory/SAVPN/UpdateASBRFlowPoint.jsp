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
String datasource = (String) request.getParameter(ASBRFlowPointConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitASBRFlowPointAction.do?datasource=" + datasource + "&rimid=" + rimid;

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
                    _location_ = "asbrserviceid";
                                                            }

%>

<html>
  <head>
    <title><bean:message bundle="ASBRFlowPointApplicationResources" key="<%= ASBRFlowPointConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.ASBRFlowPointForm.action = '/activator<%=moduleConfig%>/UpdateFormASBRFlowPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.ASBRFlowPointForm.submit();
    }
    function performCommit()
    {
      window.document.ASBRFlowPointForm.action = '/activator<%=moduleConfig%>/UpdateCommitASBRFlowPointAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.ASBRFlowPointForm.submit();
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
com.hp.ov.activator.vpn.inventory.ASBRFlowPoint beanASBRFlowPoint = (com.hp.ov.activator.vpn.inventory.ASBRFlowPoint) request.getAttribute(ASBRFlowPointConstants.ASBRFLOWPOINT_BEAN);
if(beanASBRFlowPoint==null)
   beanASBRFlowPoint = (com.hp.ov.activator.vpn.inventory.ASBRFlowPoint) request.getSession().getAttribute(ASBRFlowPointConstants.ASBRFLOWPOINT_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
ASBRFlowPointForm form = (ASBRFlowPointForm) request.getAttribute("ASBRFlowPointForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String TerminationPointId = beanASBRFlowPoint.getTerminationpointid();
        
            
                            
            
                
                String ASBRServiceId = beanASBRFlowPoint.getAsbrserviceid();
        
            
                            
            
                
                String VRFName = beanASBRFlowPoint.getVrfname();
        
            
                            
            
                
                String QoSProfile_in = beanASBRFlowPoint.getQosprofile_in();
        
            
                            
            
                
                String QoSProfile_out = beanASBRFlowPoint.getQosprofile_out();
        
            
                            
            
                
                String RateLimit_in = beanASBRFlowPoint.getRatelimit_in();
        
            
                            
            
                
                String RateLimit_out = beanASBRFlowPoint.getRatelimit_out();
        
            
                            
            
                
                String Protocol = beanASBRFlowPoint.getProtocol();
        
            
                            
            
                
                String PE_InterfaceIP = beanASBRFlowPoint.getPe_interfaceip();
        
            
                            
            
                
                String CE_InterfaceIP = beanASBRFlowPoint.getCe_interfaceip();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="ASBRFlowPointApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="ASBRFlowPointApplicationResources" property="TerminationPointId"/>
        <html:errors bundle="ASBRFlowPointApplicationResources" property="ASBRServiceId"/>
        <html:errors bundle="ASBRFlowPointApplicationResources" property="VRFName"/>
        <html:errors bundle="ASBRFlowPointApplicationResources" property="QoSProfile_in"/>
        <html:errors bundle="ASBRFlowPointApplicationResources" property="QoSProfile_out"/>
        <html:errors bundle="ASBRFlowPointApplicationResources" property="RateLimit_in"/>
        <html:errors bundle="ASBRFlowPointApplicationResources" property="RateLimit_out"/>
        <html:errors bundle="ASBRFlowPointApplicationResources" property="Protocol"/>
        <html:errors bundle="ASBRFlowPointApplicationResources" property="PE_InterfaceIP"/>
        <html:errors bundle="ASBRFlowPointApplicationResources" property="CE_InterfaceIP"/>
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
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.terminationpointid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="terminationpointid" value="<%= TerminationPointId %>"/>
                                                        <html:text disabled="true" property="terminationpointid" size="24" value="<%= TerminationPointId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.terminationpointid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.asbrserviceid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="asbrserviceid" size="24" value="<%= ASBRServiceId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.asbrserviceid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.vrfname.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vrfname" size="24" value="<%= VRFName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.vrfname.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.qosprofile_in.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="qosprofile_in" size="24" value="<%= QoSProfile_in %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.qosprofile_in.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.qosprofile_out.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="qosprofile_out" size="24" value="<%= QoSProfile_out %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.qosprofile_out.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.ratelimit_in.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ratelimit_in" size="24" value="<%= RateLimit_in %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.ratelimit_in.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.ratelimit_out.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ratelimit_out" size="24" value="<%= RateLimit_out %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.ratelimit_out.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.protocol.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="protocol" size="24" value="<%= Protocol %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.protocol.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.pe_interfaceip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="pe_interfaceip" size="24" value="<%= PE_InterfaceIP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.pe_interfaceip.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.ce_interfaceip.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ce_interfaceip" size="24" value="<%= CE_InterfaceIP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRFlowPointApplicationResources" key="field.ce_interfaceip.description"/>
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
