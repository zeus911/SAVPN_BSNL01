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
String uri = request.getRequestURI();
String baseURL = uri.substring(0,uri.indexOf("/activator"));
String useRandomColor="1";
String mainColor ="1";
String datasource = (String) request.getParameter(igw_trunkdataConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
%>

<html>
  <head>
    <title><bean:message bundle="igw_trunkdataApplicationResources" key="<%= igw_trunkdataConstants.JSP_DELETE_TITLE %>"/></title>
    <link rel="stylesheet" href="/activator/css/inventory-gui/estilos.css">
    <link rel="stylesheet" href="/activator/css/inventory-gui/subestilos.css">
    <script src="/activator/javascript/hputils/alerts.js"></script>
    <style type="text/css">
      A.nodec { text-decoration: none; }
    </style>
    <script>
    function performCommit()
    {
      window.document.igw_trunkdataForm.action = '/activator<%=moduleConfig%>/DeleteCommitigw_trunkdataAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.igw_trunkdataForm.submit();
    }
    function init()
    {
      var confirm = new HPSAConfirm('Confirm','<bean:message bundle="igw_trunkdataApplicationResources" key="delete.confirm"/>', '<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>', '<bean:message bundle="InventoryResources" key="confirm.cancel_button.label"/>');
      confirm.setAcceptButtonFunction('performCommit()');
      confirm.setCancelButtonFunction('');      
      confirm.setBounds(400, 120);
      confirm.show();
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">


<%
com.hp.ov.activator.vpn.inventory.igw_trunkdata beanigw_trunkdata = (com.hp.ov.activator.vpn.inventory.igw_trunkdata) request.getAttribute(igw_trunkdataConstants.IGW_TRUNKDATA_BEAN);


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

                  String TRUNKDATA_ID = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getTrunkdata_id());
                        
                                  
                      String PARENT_TRUNKDATA = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getParent_trunkdata());
                        
                                  
                      String TRUNK_ID = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getTrunk_id());
                        
                                  
                      String SIDE_SERVICE_ID = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getSide_service_id());
                        
                                  
                      String SIDE_NAME = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getSide_name());
                        
                                  
                      String SIDE_SORT_NAME = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getSide_sort_name());
                        
                                  
                      String ROUTER_ID = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getRouter_id());
                        
                                  
                      String INTERFACES_ID = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getInterfaces_id());
                        
                                  
                      String IPNET_POOL = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getIpnet_pool());
                        
                                  
                      String IPNET_ADDRESS = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getIpnet_address());
                        
                                  
                      String IPNET_SUBMASK = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getIpnet_submask());
                        
                                  
                      String SIDE_DESCRIPTION = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getSide_description());
                        
                                  
                      boolean NEGO_FLAG = new Boolean(beanigw_trunkdata.getNego_flag()).booleanValue();
                  
                                  
                      String LINKPROTOCOL = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getLinkprotocol());
                        
                                  
                        String MTU = "" + beanigw_trunkdata.getMtu();
                      MTU = (MTU != null && !(MTU.trim().equals(""))) ? nfA.format(beanigw_trunkdata.getMtu()) : "";
                          
                  if( beanigw_trunkdata.getMtu()==Integer.MIN_VALUE)
         MTU = "";
                            
                      boolean PIM_FLAG = new Boolean(beanigw_trunkdata.getPim_flag()).booleanValue();
                  
                                  
                      boolean OSPFNET_TYPE_FLAG = new Boolean(beanigw_trunkdata.getOspfnet_type_flag()).booleanValue();
                  
                                  
                        String OSPF_COST = "" + beanigw_trunkdata.getOspf_cost();
                      OSPF_COST = (OSPF_COST != null && !(OSPF_COST.trim().equals(""))) ? nfA.format(beanigw_trunkdata.getOspf_cost()) : "";
                          
                  if( beanigw_trunkdata.getOspf_cost()==Integer.MIN_VALUE)
         OSPF_COST = "";
                            
                      String OSPF_PASSWORD = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getOspf_password());
                        
                                  
                      boolean LDP_FLAG = new Boolean(beanigw_trunkdata.getLdp_flag()).booleanValue();
                  
                                  
                      String LDP_PASSWORD = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getLdp_password());
                        
                                  
                      String INTERFACE_DESCRIPTION = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getInterface_description());
                        
                                  
                      String TRAFFIC_POLICYNAME = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getTraffic_policyname());
                        
                                  
                      String POLICY_TYPE = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getPolicy_type());
                        
                                  
                      String IPV6_POOL = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getIpv6_pool());
                        
                                  
                      String IPV6_ADDRESS = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getIpv6_address());
                        
                                  
                      String ENCAPSULATION = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getEncapsulation());
                        
                                  
                      boolean IPBINDING_FLAG = new Boolean(beanigw_trunkdata.getIpbinding_flag()).booleanValue();
                  
                                  
                        String OSPF_PROCESSID = "" + beanigw_trunkdata.getOspf_processid();
                      OSPF_PROCESSID = (OSPF_PROCESSID != null && !(OSPF_PROCESSID.trim().equals(""))) ? nfA.format(beanigw_trunkdata.getOspf_processid()) : "";
                          
                  if( beanigw_trunkdata.getOspf_processid()==Integer.MIN_VALUE)
         OSPF_PROCESSID = "";
                            
                      String AREA = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getArea());
                        
                                  
                      String BANDWIDTH = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getBandwidth());
                        
                                  
                      String RSVP_BANDWIDTH = StringFacility.replaceAllByHTMLCharacter(beanigw_trunkdata.getRsvp_bandwidth());
                        
                                  
    
%>
<h2 style="width:100%; text-align:center;">
    <bean:message bundle="igw_trunkdataApplicationResources" key="jsp.delete.title"/>
</h2> 

<%
%>

    <div style="width:100%; text-align:center;">
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
      
                                      <table:row>
            <table:cell>  
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.trunkdata_id.alias"/>
                                *
                          </table:cell>
            <table:cell>
                            <%= TRUNKDATA_ID != null? TRUNKDATA_ID : "" %>
                          </table:cell>
            <table:cell>
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.trunkdata_id.description"/>
                                                                      </table:cell>
          </table:row>
                                                                                   <table:row>
            <table:cell>  
              <bean:message bundle="igw_trunkdataApplicationResources" key="field.parent_trunkdata.alias"/>
                          </table:cell>
            <table:cell>
                            <%= PARENT_TRUNKDATA != null? PARENT_TRUNKDATA : "" %>
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
                            <%= TRUNK_ID != null? TRUNK_ID : "" %>
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
                            <%= SIDE_SERVICE_ID != null? SIDE_SERVICE_ID : "" %>
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
                            <%= SIDE_NAME != null? SIDE_NAME : "" %>
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
                            <%= SIDE_SORT_NAME != null? SIDE_SORT_NAME : "" %>
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
                            <%= ROUTER_ID != null? ROUTER_ID : "" %>
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
                            <%= INTERFACES_ID != null? INTERFACES_ID : "" %>
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
                            <%= IPNET_POOL != null? IPNET_POOL : "" %>
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
                            <%= IPNET_ADDRESS != null? IPNET_ADDRESS : "" %>
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
                            <%= IPNET_SUBMASK != null? IPNET_SUBMASK : "" %>
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
                            <%= SIDE_DESCRIPTION != null? SIDE_DESCRIPTION : "" %>
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
              <%= NEGO_FLAG %>
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
                            <%= LINKPROTOCOL != null? LINKPROTOCOL : "" %>
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
                            <%= MTU != null? MTU : "" %>
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
              <%= PIM_FLAG %>
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
              <%= OSPFNET_TYPE_FLAG %>
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
                            <%= OSPF_COST != null? OSPF_COST : "" %>
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
                            <%= OSPF_PASSWORD != null? OSPF_PASSWORD : "" %>
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
              <%= LDP_FLAG %>
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
                            <%= LDP_PASSWORD != null? LDP_PASSWORD : "" %>
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
                            <%= INTERFACE_DESCRIPTION != null? INTERFACE_DESCRIPTION : "" %>
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
                            <%= TRAFFIC_POLICYNAME != null? TRAFFIC_POLICYNAME : "" %>
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
                            <%= POLICY_TYPE != null? POLICY_TYPE : "" %>
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
                            <%= IPV6_POOL != null? IPV6_POOL : "" %>
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
                            <%= IPV6_ADDRESS != null? IPV6_ADDRESS : "" %>
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
                            <%= ENCAPSULATION != null? ENCAPSULATION : "" %>
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
              <%= IPBINDING_FLAG %>
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
                            <%= OSPF_PROCESSID != null? OSPF_PROCESSID : "" %>
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
                            <%= AREA != null? AREA : "" %>
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
                            <%= BANDWIDTH != null? BANDWIDTH : "" %>
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
                            <%= RSVP_BANDWIDTH != null? RSVP_BANDWIDTH : "" %>
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
    </table:table>
    </div>

    <html:form action="/DeleteCommitigw_trunkdataAction.do">
    <html:hidden property="refreshTreeRimid" value="<%= (String)request.getParameter(\"refreshTreeRimid\") %>"/>
                  <html:hidden property="trunkdata_id" value="<%= String.valueOf(TRUNKDATA_ID) %>"/>
              </html:form>
  </body>
</html>

