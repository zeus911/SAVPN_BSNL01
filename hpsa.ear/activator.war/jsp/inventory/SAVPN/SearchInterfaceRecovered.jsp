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
InterfaceRecoveredForm form = (InterfaceRecoveredForm) request.getAttribute("InterfaceRecoveredForm");
if(form==null) {
 form=new InterfaceRecoveredForm();
} 
    
      
      
      
      
  
String datasource = (String) request.getParameter(InterfaceRecoveredConstants.DATASOURCE);
String tabName = (String) request.getParameter(InterfaceRecoveredConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.InterfaceRecoveredFormSearch;
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
                    if(document.getElementsByName("sourcetpid___hide")[0].checked) {
                            if(document.getElementsByName("targettpid___hide")[0].checked) {
                            if(document.getElementsByName("total___hide")[0].checked) {
                            if(document.getElementsByName("success___hide")[0].checked) {
                            if(document.getElementsByName("failed___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="InterfaceRecoveredApplicationResources" key="<%= InterfaceRecoveredConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.InterfaceRecoveredFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitInterfaceRecoveredAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.InterfaceRecoveredFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="InterfaceRecoveredApplicationResources" key="<%= InterfaceRecoveredConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(InterfaceRecoveredConstants.USER) == null) {
  response.sendRedirect(InterfaceRecoveredConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "sourcetpid";
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
      String SourceTPID = form.getSourcetpid();
            String TargetTPID = form.getTargettpid();
            String Total = form.getTotal();
          String Total___ = form.getTotal___();
            String Success = form.getSuccess();
          String Success___ = form.getSuccess___();
            String Failed = form.getFailed();
          String Failed___ = form.getFailed___();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="InterfaceRecoveredApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="InterfaceRecoveredApplicationResources" property="SourceTPID"/>
        <html:errors bundle="InterfaceRecoveredApplicationResources" property="TargetTPID"/>
        <html:errors bundle="InterfaceRecoveredApplicationResources" property="Total"/>
        <html:errors bundle="InterfaceRecoveredApplicationResources" property="Success"/>
        <html:errors bundle="InterfaceRecoveredApplicationResources" property="Failed"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitInterfaceRecoveredAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="sourcetpid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.sourcetpid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="sourcetpid" size="16" value="<%= SourceTPID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.sourcetpid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="targettpid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.targettpid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="targettpid" size="16" value="<%= TargetTPID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.targettpid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="total___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.total.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="total" size="16" value="<%= Total %>"/>
                                  -
                  <html:text property="total___" size="16" value="<%= Total___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.total.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="success___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.success.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="success" size="16" value="<%= Success %>"/>
                                  -
                  <html:text property="success___" size="16" value="<%= Success___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.success.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="failed___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.failed.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="failed" size="16" value="<%= Failed %>"/>
                                  -
                  <html:text property="failed___" size="16" value="<%= Failed___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="InterfaceRecoveredApplicationResources" key="field.failed.description"/>
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
