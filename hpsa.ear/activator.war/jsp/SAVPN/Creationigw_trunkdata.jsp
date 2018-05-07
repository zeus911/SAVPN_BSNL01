<!DOCTYPE html>
<%@ page pageEncoding="utf-8"%>

<%@ page import="java.util.*,
        com.hp.ov.activator.vpn.inventory.*,
        com.hp.ov.activator.inventory.SAVPN.*,
        org.apache.struts.util.LabelValueBean,
        org.apache.struts.action.Action,
        java.text.NumberFormat,
        org.apache.struts.action.ActionErrors,
        com.hp.ov.activator.inventory.facilities.StringFacility " %>

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
NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                                                                
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(igw_trunkdataConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitigw_trunkdataAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
                    _location_ = "parent_trunkdata";
                                                                                                                                                                                                }
%>

<html>
  <head>
    <title><bean:message bundle="igw_trunkdataApplicationResources" key="<%= igw_trunkdataConstants.JSP_CREATION_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
      H1 { color: red; font-size: 13px }
    </style>
    <script>
    function sendthis(focusthis)
    {
      window.document.igw_trunkdataForm.action = '/activator<%=moduleConfig%>/CreationFormigw_trunkdataAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.igw_trunkdataForm.submit();
    }
    function performCommit()
    {
      window.document.igw_trunkdataForm.action = '/activator<%=moduleConfig%>/CreationCommitigw_trunkdataAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.igw_trunkdataForm.submit();
    }
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
if ( errorMessage != null && !errorMessage.equals("") ) {
%>
      var alertMsg = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
      alertMsg.setBounds(400, 120);
      alertMsg.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
      alertMsg.show();
<%
}
%>
    }
    </script>
  </head>
  <body style="overflow:auto;" onload="init();">
<%

com.hp.ov.activator.vpn.inventory.igw_trunkdata beanigw_trunkdata = (com.hp.ov.activator.vpn.inventory.igw_trunkdata) request.getAttribute(igw_trunkdataConstants.IGW_TRUNKDATA_BEAN);

      String TRUNKDATA_ID = beanigw_trunkdata.getTrunkdata_id();
                String PARENT_TRUNKDATA = beanigw_trunkdata.getParent_trunkdata();
                String TRUNK_ID = beanigw_trunkdata.getTrunk_id();
                String SIDE_SERVICE_ID = beanigw_trunkdata.getSide_service_id();
                String SIDE_NAME = beanigw_trunkdata.getSide_name();
                String SIDE_SORT_NAME = beanigw_trunkdata.getSide_sort_name();
                String ROUTER_ID = beanigw_trunkdata.getRouter_id();
                String INTERFACES_ID = beanigw_trunkdata.getInterfaces_id();
                String IPNET_POOL = beanigw_trunkdata.getIpnet_pool();
                String IPNET_ADDRESS = beanigw_trunkdata.getIpnet_address();
                String IPNET_SUBMASK = beanigw_trunkdata.getIpnet_submask();
                String SIDE_DESCRIPTION = beanigw_trunkdata.getSide_description();
                boolean NEGO_FLAG = new Boolean(beanigw_trunkdata.getNego_flag()).booleanValue();
                String LINKPROTOCOL = beanigw_trunkdata.getLinkprotocol();
                String MTU = "" + beanigw_trunkdata.getMtu();
      MTU = (MTU != null && !(MTU.trim().equals(""))) ? nfA.format(beanigw_trunkdata.getMtu()) : "";
                      boolean PIM_FLAG = new Boolean(beanigw_trunkdata.getPim_flag()).booleanValue();
                boolean OSPFNET_TYPE_FLAG = new Boolean(beanigw_trunkdata.getOspfnet_type_flag()).booleanValue();
                String OSPF_COST = "" + beanigw_trunkdata.getOspf_cost();
      OSPF_COST = (OSPF_COST != null && !(OSPF_COST.trim().equals(""))) ? nfA.format(beanigw_trunkdata.getOspf_cost()) : "";
                      String OSPF_PASSWORD = beanigw_trunkdata.getOspf_password();
                boolean LDP_FLAG = new Boolean(beanigw_trunkdata.getLdp_flag()).booleanValue();
                String LDP_PASSWORD = beanigw_trunkdata.getLdp_password();
                String INTERFACE_DESCRIPTION = beanigw_trunkdata.getInterface_description();
                String TRAFFIC_POLICYNAME = beanigw_trunkdata.getTraffic_policyname();
                String POLICY_TYPE = beanigw_trunkdata.getPolicy_type();
                String IPV6_POOL = beanigw_trunkdata.getIpv6_pool();
                String IPV6_ADDRESS = beanigw_trunkdata.getIpv6_address();
                String ENCAPSULATION = beanigw_trunkdata.getEncapsulation();
                boolean IPBINDING_FLAG = new Boolean(beanigw_trunkdata.getIpbinding_flag()).booleanValue();
                String OSPF_PROCESSID = "" + beanigw_trunkdata.getOspf_processid();
      OSPF_PROCESSID = (OSPF_PROCESSID != null && !(OSPF_PROCESSID.trim().equals(""))) ? nfA.format(beanigw_trunkdata.getOspf_processid()) : "";
                      String AREA = beanigw_trunkdata.getArea();
                String BANDWIDTH = beanigw_trunkdata.getBandwidth();
                String RSVP_BANDWIDTH = beanigw_trunkdata.getRsvp_bandwidth();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="igw_trunkdataApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
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
  </h1>
<script>
var allEvents = "";
function addListener(element,eventName,functionName){
  if(element.addEventListener){
    element.addEventListener(eventName,functionName,false);
  } else {
    element.attachEvent("on" + eventName,functionName);
  }
}
</script>
<script>
function doOnLoad()
{
  // hide field
                                                                                                                                                                                                    // check hiding rules
  eval(allEvents);
}
addListener(window, "load", doOnLoad);
</script>
<html:form action="<%= formAction %>" style="text-align:center;">
    <table:table>
      <table:header>
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
      
      <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
      
                                                  <html:hidden property="trunkdata_id" value="<%= TRUNKDATA_ID %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.parent_trunkdata.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="parent_trunkdata" size="24" value="<%= PARENT_TRUNKDATA %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.parent_trunkdata.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.trunk_id.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="trunk_id" size="24" value="<%= TRUNK_ID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.trunk_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_service_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="side_service_id" size="24" value="<%= SIDE_SERVICE_ID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_service_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="side_name" size="24" value="<%= SIDE_NAME %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_name.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_sort_name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="side_sort_name" size="24" value="<%= SIDE_SORT_NAME %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_sort_name.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.router_id.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="router_id" size="24" value="<%= ROUTER_ID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.router_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.interfaces_id.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="interfaces_id" size="24" value="<%= INTERFACES_ID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.interfaces_id.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipnet_pool.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ipnet_pool" size="24" value="<%= IPNET_POOL %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipnet_pool.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipnet_address.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ipnet_address" size="24" value="<%= IPNET_ADDRESS %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipnet_address.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipnet_submask.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ipnet_submask" size="24" value="<%= IPNET_SUBMASK %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipnet_submask.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_description.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="side_description" size="24" value="<%= SIDE_DESCRIPTION %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.side_description.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.nego_flag.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="nego_flag" value="true"/>
                  <html:hidden  property="nego_flag" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.nego_flag.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.linkprotocol.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="linkprotocol" size="24" value="<%= LINKPROTOCOL %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.linkprotocol.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.mtu.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="mtu" size="24" value="<%= MTU %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.mtu.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.pim_flag.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="pim_flag" value="true"/>
                  <html:hidden  property="pim_flag" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.pim_flag.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospfnet_type_flag.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="ospfnet_type_flag" value="true"/>
                  <html:hidden  property="ospfnet_type_flag" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospfnet_type_flag.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospf_cost.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ospf_cost" size="24" value="<%= OSPF_COST %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospf_cost.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospf_password.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ospf_password" size="24" value="<%= OSPF_PASSWORD %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospf_password.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ldp_flag.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="ldp_flag" value="true"/>
                  <html:hidden  property="ldp_flag" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ldp_flag.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ldp_password.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ldp_password" size="24" value="<%= LDP_PASSWORD %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ldp_password.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.interface_description.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="interface_description" size="24" value="<%= INTERFACE_DESCRIPTION %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.interface_description.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.traffic_policyname.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="traffic_policyname" size="24" value="<%= TRAFFIC_POLICYNAME %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.traffic_policyname.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.policy_type.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="policy_type" size="24" value="<%= POLICY_TYPE %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.policy_type.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipv6_pool.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ipv6_pool" size="24" value="<%= IPV6_POOL %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipv6_pool.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipv6_address.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ipv6_address" size="24" value="<%= IPV6_ADDRESS %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipv6_address.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.encapsulation.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="encapsulation" size="24" value="<%= ENCAPSULATION %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.encapsulation.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipbinding_flag.alias"/>
                              </table:cell>
              <table:cell>
                                  <html:checkbox  property="ipbinding_flag" value="true"/>
                  <html:hidden  property="ipbinding_flag" value="false"/>
                              </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ipbinding_flag.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospf_processid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ospf_processid" size="24" value="<%= OSPF_PROCESSID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.ospf_processid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.area.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="area" size="24" value="<%= AREA %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.area.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.bandwidth.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="bandwidth" size="24" value="<%= BANDWIDTH %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.bandwidth.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.rsvp_bandwidth.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="rsvp_bandwidth" size="24" value="<%= RSVP_BANDWIDTH %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="igw_trunkdataApplicationResources" key="field.rsvp_bandwidth.description"/>
                              </table:cell>
            </table:row>
                              
      
      <table:row>
        <table:cell colspan="3" align="center">
        <br>
        </table:cell>
      </table:row>
      <table:row>
        <table:cell colspan="3" align="center">
          <input type="button" value="<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>" name="enviando" class="ButtonSubmit" onclick="this.disabled='true'; performCommit();">&nbsp;
          <input type="reset" value="<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>" class="ButtonReset">
        </table:cell>
      </table:row>
    </table:table>
  </html:form>

  </body>

</html>
