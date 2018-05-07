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
String datasource = (String) request.getParameter(EquipmentConfigurationConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitEquipmentConfigurationAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("equipmentid") + "||" + request.getParameter("timestamp") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                          _location_ = "version";
                                                }

%>

<html>
  <head>
    <title><bean:message bundle="EquipmentConfigurationApplicationResources" key="<%= EquipmentConfigurationConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.EquipmentConfigurationForm.action = '/activator<%=moduleConfig%>/UpdateFormEquipmentConfigurationAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.EquipmentConfigurationForm.submit();
    }
    function performCommit()
    {
      window.document.EquipmentConfigurationForm.action = '/activator<%=moduleConfig%>/UpdateCommitEquipmentConfigurationAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.EquipmentConfigurationForm.submit();
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
com.hp.ov.activator.vpn.inventory.EquipmentConfiguration beanEquipmentConfiguration = (com.hp.ov.activator.vpn.inventory.EquipmentConfiguration) request.getAttribute(EquipmentConfigurationConstants.EQUIPMENTCONFIGURATION_BEAN);
if(beanEquipmentConfiguration==null)
   beanEquipmentConfiguration = (com.hp.ov.activator.vpn.inventory.EquipmentConfiguration) request.getSession().getAttribute(EquipmentConfigurationConstants.EQUIPMENTCONFIGURATION_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
EquipmentConfigurationForm form = (EquipmentConfigurationForm) request.getAttribute("EquipmentConfigurationForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String EquipmentID = beanEquipmentConfiguration.getEquipmentid();
        
            
                            
            
                
                String TimeStamp = beanEquipmentConfiguration.getTimestamp();
        
            
                            
            
                
                String Version = beanEquipmentConfiguration.getVersion();
        
            
                            
            
                
                String Data = beanEquipmentConfiguration.getData();
        
            
                            
            
                
                String LastAccessTime = beanEquipmentConfiguration.getLastaccesstime();
        
            
                            
            
                
                String MemoryType = beanEquipmentConfiguration.getMemorytype();
        
            
                            
            
                
                String CreatedBy = beanEquipmentConfiguration.getCreatedby();
        
            
                            
            
                
                String ModifiedBy = beanEquipmentConfiguration.getModifiedby();
        
            
                            
            
                
                String DirtyFlag = beanEquipmentConfiguration.getDirtyflag();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="EquipmentConfigurationApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="EquipmentConfigurationApplicationResources" property="EquipmentID"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="TimeStamp"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="Version"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="Data"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="LastAccessTime"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="MemoryType"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="CreatedBy"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="ModifiedBy"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="DirtyFlag"/>
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
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.equipmentid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="equipmentid" value="<%= EquipmentID %>"/>
                                                        <html:text disabled="true" property="equipmentid" size="24" value="<%= EquipmentID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.equipmentid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.timestamp.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="timestamp" value="<%= TimeStamp %>"/>
                                                        <html:text disabled="true" property="timestamp" size="24" value="<%= TimeStamp %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.timestamp.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.version.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="version" size="24" value="<%= Version %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.version.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.data.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:textarea  property="data" cols="60" rows="10"
                          value="<%= (Data == null ? \"\" : Data ) %>" style="resize:true;"/>                  
                                                </table:cell>
              <table:cell>
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.data.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.lastaccesstime.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="lastaccesstime" size="24" value="<%= LastAccessTime %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.lastaccesstime.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.memorytype.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="memorytype" size="24" value="<%= MemoryType %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.memorytype.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.createdby.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="createdby" size="24" value="<%= CreatedBy %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.createdby.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.modifiedby.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="modifiedby" size="24" value="<%= ModifiedBy %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.modifiedby.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.dirtyflag.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="dirtyflag" size="24" value="<%= DirtyFlag %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.dirtyflag.description"/>
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
