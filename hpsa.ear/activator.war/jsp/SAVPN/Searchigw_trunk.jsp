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
igw_trunkForm form = (igw_trunkForm) request.getAttribute("igw_trunkForm");
if(form==null) {
 form=new igw_trunkForm();
} 
    
      
      
      
      
      
  
String datasource = (String) request.getParameter(igw_trunkConstants.DATASOURCE);
String tabName = (String) request.getParameter(igw_trunkConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.igw_trunkFormSearch;
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
                    if(document.getElementsByName("trunk_id___hide")[0].checked) {
                            if(document.getElementsByName("trunktype_id___hide")[0].checked) {
                            if(document.getElementsByName("name___hide")[0].checked) {
                            if(document.getElementsByName("link_type___hide")[0].checked) {
                            if(document.getElementsByName("status___hide")[0].checked) {
                            if(document.getElementsByName("submit_data___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="igw_trunkApplicationResources" key="<%= igw_trunkConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.igw_trunkFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitigw_trunkAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.igw_trunkFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="igw_trunkApplicationResources" key="<%= igw_trunkConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(igw_trunkConstants.USER) == null) {
  response.sendRedirect(igw_trunkConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "trunk_id";
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
      String TRUNK_ID = form.getTrunk_id();
            String TRUNKTYPE_ID = form.getTrunktype_id();
            String NAME = form.getName();
            String LINK_TYPE = form.getLink_type();
            String STATUS = form.getStatus();
            String SUBMIT_DATA = form.getSubmit_data();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="igw_trunkApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="igw_trunkApplicationResources" property="TRUNK_ID"/>
        <html:errors bundle="igw_trunkApplicationResources" property="TRUNKTYPE_ID"/>
        <html:errors bundle="igw_trunkApplicationResources" property="NAME"/>
        <html:errors bundle="igw_trunkApplicationResources" property="LINK_TYPE"/>
        <html:errors bundle="igw_trunkApplicationResources" property="STATUS"/>
        <html:errors bundle="igw_trunkApplicationResources" property="SUBMIT_DATA"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitigw_trunkAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="trunk_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkApplicationResources" key="field.trunk_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="trunk_id" size="16" value="<%= TRUNK_ID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkApplicationResources" key="field.trunk_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="trunktype_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkApplicationResources" key="field.trunktype_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="trunktype_id" size="16" value="<%= TRUNKTYPE_ID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkApplicationResources" key="field.trunktype_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="name___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkApplicationResources" key="field.name.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="name" size="16" value="<%= NAME %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkApplicationResources" key="field.name.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="link_type___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkApplicationResources" key="field.link_type.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="link_type" size="16" value="<%= LINK_TYPE %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkApplicationResources" key="field.link_type.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="status___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkApplicationResources" key="field.status.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="status" size="16" value="<%= STATUS %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkApplicationResources" key="field.status.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="submit_data___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkApplicationResources" key="field.submit_data.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="submit_data" size="16" value="<%= SUBMIT_DATA %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkApplicationResources" key="field.submit_data.description"/>
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
