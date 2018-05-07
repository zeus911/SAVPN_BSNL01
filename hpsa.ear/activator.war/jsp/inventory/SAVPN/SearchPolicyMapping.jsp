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
PolicyMappingForm form = (PolicyMappingForm) request.getAttribute("PolicyMappingForm");
if(form==null) {
 form=new PolicyMappingForm();
} 
    
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(PolicyMappingConstants.DATASOURCE);
String tabName = (String) request.getParameter(PolicyMappingConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.PolicyMappingFormSearch;
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
                    if(document.getElementsByName("tclassname___hide")[0].checked) {
                            if(document.getElementsByName("profilename___hide")[0].checked) {
                            if(document.getElementsByName("exp___hide")[0].checked) {
                            if(document.getElementsByName("dscp___hide")[0].checked) {
                            if(document.getElementsByName("percentage___hide")[0].checked) {
                            if(document.getElementsByName("position___hide")[0].checked) {
                            if(document.getElementsByName("plp___hide")[0].checked) {
                            if(document.getElementsByName("queuename___hide")[0].checked) {
                            if(document.getElementsByName("cosname___hide")[0].checked) {
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
            if(checkfalse){
    alert("<bean:message bundle="PolicyMappingApplicationResources" key="<%= PolicyMappingConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.PolicyMappingFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitPolicyMappingAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.PolicyMappingFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="PolicyMappingApplicationResources" key="<%= PolicyMappingConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(PolicyMappingConstants.USER) == null) {
  response.sendRedirect(PolicyMappingConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "tclassname";
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
      String TClassName = form.getTclassname();
            String ProfileName = form.getProfilename();
            String Exp = form.getExp();
            String Dscp = form.getDscp();
            String Percentage = form.getPercentage();
            String Position = form.getPosition();
            String PLP = form.getPlp();
            String queueName = form.getQueuename();
            String CoSName = form.getCosname();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="PolicyMappingApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="PolicyMappingApplicationResources" property="TClassName"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="ProfileName"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="Exp"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="Dscp"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="Percentage"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="Position"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="PLP"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="queueName"/>
        <html:errors bundle="PolicyMappingApplicationResources" property="CoSName"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitPolicyMappingAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="tclassname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.tclassname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="tclassname" size="16" value="<%= TClassName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.tclassname.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="profilename___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.profilename.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="profilename" size="16" value="<%= ProfileName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.profilename.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="exp___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.exp.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="exp" size="16" value="<%= Exp %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.exp.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="dscp___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.dscp.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="dscp" size="16" value="<%= Dscp %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.dscp.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="percentage___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.percentage.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="percentage" size="16" value="<%= Percentage %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.percentage.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="position___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.position.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="position" size="16" value="<%= Position %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.position.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="plp___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.plp.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="plp" size="16" value="<%= PLP %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.plp.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="queuename___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.queuename.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="queuename" size="16" value="<%= queueName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.queuename.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="cosname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.cosname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="cosname" size="16" value="<%= CoSName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="PolicyMappingApplicationResources" key="field.cosname.description"/>
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
