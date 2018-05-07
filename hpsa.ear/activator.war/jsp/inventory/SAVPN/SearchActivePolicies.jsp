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
ActivePoliciesForm form = (ActivePoliciesForm) request.getAttribute("ActivePoliciesForm");
if(form==null) {
 form=new ActivePoliciesForm();
} 
    
      
      
  
String datasource = (String) request.getParameter(ActivePoliciesConstants.DATASOURCE);
String tabName = (String) request.getParameter(ActivePoliciesConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.ActivePoliciesFormSearch;
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
                            if(document.getElementsByName("schedulingpolicyname___hide")[0].checked) {
                            if(document.getElementsByName("retrievalpolicyname___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="ActivePoliciesApplicationResources" key="<%= ActivePoliciesConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.ActivePoliciesFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitActivePoliciesAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.ActivePoliciesFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="ActivePoliciesApplicationResources" key="<%= ActivePoliciesConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(ActivePoliciesConstants.USER) == null) {
  response.sendRedirect(ActivePoliciesConstants.NULL_SESSION);
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
      String ID = form.getId();
            String SchedulingPolicyName = form.getSchedulingpolicyname();
            String RetrievalPolicyName = form.getRetrievalpolicyname();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="ActivePoliciesApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="ActivePoliciesApplicationResources" property="ID"/>
        <html:errors bundle="ActivePoliciesApplicationResources" property="SchedulingPolicyName"/>
        <html:errors bundle="ActivePoliciesApplicationResources" property="RetrievalPolicyName"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitActivePoliciesAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
              <bean:message bundle="ActivePoliciesApplicationResources" key="field.id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="id" size="16" value="<%= ID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ActivePoliciesApplicationResources" key="field.id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="schedulingpolicyname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ActivePoliciesApplicationResources" key="field.schedulingpolicyname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="schedulingpolicyname" size="16" value="<%= SchedulingPolicyName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ActivePoliciesApplicationResources" key="field.schedulingpolicyname.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="retrievalpolicyname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ActivePoliciesApplicationResources" key="field.retrievalpolicyname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="retrievalpolicyname" size="16" value="<%= RetrievalPolicyName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ActivePoliciesApplicationResources" key="field.retrievalpolicyname.description"/>
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
