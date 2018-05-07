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
DLCIRangeForm form = (DLCIRangeForm) request.getAttribute("DLCIRangeForm");
if(form==null) {
 form=new DLCIRangeForm();
} 
    
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(DLCIRangeConstants.DATASOURCE);
String tabName = (String) request.getParameter(DLCIRangeConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.DLCIRangeFormSearch;
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
                    if(document.getElementsByName("dlcirangeid___hide")[0].checked) {
                            if(document.getElementsByName("usage___hide")[0].checked) {
                            if(document.getElementsByName("allocation___hide")[0].checked) {
                            if(document.getElementsByName("startvalue___hide")[0].checked) {
                            if(document.getElementsByName("endvalue___hide")[0].checked) {
                            if(document.getElementsByName("description___hide")[0].checked) {
                            if(document.getElementsByName("region___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="DLCIRangeApplicationResources" key="<%= DLCIRangeConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.DLCIRangeFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitDLCIRangeAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.DLCIRangeFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="DLCIRangeApplicationResources" key="<%= DLCIRangeConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(DLCIRangeConstants.USER) == null) {
  response.sendRedirect(DLCIRangeConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "dlcirangeid";
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
      String DLCIRangeID = form.getDlcirangeid();
            String Usage = form.getUsage();
            String Allocation = form.getAllocation();
            String StartValue = form.getStartvalue();
          String StartValue___ = form.getStartvalue___();
            String EndValue = form.getEndvalue();
          String EndValue___ = form.getEndvalue___();
            String Description = form.getDescription();
            String Region = form.getRegion();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DLCIRangeApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="DLCIRangeApplicationResources" property="DLCIRangeID"/>
        <html:errors bundle="DLCIRangeApplicationResources" property="Usage"/>
        <html:errors bundle="DLCIRangeApplicationResources" property="Allocation"/>
        <html:errors bundle="DLCIRangeApplicationResources" property="StartValue"/>
        <html:errors bundle="DLCIRangeApplicationResources" property="EndValue"/>
        <html:errors bundle="DLCIRangeApplicationResources" property="Description"/>
        <html:errors bundle="DLCIRangeApplicationResources" property="Region"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitDLCIRangeAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="dlcirangeid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.dlcirangeid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="dlcirangeid" size="16" value="<%= DLCIRangeID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.dlcirangeid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="usage___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.usage.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="usage" size="16" value="<%= Usage %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.usage.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="allocation___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.allocation.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="allocation" size="16" value="<%= Allocation %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.allocation.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="startvalue___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.startvalue.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="startvalue" size="16" value="<%= StartValue %>"/>
                                  -
                  <html:text property="startvalue___" size="16" value="<%= StartValue___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.startvalue.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="endvalue___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.endvalue.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="endvalue" size="16" value="<%= EndValue %>"/>
                                  -
                  <html:text property="endvalue___" size="16" value="<%= EndValue___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.endvalue.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="description___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.description.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="description" size="16" value="<%= Description %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.description.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="region___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.region.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="region" size="16" value="<%= Region %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DLCIRangeApplicationResources" key="field.region.description"/>
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
