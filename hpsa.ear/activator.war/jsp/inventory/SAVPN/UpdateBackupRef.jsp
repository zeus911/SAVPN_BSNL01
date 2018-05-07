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
String datasource = (String) request.getParameter(BackupRefConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitBackupRefAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("eqid") + "||" + request.getParameter("creationtime") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                          _location_ = "createdby";
                              }

%>

<html>
  <head>
    <title><bean:message bundle="BackupRefApplicationResources" key="<%= BackupRefConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.BackupRefForm.action = '/activator<%=moduleConfig%>/UpdateFormBackupRefAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.BackupRefForm.submit();
    }
    function performCommit()
    {
      window.document.BackupRefForm.action = '/activator<%=moduleConfig%>/UpdateCommitBackupRefAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.BackupRefForm.submit();
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
com.hp.ov.activator.vpn.inventory.BackupRef beanBackupRef = (com.hp.ov.activator.vpn.inventory.BackupRef) request.getAttribute(BackupRefConstants.BACKUPREF_BEAN);
if(beanBackupRef==null)
   beanBackupRef = (com.hp.ov.activator.vpn.inventory.BackupRef) request.getSession().getAttribute(BackupRefConstants.BACKUPREF_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
BackupRefForm form = (BackupRefForm) request.getAttribute("BackupRefForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String eqid = beanBackupRef.getEqid();
        
            
                            
            
                
              String creationtime = (beanBackupRef.getCreationtime() == null) ? "" : beanBackupRef.getCreationtime();
      creationtime = StringFacility.replaceAllByHTMLCharacter(creationtime);
                java.text.SimpleDateFormat sdfcreationtime = new java.text.SimpleDateFormat("dd-MM-yyyy");
                    String sdfcreationtimeDesc = "Format: [" + sdfcreationtime.toPattern() + "]. Example: [" + sdfcreationtime.format(new Date()) + "]";
          sdfcreationtimeDesc = StringFacility.replaceAllByHTMLCharacter(sdfcreationtimeDesc);
    
            
                            
            
                
                String createdby = beanBackupRef.getCreatedby();
        
            
                            
            
                
              String configtime = (beanBackupRef.getConfigtime() == null) ? "" : beanBackupRef.getConfigtime();
      configtime = StringFacility.replaceAllByHTMLCharacter(configtime);
                java.text.SimpleDateFormat sdfconfigtime = new java.text.SimpleDateFormat("dd-MM-yyyy");
                    String sdfconfigtimeDesc = "Format: [" + sdfconfigtime.toPattern() + "]. Example: [" + sdfconfigtime.format(new Date()) + "]";
          sdfconfigtimeDesc = StringFacility.replaceAllByHTMLCharacter(sdfconfigtimeDesc);
    
            
                            
            
                
                String retrievalname = beanBackupRef.getRetrievalname();
        
            
                            
            
                
                String comments = beanBackupRef.getComments();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="BackupRefApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="BackupRefApplicationResources" property="eqid"/>
        <html:errors bundle="BackupRefApplicationResources" property="creationtime"/>
        <html:errors bundle="BackupRefApplicationResources" property="createdby"/>
        <html:errors bundle="BackupRefApplicationResources" property="configtime"/>
        <html:errors bundle="BackupRefApplicationResources" property="retrievalname"/>
        <html:errors bundle="BackupRefApplicationResources" property="comments"/>
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
                <bean:message bundle="BackupRefApplicationResources" key="field.eqid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="eqid" value="<%= eqid %>"/>
                                                        <html:text disabled="true" property="eqid" size="24" value="<%= eqid %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="BackupRefApplicationResources" key="field.eqid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="BackupRefApplicationResources" key="field.creationtime.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="creationtime" value="<%= creationtime %>"/>
                                                        <html:text disabled="true" property="creationtime" size="24" value="<%= creationtime %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="BackupRefApplicationResources" key="field.creationtime.description"/>
                <%=sdfcreationtimeDesc%>                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="BackupRefApplicationResources" key="field.createdby.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="createdby" size="24" value="<%= createdby %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="BackupRefApplicationResources" key="field.createdby.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="BackupRefApplicationResources" key="field.configtime.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="configtime" size="24" value="<%= configtime %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="BackupRefApplicationResources" key="field.configtime.description"/>
                <%=sdfconfigtimeDesc%>                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="BackupRefApplicationResources" key="field.retrievalname.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="retrievalname" size="24" value="<%= retrievalname %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="BackupRefApplicationResources" key="field.retrievalname.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="BackupRefApplicationResources" key="field.comments.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="comments" size="24" value="<%= comments %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="BackupRefApplicationResources" key="field.comments.description"/>
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
