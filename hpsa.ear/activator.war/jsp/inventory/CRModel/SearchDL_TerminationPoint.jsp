<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.nnmi.dl.inventory.*,
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
DL_TerminationPointForm form = (DL_TerminationPointForm) request.getAttribute("DL_TerminationPointForm");
if(form==null) {
 form=new DL_TerminationPointForm();
} 
    
      
      
      
      
      
  
String datasource = (String) request.getParameter(DL_TerminationPointConstants.DATASOURCE);
String tabName = (String) request.getParameter(DL_TerminationPointConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.DL_TerminationPointFormSearch;
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
                    if(document.getElementsByName("nnmi_id___hide")[0].checked) {
                            if(document.getElementsByName("name___hide")[0].checked) {
                            if(document.getElementsByName("ne_nnmi_id___hide")[0].checked) {
                            if(document.getElementsByName("ec_nnmi_id___hide")[0].checked) {
                            if(document.getElementsByName("state___hide")[0].checked) {
                            if(document.getElementsByName("statename___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="DL_TerminationPointApplicationResources" key="<%= DL_TerminationPointConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.DL_TerminationPointFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitDL_TerminationPointAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.DL_TerminationPointFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="DL_TerminationPointApplicationResources" key="<%= DL_TerminationPointConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(DL_TerminationPointConstants.USER) == null) {
  response.sendRedirect(DL_TerminationPointConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "nnmi_id";
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
      String NNMi_Id = form.getNnmi_id();
            String Name = form.getName();
            String NE_NNMi_Id = form.getNe_nnmi_id();
            String EC_NNMi_Id = form.getEc_nnmi_id();
            String State = form.getState();
            String StateName = form.getStatename();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_TerminationPointApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="DL_TerminationPointApplicationResources" property="NNMi_Id"/>
        <html:errors bundle="DL_TerminationPointApplicationResources" property="Name"/>
        <html:errors bundle="DL_TerminationPointApplicationResources" property="NE_NNMi_Id"/>
        <html:errors bundle="DL_TerminationPointApplicationResources" property="EC_NNMi_Id"/>
        <html:errors bundle="DL_TerminationPointApplicationResources" property="State"/>
        <html:errors bundle="DL_TerminationPointApplicationResources" property="StateName"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitDL_TerminationPointAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="nnmi_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.nnmi_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="nnmi_id" size="16" value="<%= NNMi_Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.nnmi_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="name___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.name.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="name" size="16" value="<%= Name %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.name.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ne_nnmi_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.ne_nnmi_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ne_nnmi_id" size="16" value="<%= NE_NNMi_Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.ne_nnmi_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ec_nnmi_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.ec_nnmi_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ec_nnmi_id" size="16" value="<%= EC_NNMi_Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.ec_nnmi_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="state___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.state.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="state" size="16" value="<%= State %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.state.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="statename___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.statename.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="statename" size="16" value="<%= StateName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_TerminationPointApplicationResources" key="field.statename.description"/>
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
