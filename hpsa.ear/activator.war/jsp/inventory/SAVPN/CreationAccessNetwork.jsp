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
String datasource = (String) request.getParameter(AccessNetworkConstants.DATASOURCE);
String rimid = (String) request.getParameter("rimid");
String _location_ = (String) request.getParameter("_location_");
String formAction = "/CreationCommitAccessNetworkAction.do?datasource=" + datasource + "&rimid=" + rimid;
String errorAction = (String) request.getAttribute("ERROR_ACTION");
String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
String exceptionMessage = (String) request.getAttribute("EXCEPTION_MESSAGE");
if (exceptionMessage==null){
  exceptionMessage="";
}
if ( _location_ == null ) {
                    _location_ = "name";
                                                }
%>

<html>
  <head>
    <title><bean:message bundle="AccessNetworkApplicationResources" key="<%= AccessNetworkConstants.JSP_CREATION_TITLE %>"/></title>
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
      window.document.AccessNetworkForm.action = '/activator<%=moduleConfig%>/CreationFormAccessNetworkAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>&_location_=' + focusthis;
      window.document.AccessNetworkForm.submit();
    }
    function performCommit()
    {
      window.document.AccessNetworkForm.action = '/activator<%=moduleConfig%>/CreationCommitAccessNetworkAction.do?datasource=<%= datasource %>&rimid=<%= rimid %>';
      window.document.AccessNetworkForm.submit();
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

com.hp.ov.activator.vpn.inventory.AccessNetwork beanAccessNetwork = (com.hp.ov.activator.vpn.inventory.AccessNetwork) request.getAttribute(AccessNetworkConstants.ACCESSNETWORK_BEAN);

      String NetworkId = beanAccessNetwork.getNetworkid();
                String Name = beanAccessNetwork.getName();
                String Type = beanAccessNetwork.getType();
                String ASN = beanAccessNetwork.getAsn();
                String Region = beanAccessNetwork.getRegion();
        String RegionLabel = (String) request.getAttribute(AccessNetworkConstants.REGION_LABEL);
ArrayList RegionListOfValues = (ArrayList) request.getAttribute(AccessNetworkConstants.REGION_LIST_OF_VALUES);
            String ParentNetworkId = beanAccessNetwork.getParentnetworkid();
        String ParentNetworkIdLabel = (String) request.getAttribute(AccessNetworkConstants.PARENTNETWORKID_LABEL);
ArrayList ParentNetworkIdListOfValues = (ArrayList) request.getAttribute(AccessNetworkConstants.PARENTNETWORKID_LIST_OF_VALUES);
            String State = beanAccessNetwork.getState();
                String ManagementVlans = beanAccessNetwork.getManagementvlans();
          
%>

<h2 style="width:100%; text-align:center;">
  <bean:message bundle="AccessNetworkApplicationResources" key="jsp.creation.title"/>
</h2> 

<h1>
      <html:errors bundle="AccessNetworkApplicationResources" property="NetworkId"/>
        <html:errors bundle="AccessNetworkApplicationResources" property="Name"/>
        <html:errors bundle="AccessNetworkApplicationResources" property="Type"/>
        <html:errors bundle="AccessNetworkApplicationResources" property="ASN"/>
        <html:errors bundle="AccessNetworkApplicationResources" property="Region"/>
        <html:errors bundle="AccessNetworkApplicationResources" property="ParentNetworkId"/>
        <html:errors bundle="AccessNetworkApplicationResources" property="State"/>
        <html:errors bundle="AccessNetworkApplicationResources" property="ManagementVlans"/>
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
      
                                                  <html:hidden property="networkid" value="<%= NetworkId %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="AccessNetworkApplicationResources" key="field.name.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="name" size="24" value="<%= Name %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessNetworkApplicationResources" key="field.name.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessNetworkApplicationResources" key="field.type.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="type" value="<%= Type %>"/>
                                                        <%                        
                        String selValue=null;                                    
                        if(Type==null||Type.trim().equals("")) {
                          selValue="Network";
                        } else {
                          selValue=Type.toString();
                        }    
                    %>

                    <html:select disabled="true" property="type" value="<%= selValue %>" >
                                            <html:option value="Network" >Network</html:option>
                                            <html:option value="AccessNetwork" >AccessNetwork</html:option>
                                            <html:option value="Topology" >Topology</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessNetworkApplicationResources" key="field.type.description"/>
                              </table:cell>
            </table:row>
                                                                    <html:hidden property="asn" value="<%= ASN %>"/>            
                                                                  <table:row>
              <table:cell>  
                <bean:message bundle="AccessNetworkApplicationResources" key="field.region.alias"/>
                                  *
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="region" value="<%= Region %>"/>
                                                        <html:select disabled="true" property="region" value="<%= Region %>" >
                      <html:options collection="RegionListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessNetworkApplicationResources" key="field.region.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessNetworkApplicationResources" key="field.parentnetworkid.alias"/>
                              </table:cell>
              <table:cell>
                                                      <html:hidden property="parentnetworkid" value="<%= ParentNetworkId %>"/>
                                                        <html:select disabled="true" property="parentnetworkid" value="<%= ParentNetworkId %>" >
                      <html:options collection="ParentNetworkIdListOfValues" property="value" labelProperty="label" />
                    </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessNetworkApplicationResources" key="field.parentnetworkid.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessNetworkApplicationResources" key="field.state.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <%                        
                        String selValue=null;                                    
                        if(State==null||State.trim().equals("")) {
                          selValue="Planned";
                        } else {
                          selValue=State.toString();
                        }    
                    %>

                    <html:select  property="state" value="<%= selValue %>" >
                                            <html:option value="Ready" >Ready</html:option>
                                            <html:option value="Accessible" >Accessible</html:option>
                                            <html:option value="Preconfigured" >Preconfigured</html:option>
                                            <html:option value="Planned" >Planned</html:option>
                                          </html:select>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessNetworkApplicationResources" key="field.state.description"/>
                              </table:cell>
            </table:row>
                                                      <table:row>
              <table:cell>  
                <bean:message bundle="AccessNetworkApplicationResources" key="field.managementvlans.alias"/>
                              </table:cell>
              <table:cell>
                                                                        <html:text  property="managementvlans" size="24" value="<%= ManagementVlans %>"/>
                                                </table:cell>
              <table:cell>
                <bean:message bundle="AccessNetworkApplicationResources" key="field.managementvlans.description"/>
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
