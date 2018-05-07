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
AccessFlowForm form = (AccessFlowForm) request.getAttribute("AccessFlowForm");
if(form==null) {
 form=new AccessFlowForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(AccessFlowConstants.DATASOURCE);
String tabName = (String) request.getParameter(AccessFlowConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.AccessFlowFormSearch;
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
                    if(document.getElementsByName("serviceid___hide")[0].checked) {
                            if(document.getElementsByName("customerid___hide")[0].checked) {
                                      if(document.getElementsByName("contactperson___hide")[0].checked) {
                            if(document.getElementsByName("servicename___hide")[0].checked) {
                            if(document.getElementsByName("initiationdate___hide")[0].checked) {
                            if(document.getElementsByName("activationdate___hide")[0].checked) {
                            if(document.getElementsByName("modificationdate___hide")[0].checked) {
                            if(document.getElementsByName("state___hide")[0].checked) {
                            if(document.getElementsByName("type___hide")[0].checked) {
                            if(document.getElementsByName("comments___hide")[0].checked) {
                                                          if(document.getElementsByName("siteid___hide")[0].checked) {
                            if(document.getElementsByName("vlanid___hide")[0].checked) {
                            if(document.getElementsByName("pe_status___hide")[0].checked) {
                            if(document.getElementsByName("ce_status___hide")[0].checked) {
                            if(document.getElementsByName("accessnw_status___hide")[0].checked) {
                            if(document.getElementsByName("asbr_status___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                                      }
                            }
                            }
                            }
                            }
                            }
                            }
                            }
                                                          }
                            }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="AccessFlowApplicationResources" key="<%= AccessFlowConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.AccessFlowFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitAccessFlowAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.AccessFlowFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="AccessFlowApplicationResources" key="<%= AccessFlowConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(AccessFlowConstants.USER) == null) {
  response.sendRedirect(AccessFlowConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "serviceid";
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
      String ServiceId = form.getServiceid();
            String CustomerId = form.getCustomerid();
              String ContactPerson = form.getContactperson();
            String ServiceName = form.getServicename();
            String InitiationDate = form.getInitiationdate();
            String ActivationDate = form.getActivationdate();
            String ModificationDate = form.getModificationdate();
            String State = form.getState();
            String Type = form.getType();
            String Comments = form.getComments();
                  String SiteId = form.getSiteid();
            String VlanId = form.getVlanid();
            String PE_Status = form.getPe_status();
            String CE_Status = form.getCe_status();
            String AccessNW_Status = form.getAccessnw_status();
            String ASBR_Status = form.getAsbr_status();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="AccessFlowApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="AccessFlowApplicationResources" property="ServiceId"/>
        <html:errors bundle="AccessFlowApplicationResources" property="CustomerId"/>
          <html:errors bundle="AccessFlowApplicationResources" property="ContactPerson"/>
        <html:errors bundle="AccessFlowApplicationResources" property="ServiceName"/>
        <html:errors bundle="AccessFlowApplicationResources" property="InitiationDate"/>
        <html:errors bundle="AccessFlowApplicationResources" property="ActivationDate"/>
        <html:errors bundle="AccessFlowApplicationResources" property="ModificationDate"/>
        <html:errors bundle="AccessFlowApplicationResources" property="State"/>
        <html:errors bundle="AccessFlowApplicationResources" property="Type"/>
        <html:errors bundle="AccessFlowApplicationResources" property="Comments"/>
        <html:errors bundle="AccessFlowApplicationResources" property="__count"/>
            <html:errors bundle="AccessFlowApplicationResources" property="SiteId"/>
        <html:errors bundle="AccessFlowApplicationResources" property="VlanId"/>
        <html:errors bundle="AccessFlowApplicationResources" property="PE_Status"/>
        <html:errors bundle="AccessFlowApplicationResources" property="CE_Status"/>
        <html:errors bundle="AccessFlowApplicationResources" property="AccessNW_Status"/>
        <html:errors bundle="AccessFlowApplicationResources" property="ASBR_Status"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitAccessFlowAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="serviceid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.serviceid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="serviceid" size="16" value="<%= ServiceId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.serviceid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="customerid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.customerid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="customerid" size="16" value="<%= CustomerId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.customerid.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="contactperson___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.contactperson.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="contactperson" size="16" value="<%= ContactPerson %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.contactperson.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="servicename___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.servicename.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="servicename" size="16" value="<%= ServiceName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.servicename.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="initiationdate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.initiationdate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="initiationdate" size="16" value="<%= InitiationDate %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.initiationdate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="activationdate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.activationdate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="activationdate" size="16" value="<%= ActivationDate %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.activationdate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="modificationdate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.modificationdate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="modificationdate" size="16" value="<%= ModificationDate %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.modificationdate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="state___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.state.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="state" size="16" value="<%= State %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.state.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="type___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.type.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="type" size="16" value="<%= Type %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.type.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="comments___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.comments.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="comments" size="16" value="<%= Comments %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.comments.description"/>
                          </table:cell>
          </table:row>
                                                                          <table:row>
            <table:cell>
              <center>
                <html:checkbox property="siteid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.siteid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="siteid" size="16" value="<%= SiteId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.siteid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="vlanid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.vlanid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="vlanid" size="16" value="<%= VlanId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.vlanid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="pe_status___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.pe_status.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="pe_status" size="16" value="<%= PE_Status %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.pe_status.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ce_status___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.ce_status.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ce_status" size="16" value="<%= CE_Status %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.ce_status.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="accessnw_status___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.accessnw_status.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="accessnw_status" size="16" value="<%= AccessNW_Status %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.accessnw_status.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="asbr_status___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.asbr_status.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="asbr_status" size="16" value="<%= ASBR_Status %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="AccessFlowApplicationResources" key="field.asbr_status.description"/>
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
