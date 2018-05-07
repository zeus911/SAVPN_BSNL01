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
LSPConnectionForm form = (LSPConnectionForm) request.getAttribute("LSPConnectionForm");
if(form==null) {
 form=new LSPConnectionForm();
} 
    
      
      
      
  
String datasource = (String) request.getParameter(LSPConnectionConstants.DATASOURCE);
String tabName = (String) request.getParameter(LSPConnectionConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.LSPConnectionFormSearch;
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
                    if(document.getElementsByName("headpe___hide")[0].checked) {
                            if(document.getElementsByName("tailpe___hide")[0].checked) {
                            if(document.getElementsByName("usagemode___hide")[0].checked) {
                            if(document.getElementsByName("vpnid___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="LSPConnectionApplicationResources" key="<%= LSPConnectionConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.LSPConnectionFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitLSPConnectionAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.LSPConnectionFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="LSPConnectionApplicationResources" key="<%= LSPConnectionConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(LSPConnectionConstants.USER) == null) {
  response.sendRedirect(LSPConnectionConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "headpe";
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
      String headPE = form.getHeadpe();
            String tailPE = form.getTailpe();
            String UsageMode = form.getUsagemode();
            String VpnId = form.getVpnid();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="LSPConnectionApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="LSPConnectionApplicationResources" property="headPE"/>
        <html:errors bundle="LSPConnectionApplicationResources" property="tailPE"/>
        <html:errors bundle="LSPConnectionApplicationResources" property="UsageMode"/>
        <html:errors bundle="LSPConnectionApplicationResources" property="VpnId"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitLSPConnectionAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="headpe___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="LSPConnectionApplicationResources" key="field.headpe.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="headpe" size="16" value="<%= headPE %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="LSPConnectionApplicationResources" key="field.headpe.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="tailpe___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="LSPConnectionApplicationResources" key="field.tailpe.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="tailpe" size="16" value="<%= tailPE %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="LSPConnectionApplicationResources" key="field.tailpe.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="usagemode___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="LSPConnectionApplicationResources" key="field.usagemode.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="usagemode" size="16" value="<%= UsageMode %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="LSPConnectionApplicationResources" key="field.usagemode.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="vpnid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="LSPConnectionApplicationResources" key="field.vpnid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="vpnid" size="16" value="<%= VpnId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="LSPConnectionApplicationResources" key="field.vpnid.description"/>
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
