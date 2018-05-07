<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors " %>

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
ISPForm form = (ISPForm) request.getAttribute("ISPForm");
if(form==null) {
 form=new ISPForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(ISPConstants.DATASOURCE);
String tabName = (String) request.getParameter(ISPConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.ISPFormSearch;
var formEl = formObj.elements;
for (var i=0; i<formEl.length; i++)
{
var element = formEl[i];
if (element.type == 'submit') { continue; }
if (element.type == 'reset') { continue; }
if (element.type == 'button') { continue; }
if (element.type == 'hidden') { continue; }
if (element.type == 'text') { element.value = ''; }
if (element.type == 'textarea') { element.value = ''; }
if (element.type == 'checkbox') {  element.checked = false;  }
if (element.type == 'radio') {if(element.value == '') element.checked=true; else element.checked=false;}
if (element.type == 'select-multiple') { element.selectedIndex = -1; }
if (element.type == 'select-one') { element.selectedIndex = -1; }
}
}
  function performCommit() {
  var checkfalse=false;
                    if(document.getElementsByName("idname___hide")[0].checked) {
                            if(document.getElementsByName("spname___hide")[0].checked) {
                            if(document.getElementsByName("ip___hide")[0].checked) {
                            if(document.getElementsByName("backupdirectory___hide")[0].checked) {
                            if(document.getElementsByName("asn___hide")[0].checked) {
                            if(document.getElementsByName("adminvpnenabled___hide")[0].checked) {
                            if(document.getElementsByName("errorqueue___hide")[0].checked) {
                            if(document.getElementsByName("notificationqueue___hide")[0].checked) {
                            if(document.getElementsByName("confirmationqueue___hide")[0].checked) {
                            if(document.getElementsByName("timedservicequeue___hide")[0].checked) {
                            if(document.getElementsByName("timeout___hide")[0].checked) {
                            if(document.getElementsByName("version___hide")[0].checked) {
                            if(document.getElementsByName("demomode___hide")[0].checked) {
                            if(document.getElementsByName("naparentgroupname___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="ISPApplicationResources" key="<%= ISPConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.ISPFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitISPAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.ISPFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="ISPApplicationResources" key="<%= ISPConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(ISPConstants.USER) == null) {
  response.sendRedirect(ISPConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "idname";
                                %>

    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
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
%>
    }
    </script>
  </head>

  <body style="overflow:auto;" onload="init();">

<%
      String IDName = form.getIdname();
            String SPName = form.getSpname();
            String IP = form.getIp();
            String BackupDirectory = form.getBackupdirectory();
            String ASN = form.getAsn();
            String AdminVPNEnabled = form.getAdminvpnenabled();
            String ErrorQueue = form.getErrorqueue();
            String NotificationQueue = form.getNotificationqueue();
            String ConfirmationQueue = form.getConfirmationqueue();
            String TimedServiceQueue = form.getTimedservicequeue();
            String Timeout = form.getTimeout();
          String Timeout___ = form.getTimeout___();
            String Version = form.getVersion();
            String DemoMode = form.getDemomode();
            String NAParentGroupName = form.getNaparentgroupname();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="ISPApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="ISPApplicationResources" property="IDName"/>
        <html:errors bundle="ISPApplicationResources" property="SPName"/>
        <html:errors bundle="ISPApplicationResources" property="IP"/>
        <html:errors bundle="ISPApplicationResources" property="BackupDirectory"/>
        <html:errors bundle="ISPApplicationResources" property="ASN"/>
        <html:errors bundle="ISPApplicationResources" property="AdminVPNEnabled"/>
        <html:errors bundle="ISPApplicationResources" property="ErrorQueue"/>
        <html:errors bundle="ISPApplicationResources" property="NotificationQueue"/>
        <html:errors bundle="ISPApplicationResources" property="ConfirmationQueue"/>
        <html:errors bundle="ISPApplicationResources" property="TimedServiceQueue"/>
        <html:errors bundle="ISPApplicationResources" property="Timeout"/>
        <html:errors bundle="ISPApplicationResources" property="Version"/>
        <html:errors bundle="ISPApplicationResources" property="DemoMode"/>
        <html:errors bundle="ISPApplicationResources" property="NAParentGroupName"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitISPAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

  <html:form action="<%=searchFormAction%>" style="text-align:center;">
    <table:table>
      <table:header>
        <table:cell>
          <bean:message bundle="InventoryResources" key="hide.heading"/>
        </table:cell>

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

                        <table:row>
            <table:cell>
              <center>
                <html:checkbox property="idname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.idname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="idname" size="16" value="<%= IDName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.idname.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="spname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.spname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="spname" size="16" value="<%= SPName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.spname.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ip___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.ip.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ip" size="16" value="<%= IP %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.ip.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="backupdirectory___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.backupdirectory.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="backupdirectory" size="16" value="<%= BackupDirectory %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.backupdirectory.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="asn___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.asn.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="asn" size="16" value="<%= ASN %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.asn.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="adminvpnenabled___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.adminvpnenabled.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="adminvpnenabled" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="adminvpnenabled" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="adminvpnenabled" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.adminvpnenabled.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="errorqueue___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.errorqueue.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="errorqueue" size="16" value="<%= ErrorQueue %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.errorqueue.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="notificationqueue___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.notificationqueue.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="notificationqueue" size="16" value="<%= NotificationQueue %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.notificationqueue.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="confirmationqueue___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.confirmationqueue.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="confirmationqueue" size="16" value="<%= ConfirmationQueue %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.confirmationqueue.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="timedservicequeue___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.timedservicequeue.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="timedservicequeue" size="16" value="<%= TimedServiceQueue %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.timedservicequeue.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="timeout___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.timeout.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="timeout" size="16" value="<%= Timeout %>"/>
                                  -
                  <html:text property="timeout___" size="16" value="<%= Timeout___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.timeout.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="version___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.version.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="version" size="16" value="<%= Version %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.version.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="demomode___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.demomode.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="demomode" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="demomode" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="demomode" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.demomode.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="naparentgroupname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.naparentgroupname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="naparentgroupname" size="16" value="<%= NAParentGroupName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ISPApplicationResources" key="field.naparentgroupname.description"/>
                          </table:cell>
          </table:row>
              
  
            <table:row>
              <table:cell colspan="4" align="center">
              <br>
              </table:cell>
            </table:row>
            <table:row>
              <table:cell colspan="4" align="center">
              <input type="button" value="<bean:message bundle="InventoryResources" key="search.submit.button"/>" name="enviando" class="ButtonSubmit" onclick="performCommit();">&nbsp;
              <input type="button" value="<bean:message bundle="InventoryResources" key="search.reset.button"/>" class="ButtonReset" onclick="clearForm();">
              </table:cell>
            </table:row>
    </table:table>

  </html:form>

  </body>

</html>
