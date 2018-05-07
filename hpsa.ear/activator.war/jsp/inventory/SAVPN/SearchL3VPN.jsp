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
L3VPNForm form = (L3VPNForm) request.getAttribute("L3VPNForm");
if(form==null) {
 form=new L3VPNForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(L3VPNConstants.DATASOURCE);
String tabName = (String) request.getParameter(L3VPNConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.L3VPNFormSearch;
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
                            if(document.getElementsByName("qosprofile_pe___hide")[0].checked) {
                            if(document.getElementsByName("qosprofile_ce___hide")[0].checked) {
                            if(document.getElementsByName("state___hide")[0].checked) {
                            if(document.getElementsByName("type___hide")[0].checked) {
                            if(document.getElementsByName("addressfamily___hide")[0].checked) {
                            if(document.getElementsByName("vpntopologytype___hide")[0].checked) {
                                      if(document.getElementsByName("multicast___hide")[0].checked) {
                            if(document.getElementsByName("parentid___hide")[0].checked) {
                                                if(document.getElementsByName("comments___hide")[0].checked) {
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
    alert("<bean:message bundle="L3VPNApplicationResources" key="<%= L3VPNConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.L3VPNFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitL3VPNAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.L3VPNFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="L3VPNApplicationResources" key="<%= L3VPNConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(L3VPNConstants.USER) == null) {
  response.sendRedirect(L3VPNConstants.NULL_SESSION);
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
            String QoSProfile_PE = form.getQosprofile_pe();
            String QoSProfile_CE = form.getQosprofile_ce();
            String State = form.getState();
            String Type = form.getType();
            String AddressFamily = form.getAddressfamily();
            String VPNTopologyType = form.getVpntopologytype();
              String Multicast = form.getMulticast();
            String ParentId = form.getParentid();
                String Comments = form.getComments();
        
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="L3VPNApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="L3VPNApplicationResources" property="ServiceId"/>
        <html:errors bundle="L3VPNApplicationResources" property="CustomerId"/>
          <html:errors bundle="L3VPNApplicationResources" property="ContactPerson"/>
        <html:errors bundle="L3VPNApplicationResources" property="ServiceName"/>
          <html:errors bundle="L3VPNApplicationResources" property="InitiationDate"/>
        <html:errors bundle="L3VPNApplicationResources" property="ActivationDate"/>
        <html:errors bundle="L3VPNApplicationResources" property="ModificationDate"/>
        <html:errors bundle="L3VPNApplicationResources" property="QoSProfile_PE"/>
        <html:errors bundle="L3VPNApplicationResources" property="QoSProfile_CE"/>
        <html:errors bundle="L3VPNApplicationResources" property="State"/>
        <html:errors bundle="L3VPNApplicationResources" property="Type"/>
        <html:errors bundle="L3VPNApplicationResources" property="AddressFamily"/>
        <html:errors bundle="L3VPNApplicationResources" property="VPNTopologyType"/>
          <html:errors bundle="L3VPNApplicationResources" property="Multicast"/>
        <html:errors bundle="L3VPNApplicationResources" property="ParentId"/>
            <html:errors bundle="L3VPNApplicationResources" property="Comments"/>
        <html:errors bundle="L3VPNApplicationResources" property="__count"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitL3VPNAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
              <bean:message bundle="L3VPNApplicationResources" key="field.serviceid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="serviceid" size="16" value="<%= ServiceId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.serviceid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="customerid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.customerid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="customerid" size="16" value="<%= CustomerId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.customerid.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="contactperson___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.contactperson.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="contactperson" size="16" value="<%= ContactPerson %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.contactperson.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="servicename___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.servicename.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="servicename" size="16" value="<%= ServiceName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.servicename.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="initiationdate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.initiationdate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="initiationdate" size="16" value="<%= InitiationDate %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.initiationdate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="activationdate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.activationdate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="activationdate" size="16" value="<%= ActivationDate %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.activationdate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="modificationdate___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.modificationdate.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="modificationdate" size="16" value="<%= ModificationDate %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.modificationdate.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="qosprofile_pe___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.qosprofile_pe.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="qosprofile_pe" size="16" value="<%= QoSProfile_PE %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.qosprofile_pe.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="qosprofile_ce___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.qosprofile_ce.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="qosprofile_ce" size="16" value="<%= QoSProfile_CE %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.qosprofile_ce.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="state___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.state.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="state" size="16" value="<%= State %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.state.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="type___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.type.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="type" size="16" value="<%= Type %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.type.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="addressfamily___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.addressfamily.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="addressfamily" size="16" value="<%= AddressFamily %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.addressfamily.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="vpntopologytype___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.vpntopologytype.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="vpntopologytype" size="16" value="<%= VPNTopologyType %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.vpntopologytype.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="multicast___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.multicast.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="multicast" size="16" value="<%= Multicast %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.multicast.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="parentid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.parentid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="parentid" size="16" value="<%= ParentId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.parentid.description"/>
                          </table:cell>
          </table:row>
                                                            <table:row>
            <table:cell>
              <center>
                <html:checkbox property="comments___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.comments.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="comments" size="16" value="<%= Comments %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="L3VPNApplicationResources" key="field.comments.description"/>
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
