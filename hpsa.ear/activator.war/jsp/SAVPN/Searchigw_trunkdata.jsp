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
igw_trunkdataForm form = (igw_trunkdataForm) request.getAttribute("igw_trunkdataForm");
if(form==null) {
 form=new igw_trunkdataForm();
} 
    
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
  
String datasource = (String) request.getParameter(igw_trunkdataConstants.DATASOURCE);
String tabName = (String) request.getParameter(igw_trunkdataConstants.TAB_NAME);
String viParameter = (String) request.getParameter("vi");
String viewParameter = (String) request.getParameter("view");
String ndidParameter = (String) request.getParameter("ndid");
%>

<script>
function clearForm() {
var formObj = document.igw_trunkdataFormSearch;
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
                    if(document.getElementsByName("trunkdata_id___hide")[0].checked) {
                            if(document.getElementsByName("parent_trunkdata___hide")[0].checked) {
                            if(document.getElementsByName("trunk_id___hide")[0].checked) {
                            if(document.getElementsByName("side_service_id___hide")[0].checked) {
                            if(document.getElementsByName("side_name___hide")[0].checked) {
                            if(document.getElementsByName("side_sort_name___hide")[0].checked) {
                            if(document.getElementsByName("router_id___hide")[0].checked) {
                            if(document.getElementsByName("interfaces_id___hide")[0].checked) {
                            if(document.getElementsByName("ipnet_pool___hide")[0].checked) {
                            if(document.getElementsByName("ipnet_address___hide")[0].checked) {
                            if(document.getElementsByName("ipnet_submask___hide")[0].checked) {
                            if(document.getElementsByName("side_description___hide")[0].checked) {
                            if(document.getElementsByName("nego_flag___hide")[0].checked) {
                            if(document.getElementsByName("linkprotocol___hide")[0].checked) {
                            if(document.getElementsByName("mtu___hide")[0].checked) {
                            if(document.getElementsByName("pim_flag___hide")[0].checked) {
                            if(document.getElementsByName("ospfnet_type_flag___hide")[0].checked) {
                            if(document.getElementsByName("ospf_cost___hide")[0].checked) {
                            if(document.getElementsByName("ospf_password___hide")[0].checked) {
                            if(document.getElementsByName("ldp_flag___hide")[0].checked) {
                            if(document.getElementsByName("ldp_password___hide")[0].checked) {
                            if(document.getElementsByName("interface_description___hide")[0].checked) {
                            if(document.getElementsByName("traffic_policyname___hide")[0].checked) {
                            if(document.getElementsByName("policy_type___hide")[0].checked) {
                            if(document.getElementsByName("ipv6_pool___hide")[0].checked) {
                            if(document.getElementsByName("ipv6_address___hide")[0].checked) {
                            if(document.getElementsByName("encapsulation___hide")[0].checked) {
                            if(document.getElementsByName("ipbinding_flag___hide")[0].checked) {
                            if(document.getElementsByName("ospf_processid___hide")[0].checked) {
                            if(document.getElementsByName("area___hide")[0].checked) {
                            if(document.getElementsByName("bandwidth___hide")[0].checked) {
                            if(document.getElementsByName("rsvp_bandwidth___hide")[0].checked) {
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
                            }
                            }
                            }
                            }
                            }
                            }
            if(checkfalse){
    alert("<bean:message bundle="igw_trunkdataApplicationResources" key="<%= igw_trunkdataConstants.JSP_SEARCH_NO_SHOW %>"/>");
  }else{
    window.document.igw_trunkdataFormSearch.action = '/activator<%=moduleConfig%>/SearchCommitigw_trunkdataAction.do?datasource=<%= datasource %>&tab_name=<%= tabName %>&vi=<%= viParameter%>&view=<%= viewParameter %>&ndid=<%= ndidParameter %>';
    window.document.igw_trunkdataFormSearch.submit();
  }
  }
</script>

<html>
  <head>
    <title><bean:message bundle="igw_trunkdataApplicationResources" key="<%= igw_trunkdataConstants.JSP_CREATION_TITLE %>"/></title>
<%
// Check if there is a valid session available.
if (session == null || session.getValue(igw_trunkdataConstants.USER) == null) {
  response.sendRedirect(igw_trunkdataConstants.NULL_SESSION);
  return;
}

String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String _location_ = null; 
         _location_ = "trunkdata_id";
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
      String TRUNKDATA_ID = form.getTrunkdata_id();
            String PARENT_TRUNKDATA = form.getParent_trunkdata();
            String TRUNK_ID = form.getTrunk_id();
            String SIDE_SERVICE_ID = form.getSide_service_id();
            String SIDE_NAME = form.getSide_name();
            String SIDE_SORT_NAME = form.getSide_sort_name();
            String ROUTER_ID = form.getRouter_id();
            String INTERFACES_ID = form.getInterfaces_id();
            String IPNET_POOL = form.getIpnet_pool();
            String IPNET_ADDRESS = form.getIpnet_address();
            String IPNET_SUBMASK = form.getIpnet_submask();
            String SIDE_DESCRIPTION = form.getSide_description();
            String NEGO_FLAG = form.getNego_flag();
            String LINKPROTOCOL = form.getLinkprotocol();
            String MTU = form.getMtu();
          String MTU___ = form.getMtu___();
            String PIM_FLAG = form.getPim_flag();
            String OSPFNET_TYPE_FLAG = form.getOspfnet_type_flag();
            String OSPF_COST = form.getOspf_cost();
          String OSPF_COST___ = form.getOspf_cost___();
            String OSPF_PASSWORD = form.getOspf_password();
            String LDP_FLAG = form.getLdp_flag();
            String LDP_PASSWORD = form.getLdp_password();
            String INTERFACE_DESCRIPTION = form.getInterface_description();
            String TRAFFIC_POLICYNAME = form.getTraffic_policyname();
            String POLICY_TYPE = form.getPolicy_type();
            String IPV6_POOL = form.getIpv6_pool();
            String IPV6_ADDRESS = form.getIpv6_address();
            String ENCAPSULATION = form.getEncapsulation();
            String IPBINDING_FLAG = form.getIpbinding_flag();
            String OSPF_PROCESSID = form.getOspf_processid();
          String OSPF_PROCESSID___ = form.getOspf_processid___();
            String AREA = form.getArea();
            String BANDWIDTH = form.getBandwidth();
            String RSVP_BANDWIDTH = form.getRsvp_bandwidth();
      
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="igw_trunkdataApplicationResources" key="jsp.search.title"/>
</h2> 

<div style="color:#ff0000;">
      <html:errors bundle="igw_trunkdataApplicationResources" property="TRUNKDATA_ID"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="PARENT_TRUNKDATA"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="TRUNK_ID"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="SIDE_SERVICE_ID"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="SIDE_NAME"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="SIDE_SORT_NAME"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="ROUTER_ID"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="INTERFACES_ID"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="IPNET_POOL"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="IPNET_ADDRESS"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="IPNET_SUBMASK"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="SIDE_DESCRIPTION"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="NEGO_FLAG"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="LINKPROTOCOL"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="MTU"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="PIM_FLAG"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="OSPFNET_TYPE_FLAG"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="OSPF_COST"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="OSPF_PASSWORD"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="LDP_FLAG"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="LDP_PASSWORD"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="INTERFACE_DESCRIPTION"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="TRAFFIC_POLICYNAME"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="POLICY_TYPE"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="IPV6_POOL"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="IPV6_ADDRESS"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="ENCAPSULATION"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="IPBINDING_FLAG"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="OSPF_PROCESSID"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="AREA"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="BANDWIDTH"/>
        <html:errors bundle="igw_trunkdataApplicationResources" property="RSVP_BANDWIDTH"/>
  <html:errors bundle="InventoryResources" property="warning"/>
</div>
<% String searchFormAction = "/SearchCommitigw_trunkdataAction.do?datasource="+datasource+"&tab_name="+tabName+"&vi="+ viParameter+"&view="+ viewParameter +"&ndid="+ ndidParameter ;%>

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
                <html:checkbox property="trunkdata_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.trunkdata_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="trunkdata_id" size="16" value="<%= TRUNKDATA_ID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.trunkdata_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="parent_trunkdata___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.parent_trunkdata.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="parent_trunkdata" size="16" value="<%= PARENT_TRUNKDATA %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.parent_trunkdata.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="trunk_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.trunk_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="trunk_id" size="16" value="<%= TRUNK_ID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.trunk_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="side_service_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_service_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="side_service_id" size="16" value="<%= SIDE_SERVICE_ID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_service_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="side_name___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_name.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="side_name" size="16" value="<%= SIDE_NAME %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_name.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="side_sort_name___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_sort_name.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="side_sort_name" size="16" value="<%= SIDE_SORT_NAME %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_sort_name.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="router_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.router_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="router_id" size="16" value="<%= ROUTER_ID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.router_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="interfaces_id___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.interfaces_id.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="interfaces_id" size="16" value="<%= INTERFACES_ID %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.interfaces_id.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ipnet_pool___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipnet_pool.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ipnet_pool" size="16" value="<%= IPNET_POOL %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipnet_pool.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ipnet_address___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipnet_address.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ipnet_address" size="16" value="<%= IPNET_ADDRESS %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipnet_address.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ipnet_submask___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipnet_submask.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ipnet_submask" size="16" value="<%= IPNET_SUBMASK %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipnet_submask.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="side_description___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_description.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="side_description" size="16" value="<%= SIDE_DESCRIPTION %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_description.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="nego_flag___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.nego_flag.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="nego_flag" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="nego_flag" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="nego_flag" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.nego_flag.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="linkprotocol___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.linkprotocol.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="linkprotocol" size="16" value="<%= LINKPROTOCOL %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.linkprotocol.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="mtu___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.mtu.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="mtu" size="16" value="<%= MTU %>"/>
                                  -
                  <html:text property="mtu___" size="16" value="<%= MTU___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.mtu.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="pim_flag___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.pim_flag.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="pim_flag" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="pim_flag" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="pim_flag" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.pim_flag.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ospfnet_type_flag___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospfnet_type_flag.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="ospfnet_type_flag" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="ospfnet_type_flag" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="ospfnet_type_flag" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospfnet_type_flag.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ospf_cost___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospf_cost.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ospf_cost" size="16" value="<%= OSPF_COST %>"/>
                                  -
                  <html:text property="ospf_cost___" size="16" value="<%= OSPF_COST___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospf_cost.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ospf_password___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospf_password.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ospf_password" size="16" value="<%= OSPF_PASSWORD %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospf_password.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ldp_flag___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ldp_flag.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="ldp_flag" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="ldp_flag" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="ldp_flag" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ldp_flag.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ldp_password___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ldp_password.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ldp_password" size="16" value="<%= LDP_PASSWORD %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ldp_password.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="interface_description___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.interface_description.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="interface_description" size="16" value="<%= INTERFACE_DESCRIPTION %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.interface_description.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="traffic_policyname___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.traffic_policyname.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="traffic_policyname" size="16" value="<%= TRAFFIC_POLICYNAME %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.traffic_policyname.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="policy_type___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.policy_type.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="policy_type" size="16" value="<%= POLICY_TYPE %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.policy_type.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ipv6_pool___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipv6_pool.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ipv6_pool" size="16" value="<%= IPV6_POOL %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipv6_pool.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ipv6_address___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipv6_address.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ipv6_address" size="16" value="<%= IPV6_ADDRESS %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipv6_address.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="encapsulation___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.encapsulation.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="encapsulation" size="16" value="<%= ENCAPSULATION %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.encapsulation.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ipbinding_flag___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipbinding_flag.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <bean:message bundle="InventoryResources" key="true.label"/>
                <html:radio property="ipbinding_flag" value="true"/>
                <bean:message bundle="InventoryResources" key="false.label"/>
                <html:radio property="ipbinding_flag" value="false"/>
                <bean:message bundle="InventoryResources" key="all.label"/>
                <html:radio property="ipbinding_flag" value=""/>
                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipbinding_flag.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="ospf_processid___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospf_processid.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="ospf_processid" size="16" value="<%= OSPF_PROCESSID %>"/>
                                  -
                  <html:text property="ospf_processid___" size="16" value="<%= OSPF_PROCESSID___ %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospf_processid.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="area___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.area.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="area" size="16" value="<%= AREA %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.area.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="bandwidth___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.bandwidth.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="bandwidth" size="16" value="<%= BANDWIDTH %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.bandwidth.description"/>
                          </table:cell>
          </table:row>
                                <table:row>
            <table:cell>
              <center>
                <html:checkbox property="rsvp_bandwidth___hide" value="true"/>
              </center>
            </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.rsvp_bandwidth.alias"/>
            
            </table:cell>
            
            <table:cell>
                              <html:text property="rsvp_bandwidth" size="16" value="<%= RSVP_BANDWIDTH %>"/>
                                          </table:cell>

            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.rsvp_bandwidth.description"/>
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
