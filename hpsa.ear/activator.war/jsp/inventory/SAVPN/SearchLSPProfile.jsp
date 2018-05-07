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
LSPProfileForm form = (LSPProfileForm) request.getAttribute("LSPProfileForm");
if(form==null) {
 form=new LSPProfileForm();
} 
    
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(LSPProfileConstants.DATASOURCE);
String tabName = (String) request.getParameter(LSPProfileConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.LSPProfileFormSearch;
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
                    if(document.getElementsByName("lspprofilename___hide")[0].checked) {
                            if(document.getElementsByName("type___hide")[0].checked) {
                            if(document.getElementsByName("ct___hide")[0].checked) {
                            if(document.getElementsByName("bwallocation___hide")[0].checked) {
                            if(document.getElementsByName("bwalgorithm___hide")[0].checked) {
                            if(document.getElementsByName("cos___hide")[0].checked) {
                            if(document.getElementsByName("lspfilter___hide")[0].checked) {
                            if(document.getElementsByName("lspprofileversion___hide")[0].checked) {
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
    alert("<bean:message bundle="LSPProfileApplicationResources" key="<%= LSPProfileConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.LSPProfileFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitLSPProfileAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.LSPProfileFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="LSPProfileApplicationResources" key="<%= LSPProfileConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(LSPProfileConstants.USER) == null) {
  response.sendRedirect(LSPProfileConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "lspprofilename";
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
      String LSPProfileName = form.getLspprofilename();
            String Type = form.getType();
            String CT = form.getCt();
            String bwAllocation = form.getBwallocation();
            String bwAlgorithm = form.getBwalgorithm();
            String CoS = form.getCos();
            String LSPFilter = form.getLspfilter();
            String LSPProfileVersion = form.getLspprofileversion();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="LSPProfileApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="LSPProfileApplicationResources" property="LSPProfileName"/>
        <html:errors bundle="LSPProfileApplicationResources" property="Type"/>
        <html:errors bundle="LSPProfileApplicationResources" property="CT"/>
        <html:errors bundle="LSPProfileApplicationResources" property="bwAllocation"/>
        <html:errors bundle="LSPProfileApplicationResources" property="bwAlgorithm"/>
        <html:errors bundle="LSPProfileApplicationResources" property="CoS"/>
        <html:errors bundle="LSPProfileApplicationResources" property="LSPFilter"/>
        <html:errors bundle="LSPProfileApplicationResources" property="LSPProfileVersion"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitLSPProfileAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="lspprofilename___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.lspprofilename.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="lspprofilename" size="16" value="<%= LSPProfileName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.lspprofilename.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="type___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.type.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="type" size="16" value="<%= Type %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.type.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ct___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.ct.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ct" size="16" value="<%= CT %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.ct.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="bwallocation___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.bwallocation.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="bwallocation" size="16" value="<%= bwAllocation %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.bwallocation.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="bwalgorithm___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.bwalgorithm.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="bwalgorithm" size="16" value="<%= bwAlgorithm %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.bwalgorithm.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="cos___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.cos.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="cos" size="16" value="<%= CoS %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.cos.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="lspfilter___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.lspfilter.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="lspfilter" size="16" value="<%= LSPFilter %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.lspfilter.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="lspprofileversion___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.lspprofileversion.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="lspprofileversion" size="16" value="<%= LSPProfileVersion %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="LSPProfileApplicationResources" key="field.lspprofileversion.description"/>
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
