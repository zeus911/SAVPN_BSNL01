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
TerminationPointForm form = (TerminationPointForm) request.getAttribute("TerminationPointForm");
if(form==null) {
 form=new TerminationPointForm();
} 
    
      
      
      
      
      
  
String datasource = (String) request.getParameter(TerminationPointConstants.DATASOURCE);
String tabName = (String) request.getParameter(TerminationPointConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.TerminationPointFormSearch;
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
                    if(document.getElementsByName("terminationpointid___hide")[0].checked) {
                            if(document.getElementsByName("name___hide")[0].checked) {
                            if(document.getElementsByName("ne_id___hide")[0].checked) {
                            if(document.getElementsByName("ec_id___hide")[0].checked) {
                            if(document.getElementsByName("state___hide")[0].checked) {
                        checkfalse=true;
                    }
                            }
                            }
                            }
                            }
                      if(checkfalse){
    alert("<bean:message bundle="TerminationPointApplicationResources" key="<%= TerminationPointConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.TerminationPointFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitTerminationPointAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.TerminationPointFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="TerminationPointApplicationResources" key="<%= TerminationPointConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(TerminationPointConstants.USER) == null) {
  response.sendRedirect(TerminationPointConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "terminationpointid";
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
      String TerminationPointId = form.getTerminationpointid();
            String Name = form.getName();
            String NE_Id = form.getNe_id();
            String EC_Id = form.getEc_id();
            String State = form.getState();
        
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="TerminationPointApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="TerminationPointApplicationResources" property="TerminationPointId"/>
        <html:errors bundle="TerminationPointApplicationResources" property="Name"/>
        <html:errors bundle="TerminationPointApplicationResources" property="NE_Id"/>
        <html:errors bundle="TerminationPointApplicationResources" property="EC_Id"/>
        <html:errors bundle="TerminationPointApplicationResources" property="State"/>
        <html:errors bundle="TerminationPointApplicationResources" property="__count"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitTerminationPointAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="terminationpointid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="TerminationPointApplicationResources" key="field.terminationpointid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="terminationpointid" size="16" value="<%= TerminationPointId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="TerminationPointApplicationResources" key="field.terminationpointid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="name___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="TerminationPointApplicationResources" key="field.name.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="name" size="16" value="<%= Name %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="TerminationPointApplicationResources" key="field.name.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ne_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="TerminationPointApplicationResources" key="field.ne_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ne_id" size="16" value="<%= NE_Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="TerminationPointApplicationResources" key="field.ne_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ec_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="TerminationPointApplicationResources" key="field.ec_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ec_id" size="16" value="<%= EC_Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="TerminationPointApplicationResources" key="field.ec_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="state___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="TerminationPointApplicationResources" key="field.state.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="state" size="16" value="<%= State %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="TerminationPointApplicationResources" key="field.state.description"/>
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
