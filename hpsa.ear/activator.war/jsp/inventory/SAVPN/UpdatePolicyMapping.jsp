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
String datasource = (String) request.getParameter(PolicyMappingConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitPolicyMappingAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("tclassname") + "||" + request.getParameter("profilename") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                          _location_ = "exp";
                                                }

%>

<html>
  <head>
    <title><bean:message bundle="PolicyMappingApplicationResources" key="<%= PolicyMappingConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.PolicyMappingForm.action = '/activator<%=moduleConfig%>/UpdateFormPolicyMappingAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.PolicyMappingForm.submit();
    }
    function performCommit()
    {
      window.document.PolicyMappingForm.action = '/activator<%=moduleConfig%>/UpdateCommitPolicyMappingAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.PolicyMappingForm.submit();
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
com.hp.ov.activator.vpn.inventory.PolicyMapping beanPolicyMapping = (com.hp.ov.activator.vpn.inventory.PolicyMapping) request.getAttribute(PolicyMappingConstants.POLICYMAPPING_BEAN);
if(beanPolicyMapping==null)
   beanPolicyMapping = (com.hp.ov.activator.vpn.inventory.PolicyMapping) request.getSession().getAttribute(PolicyMappingConstants.POLICYMAPPING_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
PolicyMappingForm form = (PolicyMappingForm) request.getAttribute("PolicyMappingForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String TClassName = beanPolicyMapping.getTclassname();
        
            
                            
            
                
                String ProfileName = beanPolicyMapping.getProfilename();
        
            
                            
            
                
                String Exp = beanPolicyMapping.getExp();
        
            
                            
            
                
                String Dscp = beanPolicyMapping.getDscp();
        
            
                            
            
                
                String Percentage = beanPolicyMapping.getPercentage();
        
            
                            
            
                
                String Position = beanPolicyMapping.getPosition();
        
            
                            
            
                
                String PLP = beanPolicyMapping.getPlp();
        
            
                            
            
                
                String queueName = beanPolicyMapping.getQueuename();
        
            
                            
            
                
                String CoSName = beanPolicyMapping.getCosname();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="PolicyMappingApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="PolicyMappingApplicationResources" property="TClassName"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="ProfileName"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="Exp"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="Dscp"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="Percentage"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="Position"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="PLP"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="queueName"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="CoSName"/>
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
                <bean:message bundle="PolicyMappingApplicationResources" key="field.tclassname.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="tclassname" value="<%= TClassName %>"/>
                                                        <html:text disabled="true" property="tclassname" size="24" value="<%= TClassName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PolicyMappingApplicationResources" key="field.tclassname.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PolicyMappingApplicationResources" key="field.profilename.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="profilename" value="<%= ProfileName %>"/>
                                                        <html:text disabled="true" property="profilename" size="24" value="<%= ProfileName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PolicyMappingApplicationResources" key="field.profilename.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PolicyMappingApplicationResources" key="field.exp.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="exp" size="24" value="<%= Exp %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PolicyMappingApplicationResources" key="field.exp.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PolicyMappingApplicationResources" key="field.dscp.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dscp" size="24" value="<%= Dscp %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PolicyMappingApplicationResources" key="field.dscp.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PolicyMappingApplicationResources" key="field.percentage.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="percentage" size="24" value="<%= Percentage %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PolicyMappingApplicationResources" key="field.percentage.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PolicyMappingApplicationResources" key="field.position.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="position" size="24" value="<%= Position %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PolicyMappingApplicationResources" key="field.position.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PolicyMappingApplicationResources" key="field.plp.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="plp" size="24" value="<%= PLP %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PolicyMappingApplicationResources" key="field.plp.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PolicyMappingApplicationResources" key="field.queuename.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="queuename" size="24" value="<%= queueName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PolicyMappingApplicationResources" key="field.queuename.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="PolicyMappingApplicationResources" key="field.cosname.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="cosname" size="24" value="<%= CoSName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="PolicyMappingApplicationResources" key="field.cosname.description"/>
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
