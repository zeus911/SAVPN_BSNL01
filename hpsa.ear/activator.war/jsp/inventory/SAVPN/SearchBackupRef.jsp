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
BackupRefForm form = (BackupRefForm) request.getAttribute("BackupRefForm");
if(form==null) {
 form=new BackupRefForm();
} 
    
      
                 java.text.SimpleDateFormat sdfcreationtime = new java.text.SimpleDateFormat("dd-MM-yyyy");
            String sdfcreationtimeDesc = "Format: [" + sdfcreationtime.toPattern() + "]. Example: [" + sdfcreationtime.format(new Date()) + "]";
      
      
                 java.text.SimpleDateFormat sdfconfigtime = new java.text.SimpleDateFormat("dd-MM-yyyy");
            String sdfconfigtimeDesc = "Format: [" + sdfconfigtime.toPattern() + "]. Example: [" + sdfconfigtime.format(new Date()) + "]";
      
      
  
String datasource = (String) request.getParameter(BackupRefConstants.DATASOURCE);
String tabName = (String) request.getParameter(BackupRefConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.BackupRefFormSearch;
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
                    if(document.getElementsByName("eqid___hide")[0].checked) {
                            if(document.getElementsByName("creationtime___hide")[0].checked) {
                            if(document.getElementsByName("createdby___hide")[0].checked) {
                            if(document.getElementsByName("configtime___hide")[0].checked) {
                            if(document.getElementsByName("retrievalname___hide")[0].checked) {
                            if(document.getElementsByName("comments___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="BackupRefApplicationResources" key="<%= BackupRefConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.BackupRefFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitBackupRefAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.BackupRefFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="BackupRefApplicationResources" key="<%= BackupRefConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(BackupRefConstants.USER) == null) {
  response.sendRedirect(BackupRefConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "eqid";
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
      String eqid = form.getEqid();
            String creationtime = form.getCreationtime();
          String creationtime___ = form.getCreationtime___();
            String createdby = form.getCreatedby();
            String configtime = form.getConfigtime();
          String configtime___ = form.getConfigtime___();
            String retrievalname = form.getRetrievalname();
            String comments = form.getComments();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="BackupRefApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="BackupRefApplicationResources" property="eqid"/>
        <html:errors bundle="BackupRefApplicationResources" property="creationtime"/>
        <html:errors bundle="BackupRefApplicationResources" property="createdby"/>
        <html:errors bundle="BackupRefApplicationResources" property="configtime"/>
        <html:errors bundle="BackupRefApplicationResources" property="retrievalname"/>
        <html:errors bundle="BackupRefApplicationResources" property="comments"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitBackupRefAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="eqid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.eqid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="eqid" size="16" value="<%= eqid %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.eqid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="creationtime___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.creationtime.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="creationtime" size="16" value="<%= creationtime %>"/>
                                  -
                  <html:text property="creationtime___" size="16" value="<%= creationtime___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.creationtime.description"/>
              <%=sdfcreationtimeDesc%>            </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="createdby___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.createdby.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="createdby" size="16" value="<%= createdby %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.createdby.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="configtime___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.configtime.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="configtime" size="16" value="<%= configtime %>"/>
                                  -
                  <html:text property="configtime___" size="16" value="<%= configtime___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.configtime.description"/>
              <%=sdfconfigtimeDesc%>            </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="retrievalname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.retrievalname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="retrievalname" size="16" value="<%= retrievalname %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.retrievalname.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="comments___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.comments.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="comments" size="16" value="<%= comments %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="BackupRefApplicationResources" key="field.comments.description"/>
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
