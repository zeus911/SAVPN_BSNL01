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
EquipmentConfigurationForm form = (EquipmentConfigurationForm) request.getAttribute("EquipmentConfigurationForm");
if(form==null) {
 form=new EquipmentConfigurationForm();
} 
    
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(EquipmentConfigurationConstants.DATASOURCE);
String tabName = (String) request.getParameter(EquipmentConfigurationConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.EquipmentConfigurationFormSearch;
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
                    if(document.getElementsByName("equipmentid___hide")[0].checked) {
                            if(document.getElementsByName("timestamp___hide")[0].checked) {
                            if(document.getElementsByName("version___hide")[0].checked) {
                                      if(document.getElementsByName("lastaccesstime___hide")[0].checked) {
                            if(document.getElementsByName("memorytype___hide")[0].checked) {
                            if(document.getElementsByName("createdby___hide")[0].checked) {
                            if(document.getElementsByName("modifiedby___hide")[0].checked) {
                            if(document.getElementsByName("dirtyflag___hide")[0].checked) {
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
    alert("<bean:message bundle="EquipmentConfigurationApplicationResources" key="<%= EquipmentConfigurationConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.EquipmentConfigurationFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitEquipmentConfigurationAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.EquipmentConfigurationFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="EquipmentConfigurationApplicationResources" key="<%= EquipmentConfigurationConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(EquipmentConfigurationConstants.USER) == null) {
  response.sendRedirect(EquipmentConfigurationConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "equipmentid";
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
      String EquipmentID = form.getEquipmentid();
            String TimeStamp = form.getTimestamp();
            String Version = form.getVersion();
              String LastAccessTime = form.getLastaccesstime();
            String MemoryType = form.getMemorytype();
            String CreatedBy = form.getCreatedby();
            String ModifiedBy = form.getModifiedby();
            String DirtyFlag = form.getDirtyflag();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="EquipmentConfigurationApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="EquipmentConfigurationApplicationResources" property="EquipmentID"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="TimeStamp"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="Version"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="Data"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="LastAccessTime"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="MemoryType"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="CreatedBy"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="ModifiedBy"/>
        <html:errors bundle="EquipmentConfigurationApplicationResources" property="DirtyFlag"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitEquipmentConfigurationAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="equipmentid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.equipmentid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="equipmentid" size="16" value="<%= EquipmentID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.equipmentid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="timestamp___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.timestamp.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="timestamp" size="16" value="<%= TimeStamp %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.timestamp.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="version___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.version.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="version" size="16" value="<%= Version %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.version.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="lastaccesstime___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.lastaccesstime.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="lastaccesstime" size="16" value="<%= LastAccessTime %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.lastaccesstime.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="memorytype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.memorytype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="memorytype" size="16" value="<%= MemoryType %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.memorytype.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="createdby___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.createdby.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="createdby" size="16" value="<%= CreatedBy %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.createdby.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="modifiedby___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.modifiedby.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="modifiedby" size="16" value="<%= ModifiedBy %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.modifiedby.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="dirtyflag___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.dirtyflag.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="dirtyflag" size="16" value="<%= DirtyFlag %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="EquipmentConfigurationApplicationResources" key="field.dirtyflag.description"/>
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
