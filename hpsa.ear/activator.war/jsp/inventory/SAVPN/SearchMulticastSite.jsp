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
MulticastSiteForm form = (MulticastSiteForm) request.getAttribute("MulticastSiteForm");
if(form==null) {
 form=new MulticastSiteForm();
} 
    
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(MulticastSiteConstants.DATASOURCE);
String tabName = (String) request.getParameter(MulticastSiteConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.MulticastSiteFormSearch;
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
                    if(document.getElementsByName("attachmentid___hide")[0].checked) {
                            if(document.getElementsByName("multicastloopbackaddress___hide")[0].checked) {
                            if(document.getElementsByName("virtualtunnelid___hide")[0].checked) {
                            if(document.getElementsByName("rpmode___hide")[0].checked) {
                            if(document.getElementsByName("rpaddress___hide")[0].checked) {
                            if(document.getElementsByName("msdplocaladdress___hide")[0].checked) {
                            if(document.getElementsByName("msdppeeraddress___hide")[0].checked) {
              checkfalse=true;
                    }
                            }
                            }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="MulticastSiteApplicationResources" key="<%= MulticastSiteConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.MulticastSiteFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitMulticastSiteAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.MulticastSiteFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="MulticastSiteApplicationResources" key="<%= MulticastSiteConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(MulticastSiteConstants.USER) == null) {
  response.sendRedirect(MulticastSiteConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "attachmentid";
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
      String AttachmentId = form.getAttachmentid();
            String MulticastLoopbackAddress = form.getMulticastloopbackaddress();
            String VirtualTunnelId = form.getVirtualtunnelid();
            String RPMode = form.getRpmode();
            String RPAddress = form.getRpaddress();
            String MSDPLocalAddress = form.getMsdplocaladdress();
            String MSDPPeerAddress = form.getMsdppeeraddress();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="MulticastSiteApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="MulticastSiteApplicationResources" property="AttachmentId"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="MulticastLoopbackAddress"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="VirtualTunnelId"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="RPMode"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="RPAddress"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="MSDPLocalAddress"/>
        <html:errors bundle="MulticastSiteApplicationResources" property="MSDPPeerAddress"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitMulticastSiteAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="attachmentid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.attachmentid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="attachmentid" size="16" value="<%= AttachmentId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.attachmentid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="multicastloopbackaddress___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.multicastloopbackaddress.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="multicastloopbackaddress" size="16" value="<%= MulticastLoopbackAddress %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.multicastloopbackaddress.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="virtualtunnelid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.virtualtunnelid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="virtualtunnelid" size="16" value="<%= VirtualTunnelId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.virtualtunnelid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="rpmode___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.rpmode.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="rpmode" size="16" value="<%= RPMode %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.rpmode.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="rpaddress___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="rpaddress" size="16" value="<%= RPAddress %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.rpaddress.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="msdplocaladdress___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.msdplocaladdress.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="msdplocaladdress" size="16" value="<%= MSDPLocalAddress %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.msdplocaladdress.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="msdppeeraddress___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.msdppeeraddress.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="msdppeeraddress" size="16" value="<%= MSDPPeerAddress %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="MulticastSiteApplicationResources" key="field.msdppeeraddress.description"/>
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
