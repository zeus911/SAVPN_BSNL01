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
GISFlowPointForm form = (GISFlowPointForm) request.getAttribute("GISFlowPointForm");
if(form==null) {
 form=new GISFlowPointForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(GISFlowPointConstants.DATASOURCE);
String tabName = (String) request.getParameter(GISFlowPointConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.GISFlowPointFormSearch;
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
                    if(document.getElementsByName("terminationpointid___hide")[0].checked) {
                            if(document.getElementsByName("attachmentid___hide")[0].checked) {
                            if(document.getElementsByName("vrfname___hide")[0].checked) {
                            if(document.getElementsByName("pe_interfaceip___hide")[0].checked) {
                            if(document.getElementsByName("pe_interfacesecondaryip___hide")[0].checked) {
                            if(document.getElementsByName("ce_interfaceip___hide")[0].checked) {
                            if(document.getElementsByName("ce_interfacesecondaryip___hide")[0].checked) {
                            if(document.getElementsByName("protocol___hide")[0].checked) {
                            if(document.getElementsByName("ospf_id___hide")[0].checked) {
                            if(document.getElementsByName("rip_id___hide")[0].checked) {
                            if(document.getElementsByName("maximum_prefix___hide")[0].checked) {
                            if(document.getElementsByName("staticroutes___hide")[0].checked) {
                            if(document.getElementsByName("ipprefixroutes___hide")[0].checked) {
                            if(document.getElementsByName("soo_configured___hide")[0].checked) {
                            if(document.getElementsByName("ratelimit_in___hide")[0].checked) {
                            if(document.getElementsByName("qosprofile_in___hide")[0].checked) {
                            if(document.getElementsByName("ratelimit_out___hide")[0].checked) {
                            if(document.getElementsByName("qosprofile_out___hide")[0].checked) {
                            if(document.getElementsByName("qoschildenabled___hide")[0].checked) {
                            if(document.getElementsByName("mcar___hide")[0].checked) {
                            if(document.getElementsByName("mcos___hide")[0].checked) {
                            if(document.getElementsByName("loopbackid___hide")[0].checked) {
                            if(document.getElementsByName("master___hide")[0].checked) {
                            if(document.getElementsByName("priority___hide")[0].checked) {
                            if(document.getElementsByName("vrrp_group_id___hide")[0].checked) {
                            if(document.getElementsByName("usagemode___hide")[0].checked) {
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
    alert("<bean:message bundle="GISFlowPointApplicationResources" key="<%= GISFlowPointConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.GISFlowPointFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitGISFlowPointAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.GISFlowPointFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="GISFlowPointApplicationResources" key="<%= GISFlowPointConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(GISFlowPointConstants.USER) == null) {
  response.sendRedirect(GISFlowPointConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "terminationpointid";
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
      String TerminationPointId = form.getTerminationpointid();
            String AttachmentId = form.getAttachmentid();
            String VRFName = form.getVrfname();
            String PE_InterfaceIP = form.getPe_interfaceip();
            String PE_InterfaceSecondaryIP = form.getPe_interfacesecondaryip();
            String CE_InterfaceIP = form.getCe_interfaceip();
            String CE_InterfaceSecondaryIP = form.getCe_interfacesecondaryip();
            String Protocol = form.getProtocol();
            String OSPF_id = form.getOspf_id();
            String Rip_id = form.getRip_id();
            String Maximum_Prefix = form.getMaximum_prefix();
          String Maximum_Prefix___ = form.getMaximum_prefix___();
            String StaticRoutes = form.getStaticroutes();
            String IPPrefixRoutes = form.getIpprefixroutes();
            String SOO_Configured = form.getSoo_configured();
            String RateLimit_in = form.getRatelimit_in();
            String QoSProfile_in = form.getQosprofile_in();
            String RateLimit_out = form.getRatelimit_out();
            String QoSProfile_out = form.getQosprofile_out();
            String QoSChildEnabled = form.getQoschildenabled();
            String mCAR = form.getMcar();
            String mCoS = form.getMcos();
            String LoopbackId = form.getLoopbackid();
            String Master = form.getMaster();
            String Priority = form.getPriority();
          String Priority___ = form.getPriority___();
            String VRRP_Group_Id = form.getVrrp_group_id();
          String VRRP_Group_Id___ = form.getVrrp_group_id___();
            String UsageMode = form.getUsagemode();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="GISFlowPointApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="GISFlowPointApplicationResources" property="TerminationPointId"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="AttachmentId"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="VRFName"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="PE_InterfaceIP"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="PE_InterfaceSecondaryIP"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="CE_InterfaceIP"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="CE_InterfaceSecondaryIP"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="Protocol"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="OSPF_id"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="Rip_id"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="Maximum_Prefix"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="StaticRoutes"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="IPPrefixRoutes"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="SOO_Configured"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="RateLimit_in"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="QoSProfile_in"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="RateLimit_out"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="QoSProfile_out"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="QoSChildEnabled"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="mCAR"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="mCoS"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="LoopbackId"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="Master"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="Priority"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="VRRP_Group_Id"/>
        <html:errors bundle="GISFlowPointApplicationResources" property="UsageMode"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitGISFlowPointAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="terminationpointid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.terminationpointid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="terminationpointid" size="16" value="<%= TerminationPointId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.terminationpointid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="attachmentid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.attachmentid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="attachmentid" size="16" value="<%= AttachmentId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.attachmentid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="vrfname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.vrfname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="vrfname" size="16" value="<%= VRFName %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.vrfname.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="pe_interfaceip___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.pe_interfaceip.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="pe_interfaceip" size="16" value="<%= PE_InterfaceIP %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.pe_interfaceip.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="pe_interfacesecondaryip___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.pe_interfacesecondaryip.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="pe_interfacesecondaryip" size="16" value="<%= PE_InterfaceSecondaryIP %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.pe_interfacesecondaryip.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ce_interfaceip___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ce_interfaceip.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ce_interfaceip" size="16" value="<%= CE_InterfaceIP %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ce_interfaceip.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ce_interfacesecondaryip___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ce_interfacesecondaryip.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ce_interfacesecondaryip" size="16" value="<%= CE_InterfaceSecondaryIP %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ce_interfacesecondaryip.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="protocol___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.protocol.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="protocol" size="16" value="<%= Protocol %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.protocol.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ospf_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ospf_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ospf_id" size="16" value="<%= OSPF_id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ospf_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="rip_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.rip_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="rip_id" size="16" value="<%= Rip_id %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.rip_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="maximum_prefix___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.maximum_prefix.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="maximum_prefix" size="16" value="<%= Maximum_Prefix %>"/>
                                  -
                  <html:text property="maximum_prefix___" size="16" value="<%= Maximum_Prefix___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.maximum_prefix.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="staticroutes___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.staticroutes.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="staticroutes" size="16" value="<%= StaticRoutes %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.staticroutes.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ipprefixroutes___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ipprefixroutes.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ipprefixroutes" size="16" value="<%= IPPrefixRoutes %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ipprefixroutes.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="soo_configured___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.soo_configured.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="soo_configured" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="soo_configured" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="soo_configured" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.soo_configured.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ratelimit_in___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ratelimit_in.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ratelimit_in" size="16" value="<%= RateLimit_in %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ratelimit_in.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="qosprofile_in___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.qosprofile_in.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="qosprofile_in" size="16" value="<%= QoSProfile_in %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.qosprofile_in.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ratelimit_out___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ratelimit_out.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ratelimit_out" size="16" value="<%= RateLimit_out %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.ratelimit_out.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="qosprofile_out___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.qosprofile_out.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="qosprofile_out" size="16" value="<%= QoSProfile_out %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.qosprofile_out.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="qoschildenabled___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.qoschildenabled.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="qoschildenabled" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="qoschildenabled" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="qoschildenabled" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.qoschildenabled.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="mcar___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.mcar.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="mcar" size="16" value="<%= mCAR %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.mcar.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="mcos___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.mcos.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="mcos" size="16" value="<%= mCoS %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.mcos.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="loopbackid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.loopbackid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="loopbackid" size="16" value="<%= LoopbackId %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.loopbackid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="master___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.master.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="master" size="16" value="<%= Master %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.master.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="priority___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.priority.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="priority" size="16" value="<%= Priority %>"/>
                                  -
                  <html:text property="priority___" size="16" value="<%= Priority___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.priority.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="vrrp_group_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.vrrp_group_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="vrrp_group_id" size="16" value="<%= VRRP_Group_Id %>"/>
                                  -
                  <html:text property="vrrp_group_id___" size="16" value="<%= VRRP_Group_Id___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.vrrp_group_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="usagemode___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.usagemode.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="usagemode" size="16" value="<%= UsageMode %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="GISFlowPointApplicationResources" key="field.usagemode.description"/>
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
