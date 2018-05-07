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
String datasource = (String) request.getParameter(InterfaceRecoveredConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitInterfaceRecoveredAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("sourcetpid") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                    _location_ = "targettpid";
                              }

%>

<html>
  <head>
    <title><bean:message bundle="InterfaceRecoveredApplicationResources" key="<%= InterfaceRecoveredConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.InterfaceRecoveredForm.action = '/activator<%=moduleConfig%>/UpdateFormInterfaceRecoveredAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.InterfaceRecoveredForm.submit();
    }
    function performCommit()
    {
      window.document.InterfaceRecoveredForm.action = '/activator<%=moduleConfig%>/UpdateCommitInterfaceRecoveredAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.InterfaceRecoveredForm.submit();
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
com.hp.ov.activator.vpn.inventory.InterfaceRecovered beanInterfaceRecovered = (com.hp.ov.activator.vpn.inventory.InterfaceRecovered) request.getAttribute(InterfaceRecoveredConstants.INTERFACERECOVERED_BEAN);
if(beanInterfaceRecovered==null)
   beanInterfaceRecovered = (com.hp.ov.activator.vpn.inventory.InterfaceRecovered) request.getSession().getAttribute(InterfaceRecoveredConstants.INTERFACERECOVERED_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
InterfaceRecoveredForm form = (InterfaceRecoveredForm) request.getAttribute("InterfaceRecoveredForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String SourceTPID = beanInterfaceRecovered.getSourcetpid();
        
            
                            
            
                
                String TargetTPID = beanInterfaceRecovered.getTargettpid();
        
            
                            
            
                
              String Total = "" + beanInterfaceRecovered.getTotal();
              Total = (Total != null && !(Total.trim().equals(""))) ? nfA.format(beanInterfaceRecovered.getTotal()) : "";
          
            
            if( beanInterfaceRecovered.getTotal()==Integer.MIN_VALUE)
         Total = "";
                            
            
                
              String Success = "" + beanInterfaceRecovered.getSuccess();
              Success = (Success != null && !(Success.trim().equals(""))) ? nfA.format(beanInterfaceRecovered.getSuccess()) : "";
          
            
            if( beanInterfaceRecovered.getSuccess()==Integer.MIN_VALUE)
         Success = "";
                            
            
                
              String Failed = "" + beanInterfaceRecovered.getFailed();
              Failed = (Failed != null && !(Failed.trim().equals(""))) ? nfA.format(beanInterfaceRecovered.getFailed()) : "";
          
            
            if( beanInterfaceRecovered.getFailed()==Integer.MIN_VALUE)
         Failed = "";
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="InterfaceRecoveredApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="InterfaceRecoveredApplicationResources" property="SourceTPID"/>
        <html:errors bundle="InterfaceRecoveredApplicationResources" property="TargetTPID"/>
        <html:errors bundle="InterfaceRecoveredApplicationResources" property="Total"/>
        <html:errors bundle="InterfaceRecoveredApplicationResources" property="Success"/>
        <html:errors bundle="InterfaceRecoveredApplicationResources" property="Failed"/>
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
                <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.sourcetpid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="sourcetpid" value="<%= SourceTPID %>"/>
                                                        <html:text disabled="true" property="sourcetpid" size="24" value="<%= SourceTPID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.sourcetpid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.targettpid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="targettpid" size="24" value="<%= TargetTPID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.targettpid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.total.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="total" size="24" value="<%= Total %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.total.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.success.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="success" size="24" value="<%= Success %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.success.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.failed.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="failed" size="24" value="<%= Failed %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.failed.description"/>
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
