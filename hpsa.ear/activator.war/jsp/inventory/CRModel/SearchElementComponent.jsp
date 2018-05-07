<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.cr.inventory.*,
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
ElementComponentForm form = (ElementComponentForm) request.getAttribute("ElementComponentForm");
if(form==null) {
 form=new ElementComponentForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
      
      
                 java.text.SimpleDateFormat sdfNNMi_LastUpdate = new java.text.SimpleDateFormat("dd-MM-yyyy");
            String sdfNNMi_LastUpdateDesc = "Format: [" + sdfNNMi_LastUpdate.toPattern() + "]. Example: [" + sdfNNMi_LastUpdate.format(new Date()) + "]";
      
  
String datasource = (String) request.getParameter(ElementComponentConstants.DATASOURCE);
String tabName = (String) request.getParameter(ElementComponentConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.ElementComponentFormSearch;
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
                    if(document.getElementsByName("elementcomponentid___hide")[0].checked) {
                            if(document.getElementsByName("ne_id___hide")[0].checked) {
                            if(document.getElementsByName("parentec_id___hide")[0].checked) {
                            if(document.getElementsByName("name___hide")[0].checked) {
                            if(document.getElementsByName("description___hide")[0].checked) {
                            if(document.getElementsByName("state___hide")[0].checked) {
                            if(document.getElementsByName("ectype___hide")[0].checked) {
                            if(document.getElementsByName("type___hide")[0].checked) {
                                      if(document.getElementsByName("componentnumber___hide")[0].checked) {
                            if(document.getElementsByName("capacity___hide")[0].checked) {
                            if(document.getElementsByName("nnmi_uuid___hide")[0].checked) {
                            if(document.getElementsByName("nnmi_id___hide")[0].checked) {
                            if(document.getElementsByName("nnmi_lastupdate___hide")[0].checked) {
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
                      if(checkfalse){
    alert("<bean:message bundle="ElementComponentApplicationResources" key="<%= ElementComponentConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.ElementComponentFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitElementComponentAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.ElementComponentFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="ElementComponentApplicationResources" key="<%= ElementComponentConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(ElementComponentConstants.USER) == null) {
  response.sendRedirect(ElementComponentConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "elementcomponentid";
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
      String ElementComponentId = form.getElementcomponentid();
            String NE_Id = form.getNe_id();
            String ParentEC_Id = form.getParentec_id();
            String Name = form.getName();
            String Description = form.getDescription();
            String State = form.getState();
            String ECType = form.getEctype();
            String Type = form.getType();
              String ComponentNumber = form.getComponentnumber();
            String Capacity = form.getCapacity();
          String Capacity___ = form.getCapacity___();
            String NNMi_UUId = form.getNnmi_uuid();
            String NNMi_Id = form.getNnmi_id();
            String NNMi_LastUpdate = form.getNnmi_lastupdate();
          String NNMi_LastUpdate___ = form.getNnmi_lastupdate___();
        
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="ElementComponentApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="ElementComponentApplicationResources" property="ElementComponentId"/>
        <html:errors bundle="ElementComponentApplicationResources" property="NE_Id"/>
        <html:errors bundle="ElementComponentApplicationResources" property="ParentEC_Id"/>
        <html:errors bundle="ElementComponentApplicationResources" property="Name"/>
        <html:errors bundle="ElementComponentApplicationResources" property="Description"/>
        <html:errors bundle="ElementComponentApplicationResources" property="State"/>
        <html:errors bundle="ElementComponentApplicationResources" property="ECType"/>
        <html:errors bundle="ElementComponentApplicationResources" property="Type"/>
          <html:errors bundle="ElementComponentApplicationResources" property="ComponentNumber"/>
        <html:errors bundle="ElementComponentApplicationResources" property="Capacity"/>
        <html:errors bundle="ElementComponentApplicationResources" property="NNMi_UUId"/>
        <html:errors bundle="ElementComponentApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="ElementComponentApplicationResources" property="NNMi_LastUpdate"/>
        <html:errors bundle="ElementComponentApplicationResources" property="__count"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitElementComponentAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="elementcomponentid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.elementcomponentid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="elementcomponentid" size="16" value="<%= ElementComponentId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.elementcomponentid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ne_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.ne_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ne_id" size="16" value="<%= NE_Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.ne_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="parentec_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.parentec_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="parentec_id" size="16" value="<%= ParentEC_Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.parentec_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="name___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.name.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="name" size="16" value="<%= Name %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.name.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="description___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.description.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="description" size="16" value="<%= Description %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.description.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="state___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.state.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="state" size="16" value="<%= State %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.state.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ectype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.ectype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ectype" size="16" value="<%= ECType %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.ectype.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="type___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.type.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="type" size="16" value="<%= Type %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.type.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="componentnumber___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.componentnumber.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="componentnumber" size="16" value="<%= ComponentNumber %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.componentnumber.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="capacity___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.capacity.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="capacity" size="16" value="<%= Capacity %>"/>
                                  -
                  <html:text property="capacity___" size="16" value="<%= Capacity___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.capacity.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="nnmi_uuid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.nnmi_uuid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="nnmi_uuid" size="16" value="<%= NNMi_UUId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.nnmi_uuid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="nnmi_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.nnmi_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="nnmi_id" size="16" value="<%= NNMi_Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.nnmi_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="nnmi_lastupdate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.nnmi_lastupdate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="nnmi_lastupdate" size="16" value="<%= NNMi_LastUpdate %>"/>
                                  -
                  <html:text property="nnmi_lastupdate___" size="16" value="<%= NNMi_LastUpdate___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ElementComponentApplicationResources" key="field.nnmi_lastupdate.description"/>
              <%=sdfNNMi_LastUpdateDesc%>            </table:cell>
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
