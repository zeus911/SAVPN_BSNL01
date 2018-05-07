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
ASBRAccessFlowForm form = (ASBRAccessFlowForm) request.getAttribute("ASBRAccessFlowForm");
if(form==null) {
 form=new ASBRAccessFlowForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(ASBRAccessFlowConstants.DATASOURCE);
String tabName = (String) request.getParameter(ASBRAccessFlowConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.ASBRAccessFlowFormSearch;
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
                    if(document.getElementsByName("asbrserviceid___hide")[0].checked) {
                            if(document.getElementsByName("connectionid___hide")[0].checked) {
                            if(document.getElementsByName("vpnid___hide")[0].checked) {
                            if(document.getElementsByName("networkid1___hide")[0].checked) {
                                      if(document.getElementsByName("topology1___hide")[0].checked) {
                            if(document.getElementsByName("networkid2___hide")[0].checked) {
                                      if(document.getElementsByName("topology2___hide")[0].checked) {
                            if(document.getElementsByName("vlanid___hide")[0].checked) {
                            if(document.getElementsByName("ipnet___hide")[0].checked) {
                            if(document.getElementsByName("netmask___hide")[0].checked) {
                            if(document.getElementsByName("status___hide")[0].checked) {
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
            if(checkfalse){
    alert("<bean:message bundle="ASBRAccessFlowApplicationResources" key="<%= ASBRAccessFlowConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.ASBRAccessFlowFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitASBRAccessFlowAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.ASBRAccessFlowFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="ASBRAccessFlowApplicationResources" key="<%= ASBRAccessFlowConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(ASBRAccessFlowConstants.USER) == null) {
  response.sendRedirect(ASBRAccessFlowConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "asbrserviceid";
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
      String ASBRServiceId = form.getAsbrserviceid();
            String ConnectionID = form.getConnectionid();
            String VPNId = form.getVpnid();
            String NetworkId1 = form.getNetworkid1();
              String Topology1 = form.getTopology1();
            String NetworkId2 = form.getNetworkid2();
              String Topology2 = form.getTopology2();
            String VlanId = form.getVlanid();
            String IPNet = form.getIpnet();
            String Netmask = form.getNetmask();
            String Status = form.getStatus();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="ASBRAccessFlowApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="ASBRAccessFlowApplicationResources" property="ASBRServiceId"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="ConnectionID"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="VPNId"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="NetworkId1"/>
          <html:errors bundle="ASBRAccessFlowApplicationResources" property="Topology1"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="NetworkId2"/>
          <html:errors bundle="ASBRAccessFlowApplicationResources" property="Topology2"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="VlanId"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="IPNet"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="Netmask"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="Status"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitASBRAccessFlowAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="asbrserviceid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.asbrserviceid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="asbrserviceid" size="16" value="<%= ASBRServiceId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.asbrserviceid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="connectionid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.connectionid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="connectionid" size="16" value="<%= ConnectionID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.connectionid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="vpnid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.vpnid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="vpnid" size="16" value="<%= VPNId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.vpnid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="networkid1___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.networkid1.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="networkid1" size="16" value="<%= NetworkId1 %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.networkid1.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="topology1___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.topology1.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="topology1" size="16" value="<%= Topology1 %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.topology1.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="networkid2___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.networkid2.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="networkid2" size="16" value="<%= NetworkId2 %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.networkid2.description"/>
                          </table:cell>
          </table:row>
                                              <table:row>
            <table:cell>
              <center>
                <html:checkbox property="topology2___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.topology2.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="topology2" size="16" value="<%= Topology2 %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.topology2.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="vlanid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.vlanid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="vlanid" size="16" value="<%= VlanId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.vlanid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ipnet___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.ipnet.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ipnet" size="16" value="<%= IPNet %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.ipnet.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="netmask___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.netmask.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="netmask" size="16" value="<%= Netmask %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.netmask.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="status___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.status.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="status" size="16" value="<%= Status %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.status.description"/>
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
