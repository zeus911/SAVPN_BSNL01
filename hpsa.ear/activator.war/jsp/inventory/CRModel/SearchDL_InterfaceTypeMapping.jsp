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
DL_InterfaceTypeMappingForm form = (DL_InterfaceTypeMappingForm) request.getAttribute("DL_InterfaceTypeMappingForm");
if(form==null) {
 form=new DL_InterfaceTypeMappingForm();
} 
    
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(DL_InterfaceTypeMappingConstants.DATASOURCE);
String tabName = (String) request.getParameter(DL_InterfaceTypeMappingConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.DL_InterfaceTypeMappingFormSearch;
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
                            if(document.getElementsByName("iftype___hide")[0].checked) {
                            if(document.getElementsByName("vendor___hide")[0].checked) {
                            if(document.getElementsByName("elementtype_regexp___hide")[0].checked) {
                            if(document.getElementsByName("osversion_regexp___hide")[0].checked) {
                            if(document.getElementsByName("ifdescr_regexp___hide")[0].checked) {
                            if(document.getElementsByName("hpsatype___hide")[0].checked) {
                            if(document.getElementsByName("description___hide")[0].checked) {
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
    alert("<bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="<%= DL_InterfaceTypeMappingConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.DL_InterfaceTypeMappingFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitDL_InterfaceTypeMappingAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.DL_InterfaceTypeMappingFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="<%= DL_InterfaceTypeMappingConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(DL_InterfaceTypeMappingConstants.USER) == null) {
  response.sendRedirect(DL_InterfaceTypeMappingConstants.NULL_SESSION);
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
      String Id = form.getId();
            String ifType = form.getIftype();
            String Vendor = form.getVendor();
            String ElementType_Regexp = form.getElementtype_regexp();
            String OSVersion_Regexp = form.getOsversion_regexp();
            String ifDescr_Regexp = form.getIfdescr_regexp();
            String HPSAType = form.getHpsatype();
            String Description = form.getDescription();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="DL_InterfaceTypeMappingApplicationResources" property="Id"/>
        <html:errors bundle="DL_InterfaceTypeMappingApplicationResources" property="ifType"/>
        <html:errors bundle="DL_InterfaceTypeMappingApplicationResources" property="Vendor"/>
        <html:errors bundle="DL_InterfaceTypeMappingApplicationResources" property="ElementType_Regexp"/>
        <html:errors bundle="DL_InterfaceTypeMappingApplicationResources" property="OSVersion_Regexp"/>
        <html:errors bundle="DL_InterfaceTypeMappingApplicationResources" property="ifDescr_Regexp"/>
        <html:errors bundle="DL_InterfaceTypeMappingApplicationResources" property="HPSAType"/>
        <html:errors bundle="DL_InterfaceTypeMappingApplicationResources" property="Description"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitDL_InterfaceTypeMappingAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="id" size="16" value="<%= Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="iftype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.iftype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="iftype" size="16" value="<%= ifType %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.iftype.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="vendor___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.vendor.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="vendor" size="16" value="<%= Vendor %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.vendor.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="elementtype_regexp___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.elementtype_regexp.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="elementtype_regexp" size="16" value="<%= ElementType_Regexp %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.elementtype_regexp.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="osversion_regexp___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.osversion_regexp.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="osversion_regexp" size="16" value="<%= OSVersion_Regexp %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.osversion_regexp.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ifdescr_regexp___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.ifdescr_regexp.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ifdescr_regexp" size="16" value="<%= ifDescr_Regexp %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.ifdescr_regexp.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="hpsatype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.hpsatype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="hpsatype" size="16" value="<%= HPSAType %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.hpsatype.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="description___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.description.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="description" size="16" value="<%= Description %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_InterfaceTypeMappingApplicationResources" key="field.description.description"/>
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
