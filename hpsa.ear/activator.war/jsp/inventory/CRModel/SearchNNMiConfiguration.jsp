<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.nnm.common.*,
        com.hp.ov.activator.inventory.CRModel.*,
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
NNMiConfigurationForm form = (NNMiConfigurationForm) request.getAttribute("NNMiConfigurationForm");
if(form==null) {
 form=new NNMiConfigurationForm();
} 
    
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(NNMiConfigurationConstants.DATASOURCE);
String tabName = (String) request.getParameter(NNMiConfigurationConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.NNMiConfigurationFormSearch;
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
                    if(document.getElementsByName("id___hide")[0].checked) {
                            if(document.getElementsByName("protocol___hide")[0].checked) {
                            if(document.getElementsByName("hostname___hide")[0].checked) {
                            if(document.getElementsByName("port___hide")[0].checked) {
                            if(document.getElementsByName("rediscover_enable___hide")[0].checked) {
                            if(document.getElementsByName("customattributes_enable___hide")[0].checked) {
                            if(document.getElementsByName("interfacegroup_enable___hide")[0].checked) {
                            if(document.getElementsByName("enable_cl___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="NNMiConfigurationApplicationResources" key="<%= NNMiConfigurationConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.NNMiConfigurationFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitNNMiConfigurationAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.NNMiConfigurationFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="NNMiConfigurationApplicationResources" key="<%= NNMiConfigurationConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(NNMiConfigurationConstants.USER) == null) {
  response.sendRedirect(NNMiConfigurationConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "id";
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
      String Id = form.getId();
            String Protocol = form.getProtocol();
            String Hostname = form.getHostname();
            String Port = form.getPort();
            String Rediscover_enable = form.getRediscover_enable();
            String CustomAttributes_enable = form.getCustomattributes_enable();
            String InterfaceGroup_enable = form.getInterfacegroup_enable();
            String enable_cl = form.getEnable_cl();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="NNMiConfigurationApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="NNMiConfigurationApplicationResources" property="Id"/>
        <html:errors bundle="NNMiConfigurationApplicationResources" property="Protocol"/>
        <html:errors bundle="NNMiConfigurationApplicationResources" property="Hostname"/>
        <html:errors bundle="NNMiConfigurationApplicationResources" property="Port"/>
        <html:errors bundle="NNMiConfigurationApplicationResources" property="Rediscover_enable"/>
        <html:errors bundle="NNMiConfigurationApplicationResources" property="CustomAttributes_enable"/>
        <html:errors bundle="NNMiConfigurationApplicationResources" property="InterfaceGroup_enable"/>
        <html:errors bundle="NNMiConfigurationApplicationResources" property="enable_cl"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitNNMiConfigurationAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="id" size="16" value="<%= Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="protocol___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.protocol.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="protocol" size="16" value="<%= Protocol %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.protocol.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="hostname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.hostname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="hostname" size="16" value="<%= Hostname %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.hostname.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="port___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.port.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="port" size="16" value="<%= Port %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.port.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="rediscover_enable___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.rediscover_enable.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="rediscover_enable" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="rediscover_enable" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="rediscover_enable" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.rediscover_enable.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="customattributes_enable___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.customattributes_enable.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="customattributes_enable" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="customattributes_enable" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="customattributes_enable" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.customattributes_enable.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="interfacegroup_enable___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.interfacegroup_enable.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="interfacegroup_enable" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="interfacegroup_enable" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="interfacegroup_enable" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.interfacegroup_enable.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="enable_cl___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.enable_cl.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="enable_cl" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="enable_cl" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="enable_cl" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="NNMiConfigurationApplicationResources" key="field.enable_cl.description"/>
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
