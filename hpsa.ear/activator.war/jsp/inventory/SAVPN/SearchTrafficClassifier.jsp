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
TrafficClassifierForm form = (TrafficClassifierForm) request.getAttribute("TrafficClassifierForm");
if(form==null) {
 form=new TrafficClassifierForm();
} 
    
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(TrafficClassifierConstants.DATASOURCE);
String tabName = (String) request.getParameter(TrafficClassifierConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.TrafficClassifierFormSearch;
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
                    if(document.getElementsByName("name___hide")[0].checked) {
                            if(document.getElementsByName("customerid___hide")[0].checked) {
                            if(document.getElementsByName("layer___hide")[0].checked) {
                            if(document.getElementsByName("dscps___hide")[0].checked) {
                            if(document.getElementsByName("filter___hide")[0].checked) {
                            if(document.getElementsByName("coss___hide")[0].checked) {
                            if(document.getElementsByName("compliant___hide")[0].checked) {
                            if(document.getElementsByName("addressfamily___hide")[0].checked) {
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
    alert("<bean:message bundle="TrafficClassifierApplicationResources" key="<%= TrafficClassifierConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.TrafficClassifierFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitTrafficClassifierAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.TrafficClassifierFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="TrafficClassifierApplicationResources" key="<%= TrafficClassifierConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(TrafficClassifierConstants.USER) == null) {
  response.sendRedirect(TrafficClassifierConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "name";
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
      String Name = form.getName();
            String CustomerId = form.getCustomerid();
            String Layer = form.getLayer();
            String DSCPs = form.getDscps();
            String Filter = form.getFilter();
            String CoSs = form.getCoss();
            String Compliant = form.getCompliant();
            String AddressFamily = form.getAddressfamily();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="TrafficClassifierApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="TrafficClassifierApplicationResources" property="Name"/>
        <html:errors bundle="TrafficClassifierApplicationResources" property="CustomerId"/>
        <html:errors bundle="TrafficClassifierApplicationResources" property="Layer"/>
        <html:errors bundle="TrafficClassifierApplicationResources" property="DSCPs"/>
        <html:errors bundle="TrafficClassifierApplicationResources" property="Filter"/>
        <html:errors bundle="TrafficClassifierApplicationResources" property="CoSs"/>
        <html:errors bundle="TrafficClassifierApplicationResources" property="Compliant"/>
        <html:errors bundle="TrafficClassifierApplicationResources" property="AddressFamily"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitTrafficClassifierAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="name___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.name.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="name" size="16" value="<%= Name %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.name.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="customerid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.customerid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="customerid" size="16" value="<%= CustomerId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.customerid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="layer___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.layer.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="layer" size="16" value="<%= Layer %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.layer.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="dscps___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.dscps.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="dscps" size="16" value="<%= DSCPs %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.dscps.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="filter___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.filter.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="filter" size="16" value="<%= Filter %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.filter.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="coss___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.coss.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="coss" size="16" value="<%= CoSs %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.coss.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="compliant___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.compliant.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="compliant" size="16" value="<%= Compliant %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.compliant.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="addressfamily___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.addressfamily.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="addressfamily" size="16" value="<%= AddressFamily %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="TrafficClassifierApplicationResources" key="field.addressfamily.description"/>
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
