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
SchedulingPolicyForm form = (SchedulingPolicyForm) request.getAttribute("SchedulingPolicyForm");
if(form==null) {
 form=new SchedulingPolicyForm();
} 
    
      
                 java.text.SimpleDateFormat sdfStartingTime = new java.text.SimpleDateFormat("dd-MM-yyyy");
            String sdfStartingTimeDesc = "Format: [" + sdfStartingTime.toPattern() + "]. Example: [" + sdfStartingTime.format(new Date()) + "]";
      
      
      
  
String datasource = (String) request.getParameter(SchedulingPolicyConstants.DATASOURCE);
String tabName = (String) request.getParameter(SchedulingPolicyConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.SchedulingPolicyFormSearch;
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
                    if(document.getElementsByName("schedulingpolicyname___hide")[0].checked) {
                            if(document.getElementsByName("startingtime___hide")[0].checked) {
                            if(document.getElementsByName("periodicity___hide")[0].checked) {
                            if(document.getElementsByName("refreshinterval___hide")[0].checked) {
                            if(document.getElementsByName("backupsnumber___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="SchedulingPolicyApplicationResources" key="<%= SchedulingPolicyConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.SchedulingPolicyFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitSchedulingPolicyAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.SchedulingPolicyFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="SchedulingPolicyApplicationResources" key="<%= SchedulingPolicyConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(SchedulingPolicyConstants.USER) == null) {
  response.sendRedirect(SchedulingPolicyConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "schedulingpolicyname";
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
      String SchedulingPolicyName = form.getSchedulingpolicyname();
            String StartingTime = form.getStartingtime();
          String StartingTime___ = form.getStartingtime___();
            String Periodicity = form.getPeriodicity();
          String Periodicity___ = form.getPeriodicity___();
            String RefreshInterval = form.getRefreshinterval();
          String RefreshInterval___ = form.getRefreshinterval___();
            String BackupsNumber = form.getBackupsnumber();
          String BackupsNumber___ = form.getBackupsnumber___();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="SchedulingPolicyApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="SchedulingPolicyApplicationResources" property="SchedulingPolicyName"/>
        <html:errors bundle="SchedulingPolicyApplicationResources" property="StartingTime"/>
        <html:errors bundle="SchedulingPolicyApplicationResources" property="Periodicity"/>
        <html:errors bundle="SchedulingPolicyApplicationResources" property="RefreshInterval"/>
        <html:errors bundle="SchedulingPolicyApplicationResources" property="BackupsNumber"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitSchedulingPolicyAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="schedulingpolicyname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SchedulingPolicyApplicationResources" key="field.schedulingpolicyname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="schedulingpolicyname" size="16" value="<%= SchedulingPolicyName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SchedulingPolicyApplicationResources" key="field.schedulingpolicyname.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="startingtime___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SchedulingPolicyApplicationResources" key="field.startingtime.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="startingtime" size="16" value="<%= StartingTime %>"/>
                                  -
                  <html:text property="startingtime___" size="16" value="<%= StartingTime___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SchedulingPolicyApplicationResources" key="field.startingtime.description"/>
              <%=sdfStartingTimeDesc%>            </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="periodicity___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SchedulingPolicyApplicationResources" key="field.periodicity.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="periodicity" size="16" value="<%= Periodicity %>"/>
                                  -
                  <html:text property="periodicity___" size="16" value="<%= Periodicity___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SchedulingPolicyApplicationResources" key="field.periodicity.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="refreshinterval___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SchedulingPolicyApplicationResources" key="field.refreshinterval.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="refreshinterval" size="16" value="<%= RefreshInterval %>"/>
                                  -
                  <html:text property="refreshinterval___" size="16" value="<%= RefreshInterval___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SchedulingPolicyApplicationResources" key="field.refreshinterval.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="backupsnumber___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SchedulingPolicyApplicationResources" key="field.backupsnumber.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="backupsnumber" size="16" value="<%= BackupsNumber %>"/>
                                  -
                  <html:text property="backupsnumber___" size="16" value="<%= BackupsNumber___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SchedulingPolicyApplicationResources" key="field.backupsnumber.description"/>
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
