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
AccessNetworkForm form = (AccessNetworkForm) request.getAttribute("AccessNetworkForm");
if(form==null) {
 form=new AccessNetworkForm();
} 
    
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(AccessNetworkConstants.DATASOURCE);
String tabName = (String) request.getParameter(AccessNetworkConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.AccessNetworkFormSearch;
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
                    if(document.getElementsByName("networkid___hide")[0].checked) {
                            if(document.getElementsByName("name___hide")[0].checked) {
                            if(document.getElementsByName("type___hide")[0].checked) {
                            if(document.getElementsByName("asn___hide")[0].checked) {
                            if(document.getElementsByName("region___hide")[0].checked) {
                            if(document.getElementsByName("parentnetworkid___hide")[0].checked) {
                            if(document.getElementsByName("state___hide")[0].checked) {
                            if(document.getElementsByName("managementvlans___hide")[0].checked) {
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
    alert("<bean:message bundle="AccessNetworkApplicationResources" key="<%= AccessNetworkConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.AccessNetworkFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitAccessNetworkAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.AccessNetworkFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="AccessNetworkApplicationResources" key="<%= AccessNetworkConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(AccessNetworkConstants.USER) == null) {
  response.sendRedirect(AccessNetworkConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "networkid";
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
      String NetworkId = form.getNetworkid();
            String Name = form.getName();
            String Type = form.getType();
            String ASN = form.getAsn();
            String Region = form.getRegion();
            String ParentNetworkId = form.getParentnetworkid();
            String State = form.getState();
            String ManagementVlans = form.getManagementvlans();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="AccessNetworkApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="AccessNetworkApplicationResources" property="NetworkId"/>
        <html:errors bundle="AccessNetworkApplicationResources" property="Name"/>
        <html:errors bundle="AccessNetworkApplicationResources" property="Type"/>
        <html:errors bundle="AccessNetworkApplicationResources" property="ASN"/>
        <html:errors bundle="AccessNetworkApplicationResources" property="Region"/>
        <html:errors bundle="AccessNetworkApplicationResources" property="ParentNetworkId"/>
        <html:errors bundle="AccessNetworkApplicationResources" property="State"/>
        <html:errors bundle="AccessNetworkApplicationResources" property="ManagementVlans"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitAccessNetworkAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="networkid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.networkid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="networkid" size="16" value="<%= NetworkId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.networkid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="name___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.name.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="name" size="16" value="<%= Name %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.name.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="type___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.type.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="type" size="16" value="<%= Type %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.type.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="asn___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.asn.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="asn" size="16" value="<%= ASN %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.asn.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="region___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.region.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="region" size="16" value="<%= Region %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.region.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="parentnetworkid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.parentnetworkid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="parentnetworkid" size="16" value="<%= ParentNetworkId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.parentnetworkid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="state___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.state.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="state" size="16" value="<%= State %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.state.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="managementvlans___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.managementvlans.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="managementvlans" size="16" value="<%= ManagementVlans %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessNetworkApplicationResources" key="field.managementvlans.description"/>
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
