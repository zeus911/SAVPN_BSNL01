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
DL_ElementCompTypeMappingForm form = (DL_ElementCompTypeMappingForm) request.getAttribute("DL_ElementCompTypeMappingForm");
if(form==null) {
 form=new DL_ElementCompTypeMappingForm();
} 
    
      
      
      
      
  
String datasource = (String) request.getParameter(DL_ElementCompTypeMappingConstants.DATASOURCE);
String tabName = (String) request.getParameter(DL_ElementCompTypeMappingConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.DL_ElementCompTypeMappingFormSearch;
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
                            if(document.getElementsByName("cardtype___hide")[0].checked) {
                            if(document.getElementsByName("elementcomptype___hide")[0].checked) {
                            if(document.getElementsByName("elementtypegroupname___hide")[0].checked) {
                            if(document.getElementsByName("ectype___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="DL_ElementCompTypeMappingApplicationResources" key="<%= DL_ElementCompTypeMappingConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.DL_ElementCompTypeMappingFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitDL_ElementCompTypeMappingAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.DL_ElementCompTypeMappingFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="DL_ElementCompTypeMappingApplicationResources" key="<%= DL_ElementCompTypeMappingConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(DL_ElementCompTypeMappingConstants.USER) == null) {
  response.sendRedirect(DL_ElementCompTypeMappingConstants.NULL_SESSION);
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
            String CardType = form.getCardtype();
            String ElementCompType = form.getElementcomptype();
            String ElementTypeGroupName = form.getElementtypegroupname();
            String ECType = form.getEctype();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="DL_ElementCompTypeMappingApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="DL_ElementCompTypeMappingApplicationResources" property="Id"/>
        <html:errors bundle="DL_ElementCompTypeMappingApplicationResources" property="CardType"/>
        <html:errors bundle="DL_ElementCompTypeMappingApplicationResources" property="ElementCompType"/>
        <html:errors bundle="DL_ElementCompTypeMappingApplicationResources" property="ElementTypeGroupName"/>
        <html:errors bundle="DL_ElementCompTypeMappingApplicationResources" property="ECType"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitDL_ElementCompTypeMappingAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
              <bean:message bundle="DL_ElementCompTypeMappingApplicationResources" key="field.id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="id" size="16" value="<%= Id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_ElementCompTypeMappingApplicationResources" key="field.id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="cardtype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_ElementCompTypeMappingApplicationResources" key="field.cardtype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="cardtype" size="16" value="<%= CardType %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_ElementCompTypeMappingApplicationResources" key="field.cardtype.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="elementcomptype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_ElementCompTypeMappingApplicationResources" key="field.elementcomptype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="elementcomptype" size="16" value="<%= ElementCompType %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_ElementCompTypeMappingApplicationResources" key="field.elementcomptype.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="elementtypegroupname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_ElementCompTypeMappingApplicationResources" key="field.elementtypegroupname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="elementtypegroupname" size="16" value="<%= ElementTypeGroupName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_ElementCompTypeMappingApplicationResources" key="field.elementtypegroupname.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ectype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="DL_ElementCompTypeMappingApplicationResources" key="field.ectype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ectype" size="16" value="<%= ECType %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="DL_ElementCompTypeMappingApplicationResources" key="field.ectype.description"/>
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
