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
SiteForm form = (SiteForm) request.getAttribute("SiteForm");
if(form==null) {
 form=new SiteForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(SiteConstants.DATASOURCE);
String tabName = (String) request.getParameter(SiteConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.SiteFormSearch;
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
                                      if(document.getElementsByName("contactperson___hide")[0].checked) {
                                      if(document.getElementsByName("servicename___hide")[0].checked) {
                                      if(document.getElementsByName("region___hide")[0].checked) {
                            if(document.getElementsByName("initiationdate___hide")[0].checked) {
                            if(document.getElementsByName("activationdate___hide")[0].checked) {
                            if(document.getElementsByName("modificationdate___hide")[0].checked) {
                            if(document.getElementsByName("state___hide")[0].checked) {
                            if(document.getElementsByName("type___hide")[0].checked) {
                            if(document.getElementsByName("siteoforigin___hide")[0].checked) {
                            if(document.getElementsByName("managed___hide")[0].checked) {
                                      if(document.getElementsByName("multicast___hide")[0].checked) {
                                      if(document.getElementsByName("remoteasn___hide")[0].checked) {
                            if(document.getElementsByName("ospf_area___hide")[0].checked) {
                                      if(document.getElementsByName("comments___hide")[0].checked) {
                                      if(document.getElementsByName("customerid___hide")[0].checked) {
                            if(document.getElementsByName("postaladdress___hide")[0].checked) {
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
                            }
                      if(checkfalse){
    alert("<bean:message bundle="SiteApplicationResources" key="<%= SiteConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.SiteFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitSiteAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.SiteFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="SiteApplicationResources" key="<%= SiteConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(SiteConstants.USER) == null) {
  response.sendRedirect(SiteConstants.NULL_SESSION);
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
              String ContactPerson = form.getContactperson();
              String ServiceName = form.getServicename();
              String Region = form.getRegion();
            String InitiationDate = form.getInitiationdate();
            String ActivationDate = form.getActivationdate();
            String ModificationDate = form.getModificationdate();
            String State = form.getState();
            String Type = form.getType();
            String SiteOfOrigin = form.getSiteoforigin();
            String Managed = form.getManaged();
              String Multicast = form.getMulticast();
              String RemoteASN = form.getRemoteasn();
            String OSPF_Area = form.getOspf_area();
              String Comments = form.getComments();
              String CustomerId = form.getCustomerid();
            String PostalAddress = form.getPostaladdress();
        
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="SiteApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="SiteApplicationResources" property="ServiceId"/>
          <html:errors bundle="SiteApplicationResources" property="ContactPerson"/>
          <html:errors bundle="SiteApplicationResources" property="ServiceName"/>
          <html:errors bundle="SiteApplicationResources" property="Region"/>
        <html:errors bundle="SiteApplicationResources" property="InitiationDate"/>
        <html:errors bundle="SiteApplicationResources" property="ActivationDate"/>
        <html:errors bundle="SiteApplicationResources" property="ModificationDate"/>
        <html:errors bundle="SiteApplicationResources" property="State"/>
        <html:errors bundle="SiteApplicationResources" property="Type"/>
        <html:errors bundle="SiteApplicationResources" property="SiteOfOrigin"/>
        <html:errors bundle="SiteApplicationResources" property="Managed"/>
          <html:errors bundle="SiteApplicationResources" property="Multicast"/>
          <html:errors bundle="SiteApplicationResources" property="RemoteASN"/>
        <html:errors bundle="SiteApplicationResources" property="OSPF_Area"/>
          <html:errors bundle="SiteApplicationResources" property="Comments"/>
          <html:errors bundle="SiteApplicationResources" property="CustomerId"/>
        <html:errors bundle="SiteApplicationResources" property="PostalAddress"/>
        <html:errors bundle="SiteApplicationResources" property="__count"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitSiteAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
              <bean:message bundle="SiteApplicationResources" key="field.serviceid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="serviceid" size="16" value="<%= ServiceId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.serviceid.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="contactperson___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.contactperson.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="contactperson" size="16" value="<%= ContactPerson %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.contactperson.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="servicename___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.servicename.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="servicename" size="16" value="<%= ServiceName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.servicename.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="region___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.region.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="region" size="16" value="<%= Region %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.region.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="initiationdate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.initiationdate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="initiationdate" size="16" value="<%= InitiationDate %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.initiationdate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="activationdate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.activationdate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="activationdate" size="16" value="<%= ActivationDate %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.activationdate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="modificationdate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.modificationdate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="modificationdate" size="16" value="<%= ModificationDate %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.modificationdate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="state___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.state.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="state" size="16" value="<%= State %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.state.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="type___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.type.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="type" size="16" value="<%= Type %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.type.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="siteoforigin___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.siteoforigin.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="siteoforigin" size="16" value="<%= SiteOfOrigin %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.siteoforigin.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="managed___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.managed.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="managed" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="managed" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="managed" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.managed.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="multicast___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.multicast.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="multicast" size="16" value="<%= Multicast %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.multicast.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="remoteasn___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.remoteasn.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="remoteasn" size="16" value="<%= RemoteASN %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.remoteasn.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ospf_area___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.ospf_area.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ospf_area" size="16" value="<%= OSPF_Area %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.ospf_area.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="comments___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.comments.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="comments" size="16" value="<%= Comments %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.comments.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="customerid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.customerid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="customerid" size="16" value="<%= CustomerId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.customerid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="postaladdress___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.postaladdress.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="postaladdress" size="16" value="<%= PostalAddress %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="SiteApplicationResources" key="field.postaladdress.description"/>
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
