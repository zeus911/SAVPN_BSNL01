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
RateLimitForm form = (RateLimitForm) request.getAttribute("RateLimitForm");
if(form==null) {
 form=new RateLimitForm();
} 
    
      
      
      
      
      
  
String datasource = (String) request.getParameter(RateLimitConstants.DATASOURCE);
String tabName = (String) request.getParameter(RateLimitConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.RateLimitFormSearch;
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
                    if(document.getElementsByName("ratelimitname___hide")[0].checked) {
                            if(document.getElementsByName("description___hide")[0].checked) {
                            if(document.getElementsByName("burstmaximum___hide")[0].checked) {
                            if(document.getElementsByName("burstnormal___hide")[0].checked) {
                            if(document.getElementsByName("averagebw___hide")[0].checked) {
                            if(document.getElementsByName("compliant___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="RateLimitApplicationResources" key="<%= RateLimitConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.RateLimitFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitRateLimitAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.RateLimitFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="RateLimitApplicationResources" key="<%= RateLimitConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(RateLimitConstants.USER) == null) {
  response.sendRedirect(RateLimitConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "ratelimitname";
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
      String RateLimitName = form.getRatelimitname();
            String Description = form.getDescription();
            String BurstMaximum = form.getBurstmaximum();
          String BurstMaximum___ = form.getBurstmaximum___();
            String BurstNormal = form.getBurstnormal();
          String BurstNormal___ = form.getBurstnormal___();
            String AverageBW = form.getAveragebw();
          String AverageBW___ = form.getAveragebw___();
            String Compliant = form.getCompliant();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="RateLimitApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="RateLimitApplicationResources" property="RateLimitName"/>
        <html:errors bundle="RateLimitApplicationResources" property="Description"/>
        <html:errors bundle="RateLimitApplicationResources" property="BurstMaximum"/>
        <html:errors bundle="RateLimitApplicationResources" property="BurstNormal"/>
        <html:errors bundle="RateLimitApplicationResources" property="AverageBW"/>
        <html:errors bundle="RateLimitApplicationResources" property="Compliant"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitRateLimitAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="ratelimitname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="RateLimitApplicationResources" key="field.ratelimitname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ratelimitname" size="16" value="<%= RateLimitName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="RateLimitApplicationResources" key="field.ratelimitname.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="description___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="RateLimitApplicationResources" key="field.description.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="description" size="16" value="<%= Description %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="RateLimitApplicationResources" key="field.description.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="burstmaximum___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="RateLimitApplicationResources" key="field.burstmaximum.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="burstmaximum" size="16" value="<%= BurstMaximum %>"/>
                                  -
                  <html:text property="burstmaximum___" size="16" value="<%= BurstMaximum___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="RateLimitApplicationResources" key="field.burstmaximum.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="burstnormal___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="RateLimitApplicationResources" key="field.burstnormal.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="burstnormal" size="16" value="<%= BurstNormal %>"/>
                                  -
                  <html:text property="burstnormal___" size="16" value="<%= BurstNormal___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="RateLimitApplicationResources" key="field.burstnormal.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="averagebw___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="RateLimitApplicationResources" key="field.averagebw.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="averagebw" size="16" value="<%= AverageBW %>"/>
                                  -
                  <html:text property="averagebw___" size="16" value="<%= AverageBW___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="RateLimitApplicationResources" key="field.averagebw.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="compliant___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="RateLimitApplicationResources" key="field.compliant.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="compliant" size="16" value="<%= Compliant %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="RateLimitApplicationResources" key="field.compliant.description"/>
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
