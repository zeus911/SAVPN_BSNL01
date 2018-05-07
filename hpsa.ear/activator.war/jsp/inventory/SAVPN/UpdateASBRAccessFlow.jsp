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
String datasource = (String) request.getParameter(ASBRAccessFlowConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/UpdateCommitASBRAccessFlowAction.do?datasource=" + datasource + "&rimid=" + rimid;

String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
String pk = request.getParameter("_pk_");
if ( pk == null || pk.equals("") ) {
  pk =    request.getParameter("asbrserviceid") ;
}

pk = java.net.URLEncoder.encode( pk ,"UTF-8");


if ( _location_ == null ) {
                    _location_ = "connectionid";
                                                                              }

%>

<html>
  <head>
    <title><bean:message bundle="ASBRAccessFlowApplicationResources" key="<%= ASBRAccessFlowConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.ASBRAccessFlowForm.action = '/activator<%=moduleConfig%>/UpdateFormASBRAccessFlowAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>&_location_=' + focusthis;
      window.document.ASBRAccessFlowForm.submit();
    }
    function performCommit()
    {
      window.document.ASBRAccessFlowForm.action = '/activator<%=moduleConfig%>/UpdateCommitASBRAccessFlowAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_pk_=<%=pk %>';
      window.document.ASBRAccessFlowForm.submit();
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
      var alert = new HPSAAlert('<bean:message bundle="InventoryResources" key="jsp.error.titlemessage"/>','<bean:message bundle="InventoryResources" key="<%= errorMessage %>"/><br><br>*<%= exceptionMessage %>');
      alert.setBounds(400, 120);
      alert.setButtonText('<bean:message bundle="InventoryResources" key="confirm.ok_button.label"/>');
      alert.show();
<%
}
%>
    }
    </script>
  </head>
  
  <body style="overflow:auto;" onload="init();">

<%
com.hp.ov.activator.vpn.inventory.ASBRAccessFlow beanASBRAccessFlow = (com.hp.ov.activator.vpn.inventory.ASBRAccessFlow) request.getAttribute(ASBRAccessFlowConstants.ASBRACCESSFLOW_BEAN);
if(beanASBRAccessFlow==null)
   beanASBRAccessFlow = (com.hp.ov.activator.vpn.inventory.ASBRAccessFlow) request.getSession().getAttribute(ASBRAccessFlowConstants.ASBRACCESSFLOW_BEAN);
String __HASH_CODE= (String)request.getAttribute("__HASH_CODE");
ASBRAccessFlowForm form = (ASBRAccessFlowForm) request.getAttribute("ASBRAccessFlowForm");


NumberFormat nfA = NumberFormat.getNumberInstance();
NumberFormat nfB = NumberFormat.getNumberInstance();
nfB.setMinimumFractionDigits(1);  
nfB.setMaximumFractionDigits(6);

              String ASBRServiceId = beanASBRAccessFlow.getAsbrserviceid();
        
            
                            
            
                
                String ConnectionID = beanASBRAccessFlow.getConnectionid();
        
            
                            
            
                
                String VPNId = beanASBRAccessFlow.getVpnid();
        
            
                            
            
                
                String NetworkId1 = beanASBRAccessFlow.getNetworkid1();
        
            
                            
            
                
                String Network1Name = beanASBRAccessFlow.getNetwork1name();
        
            
                            
            
                
                String Topology1 = beanASBRAccessFlow.getTopology1();
        
            
                            
            
                
                String NetworkId2 = beanASBRAccessFlow.getNetworkid2();
        
            
                            
            
                
                String Network2Name = beanASBRAccessFlow.getNetwork2name();
        
            
                            
            
                
                String Topology2 = beanASBRAccessFlow.getTopology2();
        
            
                            
            
                
                String VlanId = beanASBRAccessFlow.getVlanid();
        
            
                            
            
                
                String IPNet = beanASBRAccessFlow.getIpnet();
        
            
                            
            
                
                String Netmask = beanASBRAccessFlow.getNetmask();
        
            
                            
            
                
                String Status = beanASBRAccessFlow.getStatus();
        
            
                            
            
                
  %>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="ASBRAccessFlowApplicationResources" key="jsp.update.title"/>
</h2> 

<h1>
      <html:errors bundle="ASBRAccessFlowApplicationResources" property="ASBRServiceId"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="ConnectionID"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="VPNId"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="NetworkId1"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="Network1Name"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="Topology1"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="NetworkId2"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="Network2Name"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="Topology2"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="VlanId"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="IPNet"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="Netmask"/>
        <html:errors bundle="ASBRAccessFlowApplicationResources" property="Status"/>
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
<input type="hidden" name="_update_commit_" value="true"/> 
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
      
                                    <table:row>
              <table:cell>  
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.asbrserviceid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="asbrserviceid" value="<%= ASBRServiceId %>"/>
                                                        <html:text disabled="true" property="asbrserviceid" size="24" value="<%= ASBRServiceId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.asbrserviceid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.connectionid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="connectionid" size="24" value="<%= ConnectionID %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.connectionid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.vpnid.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="vpnid" value="<%= VPNId %>"/>
                                                        <html:text disabled="true" property="vpnid" size="24" value="<%= VPNId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.vpnid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="networkid1" value="<%= NetworkId1 %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.network1name.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="network1name" value="<%= Network1Name %>"/>
                                                        <html:text disabled="true" property="network1name" size="24" value="<%= Network1Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.network1name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.topology1.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="topology1" size="24" value="<%= Topology1 %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.topology1.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                                    <html:hidden property="networkid2" value="<%= NetworkId2 %>"/>            
				                                            
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.network2name.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="network2name" value="<%= Network2Name %>"/>
                                                        <html:text disabled="true" property="network2name" size="24" value="<%= Network2Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.network2name.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.topology2.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="topology2" size="24" value="<%= Topology2 %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.topology2.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.vlanid.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="vlanid" size="24" value="<%= VlanId %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.vlanid.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.ipnet.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="ipnet" size="24" value="<%= IPNet %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.ipnet.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.netmask.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="netmask" size="24" value="<%= Netmask %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.netmask.description"/>
                                                                        </table:cell>
            </table:row>
                                
                                      <table:row>
              <table:cell>  
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.status.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="status" size="24" value="<%= Status %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="ASBRAccessFlowApplicationResources" key="field.status.description"/>
                                                                        </table:cell>
            </table:row>
                                
                    
      <html:hidden property="__HASH_CODE" value="<%= __HASH_CODE %>"/>            
            
      
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
