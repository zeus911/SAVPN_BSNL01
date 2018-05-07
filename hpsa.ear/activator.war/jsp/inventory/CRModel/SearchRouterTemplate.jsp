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
RouterTemplateForm form = (RouterTemplateForm) request.getAttribute("RouterTemplateForm");
if(form==null) {
 form=new RouterTemplateForm();
} 
    
      
      
      
      
  
String datasource = (String) request.getParameter(RouterTemplateConstants.DATASOURCE);
String tabName = (String) request.getParameter(RouterTemplateConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.RouterTemplateFormSearch;
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
                    if(document.getElementsByName("elementtypegroupname___hide")[0].checked) {
                            if(document.getElementsByName("osversiongroup___hide")[0].checked) {
                            if(document.getElementsByName("name___hide")[0].checked) {
                            if(document.getElementsByName("parser___hide")[0].checked) {
                            if(document.getElementsByName("clitemplate___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="RouterTemplateApplicationResources" key="<%= RouterTemplateConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.RouterTemplateFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitRouterTemplateAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.RouterTemplateFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="RouterTemplateApplicationResources" key="<%= RouterTemplateConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(RouterTemplateConstants.USER) == null) {
  response.sendRedirect(RouterTemplateConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "elementtypegroupname";
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
      String ElementTypeGroupName = form.getElementtypegroupname();
            String OSVersionGroup = form.getOsversiongroup();
            String Name = form.getName();
            String Parser = form.getParser();
            String CLITemplate = form.getClitemplate();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="RouterTemplateApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="RouterTemplateApplicationResources" property="ElementTypeGroupName"/>
        <html:errors bundle="RouterTemplateApplicationResources" property="OSVersionGroup"/>
        <html:errors bundle="RouterTemplateApplicationResources" property="Name"/>
        <html:errors bundle="RouterTemplateApplicationResources" property="Parser"/>
        <html:errors bundle="RouterTemplateApplicationResources" property="CLITemplate"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitRouterTemplateAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="elementtypegroupname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="RouterTemplateApplicationResources" key="field.elementtypegroupname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="elementtypegroupname" size="16" value="<%= ElementTypeGroupName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="RouterTemplateApplicationResources" key="field.elementtypegroupname.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="osversiongroup___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="RouterTemplateApplicationResources" key="field.osversiongroup.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="osversiongroup" size="16" value="<%= OSVersionGroup %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="RouterTemplateApplicationResources" key="field.osversiongroup.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="name___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="RouterTemplateApplicationResources" key="field.name.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="name" size="16" value="<%= Name %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="RouterTemplateApplicationResources" key="field.name.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="parser___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="RouterTemplateApplicationResources" key="field.parser.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="parser" size="16" value="<%= Parser %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="RouterTemplateApplicationResources" key="field.parser.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="clitemplate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="RouterTemplateApplicationResources" key="field.clitemplate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="clitemplate" size="16" value="<%= CLITemplate %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="RouterTemplateApplicationResources" key="field.clitemplate.description"/>
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
