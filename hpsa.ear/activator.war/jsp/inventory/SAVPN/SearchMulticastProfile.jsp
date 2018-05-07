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
MulticastProfileForm form = (MulticastProfileForm) request.getAttribute("MulticastProfileForm");
if(form==null) {
 form=new MulticastProfileForm();
} 
    
      
      
      
      
      
  
String datasource = (String) request.getParameter(MulticastProfileConstants.DATASOURCE);
String tabName = (String) request.getParameter(MulticastProfileConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.MulticastProfileFormSearch;
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
                    if(document.getElementsByName("mcastprofileid___hide")[0].checked) {
                            if(document.getElementsByName("vpnid___hide")[0].checked) {
                            if(document.getElementsByName("multicastsource___hide")[0].checked) {
                            if(document.getElementsByName("multicastgroup___hide")[0].checked) {
                            if(document.getElementsByName("bandwidth___hide")[0].checked) {
                            if(document.getElementsByName("cos___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="MulticastProfileApplicationResources" key="<%= MulticastProfileConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.MulticastProfileFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitMulticastProfileAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.MulticastProfileFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="MulticastProfileApplicationResources" key="<%= MulticastProfileConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(MulticastProfileConstants.USER) == null) {
  response.sendRedirect(MulticastProfileConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "mcastprofileid";
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
      String MCastProfileId = form.getMcastprofileid();
            String VPNId = form.getVpnid();
            String MulticastSource = form.getMulticastsource();
            String MulticastGroup = form.getMulticastgroup();
            String Bandwidth = form.getBandwidth();
            String CoS = form.getCos();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="MulticastProfileApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="MulticastProfileApplicationResources" property="MCastProfileId"/>
        <html:errors bundle="MulticastProfileApplicationResources" property="VPNId"/>
        <html:errors bundle="MulticastProfileApplicationResources" property="MulticastSource"/>
        <html:errors bundle="MulticastProfileApplicationResources" property="MulticastGroup"/>
        <html:errors bundle="MulticastProfileApplicationResources" property="Bandwidth"/>
        <html:errors bundle="MulticastProfileApplicationResources" property="CoS"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitMulticastProfileAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="mcastprofileid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.mcastprofileid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="mcastprofileid" size="16" value="<%= MCastProfileId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.mcastprofileid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="vpnid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.vpnid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="vpnid" size="16" value="<%= VPNId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.vpnid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="multicastsource___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastsource.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="multicastsource" size="16" value="<%= MulticastSource %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastsource.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="multicastgroup___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastgroup.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="multicastgroup" size="16" value="<%= MulticastGroup %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.multicastgroup.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="bandwidth___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.bandwidth.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="bandwidth" size="16" value="<%= Bandwidth %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.bandwidth.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="cos___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.cos.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="cos" size="16" value="<%= CoS %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="MulticastProfileApplicationResources" key="field.cos.description"/>
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
