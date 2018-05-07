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
String datasource = (String) request.getParameter(RateLimitConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitRateLimitAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("ratelimitname") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                    _location_ = "description";
                                    }

%>

<html>
  <head>
    <title><bean:message bundle="RateLimitApplicationResources" key="<%= RateLimitConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.RateLimitForm.action = '/activator<%=moduleConfig%>/UpdateFormRateLimitAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.RateLimitForm.submit();
    }
    function performCommit()
    {
      window.document.RateLimitForm.action = '/activator<%=moduleConfig%>/UpdateCommitRateLimitAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.RateLimitForm.submit();
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
com.hp.ov.activator.vpn.inventory.RateLimit beanRateLimit = (com.hp.ov.activator.vpn.inventory.RateLimit) request.getAttribute(RateLimitConstants.RATELIMIT_BEAN);
if(beanRateLimit==null)
   beanRateLimit = (com.hp.ov.activator.vpn.inventory.RateLimit) request.getSession().getAttribute(RateLimitConstants.RATELIMIT_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
RateLimitForm form = (RateLimitForm) request.getAttribute("RateLimitForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String RateLimitName = beanRateLimit.getRatelimitname();
        
            
                            
            
                
                String Description = beanRateLimit.getDescription();
        
            
                            
            
                
              String BurstMaximum = "" + beanRateLimit.getBurstmaximum();
              BurstMaximum = (BurstMaximum != null && !(BurstMaximum.trim().equals(""))) ? nfA.format(beanRateLimit.getBurstmaximum()) : "";
          
            
                            if( beanRateLimit.getBurstmaximum()==Long.MIN_VALUE)
         BurstMaximum = "";
            
            
                
              String BurstNormal = "" + beanRateLimit.getBurstnormal();
              BurstNormal = (BurstNormal != null && !(BurstNormal.trim().equals(""))) ? nfA.format(beanRateLimit.getBurstnormal()) : "";
          
            
                            if( beanRateLimit.getBurstnormal()==Long.MIN_VALUE)
         BurstNormal = "";
            
            
                
              String AverageBW = "" + beanRateLimit.getAveragebw();
              AverageBW = (AverageBW != null && !(AverageBW.trim().equals(""))) ? nfA.format(beanRateLimit.getAveragebw()) : "";
          
            
                            if( beanRateLimit.getAveragebw()==Long.MIN_VALUE)
         AverageBW = "";
            
            
                
                String Compliant = beanRateLimit.getCompliant();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="RateLimitApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="RateLimitApplicationResources" property="RateLimitName"/>
        <html:errors bundle="RateLimitApplicationResources" property="Description"/>
        <html:errors bundle="RateLimitApplicationResources" property="BurstMaximum"/>
        <html:errors bundle="RateLimitApplicationResources" property="BurstNormal"/>
        <html:errors bundle="RateLimitApplicationResources" property="AverageBW"/>
        <html:errors bundle="RateLimitApplicationResources" property="Compliant"/>
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
                <bean:message bundle="RateLimitApplicationResources" key="field.ratelimitname.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="ratelimitname" value="<%= RateLimitName %>"/>
                                                        <html:text disabled="true" property="ratelimitname" size="24" value="<%= RateLimitName %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="RateLimitApplicationResources" key="field.ratelimitname.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="RateLimitApplicationResources" key="field.description.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="description" size="24" value="<%= Description %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="RateLimitApplicationResources" key="field.description.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="RateLimitApplicationResources" key="field.burstmaximum.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="burstmaximum" size="24" value="<%= BurstMaximum %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="RateLimitApplicationResources" key="field.burstmaximum.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="RateLimitApplicationResources" key="field.burstnormal.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="burstnormal" size="24" value="<%= BurstNormal %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="RateLimitApplicationResources" key="field.burstnormal.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="RateLimitApplicationResources" key="field.averagebw.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="averagebw" size="24" value="<%= AverageBW %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="RateLimitApplicationResources" key="field.averagebw.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="RateLimitApplicationResources" key="field.compliant.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="compliant" value="<%= Compliant %>"/>
                                                          <%
                        String selValue=null;                                    
                        if(Compliant==null||Compliant.trim().equals(""))
                           selValue="compliant";
                        else
                        selValue=Compliant.toString();    
                          %>

                    <html:select disabled="true" property="compliant" value="<%= selValue %>" >
                                            <html:option value="compliant" >compliant</html:option>
                                            <html:option value="partial compliant" >partial compliant</html:option>
                                            <html:option value="non compliant" >non compliant</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="RateLimitApplicationResources" key="field.compliant.description"/>
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
