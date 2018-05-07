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
CustomerForm form = (CustomerForm) request.getAttribute("CustomerForm");
if(form==null) {
 form=new CustomerForm();
} 
    
      
      
      
      
  
String datasource = (String) request.getParameter(CustomerConstants.DATASOURCE);
String tabName = (String) request.getParameter(CustomerConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.CustomerFormSearch;
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
                    if(document.getElementsByName("customerid___hide")[0].checked) {
                            if(document.getElementsByName("customername___hide")[0].checked) {
                                      if(document.getElementsByName("customercontact___hide")[0].checked) {
                            if(document.getElementsByName("customeremail___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                                      }
                            }
            if(checkfalse){
    alert("<bean:message bundle="CustomerApplicationResources" key="<%= CustomerConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.CustomerFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitCustomerAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.CustomerFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="CustomerApplicationResources" key="<%= CustomerConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(CustomerConstants.USER) == null) {
  response.sendRedirect(CustomerConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "customerid";
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
      String CustomerId = form.getCustomerid();
            String CustomerName = form.getCustomername();
              String CustomerContact = form.getCustomercontact();
            String CustomerEmail = form.getCustomeremail();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="CustomerApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="CustomerApplicationResources" property="CustomerId"/>
        <html:errors bundle="CustomerApplicationResources" property="CustomerName"/>
          <html:errors bundle="CustomerApplicationResources" property="CustomerContact"/>
        <html:errors bundle="CustomerApplicationResources" property="CustomerEmail"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitCustomerAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="customerid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="CustomerApplicationResources" key="field.customerid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="customerid" size="16" value="<%= CustomerId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="CustomerApplicationResources" key="field.customerid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="customername___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="CustomerApplicationResources" key="field.customername.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="customername" size="16" value="<%= CustomerName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="CustomerApplicationResources" key="field.customername.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="customercontact___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="CustomerApplicationResources" key="field.customercontact.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="customercontact" size="16" value="<%= CustomerContact %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="CustomerApplicationResources" key="field.customercontact.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="customeremail___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="CustomerApplicationResources" key="field.customeremail.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="customeremail" size="16" value="<%= CustomerEmail %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="CustomerApplicationResources" key="field.customeremail.description"/>
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
